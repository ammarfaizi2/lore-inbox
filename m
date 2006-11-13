Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754124AbWKMJSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124AbWKMJSL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 04:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753911AbWKMJRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 04:17:47 -0500
Received: from mail3.panix.com ([166.84.1.74]:48354 "EHLO mail3.panix.com")
	by vger.kernel.org with ESMTP id S1754124AbWKMJRn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 04:17:43 -0500
Message-Id: <20061113064058.954580000@panix.com>
References: <20061113064043.264211000@panix.com>
User-Agent: quilt/0.45-1
Date: Sun, 12 Nov 2006 22:40:46 -0800
From: Zack Weinberg <zackw@panix.com>
To: Chris Wright <chrisw@sous-sol.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       jmorris@namei.org
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
security checks remain there, not in the subfunctions.

kmsg.c is then changed to use those functions instead of calling
do_syslog and/or poll_wait itself.. This entails that it must call
security_syslog as appropriate itself.  In this patch I preserve the
security checks exactly as they were with one exception: neither
kmsg_close() nor sys_syslog(KLOG_CLOSE, ...) calls security_syslog
at all anymore (close operations should never fail).

Finally, I fixed a couple of minor bugs.  __put_user error handling in
klog_read was slightly off: if __put_user returns an error, that
character should not be consumed from the kernel buffer; if it returns
an error after some characters have already been copied successfully,
the read operation should return the count of already-copied
characters, not the error code.  Seeking on /proc/kmsg has never been
meaningful, so kmsg_open() should call nonseekable_open() to enforce that.

zw

Index: linux-2.6/fs/proc/kmsg.c
===================================================================
--- linux-2.6.orig/fs/proc/kmsg.c	2006-11-10 14:59:38.000000000 -0800
+++ linux-2.6/fs/proc/kmsg.c	2006-11-11 21:52:08.000000000 -0800
@@ -9,43 +9,41 @@
 #include <linux/errno.h>
 #include <linux/time.h>
 #include <linux/kernel.h>
-#include <linux/poll.h>
 #include <linux/fs.h>
 #include <linux/klog.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
-extern wait_queue_head_t log_wait;
-
-extern int do_syslog(int type, char __user *bug, int count);
-
 static int kmsg_open(struct inode * inode, struct file * file)
 {
-	return do_syslog(KLOG_OPEN,NULL,0);
+	int error = security_syslog(KLOGSEC_READ);
+	if (error)
+		return error;
+	return nonseekable_open(inode, file);
 }
 
 static int kmsg_release(struct inode * inode, struct file * file)
 {
-	(void) do_syslog(KLOG_CLOSE,NULL,0);
 	return 0;
 }
 
 static ssize_t kmsg_read(struct file *file, char __user *buf,
 			 size_t count, loff_t *ppos)
 {
-	if ((file->f_flags & O_NONBLOCK)
-	    && !do_syslog(KLOG_GET_UNREAD, NULL, 0))
-		return -EAGAIN;
-	return do_syslog(KLOG_READ, buf, count);
+	int error = security_syslog(KLOGSEC_READ);
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
+	int error = security_syslog(KLOGSEC_READ);
+	if (error)
+		return error;
+	return klog_poll(file, wait);
 }
 
 
Index: linux-2.6/include/linux/klog.h
===================================================================
--- linux-2.6.orig/include/linux/klog.h	2006-11-10 14:59:46.000000000 -0800
+++ linux-2.6/include/linux/klog.h	2006-11-11 21:55:34.000000000 -0800
@@ -17,22 +17,31 @@
 	KLOG_DISABLE_CONSOLE =  6, /* disable printk to console */
 	KLOG_ENABLE_CONSOLE  =  7, /* enable printk to console */
 	KLOG_SET_CONSOLE_LVL =  8, /* set minimum severity of messages to be
-				    * printed to console */
+				      printed to console */
 
 	KLOG_GET_UNREAD      =  9, /* return number of unread characters */
-	KLOG_GET_SIZE        = 10  /* return size of log buffer */
+	KLOG_GET_SIZE        = 10, /* return size of log buffer */
+	KLOG_READ_NONBLOCK   = 11, /* read from log, don't block if empty
+				      -- new in 2.6.19 */
 };
 
 #ifdef __KERNEL__
+#include <linux/poll.h>
 
 /*
- * Constants passed by do_syslog to security_syslog to indicate which
- * privilege is requested.
+ * Constants passed to security_syslog to indicate which privilege is
+ * requested.
  */
 #define KLOGSEC_READ	  0  /* read current messages (klogd) */
 #define KLOGSEC_READHIST  1  /* read message history (dmesg) */
 #define KLOGSEC_CLEARHIST 2  /* clear message history (dmesg -c) */
 #define KLOGSEC_CONSOLE   3  /* set console log level */
 
+/*
+ * Subfunctions of sys_syslog used from fs/proc/kmsg.c.
+ */
+extern int klog_read(char __user *buf, int len, int block);
+extern unsigned int klog_poll(struct file *, poll_table *);
+
 #endif /* __KERNEL__ */
 #endif /* klog.h */
Index: linux-2.6/kernel/printk.c
===================================================================
--- linux-2.6.orig/kernel/printk.c	2006-11-10 14:57:32.000000000 -0800
+++ linux-2.6/kernel/printk.c	2006-11-11 21:54:17.000000000 -0800
@@ -45,7 +45,7 @@
 #define MINIMUM_CONSOLE_LOGLEVEL 1 /* Minimum loglevel we let people use */
 #define DEFAULT_CONSOLE_LOGLEVEL 7 /* anything MORE serious than KERN_DEBUG */
 
-DECLARE_WAIT_QUEUE_HEAD(log_wait);
+static DECLARE_WAIT_QUEUE_HEAD(log_wait);
 
 int console_printk[4] = {
 	DEFAULT_CONSOLE_LOGLEVEL,	/* console_loglevel */
@@ -166,116 +166,142 @@
 
 __setup("log_buf_len=", log_buf_len_setup);
 
-#define security_syslog_or_fail(type) do {		\
-		int error = security_syslog(type);	\
-		if (error)				\
-			return error;			\
-	} while (0)
+/*
+ * Subfunctions of sys_syslog.  Some are also used from fs/proc/kmsg.c.
+ */
 
-/* See linux/klog.h for the command numbers passed as the first argument.  */
-int do_syslog(int type, char __user *buf, int len)
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
+unsigned int klog_poll(struct file *file, poll_table *wait)
+{
+	poll_wait(file, &log_wait, wait);
+	if (log_end - log_start > 0)
+		return POLLIN | POLLRDNORM;
+	return 0;
+}
+
+static int klog_readhist(char __user *buf, int len)
 {
 	unsigned long i, j, limit, count;
-	int do_clear = 0;
 	char c;
 	int error = 0;
 
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
+#define security_syslog_or_fail(type) do {	\
+		error = security_syslog(type);	\
+		if (error)			\
+			return error;		\
+	} while (0)
+
+/* See linux/klog.h for the command numbers passed as the first argument.  */
+asmlinkage long sys_syslog(int type, char __user *buf, int len)
+{
+	int error = 0;
 	switch (type) {
 	case KLOG_CLOSE:
-		security_syslog_or_fail(KLOGSEC_READ);
 		break;
 	case KLOG_OPEN:
 		security_syslog_or_fail(KLOGSEC_READ);
 		break;
 	case KLOG_READ:
+	case KLOG_READ_NONBLOCK:
 		security_syslog_or_fail(KLOGSEC_READ);
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
+		error = klog_read(buf, len, type == KLOG_READ);
 		break;
 	case KLOG_READ_CLEAR_HIST:
+		security_syslog_or_fail(KLOGSEC_READHIST);
 		security_syslog_or_fail(KLOGSEC_CLEARHIST);
-		do_clear = 1;
-		/* FALL THRU */
+		error = klog_readhist(buf, len);
+		logged_chars = 0;
+		break;
 	case KLOG_READ_HIST:
 		security_syslog_or_fail(KLOGSEC_READHIST);
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
+		error = klog_readhist(buf, len);
 		break;
 	case KLOG_CLEAR_HIST:
 		security_syslog_or_fail(KLOGSEC_CLEARHIST);
@@ -293,7 +319,7 @@
 		security_syslog_or_fail(KLOGSEC_CONSOLE);
 		error = -EINVAL;
 		if (len < 1 || len > 8)
-			goto out;
+			break;
 		if (len < minimum_console_loglevel)
 			len = minimum_console_loglevel;
 		console_loglevel = len;
@@ -318,15 +344,9 @@
 		error = -EINVAL;
 		break;
 	}
-out:
 	return error;
 }
 
-asmlinkage long sys_syslog(int type, char __user *buf, int len)
-{
-	return do_syslog(type, buf, len);
-}
-
 /*
  * Call the console drivers on a range of log_buf
  */

--

