Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261940AbSIYIVe>; Wed, 25 Sep 2002 04:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261941AbSIYIVe>; Wed, 25 Sep 2002 04:21:34 -0400
Received: from mx1.elte.hu ([157.181.1.137]:30126 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261940AbSIYIVd>;
	Wed, 25 Sep 2002 04:21:33 -0400
Date: Wed, 25 Sep 2002 10:35:15 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] thread-flock-2.5.38-A3
Message-ID: <Pine.LNX.4.44.0209251030170.5122-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ulrich found another small detail wrt. POSIX requirements for threads -
this time it's the recursion features (read-held lock being write-locked
means an upgrade if the same 'process' is the owner, means a deadlock if a
different 'process').

this requirement even makes some sense - the group of threads who own a
lock really own all rights to the lock as well.

the attached patch against BK-curr fixes this, all testcases pass now.  
(inter-process testcases as well, which are not affected by this patch.)

(SIGURG and SIGIO semantics should also continue to work - there's some
more stuff we can optimize with the new pidhash in this area, but that's
for later.)

	Ingo

--- linux/fs/locks.c.orig	Wed Sep 25 10:28:26 2002
+++ linux/fs/locks.c	Wed Sep 25 10:28:41 2002
@@ -252,7 +252,7 @@
 		return -ENOMEM;
 
 	fl->fl_file = filp;
-	fl->fl_pid = current->pid;
+	fl->fl_pid = current->tgid;
 	fl->fl_flags = (cmd & LOCK_NB) ? FL_FLOCK : FL_FLOCK | FL_SLEEP;
 	fl->fl_type = type;
 	fl->fl_end = OFFSET_MAX;
@@ -308,7 +308,7 @@
 		fl->fl_end = OFFSET_MAX;
 	
 	fl->fl_owner = current->files;
-	fl->fl_pid = current->pid;
+	fl->fl_pid = current->tgid;
 	fl->fl_file = filp;
 	fl->fl_flags = FL_POSIX;
 	fl->fl_notify = NULL;
@@ -348,7 +348,7 @@
 		fl->fl_end = OFFSET_MAX;
 	
 	fl->fl_owner = current->files;
-	fl->fl_pid = current->pid;
+	fl->fl_pid = current->tgid;
 	fl->fl_file = filp;
 	fl->fl_flags = FL_POSIX;
 	fl->fl_notify = NULL;
@@ -377,7 +377,7 @@
 		return -ENOMEM;
 
 	fl->fl_owner = current->files;
-	fl->fl_pid = current->pid;
+	fl->fl_pid = current->tgid;
 
 	fl->fl_file = filp;
 	fl->fl_flags = FL_LEASE;
@@ -669,7 +669,7 @@
 	int error;
 
 	fl.fl_owner = current->files;
-	fl.fl_pid = current->pid;
+	fl.fl_pid = current->tgid;
 	fl.fl_file = filp;
 	fl.fl_flags = FL_POSIX | FL_ACCESS | FL_SLEEP;
 	fl.fl_type = (read_write == FLOCK_VERIFY_WRITE) ? F_WRLCK : F_RDLCK;
@@ -1241,7 +1241,7 @@
 	*before = fl;
 	list_add(&fl->fl_link, &file_lock_list);
 
-	error = f_setown(filp, current->pid, 1);
+	error = f_setown(filp, current->tgid, 1);
 out_unlock:
 	unlock_kernel();
 	return error;
@@ -1632,7 +1632,7 @@
 	lock.fl_start = 0;
 	lock.fl_end = OFFSET_MAX;
 	lock.fl_owner = owner;
-	lock.fl_pid = current->pid;
+	lock.fl_pid = current->tgid;
 	lock.fl_file = filp;
 
 	if (filp->f_op && filp->f_op->lock != NULL) {

