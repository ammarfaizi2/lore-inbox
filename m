Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262188AbVDMC4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbVDMC4V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 22:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbVDLTlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:41:20 -0400
Received: from fire.osdl.org ([65.172.181.4]:1225 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262184AbVDLKcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:05 -0400
Message-Id: <200504121031.j3CAVZdG005348@shell0.pdx.osdl.net>
Subject: [patch 056/198] mips: update VR41xx CPU-PCI bridge  support
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, yuasa@hh.iij4u.or.jp,
       ralf@linux-mips.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

This patch updates NEC VR4100 series CPU-PCI bridge support.

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/mips/pci/ops-vr41xx.c       |    6 +-
 25-akpm/arch/mips/pci/pci-vr41xx.c       |   88 +++++++++++++++++-------------
 25-akpm/arch/mips/pci/pci-vr41xx.h       |   69 ++++++++++++-----------
 25-akpm/include/asm-mips/vr41xx/pci.h    |   90 +++++++++++++++++++++++++++++++
 25-akpm/include/asm-mips/vr41xx/vr41xx.h |   70 ------------------------
 5 files changed, 181 insertions(+), 142 deletions(-)

diff -puN arch/mips/pci/ops-vr41xx.c~mips-update-vr41xx-cpu-pci-bridge arch/mips/pci/ops-vr41xx.c
--- 25/arch/mips/pci/ops-vr41xx.c~mips-update-vr41xx-cpu-pci-bridge	2005-04-12 03:21:16.787584800 -0700
+++ 25-akpm/arch/mips/pci/ops-vr41xx.c	2005-04-12 03:21:16.795583584 -0700
@@ -3,7 +3,7 @@
  *
  *  Copyright (C) 2001-2003 MontaVista Software Inc.
  *    Author: Yoichi Yuasa <yyuasa@mvista.com or source@mvista.com>
- *  Copyright (C) 2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2004-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -29,8 +29,8 @@
 
 #include <asm/io.h>
 
-#define PCICONFDREG	KSEG1ADDR(0x0f000c14)
-#define PCICONFAREG	KSEG1ADDR(0x0f000c18)
+#define PCICONFDREG	(void __iomem *)KSEG1ADDR(0x0f000c14)
+#define PCICONFAREG	(void __iomem *)KSEG1ADDR(0x0f000c18)
 
 static inline int set_pci_configuration_address(unsigned char number,
                                                 unsigned int devfn, int where)
diff -puN arch/mips/pci/pci-vr41xx.c~mips-update-vr41xx-cpu-pci-bridge arch/mips/pci/pci-vr41xx.c
--- 25/arch/mips/pci/pci-vr41xx.c~mips-update-vr41xx-cpu-pci-bridge	2005-04-12 03:21:16.789584496 -0700
+++ 25-akpm/arch/mips/pci/pci-vr41xx.c	2005-04-12 03:21:16.796583432 -0700
@@ -3,8 +3,8 @@
  *
  *  Copyright (C) 2001-2003 MontaVista Software Inc.
  *    Author: Yoichi Yuasa <yyuasa@mvista.com or source@mvista.com>
- *  Copyright (C) 2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
- * Copyright (C) 2004 by Ralf Baechle (ralf@linux-mips.org)
+ *  Copyright (C) 2004-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2004 by Ralf Baechle (ralf@linux-mips.org)
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -31,12 +31,18 @@
 
 #include <asm/cpu.h>
 #include <asm/io.h>
+#include <asm/vr41xx/pci.h>
 #include <asm/vr41xx/vr41xx.h>
 
 #include "pci-vr41xx.h"
 
 extern struct pci_ops vr41xx_pci_ops;
 
+static void __iomem *pciu_base;
+
+#define pciu_read(offset)		readl(pciu_base + (offset))
+#define pciu_write(offset, value)	writel((value), pciu_base + (offset))
+
 static struct pci_master_address_conversion pci_master_memory1 = {
 	.bus_base_address	= PCI_MASTER_MEM1_BUS_BASE_ADDRESS,
 	.address_mask		= PCI_MASTER_MEM1_ADDRESS_MASK,
@@ -113,6 +119,15 @@ static int __init vr41xx_pciu_init(void)
 
 	setup = &vr41xx_pci_controller_unit_setup;
 
+	if (request_mem_region(PCIU_BASE, PCIU_SIZE, "PCIU") == NULL)
+		return -EBUSY;
+
+	pciu_base = ioremap(PCIU_BASE, PCIU_SIZE);
+	if (pciu_base == NULL) {
+		release_mem_region(PCIU_BASE, PCIU_SIZE);
+		return -EBUSY;
+	}
+
 	/* Disable PCI interrupt */
 	vr41xx_disable_pciint();
 
@@ -129,14 +144,14 @@ static int __init vr41xx_pciu_init(void)
 		pci_clock_max = PCI_CLOCK_MAX;
 	vtclock = vr41xx_get_vtclock_frequency();
 	if (vtclock < pci_clock_max)
-		writel(EQUAL_VTCLOCK, PCICLKSELREG);
+		pciu_write(PCICLKSELREG, EQUAL_VTCLOCK);
 	else if ((vtclock / 2) < pci_clock_max)
-		writel(HALF_VTCLOCK, PCICLKSELREG);
+		pciu_write(PCICLKSELREG, HALF_VTCLOCK);
 	else if (current_cpu_data.processor_id >= PRID_VR4131_REV2_1 &&
 	         (vtclock / 3) < pci_clock_max)
-		writel(ONE_THIRD_VTCLOCK, PCICLKSELREG);
+		pciu_write(PCICLKSELREG, ONE_THIRD_VTCLOCK);
 	else if ((vtclock / 4) < pci_clock_max)
-		writel(QUARTER_VTCLOCK, PCICLKSELREG);
+		pciu_write(PCICLKSELREG, QUARTER_VTCLOCK);
 	else {
 		printk(KERN_ERR "PCI Clock is over 33MHz.\n");
 		return -EINVAL;
@@ -151,11 +166,11 @@ static int __init vr41xx_pciu_init(void)
 		      MASTER_MSK(master->address_mask) |
 		      WINEN |
 		      PCIA(master->pci_base_address);
-		writel(val, PCIMMAW1REG);
+		pciu_write(PCIMMAW1REG, val);
 	} else {
-		val = readl(PCIMMAW1REG);
+		val = pciu_read(PCIMMAW1REG);
 		val &= ~WINEN;
-		writel(val, PCIMMAW1REG);
+		pciu_write(PCIMMAW1REG, val);
 	}
 
 	if (setup->master_memory2 != NULL) {
@@ -164,11 +179,11 @@ static int __init vr41xx_pciu_init(void)
 		      MASTER_MSK(master->address_mask) |
 		      WINEN |
 		      PCIA(master->pci_base_address);
-		writel(val, PCIMMAW2REG);
+		pciu_write(PCIMMAW2REG, val);
 	} else {
-		val = readl(PCIMMAW2REG);
+		val = pciu_read(PCIMMAW2REG);
 		val &= ~WINEN;
-		writel(val, PCIMMAW2REG);
+		pciu_write(PCIMMAW2REG, val);
 	}
 
 	if (setup->target_memory1 != NULL) {
@@ -176,11 +191,11 @@ static int __init vr41xx_pciu_init(void)
 		val = TARGET_MSK(target->address_mask) |
 		      WINEN |
 		      ITA(target->bus_base_address);
-		writel(val, PCITAW1REG);
+		pciu_write(PCITAW1REG, val);
 	} else {
-		val = readl(PCITAW1REG);
+		val = pciu_read(PCITAW1REG);
 		val &= ~WINEN;
-		writel(val, PCITAW1REG);
+		pciu_write(PCITAW1REG, val);
 	}
 
 	if (setup->target_memory2 != NULL) {
@@ -188,11 +203,11 @@ static int __init vr41xx_pciu_init(void)
 		val = TARGET_MSK(target->address_mask) |
 		      WINEN |
 		      ITA(target->bus_base_address);
-		writel(val, PCITAW2REG);
+		pciu_write(PCITAW2REG, val);
 	} else {
-		val = readl(PCITAW2REG);
+		val = pciu_read(PCITAW2REG);
 		val &= ~WINEN;
-		writel(val, PCITAW2REG);
+		pciu_write(PCITAW2REG, val);
 	}
 
 	if (setup->master_io != NULL) {
@@ -201,50 +216,50 @@ static int __init vr41xx_pciu_init(void)
 		      MASTER_MSK(master->address_mask) |
 		      WINEN |
 		      PCIIA(master->pci_base_address);
-		writel(val, PCIMIOAWREG);
+		pciu_write(PCIMIOAWREG, val);
 	} else {
-		val = readl(PCIMIOAWREG);
+		val = pciu_read(PCIMIOAWREG);
 		val &= ~WINEN;
-		writel(val, PCIMIOAWREG);
+		pciu_write(PCIMIOAWREG, val);
 	}
 
 	if (setup->exclusive_access == CANNOT_LOCK_FROM_DEVICE)
-		writel(UNLOCK, PCIEXACCREG);
+		pciu_write(PCIEXACCREG, UNLOCK);
 	else
-		writel(0, PCIEXACCREG);
+		pciu_write(PCIEXACCREG, 0);
 
 	if (current_cpu_data.cputype == CPU_VR4122)
-		writel(TRDYV(setup->wait_time_limit_from_irdy_to_trdy), PCITRDYVREG);
+		pciu_write(PCITRDYVREG, TRDYV(setup->wait_time_limit_from_irdy_to_trdy));
 
-	writel(MLTIM(setup->master_latency_timer), LATTIMEREG);
+	pciu_write(LATTIMEREG, MLTIM(setup->master_latency_timer));
 
 	if (setup->mailbox != NULL) {
 		mailbox = setup->mailbox;
 		val = MBADD(mailbox->base_address) | TYPE_32BITSPACE |
 		      MSI_MEMORY | PREF_APPROVAL;
-		writel(val, MAILBAREG);
+		pciu_write(MAILBAREG, val);
 	}
 
 	if (setup->target_window1) {
 		window = setup->target_window1;
 		val = PMBA(window->base_address) | TYPE_32BITSPACE |
 		      MSI_MEMORY | PREF_APPROVAL;
-		writel(val, PCIMBA1REG);
+		pciu_write(PCIMBA1REG, val);
 	}
 
 	if (setup->target_window2) {
 		window = setup->target_window2;
 		val = PMBA(window->base_address) | TYPE_32BITSPACE |
 		      MSI_MEMORY | PREF_APPROVAL;
-		writel(val, PCIMBA2REG);
+		pciu_write(PCIMBA2REG, val);
 	}
 
-	val = readl(RETVALREG);
+	val = pciu_read(RETVALREG);
 	val &= ~RTYVAL_MASK;
 	val |= RTYVAL(setup->retry_limit);
-	writel(val, RETVALREG);
+	pciu_write(RETVALREG, val);
 
-	val = readl(PCIAPCNTREG);
+	val = pciu_read(PCIAPCNTREG);
 	val &= ~(TKYGNT | PAPC);
 
 	switch (setup->arbiter_priority_control) {
@@ -262,15 +277,16 @@ static int __init vr41xx_pciu_init(void)
 	if (setup->take_away_gnt_mode == PCI_TAKE_AWAY_GNT_ENABLE)
 		val |= TKYGNT_ENABLE;
 
-	writel(val, PCIAPCNTREG);
+	pciu_write(PCIAPCNTREG, val);
 
-	writel(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
-	       PCI_COMMAND_PARITY | PCI_COMMAND_SERR, COMMANDREG);
+	pciu_write(COMMANDREG, PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
+	                       PCI_COMMAND_MASTER | PCI_COMMAND_PARITY |
+			       PCI_COMMAND_SERR);
 
 	/* Clear bus error */
-	readl(BUSERRADREG);
+	pciu_read(BUSERRADREG);
 
-	writel(BLOODY_CONFIG_DONE, PCIENREG);
+	pciu_write(PCIENREG, PCIU_CONFIG_DONE);
 
 	if (setup->mem_resource != NULL)
 		vr41xx_pci_controller.mem_resource = setup->mem_resource;
diff -puN arch/mips/pci/pci-vr41xx.h~mips-update-vr41xx-cpu-pci-bridge arch/mips/pci/pci-vr41xx.h
--- 25/arch/mips/pci/pci-vr41xx.h~mips-update-vr41xx-cpu-pci-bridge	2005-04-12 03:21:16.790584344 -0700
+++ 25-akpm/arch/mips/pci/pci-vr41xx.h	2005-04-12 03:21:16.797583280 -0700
@@ -3,7 +3,7 @@
  *
  *  Copyright (C) 2002  MontaVista Software Inc.
  *    Author: Yoichi Yuasa <yyuasa@mvista.com or source@mvista.com>
- *  Copyright (C) 2004  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *  Copyright (C) 2004-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -22,11 +22,14 @@
 #ifndef __PCI_VR41XX_H
 #define __PCI_VR41XX_H
 
-#define PCIMMAW1REG		KSEG1ADDR(0x0f000c00)
-#define PCIMMAW2REG		KSEG1ADDR(0x0f000c04)
-#define PCITAW1REG		KSEG1ADDR(0x0f000c08)
-#define PCITAW2REG		KSEG1ADDR(0x0f000c0c)
-#define PCIMIOAWREG		KSEG1ADDR(0x0f000c10)
+#define PCIU_BASE		0x0f000c00UL
+#define PCIU_SIZE		0x200UL
+
+#define PCIMMAW1REG		0x00
+#define PCIMMAW2REG		0x04
+#define PCITAW1REG		0x08
+#define PCITAW2REG		0x0c
+#define PCIMIOAWREG		0x10
  #define IBA(addr)		((addr) & 0xff000000U)
  #define MASTER_MSK(mask)	(((mask) >> 11) & 0x000fe000U)
  #define PCIA(addr)		(((addr) >> 24) & 0x000000ffU)
@@ -34,13 +37,13 @@
  #define ITA(addr)		(((addr) >> 24) & 0x000000ffU)
  #define PCIIA(addr)		(((addr) >> 24) & 0x000000ffU)
  #define WINEN			0x1000U
-#define PCICONFDREG		KSEG1ADDR(0x0f000c14)
-#define PCICONFAREG		KSEG1ADDR(0x0f000c18)
-#define PCIMAILREG		KSEG1ADDR(0x0f000c1c)
-#define BUSERRADREG		KSEG1ADDR(0x0f000c24)
+#define PCICONFDREG		0x14
+#define PCICONFAREG		0x18
+#define PCIMAILREG		0x1c
+#define BUSERRADREG		0x24
  #define EA(reg)		((reg) &0xfffffffc)
 
-#define INTCNTSTAREG		KSEG1ADDR(0x0f000c28)
+#define INTCNTSTAREG		0x28
  #define MABTCLR		0x80000000U
  #define TRDYCLR		0x40000000U
  #define PARCLR			0x20000000U
@@ -67,34 +70,34 @@
  #define MABORT			0x00000002U
  #define TABORT			0x00000001U
 
-#define PCIEXACCREG		KSEG1ADDR(0x0f000c2c)
+#define PCIEXACCREG		0x2c
  #define UNLOCK			0x2U
  #define EAREQ			0x1U
-#define PCIRECONTREG		KSEG1ADDR(0x0f000c30)
+#define PCIRECONTREG		0x30
  #define RTRYCNT(reg)		((reg) & 0x000000ffU)
-#define PCIENREG		KSEG1ADDR(0x0f000c34)
- #define BLOODY_CONFIG_DONE	0x4U
-#define PCICLKSELREG		KSEG1ADDR(0x0f000c38)
+#define PCIENREG		0x34
+ #define PCIU_CONFIG_DONE	0x4U
+#define PCICLKSELREG		0x38
  #define EQUAL_VTCLOCK		0x2U
  #define HALF_VTCLOCK		0x0U
  #define ONE_THIRD_VTCLOCK	0x3U
  #define QUARTER_VTCLOCK	0x1U
-#define PCITRDYVREG		KSEG1ADDR(0x0f000c3c)
+#define PCITRDYVREG		0x3c
  #define TRDYV(val)		((uint32_t)(val) & 0xffU)
-#define PCICLKRUNREG		KSEG1ADDR(0x0f000c60)
+#define PCICLKRUNREG		0x60
 
-#define VENDORIDREG		KSEG1ADDR(0x0f000d00)
-#define DEVICEIDREG		KSEG1ADDR(0x0f000d00)
-#define COMMANDREG		KSEG1ADDR(0x0f000d04)
-#define STATUSREG		KSEG1ADDR(0x0f000d04)
-#define REVIDREG		KSEG1ADDR(0x0f000d08)
-#define CLASSREG		KSEG1ADDR(0x0f000d08)
-#define CACHELSREG		KSEG1ADDR(0x0f000d0c)
-#define LATTIMEREG		KSEG1ADDR(0x0f000d0c)
+#define VENDORIDREG		0x100
+#define DEVICEIDREG		0x100
+#define COMMANDREG		0x104
+#define STATUSREG		0x104
+#define REVIDREG		0x108
+#define CLASSREG		0x108
+#define CACHELSREG		0x10c
+#define LATTIMEREG		0x10c
  #define MLTIM(val)		(((uint32_t)(val) << 7) & 0xff00U)
-#define MAILBAREG		KSEG1ADDR(0x0f000d10)
-#define PCIMBA1REG		KSEG1ADDR(0x0f000d14)
-#define PCIMBA2REG		KSEG1ADDR(0x0f000d18)
+#define MAILBAREG		0x110
+#define PCIMBA1REG		0x114
+#define PCIMBA2REG		0x118
  #define MBADD(base)		((base) & 0xfffff800U)
  #define PMBA(base)		((base) & 0xffe00000U)
  #define PREF			0x8U
@@ -104,10 +107,10 @@
  #define TYPE_32BITSPACE	0x0U
  #define MSI			0x1U
  #define MSI_MEMORY		0x0U
-#define INTLINEREG		KSEG1ADDR(0x0f000d3c)
-#define INTPINREG		KSEG1ADDR(0x0f000d3c)
-#define RETVALREG		KSEG1ADDR(0x0f000d40)
-#define PCIAPCNTREG		KSEG1ADDR(0x0f000d40)
+#define INTLINEREG		0x13c
+#define INTPINREG		0x13c
+#define RETVALREG		0x140
+#define PCIAPCNTREG		0x140
  #define TKYGNT			0x04000000U
  #define TKYGNT_ENABLE		0x04000000U
  #define TKYGNT_DISABLE		0x00000000U
diff -puN /dev/null include/asm-mips/vr41xx/pci.h
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ 25-akpm/include/asm-mips/vr41xx/pci.h	2005-04-12 03:21:16.798583128 -0700
@@ -0,0 +1,90 @@
+/*
+ *  Include file for NEC VR4100 series PCI Control Unit.
+ *
+ *  Copyright (C) 2004-2005  Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#ifndef __NEC_VR41XX_PCI_H
+#define __NEC_VR41XX_PCI_H
+
+#define PCI_MASTER_ADDRESS_MASK	0x7fffffffU
+
+struct pci_master_address_conversion {
+	uint32_t bus_base_address;
+	uint32_t address_mask;
+	uint32_t pci_base_address;
+};
+
+struct pci_target_address_conversion {
+	uint32_t address_mask;
+	uint32_t bus_base_address;
+};
+
+typedef enum {
+	CANNOT_LOCK_FROM_DEVICE,
+	CAN_LOCK_FROM_DEVICE,
+} pci_exclusive_access_t;
+
+struct pci_mailbox_address {
+	uint32_t base_address;
+};
+
+struct pci_target_address_window {
+	uint32_t base_address;
+};
+
+typedef enum {
+	PCI_ARBITRATION_MODE_FAIR,
+	PCI_ARBITRATION_MODE_ALTERNATE_0,
+	PCI_ARBITRATION_MODE_ALTERNATE_B,
+} pci_arbiter_priority_control_t;
+
+typedef enum {
+	PCI_TAKE_AWAY_GNT_DISABLE,
+	PCI_TAKE_AWAY_GNT_ENABLE,
+} pci_take_away_gnt_mode_t;
+
+struct pci_controller_unit_setup {
+	struct pci_master_address_conversion *master_memory1;
+	struct pci_master_address_conversion *master_memory2;
+
+	struct pci_target_address_conversion *target_memory1;
+	struct pci_target_address_conversion *target_memory2;
+
+	struct pci_master_address_conversion *master_io;
+
+	pci_exclusive_access_t exclusive_access;
+
+	uint32_t pci_clock_max;
+	uint8_t wait_time_limit_from_irdy_to_trdy;	/* Only VR4122 is supported */
+
+	struct pci_mailbox_address *mailbox;
+	struct pci_target_address_window *target_window1;
+	struct pci_target_address_window *target_window2;
+
+	uint8_t master_latency_timer;
+	uint8_t retry_limit;
+
+	pci_arbiter_priority_control_t arbiter_priority_control;
+	pci_take_away_gnt_mode_t take_away_gnt_mode;
+
+	struct resource *mem_resource;
+	struct resource *io_resource;
+};
+
+extern void vr41xx_pciu_setup(struct pci_controller_unit_setup *setup);
+
+#endif /* __NEC_VR41XX_PCI_H */
diff -puN include/asm-mips/vr41xx/vr41xx.h~mips-update-vr41xx-cpu-pci-bridge include/asm-mips/vr41xx/vr41xx.h
--- 25/include/asm-mips/vr41xx/vr41xx.h~mips-update-vr41xx-cpu-pci-bridge	2005-04-12 03:21:16.792584040 -0700
+++ 25-akpm/include/asm-mips/vr41xx/vr41xx.h	2005-04-12 03:21:16.798583128 -0700
@@ -231,74 +231,4 @@ enum {
 	DATA_HIGH
 };
 
-/*
- * PCI Control Unit
- */
-#define PCI_MASTER_ADDRESS_MASK	0x7fffffffU
-
-struct pci_master_address_conversion {
-	uint32_t bus_base_address;
-	uint32_t address_mask;
-	uint32_t pci_base_address;
-};
-
-struct pci_target_address_conversion {
-	uint32_t address_mask;
-	uint32_t bus_base_address;
-};
-
-typedef enum {
-	CANNOT_LOCK_FROM_DEVICE,
-	CAN_LOCK_FROM_DEVICE,
-} pci_exclusive_access_t;
-
-struct pci_mailbox_address {
-	uint32_t base_address;
-};
-
-struct pci_target_address_window {
-	uint32_t base_address;
-};
-
-typedef enum {
-	PCI_ARBITRATION_MODE_FAIR,
-	PCI_ARBITRATION_MODE_ALTERNATE_0,
-	PCI_ARBITRATION_MODE_ALTERNATE_B,
-} pci_arbiter_priority_control_t;
-
-typedef enum {
-	PCI_TAKE_AWAY_GNT_DISABLE,
-	PCI_TAKE_AWAY_GNT_ENABLE,
-} pci_take_away_gnt_mode_t;
-
-struct pci_controller_unit_setup {
-	struct pci_master_address_conversion *master_memory1;
-	struct pci_master_address_conversion *master_memory2;
-
-	struct pci_target_address_conversion *target_memory1;
-	struct pci_target_address_conversion *target_memory2;
-
-	struct pci_master_address_conversion *master_io;
-
-	pci_exclusive_access_t exclusive_access;
-
-	uint32_t pci_clock_max;
-	uint8_t wait_time_limit_from_irdy_to_trdy;	/* Only VR4122 is supported */
-
-	struct pci_mailbox_address *mailbox;
-	struct pci_target_address_window *target_window1;
-	struct pci_target_address_window *target_window2;
-
-	uint8_t master_latency_timer;
-	uint8_t retry_limit;
-
-	pci_arbiter_priority_control_t arbiter_priority_control;
-	pci_take_away_gnt_mode_t take_away_gnt_mode;
-
-	struct resource *mem_resource;
-	struct resource *io_resource;
-};
-
-extern void vr41xx_pciu_setup(struct pci_controller_unit_setup *setup);
-
 #endif /* __NEC_VR41XX_H */
_
