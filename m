Return-Path: <linux-kernel-owner+w=401wt.eu-S932682AbWLOArl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932682AbWLOArl (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 19:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbWLOArk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 19:47:40 -0500
Received: from l2mail1.panix.com ([166.84.1.75]:60395 "EHLO l2mail1.panix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932592AbWLOAqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 19:46:37 -0500
Message-Id: <20061215002333.920560000@panix.com>
References: <20061215001639.988521000@panix.com>
User-Agent: quilt/0.45-1
Date: Thu, 14 Dec 2006 16:16:40 -0800
From: Zack Weinberg <zackw@panix.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, jmorris@namei.org,
       Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 1/4] Add <linux/klog.h>
Content-Disposition: inline; filename=add_klog_h.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces <linux/klog.h> with symbolic constants for the
various sys_syslog() opcodes, and changes all in-kernel references to
those opcodes to use the constants.  The header is added to the set of
user/kernel interface headers.  (Unlike the previous revision of this
patch series, no kernel-private additions to this file are contemplated.)

zw

Index: linux-2.6/include/linux/Kbuild
===================================================================
--- linux-2.6.orig/include/linux/Kbuild	2006-12-13 15:58:13.000000000 -0800
+++ linux-2.6/include/linux/Kbuild	2006-12-13 16:06:57.000000000 -0800
@@ -100,6 +100,7 @@
 header-y += ixjuser.h
 header-y += jffs2.h
 header-y += keyctl.h
+header-y += klog.h
 header-y += limits.h
 header-y += lock_dlm_plock.h
 header-y += magic.h
Index: linux-2.6/include/linux/klog.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/include/linux/klog.h	2006-12-13 16:06:22.000000000 -0800
@@ -0,0 +1,26 @@
+#ifndef _LINUX_KLOG_H
+#define _LINUX_KLOG_H
+
+/*
+ * Constants for the first argument to the syslog() system call
+ * (aka klogctl()).  These numbers are part of the user space ABI!
+ */
+enum {
+	KLOG_CLOSE           =  0, /* close log */
+	KLOG_OPEN            =  1, /* open log */
+	KLOG_READ            =  2, /* read from log (klogd) */
+
+	KLOG_READ_HIST       =  3, /* read history of log messages (dmesg) */
+	KLOG_READ_CLEAR_HIST =  4, /* read and clear history */
+	KLOG_CLEAR_HIST      =  5, /* just clear history */
+
+	KLOG_DISABLE_CONSOLE =  6, /* disable printk to console */
+	KLOG_ENABLE_CONSOLE  =  7, /* enable printk to console */
+	KLOG_SET_CONSOLE_LVL =  8, /* set minimum severity of messages to be
+				    * printed to console */
+
+	KLOG_GET_UNREAD      =  9, /* return number of unread characters */
+	KLOG_GET_SIZE        = 10  /* return size of log buffer */
+};
+
+#endif /* klog.h */
Index: linux-2.6/kernel/printk.c
===================================================================
--- linux-2.6.orig/kernel/printk.c	2006-12-13 15:58:16.000000000 -0800
+++ linux-2.6/kernel/printk.c	2006-12-13 16:06:22.000000000 -0800
@@ -32,6 +32,7 @@
 #include <linux/bootmem.h>
 #include <linux/syscalls.h>
 #include <linux/jiffies.h>
+#include <linux/klog.h>
 
 #include <asm/uaccess.h>
 
@@ -163,21 +164,7 @@
 
 __setup("log_buf_len=", log_buf_len_setup);
 
-/*
- * Commands to do_syslog:
- *
- * 	0 -- Close the log.  Currently a NOP.
- * 	1 -- Open the log. Currently a NOP.
- * 	2 -- Read from the log.
- * 	3 -- Read all messages remaining in the ring buffer.
- * 	4 -- Read and clear all messages remaining in the ring buffer
- * 	5 -- Clear ring buffer.
- * 	6 -- Disable printk's to console
- * 	7 -- Enable printk's to console
- *	8 -- Set level of messages printed to console
- *	9 -- Return number of unread characters in the log buffer
- *     10 -- Return size of the log buffer
- */
+/* See linux/klog.h for the command numbers passed as the first argument.  */
 int do_syslog(int type, char __user *buf, int len)
 {
 	unsigned long i, j, limit, count;
@@ -190,11 +177,11 @@
 		return error;
 
 	switch (type) {
-	case 0:		/* Close log */
+	case KLOG_CLOSE:
 		break;
-	case 1:		/* Open log */
+	case KLOG_OPEN:
 		break;
-	case 2:		/* Read from log */
+	case KLOG_READ:
 		error = -EINVAL;
 		if (!buf || len < 0)
 			goto out;
@@ -225,10 +212,10 @@
 		if (!error)
 			error = i;
 		break;
-	case 4:		/* Read/clear last kernel messages */
+	case KLOG_READ_CLEAR_HIST:
 		do_clear = 1;
 		/* FALL THRU */
-	case 3:		/* Read last kernel messages */
+	case KLOG_READ_HIST:
 		error = -EINVAL;
 		if (!buf || len < 0)
 			goto out;
@@ -281,16 +268,16 @@
 			}
 		}
 		break;
-	case 5:		/* Clear ring buffer */
+	case KLOG_CLEAR_HIST:
 		logged_chars = 0;
 		break;
-	case 6:		/* Disable logging to console */
+	case KLOG_DISABLE_CONSOLE:
 		console_loglevel = minimum_console_loglevel;
 		break;
-	case 7:		/* Enable logging to console */
+	case KLOG_ENABLE_CONSOLE:
 		console_loglevel = default_console_loglevel;
 		break;
-	case 8:		/* Set level of messages printed to console */
+	case KLOG_SET_CONSOLE_LVL:
 		error = -EINVAL;
 		if (len < 1 || len > 8)
 			goto out;
@@ -299,10 +286,10 @@
 		console_loglevel = len;
 		error = 0;
 		break;
-	case 9:		/* Number of chars in the log buffer */
+	case KLOG_GET_UNREAD:
 		error = log_end - log_start;
 		break;
-	case 10:	/* Size of the log buffer */
+	case KLOG_GET_SIZE:
 		error = log_buf_len;
 		break;
 	default:
Index: linux-2.6/fs/proc/kmsg.c
===================================================================
--- linux-2.6.orig/fs/proc/kmsg.c	2006-12-13 15:53:29.000000000 -0800
+++ linux-2.6/fs/proc/kmsg.c	2006-12-13 16:04:46.000000000 -0800
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/poll.h>
 #include <linux/fs.h>
+#include <linux/klog.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -21,27 +22,28 @@
 
 static int kmsg_open(struct inode * inode, struct file * file)
 {
-	return do_syslog(1,NULL,0);
+	return do_syslog(KLOG_OPEN,NULL,0);
 }
 
 static int kmsg_release(struct inode * inode, struct file * file)
 {
-	(void) do_syslog(0,NULL,0);
+	(void) do_syslog(KLOG_CLOSE,NULL,0);
 	return 0;
 }
 
 static ssize_t kmsg_read(struct file *file, char __user *buf,
 			 size_t count, loff_t *ppos)
 {
-	if ((file->f_flags & O_NONBLOCK) && !do_syslog(9, NULL, 0))
+	if ((file->f_flags & O_NONBLOCK)
+	    && !do_syslog(KLOG_GET_UNREAD, NULL, 0))
 		return -EAGAIN;
-	return do_syslog(2, buf, count);
+	return do_syslog(KLOG_READ, buf, count);
 }
 
 static unsigned int kmsg_poll(struct file *file, poll_table *wait)
 {
 	poll_wait(file, &log_wait, wait);
-	if (do_syslog(9, NULL, 0))
+	if (do_syslog(KLOG_GET_UNREAD, NULL, 0))
 		return POLLIN | POLLRDNORM;
 	return 0;
 }

--

