Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315701AbSECUsP>; Fri, 3 May 2002 16:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315700AbSECUsO>; Fri, 3 May 2002 16:48:14 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:43414 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315701AbSECUsL>; Fri, 3 May 2002 16:48:11 -0400
Subject: [PATCH] problem with locks_remove_posix calling filesystem lock operation
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.07a  May 14, 2001
Message-ID: <OFDE9F8F2B.9F554D29-ON85256BAE.0071FFEE@raleigh.ibm.com>
From: "Brian Dixon" <dixonbp@us.ibm.com>
Date: Fri, 3 May 2002 15:48:08 -0500
X-MIMETrack: Serialize by Router on D04NM109/04/M/IBM(Release 5.0.9a |January 7, 2002) at
 05/03/2002 04:48:08 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steps to Reproduce:
1. fcntl locking on a filesystem that defines the lock operation
2. a second thread tests a lock while the first is in the process of unlock
   due to the file being closed.

Actual Results: thread loops with this printk from locks_conflict in the
linux kernel:
        default:
                printk("locks_conflict(): impossible lock type - %d\n",
                       caller_fl->fl_type);
Note that corruption of the lock list and an Oops is also possile.

Expected Results: unlock should complete, this printk should never occur

Additional Information:
When a file is closed, filp_close calls locks_remove_posix to remove locks.
To remove the locks, the kernel lock is obtained and the filesystem lock
operation is called with an unlock for each of the locks on the i_flock list.
The problem is that the filesystem may have to wait for synchronization which
implies a call to schedule() which releases the kernel lock.  Once the lock is
released, other threads can manipulate the list and it can become corrupted.

A secondary problem is that locks_unlock_delete doesn't allocate a file_lock
structure for the unlock, but instead changes the existing lock to fl_type
F_UNLCK and points to it on the filesystem call.  This is assumed to be ok
because the kernel lock is held by locks_remove_posix before the call is made
(so no other thread will be able to observe the lock while it is in this invalid
state).  However, if the unlock thread waits in the filesystem, another thread
may see the invalid lock (in addition to corrupting the lock list).  This was
obseved as a printk in locks_conflict when it detected the invalid fl_type.

Two small changes are required:  locks_remove_posix must restart from the top
of the i_flock list after deleting a lock from a filesystem that defined its own
lock operation, and the file_lock used by locks_unlock_delete must be a COPY
of the held lock (with the fl_type in the COPY changed to F_UNLCK).

Suggested patch:
diff -Naur linux-2.4.2-2/fs/locks.c linux-2.4.2-2-patches/fs/locks.c
--- linux-2.4.2-2/fs/locks.c    Mon Dec 10 13:11:16 2001
+++ linux-2.4.2-2-patches/fs/locks.c    Mon Dec 10 16:21:28 2001
@@ -509,11 +509,25 @@
 {
        struct file_lock *fl = *thisfl_p;
        int (*lock)(struct file *, int, struct file_lock *);
+        struct file_lock ufl;

        if (fl->fl_file->f_op &&
            (lock = fl->fl_file->f_op->lock) != NULL) {
-               fl->fl_type = F_UNLCK;
-               lock(fl->fl_file, F_SETLK, fl);
+
+               /*
+                * The filesystem defined its own lock operation.  Make a
+                * copy of the lock before changing its type to unlock so that
+                * the file_lock being removed stays valid.
+                */
+               ufl = *fl;
+               ufl.fl_type = F_UNLCK;
+               lock(ufl.fl_file, F_SETLK, &ufl);
+
+               /*
+                * If the file_lock was removed, we are done.
+                */
+               if (*thisfl_p != fl)
+                       return;
        }
        locks_delete_lock(thisfl_p, 0);
 }
@@ -1641,6 +1655,7 @@
        struct inode * inode = filp->f_dentry->d_inode;
        struct file_lock *fl;
        struct file_lock **before;
+       void *lockOp;

        /*
         * For POSIX locks we free all locks on this file for the given task.
@@ -1655,10 +1670,18 @@
                return;
        }
        lock_kernel();
+       lockOp = filp->f_op? filp->f_op->lock: NULL;
+restart:
        before = &inode->i_flock;
        while ((fl = *before) != NULL) {
                if ((fl->fl_flags & FL_POSIX) && fl->fl_owner == owner) {
                        locks_unlock_delete(before);
+                       /*
+                        * If there is a possibility that the kernel lock was
+                        * released, start back at the beginning.
+                        */
+                       if (lockOp)
+                               goto restart;
                        continue;
                }
                before = &fl->fl_next;

