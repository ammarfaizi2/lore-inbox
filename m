Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267788AbTBEEN3>; Tue, 4 Feb 2003 23:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267792AbTBEEMf>; Tue, 4 Feb 2003 23:12:35 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:11022 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267787AbTBEELp>;
	Tue, 4 Feb 2003 23:11:45 -0500
Date: Tue, 4 Feb 2003 20:17:07 -0800
From: Greg KH <greg@kroah.com>
To: linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] LSM changes for 2.5.59
Message-ID: <20030205041707.GE16823@kroah.com>
References: <20030205041538.GA16823@kroah.com> <20030205041611.GB16823@kroah.com> <20030205041632.GC16823@kroah.com> <20030205041651.GD16823@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030205041651.GD16823@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.952.1.4, 2003/01/16 14:54:42-08:00, sds@epoch.ncsc.mil

[PATCH] Restore LSM hook calls to setpriority and setpgid

This patch restores the LSM hook calls in setpriority and setpgid to
2.5.58.  These hooks were previously added as of 2.5.27, but the hook
calls were subsequently lost as a result of other changes to the code
as of 2.5.37.

Ingo has signed off on this patch, and no one else has objected.


diff -Nru a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c	Wed Feb  5 14:58:27 2003
+++ b/kernel/sys.c	Wed Feb  5 14:58:27 2003
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
