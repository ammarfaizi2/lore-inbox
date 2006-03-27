Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWC0Fh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWC0Fh6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 00:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWC0Fh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 00:37:58 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:61120 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750707AbWC0Fh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 00:37:57 -0500
Message-ID: <4427799E.1070902@jp.fujitsu.com>
Date: Mon, 27 Mar 2006 14:35:26 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 2.6.16-mm1 1/4] PCI legacy I/O port free driver (take
 6) - Changes to generic PCI code
References: <442382F1.2050300@jp.fujitsu.com>	<44238424.3080500@jp.fujitsu.com> <20060324013626.4e15082d.akpm@osdl.org>
In-Reply-To: <20060324013626.4e15082d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com> wrote:
> 
>>+/*
>> + * This helper routine makes bar mask from the type of resource.
>> + */
>> +static inline int pci_select_bars(struct pci_dev *dev, unsigned long flags)
>> +{
>> +	int i, bars = 0;
>> +	for (i = 0; i < PCI_NUM_RESOURCES; i++)
>> +		if (pci_resource_flags(dev, i) & flags)
>> +			bars |= (1 << i);
>> +	return bars;
>> +}
> 
> 
> Can we please uninline this?
> 

OK. Here is an updated one.

Thanks,
Kenji Kaneshige


This patch adds the following changes into generic PCI code especially
for PCI legacy free drivers.

    - Moved the following two things from pci_enable_device() into
      pci_enable_device_bars(). By this change, we can use
      pci_enable_device_bars() to enable only the specific regions.

          o Call pci_fixup_device() on the device
          o Set dev->is_enabled

    - Added new field 'bars_enabled' into struct pci_device to
      remember which BARs already enabled. This new field is
      initialized at pci_enable_device_bars() time and cleared
      at pci_disable_device() time.
 
    - Changed pci_request_regions()/pci_release_regions() to
      request/release only the regions which have already been
      enabled.

    - Added helper routine pci_select_bars() which makes proper mask
      of BARs from the specified resource type. This would be very
      helpful for users of pci_enable_device_bars().

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 drivers/pci/pci-driver.c |    3 ++-
 drivers/pci/pci.c        |   47 ++++++++++++++++++++++++++++++++++++++++-------
 include/linux/pci.h      |    2 ++
 3 files changed, 44 insertions(+), 8 deletions(-)

Index: linux-2.6.16-mm1/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.16-mm1.orig/drivers/pci/pci-driver.c	2006-03-27 11:58:23.000000000 +0900
+++ linux-2.6.16-mm1/drivers/pci/pci-driver.c	2006-03-27 11:58:25.000000000 +0900
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
Index: linux-2.6.16-mm1/drivers/pci/pci.c
===================================================================
--- linux-2.6.16-mm1.orig/drivers/pci/pci.c	2006-03-27 11:58:23.000000000 +0900
+++ linux-2.6.16-mm1/drivers/pci/pci.c	2006-03-27 13:33:32.000000000 +0900
@@ -493,6 +493,9 @@
 	err = pcibios_enable_device(dev, bars);
 	if (err < 0)
 		return err;
+	pci_fixup_device(pci_fixup_enable, dev);
+	dev->is_enabled = 1;
+	dev->bars_enabled = bars;
 	return 0;
 }
 
@@ -510,8 +513,6 @@
 	int err = pci_enable_device_bars(dev, (1 << PCI_NUM_RESOURCES) - 1);
 	if (err)
 		return err;
-	pci_fixup_device(pci_fixup_enable, dev);
-	dev->is_enabled = 1;
 	return 0;
 }
 
@@ -546,6 +547,7 @@
 
 	pcibios_disable_device(dev);
 	dev->is_enabled = 0;
+	dev->bars_enabled = 0;
 }
 
 /**
@@ -628,6 +630,12 @@
 {
 	if (pci_resource_len(pdev, bar) == 0)
 		return;
+	if (!(pdev->bars_enabled & (1 << bar))) {
+		dev_warn(&pdev->dev,
+			 "Trying to release region #%d that is not enabled\n",
+			 bar + 1);
+		return;
+	}
 	if (pci_resource_flags(pdev, bar) & IORESOURCE_IO)
 		release_region(pci_resource_start(pdev, bar),
 				pci_resource_len(pdev, bar));
@@ -654,7 +662,12 @@
 {
 	if (pci_resource_len(pdev, bar) == 0)
 		return 0;
-		
+	if (!(pdev->bars_enabled & (1 << bar))) {
+		dev_warn(&pdev->dev,
+			 "Trying to request region #%d that is not enabled\n",
+			 bar + 1);
+		goto err_out;
+	}
 	if (pci_resource_flags(pdev, bar) & IORESOURCE_IO) {
 		if (!request_region(pci_resource_start(pdev, bar),
 			    pci_resource_len(pdev, bar), res_name))
@@ -692,7 +705,8 @@
 	int i;
 	
 	for (i = 0; i < 6; i++)
-		pci_release_region(pdev, i);
+		if (pdev->bars_enabled & (1 << i))
+			pci_release_region(pdev, i);
 }
 
 /**
@@ -713,13 +727,15 @@
 	int i;
 	
 	for (i = 0; i < 6; i++)
-		if(pci_request_region(pdev, i, res_name))
-			goto err_out;
+		if (pdev->bars_enabled & (1 << i))
+			if(pci_request_region(pdev, i, res_name))
+				goto err_out;
 	return 0;
 
 err_out:
 	while(--i >= 0)
-		pci_release_region(pdev, i);
+		if (pdev->bars_enabled & (1 << i))
+			pci_release_region(pdev, i);
 		
 	return -EBUSY;
 }
@@ -894,6 +910,22 @@
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
@@ -951,6 +983,7 @@
 EXPORT_SYMBOL(pci_set_consistent_dma_mask);
 EXPORT_SYMBOL(pci_assign_resource);
 EXPORT_SYMBOL(pci_find_parent_resource);
+EXPORT_SYMBOL(pci_select_bars);
 
 EXPORT_SYMBOL(pci_set_power_state);
 EXPORT_SYMBOL(pci_save_state);
Index: linux-2.6.16-mm1/include/linux/pci.h
===================================================================
--- linux-2.6.16-mm1.orig/include/linux/pci.h	2006-03-27 11:58:23.000000000 +0900
+++ linux-2.6.16-mm1/include/linux/pci.h	2006-03-27 12:13:43.000000000 +0900
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
