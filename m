Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753844AbWKMJRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844AbWKMJRp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 04:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754156AbWKMJRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 04:17:45 -0500
Received: from mail3.panix.com ([166.84.1.74]:49122 "EHLO mail3.panix.com")
	by vger.kernel.org with ESMTP id S1753946AbWKMJRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 04:17:42 -0500
Message-Id: <20061113064058.779558000@panix.com>
References: <20061113064043.264211000@panix.com>
User-Agent: quilt/0.45-1
Date: Sun, 12 Nov 2006 22:40:45 -0800
From: Zack Weinberg <zackw@panix.com>
To: Chris Wright <chrisw@sous-sol.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       jmorris@namei.org
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

zw


Index: linux-2.6/include/linux/klog.h
===================================================================
--- linux-2.6.orig/include/linux/klog.h	2006-11-10 13:48:52.000000000 -0800
+++ linux-2.6/include/linux/klog.h	2006-11-10 14:08:57.000000000 -0800
@@ -23,4 +23,16 @@
 	KLOG_GET_SIZE        = 10  /* return size of log buffer */
 };
 
+#ifdef __KERNEL__
+
+/*
+ * Constants passed by do_syslog to security_syslog to indicate which
+ * privilege is requested.
+ */
+#define KLOGSEC_READ	  0  /* read current messages (klogd) */
+#define KLOGSEC_READHIST  1  /* read message history (dmesg) */
+#define KLOGSEC_CLEARHIST 2  /* clear message history (dmesg -c) */
+#define KLOGSEC_CONSOLE   3  /* set console log level */
+
+#endif /* __KERNEL__ */
 #endif /* klog.h */
Index: linux-2.6/kernel/printk.c
===================================================================
--- linux-2.6.orig/kernel/printk.c	2006-11-10 13:44:16.000000000 -0800
+++ linux-2.6/kernel/printk.c	2006-11-10 13:54:53.000000000 -0800
@@ -166,6 +166,12 @@
 
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
@@ -174,16 +180,15 @@
 	char c;
 	int error = 0;
 
-	error = security_syslog(type);
-	if (error)
-		return error;
-
 	switch (type) {
 	case KLOG_CLOSE:
+		security_syslog_or_fail(KLOGSEC_READ);
 		break;
 	case KLOG_OPEN:
+		security_syslog_or_fail(KLOGSEC_READ);
 		break;
 	case KLOG_READ:
+		security_syslog_or_fail(KLOGSEC_READ);
 		error = -EINVAL;
 		if (!buf || len < 0)
 			goto out;
@@ -215,9 +220,11 @@
 			error = i;
 		break;
 	case KLOG_READ_CLEAR_HIST:
+		security_syslog_or_fail(KLOGSEC_CLEARHIST);
 		do_clear = 1;
 		/* FALL THRU */
 	case KLOG_READ_HIST:
+		security_syslog_or_fail(KLOGSEC_READHIST);
 		error = -EINVAL;
 		if (!buf || len < 0)
 			goto out;
@@ -271,15 +278,19 @@
 		}
 		break;
 	case KLOG_CLEAR_HIST:
+		security_syslog_or_fail(KLOGSEC_CLEARHIST);
 		logged_chars = 0;
 		break;
 	case KLOG_DISABLE_CONSOLE:
+		security_syslog_or_fail(KLOGSEC_CONSOLE);
 		console_loglevel = minimum_console_loglevel;
 		break;
 	case KLOG_ENABLE_CONSOLE:
+		security_syslog_or_fail(KLOGSEC_CONSOLE);
 		console_loglevel = default_console_loglevel;
 		break;
 	case KLOG_SET_CONSOLE_LVL:
+		security_syslog_or_fail(KLOGSEC_CONSOLE);
 		error = -EINVAL;
 		if (len < 1 || len > 8)
 			goto out;
@@ -289,9 +300,18 @@
 		error = 0;
 		break;
 	case KLOG_GET_UNREAD:
+		security_syslog_or_fail(KLOGSEC_READ);
 		error = log_end - log_start;
 		break;
 	case KLOG_GET_SIZE:
+		/* This one is allowed if you have _either_
+		   KLOGSEC_READ or KLOGSEC_READHIST.  */
+		error = security_syslog(KLOGSEC_READ);
+		if (error)
+			error = security_syslog(KLOGSEC_READHIST);
+		if (error)
+			break;
+
 		error = log_buf_len;
 		break;
 	default:
Index: linux-2.6/security/commoncap.c
===================================================================
--- linux-2.6.orig/security/commoncap.c	2006-11-10 13:55:49.000000000 -0800
+++ linux-2.6/security/commoncap.c	2006-11-10 13:56:35.000000000 -0800
@@ -23,6 +23,7 @@
 #include <linux/ptrace.h>
 #include <linux/xattr.h>
 #include <linux/hugetlb.h>
+#include <linux/klog.h>
 
 int cap_netlink_send(struct sock *sk, struct sk_buff *skb)
 {
@@ -311,7 +312,7 @@
 
 int cap_syslog (int type)
 {
-	if ((type != 3 && type != 10) && !capable(CAP_SYS_ADMIN))
+	if (type != KLOGSEC_READHIST && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 	return 0;
 }
Index: linux-2.6/security/dummy.c
===================================================================
--- linux-2.6.orig/security/dummy.c	2006-11-10 13:55:49.000000000 -0800
+++ linux-2.6/security/dummy.c	2006-11-10 13:57:22.000000000 -0800
@@ -28,6 +28,7 @@
 #include <linux/hugetlb.h>
 #include <linux/ptrace.h>
 #include <linux/file.h>
+#include <linux/klog.h>
 
 static int dummy_ptrace (struct task_struct *parent, struct task_struct *child)
 {
@@ -96,11 +97,10 @@
 
 static int dummy_syslog (int type)
 {
-	if ((type != 3 && type != 10) && current->euid)
+	if (type != KLOGSEC_READHIST && current->euid)
 		return -EPERM;
 	return 0;
 }
-
 static int dummy_settime(struct timespec *ts, struct timezone *tz)
 {
 	if (!capable(CAP_SYS_TIME))
Index: linux-2.6/security/selinux/hooks.c
===================================================================
--- linux-2.6.orig/security/selinux/hooks.c	2006-11-10 13:55:49.000000000 -0800
+++ linux-2.6/security/selinux/hooks.c	2006-11-10 14:00:49.000000000 -0800
@@ -71,6 +71,7 @@
 #include <linux/string.h>
 #include <linux/selinux.h>
 #include <linux/mutex.h>
+#include <linux/klog.h>
 
 #include "avc.h"
 #include "objsec.h"
@@ -1506,25 +1507,17 @@
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
+	case KLOGSEC_READHIST:
+		return task_has_system(current, SYSTEM__SYSLOG_READ);
+
+	case KLOGSEC_CONSOLE:
+		return task_has_system(current, SYSTEM__SYSLOG_CONSOLE);
+
+	case KLOGSEC_READ:
+	case KLOGSEC_CLEARHIST:
+	default:
+		return task_has_system(current, SYSTEM__SYSLOG_MOD);
 	}
-	return rc;
 }
 
 /*

--

