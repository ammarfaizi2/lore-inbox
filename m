Return-Path: <linux-kernel-owner+w=401wt.eu-S1752733AbWLXU31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733AbWLXU31 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 15:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752731AbWLXU3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 15:29:00 -0500
Received: from mail2.panix.com ([166.84.1.73]:51066 "EHLO mail2.panix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752708AbWLXU24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 15:28:56 -0500
Message-Id: <20061224202629.173462866@panix.com>
References: <20061224202207.150596681@panix.com>
User-Agent: quilt/0.45-1
Date: Sun, 24 Dec 2006 12:22:10 -0800
From: Zack Weinberg <zackw@panix.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, jmorris@namei.org,
       Chris Wright <chrisw@sous-sol.org>, Vincent Legoll <vlegoll@9online.fr>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 3/4] Refactor do_syslog interface
Content-Disposition: inline; filename=break_up_do_syslog.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch breaks out the read operations in do_syslog() into their
own functions (klog_read, klog_readhist) and adds a klog_poll.
klog_read grows the ability to do a nonblocking read, which I expose
in the sys_syslog interface because there doesn't seem to be any
reason not to.  do_syslog itself is folded into sys_syslog.  The
security checks remain there, not in the subfunctions.  I've added
kerneldoc comments for all the new functions in printk.c.  The control
flow in sys_syslog is different in style but not in substance -- I
like direct returns rather than setting a local variable and returning
at the end; it lets me put a BUG() after the switch statement to catch
missed cases.  [gcc4 at least can optimize it out when there aren't
any.]

kmsg.c is then changed to use those functions instead of calling
do_syslog and/or poll_wait itself.. This entails that it must call
security_syslog as appropriate itself.  In this patch I preserve the
security checks exactly as they were after the changes in the "map
permissions" patch (i.e. kmsg_close() doesn't do a permission check).

Finally, I fixed some minor bugs. Error and partial read handling in
klog_read/klog_readhist were slightly off: if __put_user returns an
error, that character should not be consumed from the kernel buffer;
if it returns an error after some characters have already been copied
successfully, the read operation should return the count of
already-copied characters, not the error code; if less than the entire
buffer is read with KLOG_READ_CLEAR_HIST, we should only clear the
part that was successfully read.  Seeking on /proc/kmsg has never been
meaningful, so kmsg_open() should call nonseekable_open() to enforce
that.

proc/kmsg.c declares the kernel/printk.c interfaces itself, instead of
getting them from klog.h which people want to be purely userspace-
visible constants.  kmsg.c has always had private declarations of
printk.c functions (before, there were declarations of do_syslog and a
wait queue there); as it is unlikely that more users of these
functions will appear, I think this will do fine.  (It might be
reasonable to put declarations in console.h.)

It was possible to prune down the set of headers included by kmsg.c
quite substantially.

zw

Index: linux-2.6/fs/proc/kmsg.c
===================================================================
--- linux-2.6.orig/fs/proc/kmsg.c	2006-12-24 11:43:14.000000000 -0800
+++ linux-2.6/fs/proc/kmsg.c	2006-12-24 11:43:18.000000000 -0800
@@ -5,47 +5,42 @@
  *
  */
 
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/time.h>
-#include <linux/kernel.h>
-#include <linux/poll.h>
 #include <linux/fs.h>
-#include <linux/klog.h>
-
-#include <asm/uaccess.h>
-#include <asm/io.h>
-
-extern wait_queue_head_t log_wait;
+#include <linux/poll.h>
+#include <linux/security.h>
 
-extern int do_syslog(int type, char __user *bug, int count);
+/* interfaces from kernel/printk.c */
+extern int klog_read(char __user *, int, int);
+extern unsigned int klog_poll(struct file *, poll_table *);
 
 static int kmsg_open(struct inode * inode, struct file * file)
 {
-	return do_syslog(KLOG_OPEN, NULL, 0);
+	int error = security_syslog(LSM_KLOG_READ);
+	if (error)
+		return error;
+	return nonseekable_open(inode, file);
 }
 
 static int kmsg_release(struct inode * inode, struct file * file)
 {
-	(void) do_syslog(KLOG_CLOSE, NULL, 0);
 	return 0;
 }
 
 static ssize_t kmsg_read(struct file *file, char __user *buf,
 			 size_t count, loff_t *ppos)
 {
-	if ((file->f_flags & O_NONBLOCK)
-	    && !do_syslog(KLOG_GET_UNREAD, NULL, 0))
-		return -EAGAIN;
-	return do_syslog(KLOG_READ, buf, count);
+	int error = security_syslog(LSM_KLOG_READ);
+	if (error)
+		return error;
+	return klog_read(buf, count, !(file->f_flags & O_NONBLOCK));
 }
 
 static unsigned int kmsg_poll(struct file *file, poll_table *wait)
 {
-	poll_wait(file, &log_wait, wait);
-	if (do_syslog(KLOG_GET_UNREAD, NULL, 0))
-		return POLLIN | POLLRDNORM;
-	return 0;
+	int error = security_syslog(LSM_KLOG_READ);
+	if (error)
+		return error;
+	return klog_poll(file, wait);
 }
 
 
Index: linux-2.6/include/linux/klog.h
===================================================================
--- linux-2.6.orig/include/linux/klog.h	2006-12-24 11:43:14.000000000 -0800
+++ linux-2.6/include/linux/klog.h	2006-12-24 11:43:18.000000000 -0800
@@ -21,6 +21,8 @@
 
 	KLOG_GET_UNREAD      =  9, /* return number of unread characters */
 	KLOG_GET_SIZE        = 10, /* return size of log buffer */
+ 	KLOG_READ_NONBLOCK   = 11, /* read from log, don't block if empty
+ 				    * -- new in 2.6.20 */
 
 	KLOG_OPCODE_MAX
 };
Index: linux-2.6/kernel/printk.c
===================================================================
--- linux-2.6.orig/kernel/printk.c	2006-12-24 11:43:16.000000000 -0800
+++ linux-2.6/kernel/printk.c	2006-12-24 11:43:18.000000000 -0800
@@ -33,6 +33,7 @@
 #include <linux/syscalls.h>
 #include <linux/jiffies.h>
 #include <linux/klog.h>
+#include <linux/poll.h>
 
 #include <asm/uaccess.h>
 
@@ -45,7 +46,7 @@
 #define MINIMUM_CONSOLE_LOGLEVEL 1 /* Minimum loglevel we let people use */
 #define DEFAULT_CONSOLE_LOGLEVEL 7 /* anything MORE serious than KERN_DEBUG */
 
-DECLARE_WAIT_QUEUE_HEAD(log_wait);
+static DECLARE_WAIT_QUEUE_HEAD(log_wait);
 
 int console_printk[4] = {
 	DEFAULT_CONSOLE_LOGLEVEL,	/* console_loglevel */
@@ -165,6 +166,136 @@
 __setup("log_buf_len=", log_buf_len_setup);
 
 /*
+ * Subfunctions of sys_syslog.  Some are also used from fs/proc/kmsg.c.
+ */
+
+/**
+ * klog_read - read current messages from the kernel log buffer.
+ * @buf: user-space buffer to copy data into
+ * @len: number of bytes of space available at @buf
+ * @block: if nonzero, block until data is available.
+ *
+ * Return value is as for the read() system call.
+ */
+int klog_read(char __user *buf, int len, int block)
+{
+	int i, error;
+	char c;
+
+	if (!buf || len < 0)
+		return -EINVAL;
+	if (len == 0)
+		return 0;
+	if (!access_ok(VERIFY_WRITE, buf, len))
+		return -EFAULT;
+	if (!block && log_start - log_end == 0)
+		return -EAGAIN;
+
+	error = wait_event_interruptible(log_wait, (log_start - log_end));
+	if (error)
+		return error;
+
+	i = 0;
+	spin_lock_irq(&logbuf_lock);
+	while (log_start != log_end && i < len) {
+		c = LOG_BUF(log_start);
+		spin_unlock_irq(&logbuf_lock);
+		error = __put_user(c,buf);
+		if (error)
+			goto out;
+		cond_resched();
+		spin_lock_irq(&logbuf_lock);
+		log_start++;
+		buf++;
+		i++;
+	}
+	spin_unlock_irq(&logbuf_lock);
+out:
+	if (i > 0)
+		return i;
+	return error;
+}
+
+/**
+ * klog_poll - poll() worker for the kernel log buffer.
+ */
+unsigned int klog_poll(struct file *file, poll_table *wait)
+{
+	poll_wait(file, &log_wait, wait);
+	if (log_end - log_start > 0)
+		return POLLIN | POLLRDNORM;
+	return 0;
+}
+
+/**
+ * klog_read - read historic messages from the kernel log buffer.
+ * @buf: user-space buffer to copy data into
+ * @len: number of bytes of space available at @buf
+ * @block: if nonzero, block until data is available.
+ *
+ * Return value is as for the read() system call.  The difference
+ * between this and klog_read() is that this function will copy out all
+ * the messages that have ever been reported by the kernel, as long as
+ * they've not been overwritten by newer messages; whereas klog_read()
+ * only ever copies out a given message once.
+ */
+static int klog_readhist(char __user *buf, int len)
+{
+	unsigned long i, j, limit, count;
+	char c;
+	int error = 0;
+
+	if (!buf || len < 0)
+		return -EINVAL;
+	if (!len)
+		return 0;
+	if (!access_ok(VERIFY_WRITE, buf, len))
+		return -EFAULT;
+
+	count = len;
+	if (count > log_buf_len)
+		count = log_buf_len;
+	spin_lock_irq(&logbuf_lock);
+	if (count > logged_chars)
+		count = logged_chars;
+	limit = log_end;
+	/*
+	 * __put_user() could sleep, and while we sleep
+	 * printk() could overwrite the messages
+	 * we try to copy to user space. Therefore
+	 * the messages are copied in reverse. <manfreds>
+	 */
+	for (i = 0; i < count && !error; i++) {
+		j = limit-1-i;
+		if (j + log_buf_len < log_end)
+			break;
+		c = LOG_BUF(j);
+		spin_unlock_irq(&logbuf_lock);
+		error = __put_user(c,&buf[count-1-i]);
+		cond_resched();
+		spin_lock_irq(&logbuf_lock);
+	}
+	spin_unlock_irq(&logbuf_lock);
+	if (error)
+		return error;
+	error = i;
+	if (i != count) {
+		int offset = count-error;
+		/* buffer overflow during copy, correct user buffer. */
+		for (i = 0; i < error; i++) {
+			if (__get_user(c,&buf[i+offset]) ||
+			    __put_user(c,&buf[i])) {
+				error = -EFAULT;
+				break;
+			}
+			cond_resched();
+		}
+	}
+	return error;
+}
+
+
+/*
  * This table maps KLOG_* operation codes to LSM_KLOG_* privilege classes.
  * "unsigned char" is used just to keep it small.
  */
@@ -174,6 +305,7 @@
 	[KLOG_OPEN]            = LSM_KLOG_READ,
 	[KLOG_READ]            = LSM_KLOG_READ,
 	[KLOG_GET_UNREAD]      = LSM_KLOG_READ,
+	[KLOG_READ_NONBLOCK]   = LSM_KLOG_READ,
 
 	[KLOG_READ_HIST]       = LSM_KLOG_READHIST,
 	[KLOG_GET_SIZE]        = LSM_KLOG_READHIST,
@@ -198,7 +330,7 @@
 ];
 
 /**
- * do_syslog - operate on the log of kernel messages
+ * sys_syslog - operate on the log of kernel messages
  * @type: operation to perform
  * @buf: user-space buffer to copy data into
  * @len: number of bytes of space available at @buf
@@ -213,11 +345,8 @@
  * On failure, returns a negative errno code.  On success, returns a
  * nonnegative integer whose meaning depends on @type.
  */
-int do_syslog(int type, char __user *buf, int len)
+asmlinkage long sys_syslog(int type, char __user *buf, int len)
 {
-	unsigned long i, j, limit, count;
-	int do_clear = 0;
-	char c;
 	int error;
 
 	if (type < 0 || type >= KLOG_OPCODE_MAX)
@@ -228,131 +357,51 @@
 
 	switch (type) {
 	case KLOG_CLOSE:
-		break;
 	case KLOG_OPEN:
-		break;
+		return 0;
+
 	case KLOG_READ:
-		error = -EINVAL;
-		if (!buf || len < 0)
-			goto out;
-		error = 0;
-		if (!len)
-			goto out;
-		if (!access_ok(VERIFY_WRITE, buf, len)) {
-			error = -EFAULT;
-			goto out;
-		}
-		error = wait_event_interruptible(log_wait,
-							(log_start - log_end));
-		if (error)
-			goto out;
-		i = 0;
-		spin_lock_irq(&logbuf_lock);
-		while (!error && (log_start != log_end) && i < len) {
-			c = LOG_BUF(log_start);
-			log_start++;
-			spin_unlock_irq(&logbuf_lock);
-			error = __put_user(c,buf);
-			buf++;
-			i++;
-			cond_resched();
-			spin_lock_irq(&logbuf_lock);
-		}
-		spin_unlock_irq(&logbuf_lock);
-		if (!error)
-			error = i;
-		break;
+	case KLOG_READ_NONBLOCK:
+		return klog_read(buf, len, type == KLOG_READ);
+
 	case KLOG_READ_CLEAR_HIST:
-		do_clear = 1;
-		/* FALL THRU */
+		error = klog_readhist(buf, len);
+		if (error > 0)
+			logged_chars -= error;
+		return error;
+
 	case KLOG_READ_HIST:
-		error = -EINVAL;
-		if (!buf || len < 0)
-			goto out;
-		error = 0;
-		if (!len)
-			goto out;
-		if (!access_ok(VERIFY_WRITE, buf, len)) {
-			error = -EFAULT;
-			goto out;
-		}
-		count = len;
-		if (count > log_buf_len)
-			count = log_buf_len;
-		spin_lock_irq(&logbuf_lock);
-		if (count > logged_chars)
-			count = logged_chars;
-		if (do_clear)
-			logged_chars = 0;
-		limit = log_end;
-		/*
-		 * __put_user() could sleep, and while we sleep
-		 * printk() could overwrite the messages
-		 * we try to copy to user space. Therefore
-		 * the messages are copied in reverse. <manfreds>
-		 */
-		for (i = 0; i < count && !error; i++) {
-			j = limit-1-i;
-			if (j + log_buf_len < log_end)
-				break;
-			c = LOG_BUF(j);
-			spin_unlock_irq(&logbuf_lock);
-			error = __put_user(c,&buf[count-1-i]);
-			cond_resched();
-			spin_lock_irq(&logbuf_lock);
-		}
-		spin_unlock_irq(&logbuf_lock);
-		if (error)
-			break;
-		error = i;
-		if (i != count) {
-			int offset = count-error;
-			/* buffer overflow during copy, correct user buffer. */
-			for (i = 0; i < error; i++) {
-				if (__get_user(c,&buf[i+offset]) ||
-				    __put_user(c,&buf[i])) {
-					error = -EFAULT;
-					break;
-				}
-				cond_resched();
-			}
-		}
-		break;
+		return klog_readhist(buf, len);
+
 	case KLOG_CLEAR_HIST:
 		logged_chars = 0;
-		break;
+		return 0;
+
 	case KLOG_DISABLE_CONSOLE:
 		console_loglevel = minimum_console_loglevel;
-		break;
+		return 0;
+
 	case KLOG_ENABLE_CONSOLE:
 		console_loglevel = default_console_loglevel;
-		break;
+		return 0;
+
 	case KLOG_SET_CONSOLE_LVL:
-		error = -EINVAL;
 		if (len < 1 || len > 8)
-			goto out;
+			return -EINVAL;
+
 		if (len < minimum_console_loglevel)
 			len = minimum_console_loglevel;
 		console_loglevel = len;
-		error = 0;
-		break;
+		return 0;
+
 	case KLOG_GET_UNREAD:
-		error = log_end - log_start;
-		break;
+		return log_end - log_start;
+
 	case KLOG_GET_SIZE:
-		error = log_buf_len;
-		break;
-	default:
-		error = -EINVAL;
-		break;
+		return log_buf_len;
 	}
-out:
-	return error;
-}
 
-asmlinkage long sys_syslog(int type, char __user *buf, int len)
-{
-	return do_syslog(type, buf, len);
+	BUG();
 }
 
 /*

--

