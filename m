Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbULUSRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbULUSRS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 13:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbULUSRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 13:17:17 -0500
Received: from fmr18.intel.com ([134.134.136.17]:64652 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261826AbULUSPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 13:15:09 -0500
Date: Tue, 21 Dec 2004 11:21:21 -0800
From: long <tlnguyen@snoqualmie.dp.intel.com>
Message-Id: <200412211921.iBLJLLwG007091@snoqualmie.dp.intel.com>
To: greg@kroah.com
Subject: Re:[PATCH]PCI Express Port Bus Driver
Cc: linux-kernel@vger.kernel.org, tom.l.nguyen@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for your inputs. To reflect your inputs, the update patch
below includes the following changes:

@@ -3,7 +3,7 @@
 #
 config PCIEPORTBUS
 	bool "PCI Express support"
-	depends on PCI_GOMMCONFIG
+	depends on PCI_GOMMCONFIG || PCI_GOANY
 	default n
 
@@ -21,7 +21,7 @@ static int pcie_port_bus_suspend(struct 
 static int pcie_port_bus_resume(struct device *dev);
 
 struct bus_type pcie_port_bus_type = {
-	.name 		= "PCIE port bus",
+	.name 		= "pci_express",
 	.match 		= pcie_port_bus_match,
 	.suspend	= pcie_port_bus_suspend,
 	.resume		= pcie_port_bus_resume, 

Please send us any suggestions or comments.

Signed-off-by: T. Long Nguyen <tom.l.nguyen@intel.com>

--------------------------------------------------------------------
diff -urpN linux-2.6.10-rc3/arch/i386/Kconfig patch-2.6.10-rc3-pbdhp/arch/i386/Kconfig
--- linux-2.6.10-rc3/arch/i386/Kconfig	2004-12-03 16:52:47.000000000 -0500
+++ patch-2.6.10-rc3-pbdhp/arch/i386/Kconfig	2004-12-10 14:06:05.000000000 -0500
@@ -1117,6 +1117,8 @@ config PCI_MMCONFIG
 	select ACPI_BOOT
 	default y
 
+source "drivers/pcieport/Kconfig"
+
 source "drivers/pci/Kconfig"
 
 config ISA
diff -urpN linux-2.6.10-rc3/Documentation/PCIEBUS-HOWTO.txt patch-2.6.10-rc3-pbdhp/Documentation/PCIEBUS-HOWTO.txt
--- linux-2.6.10-rc3/Documentation/PCIEBUS-HOWTO.txt	1969-12-31 19:00:00.000000000 -0500
+++ patch-2.6.10-rc3-pbdhp/Documentation/PCIEBUS-HOWTO.txt	2004-12-10 14:06:05.000000000 -0500
@@ -0,0 +1,217 @@
+		The PCI Express Port Bus Driver Guide HOWTO
+	Tom L Nguyen tom.l.nguyen@intel.com
+			11/03/2004
+
+1. About this guide
+
+This guide describes the basics of the PCI Express Port Bus driver
+and provides information on how to enable the service drivers to
+register/unregister with the PCI Express Port Bus Driver.
+
+2. Copyright 2004 Intel Corporation
+
+3. What is the PCI Express Port Bus Driver
+
+A PCI Express Port is a logical PCI-PCI Bridge structure. There
+are two types of PCI Express Port: the Root Port and the Switch
+Port. The Root Port originates a PCI Express link from a PCI Express
+Root Complex and the Switch Port connects PCI Express links to
+internal logical PCI buses. The Switch Port, which has its secondary
+bus representing the switch's internal routing logic, is called the
+switch's Upstream Port. The switch's Downstream Port is bridging from
+switch's internal routing bus to a bus representing the downstream
+PCI Express link from the PCI Express Switch.
+
+A PCI Express Port can provide up to four distinct functions,
+referred to in this document as services, depending on its port type.
+PCI Express Port's services include native hotplug support (HP),
+power management event support (PME), advanced error reporting
+support (AER), and virtual channel support (VC). These services may
+be handled by a single complex driver or be individually distributed
+and handled by corresponding service drivers.
+
+4. Why use the PCI Express Port Bus Driver?
+
+In existing Linux kernels, the Linux Device Driver Model allows a
+physical device to be handled by only a single driver. The PCI
+Express Port is a PCI-PCI Bridge device with multiple distinct
+services. To maintain a clean and simple solution each service
+may have its own software service driver. In this case several
+service drivers will compete for a single PCI-PCI Bridge device.
+For example, if the PCI Express Root Port native hotplug service
+driver is loaded first, it claims a PCI-PCI Bridge Root Port. The
+kernel therefore does not load other service drivers for that Root
+Port. In other words, it is impossible to have multiple service
+drivers load and run on a PCI-PCI Bridge device simultaneously
+using the current driver model.
+
+To enable multiple service drivers running simultaneously requires
+having a PCI Express Port Bus driver, which manages all populated
+PCI Express Ports and distributes all provided service requests
+to the corresponding service drivers as required. Some key
+advantages of using the PCI Express Port Bus driver are listed below:
+
+	- Allow multiple service drivers to run simultaneously on
+	  a PCI-PCI Bridge Port device.
+
+	- Allow service drivers implemented in an independent
+	  staged approach.
+	
+	- Allow one service driver to run on multiple PCI-PCI Bridge
+	  Port devices. 
+
+	- Manage and distribute resources of a PCI-PCI Bridge Port
+	  device to requested service drivers.
+
+5. Configuring the PCI Express Port Bus Driver vs. Service Drivers
+
+5.1 Including the PCI Express Port Bus Driver Support into the Kernel
+
+Including the PCI Express Port Bus driver depends on whether the PCI
+Express support is included in the kernel config. The kernel will
+automatically include the PCI Express Port Bus driver as a kernel
+driver when the PCI Express support is enabled in the kernel.
+
+5.2 Enabling Service Driver Support
+
+PCI device drivers are implemented based on Linux Device Driver Model.
+All service drivers are PCI device drivers. As discussed above, it is
+impossible to load any service driver once the kernel has loaded the
+PCI Express Port Bus Driver. To meet the PCI Express Port Bus Driver
+Model requires some minimal changes on existing service drivers that
+imposes no impact on the functionality of existing service drivers.
+
+A service driver is required to use the two APIs shown below to
+register its service with the PCI Express Port Bus driver (see 
+section 5.2.1 & 5.2.2). It is important that a service driver
+initializes the pcie_port_service_driver data structure, included in
+header file /include/linux/pcieport_if.h, before calling these APIs.
+Failure to do so will result an identity mismatch, which prevents
+the PCI Express Port Bus driver from loading a service driver.
+
+5.2.1 pcie_port_service_register
+
+int pcie_port_service_register(struct pcie_port_service_driver *new)
+
+This API replaces the Linux Driver Model's pci_module_init API. A
+service driver should always calls pcie_port_service_register at
+module init. Note that after service driver being loaded, calls
+such as pci_enable_device(dev) and pci_set_master(dev) are no longer
+necessary since these calls are executed by the PCI Port Bus driver.
+
+5.2.2 pcie_port_service_unregister
+
+void pcie_port_service_unregister(struct pcie_port_service_driver *new)
+
+pcie_port_service_unregister replaces the Linux Driver Model's
+pci_unregister_driver. It's always called by service driver when a
+module exits.
+
+5.2.3 Sample Code
+
+Below is sample service driver code to initialize the port service
+driver data structure.
+
+static struct pcie_port_service_id service_id[] = { {
+	.vendor = PCI_ANY_ID,
+	.device = PCI_ANY_ID,
+	.port_type = PCIE_RC_PORT,
+	.service_type = PCIE_PORT_SERVICE_AER,
+	}, { /* end: all zeroes */ }
+};
+
+static struct pcie_port_service_driver root_aerdrv = {
+	.name		= (char *)device_name,
+	.id_table	= &service_id[0],
+
+	.probe		= aerdrv_load,
+	.remove		= aerdrv_unload,
+
+	.suspend	= aerdrv_suspend,
+	.resume		= aerdrv_resume,
+};
+
+Below is a sample code for registering/unregistering a service
+driver.
+
+static int __init aerdrv_service_init(void)
+{
+	int retval = 0;
+	
+	retval = pcie_port_service_register(&root_aerdrv);
+	if (!retval) {
+		/*
+		 * FIX ME
+		 */
+	}
+	return retval;
+}
+
+static void __exit aerdrv_service_exit(void) 
+{
+	pcie_port_service_unregister(&root_aerdrv);
+}
+
+module_init(aerdrv_service_init);
+module_exit(aerdrv_service_exit);
+
+6. Possible Resource Conflicts
+
+Since all service drivers of a PCI-PCI Bridge Port device are
+allowed to run simultaneously, below lists a few of possible resource
+conflicts with proposed solutions.
+
+6.1 MSI Vector Resource
+
+The MSI capability structure enables a device software driver to call
+pci_enable_msi to request MSI based interrupts. Once MSI interrupts
+are enabled on a device, it stays in this mode until a device driver
+calls pci_disable_msi to disable MSI interrupts and revert back to
+INTx emulation mode. Since service drivers of the same PCI-PCI Bridge
+port share the same physical device, if an individual service driver
+calls pci_enable_msi/pci_disable_msi it may result unpredictable
+behavior. For example, two service drivers run simultaneously on the
+same physical Root Port. Both service drivers call pci_enable_msi to
+request MSI based interrupts. A service driver may not know whether
+any other service drivers have run on this Root Port. If either one
+of them calls pci_disable_msi, it puts the other service driver
+in a wrong interrupt mode. 
+
+To avoid this situation all service drivers are not permitted to
+switch interrupt mode on its device. The PCI Express Port Bus driver
+is responsible for determining the interrupt mode and this should be
+transparent to service drivers. Service drivers need to know only
+the vector IRQ assigned to the field irq of struct pcie_device, which
+is passed in when the PCI Express Port Bus driver probes each service
+driver. Service drivers should use (struct pcie_device*)dev->irq to
+call request_irq/free_irq. In addition, the interrupt mode is stored
+in the field interrupt_mode of struct pcie_device.
+
+6.2 MSI-X Vector Resources
+
+Similar to the MSI a device driver for an MSI-X capable device can
+call pci_enable_msix to request MSI-X interrupts. All service drivers
+are not permitted to switch interrupt mode on its device. The PCI
+Express Port Bus driver is responsible for determining the interrupt
+mode and this should be transparent to service drivers. Any attempt
+by service driver to call pci_enable_msix/pci_disable_msix may
+result unpredictable behavior. Service drivers should use
+(struct pcie_device*)dev->irq and call request_irq/free_irq.
+
+6.3 PCI Memory/IO Mapped Regions
+
+Service drivers for PCI Express Power Management (PME), Advanced
+Error Reporting (AER), Hot-Plug (HP) and Virtual Channel (VC) access
+PCI configuration space on the PCI Express port. In all cases the
+registers accessed are independent of each other. This patch assumes
+that all service drivers will be well behaved and not overwrite
+other service driver's configuration settings.
+
+6.4 PCI Config Registers
+
+Each service driver runs its PCI config operations on its own
+capability structure except the PCI Express capability structure, in
+which Root Control register and Device Control register are shared
+between PME and AER. This patch assumes that all service drivers
+will be well behaved and not overwrite other service driver's
+configuration settings.
diff -urpN linux-2.6.10-rc3/drivers/Makefile patch-2.6.10-rc3-pbdhp/drivers/Makefile
--- linux-2.6.10-rc3/drivers/Makefile	2004-12-03 16:55:13.000000000 -0500
+++ patch-2.6.10-rc3-pbdhp/drivers/Makefile	2004-12-10 14:06:05.000000000 -0500
@@ -54,6 +54,7 @@ obj-$(CONFIG_W1)		+= w1/
 obj-$(CONFIG_PHONE)		+= telephony/
 obj-$(CONFIG_MD)		+= md/
 obj-$(CONFIG_BT)		+= bluetooth/
+obj-$(CONFIG_PCIEPORTBUS)	+= pcieport/
 obj-$(CONFIG_ISDN)		+= isdn/
 obj-$(CONFIG_MCA)		+= mca/
 obj-$(CONFIG_EISA)		+= eisa/
diff -urpN linux-2.6.10-rc3/drivers/pci/hotplug/Kconfig patch-2.6.10-rc3-pbdhp/drivers/pci/hotplug/Kconfig
--- linux-2.6.10-rc3/drivers/pci/hotplug/Kconfig	2004-12-03 16:55:13.000000000 -0500
+++ patch-2.6.10-rc3-pbdhp/drivers/pci/hotplug/Kconfig	2004-12-10 14:06:05.000000000 -0500
@@ -134,27 +134,6 @@ config HOTPLUG_PCI_CPCI_GENERIC
 
 	  When in doubt, say N.
 
-config HOTPLUG_PCI_PCIE
-	tristate "PCI Express Hotplug driver"
-	depends on HOTPLUG_PCI
-	help
-	  Say Y here if you have a motherboard that supports PCI Express Native
-	  Hotplug
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called pciehp.
-
-	  When in doubt, say N.
-
-config HOTPLUG_PCI_PCIE_POLL_EVENT_MODE
-	bool "Use polling mechanism for hot-plug events (for testing purpose)"
-	depends on HOTPLUG_PCI_PCIE
-	help
-	  Say Y here if you want to use the polling mechanism for hot-plug 
-	  events for early platform testing.
-	   
-	  When in doubt, say N.
-
 config HOTPLUG_PCI_SHPC
 	tristate "SHPC PCI Hotplug driver"
 	depends on HOTPLUG_PCI
diff -urpN linux-2.6.10-rc3/drivers/pci/hotplug/pciehp_core.c patch-2.6.10-rc3-pbdhp/drivers/pci/hotplug/pciehp_core.c
--- linux-2.6.10-rc3/drivers/pci/hotplug/pciehp_core.c	2004-12-03 16:55:12.000000000 -0500
+++ patch-2.6.10-rc3-pbdhp/drivers/pci/hotplug/pciehp_core.c	2004-12-10 14:06:05.000000000 -0500
@@ -41,6 +41,7 @@
 #include <asm/uaccess.h>
 #include "pciehp.h"
 #include "pciehprm.h"
+#include <linux/interrupt.h>
 
 /* Global variables */
 int pciehp_debug;
@@ -347,7 +348,7 @@ static int get_cur_bus_speed(struct hotp
 	return 0;
 }
 
-static int pcie_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+static int pciehp_probe(struct pcie_device *dev, const struct pcie_port_service_id *id)
 {
 	int rc;
 	struct controller *ctrl;
@@ -355,7 +356,9 @@ static int pcie_probe(struct pci_dev *pd
 	int first_device_num = 0 ;	/* first PCI device number supported by this PCIE */  
 	int num_ctlr_slots;		/* number of slots supported by this HPC */
 	u8 value;
-
+	struct pci_dev *pdev;
+	
+	dbg("%s: Called by hp_drv\n", __FUNCTION__);
 	ctrl = kmalloc(sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl) {
 		err("%s : out of memory\n", __FUNCTION__);
@@ -364,8 +367,10 @@ static int pcie_probe(struct pci_dev *pd
 	memset(ctrl, 0, sizeof(struct controller));
 
 	dbg("%s: DRV_thread pid = %d\n", __FUNCTION__, current->pid);
+	
+	pdev = dev->port;
 
-	rc = pcie_init(ctrl, pdev,
+	rc = pcie_init(ctrl, dev,
 		(php_intr_callback_t) pciehp_handle_attention_button,
 		(php_intr_callback_t) pciehp_handle_switch_change,
 		(php_intr_callback_t) pciehp_handle_presence_change,
@@ -563,32 +568,52 @@ static void __exit unload_pciehpd(void)
 
 }
 
+int hpdriver_context = 0;
 
-static struct pci_device_id pcied_pci_tbl[] = {
-	{
-	.class =        ((PCI_CLASS_BRIDGE_PCI << 8) | 0x00),
-	.class_mask =	~0,
-	.vendor =       PCI_ANY_ID,
-	.device =       PCI_ANY_ID,
-	.subvendor =    PCI_ANY_ID,
-	.subdevice =    PCI_ANY_ID,
-	},
-	
-	{ /* end: all zeroes */ }
-};
-
-MODULE_DEVICE_TABLE(pci, pcied_pci_tbl);
+static void pciehp_remove (struct pcie_device *device)
+{
+	printk("%s ENTRY\n", __FUNCTION__);	
+	printk("%s -> Call free_irq for irq = %d\n",  
+		__FUNCTION__, device->irq);
+	free_irq(device->irq, &hpdriver_context);
+}
 
+#ifdef CONFIG_PM
+static int pciehp_suspend (struct pcie_device *dev, u32 state)
+{
+	printk("%s ENTRY\n", __FUNCTION__);	
+	return 0;
+}
 
+static int pciehp_resume (struct pcie_device *dev)
+{
+	printk("%s ENTRY\n", __FUNCTION__);	
+	return 0;
+}
+#endif
 
-static struct pci_driver pcie_driver = {
-	.name		=	PCIE_MODULE_NAME,
-	.id_table	=	pcied_pci_tbl,
-	.probe		=	pcie_probe,
-	/* remove:	pcie_remove_one, */
+static struct pcie_port_service_id port_pci_ids[] = { { 
+	.vendor = PCI_ANY_ID, 
+	.device = PCI_ANY_ID,
+	.port_type = PCIE_RC_PORT, 
+	.service_type = PCIE_PORT_SERVICE_HP,
+	.driver_data =	0, 
+	}, { /* end: all zeroes */ }
 };
+static const char device_name[] = "hpdriver";
 
-
+static struct pcie_port_service_driver hpdriver_portdrv = {
+	.name		= (char *)device_name,
+	.id_table	= &port_pci_ids[0],
+
+	.probe		= pciehp_probe,
+	.remove		= pciehp_remove,
+
+#ifdef	CONFIG_PM
+	.suspend	= pciehp_suspend,
+	.resume		= pciehp_resume,
+#endif	/* PM */
+};
 
 static int __init pcied_init(void)
 {
@@ -604,9 +629,11 @@ static int __init pcied_init(void)
 
 	retval = pciehprm_init(PCI);
 	if (!retval) {
-		retval = pci_register_driver(&pcie_driver);
-		dbg("pci_register_driver = %d\n", retval);
-		info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
+ 		retval = pcie_port_service_register(&hpdriver_portdrv);
+ 		dbg("pcie_port_service_register = %d\n", retval);
+  		info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
+ 		if (retval)
+ 		   dbg("%s: Failure to register service\n", __FUNCTION__);
 	}
 
 error_hpc_init:
@@ -626,8 +653,8 @@ static void __exit pcied_cleanup(void)
 
 	pciehprm_cleanup();
 
-	dbg("pci_unregister_driver\n");
-	pci_unregister_driver(&pcie_driver);
+	dbg("pcie_port_service_unregister\n");
+	pcie_port_service_unregister(&hpdriver_portdrv);
 
 	info(DRIVER_DESC " version: " DRIVER_VERSION " unloaded\n");
 }
diff -urpN linux-2.6.10-rc3/drivers/pci/hotplug/pciehp.h patch-2.6.10-rc3-pbdhp/drivers/pci/hotplug/pciehp.h
--- linux-2.6.10-rc3/drivers/pci/hotplug/pciehp.h	2004-12-03 16:54:16.000000000 -0500
+++ patch-2.6.10-rc3-pbdhp/drivers/pci/hotplug/pciehp.h	2004-12-10 14:06:05.000000000 -0500
@@ -34,6 +34,7 @@
 #include <linux/delay.h>
 #include <asm/semaphore.h>
 #include <asm/io.h>		
+#include <linux/pcieport_if.h>
 #include "pci_hotplug.h"
 
 #define MY_NAME	"pciehp"
@@ -311,7 +312,7 @@ enum php_ctlr_type {
 
 typedef u8(*php_intr_callback_t) (unsigned int change_id, void *instance_id);
 
-int pcie_init(struct controller *ctrl, struct pci_dev *pdev,
+int pcie_init(struct controller *ctrl, struct pcie_device *dev,
 		php_intr_callback_t attention_button_callback,
 		php_intr_callback_t switch_change_callback,
 		php_intr_callback_t presence_change_callback,
diff -urpN linux-2.6.10-rc3/drivers/pci/hotplug/pciehp_hpc.c patch-2.6.10-rc3-pbdhp/drivers/pci/hotplug/pciehp_hpc.c
--- linux-2.6.10-rc3/drivers/pci/hotplug/pciehp_hpc.c	2004-12-03 16:53:57.000000000 -0500
+++ patch-2.6.10-rc3-pbdhp/drivers/pci/hotplug/pciehp_hpc.c	2004-12-10 14:06:05.000000000 -0500
@@ -1249,7 +1249,7 @@ static struct hpc_ops pciehp_hpc_ops = {
 };
 
 int pcie_init(struct controller * ctrl,
-	struct pci_dev *pdev,
+	struct pcie_device *dev,
 	php_intr_callback_t attention_button_callback,
 	php_intr_callback_t switch_change_callback,
 	php_intr_callback_t presence_change_callback,
@@ -1265,6 +1265,7 @@ int pcie_init(struct controller * ctrl,
 	u32 slot_cap;
 	int cap_base, saved_cap_base;
 	u16 slot_status, slot_ctrl;
+	struct pci_dev *pdev;
 
 	DBG_ENTER_ROUTINE
 	
@@ -1277,7 +1278,8 @@ int pcie_init(struct controller * ctrl,
 	}
 
 	memset(php_ctlr, 0, sizeof(struct php_ctlr_state_s));
-
+	
+	pdev = dev->port;
 	php_ctlr->pci_dev = pdev;	/* save pci_dev in context */
 
 	dbg("%s: pdev->vendor %x pdev->device %x\n", __FUNCTION__,
@@ -1338,7 +1340,7 @@ int pcie_init(struct controller * ctrl,
 	}
 
 	dbg("pdev = %p: b:d:f:irq=0x%x:%x:%x:%x\n", pdev, pdev->bus->number, 
-		PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn), pdev->irq);
+		PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn), dev->irq);
 	for ( rc = 0; rc < DEVICE_COUNT_RESOURCE; rc++)
 		if (pci_resource_len(pdev, rc) > 0)
 			dbg("pci resource[%d] start=0x%lx(len=0x%lx)\n", rc,
@@ -1355,7 +1357,7 @@ int pcie_init(struct controller * ctrl,
 	init_waitqueue_head(&ctrl->queue);
 
 	/* find the IRQ */
-	php_ctlr->irq = pdev->irq;
+	php_ctlr->irq = dev->irq;
 	dbg("HPC interrupt = %d\n", php_ctlr->irq);
 
 	/* Save interrupt callback info */
@@ -1407,17 +1409,6 @@ int pcie_init(struct controller * ctrl,
 		start_int_poll_timer( php_ctlr, 10 );   /* start with 10 second delay */
 	} else {
 		/* Installs the interrupt handler */
-		dbg("%s: pcie_mch_quirk = %x\n", __FUNCTION__, pcie_mch_quirk);
-		if (!pcie_mch_quirk) {
-			rc = pci_enable_msi(pdev);
-			if (rc) {
-				info("Can't get msi for the hotplug controller\n");
-				info("Use INTx for the hotplug controller\n");
-				dbg("%s: rc = %x\n", __FUNCTION__, rc);
-			} else 
-				php_ctlr->irq = pdev->irq;
-		}
-
 		rc = request_irq(php_ctlr->irq, pcie_isr, SA_SHIRQ, MY_NAME, (void *) ctrl);
 		dbg("%s: request_irq %d for hpc%d (returns %d)\n", __FUNCTION__, php_ctlr->irq, ctlr_seq_num, rc);
 		if (rc) {
diff -urpN linux-2.6.10-rc3/drivers/pcieport/Kconfig patch-2.6.10-rc3-pbdhp/drivers/pcieport/Kconfig
--- linux-2.6.10-rc3/drivers/pcieport/Kconfig	1969-12-31 19:00:00.000000000 -0500
+++ patch-2.6.10-rc3-pbdhp/drivers/pcieport/Kconfig	2004-12-20 13:26:20.726605536 -0500
@@ -0,0 +1,38 @@
+#
+# PCI Express Port Bus Configuration
+#
+config PCIEPORTBUS
+	bool "PCI Express support"
+	depends on PCI_GOMMCONFIG || PCI_GOANY
+	default n
+
+	---help---
+	This automatically enables PCI Express Port Bus support. Users can
+	choose Native Hot-Plug support, Advanced Error Reporting support,
+	Power Management Event support and Virtual Channel support to run
+	on PCI Express Ports (Root or Switch).
+
+#
+# Include service Kconfig here
+#
+config HOTPLUG_PCI_PCIE
+	tristate "PCI Express Hotplug driver"
+	depends on HOTPLUG_PCI && PCIEPORTBUS
+	help
+	  Say Y here if you have a motherboard that supports PCI Express Native
+	  Hotplug
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called pciehp.
+
+	  When in doubt, say N.
+
+config HOTPLUG_PCI_PCIE_POLL_EVENT_MODE
+	bool "Use polling mechanism for hot-plug events (for testing purpose)"
+	depends on HOTPLUG_PCI_PCIE
+	help
+	  Say Y here if you want to use the polling mechanism for hot-plug 
+	  events for early platform testing.
+	   
+	  When in doubt, say N.
+
diff -urpN linux-2.6.10-rc3/drivers/pcieport/Makefile patch-2.6.10-rc3-pbdhp/drivers/pcieport/Makefile
--- linux-2.6.10-rc3/drivers/pcieport/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ patch-2.6.10-rc3-pbdhp/drivers/pcieport/Makefile	2004-12-10 14:06:05.000000000 -0500
@@ -0,0 +1,7 @@
+#
+# Makefile for PCI-Express PORT Driver
+#
+
+pcieportdrv-y			:= portdrv_core.o portdrv_pci.o portdrv_bus.o
+
+obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
diff -urpN linux-2.6.10-rc3/drivers/pcieport/portdrv_bus.c patch-2.6.10-rc3-pbdhp/drivers/pcieport/portdrv_bus.c
--- linux-2.6.10-rc3/drivers/pcieport/portdrv_bus.c	1969-12-31 19:00:00.000000000 -0500
+++ patch-2.6.10-rc3-pbdhp/drivers/pcieport/portdrv_bus.c	2004-12-20 13:28:05.035748136 -0500
@@ -0,0 +1,88 @@
+/*
+ * File:	portdrv_bus.c
+ * Purpose:	PCI Express Port Bus Driver's Bus Overloading Functions
+ *
+ * Copyright (C) 2004 Intel
+ * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/pm.h>
+
+#include <linux/pcieport_if.h>
+
+static int generic_probe (struct device *dev) {	return 0;}
+static int generic_remove (struct device *dev) { return 0;}
+static int pcie_port_bus_match(struct device *dev, struct device_driver *drv);
+static int pcie_port_bus_suspend(struct device *dev, u32 state);
+static int pcie_port_bus_resume(struct device *dev);
+
+struct bus_type pcie_port_bus_type = {
+	.name 		= "pci_express",
+	.match 		= pcie_port_bus_match,
+	.suspend	= pcie_port_bus_suspend,
+	.resume		= pcie_port_bus_resume, 
+};
+
+struct device_driver pcieport_generic_driver = {
+	.name =	"pcieport",
+	.bus = &pcie_port_bus_type,
+	.probe = generic_probe,
+	.remove = generic_remove,
+};
+
+static int pcie_port_bus_match(struct device *dev, struct device_driver *drv)
+{
+	struct pcie_device *pciedev;
+	struct pcie_port_service_driver *driver;
+
+	if (	drv->bus != &pcie_port_bus_type || 
+		dev->bus != &pcie_port_bus_type	||
+		drv == &pcieport_generic_driver) {
+		return 0;
+	}
+	pciedev = to_pcie_device(dev);
+	driver = to_service_driver(drv);
+	if (   (driver->id_table->vendor != PCI_ANY_ID && 
+		driver->id_table->vendor != pciedev->id.vendor) ||
+	       (driver->id_table->device != PCI_ANY_ID &&
+		driver->id_table->device != pciedev->id.device) ||	
+		driver->id_table->port_type != pciedev->id.port_type ||
+		driver->id_table->service_type != pciedev->id.service_type )
+		return 0;
+
+	return 1;
+}
+
+static int pcie_port_bus_suspend(struct device *dev, u32 state)
+{
+	struct pcie_device *pciedev;
+	struct pcie_port_service_driver *driver;
+
+	if (!dev || !dev->driver)
+		return 0;
+
+	pciedev = to_pcie_device(dev);
+ 	driver = to_service_driver(dev->driver);
+	if (driver && driver->suspend)
+		driver->suspend(pciedev, state);
+	return 0;
+}
+
+static int pcie_port_bus_resume(struct device *dev)
+{
+	struct pcie_device *pciedev;
+	struct pcie_port_service_driver *driver;
+
+	if (!dev || !dev->driver)
+		return 0;
+
+	pciedev = to_pcie_device(dev);
+ 	driver = to_service_driver(dev->driver);
+	if (driver && driver->resume)
+		driver->resume(pciedev);
+	return 0;
+}
diff -urpN linux-2.6.10-rc3/drivers/pcieport/portdrv_core.c patch-2.6.10-rc3-pbdhp/drivers/pcieport/portdrv_core.c
--- linux-2.6.10-rc3/drivers/pcieport/portdrv_core.c	1969-12-31 19:00:00.000000000 -0500
+++ patch-2.6.10-rc3-pbdhp/drivers/pcieport/portdrv_core.c	2004-12-10 15:32:48.000000000 -0500
@@ -0,0 +1,453 @@
+/*
+ * File:	portdrv_core.c
+ * Purpose:	PCI Express Port Bus Driver's Core Functions
+ *
+ * Copyright (C) 2004 Intel
+ * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/pm.h>
+#include <linux/pcieport_if.h>
+
+#include "portdrv.h"
+
+extern int pcie_mch_quirk;	/* MSI-quirk Indicator */
+
+extern struct device_driver pcieport_generic_driver;
+
+static int pcie_port_probe_service(struct device *dev)
+{
+	struct pcie_device *pciedev;
+	struct pcie_port_service_driver *driver;
+	int status = -ENODEV;
+
+	if (!dev || !dev->driver)
+		return status;
+
+ 	driver = to_service_driver(dev->driver);
+	if (!driver || !driver->probe)
+		return status;
+
+	pciedev = to_pcie_device(dev);
+	status = driver->probe(pciedev, driver->id_table);
+	if (!status) {
+		printk(KERN_DEBUG "Load service driver %s on pcie device %s\n",
+			driver->name, dev->bus_id);
+		get_device(dev);
+	}
+	return status;
+}
+
+static int pcie_port_remove_service(struct device *dev)
+{
+	struct pcie_device *pciedev;
+	struct pcie_port_service_driver *driver;
+
+	if (!dev || !dev->driver)
+		return 0;
+
+	pciedev = to_pcie_device(dev);
+ 	driver = to_service_driver(dev->driver);
+	if (driver && driver->remove) { 
+		printk(KERN_DEBUG "Unload service driver %s on pcie device %s\n",
+			driver->name, dev->bus_id);
+		driver->remove(pciedev);
+		put_device(dev);
+	}
+	return 0;
+}
+
+static void pcie_port_shutdown_service(struct device *dev) {}
+
+static int pcie_port_suspend_service(struct device *dev, u32 state, u32 level)
+{
+	struct pcie_device *pciedev;
+	struct pcie_port_service_driver *driver;
+
+	if (!dev || !dev->driver)
+		return 0;
+
+	pciedev = to_pcie_device(dev);
+ 	driver = to_service_driver(dev->driver);
+	if (driver && driver->suspend)
+		driver->suspend(pciedev, state);
+	return 0;
+}
+
+static int pcie_port_resume_service(struct device *dev, u32 state)
+{
+	struct pcie_device *pciedev;
+	struct pcie_port_service_driver *driver;
+
+	if (!dev || !dev->driver)
+		return 0;
+
+	pciedev = to_pcie_device(dev);
+ 	driver = to_service_driver(dev->driver);
+
+	if (driver && driver->resume)
+		driver->resume(pciedev);
+	return 0;
+}
+
+/*
+ * release_pcie_device
+ *	
+ *	Being invoked automatically when device is being removed 
+ *	in response to device_unregister(dev) call.
+ *	Release all resources being claimed.
+ */
+static void release_pcie_device(struct device *dev)
+{
+	kfree(to_pcie_device(dev));			
+}
+
+static int is_msi_quirked(struct pci_dev *dev)
+{
+	int port_type, quirk = 0;
+	u16 reg16;
+
+	pci_read_config_word(dev, 
+		pci_find_capability(dev, PCI_CAP_ID_EXP) + 
+		PCIE_CAPABILITIES_REG, &reg16);
+	port_type = (reg16 >> 4) & PORT_TYPE_MASK;
+	switch(port_type) {
+	case PCIE_RC_PORT:
+		if (pcie_mch_quirk == 1)
+			quirk = 1;
+		break;
+	case PCIE_SW_UPSTREAM_PORT:
+	case PCIE_SW_DOWNSTREAM_PORT:
+	default:
+		break;	
+	}
+	return quirk;
+}
+	
+static int assign_interrupt_mode(struct pci_dev *dev, int *vectors, int mask)
+{
+	int i, pos, nvec, status = -EINVAL;
+	int interrupt_mode = PCIE_PORT_INTx_MODE;
+
+	/* Set INTx as default */
+	for (i = 0, nvec = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
+		if (mask & (1 << i)) 
+			nvec++;
+		vectors[i] = dev->irq;
+	}
+	
+	/* Check MSI quirk */
+	if (is_msi_quirked(dev))
+		return interrupt_mode;
+
+	/* Select MSI-X over MSI if supported */		
+	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
+	if (pos) {
+		struct msix_entry msix_entries[PCIE_PORT_DEVICE_MAXSERVICES] = 
+			{{0, 0}, {0, 1}, {0, 2}, {0, 3}};
+		printk("%s Found MSIX capability\n", __FUNCTION__);
+		status = pci_enable_msix(dev, msix_entries, nvec);
+		if (!status) {
+			int j = 0;
+
+			interrupt_mode = PCIE_PORT_MSIX_MODE;
+			for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
+				if (mask & (1 << i)) 
+					vectors[i] = msix_entries[j++].vector;
+			}
+		}
+	} 
+	if (status) {
+		pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
+		if (pos) {
+			printk("%s Found MSI capability\n", __FUNCTION__);
+			status = pci_enable_msi(dev);
+			if (!status) {
+				interrupt_mode = PCIE_PORT_MSI_MODE;
+				for (i = 0;i < PCIE_PORT_DEVICE_MAXSERVICES;i++)
+					vectors[i] = dev->irq;
+			}
+		}
+	} 
+	return interrupt_mode;
+}
+
+static int get_port_device_capability(struct pci_dev *dev)
+{
+	int services = 0, pos;
+	u16 reg16;
+	u32 reg32;
+
+	pos = pci_find_capability(dev, PCI_CAP_ID_EXP);
+	pci_read_config_word(dev, pos + PCIE_CAPABILITIES_REG, &reg16);
+	/* Hot-Plug Capable */
+	if (reg16 & PORT_TO_SLOT_MASK) {
+		pci_read_config_dword(dev, 
+			pos + PCIE_SLOT_CAPABILITIES_REG, &reg32);
+		if (reg32 & SLOT_HP_CAPABLE_MASK)
+			services |= PCIE_PORT_SERVICE_HP;
+	} 
+	/* PME Capable */
+	pos = pci_find_capability(dev, PCI_CAP_ID_PME);
+	if (pos) 
+		services |= PCIE_PORT_SERVICE_PME;
+	
+	pos = PCI_CFG_SPACE_SIZE;
+	while (pos) {
+		pci_read_config_dword(dev, pos, &reg32);
+		switch (reg32 & 0xffff) {
+		case PCI_EXT_CAP_ID_ERR:
+			services |= PCIE_PORT_SERVICE_AER;
+			pos = reg32 >> 20;
+			break;
+		case PCI_EXT_CAP_ID_VC:
+			services |= PCIE_PORT_SERVICE_VC;
+			pos = reg32 >> 20;
+			break;
+		default:
+			pos = 0;
+			break;
+		}
+	}
+
+	return services;
+}
+
+static void pcie_device_init(struct pcie_device *parent, 
+			struct pcie_device *dev, 
+			int port_type, int service_type)
+{
+	struct device *device;
+
+	if (parent) {
+		dev->id.vendor = parent->port->vendor;
+		dev->id.device = parent->port->device;
+		dev->id.port_type = port_type;
+		dev->id.service_type = (1 << service_type);
+	}
+
+	/* Initialize generic device interface */
+	device = &dev->device;
+	memset(device, 0, sizeof(struct device));
+	INIT_LIST_HEAD(&device->node);
+	INIT_LIST_HEAD(&device->children);
+	INIT_LIST_HEAD(&device->bus_list);
+	device->bus = &pcie_port_bus_type;
+	device->driver = NULL;
+	device->driver_data = NULL; 
+	device->release = release_pcie_device;	/* callback to free pcie dev */
+	sprintf(&device->bus_id[0], "%s.%02x", parent->device.bus_id, 
+			get_descriptor_id(port_type, service_type));
+	device->parent = ((parent == NULL) ? NULL : &parent->device);
+}
+
+static struct pcie_device* alloc_pcie_device(
+	struct pcie_device *parent, struct pci_dev *bridge, 
+	int port_type, int service_type, int irq, int irq_mode)
+{
+	struct pcie_device *device;
+	static int NR_PORTS = 0;
+
+	device = kmalloc(sizeof(struct pcie_device), GFP_KERNEL);
+	if (!device)
+		return NULL;
+
+	memset(device, 0, sizeof(struct pcie_device));
+	device->port = bridge;
+	device->interrupt_mode = irq_mode;
+	device->irq = irq;
+	if (!parent) {
+		pcie_device_init(NULL, device, port_type, service_type);
+		NR_PORTS++;
+		device->device.driver = &pcieport_generic_driver;
+		sprintf(&device->device.bus_id[0], "port%d", NR_PORTS); 
+	} else { 
+		pcie_device_init(parent, device, port_type, service_type);
+	}
+	printk(KERN_DEBUG "Allocate Port Device[%s]\n", device->device.bus_id);
+	return device;
+}
+
+int pcie_port_device_probe(struct pci_dev *dev)
+{
+	int pos, type;
+	u16 reg;
+
+	if (!(pos = pci_find_capability(dev, PCI_CAP_ID_EXP)))
+		return -ENODEV;
+
+	pci_read_config_word(dev, pos + PCIE_CAPABILITIES_REG, &reg);
+	type = (reg >> 4) & PORT_TYPE_MASK;
+	if (	type == PCIE_RC_PORT || type == PCIE_SW_UPSTREAM_PORT ||
+		type == PCIE_SW_DOWNSTREAM_PORT )  
+		return 0;
+ 
+	return -ENODEV;
+}
+
+int pcie_port_device_register(struct pci_dev *dev)
+{
+	struct pcie_device *parent;
+	int status, type, capabilities, irq_mode, i;
+	int vectors[PCIE_PORT_DEVICE_MAXSERVICES];
+	u16 reg16;
+
+	/* Get port type */
+	pci_read_config_word(dev, 
+		pci_find_capability(dev, PCI_CAP_ID_EXP) + 
+		PCIE_CAPABILITIES_REG, &reg16);
+	type = (reg16 >> 4) & PORT_TYPE_MASK;
+
+	/* Now get port services */
+	capabilities = get_port_device_capability(dev);
+	irq_mode = assign_interrupt_mode(dev, vectors, capabilities);
+
+	/* Allocate parent */
+	parent = alloc_pcie_device(NULL, dev, type, 0, dev->irq, irq_mode);
+	if (!parent) 
+		return -ENOMEM;
+	
+	status = device_register(&parent->device);
+	if (status) {
+		kfree(parent);
+		return status;
+	}
+	get_device(&parent->device);
+	pci_set_drvdata(dev, parent);	
+
+	/* Allocate child services if any */
+	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
+		struct pcie_device *child;
+
+		if (capabilities & (1 << i)) {
+			child = alloc_pcie_device(
+				parent,		/* parent */ 
+				dev, 		/* Root/Upstream/Downstream */
+				type,		/* port type */ 
+				i,		/* service type */
+				vectors[i],	/* irq */
+				irq_mode	/* interrupt mode */);
+			if (child) { 
+				status = device_register(&child->device);
+				if (status) {
+					kfree(child);
+					continue;
+				}
+				get_device(&child->device);
+			}
+		}
+	}
+	return 0;
+}
+
+#ifdef CONFIG_PM
+int pcie_port_device_suspend(struct pcie_device *dev, u32 state)
+{
+	struct list_head 		*head;
+	struct device 			*parent, *child;
+	struct device_driver 		*driver;
+	struct pcie_port_service_driver *service_driver;
+
+	parent = &dev->device;
+	head = &parent->children;
+	while (!list_empty(head)) {
+		child = container_of(head->next, struct device, node);
+		driver = child->driver;
+		if (!driver)
+			continue;
+		service_driver = to_service_driver(driver);
+		if (service_driver->suspend)  
+			service_driver->suspend(to_pcie_device(child), state);
+	}
+	return 0; 
+}
+
+int pcie_port_device_resume(struct pcie_device *dev) 
+{ 
+	struct list_head 		*head;
+	struct device 			*parent, *child;
+	struct device_driver 		*driver;
+	struct pcie_port_service_driver *service_driver;
+
+	parent = &dev->device;
+	head = &parent->children;
+	while (!list_empty(head)) {
+		child = container_of(head->next, struct device, node);
+		driver = child->driver;
+		if (!driver)
+			continue;
+		service_driver = to_service_driver(driver);
+		if (service_driver->resume)  
+			service_driver->resume(to_pcie_device(child));
+	}
+	return 0; 
+
+}
+#endif
+
+void pcie_port_device_remove(struct pcie_device *dev)
+{
+	struct list_head 		*head;
+	struct device 			*parent, *child;
+	struct device_driver 		*driver;
+	struct pcie_port_service_driver *service_driver;
+
+	parent = &dev->device;
+	head = &parent->children;
+	while (!list_empty(head)) {
+		child = container_of(head->next, struct device, node);
+		driver = child->driver;
+		if (driver) { 
+			service_driver = to_service_driver(driver);
+			if (service_driver->remove)  
+				service_driver->remove(to_pcie_device(child));
+		}
+		put_device(child);
+		device_unregister(child);
+	}
+
+	/* Switch to INTx by default if MSI enabled */
+	if (dev->interrupt_mode == PCIE_PORT_MSIX_MODE)
+		pci_disable_msix(dev->port);
+	else if (dev->interrupt_mode == PCIE_PORT_MSI_MODE)
+		pci_disable_msi(dev->port);
+	put_device(parent);
+	device_unregister(parent);
+}
+
+void pcie_port_bus_register(void)
+{
+	bus_register(&pcie_port_bus_type);
+	driver_register(&pcieport_generic_driver);
+}
+
+void pcie_port_bus_unregister(void)
+{
+	driver_unregister(&pcieport_generic_driver);
+	bus_unregister(&pcie_port_bus_type);
+}
+
+int pcie_port_service_register(struct pcie_port_service_driver *new)
+{
+	new->driver.name = (char *)new->name;
+	new->driver.bus = &pcie_port_bus_type;
+	new->driver.probe = pcie_port_probe_service;
+	new->driver.remove = pcie_port_remove_service;
+	new->driver.shutdown = pcie_port_shutdown_service;
+	new->driver.suspend = pcie_port_suspend_service;
+	new->driver.resume = pcie_port_resume_service;
+
+	return driver_register(&new->driver);
+} 
+
+void pcie_port_service_unregister(struct pcie_port_service_driver *new)
+{
+	driver_unregister(&new->driver);
+}
+
+EXPORT_SYMBOL(pcie_port_service_register);
+EXPORT_SYMBOL(pcie_port_service_unregister);
diff -urpN linux-2.6.10-rc3/drivers/pcieport/portdrv.h patch-2.6.10-rc3-pbdhp/drivers/pcieport/portdrv.h
--- linux-2.6.10-rc3/drivers/pcieport/portdrv.h	1969-12-31 19:00:00.000000000 -0500
+++ patch-2.6.10-rc3-pbdhp/drivers/pcieport/portdrv.h	2004-12-10 15:17:31.000000000 -0500
@@ -0,0 +1,42 @@
+/*
+ * File:	portdrv.h
+ * Purpose:	PCI Express Port Bus Driver's Internal Data Structures
+ *
+ * Copyright (C) 2004 Intel
+ * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
+ */
+
+#ifndef _PORTDRV_H_
+#define _PORTDRV_H_
+
+#if !defined(PCI_CAP_ID_PME)
+#define PCI_CAP_ID_PME			1
+#endif
+
+#if !defined(PCI_CAP_ID_EXP)
+#define PCI_CAP_ID_EXP			0x10
+#endif
+
+#define PORT_TYPE_MASK			0xf
+#define PORT_TO_SLOT_MASK		0x100
+#define SLOT_HP_CAPABLE_MASK		0x40
+#define PCIE_CAPABILITIES_REG		0x2
+#define PCIE_SLOT_CAPABILITIES_REG	0x14
+#define PCIE_PORT_DEVICE_MAXSERVICES	4
+#define PCI_CFG_SPACE_SIZE		256
+
+#define get_descriptor_id(type, service) (((type - 4) << 4) | service)
+
+extern struct bus_type pcie_port_bus_type;
+extern struct device_driver pcieport_generic_driver;
+extern int pcie_port_device_probe(struct pci_dev *dev);
+extern int pcie_port_device_register(struct pci_dev *dev);
+#ifdef CONFIG_PM
+extern int pcie_port_device_suspend(struct pcie_device *dev, u32 state);
+extern int pcie_port_device_resume(struct pcie_device *dev);
+#endif
+extern void pcie_port_device_remove(struct pcie_device *dev);
+extern void pcie_port_bus_register(void);
+extern void pcie_port_bus_unregister(void);
+
+#endif /* _PORTDRV_H_ */
diff -urpN linux-2.6.10-rc3/drivers/pcieport/portdrv_pci.c patch-2.6.10-rc3-pbdhp/drivers/pcieport/portdrv_pci.c
--- linux-2.6.10-rc3/drivers/pcieport/portdrv_pci.c	1969-12-31 19:00:00.000000000 -0500
+++ patch-2.6.10-rc3-pbdhp/drivers/pcieport/portdrv_pci.c	2004-12-10 15:31:35.000000000 -0500
@@ -0,0 +1,138 @@
+/*
+ * File:	portdrv_pci.c
+ * Purpose:	PCI Express Port Bus Driver
+ *
+ * Copyright (C) 2004 Intel
+ * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/pm.h>
+#include <linux/init.h>
+#include <linux/pcieport_if.h>
+
+#include "portdrv.h"
+
+/*
+ * Version Information
+ */
+#define DRIVER_VERSION "v1.0"
+#define DRIVER_AUTHOR "tom.l.nguyen@intel.com"
+#define DRIVER_DESC "PCIE Port Bus Driver"
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
+
+/* global data */
+static const char device_name[] = "pcieport-driver";
+
+/*
+ * pcie_portdrv_probe - Probe PCI-Express port devices
+ * @dev: PCI-Express port device being probed
+ *
+ * If detected invokes the pcie_port_device_register() method for 
+ * this port device.
+ *
+ */
+static int __devinit pcie_portdrv_probe (struct pci_dev *dev, 
+				const struct pci_device_id *id )
+{
+	int			status;
+
+	status = pcie_port_device_probe(dev);
+	if (status)
+		return status;
+
+	if (pci_enable_device(dev) < 0) 
+		return -ENODEV;
+	
+	pci_set_master(dev);
+        if (!dev->irq) {
+		printk(KERN_WARNING 
+		"%s->Dev[%04x:%04x] has invalid IRQ. Check vendor BIOS\n", 
+		__FUNCTION__, dev->device, dev->vendor);
+	}
+	if (pcie_port_device_register(dev)) 
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void pcie_portdrv_remove (struct pci_dev *dev)
+{
+	struct pcie_device *pciedev;
+
+      	pciedev = (struct pcie_device *)pci_get_drvdata(dev);
+	if (pciedev) {
+		pcie_port_device_remove(pciedev);
+		pci_set_drvdata(dev, NULL); 
+	}
+}
+
+#ifdef CONFIG_PM
+static int pcie_portdrv_suspend (struct pci_dev *dev, u32 state)
+{
+	struct pcie_device *pciedev;
+	
+      	pciedev = (struct pcie_device *)pci_get_drvdata(dev);
+	if (pciedev) 
+		pcie_port_device_suspend(pciedev, state);
+	return 0;
+}
+
+static int pcie_portdrv_resume (struct pci_dev *dev)
+{
+	struct pcie_device *pciedev;
+	
+      	pciedev = (struct pcie_device *)pci_get_drvdata(dev);
+	if (pciedev) 
+		pcie_port_device_resume(pciedev);
+	return 0;
+}
+#endif
+
+/*
+ * LINUX Device Driver Model
+ */
+static const struct pci_device_id port_pci_ids[] = { {
+	/* handle any PCI-Express port */
+	PCI_DEVICE_CLASS(((PCI_CLASS_BRIDGE_PCI << 8) | 0x00), ~0),
+	}, { /* end: all zeroes */ }
+};
+MODULE_DEVICE_TABLE(pci, port_pci_ids);
+
+static struct pci_driver pcie_portdrv = {
+	.name		= (char *)device_name,
+	.id_table	= &port_pci_ids[0],
+
+	.probe		= pcie_portdrv_probe,
+	.remove		= pcie_portdrv_remove,
+
+#ifdef	CONFIG_PM
+	.suspend	= pcie_portdrv_suspend,
+	.resume		= pcie_portdrv_resume,
+#endif	/* PM */
+};
+
+static int __init pcie_portdrv_init(void)
+{
+	int retval = 0;
+
+	pcie_port_bus_register();
+	retval = pci_module_init(&pcie_portdrv);
+	if (retval)
+		pcie_port_bus_unregister();
+	return retval;
+}
+
+static void __exit pcie_portdrv_exit(void) 
+{
+	pci_unregister_driver(&pcie_portdrv);
+	pcie_port_bus_unregister();
+}
+
+module_init(pcie_portdrv_init);
+module_exit(pcie_portdrv_exit);
diff -urpN linux-2.6.10-rc3/include/linux/pcieport_if.h patch-2.6.10-rc3-pbdhp/include/linux/pcieport_if.h
--- linux-2.6.10-rc3/include/linux/pcieport_if.h	1969-12-31 19:00:00.000000000 -0500
+++ patch-2.6.10-rc3-pbdhp/include/linux/pcieport_if.h	2004-12-10 14:06:05.000000000 -0500
@@ -0,0 +1,74 @@
+/*
+ * File:	pcieport_if.h
+ * Purpose:	PCI Express Port Bus Driver's IF Data Structure
+ *
+ * Copyright (C) 2004 Intel
+ * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
+ */
+
+#ifndef _PCIEPORT_IF_H_
+#define _PCIEPORT_IF_H_
+
+/* Port Type */
+#define PCIE_RC_PORT			4	/* Root port of RC */
+#define PCIE_SW_UPSTREAM_PORT		5	/* Upstream port of Switch */
+#define PCIE_SW_DOWNSTREAM_PORT		6	/* Downstream port of Switch */
+#define PCIE_ANY_PORT			7
+
+/* Service Type */
+#define PCIE_PORT_SERVICE_PME		1	/* Power Management Event */
+#define PCIE_PORT_SERVICE_AER		2	/* Advanced Error Reporting */
+#define PCIE_PORT_SERVICE_HP		4	/* Native Hotplug */
+#define PCIE_PORT_SERVICE_VC		8	/* Virtual Channel */
+
+/* Root/Upstream/Downstream Port's Interrupt Mode */
+#define PCIE_PORT_INTx_MODE		0
+#define PCIE_PORT_MSI_MODE		1
+#define PCIE_PORT_MSIX_MODE		2
+
+struct pcie_port_service_id {
+	__u32 vendor, device;		/* Vendor and device ID or PCI_ANY_ID*/
+	__u32 subvendor, subdevice;	/* Subsystem ID's or PCI_ANY_ID */
+	__u32 class, class_mask;	/* (class,subclass,prog-if) triplet */
+	__u32 port_type, service_type;	/* Port Entity */
+	kernel_ulong_t driver_data;
+};
+
+struct pcie_device {
+	int 		irq;	    /* Service IRQ/MSI/MSI-X Vector */
+	int 		interrupt_mode;	/* [0:INTx | 1:MSI | 2:MSI-X] */	
+	struct pcie_port_service_id id;	/* Service ID */
+	struct pci_dev	*port;	    /* Root/Upstream/Downstream Port */
+	void		*priv_data; /* Service Private Data */
+	struct device	device;     /* Generic Device Interface */
+};
+#define to_pcie_device(d) container_of(d, struct pcie_device, device)
+
+static inline void set_service_data(struct pcie_device *dev, void *data)
+{
+	dev->priv_data = data;
+}
+
+static inline void* get_service_data(struct pcie_device *dev)
+{
+	return dev->priv_data;
+}
+
+struct pcie_port_service_driver {
+	const char *name;
+	int (*probe) (struct pcie_device *dev, 
+		const struct pcie_port_service_id *id);
+	void (*remove) (struct pcie_device *dev);
+	int (*suspend) (struct pcie_device *dev, u32 state);
+	int (*resume) (struct pcie_device *dev);
+
+	const struct pcie_port_service_id *id_table;
+	struct device_driver driver;
+};
+#define to_service_driver(d) \
+	container_of(d, struct pcie_port_service_driver, driver)
+
+extern int pcie_port_service_register(struct pcie_port_service_driver *new);
+extern void pcie_port_service_unregister(struct pcie_port_service_driver *new);
+
+#endif /* _PCIEPORT_IF_H_ */
