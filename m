Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268999AbUIHCuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268999AbUIHCuW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 22:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269000AbUIHCuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 22:50:22 -0400
Received: from coverity.dreamhost.com ([66.33.192.105]:6088 "EHLO
	coverity.dreamhost.com") by vger.kernel.org with ESMTP
	id S268999AbUIHCtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 22:49:51 -0400
Date: Tue, 7 Sep 2004 19:49:50 -0700 (PDT)
From: Dawson Engler <engler@coverity.dreamhost.com>
To: linux-kernel@vger.kernel.org
Cc: developers@coverity.com
Subject: [CHECKER] potential NFS deadlock in 2.6.8.1
Message-ID: <Pine.LNX.4.58.0409071949070.28006@coverity.dreamhost.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

below is a possible deadlock in the linux-2.6.8.1 NFS found by a static
deadlock checker I'm writing.  Let me know if it looks valid and/or
whether the output is too cryptic.

Thanks,
Dawson

------------------------------------------------------------------

ERROR:DEADLOCK: 2 thread cycle:
     lock_kernel  <<===>>  client_sema

[both traces look valid]

   thread 1: lock_kernel ==>> client_sema
      2 traces
       trace 1: ncalls=2, ncond=0
          fs/nfsd/nfssvc.c:nfsd
             172: nfsd(struct svc_rqst *rqstp)
             173: {
             174: 	struct svc_serv	*serv = rqstp->rq_server;
             175: 	struct fs_struct *fsp;
             176: 	int		err;
             ...
             257: 				break;
             258: 		err = signo;
             259: 	}
             260:
===>         261: 	lock_kernel();
             ...
             266: 	/* Check if this is last thread */
             267: 	if (serv->sv_nrthreads==1) {
             268:
             269: 		printk(KERN_WARNING "nfsd: last server has exited\n");
             270: 		if (err != SIG_NOCLEAN) {
             ...
             272: 			nfsd_export_flush();
             273: 		}
             274: 		nfsd_serv = NULL;
             275: 	        nfsd_racache_shutdown();	/* release read-ahead cache */
===>         276: 		nfs4_state_shutdown();

             fs/nfsd/nfs4state.c:nfs4_state_shutdown
                2703: nfs4_state_shutdown(void)
                2704: {
===>            2705: 	nfs4_lock_state();

                fs/nfsd/nfs4state.c:nfs4_lock_state
                   91: nfs4_lock_state(void)
                   92: {
===>               93: 	down(&client_sema);

       trace 2: ncalls=2, ncond=0
          fs/nfsd/nfssvc.c:nfsd_svc
             79: nfsd_svc(unsigned short port, int nrservs)
             80: {
             81: 	int	error;
             82: 	int	none_left;
             83: 	struct list_head *victim;
             84:
===>         85: 	lock_kernel();
             ...
             130: 		victim = victim->next;
             131: 		send_sig(SIG_NOCLEAN, nl->task, 1);
             132: 		nrservs++;
             133: 	}
             134:  failure:
             ...
             136: 	svc_destroy(nfsd_serv);		/* Release server */
             137: 	if (none_left) {
             138: 		nfsd_serv = NULL;
             139: 		nfsd_racache_shutdown();
===>         140: 		nfs4_state_shutdown();
             fs/nfsd/nfs4state.c:nfs4_state_shutdown
                2703: nfs4_state_shutdown(void)
                2704: {
===>            2705: 	nfs4_lock_state();
                fs/nfsd/nfs4state.c:nfs4_lock_state
                   91: nfs4_lock_state(void)
                   92: {
===>               93: 	down(&client_sema);



    ---------------------------------------------------------
[both of these traces look valid]
   thread 2: client_sema ==>> lock_kernel

       [looks valid]
       trace 1: ncalls=2, ncond=0
          fs/nfsd/nfs4state.c:nfsd4_lock
             2084: nfsd4_lock(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_lock *lock)
             2085: {
             2086: 	struct nfs4_stateowner *lock_sop = NULL, *open_sop = NULL;
             2087: 	struct nfs4_stateid *lock_stp;
             2088: 	struct file *filp;
             ...
             2103: 	if (check_lock_length(lock->lk_offset, lock->lk_length))
             2104: 		 return nfserr_inval;
             2105:
             2106: 	lock->lk_stateowner = NULL;
===>         2107: 	nfs4_lock_state();
             fs/nfsd/nfs4state.c:nfs4_lock_state
                91: nfs4_lock_state(void)
                92: {
===>            93: 	down(&client_sema);

    path to B acquisition:
          ...
          2229: 		dprintk("NFSD: nfsd4_lock: posix_lock_file() failed! status %d\n",status);
          2230: 		goto out_destroy_new_stateid;
          2231: 	}
          2232:
          2233: conflicting_lock:
          ...
          2235: 	status = nfserr_denied;
          2236: 	/* XXX There is a race here. Future patch needed to provide
          2237: 	 * an atomic posix_lock_and_test_file
          2238: 	 */
===>      2239: 	if (!(conflock = posix_test_lock(filp, &file_lock))) {
          fs/locks.c:posix_test_lock
             598: posix_test_lock(struct file *filp, struct file_lock *fl)
             599: {
             600: 	struct file_lock *cfl;
             601:
===>         602: 	lock_kernel();


       trace 3: ncalls=2, ncond=0
          fs/nfsd/nfs4state.c:nfsd4_release_lockowner
		...
===>      2463: 	nfs4_lock_state();
             fs/nfsd/nfs4state.c:nfs4_lock_state
                91: nfs4_lock_state(void)
                92: {
===>            93: 	down(&client_sema);

          ...
===>      2476: 	if (check_for_locks(&stp->st_vfs_file, local))

          fs/nfsd/nfs4state.c:check_for_locks
             2427: check_for_locks(struct file *filp, struct nfs4_stateowner *lowner)
             2428: {
             2429: 	struct file_lock **flpp;
             2430: 	struct inode *inode = filp->f_dentry->d_inode;
             2431: 	int status = 0;
             2432:
===>         2433: 	lock_kernel();

