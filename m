Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316997AbSFFVyM>; Thu, 6 Jun 2002 17:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317002AbSFFVyM>; Thu, 6 Jun 2002 17:54:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56844 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316997AbSFFVyH>;
	Thu, 6 Jun 2002 17:54:07 -0400
Date: Thu, 6 Jun 2002 22:54:08 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
        Trivial Kernel Patches <trivial@rustcorp.com.au>
Subject: [PATCH] fs/locks.c: more cleanup
Message-ID: <20020606225408.N27186@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch applies on top of the recent series of patches I & sfr have sent.

Define the for_each_lock macro and start replacing ugly special for loops
with it.  Rejig the interface between sys_flock and flock_lock_file to
always pass a struct file_lock rather than a command.  Eliminate some
gotos by simplifying the logic.  Remove some redundant initialisation.

diff -u linux-2.5.15-flock/fs/locks.c linux-2.5.15-flock/fs/locks.c
--- linux-2.5.15-flock/fs/locks.c	Mon May 13 08:05:00 2002
+++ linux-2.5.15-flock/fs/locks.c	Tue May 14 07:32:42 2002
@@ -128,6 +128,9 @@
 int leases_enable = 1;
 int lease_break_time = 45;
 
+#define for_each_lock(inode, lockp) \
+	for (lockp = &inode->i_flock; *lockp != NULL; lockp = &(*lockp)->fl_next)
+
 LIST_HEAD(file_lock_list);
 static LIST_HEAD(blocked_list);
 
@@ -216,25 +223,41 @@
 	new->fl_u = fl->fl_u;
 }
 
+static inline int flock_translate_cmd(int cmd) {
+	if (cmd & LOCK_MAND)
+		return cmd & (LOCK_MAND | LOCK_RW);
+	switch (cmd &~ LOCK_NB) {
+	case LOCK_SH:
+		return F_RDLCK;
+	case LOCK_EX:
+		return F_WRLCK;
+	case LOCK_UN:
+		return F_UNLCK;
+	}
+	return -EINVAL;
+}
+
 /* Fill in a file_lock structure with an appropriate FLOCK lock. */
-static struct file_lock *flock_make_lock(struct file *filp, unsigned int type)
+static int flock_make_lock(struct file *filp,
+		struct file_lock **lock, unsigned int cmd)
 {
-	struct file_lock *fl = locks_alloc_lock(1);
+	struct file_lock *fl;
+	int type = flock_translate_cmd(cmd);
+	if (type < 0)
+		return type;
+	
+	fl = locks_alloc_lock(1);
 	if (fl == NULL)
-		return NULL;
+		return -ENOMEM;
 
-	fl->fl_owner = NULL;
 	fl->fl_file = filp;
 	fl->fl_pid = current->pid;
 	fl->fl_flags = FL_FLOCK;
 	fl->fl_type = type;
-	fl->fl_start = 0;
 	fl->fl_end = OFFSET_MAX;
-	fl->fl_notify = NULL;
-	fl->fl_insert = NULL;
-	fl->fl_remove = NULL;
 	
-	return fl;
+	*lock = fl;
+	return 0;
 }
 
 static int assign_type(struct file_lock *fl, int type)
@@ -746,59 +769,45 @@
  * at the head of the list, but that's secret knowledge known only to
  * flock_lock_file and posix_lock_file.
  */
-static int flock_lock_file(struct file *filp, unsigned int lock_type,
+static int flock_lock_file(struct file *filp, struct file_lock *new_fl,
 			   unsigned int wait)
 {
-	struct file_lock *fl;
-	struct file_lock *new_fl = NULL;
 	struct file_lock **before;
 	struct inode * inode = filp->f_dentry->d_inode;
-	int error, change;
-	int unlock = (lock_type == F_UNLCK);
-
-	/*
-	 * If we need a new lock, get it in advance to avoid races.
-	 */
-	if (!unlock) {
-		error = -ENOLCK;
-		new_fl = flock_make_lock(filp, lock_type);
-		if (!new_fl)
-			return error;
-	}
+	int error = 0;
+	int found = 0;
 
-	error = 0;
-search:
-	change = 0;
-	before = &inode->i_flock;
-	while (((fl = *before) != NULL) && IS_FLOCK(fl)) {
-		if (filp == fl->fl_file) {
-			if (lock_type == fl->fl_type)
-				goto out;
-			change = 1;
+	lock_kernel();
+	for_each_lock(inode, before) {
+		struct file_lock *fl = *before;
+		if (IS_POSIX(fl))
 			break;
-		}
-		before = &fl->fl_next;
-	}
-	/* change means that we are changing the type of an existing lock,
-	 * or else unlocking it.
-	 */
-	if (change) {
-		/* N.B. What if the wait argument is false? */
+		if (IS_LEASE(fl))
+			continue;
+		if (filp != fl->fl_file)
+			continue;
+		if (new_fl->fl_type == fl->fl_type)
+			goto out;
+		found = 1;
 		locks_delete_lock(before);
-		if (!unlock) {
-			yield();
-			/*
-			 * If we waited, another lock may have been added ...
-			 */
-			goto search;
-		}
+		break;
 	}
-	if (unlock)
-		goto out;
+	unlock_kernel();
 
+	if (found)
+		yield();
+
+	if (new_fl->fl_type == F_UNLCK)
+		return 0;
+
+	lock_kernel();
 repeat:
-	for (fl = inode->i_flock; (fl != NULL) && IS_FLOCK(fl);
-	     fl = fl->fl_next) {
+	for_each_lock(inode, before) {
+		struct file_lock *fl = *before;
+		if (IS_POSIX(fl))
+			break;
+		if (IS_LEASE(fl))
+			continue;
 		if (!flock_locks_conflict(new_fl, fl))
 			continue;
 		error = -EAGAIN;
@@ -810,12 +819,10 @@
 		goto repeat;
 	}
 	locks_insert_lock(&inode->i_flock, new_fl);
-	new_fl = NULL;
 	error = 0;
 
 out:
-	if (new_fl)
-		locks_free_lock(new_fl);
+	unlock_kernel();
 	return error;
 }
 
@@ -1015,20 +1022,6 @@
 	return error;
 }
 
-static inline int flock_translate_cmd(int cmd) {
-	if (cmd & LOCK_MAND)
-		return cmd & (LOCK_MAND | LOCK_RW);
-	switch (cmd &~ LOCK_NB) {
-	case LOCK_SH:
-		return F_RDLCK;
-	case LOCK_EX:
-		return F_WRLCK;
-	case LOCK_UN:
-		return F_UNLCK;
-	}
-	return -EINVAL;
-}
-
 /**
  *	__get_lease	-	revoke all outstanding leases on file
  *	@inode: the inode of the file to return
@@ -1297,26 +1290,26 @@
 asmlinkage long sys_flock(unsigned int fd, unsigned int cmd)
 {
 	struct file *filp;
-	int error, type;
+	struct file_lock *lock;
+	int error;
 
 	error = -EBADF;
 	filp = fget(fd);
 	if (!filp)
 		goto out;
 
-	error = flock_translate_cmd(cmd);
-	if (error < 0)
+	if ((cmd != LOCK_UN) && !(cmd & LOCK_MAND) && !(filp->f_mode & 3))
 		goto out_putf;
-	type = error;
 
-	error = -EBADF;
-	if ((type != F_UNLCK) && !(type & LOCK_MAND) && !(filp->f_mode & 3))
+	error = flock_make_lock(filp, &lock, cmd);
+	if (error < 0)
 		goto out_putf;
 
-	lock_kernel();
-	error = flock_lock_file(filp, type,
+	error = flock_lock_file(filp, lock,
 				(cmd & (LOCK_UN | LOCK_NB)) ? 0 : 1);
-	unlock_kernel();
+
+	if (error)
+		locks_free_lock(lock);
 
 out_putf:
 	fput(filp);

-- 
Revolutions do not require corporate support.
