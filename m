Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161407AbWBUGaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161407AbWBUGaO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 01:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161410AbWBUGaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 01:30:13 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:45751 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161407AbWBUGaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 01:30:11 -0500
Message-ID: <43FAB2F1.5030106@jp.fujitsu.com>
Date: Tue, 21 Feb 2006 15:28:01 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, greg@kroah.com
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, ak@suse.de,
       rmk+lkml@arm.linux.org.uk
Subject: [PATCH 1/6] PCI legacy I/O port free driver (take2) - Add no_ioport
 flag into pci_dev
References: <43FAB283.8090206@jp.fujitsu.com>
In-Reply-To: <43FAB283.8090206@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the no_ioport field into struct pci_dev, which is used
to tell the kernel not to touch any I/O port regions.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

 drivers/pci/pci.c   |   33 +++++++++++++++++++++++++--------
 include/linux/pci.h |    1 +
 2 files changed, 26 insertions(+), 8 deletions(-)

Index: linux-2.6.16-rc4/include/linux/pci.h
===================================================================
--- linux-2.6.16-rc4.orig/include/linux/pci.h	2006-02-21 14:40:46.000000000 +0900
+++ linux-2.6.16-rc4/include/linux/pci.h	2006-02-21 14:40:54.000000000 +0900
@@ -152,6 +152,7 @@
 	unsigned int	is_busmaster:1; /* device is busmaster */
 	unsigned int	no_msi:1;	/* device may not use msi */
 	unsigned int	block_ucfg_access:1;	/* userspace config space access is blocked */
+	unsigned int	no_ioport:1;	/* device may not use ioport */
 
 	u32		saved_config_space[16]; /* config space saved at suspend time */
 	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
Index: linux-2.6.16-rc4/drivers/pci/pci.c
===================================================================
--- linux-2.6.16-rc4.orig/drivers/pci/pci.c	2006-02-21 14:40:46.000000000 +0900
+++ linux-2.6.16-rc4/drivers/pci/pci.c	2006-02-21 14:40:54.000000000 +0900
@@ -495,9 +495,14 @@
 int
 pci_enable_device(struct pci_dev *dev)
 {
-	int err;
+	int err, i, bars = (1 << PCI_NUM_RESOURCES) - 1;
 
-	if ((err = pci_enable_device_bars(dev, (1 << PCI_NUM_RESOURCES) - 1)))
+	if (dev->no_ioport)
+		for (i = 0; i < PCI_NUM_RESOURCES; i++)
+			if (pci_resource_flags(dev, i) & IORESOURCE_IO)
+				bars &= ~(1 << i);
+
+	if ((err = pci_enable_device_bars(dev, bars)))
 		return err;
 	pci_fixup_device(pci_fixup_enable, dev);
 	dev->is_enabled = 1;
@@ -617,9 +622,11 @@
 {
 	if (pci_resource_len(pdev, bar) == 0)
 		return;
-	if (pci_resource_flags(pdev, bar) & IORESOURCE_IO)
+	if (pci_resource_flags(pdev, bar) & IORESOURCE_IO) {
+		WARN_ON(pdev->no_ioport);
 		release_region(pci_resource_start(pdev, bar),
 				pci_resource_len(pdev, bar));
+	}
 	else if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM)
 		release_mem_region(pci_resource_start(pdev, bar),
 				pci_resource_len(pdev, bar));
@@ -645,6 +652,7 @@
 		return 0;
 		
 	if (pci_resource_flags(pdev, bar) & IORESOURCE_IO) {
+		WARN_ON(pdev->no_ioport);
 		if (!request_region(pci_resource_start(pdev, bar),
 			    pci_resource_len(pdev, bar), res_name))
 			goto err_out;
@@ -678,10 +686,13 @@
 
 void pci_release_regions(struct pci_dev *pdev)
 {
-	int i;
+	int i, no_ioport = pdev->no_ioport;
 	
-	for (i = 0; i < 6; i++)
+	for (i = 0; i < 6; i++) {
+		if (no_ioport && (pci_resource_flags(pdev, i) & IORESOURCE_IO))
+			continue;
 		pci_release_region(pdev, i);
+	}
 }
 
 /**
@@ -699,16 +710,22 @@
  */
 int pci_request_regions(struct pci_dev *pdev, char *res_name)
 {
-	int i;
+	int i, no_ioport = pdev->no_ioport;
 	
-	for (i = 0; i < 6; i++)
+	for (i = 0; i < 6; i++) {
+		if (no_ioport && (pci_resource_flags(pdev, i) & IORESOURCE_IO))
+			continue;
 		if(pci_request_region(pdev, i, res_name))
 			goto err_out;
+	}
 	return 0;
 
 err_out:
-	while(--i >= 0)
+	while(--i >= 0) {
+		if (no_ioport && (pci_resource_flags(pdev, i) & IORESOURCE_IO))
+			continue;
 		pci_release_region(pdev, i);
+	}
 		
 	return -EBUSY;
 }


