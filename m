Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVCTVbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVCTVbG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 16:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVCTVbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 16:31:06 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:55714 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S261177AbVCTVbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 16:31:02 -0500
Date: Sun, 20 Mar 2005 22:35:33 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Bodo Eggert <7eggert@gmx.de>
Cc: Michael Tokarev <mjt@tls.msk.ru>, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.11.2][1/2] printk with anti-cluttering-feature
In-Reply-To: <Pine.LNX.4.58.0503202151360.2869@be1.lrz>
Message-ID: <Pine.LNX.4.58.0503202232001.3051@be1.lrz>
References: <Pine.LNX.4.58.0503200528520.2804@be1.lrz> <423D6353.5010603@tls.msk.ru>
 <Pine.LNX.4.58.0503201425080.2886@be1.lrz> <Pine.LNX.4.58.0503202151360.2869@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce printk_nospam, which will prevent duplicate and excessive 
printing.

Signed-Off-By: Bodo Eggert <7eggert@gmx.de>

diff -purNXdontdiff linux-2.6.11/include/linux/kernel.h linux-2.6.11.new/include/linux/kernel.h
--- linux-2.6.11/include/linux/kernel.h	2005-03-03 15:42:13.000000000 +0100
+++ linux-2.6.11.new/include/linux/kernel.h	2005-03-20 21:15:23.000000000 +0100
@@ -104,6 +104,12 @@ extern int session_of_pgrp(int pgrp);
 asmlinkage int vprintk(const char *fmt, va_list args);
 asmlinkage int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
+asmlinkage int printk_nospam(unsigned int magic, const char * fmt, ...)
+	__attribute__ ((format (printf, 2, 3)));
+/* Don't print the previously printed message had the same magic or the rate
+   limit would be exceeded.
+   Hint: Use a unique random value for the magic, e.g. the first value from
+   cksum on the file you're editing */
 
 unsigned long int_sqrt(unsigned long);
 
diff -purNXdontdiff linux-2.6.11/kernel/printk.c linux-2.6.11.new/kernel/printk.c
--- linux-2.6.11/kernel/printk.c	2005-03-18 21:54:35.000000000 +0100
+++ linux-2.6.11.new/kernel/printk.c	2005-03-20 21:15:14.000000000 +0100
@@ -115,6 +115,8 @@ static int preferred_console = -1;
 /* Flag: console code may call schedule() */
 static int console_may_schedule;
 
+static int antispam_magic;
+
 /*
  *	Setup a list of consoles. Called from init/main.c
  */
@@ -517,6 +519,26 @@ asmlinkage int printk(const char *fmt, .
 	va_list args;
 	int r;
 
+	antispam_magic = 0;
+
+	va_start(args, fmt);
+	r = vprintk(fmt, args);
+	va_end(args);
+
+	return r;
+}
+
+asmlinkage int printk_nospam(unsigned int magic, const char *fmt, ...)
+{
+	va_list args;
+	int r;
+	
+	if (magic == antispam_magic)
+		return 0;
+	if (!printk_ratelimit())
+		return 0;
+	antispam_magic = magic;
+
 	va_start(args, fmt);
 	r = vprintk(fmt, args);
 	va_end(args);
@@ -591,6 +613,7 @@ out:
 	return printed_len;
 }
 EXPORT_SYMBOL(printk);
+EXPORT_SYMBOL(printk_nospam);
 EXPORT_SYMBOL(vprintk);
 
 /**
