Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266517AbUJWIHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266517AbUJWIHb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 04:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbUJWIHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 04:07:31 -0400
Received: from gate.crashing.org ([63.228.1.57]:19647 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266517AbUJWIHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 04:07:20 -0400
Subject: Re: [PATCH] ppc64: Add mecanism to check existence of legacy ISA
	devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <1098493130.6008.122.camel@gaston>
References: <1098490981.11740.109.camel@gaston>
	 <Pine.LNX.4.58.0410221730560.2101@ppc970.osdl.org>
	 <1098493130.6008.122.camel@gaston>
Content-Type: text/plain
Message-Id: <1098518731.6029.161.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 23 Oct 2004 18:05:32 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, after having a second look & talking to paulus, I still think
that bringing in the isapnp stuff for 2 drivers that don't even use
it at this point is overkill... However, my previous patch exposed
the internals of the ppc_md. data structure to drivers, which wasn't
nice, this new patch cleans that up.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc64/kernel/pSeries_setup.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pSeries_setup.c	2004-10-23 13:22:19.321313848 +1000
+++ linux-work/arch/ppc64/kernel/pSeries_setup.c	2004-10-23 13:22:19.652263536 +1000
@@ -476,6 +476,31 @@
 	setup_default_decr();
 }
 
+static int pSeries_check_legacy_ioport(unsigned int baseport)
+{
+	struct device_node *np;
+
+#define I8042_DATA_REG	0x60
+#define FDC_BASE	0x3f0
+
+
+	switch(baseport) {
+	case I8042_DATA_REG:
+		np = of_find_node_by_type(NULL, "8042");
+		if (np == NULL)
+			return -ENODEV;
+		of_node_put(np);
+		break;
+	case FDC_BASE:
+		np = of_find_node_by_type(NULL, "fdc");
+		if (np == NULL)
+			return -ENODEV;
+		of_node_put(np);
+		break;
+	}
+	return 0;
+}
+
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
@@ -510,4 +535,5 @@
 	.set_rtc_time		= pSeries_set_rtc_time,
 	.calibrate_decr		= pSeries_calibrate_decr,
 	.progress		= pSeries_progress,
+	.check_legacy_ioport	= pSeries_check_legacy_ioport,
 };
Index: linux-work/arch/ppc64/kernel/pmac_setup.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pmac_setup.c	2004-10-21 11:47:00.000000000 +1000
+++ linux-work/arch/ppc64/kernel/pmac_setup.c	2004-10-23 13:22:19.662262016 +1000
@@ -420,6 +420,15 @@
 #endif /* CONFIG_BOOTX_TEXT */
 }
 
+/*
+ * pmac has no legacy IO, anything calling this function has to
+ * fail or bad things will happen
+ */
+static int pmac_check_legacy_ioport(unsigned int baseport)
+{
+	return -ENODEV;
+}
+
 static int __init pmac_declare_of_platform_devices(void)
 {
 	struct device_node *np;
@@ -474,4 +483,5 @@
       	.calibrate_decr		= pmac_calibrate_decr,
 	.feature_call		= pmac_do_feature_call,
 	.progress		= pmac_progress,
+	.check_legacy_ioport	= pmac_check_legacy_ioport
 };
Index: linux-work/include/asm-ppc64/floppy.h
===================================================================
--- linux-work.orig/include/asm-ppc64/floppy.h	2004-09-24 14:36:11.000000000 +1000
+++ linux-work/include/asm-ppc64/floppy.h	2004-10-23 13:22:19.679259432 +1000
@@ -11,6 +11,7 @@
 #define __ASM_PPC64_FLOPPY_H
 
 #include <linux/config.h>
+#include <asm/machdep.h>
 
 #define fd_inb(port)			inb_p(port)
 #define fd_outb(value,port)		outb_p(value,port)
Index: linux-work/include/asm-ppc64/machdep.h
===================================================================
--- linux-work.orig/include/asm-ppc64/machdep.h	2004-09-29 18:24:23.000000000 +1000
+++ linux-work/include/asm-ppc64/machdep.h	2004-10-23 17:41:20.852641960 +1000
@@ -114,6 +114,9 @@
 	 */
 	long	 	(*feature_call)(unsigned int feature, ...);
 
+	/* Check availability of legacy devices like i8042 */
+	int 		(*check_legacy_ioport)(unsigned int baseport);
+
 };
 
 extern struct machdep_calls ppc_md;
Index: linux-work/drivers/block/floppy.c
===================================================================
--- linux-work.orig/drivers/block/floppy.c	2004-09-24 14:33:36.000000000 +1000
+++ linux-work/drivers/block/floppy.c	2004-10-23 17:04:19.944271352 +1000
@@ -4286,6 +4286,13 @@
 	}
 
 	use_virtual_dma = can_use_virtual_dma & 1;
+#if defined(CONFIG_PPC64)
+	if (check_legacy_ioport(FDC1)) {
+		del_timer(&fd_timeout);
+		err = -ENODEV;
+		goto out_unreg_region;
+	}
+#endif
 	fdc_state[0].address = FDC1;
 	if (fdc_state[0].address == -1) {
 		del_timer(&fd_timeout);
Index: linux-work/drivers/input/serio/i8042-io.h
===================================================================
--- linux-work.orig/drivers/input/serio/i8042-io.h	2004-09-24 14:34:02.000000000 +1000
+++ linux-work/drivers/input/serio/i8042-io.h	2004-10-23 17:00:52.638786576 +1000
@@ -35,6 +35,7 @@
 # define I8042_AUX_IRQ	12
 #endif
 
+
 /*
  * Register numbers.
  */
@@ -96,7 +97,7 @@
  * On ix86 platforms touching the i8042 data register region can do really
  * bad things. Because of this the region is always reserved on ix86 boxes.
  */
-#if !defined(__i386__) && !defined(__sh__) && !defined(__alpha__) && !defined(__x86_64__) && !defined(__mips__)
+#if !defined(__i386__) && !defined(__sh__) && !defined(__alpha__) && !defined(__x86_64__) && !defined(__mips__) && !defined (CONFIG_PPC64)
 	if (!request_region(I8042_DATA_REG, 16, "i8042"))
 		return -1;
 #endif
@@ -110,12 +111,18 @@
 		i8042_noloop = 1;
 #endif
 
+#if defined(CONFIG_PPC64)
+	if (check_legacy_ioport(I8042_DATA_REG))
+		return -1;
+	if (!request_region(I8042_DATA_REG, 16, "i8042"))
+		return -1;
+#endif
 	return 0;
 }
 
 static inline void i8042_platform_exit(void)
 {
-#if !defined(__i386__) && !defined(__sh__) && !defined(__alpha__) && !defined(__x86_64__)
+#if !defined(__i386__) && !defined(__sh__) && !defined(__alpha__) && !defined(__x86_64__) && !defined(CONFIG_PPC64)
 	release_region(I8042_DATA_REG, 16);
 #endif
 }
Index: linux-work/arch/ppc64/kernel/pSeries_pci.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pSeries_pci.c	2004-10-20 13:01:00.000000000 +1000
+++ linux-work/arch/ppc64/kernel/pSeries_pci.c	2004-10-23 13:22:19.737250616 +1000
@@ -619,25 +619,12 @@
 
 static void __init pSeries_request_regions(void)
 {
-	struct device_node *i8042;
-
 	request_region(0x20,0x20,"pic1");
 	request_region(0xa0,0x20,"pic2");
 	request_region(0x00,0x20,"dma1");
 	request_region(0x40,0x20,"timer");
 	request_region(0x80,0x10,"dma page reg");
 	request_region(0xc0,0x20,"dma2");
-
-#define I8042_DATA_REG 0x60
-
-	/*
-	 * Some machines have an unterminated i8042 so check the device
-	 * tree and reserve the region if it does not appear. Later on
-	 * the i8042 code will try and reserve this region and fail.
-	 */
-	if (!(i8042 = of_find_node_by_type(NULL, "8042")))
-		request_region(I8042_DATA_REG, 16, "reserved (no i8042)");
-	of_node_put(i8042);
 }
 
 void __init pSeries_final_fixup(void)
Index: linux-work/include/asm-ppc64/io.h
===================================================================
--- linux-work.orig/include/asm-ppc64/io.h	2004-10-22 10:40:02.000000000 +1000
+++ linux-work/include/asm-ppc64/io.h	2004-10-23 17:37:06.968238256 +1000
@@ -1,4 +1,4 @@
-#ifndef _PPC64_IO_H
+ #ifndef _PPC64_IO_H
 #define _PPC64_IO_H
 
 /* 
@@ -436,6 +436,10 @@
 #define dma_cache_wback(_start,_size)		do { } while (0)
 #define dma_cache_wback_inv(_start,_size)	do { } while (0)
 
+/* Check of existence of legacy devices */
+extern int check_legacy_ioport(unsigned long base_port);
+
+
 #endif /* __KERNEL__ */
 
 #endif /* _PPC64_IO_H */
Index: linux-work/arch/ppc64/kernel/setup.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/setup.c	2004-10-23 13:22:19.290318560 +1000
+++ linux-work/arch/ppc64/kernel/setup.c	2004-10-23 17:09:58.131859024 +1000
@@ -1288,6 +1288,14 @@
 #endif /* CONFIG_PPC_ISERIES */
 EXPORT_SYMBOL(get_legacy_serial_ports);
 
+int check_legacy_ioport(unsigned long base_port)
+{
+	if (ppc_md.check_legacy_ioport == NULL)
+		return 0;
+	return ppc_md.check_legacy_ioport(base_port);
+}
+EXPORT_SYMBOL(check_legacy_ioport);
+
 #ifdef CONFIG_XMON
 static int __init early_xmon(char *p)
 {


