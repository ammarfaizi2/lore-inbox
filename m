Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264321AbTCXRDf>; Mon, 24 Mar 2003 12:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264323AbTCXRBP>; Mon, 24 Mar 2003 12:01:15 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:1154 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264321AbTCXQ7T>;
	Mon, 24 Mar 2003 11:59:19 -0500
Subject: re: [PATCH] NFS locking routines do not invoke the filesystem lock
 operation
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OF6BB6BC0F.0A73968D-ON87256CF3.005E25D5-86256CF3.005E4972@us.ibm.com>
From: Brian Dixon <dixonbp@us.ibm.com>
Date: Mon, 24 Mar 2003 11:10:20 -0600
X-MIMETrack: Serialize by Router on D03NM124/03/M/IBM(Release 6.0 [IBM]|December 16, 2002) at
 03/24/2003 10:10:21
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org






There is a problem with the getlk part of the original patch for this.
Here is a more recent patch that includes the fix.

-Brian

diff -Naur linux-2.4.19/fs/lockd/svclock.c linux-2.4.19-patches/fs/lockd/svclock.c
--- linux-2.4.19/fs/lockd/svclock.c Thu Oct 11 09:52:18 2001
+++ linux-2.4.19-patches/fs/lockd/svclock.c     Tue Oct  1 15:02:49 2002
@@ -242,6 +242,14 @@
      if (unlock && block->b_granted) {
            dprintk("lockd: deleting granted lock\n");
            fl->fl_type = F_UNLCK;
+
+           /* If the filesystem defined its own lock operation, invoke it. */
+           if ((block->b_file->f_file.f_op) && (block->b_file->f_file.f_op->lock)) {
+                 int error;
+                 error = block->b_file->f_file.f_op->lock(&block->b_file->f_file, F_SETLK, fl);
+                 dprintk("nlmsvc_delete_block: filesystem (un)lock operation returned %d\n", error);
+           }
+
            posix_lock_file(&block->b_file->f_file, fl, 0);
            block->b_granted = 0;
      } else {
@@ -324,7 +332,16 @@

 again:
      if (!(conflock = posix_test_lock(&file->f_file, &lock->fl))) {
-           error = posix_lock_file(&file->f_file, &lock->fl, 0);
+
+           /* If the filesystem defined its own lock operation, invoke it. */
+           error = 0;
+           if ((file->f_file.f_op) && (file->f_file.f_op->lock)) {
+                 error = file->f_file.f_op->lock(&file->f_file, F_SETLK, &lock->fl);
+                 dprintk("nlmsvc_lock: filesystem lock operation returned %d\n", error);
+           }
+
+           if (error == 0)
+                 error = posix_lock_file(&file->f_file, &lock->fl, 0);

            if (block)
                  nlmsvc_delete_block(block, 0);
@@ -392,6 +409,21 @@
                        (long long)lock->fl.fl_start,
                        (long long)lock->fl.fl_end);

+     /* If the filesystem defined its own lock operation, invoke it. */
+     if ((file->f_file.f_op) && (file->f_file.f_op->lock)) {
+           int error;
+
+           error = file->f_file.f_op->lock(&file->f_file, F_GETLK, &lock->fl);
+           if ((!error) && (lock->fl.fl_type != F_UNLCK)) {
+                 conflock->caller = "somehost";  /* FIXME */
+                 conflock->oh.len = 0;   /* don't return OH info */
+                 conflock->fl = lock->fl;
+                 dprintk("nlmsvc_testlock: filesystem (get)lock operation returned error %d type %d pid %d start %Ld end %Ld\n",
+                       error, lock->fl.fl_type, lock->fl.fl_pid, lock->fl.fl_start, lock->fl.fl_end);
+                 return nlm_lck_denied;
+           }
+     }
+
      if ((fl = posix_test_lock(&file->f_file, &lock->fl)) != NULL) {
            dprintk("lockd: conflicting lock(ty=%d, %Ld-%Ld)\n",
                        fl->fl_type, (long long)fl->fl_start,
@@ -428,7 +460,16 @@
      nlmsvc_cancel_blocked(file, lock);

      lock->fl.fl_type = F_UNLCK;
-     error = posix_lock_file(&file->f_file, &lock->fl, 0);
+
+     /* If the filesystem defined its own lock operation, invoke it. */
+     error = 0;
+     if ((file->f_file.f_op) && (file->f_file.f_op->lock)) {
+           error = file->f_file.f_op->lock(&file->f_file, F_SETLK, &lock->fl);
+           dprintk("nlmsvc_unlock: filesystem (un)lock operation returned error %d\n", error);
+     }
+
+     if (error == 0)
+           error = posix_lock_file(&file->f_file, &lock->fl, 0);

      return (error < 0)? nlm_lck_denied_nolocks : nlm_granted;
 }
@@ -520,6 +561,52 @@
      }

      /* Try the lock operation again */
+
+     /* If the filesystem defined its own lock operation, invoke it. */
+     if ((file->f_file.f_op) && (file->f_file.f_op->lock)) {
+           struct file_lock getlock;
+           unsigned char found_type;
+
+           /* save requestor lock inforation since GETLK will overwrite it */
+           getlock.fl_pid   = lock->fl.fl_pid;
+           getlock.fl_type  = lock->fl.fl_type;
+           getlock.fl_start = lock->fl.fl_start;
+           getlock.fl_end   = lock->fl.fl_end;
+
+           error = file->f_file.f_op->lock(&file->f_file, F_GETLK, &lock->fl);
+           found_type = lock->fl.fl_type;
+
+           /* restore requestor lock inforation.  */
+           lock->fl.fl_pid   = getlock.fl_pid;
+           lock->fl.fl_type  = getlock.fl_type;
+           lock->fl.fl_start = getlock.fl_start;
+           lock->fl.fl_end   = getlock.fl_end;
+
+           if ((!error) && (found_type != F_UNLCK)) {
+                 dprintk("nlmsvc_grant_blocked: filesystem (get)lock operation returned error %d type %d pid %d start %Ld end %Ld\n",
+                       error, lock->fl.fl_type, lock->fl.fl_pid, lock->fl.fl_start, lock->fl.fl_end);
+                 dprintk("lockd: lock still blocked\n");
+
+                 /* If the blocker is local and recorded in the vfs lock structures, use its
+                  * conflock to wait on.  If the lock is denied due to the filesystem call, we
+                  * don't have a conflicting lock so retry in a while.
+                  */
+
+                 if ((conflock = posix_test_lock(&file->f_file, &lock->fl)) != NULL) {
+                       nlmsvc_insert_block(block, NLM_NEVER);
+                       posix_block_lock(conflock, &lock->fl);
+                       up(&file->f_sema);
+                       return;
+                 }
+                 else {
+                       dprintk("nlmsvc_grant_blocked: NO conflock RECORDED IN THE VFS!\n");
+                       nlmsvc_insert_block(block, jiffies + 30 * HZ);
+                       up(&file->f_sema);
+                       return;
+                 }
+           }
+     }
+
      if ((conflock = posix_test_lock(&file->f_file, &lock->fl)) != NULL) {
            /* Bummer, we blocked again */
            dprintk("lockd: lock still blocked\n");
@@ -533,6 +620,20 @@
       * following yields an error, this is most probably due to low
       * memory. Retry the lock in a few seconds.
       */
+
+     /* If the filesystem defined its own lock operation, invoke it. */
+     if ((file->f_file.f_op) && (file->f_file.f_op->lock)) {
+           error = file->f_file.f_op->lock(&file->f_file, F_SETLK, &lock->fl);
+           dprintk("nlmsvc_grant_blocked: filesystem lock operation returned error %d\n", error);
+           if (error) {
+                 printk(KERN_WARNING "lockd: unexpected error %d in %s!\n",
+                       error, __FUNCTION__);
+                 nlmsvc_insert_block(block, jiffies + 10 * HZ);
+                 up(&file->f_sema);
+                 return;
+           }
+     }
+
      if ((error = posix_lock_file(&file->f_file, &lock->fl, 0)) < 0) {
            printk(KERN_WARNING "lockd: unexpected error %d in %s!\n",
                        -error, __FUNCTION__);

