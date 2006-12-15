Return-Path: <linux-kernel-owner+w=401wt.eu-S932640AbWLOAq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640AbWLOAq6 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 19:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbWLOAqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 19:46:39 -0500
Received: from l2mail1.panix.com ([166.84.1.75]:60447 "EHLO l2mail1.panix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932620AbWLOAqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 19:46:36 -0500
Message-Id: <20061215002334.387333000@panix.com>
References: <20061215001639.988521000@panix.com>
User-Agent: quilt/0.45-1
Date: Thu, 14 Dec 2006 16:16:43 -0800
From: Zack Weinberg <zackw@panix.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, jmorris@namei.org,
       Chris Wright <chrisw@sous-sol.org>
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
shim, in a non-SELinux installation.  Please remember that the
default DAC permissions for /proc/kmsg restrict it to root, so unless
you chmod it in your installation or modify klogd to open the file and
then drop privs, the actual restrictions are unchanged.

zw


Index: linux-2.6/fs/proc/kmsg.c
===================================================================
--- linux-2.6.orig/fs/proc/kmsg.c	2006-12-13 16:36:56.000000000 -0800
+++ linux-2.6/fs/proc/kmsg.c	2006-12-13 16:41:33.000000000 -0800
@@ -23,7 +23,7 @@
 
 static int kmsg_open(struct inode * inode, struct file * file)
 {
-	int error = security_syslog(LSM_KLOG_READ);
+	int error = security_syslog(LSM_KLOG_READ_PROC);
 	if (error)
 		return error;
 	return nonseekable_open(inode, file);
@@ -37,7 +37,7 @@
 static ssize_t kmsg_read(struct file *file, char __user *buf,
 			 size_t count, loff_t *ppos)
 {
-	int error = security_syslog(LSM_KLOG_READ);
+	int error = security_syslog(LSM_KLOG_READ_PROC);
 	if (error)
 		return error;
 	return klog_read(buf, count, !(file->f_flags & O_NONBLOCK));
@@ -45,7 +45,7 @@
 
 static unsigned int kmsg_poll(struct file *file, poll_table *wait)
 {
-	int error = security_syslog(LSM_KLOG_READ);
+	int error = security_syslog(LSM_KLOG_READ_PROC);
 	if (error)
 		return error;
 	return klog_poll(file, wait);
Index: linux-2.6/security/commoncap.c
===================================================================
--- linux-2.6.orig/security/commoncap.c	2006-12-13 16:11:13.000000000 -0800
+++ linux-2.6/security/commoncap.c	2006-12-13 16:41:33.000000000 -0800
@@ -311,7 +311,14 @@
 
 int cap_syslog (int type)
 {
-	if (type != LSM_KLOG_READHIST && !capable(CAP_SYS_ADMIN))
+	/*
+	 * Reading history is allowed to any user, and so is reading
+	 * current messages via /proc/kmsg (by default that file is
+	 * only readable by root, but root is allowed to change that,
+	 * or open it and hand the fd to an unprivileged process).
+	 */
+	if (type != LSM_KLOG_READHIST && type != LSM_KLOG_READ_PROC
+	    && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 	return 0;
 }
Index: linux-2.6/security/selinux/hooks.c
===================================================================
--- linux-2.6.orig/security/selinux/hooks.c	2006-12-13 16:11:41.000000000 -0800
+++ linux-2.6/security/selinux/hooks.c	2006-12-13 16:41:33.000000000 -0800
@@ -1515,7 +1515,14 @@
 	case LSM_KLOG_CONSOLE:
 		return task_has_system(current, SYSTEM__SYSLOG_CONSOLE);
 
+		/*
+		 * N.B. Unlike the default security model, with
+		 * SELinux active you have to have SYSTEM__SYSLOG_MOD
+		 * privilege to read current messages either with the
+		 * system call or from /proc/kmsg.
+		 */
 	case LSM_KLOG_READ:
+	case LSM_KLOG_READ_PROC:
 	case LSM_KLOG_CLEARHIST:
 	default:
 		return task_has_system(current, SYSTEM__SYSLOG_MOD);
Index: linux-2.6/include/linux/security.h
===================================================================
--- linux-2.6.orig/include/linux/security.h	2006-12-13 16:41:45.000000000 -0800
+++ linux-2.6/include/linux/security.h	2006-12-13 16:42:26.000000000 -0800
@@ -94,6 +94,8 @@
 #define LSM_KLOG_READHIST  1  /* read message history (dmesg) */
 #define LSM_KLOG_CLEARHIST 2  /* clear message history (dmesg -c) */
 #define LSM_KLOG_CONSOLE   3  /* set console log level */
+#define LSM_KLOG_READ_PROC 4  /* read current messages, but from /proc/kmsg
+				rather than the system call */
 
 /* forward declares to avoid warnings */
 struct nfsctl_arg;

--

