Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267556AbUG2SWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267556AbUG2SWW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 14:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265201AbUG2STl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 14:19:41 -0400
Received: from motgate8.mot.com ([129.188.136.8]:28361 "EHLO motgate8.mot.com")
	by vger.kernel.org with ESMTP id S263980AbUG2SQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 14:16:16 -0400
Date: Thu, 29 Jul 2004 13:16:07 -0500 (CDT)
From: Kumar Gala <galak@somerset.sps.mot.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Support for MPC8560 CPU and boards
Message-ID: <Pine.LNX.4.44.0407291153310.12662-100000@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

The following patch adds completes the CPU support for the MPC8560
PowerPC.  Additionally, it adds support for the MPC8560 ADS reference
board and fixes up some build issues with the SBC8560 board.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

--


diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	2004-07-29 13:14:10 -05:00
+++ b/arch/ppc/Kconfig	2004-07-29 13:14:10 -05:00
@@ -638,7 +638,7 @@
 
 config CPM2
 	bool
-	depends on 8260
+	depends on 8260 || MPC8560
 	default y
 	help
 	  The CPM2 (Communications Processor Module) is a coprocessor on
diff -Nru a/arch/ppc/platforms/85xx/Kconfig b/arch/ppc/platforms/85xx/Kconfig
--- a/arch/ppc/platforms/85xx/Kconfig	2004-07-29 13:14:10 -05:00
+++ b/arch/ppc/platforms/85xx/Kconfig	2004-07-29 13:14:10 -05:00
@@ -17,10 +17,15 @@
 	default MPC8540_ADS
 
 config MPC8540_ADS
-	bool "MPC8540ADS"
+	bool "Freescale MPC8540 ADS"
 	help
 	  This option enables support for the MPC 8540 ADS evaluation board.
 
+config MPC8560_ADS
+	bool "Freescale MPC8560 ADS"
+	help
+	  This option enables support for the MPC 8560 ADS evaluation board.
+
 config SBC8560
 	bool "WindRiver PowerQUICC III SBC8560"
 	help
@@ -39,7 +44,7 @@
 
 config MPC8560
 	bool
-	depends on SBC8560
+	depends on SBC8560 || MPC8560_ADS
 	default y
 
 config FSL_OCP
diff -Nru a/arch/ppc/platforms/85xx/Makefile b/arch/ppc/platforms/85xx/Makefile
--- a/arch/ppc/platforms/85xx/Makefile	2004-07-29 13:14:10 -05:00
+++ b/arch/ppc/platforms/85xx/Makefile	2004-07-29 13:14:10 -05:00
@@ -3,6 +3,7 @@
 #
 
 obj-$(CONFIG_MPC8540_ADS)	+= mpc85xx_ads_common.o mpc8540_ads.o
+obj-$(CONFIG_MPC8560_ADS)	+= mpc85xx_ads_common.o mpc8560_ads.o
 obj-$(CONFIG_SBC8560)		+= sbc85xx.o sbc8560.o
 
 obj-$(CONFIG_MPC8540)		+= mpc8540.o
diff -Nru a/arch/ppc/platforms/85xx/mpc8540_ads.c b/arch/ppc/platforms/85xx/mpc8540_ads.c
--- a/arch/ppc/platforms/85xx/mpc8540_ads.c	2004-07-29 13:14:10 -05:00
+++ b/arch/ppc/platforms/85xx/mpc8540_ads.c	2004-07-29 13:14:10 -05:00
@@ -30,6 +30,7 @@
 #include <linux/serial.h>
 #include <linux/tty.h>	/* for linux/serial_core.h */
 #include <linux/serial_core.h>
+#include <linux/initrd.h>
 #include <linux/module.h>
 
 #include <asm/system.h>
diff -Nru a/arch/ppc/platforms/85xx/mpc8540_ads.h b/arch/ppc/platforms/85xx/mpc8540_ads.h
--- a/arch/ppc/platforms/85xx/mpc8540_ads.h	2004-07-29 13:14:10 -05:00
+++ b/arch/ppc/platforms/85xx/mpc8540_ads.h	2004-07-29 13:14:10 -05:00
@@ -18,7 +18,6 @@
 #define __MACH_MPC8540ADS_H__
 
 #include <linux/config.h>
-#include <linux/serial.h>
 #include <linux/initrd.h>
 #include <syslib/ppc85xx_setup.h>
 #include <platforms/85xx/mpc85xx_ads_common.h>
diff -Nru a/arch/ppc/platforms/85xx/mpc8560_ads.c b/arch/ppc/platforms/85xx/mpc8560_ads.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/platforms/85xx/mpc8560_ads.c	2004-07-29 13:14:10 -05:00
@@ -0,0 +1,241 @@
+/*
+ * arch/ppc/platforms/85xx/mpc8560_ads.c
+ *
+ * MPC8560ADS board specific routines
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2004 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/reboot.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/major.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/seq_file.h>
+#include <linux/root_dev.h>
+#include <linux/serial.h>
+#include <linux/tty.h>	/* for linux/serial_core.h */
+#include <linux/serial_core.h>
+#include <linux/initrd.h>
+#include <linux/module.h>
+
+#include <asm/system.h>
+#include <asm/pgtable.h>
+#include <asm/page.h>
+#include <asm/atomic.h>
+#include <asm/time.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/open_pic.h>
+#include <asm/bootinfo.h>
+#include <asm/pci-bridge.h>
+#include <asm/mpc85xx.h>
+#include <asm/irq.h>
+#include <asm/immap_85xx.h>
+#include <asm/kgdb.h>
+#include <asm/ocp.h>
+#include <asm/cpm2.h>
+#include <mm/mmu_decl.h>
+
+#include <syslib/cpm2_pic.h>
+#include <syslib/ppc85xx_common.h>
+#include <syslib/ppc85xx_setup.h>
+
+extern void cpm2_reset(void);
+
+struct ocp_gfar_data mpc85xx_tsec1_def = {
+        .interruptTransmit = MPC85xx_IRQ_TSEC1_TX,
+        .interruptError = MPC85xx_IRQ_TSEC1_ERROR,
+        .interruptReceive = MPC85xx_IRQ_TSEC1_RX,
+        .interruptPHY = MPC85xx_IRQ_EXT5,
+        .flags = (GFAR_HAS_GIGABIT | GFAR_HAS_MULTI_INTR
+			| GFAR_HAS_RMON | GFAR_HAS_COALESCE
+                        | GFAR_HAS_PHY_INTR),
+        .phyid = 0,
+        .phyregidx = 0,
+};
+
+struct ocp_gfar_data mpc85xx_tsec2_def = {
+        .interruptTransmit = MPC85xx_IRQ_TSEC2_TX,
+        .interruptError = MPC85xx_IRQ_TSEC2_ERROR,
+        .interruptReceive = MPC85xx_IRQ_TSEC2_RX,
+        .interruptPHY = MPC85xx_IRQ_EXT5,
+        .flags = (GFAR_HAS_GIGABIT | GFAR_HAS_MULTI_INTR
+			| GFAR_HAS_RMON | GFAR_HAS_COALESCE
+                        | GFAR_HAS_PHY_INTR),
+        .phyid = 1,
+        .phyregidx = 0,
+};
+
+struct ocp_fs_i2c_data mpc85xx_i2c1_def = {
+	.flags = FS_I2C_SEPARATE_DFSRR,
+};
+
+/* ************************************************************************
+ *
+ * Setup the architecture
+ *
+ */
+
+static void __init
+mpc8560ads_setup_arch(void)
+{
+	struct ocp_def *def;
+	struct ocp_gfar_data *einfo;
+	bd_t *binfo = (bd_t *) __res;
+	unsigned int freq;
+
+	cpm2_reset();
+
+	/* get the core frequency */
+	freq = binfo->bi_intfreq;
+
+	if (ppc_md.progress)
+		ppc_md.progress("mpc8560ads_setup_arch()", 0);
+
+	/* Set loops_per_jiffy to a half-way reasonable value,
+	   for use until calibrate_delay gets called. */
+	loops_per_jiffy = freq / HZ;
+
+#ifdef CONFIG_PCI
+	/* setup PCI host bridges */
+	mpc85xx_setup_hose();
+#endif
+
+	def = ocp_get_one_device(OCP_VENDOR_FREESCALE, OCP_FUNC_GFAR, 0);
+	if (def) {
+		einfo = (struct ocp_gfar_data *) def->additions;
+		memcpy(einfo->mac_addr, binfo->bi_enetaddr, 6);
+	}
+
+	def = ocp_get_one_device(OCP_VENDOR_FREESCALE, OCP_FUNC_GFAR, 1);
+	if (def) {
+		einfo = (struct ocp_gfar_data *) def->additions;
+		memcpy(einfo->mac_addr, binfo->bi_enet1addr, 6);
+	}
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	if (initrd_start)
+		ROOT_DEV = Root_RAM0;
+	else
+#endif
+#ifdef  CONFIG_ROOT_NFS
+		ROOT_DEV = Root_NFS;
+#else
+		ROOT_DEV = Root_HDA1;
+#endif
+
+	ocp_for_each_device(mpc85xx_update_paddr_ocp, &(binfo->bi_immr_base));
+}
+
+static irqreturn_t cpm2_cascade(int irq, void *dev_id, struct pt_regs *regs)
+{
+	while ((irq = cpm2_get_irq(regs)) >= 0) {
+		ppc_irq_dispatch_handler(regs, irq);
+	}
+	return IRQ_HANDLED;
+}
+
+static void __init
+mpc8560_ads_init_IRQ(void)
+{
+	int i;
+	volatile cpm2_map_t *immap = cpm2_immr;
+
+	/* Setup OpenPIC */
+	mpc85xx_ads_init_IRQ();
+
+	/* disable all CPM interupts */
+	immap->im_intctl.ic_simrh = 0x0;
+	immap->im_intctl.ic_simrl = 0x0;
+
+	for (i = CPM_IRQ_OFFSET; i < (NR_CPM_INTS + CPM_IRQ_OFFSET); i++)
+		irq_desc[i].handler = &cpm2_pic;
+
+	/* Initialize the default interrupt mapping priorities,
+	 * in case the boot rom changed something on us.
+	 */
+	immap->im_intctl.ic_sicr = 0;
+	immap->im_intctl.ic_scprrh = 0x05309770;
+	immap->im_intctl.ic_scprrl = 0x05309770;
+
+	request_irq(MPC85xx_IRQ_CPM, cpm2_cascade, SA_INTERRUPT, "cpm2_cascade", NULL);
+
+	return;
+}
+
+
+
+/* ************************************************************************ */
+void __init
+platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+	      unsigned long r6, unsigned long r7)
+{
+	/* parse_bootinfo must always be called first */
+	parse_bootinfo(find_bootinfo());
+
+	/*
+	 * If we were passed in a board information, copy it into the
+	 * residual data area.
+	 */
+	if (r3) {
+		memcpy((void *) __res, (void *) (r3 + KERNELBASE),
+		       sizeof (bd_t));
+
+	}
+#if defined(CONFIG_BLK_DEV_INITRD)
+	/*
+	 * If the init RAM disk has been configured in, and there's a valid
+	 * starting address for it, set it up.
+	 */
+	if (r4) {
+		initrd_start = r4 + KERNELBASE;
+		initrd_end = r5 + KERNELBASE;
+	}
+#endif				/* CONFIG_BLK_DEV_INITRD */
+
+	/* Copy the kernel command line arguments to a safe place. */
+
+	if (r6) {
+		*(char *) (r7 + KERNELBASE) = 0;
+		strcpy(cmd_line, (char *) (r6 + KERNELBASE));
+	}
+
+	/* setup the PowerPC module struct */
+	ppc_md.setup_arch = mpc8560ads_setup_arch;
+	ppc_md.show_cpuinfo = mpc85xx_ads_show_cpuinfo;
+
+	ppc_md.init_IRQ = mpc8560_ads_init_IRQ;
+	ppc_md.get_irq = openpic_get_irq;
+
+	ppc_md.restart = mpc85xx_restart;
+	ppc_md.power_off = mpc85xx_power_off;
+	ppc_md.halt = mpc85xx_halt;
+
+	ppc_md.find_end_of_memory = mpc85xx_find_end_of_memory;
+
+	ppc_md.time_init = NULL;
+	ppc_md.set_rtc_time = NULL;
+	ppc_md.get_rtc_time = NULL;
+	ppc_md.calibrate_decr = mpc85xx_calibrate_decr;
+
+	if (ppc_md.progress)
+		ppc_md.progress("mpc8560ads_init(): exit", 0);
+
+	return;
+}
diff -Nru a/arch/ppc/platforms/85xx/mpc8560_ads.h b/arch/ppc/platforms/85xx/mpc8560_ads.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/platforms/85xx/mpc8560_ads.h	2004-07-29 13:14:10 -05:00
@@ -0,0 +1,27 @@
+/*
+ * arch/ppc/platforms/mpc8560_ads.h
+ *
+ * MPC8540ADS board definitions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2004 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#ifndef __MACH_MPC8560ADS_H
+#define __MACH_MPC8560ADS_H
+
+#include <linux/config.h>
+#include <syslib/ppc85xx_setup.h>
+#include <platforms/85xx/mpc85xx_ads_common.h>
+
+#define CPM_MAP_ADDR	(CCSRBAR + MPC85xx_CPM_OFFSET)
+#define PHY_INTERRUPT	MPC85xx_IRQ_EXT7
+
+#endif				/* __MACH_MPC8560ADS_H */
diff -Nru a/arch/ppc/platforms/85xx/sbc8560.c b/arch/ppc/platforms/85xx/sbc8560.c
--- a/arch/ppc/platforms/85xx/sbc8560.c	2004-07-29 13:14:10 -05:00
+++ b/arch/ppc/platforms/85xx/sbc8560.c	2004-07-29 13:14:10 -05:00
@@ -30,6 +30,7 @@
 #include <linux/serial.h>
 #include <linux/tty.h>	/* for linux/serial_core.h */
 #include <linux/serial_core.h>
+#include <linux/initrd.h>
 #include <linux/module.h>
 
 #include <asm/system.h>
diff -Nru a/arch/ppc/platforms/85xx/sbc8560.h b/arch/ppc/platforms/85xx/sbc8560.h
--- a/arch/ppc/platforms/85xx/sbc8560.h	2004-07-29 13:14:10 -05:00
+++ b/arch/ppc/platforms/85xx/sbc8560.h	2004-07-29 13:14:10 -05:00
@@ -16,8 +16,9 @@
 #define __MACH_SBC8560_H__
  
 #include <linux/config.h>
-#include <linux/serial.h>
 #include <platforms/85xx/sbc85xx.h>
+
+#define CPM_MAP_ADDR    (CCSRBAR + MPC85xx_CPM_OFFSET)
  
 #ifdef CONFIG_SERIAL_MANY_PORTS
 #define RS_TABLE_SIZE  64
diff -Nru a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile	2004-07-29 13:14:10 -05:00
+++ b/arch/ppc/syslib/Makefile	2004-07-29 13:14:10 -05:00
@@ -69,10 +69,10 @@
 obj-$(CONFIG_SBC82xx)		+= todc_time.o
 obj-$(CONFIG_SPRUCE)		+= cpc700_pic.o indirect_pci.o pci_auto.o \
 				   todc_time.o
-obj-$(CONFIG_8260)		+= m8260_setup.o cpm2_pic.o
+obj-$(CONFIG_8260)		+= m8260_setup.o
 obj-$(CONFIG_PCI_8260)		+= m8260_pci.o indirect_pci.o
 obj-$(CONFIG_8260_PCI9)		+= m8260_pci_erratum9.o
-obj-$(CONFIG_CPM2)		+= cpm2_common.o
+obj-$(CONFIG_CPM2)		+= cpm2_common.o cpm2_pic.o
 ifeq ($(CONFIG_PPC_GEN550),y)
 obj-$(CONFIG_KGDB)		+= gen550_kgdb.o gen550_dbg.o
 obj-$(CONFIG_SERIAL_TEXT_DEBUG)	+= gen550_dbg.o
diff -Nru a/arch/ppc/syslib/ppc85xx_setup.h b/arch/ppc/syslib/ppc85xx_setup.h
--- a/arch/ppc/syslib/ppc85xx_setup.h	2004-07-29 13:14:10 -05:00
+++ b/arch/ppc/syslib/ppc85xx_setup.h	2004-07-29 13:14:10 -05:00
@@ -18,7 +18,6 @@
 #define __PPC_SYSLIB_PPC85XX_SETUP_H
 
 #include <linux/config.h>
-#include <linux/serial.h>
 #include <linux/init.h>
 #include <asm/ppcboot.h>
 
diff -Nru a/include/asm-ppc/irq.h b/include/asm-ppc/irq.h
--- a/include/asm-ppc/irq.h	2004-07-29 13:14:10 -05:00
+++ b/include/asm-ppc/irq.h	2004-07-29 13:14:10 -05:00
@@ -153,6 +153,79 @@
 	return irq;
 }
 
+#elif defined(CONFIG_CPM2) && defined(CONFIG_85xx)
+/* Now include the board configuration specific associations.
+*/
+#include <asm/mpc85xx.h>
+
+/* The MPC8560 openpic has  32 internal interrupts and 12 external
+ * interrupts.
+ *
+ * We are "flattening" the interrupt vectors of the cascaded CPM
+ * so that we can uniquely identify any interrupt source with a
+ * single integer.
+ */
+#define NR_CPM_INTS	64
+#define NR_EPIC_INTS	44
+#ifndef NR_8259_INTS
+#define NR_8259_INTS 0
+#endif
+#define NUM_8259_INTERRUPTS NR_8259_INTS
+
+#ifndef CPM_IRQ_OFFSET
+#define CPM_IRQ_OFFSET	0	
+#endif
+
+#define NR_IRQS	(NR_EPIC_INTS + NR_CPM_INTS + NR_8259_INTS)
+
+/* These values must be zero-based and map 1:1 with the EPIC configuration.
+ * They are used throughout the 8560 I/O subsystem to generate
+ * interrupt masks, flags, and other control patterns.  This is why the
+ * current kernel assumption of the 8259 as the base controller is such
+ * a pain in the butt.
+ */
+
+#define	SIU_INT_ERROR		((uint)0x00+CPM_IRQ_OFFSET)
+#define	SIU_INT_I2C		((uint)0x01+CPM_IRQ_OFFSET)
+#define	SIU_INT_SPI		((uint)0x02+CPM_IRQ_OFFSET)
+#define	SIU_INT_RISC		((uint)0x03+CPM_IRQ_OFFSET)
+#define	SIU_INT_SMC1		((uint)0x04+CPM_IRQ_OFFSET)
+#define	SIU_INT_SMC2		((uint)0x05+CPM_IRQ_OFFSET)
+#define	SIU_INT_TIMER1		((uint)0x0c+CPM_IRQ_OFFSET)
+#define	SIU_INT_TIMER2		((uint)0x0d+CPM_IRQ_OFFSET)
+#define	SIU_INT_TIMER3		((uint)0x0e+CPM_IRQ_OFFSET)
+#define	SIU_INT_TIMER4		((uint)0x0f+CPM_IRQ_OFFSET)
+#define	SIU_INT_FCC1		((uint)0x20+CPM_IRQ_OFFSET)
+#define	SIU_INT_FCC2		((uint)0x21+CPM_IRQ_OFFSET)
+#define	SIU_INT_FCC3		((uint)0x22+CPM_IRQ_OFFSET)
+#define	SIU_INT_MCC1		((uint)0x24+CPM_IRQ_OFFSET)
+#define	SIU_INT_MCC2		((uint)0x25+CPM_IRQ_OFFSET)
+#define	SIU_INT_SCC1		((uint)0x28+CPM_IRQ_OFFSET)
+#define	SIU_INT_SCC2		((uint)0x29+CPM_IRQ_OFFSET)
+#define	SIU_INT_SCC3		((uint)0x2a+CPM_IRQ_OFFSET)
+#define	SIU_INT_SCC4		((uint)0x2b+CPM_IRQ_OFFSET)
+#define	SIU_INT_PC15		((uint)0x30+CPM_IRQ_OFFSET)
+#define	SIU_INT_PC14		((uint)0x31+CPM_IRQ_OFFSET)
+#define	SIU_INT_PC13		((uint)0x32+CPM_IRQ_OFFSET)
+#define	SIU_INT_PC12		((uint)0x33+CPM_IRQ_OFFSET)
+#define	SIU_INT_PC11		((uint)0x34+CPM_IRQ_OFFSET)
+#define	SIU_INT_PC10		((uint)0x35+CPM_IRQ_OFFSET)
+#define	SIU_INT_PC9		((uint)0x36+CPM_IRQ_OFFSET)
+#define	SIU_INT_PC8		((uint)0x37+CPM_IRQ_OFFSET)
+#define	SIU_INT_PC7		((uint)0x38+CPM_IRQ_OFFSET)
+#define	SIU_INT_PC6		((uint)0x39+CPM_IRQ_OFFSET)
+#define	SIU_INT_PC5		((uint)0x3a+CPM_IRQ_OFFSET)
+#define	SIU_INT_PC4		((uint)0x3b+CPM_IRQ_OFFSET)
+#define	SIU_INT_PC3		((uint)0x3c+CPM_IRQ_OFFSET)
+#define	SIU_INT_PC2		((uint)0x3d+CPM_IRQ_OFFSET)
+#define	SIU_INT_PC1		((uint)0x3e+CPM_IRQ_OFFSET)
+#define	SIU_INT_PC0		((uint)0x3f+CPM_IRQ_OFFSET)
+
+static __inline__ int irq_canonicalize(int irq)
+{
+	return irq;
+}
+
 #else /* CONFIG_40x + CONFIG_8xx */
 /*
  * this is the # irq's for all ppc arch's (pmac/chrp/prep)
diff -Nru a/include/asm-ppc/mpc85xx.h b/include/asm-ppc/mpc85xx.h
--- a/include/asm-ppc/mpc85xx.h	2004-07-29 13:14:10 -05:00
+++ b/include/asm-ppc/mpc85xx.h	2004-07-29 13:14:10 -05:00
@@ -25,13 +25,20 @@
 #ifdef CONFIG_MPC8540_ADS
 #include <platforms/85xx/mpc8540_ads.h>
 #endif
+#ifdef CONFIG_MPC8560_ADS
+#include <platforms/85xx/mpc8560_ads.h>
+#endif
 #ifdef CONFIG_SBC8560
 #include <platforms/85xx/sbc8560.h>
 #endif
 
 #define _IO_BASE        isa_io_base
 #define _ISA_MEM_BASE   isa_mem_base
+#ifdef CONFIG_PCI
 #define PCI_DRAM_OFFSET pci_dram_offset
+#else
+#define PCI_DRAM_OFFSET 0
+#endif
 
 /*
  * The "residual" board information structure the boot loader passes

