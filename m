Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316746AbSFFESj>; Thu, 6 Jun 2002 00:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316757AbSFFESi>; Thu, 6 Jun 2002 00:18:38 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:18324 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S316746AbSFFESh>;
	Thu, 6 Jun 2002 00:18:37 -0400
Date: Thu, 6 Jun 2002 14:18:04 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <matthew@wil.cx>,
        Trivial Kernel Patches <trivial@rustcorp.com.au>
Subject: [PATCH] fs/locks.c: add and use IS_{POSIX, FLOCK, LEASE} macros
Message-Id: <20020606141804.481247ca.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Another tirivla part of a Matthew Wilcox patch.  This just
defines macros for distinguishing the differnet types of locks.

This is relative to the previous two patches I sent you.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.20-sfr.2/fs/locks.c 2.5.20-sfr.3/fs/locks.c
--- 2.5.20-sfr.2/fs/locks.c	Thu Jun  6 01:39:11 2002
+++ 2.5.20-sfr.3/fs/locks.c	Thu Jun  6 14:04:20 2002
@@ -126,6 +126,10 @@
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
 
+#define IS_POSIX(fl)	(fl->fl_flags & FL_POSIX)
+#define IS_FLOCK(fl)	(fl->fl_flags & FL_FLOCK)
+#define IS_LEASE(fl)	(fl->fl_flags & FL_LEASE)
+
 int leases_enable = 1;
 int lease_break_time = 45;
 
@@ -563,8 +567,7 @@
 	/* POSIX locks owned by the same process do not conflict with
 	 * each other.
 	 */
-	if (!(sys_fl->fl_flags & FL_POSIX) ||
-	    locks_same_owner(caller_fl, sys_fl))
+	if (!IS_POSIX(sys_fl) || locks_same_owner(caller_fl, sys_fl))
 		return (0);
 
 	/* Check whether they overlap */
@@ -582,8 +585,7 @@
 	/* FLOCK locks referring to the same filp do not conflict with
 	 * each other.
 	 */
-	if (!(sys_fl->fl_flags & FL_FLOCK) ||
-	    (caller_fl->fl_file == sys_fl->fl_file))
+	if (!IS_FLOCK(sys_fl) || (caller_fl->fl_file == sys_fl->fl_file))
 		return (0);
 #ifdef MSNFS
 	if ((caller_fl->fl_type & LOCK_MAND) || (sys_fl->fl_type & LOCK_MAND))
@@ -636,7 +638,7 @@
 
 	lock_kernel();
 	for (cfl = filp->f_dentry->d_inode->i_flock; cfl; cfl = cfl->fl_next) {
-		if (!(cfl->fl_flags & FL_POSIX))
+		if (!IS_POSIX(cfl))
 			continue;
 		if (posix_locks_conflict(cfl, fl))
 			break;
@@ -698,7 +700,7 @@
 	 */
 	lock_kernel();
 	for (fl = inode->i_flock; fl != NULL; fl = fl->fl_next) {
-		if (!(fl->fl_flags & FL_POSIX))
+		if (!IS_POSIX(fl))
 			continue;
 		if (fl->fl_owner != owner)
 			break;
@@ -734,7 +736,7 @@
 	 * the proposed read/write.
 	 */
 	for (fl = inode->i_flock; fl != NULL; fl = fl->fl_next) {
-		if (!(fl->fl_flags & FL_POSIX))
+		if (!IS_POSIX(fl))
 			continue;
 		if (fl->fl_start > new_fl->fl_end)
 			break;
@@ -792,7 +794,7 @@
 search:
 	change = 0;
 	before = &inode->i_flock;
-	while (((fl = *before) != NULL) && (fl->fl_flags & FL_FLOCK)) {
+	while (((fl = *before) != NULL) && IS_FLOCK(fl)) {
 		if (filp == fl->fl_file) {
 			if (lock_type == fl->fl_type)
 				goto out;
@@ -817,7 +819,7 @@
 		goto out;
 
 repeat:
-	for (fl = inode->i_flock; (fl != NULL) && (fl->fl_flags & FL_FLOCK);
+	for (fl = inode->i_flock; (fl != NULL) && IS_FLOCK(fl);
 	     fl = fl->fl_next) {
 		if (!flock_locks_conflict(new_fl, fl))
 			continue;
@@ -882,7 +884,7 @@
 	if (caller->fl_type != F_UNLCK) {
   repeat:
 		for (fl = inode->i_flock; fl != NULL; fl = fl->fl_next) {
-			if (!(fl->fl_flags & FL_POSIX))
+			if (!IS_POSIX(fl))
 				continue;
 			if (!posix_locks_conflict(caller, fl))
 				continue;
@@ -911,7 +913,7 @@
 
 	/* First skip locks owned by other processes.
 	 */
-	while ((fl = *before) && (!(fl->fl_flags & FL_POSIX) ||
+	while ((fl = *before) && (!IS_POSIX(fl) ||
 				  !locks_same_owner(caller, fl))) {
 		before = &fl->fl_next;
 	}
@@ -1087,7 +1089,7 @@
 			if (error != 0)
 				goto out;
 			flock = inode->i_flock;
-			if (!(flock && (flock->fl_flags & FL_LEASE)))
+			if (!(flock && IS_LEASE(flock)))
 				goto out;
 		} while (flock->fl_type & F_INPROGRESS);
 	}
@@ -1112,7 +1114,7 @@
 	do {
 		fl->fl_type = future;
 		fl = fl->fl_next;
-	} while (fl != NULL && (fl->fl_flags & FL_LEASE));
+	} while (fl != NULL && IS_LEASE(fl));
 
 	kill_fasync(&flock->fl_fasync, SIGIO, POLL_MSG);
 
@@ -1133,7 +1135,7 @@
 		printk(KERN_WARNING "lease timed out\n");
 	} else if (error > 0) {
 		flock = inode->i_flock;
-		if (flock && (flock->fl_flags & FL_LEASE))
+		if (flock && IS_LEASE(flock))
 			goto restart;
 		error = 0;
 	}
@@ -1156,7 +1158,7 @@
 time_t lease_get_mtime(struct inode *inode)
 {
 	struct file_lock *flock = inode->i_flock;
-	if (flock && (flock->fl_flags & FL_LEASE) && (flock->fl_type & F_WRLCK))
+	if (flock && IS_LEASE(flock) && (flock->fl_type & F_WRLCK))
 		return CURRENT_TIME;
 	return inode->i_mtime;
 }
@@ -1179,7 +1181,7 @@
 	struct file_lock *fl;
 	
 	fl = filp->f_dentry->d_inode->i_flock;
-	if ((fl == NULL) || ((fl->fl_flags & FL_LEASE) == 0))
+	if ((fl == NULL) || !IS_LEASE(fl))
 		return F_UNLCK;
 	return fl->fl_type & ~F_INPROGRESS;
 }
@@ -1245,7 +1247,7 @@
 	lock_kernel();
 
 	while ((fl = *before) != NULL) {
-		if (fl->fl_flags != FL_LEASE)
+		if (!IS_LEASE(fl))
 			break;
 		if (fl->fl_file == filp)
 			my_before = before;
@@ -1648,7 +1650,7 @@
 	lock_kernel();
 	before = &inode->i_flock;
 	while ((fl = *before) != NULL) {
-		if ((fl->fl_flags & FL_POSIX) && fl->fl_owner == owner) {
+		if (IS_POSIX(fl) && fl->fl_owner == owner) {
 			locks_unlock_delete(before);
 			before = &inode->i_flock;
 			continue;
@@ -1674,8 +1676,7 @@
 	before = &inode->i_flock;
 
 	while ((fl = *before) != NULL) {
-		if ((fl->fl_flags & (FL_FLOCK|FL_LEASE))
-		    && (fl->fl_file == filp)) {
+		if ((IS_FLOCK(fl) || IS_LEASE(fl)) && (fl->fl_file == filp)) {
 			locks_delete_lock(before, 0);
 			continue;
  		}
@@ -1718,21 +1719,21 @@
 		inode = fl->fl_file->f_dentry->d_inode;
 
 	out += sprintf(out, "%d:%s ", id, pfx);
-	if (fl->fl_flags & FL_POSIX) {
+	if (IS_POSIX(fl)) {
 		out += sprintf(out, "%6s %s ",
 			     (fl->fl_flags & FL_ACCESS) ? "ACCESS" : "POSIX ",
 			     (inode == NULL) ? "*NOINODE*" :
 			     (IS_MANDLOCK(inode) &&
 			      (inode->i_mode & (S_IXGRP | S_ISGID)) == S_ISGID) ?
 			     "MANDATORY" : "ADVISORY ");
-	} else if (fl->fl_flags & FL_FLOCK) {
+	} else if (IS_FLOCK(fl)) {
 #ifdef MSNFS
 		if (fl->fl_type & LOCK_MAND) {
 			out += sprintf(out, "FLOCK  MSNFS     ");
 		} else
 #endif
 			out += sprintf(out, "FLOCK  ADVISORY  ");
-	} else if (fl->fl_flags & FL_LEASE) {
+	} else if (IS_LEASE(fl)) {
 		out += sprintf(out, "LEASE  MANDATORY ");
 	} else {
 		out += sprintf(out, "UNKNOWN UNKNOWN  ");
@@ -1846,12 +1847,12 @@
 	int result = 1;
 	lock_kernel();
 	for (fl = inode->i_flock; fl != NULL; fl = fl->fl_next) {
-		if (fl->fl_flags == FL_POSIX) {
+		if (IS_POSIX(fl)) {
 			if (fl->fl_type == F_RDLCK)
 				continue;
 			if ((fl->fl_end < start) || (fl->fl_start > (start + len)))
 				continue;
-		} else if (fl->fl_flags == FL_FLOCK) {
+		} else if (IS_FLOCK(fl)) {
 			if (!(fl->fl_type & LOCK_MAND))
 				continue;
 			if (fl->fl_type & LOCK_READ)
@@ -1884,10 +1885,10 @@
 	int result = 1;
 	lock_kernel();
 	for (fl = inode->i_flock; fl != NULL; fl = fl->fl_next) {
-		if (fl->fl_flags == FL_POSIX) {
+		if (IS_POSIX(fl)) {
 			if ((fl->fl_end < start) || (fl->fl_start > (start + len)))
 				continue;
-		} else if (fl->fl_flags == FL_FLOCK) {
+		} else if (IS_FLOCK(fl)) {
 			if (!(fl->fl_type & LOCK_MAND))
 				continue;
 			if (fl->fl_type & LOCK_WRITE)
