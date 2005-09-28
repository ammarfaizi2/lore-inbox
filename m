Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbVI1Xma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbVI1Xma (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 19:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbVI1Xma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 19:42:30 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:17600 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751248AbVI1Xm3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 19:42:29 -0400
Date: Thu, 29 Sep 2005 00:42:27 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, jchapman@katalix.com,
       linuxppc-dev@ozlabs.org
Subject: [PATCH] mv64x60_wdt __user annotations and cleanups
Message-ID: <20050928234227.GN7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	* use nonseekable_open() instead of messing with 
	if (*ppos != file->f_pos)
		return -EISPIPE
in ->write() (->read is NULL).
	* trivial __user annotations
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git6-base/drivers/char/watchdog/mv64x60_wdt.c current/drivers/char/watchdog/mv64x60_wdt.c
--- RC14-rc2-git6-base/drivers/char/watchdog/mv64x60_wdt.c	2005-09-26 00:02:29.000000000 -0400
+++ current/drivers/char/watchdog/mv64x60_wdt.c	2005-09-22 15:08:16.000000000 -0400
@@ -87,6 +87,8 @@
 	mv64x60_wdt_service();
 	mv64x60_wdt_handler_enable();
 
+	nonseekable_open(inode, file);
+
 	return 0;
 }
 
@@ -103,12 +105,9 @@
 	return 0;
 }
 
-static ssize_t mv64x60_wdt_write(struct file *file, const char *data,
+static ssize_t mv64x60_wdt_write(struct file *file, const char __user *data,
 				 size_t len, loff_t * ppos)
 {
-	if (*ppos != file->f_pos)
-		return -ESPIPE;
-
 	if (len)
 		mv64x60_wdt_service();
 
@@ -119,6 +118,7 @@
 			     unsigned int cmd, unsigned long arg)
 {
 	int timeout;
+	void __user *argp = (void __user *)arg;
 	static struct watchdog_info info = {
 		.options = WDIOF_KEEPALIVEPING,
 		.firmware_version = 0,
@@ -127,13 +127,13 @@
 
 	switch (cmd) {
 	case WDIOC_GETSUPPORT:
-		if (copy_to_user((void *)arg, &info, sizeof(info)))
+		if (copy_to_user(argp, &info, sizeof(info)))
 			return -EFAULT;
 		break;
 
 	case WDIOC_GETSTATUS:
 	case WDIOC_GETBOOTSTATUS:
-		if (put_user(wdt_status, (int *)arg))
+		if (put_user(wdt_status, (int __user *)argp))
 			return -EFAULT;
 		wdt_status &= ~WDIOF_KEEPALIVEPING;
 		break;
@@ -154,7 +154,7 @@
 
 	case WDIOC_GETTIMEOUT:
 		timeout = mv64x60_wdt_timeout * HZ;
-		if (put_user(timeout, (int *)arg))
+		if (put_user(timeout, (int __user *)argp))
 			return -EFAULT;
 		break;
 
