Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVARPgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVARPgl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 10:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVARPgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 10:36:41 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:4827 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S261324AbVARPfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 10:35:07 -0500
Date: Tue, 18 Jan 2005 09:35:00 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@blarg.somerset.sps.mot.com
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH 1/4] ppc32: platform_device conversion from OCP
Message-ID: <Pine.LNX.4.61.0501172304390.9340@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System platform_device description, discovery and management:

On most embedded PPC systems we either have a core CPU and chipset 
(MPC10x, TSI10x, Marvell, etc.) or a system-on-chip device (4xx, 8xx, 
82xx, 85xx, etc.).  Some of these sub-archs have been using the On Chip 
Peripheral (OCP) driver model.  The functionality that OCP provide has 
been replaced by the generic driver model and platform_device.  Also, some 
of these device may exist across a number of architectures (PPC, MIPS, 
ARM) such that some information that is shared between the architecture 
and driver needs to exist outside of either.

The ppc_sys changes add a standard way for PowerPC systems to describe the 
devices and systems that exist in the sub-arch.  Additionally, we are able 
to discover which system we are and manage which devices are actually 
registered and any platform specific fixups that may be needed.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
diff -Nru a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile	2005-01-17 22:31:44 -06:00
+++ b/arch/ppc/syslib/Makefile	2005-01-17 22:31:44 -06:00
@@ -92,7 +92,8 @@
 obj-$(CONFIG_MPC10X_OPENPIC)	+= open_pic.o
 obj-$(CONFIG_40x)		+= dcr.o
 obj-$(CONFIG_BOOKE)		+= dcr.o
-obj-$(CONFIG_85xx)		+= open_pic.o ppc85xx_common.o ppc85xx_setup.o
+obj-$(CONFIG_85xx)		+= open_pic.o ppc85xx_common.o ppc85xx_setup.o \
+					ppc_sys.o
 ifeq ($(CONFIG_85xx),y)
 obj-$(CONFIG_PCI)		+= indirect_pci.o pci_auto.o
 endif
diff -Nru a/arch/ppc/syslib/ppc_sys.c b/arch/ppc/syslib/ppc_sys.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/syslib/ppc_sys.c	2005-01-17 22:31:44 -06:00
@@ -0,0 +1,103 @@
+/*
+ * arch/ppc/syslib/ppc_sys.c
+ *
+ * PPC System library functions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2005 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <asm/ppc_sys.h>
+
+int (*ppc_sys_device_fixup) (struct platform_device * pdev);
+
+static int ppc_sys_inited;
+
+void __init identify_ppc_sys_by_id(u32 id)
+{
+	unsigned int i = 0;
+	while (1) {
+		if ((ppc_sys_specs[i].mask & id) == ppc_sys_specs[i].value)
+			break;
+		i++;
+	}
+
+	cur_ppc_sys_spec = &ppc_sys_specs[i];
+
+	return;
+}
+
+void __init identify_ppc_sys_by_name(char *name)
+{
+	/* TODO */
+	return;
+}
+
+/* Update all memory resources by paddr, call before platform_device_register */
+void __init
+ppc_sys_fixup_mem_resource(struct platform_device *pdev, phys_addr_t paddr)
+{
+	int i;
+	for (i = 0; i < pdev->num_resources; i++) {
+		struct resource *r = &pdev->resource[i];
+		if ((r->flags & IORESOURCE_MEM) == IORESOURCE_MEM) {
+			r->start += paddr;
+			r->end += paddr;
+		}
+	}
+}
+
+/* Get platform_data pointer out of platform device, call before platform_device_register */
+void *__init ppc_sys_get_pdata(enum ppc_sys_devices dev)
+{
+	return ppc_sys_platform_devices[dev].dev.platform_data;
+}
+
+void ppc_sys_device_remove(enum ppc_sys_devices dev)
+{
+	unsigned int i;
+
+	if (ppc_sys_inited) {
+		platform_device_unregister(&ppc_sys_platform_devices[dev]);
+	} else {
+		if (cur_ppc_sys_spec == NULL)
+			return;
+		for (i = 0; i < cur_ppc_sys_spec->num_devices; i++)
+			if (cur_ppc_sys_spec->device_list[i] == dev)
+				cur_ppc_sys_spec->device_list[i] = -1;
+	}
+}
+
+static int __init ppc_sys_init(void)
+{
+	unsigned int i, dev_id, ret = 0;
+
+	BUG_ON(cur_ppc_sys_spec == NULL);
+
+	for (i = 0; i < cur_ppc_sys_spec->num_devices; i++) {
+		dev_id = cur_ppc_sys_spec->device_list[i];
+		if (dev_id != -1) {
+			if (ppc_sys_device_fixup != NULL)
+				ppc_sys_device_fixup(&ppc_sys_platform_devices
+						     [dev_id]);
+			if (platform_device_register
+			    (&ppc_sys_platform_devices[dev_id])) {
+				ret = 1;
+				printk(KERN_ERR
+				       "unable to register device %d\n",
+				       dev_id);
+			}
+		}
+	}
+
+	ppc_sys_inited = 1;
+	return ret;
+}
+
+subsys_initcall(ppc_sys_init);
diff -Nru a/include/asm-ppc/ppc_sys.h b/include/asm-ppc/ppc_sys.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-ppc/ppc_sys.h	2005-01-17 22:31:44 -06:00
@@ -0,0 +1,65 @@
+/*
+ * include/asm-ppc/ppc_sys.h
+ *
+ * PPC system definitions and library functions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * Copyright 2005 Freescale Semiconductor, Inc
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifdef __KERNEL__
+#ifndef __ASM_PPC_SYS_H
+#define __ASM_PPC_SYS_H
+
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/types.h>
+
+#if defined(CONFIG_85xx)
+#include <asm/mpc85xx.h>
+#else
+#error "need definition of ppc_sys_devices"
+#endif
+
+struct ppc_sys_spec {
+	/* PPC sys is matched via (ID & mask) == value, id could be
+	 * PVR, SVR, IMMR, * etc. */
+	u32 			mask;
+	u32 			value;
+	u32 			num_devices;
+	char 			*ppc_sys_name;
+	enum ppc_sys_devices 	*device_list;
+};
+
+/* describes all specific chips and which devices they have on them */
+extern struct ppc_sys_spec ppc_sys_specs[];
+extern struct ppc_sys_spec *cur_ppc_sys_spec;
+
+/* determine which specific SOC we are */
+extern void identify_ppc_sys_by_id(u32 id) __init;
+extern void identify_ppc_sys_by_name(char *name) __init;
+
+/* describes all devices that may exist in a given family of processors */
+extern struct platform_device ppc_sys_platform_devices[];
+
+/* allow any platform_device fixup to occur before device is registered */
+extern int (*ppc_sys_device_fixup) (struct platform_device * pdev);
+
+/* Update all memory resources by paddr, call before platform_device_register */
+extern void ppc_sys_fixup_mem_resource(struct platform_device *pdev,
+				       phys_addr_t paddr) __init;
+
+/* Get platform_data pointer out of platform device, call before platform_device_register */
+extern void *ppc_sys_get_pdata(enum ppc_sys_devices dev) __init;
+
+/* remove a device from the system */
+extern void ppc_sys_device_remove(enum ppc_sys_devices dev);
+
+#endif				/* __ASM_PPC_SYS_H */
+#endif				/* __KERNEL__ */
diff -Nru a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/linux/fsl_devices.h	2005-01-17 22:31:44 -06:00
@@ -0,0 +1,78 @@
+/*
+ * include/linux/fsl_devices.h
+ *
+ * Definitions for any platform device related flags or structures for
+ * Freescale processor devices
+ *
+ * Maintainer: Kumar Gala (kumar.gala@freescale.com)
+ *
+ * Copyright 2004 Freescale Semiconductor, Inc
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifdef __KERNEL__
+#ifndef _FSL_DEVICE_H_
+#define _FSL_DEVICE_H_
+
+#include <linux/types.h>
+
+/*
+ * Some conventions on how we handle peripherals on Freescale chips
+ *
+ * unique device: a platform_device entry in fsl_plat_devs[] plus
+ * associated device information in its platform_data structure.
+ *
+ * A chip is described by a set of unique devices.
+ *
+ * Each sub-arch has its own master list of unique devices and
+ * enumerates them by enum fsl_devices in a sub-arch specific header
+ *
+ * The platform data structure is broken into two parts.  The
+ * first is device specific information that help identify any
+ * unique features of a peripheral.  The second is any
+ * information that may be defined by the board or how the device
+ * is connected externally of the chip.
+ *
+ * naming conventions:
+ * - platform data structures: <driver>_platform_data
+ * - platform data device flags: FSL_<driver>_DEV_<FLAG>
+ * - platform data board flags: FSL_<driver>_BRD_<FLAG>
+ *
+ */
+
+struct gianfar_platform_data {
+	/* device specific information */
+	u32 device_flags;
+	u32 phy_reg_addr;
+
+	/* board specific information */
+	u32 board_flags;
+	u32 phyid;
+	u32 interruptPHY;
+	u8 mac_addr[6];
+};
+
+/* Flags related to gianfar device features */
+#define FSL_GIANFAR_DEV_HAS_GIGABIT		0x00000001
+#define FSL_GIANFAR_DEV_HAS_COALESCE		0x00000002
+#define FSL_GIANFAR_DEV_HAS_RMON		0x00000004
+#define FSL_GIANFAR_DEV_HAS_MULTI_INTR		0x00000008
+
+/* Flags in gianfar_platform_data */
+#define FSL_GIANFAR_BRD_HAS_PHY_INTR	0x00000001	/* if not set use a timer */
+
+struct fsl_i2c_platform_data {
+	/* device specific information */
+	u32 device_flags;
+};
+
+/* Flags related to I2C device features */
+#define FSL_I2C_DEV_SEPARATE_DFSRR	0x00000001
+#define FSL_I2C_DEV_CLOCK_5200		0x00000002
+
+#endif				/* _FSL_DEVICE_H_ */
+#endif				/* __KERNEL__ */
