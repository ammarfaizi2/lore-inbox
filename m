Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316961AbSEaW3l>; Fri, 31 May 2002 18:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316962AbSEaW3k>; Fri, 31 May 2002 18:29:40 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:34966 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S316961AbSEaW3k>; Fri, 31 May 2002 18:29:40 -0400
Message-ID: <3CF7F953.7DA13554@austin.ibm.com>
Date: Fri, 31 May 2002 17:29:39 -0500
From: Saurabh Desai <sdesai@austin.ibm.com>
Organization: IBM Corporation
X-Mailer: Mozilla 4.7 [en] (X11; U; AIX 4.3)
X-Accept-Language: en-US,en-GB
MIME-Version: 1.0
To: marcelo@conectiva.com.br
CC: linux-kernel@vger.kernel.org
Subject: [PATCH]2.4.19-pre9: fs/locks.c
Content-Type: multipart/mixed;
 boundary="------------E5EDFB8C140A9C8B8E7DC7B9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E5EDFB8C140A9C8B8E7DC7B9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


     The following patch addresses problem associated with
process locks when called from cloned process created with 
CLONE_THREAD flag. The fcntl locks are per-process and 
creates a dead-lock for cloned (w/CLONE_THREAD) processes.
It should use tgid instead pid (same way as getpid()).

Thanks,
Saurabh Desai  (sdesai@austin.ibm.com)
=======================================
--------------E5EDFB8C140A9C8B8E7DC7B9
Content-Type: text/plain; charset=us-ascii;
 name="fcntl-2.4.19-pre9.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fcntl-2.4.19-pre9.diff"

diff -Naur linux-2.4.19-pre9/fs/locks.c linux-2.4.19-pre9-patch/fs/locks.c
--- linux-2.4.19-pre9/fs/locks.c	Thu Oct 11 09:52:18 2001
+++ linux-2.4.19-pre9-patch/fs/locks.c	Fri May 31 13:40:49 2002
@@ -225,7 +225,7 @@
 
 	fl->fl_owner = NULL;
 	fl->fl_file = filp;
-	fl->fl_pid = current->pid;
+	fl->fl_pid = current->tgid;
 	fl->fl_flags = FL_FLOCK;
 	fl->fl_type = type;
 	fl->fl_start = 0;
@@ -284,7 +284,7 @@
 		fl->fl_end = OFFSET_MAX;
 	
 	fl->fl_owner = current->files;
-	fl->fl_pid = current->pid;
+	fl->fl_pid = current->tgid;
 	fl->fl_file = filp;
 	fl->fl_flags = FL_POSIX;
 	fl->fl_notify = NULL;
@@ -324,7 +324,7 @@
 		fl->fl_end = OFFSET_MAX;
 	
 	fl->fl_owner = current->files;
-	fl->fl_pid = current->pid;
+	fl->fl_pid = current->tgid;
 	fl->fl_file = filp;
 	fl->fl_flags = FL_POSIX;
 	fl->fl_notify = NULL;
@@ -353,7 +353,7 @@
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

--------------E5EDFB8C140A9C8B8E7DC7B9--

