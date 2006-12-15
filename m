Return-Path: <linux-kernel-owner+w=401wt.eu-S932128AbWLOAqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWLOAqg (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 19:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbWLOAqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 19:46:36 -0500
Received: from l2mail1.panix.com ([166.84.1.75]:60509 "EHLO l2mail1.panix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932128AbWLOAqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 19:46:34 -0500
X-Greylist: delayed 1278 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 19:46:34 EST
Message-Id: <20061215002334.221055000@panix.com>
References: <20061215001639.988521000@panix.com>
User-Agent: quilt/0.45-1
Date: Thu, 14 Dec 2006 16:16:42 -0800
From: Zack Weinberg <zackw@panix.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, jmorris@namei.org,
       Chris Wright <chrisw@sous-sol.org>
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

Change from previous version of patch: proc/kmsg.c declares the
kernel/printk.c interfaces itself, instead of getting them from klog.h
which people want to be purely userspace-visible constants.  kmsg.c has
always had private declarations of printk.c functions (before, there were
declarations of do_syslog and a wait queue there); as it is unlikely that
more users of these functions will appear, I think this will do fine.
(It might be reasonable to put declarations in console.h.)

zw

Index: linux-2.6/fs/proc/kmsg.c
===================================================================
--- linux-2.6.orig/fs/proc/kmsg.c	2006-12-13 16:04:46.000000000 -0800
+++ linux-2.6/fs/proc/kmsg.c	2006-12-13 16:36:56.000000000 -0800
@@ -12,40 +12,43 @@
 #include <linux/poll.h>
 #include <linux/fs.h>
 #include <linux/klog.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
-extern wait_queue_head_t log_wait;
-
-extern int do_syslog(int type, char __user *bug, int count);
+/* interfaces from kernel/printk.c */
+extern int klog_read(char __user *, int, int);
+extern unsigned int klog_poll(struct file *, poll_table *);
 
 static int kmsg_open(struct inode * inode, struct file * file)
 {
-	return do_syslog(KLOG_OPEN,NULL,0);
+	int error = security_syslog(LSM_KLOG_READ);
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
--- linux-2.6.orig/include/linux/klog.h	2006-12-13 16:12:43.000000000 -0800
+++ linux-2.6/include/linux/klog.h	2006-12-13 16:33:09.000000000 -0800
@@ -20,7 +20,9 @@
 				    * printed to console */
 
 	KLOG_GET_UNREAD      =  9, /* return number of unread characters */
-	KLOG_GET_SIZE        = 10  /* return size of log buffer */
+	KLOG_GET_SIZE        = 10, /* return size of log buffer */
+	KLOG_READ_NONBLOCK   = 11, /* read from log, don't block if empty
+				    * -- new in 2.6.20 */
 };
 
 #endif /* klog.h */
Index: linux-2.6/kernel/printk.c
===================================================================
--- linux-2.6.orig/kernel/printk.c	2006-12-13 16:08:30.000000000 -0800
+++ linux-2.6/kernel/printk.c	2006-12-13 16:39:24.000000000 -0800
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
@@ -164,116 +165,142 @@
 
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
-		security_syslog_or_fail(LSM_KLOG_READ);
 		break;
 	case KLOG_OPEN:
 		security_syslog_or_fail(LSM_KLOG_READ);
 		break;
 	case KLOG_READ:
+	case KLOG_READ_NONBLOCK:
 		security_syslog_or_fail(LSM_KLOG_READ);
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
+		security_syslog_or_fail(LSM_KLOG_READHIST);
 		security_syslog_or_fail(LSM_KLOG_CLEARHIST);
-		do_clear = 1;
-		/* FALL THRU */
+		error = klog_readhist(buf, len);
+		logged_chars = 0;
+		break;
 	case KLOG_READ_HIST:
 		security_syslog_or_fail(LSM_KLOG_READHIST);
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
 		security_syslog_or_fail(LSM_KLOG_CLEARHIST);
@@ -291,7 +318,7 @@
 		security_syslog_or_fail(LSM_KLOG_CONSOLE);
 		error = -EINVAL;
 		if (len < 1 || len > 8)
-			goto out;
+			break;
 		if (len < minimum_console_loglevel)
 			len = minimum_console_loglevel;
 		console_loglevel = len;
@@ -316,15 +343,9 @@
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

