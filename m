Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316047AbSFDAiY>; Mon, 3 Jun 2002 20:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316051AbSFDAiX>; Mon, 3 Jun 2002 20:38:23 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:42650 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S316047AbSFDAiT>;
	Mon, 3 Jun 2002 20:38:19 -0400
Date: Tue, 4 Jun 2002 10:37:52 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <matthew@wil.cx>,
        "Michael Kerrisk" <mtk16@ext.canterbury.ac.nz>
Subject: [PATCH] Make file leases more stable
Message-Id: <20020604103752.4e030763.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

If you deem it appropriate, please apply this patch.

It makes the file leases much more stable and reliable in the
presence of multiple shared leases.  This patch cannot make
things worse than they currently are. :-)

There is a further problem with leases that I am working on, but that
is harder and will require more testing.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.4.19-pre9/fs/locks.c 2.4.19-pre9-leases.1/fs/locks.c
--- 2.4.19-pre9/fs/locks.c	Wed Oct 24 16:12:29 2001
+++ 2.4.19-pre9-leases.1/fs/locks.c	Wed May 29 10:38:57 2002
@@ -1051,6 +1051,30 @@
 	return -EINVAL;
 }
 
+/* We already had a lease on this file; just change its type */
+static int lease_modify(struct file_lock **before, int arg)
+{
+	struct file_lock *fl = *before;
+	int error = assign_type(fl, arg);
+	if (error < 0)
+		goto out;
+
+	locks_wake_up_blocks(fl, 0);
+
+	if (arg == F_UNLCK) {
+		struct file *filp = fl->fl_file;
+
+		filp->f_owner.pid = 0;
+		filp->f_owner.uid = 0;
+		filp->f_owner.euid = 0;
+		filp->f_owner.signum = 0;
+		locks_delete_lock(before, 0);
+	}
+
+out:
+	return error;
+}
+
 /**
  *	__get_lease	-	revoke all outstanding leases on file
  *	@inode: the inode of the file to return
@@ -1068,10 +1092,15 @@
 	struct file_lock *fl;
 	int alloc_err;
 
-	alloc_err = lease_alloc(NULL, 0, &new_fl);
+	alloc_err = lease_alloc(NULL, mode & FMODE_WRITE ? F_WRLCK : F_RDLCK,
+			&new_fl);
 
 	lock_kernel();
+
 	flock = inode->i_flock;
+	if ((flock->fl_flags & FL_LEASE) == 0)
+		goto out;
+
 	if (flock->fl_type & F_INPROGRESS) {
 		if ((mode & O_NONBLOCK)
 		    || (flock->fl_owner == current->files)) {
@@ -1111,11 +1140,10 @@
 	fl = flock;
 	do {
 		fl->fl_type = future;
+		kill_fasync(&fl->fl_fasync, SIGIO, POLL_MSG);
 		fl = fl->fl_next;
 	} while (fl != NULL && (fl->fl_flags & FL_LEASE));
 
-	kill_fasync(&flock->fl_fasync, SIGIO, POLL_MSG);
-
 	if ((mode & O_NONBLOCK) || (flock->fl_owner == current->files)) {
 		error = -EWOULDBLOCK;
 		goto out;
@@ -1128,13 +1156,30 @@
 restart:
 	error = locks_block_on_timeout(flock, new_fl, error);
 	if (error == 0) {
-		/* We timed out.  Unilaterally break the lease. */
-		locks_delete_lock(&inode->i_flock, 0);
-		printk(KERN_WARNING "lease timed out\n");
+		struct file_lock **fp;
+		/* We timed out.  Unilaterally break any leases that
+		 * are still in the process of being broken.
+		 */
+		fp = &inode->i_flock;
+		while (((fl = *fp) != NULL) && (fl->fl_flags & FL_LEASE)) {
+			if (!(fl->fl_type & F_INPROGRESS)) {
+				fp = &fl->fl_next;
+				continue;
+			}
+			printk(KERN_INFO "lease broken - owner pid = %d\n",
+					fl->fl_pid);
+			lease_modify(fp, fl->fl_type & ~F_INPROGRESS);
+			if (fl == *fp)
+				fp = &fl->fl_next;
+		}
 	} else if (error > 0) {
-		flock = inode->i_flock;
-		if (flock && (flock->fl_flags & FL_LEASE))
-			goto restart;
+		/* Wait for the next lease that has not been broken yet */
+		for (flock = inode->i_flock;
+				flock && flock->fl_flags & FL_LEASE;
+				flock = flock->fl_next) {
+			if (flock->fl_type & F_INPROGRESS)
+				goto restart;
+		}	
 		error = 0;
 	}
 
@@ -1166,45 +1211,40 @@
  *	@filp: the file
  *
  *	The value returned by this function will be one of
+ *	(if no lease break is pending):
  *
- *	%F_RDLCK to indicate a read-only (type II) lease is held.
+ *	%F_RDLCK to indicate a shared lease is held.
  *
  *	%F_WRLCK to indicate an exclusive lease is held.
  *
- *	XXX: sfr & i disagree over whether F_INPROGRESS
+ *	%F_UNLCK to indicate no lease is held.
+ *
+ *	(if a lease break is pending):
+ *
+ *	%F_RDLCK to indicate an exclusive lease needs to be
+ *		changed to a shared lease (or removed).
+ *
+ *	%F_UNLCK to indicate the lease needs to be removed.
+ *
+ *	XXX: sfr & willy disagree over whether F_INPROGRESS
  *	should be returned to userspace.
  */
 int fcntl_getlease(struct file *filp)
 {
 	struct file_lock *fl;
-	
-	fl = filp->f_dentry->d_inode->i_flock;
-	if ((fl == NULL) || ((fl->fl_flags & FL_LEASE) == 0))
-		return F_UNLCK;
-	return fl->fl_type & ~F_INPROGRESS;
-}
+	int type = F_UNLCK;
 
-/* We already had a lease on this file; just change its type */
-static int lease_modify(struct file_lock **before, int arg, int fd, struct file *filp)
-{
-	struct file_lock *fl = *before;
-	int error = assign_type(fl, arg);
-	if (error < 0)
-		goto out;
-
-	locks_wake_up_blocks(fl, 0);
-
-	if (arg == F_UNLCK) {
-		filp->f_owner.pid = 0;
-		filp->f_owner.uid = 0;
-		filp->f_owner.euid = 0;
-		filp->f_owner.signum = 0;
-		locks_delete_lock(before, 0);
-		fasync_helper(fd, filp, 0, &fl->fl_fasync);
+	lock_kernel();
+	for (fl = filp->f_dentry->d_inode->i_flock;
+			fl && (fl->fl_flags & FL_LEASE);
+			fl = fl->fl_next) {
+		if (fl->fl_file == filp) {
+			type = fl->fl_type & ~F_INPROGRESS;
+			break;
+		}
 	}
-
-out:
-	return error;
+	unlock_kernel();
+	return type;
 }
 
 /**
@@ -1224,32 +1264,36 @@
 	struct inode *inode;
 	int error, rdlease_count = 0, wrlease_count = 0;
 
+	lock_kernel();
+
 	dentry = filp->f_dentry;
 	inode = dentry->d_inode;
 
+	error = -EACCES;
 	if ((current->fsuid != inode->i_uid) && !capable(CAP_LEASE))
-		return -EACCES;
+		goto out_unlock;
+	error = -EINVAL;
 	if (!S_ISREG(inode->i_mode))
-		return -EINVAL;
+		goto out_unlock;
 
 	/*
 	 * FIXME: What about F_RDLCK and files open for writing?
 	 */
+	error = -EAGAIN;
 	if ((arg == F_WRLCK)
 	    && ((atomic_read(&dentry->d_count) > 1)
 		|| (atomic_read(&inode->i_count) > 1)))
-		return -EAGAIN;
+		goto out_unlock;
 
 	before = &inode->i_flock;
 
-	lock_kernel();
-
 	while ((fl = *before) != NULL) {
 		if (fl->fl_flags != FL_LEASE)
 			break;
 		if (fl->fl_file == filp)
 			my_before = before;
-		else if (fl->fl_type & F_WRLCK)
+		else if ((fl->fl_type & F_WRLCK)
+				|| (fl->fl_type == (F_INPROGRESS | F_UNLCK)))
 			wrlease_count++;
 		else
 			rdlease_count++;
@@ -1263,7 +1307,7 @@
 	}
 
 	if (my_before != NULL) {
-		error = lease_modify(my_before, arg, fd, filp);
+		error = lease_modify(my_before, arg);
 		goto out_unlock;
 	}
 
@@ -1710,10 +1754,15 @@
 	before = &inode->i_flock;
 
 	while ((fl = *before) != NULL) {
-		if ((fl->fl_flags & (FL_FLOCK|FL_LEASE))
-		    && (fl->fl_file == filp)) {
-			locks_delete_lock(before, 0);
-			continue;
+		if (fl->fl_file == filp) {
+			if (fl->fl_flags & FL_FLOCK) {
+				locks_delete_lock(before, 0);
+				continue;
+			}
+			if (fl->fl_flags & FL_LEASE) {
+				lease_modify(before, F_UNLCK);
+				continue;
+			}
  		}
 		before = &fl->fl_next;
 	}
@@ -1769,7 +1818,13 @@
 #endif
 			out += sprintf(out, "FLOCK  ADVISORY  ");
 	} else if (fl->fl_flags & FL_LEASE) {
-		out += sprintf(out, "LEASE  MANDATORY ");
+		out += sprintf(out, "LEASE  ");
+		if (fl->fl_type & F_INPROGRESS)
+			out += sprintf(out, "BREAKING  ");
+		else if (fl->fl_file)
+			out += sprintf(out, "ACTIVE    ");
+		else
+			out += sprintf(out, "BREAKER   ");
 	} else {
 		out += sprintf(out, "UNKNOWN UNKNOWN  ");
 	}
@@ -1782,7 +1837,9 @@
 	} else
 #endif
 		out += sprintf(out, "%s ",
-			       (fl->fl_type & F_WRLCK) ? "WRITE" : "READ ");
+			       (fl->fl_type & F_INPROGRESS)
+			       ? (fl->fl_type & F_UNLCK) ? "UNLCK" : "READ "
+			       : (fl->fl_type & F_WRLCK) ? "WRITE" : "READ ");
 	out += sprintf(out, "%d %s:%ld ",
 		     fl->fl_pid,
 		     inode ? kdevname(inode->i_dev) : "<none>",
