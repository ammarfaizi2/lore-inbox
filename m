Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263273AbTDYOyS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 10:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbTDYOyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 10:54:18 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:10369 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263273AbTDYOyQ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 10:54:16 -0400
Message-Id: <200304251506.h3PF6PQd005297@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: 2.5.68-bk3 - #if cleanups continued, (1/2)
From: Valdis.Kletnieks@vt.edu
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5293.1051283185.1@turing-police.cc.vt.edu>
Date: Fri, 25 Apr 2003 11:06:25 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus:  here are 2 final patches for #if CONFIG* issues, which involved
a bit more extensive surgery.  

After this and the following patch, 'make allyesconfig' and 'make allmodconfig'
are clean for -Wundef for CONFIG* and LINUX_VERSION_CODE except for the one
reference at line 28 of include/linux/serialP.h:

#include <linux/circ_buf.h>
#include <linux/wait.h>
#if (LINUX_VERSION_CODE < 0x020300)
/* Unfortunate, but Linux 2.2 needs async_icount defined here and
 * it got moved in 2.3 */
#include <linux/serial.h>
#endif

Somebody (Alan?) stated this was dead code, so I'm not sure if the better
fix is to #include linux/version.h or remove the if/include/endif block.

-Wundef still produces some 550 warnings, almost all confined to the
drivers/char and drivers/scsi trees.  stallion.c and istallion.c are about 20%
of the warnings by themselves. This is down from some 11,000+ warnings when
I started this cleanup.

--- linux-2.5.68-bk3/include/linux/ftape.h.dist	2003-04-07 13:31:56.000000000 -0400
+++ linux-2.5.68-bk3/include/linux/ftape.h	2003-04-23 02:43:25.918415976 -0400
@@ -137,6 +137,12 @@
 #else
 # define CONFIG_FT_MACH2 0
 #endif
+#ifdef CONFIG_FT_ALT_FDC
+# undef CONFIG_FT_ALT_FDC
+# define CONFIG_FT_ALT_FDC 1
+#else
+# define CONFIG_FT_ALT_FDC 0
+#endif
 
 /* Insert default settings
  */
--- linux-2.5.68-bk3/arch/i386/kernel/io_apic.c.dist	2003-04-22 13:57:34.000000000 -0400
+++ linux-2.5.68-bk3/arch/i386/kernel/io_apic.c	2003-04-23 02:49:39.397645051 -0400
@@ -269,7 +269,7 @@
 # include <linux/slab.h>		/* kmalloc() */
 # include <linux/timer.h>	/* time_after() */
  
-# if CONFIG_BALANCED_IRQ_DEBUG
+# ifdef CONFIG_BALANCED_IRQ_DEBUG
 #  define TDprintk(x...) do { printk("<%ld:%s:%d>: ", jiffies, __FILE__, __LINE__); printk(x); } while (0)
 #  define Dprintk(x...) do { TDprintk(x); } while (0)
 # else
--- linux-2.5.68-bk3/sound/oss/trident.c.dist	2003-04-22 13:57:51.000000000 -0400
+++ linux-2.5.68-bk3/sound/oss/trident.c	2003-04-23 02:58:39.534179158 -0400
@@ -207,7 +207,7 @@
 #include <asm/io.h>
 #include <asm/dma.h>
 
-#if defined CONFIG_ALPHA_NAUTILUS || CONFIG_ALPHA_GENERIC
+#if defined(CONFIG_ALPHA_NAUTILUS) || defined(CONFIG_ALPHA_GENERIC)
 #include <asm/hwrpb.h>
 #endif
 
@@ -4285,7 +4285,7 @@
 		if(card->revision == ALI_5451_V02)
 			ali_close_multi_channels();
 		/* edited by HMSEO for GT sound */
-#if defined CONFIG_ALPHA_NAUTILUS || CONFIG_ALPHA_GENERIC
+#if defined(CONFIG_ALPHA_NAUTILUS) || defined(CONFIG_ALPHA_GENERIC)
 		{
 			u16 ac97_data;
 			extern struct hwrpb_struct *hwrpb;
--- linux-2.5.68-bk3/drivers/ieee1394/sbp2.c.dist	2003-04-22 13:57:37.000000000 -0400
+++ linux-2.5.68-bk3/drivers/ieee1394/sbp2.c	2003-04-23 03:05:37.056109520 -0400
@@ -407,6 +407,9 @@
 #define outstanding_orb_incr
 #define outstanding_orb_decr
 #endif
+#ifndef CONFIG_IEEE1394_SBP2_DEBUG
+#define CONFIG_IEEE1394_SBP2_DEBUG 0
+#endif
 
 #ifdef CONFIG_IEEE1394_SBP2_DEBUG_DMA
 #define SBP2_DMA_ALLOC(fmt, args...) \


