Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbVHOSIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbVHOSIM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 14:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbVHOSIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 14:08:12 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:44244 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964854AbVHOSIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 14:08:11 -0400
Date: Mon, 15 Aug 2005 11:08:04 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: sfrench@samba.org, sct@redhat.com, okir@monad.swb.de,
       trond.myklebust@fys.uio.no, reiserfs-dev@namesys.com,
       urban@teststation.com, xfs-masters@oss.sgi.com, nathans@sgi.com
Cc: akpm@osdl.org, samba-technical@lists.samba.org,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       samba@samba.org, linux-xfs@oss.sgi.com
Subject: [-mm PATCH 2/32] fs: fix-up schedule_timeout() usage
Message-ID: <20050815180804.GE2854@us.ibm.com>
References: <20050815180514.GC2854@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050815180514.GC2854@us.ibm.com>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Use schedule_timeout_{,un}interruptible() instead of
set_current_state()/schedule_timeout() to reduce kernel size. Also use
helper functions to convert between human time units and jiffies rather
than constant HZ division to avoid rounding errors.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 fs/cifs/cifsfs.c             |    7 ++-----
 fs/cifs/connect.c            |    6 ++----
 fs/jbd/transaction.c         |    3 +--
 fs/lockd/clntproc.c          |    3 +--
 fs/nfs/nfs3proc.c            |    3 +--
 fs/nfs/nfs4proc.c            |   12 ++++--------
 fs/reiserfs/journal.c        |    3 +--
 fs/smbfs/proc.c              |    3 +--
 fs/xfs/linux-2.6/time.h      |    3 +--
 fs/xfs/linux-2.6/xfs_buf.c   |    6 +++---
 fs/xfs/linux-2.6/xfs_super.c |   12 ++++++------
 11 files changed, 23 insertions(+), 38 deletions(-)

diff -urpN 2.6.13-rc5-mm1/fs/cifs/cifsfs.c 2.6.13-rc5-mm1-dev/fs/cifs/cifsfs.c
--- 2.6.13-rc5-mm1/fs/cifs/cifsfs.c	2005-08-07 09:57:37.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/fs/cifs/cifsfs.c	2005-08-10 15:03:11.000000000 -0700
@@ -781,14 +781,11 @@ static int cifs_oplock_thread(void * dum
 
 	oplockThread = current;
 	do {
-		set_current_state(TASK_INTERRUPTIBLE);
-		
-		schedule_timeout(1*HZ);  
+		schedule_timeout_interruptible(1*HZ);  
 		spin_lock(&GlobalMid_Lock);
 		if(list_empty(&GlobalOplock_Q)) {
 			spin_unlock(&GlobalMid_Lock);
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(39*HZ);
+			schedule_timeout_interruptible(39*HZ);
 		} else {
 			oplock_item = list_entry(GlobalOplock_Q.next, 
 				struct oplock_q_entry, qhead);
diff -urpN 2.6.13-rc5-mm1/fs/cifs/connect.c 2.6.13-rc5-mm1-dev/fs/cifs/connect.c
--- 2.6.13-rc5-mm1/fs/cifs/connect.c	2005-08-07 10:05:22.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/fs/cifs/connect.c	2005-08-12 13:42:49.000000000 -0700
@@ -3215,10 +3215,8 @@ cifs_umount(struct super_block *sb, stru
 	}
 	
 	cifs_sb->tcon = NULL;
-	if (ses) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(HZ / 2);
-	}
+	if (ses)
+		schedule_timeout_interruptible(msecs_to_jiffies(500));
 	if (ses)
 		sesInfoFree(ses);
 
diff -urpN 2.6.13-rc5-mm1/fs/jbd/transaction.c 2.6.13-rc5-mm1-dev/fs/jbd/transaction.c
--- 2.6.13-rc5-mm1/fs/jbd/transaction.c	2005-08-07 10:05:22.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/fs/jbd/transaction.c	2005-08-10 15:03:33.000000000 -0700
@@ -1340,8 +1340,7 @@ int journal_stop(handle_t *handle)
 	if (handle->h_sync) {
 		do {
 			old_handle_count = transaction->t_handle_count;
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_timeout(1);
+			schedule_timeout_uninterruptible(1);
 		} while (old_handle_count != transaction->t_handle_count);
 	}
 
diff -urpN 2.6.13-rc5-mm1/fs/lockd/clntproc.c 2.6.13-rc5-mm1-dev/fs/lockd/clntproc.c
--- 2.6.13-rc5-mm1/fs/lockd/clntproc.c	2005-08-07 09:58:15.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/fs/lockd/clntproc.c	2005-08-10 15:03:41.000000000 -0700
@@ -299,8 +299,7 @@ nlmclnt_alloc_call(void)
 			return call;
 		}
 		printk("nlmclnt_alloc_call: failed, waiting for memory\n");
-		current->state = TASK_INTERRUPTIBLE;
-		schedule_timeout(5*HZ);
+		schedule_timeout_interruptible(5*HZ);
 	}
 	return NULL;
 }
diff -urpN 2.6.13-rc5-mm1/fs/nfs/nfs3proc.c 2.6.13-rc5-mm1-dev/fs/nfs/nfs3proc.c
--- 2.6.13-rc5-mm1/fs/nfs/nfs3proc.c	2005-08-07 09:58:15.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/fs/nfs/nfs3proc.c	2005-08-10 15:12:50.000000000 -0700
@@ -34,8 +34,7 @@ nfs3_rpc_wrapper(struct rpc_clnt *clnt, 
 		res = rpc_call_sync(clnt, msg, flags);
 		if (res != -EJUKEBOX)
 			break;
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(NFS_JUKEBOX_RETRY_TIME);
+		schedule_timeout_interruptible(NFS_JUKEBOX_RETRY_TIME);
 		res = -ERESTARTSYS;
 	} while (!signalled());
 	rpc_clnt_sigunmask(clnt, &oldset);
diff -urpN 2.6.13-rc5-mm1/fs/nfs/nfs4proc.c 2.6.13-rc5-mm1-dev/fs/nfs/nfs4proc.c
--- 2.6.13-rc5-mm1/fs/nfs/nfs4proc.c	2005-08-07 09:58:15.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/fs/nfs/nfs4proc.c	2005-08-10 15:15:04.000000000 -0700
@@ -2412,14 +2412,11 @@ static int nfs4_delay(struct rpc_clnt *c
 		*timeout = NFS4_POLL_RETRY_MAX;
 	rpc_clnt_sigmask(clnt, &oldset);
 	if (clnt->cl_intr) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(*timeout);
+		schedule_timeout_interruptible(*timeout);
 		if (signalled())
 			res = -ERESTARTSYS;
-	} else {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(*timeout);
-	}
+	} else
+		schedule_timeout_uninterruptible(*timeout);
 	rpc_clnt_sigunmask(clnt, &oldset);
 	*timeout <<= 1;
 	return res;
@@ -2572,8 +2569,7 @@ int nfs4_proc_delegreturn(struct inode *
 static unsigned long
 nfs4_set_lock_task_retry(unsigned long timeout)
 {
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(timeout);
+	schedule_timeout_interruptible(timeout);
 	timeout <<= 1;
 	if (timeout > NFS4_LOCK_MAXTIMEOUT)
 		return NFS4_LOCK_MAXTIMEOUT;
diff -urpN 2.6.13-rc5-mm1/fs/reiserfs/journal.c 2.6.13-rc5-mm1-dev/fs/reiserfs/journal.c
--- 2.6.13-rc5-mm1/fs/reiserfs/journal.c	2005-08-07 10:05:22.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/fs/reiserfs/journal.c	2005-08-10 15:15:11.000000000 -0700
@@ -2868,8 +2868,7 @@ static void let_transaction_grow(struct 
 	struct reiserfs_journal *journal = SB_JOURNAL(sb);
 	unsigned long bcount = journal->j_bcount;
 	while (1) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1);
+		schedule_timeout_uninterruptible(1);
 		journal->j_current_jl->j_state |= LIST_COMMIT_PENDING;
 		while ((atomic_read(&journal->j_wcount) > 0 ||
 			atomic_read(&journal->j_jlock)) &&
diff -urpN 2.6.13-rc5-mm1/fs/smbfs/proc.c 2.6.13-rc5-mm1-dev/fs/smbfs/proc.c
--- 2.6.13-rc5-mm1/fs/smbfs/proc.c	2005-03-01 23:37:49.000000000 -0800
+++ 2.6.13-rc5-mm1-dev/fs/smbfs/proc.c	2005-08-12 13:43:10.000000000 -0700
@@ -2397,8 +2397,7 @@ smb_proc_readdir_long(struct file *filp,
 		if (req->rq_rcls == ERRSRV && req->rq_err == ERRerror) {
 			/* a damn Win95 bug - sometimes it clags if you 
 			   ask it too fast */
-			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(HZ/5);
+			schedule_timeout_interruptible(msecs_to_jiffies(200));
 			continue;
                 }
 
diff -urpN 2.6.13-rc5-mm1/fs/xfs/linux-2.6/time.h 2.6.13-rc5-mm1-dev/fs/xfs/linux-2.6/time.h
--- 2.6.13-rc5-mm1/fs/xfs/linux-2.6/time.h	2005-03-01 23:38:33.000000000 -0800
+++ 2.6.13-rc5-mm1-dev/fs/xfs/linux-2.6/time.h	2005-08-10 15:15:43.000000000 -0700
@@ -39,8 +39,7 @@ typedef struct timespec timespec_t;
 
 static inline void delay(long ticks)
 {
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(ticks);
+	schedule_timeout_uninterruptible(ticks);
 }
 
 static inline void nanotime(struct timespec *tvp)
diff -urpN 2.6.13-rc5-mm1/fs/xfs/linux-2.6/xfs_buf.c 2.6.13-rc5-mm1-dev/fs/xfs/linux-2.6/xfs_buf.c
--- 2.6.13-rc5-mm1/fs/xfs/linux-2.6/xfs_buf.c	2005-08-07 09:58:15.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/fs/xfs/linux-2.6/xfs_buf.c	2005-08-12 13:44:19.000000000 -0700
@@ -1778,10 +1778,10 @@ xfsbufd(
 			xfsbufd_force_sleep = 0;
 		}
 
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout((xfs_buf_timer_centisecs * HZ) / 100);
+		schedule_timeout_interruptible
+			(xfs_buf_timer_centisecs * msecs_to_jiffies(10));
 
-		age = (xfs_buf_age_centisecs * HZ) / 100;
+		age = xfs_buf_age_centisecs * msecs_to_jiffies(10);
 		spin_lock(&pbd_delwrite_lock);
 		list_for_each_entry_safe(pb, n, &pbd_delwrite_queue, pb_list) {
 			PB_TRACE(pb, "walkq1", (long)pagebuf_ispin(pb));
diff -urpN 2.6.13-rc5-mm1/fs/xfs/linux-2.6/xfs_super.c 2.6.13-rc5-mm1-dev/fs/xfs/linux-2.6/xfs_super.c
--- 2.6.13-rc5-mm1/fs/xfs/linux-2.6/xfs_super.c	2005-08-07 09:58:15.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/fs/xfs/linux-2.6/xfs_super.c	2005-08-12 13:47:02.000000000 -0700
@@ -416,7 +416,7 @@ xfs_flush_inode(
 
 	igrab(inode);
 	xfs_syncd_queue_work(vfs, inode, xfs_flush_inode_work);
-	delay(HZ/2);
+	delay(msecs_to_jiffies(500));
 }
 
 /*
@@ -441,7 +441,7 @@ xfs_flush_device(
 
 	igrab(inode);
 	xfs_syncd_queue_work(vfs, inode, xfs_flush_device_work);
-	delay(HZ/2);
+	delay(msecs_to_jiffies(500));
 	xfs_log_force(ip->i_mount, (xfs_lsn_t)0, XFS_LOG_FORCE|XFS_LOG_SYNC);
 }
 
@@ -478,10 +478,9 @@ xfssyncd(
 	wake_up(&vfsp->vfs_wait_sync_task);
 
 	INIT_LIST_HEAD(&tmp);
-	timeleft = (xfs_syncd_centisecs * HZ) / 100;
+	timeleft = xfs_syncd_centisecs * msecs_to_jiffies(10);
 	for (;;) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		timeleft = schedule_timeout(timeleft);
+		timeleft = schedule_timeout_interruptible(timeleft);
 		/* swsusp */
 		try_to_freeze();
 		if (vfsp->vfs_flag & VFS_UMOUNT)
@@ -495,7 +494,8 @@ xfssyncd(
 		 */
 		if (!timeleft || list_empty(&vfsp->vfs_sync_list)) {
 			if (!timeleft)
-				timeleft = (xfs_syncd_centisecs * HZ) / 100;
+				timeleft = xfs_syncd_centisecs *
+							msecs_to_jiffies(10);
 			INIT_LIST_HEAD(&vfsp->vfs_sync_work.w_list);
 			list_add_tail(&vfsp->vfs_sync_work.w_list,
 					&vfsp->vfs_sync_list);
