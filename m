Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265396AbUHNUbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265396AbUHNUbT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 16:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265301AbUHNUat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 16:30:49 -0400
Received: from dh138.citi.umich.edu ([141.211.133.138]:387 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S265287AbUHNUaf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 16:30:35 -0400
Subject: PATCH [2/7] Fix posix locking code (resend with fixes)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1092511792.4109.22.camel@lade.trondhjem.org>
References: <1092511792.4109.22.camel@lade.trondhjem.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092515434.4109.59.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 14 Aug 2004 16:30:34 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 VFS: Enable filesystems and to hook certain functions for copying
      locks, and freeing locks using the new struct file_lock_operations.

 VFS: Enable lock managers (i.e. lockd) to hook functions for comparing
      lock ownership using the new struct lock_manager_operations.

 Signed-off-by: Trond Myklebust <trond.myklebust@fys.uio.no>

 fs/locks.c         |   32 ++++++++++++++++++++++++++------
 include/linux/fs.h |   11 +++++++++++
 2 files changed, 37 insertions(+), 6 deletions(-)

diff -u --recursive --new-file --show-c-function linux-2.6.8.1-01-fix_locks/fs/locks.c linux-2.6.8.1-02-fix_locks2/fs/locks.c
--- linux-2.6.8.1-01-fix_locks/fs/locks.c	2004-08-14 14:28:58.000000000 -0400
+++ linux-2.6.8.1-02-fix_locks2/fs/locks.c	2004-08-14 16:24:29.000000000 -0400
@@ -167,6 +167,13 @@ static inline void locks_free_lock(struc
 	if (!list_empty(&fl->fl_link))
 		panic("Attempting to free lock on active lock list");
 
+	if (fl->fl_ops) {
+		if (fl->fl_ops->fl_release_private)
+			fl->fl_ops->fl_release_private(fl);
+		fl->fl_ops = NULL;
+	}
+	fl->fl_lmops = NULL;
+
 	kmem_cache_free(filelock_cache, fl);
 }
 
@@ -186,6 +193,8 @@ void locks_init_lock(struct file_lock *f
 	fl->fl_notify = NULL;
 	fl->fl_insert = NULL;
 	fl->fl_remove = NULL;
+	fl->fl_ops = NULL;
+	fl->fl_lmops = NULL;
 }
 
 EXPORT_SYMBOL(locks_init_lock);
@@ -220,7 +229,10 @@ void locks_copy_lock(struct file_lock *n
 	new->fl_notify = fl->fl_notify;
 	new->fl_insert = fl->fl_insert;
 	new->fl_remove = fl->fl_remove;
-	new->fl_u = fl->fl_u;
+	new->fl_ops = fl->fl_ops;
+	new->fl_lmops = fl->fl_lmops;
+	if (fl->fl_ops && fl->fl_ops->fl_copy_lock)
+		fl->fl_ops->fl_copy_lock(new, fl);
 }
 
 EXPORT_SYMBOL(locks_copy_lock);
@@ -324,6 +336,8 @@ static int flock_to_posix_lock(struct fi
 	fl->fl_notify = NULL;
 	fl->fl_insert = NULL;
 	fl->fl_remove = NULL;
+	fl->fl_ops = NULL;
+	fl->fl_lmops = NULL;
 
 	return assign_type(fl, l->l_type);
 }
@@ -364,6 +378,8 @@ static int flock64_to_posix_lock(struct 
 	fl->fl_notify = NULL;
 	fl->fl_insert = NULL;
 	fl->fl_remove = NULL;
+	fl->fl_ops = NULL;
+	fl->fl_lmops = NULL;
 
 	switch (l->l_type) {
 	case F_RDLCK:
@@ -400,6 +416,8 @@ static int lease_alloc(struct file *filp
 	fl->fl_notify = NULL;
 	fl->fl_insert = NULL;
 	fl->fl_remove = NULL;
+	fl->fl_ops = NULL;
+	fl->fl_lmops = NULL;
 
 	*flp = fl;
 	return 0;
@@ -419,10 +437,9 @@ static inline int locks_overlap(struct f
 static inline int
 posix_same_owner(struct file_lock *fl1, struct file_lock *fl2)
 {
-	/* FIXME: Replace this sort of thing with struct file_lock_operations */
-	if ((fl1->fl_type | fl2->fl_type) & FL_LOCKD)
-		return fl1->fl_owner == fl2->fl_owner &&
-			fl1->fl_pid == fl2->fl_pid;
+	if (fl1->fl_lmops && fl1->fl_lmops->fl_compare_owner)
+		return fl2->fl_lmops == fl1->fl_lmops &&
+			fl1->fl_lmops->fl_compare_owner(fl1, fl2);
 	return fl1->fl_owner == fl2->fl_owner;
 }
 
@@ -1415,7 +1432,6 @@ int fcntl_getlk(struct file *filp, struc
 	error = -EFAULT;
 	if (!copy_to_user(l, &flock, sizeof(flock)))
 		error = 0;
-  
 out:
 	return error;
 }
@@ -1665,6 +1681,8 @@ void locks_remove_posix(struct file *fil
 	lock.fl_owner = owner;
 	lock.fl_pid = current->tgid;
 	lock.fl_file = filp;
+	lock.fl_ops = NULL;
+	lock.fl_lmops = NULL;
 
 	if (filp->f_op && filp->f_op->lock != NULL) {
 		filp->f_op->lock(filp, F_SETLK, &lock);
@@ -1684,6 +1702,8 @@ void locks_remove_posix(struct file *fil
 		before = &fl->fl_next;
 	}
 	unlock_kernel();
+	if (lock.fl_ops && lock.fl_ops->fl_release_private)
+		lock.fl_ops->fl_release_private(&lock);
 }
 
 EXPORT_SYMBOL(locks_remove_posix);
diff -u --recursive --new-file --show-c-function linux-2.6.8.1-01-fix_locks/include/linux/fs.h linux-2.6.8.1-02-fix_locks2/include/linux/fs.h
--- linux-2.6.8.1-01-fix_locks/include/linux/fs.h	2004-08-14 14:25:55.000000000 -0400
+++ linux-2.6.8.1-02-fix_locks2/include/linux/fs.h	2004-08-14 14:40:11.000000000 -0400
@@ -626,6 +626,15 @@ extern void close_private_file(struct fi
  */
 typedef struct files_struct *fl_owner_t;
 
+struct file_lock_operations {
+	void (*fl_copy_lock)(struct file_lock *, struct file_lock *);
+	void (*fl_release_private)(struct file_lock *);
+};
+
+struct lock_manager_operations {
+	int (*fl_compare_owner)(struct file_lock *, struct file_lock *);
+};
+
 /* that will die - we need it for nfs_lock_info */
 #include <linux/nfs_fs_i.h>
 
@@ -649,6 +658,8 @@ struct file_lock {
 	struct fasync_struct *	fl_fasync; /* for lease break notifications */
 	unsigned long fl_break_time;	/* for nonblocking lease breaks */
 
+	struct file_lock_operations *fl_ops;	/* Callbacks for filesystems */
+	struct lock_manager_operations *fl_lmops;	/* Callbacks for lockmanagers */
 	union {
 		struct nfs_lock_info	nfs_fl;
 	} fl_u;

