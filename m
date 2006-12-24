Return-Path: <linux-kernel-owner+w=401wt.eu-S1752672AbWLXU25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672AbWLXU25 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 15:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752731AbWLXU25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 15:28:57 -0500
Received: from mail2.panix.com ([166.84.1.73]:51065 "EHLO mail2.panix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752672AbWLXU24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 15:28:56 -0500
Message-Id: <20061224202629.349553913@panix.com>
References: <20061224202207.150596681@panix.com>
User-Agent: quilt/0.45-1
Date: Sun, 24 Dec 2006 12:22:11 -0800
From: Zack Weinberg <zackw@panix.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, jmorris@namei.org,
       Chris Wright <chrisw@sous-sol.org>, Vincent Legoll <vlegoll@9online.fr>
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
--- linux-2.6.orig/fs/proc/kmsg.c	2006-12-24 11:43:18.000000000 -0800
+++ linux-2.6/fs/proc/kmsg.c	2006-12-24 11:43:19.000000000 -0800
@@ -15,7 +15,7 @@
 
 static int kmsg_open(struct inode * inode, struct file * file)
 {
-	int error = security_syslog(LSM_KLOG_READ);
+	int error = security_syslog(LSM_KLOG_READ_PROC);
 	if (error)
 		return error;
 	return nonseekable_open(inode, file);
@@ -29,7 +29,7 @@
 static ssize_t kmsg_read(struct file *file, char __user *buf,
 			 size_t count, loff_t *ppos)
 {
-	int error = security_syslog(LSM_KLOG_READ);
+	int error = security_syslog(LSM_KLOG_READ_PROC);
 	if (error)
 		return error;
 	return klog_read(buf, count, !(file->f_flags & O_NONBLOCK));
@@ -37,7 +37,7 @@
 
 static unsigned int kmsg_poll(struct file *file, poll_table *wait)
 {
-	int error = security_syslog(LSM_KLOG_READ);
+	int error = security_syslog(LSM_KLOG_READ_PROC);
 	if (error)
 		return error;
 	return klog_poll(file, wait);
Index: linux-2.6/security/commoncap.c
===================================================================
--- linux-2.6.orig/security/commoncap.c	2006-12-24 11:43:16.000000000 -0800
+++ linux-2.6/security/commoncap.c	2006-12-24 11:43:19.000000000 -0800
@@ -311,7 +311,14 @@
 
 int cap_syslog (int type)
 {
-	if ((type & ~LSM_KLOG_READHIST) && !capable(CAP_SYS_ADMIN))
+ 	/*
+ 	 * Reading history is allowed to any user, and so is reading
+ 	 * current messages via /proc/kmsg (by default that file is
+ 	 * only readable by root, but root is allowed to change that,
+ 	 * or open it and hand the fd to an unprivileged process).
+ 	 */
+	if ((type & ~(LSM_KLOG_READHIST|LSM_KLOG_READ_PROC))
+	    && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 	return 0;
 }
Index: linux-2.6/security/selinux/hooks.c
===================================================================
--- linux-2.6.orig/security/selinux/hooks.c	2006-12-24 11:43:16.000000000 -0800
+++ linux-2.6/security/selinux/hooks.c	2006-12-24 11:43:19.000000000 -0800
@@ -1505,14 +1505,20 @@
 	int rc;
 
 	/* if there are any codes we don't know about, there's a bug */
-	BUG_ON(type & ~(LSM_KLOG_READ|LSM_KLOG_READHIST
+	BUG_ON(type & ~(LSM_KLOG_READ|LSM_KLOG_READ_PROC|LSM_KLOG_READHIST
 			|LSM_KLOG_CLEARHIST|LSM_KLOG_CONSOLE));
 
 	rc = secondary_ops->syslog(type);
 	if (rc)
 		return rc;
 
-	if (type & (LSM_KLOG_READ|LSM_KLOG_CLEARHIST))
+	/*
+	 * N.B. Unlike the default security model, with
+	 * SELinux active you have to have SYSTEM__SYSLOG_MOD
+	 * privilege to read current messages either with the
+	 * system call or from /proc/kmsg.
+	 */
+	if (type & (LSM_KLOG_READ|LSM_KLOG_READ_PROC|LSM_KLOG_CLEARHIST))
 		rc = task_has_system(current, SYSTEM__SYSLOG_MOD);
 	if (rc)
 		return rc;
Index: linux-2.6/include/linux/security.h
===================================================================
--- linux-2.6.orig/include/linux/security.h	2006-12-24 11:43:16.000000000 -0800
+++ linux-2.6/include/linux/security.h	2006-12-24 11:43:19.000000000 -0800
@@ -97,6 +97,8 @@
 #define LSM_KLOG_READHIST  2  /* read message history (dmesg) */
 #define LSM_KLOG_CLEARHIST 4  /* clear message history (dmesg -c) */
 #define LSM_KLOG_CONSOLE   8  /* set or query console log level */
+#define LSM_KLOG_READ_PROC 16 /* read current messages, but from /proc/kmsg
+				 rather than the system call */
 
 /* forward declares to avoid warnings */
 struct nfsctl_arg;
Index: linux-2.6/security/dummy.c
===================================================================
--- linux-2.6.orig/security/dummy.c	2006-12-24 11:43:16.000000000 -0800
+++ linux-2.6/security/dummy.c	2006-12-24 11:43:19.000000000 -0800
@@ -96,7 +96,13 @@
 
 static int dummy_syslog (int type)
 {
-	if ((type & ~LSM_KLOG_READHIST) && current->euid)
+ 	/*
+ 	 * Reading history is allowed to any user, and so is reading
+ 	 * current messages via /proc/kmsg (by default that file is
+ 	 * only readable by root, but root is allowed to change that,
+ 	 * or open it and hand the fd to an unprivileged process).
+ 	 */
+	if ((type & ~(LSM_KLOG_READHIST|LSM_KLOG_READ_PROC)) && current->euid)
 		return -EPERM;
 	return 0;
 }

--

