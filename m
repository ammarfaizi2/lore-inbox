Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267458AbUG2Vqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267458AbUG2Vqw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 17:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267468AbUG2Vq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 17:46:26 -0400
Received: from motgate8.mot.com ([129.188.136.8]:47802 "EHLO motgate8.mot.com")
	by vger.kernel.org with ESMTP id S267451AbUG2VmY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 17:42:24 -0400
Date: Thu, 29 Jul 2004 16:42:18 -0500 (CDT)
From: Kumar Gala <galak@somerset.sps.mot.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Support for MPC8555 CPU and board
Message-ID: <Pine.LNX.4.44.0407291639130.28838-100000@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

The following patch adds completes the CPU support for the MPC8555
PowerPC.  Additionally, it adds support for the MPC8555 CDS reference
board.  This is another PowerPC in the Freescale MPC85xx family.

* Add support for MPC8555 CPU and reference board

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

--

diff -Nru a/arch/ppc/platforms/85xx/Kconfig b/arch/ppc/platforms/85xx/Kconfig
--- a/arch/ppc/platforms/85xx/Kconfig	2004-07-29 16:38:17 -05:00
+++ b/arch/ppc/platforms/85xx/Kconfig	2004-07-29 16:38:17 -05:00
@@ -21,6 +21,11 @@
 	help
 	  This option enables support for the MPC 8540 ADS evaluation board.
 
+config MPC8555_CDS
+	bool "Freescale MPC8555 CDS"
+	help
+	  This option enablese support for the MPC8555 CDS evaluation board.
+
 config MPC8560_ADS
 	bool "Freescale MPC8560 ADS"
 	help
@@ -42,11 +47,21 @@
 	depends on MPC8540_ADS
 	default y
 
+config MPC8555
+	bool
+	depends on MPC8555_CDS
+	default y
+
 config MPC8560
 	bool
 	depends on SBC8560 || MPC8560_ADS
 	default y
 
+config 85xx_PCI2
+	bool "Supprt for 2nd PCI host controller"
+	depends on MPC8555_CDS
+	default y
+	
 config FSL_OCP
 	bool
 	depends on 85xx
@@ -54,7 +69,7 @@
 
 config PPC_GEN550
 	bool
-	depends on MPC8540 || SBC8560
+	depends on MPC8540 || SBC8560 || MPC8555
 	default y
 
 endmenu
diff -Nru a/arch/ppc/platforms/85xx/Makefile b/arch/ppc/platforms/85xx/Makefile
--- a/arch/ppc/platforms/85xx/Makefile	2004-07-29 16:38:17 -05:00
+++ b/arch/ppc/platforms/85xx/Makefile	2004-07-29 16:38:17 -05:00
@@ -3,8 +3,10 @@
 #
 
 obj-$(CONFIG_MPC8540_ADS)	+= mpc85xx_ads_common.o mpc8540_ads.o
+obj-$(CONFIG_MPC8555_CDS)	+= mpc85xx_cds_common.o
 obj-$(CONFIG_MPC8560_ADS)	+= mpc85xx_ads_common.o mpc8560_ads.o
 obj-$(CONFIG_SBC8560)		+= sbc85xx.o sbc8560.o
 
 obj-$(CONFIG_MPC8540)		+= mpc8540.o
+obj-$(CONFIG_MPC8555)		+= mpc8555.o
 obj-$(CONFIG_MPC8560)		+= mpc8560.o
diff -Nru a/arch/ppc/platforms/85xx/mpc8555.c b/arch/ppc/platforms/85xx/mpc8555.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/platforms/85xx/mpc8555.c	2004-07-29 16:38:17 -05:00
@@ -0,0 +1,88 @@
+/*
+ * arch/ppc/platform/85xx/mpc8555.c
+ *
+ * MPC8555 I/O descriptions
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
+#include <linux/init.h>
+#include <linux/module.h>
+#include <asm/mpc85xx.h>
+#include <asm/ocp.h>
+
+/* These should be defined in platform code */
+extern struct ocp_gfar_data mpc85xx_tsec1_def;
+extern struct ocp_gfar_data mpc85xx_tsec2_def;
+extern struct ocp_mpc_i2c_data mpc85xx_i2c1_def;
+
+/* We use offsets for paddr since we do not know at compile time
+ * what CCSRBAR is, platform code should fix this up in
+ * setup_arch
+ *
+ * Only the first IRQ is given even if a device has
+ * multiple lines associated with ita
+ */
+struct ocp_def core_ocp[] = {
+        { .vendor       = OCP_VENDOR_FREESCALE,
+          .function     = OCP_FUNC_IIC,
+          .index        = 0,
+          .paddr        = MPC85xx_IIC1_OFFSET,
+          .irq          = MPC85xx_IRQ_IIC1,
+          .pm           = OCP_CPM_NA,
+	  .additions	= &mpc85xx_i2c1_def,
+        },
+        { .vendor       = OCP_VENDOR_FREESCALE,
+          .function     = OCP_FUNC_16550,
+          .index        = 0,
+          .paddr        = MPC85xx_UART0_OFFSET,
+          .irq          = MPC85xx_IRQ_DUART,
+          .pm           = OCP_CPM_NA,
+        },
+        { .vendor       = OCP_VENDOR_FREESCALE,
+          .function     = OCP_FUNC_16550,
+          .index        = 1,
+          .paddr        = MPC85xx_UART1_OFFSET,
+          .irq          = MPC85xx_IRQ_DUART,
+          .pm           = OCP_CPM_NA,
+        },
+        { .vendor       = OCP_VENDOR_FREESCALE,
+          .function     = OCP_FUNC_GFAR,
+          .index        = 0,
+          .paddr        = MPC85xx_ENET1_OFFSET,
+          .irq          = MPC85xx_IRQ_TSEC1_TX,
+          .pm           = OCP_CPM_NA,
+          .additions    = &mpc85xx_tsec1_def,
+        },
+        { .vendor       = OCP_VENDOR_FREESCALE,
+          .function     = OCP_FUNC_GFAR,
+          .index        = 1,
+          .paddr        = MPC85xx_ENET2_OFFSET,
+          .irq          = MPC85xx_IRQ_TSEC2_TX,
+          .pm           = OCP_CPM_NA,
+          .additions    = &mpc85xx_tsec2_def,
+        },
+        { .vendor       = OCP_VENDOR_FREESCALE,
+          .function     = OCP_FUNC_DMA,
+          .index        = 0,
+          .paddr        = MPC85xx_DMA_OFFSET,
+          .irq          = MPC85xx_IRQ_DMA0,
+          .pm           = OCP_CPM_NA,
+        },
+        { .vendor       = OCP_VENDOR_FREESCALE,
+          .function     = OCP_FUNC_PERFMON,
+          .index        = 0,
+          .paddr        = MPC85xx_PERFMON_OFFSET,
+          .irq          = MPC85xx_IRQ_PERFMON,
+          .pm           = OCP_CPM_NA,
+        },
+        { .vendor       = OCP_VENDOR_INVALID
+        }
+};
diff -Nru a/arch/ppc/platforms/85xx/mpc8555_cds.h b/arch/ppc/platforms/85xx/mpc8555_cds.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/platforms/85xx/mpc8555_cds.h	2004-07-29 16:38:17 -05:00
@@ -0,0 +1,26 @@
+/*
+ * arch/ppc/platforms/mpc8555_cds.h
+ *
+ * MPC8555CDS board definitions
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
+#ifndef __MACH_MPC8555CDS_H__
+#define __MACH_MPC8555CDS_H__
+
+#include <linux/config.h>
+#include <linux/serial.h>
+#include <platforms/85xx/mpc85xx_cds_common.h>
+
+#define CPM_MAP_ADDR	(CCSRBAR + MPC85xx_CPM_OFFSET)
+
+#endif /* __MACH_MPC8555CDS_H__ */
diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2004-07-29 16:38:17 -05:00
@@ -0,0 +1,473 @@
+/*
+ * arch/ppc/platform/85xx/mpc85xx_cds_common.c
+ *
+ * MPC85xx CDS board specific routines
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2004 Freescale Semiconductor, Inc
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
+#include <linux/serial.h>
+#include <linux/module.h>
+#include <linux/root_dev.h>
+#include <linux/initrd.h>
+#include <linux/tty.h>
+#include <linux/serial_core.h>
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
+#include <asm/immap_cpm2.h>
+#include <asm/ocp.h>
+#include <asm/kgdb.h>
+
+#include <mm/mmu_decl.h>
+#include <syslib/cpm2_pic.h>
+#include <syslib/ppc85xx_common.h>
+#include <syslib/ppc85xx_setup.h>
+
+
+#ifndef CONFIG_PCI
+unsigned long isa_io_base = 0;
+unsigned long isa_mem_base = 0;
+#endif
+
+extern unsigned long total_memory;      /* in mm/init */
+
+unsigned char __res[sizeof (bd_t)];
+
+static int cds_pci_slot = 2;
+static volatile u8 * cadmus;
+
+/* Internal interrupts are all Level Sensitive, and Positive Polarity */
+
+static u_char mpc85xx_cds_openpic_initsenses[] __initdata = {
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal  0: L2 Cache */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal  1: ECM */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal  2: DDR DRAM */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal  3: LBIU */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal  4: DMA 0 */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal  5: DMA 1 */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal  6: DMA 2 */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal  7: DMA 3 */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal  8: PCI/PCI-X */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal  9: RIO Inbound Port Write Error */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 10: RIO Doorbell Inbound */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 11: RIO Outbound Message */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 12: RIO Inbound Message */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 13: TSEC 0 Transmit */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 14: TSEC 0 Receive */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 15: Unused */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 16: Unused */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 17: Unused */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 18: TSEC 0 Receive/Transmit Error */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 19: TSEC 1 Transmit */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 20: TSEC 1 Receive */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 21: Unused */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 22: Unused */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 23: Unused */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 24: TSEC 1 Receive/Transmit Error */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 25: Fast Ethernet */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 26: DUART */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 27: I2C */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 28: Performance Monitor */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 29: Unused */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 30: CPM */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 31: Unused */
+#if defined(CONFIG_PCI)
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* External 0: PCI1 slot */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* External 1: PCI1 slot */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* External 2: PCI1 slot */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* External 3: PCI1 slot */
+#else
+        0x0,                            /* External  0: */
+        0x0,                            /* External  1: */
+        0x0,                            /* External  2: */
+        0x0,                            /* External  3: */
+#endif
+        0x0,                            /* External  4: */
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* External 5: PHY */
+        0x0,                            /* External  6: */
+        0x0,                            /* External  7: */
+        0x0,                            /* External  8: */
+        0x0,                            /* External  9: */
+        0x0,                            /* External 10: */
+#if defined(CONFIG_85xx_PCI2) && defined(CONFIG_PCI)
+        (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* External 11: PCI2 slot 0 */
+#else
+        0x0,                            /* External 11: */
+#endif
+};
+
+struct ocp_gfar_data mpc85xx_tsec1_def = {
+        .interruptTransmit = MPC85xx_IRQ_TSEC1_TX,
+        .interruptError = MPC85xx_IRQ_TSEC1_ERROR,
+        .interruptReceive = MPC85xx_IRQ_TSEC1_RX,
+        .interruptPHY = MPC85xx_IRQ_EXT5,
+        .flags = (GFAR_HAS_GIGABIT | GFAR_HAS_MULTI_INTR |
+                        GFAR_HAS_PHY_INTR),
+        .phyid = 0,
+        .phyregidx = 0,
+};
+
+struct ocp_gfar_data mpc85xx_tsec2_def = {
+        .interruptTransmit = MPC85xx_IRQ_TSEC2_TX,
+        .interruptError = MPC85xx_IRQ_TSEC2_ERROR,
+        .interruptReceive = MPC85xx_IRQ_TSEC2_RX,
+        .interruptPHY = MPC85xx_IRQ_EXT5,
+        .flags = (GFAR_HAS_GIGABIT | GFAR_HAS_MULTI_INTR |
+                        GFAR_HAS_PHY_INTR),
+        .phyid = 1,
+        .phyregidx = 0,
+};
+
+struct ocp_fs_i2c_data mpc85xx_i2c1_def = {
+	.flags = FS_I2C_SEPARATE_DFSRR,
+};
+
+/* ************************************************************************ */
+int
+mpc85xx_cds_show_cpuinfo(struct seq_file *m)
+{
+        uint pvid, svid, phid1;
+        uint memsize = total_memory;
+        bd_t *binfo = (bd_t *) __res;
+        unsigned int freq;
+
+        /* get the core frequency */
+        freq = binfo->bi_intfreq;
+
+        pvid = mfspr(PVR);
+        svid = mfspr(SVR);
+
+        seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
+	seq_printf(m, "Machine\t\t: CDS (%x)\n", cadmus[CM_VER]);
+        seq_printf(m, "bus freq\t: %u.%.6u MHz\n", freq / 1000000,
+                   freq % 1000000);
+        seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
+        seq_printf(m, "SVR\t\t: 0x%x\n", svid);
+
+        /* Display cpu Pll setting */
+        phid1 = mfspr(HID1);
+        seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
+
+        /* Display the amount of memory */
+        seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
+
+        return 0;
+}
+
+#ifdef CONFIG_CPM2
+static void cpm2_cascade(int irq, void *dev_id, struct pt_regs *regs)
+{
+	while((irq = cpm2_get_irq(regs)) >= 0)
+	{
+		ppc_irq_dispatch_handler(regs,irq);
+	}
+}
+#endif /* CONFIG_CPM2 */
+
+void __init
+mpc85xx_cds_init_IRQ(void)
+{
+	bd_t *binfo = (bd_t *) __res;
+#ifdef CONFIG_CPM2
+	volatile cpm2_map_t *immap = cpm2_immr;
+	int i;
+#endif
+
+        /* Determine the Physical Address of the OpenPIC regs */
+        phys_addr_t OpenPIC_PAddr = binfo->bi_immr_base + MPC85xx_OPENPIC_OFFSET;
+        OpenPIC_Addr = ioremap(OpenPIC_PAddr, MPC85xx_OPENPIC_SIZE);
+        OpenPIC_InitSenses = mpc85xx_cds_openpic_initsenses;
+        OpenPIC_NumInitSenses = sizeof (mpc85xx_cds_openpic_initsenses);
+
+        /* Skip reserved space and internal sources */
+        openpic_set_sources(0, 32, OpenPIC_Addr + 0x10200);
+        /* Map PIC IRQs 0-11 */
+        openpic_set_sources(32, 12, OpenPIC_Addr + 0x10000);
+
+        /* we let openpic interrupts starting from an offset, to
+         * leave space for cascading interrupts underneath.
+         */
+        openpic_init(MPC85xx_OPENPIC_IRQ_OFFSET);
+
+#ifdef CONFIG_CPM2
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
+#endif
+
+        return;
+}
+
+#ifdef CONFIG_PCI
+/*
+ * interrupt routing
+ */
+int
+mpc85xx_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
+{
+	struct pci_controller *hose = pci_bus_to_hose(dev->bus->number);
+
+	if (!hose->index)
+	{
+		/* Handle PCI1 interrupts */
+		char pci_irq_table[][4] =
+			/*
+			 *      PCI IDSEL/INTPIN->INTLINE
+			 *        A      B      C      D
+			 */
+
+			/* Note IRQ assignment for slots is based on which slot the elysium is
+			 * in -- in this setup elysium is in slot #2 (this PIRQA as first
+			 * interrupt on slot */
+		{
+			{ 0, 1, 2, 3 }, /* 16 - PMC */
+			{ 3, 0, 0, 0 }, /* 17 P2P (Tsi320) */
+			{ 0, 1, 2, 3 }, /* 18 - Slot 1 */
+			{ 1, 2, 3, 0 }, /* 19 - Slot 2 */
+			{ 2, 3, 0, 1 }, /* 20 - Slot 3 */
+			{ 3, 0, 1, 2 }, /* 21 - Slot 4 */
+		};
+
+		const long min_idsel = 16, max_idsel = 21, irqs_per_slot = 4;
+		int i, j;
+
+		for (i = 0; i < 6; i++)
+			for (j = 0; j < 4; j++)
+				pci_irq_table[i][j] =
+					((pci_irq_table[i][j] + 5 -
+					  cds_pci_slot) & 0x3) + PIRQ0A;
+
+		return PCI_IRQ_TABLE_LOOKUP;
+	} else {
+		/* Handle PCI2 interrupts (if we have one) */
+		char pci_irq_table[][4] =
+		{
+			/*
+			 * We only have one slot and one interrupt
+			 * going to PIRQA - PIRQD */
+			{ PIRQ1A, PIRQ1A, PIRQ1A, PIRQ1A }, /* 21 - slot 0 */
+		};
+
+		const long min_idsel = 21, max_idsel = 21, irqs_per_slot = 4;
+
+		return PCI_IRQ_TABLE_LOOKUP;
+	}
+}
+
+#define ARCADIA_HOST_BRIDGE_IDSEL     17
+#define ARCADIA_2ND_BRIDGE_IDSEL     3
+
+int
+mpc85xx_exclude_device(u_char bus, u_char devfn)
+{
+	if (bus == 0 && PCI_SLOT(devfn) == 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+#if CONFIG_85xx_PCI2
+	/* With the current code we know PCI2 will be bus 2, however this may
+	 * not be guarnteed */
+	if (bus == 2 && PCI_SLOT(devfn) == 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+#endif
+	/* We explicitly do not go past the Tundra 320 Bridge */
+	if (bus == 1)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	if ((bus == 0) && (PCI_SLOT(devfn) == ARCADIA_2ND_BRIDGE_IDSEL))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	else
+		return PCIBIOS_SUCCESSFUL;
+}
+#endif /* CONFIG_PCI */
+
+/* ************************************************************************
+ *
+ * Setup the architecture
+ *
+ */
+static void __init
+mpc85xx_cds_setup_arch(void)
+{
+        struct ocp_def *def;
+        struct ocp_gfar_data *einfo;
+        bd_t *binfo = (bd_t *) __res;
+        unsigned int freq;
+
+        /* get the core frequency */
+        freq = binfo->bi_intfreq;
+
+        printk("mpc85xx_cds_setup_arch\n");
+
+#ifdef CONFIG_CPM2
+	cpm2_reset();
+#endif
+
+	cadmus = ioremap(CADMUS_BASE, CADMUS_SIZE);
+	cds_pci_slot = ((cadmus[CM_CSR] >> 6) & 0x3) + 1;
+	printk("CDS Version = %x in PCI slot %d\n", cadmus[CM_VER], cds_pci_slot);
+
+        /* Set loops_per_jiffy to a half-way reasonable value,
+           for use until calibrate_delay gets called. */
+        loops_per_jiffy = freq / HZ;
+
+#ifdef CONFIG_PCI
+        /* setup PCI host bridges */
+        mpc85xx_setup_hose();
+#endif
+
+#ifdef CONFIG_DUMMY_CONSOLE
+        conswitchp = &dummy_con;
+#endif
+
+#ifdef CONFIG_SERIAL_8250
+        mpc85xx_early_serial_map();
+#endif
+
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
+	/* Invalidate the entry we stole earlier the serial ports
+	 * should be properly mapped */
+	invalidate_tlbcam_entry(NUM_TLBCAMS - 1);
+#endif
+
+        def = ocp_get_one_device(OCP_VENDOR_FREESCALE, OCP_FUNC_GFAR, 0);
+        if (def) {
+                einfo = (struct ocp_gfar_data *) def->additions;
+                memcpy(einfo->mac_addr, binfo->bi_enetaddr, 6);
+        }
+
+        def = ocp_get_one_device(OCP_VENDOR_FREESCALE, OCP_FUNC_GFAR, 1);
+        if (def) {
+                einfo = (struct ocp_gfar_data *) def->additions;
+                memcpy(einfo->mac_addr, binfo->bi_enet1addr, 6);
+        }
+
+#ifdef CONFIG_BLK_DEV_INITRD
+        if (initrd_start)
+                ROOT_DEV = Root_RAM0;
+        else
+#endif
+#ifdef  CONFIG_ROOT_NFS
+                ROOT_DEV = Root_NFS;
+#else
+                ROOT_DEV = Root_HDA1;
+#endif
+
+	ocp_for_each_device(mpc85xx_update_paddr_ocp, &(binfo->bi_immr_base));
+}
+
+/* ************************************************************************ */
+void __init
+platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+              unsigned long r6, unsigned long r7)
+{
+        /* parse_bootinfo must always be called first */
+        parse_bootinfo(find_bootinfo());
+
+        /*
+         * If we were passed in a board information, copy it into the
+         * residual data area.
+         */
+        if (r3) {
+                memcpy((void *) __res, (void *) (r3 + KERNELBASE),
+                       sizeof (bd_t));
+
+        }
+#ifdef CONFIG_SERIAL_TEXT_DEBUG
+	{
+		bd_t *binfo = (bd_t *) __res;
+
+		/* Use the last TLB entry to map CCSRBAR to allow access to DUART regs */
+		settlbcam(NUM_TLBCAMS - 1, binfo->bi_immr_base,
+			binfo->bi_immr_base, MPC85xx_CCSRBAR_SIZE, _PAGE_IO, 0);
+		
+	}
+#endif
+
+#if defined(CONFIG_BLK_DEV_INITRD)
+        /*
+         * If the init RAM disk has been configured in, and there's a valid
+         * starting address for it, set it up.
+         */
+        if (r4) {
+                initrd_start = r4 + KERNELBASE;
+                initrd_end = r5 + KERNELBASE;
+        }
+#endif                          /* CONFIG_BLK_DEV_INITRD */
+
+        /* Copy the kernel command line arguments to a safe place. */
+
+        if (r6) {
+                *(char *) (r7 + KERNELBASE) = 0;
+                strcpy(cmd_line, (char *) (r6 + KERNELBASE));
+        }
+
+        /* setup the PowerPC module struct */
+        ppc_md.setup_arch = mpc85xx_cds_setup_arch;
+        ppc_md.show_cpuinfo = mpc85xx_cds_show_cpuinfo;
+
+        ppc_md.init_IRQ = mpc85xx_cds_init_IRQ;
+        ppc_md.get_irq = openpic_get_irq;
+
+        ppc_md.restart = mpc85xx_restart;
+        ppc_md.power_off = mpc85xx_power_off;
+        ppc_md.halt = mpc85xx_halt;
+
+        ppc_md.find_end_of_memory = mpc85xx_find_end_of_memory;
+
+        ppc_md.time_init = NULL;
+        ppc_md.set_rtc_time = NULL;
+        ppc_md.get_rtc_time = NULL;
+        ppc_md.calibrate_decr = mpc85xx_calibrate_decr;
+
+#if defined(CONFIG_SERIAL_8250) && defined(CONFIG_SERIAL_TEXT_DEBUG)
+        ppc_md.progress = gen550_progress;
+#endif /* CONFIG_SERIAL_8250 && CONFIG_SERIAL_TEXT_DEBUG */
+
+        if (ppc_md.progress)
+                ppc_md.progress("mpc85xx_cds_init(): exit", 0);
+
+        return;
+}
diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_cds_common.h b/arch/ppc/platforms/85xx/mpc85xx_cds_common.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.h	2004-07-29 16:38:17 -05:00
@@ -0,0 +1,78 @@
+/*
+ * arch/ppc/platforms/85xx/mpc85xx_cds_common.h
+ *
+ * MPC85xx CDS board definitions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2004 Freescale Semiconductor, Inc
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#ifndef __MACH_MPC85XX_CDS_H__
+#define __MACH_MPC85XX_CDS_H__
+
+#include <linux/config.h>
+#include <linux/serial.h>
+#include <asm/ppcboot.h>
+#include <linux/initrd.h>
+#include <syslib/ppc85xx_setup.h>
+
+#define BOARD_CCSRBAR           ((uint)0xe0000000)
+#define CCSRBAR_SIZE            ((uint)1024*1024)
+
+/* CADMUS info */
+#define CADMUS_BASE (0xf8004000)
+#define CADMUS_SIZE (256)
+#define CM_VER	(0)
+#define CM_CSR	(1)
+#define CM_RST	(2)
+
+/* PCI config */
+#define PCI1_CFG_ADDR_OFFSET	(0x8000)
+#define PCI1_CFG_DATA_OFFSET	(0x8004)
+
+#define PCI2_CFG_ADDR_OFFSET	(0x9000)
+#define PCI2_CFG_DATA_OFFSET	(0x9004)
+
+/* PCI interrupt controller */
+#define PIRQ0A                   MPC85xx_IRQ_EXT0
+#define PIRQ0B                   MPC85xx_IRQ_EXT1
+#define PIRQ0C                   MPC85xx_IRQ_EXT2
+#define PIRQ0D                   MPC85xx_IRQ_EXT3
+#define PIRQ1A                   MPC85xx_IRQ_EXT11
+
+/* PCI 1 memory map */
+#define MPC85XX_PCI1_LOWER_IO        0x00000000
+#define MPC85XX_PCI1_UPPER_IO        0x00ffffff
+
+#define MPC85XX_PCI1_LOWER_MEM       0x80000000
+#define MPC85XX_PCI1_UPPER_MEM       0x9fffffff
+
+#define MPC85XX_PCI1_IO_BASE         0xe2000000
+#define MPC85XX_PCI1_MEM_OFFSET      0x00000000
+
+#define MPC85XX_PCI1_IO_SIZE         0x01000000
+
+/* PCI 2 memory map */
+#define MPC85XX_PCI2_LOWER_IO        0x01000000
+#define MPC85XX_PCI2_UPPER_IO        0x01ffffff
+
+#define MPC85XX_PCI2_LOWER_MEM       0xa0000000
+#define MPC85XX_PCI2_UPPER_MEM       0xbfffffff
+
+#define MPC85XX_PCI2_IO_BASE         0xe3000000
+#define MPC85XX_PCI2_MEM_OFFSET      0x00000000
+
+#define MPC85XX_PCI2_IO_SIZE         0x01000000
+
+#define SERIAL_PORT_DFNS		\
+	       STD_UART_OP(0)		\
+	       STD_UART_OP(1)
+
+#endif /* __MACH_MPC85XX_CDS_H__ */
diff -Nru a/arch/ppc/syslib/ppc85xx_setup.c b/arch/ppc/syslib/ppc85xx_setup.c
--- a/arch/ppc/syslib/ppc85xx_setup.c	2004-07-29 16:38:17 -05:00
+++ b/arch/ppc/syslib/ppc85xx_setup.c	2004-07-29 16:38:17 -05:00
@@ -169,17 +169,20 @@
 	pci->piwar2 = 0;
 	pci->piwar3 = 0;
 
-	/* Setup 512M Phys:PCI 1:1 outbound mem window @ 0x80000000 */
+	/* Setup Phys:PCI 1:1 outbound mem window @ MPC85XX_PCI1_LOWER_MEM */
 	pci->potar1 = (MPC85XX_PCI1_LOWER_MEM >> 12) & 0x000fffff;
 	pci->potear1 = 0x00000000;
 	pci->powbar1 = (MPC85XX_PCI1_LOWER_MEM >> 12) & 0x000fffff;
-	pci->powar1 = 0x8004401c;	/* Enable, Mem R/W, 512M */
+	/* Enable, Mem R/W */
+	pci->powar1 = 0x80044000 |
+	   (__ilog2(MPC85XX_PCI1_UPPER_MEM - MPC85XX_PCI1_LOWER_MEM + 1) - 1);
 
-	/* Setup 16M outboud IO windows @ 0xe2000000 */
+	/* Setup outboud IO windows @ MPC85XX_PCI1_IO_BASE */
 	pci->potar2 = 0x00000000;
 	pci->potear2 = 0x00000000;
 	pci->powbar2 = (MPC85XX_PCI1_IO_BASE >> 12) & 0x000fffff;
-	pci->powar2 = 0x80088017;	/* Enable, IO R/W, 16M */
+	/* Enable, IO R/W */
+	pci->powar2 = 0x80088000 | (__ilog2(MPC85XX_PCI1_IO_SIZE) - 1);
 
 	/* Setup 2G inbound Memory Window @ 0 */
 	pci->pitar1 = 0x00000000;
@@ -192,7 +195,7 @@
 extern int mpc85xx_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin);
 extern int mpc85xx_exclude_device(u_char bus, u_char devfn);
 
-#if CONFIG_85xx_PCI2
+#ifdef CONFIG_85xx_PCI2
 static void __init
 mpc85xx_setup_pci2(struct pci_controller *hose)
 {
@@ -203,10 +206,10 @@
 	pci = ioremap(binfo->bi_immr_base + MPC85xx_PCI2_OFFSET,
 		    MPC85xx_PCI2_SIZE);
 
-	early_read_config_word(hose, 0, 0, PCI_COMMAND, &temps);
+	early_read_config_word(hose, hose->bus_offset, 0, PCI_COMMAND, &temps);
 	temps |= PCI_COMMAND_SERR | PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY;
-	early_write_config_word(hose, 0, 0, PCI_COMMAND, temps);
-	early_write_config_byte(hose, 0, 0, PCI_LATENCY_TIMER, 0x80);
+	early_write_config_word(hose, hose->bus_offset, 0, PCI_COMMAND, temps);
+	early_write_config_byte(hose, hose->bus_offset, 0, PCI_LATENCY_TIMER, 0x80);
 
 	/* Disable all windows (except powar0 since its ignored) */
 	pci->powar1 = 0;
@@ -217,17 +220,20 @@
 	pci->piwar2 = 0;
 	pci->piwar3 = 0;
 
-	/* Setup 512M Phys:PCI 1:1 outbound mem window @ 0xa0000000 */
+	/* Setup Phys:PCI 1:1 outbound mem window @ MPC85XX_PCI2_LOWER_MEM */
 	pci->potar1 = (MPC85XX_PCI2_LOWER_MEM >> 12) & 0x000fffff;
 	pci->potear1 = 0x00000000;
 	pci->powbar1 = (MPC85XX_PCI2_LOWER_MEM >> 12) & 0x000fffff;
-	pci->powar1 = 0x8004401c;	/* Enable, Mem R/W, 512M */
+	/* Enable, Mem R/W */
+	pci->powar1 = 0x80044000 |
+	   (__ilog2(MPC85XX_PCI1_UPPER_MEM - MPC85XX_PCI1_LOWER_MEM + 1) - 1);
 
-	/* Setup 16M outboud IO windows @ 0xe3000000 */
+	/* Setup outboud IO windows @ MPC85XX_PCI2_IO_BASE */
 	pci->potar2 = 0x00000000;
 	pci->potear2 = 0x00000000;
 	pci->powbar2 = (MPC85XX_PCI2_IO_BASE >> 12) & 0x000fffff;
-	pci->powar2 = 0x80088017;	/* Enable, IO R/W, 16M */
+	/* Enable, IO R/W */
+	pci->powar2 = 0x80088000 | (__ilog2(MPC85XX_PCI1_IO_SIZE) - 1);
 
 	/* Setup 2G inbound Memory Window @ 0 */
 	pci->pitar1 = 0x00000000;
diff -Nru a/include/asm-ppc/mpc85xx.h b/include/asm-ppc/mpc85xx.h
--- a/include/asm-ppc/mpc85xx.h	2004-07-29 16:38:17 -05:00
+++ b/include/asm-ppc/mpc85xx.h	2004-07-29 16:38:17 -05:00
@@ -25,6 +25,9 @@
 #ifdef CONFIG_MPC8540_ADS
 #include <platforms/85xx/mpc8540_ads.h>
 #endif
+#ifdef CONFIG_MPC8555_CDS
+#include <platforms/85xx/mpc8555_cds.h>
+#endif
 #ifdef CONFIG_MPC8560_ADS
 #include <platforms/85xx/mpc8560_ads.h>
 #endif

