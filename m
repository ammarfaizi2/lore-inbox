Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261624AbSLJTMP>; Tue, 10 Dec 2002 14:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262828AbSLJTMP>; Tue, 10 Dec 2002 14:12:15 -0500
Received: from air-2.osdl.org ([65.172.181.6]:31403 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261624AbSLJTML>;
	Tue, 10 Dec 2002 14:12:11 -0500
Date: Tue, 10 Dec 2002 11:16:04 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
Subject: move LOG_BUF_SIZE to header file
Message-ID: <Pine.LNX.4.33L2.0212101108550.12283-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'd like to see LOG_BUF_LEN from kernel/printk.c moved to a header file
so that some non-kernel (kernel-mode) tools can know the value being
used (tools like kmsgdump or lkcd etc.).

This patch moves LOG_BUF_LEN to include/linux/kernel.h .
Or it could go to a separate (new) header file...

Comments?

Thanks,
-- 
~Randy



--- ./include/linux/kernel.h%LOGBUF	Wed Nov 27 14:35:46 2002
+++ ./include/linux/kernel.h	Fri Dec  6 15:50:06 2002
@@ -38,6 +38,17 @@
 #define	KERN_INFO	"<6>"	/* informational			*/
 #define	KERN_DEBUG	"<7>"	/* debug-level messages			*/

+#if defined(CONFIG_X86_NUMAQ) || defined(CONFIG_IA64)
+#define LOG_BUF_LEN	(65536)
+#elif defined(CONFIG_ARCH_S390)
+#define LOG_BUF_LEN	(131072)
+#elif defined(CONFIG_SMP)
+#define LOG_BUF_LEN	(32768)
+#else
+#define LOG_BUF_LEN	(16384)			/* This must be a power of two */
+#endif
+#define LOG_BUF_MASK	(LOG_BUF_LEN-1)
+
 struct completion;

 #ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
--- ./kernel/printk.c%LOGBUF	Wed Nov 27 14:36:23 2002
+++ ./kernel/printk.c	Fri Dec  6 15:34:31 2002
@@ -16,6 +16,7 @@
  *	01Mar01 Andrew Morton <andrewm@uow.edu.au>
  */

+#include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/tty.h>
 #include <linux/tty_driver.h>
@@ -24,24 +25,12 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>			/* For in_interrupt() */
-#include <linux/config.h>
+#include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/delay.h>

 #include <asm/uaccess.h>

-#if defined(CONFIG_X86_NUMAQ) || defined(CONFIG_IA64)
-#define LOG_BUF_LEN	(65536)
-#elif defined(CONFIG_ARCH_S390)
-#define LOG_BUF_LEN	(131072)
-#elif defined(CONFIG_SMP)
-#define LOG_BUF_LEN	(32768)
-#else
-#define LOG_BUF_LEN	(16384)			/* This must be a power of two */
-#endif
-
-#define LOG_BUF_MASK	(LOG_BUF_LEN-1)
-
 #ifndef arch_consoles_callable
 #define arch_consoles_callable() (1)
 #endif

