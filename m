Return-Path: <linux-kernel-owner+w=401wt.eu-S1752742AbWLXU33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742AbWLXU33 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 15:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752712AbWLXU3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 15:29:04 -0500
Received: from mail3.panix.com ([166.84.1.74]:51627 "EHLO mail3.panix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752711AbWLXU24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 15:28:56 -0500
Message-Id: <20061224202628.820320038@panix.com>
References: <20061224202207.150596681@panix.com>
User-Agent: quilt/0.45-1
Date: Sun, 24 Dec 2006 12:22:08 -0800
From: Zack Weinberg <zackw@panix.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, jmorris@namei.org,
       Chris Wright <chrisw@sous-sol.org>, Vincent Legoll <vlegoll@9online.fr>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 1/4] Add <linux/klog.h>
Content-Disposition: inline; filename=add_klog_h.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces <linux/klog.h> with symbolic constants for the
various sys_syslog() opcodes, and changes all in-kernel references to
those opcodes to use the constants.  The header is added to the set of
user/kernel interface headers.

zw

Index: linux-2.6/include/linux/Kbuild
===================================================================
--- linux-2.6.orig/include/linux/Kbuild	2006-12-23 08:56:15.000000000 -0800
+++ linux-2.6/include/linux/Kbuild	2006-12-24 11:43:14.000000000 -0800
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
+++ linux-2.6/include/linux/klog.h	2006-12-24 11:43:14.000000000 -0800
@@ -0,0 +1,28 @@
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
+	KLOG_GET_SIZE        = 10, /* return size of log buffer */
+
+	KLOG_OPCODE_MAX
+};
+
+#endif /* klog.h */
Index: linux-2.6/kernel/printk.c
===================================================================
--- linux-2.6.orig/kernel/printk.c	2006-12-23 08:56:15.000000000 -0800
+++ linux-2.6/kernel/printk.c	2006-12-24 11:43:14.000000000 -0800
@@ -32,6 +32,7 @@
 #include <linux/bootmem.h>
 #include <linux/syscalls.h>
 #include <linux/jiffies.h>
+#include <linux/klog.h>
 
 #include <asm/uaccess.h>
 
@@ -163,20 +164,21 @@
 
 __setup("log_buf_len=", log_buf_len_setup);
 
-/*
- * Commands to do_syslog:
+/**
+ * do_syslog - operate on the log of kernel messages
+ * @type: operation to perform
+ * @buf: user-space buffer to copy data into
+ * @len: number of bytes of space available at @buf
+ *
+ * See include/linux/klog.h for the command numbers passed as @type.
+ * The @buf and @len parameters are used with the above meanings for
+ * @type values %KLOG_READ, %KLOG_READ_HIST and %KLOG_READ_CLEAR_HIST.
+ * @len is reused with a different meaning, and @buf ignored, for
+ * %KLOG_SET_CONSOLE_LVL.  Both @buf and @len are ignored for all
+ * other @type values.
  *
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
+ * On failure, returns a negative errno code.  On success, returns a
+ * nonnegative integer whose meaning depends on @type.
  */
 int do_syslog(int type, char __user *buf, int len)
 {
@@ -190,11 +192,11 @@
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
@@ -225,10 +227,10 @@
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
@@ -281,16 +283,16 @@
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
@@ -299,10 +301,10 @@
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
--- linux-2.6.orig/fs/proc/kmsg.c	2006-12-23 08:55:17.000000000 -0800
+++ linux-2.6/fs/proc/kmsg.c	2006-12-24 11:43:14.000000000 -0800
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
+	return do_syslog(KLOG_OPEN, NULL, 0);
 }
 
 static int kmsg_release(struct inode * inode, struct file * file)
 {
-	(void) do_syslog(0,NULL,0);
+	(void) do_syslog(KLOG_CLOSE, NULL, 0);
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

