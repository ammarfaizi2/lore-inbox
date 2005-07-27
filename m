Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262117AbVG0RiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbVG0RiH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 13:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbVG0Rf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 13:35:56 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:28361 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S262213AbVG0ReY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 13:34:24 -0400
Cc: wfarnsworth@mvista.com, linuxppc-embedded@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH][2/3] ppc32: add bamboo platform
In-Reply-To: <11224856623638@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 27 Jul 2005 10:34:23 -0700
Message-Id: <11224856632322@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Matt Porter <mporter@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add Bamboo platform support. This is an AMCC 440EP-based
reference platform.

Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>
Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff --git a/arch/ppc/platforms/4xx/bamboo.c b/arch/ppc/platforms/4xx/bamboo.c
new file mode 100644
--- /dev/null
+++ b/arch/ppc/platforms/4xx/bamboo.c
@@ -0,0 +1,427 @@
+/*
+ * arch/ppc/platforms/4xx/bamboo.c
+ *
+ * Bamboo board specific routines
+ *
+ * Wade Farnsworth <wfarnsworth@mvista.com>
+ * Copyright 2004 MontaVista Software Inc.
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
+#include <linux/types.h>
+#include <linux/major.h>
+#include <linux/blkdev.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/ide.h>
+#include <linux/initrd.h>
+#include <linux/irq.h>
+#include <linux/seq_file.h>
+#include <linux/root_dev.h>
+#include <linux/tty.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/ethtool.h>
+
+#include <asm/system.h>
+#include <asm/pgtable.h>
+#include <asm/page.h>
+#include <asm/dma.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/ocp.h>
+#include <asm/pci-bridge.h>
+#include <asm/time.h>
+#include <asm/todc.h>
+#include <asm/bootinfo.h>
+#include <asm/ppc4xx_pic.h>
+#include <asm/ppcboot.h>
+
+#include <syslib/gen550.h>
+#include <syslib/ibm440gx_common.h>
+
+/*
+ * This is a horrible kludge, we eventually need to abstract this
+ * generic PHY stuff, so the  standard phy mode defines can be
+ * easily used from arch code.
+ */
+#include "../../../../drivers/net/ibm_emac/ibm_emac_phy.h"
+
+bd_t __res;
+
+static struct ibm44x_clocks clocks __initdata;
+
+/*
+ * Bamboo external IRQ triggering/polarity settings
+ */
+unsigned char ppc4xx_uic_ext_irq_cfg[] __initdata = {
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ0: Ethernet transceiver */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE), /* IRQ1: Expansion connector */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ2: PCI slot 0 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ3: PCI slot 1 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ4: PCI slot 2 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ5: PCI slot 3 */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_NEGATIVE), /* IRQ6: SMI pushbutton */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ7: EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ8: EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE), /* IRQ9: EXT */
+};
+
+static void __init
+bamboo_calibrate_decr(void)
+{
+	unsigned int freq;
+
+	if (mfspr(SPRN_CCR1) & CCR1_TCS)
+		freq = BAMBOO_TMRCLK;
+	else
+		freq = clocks.cpu;
+
+	ibm44x_calibrate_decr(freq);
+	
+}
+
+static int
+bamboo_show_cpuinfo(struct seq_file *m)
+{
+	seq_printf(m, "vendor\t\t: IBM\n");
+	seq_printf(m, "machine\t\t: PPC440EP EVB (Bamboo)\n");
+
+	return 0;
+}
+
+static inline int
+bamboo_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
+{
+	static char pci_irq_table[][4] =
+	/*
+	 *	PCI IDSEL/INTPIN->INTLINE
+	 * 	   A   B   C   D
+	 */
+	{
+		{ 28, 28, 28, 28 },	/* IDSEL 1 - PCI Slot 0 */
+		{ 27, 27, 27, 27 },	/* IDSEL 2 - PCI Slot 1 */
+		{ 26, 26, 26, 26 },	/* IDSEL 3 - PCI Slot 2 */
+		{ 25, 25, 25, 25 },	/* IDSEL 4 - PCI Slot 3 */
+	};
+
+	const long min_idsel = 1, max_idsel = 4, irqs_per_slot = 4;
+	return PCI_IRQ_TABLE_LOOKUP;
+}
+
+static void __init bamboo_set_emacdata(void)
+{
+	unsigned char * selection1_base;
+	struct ocp_def *def;
+	struct ocp_func_emac_data *emacdata;
+	u8 selection1_val;
+	int mode;
+	
+	selection1_base = ioremap64(BAMBOO_FPGA_SELECTION1_REG_ADDR, 16);
+	selection1_val = readb(selection1_base);
+	iounmap((void *) selection1_base);
+	if (BAMBOO_SEL_MII(selection1_val))
+		mode = PHY_MODE_MII;
+	else if (BAMBOO_SEL_RMII(selection1_val))
+		mode = PHY_MODE_RMII;
+	else 
+		mode = PHY_MODE_SMII;
+	
+	/* Set mac_addr and phy mode for each EMAC */
+
+	def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 0);
+	emacdata = def->additions;
+	memcpy(emacdata->mac_addr, __res.bi_enetaddr, 6);
+	emacdata->phy_mode = mode;
+
+	def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 1);
+	emacdata = def->additions;
+	memcpy(emacdata->mac_addr, __res.bi_enet1addr, 6);
+	emacdata->phy_mode = mode;
+}
+
+static int
+bamboo_exclude_device(unsigned char bus, unsigned char devfn)
+{
+	return (bus == 0 && devfn == 0);
+}
+
+#define PCI_READW(offset) \
+        (readw((void *)((u32)pci_reg_base+offset)))
+
+#define PCI_WRITEW(value, offset) \
+	(writew(value, (void *)((u32)pci_reg_base+offset)))
+	
+#define PCI_WRITEL(value, offset) \
+	(writel(value, (void *)((u32)pci_reg_base+offset)))
+
+static void __init
+bamboo_setup_pci(void)
+{
+	void *pci_reg_base;
+	unsigned long memory_size;
+	memory_size = ppc_md.find_end_of_memory();
+
+	pci_reg_base = ioremap64(BAMBOO_PCIL0_BASE, BAMBOO_PCIL0_SIZE);
+
+	/* Enable PCI I/O, Mem, and Busmaster cycles */
+	PCI_WRITEW(PCI_READW(PCI_COMMAND) | 
+		   PCI_COMMAND_MEMORY | 
+		   PCI_COMMAND_MASTER, PCI_COMMAND);
+
+	/* Disable region first */
+	PCI_WRITEL(0, BAMBOO_PCIL0_PMM0MA);
+
+	/* PLB starting addr: 0x00000000A0000000 */
+	PCI_WRITEL(BAMBOO_PCI_PHY_MEM_BASE, BAMBOO_PCIL0_PMM0LA);
+
+	/* PCI start addr, 0xA0000000 (PCI Address) */
+	PCI_WRITEL(BAMBOO_PCI_MEM_BASE, BAMBOO_PCIL0_PMM0PCILA);
+	PCI_WRITEL(0, BAMBOO_PCIL0_PMM0PCIHA);
+
+	/* Enable no pre-fetch, enable region */
+	PCI_WRITEL(((0xffffffff - 
+		     (BAMBOO_PCI_UPPER_MEM - BAMBOO_PCI_MEM_BASE)) | 0x01), 
+		      BAMBOO_PCIL0_PMM0MA);
+	
+	/* Disable region one */
+	PCI_WRITEL(0, BAMBOO_PCIL0_PMM1MA);
+	PCI_WRITEL(0, BAMBOO_PCIL0_PMM1LA);
+	PCI_WRITEL(0, BAMBOO_PCIL0_PMM1PCILA);
+	PCI_WRITEL(0, BAMBOO_PCIL0_PMM1PCIHA);
+	PCI_WRITEL(0, BAMBOO_PCIL0_PMM1MA);
+	
+	/* Disable region two */
+	PCI_WRITEL(0, BAMBOO_PCIL0_PMM2MA);
+	PCI_WRITEL(0, BAMBOO_PCIL0_PMM2LA);
+	PCI_WRITEL(0, BAMBOO_PCIL0_PMM2PCILA);
+	PCI_WRITEL(0, BAMBOO_PCIL0_PMM2PCIHA);
+	PCI_WRITEL(0, BAMBOO_PCIL0_PMM2MA);
+	
+	/* Now configure the PCI->PLB windows, we only use PTM1
+	 *
+	 * For Inbound flow, set the window size to all available memory
+	 * This is required because if size is smaller,
+	 * then Eth/PCI DD would fail as PCI card not able to access
+	 * the memory allocated by DD.
+	 */
+	
+	PCI_WRITEL(0, BAMBOO_PCIL0_PTM1MS);	/* disabled region 1 */
+	PCI_WRITEL(0, BAMBOO_PCIL0_PTM1LA);	/* begin of address map */
+
+	memory_size = 1 << fls(memory_size - 1);
+
+	/* Size low + Enabled */
+	PCI_WRITEL((0xffffffff - (memory_size - 1)) | 0x1, BAMBOO_PCIL0_PTM1MS);
+	
+	eieio();
+	iounmap(pci_reg_base);
+}
+
+static void __init
+bamboo_setup_hose(void)
+{
+	unsigned int bar_response, bar;
+	struct pci_controller *hose;
+
+	bamboo_setup_pci();
+
+	hose = pcibios_alloc_controller();
+
+	if (!hose)
+		return;
+
+	hose->first_busno = 0;
+	hose->last_busno = 0xff;
+
+	hose->pci_mem_offset = BAMBOO_PCI_MEM_OFFSET;
+
+	pci_init_resource(&hose->io_resource,
+			BAMBOO_PCI_LOWER_IO,
+			BAMBOO_PCI_UPPER_IO,
+			IORESOURCE_IO,
+			"PCI host bridge");
+
+	pci_init_resource(&hose->mem_resources[0],
+			BAMBOO_PCI_LOWER_MEM,
+			BAMBOO_PCI_UPPER_MEM,
+			IORESOURCE_MEM,
+			"PCI host bridge");
+
+	ppc_md.pci_exclude_device = bamboo_exclude_device;
+
+	hose->io_space.start = BAMBOO_PCI_LOWER_IO;
+	hose->io_space.end = BAMBOO_PCI_UPPER_IO;
+	hose->mem_space.start = BAMBOO_PCI_LOWER_MEM;
+	hose->mem_space.end = BAMBOO_PCI_UPPER_MEM;
+	isa_io_base =
+		(unsigned long)ioremap64(BAMBOO_PCI_IO_BASE, BAMBOO_PCI_IO_SIZE);
+	hose->io_base_virt = (void *)isa_io_base;
+
+	setup_indirect_pci(hose,
+			BAMBOO_PCI_CFGA_PLB32,
+			BAMBOO_PCI_CFGD_PLB32);
+	hose->set_cfg_type = 1;
+
+	/* Zero config bars */
+	for (bar = PCI_BASE_ADDRESS_1; bar <= PCI_BASE_ADDRESS_2; bar += 4) {
+		early_write_config_dword(hose, hose->first_busno,
+					 PCI_FUNC(hose->first_busno), bar,
+					 0x00000000);
+		early_read_config_dword(hose, hose->first_busno,
+					PCI_FUNC(hose->first_busno), bar,
+					&bar_response);
+	}
+
+	hose->last_busno = pciauto_bus_scan(hose, hose->first_busno);
+
+	ppc_md.pci_swizzle = common_swizzle;
+	ppc_md.pci_map_irq = bamboo_map_irq;
+}
+
+TODC_ALLOC();
+
+static void __init
+bamboo_early_serial_map(void)
+{
+	struct uart_port port;
+
+	/* Setup ioremapped serial port access */
+	memset(&port, 0, sizeof(port));
+	port.membase = ioremap64(PPC440EP_UART0_ADDR, 8);
+	port.irq = 0;
+	port.uartclk = clocks.uart0;
+	port.regshift = 0;
+	port.iotype = SERIAL_IO_MEM;
+	port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
+	port.line = 0;
+
+	if (early_serial_setup(&port) != 0) {
+		printk("Early serial init of port 0 failed\n");
+	}
+
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+	/* Configure debug serial access */
+	gen550_init(0, &port);
+#endif
+
+	port.membase = ioremap64(PPC440EP_UART1_ADDR, 8);
+	port.irq = 1;
+	port.uartclk = clocks.uart1;
+	port.line = 1;
+
+	if (early_serial_setup(&port) != 0) {
+		printk("Early serial init of port 1 failed\n");
+	}
+
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+	/* Configure debug serial access */
+	gen550_init(1, &port);
+#endif
+
+	port.membase = ioremap64(PPC440EP_UART2_ADDR, 8);
+	port.irq = 3;
+	port.uartclk = clocks.uart2;
+	port.line = 2;
+
+	if (early_serial_setup(&port) != 0) {
+		printk("Early serial init of port 2 failed\n");
+	}
+
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+	/* Configure debug serial access */
+	gen550_init(2, &port);
+#endif
+
+	port.membase = ioremap64(PPC440EP_UART3_ADDR, 8);
+	port.irq = 4;
+	port.uartclk = clocks.uart3;
+	port.line = 3;
+
+	if (early_serial_setup(&port) != 0) {
+		printk("Early serial init of port 3 failed\n");
+	}
+}
+
+static void __init
+bamboo_setup_arch(void)
+{
+
+	bamboo_set_emacdata();
+
+	ibm440gx_get_clocks(&clocks, 33333333, 6 * 1843200);
+	ocp_sys_info.opb_bus_freq = clocks.opb;
+
+	/* Setup TODC access */
+	TODC_INIT(TODC_TYPE_DS1743,
+			0,
+			0,
+			ioremap64(BAMBOO_RTC_ADDR, BAMBOO_RTC_SIZE),
+			8);
+
+	/* init to some ~sane value until calibrate_delay() runs */
+        loops_per_jiffy = 50000000/HZ;
+
+	/* Setup PCI host bridge */
+	bamboo_setup_hose();
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	if (initrd_start)
+		ROOT_DEV = Root_RAM0;
+	else
+#endif
+#ifdef CONFIG_ROOT_NFS
+		ROOT_DEV = Root_NFS;
+#else
+		ROOT_DEV = Root_HDA1;
+#endif
+
+	bamboo_early_serial_map();
+
+	/* Identify the system */
+	printk("IBM Bamboo port (MontaVista Software, Inc. (source@mvista.com))\n");
+}
+
+void __init platform_init(unsigned long r3, unsigned long r4,
+		unsigned long r5, unsigned long r6, unsigned long r7)
+{
+	parse_bootinfo(find_bootinfo());
+
+	/*
+	 * If we were passed in a board information, copy it into the
+	 * residual data area.
+	 */
+	if (r3)
+		__res = *(bd_t *)(r3 + KERNELBASE);
+
+
+	ibm44x_platform_init();
+
+	ppc_md.setup_arch = bamboo_setup_arch;
+	ppc_md.show_cpuinfo = bamboo_show_cpuinfo;
+	ppc_md.get_irq = NULL;		/* Set in ppc4xx_pic_init() */
+
+	ppc_md.calibrate_decr = bamboo_calibrate_decr;
+	ppc_md.time_init = todc_time_init;
+	ppc_md.set_rtc_time = todc_set_rtc_time;
+	ppc_md.get_rtc_time = todc_get_rtc_time;
+
+	ppc_md.nvram_read_val = todc_direct_read_val;
+	ppc_md.nvram_write_val = todc_direct_write_val;
+#ifdef CONFIG_KGDB
+	ppc_md.early_serial_map = bamboo_early_serial_map;
+#endif
+}
+
diff --git a/arch/ppc/platforms/4xx/bamboo.h b/arch/ppc/platforms/4xx/bamboo.h
new file mode 100644
--- /dev/null
+++ b/arch/ppc/platforms/4xx/bamboo.h
@@ -0,0 +1,136 @@
+/*
+ * arch/ppc/platforms/bamboo.h
+ *
+ * Bamboo board definitions
+ *
+ * Wade Farnsworth <wfarnsworth@mvista.com>
+ *
+ * Copyright 2004 MontaVista Software Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifdef __KERNEL__
+#ifndef __ASM_BAMBOO_H__
+#define __ASM_BAMBOO_H__
+
+#include <linux/config.h>
+#include <platforms/4xx/ibm440ep.h>
+
+/* F/W TLB mapping used in bootloader glue to reset EMAC */
+#define PPC44x_EMAC0_MR0		0x0EF600E00
+
+/* Location of MAC addresses in PIBS image */
+#define PIBS_FLASH_BASE			0xfff00000
+#define PIBS_MAC_BASE			(PIBS_FLASH_BASE+0xc0400)
+#define PIBS_MAC_SIZE			0x200
+#define PIBS_MAC_OFFSET			0x100
+
+/* Default clock rate */
+#define BAMBOO_TMRCLK			25000000
+
+/* RTC/NVRAM location */
+#define BAMBOO_RTC_ADDR			0x080000000ULL
+#define BAMBOO_RTC_SIZE			0x2000
+
+/* FPGA Registers */
+#define BAMBOO_FPGA_ADDR		0x080002000ULL
+
+#define BAMBOO_FPGA_CONFIG2_REG_ADDR	(BAMBOO_FPGA_ADDR + 0x1)
+#define BAMBOO_FULL_DUPLEX_EN(x)	(x & 0x08)
+#define BAMBOO_FORCE_100Mbps(x)		(x & 0x04)
+#define BAMBOO_AUTONEGOTIATE(x)		(x & 0x02)
+
+#define BAMBOO_FPGA_SETTING_REG_ADDR	(BAMBOO_FPGA_ADDR + 0x3)
+#define BAMBOO_BOOT_SMALL_FLASH(x)	(!(x & 0x80))
+#define BAMBOO_LARGE_FLASH_EN(x)	(!(x & 0x40))
+#define BAMBOO_BOOT_NAND_FLASH(x)	(!(x & 0x20))
+
+#define BAMBOO_FPGA_SELECTION1_REG_ADDR (BAMBOO_FPGA_ADDR + 0x4)
+#define BAMBOO_SEL_MII(x)		(x & 0x80)
+#define BAMBOO_SEL_RMII(x)		(x & 0x40)
+#define BAMBOO_SEL_SMII(x)		(x & 0x20)
+
+/* Flash */
+#define BAMBOO_SMALL_FLASH_LOW		0x087f00000ULL
+#define BAMBOO_SMALL_FLASH_HIGH		0x0fff00000ULL
+#define BAMBOO_SMALL_FLASH_SIZE		0x100000
+#define BAMBOO_LARGE_FLASH_LOW		0x087800000ULL
+#define BAMBOO_LARGE_FLASH_HIGH1	0x0ff800000ULL
+#define BAMBOO_LARGE_FLASH_HIGH2	0x0ffc00000ULL
+#define BAMBOO_LARGE_FLASH_SIZE		0x400000
+#define BAMBOO_SRAM_LOW			0x087f00000ULL
+#define BAMBOO_SRAM_HIGH1		0x0fff00000ULL
+#define BAMBOO_SRAM_HIGH2		0x0ff800000ULL
+#define BAMBOO_SRAM_SIZE		0x100000
+#define BAMBOO_NAND_FLASH_REG_ADDR	0x090000000ULL
+#define BAMBOO_NAND_FLASH_REG_SIZE	0x2000
+
+/*
+ * Serial port defines
+ */
+#define RS_TABLE_SIZE			4
+
+#define UART0_IO_BASE			0xEF600300
+#define UART1_IO_BASE			0xEF600400
+#define UART2_IO_BASE			0xEF600500
+#define UART3_IO_BASE			0xEF600600
+
+#define BASE_BAUD			33177600/3/16
+#define UART0_INT			0
+#define UART1_INT			1
+#define UART2_INT			3
+#define UART3_INT			4
+
+#define STD_UART_OP(num)					\
+	{ 0, BASE_BAUD, 0, UART##num##_INT,			\
+		(ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST),	\
+		iomem_base: UART##num##_IO_BASE,		\
+		io_type: SERIAL_IO_MEM},
+
+#define SERIAL_PORT_DFNS	\
+	STD_UART_OP(0)		\
+	STD_UART_OP(1)		\
+	STD_UART_OP(2)		\
+	STD_UART_OP(3)
+
+/* PCI support */
+#define BAMBOO_PCI_CFGA_PLB32		0xeec00000
+#define BAMBOO_PCI_CFGD_PLB32		0xeec00004
+
+#define BAMBOO_PCI_IO_BASE		0x00000000e8000000ULL
+#define BAMBOO_PCI_IO_SIZE		0x00010000
+#define BAMBOO_PCI_MEM_OFFSET		0x00000000
+#define BAMBOO_PCI_PHY_MEM_BASE		0x00000000a0000000ULL
+
+#define BAMBOO_PCI_LOWER_IO		0x00000000
+#define BAMBOO_PCI_UPPER_IO		0x0000ffff
+#define BAMBOO_PCI_LOWER_MEM		0xa0000000
+#define BAMBOO_PCI_UPPER_MEM		0xafffffff
+#define BAMBOO_PCI_MEM_BASE		0xa0000000
+
+#define BAMBOO_PCIL0_BASE		0x00000000ef400000ULL
+#define BAMBOO_PCIL0_SIZE		0x40
+
+#define BAMBOO_PCIL0_PMM0LA		0x000
+#define BAMBOO_PCIL0_PMM0MA		0x004
+#define BAMBOO_PCIL0_PMM0PCILA		0x008
+#define BAMBOO_PCIL0_PMM0PCIHA		0x00C
+#define BAMBOO_PCIL0_PMM1LA		0x010
+#define BAMBOO_PCIL0_PMM1MA		0x014
+#define BAMBOO_PCIL0_PMM1PCILA		0x018
+#define BAMBOO_PCIL0_PMM1PCIHA		0x01C
+#define BAMBOO_PCIL0_PMM2LA		0x020
+#define BAMBOO_PCIL0_PMM2MA		0x024
+#define BAMBOO_PCIL0_PMM2PCILA		0x028
+#define BAMBOO_PCIL0_PMM2PCIHA		0x02C
+#define BAMBOO_PCIL0_PTM1MS		0x030
+#define BAMBOO_PCIL0_PTM1LA		0x034
+#define BAMBOO_PCIL0_PTM2MS		0x038
+#define BAMBOO_PCIL0_PTM2LA		0x03C
+	
+#endif                          /* __ASM_BAMBOO_H__ */
+#endif                          /* __KERNEL__ */

