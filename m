Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272328AbRIKIpb>; Tue, 11 Sep 2001 04:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272329AbRIKIpW>; Tue, 11 Sep 2001 04:45:22 -0400
Received: from mons.uio.no ([129.240.130.14]:56018 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S272328AbRIKIpL>;
	Tue, 11 Sep 2001 04:45:11 -0400
MIME-Version: 1.0
Message-ID: <15261.53031.349271.425562@charged.uio.no>
Date: Tue, 11 Sep 2001 10:45:27 +0200
To: Erik DeBill <erik@www.creditminders.com>
Cc: linux-kernel@vger.kernel.org, Olivier Molteni <olivier@molteni.net>,
        Francis Galiegue <fg@mandrakesoft.com>
Subject: nfs client oops, all 2.4 kernels
In-Reply-To: <20010910100202.A14106@www.creditminders.com>
In-Reply-To: <20010910100202.A14106@www.creditminders.com>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Erik DeBill <erik@www.creditminders.com> writes:

     > I've been running into a repeatable oops in the NFS client
     > code, apparently related to file locking.

This is the same Oops as was sent in by Olivier Molteni. It's due to
an incorrect assumption in the locking code. To repeat:

2 processes are calling close(), which under POSIX, tries to free all
locks held by a program. The problem occurs when you `dup()' a file.

In that case, both processes can call close() at the same time, thus
triggering a call to filp_close().

The race boils down to:

   -  locks_unlock_delete() assumes that the BKL (kernel_lock()) is
      sufficient to protect against *thisfl_p from disappearing
      beneath it due to some second process.
BUT
   -  The call to lock() in locks_unlock_delete() sleeps when the
      underlying filesystem is NFS, hence 2 processes can race despite
      the BKL assumption.

IMHO the correct thing to do is to detach the lock from the global
linked list *before* one makes the call to f_op->lock() down to the
NFS code.

This would probably entail splitting locks_delete_lock() into 2
procedures: one that does the unlinking from the global list:

        *thisfl_p = fl->fl_next;
        fl->fl_next = NULL;

        list_del(&fl->fl_link);
        INIT_LIST_HEAD(&fl->fl_link);

the other that does the rest.

Could you check if the appended patch works?

Cheers,
   Trond

--- linux-2.4.9/fs/locks.c.orig	Thu Jul  5 00:39:28 2001
+++ linux-2.4.9/fs/locks.c	Tue Sep 11 10:41:53 2001
@@ -473,21 +473,26 @@
 		fl->fl_insert(fl);
 }
 
-/* Delete a lock and then free it.
- * Remove our lock from the lock lists, wake up processes that are blocked
- * waiting for this lock, notify the FS that the lock has been cleared and
- * finally free the lock.
+/*
+ * Remove lock from the lock lists
  */
-static void locks_delete_lock(struct file_lock **thisfl_p, unsigned int wait)
+static inline void _unhash_lock(struct file_lock **thisfl_p)
 {
 	struct file_lock *fl = *thisfl_p;
 
 	*thisfl_p = fl->fl_next;
 	fl->fl_next = NULL;
 
-	list_del(&fl->fl_link);
-	INIT_LIST_HEAD(&fl->fl_link);
+	list_del_init(&fl->fl_link);
+}
 
+/*
+ * Wake up processes that are blocked waiting for this lock,
+ * notify the FS that the lock has been cleared and
+ * finally free the lock.
+ */
+static inline void _delete_lock(struct file_lock *fl, unsigned int wait)
+{
 	fasync_helper(0, fl->fl_file, 0, &fl->fl_fasync);
 	if (fl->fl_fasync != NULL){
 		printk(KERN_ERR "locks_delete_lock: fasync == %p\n", fl->fl_fasync);
@@ -502,6 +507,15 @@
 }
 
 /*
+ * Delete a lock and then free it.
+ */
+static void locks_delete_lock(struct file_lock **thisfl_p, unsigned int wait)
+{
+	_unhash_lock(thisfl_p);
+	_delete_lock(*thisfl_p, wait);
+}
+
+/*
  * Call back client filesystem in order to get it to unregister a lock,
  * then delete lock. Essentially useful only in locks_remove_*().
  * Note: this must be called with the semaphore already held!
@@ -511,12 +525,13 @@
 	struct file_lock *fl = *thisfl_p;
 	int (*lock)(struct file *, int, struct file_lock *);
 
+	_unhash_lock(thisfl_p);
 	if (fl->fl_file->f_op &&
 	    (lock = fl->fl_file->f_op->lock) != NULL) {
 		fl->fl_type = F_UNLCK;
 		lock(fl->fl_file, F_SETLK, fl);
 	}
-	locks_delete_lock(thisfl_p, 0);
+	_delete_lock(fl, 0);
 }
 
 /* Determine if lock sys_fl blocks lock caller_fl. Common functionality
@@ -1661,6 +1676,7 @@
 	while ((fl = *before) != NULL) {
 		if ((fl->fl_flags & FL_POSIX) && fl->fl_owner == owner) {
 			locks_unlock_delete(before);
+			before = &inode->i_flock;
 			continue;
 		}
 		before = &fl->fl_next;
