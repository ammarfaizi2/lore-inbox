Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVFCUda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVFCUda (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 16:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVFCUd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 16:33:29 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:37631 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261354AbVFCUdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 16:33:06 -0400
Date: Fri, 3 Jun 2005 15:32:47 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org, msm@freescale.com
Subject: [PATCH] ppc32: Converted MPC10X bridge to use platform devices
 instead of OCP
Message-ID: <Pine.LNX.4.61.0506031532120.8389@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Converted the MPC10x bridge support (used by MPC10x and 8240/1/5) to
used the standard platform device model.

Signed-off-by: Matt McClintock <msm@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit c4fa624a5c007f17142ab5225d1085564ffa8f83
tree 63546f2e7de561696db29a0a481bf40c449e9f0e
parent e832e0d9e4878d02ab2ef6bad5971dc9f9cd7679
author Kumar K. Gala <kumar.gala@freescale.com> Fri, 03 Jun 2005 14:20:50 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Fri, 03 Jun 2005 14:20:50 -0500

 arch/ppc/Kconfig                |    5 -
 arch/ppc/kernel/setup.c         |    4 
 arch/ppc/syslib/Makefile        |    2 
 arch/ppc/syslib/mpc10x_common.c |  177 +++++++++++++++++++++++++++++----------
 include/asm-ppc/mpc10x.h        |    6 +
 include/asm-ppc/ppc_sys.h       |    2 
 6 files changed, 144 insertions(+), 52 deletions(-)

diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -826,11 +826,6 @@ config MPC10X_BRIDGE
 	depends on PCORE || POWERPMC250 || LOPEC || SANDPOINT
 	default y
 
-config FSL_OCP
-	bool
-	depends on MPC10X_BRIDGE
-	default y
-
 config MPC10X_OPENPIC
 	bool
 	depends on POWERPMC250 || LOPEC || SANDPOINT
diff --git a/arch/ppc/kernel/setup.c b/arch/ppc/kernel/setup.c
--- a/arch/ppc/kernel/setup.c
+++ b/arch/ppc/kernel/setup.c
@@ -41,7 +41,7 @@
 #include <asm/xmon.h>
 #include <asm/ocp.h>
 
-#if defined(CONFIG_85xx) || defined(CONFIG_83xx)
+#if defined(CONFIG_85xx) || defined(CONFIG_83xx) || defined(CONFIG_MPC10X_BRIDGE)
 #include <asm/ppc_sys.h>
 #endif
 
@@ -249,7 +249,7 @@ int show_cpuinfo(struct seq_file *m, voi
 	seq_printf(m, "bogomips\t: %lu.%02lu\n",
 		   lpj / (500000/HZ), (lpj / (5000/HZ)) % 100);
 
-#if defined(CONFIG_85xx) || defined(CONFIG_83xx)
+#if defined(CONFIG_85xx) || defined(CONFIG_83xx) || defined(CONFIG_MPC10X_BRIDGE)
 	if (cur_ppc_sys_spec->ppc_sys_name)
 		seq_printf(m, "chipset\t\t: %s\n",
 			cur_ppc_sys_spec->ppc_sys_name);
diff --git a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile
+++ b/arch/ppc/syslib/Makefile
@@ -92,7 +92,7 @@ ifeq ($(CONFIG_SERIAL_MPSC_CONSOLE),y)
 obj-$(CONFIG_SERIAL_TEXT_DEBUG)	+= mv64x60_dbg.o
 endif
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
-obj-$(CONFIG_MPC10X_BRIDGE)     += mpc10x_common.o indirect_pci.o
+obj-$(CONFIG_MPC10X_BRIDGE)	+= mpc10x_common.o indirect_pci.o ppc_sys.o
 obj-$(CONFIG_MPC10X_OPENPIC)	+= open_pic.o
 obj-$(CONFIG_40x)		+= dcr.o
 obj-$(CONFIG_BOOKE)		+= dcr.o
diff --git a/arch/ppc/syslib/mpc10x_common.c b/arch/ppc/syslib/mpc10x_common.c
--- a/arch/ppc/syslib/mpc10x_common.c
+++ b/arch/ppc/syslib/mpc10x_common.c
@@ -21,6 +21,9 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <linux/serial_8250.h>
+#include <linux/fsl_devices.h>
+#include <linux/device.h>
 
 #include <asm/byteorder.h>
 #include <asm/io.h>
@@ -30,16 +33,7 @@
 #include <asm/pci-bridge.h>
 #include <asm/open_pic.h>
 #include <asm/mpc10x.h>
-#include <asm/ocp.h>
-
-/* The OCP structure is fixed by code below, before OCP initialises.
-   paddr depends on where the board places the EUMB.
-    - fixed in mpc10x_bridge_init().
-   irq depends on two things:
-    > does the board use the EPIC at all? (PCORE does not).
-    > is the EPIC in serial or parallel mode?
-    - fixed in mpc10x_set_openpic().
-*/
+#include <asm/ppc_sys.h>
 
 #ifdef CONFIG_MPC10X_OPENPIC
 #ifdef CONFIG_EPIC_SERIAL_MODE
@@ -51,34 +45,127 @@
 #define MPC10X_DMA0_IRQ (EPIC_IRQ_BASE + 1 + NUM_8259_INTERRUPTS)
 #define MPC10X_DMA1_IRQ (EPIC_IRQ_BASE + 2 + NUM_8259_INTERRUPTS)
 #else
-#define MPC10X_I2C_IRQ OCP_IRQ_NA
-#define MPC10X_DMA0_IRQ OCP_IRQ_NA
-#define MPC10X_DMA1_IRQ OCP_IRQ_NA
+#define MPC10X_I2C_IRQ -1
+#define MPC10X_DMA0_IRQ -1
+#define MPC10X_DMA1_IRQ -1
 #endif
 
-
-struct ocp_def core_ocp[] = {
-	{ .vendor	= OCP_VENDOR_INVALID
-	}
+static struct fsl_i2c_platform_data mpc10x_i2c_pdata = {
+	.device_flags		= 0,
 };
 
-static struct ocp_fs_i2c_data mpc10x_i2c_data = {
-	.flags		= 0
+static struct plat_serial8250_port serial_platform_data[] = {
+	{ },
 };
-static struct ocp_def mpc10x_i2c_ocp = {
-	.vendor		= OCP_VENDOR_MOTOROLA,
-	.function	= OCP_FUNC_IIC,
-	.index		= 0,
-	.additions	= &mpc10x_i2c_data
+
+struct platform_device ppc_sys_platform_devices[] = {
+	[MPC10X_IIC1] = {
+		.name 	= "fsl-i2c",
+		.id	= 1,
+		.dev.platform_data = &mpc10x_i2c_pdata,
+		.num_resources = 2,
+		.resource = (struct resource[]) {
+			{
+				.start 	= MPC10X_EUMB_I2C_OFFSET,
+				.end	= MPC10X_EUMB_I2C_OFFSET +
+		                            MPC10X_EUMB_I2C_SIZE - 1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.flags 	= IORESOURCE_IRQ
+			},
+		},
+	},
+	[MPC10X_DMA0] = {
+		.name	= "fsl-dma",
+		.id	= 0,
+		.num_resources = 2,
+		.resource = (struct resource[]) {
+			{
+				.start 	= MPC10X_EUMB_DMA_OFFSET + 0x10,
+				.end	= MPC10X_EUMB_DMA_OFFSET + 0x1f,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC10X_DMA1] = {
+		.name	= "fsl-dma",
+		.id	= 1,
+		.num_resources = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC10X_EUMB_DMA_OFFSET + 0x20,
+				.end	= MPC10X_EUMB_DMA_OFFSET + 0x2f,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC10X_DMA1] = {
+		.name	= "fsl-dma",
+		.id	= 1,
+		.num_resources = 2,
+		.resource = (struct resource[]) {
+			{
+				.start	= MPC10X_EUMB_DMA_OFFSET + 0x20,
+				.end	= MPC10X_EUMB_DMA_OFFSET + 0x2f,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC10X_DUART] = {
+		.name = "serial8250",
+		.id	= 0,
+		.dev.platform_data = serial_platform_data,
+	},
 };
 
-static struct ocp_def mpc10x_dma_ocp[2] = {
-{	.vendor		= OCP_VENDOR_MOTOROLA,
-	.function	= OCP_FUNC_DMA,
-	.index		= 0 },
-{	.vendor		= OCP_VENDOR_MOTOROLA,
-	.function	= OCP_FUNC_DMA,
-	.index		= 1 }
+/* We use the PCI ID to match on */
+struct ppc_sys_spec *cur_ppc_sys_spec;
+struct ppc_sys_spec ppc_sys_specs[] = {
+	{
+		.ppc_sys_name 	= "8245",
+		.mask		= 0xFFFFFFFF,
+		.value		= MPC10X_BRIDGE_8245,
+		.num_devices	= 4,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC10X_IIC1, MPC10X_DMA0, MPC10X_DMA1, MPC10X_DUART,
+		},
+	},
+	{
+		.ppc_sys_name 	= "8240",
+		.mask		= 0xFFFFFFFF,
+		.value		= MPC10X_BRIDGE_8240,
+		.num_devices	= 3,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC10X_IIC1, MPC10X_DMA0, MPC10X_DMA1,
+		},
+	},
+	{
+		.ppc_sys_name	= "107",
+		.mask		= 0xFFFFFFFF,
+		.value		= MPC10X_BRIDGE_107,
+		.num_devices	= 3,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC10X_IIC1, MPC10X_DMA0, MPC10X_DMA1,
+		},
+	},
+	{       /* default match */
+		.ppc_sys_name   = "",
+		.mask           = 0x00000000,
+		.value          = 0x00000000,
+	},
 };
 
 /* Set resources to match bridge memory map */
@@ -273,7 +360,7 @@ mpc10x_bridge_init(struct pci_controller
 			printk("Host bridge in Agent mode\n");
 			/* Read or Set LMBAR & PCSRBAR? */
 		}
-		
+
 		/* Set base addr of the 8240/107 EUMB.  */
 		early_write_config_dword(hose,
 					 0,
@@ -287,17 +374,6 @@ mpc10x_bridge_init(struct pci_controller
 			ioremap(phys_eumb_base + MPC10X_EUMB_EPIC_OFFSET,
 				MPC10X_EUMB_EPIC_SIZE);
 #endif
-		mpc10x_i2c_ocp.paddr = phys_eumb_base + MPC10X_EUMB_I2C_OFFSET;
-		mpc10x_i2c_ocp.irq = MPC10X_I2C_IRQ;
-		ocp_add_one_device(&mpc10x_i2c_ocp);
-		mpc10x_dma_ocp[0].paddr = phys_eumb_base +
-					MPC10X_EUMB_DMA_OFFSET + 0x100;
-		mpc10x_dma_ocp[0].irq = MPC10X_DMA0_IRQ;
-		ocp_add_one_device(&mpc10x_dma_ocp[0]);
-		mpc10x_dma_ocp[1].paddr = phys_eumb_base +
-					MPC10X_EUMB_DMA_OFFSET + 0x200;
-		mpc10x_dma_ocp[1].irq = MPC10X_DMA1_IRQ;
-		ocp_add_one_device(&mpc10x_dma_ocp[1]);
 	}
 
 #ifdef CONFIG_MPC10X_STORE_GATHERING
@@ -330,7 +406,7 @@ mpc10x_bridge_init(struct pci_controller
 	 * 8245 (Rev 2., dated 10/2003) says PICR2[0] is reserverd.
 	 */
 	if (host_bridge == MPC10X_BRIDGE_8245) {
-		ulong	picr2;
+		u32	picr2;
 
 		early_read_config_dword(hose, 0, PCI_DEVFN(0,0),
 			MPC10X_CFG_PICR2_REG, &picr2);
@@ -340,6 +416,19 @@ mpc10x_bridge_init(struct pci_controller
 		early_write_config_dword(hose, 0, PCI_DEVFN(0,0),
 			 MPC10X_CFG_PICR2_REG, picr2);
 	}
+
+	ppc_sys_fixup_mem_resource (ppc_sys_platform_devices,
+					phys_eumb_base);
+
+	/* IRQ's are determined at runtime */
+	ppc_sys_platform_devices[MPC10X_IIC1].resource[1].start = MPC10X_I2C_IRQ;
+	ppc_sys_platform_devices[MPC10X_IIC1].resource[1].end = MPC10X_I2C_IRQ;
+	ppc_sys_platform_devices[MPC10X_DMA0].resource[1].start = MPC10X_DMA0_IRQ;
+	ppc_sys_platform_devices[MPC10X_DMA0].resource[1].end = MPC10X_DMA0_IRQ;
+	ppc_sys_platform_devices[MPC10X_DMA1].resource[1].start = MPC10X_DMA1_IRQ;
+	ppc_sys_platform_devices[MPC10X_DMA1].resource[1].end = MPC10X_DMA1_IRQ;
+
+	identify_ppc_sys_by_id (host_bridge);
 
 	if (ppc_md.progress) ppc_md.progress("mpc10x:exit", 0x100);
 	return 0;
diff --git a/include/asm-ppc/mpc10x.h b/include/asm-ppc/mpc10x.h
--- a/include/asm-ppc/mpc10x.h
+++ b/include/asm-ppc/mpc10x.h
@@ -159,6 +159,12 @@ extern unsigned long			ioremap_base;
 #define	MPC10X_MAPA_EUMB_BASE		(ioremap_base - MPC10X_EUMB_SIZE)
 #define	MPC10X_MAPB_EUMB_BASE		MPC10X_MAPA_EUMB_BASE
 
+enum ppc_sys_devices {
+	MPC10X_IIC1,
+	MPC10X_DMA0,
+	MPC10X_DMA1,
+	MPC10X_DUART,
+};
 
 int mpc10x_bridge_init(struct pci_controller *hose,
 		       uint current_map,
diff --git a/include/asm-ppc/ppc_sys.h b/include/asm-ppc/ppc_sys.h
--- a/include/asm-ppc/ppc_sys.h
+++ b/include/asm-ppc/ppc_sys.h
@@ -27,6 +27,8 @@
 #include <asm/mpc85xx.h>
 #elif defined(CONFIG_PPC_MPC52xx)
 #include <asm/mpc52xx.h>
+#elif defined(CONFIG_MPC10X_BRIDGE)
+#include <asm/mpc10x.h>
 #else
 #error "need definition of ppc_sys_devices"
 #endif
