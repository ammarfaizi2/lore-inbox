Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbVCTKP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbVCTKP1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 05:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVCTKP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 05:15:26 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:36271 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S262092AbVCTKOo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 05:14:44 -0500
Subject: [PATCH][5/5] Four more sysctls
In-Reply-To: <1111278162.22BA.5209@neapel230.server4you.de>
Date: Sun, 20 Mar 2005 11:14:43 +0100
Message-Id: <1111313683.1702.17773@neapel230.server4you.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add four more sysctls: proc.maps, proc.stat, proc.statm, proc.status.

diff -pur l1/fs/proc/base.c l2/fs/proc/base.c
--- l1/fs/proc/base.c	2005-03-19 20:10:22.000000000 +0100
+++ l2/fs/proc/base.c	2005-03-19 20:11:38.000000000 +0100
@@ -149,11 +149,11 @@ static struct pid_entry tgid_base_stuff[
 	E(PROC_TGID_FD,        "fd",      S_IFDIR|S_IRUSR|S_IXUSR),
 	E(PROC_TGID_ENVIRON,   "environ", S_IFREG|S_IRUSR),
 	E(PROC_TGID_AUXV,      "auxv",	  S_IFREG|S_IRUSR),
-	E(PROC_TGID_STATUS,    "status",  S_IFREG|S_IRUGO),
+	S(PROC_TGID_STATUS,    "status",  S_IFREG|S_IRUGO, PROC_STATUS),
 	S(PROC_TGID_CMDLINE,   "cmdline", S_IFREG|S_IRUGO, PROC_CMDLINE),
-	E(PROC_TGID_STAT,      "stat",    S_IFREG|S_IRUGO),
-	E(PROC_TGID_STATM,     "statm",   S_IFREG|S_IRUGO),
-	E(PROC_TGID_MAPS,      "maps",    S_IFREG|S_IRUGO),
+	S(PROC_TGID_STAT,      "stat",    S_IFREG|S_IRUGO, PROC_STAT),
+	S(PROC_TGID_STATM,     "statm",   S_IFREG|S_IRUGO, PROC_STATM),
+	S(PROC_TGID_MAPS,      "maps",    S_IFREG|S_IRUGO, PROC_MAPS),
 	E(PROC_TGID_MEM,       "mem",     S_IFREG|S_IRUSR|S_IWUSR),
 #ifdef CONFIG_SECCOMP
 	E(PROC_TGID_SECCOMP,   "seccomp", S_IFREG|S_IRUSR|S_IWUSR),
@@ -185,11 +185,11 @@ static struct pid_entry tid_base_stuff[]
 	E(PROC_TID_FD,         "fd",      S_IFDIR|S_IRUSR|S_IXUSR),
 	E(PROC_TID_ENVIRON,    "environ", S_IFREG|S_IRUSR),
 	E(PROC_TID_AUXV,       "auxv",	  S_IFREG|S_IRUSR),
-	E(PROC_TID_STATUS,     "status",  S_IFREG|S_IRUGO),
+	S(PROC_TID_STATUS,     "status",  S_IFREG|S_IRUGO, PROC_STATUS),
 	S(PROC_TID_CMDLINE,    "cmdline", S_IFREG|S_IRUGO, PROC_CMDLINE),
-	E(PROC_TID_STAT,       "stat",    S_IFREG|S_IRUGO),
-	E(PROC_TID_STATM,      "statm",   S_IFREG|S_IRUGO),
-	E(PROC_TID_MAPS,       "maps",    S_IFREG|S_IRUGO),
+	S(PROC_TID_STAT,       "stat",    S_IFREG|S_IRUGO, PROC_STAT),
+	S(PROC_TID_STATM,      "statm",   S_IFREG|S_IRUGO, PROC_STATM),
+	S(PROC_TID_MAPS,       "maps",    S_IFREG|S_IRUGO, PROC_MAPS),
 	E(PROC_TID_MEM,        "mem",     S_IFREG|S_IRUSR|S_IWUSR),
 #ifdef CONFIG_SECCOMP
 	E(PROC_TID_SECCOMP,    "seccomp", S_IFREG|S_IRUSR|S_IWUSR),
@@ -242,6 +242,10 @@ static struct pid_entry tid_attr_stuff[]
 /* Order and number of elements must match CTL_PROC table in sysctl.h! */
 mode_t proc_base_permissions[] = {
 	S_IRUGO,	/* PROC_CMDLINE */
+	S_IRUGO,	/* PROC_MAPS */
+	S_IRUGO,	/* PROC_STAT */
+	S_IRUGO,	/* PROC_STATM */
+	S_IRUGO,	/* PROC_STATUS */
 };
 
 static void proc_update_mode(struct inode *inode)
diff -pur l1/include/linux/sysctl.h l2/include/linux/sysctl.h
--- l1/include/linux/sysctl.h	2005-03-19 20:08:27.000000000 +0100
+++ l2/include/linux/sysctl.h	2005-03-19 20:10:31.000000000 +0100
@@ -656,6 +656,10 @@ enum {
 /* CTL_PROC names: */
 enum {
 	PROC_CMDLINE	= 1,
+	PROC_MAPS	= 2,
+	PROC_STAT	= 3,
+	PROC_STATM	= 4,
+	PROC_STATUS	= 5,
 };
 
 /* CTL_FS names: */
diff -pur l1/kernel/sysctl.c l2/kernel/sysctl.c
--- l1/kernel/sysctl.c	2005-03-19 20:08:27.000000000 +0100
+++ l2/kernel/sysctl.c	2005-03-19 20:10:31.000000000 +0100
@@ -853,6 +853,38 @@ static ctl_table proc_table[] = {
 		.proc_handler	= &proc_domode,
 		.extra1		= &mode_r_ugo,
 	},
+	{
+		.ctl_name	= PROC_MAPS,
+		.procname	= "maps",
+		.data		= &proc_base_permissions[PROC_MAPS-1],
+		.mode		= 0644,
+		.proc_handler	= &proc_domode,
+		.extra1		= &mode_r_ugo,
+	},
+	{
+		.ctl_name	= PROC_STAT,
+		.procname	= "stat",
+		.data		= &proc_base_permissions[PROC_STAT-1],
+		.mode		= 0644,
+		.proc_handler	= &proc_domode,
+		.extra1		= &mode_r_ugo,
+	},
+	{
+		.ctl_name	= PROC_STATM,
+		.procname	= "statm",
+		.data		= &proc_base_permissions[PROC_STATM-1],
+		.mode		= 0644,
+		.proc_handler	= &proc_domode,
+		.extra1		= &mode_r_ugo,
+	},
+	{
+		.ctl_name	= PROC_STATUS,
+		.procname	= "status",
+		.data		= &proc_base_permissions[PROC_STATUS-1],
+		.mode		= 0644,
+		.proc_handler	= &proc_domode,
+		.extra1		= &mode_r_ugo,
+	},
 #endif
 	{ .ctl_name = 0 }
 };

