Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269000AbUIHC5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269000AbUIHC5m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 22:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269006AbUIHC5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 22:57:42 -0400
Received: from coverity.dreamhost.com ([66.33.192.105]:52405 "EHLO
	coverity.dreamhost.com") by vger.kernel.org with ESMTP
	id S269000AbUIHC53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 22:57:29 -0400
Date: Tue, 7 Sep 2004 19:57:28 -0700 (PDT)
From: Dawson Engler <engler@coverity.dreamhost.com>
To: linux-kernel@vger.kernel.org
Cc: developers@coverity.com
Subject: [CHECKER] possible deadlock in 2.6.8.1 lockd code
Message-ID: <Pine.LNX.4.58.0409071956380.6778@coverity.dreamhost.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

below is a possible deadlock in the linux-2.6.8.1 lockd code found by a
static deadlock checker I'm writing.  Let me know if it looks valid and/or
whether the output is too cryptic.  (Note, the locking dependencies go
across a bunch of function calls, so the paths may be infeasible.)

Thanks,
Dawson

     lock_kernel  <<===>>  nlm_file_sema

   thread 1: lock_kernel ==>> nlm_file_sema
      3 traces
       trace 1: ncalls=3, ncond=2
          fs/lockd/svc.c:lockd
             94: lockd(struct svc_rqst *rqstp)
             95: {
             96: 	struct svc_serv	*serv = rqstp->rq_server;
             97: 	int		err = 0;
             98: 	unsigned long grace_period_expire;
             ...
             102: 	 * be holding a reference to this module, so it
             103: 	 * is safe to just claim another reference
             104: 	 */
             105: 	__module_get(THIS_MODULE);
===>         106: 	lock_kernel();
             ...
             135: 	while ((nlmsvc_users || !signalled()) && nlmsvc_pid == current->pid) {
             137:
             138: 		if (signalled()) {
             139: 			flush_signals(current);
             140: 			if (nlmsvc_ops) {
===>         141: 				nlmsvc_invalidate_all();
             fs/lockd/svcsubs.c:nlmsvc_invalidate_all
                300: nlmsvc_invalidate_all(void)
                301: {
                302: 	struct nlm_host *host;
                303: 	while ((host = nlm_find_client()) != NULL) {
===>            304: 		nlmsvc_free_host_resources(host);
                fs/lockd/svcsubs.c:nlmsvc_free_host_resources
                   286: nlmsvc_free_host_resources(struct nlm_host *host)
                   287: {
                   288: 	dprintk("lockd: nlmsvc_free_host_resources\n");
                   289:
===>               290: 	if (nlm_traverse_files(host, NLM_ACT_UNLOCK))
                   fs/lockd/svcsubs.c:nlm_traverse_files
                      213: nlm_traverse_files(struct nlm_host *host, int action)
                      214: {
                      215: 	struct nlm_file	*file, **fp;
                      216: 	int		i;
                      217:
===>                  218: 	down(&nlm_file_sema);


       trace 2: ncalls=3, ncond=2
          fs/lockd/svc.c:lockd
             94: lockd(struct svc_rqst *rqstp)
             95: {
             96: 	struct svc_serv	*serv = rqstp->rq_server;
             97: 	int		err = 0;
             98: 	unsigned long grace_period_expire;
             ...
             102: 	 * be holding a reference to this module, so it
             103: 	 * is safe to just claim another reference
             104: 	 */
             105: 	__module_get(THIS_MODULE);
===>         106: 	lock_kernel();
             ...
             174: 		svc_process(serv, rqstp);
             175:
             176: 	}
             177:
             178: 	/*
             ...
             180: 	 * shutting down the hosts and clearing the slot.
             181: 	 */
             182: 	if (!nlmsvc_pid || current->pid == nlmsvc_pid) {
             183: 		if (nlmsvc_ops)
===>         184: 			nlmsvc_invalidate_all();
             fs/lockd/svcsubs.c:nlmsvc_invalidate_all
                300: nlmsvc_invalidate_all(void)
                301: {
                302: 	struct nlm_host *host;
                303: 	while ((host = nlm_find_client()) != NULL) {
===>            304: 		nlmsvc_free_host_resources(host);
                fs/lockd/svcsubs.c:nlmsvc_free_host_resources
                   286: nlmsvc_free_host_resources(struct nlm_host *host)
                   287: {
                   288: 	dprintk("lockd: nlmsvc_free_host_resources\n");
                   289:
===>               290: 	if (nlm_traverse_files(host, NLM_ACT_UNLOCK))
                   fs/lockd/svcsubs.c:nlm_traverse_files
                      213: nlm_traverse_files(struct nlm_host *host, int action)
                      214: {
                      215: 	struct nlm_file	*file, **fp;
                      216: 	int		i;
                      217:
===>                  218: 	down(&nlm_file_sema);


     --------------------------------------------------------------
   thread 2: nlm_file_sema ==>> lock_kernel
      6 traces
       trace 1: ncalls=4, ncond=3
          fs/lockd/svcsubs.c:nlm_release_file
             254: nlm_release_file(struct nlm_file *file)
             255: {
             256: 	dprintk("lockd: nlm_release_file(%p, ct = %d)\n",
             257: 				file, file->f_count);
             258:
             259: 	/* Lock file table */
===>         260: 	down(&nlm_file_sema);
             261:
             262: 	/* If there are no more locks etc, delete the file */
             263: 	if(--file->f_count == 0) {
===>         264: 		if(!nlm_inspect_file(NULL, file, NLM_ACT_CHECK))
             fs/lockd/svcsubs.c:nlm_inspect_file
                195: nlm_inspect_file(struct nlm_host *host, struct nlm_file *file, int action)
                196: {
                197: 	if (action == NLM_ACT_CHECK) {
                198: 		/* Fast path for mark and sweep garbage collection */
                199: 		if (file->f_count || file->f_blocks || file->f_shares)
                200: 			return 1;
                201: 	} else {
===>            202: 		if (nlmsvc_traverse_blocks(host, file, action)
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
===>               282: 				nlmsvc_delete_block(block, 1);
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
===>                  241: 	posix_unblock_lock(&file->f_file, fl);
                      fs/locks.c:posix_unblock_lock
                         1756: posix_unblock_lock(struct file *filp, struct file_lock *waiter)
                         1757: {
                         1758: 	/*
                         1759: 	 * A remote machine may cancel the lock request after it's been
                         1760: 	 * granted locally.  If that happens, we need to delete the lock.
                         1761: 	 */
===>                     1762: 	lock_kernel();


       trace 3: ncalls=4, ncond=4
          fs/lockd/svcsubs.c:nlm_release_file
             254: nlm_release_file(struct nlm_file *file)
             255: {
             256: 	dprintk("lockd: nlm_release_file(%p, ct = %d)\n",
             257: 				file, file->f_count);
             258:
             259: 	/* Lock file table */
===>         260: 	down(&nlm_file_sema);
             261:
             262: 	/* If there are no more locks etc, delete the file */
             263: 	if(--file->f_count == 0) {
===>         264: 		if(!nlm_inspect_file(NULL, file, NLM_ACT_CHECK))
             fs/lockd/svcsubs.c:nlm_inspect_file
                195: nlm_inspect_file(struct nlm_host *host, struct nlm_file *file, int action)
                196: {
                197: 	if (action == NLM_ACT_CHECK) {
                198: 		/* Fast path for mark and sweep garbage collection */
                199: 		if (file->f_count || file->f_blocks || file->f_shares)
                ...
                202: 		if (nlmsvc_traverse_blocks(host, file, action)
                203: 		 || nlmsvc_traverse_shares(host, file, action))
                204: 			return 1;
                205: 	}
===>            206: 	return nlm_traverse_locks(host, file, action);
                fs/lockd/svcsubs.c:nlm_traverse_locks
                   151: nlm_traverse_locks(struct nlm_host *host, struct nlm_file *file, int action)
                   152: {
                   153: 	struct inode	 *inode = nlmsvc_file_inode(file);
                   154: 	struct file_lock *fl;
                   155: 	struct nlm_host	 *lockhost;
                   ...
                   175:
                   176: 			lock.fl_type  = F_UNLCK;
                   177: 			lock.fl_start = 0;
                   178: 			lock.fl_end   = OFFSET_MAX;
===>               179: 			if (posix_lock_file(&file->f_file, &lock) < 0) {
                   fs/locks.c:posix_lock_file
                      909: int posix_lock_file(struct file *filp, struct file_lock *fl)
                      910: {
===>                  911: 	return __posix_lock_file(filp->f_dentry->d_inode, fl);
                      fs/locks.c:__posix_lock_file
                         723: static int __posix_lock_file(struct inode *inode, struct file_lock *request)
                         724: {
                         725: 	struct file_lock *fl;
                         726: 	struct file_lock *new_fl, *new_fl2;
                         727: 	struct file_lock *left = NULL;
                         ...
                         735: 	 */
                         736: 	new_fl = locks_alloc_lock();
                         737: 	new_fl2 = locks_alloc_lock();
                         738:
===>                     739: 	lock_kernel();

       trace 4: ncalls=4, ncond=4
          fs/lockd/svcsubs.c:nlm_traverse_files
             213: nlm_traverse_files(struct nlm_host *host, int action)
             214: {
             215: 	struct nlm_file	*file, **fp;
             216: 	int		i;
             217:
===>         218: 	down(&nlm_file_sema);
             219: 	for (i = 0; i < FILE_NRHASH; i++) {
             220: 		fp = nlm_files + i;
             221: 		while ((file = *fp) != NULL) {
             222: 			/* Traverse locks, blocks and shares of this file
             223: 			 * and update file->f_locks count */
===>         224: 			if (nlm_inspect_file(host, file, action)) {
             fs/lockd/svcsubs.c:nlm_inspect_file
                195: nlm_inspect_file(struct nlm_host *host, struct nlm_file *file, int action)
                196: {
                197: 	if (action == NLM_ACT_CHECK) {
                198: 		/* Fast path for mark and sweep garbage collection */
                199: 		if (file->f_count || file->f_blocks || file->f_shares)
                ...
                202: 		if (nlmsvc_traverse_blocks(host, file, action)
                203: 		 || nlmsvc_traverse_shares(host, file, action))
                204: 			return 1;
                205: 	}
===>            206: 	return nlm_traverse_locks(host, file, action);
                fs/lockd/svcsubs.c:nlm_traverse_locks
                   151: nlm_traverse_locks(struct nlm_host *host, struct nlm_file *file, int action)
                   152: {
                   153: 	struct inode	 *inode = nlmsvc_file_inode(file);
                   154: 	struct file_lock *fl;
                   155: 	struct nlm_host	 *lockhost;
                   ...
                   175:
                   176: 			lock.fl_type  = F_UNLCK;
                   177: 			lock.fl_start = 0;
                   178: 			lock.fl_end   = OFFSET_MAX;
===>               179: 			if (posix_lock_file(&file->f_file, &lock) < 0) {
                   fs/locks.c:posix_lock_file
                      909: int posix_lock_file(struct file *filp, struct file_lock *fl)
                      910: {
===>                  911: 	return __posix_lock_file(filp->f_dentry->d_inode, fl);
                      fs/locks.c:__posix_lock_file
                         723: static int __posix_lock_file(struct inode *inode, struct file_lock *request)
                         724: {
                         725: 	struct file_lock *fl;
                         726: 	struct file_lock *new_fl, *new_fl2;
                         727: 	struct file_lock *left = NULL;
                         ...
                         735: 	 */
                         736: 	new_fl = locks_alloc_lock();
                         737: 	new_fl2 = locks_alloc_lock();
                         738:
===>                     739: 	lock_kernel();

