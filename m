Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315693AbSECUkl>; Fri, 3 May 2002 16:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315697AbSECUkk>; Fri, 3 May 2002 16:40:40 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:40591 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315693AbSECUkg>; Fri, 3 May 2002 16:40:36 -0400
Subject: [PATCH] NFS locking routines do not invoke the filesystem lock operation
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.07a  May 14, 2001
Message-ID: <OF676A9D08.8758D24B-ON85256BAE.00716BCE@raleigh.ibm.com>
From: "Brian Dixon" <dixonbp@us.ibm.com>
Date: Fri, 3 May 2002 15:40:07 -0500
X-MIMETrack: Serialize by Router on D04NM109/04/M/IBM(Release 5.0.9a |January 7, 2002) at
 05/03/2002 04:40:08 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Submitting a patch for NFS locking that has been part of the -ac tree
since 2.4.2-ac4 but has never picked-up in the base kernel.

The NFS locking routines (nlmsvc_lock and others in svclock.c) go directly
to the default kernel operations (eg., posix_lock_file) and do not invoke
any filesystem lock operation that may have been provided.  They SHOULD
invoke the lock file_operation (if one exists for the filesystem)
similarly to the non-NFS fcntl_setlk which does the following:

   if (filp->f_op->lock != NULL) {
       error = filp->f_op->lock(filp, cmd, &file_lock);

Without this, a filesystem that needs to provide the lock operation has no
way to achieve proper locking via nfs clients.

diff -Naur linux-2.4.10/fs/lockd/svclock.c linux-2.4.10-patch/fs/lockd/svclock.c
--- linux-2.4.10/fs/lockd/svclock.c Mon Oct  8 10:12:36 2001
+++ linux-2.4.10-patch/fs/lockd/svclock.c Mon Oct  8 10:13:37 2001
@@ -237,6 +237,14 @@
      if (unlock && block->b_granted) {
            dprintk("lockd: deleting granted lock\n");
            fl->fl_type = F_UNLCK;
+
+            /* If the filesystem defined its own lock operation, invoke it. */
+           if ((block->b_file->f_file.f_op) && (block->b_file->f_file.f_op->lock)) {
+                 int error;
+                 error = block->b_file->f_file.f_op->lock(&block->b_file->f_file, F_SETLK, fl);
+                 dprintk("nlmsvc_delete_block: filesystem (un)lock operation returned %d\n", error);
+           }
+
            posix_lock_file(&block->b_file->f_file, fl, 0);
            block->b_granted = 0;
      } else {
@@ -319,7 +327,16 @@

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
@@ -348,6 +365,11 @@
            return nlm_lck_denied;
      }

+     if (posix_locks_deadlock(&lock->fl, conflock)) {
+           up(&file->f_sema);
+           return nlm_lck_denied; /* EDEADLK */
+     }
+
      /* If we don't have a block, create and initialize it. Then
       * retry because we may have slept in kmalloc. */
      if (block == NULL) {
@@ -357,6 +379,11 @@
            goto again;
      }

+     if (!conflock) {
+           printk("nlmsvc_lock: BUG! Trying to block without a conflock!\n");
+           BUG();
+     }
+
      /* Append to list of blocked */
      nlmsvc_insert_block(block, NLM_NEVER);

@@ -387,6 +414,22 @@
                        (long long)lock->fl.fl_start,
                        (long long)lock->fl.fl_end);

+     /* If the filesystem defined its own lock operation, invoke it. */
+     if ((file->f_file.f_op) && (file->f_file.f_op->lock)) {
+           int error;
+
+           error = file->f_file.f_op->lock(&file->f_file, F_GETLK, &lock->fl);
+           if ((!error) && (lock->fl.fl_type != F_UNLCK))
+           {
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
@@ -423,7 +466,16 @@
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
@@ -515,6 +567,50 @@
      }

      /* Try the lock operation again */
+
+     /* If the filesystem defined its own lock operation, invoke it. */
+     if ((file->f_file.f_op) && (file->f_file.f_op->lock)) {
+     struct file_lock getlock;
+
+     /* save requestor lock inforation since GETLK will overwrite it */
+     getlock.fl_pid   = lock->fl.fl_pid;
+     getlock.fl_type  = lock->fl.fl_type;
+     getlock.fl_start = lock->fl.fl_start;
+     getlock.fl_end   = lock->fl.fl_end;
+
+     error = file->f_file.f_op->lock(&file->f_file, F_GETLK, &lock->fl);
+
+     /* restore requestor lock inforation.  */
+     lock->fl.fl_pid   = getlock.fl_pid;
+     lock->fl.fl_type  = getlock.fl_type;
+     lock->fl.fl_start = getlock.fl_start;
+     lock->fl.fl_end   = getlock.fl_end;
+
+     if ((!error) && (lock->fl.fl_type != F_UNLCK)) {
+           dprintk("nlmsvc_grant_blocked: filesystem (get)lock operation returned error %d type %d pid %d start %Ld end %Ld\n",
+                 error, lock->fl.fl_type, lock->fl.fl_pid, lock->fl.fl_start, lock->fl.fl_end);
+           dprintk("lockd: lock still blocked\n");
+
+           /* If the blocker is local and recorded in the vfs lock structures, use its
+           conflock to wait on.  If the lock is denied due to the filesystem call, we
+           don't have a conflicting lock so retry in a while. */
+
+           if ((conflock = posix_test_lock(&file->f_file, &lock->fl)) != NULL) {
+                 nlmsvc_insert_block(block, NLM_NEVER);
+                 posix_block_lock(conflock, &lock->fl);
+                 up(&file->f_sema);
+                 return;
+           }
+           else {
+                 dprintk("nlmsvc_grant_blocked: NO conflock RECORDED IN THE VFS!\n");
+                 nlmsvc_insert_block(block, jiffies + 30 * HZ);
+                 up(&file->f_sema);
+                 return;
+                 }
+
+           }
+     }
+
      if ((conflock = posix_test_lock(&file->f_file, &lock->fl)) != NULL) {
            /* Bummer, we blocked again */
            dprintk("lockd: lock still blocked\n");
@@ -528,6 +624,20 @@
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
diff -Naur linux-2.4.10/fs/locks.c linux-2.4.10-patch/fs/locks.c
--- linux-2.4.10/fs/locks.c   Mon Oct  8 10:12:28 2001
+++ linux-2.4.10-patch/fs/locks.c   Mon Oct  8 10:13:30 2001
@@ -660,7 +660,7 @@
  * from a broken NFS client. But broken NFS clients have a lot more to
  * worry about than proper deadlock detection anyway... --okir
  */
-static int posix_locks_deadlock(struct file_lock *caller_fl,
+int posix_locks_deadlock(struct file_lock *caller_fl,
                        struct file_lock *block_fl)
 {
      struct list_head *tmp;
diff -Naur linux-2.4.10/include/linux/fs.h linux-2.4.10-patch/include/linux/fs.h
--- linux-2.4.10/include/linux/fs.h Mon Oct  8 10:12:48 2001
+++ linux-2.4.10-patch/include/linux/fs.h Mon Oct  8 10:13:52 2001
@@ -605,6 +605,7 @@
 extern int posix_lock_file(struct file *, struct file_lock *, unsigned int);
 extern void posix_block_lock(struct file_lock *, struct file_lock *);
 extern void posix_unblock_lock(struct file_lock *);
+extern int posix_locks_deadlock(struct file_lock *, struct file_lock *);
 extern int __get_lease(struct inode *inode, unsigned int flags);
 extern time_t lease_get_mtime(struct inode *);
 extern int lock_may_read(struct inode *, loff_t start, unsigned long count);
diff -Naur linux-2.4.10/kernel/ksyms.c linux-2.4.10-patch/kernel/ksyms.c
--- linux-2.4.10/kernel/ksyms.c     Mon Oct  8 10:13:00 2001
+++ linux-2.4.10-patch/kernel/ksyms.c     Mon Oct  8 10:13:59 2001
@@ -223,6 +223,7 @@
 EXPORT_SYMBOL(posix_test_lock);
 EXPORT_SYMBOL(posix_block_lock);
 EXPORT_SYMBOL(posix_unblock_lock);
+EXPORT_SYMBOL(posix_locks_deadlock);
 EXPORT_SYMBOL(locks_mandatory_area);
 EXPORT_SYMBOL(dput);
 EXPORT_SYMBOL(have_submounts);

