Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbVHKEPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbVHKEPv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 00:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbVHKEPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 00:15:51 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:47795 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S932246AbVHKEPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 00:15:50 -0400
Date: Wed, 10 Aug 2005 23:15:32 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>, msm@freescale.com
Subject: [PATCH] ppc32: Add ppc_sys descriptions for PowerQUICC II devices
Message-ID: <Pine.LNX.4.61.0508102315001.13554@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added ppc_sys device and system definitions for PowerQUICC II devices.
This will allow drivers for PQ2 to be proper platform device drivers.
Which can be shared on PQ3 processors with the same peripherals.

Signed-off-by: Matt McClintock <msm@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 31937ee5383892a5236505c8bbad8715fbfbfadf
tree 30c204867add0d919be4dc7fc5e02e749cea34d2
parent b53ff9c2e3f62d23f4dd9ca3e312968d1466c188
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 10 Aug 2005 23:14:26 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 10 Aug 2005 23:14:26 -0500

 arch/ppc/kernel/setup.c       |    8 +
 arch/ppc/syslib/Makefile      |    3 
 arch/ppc/syslib/pq2_devices.c |  389 +++++++++++++++++++++++++++++++++++++++++
 arch/ppc/syslib/pq2_sys.c     |  200 +++++++++++++++++++++
 include/asm-ppc/irq.h         |    1 
 include/asm-ppc/mpc8260.h     |   18 ++
 include/asm-ppc/ppc_sys.h     |    4 
 7 files changed, 619 insertions(+), 4 deletions(-)

diff --git a/arch/ppc/kernel/setup.c b/arch/ppc/kernel/setup.c
--- a/arch/ppc/kernel/setup.c
+++ b/arch/ppc/kernel/setup.c
@@ -41,7 +41,11 @@
 #include <asm/xmon.h>
 #include <asm/ocp.h>
 
-#if defined(CONFIG_85xx) || defined(CONFIG_83xx) || defined(CONFIG_MPC10X_BRIDGE)
+#define USES_PPC_SYS (defined(CONFIG_85xx) || defined(CONFIG_83xx) || \
+		      defined(CONFIG_MPC10X_BRIDGE) || defined(CONFIG_8260) || \
+		      defined(CONFIG_PPC_MPC52xx))
+
+#if USES_PPC_SYS
 #include <asm/ppc_sys.h>
 #endif
 
@@ -241,7 +245,7 @@ int show_cpuinfo(struct seq_file *m, voi
 	seq_printf(m, "bogomips\t: %lu.%02lu\n",
 		   lpj / (500000/HZ), (lpj / (5000/HZ)) % 100);
 
-#if defined(CONFIG_85xx) || defined(CONFIG_83xx) || defined(CONFIG_MPC10X_BRIDGE)
+#if USES_PPC_SYS
 	if (cur_ppc_sys_spec->ppc_sys_name)
 		seq_printf(m, "chipset\t\t: %s\n",
 			cur_ppc_sys_spec->ppc_sys_name);
diff --git a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile
+++ b/arch/ppc/syslib/Makefile
@@ -82,7 +82,8 @@ obj-$(CONFIG_SANDPOINT)		+= i8259.o pci_
 obj-$(CONFIG_SBC82xx)		+= todc_time.o
 obj-$(CONFIG_SPRUCE)		+= cpc700_pic.o indirect_pci.o pci_auto.o \
 				   todc_time.o
-obj-$(CONFIG_8260)		+= m8260_setup.o
+obj-$(CONFIG_8260)		+= m8260_setup.o pq2_devices.o pq2_sys.o \
+				   ppc_sys.o
 obj-$(CONFIG_PCI_8260)		+= m82xx_pci.o indirect_pci.o pci_auto.o
 obj-$(CONFIG_8260_PCI9)		+= m8260_pci_erratum9.o
 obj-$(CONFIG_CPM2)		+= cpm2_common.o cpm2_pic.o
diff --git a/arch/ppc/syslib/pq2_devices.c b/arch/ppc/syslib/pq2_devices.c
new file mode 100644
--- /dev/null
+++ b/arch/ppc/syslib/pq2_devices.c
@@ -0,0 +1,389 @@
+/*
+ * arch/ppc/syslib/pq2_devices.c
+ *
+ * PQ2 Device descriptions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/ioport.h>
+#include <asm/cpm2.h>
+#include <asm/irq.h>
+#include <asm/ppc_sys.h>
+
+struct platform_device ppc_sys_platform_devices[] = {
+	[MPC82xx_CPM_FCC1] = {
+		.name = "fsl-cpm-fcc",
+		.id	= 1,
+		.num_resources	 = 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "fcc_regs",
+				.start	= 0x11300,
+				.end	= 0x1131f,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "fcc_pram",
+				.start	= 0x8400,
+				.end	= 0x84ff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= SIU_INT_FCC1,
+				.end	= SIU_INT_FCC1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC82xx_CPM_FCC2] = {
+		.name = "fsl-cpm-fcc",
+		.id	= 2,
+		.num_resources	 = 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "fcc_regs",
+				.start	= 0x11320,
+				.end	= 0x1133f,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "fcc_pram",
+				.start	= 0x8500,
+				.end	= 0x85ff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= SIU_INT_FCC2,
+				.end	= SIU_INT_FCC2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC82xx_CPM_FCC3] = {
+		.name = "fsl-cpm-fcc",
+		.id	= 3,
+		.num_resources	 = 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "fcc_regs",
+				.start	= 0x11340,
+				.end	= 0x1135f,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "fcc_pram",
+				.start	= 0x8600,
+				.end	= 0x86ff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= SIU_INT_FCC3,
+				.end	= SIU_INT_FCC3,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC82xx_CPM_I2C] = {
+		.name = "fsl-cpm-i2c",
+		.id	= 1,
+		.num_resources	 = 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "i2c_mem",
+				.start	= 0x11860,
+				.end	= 0x118BF,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "i2c_pram",
+				.start 	= 0x8afc,
+				.end	= 0x8afd,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= SIU_INT_I2C,
+				.end	= SIU_INT_I2C,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC82xx_CPM_SCC1] = {
+		.name = "fsl-cpm-scc",
+		.id	= 1,
+		.num_resources	 = 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "scc_mem",
+				.start	= 0x11A00,
+				.end	= 0x11A1F,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "scc_pram",
+				.start	= 0x8000,
+				.end	= 0x80ff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= SIU_INT_SCC1,
+				.end	= SIU_INT_SCC1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC82xx_CPM_SCC2] = {
+		.name = "fsl-cpm-scc",
+		.id	= 2,
+		.num_resources	 = 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "scc_mem",
+				.start	= 0x11A20,
+				.end	= 0x11A3F,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "scc_pram",
+				.start	= 0x8100,
+				.end	= 0x81ff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= SIU_INT_SCC2,
+				.end	= SIU_INT_SCC2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC82xx_CPM_SCC3] = {
+		.name = "fsl-cpm-scc",
+		.id	= 3,
+		.num_resources	 = 3,
+		.resource = (struct resource[]) {
+			{
+				.name 	= "scc_mem",
+				.start	= 0x11A40,
+				.end	= 0x11A5F,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "scc_pram",
+				.start	= 0x8200,
+				.end	= 0x82ff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= SIU_INT_SCC3,
+				.end	= SIU_INT_SCC3,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC82xx_CPM_SCC4] = {
+		.name = "fsl-cpm-scc",
+		.id	= 4,
+		.num_resources	 = 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "scc_mem",
+				.start	= 0x11A60,
+				.end	= 0x11A7F,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "scc_pram",
+				.start	= 0x8300,
+				.end	= 0x83ff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= SIU_INT_SCC4,
+				.end	= SIU_INT_SCC4,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC82xx_CPM_SPI] = {
+		.name = "fsl-cpm-spi",
+		.id	= 1,
+		.num_resources	 = 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "spi_mem",
+				.start	= 0x11AA0,
+				.end	= 0x11AFF,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "spi_pram",
+				.start	= 0x89fc,
+				.end	= 0x89fd,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= SIU_INT_SPI,
+				.end	= SIU_INT_SPI,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC82xx_CPM_MCC1] = {
+		.name = "fsl-cpm-mcc",
+		.id	= 1,
+		.num_resources	 = 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "mcc_mem",
+				.start	= 0x11B30,
+				.end	= 0x11B3F,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "mcc_pram",
+				.start	= 0x8700,
+				.end	= 0x877f,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= SIU_INT_MCC1,
+				.end	= SIU_INT_MCC1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC82xx_CPM_MCC2] = {
+		.name = "fsl-cpm-mcc",
+		.id	= 2,
+		.num_resources	 = 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "mcc_mem",
+				.start	= 0x11B50,
+				.end	= 0x11B5F,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "mcc_pram",
+				.start	= 0x8800,
+				.end	= 0x887f,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= SIU_INT_MCC2,
+				.end	= SIU_INT_MCC2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC82xx_CPM_SMC1] = {
+		.name = "fsl-cpm-smc",
+		.id	= 1,
+		.num_resources	 = 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "smc_mem",
+				.start	= 0x11A80,
+				.end	= 0x11A8F,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "smc_pram",
+				.start	= 0x87fc,
+				.end	= 0x87fd,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= SIU_INT_SMC1,
+				.end	= SIU_INT_SMC1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC82xx_CPM_SMC2] = {
+		.name = "fsl-cpm-smc",
+		.id	= 2,
+		.num_resources	 = 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "smc_mem",
+				.start	= 0x11A90,
+				.end	= 0x11A9F,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "smc_pram",
+				.start	= 0x88fc,
+				.end	= 0x88fd,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.start	= SIU_INT_SMC2,
+				.end	= SIU_INT_SMC2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC82xx_CPM_USB] = {
+		.name = "fsl-cpm-usb",
+		.id	= 1,
+		.num_resources	= 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "usb_mem",
+				.start	= 0x11b60,
+				.end	= 0x11b78,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "usb_pram",
+				.start	= 0x8b00,
+				.end	= 0x8bff,
+				.flags 	= IORESOURCE_MEM,
+			},
+			{
+				.start	= SIU_INT_USB,
+				.end	= SIU_INT_USB,
+				.flags	= IORESOURCE_IRQ,
+			},
+
+		},
+	},
+	[MPC82xx_SEC1] = {
+		.name = "fsl-sec",
+		.id = 1,
+		.num_resources = 1,
+		.resource = (struct resource[]) {
+			{
+				.name	= "sec_mem",
+				.start	= 0x40000,
+				.end	= 0x52fff,
+				.flags	= IORESOURCE_MEM,
+			},
+		},
+	},
+};
+
+static int __init mach_mpc82xx_fixup(struct platform_device *pdev)
+{
+	ppc_sys_fixup_mem_resource(pdev, CPM_MAP_ADDR);
+	return 0;
+}
+
+static int __init mach_mpc82xx_init(void)
+{
+	if (ppc_md.progress)
+		ppc_md.progress("mach_mpc82xx_init:enter", 0);
+	ppc_sys_device_fixup = mach_mpc82xx_fixup;
+	return 0;
+}
+
+postcore_initcall(mach_mpc82xx_init);
diff --git a/arch/ppc/syslib/pq2_sys.c b/arch/ppc/syslib/pq2_sys.c
new file mode 100644
--- /dev/null
+++ b/arch/ppc/syslib/pq2_sys.c
@@ -0,0 +1,200 @@
+/*
+ * arch/ppc/syslib/pq2_devices.c
+ *
+ * PQ2 System descriptions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+
+#include <asm/ppc_sys.h>
+
+struct ppc_sys_spec *cur_ppc_sys_spec;
+struct ppc_sys_spec ppc_sys_specs[] = {
+	/* below is a list of the 8260 family of processors */
+	{
+		.ppc_sys_name	= "8250",
+		.mask		= 0x0000ff00,
+		.value		= 0x00000000,
+		.num_devices	= 12,
+		.device_list = (enum ppc_sys_devices[])
+		{
+			MPC82xx_CPM_FCC1, MPC82xx_CPM_FCC2, MPC82xx_CPM_FCC3,
+			MPC82xx_CPM_SCC1, MPC82xx_CPM_SCC2, MPC82xx_CPM_SCC3,
+			MPC82xx_CPM_SCC4, MPC82xx_CPM_MCC1, MPC82xx_CPM_SMC1,
+			MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI, MPC82xx_CPM_I2C,
+		}
+	},
+	{
+		.ppc_sys_name	= "8255",
+		.mask		= 0x0000ff00,
+		.value		= 0x00000000,
+		.num_devices	= 11,
+		.device_list = (enum ppc_sys_devices[])
+		{
+			MPC82xx_CPM_FCC1, MPC82xx_CPM_FCC2, MPC82xx_CPM_SCC1,
+			MPC82xx_CPM_SCC2, MPC82xx_CPM_SCC3, MPC82xx_CPM_SCC4,
+			MPC82xx_CPM_MCC1, MPC82xx_CPM_SMC1, MPC82xx_CPM_SMC2,
+			MPC82xx_CPM_SPI, MPC82xx_CPM_I2C,
+		}
+	},
+	{
+		.ppc_sys_name	= "8260",
+		.mask		= 0x0000ff00,
+		.value		= 0x00000000,
+		.num_devices	= 12,
+		.device_list = (enum ppc_sys_devices[])
+		{
+			MPC82xx_CPM_FCC1, MPC82xx_CPM_FCC2, MPC82xx_CPM_FCC3,
+			MPC82xx_CPM_SCC1, MPC82xx_CPM_SCC2, MPC82xx_CPM_SCC3,
+			MPC82xx_CPM_SCC4, MPC82xx_CPM_MCC1, MPC82xx_CPM_SMC1,
+			MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI, MPC82xx_CPM_I2C,
+		}
+	},
+	{
+		.ppc_sys_name	= "8264",
+		.mask		= 0x0000ff00,
+		.value		= 0x00000000,
+		.num_devices	= 12,
+		.device_list = (enum ppc_sys_devices[])
+		{
+			MPC82xx_CPM_FCC1, MPC82xx_CPM_FCC2, MPC82xx_CPM_FCC3,
+			MPC82xx_CPM_SCC1, MPC82xx_CPM_SCC2, MPC82xx_CPM_SCC3,
+			MPC82xx_CPM_SCC4, MPC82xx_CPM_MCC1, MPC82xx_CPM_SMC1,
+			MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI, MPC82xx_CPM_I2C,
+		}
+	},
+	{
+		.ppc_sys_name	= "8265",
+		.mask		= 0x0000ff00,
+		.value		= 0x00000000,
+		.num_devices	= 12,
+		.device_list = (enum ppc_sys_devices[])
+		{
+			MPC82xx_CPM_FCC1, MPC82xx_CPM_FCC2, MPC82xx_CPM_FCC3,
+			MPC82xx_CPM_SCC1, MPC82xx_CPM_SCC2, MPC82xx_CPM_SCC3,
+			MPC82xx_CPM_SCC4, MPC82xx_CPM_MCC1, MPC82xx_CPM_SMC1,
+			MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI, MPC82xx_CPM_I2C,
+		}
+	},
+	{
+		.ppc_sys_name	= "8266",
+		.mask		= 0x0000ff00,
+		.value		= 0x00000000,
+		.num_devices	= 12,
+		.device_list = (enum ppc_sys_devices[])
+		{
+			MPC82xx_CPM_FCC1, MPC82xx_CPM_FCC2, MPC82xx_CPM_FCC3,
+			MPC82xx_CPM_SCC1, MPC82xx_CPM_SCC2, MPC82xx_CPM_SCC3,
+			MPC82xx_CPM_SCC4, MPC82xx_CPM_MCC1, MPC82xx_CPM_SMC1,
+			MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI, MPC82xx_CPM_I2C,
+		}
+	},
+	/* below is a list of the 8272 family of processors */
+	{
+		.ppc_sys_name	= "8247",
+		.mask		= 0x0000ff00,
+		.value		= 0x00000d00,
+		.num_devices	= 10,
+		.device_list = (enum ppc_sys_devices[])
+		{
+			MPC82xx_CPM_FCC1, MPC82xx_CPM_FCC2, MPC82xx_CPM_SCC1,
+			MPC82xx_CPM_SCC2, MPC82xx_CPM_SCC3, MPC82xx_CPM_SMC1,
+			MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI, MPC82xx_CPM_I2C,
+			MPC82xx_CPM_USB,
+		},
+	},
+	{
+		.ppc_sys_name	= "8248",
+		.mask		= 0x0000ff00,
+		.value		= 0x00000c00,
+		.num_devices	= 11,
+		.device_list = (enum ppc_sys_devices[])
+		{
+			MPC82xx_CPM_FCC1, MPC82xx_CPM_FCC2, MPC82xx_CPM_SCC1,
+			MPC82xx_CPM_SCC2, MPC82xx_CPM_SCC3, MPC82xx_CPM_SMC1,
+			MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI, MPC82xx_CPM_I2C,
+			MPC82xx_CPM_USB, MPC82xx_SEC1,
+		},
+	},
+	{
+		.ppc_sys_name	= "8271",
+		.mask		= 0x0000ff00,
+		.value		= 0x00000d00,
+		.num_devices	= 10,
+		.device_list = (enum ppc_sys_devices[])
+		{
+			MPC82xx_CPM_FCC1, MPC82xx_CPM_FCC2, MPC82xx_CPM_SCC1,
+			MPC82xx_CPM_SCC2, MPC82xx_CPM_SCC3, MPC82xx_CPM_SMC1,
+			MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI, MPC82xx_CPM_I2C,
+			MPC82xx_CPM_USB,
+		},
+	},
+	{
+		.ppc_sys_name	= "8272",
+		.mask		= 0x0000ff00,
+		.value		= 0x00000c00,
+		.num_devices	= 11,
+		.device_list = (enum ppc_sys_devices[])
+		{
+			MPC82xx_CPM_FCC1, MPC82xx_CPM_FCC2, MPC82xx_CPM_SCC1,
+			MPC82xx_CPM_SCC2, MPC82xx_CPM_SCC3, MPC82xx_CPM_SMC1,
+			MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI, MPC82xx_CPM_I2C,
+			MPC82xx_CPM_USB, MPC82xx_SEC1,
+		},
+	},
+	/* below is a list of the 8280 family of processors */
+	{
+		.ppc_sys_name	= "8270",
+		.mask 		= 0x0000ff00,
+		.value 		= 0x00000a00,
+		.num_devices 	= 12,
+		.device_list = (enum ppc_sys_devices[])
+		{
+			MPC82xx_CPM_FCC1, MPC82xx_CPM_FCC2, MPC82xx_CPM_FCC3,
+			MPC82xx_CPM_SCC1, MPC82xx_CPM_SCC2, MPC82xx_CPM_SCC3,
+			MPC82xx_CPM_SCC4, MPC82xx_CPM_MCC1, MPC82xx_CPM_SMC1,
+			MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI, MPC82xx_CPM_I2C,
+		},
+	},
+	{
+		.ppc_sys_name	= "8275",
+		.mask 		= 0x0000ff00,
+		.value 		= 0x00000a00,
+		.num_devices 	= 12,
+		.device_list = (enum ppc_sys_devices[])
+		{
+			MPC82xx_CPM_FCC1, MPC82xx_CPM_FCC2, MPC82xx_CPM_FCC3,
+			MPC82xx_CPM_SCC1, MPC82xx_CPM_SCC2, MPC82xx_CPM_SCC3,
+			MPC82xx_CPM_SCC4, MPC82xx_CPM_MCC1, MPC82xx_CPM_SMC1,
+			MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI, MPC82xx_CPM_I2C,
+		},
+	},
+	{
+		.ppc_sys_name	= "8280",
+		.mask 		= 0x0000ff00,
+		.value 		= 0x00000a00,
+		.num_devices 	= 13,
+		.device_list = (enum ppc_sys_devices[])
+		{
+			MPC82xx_CPM_FCC1, MPC82xx_CPM_FCC2, MPC82xx_CPM_FCC3,
+			MPC82xx_CPM_SCC1, MPC82xx_CPM_SCC2, MPC82xx_CPM_SCC3,
+			MPC82xx_CPM_SCC4, MPC82xx_CPM_MCC1, MPC82xx_CPM_MCC2,
+			MPC82xx_CPM_SMC1, MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI,
+			MPC82xx_CPM_I2C,
+		},
+	},
+	{
+		/* default match */
+		.ppc_sys_name	= "",
+		.mask 		= 0x00000000,
+		.value 		= 0x00000000,
+	},
+};
diff --git a/include/asm-ppc/irq.h b/include/asm-ppc/irq.h
--- a/include/asm-ppc/irq.h
+++ b/include/asm-ppc/irq.h
@@ -337,6 +337,7 @@ static __inline__ int irq_canonicalize(i
 #define	SIU_INT_IDMA3		((uint)0x08 + CPM_IRQ_OFFSET)
 #define	SIU_INT_IDMA4		((uint)0x09 + CPM_IRQ_OFFSET)
 #define	SIU_INT_SDMA		((uint)0x0a + CPM_IRQ_OFFSET)
+#define	SIU_INT_USB		((uint)0x0b + CPM_IRQ_OFFSET)
 #define	SIU_INT_TIMER1		((uint)0x0c + CPM_IRQ_OFFSET)
 #define	SIU_INT_TIMER2		((uint)0x0d + CPM_IRQ_OFFSET)
 #define	SIU_INT_TIMER3		((uint)0x0e + CPM_IRQ_OFFSET)
diff --git a/include/asm-ppc/mpc8260.h b/include/asm-ppc/mpc8260.h
--- a/include/asm-ppc/mpc8260.h
+++ b/include/asm-ppc/mpc8260.h
@@ -67,6 +67,24 @@
 #define IO_VIRT_ADDR	IO_PHYS_ADDR
 #endif
 
+enum ppc_sys_devices {
+	MPC82xx_CPM_FCC1,
+	MPC82xx_CPM_FCC2,
+	MPC82xx_CPM_FCC3,
+	MPC82xx_CPM_I2C,
+	MPC82xx_CPM_SCC1,
+	MPC82xx_CPM_SCC2,
+	MPC82xx_CPM_SCC3,
+	MPC82xx_CPM_SCC4,
+	MPC82xx_CPM_SPI,
+	MPC82xx_CPM_MCC1,
+	MPC82xx_CPM_MCC2,
+	MPC82xx_CPM_SMC1,
+	MPC82xx_CPM_SMC2,
+	MPC82xx_CPM_USB,
+	MPC82xx_SEC1,
+};
+
 #ifndef __ASSEMBLY__
 /* The "residual" data board information structure the boot loader
  * hands to us.
diff --git a/include/asm-ppc/ppc_sys.h b/include/asm-ppc/ppc_sys.h
--- a/include/asm-ppc/ppc_sys.h
+++ b/include/asm-ppc/ppc_sys.h
@@ -21,7 +21,9 @@
 #include <linux/device.h>
 #include <linux/types.h>
 
-#if defined(CONFIG_83xx)
+#if defined(CONFIG_8260)
+#include <asm/mpc8260.h>
+#elif defined(CONFIG_83xx)
 #include <asm/mpc83xx.h>
 #elif defined(CONFIG_85xx)
 #include <asm/mpc85xx.h>
