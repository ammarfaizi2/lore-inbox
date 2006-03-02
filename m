Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWCBPQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWCBPQc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 10:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWCBPQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 10:16:31 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:63376 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751380AbWCBPQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 10:16:31 -0500
Message-ID: <44070BF3.3000706@jp.fujitsu.com>
Date: Fri, 03 Mar 2006 00:14:59 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 1/4] PCI legacy I/O port free driver (take4) - Add no_ioport
 flag into pci_dev
References: <44070B62.3070608@jp.fujitsu.com>
In-Reply-To: <44070B62.3070608@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the no_ioport field into struct pci_dev, which is used
to tell the kernel not to touch any I/O port regions.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

 drivers/pci/pci.c   |   39 ++++++++++++++++++++++++++++++++-------
 include/linux/pci.h |    1 +
 2 files changed, 33 insertions(+), 7 deletions(-)

Index: linux-2.6.16-rc5-mm1/include/linux/pci.h
===================================================================
--- linux-2.6.16-rc5-mm1.orig/include/linux/pci.h	2006-03-01 13:56:06.000000000 +0900
+++ linux-2.6.16-rc5-mm1/include/linux/pci.h	2006-03-01 16:30:56.000000000 +0900
@@ -163,6 +163,7 @@
 	unsigned int	is_busmaster:1; /* device is busmaster */
 	unsigned int	no_msi:1;	/* device may not use msi */
 	unsigned int	block_ucfg_access:1;	/* userspace config space access is blocked */
+	unsigned int	no_ioport:1;	/* device may not use ioport */
 
 	u32		saved_config_space[16]; /* config space saved at suspend time */
 	struct hlist_head saved_cap_space;
Index: linux-2.6.16-rc5-mm1/drivers/pci/pci.c
===================================================================
--- linux-2.6.16-rc5-mm1.orig/drivers/pci/pci.c	2006-03-01 13:56:04.000000000 +0900
+++ linux-2.6.16-rc5-mm1/drivers/pci/pci.c	2006-03-01 16:35:00.000000000 +0900
@@ -507,7 +507,14 @@
 int
 pci_enable_device(struct pci_dev *dev)
 {
-	int err = pci_enable_device_bars(dev, (1 << PCI_NUM_RESOURCES) - 1);
+	int i, err, bars = (1 << PCI_NUM_RESOURCES) - 1;
+
+	if (dev->no_ioport)
+		for (i = 0; i < PCI_NUM_RESOURCES; i++)
+			if (pci_resource_flags(dev, i) & IORESOURCE_IO)
+				bars &= ~(1 << i);
+
+	err = pci_enable_device_bars(dev, bars);
 	if (err)
 		return err;
 	pci_fixup_device(pci_fixup_enable, dev);
@@ -628,9 +635,14 @@
 {
 	if (pci_resource_len(pdev, bar) == 0)
 		return;
-	if (pci_resource_flags(pdev, bar) & IORESOURCE_IO)
+	if (pci_resource_flags(pdev, bar) & IORESOURCE_IO) {
+		if (pdev->no_ioport)
+			dev_warn(&pdev->dev,
+				 "Trying to release PCI I/O region #%d for "
+				 "the device marked I/O resource free\n", bar);
 		release_region(pci_resource_start(pdev, bar),
 				pci_resource_len(pdev, bar));
+	}
 	else if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM)
 		release_mem_region(pci_resource_start(pdev, bar),
 				pci_resource_len(pdev, bar));
@@ -656,6 +668,10 @@
 		return 0;
 		
 	if (pci_resource_flags(pdev, bar) & IORESOURCE_IO) {
+		if (pdev->no_ioport)
+			dev_warn(&pdev->dev,
+				 "Trying to request PCI I/O region #%d for "
+				 "the device marked I/O resource free\n", bar);
 		if (!request_region(pci_resource_start(pdev, bar),
 			    pci_resource_len(pdev, bar), res_name))
 			goto err_out;
@@ -689,10 +705,13 @@
 
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
@@ -710,16 +729,22 @@
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

