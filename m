Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbVHOVHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbVHOVHe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 17:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbVHOVHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 17:07:33 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:50816 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S964965AbVHOVHc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 17:07:32 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Date: Mon, 15 Aug 2005 15:07:22 -0600
User-Agent: KMail/1.8.1
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-ia64@vger.kernel.org
References: <200508111424.43150.bjorn.helgaas@hp.com> <1123836012.22460.16.camel@localhost.localdomain>
In-Reply-To: <1123836012.22460.16.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508151507.22776.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 August 2005 2:40 am, Alan Cox wrote:
> Assuming all IA-64 boxes are PCI or better then you actually want to
> edit include/asm-ia64/ide.h and edit ide_default_io_base where someone
> years ago cut and pasted x86-32 values so that case 2-5 are removed.
> Then you will just probe the compatibility mode PCI addresses for system
> IDE channels.

Thanks for the pointer.  There shouldn't be anything arch-
specific required for ia64, so I think we can get rid of
just about everything in asm-ia64/ide.h, since everything
we care about will be discovered by PCI IDE.

There's no ia64 reason to limit MAX_HWIFS, so I used
CONFIG_IDE_MAX_HWIFS, resulting in a little more Kconfig
ugliness.  Maybe that should move into linux/ide.h, so
arches only need to define MAX_HWIFS if they have a need
for it?

I noticed that on a box with no devices on ide1, we probed
ide1 twice -- once via ide_setup_pci_device() and again via
ide_generic_init().  This isn't fatal, since the generic probe
uses the I/O ports setup by PCI IDE, but it's unnecessary
and a bit ugly.

I stuck in a "hwif->noprobe = 1" at the point where probe_hwif()
decides the interface isn't present, which prevents the second
probe by ide_generic_init().

Other comments or advice?

Index: work-vga/drivers/ide/Kconfig
===================================================================
--- work-vga.orig/drivers/ide/Kconfig	2005-08-11 15:39:27.000000000 -0600
+++ work-vga/drivers/ide/Kconfig	2005-08-15 12:08:05.000000000 -0600
@@ -52,9 +52,9 @@
 
 if IDE
 
-config IDE_MAX_HWIFS 
+config IDE_MAX_HWIFS
 	int "Max IDE interfaces"
-	depends on ALPHA || SUPERH
+	depends on ALPHA || SUPERH || IA64
 	default 4
 	help
 	  This is the maximum number of IDE hardware interfaces that will
Index: work-vga/include/asm-ia64/ide.h
===================================================================
--- work-vga.orig/include/asm-ia64/ide.h	2005-08-03 16:48:31.000000000 -0600
+++ work-vga/include/asm-ia64/ide.h	2005-08-15 14:29:44.000000000 -0600
@@ -14,58 +14,12 @@
 #ifdef __KERNEL__
 
 #include <linux/config.h>
-
-#include <linux/irq.h>
+#include <asm-generic/ide_iops.h>
 
 #ifndef MAX_HWIFS
-# ifdef CONFIG_PCI
-#define MAX_HWIFS	10
-# else
-#define MAX_HWIFS	6
-# endif
-#endif
-
-#define IDE_ARCH_OBSOLETE_DEFAULTS
-
-static inline int ide_default_irq(unsigned long base)
-{
-	switch (base) {
-	      case 0x1f0: return isa_irq_to_vector(14);
-	      case 0x170: return isa_irq_to_vector(15);
-	      case 0x1e8: return isa_irq_to_vector(11);
-	      case 0x168: return isa_irq_to_vector(10);
-	      case 0x1e0: return isa_irq_to_vector(8);
-	      case 0x160: return isa_irq_to_vector(12);
-	      default:
-		return 0;
-	}
-}
-
-static inline unsigned long ide_default_io_base(int index)
-{
-	switch (index) {
-	      case 0: return 0x1f0;
-	      case 1: return 0x170;
-	      case 2: return 0x1e8;
-	      case 3: return 0x168;
-	      case 4: return 0x1e0;
-	      case 5: return 0x160;
-	      default:
-		return 0;
-	}
-}
-
-#define IDE_ARCH_OBSOLETE_INIT
-#define ide_default_io_ctl(base)	((base) + 0x206) /* obsolete */
-
-#ifdef CONFIG_PCI
-#define ide_init_default_irq(base)	(0)
-#else
-#define ide_init_default_irq(base)	ide_default_irq(base)
+#define MAX_HWIFS	CONFIG_IDE_MAX_HWIFS
 #endif
 
-#include <asm-generic/ide_iops.h>
-
 #endif /* __KERNEL__ */
 
 #endif /* __ASM_IA64_IDE_H */
Index: work-vga/include/linux/ide.h
===================================================================
--- work-vga.orig/include/linux/ide.h	2005-08-03 16:48:32.000000000 -0600
+++ work-vga/include/linux/ide.h	2005-08-15 12:43:38.000000000 -0600
@@ -266,7 +266,7 @@
 
 #include <asm/ide.h>
 
-/* needed on alpha, x86/x86_64, ia64, mips, ppc32 and sh */
+/* needed on alpha, x86/x86_64, mips, ppc32 and sh */
 #ifndef IDE_ARCH_OBSOLETE_DEFAULTS
 # define ide_default_io_base(index)	(0)
 # define ide_default_irq(base)		(0)
Index: work-vga/drivers/ide/ide-probe.c
===================================================================
--- work-vga.orig/drivers/ide/ide-probe.c	2005-08-09 15:09:59.000000000 -0600
+++ work-vga/drivers/ide/ide-probe.c	2005-08-15 14:30:33.000000000 -0600
@@ -852,6 +852,7 @@
 
 	if (!hwif->present) {
 		ide_hwif_release_regions(hwif);
+		hwif->noprobe = 1;
 		return;
 	}
 
