Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262694AbUKLXbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbUKLXbx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbUKLXay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:30:54 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:1273 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262696AbUKLXWs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:48 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017163474@kroah.com>
Date: Fri, 12 Nov 2004 15:21:56 -0800
Message-Id: <11003017161992@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2026.66.15, 2004/11/05 15:06:04-08:00, dlsy@snoqualmie.dp.intel.com

[PATCH] PCI: ASPM patch for

This is the ASPM patch against 2.6.10-rc1-mm2.

As mentioned in my last email, this patch has a slight difference than
the one for 2.6.10-rc1,  because the irqbalance quirk was moved from
drivers/pci/quirks.c in 2.6.10-rc1 to arch/i386/kernel/quirks.c in
2.6.10-rc1-mm2.

Signed-off-by: Dely Sy <dely.l.sy@intel.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/i386/kernel/quirks.c         |    4 -
 arch/i386/pci/fixup.c             |   91 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/hotplug/pciehp_ctrl.c |    9 +++
 drivers/pci/hotplug/pciehp_hpc.c  |    6 +-
 drivers/pci/hotplug/pciehp_pci.c  |    8 +++
 drivers/pci/hotplug/shpchp_hpc.c  |    1 
 drivers/pci/pci.h                 |    2 
 drivers/pci/quirks.c              |   18 ++++---
 include/linux/pci_ids.h           |    8 ++-
 9 files changed, 133 insertions(+), 14 deletions(-)


diff -Nru a/arch/i386/kernel/quirks.c b/arch/i386/kernel/quirks.c
--- a/arch/i386/kernel/quirks.c	2004-11-12 15:13:05 -08:00
+++ b/arch/i386/kernel/quirks.c	2004-11-12 15:13:05 -08:00
@@ -6,7 +6,7 @@
 
 #if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_SMP)
 
-void __init quirk_intel_irqbalance(struct pci_dev *dev)
+void __devinit quirk_intel_irqbalance(struct pci_dev *dev)
 {
 	u8 config, rev;
 	u32 word;
@@ -45,5 +45,5 @@
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7320_MCH,	quirk_intel_irqbalance);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7525_MCH,	quirk_intel_irqbalance);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_SMCH,	quirk_intel_irqbalance);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7520_MCH,	quirk_intel_irqbalance);
 #endif
diff -Nru a/arch/i386/pci/fixup.c b/arch/i386/pci/fixup.c
--- a/arch/i386/pci/fixup.c	2004-11-12 15:13:05 -08:00
+++ b/arch/i386/pci/fixup.c	2004-11-12 15:13:05 -08:00
@@ -255,3 +255,94 @@
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2, pci_fixup_nforce2);
 
+/* Max PCI Express root ports */
+#define MAX_PCIEROOT	6
+static int quirk_aspm_offset[MAX_PCIEROOT << 3];
+
+#define GET_INDEX(a, b) (((a - PCI_DEVICE_ID_INTEL_MCH_PA) << 3) + b)
+
+static int quirk_pcie_aspm_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
+{
+	return raw_pci_ops->read(0, bus->number, devfn, where, size, value);
+}
+
+/*
+ * Replace the original pci bus ops for write with a new one that will filter
+ * the request to insure ASPM cannot be enabled.
+ */
+static int quirk_pcie_aspm_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
+{
+	u8 offset;
+
+	offset = quirk_aspm_offset[GET_INDEX(bus->self->device, devfn)];
+
+	if ((offset) && (where == offset))
+		value = value & 0xfffffffc;
+	
+	return raw_pci_ops->write(0, bus->number, devfn, where, size, value);
+}
+
+struct pci_ops quirk_pcie_aspm_ops = {
+	.read = quirk_pcie_aspm_read,
+	.write = quirk_pcie_aspm_write,
+};
+
+/*
+ * Prevents PCI Express ASPM (Active State Power Management) being enabled.
+ *
+ * Save the register offset, where the ASPM control bits are located,
+ * for each PCI Express device that is in the device list of
+ * the root port in an array for fast indexing. Replace the bus ops
+ * with the modified one.
+ */
+void pcie_rootport_aspm_quirk(struct pci_dev *pdev)
+{
+	int cap_base, i;
+	struct pci_bus  *pbus;
+	struct pci_dev *dev;
+
+	if ((pbus = pdev->subordinate) == NULL)
+		return;
+
+	/*
+	 * Check if the DID of pdev matches one of the six root ports. This
+	 * check is needed in the case this function is called directly by the
+	 * hot-plug driver.
+	 */
+	if ((pdev->device < PCI_DEVICE_ID_INTEL_MCH_PA) ||
+	    (pdev->device > PCI_DEVICE_ID_INTEL_MCH_PC1))
+		return;
+
+	if (list_empty(&pbus->devices)) {
+		/*
+		 * If no device is attached to the root port at power-up or
+		 * after hot-remove, the pbus->devices is empty and this code
+		 * will set the offsets to zero and the bus ops to parent's bus
+		 * ops, which is unmodified.
+	 	 */
+		for (i= GET_INDEX(pdev->device, 0); i <= GET_INDEX(pdev->device, 7); ++i)
+			quirk_aspm_offset[i] = 0;
+
+		pbus->ops = pbus->parent->ops;
+	} else {
+		/*
+		 * If devices are attached to the root port at power-up or
+		 * after hot-add, the code loops through the device list of
+		 * each root port to save the register offsets and replace the
+		 * bus ops.
+		 */
+		list_for_each_entry(dev, &pbus->devices, bus_list) {
+			/* There are 0 to 8 devices attached to this bus */
+			cap_base = pci_find_capability(dev, PCI_CAP_ID_EXP);
+			quirk_aspm_offset[GET_INDEX(pdev->device, dev->devfn)]= cap_base + 0x10;
+		}
+		pbus->ops = &quirk_pcie_aspm_ops;
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PA,	pcie_rootport_aspm_quirk );
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PA1,	pcie_rootport_aspm_quirk );
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PB,	pcie_rootport_aspm_quirk );
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PB1,	pcie_rootport_aspm_quirk );
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PC,	pcie_rootport_aspm_quirk );
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_MCH_PC1,	pcie_rootport_aspm_quirk );
+
diff -Nru a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
--- a/drivers/pci/hotplug/pciehp_ctrl.c	2004-11-12 15:13:05 -08:00
+++ b/drivers/pci/hotplug/pciehp_ctrl.c	2004-11-12 15:13:05 -08:00
@@ -38,6 +38,7 @@
 #include <linux/wait.h>
 #include <linux/smp_lock.h>
 #include <linux/pci.h>
+#include "../pci.h"
 #include "pciehp.h"
 #include "pciehprm.h"
 
@@ -1220,7 +1221,13 @@
 				pciehp_configure_device(ctrl, new_func);
 			}
 		} while (new_func);
-  		
+
+ 		/* 
+ 		 * Some PCI Express root ports require fixup after hot-plug operation.
+ 		 */
+ 		if (pcie_mch_quirk)
+ 			pci_fixup_device(pci_fixup_final, ctrl->pci_dev);
+ 
   		if (PWR_LED(ctrl->ctrlcap)) {
   			/* Wait for exclusive access to hardware */
   			down(&ctrl->crit_sect);
diff -Nru a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
--- a/drivers/pci/hotplug/pciehp_hpc.c	2004-11-12 15:13:05 -08:00
+++ b/drivers/pci/hotplug/pciehp_hpc.c	2004-11-12 15:13:05 -08:00
@@ -741,6 +741,8 @@
 		if (php_ctlr->irq) {
 			free_irq(php_ctlr->irq, ctrl);
 			php_ctlr->irq = 0;
+			if (!pcie_mch_quirk) 
+				pci_disable_msi(php_ctlr->pci_dev);
 		}
 	}
 	if (php_ctlr->pci_dev) 
@@ -1402,8 +1404,8 @@
 		start_int_poll_timer( php_ctlr, 10 );   /* start with 10 second delay */
 	} else {
 		/* Installs the interrupt handler */
-		dbg("%s: pciehp_msi_quirk = %x\n", __FUNCTION__, pciehp_msi_quirk);
-		if (!pciehp_msi_quirk) {
+		dbg("%s: pcie_mch_quirk = %x\n", __FUNCTION__, pcie_mch_quirk);
+		if (!pcie_mch_quirk) {
 			rc = pci_enable_msi(pdev);
 			if (rc) {
 				info("Can't get msi for the hotplug controller\n");
diff -Nru a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
--- a/drivers/pci/hotplug/pciehp_pci.c	2004-11-12 15:13:05 -08:00
+++ b/drivers/pci/hotplug/pciehp_pci.c	2004-11-12 15:13:05 -08:00
@@ -82,9 +82,11 @@
 {
 	int rc = 0;
 	int j;
+	struct pci_bus *pbus;
 
 	dbg("%s: bus/dev/func = %x/%x/%x\n", __FUNCTION__, func->bus,
 				func->device, func->function);
+	pbus = func->pci_dev->bus;
 
 	for (j=0; j<8 ; j++) {
 		struct pci_dev* temp = pci_find_slot(func->bus,
@@ -93,6 +95,12 @@
 			pci_remove_bus_device(temp);
 		}
 	}
+	/* 
+	 * Some PCI Express root ports require fixup after hot-plug operation.
+	 */
+	if (pcie_mch_quirk) 
+		pci_fixup_device(pci_fixup_final, pbus->self);
+	
 	return rc;
 }
 
diff -Nru a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
--- a/drivers/pci/hotplug/shpchp_hpc.c	2004-11-12 15:13:05 -08:00
+++ b/drivers/pci/hotplug/shpchp_hpc.c	2004-11-12 15:13:05 -08:00
@@ -792,6 +792,7 @@
 		if (php_ctlr->irq) {
 			free_irq(php_ctlr->irq, ctrl);
 			php_ctlr->irq = 0;
+			pci_disable_msi(php_ctlr->pci_dev);
 		}
 	}
 	if (php_ctlr->pci_dev) {
diff -Nru a/drivers/pci/pci.h b/drivers/pci/pci.h
--- a/drivers/pci/pci.h	2004-11-12 15:13:05 -08:00
+++ b/drivers/pci/pci.h	2004-11-12 15:13:05 -08:00
@@ -61,7 +61,7 @@
 /* Lock for read/write access to pci device and bus lists */
 extern spinlock_t pci_bus_lock;
 
-extern int pciehp_msi_quirk;
+extern int pcie_mch_quirk;
 extern struct device_attribute pci_dev_attrs[];
 
 /**
diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2004-11-12 15:13:05 -08:00
+++ b/drivers/pci/quirks.c	2004-11-12 15:13:05 -08:00
@@ -1135,7 +1135,7 @@
 #endif
 
 #ifdef CONFIG_SCSI_SATA
-static void __init quirk_intel_ide_combined(struct pci_dev *pdev)
+static void __devinit quirk_intel_ide_combined(struct pci_dev *pdev)
 {
 	u8 prog, comb, tmp;
 	int ich = 0;
@@ -1209,14 +1209,15 @@
 #endif /* CONFIG_SCSI_SATA */
 
 
-int pciehp_msi_quirk;
+int pcie_mch_quirk;
 
-static void __devinit quirk_pciehp_msi(struct pci_dev *pdev)
+static void __devinit quirk_pcie_mch(struct pci_dev *pdev)
 {
-	pciehp_msi_quirk = 1;
+	pcie_mch_quirk = 1;
 }
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_SMCH,	quirk_pciehp_msi );
-
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7520_MCH,	quirk_pcie_mch );
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7320_MCH,	quirk_pcie_mch );
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7525_MCH,	quirk_pcie_mch );
 
 static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f, struct pci_fixup *end)
 {
@@ -1265,4 +1266,7 @@
 	pci_do_fixups(dev, start, end);
 }
 
-EXPORT_SYMBOL(pciehp_msi_quirk);
+EXPORT_SYMBOL(pcie_mch_quirk);
+#ifdef CONFIG_HOTPLUG
+EXPORT_SYMBOL(pci_fixup_device);
+#endif
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	2004-11-12 15:13:05 -08:00
+++ b/include/linux/pci_ids.h	2004-11-12 15:13:05 -08:00
@@ -2206,8 +2206,14 @@
 #define PCI_DEVICE_ID_INTEL_82830_CGC	0x3577
 #define PCI_DEVICE_ID_INTEL_82855GM_HB	0x3580
 #define PCI_DEVICE_ID_INTEL_82855GM_IG	0x3582
-#define PCI_DEVICE_ID_INTEL_SMCH	0x3590
+#define PCI_DEVICE_ID_INTEL_E7520_MCH	0x3590
 #define PCI_DEVICE_ID_INTEL_E7320_MCH	0x3592
+#define PCI_DEVICE_ID_INTEL_MCH_PA	0x3595
+#define PCI_DEVICE_ID_INTEL_MCH_PA1	0x3596
+#define PCI_DEVICE_ID_INTEL_MCH_PB	0x3597
+#define PCI_DEVICE_ID_INTEL_MCH_PB1	0x3598
+#define PCI_DEVICE_ID_INTEL_MCH_PC	0x3599
+#define PCI_DEVICE_ID_INTEL_MCH_PC1	0x359a
 #define PCI_DEVICE_ID_INTEL_E7525_MCH	0x359e
 #define PCI_DEVICE_ID_INTEL_80310	0x530d
 #define PCI_DEVICE_ID_INTEL_82371SB_0	0x7000

