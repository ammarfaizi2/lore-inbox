Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161074AbVIPMyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161074AbVIPMyw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 08:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161087AbVIPMyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 08:54:52 -0400
Received: from [85.21.88.2] ([85.21.88.2]:33430 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S1161074AbVIPMyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 08:54:51 -0400
Message-ID: <432AC094.9020606@ru.mvista.com>
Date: Fri, 16 Sep 2005 16:54:44 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       Kumar Gala <galak@freescale.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH] ppc32: Add ppc_sys descriptions for PowerQUICC I devices
Content-Type: multipart/mixed;
 boundary="------------050701010500010609040506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050701010500010609040506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added ppc_sys device and system definitions for PowerQUICC I devices.
This will allow drivers for PQI to be proper platform device drivers. 
Currently sys section contains only MPC885 and MPC866. Identification 
should be done with identify_ppc_sys_by_name call, with board-specific 
"name" string passed, since PQI do not have any register that could 
identify the SOC.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>



--------------050701010500010609040506
Content-Type: text/x-patch;
 name="mpc8xx_sys_desc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mpc8xx_sys_desc.patch"

diff --git a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile
+++ b/arch/ppc/syslib/Makefile
@@ -34,7 +34,8 @@ ifeq ($(CONFIG_40x),y)
 obj-$(CONFIG_PCI)		+= indirect_pci.o pci_auto.o ppc405_pci.o
 endif
 endif
-obj-$(CONFIG_8xx)		+= m8xx_setup.o ppc8xx_pic.o $(wdt-mpc8xx-y)
+obj-$(CONFIG_8xx)		+= m8xx_setup.o ppc8xx_pic.o $(wdt-mpc8xx-y) \
+				   ppc_sys.o mpc8xx_devices.o mpc8xx_sys.o
 ifeq ($(CONFIG_8xx),y)
 obj-$(CONFIG_PCI)		+= qspan_pci.o i8259.o
 endif
diff --git a/arch/ppc/syslib/mpc8xx_devices.c b/arch/ppc/syslib/mpc8xx_devices.c
new file mode 100644
--- /dev/null
+++ b/arch/ppc/syslib/mpc8xx_devices.c
@@ -0,0 +1,224 @@
+/*
+ * arch/ppc/syslib/mpc8xx_devices.c
+ *
+ * MPC8xx Device descriptions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2005 MontaVista Software, Inc. by Vitaly Bordug<vbordug@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/serial_8250.h>
+#include <linux/mii.h>
+#include <asm/commproc.h>
+#include <asm/mpc8xx.h>
+#include <asm/irq.h>
+#include <asm/ppc_sys.h>
+
+/* We use offsets for IORESOURCE_MEM to do not set dependences at compile time.
+ * They will get fixed up by mach_mpc8xx_fixup
+ */
+
+struct platform_device ppc_sys_platform_devices[] = {
+	[MPC8xx_CPM_FEC1] =	{
+		.name = "fsl-cpm-fec",
+		.id	= 1,
+		.num_resources = 2,
+		.resource = (struct resource[])	{
+			{
+				.name 	= "regs",
+				.start	= 0xe00,
+				.end	= 0xe88,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= MPC8xx_INT_FEC1,
+				.end	= MPC8xx_INT_FEC1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC8xx_CPM_FEC2] =	{
+		.name = "fsl-cpm-fec",
+		.id	= 2,
+		.num_resources = 2,
+		.resource = (struct resource[])	{
+			{
+				.name	= "regs",
+				.start	= 0x1e00,
+				.end	= 0x1e88,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= MPC8xx_INT_FEC2,
+				.end	= MPC8xx_INT_FEC2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC8xx_CPM_SCC1] = {
+		.name = "fsl-cpm-scc",
+		.id	= 1,
+		.num_resources = 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "regs",
+				.start	= 0xa00,
+				.end	= 0xa18,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name 	= "pram",
+				.start 	= 0x3c00,
+				.end 	= 0x3c80,
+				.flags 	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= MPC8xx_INT_SCC1,
+				.end	= MPC8xx_INT_SCC1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC8xx_CPM_SCC2] = {
+		.name = "fsl-cpm-scc",
+		.id	= 2,
+		.num_resources	= 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "regs",
+				.start	= 0xa20,
+				.end	= 0xa38,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name 	= "pram",
+				.start 	= 0x3d00,
+				.end 	= 0x3d80,
+				.flags 	= IORESOURCE_MEM,
+			},
+
+			{
+				.name	= "interrupt",
+				.start	= MPC8xx_INT_SCC2,
+				.end	= MPC8xx_INT_SCC2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC8xx_CPM_SCC3] = {
+		.name = "fsl-cpm-scc",
+		.id	= 3,
+		.num_resources	= 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "regs",
+				.start	= 0xa40,
+				.end	= 0xa58,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name 	= "pram",
+				.start 	= 0x3e00,
+				.end 	= 0x3e80,
+				.flags 	= IORESOURCE_MEM,
+			},
+
+			{
+				.name	= "interrupt",
+				.start	= MPC8xx_INT_SCC3,
+				.end	= MPC8xx_INT_SCC3,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC8xx_CPM_SCC4] = {
+		.name = "fsl-cpm-scc",
+		.id	= 4,
+		.num_resources	= 3,
+		.resource = (struct resource[]) {
+			{
+				.name	= "regs",
+				.start	= 0xa60,
+				.end	= 0xa78,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name 	= "pram",
+				.start 	= 0x3f00,
+				.end 	= 0x3f80,
+				.flags 	= IORESOURCE_MEM,
+			},
+
+			{
+				.name	= "interrupt",
+				.start	= MPC8xx_INT_SCC4,
+				.end	= MPC8xx_INT_SCC4,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC8xx_CPM_SMC1] = {
+		.name = "fsl-cpm-smc",
+		.id	= 1,
+		.num_resources	= 2,
+		.resource = (struct resource[]) {
+			{
+				.name	= "regs",
+				.start	= 0xa82,
+				.end	= 0xa91,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= MPC8xx_INT_SMC1,
+				.end	= MPC8xx_INT_SMC1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC8xx_CPM_SMC2] = {
+		.name = "fsl-cpm-smc",
+		.id	= 2,
+		.num_resources	= 2,
+		.resource = (struct resource[]) {
+			{
+				.name	= "regs",
+				.start	= 0xa92,
+				.end	= 0xaa1,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= MPC8xx_INT_SMC2,
+				.end	= MPC8xx_INT_SMC2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+};
+
+static int __init mach_mpc8xx_fixup(struct platform_device *pdev)
+{
+	ppc_sys_fixup_mem_resource (pdev, IMAP_ADDR);
+	return 0;
+}
+
+static int __init mach_mpc8xx_init(void)
+{
+	ppc_sys_device_fixup = mach_mpc8xx_fixup;
+	return 0;
+}
+
+postcore_initcall(mach_mpc8xx_init);
diff --git a/arch/ppc/syslib/mpc8xx_sys.c b/arch/ppc/syslib/mpc8xx_sys.c
new file mode 100644
--- /dev/null
+++ b/arch/ppc/syslib/mpc8xx_sys.c
@@ -0,0 +1,61 @@
+/*
+ * arch/ppc/platforms/mpc8xx_sys.c
+ *
+ * MPC8xx System descriptions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2005 MontaVista Software, Inc. by Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <asm/ppc_sys.h>
+
+struct ppc_sys_spec *cur_ppc_sys_spec; 
+struct ppc_sys_spec ppc_sys_specs[] = {
+	{
+		.ppc_sys_name	= "MPC86X",
+		.mask 		= 0xFFFFFFFF,
+		.value 		= 0x00000000,
+		.num_devices	= 2,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC8xx_CPM_FEC1,
+			MPC8xx_CPM_SCC1,
+			MPC8xx_CPM_SCC2,
+			MPC8xx_CPM_SCC3,
+			MPC8xx_CPM_SCC4,
+			MPC8xx_CPM_SMC1,
+			MPC8xx_CPM_SMC2,
+		},
+	},
+	{
+		.ppc_sys_name	= "MPC885",
+		.mask 		= 0xFFFFFFFF,
+		.value 		= 0x00000000,
+		.num_devices	= 3,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			MPC8xx_CPM_FEC1,
+			MPC8xx_CPM_FEC2,
+			MPC8xx_CPM_SCC1,
+			MPC8xx_CPM_SCC2,
+			MPC8xx_CPM_SCC3,
+			MPC8xx_CPM_SCC4,
+			MPC8xx_CPM_SMC1,
+			MPC8xx_CPM_SMC2,
+		},
+	},
+	{	/* default match */
+		.ppc_sys_name	= "",
+		.mask 		= 0x00000000,
+		.value 		= 0x00000000,
+	},
+};
diff --git a/include/asm-ppc/irq.h b/include/asm-ppc/irq.h
--- a/include/asm-ppc/irq.h
+++ b/include/asm-ppc/irq.h
@@ -138,6 +138,16 @@ irq_canonicalize(int irq)
 #define	SIU_IRQ7	(14)
 #define	SIU_LEVEL7	(15)
 
+#define MPC8xx_INT_FEC1		SIU_LEVEL1
+#define MPC8xx_INT_FEC2		SIU_LEVEL3
+
+#define MPC8xx_INT_SCC1		(CPM_IRQ_OFFSET + CPMVEC_SCC1)
+#define MPC8xx_INT_SCC2		(CPM_IRQ_OFFSET + CPMVEC_SCC2)
+#define MPC8xx_INT_SCC3		(CPM_IRQ_OFFSET + CPMVEC_SCC3)
+#define MPC8xx_INT_SCC4		(CPM_IRQ_OFFSET + CPMVEC_SCC4)
+#define MPC8xx_INT_SMC1		(CPM_IRQ_OFFSET + CPMVEC_SMC1)
+#define MPC8xx_INT_SMC2		(CPM_IRQ_OFFSET + CPMVEC_SMC2)
+
 /* The internal interrupts we can configure as we see fit.
  * My personal preference is CPM at level 2, which puts it above the
  * MBX PCI/ISA/IDE interrupts.
diff --git a/include/asm-ppc/mpc8xx.h b/include/asm-ppc/mpc8xx.h
--- a/include/asm-ppc/mpc8xx.h
+++ b/include/asm-ppc/mpc8xx.h
@@ -97,6 +97,22 @@ extern unsigned char __res[];
 
 struct pt_regs;
 
+enum ppc_sys_devices {
+	MPC8xx_CPM_FEC1,
+	MPC8xx_CPM_FEC2,
+	MPC8xx_CPM_I2C,
+	MPC8xx_CPM_SCC1,
+	MPC8xx_CPM_SCC2,
+	MPC8xx_CPM_SCC3,
+	MPC8xx_CPM_SCC4,
+	MPC8xx_CPM_SPI,
+	MPC8xx_CPM_MCC1,
+	MPC8xx_CPM_MCC2,
+	MPC8xx_CPM_SMC1,
+	MPC8xx_CPM_SMC2,
+	MPC8xx_CPM_USB,
+};
+
 #endif /* !__ASSEMBLY__ */
 #endif /* CONFIG_8xx */
 #endif /* __CONFIG_8xx_DEFS */
diff --git a/include/asm-ppc/ppc_sys.h b/include/asm-ppc/ppc_sys.h
--- a/include/asm-ppc/ppc_sys.h
+++ b/include/asm-ppc/ppc_sys.h
@@ -27,6 +27,8 @@
 #include <asm/mpc83xx.h>
 #elif defined(CONFIG_85xx)
 #include <asm/mpc85xx.h>
+#elif defined(CONFIG_8xx)
+#include <asm/mpc8xx.h>
 #elif defined(CONFIG_PPC_MPC52xx)
 #include <asm/mpc52xx.h>
 #elif defined(CONFIG_MPC10X_BRIDGE)

--------------050701010500010609040506--
