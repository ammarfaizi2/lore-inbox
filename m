Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263277AbTEVU6u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 16:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263279AbTEVU6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 16:58:50 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:59533 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S263277AbTEVU6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 16:58:46 -0400
Subject: Re: [PATCH] Shared crc32 for 2.4.
From: David Woodhouse <dwmw2@infradead.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030521235033.GA2470@werewolf.able.es>
References: <1053193432.9218.13.camel@imladris.demon.co.uk>
	 <20030521235033.GA2470@werewolf.able.es>
Content-Type: text/plain
Organization: 
Message-Id: <1053637864.21582.700.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Thu, 22 May 2003 22:11:05 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Rcpt-To: jamagallon@able.es, marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-22 at 00:50, J.A. Magallon wrote:
> This works if crc32.o is compiled as a module, but does not work if it is
> built into the kernel. For example, crc32_le symbol does not appear
> in System.map nor vmlinux.

Oh bollocks; sorry I'd forgotten about that.

Added to the tree from which Marcelo will pull for 2.4.22-pre1...


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1211  -> 1.1212 
#	         lib/crc32.c	1.1     -> 1.2    
#	      kernel/ksyms.c	1.67    -> 1.68   
#	        lib/Makefile	1.10    -> 1.11   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/22	dwmw2@dwmw2.baythorne.internal	1.1212
# Fix CONFIG_CRC32=y when nothing in-kernel uses CRC32 functions
# by exporting the symbol from kernel/ksyms.c instead of lib/crc32.c,
# hence forcing lib/crc32.o to get pulled in during the final link.
# --------------------------------------------
#
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Thu May 22 22:08:02 2003
+++ b/kernel/ksyms.c	Thu May 22 22:08:02 2003
@@ -48,6 +48,7 @@
 #include <linux/completion.h>
 #include <linux/seq_file.h>
 #include <linux/dnotify.h>
+#include <linux/crc32.h>
 #include <asm/checksum.h>
 
 #if defined(CONFIG_PROC_FS)
@@ -557,6 +558,12 @@
 EXPORT_SYMBOL(strnicmp);
 EXPORT_SYMBOL(strspn);
 EXPORT_SYMBOL(strsep);
+
+#ifdef CONFIG_CRC32
+EXPORT_SYMBOL(crc32_le);
+EXPORT_SYMBOL(crc32_be);
+EXPORT_SYMBOL(bitreverse);
+#endif
 
 /* software interrupts */
 EXPORT_SYMBOL(tasklet_hi_vec);
diff -Nru a/lib/Makefile b/lib/Makefile
--- a/lib/Makefile	Thu May 22 22:08:02 2003
+++ b/lib/Makefile	Thu May 22 22:08:02 2003
@@ -8,7 +8,7 @@
 
 L_TARGET := lib.a
 
-export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o rbtree.o crc32.o
+export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o rbtree.o
 
 obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o \
 	 bust_spinlocks.o rbtree.o dump_stack.o
diff -Nru a/lib/crc32.c b/lib/crc32.c
--- a/lib/crc32.c	Thu May 22 22:08:02 2003
+++ b/lib/crc32.c	Thu May 22 22:08:02 2003
@@ -266,10 +266,6 @@
 	return x;
 }
 
-EXPORT_SYMBOL(crc32_le);
-EXPORT_SYMBOL(crc32_be);
-EXPORT_SYMBOL(bitreverse);
-
 /*
  * A brief CRC tutorial.
  *

-- 
dwmw2


