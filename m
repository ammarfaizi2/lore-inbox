Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVCKXkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVCKXkh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 18:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbVCKXT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 18:19:27 -0500
Received: from fmr17.intel.com ([134.134.136.16]:56787 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261824AbVCKW5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 17:57:37 -0500
Date: Fri, 11 Mar 2005 16:17:56 -0800
From: long <tlnguyen@snoqualmie.dp.intel.com>
Message-Id: <200503120017.j2C0HucD020331@snoqualmie.dp.intel.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 6/6] PCI Express Advanced Error Reporting Driver
Cc: greg@kroah.com, tom.l.nguyen@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes the source code of startup component (last patch
to be applied) of PCI Express Advanced Error Reporting driver.

Signed-off-by: T. Long Nguyen <tom.l.nguyen@intel.com>

--------------------------------------------------------------------
diff -urpN linux-2.6.11-rc5/arch/i386/Kconfig patch-2.6.11-rc5-aerc3-split6/arch/i386/Kconfig
--- linux-2.6.11-rc5/arch/i386/Kconfig	2005-02-24 11:39:54.000000000 -0500
+++ patch-2.6.11-rc5-aerc3-split6/arch/i386/Kconfig	2005-03-11 11:28:42.000000000 -0500
@@ -1131,8 +1131,6 @@ config PCI_MMCONFIG
 	select ACPI_BOOT
 	default y
 
-source "drivers/pci/pcie/Kconfig"
-
 source "drivers/pci/Kconfig"
 
 config ISA
diff -urpN linux-2.6.11-rc5/drivers/pci/Kconfig patch-2.6.11-rc5-aerc3-split6/drivers/pci/Kconfig
--- linux-2.6.11-rc5/drivers/pci/Kconfig	2005-02-24 11:40:05.000000000 -0500
+++ patch-2.6.11-rc5-aerc3-split6/drivers/pci/Kconfig	2005-03-11 12:17:29.000000000 -0500
@@ -1,4 +1,9 @@
 #
+# PCI Express configuration
+#
+source "drivers/pci/pcie/Kconfig"
+
+#
 # PCI configuration
 #
 config PCI_MSI
diff -urpN linux-2.6.11-rc5/drivers/pci/pcie/aer/aerdrv.c patch-2.6.11-rc5-aerc3-split6/drivers/pci/pcie/aer/aerdrv.c
--- linux-2.6.11-rc5/drivers/pci/pcie/aer/aerdrv.c	1969-12-31 19:00:00.000000000 -0500
+++ patch-2.6.11-rc5-aerc3-split6/drivers/pci/pcie/aer/aerdrv.c	2005-03-10 10:25:15.000000000 -0500
@@ -0,0 +1,254 @@
+/*
+ * Copyright (C) 2005 Intel
+ * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/pm.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/pcieport_if.h>
+
+#include "aerdrv.h"
+
+/*
+ * Version Information
+ */
+#define DRIVER_VERSION "v1.0"
+#define DRIVER_AUTHOR "tom.l.nguyen@intel.com"
+#define DRIVER_DESC "Root Port Advanced Error Reporting Driver"
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
+
+static int __devinit aerdrv_probe (struct pcie_device *dev, 
+	const struct pcie_port_service_id *id );
+static void aerdrv_remove(struct pcie_device *dev);
+static int aerdrv_suspend(struct pcie_device *dev, u32 state) {return 0;}
+static int aerdrv_resume(struct pcie_device *dev) {return 0;}
+
+/*
+ * PCI Express bus's AER Root service driver data structure
+ */
+static struct pcie_port_service_id service_id[] = { { 
+	.vendor = PCI_ANY_ID, 
+	.device = PCI_ANY_ID,
+	.port_type = PCIE_RC_PORT, 
+	.service_type = PCIE_PORT_SERVICE_AER,
+	}, { /* end: all zeroes */ }
+};
+
+static struct pcie_port_service_driver root_aerdrv = {
+	.name		= "aer",
+	.id_table	= &service_id[0],
+
+	.probe		= aerdrv_probe,
+	.remove		= aerdrv_remove,
+
+	.suspend	= aerdrv_suspend,
+	.resume		= aerdrv_resume,
+};
+
+/**
+ * aerdrv_irq - Root Port's ISR
+ * @irq: IRQ assigned to Root Port
+ * @context: pointer to Root Port data structure
+ * @r: pointer struct pt_regs
+ *
+ * Invoked when Root Port detects AER messages.
+ **/
+irqreturn_t aerdrv_irq(int irq, void *context, struct pt_regs * r)
+{
+	unsigned int status, id;
+	struct pcie_device *pdev = (struct pcie_device *)context;
+	struct aer_rpc *rpc = get_service_data(pdev);
+	int next_prod_idx;
+	unsigned long flags;
+
+	/* 
+	 * Must lock access to Root Error Status Reg, Root Error ID Reg, 
+	 * and Root error producer/consumer index 
+	 */
+	spin_lock_irqsave(&rpc->e_lock, flags);
+
+	/* Read error status */
+	pci_read_config_dword(pdev->port, ROOT_ERROR_STATUS_REG, &status);
+	if (!(status & ROOT_ERR_STATUS_MASKS)) {
+		spin_unlock_irqrestore(&rpc->e_lock, flags);
+		return IRQ_NONE;
+	}
+
+	/* Read error source and clear error status */
+	pci_read_config_dword(pdev->port, CORRECTABLE_SOURCE_ID_REG, &id);
+	pci_write_config_dword(pdev->port, ROOT_ERROR_STATUS_REG, status);
+	
+	/* Store error source for later DPC handler */
+	next_prod_idx = rpc->prod_idx + 1;
+	if (next_prod_idx == AER_ERROR_SOURCES_MAX)
+		next_prod_idx = 0;
+	if (next_prod_idx == rpc->cons_idx) {
+		/* 
+		 * Error Storm Condition - possibly the same error occurred.
+		 * Drop the error.
+		 */
+		spin_unlock_irqrestore(&rpc->e_lock, flags);
+		return IRQ_HANDLED;
+	} 
+	rpc->e_sources[rpc->prod_idx].status =  status & ROOT_ERR_STATUS_MASKS;
+	rpc->e_sources[rpc->prod_idx].id =  id;
+	rpc->prod_idx = next_prod_idx;
+	spin_unlock_irqrestore(&rpc->e_lock, flags);
+	
+	/*  Invoke DPC handler */
+	schedule_work(&rpc->dpc_handler);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * aerdrv_alloc_rpc - allocate Root Port data structure
+ * @dev: pointer to the pcie_dev data structure
+ *
+ * Invoked when Root Port's AER service is loaded.
+ **/
+static struct aer_rpc* aerdrv_alloc_rpc(struct pcie_device *dev)
+{
+	struct aer_rpc *rpc;
+	struct pci_dev *pdev = dev->port;
+	unsigned int busnr;
+
+	if (!(rpc = (struct aer_rpc *)kmalloc(sizeof(struct aer_rpc), 
+		GFP_KERNEL)))
+		return NULL;
+
+	memset(rpc, 0, sizeof(struct aer_rpc));
+	/* 
+	 * Initialize Root lock access, e_lock, to Root Error Status Reg, 
+	 * Root Error ID Reg, and Root error producer/consumer index. 
+	 */
+	rpc->e_lock = SPIN_LOCK_UNLOCKED; 		
+
+	/* 
+	 * Initialize semaphore access required to access, add, remove,
+	 * or print AER aware devices in this RPC hierarchy 
+	 */
+	sema_init(&rpc->rpc_sema, 1);
+
+	INIT_LIST_HEAD(&rpc->node);
+	INIT_LIST_HEAD(&rpc->children);
+	rpc->rpd = dev;
+	rpc->self_id = (pdev->bus->number << 8) | pdev->devfn;	
+	pci_read_config_dword(pdev, PCI_PRIMARY_BUS, &busnr);
+	rpc->primary = busnr & 0xff;
+	rpc->secondary = (busnr >> 8) & 0xff;
+	rpc->subordinate = (busnr >> 16) & 0xff;
+	INIT_WORK(&rpc->dpc_handler, aer_isr, (void *)dev);
+	rpc->prod_idx = rpc->cons_idx = 0;
+
+	/* Use PCIE bus function to store rpc into PCIE device */
+	set_service_data(dev, rpc);	
+	
+	return rpc;
+}
+
+/**
+ * aerdrv_remove - clean up resources
+ * @dev: pointer to the pcie_dev data structure
+ *
+ * Invoked when PCI Express bus unloads or AER probe fails.
+ **/
+static void aerdrv_remove(struct pcie_device *dev)
+{
+	struct aer_rpc *rpc = get_service_data(dev);
+	struct device *device = &dev->device;
+
+	if (rpc) {
+		/* If register interrupt service, it must be free. */
+		if (rpc->isr)			
+			free_irq(dev->irq, dev);
+
+		/* Delete this node from a RC hierarchy */
+		aer_delete_rootport(rpc);
+		set_service_data(dev, NULL);
+	}
+
+	/* Clean up */
+	aer_cleanup(to_service_driver(device->driver));
+}
+
+/**
+ * aerdrv_probe - initialize resources
+ * @dev: pointer to the pcie_dev data structure
+ * @id: pointer to the service id data structure
+ *
+ * Invoked when PCI Express bus loads AER service driver.
+ **/
+static int __devinit aerdrv_probe (struct pcie_device *dev, 
+				const struct pcie_port_service_id *id )
+{
+	int status;
+	struct aer_rpc *rpc;
+	struct device *device = &dev->device;
+
+	/* Init */
+	if ((status = aer_init(&root_aerdrv))) {
+		printk(KERN_DEBUG "%s: AER service init fails - %s\n",
+			__FUNCTION__, (status == OSC_METHOD_NOT_SUPPORTED) ? 
+			"No ACPI _OSC support" : "Run ACPI _OSC fails");
+		return status;
+	}
+
+	/* Alloc rpc data structure */
+	if (!(rpc = aerdrv_alloc_rpc(dev))) {
+		printk(KERN_DEBUG "%s: Alloc rpc fails on PCIE device[%s]\n",
+			__FUNCTION__, device->bus_id);
+		aerdrv_remove(dev);
+		return -ENOMEM;
+	}
+
+	/* Request IRQ ISR */
+	if ((status = request_irq(dev->irq, aerdrv_irq, SA_SHIRQ, "aerdrv", 
+				dev))) {
+		printk(KERN_DEBUG "%s: Request ISR fails on PCIE device[%s]\n", 
+			__FUNCTION__, device->bus_id);
+		aerdrv_remove(dev);
+		return status;
+	}
+	rpc->isr = 1;	
+
+	/* Add rpc into a RC hierarchy */
+	if ((status = aer_add_rootport(rpc))) {
+		printk(KERN_DEBUG "%s: Add rpc fails on PCIE device[%s]\n", 
+			__FUNCTION__, device->bus_id);
+		aerdrv_remove(dev);
+	}
+
+	return status;
+}
+
+/**
+ * aerdrv_service_init - register AER root service driver
+ *
+ * Invoked when AER root service driver is loaded.
+ **/
+static int __init aerdrv_service_init(void)
+{
+	return pcie_port_service_register(&root_aerdrv);
+}
+
+/**
+ * aerdrv_service_exit - unregister AER root service driver
+ *
+ * Invoked when AER root service driver is unloaded.
+ **/
+static void __exit aerdrv_service_exit(void) 
+{
+	pcie_port_service_unregister(&root_aerdrv);
+}
+
+module_init(aerdrv_service_init);
+module_exit(aerdrv_service_exit);
diff -urpN linux-2.6.11-rc5/drivers/pci/pcie/aer/aerdrv.h patch-2.6.11-rc5-aerc3-split6/drivers/pci/pcie/aer/aerdrv.h
--- linux-2.6.11-rc5/drivers/pci/pcie/aer/aerdrv.h	1969-12-31 19:00:00.000000000 -0500
+++ patch-2.6.11-rc5-aerc3-split6/drivers/pci/pcie/aer/aerdrv.h	2005-03-10 10:32:52.000000000 -0500
@@ -0,0 +1,178 @@
+/*
+ * Copyright (C) 2005 Intel
+ * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
+ *
+ */
+
+#ifndef _AERDRV_H_
+#define _AERDRV_H_
+
+#include <linux/pcieport_if.h>
+#include <linux/aer.h>
+#include "aerdrv_event.h"
+
+#define VERBOSE_LIMIT_DISPLAY		1
+#define VERBOSE_FULL_DISPLAY		2
+#define VERBOSE_RAW_DISPLAY		3
+#define VERBOSE_MASK			0x3 
+
+#define OSC_METHOD_RUN_SUCCESS		0
+#define OSC_METHOD_NOT_SUPPORTED	1
+#define OSC_METHOD_RUN_FAILURE		2
+
+#define PCIE_PORT_TYPE_MASK		0xf
+#define PCIE_PORT(d)			((d & 0x4) && (d != 0x7))
+#define PCIE_ROOT_PORT(d)		(d == PCIE_RC_PORT)
+#define PCIE_SWITCH_PORT(d)		(PCIE_PORT(d) && !PCIE_ROOT_PORT(d)) 
+
+/* Root Device Control Register Bits */
+#define ROOT_ERR_COR_REPORT_ENABLE_BIT		1
+#define ROOT_ERR_NONFATAL_REPORT_ENABLE_BIT	2
+#define ROOT_ERR_FATAL_REPORT_ENABLE_BIT	4
+#define ROOT_ERR_UR_REPORT_ENABLE_BIT		8
+#define ROOT_ERR_REPORT_ENABLE_BITS	(ROOT_ERR_COR_REPORT_ENABLE_BIT | \
+					ROOT_ERR_NONFATAL_REPORT_ENABLE_BIT | \
+					ROOT_ERR_FATAL_REPORT_ENABLE_BIT | \
+					ROOT_ERR_UR_REPORT_ENABLE_BIT)
+
+/* Root Error Status Register Bits */
+#define ROOT_ERR_STATUS_COR_BIT_MASK		0x01
+#define ROOT_ERR_STATUS_MULTI_COR_BIT_MASK	0x02
+#define ROOT_ERR_STATUS_UNCOR_BIT_MASK		0x04
+#define ROOT_ERR_STATUS_MULTI_UNCOR_BIT_MASK 	0x08
+#define ROOT_ERR_STATUS_MASKS			0x0f
+#define ROOT_ERR_STATUS_CORRECTABLE(d)	(d & (ROOT_ERR_STATUS_COR_BIT_MASK | \
+					ROOT_ERR_STATUS_MULTI_COR_BIT_MASK))
+#define ROOT_ERR_STATUS_UNCORRECTABLE(d) (d & (ROOT_ERR_STATUS_UNCOR_BIT_MASK |\
+					ROOT_ERR_STATUS_MULTI_UNCOR_BIT_MASK))
+
+#define SYSTEM_ERROR_INTR_ON_MESG_DISABLED	0xfff8
+#define ROOT_PORT_INTR_ON_MESG_ENABLED		0x7
+#define ERR_SOURCE_ID_MASK			0xffff
+#define ERR_COR_ID(d)			(d & ERR_SOURCE_ID_MASK)
+#define ERR_UNCOR_ID(d)			(d >> 16)
+#define FIRST_ERROR(d)			(d & 1)
+#define NEXT_ERROR(d)			((d >> 1) & 1)
+
+#define AER_DEVICE_BUS(id)		(id >> 8)
+#define AER_DEVICE_DEV(id)		((id >> 3) & 0x1f)
+#define AER_DEVICE_FUNC(id)		(id & 0x7)
+	
+#define ROOT_CONFIG_COR_ERROR_MASKS	0
+#define ROOT_CONFIG_UNCOR_ERROR_SEVERITY (ERR_TRAINING |		\
+					ERR_DATA_LINK_PROTOCOL | 	\
+					ERR_RECEIVER_OVERFLOW | 	\
+					ERR_MALFORMED_TLP)
+#define ROOT_CONFIG_UNCOR_ERROR_MASKS	0
+#define AER_SUCCESS			0
+#define AER_UNSUCCESS			1
+#define AER_ERROR_SOURCES_MAX		100
+
+#define AER_LOG_TLP_MASKS		(ERR_POISONED_TLP |		\
+					ERR_ECRC |			\
+					ERR_UNSUPPORTED_REQUEST	|	\
+					ERR_COMPLETION_ABORT |		\
+					ERR_COMPLETION_UNEXPECT |	\
+					ERR_MALFORMED_TLP)
+
+struct err_source {
+	unsigned int status;
+	unsigned int id;
+};
+
+struct aer_rpc {
+ 	struct list_head node;
+ 	struct list_head children;	/* AER children of this root port */
+	struct pcie_device *rpd;	/* Root Port device */
+	struct work_struct dpc_handler;
+	struct err_source e_sources[AER_ERROR_SOURCES_MAX];
+	unsigned short prod_idx;	/* Error Producer Index */
+	unsigned short cons_idx;	/* Error Consumer Index */
+	unsigned short self_id;
+	int isr;
+	int primary;			/* Primary bus of this node */
+	int secondary;			/* Secondary bus of this node */
+	int subordinate; 		/* Subordinate bus of this node */
+
+	spinlock_t e_lock;		/* 
+					 * Lock access to Error Status/ID Regs
+					 * and error producer/consumer index 
+					 */
+ 
+	struct semaphore rpc_sema;	/* 
+					 * Semaphore access required to
+					 * access, add, remove, or print AER 
+				 	 * aware devices in this RPC hierarchy 
+					 */
+};
+
+union aer_device_attrib {
+	int type;
+	struct {
+		int type;
+		struct {
+			unsigned int primary		: 8;
+			unsigned int secondary		: 8;
+			unsigned int subordinate	: 8;
+			unsigned int reserved		: 8;
+		} bus;
+	} p2p;
+};
+
+struct aer_device_flags {
+	unsigned short tlp 	: 1;	/* Whether TLP header is available */
+	unsigned short reset 	: 1;	/* Whether a link reset is performed */
+	unsigned short multi	: 1;	/* Whether an error is first or multi */
+	unsigned short reserved : 13;
+};
+
+struct aer_device {
+ 	struct aer_device *parent;
+ 	struct list_head node;
+	struct list_head children;
+	struct pcie_aer_handle *handle;
+	unsigned short vendor;
+	unsigned short device;
+	unsigned int class_code;
+	unsigned short requestor_id;
+	struct aer_device_flags flags;
+	struct header_log_regs tlp;
+	union aer_device_attrib attribute;
+	
+	/* Error Frequency */
+	int correctables;
+	int uncorrectables;
+	int nonfatals;
+	int fatals;
+
+	/* Last Recorded */
+	union aer_error last_recorded_err;	
+	struct aer_record_time_stamp time_stamp;
+	
+	struct semaphore d_sema;	/* 
+					 * Used when logging an error
+					 *  reported by this device 
+					 */	
+};
+#define to_aer_device(d) container_of(d, struct aer_device, gendev)
+
+extern struct pcie_aer_handle aer_root_handle;
+extern struct pci_dev* get_root_pci_dev(unsigned short requestor_id);
+extern int aer_get_verbose(void);
+extern int aer_get_auto_mode(void);
+extern void aer_log_event(struct aer_device *dev);
+extern void aer_send_alert(union aer_error *error);
+extern int aer_event_log_init(void);
+extern void aer_event_log_cleanup(void);
+extern int aer_get_record(char *page, int verbose);
+extern void aer_set_auto_consume(void);
+extern int aer_sysfs_init(struct device_driver *drv);
+extern void aer_sysfs_cleanup(struct device_driver *drv);
+extern int aer_add_rootport(struct aer_rpc *rpc);
+extern void aer_delete_rootport(struct aer_rpc *rpc);
+extern int aer_init(struct pcie_port_service_driver *drv);
+extern void aer_cleanup(struct pcie_port_service_driver *drv);
+extern void aer_isr(void *context);
+extern char* aer_get_error_source_name(union aer_error *error);
+
+#endif //_AERDRV_H_
diff -urpN linux-2.6.11-rc5/drivers/pci/pcie/aer/Kconfig patch-2.6.11-rc5-aerc3-split6/drivers/pci/pcie/aer/Kconfig
--- linux-2.6.11-rc5/drivers/pci/pcie/aer/Kconfig	1969-12-31 19:00:00.000000000 -0500
+++ patch-2.6.11-rc5-aerc3-split6/drivers/pci/pcie/aer/Kconfig	2005-03-09 13:25:36.000000000 -0500
@@ -0,0 +1,13 @@
+#
+# Root Port Device Configuration
+#
+
+config PCIEAER
+	bool "Root Port Advanced Error Reporting support"
+	depends on PCIEPORTBUS 
+	default y
+
+	---help---
+	This enables Root Port Advanced Error Reporting (AER) driver
+	support. Error reporting messages sent to Root Port will be
+	handled by PCI Express AER driver.	
diff -urpN linux-2.6.11-rc5/drivers/pci/pcie/aer/Makefile patch-2.6.11-rc5-aerc3-split6/drivers/pci/pcie/aer/Makefile
--- linux-2.6.11-rc5/drivers/pci/pcie/aer/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ patch-2.6.11-rc5-aerc3-split6/drivers/pci/pcie/aer/Makefile	2005-03-10 10:33:41.000000000 -0500
@@ -0,0 +1,8 @@
+#
+# Makefile for PCI-Express Root Port Advanced Error Reporting Driver
+#
+
+aerdriver-y		:= aerdrv_sysfs.o aerdrv_event.o aerdrv_core.o \
+			   aerdrv_rpc_handle.o aerdrv.o
+
+obj-$(CONFIG_PCIEAER)	+= aerdriver.o
diff -urpN linux-2.6.11-rc5/drivers/pci/pcie/Kconfig patch-2.6.11-rc5-aerc3-split6/drivers/pci/pcie/Kconfig
--- linux-2.6.11-rc5/drivers/pci/pcie/Kconfig	2005-02-24 11:40:54.000000000 -0500
+++ patch-2.6.11-rc5-aerc3-split6/drivers/pci/pcie/Kconfig	2005-03-11 11:25:29.000000000 -0500
@@ -36,3 +36,4 @@ config HOTPLUG_PCI_PCIE_POLL_EVENT_MODE
 	   
 	  When in doubt, say N.
 
+source "drivers/pci/pcie/aer/Kconfig"
diff -urpN linux-2.6.11-rc5/drivers/pci/pcie/Makefile patch-2.6.11-rc5-aerc3-split6/drivers/pci/pcie/Makefile
--- linux-2.6.11-rc5/drivers/pci/pcie/Makefile	2005-02-24 11:39:47.000000000 -0500
+++ patch-2.6.11-rc5-aerc3-split6/drivers/pci/pcie/Makefile	2005-03-11 11:24:21.000000000 -0500
@@ -5,3 +5,6 @@
 pcieportdrv-y			:= portdrv_core.o portdrv_pci.o portdrv_bus.o
 
 obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
+
+# Build PCI Express AER if needed
+obj-$(CONFIG_PCIEAER)		+= aer/
diff -urpN linux-2.6.11-rc5/include/linux/aer.h patch-2.6.11-rc5-aerc3-split6/include/linux/aer.h
--- linux-2.6.11-rc5/include/linux/aer.h	1969-12-31 19:00:00.000000000 -0500
+++ patch-2.6.11-rc5-aerc3-split6/include/linux/aer.h	2005-03-11 11:27:27.000000000 -0500
@@ -0,0 +1,101 @@
+/*
+ * Copyright (C) 2005 Intel
+ * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
+ *
+ */
+
+#ifndef _AER_H_
+#define _AER_H_
+
+/* PCI Express Capability Structure's Register Offset */
+#define PCIE_CAP_DEVICE_CONTROL_REG_OFF	0x08
+#define PCIE_CAP_DEVICE_STATUS_REG_OFF	0x0a
+#define PCIE_CAP_ROOT_CONTROL_REG_OFF	0x1c
+
+/* PCI Express Enhanced Capability Header */
+#define PCIE_ENHANCED_CAP_HEADER	0x100
+#define UNCORRECTABLE_ERROR_STATUS_REG	(PCIE_ENHANCED_CAP_HEADER | 0x04) 
+#define UNCORRECTABLE_ERROR_MASK_REG	(PCIE_ENHANCED_CAP_HEADER | 0x08) 
+#define UNCORRECTABLE_ERROR_SEVERITY_REG (PCIE_ENHANCED_CAP_HEADER | 0x0c) 
+#define CORRECTABLE_ERROR_STATUS_REG	(PCIE_ENHANCED_CAP_HEADER | 0x10) 
+#define CORRECTABLE_ERROR_MASK_REG	(PCIE_ENHANCED_CAP_HEADER | 0x14) 
+#define ADVANCE_CAPABILITY_CONTROL_REG	(PCIE_ENHANCED_CAP_HEADER | 0x18) 
+#define HEADER_LOG_REG			(PCIE_ENHANCED_CAP_HEADER | 0x1c) 
+#define ROOT_ERROR_COMMAND_REG		(PCIE_ENHANCED_CAP_HEADER | 0x2c) 
+#define ROOT_ERROR_STATUS_REG		(PCIE_ENHANCED_CAP_HEADER | 0x30) 
+#define CORRECTABLE_SOURCE_ID_REG	(PCIE_ENHANCED_CAP_HEADER | 0x34) 
+#define UNCORRECTABLE_SOURCE_ID_REG	(PCIE_ENHANCED_CAP_HEADER | 0x36) 
+
+#define AER_NONFATAL			0
+#define AER_FATAL			1
+#define AER_CORRECTABLE			2
+#define AER_UNCORRECTABLE		3
+#define AER_ERROR_MASK			0x001fffff
+#define AER_ERROR(d)			(d & AER_ERROR_MASK)			
+
+/* PCI Express AER Correctable Errors */
+#define ERR_RECEIVER			0x00000001	/* COR bit 0 	*/ 
+#define ERR_BAD_TLP			0x00000040  	/* COR bit 6 	*/
+#define ERR_BAD_DLLP			0x00000080	/* COR bit 7 	*/
+#define ERR_RELAY_NUM_ROLLOVER		0x00000100 	/* COR bit 8 	*/
+#define ERR_RELAY_TIMEOUT		0x00001000 	/* COR bit 12 	*/
+#define ERR_CORRECTABLE_ERROR_MASK	0x000011c1
+
+/* PCI Express AER UnCorrectable Errors */
+#define ERR_TRAINING			0x00000001	/* UNCOR bit 0	*/
+#define ERR_DATA_LINK_PROTOCOL		0x00000010	/* UNCOR bit 4	*/
+#define ERR_POISONED_TLP		0x00001000	/* UNCOR bit 12 */
+#define ERR_FLOW_CONTROL_PROTOCOL	0x00002000	/* UNCOR bit 13 */
+#define ERR_COMPLETION_TIMEOUT		0x00004000	/* UNCOR bit 14 */
+#define ERR_COMPLETION_ABORT		0x00008000	/* UNCOR bit 15 */
+#define ERR_COMPLETION_UNEXPECT		0x00010000	/* UNCOR bit 16 */
+#define ERR_RECEIVER_OVERFLOW		0x00020000	/* UNCOR bit 17 */
+#define ERR_MALFORMED_TLP		0x00040000	/* UNCOR bit 18 */
+#define ERR_ECRC			0x00080000	/* UNCOR bit 19 */
+#define ERR_UNSUPPORTED_REQUEST		0x00100000	/* UNCOR bit 20 */
+#define ERR_UNCORRECTABLE_ERROR_MASK	0x001ff011
+
+union aer_error {
+	unsigned int type;	     /*AER_CORRECTABLE|AER_UNCORRECTABLE*/
+	struct {
+		unsigned int type;   /*AER_CORRECTABLE|AER_NONFATAL|AER_FATAL*/
+		unsigned int status; /*Particular Error Status*/ 
+	}source;
+};
+
+union request_id {
+	unsigned short value;
+	struct {
+		unsigned short func	: 3;
+		unsigned short dev	: 5;
+		unsigned short bus	: 8;
+	}u;
+};
+
+struct header_log_regs {
+	unsigned int dw0;
+	unsigned int dw1;
+	unsigned int dw2;
+	unsigned int dw3;
+};
+
+struct pcie_aer_handle {
+	int (*notify) (unsigned short requestor_id, union aer_error *error);
+	int (*get_header) (unsigned short requestor_id, union aer_error *error,
+		struct header_log_regs *log);
+	int (*link_rec_prepare) (unsigned short requestor_id);
+	int (*link_rec_restart) (unsigned short requestor_id);
+	int (*link_reset) (unsigned short requestor_id);
+};
+
+#ifndef CONFIG_PCIEAER
+static inline int pcie_aer_register(struct pci_dev *dev,  
+	struct pcie_aer_handle *handle) {return -1;}
+static inline void pcie_aer_unregister(unsigned short requestor_id) {}
+#else
+extern int pcie_aer_register(struct pci_dev *dev, 
+	struct pcie_aer_handle *handle);
+extern void pcie_aer_unregister(unsigned short requestor_id);
+#endif
+
+#endif //_AER_H_
