Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVEXAxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVEXAxv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 20:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVEXAxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 20:53:51 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:42137 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261274AbVEXAsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 20:48:12 -0400
Date: Mon, 23 May 2005 19:48:08 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ioc4: Core driver rewrite
Message-ID: <20050523194112.X75588@chenjesu.americas.sgi.com>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The SGI IOC4 I/O controller chip implements multiple functions, though it
is not a multi-function PCI device.  Additionally, various PCI resources
of the IOC4 are shared by multiple hardware functions, and thus resource
ownership by driver is not clearly delineated.  Due to the current driver
design, all core and subordinate drivers must be loaded, or none, which
is undesirable if not all IOC4 hardware features are being used.

This patch reorganizes the IOC4 drivers so that the core driver
provides a subdriver registration service.  Through appropriate
callbacks the subdrivers can now handle device addition and removal,
as well as module insertion and deletion (though the IOC4 IDE driver
requires further work before module deletion will work).  The core
driver now takes care of allocating PCI resources and data which
must be shared between subdrivers, to clearly delineate module
ownership of these items.

Signed-off-by: Brent Casavant <bcasavan@sgi.com>
Acked-by: Pat Gefre <pfg@sgi.com
Acked-by: Jeremy Higdon <jeremy@sgi.com>

 include/linux/ioc4_common.h        |   21 --
 linux/Documentation/sgi-ioc4.txt   |   45 +++++
 linux/drivers/ide/pci/sgiioc4.c    |   30 ++-
 linux/drivers/serial/ioc4_serial.c |  311 +++++++++++++++---------------------- linux/drivers/sn/ioc4.c            |  290 +++++++++++++++++++++++++++++++---
 linux/include/linux/ioc4.h         |  156 ++++++++++++++++++
 6 files changed, 617 insertions(+), 236 deletions(-)

Index: linux/drivers/sn/ioc4.c
===================================================================
--- linux.orig/drivers/sn/ioc4.c	2005-05-23 11:27:04.773769040 -0500
+++ linux/drivers/sn/ioc4.c	2005-05-23 15:55:41.064391719 -0500
@@ -6,60 +6,294 @@
  * Copyright (C) 2005 Silicon Graphics, Inc.  All Rights Reserved.
  */
 
-/*
- * This file contains a shim driver for the IOC4 IDE and serial drivers.
+/* This file contains the master driver module for use by SGI IOC4 subdrivers.
+ *
+ * It allocates any resources shared between multiple subdevices, and
+ * provides accessor functions (where needed) and the like for those
+ * resources.  It also provides a mechanism for the subdevice modules
+ * to support loading and unloading.
+ *
+ * Non-shared resources (e.g. external interrupt A_INT_OUT register page
+ * alias, serial port and UART registers) are handled by the subdevice
+ * modules themselves.
+ *
+ * This is all necessary because IOC4 is not implemented as a multi-function
+ * PCI device, but an amalgamation of disparate registers for several
+ * types of device (ATA, serial, external interrupts).  The normal
+ * resource management in the kernel doesn't have quite the right interfaces
+ * to handle this situation (e.g. multiple modules can't claim the same
+ * PCI ID), thus this IOC4 master module.
  */
 
 #include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/pci.h>
-#include <linux/ioc4_common.h>
-#include <linux/ide.h>
+#include <linux/ioc4.h>
+#include <linux/rwsem.h>
 
+/************************
+ * Submodule management *
+ ************************/
+
+static LIST_HEAD(ioc4_devices);
+static DECLARE_RWSEM(ioc4_devices_rwsem);
+
+static LIST_HEAD(ioc4_submodules);
+static DECLARE_RWSEM(ioc4_submodules_rwsem);
+
+/* Register an IOC4 submodule */
+int
+ioc4_register_submodule(struct ioc4_submodule *is)
+{
+	struct ioc4_driver_data *idd;
 
-static int __devinit
-ioc4_probe_one(struct pci_dev *pdev, const struct pci_device_id *pci_id)
+	down_write(&ioc4_submodules_rwsem);
+	list_add(&is->is_list, &ioc4_submodules);
+	up_write(&ioc4_submodules_rwsem);
+
+	/* Initialize submodule for each IOC4 */
+	if (!is->is_probe)
+		return 0;
+
+	down_read(&ioc4_devices_rwsem);
+	list_for_each_entry(idd, &ioc4_devices, idd_list) {
+		if (is->is_probe(idd)) {
+			printk(KERN_WARNING
+			       "%s: IOC4 submodule %s probe failed "
+			       "for pci_dev %s",
+			       __FUNCTION__, module_name(is->is_owner),
+			       pci_name(idd->idd_pdev));
+		}
+	}
+	up_read(&ioc4_devices_rwsem);
+
+	return 0;
+}
+
+/* Unregister an IOC4 submodule */
+void
+ioc4_unregister_submodule(struct ioc4_submodule *is)
+{
+	struct ioc4_driver_data *idd;
+
+	down_write(&ioc4_submodules_rwsem);
+	list_del(&is->is_list);
+	up_write(&ioc4_submodules_rwsem);
+
+	/* Remove submodule for each IOC4 */
+	if (!is->is_remove)
+		return;
+
+	down_read(&ioc4_devices_rwsem);
+	list_for_each_entry(idd, &ioc4_devices, idd_list) {
+		if (is->is_remove(idd)) {
+			printk(KERN_WARNING
+			       "%s: IOC4 submodule %s remove failed "
+			       "for pci_dev %s.\n",
+			       __FUNCTION__, module_name(is->is_owner),
+			       pci_name(idd->idd_pdev));
+		}
+	}
+	up_read(&ioc4_devices_rwsem);
+}
+
+/*********************
+ * Device management *
+ *********************/
+
+/* Adds a new instance of an IOC4 card */
+static int
+ioc4_probe(struct pci_dev *pdev, const struct pci_device_id *pci_id)
 {
+	struct ioc4_driver_data *idd;
+	struct ioc4_submodule *is;
+	uint32_t pcmd;
 	int ret;
 
+	/* Enable IOC4 and take ownership of it */
 	if ((ret = pci_enable_device(pdev))) {
 		printk(KERN_WARNING
-			 "%s: Failed to enable device with "
-				"pci_dev 0x%p... returning\n",
-				__FUNCTION__, (void *)pdev);
-		return ret;
+		       "%s: Failed to enable IOC4 device for pci_dev %s.\n",
+		       __FUNCTION__, pci_name(pdev));
+		goto out;
 	}
 	pci_set_master(pdev);
 
-	/* attach each sub-device */
-	ret = ioc4_ide_attach_one(pdev, pci_id);
-	if (ret)
-		return ret;
-	return ioc4_serial_attach_one(pdev, pci_id);
+	/* Set up per-IOC4 data */
+	idd = kmalloc(sizeof(struct ioc4_driver_data), GFP_KERNEL);
+	if (!idd) {
+		printk(KERN_WARNING
+		       "%s: Failed to allocate IOC4 data for pci_dev %s.\n",
+		       __FUNCTION__, pci_name(pdev));
+		ret = -ENODEV;
+		goto out_idd;
+	}
+	idd->idd_pdev = pdev;
+	idd->idd_pci_id = pci_id;
+
+	/* Map IOC4 misc registers.  These are shared between subdevices
+	 * so the main IOC4 module manages them.
+	 */
+	idd->idd_bar0 = pci_resource_start(idd->idd_pdev, 0);
+	if (!idd->idd_bar0) {
+		printk(KERN_WARNING
+		       "%s: Unable to find IOC4 misc resource "
+		       "for pci_dev %s.\n",
+		       __FUNCTION__, pci_name(idd->idd_pdev));
+		ret = -ENODEV;
+		goto out_pci;
+	}
+	if (!request_region(idd->idd_bar0, sizeof(struct ioc4_misc_regs),
+			    "ioc4_misc")) {
+		printk(KERN_WARNING
+		       "%s: Unable to request IOC4 misc region "
+		       "for pci_dev %s.\n",
+		       __FUNCTION__, pci_name(idd->idd_pdev));
+		ret = -ENODEV;
+		goto out_pci;
+	}
+	idd->idd_misc_regs = ioremap(idd->idd_bar0,
+				     sizeof(struct ioc4_misc_regs));
+	if (!idd->idd_misc_regs) {
+		printk(KERN_WARNING
+		       "%s: Unable to remap IOC4 misc region "
+		       "for pci_dev %s.\n",
+		       __FUNCTION__, pci_name(idd->idd_pdev));
+		ret = -ENODEV;
+		goto out_misc_region;
+	}
+
+	/* Failsafe portion of per-IOC4 initialization */
+
+	/* Initialize IOC4 */
+	pci_read_config_dword(idd->idd_pdev, PCI_COMMAND, &pcmd);
+	pci_write_config_dword(idd->idd_pdev, PCI_COMMAND,
+			       pcmd | PCI_COMMAND_PARITY | PCI_COMMAND_SERR);
+
+	/* Disable/clear all interrupts.  Need to do this here lest
+	 * one submodule request the shared IOC4 IRQ, but interrupt
+	 * is generated by a different subdevice.
+	 */
+	/* Disable */
+	writel(~0, &idd->idd_misc_regs->other_iec.raw);
+	writel(~0, &idd->idd_misc_regs->sio_iec);
+	/* Clear (i.e. acknowledge) */
+	writel(~0, &idd->idd_misc_regs->other_ir.raw);
+	writel(~0, &idd->idd_misc_regs->sio_ir);
+
+	/* Track PCI-device specific data */
+	idd->idd_serial_data = NULL;
+	pci_set_drvdata(idd->idd_pdev, idd);
+	down_write(&ioc4_devices_rwsem);
+	list_add(&idd->idd_list, &ioc4_devices);
+	up_write(&ioc4_devices_rwsem);
+
+	/* Add this IOC4 to all submodules */
+	down_read(&ioc4_submodules_rwsem);
+	list_for_each_entry(is, &ioc4_submodules, is_list) {
+		if (is->is_probe && is->is_probe(idd)) {
+			printk(KERN_WARNING
+			       "%s: IOC4 submodule 0x%s probe failed "
+			       "for pci_dev %s.\n",
+			       __FUNCTION__, module_name(is->is_owner),
+			       pci_name(idd->idd_pdev));
+		}
+	}
+	up_read(&ioc4_submodules_rwsem);
+
+	return 0;
+
+out_misc_region:
+	release_region(idd->idd_bar0, sizeof(struct ioc4_misc_regs));
+out_pci:
+	kfree(idd);
+out_idd:
+	pci_disable_device(pdev);
+out:
+	return ret;
 }
 
-/* pci device struct */
-static struct pci_device_id ioc4_s_id_table[] = {
+/* Removes a particular instance of an IOC4 card. */
+static void
+ioc4_remove(struct pci_dev *pdev)
+{
+	struct ioc4_submodule *is;
+	struct ioc4_driver_data *idd;
+
+	idd = pci_get_drvdata(pdev);
+
+	/* Remove this IOC4 from all submodules */
+	down_read(&ioc4_submodules_rwsem);
+	list_for_each_entry(is, &ioc4_submodules, is_list) {
+		if (is->is_remove && is->is_remove(idd)) {
+			printk(KERN_WARNING
+			       "%s: IOC4 submodule 0x%s remove failed "
+			       "for pci_dev %s.\n",
+			       __FUNCTION__, module_name(is->is_owner),
+			       pci_name(idd->idd_pdev));
+		}
+	}
+	up_read(&ioc4_submodules_rwsem);
+
+	/* Release resources */
+	iounmap(idd->idd_misc_regs);
+	if (!idd->idd_bar0) {
+		printk(KERN_WARNING
+		       "%s: Unable to get IOC4 misc mapping for pci_dev %s. "
+		       "Device removal may be incomplete.\n",
+		       __FUNCTION__, pci_name(idd->idd_pdev));
+	}
+	release_region(idd->idd_bar0, sizeof(struct ioc4_misc_regs));
+
+	/* Disable IOC4 and relinquish */
+	pci_disable_device(pdev);
+
+	/* Remove and free driver data */
+	down_write(&ioc4_devices_rwsem);
+	list_del(&idd->idd_list);
+	up_write(&ioc4_devices_rwsem);
+	kfree(idd);
+}
+
+static struct pci_device_id ioc4_id_table[] = {
 	{PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_IOC4, PCI_ANY_ID,
 	 PCI_ANY_ID, 0x0b4000, 0xFFFFFF},
 	{0}
 };
-MODULE_DEVICE_TABLE(pci, ioc4_s_id_table);
 
-static struct pci_driver __devinitdata ioc4_s_driver = {
-	.name	= "IOC4",
-	.id_table = ioc4_s_id_table,
-	.probe	= ioc4_probe_one,
+static struct pci_driver __devinitdata ioc4_driver = {
+	.name = "IOC4",
+	.id_table = ioc4_id_table,
+	.probe = ioc4_probe,
+	.remove = ioc4_remove,
 };
 
-static int __devinit ioc4_detect(void)
+MODULE_DEVICE_TABLE(pci, ioc4_id_table);
+
+/*********************
+ * Module management *
+ *********************/
+
+/* Module load */
+static int __devinit
+ioc4_init(void)
 {
-	ioc4_serial_init();
+	return pci_register_driver(&ioc4_driver);
+}
 
-	return pci_register_driver(&ioc4_s_driver);
+/* Module unload */
+static void __devexit
+ioc4_exit(void)
+{
+	pci_unregister_driver(&ioc4_driver);
 }
-module_init(ioc4_detect);
 
-MODULE_AUTHOR("Pat Gefre - Silicon Graphics Inc. (SGI) <pfg@sgi.com>");
-MODULE_DESCRIPTION("PCI driver module for SGI IOC4 Base-IO Card");
+module_init(ioc4_init);
+module_exit(ioc4_exit);
+
+MODULE_AUTHOR("Brent Casavant - Silicon Graphics, Inc. <bcasavan@sgi.com>");
+MODULE_DESCRIPTION("PCI driver master module for SGI IOC4 Base-IO Card");
 MODULE_LICENSE("GPL");
+
+EXPORT_SYMBOL(ioc4_register_submodule);
+EXPORT_SYMBOL(ioc4_unregister_submodule);
Index: linux/include/linux/ioc4_common.h
===================================================================
--- linux.orig/include/linux/ioc4_common.h	2005-05-23 11:27:04.776698696 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,21 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (c) 2005 Silicon Graphics, Inc.  All Rights Reserved.
- */
-
-#ifndef _LINUX_IOC4_COMMON_H
-#define _LINUX_IOC4_COMMON_H
-
-/* prototypes */
-
-int ioc4_serial_init(void);
-
-int ioc4_serial_attach_one(struct pci_dev *pdev, const struct
-				pci_device_id *pci_id);
-int ioc4_ide_attach_one(struct pci_dev *pdev, const struct
-				pci_device_id *pci_id);
-
-#endif	/* _LINUX_IOC4_COMMON_H */
Index: linux/drivers/serial/ioc4_serial.c
===================================================================
--- linux.orig/drivers/serial/ioc4_serial.c	2005-05-23 11:27:04.774745592 -0500
+++ linux/drivers/serial/ioc4_serial.c	2005-05-23 15:55:17.659383261 -0500
@@ -20,7 +20,7 @@
 #include <linux/serial_reg.h>
 #include <linux/module.h>
 #include <linux/pci.h>
-#include <linux/ioc4_common.h>
+#include <linux/ioc4.h>
 #include <linux/serial_core.h>
 
 /*
@@ -130,12 +130,19 @@
 				 IOC4_SIO_IR_S3_TX_EXPLICIT)
 
 /* Bitmasks for IOC4_OTHER_IR, IOC4_OTHER_IEC, and IOC4_OTHER_IES  */
-#define IOC4_OTHER_IR_ATA_INT           0x00000001  /* ATAPI intr pass-thru */
-#define IOC4_OTHER_IR_ATA_MEMERR        0x00000002  /* ATAPI DMA PCI error */
-#define IOC4_OTHER_IR_S0_MEMERR         0x00000004  /* Port 0 PCI error */
-#define IOC4_OTHER_IR_S1_MEMERR         0x00000008  /* Port 1 PCI error */
-#define IOC4_OTHER_IR_S2_MEMERR         0x00000010  /* Port 2 PCI error */
-#define IOC4_OTHER_IR_S3_MEMERR         0x00000020  /* Port 3 PCI error */
+#define IOC4_OTHER_IR_ATA_INT		0x00000001  /* ATAPI intr pass-thru */
+#define IOC4_OTHER_IR_ATA_MEMERR	0x00000002  /* ATAPI DMA PCI error */
+#define IOC4_OTHER_IR_S0_MEMERR		0x00000004  /* Port 0 PCI error */
+#define IOC4_OTHER_IR_S1_MEMERR		0x00000008  /* Port 1 PCI error */
+#define IOC4_OTHER_IR_S2_MEMERR		0x00000010  /* Port 2 PCI error */
+#define IOC4_OTHER_IR_S3_MEMERR		0x00000020  /* Port 3 PCI error */
+#define IOC4_OTHER_IR_KBD_INT		0x00000040  /* Keyboard/mouse */
+#define IOC4_OTHER_IR_RESERVED		0x007fff80  /* Reserved */
+#define IOC4_OTHER_IR_RT_INT		0x00800000  /* INT_OUT section output */
+#define IOC4_OTHER_IR_GEN_INT		0xff000000  /* Generic pins */
+
+#define IOC4_OTHER_IR_SER_MEMERR (IOC4_OTHER_IR_S0_MEMERR | IOC4_OTHER_IR_S1_MEMERR | \
+				  IOC4_OTHER_IR_S2_MEMERR | IOC4_OTHER_IR_S3_MEMERR)
 
 /* Bitmasks for IOC4_SIO_CR */
 #define IOC4_SIO_CR_CMD_PULSE_SHIFT              0  /* byte bus strobe shift */
@@ -274,67 +281,22 @@
 #define i4u_dlm u2.dlm
 #define i4u_fcr u3.fcr
 
-/* PCI memory space register map addressed using pci_bar0 */
-struct ioc4_memregs {
-	struct ioc4_mem {
-		/* Miscellaneous IOC4  registers */
-		uint32_t pci_err_addr_l;
-		uint32_t pci_err_addr_h;
-		uint32_t sio_ir;
-		uint32_t other_ir;
-
-		/* These registers are read-only for general kernel code.  */
-		uint32_t sio_ies_ro;
-		uint32_t other_ies_ro;
-		uint32_t sio_iec_ro;
-		uint32_t other_iec_ro;
-		uint32_t sio_cr;
-		uint32_t misc_fill1;
-		uint32_t int_out;
-		uint32_t misc_fill2;
-		uint32_t gpcr_s;
-		uint32_t gpcr_c;
-		uint32_t gpdr;
-		uint32_t misc_fill3;
-		uint32_t gppr_0;
-		uint32_t gppr_1;
-		uint32_t gppr_2;
-		uint32_t gppr_3;
-		uint32_t gppr_4;
-		uint32_t gppr_5;
-		uint32_t gppr_6;
-		uint32_t gppr_7;
-	} ioc4_mem;
-
-	char misc_fill4[0x100 - 0x5C - 4];
-
-	/* ATA/ATAP registers */
-	uint32_t ata_notused[9];
-	char ata_fill1[0x140 - 0x120 - 4];
-	uint32_t ata_notused1[8];
-	char ata_fill2[0x200 - 0x15C - 4];
-
-	/* Keyboard and mouse registers */
-	uint32_t km_notused[5];;
-	char km_fill1[0x300 - 0x210 - 4];
-
-	/* Serial port registers used for DMA serial I/O */
-	struct ioc4_serial {
-		uint32_t sbbr01_l;
-		uint32_t sbbr01_h;
-		uint32_t sbbr23_l;
-		uint32_t sbbr23_h;
-
-		struct ioc4_serialregs port_0;
-		struct ioc4_serialregs port_1;
-		struct ioc4_serialregs port_2;
-		struct ioc4_serialregs port_3;
-		struct ioc4_uartregs uart_0;
-		struct ioc4_uartregs uart_1;
-		struct ioc4_uartregs uart_2;
-		struct ioc4_uartregs uart_3;
-	} ioc4_serial;
-};
+/* Serial port registers used for DMA serial I/O */
+struct ioc4_serial {
+	uint32_t sbbr01_l;
+	uint32_t sbbr01_h;
+	uint32_t sbbr23_l;
+	uint32_t sbbr23_h;
+
+	struct ioc4_serialregs port_0;
+	struct ioc4_serialregs port_1;
+	struct ioc4_serialregs port_2;
+	struct ioc4_serialregs port_3;
+	struct ioc4_uartregs uart_0;
+	struct ioc4_uartregs uart_1;
+	struct ioc4_uartregs uart_2;
+	struct ioc4_uartregs uart_3;
+} ioc4_serial;
 
 /* UART clock speed */
 #define IOC4_SER_XIN_CLK        IOC4_SER_XIN_CLK_66
@@ -412,8 +374,8 @@
 					| UART_LCR_WLEN7 | UART_LCR_WLEN8)
 #define LCR_MASK_STOP_BITS	(UART_LCR_STOP)
 
-#define PENDING(_p)	(readl(&(_p)->ip_mem->sio_ir) & _p->ip_ienb)
-#define READ_SIO_IR(_p) readl(&(_p)->ip_mem->sio_ir)
+#define PENDING(_p)	(readl(&(_p)->ip_mem->sio_ir.raw) & _p->ip_ienb)
+#define READ_SIO_IR(_p) readl(&(_p)->ip_mem->sio_ir.raw)
 
 /* Default to 4k buffers */
 #ifdef IOC4_1K_BUFFERS
@@ -447,7 +409,7 @@
  */
 #define MAX_IOC4_INTR_ENTS	(8 * sizeof(uint32_t))
 struct ioc4_soft {
-	struct ioc4_mem __iomem *is_ioc4_mem_addr;
+	struct ioc4_misc_regs __iomem *is_ioc4_misc_addr;
 	struct ioc4_serial __iomem *is_ioc4_serial_addr;
 
 	/* Each interrupt type has an entry in the array */
@@ -486,7 +448,7 @@
 	struct ioc4_soft *ip_ioc4_soft;
 
 	/* pci mem addresses */
-	struct ioc4_mem __iomem *ip_mem;
+	struct ioc4_misc_regs __iomem *ip_mem;
 	struct ioc4_serial __iomem *ip_serial;
 	struct ioc4_serialregs __iomem *ip_serial_regs;
 	struct ioc4_uartregs __iomem *ip_uart_regs;
@@ -553,7 +515,7 @@
 	uint32_t intr_dma_error;
 	uint32_t intr_clear;
 	uint32_t intr_all;
-	char rs422_select_pin;
+	int rs422_select_pin;
 };
 
 static struct hooks hooks_array[IOC4_NUM_SERIAL_PORTS] = {
@@ -669,7 +631,7 @@
 static inline void
 write_ireg(struct ioc4_soft *ioc4_soft, uint32_t val, int which, int type)
 {
-	struct ioc4_mem __iomem *mem = ioc4_soft->is_ioc4_mem_addr;
+	struct ioc4_misc_regs __iomem *mem = ioc4_soft->is_ioc4_misc_addr;
 	unsigned long flags;
 
 	spin_lock_irqsave(&ioc4_soft->is_ir_lock, flags);
@@ -678,11 +640,11 @@
 	case IOC4_SIO_INTR_TYPE:
 		switch (which) {
 		case IOC4_W_IES:
-			writel(val, &mem->sio_ies_ro);
+			writel(val, &mem->sio_ies.raw);
 			break;
 
 		case IOC4_W_IEC:
-			writel(val, &mem->sio_iec_ro);
+			writel(val, &mem->sio_iec.raw);
 			break;
 		}
 		break;
@@ -690,11 +652,11 @@
 	case IOC4_OTHER_INTR_TYPE:
 		switch (which) {
 		case IOC4_W_IES:
-			writel(val, &mem->other_ies_ro);
+			writel(val, &mem->other_ies.raw);
 			break;
 
 		case IOC4_W_IEC:
-			writel(val, &mem->other_iec_ro);
+			writel(val, &mem->other_iec.raw);
 			break;
 		}
 		break;
@@ -747,7 +709,8 @@
  */
 static struct ioc4_port *get_ioc4_port(struct uart_port *the_port)
 {
-	struct ioc4_control *control = dev_get_drvdata(the_port->dev);
+	struct ioc4_driver_data *idd = dev_get_drvdata(the_port->dev);
+	struct ioc4_control *control = idd->idd_serial_data;
 	int ii;
 
 	if (control) {
@@ -782,7 +745,7 @@
 static inline uint32_t
 pending_intrs(struct ioc4_soft *soft, int type)
 {
-	struct ioc4_mem __iomem *mem = soft->is_ioc4_mem_addr;
+	struct ioc4_misc_regs __iomem *mem = soft->is_ioc4_misc_addr;
 	unsigned long flag;
 	uint32_t intrs = 0;
 
@@ -793,11 +756,11 @@
 
 	switch (type) {
 	case IOC4_SIO_INTR_TYPE:
-		intrs = readl(&mem->sio_ir) & readl(&mem->sio_ies_ro);
+		intrs = readl(&mem->sio_ir.raw) & readl(&mem->sio_ies.raw);
 		break;
 
 	case IOC4_OTHER_INTR_TYPE:
-		intrs = readl(&mem->other_ir) & readl(&mem->other_ies_ro);
+		intrs = readl(&mem->other_ir.raw) & readl(&mem->other_ies.raw);
 
 		/* Don't process any ATA interrupte */
 		intrs &= ~(IOC4_OTHER_IR_ATA_INT | IOC4_OTHER_IR_ATA_MEMERR);
@@ -826,7 +789,7 @@
 
 	/* Wait until any pending bus activity for this port has ceased */
 	do
-		sio_cr = readl(&port->ip_mem->sio_cr);
+		sio_cr = readl(&port->ip_mem->sio_cr.raw);
 	while (!(sio_cr & IOC4_SIO_CR_SIO_DIAG_IDLE));
 
 	/* Finish reset sequence */
@@ -899,7 +862,7 @@
 	write_ireg(port->ip_ioc4_soft, hooks->intr_clear,
 		       IOC4_W_IEC, IOC4_SIO_INTR_TYPE);
 	port->ip_ienb &= ~hooks->intr_clear;
-	writel(hooks->intr_clear, &port->ip_mem->sio_ir);
+	writel(hooks->intr_clear, &port->ip_mem->sio_ir.raw);
 	return 0;
 }
 
@@ -918,23 +881,23 @@
 	spin_lock_irqsave(&port->ip_lock, flags);
 
 	/* ACK the interrupt */
-	writel(hooks->intr_dma_error, &port->ip_mem->other_ir);
+	writel(hooks->intr_dma_error, &port->ip_mem->other_ir.raw);
 
-	if (readl(&port->ip_mem->pci_err_addr_l) & IOC4_PCI_ERR_ADDR_VLD) {
+	if (readl(&port->ip_mem->pci_err_addr_l.raw) & IOC4_PCI_ERR_ADDR_VLD) {
 		printk(KERN_ERR
 			"PCI error address is 0x%lx, "
 				"master is serial port %c %s\n",
 		     (((uint64_t)readl(&port->ip_mem->pci_err_addr_h)
 							 << 32)
-				| readl(&port->ip_mem->pci_err_addr_l))
+				| readl(&port->ip_mem->pci_err_addr_l.raw))
 					& IOC4_PCI_ERR_ADDR_ADDR_MSK, '1' +
-		     ((char)(readl(&port->ip_mem-> pci_err_addr_l) &
+		     ((char)(readl(&port->ip_mem->pci_err_addr_l.raw) &
 			     IOC4_PCI_ERR_ADDR_MST_NUM_MSK) >> 1),
-		     (readl(&port->ip_mem->pci_err_addr_l)
+		     (readl(&port->ip_mem->pci_err_addr_l.raw)
 				& IOC4_PCI_ERR_ADDR_MST_TYP_MSK)
 				? "RX" : "TX");
 
-		if (readl(&port->ip_mem->pci_err_addr_l)
+		if (readl(&port->ip_mem->pci_err_addr_l.raw)
 						& IOC4_PCI_ERR_ADDR_MUL_ERR) {
 			printk(KERN_ERR
 				"Multiple errors occurred\n");
@@ -1018,26 +981,26 @@
 				"other_ies = 0x%x\n",
 			       (intr_type == IOC4_SIO_INTR_TYPE) ? "sio" :
 			       "other", this_ir,
-			       readl(&soft->is_ioc4_mem_addr->sio_ir),
-			       readl(&soft->is_ioc4_mem_addr->sio_ies_ro),
-			       readl(&soft->is_ioc4_mem_addr->other_ir),
-			       readl(&soft->is_ioc4_mem_addr->other_ies_ro));
+			       readl(&soft->is_ioc4_misc_addr->sio_ir.raw),
+			       readl(&soft->is_ioc4_misc_addr->sio_ies.raw),
+			       readl(&soft->is_ioc4_misc_addr->other_ir.raw),
+			       readl(&soft->is_ioc4_misc_addr->other_ies.raw));
 		}
 	}
 #ifdef DEBUG_INTERRUPTS
 	{
-		struct ioc4_mem __iomem *mem = soft->is_ioc4_mem_addr;
+		struct ioc4_misc_regs __iomem *mem = soft->is_ioc4_misc_addr;
 		spinlock_t *lp = &soft->is_ir_lock;
 		unsigned long flag;
 
 		spin_lock_irqsave(&soft->is_ir_lock, flag);
-		printk ("%s : %d : mem 0x%p sio_ir 0x%x sio_ies_ro 0x%x "
-				"other_ir 0x%x other_ies_ro 0x%x mask 0x%x\n",
+		printk ("%s : %d : mem 0x%p sio_ir 0x%x sio_ies 0x%x "
+				"other_ir 0x%x other_ies 0x%x mask 0x%x\n",
 		     __FUNCTION__, __LINE__,
-		     (void *)mem, readl(&mem->sio_ir),
-		     readl(&mem->sio_ies_ro),
-		     readl(&mem->other_ir),
-		     readl(&mem->other_ies_ro),
+		     (void *)mem, readl(&mem->sio_ir.raw),
+		     readl(&mem->sio_ies.raw),
+		     readl(&mem->other_ir.raw),
+		     readl(&mem->other_ies.raw),
 		     IOC4_OTHER_IR_ATA_INT | IOC4_OTHER_IR_ATA_MEMERR);
 		spin_unlock_irqrestore(&soft->is_ir_lock, flag);
 	}
@@ -1056,7 +1019,7 @@
  */
 static int inline ioc4_attach_local(struct pci_dev *pdev,
 			struct ioc4_control *control,
-			struct ioc4_soft *soft, void __iomem *ioc4_mem,
+			struct ioc4_soft *soft, void __iomem *ioc4_misc,
 			void __iomem *ioc4_serial)
 {
 	struct ioc4_port *port;
@@ -1076,7 +1039,7 @@
 				ioc4_revid, ioc4_revid_min);
 		return -EPERM;
 	}
-	BUG_ON(ioc4_mem == NULL);
+	BUG_ON(ioc4_misc == NULL);
 	BUG_ON(ioc4_serial == NULL);
 
 	/* Create port structures for each port */
@@ -1103,7 +1066,7 @@
 		port->ip_pci_bus_speed = IOC4_SER_XIN_CLK;
 		port->ip_baud = 9600;
 		port->ip_control = control;
-		port->ip_mem = ioc4_mem;
+		port->ip_mem = ioc4_misc;
 		port->ip_serial = ioc4_serial;
 
 		/* point to the right hook */
@@ -1604,14 +1567,12 @@
 	switch (proto) {
 	case PROTO_RS232:
 		/* Clear the appropriate GIO pin */
-		writel(0, (&port->ip_mem->gppr_0 +
-				  hooks->rs422_select_pin));
+		writel(0, (&port->ip_mem->gppr[hooks->rs422_select_pin].raw));
 		break;
 
 	case PROTO_RS422:
 		/* Set the appropriate GIO pin */
-		writel(1, (&port->ip_mem->gppr_0 +
-				  hooks->rs422_select_pin));
+		writel(1, (&port->ip_mem->gppr[hooks->rs422_select_pin].raw));
 		break;
 
 	default:
@@ -1885,7 +1846,7 @@
 		if (sio_ir & hooks->intr_delta_dcd) {
 			/* ACK the interrupt */
 			writel(hooks->intr_delta_dcd,
-				&port->ip_mem->sio_ir);
+				&port->ip_mem->sio_ir.raw);
 
 			shadow = readl(&port->ip_serial_regs->shadow);
 
@@ -1907,7 +1868,7 @@
 		if (sio_ir & hooks->intr_delta_cts) {
 			/* ACK the interrupt */
 			writel(hooks->intr_delta_cts,
-					&port->ip_mem->sio_ir);
+					&port->ip_mem->sio_ir.raw);
 
 			shadow = readl(&port->ip_serial_regs->shadow);
 
@@ -1928,7 +1889,7 @@
 		if (sio_ir & hooks->intr_rx_timer) {
 			/* ACK the interrupt */
 			writel(hooks->intr_rx_timer,
-				&port->ip_mem->sio_ir);
+				&port->ip_mem->sio_ir.raw);
 
 			if ((port->ip_notify & N_DATA_READY)
 					&& (port->ip_port)) {
@@ -1974,7 +1935,7 @@
 
 			/* ACK the interrupt */
 			writel(hooks->intr_tx_explicit,
-					&port->ip_mem->sio_ir);
+					&port->ip_mem->sio_ir.raw);
 
 			if (port->ip_notify & N_OUTPUT_LOWAT)
 				ioc4_cb_output_lowat(port);
@@ -2634,7 +2595,8 @@
 {
 	struct ioc4_port *port;
 	struct uart_port *the_port;
-	struct ioc4_control *control = pci_get_drvdata(pdev);
+	struct ioc4_driver_data *idd = pci_get_drvdata(pdev);
+	struct ioc4_control *control = idd->idd_serial_data;
 	int ii;
 
 	DPRINT_CONFIG(("%s: attach pdev 0x%p - control 0x%p\n",
@@ -2680,55 +2642,29 @@
 
 /**
  * ioc4_serial_attach_one - register attach function
- *		called per card found from ioc4_serial_detect as part
- *		of module_init().
- * @pdev: handle for this card
- * @pci_id: pci id for this card
+ *		called per card found from IOC4 master module.
+ * @idd: Master module data for this IOC4
  */
 int
-ioc4_serial_attach_one(struct pci_dev *pdev, const struct pci_device_id *pci_id)
+ioc4_serial_attach_one(struct ioc4_driver_data *idd)
 {
-	struct ioc4_mem __iomem *mem;
-	unsigned long tmp_addr, tmp_addr1;
+	unsigned long tmp_addr1;
 	struct ioc4_serial __iomem *serial;
 	struct ioc4_soft *soft;
 	struct ioc4_control *control;
-	int tmp, ret = 0;
-
+	int ret = 0;
 
-	DPRINT_CONFIG(("%s (0x%p, 0x%p)\n", __FUNCTION__, pdev, pci_id));
 
-	/* Map in the ioc4 memory */
-	tmp_addr = pci_resource_start(pdev, 0);
-	if (!tmp_addr) {
-		printk(KERN_WARNING
-			 "ioc4 (%p) : unable to get PIO mapping for "
-				"MEM space\n", (void *)pdev);
-		return -ENODEV;
-	}
-	if (!request_region(tmp_addr, sizeof(struct ioc4_mem), "sioc4_mem")) {
-		printk(KERN_ALERT
-			"ioc4 (%p): unable to get request region for "
-			"MEM space\n", (void *)pdev);
-		return -ENODEV;
-	}
-	mem = ioremap(tmp_addr, sizeof(struct ioc4_mem));
-	if (!mem) {
-		printk(KERN_WARNING
-			 "ioc4 (%p) : unable to remap ioc4 memory\n",
-				(void *)pdev);
-		ret = -ENODEV;
-		goto out1;
-	}
+	DPRINT_CONFIG(("%s (0x%p, 0x%p)\n", __FUNCTION__, idd->idd_pdev, idd->idd_pci_id));
 
 	/* request serial registers */
-	tmp_addr1 = pci_resource_start(pdev, 0) + IOC4_SERIAL_OFFSET;
+	tmp_addr1 = idd->idd_bar0 + IOC4_SERIAL_OFFSET;
 
 	if (!request_region(tmp_addr1, sizeof(struct ioc4_serial),
 					"sioc4_uart")) {
 		printk(KERN_WARNING
 			"ioc4 (%p): unable to get request region for "
-				"uart space\n", (void *)pdev);
+				"uart space\n", (void *)idd->idd_pdev);
 		ret = -ENODEV;
 		goto out1;
 	}
@@ -2736,12 +2672,12 @@
 	if (!serial) {
 		printk(KERN_WARNING
 			 "ioc4 (%p) : unable to remap ioc4 serial register\n",
-				(void *)pdev);
+				(void *)idd->idd_pdev);
 		ret = -ENODEV;
 		goto out2;
 	}
 	DPRINT_CONFIG(("%s : mem 0x%p, serial 0x%p\n",
-				__FUNCTION__, (void *)mem, (void *)serial));
+				__FUNCTION__, (void *)idd->idd_misc_regs, (void *)serial));
 
 	/* Get memory for the new card */
 	control = kmalloc(sizeof(struct ioc4_control) * IOC4_NUM_SERIAL_PORTS,
@@ -2754,59 +2690,57 @@
 		goto out2;
 	}
 	memset(control, 0, sizeof(struct ioc4_control));
-	pci_set_drvdata(pdev, control);
+	idd->idd_serial_data = control;
 
 	/* Allocate the soft structure */
 	soft = kmalloc(sizeof(struct ioc4_soft), GFP_KERNEL);
 	if (!soft) {
 		printk(KERN_WARNING
 		       "ioc4 (%p): unable to get memory for the soft struct\n",
-		       (void *)pdev);
+		       (void *)idd->idd_pdev);
 		ret = -ENOMEM;
 		goto out3;
 	}
 	memset(soft, 0, sizeof(struct ioc4_soft));
 
 	spin_lock_init(&soft->is_ir_lock);
-	soft->is_ioc4_mem_addr = mem;
+	soft->is_ioc4_misc_addr = idd->idd_misc_regs;
 	soft->is_ioc4_serial_addr = serial;
 
 	/* Init the IOC4 */
-	pci_read_config_dword(pdev, PCI_COMMAND, &tmp);
-	pci_write_config_dword(pdev, PCI_COMMAND,
-			       tmp | PCI_COMMAND_PARITY | PCI_COMMAND_SERR);
-
-	writel(0xf << IOC4_SIO_CR_CMD_PULSE_SHIFT, &mem->sio_cr);
+	writel(0xf << IOC4_SIO_CR_CMD_PULSE_SHIFT,
+	       &idd->idd_misc_regs->sio_cr.raw);
 
 	/* Enable serial port mode select generic PIO pins as outputs */
 	writel(IOC4_GPCR_UART0_MODESEL | IOC4_GPCR_UART1_MODESEL
 		| IOC4_GPCR_UART2_MODESEL | IOC4_GPCR_UART3_MODESEL,
-		&mem->gpcr_s);
+		&idd->idd_misc_regs->gpcr_s.raw);
 
-	/* Clear and disable all interrupts */
+	/* Clear and disable all serial interrupts */
 	write_ireg(soft, ~0, IOC4_W_IEC, IOC4_SIO_INTR_TYPE);
-	writel(~0, &mem->sio_ir);
-	write_ireg(soft, ~(IOC4_OTHER_IR_ATA_INT | IOC4_OTHER_IR_ATA_MEMERR),
-			IOC4_W_IEC, IOC4_OTHER_INTR_TYPE);
-	writel(~(IOC4_OTHER_IR_ATA_MEMERR | IOC4_OTHER_IR_ATA_MEMERR),
-					&mem->other_ir);
+	writel(~0, &idd->idd_misc_regs->sio_ir.raw);
+	write_ireg(soft, IOC4_OTHER_IR_SER_MEMERR, IOC4_W_IEC,
+		   IOC4_OTHER_INTR_TYPE);
+	writel(IOC4_OTHER_IR_SER_MEMERR, &idd->idd_misc_regs->other_ir.raw);
 	control->ic_soft = soft;
-	if (!request_irq(pdev->irq, ioc4_intr, SA_SHIRQ,
+
+	/* Hook up interrupt handler */
+	if (!request_irq(idd->idd_pdev->irq, ioc4_intr, SA_SHIRQ,
 				"sgi-ioc4serial", (void *)soft)) {
-		control->ic_irq = pdev->irq;
+		control->ic_irq = idd->idd_pdev->irq;
 	} else {
 		printk(KERN_WARNING
 		    "%s : request_irq fails for IRQ 0x%x\n ",
-			__FUNCTION__, pdev->irq);
+			__FUNCTION__, idd->idd_pdev->irq);
 	}
-	if ((ret = ioc4_attach_local(pdev, control, soft,
-				soft->is_ioc4_mem_addr,
+	if ((ret = ioc4_attach_local(idd->idd_pdev, control, soft,
+				soft->is_ioc4_misc_addr,
 				soft->is_ioc4_serial_addr)))
 		goto out4;
 
 	/* register port with the serial core */
 
-	if ((ret = ioc4_serial_core_attach(pdev)))
+	if ((ret = ioc4_serial_core_attach(idd->idd_pdev)))
 		goto out4;
 
 	return ret;
@@ -2819,7 +2753,6 @@
 out2:
 	release_region(tmp_addr1, sizeof(struct ioc4_serial));
 out1:
-	release_region(tmp_addr, sizeof(struct ioc4_mem));
 
 	return ret;
 }
@@ -2828,11 +2761,10 @@
 /**
  * ioc4_serial_remove_one - detach function
  *
- * @pdev: handle for this card
+ * @idd: IOC4 master module data for this IOC4
  */
 
-#if 0
-void ioc4_serial_remove_one(struct pci_dev *pdev)
+int ioc4_serial_remove_one(struct ioc4_driver_data *idd)
 {
 	int ii;
 	struct ioc4_control *control;
@@ -2840,7 +2772,7 @@
 	struct ioc4_port *port;
 	struct ioc4_soft *soft;
 
-	control = pci_get_drvdata(pdev);
+	control = idd->idd_serial_data;
 
 	for (ii = 0; ii < IOC4_NUM_SERIAL_PORTS; ii++) {
 		the_port = &control->ic_port[ii].icp_uart_port;
@@ -2867,10 +2799,17 @@
 		kfree(soft);
 	}
 	kfree(control);
-	pci_set_drvdata(pdev, NULL);
-	uart_unregister_driver(&ioc4_uart);
+	idd->idd_serial_data = NULL;
+
+	return 0;
 }
-#endif
+
+static struct ioc4_submodule ioc4_serial_submodule = {
+	.is_name = "IOC4_serial",
+	.is_owner = THIS_MODULE,
+	.is_probe = ioc4_serial_attach_one,
+	.is_remove = ioc4_serial_remove_one,
+};
 
 /**
  * ioc4_serial_init - module init
@@ -2886,12 +2825,20 @@
 			__FUNCTION__);
 		return ret;
 	}
-	return 0;
+
+	/* register with IOC4 main module */
+	return ioc4_register_submodule(&ioc4_serial_submodule);
 }
 
+static void __devexit ioc4_serial_exit(void)
+{
+	ioc4_unregister_submodule(&ioc4_serial_submodule);
+	uart_unregister_driver(&ioc4_uart);
+}
+
+module_init(ioc4_serial_init);
+module_exit(ioc4_serial_exit);
+
 MODULE_AUTHOR("Pat Gefre - Silicon Graphics Inc. (SGI) <pfg@sgi.com>");
 MODULE_DESCRIPTION("Serial PCI driver module for SGI IOC4 Base-IO Card");
 MODULE_LICENSE("GPL");
-
-EXPORT_SYMBOL(ioc4_serial_init);
-EXPORT_SYMBOL(ioc4_serial_attach_one);
Index: linux/drivers/ide/pci/sgiioc4.c
===================================================================
--- linux.orig/drivers/ide/pci/sgiioc4.c	2005-05-23 11:27:04.774745592 -0500
+++ linux/drivers/ide/pci/sgiioc4.c	2005-05-23 11:27:30.804734843 -0500
@@ -34,7 +34,7 @@
 #include <linux/mm.h>
 #include <linux/ioport.h>
 #include <linux/blkdev.h>
-#include <linux/ioc4_common.h>
+#include <linux/ioc4.h>
 #include <asm/io.h>
 
 #include <linux/ide.h>
@@ -715,14 +715,34 @@
 };
 
 int
-ioc4_ide_attach_one(struct pci_dev *dev, const struct pci_device_id *id)
+ioc4_ide_attach_one(struct ioc4_driver_data *idd)
 {
-	return pci_init_sgiioc4(dev, &sgiioc4_chipsets[id->driver_data]);
+	return pci_init_sgiioc4(idd->idd_pdev,
+				&sgiioc4_chipsets[idd->idd_pci_id->driver_data]);
 }
 
+static struct ioc4_submodule ioc4_ide_submodule = {
+	.is_name = "IOC4_ide",
+	.is_owner = THIS_MODULE,
+	.is_probe = ioc4_ide_attach_one,
+/*	.is_remove = ioc4_ide_remove_one,	*/
+};
+
+static int __devinit
+ioc4_ide_init(void)
+{
+	return ioc4_register_submodule(&ioc4_ide_submodule);
+}
+
+static void __devexit
+ioc4_ide_exit(void)
+{
+	ioc4_unregister_submodule(&ioc4_ide_submodule);
+}
+
+module_init(ioc4_ide_init);
+module_exit(ioc4_ide_exit);
 
 MODULE_AUTHOR("Aniket Malatpure - Silicon Graphics Inc. (SGI)");
 MODULE_DESCRIPTION("IDE PCI driver module for SGI IOC4 Base-IO Card");
 MODULE_LICENSE("GPL");
-
-EXPORT_SYMBOL(ioc4_ide_attach_one);
Index: linux/include/linux/ioc4.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/include/linux/ioc4.h	2005-05-23 15:55:17.660359813 -0500
@@ -0,0 +1,156 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (c) 2005 Silicon Graphics, Inc.  All Rights Reserved.
+ */
+
+#ifndef _LINUX_IOC4_H
+#define _LINUX_IOC4_H
+
+#include <linux/interrupt.h>
+
+/***********************************
+ * Structures needed by subdrivers *
+ ***********************************/
+
+/* This structure fully describes the IOC4 miscellaneous registers which
+ * appear at bar[0]+0x00000 through bar[0]+0x0005c.  The corresponding
+ * PCI resource is managed by the main IOC4 driver because it contains
+ * registers of interest to many different IOC4 subdrivers.
+ */
+struct ioc4_misc_regs {
+	/* Miscellaneous IOC4 registers */
+	union ioc4_pci_err_addr_l {
+		uint32_t raw;
+		struct {
+			uint32_t valid:1;	/* Address captured */
+			uint32_t master_id:4;	/* Unit causing error
+						 * 0/1: Serial port 0 TX/RX
+						 * 2/3: Serial port 1 TX/RX
+						 * 4/5: Serial port 2 TX/RX
+						 * 6/7: Serial port 3 TX/RX
+						 * 8: ATA/ATAPI
+						 * 9-15: Undefined
+						 */
+			uint32_t mul_err:1;	/* Multiple errors occurred */
+			uint32_t addr:26;	/* Bits 31-6 of error addr */
+		} fields;
+	} pci_err_addr_l;
+	uint32_t pci_err_addr_h;	/* Bits 63-32 of error addr */
+	union ioc4_sio_int {
+		uint32_t raw;
+		struct {
+			uint8_t tx_mt:1;	/* TX ring buffer empty */
+			uint8_t rx_full:1;	/* RX ring buffer full */
+			uint8_t rx_high:1;	/* RX high-water exceeded */
+			uint8_t rx_timer:1;	/* RX timer has triggered */
+			uint8_t delta_dcd:1;	/* DELTA_DCD seen */
+			uint8_t delta_cts:1;	/* DELTA_CTS seen */
+			uint8_t intr_pass:1;	/* Interrupt pass-through */
+			uint8_t tx_explicit:1;	/* TX, MCW, or delay complete */
+		} fields[4];
+	} sio_ir;		/* Serial interrupt state */
+	union ioc4_other_int {
+		uint32_t raw;
+		struct {
+			uint32_t ata_int:1;	/* ATA port passthru */
+			uint32_t ata_memerr:1;	/* ATA halted by mem error */
+			uint32_t memerr:4;	/* Serial halted by mem err */
+			uint32_t kbd_int:1;	/* kbd/mouse intr asserted */
+			uint32_t reserved:16;	/* zero */
+			uint32_t rt_int:1;	/* INT_OUT section latch */
+			uint32_t gen_int:8;	/* Intr. from generic pins */
+		} fields;
+	} other_ir;		/* Other interrupt state */
+	union ioc4_sio_int sio_ies;	/* Serial interrupt enable set */
+	union ioc4_other_int other_ies;	/* Other interrupt enable set */
+	union ioc4_sio_int sio_iec;	/* Serial interrupt enable clear */
+	union ioc4_other_int other_iec;	/* Other interrupt enable clear */
+	union ioc4_sio_cr {
+		uint32_t raw;
+		struct {
+			uint32_t cmd_pulse:4;	/* Bytebus strobe width */
+			uint32_t arb_diag:3;	/* PCI bus requester */
+			uint32_t sio_diag_idle:1;	/* Active ser req? */
+			uint32_t ata_diag_idle:1;	/* Active ATA req? */
+			uint32_t ata_diag_active:1;	/* ATA req is winner */
+			uint32_t reserved:22;	/* zero */
+		} fields;
+	} sio_cr;
+	uint32_t unused1;
+	union ioc4_int_out {
+		uint32_t raw;
+		struct {
+			uint32_t count:16;	/* Period control */
+			uint32_t mode:3;	/* Output signal shape */
+			uint32_t reserved:11;	/* zero */
+			uint32_t diag:1;	/* Timebase control */
+			uint32_t int_out:1;	/* Current value */
+		} fields;
+	} int_out;		/* External interrupt output control */
+	uint32_t unused2;
+	union ioc4_gpcr {
+		uint32_t raw;
+		struct {
+			uint32_t dir:8;	/* Pin direction */
+			uint32_t edge:8;	/* Edge/level mode */
+			uint32_t reserved1:4;	/* zero */
+			uint32_t int_out_en:1;	/* INT_OUT enable */
+			uint32_t reserved2:11;	/* zero */
+		} fields;
+	} gpcr_s;		/* Generic PIO control set */
+	union ioc4_gpcr gpcr_c;	/* Generic PIO control clear */
+	union ioc4_gpdr {
+		uint32_t raw;
+		struct {
+			uint32_t gen_pin:8;	/* State of pins */
+			uint32_t reserved:24;
+		} fields;
+	} gpdr;			/* Generic PIO data */
+	uint32_t unused3;
+	union ioc4_gppr {
+		uint32_t raw;
+		struct {
+			uint32_t gen_pin:1;	/* Single pin state */
+			uint32_t reserved:31;
+		} fields;
+	} gppr[8];		/* Generic PIO pins */
+};
+
+/* One of these per IOC4
+ *
+ * The idd_serial_data field is present here, even though it's used
+ * solely by the serial subdriver, because the main IOC4 module
+ * properly owns pci_{get,set}_drvdata functionality.  This field
+ * allows that subdriver to stash its own drvdata somewhere.
+ */
+struct ioc4_driver_data {
+	struct list_head idd_list;
+	unsigned long idd_bar0;
+	struct pci_dev *idd_pdev;
+	const struct pci_device_id *idd_pci_id;
+	struct __iomem ioc4_misc_regs *idd_misc_regs;
+	void *idd_serial_data;
+};
+
+/* One per submodule */
+struct ioc4_submodule {
+	struct list_head is_list;
+	char *is_name;
+	struct module *is_owner;
+	int (*is_probe) (struct ioc4_driver_data *);
+	int (*is_remove) (struct ioc4_driver_data *);
+};
+
+#define IOC4_NUM_CARDS		8	/* max cards per partition */
+
+/**********************************
+ * Functions needed by submodules *
+ **********************************/
+
+extern int ioc4_register_submodule(struct ioc4_submodule *);
+extern void ioc4_unregister_submodule(struct ioc4_submodule *);
+
+#endif				/* _LINUX_IOC4_H */
Index: linux/Documentation/sgi-ioc4.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/Documentation/sgi-ioc4.txt	2005-05-23 11:27:30.819383121 -0500
@@ -0,0 +1,45 @@
+The SGI IOC4 PCI device is a bit of a strange beast, so some notes on
+it are in order.
+
+First, even though the IOC4 performs multiple functions, such as an
+IDE controller, a serial controller, a PS/2 keyboard/mouse controller,
+and an external interrupt mechanism, it's not implemented as a
+multifunction device.  The consequence of this from a software
+standpoint is that all these functions share a single IRQ, and
+they can't all register to own the same PCI device ID.  To make
+matters a bit worse, some of the register blocks (and even registers
+themselves) present in IOC4 are mixed-purpose between these several
+functions, meaning that there's no clear "owning" device driver.
+
+The solution is to organize the IOC4 driver into several independent
+drivers, "ioc4", "sgiioc4", and "ioc4_serial".  Note that there is no
+PS/2 controller driver as this functionality has never been wired up
+on a shipping IO card.
+
+ioc4
+====
+This is the core (or shim) driver for IOC4.  It is responsible for
+initializing the basic functionality of the chip, and allocating
+the PCI resources that are shared between the IOC4 functions.
+
+This driver also provides registration functions that the other
+IOC4 drivers can call to make their presence known.  Each driver
+needs to provide a probe and remove function, which are invoked
+by the core driver at appropriate times.  The interface of these
+IOC4 function probe and remove operations isn't precisely the same
+as PCI device probe and remove operations, but is logically the
+same operation.
+
+sgiioc4
+=======
+This is the IDE driver for IOC4.  Its name isn't very descriptive
+simply for historical reasons (it used to be the only IOC4 driver
+component).  There's not much to say about it other than it hooks
+up to the ioc4 driver via the appropriate registration, probe, and
+remove functions.
+
+ioc4_serial
+===========
+This is the serial driver for IOC4.  There's not much to say about it
+other than it hooks up to the ioc4 driver via the appropriate registration,
+probe, and remove functions.

-- 
Brent Casavant                          If you had nothing to fear,
bcasavan@sgi.com                        how then could you be brave?
Silicon Graphics, Inc.                    -- Queen Dama, Source Wars
