Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261271AbSJCVdr>; Thu, 3 Oct 2002 17:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261332AbSJCVdr>; Thu, 3 Oct 2002 17:33:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13331 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261271AbSJCVdq>;
	Thu, 3 Oct 2002 17:33:46 -0400
Date: Thu, 3 Oct 2002 22:39:18 +0100
From: Matthew Wilcox <willy@debian.org>
To: mingo@redhat.com, Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove another for_each_process loop
Message-ID: <20021003223918.K28586@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Convert send_sigurg() to the for_each_task_pid() mechanism.  Also in
the case where we were trying to send a signal to a non-existent PID,
don't bother searching for -PID in the PGID array; we won't find it.

diff -urpNX dontdiff linux-2.5.40/fs/fcntl.c linux-2.5.40-willy/fs/fcntl.c
--- linux-2.5.40/fs/fcntl.c	2002-10-01 03:06:17.000000000 -0400
+++ linux-2.5.40-willy/fs/fcntl.c	2002-10-03 15:48:19.000000000 -0400
@@ -491,15 +491,17 @@ void send_sigio(struct fown_struct *fown
 		goto out_unlock_fown;
 	
 	read_lock(&tasklist_lock);
-	if ( (pid > 0) && (p = find_task_by_pid(pid)) ) {
-		send_sigio_to_task(p, fown, fd, band);
-		goto out_unlock_task;
-	}
-	for_each_task_pid(-pid, PIDTYPE_PGID, p, l, pidptr)
-		send_sigio_to_task(p, fown,fd,band);
-out_unlock_task:
+	if (pid > 0) {
+		if (p = find_task_by_pid(pid)) {
+			send_sigio_to_task(p, fown, fd, band);
+		}
+	} else {
+		for_each_task_pid(-pid, PIDTYPE_PGID, p, l, pidptr) {
+			send_sigio_to_task(p, fown, fd, band);
+		}
+	}
 	read_unlock(&tasklist_lock);
-out_unlock_fown:
+ out_unlock_fown:
 	read_unlock(&fown->lock);
 }
 
@@ -523,21 +525,17 @@ int send_sigurg(struct fown_struct *fown
 	ret = 1;
 	
 	read_lock(&tasklist_lock);
-	if ((pid > 0) && (p = find_task_by_pid(pid))) {
-		send_sigurg_to_task(p, fown);
-		goto out_unlock_task;
-	}
-	for_each_process(p) {
-		int match = p->pid;
-		if (pid < 0)
-			match = -p->pgrp;
-		if (pid != match)
-			continue;
-		send_sigurg_to_task(p, fown);
+	if (pid > 0) {
+		if (p = find_task_by_pid(pid)) {
+			send_sigurg_to_task(p, fown);
+		}
+	} else {
+		for_each_task_pid(-pid, PIDTYPE_PGID, p, l, pidptr) {
+			send_sigurg_to_task(p, fown);
+		}
 	}
-out_unlock_task:
 	read_unlock(&tasklist_lock);
-out_unlock_fown:
+ out_unlock_fown:
 	read_unlock(&fown->lock);
 	return ret;
 }

-- 
Revolutions do not require corporate support.
