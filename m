Return-Path: <linux-kernel-owner+w=401wt.eu-S932513AbWLOAqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbWLOAqf (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 19:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbWLOAqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 19:46:35 -0500
Received: from l2mail1.panix.com ([166.84.1.75]:60508 "EHLO l2mail1.panix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932513AbWLOAqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 19:46:34 -0500
Message-Id: <20061215002334.039728000@panix.com>
References: <20061215001639.988521000@panix.com>
User-Agent: quilt/0.45-1
Date: Thu, 14 Dec 2006 16:16:41 -0800
From: Zack Weinberg <zackw@panix.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, jmorris@namei.org,
       Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2/4] permission mapping for sys_syslog operations
Content-Disposition: inline; filename=map_perms.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by Stephen Smalley: map the various sys_syslog operations
to a smaller set of privilege codes before calling security modules.
This patch changes the security module interface!  There should be no
change in the actual security semantics enforced by dummy, capability,
nor SELinux (with one exception, clearly marked in sys_syslog).

Change from previous version of patch: the privilege codes are now
in linux/security.h instead of linux/klog.h, and use the LSM_* naming
convention used for other such constants in that file.

zw


Index: linux-2.6/kernel/printk.c
===================================================================
--- linux-2.6.orig/kernel/printk.c	2006-12-13 16:06:22.000000000 -0800
+++ linux-2.6/kernel/printk.c	2006-12-13 16:08:30.000000000 -0800
@@ -164,6 +164,12 @@
 
 __setup("log_buf_len=", log_buf_len_setup);
 
+#define security_syslog_or_fail(type) do {		\
+		int error = security_syslog(type);	\
+		if (error)				\
+			return error;			\
+	} while (0)
+
 /* See linux/klog.h for the command numbers passed as the first argument.  */
 int do_syslog(int type, char __user *buf, int len)
 {
@@ -172,16 +178,15 @@
 	char c;
 	int error = 0;
 
-	error = security_syslog(type);
-	if (error)
-		return error;
-
 	switch (type) {
 	case KLOG_CLOSE:
+		security_syslog_or_fail(LSM_KLOG_READ);
 		break;
 	case KLOG_OPEN:
+		security_syslog_or_fail(LSM_KLOG_READ);
 		break;
 	case KLOG_READ:
+		security_syslog_or_fail(LSM_KLOG_READ);
 		error = -EINVAL;
 		if (!buf || len < 0)
 			goto out;
@@ -213,9 +218,11 @@
 			error = i;
 		break;
 	case KLOG_READ_CLEAR_HIST:
+		security_syslog_or_fail(LSM_KLOG_CLEARHIST);
 		do_clear = 1;
 		/* FALL THRU */
 	case KLOG_READ_HIST:
+		security_syslog_or_fail(LSM_KLOG_READHIST);
 		error = -EINVAL;
 		if (!buf || len < 0)
 			goto out;
@@ -269,15 +276,19 @@
 		}
 		break;
 	case KLOG_CLEAR_HIST:
+		security_syslog_or_fail(LSM_KLOG_CLEARHIST);
 		logged_chars = 0;
 		break;
 	case KLOG_DISABLE_CONSOLE:
+		security_syslog_or_fail(LSM_KLOG_CONSOLE);
 		console_loglevel = minimum_console_loglevel;
 		break;
 	case KLOG_ENABLE_CONSOLE:
+		security_syslog_or_fail(LSM_KLOG_CONSOLE);
 		console_loglevel = default_console_loglevel;
 		break;
 	case KLOG_SET_CONSOLE_LVL:
+		security_syslog_or_fail(LSM_KLOG_CONSOLE);
 		error = -EINVAL;
 		if (len < 1 || len > 8)
 			goto out;
@@ -287,9 +298,18 @@
 		error = 0;
 		break;
 	case KLOG_GET_UNREAD:
+		security_syslog_or_fail(LSM_KLOG_READ);
 		error = log_end - log_start;
 		break;
 	case KLOG_GET_SIZE:
+		/* This one is allowed if you have _either_
+		   LSM_KLOG_READ or LSM_KLOG_READHIST.  */
+		error = security_syslog(LSM_KLOG_READ);
+		if (error)
+			error = security_syslog(LSM_KLOG_READHIST);
+		if (error)
+			break;
+
 		error = log_buf_len;
 		break;
 	default:
Index: linux-2.6/security/commoncap.c
===================================================================
--- linux-2.6.orig/security/commoncap.c	2006-12-13 16:06:22.000000000 -0800
+++ linux-2.6/security/commoncap.c	2006-12-13 16:11:13.000000000 -0800
@@ -311,7 +311,7 @@
 
 int cap_syslog (int type)
 {
-	if ((type != 3 && type != 10) && !capable(CAP_SYS_ADMIN))
+	if (type != LSM_KLOG_READHIST && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 	return 0;
 }
Index: linux-2.6/security/dummy.c
===================================================================
--- linux-2.6.orig/security/dummy.c	2006-12-13 16:06:22.000000000 -0800
+++ linux-2.6/security/dummy.c	2006-12-13 16:11:31.000000000 -0800
@@ -96,7 +96,7 @@
 
 static int dummy_syslog (int type)
 {
-	if ((type != 3 && type != 10) && current->euid)
+	if (type != LSM_KLOG_READHIST && current->euid)
 		return -EPERM;
 	return 0;
 }
Index: linux-2.6/security/selinux/hooks.c
===================================================================
--- linux-2.6.orig/security/selinux/hooks.c	2006-12-13 16:06:22.000000000 -0800
+++ linux-2.6/security/selinux/hooks.c	2006-12-13 16:11:41.000000000 -0800
@@ -1509,25 +1509,17 @@
 		return rc;
 
 	switch (type) {
-		case 3:         /* Read last kernel messages */
-		case 10:        /* Return size of the log buffer */
-			rc = task_has_system(current, SYSTEM__SYSLOG_READ);
-			break;
-		case 6:         /* Disable logging to console */
-		case 7:         /* Enable logging to console */
-		case 8:		/* Set level of messages printed to console */
-			rc = task_has_system(current, SYSTEM__SYSLOG_CONSOLE);
-			break;
-		case 0:         /* Close log */
-		case 1:         /* Open log */
-		case 2:         /* Read from log */
-		case 4:         /* Read/clear last kernel messages */
-		case 5:         /* Clear ring buffer */
-		default:
-			rc = task_has_system(current, SYSTEM__SYSLOG_MOD);
-			break;
+	case LSM_KLOG_READHIST:
+		return task_has_system(current, SYSTEM__SYSLOG_READ);
+
+	case LSM_KLOG_CONSOLE:
+		return task_has_system(current, SYSTEM__SYSLOG_CONSOLE);
+
+	case LSM_KLOG_READ:
+	case LSM_KLOG_CLEARHIST:
+	default:
+		return task_has_system(current, SYSTEM__SYSLOG_MOD);
 	}
-	return rc;
 }
 
 /*
Index: linux-2.6/include/linux/security.h
===================================================================
--- linux-2.6.orig/include/linux/security.h	2006-12-13 16:09:10.000000000 -0800
+++ linux-2.6/include/linux/security.h	2006-12-13 16:10:13.000000000 -0800
@@ -86,6 +86,15 @@
 /* setfsuid or setfsgid, id0 == fsuid or fsgid */
 #define LSM_SETID_FS	8
 
+/*
+ * Values passed to security_syslog to indicate which privilege is
+ * requested.
+ */
+#define LSM_KLOG_READ      0  /* read current messages (klogd) */
+#define LSM_KLOG_READHIST  1  /* read message history (dmesg) */
+#define LSM_KLOG_CLEARHIST 2  /* clear message history (dmesg -c) */
+#define LSM_KLOG_CONSOLE   3  /* set console log level */
+
 /* forward declares to avoid warnings */
 struct nfsctl_arg;
 struct sched_param;

--

