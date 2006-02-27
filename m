Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWB0Eyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWB0Eyq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 23:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWB0Eyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 23:54:46 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:52683 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750729AbWB0Eyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 23:54:45 -0500
Message-ID: <4402857A.4040801@jp.fujitsu.com>
Date: Mon, 27 Feb 2006 13:52:10 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
CC: Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com>,
       Andi Kleen <ak@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       benh@kernel.crashing.org
Subject: [PATCH 1/4] PCI legacy I/O port free driver (take 3) - Add no_ioport
 flag into pci_dev
References: <44028502.4000108@soft.fujitsu.com>
In-Reply-To: <44028502.4000108@soft.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the no_ioport field into struct pci_dev, which is used
to tell the kernel not to touch any I/O port regions.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

 drivers/pci/pci.c   |   39 +++++++++++++++++++++++++++++++--------
 include/linux/pci.h |    1 +
 2 files changed, 32 insertions(+), 8 deletions(-)

Index: linux-2.6.16-rc4/include/linux/pci.h
===================================================================
--- linux-2.6.16-rc4.orig/include/linux/pci.h	2006-02-27 13:29:34.000000000 +0900
+++ linux-2.6.16-rc4/include/linux/pci.h	2006-02-27 13:29:41.000000000 +0900
@@ -152,6 +152,7 @@
 	unsigned int	is_busmaster:1; /* device is busmaster */
 	unsigned int	no_msi:1;	/* device may not use msi */
 	unsigned int	block_ucfg_access:1;	/* userspace config space access is blocked */
+	unsigned int	no_ioport:1;	/* device may not use ioport */
 
 	u32		saved_config_space[16]; /* config space saved at suspend time */
 	struct bin_attribute *rom_attr; /* attribute descriptor for sysfs ROM entry */
Index: linux-2.6.16-rc4/drivers/pci/pci.c
===================================================================
--- linux-2.6.16-rc4.orig/drivers/pci/pci.c	2006-02-27 13:29:34.000000000 +0900
+++ linux-2.6.16-rc4/drivers/pci/pci.c	2006-02-27 13:29:41.000000000 +0900
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
@@ -617,9 +622,14 @@
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
@@ -645,6 +655,10 @@
 		return 0;
 		
 	if (pci_resource_flags(pdev, bar) & IORESOURCE_IO) {
+		if (pdev->no_ioport)
+			dev_warn(&pdev->dev,
+				 "Trying to request PCI I/O region #%d for "
+				 "the device marked I/O resource free\n", bar);
 		if (!request_region(pci_resource_start(pdev, bar),
 			    pci_resource_len(pdev, bar), res_name))
 			goto err_out;
@@ -678,10 +692,13 @@
 
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
@@ -699,16 +716,22 @@
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

