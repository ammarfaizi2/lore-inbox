Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWCGF6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWCGF6J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 00:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWCGF6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 00:58:09 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:27858 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750804AbWCGF6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 00:58:08 -0500
Message-ID: <440D208F.2020202@jp.fujitsu.com>
Date: Tue, 07 Mar 2006 14:56:31 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 1/4] PCI legacy I/O port free driver (take5) - changes to
 generic PCI code
References: <440D1FEC.1070701@jp.fujitsu.com>
In-Reply-To: <440D1FEC.1070701@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
 drivers/pci/pci.c        |   30 +++++++++++++++++++++++-------
 include/linux/pci.h      |   12 ++++++++++++
 3 files changed, 37 insertions(+), 8 deletions(-)

Index: linux-2.6.16-rc5-mm2/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.16-rc5-mm2.orig/drivers/pci/pci-driver.c	2006-03-07 13:45:33.000000000 +0900
+++ linux-2.6.16-rc5-mm2/drivers/pci/pci-driver.c	2006-03-07 13:45:39.000000000 +0900
@@ -294,7 +294,8 @@
 	pci_restore_state(pci_dev);
 	/* if the device was enabled before suspend, reenable */
 	if (pci_dev->is_enabled)
-		retval = pci_enable_device(pci_dev);
+		retval = pci_enable_device_bars(pci_dev,
+						pci_dev->bars_enabled);
 	/* if the device was busmaster before the suspend, make it busmaster again */
 	if (pci_dev->is_busmaster)
 		pci_set_master(pci_dev);
Index: linux-2.6.16-rc5-mm2/drivers/pci/pci.c
===================================================================
--- linux-2.6.16-rc5-mm2.orig/drivers/pci/pci.c	2006-03-07 13:45:33.000000000 +0900
+++ linux-2.6.16-rc5-mm2/drivers/pci/pci.c	2006-03-07 14:07:09.000000000 +0900
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
Index: linux-2.6.16-rc5-mm2/include/linux/pci.h
===================================================================
--- linux-2.6.16-rc5-mm2.orig/include/linux/pci.h	2006-03-07 13:45:33.000000000 +0900
+++ linux-2.6.16-rc5-mm2/include/linux/pci.h	2006-03-07 13:45:39.000000000 +0900
@@ -169,6 +169,7 @@
 	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
 	int rom_attr_enabled;		/* has display of the rom attribute been enabled? */
 	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
+	int	bars_enabled;		/* BARs enabled */
 };
 
 #define pci_dev_g(n) list_entry(n, struct pci_dev, global_list)
@@ -732,6 +733,17 @@
 }
 #endif /* HAVE_ARCH_PCI_RESOURCE_TO_USER */
 
+/*
+ * This helper routine makes bar mask from the type of resource.
+ */
+static inline int pci_select_bars(struct pci_dev *dev, unsigned long flags)
+{
+	int i, bars = 0;
+	for (i = 0; i < PCI_NUM_RESOURCES; i++)
+		if (pci_resource_flags(dev, i) & flags)
+			bars |= (1 << i);
+	return bars;
+}
 
 /*
  *  The world is not perfect and supplies us with broken PCI devices.

