Return-Path: <linux-kernel-owner+w=401wt.eu-S1754614AbWLTMBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754614AbWLTMBt (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 07:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754805AbWLTMBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 07:01:49 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:1550 "EHLO
	pollux.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614AbWLTMBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 07:01:40 -0500
Date: Wed, 20 Dec 2006 12:01:36 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>, Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.20-rc1 02/10] TURBOchannel support for the DECstation
Message-ID: <Pine.LNX.4.64N.0612191854590.20895@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 This is the platform-specific part of TURBOchannel bus support for the 
DECstation.  It implements determining whether the bus is actually there, 
getting bus parameters, IRQ assignments for devices and protected accesses 
to possibly unoccupied slots that may trigger bus error exceptions.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---

 Please apply.

  Maciej

patch-mips-2.6.18-20060920-tc-dec-1
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/arch/mips/dec/Makefile linux-mips-2.6.18-20060920/arch/mips/dec/Makefile
--- linux-mips-2.6.18-20060920.macro/arch/mips/dec/Makefile	2005-07-20 04:56:55.000000000 +0000
+++ linux-mips-2.6.18-20060920/arch/mips/dec/Makefile	2006-12-01 01:50:37.000000000 +0000
@@ -6,6 +6,7 @@ obj-y		:= ecc-berr.o int-handler.o ioasi
 		   kn02-irq.o kn02xa-berr.o reset.o setup.o time.o
 
 obj-$(CONFIG_PROM_CONSOLE)	+= promcon.o
+obj-$(CONFIG_TC)		+= tc.o
 obj-$(CONFIG_CPU_HAS_WB)	+= wbflush.o
 
 EXTRA_AFLAGS := $(CFLAGS)
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/arch/mips/dec/prom/identify.c linux-mips-2.6.18-20060920/arch/mips/dec/prom/identify.c
--- linux-mips-2.6.18-20060920.macro/arch/mips/dec/prom/identify.c	2005-07-20 04:56:55.000000000 +0000
+++ linux-mips-2.6.18-20060920/arch/mips/dec/prom/identify.c	2006-12-19 22:06:13.000000000 +0000
@@ -88,6 +88,7 @@ static inline void prom_init_kn02(void)
 {
 	dec_kn_slot_base = KN02_SLOT_BASE;
 	dec_kn_slot_size = KN02_SLOT_SIZE;
+	dec_tc_bus = 1;
 
 	dec_rtc_base = (void *)CKSEG1ADDR(dec_kn_slot_base + KN02_RTC);
 }
@@ -96,6 +97,7 @@ static inline void prom_init_kn02xa(void
 {
 	dec_kn_slot_base = KN02XA_SLOT_BASE;
 	dec_kn_slot_size = IOASIC_SLOT_SIZE;
+	dec_tc_bus = 1;
 
 	ioasic_base = (void *)CKSEG1ADDR(dec_kn_slot_base + IOASIC_IOCTL);
 	dec_rtc_base = (void *)CKSEG1ADDR(dec_kn_slot_base + IOASIC_TOY);
@@ -105,6 +107,7 @@ static inline void prom_init_kn03(void)
 {
 	dec_kn_slot_base = KN03_SLOT_BASE;
 	dec_kn_slot_size = IOASIC_SLOT_SIZE;
+	dec_tc_bus = 1;
 
 	ioasic_base = (void *)CKSEG1ADDR(dec_kn_slot_base + IOASIC_IOCTL);
 	dec_rtc_base = (void *)CKSEG1ADDR(dec_kn_slot_base + IOASIC_TOY);
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/arch/mips/dec/setup.c linux-mips-2.6.18-20060920/arch/mips/dec/setup.c
--- linux-mips-2.6.18-20060920.macro/arch/mips/dec/setup.c	2006-07-10 04:59:17.000000000 +0000
+++ linux-mips-2.6.18-20060920/arch/mips/dec/setup.c	2006-12-19 22:01:33.000000000 +0000
@@ -53,6 +53,8 @@ unsigned long dec_kn_slot_base, dec_kn_s
 EXPORT_SYMBOL(dec_kn_slot_base);
 EXPORT_SYMBOL(dec_kn_slot_size);
 
+int dec_tc_bus;
+
 spinlock_t ioasic_ssr_lock;
 
 volatile u32 *ioasic_base;
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/arch/mips/dec/tc.c linux-mips-2.6.18-20060920/arch/mips/dec/tc.c
--- linux-mips-2.6.18-20060920.macro/arch/mips/dec/tc.c	1970-01-01 00:00:00.000000000 +0000
+++ linux-mips-2.6.18-20060920/arch/mips/dec/tc.c	2006-12-19 22:10:23.000000000 +0000
@@ -0,0 +1,95 @@
+/*
+ *	TURBOchannel architecture calls.
+ *
+ *	Copyright (c) Harald Koerfgen, 1998
+ *	Copyright (c) 2001, 2003, 2005, 2006  Maciej W. Rozycki
+ *	Copyright (c) 2005  James Simmons
+ *
+ *	This file is subject to the terms and conditions of the GNU
+ *	General Public License.  See the file "COPYING" in the main
+ *	directory of this archive for more details.
+ */
+#include <linux/compiler.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/tc.h>
+#include <linux/types.h>
+
+#include <asm/addrspace.h>
+#include <asm/bootinfo.h>
+#include <asm/paccess.h>
+
+#include <asm/dec/interrupts.h>
+#include <asm/dec/prom.h>
+#include <asm/dec/system.h>
+
+/*
+ * Protected read byte from TURBOchannel slot space.
+ */
+int tc_preadb(u8 *valp, void __iomem *addr)
+{
+	return get_dbe(*valp, (u8 *)addr);
+}
+
+/*
+ * Get TURBOchannel bus information as specified by the spec, plus
+ * the slot space base address and the number of slots.
+ */
+int __init tc_bus_get_info(struct tc_bus *tbus)
+{
+	if (!dec_tc_bus)
+		return -ENXIO;
+
+	memcpy(&tbus->info, rex_gettcinfo(), sizeof(tbus->info));
+	tbus->slot_base = CPHYSADDR((long)rex_slot_address(0));
+
+	switch (mips_machtype) {
+	case MACH_DS5000_200:
+		tbus->num_tcslots = 7;
+		break;
+	case MACH_DS5000_2X0:
+	case MACH_DS5900:
+		tbus->ext_slot_base = 0x20000000;
+		tbus->ext_slot_size = 0x20000000;
+		/* fall through */
+	case MACH_DS5000_1XX:
+		tbus->num_tcslots = 3;
+		break;
+	case MACH_DS5000_XX:
+		tbus->num_tcslots = 2;
+	default:
+		break;
+	}
+	return 0;
+}
+
+/*
+ * Get the IRQ for the specified slot.
+ */
+void __init tc_device_get_irq(struct tc_dev *tdev)
+{
+	switch (tdev->slot) {
+	case 0:
+		tdev->interrupt = dec_interrupt[DEC_IRQ_TC0];
+		break;
+	case 1:
+		tdev->interrupt = dec_interrupt[DEC_IRQ_TC1];
+		break;
+	case 2:
+		tdev->interrupt = dec_interrupt[DEC_IRQ_TC2];
+		break;
+	/*
+	 * Yuck! DS5000/200 onboard devices
+	 */
+	case 5:
+		tdev->interrupt = dec_interrupt[DEC_IRQ_TC5];
+		break;
+	case 6:
+		tdev->interrupt = dec_interrupt[DEC_IRQ_TC6];
+		break;
+	default:
+		tdev->interrupt = -1;
+		break;
+	}
+}
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/include/asm-mips/dec/system.h linux-mips-2.6.18-20060920/include/asm-mips/dec/system.h
--- linux-mips-2.6.18-20060920.macro/include/asm-mips/dec/system.h	2005-09-13 04:56:38.000000000 +0000
+++ linux-mips-2.6.18-20060920/include/asm-mips/dec/system.h	2006-12-19 22:01:13.000000000 +0000
@@ -3,7 +3,7 @@
  *
  *	Generic DECstation/DECsystem bits.
  *
- *	Copyright (C) 2005  Maciej W. Rozycki
+ *	Copyright (C) 2005, 2006  Maciej W. Rozycki
  *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License
@@ -14,5 +14,6 @@
 #define __ASM_DEC_SYSTEM_H
 
 extern unsigned long dec_kn_slot_base, dec_kn_slot_size;
+extern int dec_tc_bus;
 
 #endif /* __ASM_DEC_SYSTEM_H */
