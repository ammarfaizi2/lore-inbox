Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267291AbSK3T7T>; Sat, 30 Nov 2002 14:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267292AbSK3T7T>; Sat, 30 Nov 2002 14:59:19 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:8439 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267291AbSK3T7Q>; Sat, 30 Nov 2002 14:59:16 -0500
Date: Sat, 30 Nov 2002 21:06:35 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.50
Message-ID: <20021130200635.GE20774@fs.tum.de>
References: <Pine.LNX.4.44.0211271456160.18214-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211271456160.18214-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2002 at 03:07:38PM -0800, Linus Torvalds wrote:

>...
> Summary of changes from v2.5.49 to v2.5.50
> ============================================

2.5.50 includes two changes that have the following in common:
- Alan forwarded them to you
- they were originally sent by me
- they are buggy

Below are explanations and fixes.

>...
> Alan Cox <alan@lxorguk.ukuu.org.uk>:
>...
>   o remove junk from vlsi_ir
>...

1. the maintainer prefers to leave the LINUX_VERSION_CODE und to add an
   #include <linux/version.h> to make it easier to have the same driver 
   in both 2.4 and 2.5
2. my removal of pci_dma_prep_single was complete nonsense (no, it's not
   part of the comment...)

The following patch fixes it:

--- linux-2.5.50/include/net/irda/vlsi_ir.h.old	2002-11-30 20:50:10.000000000 +0100
+++ linux-2.5.50/include/net/irda/vlsi_ir.h	2002-11-30 20:50:20.000000000 +0100
@@ -27,6 +27,26 @@
 #ifndef IRDA_VLSI_FIR_H
 #define IRDA_VLSI_FIR_H
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,4)
+#ifdef CONFIG_PROC_FS
+/* PDE() introduced in 2.5.4 */
+#define PDE(inode) ((inode)->u.generic_ip)
+#endif
+#endif
+
+/*
+ * #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,xx)
+ *
+ * missing pci-dma api call to give streaming dma buffer back to hw
+ * patch floating on lkml - probably present in 2.5.26 or later
+ * otherwise defining it as noop is ok, since the vlsi-ir is only
+ * used on two oldish x86-based notebooks which are cache-coherent
+ */
+#define pci_dma_prep_single(dev, addr, size, direction)	/* nothing */
+/*
+ * #endif
+ */
+
 /* ================================================================ */
 
 /* non-standard PCI registers */
--- linux-2.5.50/drivers/net/irda/vlsi_ir.c.old	2002-11-30 20:51:12.000000000 +0100
+++ linux-2.5.50/drivers/net/irda/vlsi_ir.c	2002-11-30 20:51:39.000000000 +0100
@@ -44,6 +44,7 @@
 #include <linux/time.h>
 #include <linux/proc_fs.h>
 #include <linux/smp_lock.h>
+#include <linux/version.h>
 #include <asm/uaccess.h>
 
 #include <net/irda/irda.h>


>   o fix sound kconfig file locations
>...

The changed file locations are OK, wrond is my addition of the question 
strings to MSNDCLAS_HAVE_BOOT are MSNDPIN_HAVE_BOOT. As Roman Zippel 
told me in another thread they were define_bool in the old kconfig.

The following patch corrects this:

--- linux-2.5.50/sound/oss/Kconfig.old	2002-11-30 20:47:01.000000000 +0100
+++ linux-2.5.50/sound/oss/Kconfig	2002-11-30 20:47:25.000000000 +0100
@@ -293,7 +293,7 @@
 	depends on SOUND_PRIME && SOUND_MSNDCLAS=y
 
 config MSNDCLAS_HAVE_BOOT
-	bool "Have MSNDINIT.BIN firmware file"
+	bool
 	depends on SOUND_MSNDCLAS=y
 	default y
 
@@ -355,7 +355,7 @@
 	depends on SOUND_PRIME && SOUND_MSNDPIN=y
 
 config MSNDPIN_HAVE_BOOT
-	bool "Have PNDSPINI.BIN firmware file"
+	bool
 	depends on SOUND_MSNDPIN=y
 	default y
 



Sorry
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

