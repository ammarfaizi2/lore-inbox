Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318923AbSG1Hvf>; Sun, 28 Jul 2002 03:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318929AbSG1Hvf>; Sun, 28 Jul 2002 03:51:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14086 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318923AbSG1Hvc>;
	Sun, 28 Jul 2002 03:51:32 -0400
Date: Sun, 28 Jul 2002 08:54:51 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/locks.c: eliminate locks_unlock_delete
Message-ID: <20020728085451.K1441@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


locks_unlock_delete is buggy in a couple of different ways (previously
reported by Brian Dixon).  Rather than fix it, this patch simply
deletes it and has the normal posix file locking mechanisms deal with
locks_remove_posix instead.

--- linux-2.5.29/fs/locks.c	2002-07-27 12:09:31.000000000 -0600
+++ linux-2.5.29-willy/fs/locks.c	2002-07-28 01:45:55.000000000 -0600
@@ -477,27 +477,21 @@ static void locks_insert_lock(struct fil
 }
 
 /*
- * Remove lock from the lock lists
+ * Delete a lock and then free it.
+ * Wake up processes that are blocked waiting for this lock,
+ * notify the FS that the lock has been cleared and
+ * finally free the lock.
  */
-static inline void _unhash_lock(struct file_lock **thisfl_p)
+static void locks_delete_lock(struct file_lock **thisfl_p)
 {
 	struct file_lock *fl = *thisfl_p;
 
 	*thisfl_p = fl->fl_next;
 	fl->fl_next = NULL;
-
 	list_del_init(&fl->fl_link);
-}
 
-/*
- * Wake up processes that are blocked waiting for this lock,
- * notify the FS that the lock has been cleared and
- * finally free the lock.
- */
-static inline void _delete_lock(struct file_lock *fl)
-{
 	fasync_helper(0, fl->fl_file, 0, &fl->fl_fasync);
-	if (fl->fl_fasync != NULL){
+	if (fl->fl_fasync != NULL) {
 		printk(KERN_ERR "locks_delete_lock: fasync == %p\n", fl->fl_fasync);
 		fl->fl_fasync = NULL;
 	}
@@ -509,36 +503,6 @@ static inline void _delete_lock(struct f
 	locks_free_lock(fl);
 }
 
-/*
- * Delete a lock and then free it.
- */
-static void locks_delete_lock(struct file_lock **thisfl_p)
-{
-	struct file_lock *fl = *thisfl_p;
-
-	_unhash_lock(thisfl_p);
-	_delete_lock(fl);
-}
-
-/*
- * Call back client filesystem in order to get it to unregister a lock,
- * then delete lock. Essentially useful only in locks_remove_*().
- * Note: this must be called with the semaphore already held!
- */
-static inline void locks_unlock_delete(struct file_lock **thisfl_p)
-{
-	struct file_lock *fl = *thisfl_p;
-	int (*lock)(struct file *, int, struct file_lock *);
-
-	_unhash_lock(thisfl_p);
-	if (fl->fl_file->f_op &&
-	    (lock = fl->fl_file->f_op->lock) != NULL) {
-		fl->fl_type = F_UNLCK;
-		lock(fl->fl_file, F_SETLK, fl);
-	}
-	_delete_lock(fl);
-}
-
 /* Determine if lock sys_fl blocks lock caller_fl. Common functionality
  * checks for shared/exclusive status of overlapping locks.
  */
@@ -1638,37 +1602,27 @@ out:
 
 /*
  * This function is called when the file is being removed
- * from the task's fd array.
+ * from the task's fd array.  POSIX locks belonging to this task
+ * are deleted at this time.
  */
 void locks_remove_posix(struct file *filp, fl_owner_t owner)
 {
-	struct inode * inode = filp->f_dentry->d_inode;
-	struct file_lock *fl;
-	struct file_lock **before;
+	struct file_lock lock;
 
-	/*
-	 * For POSIX locks we free all locks on this file for the given task.
-	 */
-	if (!inode->i_flock) {
-		/*
-		 * Notice that something might be grabbing a lock right now.
-		 * Consider it as a race won by us - event is async, so even if
-		 * we miss the lock added we can trivially consider it as added
-		 * after we went through this call.
-		 */
-		return;
-	}
-	lock_kernel();
-	before = &inode->i_flock;
-	while ((fl = *before) != NULL) {
-		if (IS_POSIX(fl) && fl->fl_owner == owner) {
-			locks_unlock_delete(before);
-			before = &inode->i_flock;
-			continue;
-		}
-		before = &fl->fl_next;
+	lock.fl_type = F_UNLCK;
+	lock.fl_flags = FL_POSIX;
+	lock.fl_start = 0;
+	lock.fl_end = OFFSET_MAX;
+	lock.fl_owner = owner;
+	lock.fl_pid = current->pid;
+	lock.fl_file = filp;
+
+	if (filp->f_op && filp->f_op->lock != NULL) {
+		filp->f_op->lock(filp, F_SETLK, &lock);
+		/* Ignore any error -- we must remove the locks anyway */
 	}
-	unlock_kernel();
+
+	posix_lock_file(filp, &lock, 0);
 }
 
 /*

-- 
Revolutions do not require corporate support.
