Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316962AbSEaWf6>; Fri, 31 May 2002 18:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316963AbSEaWf5>; Fri, 31 May 2002 18:35:57 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:38808 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S316962AbSEaWf4>; Fri, 31 May 2002 18:35:56 -0400
Message-ID: <3CF7FACC.2113122@austin.ibm.com>
Date: Fri, 31 May 2002 17:35:56 -0500
From: Saurabh Desai <sdesai@austin.ibm.com>
Organization: IBM Corporation
X-Mailer: Mozilla 4.7 [en] (X11; U; AIX 4.3)
X-Accept-Language: en-US,en-GB
MIME-Version: 1.0
To: torvalds@transmeta.com, davej@suse.de
CC: linux-kernel@vger.kernel.org
Subject: [PATCH]2.5.19:fs/locks.c
Content-Type: multipart/mixed;
 boundary="------------545A5596DB6F0113D175A045"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------545A5596DB6F0113D175A045
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


The following patch addresses problem associated with
process locks when called from the cloned process created 
with CLONE_THREAD flag. The fcntl locks are per-process and 
creates a dead-lock for cloned (w/CLONE_THREAD) processes.
It should use tgid instead pid (same way as getpid()).

Thanks,
Saurabh Desai  (sdesai@austin.ibm.com)
=======================================
--------------545A5596DB6F0113D175A045
Content-Type: text/plain; charset=us-ascii;
 name="fcntl_locks-2.5.19.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fcntl_locks-2.5.19.diff"

diff -Naur linux-2.5.19/fs/locks.c linux-2.5.19-patch/fs/locks.c
--- linux-2.5.19/fs/locks.c	Wed May 29 13:42:53 2002
+++ linux-2.5.19-patch/fs/locks.c	Fri May 31 13:24:12 2002
@@ -226,7 +226,7 @@
 
 	fl->fl_owner = NULL;
 	fl->fl_file = filp;
-	fl->fl_pid = current->pid;
+	fl->fl_pid = current->tgid;
 	fl->fl_flags = FL_FLOCK;
 	fl->fl_type = type;
 	fl->fl_start = 0;
@@ -285,7 +285,7 @@
 		fl->fl_end = OFFSET_MAX;
 	
 	fl->fl_owner = current->files;
-	fl->fl_pid = current->pid;
+	fl->fl_pid = current->tgid;
 	fl->fl_file = filp;
 	fl->fl_flags = FL_POSIX;
 	fl->fl_notify = NULL;
@@ -325,7 +325,7 @@
 		fl->fl_end = OFFSET_MAX;
 	
 	fl->fl_owner = current->files;
-	fl->fl_pid = current->pid;
+	fl->fl_pid = current->tgid;
 	fl->fl_file = filp;
 	fl->fl_flags = FL_POSIX;
 	fl->fl_notify = NULL;
@@ -354,7 +354,7 @@
 		return -ENOMEM;
 
 	fl->fl_owner = current->files;
-	fl->fl_pid = current->pid;
+	fl->fl_pid = current->tgid;
 
 	fl->fl_file = filp;
 	fl->fl_flags = FL_LEASE;
@@ -719,7 +719,7 @@
 		return -ENOMEM;
 
 	new_fl->fl_owner = current->files;
-	new_fl->fl_pid = current->pid;
+	new_fl->fl_pid = current->tgid;
 	new_fl->fl_file = filp;
 	new_fl->fl_flags = FL_POSIX | FL_ACCESS;
 	new_fl->fl_type = (read_write == FLOCK_VERIFY_WRITE) ? F_WRLCK : F_RDLCK;

--------------545A5596DB6F0113D175A045--

