Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264284AbTCXRE3>; Mon, 24 Mar 2003 12:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264285AbTCXQtx>; Mon, 24 Mar 2003 11:49:53 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:46058 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264284AbTCXQa5>; Mon, 24 Mar 2003 11:30:57 -0500
Message-Id: <200303241642.h2OGg535008281@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:41:52 +0000
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: bring sparc riowatchdog in sync with 2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

+ C99 struct initialisers

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/sbus/char/riowatchdog.c linux-2.5/drivers/sbus/char/riowatchdog.c
--- bk-linus/drivers/sbus/char/riowatchdog.c	2003-03-08 09:57:23.000000000 +0000
+++ linux-2.5/drivers/sbus/char/riowatchdog.c	2003-03-17 23:42:32.000000000 +0000
@@ -1,4 +1,4 @@
-/* $Id: riowatchdog.c,v 1.3 2001/10/08 22:19:51 davem Exp $
+/* $Id: riowatchdog.c,v 1.3.2.2 2002/01/23 18:48:02 davem Exp $
  * riowatchdog.c - driver for hw watchdog inside Super I/O of RIO
  *
  * Copyright (C) 2001 David S. Miller (davem@redhat.com)
@@ -127,8 +127,11 @@ static int riowd_release(struct inode *i
 static int riowd_ioctl(struct inode *inode, struct file *filp,
 		       unsigned int cmd, unsigned long arg)
 {
-	static struct watchdog_info info = { 0, 0, "Natl. Semiconductor PC97317" };
+	static struct watchdog_info info = {
+	       	WDIOF_SETTIMEOUT, 0, "Natl. Semiconductor PC97317"
+	};
 	unsigned int options;
+	int new_margin;
 
 	switch (cmd) {
 	case WDIOC_GETSUPPORT:
@@ -159,6 +162,18 @@ static int riowd_ioctl(struct inode *ino
 
 		break;
 
+	case WDIOC_SETTIMEOUT:
+		if (get_user(new_margin, (int *)arg))
+			return -EFAULT;
+		if ((new_margin < 60) || (new_margin > (255 * 60)))
+		    return -EINVAL;
+		riowd_timeout = (new_margin + 59) / 60;
+		riowd_pingtimer();
+		/* Fall */
+
+	case WDIOC_GETTIMEOUT:
+		return put_user(riowd_timeout * 60, (int *)arg);
+
 	default:
 		return -EINVAL;
 	};
