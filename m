Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbUBKCGj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 21:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUBKCGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 21:06:39 -0500
Received: from waste.org ([209.173.204.2]:7338 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261595AbUBKCGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 21:06:37 -0500
Date: Tue, 10 Feb 2004 20:06:26 -0600
From: Matt Mackall <mpm@selenic.com>
To: wdebruij@dds.nl, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch] Re: missing vprintf in kernel.api. Interest in patch?
Message-ID: <20040211020626.GA7931@waste.org>
References: <1076408579.4028b1036a8ae@webmail.dds.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076408579.4028b1036a8ae@webmail.dds.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 11:22:59AM +0100, wdebruij@dds.nl wrote:
> Therefore my question is this: is there any interest in 
> 
> (1) a small patch that extracts the vsnprintf(printk_buf,...) from printk and
> thus creates a vprintf function (trivial change, perhaps +5 lines of code).

I already have this patch in my -tiny tree as well as some other patches to
convert some would-be users like ext3_error. Andrew, interested in these? 

Add vprintk call


 tiny-mpm/include/linux/kernel.h |    1 +
 tiny-mpm/kernel/printk.c        |   14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff -puN include/linux/kernel.h~vprintk include/linux/kernel.h
--- tiny/include/linux/kernel.h~vprintk	2004-02-04 14:55:22.000000000 -0600
+++ tiny-mpm/include/linux/kernel.h	2004-02-04 14:55:22.000000000 -0600
@@ -84,6 +84,7 @@ extern unsigned long long memparse(char 
 extern int kernel_text_address(unsigned long addr);
 extern int session_of_pgrp(int pgrp);
 
+asmlinkage int vprintk(const char *fmt, va_list args);
 asmlinkage int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
 
diff -puN kernel/printk.c~vprintk kernel/printk.c
--- tiny/kernel/printk.c~vprintk	2004-02-04 14:55:22.000000000 -0600
+++ tiny-mpm/kernel/printk.c	2004-02-04 14:55:22.000000000 -0600
@@ -474,6 +474,17 @@ static void emit_log_char(char c)
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
@@ -491,9 +502,7 @@ asmlinkage int printk(const char *fmt, .
 	spin_lock_irqsave(&logbuf_lock, flags);
 
 	/* Emit the output into the temporary buffer */
-	va_start(args, fmt);
 	printed_len = vsnprintf(printk_buf, sizeof(printk_buf), fmt, args);
-	va_end(args);
 
 	/*
 	 * Copy the output into log_buf.  If the caller didn't provide
@@ -543,6 +552,7 @@ out:
 	return printed_len;
 }
 EXPORT_SYMBOL(printk);
+EXPORT_SYMBOL(vprintk);
 
 /**
  * acquire_console_sem - lock the console system for exclusive use.

_


-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
