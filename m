Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbVHRRwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbVHRRwK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 13:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbVHRRwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 13:52:09 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:8091 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932355AbVHRRwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 13:52:07 -0400
Message-Id: <200508181752.j7IHq2Qr001692@d03av02.boulder.ibm.com>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Subject: [PATCH 4/4] ppc64: small hacks for running on BPA hardware
Date: Thu, 18 Aug 2005 19:42:13 +0200
User-Agent: KMail/1.7.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
References: <200508181931.43481.arnd@arndb.de>
In-Reply-To: <200508181931.43481.arnd@arndb.de>
X-KMail-CryptoFormat: 15
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is not meant for inclusion in a generic kernel,
but is currently needed to support the available HW.
Most of the things done in here are workarounds for
deficiencies in the present hardware or firmware that
will be solved there in later releases.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

--- linux-cg.orig/arch/ppc64/Kconfig	2005-08-18 17:23:29.789907568 -0400
+++ linux-cg/arch/ppc64/Kconfig	2005-08-18 17:23:52.529911976 -0400
@@ -221,6 +221,12 @@ config SMP
 
 	  If you don't know what to do here, say Y.
 
+config BE_DD2
+	bool "BE DD2.x Errata Workaround Support"
+	depends on PPC_BPA
+	---help---
+	This support enables BE DD2.x errata workarounds.
+
 config NR_CPUS
 	int "Maximum number of CPUs (2-128)"
 	range 2 128
--- linux-cg.orig/arch/ppc64/kernel/Makefile	2005-08-18 17:22:05.500940704 -0400
+++ linux-cg/arch/ppc64/kernel/Makefile	2005-08-18 17:23:52.668890848 -0400
@@ -33,7 +33,7 @@ obj-$(CONFIG_PPC_PSERIES) += pSeries_pci
 			     pSeries_nvram.o rtasd.o ras.o pSeries_reconfig.o \
 			     pSeries_setup.o pSeries_iommu.o
 
-obj-$(CONFIG_PPC_BPA) += bpa_setup.o bpa_iommu.o bpa_nvram.o \
+obj-$(CONFIG_PPC_BPA) += bpa_setup.o bpa_iommu.o bpa_nvram.o bpa_pci.o \
 			 bpa_iic.o spider-pic.o
 
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o
--- linux-cg.orig/arch/ppc64/kernel/bpa_iommu.c	2005-08-18 17:23:29.778909240 -0400
+++ linux-cg/arch/ppc64/kernel/bpa_iommu.c	2005-08-18 17:23:52.472920640 -0400
@@ -245,8 +245,6 @@ set_iocmd_config(void __iomem *base)
 }
 
 /* FIXME: get these from the device tree */
-#define ioc_base	0x20000511000ull
-#define ioc_mmio_base	0x20000510000ull
 #define ioid		0x48a
 #define iopt_phys_offset (- 0x20000000) /* We have a 512MB offset from the SB */
 #define io_page_size	0x1000000
@@ -278,12 +276,22 @@ static void bpa_map_iommu(void)
 	void __iomem *base;
 	ioste ioste;
 	unsigned long index;
-
+	struct device_node *node;
+	unsigned long *handle, ioc_mmio_base, ioc_base;
+	int nodelen;
+
+	for(node = of_find_node_by_type(NULL, "cpu");
+	    node;
+	    node = of_find_node_by_type(node, "cpu")) {
+		handle = (unsigned long *) get_property(node, "ioc-translation", &nodelen); 
+		ioc_base = *handle + 0x1000;
+				
 	base = __ioremap(ioc_base, 0x1000, _PAGE_NO_CACHE);
 	pr_debug("%lx mapped to %p\n", ioc_base, base);
 	set_iocmd_config(base);
 	iounmap(base);
 
+		ioc_mmio_base = *handle;
 	base = __ioremap(ioc_mmio_base, 0x1000, _PAGE_NO_CACHE);
 	pr_debug("%lx mapped to %p\n", ioc_mmio_base, base);
 
@@ -302,6 +310,7 @@ static void bpa_map_iommu(void)
 			map_iopt_entry(address));
 	}
 	iounmap(base);
+	}
 }
 
 
--- linux-cg.orig/arch/ppc64/kernel/bpa_pci.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-cg/arch/ppc64/kernel/bpa_pci.c	2005-08-18 17:28:39.211996792 -0400
@@ -0,0 +1,83 @@
+/*
+ * BPA specific PCI code
+ *
+ * Copyright (C) 2005 IBM Corporation,
+ 			Arnd Bergmann <arndb@de.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+
+#include <asm/prom.h>
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+
+#include "pci.h"
+#include "bpa_iic.h"
+
+void __init bpa_final_fixup(void)
+{
+	struct pci_dev *dev = NULL;
+
+	phbs_remap_io();
+
+	for_each_pci_dev(dev) {
+	// FIXME: fix IRQ numbers for devices on second south bridge
+	}
+}
+
+static void fixup_spider_ipci_irq(struct pci_dev* dev)
+{
+	int irq_node_offset;
+	pr_debug("fixup for %04x:%04x at %02x.%1x: ", dev->vendor, dev->device,
+			 PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+	switch (dev->devfn) {
+		case PCI_DEVFN(3,0):
+			/* ethernet */
+			dev->irq = 8;
+			break;
+		case PCI_DEVFN(5,0):
+			/* OHCI 0 */
+			dev->irq = 10;
+			break;
+		case PCI_DEVFN(6,0):
+			/* OHCI 1 */
+			dev->irq = 11;
+			break;
+		case PCI_DEVFN(5,1):
+			/* EHCI 0 */
+			dev->irq = 10;
+			break;
+		case PCI_DEVFN(6,1):
+			/* EHCI 1 */
+			dev->irq = 11;
+			break;
+	}
+
+	irq_node_offset = IIC_NODE_STRIDE * (pci_domain_nr(dev->bus)-1);
+	dev->irq += irq_node_offset;
+
+	pr_debug("irq %0x\n", dev->irq);
+}
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TOSHIBA_2,
+		PCI_DEVICE_ID_TOSHIBA_SPIDER_NET, fixup_spider_ipci_irq);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TOSHIBA_2,
+		PCI_DEVICE_ID_TOSHIBA_SPIDER_OHCI, fixup_spider_ipci_irq);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TOSHIBA_2,
+		PCI_DEVICE_ID_TOSHIBA_SPIDER_EHCI, fixup_spider_ipci_irq);
--- linux-cg.orig/arch/ppc64/kernel/bpa_setup.c	2005-08-18 17:22:05.507939640 -0400
+++ linux-cg/arch/ppc64/kernel/bpa_setup.c	2005-08-18 17:23:52.669890696 -0400
@@ -54,6 +54,8 @@
 #define DBG(fmt...)
 #endif
 
+extern void bpa_final_fixup(void);
+
 void bpa_get_cpuinfo(struct seq_file *m)
 {
 	struct device_node *root;
@@ -129,6 +131,7 @@ struct machdep_calls __initdata bpa_md =
 	.setup_arch		= bpa_setup_arch,
 	.init_early		= bpa_init_early,
 	.get_cpuinfo		= bpa_get_cpuinfo,
+	.pcibios_fixup		= bpa_final_fixup,
 	.restart		= rtas_restart,
 	.power_off		= rtas_power_off,
 	.halt			= rtas_halt,
--- linux-cg.orig/arch/ppc64/kernel/head.S	2005-08-18 17:23:29.782908632 -0400
+++ linux-cg/arch/ppc64/kernel/head.S	2005-08-18 17:23:52.626897232 -0400
@@ -312,6 +312,38 @@ label##_pSeries:					\
 	RUNLATCH_ON(r13);				\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common)
 
+#define WORKAROUND_EXCEPTION_PSERIES(n, label)			\
+	. = n;						\
+	.globl label##_pSeries;				\
+label##_pSeries:					\
+	mtspr	SPRG1,r21;		/* save r21 */	\
+        mfspr   r21, SPRN_CTRLF;			\
+        oris    r21, r21, 0x00C0;			\
+        mtspr   SPRN_CTRLT, r21;			\
+	mfspr	r21,SPRG1;		/* restore r21 */	\
+	mtspr	SPRG1,r13;		/* save r13 */	\
+	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common)
+
+#define RES_EXCEPTION_PSERIES(n, label)			\
+	. = n;						\
+	.globl label##_pSeries;				\
+label##_pSeries:					\
+        mtspr   SPRG2,r20;              /* use SPRG2 as scratch reg */ \
+        mtspr   SPRG1,r21;              /* use SPRG1 as scratch reg */ \
+        mfspr   r20,SPRG3;              /* get paca virtual address */ \
+        cmpdi   r20,0x0;                /* if SPRG3 zero,thread  */    \
+	bne     20f;			/* shouldn't run */ \
+18:					/* Stop current Thread */ \
+	andi.	 r21,0,0;					 \
+	mtspr    SPRN_CTRLT,r21;					 \
+19:								\
+	b	 19b;		 	/* Thread should be stopped */	 \
+20:							\
+	HMT_MEDIUM;					\
+	mtspr	SPRG1,r13;		/* save r13 */	\
+	RUNLATCH_ON(r13);				\
+	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common)
+
 #define STD_EXCEPTION_ISERIES(n, label, area)		\
 	.globl label##_iSeries;				\
 label##_iSeries:					\
@@ -391,7 +423,11 @@ label##_common:						\
 	.globl __start_interrupts
 __start_interrupts:
 
+#ifdef CONFIG_BE_DD2
+	RES_EXCEPTION_PSERIES(0x100, system_reset)
+#else
 	STD_EXCEPTION_PSERIES(0x100, system_reset)
+#endif
 
 	. = 0x200
 _machine_check_pSeries:
@@ -459,11 +495,15 @@ instruction_access_slb_pSeries:
 	mfspr	r3,SRR0			/* SRR0 is faulting address */
 	b	.do_slb_miss		/* Rel. branch works in real mode */
 
-	STD_EXCEPTION_PSERIES(0x500, hardware_interrupt)
+#ifdef CONFIG_BE_DD2
+	WORKAROUND_EXCEPTION_PSERIES(0x500, hardware_interrupt)
+#endif
 	STD_EXCEPTION_PSERIES(0x600, alignment)
 	STD_EXCEPTION_PSERIES(0x700, program_check)
 	STD_EXCEPTION_PSERIES(0x800, fp_unavailable)
-	STD_EXCEPTION_PSERIES(0x900, decrementer)
+#ifdef CONFIG_BE_DD2
+	WORKAROUND_EXCEPTION_PSERIES(0x900, decrementer)
+#endif
 	STD_EXCEPTION_PSERIES(0xa00, trap_0a)
 	STD_EXCEPTION_PSERIES(0xb00, trap_0b)
 
--- linux-cg.orig/arch/ppc64/kernel/prom_init.c	2005-08-18 17:23:29.787907872 -0400
+++ linux-cg/arch/ppc64/kernel/prom_init.c	2005-08-18 17:23:52.776874432 -0400
@@ -1365,6 +1365,8 @@ static int __init prom_find_machine_type
 				return PLATFORM_POWERMAC;
 			if (strstr(p, RELOC("Momentum,Maple")))
 				return PLATFORM_MAPLE;
+			if (strstr(p, RELOC("IBM,CPB")))
+				return PLATFORM_BPA;
 			i += sl + 1;
 		}
 	}
--- linux-cg.orig/arch/ppc64/kernel/spider-pic.c	2005-08-18 17:23:29.780908936 -0400
+++ linux-cg/arch/ppc64/kernel/spider-pic.c	2005-08-18 17:23:52.473920488 -0400
@@ -84,10 +84,11 @@ static void __iomem *spider_get_irq_conf
 
 static void spider_enable_irq(unsigned int irq)
 {
+	int nodeid = (irq / IIC_NODE_STRIDE) * 0x10;
 	void __iomem *cfg = spider_get_irq_config(irq);
 	irq = spider_get_nr(irq);
 
-	out_be32(cfg, in_be32(cfg) | 0x3107000eu);
+	out_be32(cfg, in_be32(cfg) | 0x3107000eu | nodeid);
 	out_be32(cfg + 4, in_be32(cfg + 4) | 0x00020000u | irq);
 }
 
@@ -150,13 +151,17 @@ int spider_get_irq(unsigned long int_pen
 void spider_init_IRQ(void)
 {
 	int node;
+#if 0
 	struct device_node *dn;
 	unsigned int *property;
+#endif
 	long spiderpic;
+	long pics[] = { 0x24000008000, 0x34000008000 };
 	int n;
 
 /* FIXME: detect multiple PICs as soon as the device tree has them */
-	for (node = 0; node < 1; node++) {
+	for (node = 0; node <= 1; node++) {
+#if 0
 		dn = of_find_node_by_path("/");
 		n = prom_n_addr_cells(dn);
 		property = (unsigned int *) get_property(dn,
@@ -166,6 +171,8 @@ void spider_init_IRQ(void)
 			continue;
 		for (spiderpic = 0; n > 0; --n)
 			spiderpic = (spiderpic << 32) + *property++;
+#endif
+		spiderpic = pics[node];
 		printk(KERN_DEBUG "SPIDER addr: %lx\n", spiderpic);
 		spider_pics[node] = __ioremap(spiderpic, 0x800, _PAGE_NO_CACHE);
 		for (n = 0; n < IIC_NUM_EXT; n++) {
--- linux-cg.orig/include/asm-ppc64/processor.h	2005-08-18 17:23:29.773910000 -0400
+++ linux-cg/include/asm-ppc64/processor.h	2005-08-18 17:23:52.423928088 -0400
@@ -438,7 +438,7 @@ struct thread_struct {
 	.fs = KERNEL_DS, \
 	.fpr = {0}, \
 	.fpscr = 0, \
-	.fpexc_mode = MSR_FE0|MSR_FE1, \
+	.fpexc_mode = 0, \
 }
 
 /*
--- linux-cg.orig/include/linux/pci_ids.h	2005-08-18 17:23:29.775909696 -0400
+++ linux-cg/include/linux/pci_ids.h	2005-08-18 17:23:52.827004832 -0400
@@ -1611,6 +1611,8 @@
 #define PCI_DEVICE_ID_TOSHIBA_TX4927	0x0180
 #define PCI_DEVICE_ID_TOSHIBA_TC86C001_MISC	0x0108
 #define PCI_DEVICE_ID_TOSHIBA_SPIDER_NET 0x01b3
+#define PCI_DEVICE_ID_TOSHIBA_SPIDER_OHCI 0x01b6
+#define PCI_DEVICE_ID_TOSHIBA_SPIDER_EHCI 0x01b5
 
 #define PCI_VENDOR_ID_RICOH		0x1180
 #define PCI_DEVICE_ID_RICOH_RL5C465	0x0465

