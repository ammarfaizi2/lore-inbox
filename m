Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbTILUNc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 16:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTILUNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 16:13:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15005 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261871AbTILUNS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 16:13:18 -0400
Date: Fri, 12 Sep 2003 21:13:16 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] file locking memory leak
Message-ID: <20030912201316.GD21596@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes a memory leak in the file locking code.  Each attempt
to unlock a file would result in the leak of a file lock.  Many thanks
to Martin Josefsson for providing the testcase which enabled me to figure
out the problem.

Index: fs/locks.c
===================================================================
RCS file: /var/cvs/linux-2.6/fs/locks.c,v
retrieving revision 1.1
diff -u -p -r1.1 locks.c
--- fs/locks.c	29 Jul 2003 17:01:37 -0000	1.1
+++ fs/locks.c	12 Sep 2003 19:07:38 -0000
@@ -221,7 +221,7 @@ void locks_copy_lock(struct file_lock *n
 static inline int flock_translate_cmd(int cmd) {
 	if (cmd & LOCK_MAND)
 		return cmd & (LOCK_MAND | LOCK_RW);
-	switch (cmd &~ LOCK_NB) {
+	switch (cmd) {
 	case LOCK_SH:
 		return F_RDLCK;
 	case LOCK_EX:
@@ -233,8 +233,8 @@ static inline int flock_translate_cmd(in
 }
 
 /* Fill in a file_lock structure with an appropriate FLOCK lock. */
-static int flock_make_lock(struct file *filp,
-		struct file_lock **lock, unsigned int cmd)
+static int flock_make_lock(struct file *filp, struct file_lock **lock,
+		unsigned int cmd)
 {
 	struct file_lock *fl;
 	int type = flock_translate_cmd(cmd);
@@ -247,7 +247,7 @@ static int flock_make_lock(struct file *
 
 	fl->fl_file = filp;
 	fl->fl_pid = current->tgid;
-	fl->fl_flags = (cmd & LOCK_NB) ? FL_FLOCK : FL_FLOCK | FL_SLEEP;
+	fl->fl_flags = FL_FLOCK;
 	fl->fl_type = type;
 	fl->fl_end = OFFSET_MAX;
 	
@@ -1298,6 +1298,7 @@ asmlinkage long sys_flock(unsigned int f
 {
 	struct file *filp;
 	struct file_lock *lock;
+	int can_sleep, unlock;
 	int error;
 
 	error = -EBADF;
@@ -1305,12 +1306,18 @@ asmlinkage long sys_flock(unsigned int f
 	if (!filp)
 		goto out;
 
-	if ((cmd != LOCK_UN) && !(cmd & LOCK_MAND) && !(filp->f_mode & 3))
+	can_sleep = !(cmd & LOCK_NB);
+	cmd &= ~LOCK_NB;
+	unlock = (cmd == LOCK_UN);
+
+	if (!unlock && !(cmd & LOCK_MAND) && !(filp->f_mode & 3))
 		goto out_putf;
 
 	error = flock_make_lock(filp, &lock, cmd);
 	if (error)
 		goto out_putf;
+	if (can_sleep)
+		lock->fl_flags |= FL_SLEEP;
 
 	error = security_file_lock(filp, cmd);
 	if (error)
@@ -1318,7 +1325,7 @@ asmlinkage long sys_flock(unsigned int f
 
 	for (;;) {
 		error = flock_lock_file(filp, lock);
-		if ((error != -EAGAIN) || (cmd & LOCK_NB))
+		if ((error != -EAGAIN) || !can_sleep)
 			break;
 		error = wait_event_interruptible(lock->fl_wait, !lock->fl_next);
 		if (!error)
@@ -1329,7 +1336,7 @@ asmlinkage long sys_flock(unsigned int f
 	}
 
  out_free:
-	if (error) {
+	if (unlock || error) {
 		locks_free_lock(lock);
 	}
 

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
