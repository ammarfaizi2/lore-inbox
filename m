Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267861AbUG3WjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267861AbUG3WjN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 18:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbUG3WjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 18:39:12 -0400
Received: from waste.org ([209.173.204.2]:50397 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S267861AbUG3Wib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 18:38:31 -0400
Date: Fri, 30 Jul 2004 17:38:23 -0500
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/3] vprintk support
Message-ID: <20040730223823.GW16310@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add vprintk call. This lets us directly pass varargs stuff to the
console without using vsnprintf to an intermediate buffer.

Signed-off-by: Matt Mackall <mpm@selenic.com>

 tiny-mpm/include/linux/kernel.h |    1 +
 tiny-mpm/kernel/printk.c        |   14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

Index: tiny/include/linux/kernel.h
===================================================================
--- tiny.orig/include/linux/kernel.h	2004-04-15 14:18:37.000000000 -0500
+++ tiny/include/linux/kernel.h	2004-04-19 13:29:39.000000000 -0500
@@ -87,6 +87,7 @@
 extern int kernel_text_address(unsigned long addr);
 extern int session_of_pgrp(int pgrp);
 
+asmlinkage int vprintk(const char *fmt, va_list args);
 asmlinkage int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
 
Index: tiny/kernel/printk.c
===================================================================
--- tiny.orig/kernel/printk.c	2004-04-15 14:18:37.000000000 -0500
+++ tiny/kernel/printk.c	2004-04-19 13:29:39.000000000 -0500
@@ -483,6 +483,17 @@
 asmlinkage int printk(const char *fmt, ...)
 {
 	va_list args;
+	int r;
+
+	va_start(args, fmt);
+	r = vprintk(fmt, args);
+	va_end(args);
+
+	return r;
+}
+
+asmlinkage int vprintk(const char *fmt, va_list args)
+{
 	unsigned long flags;
 	int printed_len;
 	char *p;
@@ -500,9 +511,7 @@
 	spin_lock_irqsave(&logbuf_lock, flags);
 
 	/* Emit the output into the temporary buffer */
-	va_start(args, fmt);
 	printed_len = vscnprintf(printk_buf, sizeof(printk_buf), fmt, args);
-	va_end(args);
 
 	/*
 	 * Copy the output into log_buf.  If the caller didn't provide
@@ -554,6 +563,7 @@
 	return printed_len;
 }
 EXPORT_SYMBOL(printk);
+EXPORT_SYMBOL(vprintk);
 
 /**
  * acquire_console_sem - lock the console system for exclusive use.


-- 
Mathematics is the supreme nostalgia of our time.
