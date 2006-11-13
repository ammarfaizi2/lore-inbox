Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754207AbWKMJSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754207AbWKMJSL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 04:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754156AbWKMJRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 04:17:48 -0500
Received: from mail3.panix.com ([166.84.1.74]:47586 "EHLO mail3.panix.com")
	by vger.kernel.org with ESMTP id S1754140AbWKMJRn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 04:17:43 -0500
Message-Id: <20061113064059.131147000@panix.com>
References: <20061113064043.264211000@panix.com>
User-Agent: quilt/0.45-1
Date: Sun, 12 Nov 2006 22:40:47 -0800
From: Zack Weinberg <zackw@panix.com>
To: Chris Wright <chrisw@sous-sol.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       jmorris@namei.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch 4/4] Distinguish /proc/kmsg access from sys_syslog
Content-Disposition: inline; filename=distinguish_kmsg_security.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Finally, add a new security class for access to /proc/kmsg, distinct
from the class used for the "read current messages" operations on
sys_syslog.  The dummy and capability modules permit access to
/proc/kmsg to any user (who has somehow acquired an open fd on it);
SELinux is unchanged.  This accomplishes what I was trying to do in
the first place, i.e. enable running klogd unprivileged without a root
shim, in a non-SELinux installation.  (Please remember that the
default DAC permissions for /proc/kmsg restrict it to root, so unless
you chmod it in your installation or modify klogd to open the file and
then drop privs, the effective restrictions are unchanged.)

zw


Index: linux-2.6/fs/proc/kmsg.c
===================================================================
--- linux-2.6.orig/fs/proc/kmsg.c	2006-11-11 21:57:45.000000000 -0800
+++ linux-2.6/fs/proc/kmsg.c	2006-11-11 21:59:01.000000000 -0800
@@ -18,7 +18,7 @@
 
 static int kmsg_open(struct inode * inode, struct file * file)
 {
-	int error = security_syslog(KLOGSEC_READ);
+	int error = security_syslog(KLOGSEC_READ_PROC);
 	if (error)
 		return error;
 	return nonseekable_open(inode, file);
@@ -32,7 +32,7 @@
 static ssize_t kmsg_read(struct file *file, char __user *buf,
 			 size_t count, loff_t *ppos)
 {
-	int error = security_syslog(KLOGSEC_READ);
+	int error = security_syslog(KLOGSEC_READ_PROC);
 	if (error)
 		return error;
 	return klog_read(buf, count, !(file->f_flags & O_NONBLOCK));
@@ -40,7 +40,7 @@
 
 static unsigned int kmsg_poll(struct file *file, poll_table *wait)
 {
-	int error = security_syslog(KLOGSEC_READ);
+	int error = security_syslog(KLOGSEC_READ_PROC);
 	if (error)
 		return error;
 	return klog_poll(file, wait);
Index: linux-2.6/include/linux/klog.h
===================================================================
--- linux-2.6.orig/include/linux/klog.h	2006-11-11 21:57:52.000000000 -0800
+++ linux-2.6/include/linux/klog.h	2006-11-11 21:58:40.000000000 -0800
@@ -36,6 +36,8 @@
 #define KLOGSEC_READHIST  1  /* read message history (dmesg) */
 #define KLOGSEC_CLEARHIST 2  /* clear message history (dmesg -c) */
 #define KLOGSEC_CONSOLE   3  /* set console log level */
+#define KLOGSEC_READ_PROC 4  /* read current messages, but from /proc/kmsg
+				rather than the system call */
 
 /*
  * Subfunctions of sys_syslog used from fs/proc/kmsg.c.
Index: linux-2.6/security/commoncap.c
===================================================================
--- linux-2.6.orig/security/commoncap.c	2006-11-11 22:02:07.000000000 -0800
+++ linux-2.6/security/commoncap.c	2006-11-11 22:02:34.000000000 -0800
@@ -312,7 +312,14 @@
 
 int cap_syslog (int type)
 {
-	if (type != KLOGSEC_READHIST && !capable(CAP_SYS_ADMIN))
+	/*
+	 * Reading history is allowed to any user, and so is reading
+	 * current messages via /proc/kmsg (by default that file is
+	 * only readable by root, but root is allowed to change that,
+	 * or open it and hand the fd to an unprivileged process).
+	 */
+	if (type != KLOGSEC_READHIST && type != KLOGSEC_READ_PROC
+	    && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 	return 0;
 }
Index: linux-2.6/security/selinux/hooks.c
===================================================================
--- linux-2.6.orig/security/selinux/hooks.c	2006-11-11 22:02:07.000000000 -0800
+++ linux-2.6/security/selinux/hooks.c	2006-11-11 22:04:11.000000000 -0800
@@ -1513,7 +1513,14 @@
 	case KLOGSEC_CONSOLE:
 		return task_has_system(current, SYSTEM__SYSLOG_CONSOLE);
 
+		/*
+		 * N.B. Unlike the default security model, with
+		 * SELinux active you have to have SYSTEM__SYSLOG_MOD
+		 * privilege to read current messages either with the
+		 * system call or from /proc/kmsg.
+		 */
 	case KLOGSEC_READ:
+	case KLOGSEC_READ_PROC:
 	case KLOGSEC_CLEARHIST:
 	default:
 		return task_has_system(current, SYSTEM__SYSLOG_MOD);

--

