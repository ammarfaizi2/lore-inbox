Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269012AbUIHDHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269012AbUIHDHI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 23:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269015AbUIHDHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 23:07:08 -0400
Received: from coverity.dreamhost.com ([66.33.192.105]:48099 "EHLO
	coverity.dreamhost.com") by vger.kernel.org with ESMTP
	id S269012AbUIHDGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 23:06:22 -0400
Date: Tue, 7 Sep 2004 20:06:21 -0700 (PDT)
From: Dawson Engler <engler@coverity.dreamhost.com>
To: linux-kernel@vger.kernel.org
Cc: developers@coverity.com
Subject: [CHECKER] possible deadlock in linux 2.6.8.1 lockd code
Message-ID: <Pine.LNX.4.58.0409072005280.32310@coverity.dreamhost.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

below is a possible deadlock in the linux-2.6.8.1 lockd code found by
a static deadlock checker I'm writing.  Let me know if it looks valid
and/or whether the output is too cryptic.  Note, the dependency from
nlm_host_sema ==>> lock_kernel  goes across seven function calls, so
sucks to reason about.

Thanks,
Dawson

     lock_kernel  <<===>>  nlm_host_sema

   thread 1: lock_kernel ==>> nlm_host_sema
       trace 1: ncalls=1, ncond=1
          fs/lockd/svc.c:lockd
             94: lockd(struct svc_rqst *rqstp)
             95: {
	     ...
===>         106: 	lock_kernel();
             ...
===>         185: 		nlm_shutdown_hosts();
             fs/lockd/host.c:nlm_shutdown_hosts
                260: nlm_shutdown_hosts(void)
                261: {
                262: 	struct nlm_host	*host;
                263: 	int		i;
                264:
                265: 	dprintk("lockd: shutting down host module\n");
===>            266: 	down(&nlm_host_sema);


       trace 2: ncalls=2, ncond=0
          fs/lockd/svc.c:lockd
             94: lockd(struct svc_rqst *rqstp)
===>         106: 	lock_kernel();
             ...
             140: 			if (nlmsvc_ops) {
===>         141: 				nlmsvc_invalidate_all();
             fs/lockd/svcsubs.c:nlmsvc_invalidate_all
                300: nlmsvc_invalidate_all(void)
                301: {
                302: 	struct nlm_host *host;
===>            303: 	while ((host = nlm_find_client()) != NULL) {
                fs/lockd/host.c:nlm_find_client
                   139: nlm_find_client(void)
                   140: {
                   141: 	/* find a nlm_host for a client for which h_killed == 0.
                   142: 	 * and return it
                   143: 	 */
                   144: 	int hash;
===>               145: 	down(&nlm_host_sema);



     -----------
   thread 2: nlm_host_sema ==>> lock_kernel
      4 traces
          fs/lockd/host.c:nlm_lookup_host
             62: 					int proto, int version)
             73: 	/* Lock hash table */
===>         74: 	down(&nlm_host_sema);
             75:
             76: 	if (time_after_eq(jiffies, next_gc))
===>         77: 		nlm_gc_hosts();
             fs/lockd/host.c:nlm_gc_hosts
                299: nlm_gc_hosts(void)
                300: {
                301: 	struct nlm_host	**q, *host;
                302: 	struct rpc_clnt	*clnt;
                303: 	int		i;
                ...
                308: 			host->h_inuse = 0;
                309: 	}
                310:
                311: 	/* Mark all hosts that hold locks, blocks or shares */
===>            312: 	nlmsvc_mark_resources();
                fs/lockd/svcsubs.c:nlmsvc_mark_resources
                   275: nlmsvc_mark_resources(void)
                   276: {
                   277: 	dprintk("lockd: nlmsvc_mark_resources\n");
                   278:
===>               279: 	nlm_traverse_files(NULL, NLM_ACT_MARK);
                   fs/lockd/svcsubs.c:nlm_traverse_files
                      213: nlm_traverse_files(struct nlm_host *host, int action)
                      214: {
                      215: 	struct nlm_file	*file, **fp;
                      216: 	int		i;
                      217:
                      ...
                      220: 		fp = nlm_files + i;
                      221: 		while ((file = *fp) != NULL) {
                      222: 			/* Traverse locks, blocks and shares of this file
                      223: 			 * and update file->f_locks count */
===>                  224: 			if (nlm_inspect_file(host, file, action)) {
                      fs/lockd/svcsubs.c:nlm_inspect_file
                         195: nlm_inspect_file(struct nlm_host *host, struct nlm_file *file, int action)
                         196: {
                         197: 	if (action == NLM_ACT_CHECK) {
                         198: 		/* Fast path for mark and sweep garbage collection */
                         199: 		if (file->f_count || file->f_blocks || file->f_shares)
                         200: 			return 1;
                         201: 	} else {
===>                     202: 		if (nlmsvc_traverse_blocks(host, file, action)
                         fs/lockd/svclock.c:nlmsvc_traverse_blocks
                            271: nlmsvc_traverse_blocks(struct nlm_host *host, struct nlm_file *file, int action)
                            272: {
                            273: 	struct nlm_block	*block, *next;
                            274:
                            275: 	down(&file->f_sema);
                            ...
                            278: 		if (action == NLM_ACT_MARK)
                            279: 			block->b_host->h_inuse = 1;
                            280: 		else if (action == NLM_ACT_UNLOCK) {
                            281: 			if (host == NULL || host == block->b_host)
===>                        282: 				nlmsvc_delete_block(block, 1);
                            fs/lockd/svclock.c:nlmsvc_delete_block
                               231: nlmsvc_delete_block(struct nlm_block *block, int unlock)
                               232: {
                               233: 	struct file_lock	*fl = &block->b_call.a_args.lock.fl;
                               234: 	struct nlm_file		*file = block->b_file;
                               235: 	struct nlm_block	**bp;
                               ...
                               237: 	dprintk("lockd: deleting block %p...\n", block);
                               238:
                               239: 	/* Remove block from list */
                               240: 	nlmsvc_remove_block(block);
===>                           241: 	posix_unblock_lock(&file->f_file, fl);
                               fs/locks.c:posix_unblock_lock
                                  1756: posix_unblock_lock(struct file *filp, struct file_lock *waiter)
                                  1757: {
                                  1758: 	/*
                                  1759: 	 * A remote machine may cancel the lock request after it's been
                                  1760: 	 * granted locally.  If that happens, we need to delete the lock.
                                  1761: 	 */
===>                              1762: 	lock_kernel();

       trace 2: ncalls=7, ncond=6
          fs/lockd/host.c:nlm_shutdown_hosts
             260: nlm_shutdown_hosts(void)
		...
===>         266: 	down(&nlm_host_sema);
		...
===>         276: 	nlm_gc_hosts();
             fs/lockd/host.c:nlm_gc_hosts
                299: nlm_gc_hosts(void)
		...
===>            312: 	nlmsvc_mark_resources();
                fs/lockd/svcsubs.c:nlmsvc_mark_resources
                   275: nlmsvc_mark_resources(void)
                   276: {
                   277: 	dprintk("lockd: nlmsvc_mark_resources\n");
                   278:
===>               279: 	nlm_traverse_files(NULL, NLM_ACT_MARK);

                   fs/lockd/svcsubs.c:nlm_traverse_files
                      213: nlm_traverse_files(struct nlm_host *host, int action)
                      ...
===>                  224: 			if (nlm_inspect_file(host, file, action)) {
                      fs/lockd/svcsubs.c:nlm_inspect_file
                         195: nlm_inspect_file(struct nlm_host *host, struct nlm_file *file, int action)
			...
                         201: 	} else {
===>                     202: 		if (nlmsvc_traverse_blocks(host, file, action)
                         fs/lockd/svclock.c:nlmsvc_traverse_blocks
                            271: nlmsvc_traverse_blocks(struct nlm_host *host, struct nlm_file *file, int action)
			    ...
===>                        282: 				nlmsvc_delete_block(block, 1);
                            fs/lockd/svclock.c:nlmsvc_delete_block
                               231: nlmsvc_delete_block(struct nlm_block *block, int unlock)
				...
                               240: 	nlmsvc_remove_block(block);
===>                           241: 	posix_unblock_lock(&file->f_file, fl);
                               fs/locks.c:posix_unblock_lock
                                  1756: posix_unblock_lock(struct file *filp, struct file_lock *waiter)
                                  1757: {
                                  1758: 	/*
                                  1759: 	 * A remote machine may cancel the lock request after it's been
                                  1760: 	 * granted locally.  If that happens, we need to delete the lock.
                                  1761: 	 */
===>                              1762: 	lock_kernel();

