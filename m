Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263088AbVHETMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbVHETMw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 15:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263009AbVHETMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 15:12:33 -0400
Received: from fmr18.intel.com ([134.134.136.17]:958 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S263107AbVHETKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 15:10:12 -0400
Subject: Re: [PATCH] 6700/6702PXH quirk
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Greg KH <greg@kroah.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       rajesh.shah@intel.com
In-Reply-To: <20050805183505.GA32405@kroah.com>
References: <1123259263.8917.9.camel@whizzy>
	 <20050805183505.GA32405@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 05 Aug 2005 12:10:08 -0700
Message-Id: <1123269008.8917.35.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
X-OriginalArrivalTime: 05 Aug 2005 19:10:09.0139 (UTC) FILETIME=[4C037430:01C599F1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 11:35 -0700, Greg KH wrote:
> On Fri, Aug 05, 2005 at 09:27:42AM -0700, Kristen Accardi wrote:
> > @@ -1127,3 +1159,5 @@ EXPORT_SYMBOL(pci_enable_msi);
> >  EXPORT_SYMBOL(pci_disable_msi);
> >  EXPORT_SYMBOL(pci_enable_msix);
> >  EXPORT_SYMBOL(pci_disable_msix);
> > +EXPORT_SYMBOL(disable_msi_mode);
> > +EXPORT_SYMBOL(msi_add_quirk);
> 
> Why do these need to be exported?  It doesn't look like you are trying
> to access these from a module, or do you have a patch that uses them
> somewhere else?
> 
> thanks,
> 
> greg k-h

Oh... I thought I had to in order to access it from quirks.c.  You are
right, I don't need this, and we can always export later if modules want
to add to the msi_quirks list.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

diff -uprN -X linux-2.6.13-rc4/Documentation/dontdiff linux-2.6.13-rc4/drivers/pci/msi.c linux-2.6.13-rc4-pxhquirk/drivers/pci/msi.c
--- linux-2.6.13-rc4/drivers/pci/msi.c	2005-07-28 15:44:44.000000000 -0700
+++ linux-2.6.13-rc4-pxhquirk/drivers/pci/msi.c	2005-08-05 11:38:00.000000000 -0700
@@ -38,6 +38,32 @@ int vector_irq[NR_VECTORS] = { [0 ... NR
 u8 irq_vector[NR_IRQ_VECTORS] = { FIRST_DEVICE_VECTOR , 0 };
 #endif
 
+
+LIST_HEAD(msi_quirk_list);
+
+struct msi_quirk 
+{
+	struct list_head list;
+	struct pci_dev *dev;
+};
+
+
+int msi_add_quirk(struct pci_dev *dev)
+{
+	struct msi_quirk *quirk;
+
+	quirk = (struct msi_quirk *) kmalloc(sizeof(*quirk), GFP_KERNEL);
+	if (!quirk)
+		return -ENOMEM;
+	
+	INIT_LIST_HEAD(&quirk->list);
+	quirk->dev = dev;
+	list_add(&quirk->list, &msi_quirk_list);
+	return 0;
+}
+
+
+
 static void msi_cache_ctor(void *p, kmem_cache_t *cache, unsigned long flags)
 {
 	memset(p, 0, NR_IRQS * sizeof(struct msi_desc));
@@ -453,7 +479,7 @@ static void enable_msi_mode(struct pci_d
 	}
 }
 
-static void disable_msi_mode(struct pci_dev *dev, int pos, int type)
+void disable_msi_mode(struct pci_dev *dev, int pos, int type)
 {
 	u16 control;
 
@@ -695,10 +721,16 @@ int pci_enable_msi(struct pci_dev* dev)
 {
 	int pos, temp, status = -EINVAL;
 	u16 control;
+	struct msi_quirk *quirk;
 
 	if (!pci_msi_enable || !dev)
  		return status;
 
+	list_for_each_entry(quirk, &msi_quirk_list, list) {
+		if (quirk->dev == dev)
+			return -EINVAL;
+	}
+
 	temp = dev->irq;
 
 	if ((status = msi_init()) < 0)
diff -uprN -X linux-2.6.13-rc4/Documentation/dontdiff linux-2.6.13-rc4/drivers/pci/quirks.c linux-2.6.13-rc4-pxhquirk/drivers/pci/quirks.c
--- linux-2.6.13-rc4/drivers/pci/quirks.c	2005-07-28 15:44:44.000000000 -0700
+++ linux-2.6.13-rc4-pxhquirk/drivers/pci/quirks.c	2005-08-05 11:54:15.000000000 -0700
@@ -21,6 +21,10 @@
 #include <linux/acpi.h>
 #include "pci.h"
 
+
+void disable_msi_mode(struct pci_dev *dev, int pos, int type);
+int msi_add_quirk(struct pci_dev *dev);
+
 /* Deal with broken BIOS'es that neglect to enable passive release,
    which can cause problems in combination with the 82441FX/PPro MTRRs */
 static void __devinit quirk_passive_release(struct pci_dev *dev)
@@ -1267,6 +1271,30 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_IN
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7320_MCH,	quirk_pcie_mch );
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7525_MCH,	quirk_pcie_mch );
 
+
+/* 
+ * It's possible for the MSI to get corrupted if shpc and acpi
+ * are used together on certain PXH-based systems.
+ */
+static void __devinit quirk_pcie_pxh(struct pci_dev *dev)
+{
+	disable_msi_mode(dev, pci_find_capability(dev, PCI_CAP_ID_MSI),
+					PCI_CAP_ID_MSI);
+	if (!msi_add_quirk(dev)) 
+		printk(KERN_WARNING "PCI: PXH quirk detected, disabling MSI for SHPC device\n");
+	else {
+		pci_msi_quirk = 1;
+		printk(KERN_WARNING "PCI: PXH quirk detected, unable to disable MSI for SHPC device, disabling MSI for all devices\n");
+	}
+			
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXHD_0,	quirk_pcie_pxh);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXHD_1,	quirk_pcie_pxh);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXH_0,	quirk_pcie_pxh);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXH_1,	quirk_pcie_pxh);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXHV,	quirk_pcie_pxh);
+
+
 static void __devinit quirk_netmos(struct pci_dev *dev)
 {
 	unsigned int num_parallel = (dev->subsystem_device & 0xf0) >> 4;
diff -uprN -X linux-2.6.13-rc4/Documentation/dontdiff linux-2.6.13-rc4/include/linux/pci_ids.h linux-2.6.13-rc4-pxhquirk/include/linux/pci_ids.h
--- linux-2.6.13-rc4/include/linux/pci_ids.h	2005-07-28 15:44:44.000000000 -0700
+++ linux-2.6.13-rc4-pxhquirk/include/linux/pci_ids.h	2005-08-02 13:58:53.000000000 -0700
@@ -2281,6 +2281,11 @@
 #define PCI_VENDOR_ID_INTEL		0x8086
 #define PCI_DEVICE_ID_INTEL_EESSC	0x0008
 #define PCI_DEVICE_ID_INTEL_21145	0x0039
+#define PCI_DEVICE_ID_INTEL_PXHD_0	0x0320
+#define PCI_DEVICE_ID_INTEL_PXHD_1	0x0321
+#define PCI_DEVICE_ID_INTEL_PXH_0	0x0329
+#define PCI_DEVICE_ID_INTEL_PXH_1	0x032A
+#define PCI_DEVICE_ID_INTEL_PXHV	0x032C
 #define PCI_DEVICE_ID_INTEL_82375	0x0482
 #define PCI_DEVICE_ID_INTEL_82424	0x0483
 #define PCI_DEVICE_ID_INTEL_82378	0x0484

