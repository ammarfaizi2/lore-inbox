Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268835AbRIKNPk>; Tue, 11 Sep 2001 09:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266827AbRIKNPa>; Tue, 11 Sep 2001 09:15:30 -0400
Received: from pat.uio.no ([129.240.130.16]:7042 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S268017AbRIKNPU>;
	Tue, 11 Sep 2001 09:15:20 -0400
To: Erik DeBill <erik@www.creditminders.com>,
        Olivier Molteni <olivier@molteni.net>
Cc: linux-kernel@vger.kernel.org, Francis Galiegue <fg@mandrakesoft.com>
Subject: Re: nfs client oops, all 2.4 kernels
In-Reply-To: <20010910100202.A14106@www.creditminders.com>
	<15261.53031.349271.425562@charged.uio.no>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 11 Sep 2001 15:15:34 +0200
In-Reply-To: Trond Myklebust's message of "Tue, 11 Sep 2001 10:45:27 +0200"
Message-ID: <shsitep7ts9.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Trond Myklebust <trond.myklebust@fys.uio.no> writes:

     > Could you check if the appended patch works?

The previous patch had a bug in the rewrite of locks_delete_lock()
which will Oops/corrupt the inode->i_flock list. Please consign to
/dev/null, and try the following instead.

(Note to self: Never attempt to write any patches *before* lunch...)

Cheers,
   Trond

--- linux-2.4.9/fs/locks.c.orig	Thu Jul  5 00:39:28 2001
+++ linux-2.4.9/fs/locks.c	Tue Sep 11 15:09:13 2001
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
@@ -502,6 +507,17 @@
 }
 
 /*
+ * Delete a lock and then free it.
+ */
+static void locks_delete_lock(struct file_lock **thisfl_p, unsigned int wait)
+{
+	struct file_lock *fl = *thisfl_p;
+
+	_unhash_lock(thisfl_p);
+	_delete_lock(fl, wait);
+}
+
+/*
  * Call back client filesystem in order to get it to unregister a lock,
  * then delete lock. Essentially useful only in locks_remove_*().
  * Note: this must be called with the semaphore already held!
@@ -511,12 +527,13 @@
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
@@ -1661,6 +1678,7 @@
 	while ((fl = *before) != NULL) {
 		if ((fl->fl_flags & FL_POSIX) && fl->fl_owner == owner) {
 			locks_unlock_delete(before);
+			before = &inode->i_flock;
 			continue;
 		}
 		before = &fl->fl_next;
