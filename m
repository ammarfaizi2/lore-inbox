Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264919AbTANV2i>; Tue, 14 Jan 2003 16:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbTANV2i>; Tue, 14 Jan 2003 16:28:38 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:22416 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id <S264919AbTANV2g>;
	Tue, 14 Jan 2003 16:28:36 -0500
Message-Id: <200301142144.QAA17049@moss-shockers.ncsc.mil>
Date: Tue, 14 Jan 2003 16:44:51 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: [RFC][PATCH] Restore LSM hook calls to setpriority and setpgid
To: mingo@elte.hu, linux-kernel@vger.kernel.org
Cc: linux-security-module@wirex.com, sds@epoch.ncsc.mil
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: ecQ2nmNUHdpNucqFTMETXQ==
X-Mailer: dtmail 1.2.0 CDE Version 1.2 SunOS 5.6 sun4u sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch restores the LSM hook calls in setpriority and setpgid to
2.5.58.  These hooks were previously added as of 2.5.27, but the hook
calls were subsequently lost as a result of other changes to the code
as of 2.5.37.

If anyone has any objections to these changes, please let me know.

 sys.c |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)
-----

===== kernel/sys.c 1.38 vs edited =====
--- 1.38/kernel/sys.c	Thu Dec  5 21:56:43 2002
+++ edited/kernel/sys.c	Tue Jan 14 16:02:15 2003
@@ -212,18 +212,25 @@
 
 static int set_one_prio(struct task_struct *p, int niceval, int error)
 {
+	int no_nice;
+
 	if (p->uid != current->euid &&
 		p->uid != current->uid && !capable(CAP_SYS_NICE)) {
 		error = -EPERM;
 		goto out;
 	}
-
+	if (niceval < task_nice(p) && !capable(CAP_SYS_NICE)) {
+		error = -EACCES;
+		goto out;
+	}
+	no_nice = security_task_setnice(p, niceval);
+	if (no_nice) {
+		error = no_nice;
+		goto out;
+	}
 	if (error == -ESRCH)
 		error = 0;
-	if (niceval < task_nice(p) && !capable(CAP_SYS_NICE))
-		error = -EACCES;
-	else
-		set_user_nice(p, niceval);
+	set_user_nice(p, niceval);
 out:
 	return error;
 }
@@ -944,6 +951,10 @@
 	}
 
 ok_pgid:
+	err = security_task_setpgid(p, pgid);
+	if (err)
+		goto out;
+
 	if (p->pgrp != pgid) {
 		detach_pid(p, PIDTYPE_PGID);
 		p->pgrp = pgid;


--
Stephen Smalley, NSA
sds@epoch.ncsc.mil

