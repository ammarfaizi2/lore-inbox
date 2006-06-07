Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWFGDPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWFGDPv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 23:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWFGDPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 23:15:51 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:1762 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750772AbWFGDPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 23:15:50 -0400
Message-ID: <44864424.8040408@jp.fujitsu.com>
Date: Wed, 07 Jun 2006 12:12:36 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, akpm@osdl.org,
       Rajesh Shah <rajesh.shah@intel.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       "bibo,mao" <bibo.mao@intel.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 1/4] Changes to generic pci code
References: <447E91CE.7010705@intel.com> <20060601024611.A32490@unix-os.sc.intel.com> <20060601171559.GA16288@colo.lackof.org> <20060601113625.A4043@unix-os.sc.intel.com> <447FA920.9060509@jp.fujitsu.com> <4484263C.1030508@jp.fujitsu.com> <20060606075812.GB19619@kroah.com> <448643B9.2080805@jp.fujitsu.com>
In-Reply-To: <448643B9.2080805@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the following changes into generic PCI code especially
for PCI legacy I/O port free drivers.

    - Moved the following two things from pci_enable_device() into
      pci_enable_device_bars(). By this change, we can use
      pci_enable_device_bars() to enable only the specific regions.

          o Call pci_fixup_device() on the device
          o Set dev->is_enabled

    - Added new field 'bars_enabled' into struct pci_device to
      remember which BARs already enabled. This new field is
      initialized at pci_enable_device_bars() time and cleared
      at pci_disable_device() time. This is needed for
      pci_default_resume() to enable appropriate BARs.

    - Added new pci_request_selected_regions() and
      pci_release_selected_regions() for PCI legacy I/O port free
      drivers in order to request/release only the selected regions.

    - Added helper routine pci_select_bars() which makes proper mask
      of BARs from the specified resource type. This would be very
      helpful for users of pci_enable_device_bars().

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 drivers/pci/pci-driver.c |    3 +
 drivers/pci/pci.c        |   86 ++++++++++++++++++++++++++++++++++++-----------
 include/linux/pci.h      |    4 ++
 3 files changed, 73 insertions(+), 20 deletions(-)

Index: linux-2.6.17-rc6/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.17-rc6.orig/drivers/pci/pci-driver.c	2006-06-06 21:39:11.000000000 +0900
+++ linux-2.6.17-rc6/drivers/pci/pci-driver.c	2006-06-06 21:40:26.000000000 +0900
@@ -293,7 +293,8 @@
 	pci_restore_state(pci_dev);
 	/* if the device was enabled before suspend, reenable */
 	if (pci_dev->is_enabled)
-		retval = pci_enable_device(pci_dev);
+		retval = pci_enable_device_bars(pci_dev,
+						pci_dev->bars_enabled);
 	/* if the device was busmaster before the suspend, make it busmaster again */
 	if (pci_dev->is_busmaster)
 		pci_set_master(pci_dev);
Index: linux-2.6.17-rc6/drivers/pci/pci.c
===================================================================
--- linux-2.6.17-rc6.orig/drivers/pci/pci.c	2006-06-06 21:39:11.000000000 +0900
+++ linux-2.6.17-rc6/drivers/pci/pci.c	2006-06-06 21:55:46.000000000 +0900
@@ -490,6 +490,9 @@
 	err = pcibios_enable_device(dev, bars);
 	if (err < 0)
 		return err;
+	pci_fixup_device(pci_fixup_enable, dev);
+	dev->is_enabled = 1;
+	dev->bars_enabled = bars;
 	return 0;
 }
 
@@ -507,8 +510,6 @@
 	int err = pci_enable_device_bars(dev, (1 << PCI_NUM_RESOURCES) - 1);
 	if (err)
 		return err;
-	pci_fixup_device(pci_fixup_enable, dev);
-	dev->is_enabled = 1;
 	return 0;
 }
 
@@ -543,6 +544,7 @@
 
 	pcibios_disable_device(dev);
 	dev->is_enabled = 0;
+	dev->bars_enabled = 0;
 }
 
 /**
@@ -651,7 +653,7 @@
 {
 	if (pci_resource_len(pdev, bar) == 0)
 		return 0;
-		
+
 	if (pci_resource_flags(pdev, bar) & IORESOURCE_IO) {
 		if (!request_region(pci_resource_start(pdev, bar),
 			    pci_resource_len(pdev, bar), res_name))
@@ -674,6 +676,47 @@
 	return -EBUSY;
 }
 
+/**
+ * pci_release_selected_regions - Release selected PCI I/O and memory resources
+ * @pdev: PCI device whose resources were previously reserved
+ * @bars: Bitmask of BARs to be released
+ *
+ * Release selected PCI I/O and memory resources previously reserved.
+ * Call this function only after all use of the PCI regions has ceased.
+ */
+void pci_release_selected_regions(struct pci_dev *pdev, int bars)
+{
+	int i;
+
+	for (i = 0; i < 6; i++)
+		if (bars & (1 << i))
+			pci_release_region(pdev, i);
+}
+
+/**
+ * pci_request_selected_regions - Reserve selected PCI I/O and memory resources
+ * @pdev: PCI device whose resources are to be reserved
+ * @bars: Bitmask of BARs to be requested
+ * @res_name: Name to be associated with resource
+ */
+int pci_request_selected_regions(struct pci_dev *pdev, int bars,
+				 const char *res_name)
+{
+	int i;
+
+	for (i = 0; i < 6; i++)
+		if (bars & (1 << i))
+			if(pci_request_region(pdev, i, res_name))
+				goto err_out;
+	return 0;
+
+err_out:
+	while(--i >= 0)
+		if (bars & (1 << i))
+			pci_release_region(pdev, i);
+
+	return -EBUSY;
+}
 
 /**
  *	pci_release_regions - Release reserved PCI I/O and memory resources
@@ -686,10 +729,7 @@
 
 void pci_release_regions(struct pci_dev *pdev)
 {
-	int i;
-	
-	for (i = 0; i < 6; i++)
-		pci_release_region(pdev, i);
+	pci_release_selected_regions(pdev, (1 << 6) - 1);
 }
 
 /**
@@ -707,18 +747,7 @@
  */
 int pci_request_regions(struct pci_dev *pdev, const char *res_name)
 {
-	int i;
-	
-	for (i = 0; i < 6; i++)
-		if(pci_request_region(pdev, i, res_name))
-			goto err_out;
-	return 0;
-
-err_out:
-	while(--i >= 0)
-		pci_release_region(pdev, i);
-		
-	return -EBUSY;
+	return pci_request_selected_regions(pdev, ((1 << 6) - 1), res_name);
 }
 
 /**
@@ -891,6 +920,22 @@
 }
 #endif
      
+/**
+ * pci_select_bars - Make BAR mask from the type of resource
+ * @pdev: the PCI device for which BAR mask is made
+ * @flags: resource type mask to be selected
+ *
+ * This helper routine makes bar mask from the type of resource.
+ */
+int pci_select_bars(struct pci_dev *dev, unsigned long flags)
+{
+	int i, bars = 0;
+	for (i = 0; i < PCI_NUM_RESOURCES; i++)
+		if (pci_resource_flags(dev, i) & flags)
+			bars |= (1 << i);
+	return bars;
+}
+
 static int __devinit pci_init(void)
 {
 	struct pci_dev *dev = NULL;
@@ -940,6 +985,8 @@
 EXPORT_SYMBOL(pci_request_regions);
 EXPORT_SYMBOL(pci_release_region);
 EXPORT_SYMBOL(pci_request_region);
+EXPORT_SYMBOL(pci_release_selected_regions);
+EXPORT_SYMBOL(pci_request_selected_regions);
 EXPORT_SYMBOL(pci_set_master);
 EXPORT_SYMBOL(pci_set_mwi);
 EXPORT_SYMBOL(pci_clear_mwi);
@@ -948,6 +995,7 @@
 EXPORT_SYMBOL(pci_set_consistent_dma_mask);
 EXPORT_SYMBOL(pci_assign_resource);
 EXPORT_SYMBOL(pci_find_parent_resource);
+EXPORT_SYMBOL(pci_select_bars);
 
 EXPORT_SYMBOL(pci_set_power_state);
 EXPORT_SYMBOL(pci_save_state);
Index: linux-2.6.17-rc6/include/linux/pci.h
===================================================================
--- linux-2.6.17-rc6.orig/include/linux/pci.h	2006-06-06 21:39:11.000000000 +0900
+++ linux-2.6.17-rc6/include/linux/pci.h	2006-06-06 21:40:26.000000000 +0900
@@ -169,6 +169,7 @@
 	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
 	int rom_attr_enabled;		/* has display of the rom attribute been enabled? */
 	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
+	int	bars_enabled;		/* BARs enabled */
 };
 
 #define pci_dev_g(n) list_entry(n, struct pci_dev, global_list)
@@ -497,6 +498,7 @@
 void pci_update_resource(struct pci_dev *dev, struct resource *res, int resno);
 int pci_assign_resource(struct pci_dev *dev, int i);
 void pci_restore_bars(struct pci_dev *dev);
+int pci_select_bars(struct pci_dev *dev, unsigned long flags);
 
 /* ROM control related routines */
 void __iomem __must_check *pci_map_rom(struct pci_dev *pdev, size_t *size);
@@ -525,6 +527,8 @@
 void pci_release_regions(struct pci_dev *);
 int pci_request_region(struct pci_dev *, int, const char *);
 void pci_release_region(struct pci_dev *, int);
+int pci_request_selected_regions(struct pci_dev *, int, const char *);
+void pci_release_selected_regions(struct pci_dev *, int);
 
 /* drivers/pci/bus.c */
 int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,

