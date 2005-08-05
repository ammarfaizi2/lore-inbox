Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262131AbVHEXym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbVHEXym (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 19:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbVHEXym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 19:54:42 -0400
Received: from fmr20.intel.com ([134.134.136.19]:16601 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S263157AbVHEXwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 19:52:55 -0400
Subject: Re: [PATCH] 6700/6702PXH quirk
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, rajesh.shah@intel.com
In-Reply-To: <20050805225005.GA16155@havoc.gtf.org>
References: <1123259263.8917.9.camel@whizzy>
	 <20050805183505.GA32405@kroah.com>  <20050805225005.GA16155@havoc.gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 05 Aug 2005 16:51:47 -0700
Message-Id: <1123285907.4706.19.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
X-OriginalArrivalTime: 05 Aug 2005 23:51:48.0192 (UTC) FILETIME=[A4A24E00:01C59A18]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 18:50 -0400, Jeff Garzik wrote:
> 
> AFAICS we don't need a new list, simply consisting of PCI devs.
> 
> Just invent, and set, a bit somewhere in struct pci_dev.
> 
> 	Jeff
> 
> 
> 
Great!  I like that much better.  How about this:

On the 6700/6702 PXH part, a MSI may get corrupted if an ACPI hotplug
driver and SHPC driver in MSI mode are used together.  This patch will
prevent MSI from being enabled for the SHPC as part of an early pci
quirk, as well as on any pci device which sets the no_msi bit.  

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

diff -uprN -X linux-2.6.13-rc4/Documentation/dontdiff linux-2.6.13-rc4/drivers/pci/msi.c linux-2.6.13-rc4-pxhquirk/drivers/pci/msi.c
--- linux-2.6.13-rc4/drivers/pci/msi.c	2005-07-28 15:44:44.000000000 -0700
+++ linux-2.6.13-rc4-pxhquirk/drivers/pci/msi.c	2005-08-05 16:35:16.000000000 -0700
@@ -453,7 +453,7 @@ static void enable_msi_mode(struct pci_d
 	}
 }
 
-static void disable_msi_mode(struct pci_dev *dev, int pos, int type)
+void disable_msi_mode(struct pci_dev *dev, int pos, int type)
 {
 	u16 control;
 
@@ -699,6 +699,9 @@ int pci_enable_msi(struct pci_dev* dev)
 	if (!pci_msi_enable || !dev)
  		return status;
 
+	if (dev->no_msi)
+		return status;
+
 	temp = dev->irq;
 
 	if ((status = msi_init()) < 0)
diff -uprN -X linux-2.6.13-rc4/Documentation/dontdiff linux-2.6.13-rc4/drivers/pci/pci.h linux-2.6.13-rc4-pxhquirk/drivers/pci/pci.h
--- linux-2.6.13-rc4/drivers/pci/pci.h	2005-07-28 15:44:44.000000000 -0700
+++ linux-2.6.13-rc4-pxhquirk/drivers/pci/pci.h	2005-08-05 16:37:18.000000000 -0700
@@ -46,7 +46,7 @@ extern int pci_msi_quirk;
 #else
 #define pci_msi_quirk 0
 #endif
-
+void disable_msi_mode(struct pci_dev *dev, int pos, int type);
 extern int pcie_mch_quirk;
 extern struct device_attribute pci_dev_attrs[];
 extern struct class_device_attribute class_device_attr_cpuaffinity;
diff -uprN -X linux-2.6.13-rc4/Documentation/dontdiff linux-2.6.13-rc4/drivers/pci/quirks.c linux-2.6.13-rc4-pxhquirk/drivers/pci/quirks.c
--- linux-2.6.13-rc4/drivers/pci/quirks.c	2005-07-28 15:44:44.000000000 -0700
+++ linux-2.6.13-rc4-pxhquirk/drivers/pci/quirks.c	2005-08-05 16:38:28.000000000 -0700
@@ -1267,6 +1267,27 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_IN
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
+	dev->no_msi = 1;
+
+	printk(KERN_WARNING "PCI: PXH quirk detected, "
+		"disabling MSI for SHPC device\n");
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
diff -uprN -X linux-2.6.13-rc4/Documentation/dontdiff linux-2.6.13-rc4/include/linux/pci.h linux-2.6.13-rc4-pxhquirk/include/linux/pci.h
--- linux-2.6.13-rc4/include/linux/pci.h	2005-07-28 15:44:44.000000000 -0700
+++ linux-2.6.13-rc4-pxhquirk/include/linux/pci.h	2005-08-05 16:37:08.000000000 -0700
@@ -556,6 +556,7 @@ struct pci_dev {
 	/* keep track of device state */
 	unsigned int	is_enabled:1;	/* pci_enable_device has been called */
 	unsigned int	is_busmaster:1; /* device is busmaster */
+	unsigned int	no_msi:1;    	/* device may not use msi */
 	
 	u32		saved_config_space[16]; /* config space saved at suspend time */
 	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
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

