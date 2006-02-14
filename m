Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030393AbWBNGJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbWBNGJR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 01:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030423AbWBNGJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 01:09:17 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:62881 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030393AbWBNGJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 01:09:16 -0500
Message-ID: <43F17379.8010900@jp.fujitsu.com>
Date: Tue, 14 Feb 2006 15:06:49 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [RFC][PATCH 1/4] PCI legacy I/O port free driver - Introduce pci_set_bar_mask*()
References: <43F172BA.1020405@jp.fujitsu.com>
In-Reply-To: <43F172BA.1020405@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a new interface pci_select_resource() for PCI
device drivers to tell kernel what resources they want to use. This
interface enables some PCI device drivers to handle the devices even
if no I/O resources are allocated to the devices.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

 drivers/pci/pci.c   |   14 +++++++++-----
 drivers/pci/probe.c |    1 +
 include/linux/pci.h |   15 +++++++++++++++
 3 files changed, 25 insertions(+), 5 deletions(-)

Index: linux-2.6.16-rc3/drivers/pci/pci.c
===================================================================
--- linux-2.6.16-rc3.orig/drivers/pci/pci.c	2006-02-14 12:25:10.000000000 +0900
+++ linux-2.6.16-rc3/drivers/pci/pci.c	2006-02-14 12:27:59.000000000 +0900
@@ -497,7 +497,7 @@
 {
 	int err;
 
-	if ((err = pci_enable_device_bars(dev, (1 << PCI_NUM_RESOURCES) - 1)))
+	if ((err = pci_enable_device_bars(dev, dev->bar_mask)))
 		return err;
 	pci_fixup_device(pci_fixup_enable, dev);
 	dev->is_enabled = 1;
@@ -535,6 +535,7 @@
 
 	pcibios_disable_device(dev);
 	dev->is_enabled = 0;
+	pci_set_bar_mask(dev, (1 << PCI_NUM_RESOURCES) - 1);
 }
 
 /**
@@ -681,7 +682,8 @@
 	int i;
 	
 	for (i = 0; i < 6; i++)
-		pci_release_region(pdev, i);
+		if (pdev->bar_mask & (1 << i))
+			pci_release_region(pdev, i);
 }
 
 /**
@@ -702,13 +704,15 @@
 	int i;
 	
 	for (i = 0; i < 6; i++)
-		if(pci_request_region(pdev, i, res_name))
-			goto err_out;
+		if (pdev->bar_mask & (1 << i))
+			if (pci_request_region(pdev, i, res_name))
+				goto err_out;
 	return 0;
 
 err_out:
 	while(--i >= 0)
-		pci_release_region(pdev, i);
+		if (pdev->bar_mask & (1 << i))
+			pci_release_region(pdev, i);
 		
 	return -EBUSY;
 }
Index: linux-2.6.16-rc3/drivers/pci/probe.c
===================================================================
--- linux-2.6.16-rc3.orig/drivers/pci/probe.c	2006-02-14 12:25:10.000000000 +0900
+++ linux-2.6.16-rc3/drivers/pci/probe.c	2006-02-14 12:27:59.000000000 +0900
@@ -803,6 +803,7 @@
 	dev->vendor = l & 0xffff;
 	dev->device = (l >> 16) & 0xffff;
 	dev->cfg_size = pci_cfg_space_size(dev);
+	pci_set_bar_mask(dev, (1 << PCI_NUM_RESOURCES) - 1);
 
 	/* Assume 32-bit PCI; let 64-bit PCI cards (which are far rarer)
 	   set this higher, assuming the system even supports it.  */
Index: linux-2.6.16-rc3/include/linux/pci.h
===================================================================
--- linux-2.6.16-rc3.orig/include/linux/pci.h	2006-02-14 12:25:13.000000000 +0900
+++ linux-2.6.16-rc3/include/linux/pci.h	2006-02-14 12:27:59.000000000 +0900
@@ -143,6 +143,7 @@
 	 */
 	unsigned int	irq;
 	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
+	int		bar_mask;	/* bitmask of BAR's to be enabled */
 
 	/* These fields are used by common fixups */
 	unsigned int	transparent:1;	/* Transparent PCI bridge */
@@ -695,6 +696,20 @@
 }
 #endif /* HAVE_ARCH_PCI_RESOURCE_TO_USER */
 
+static inline void pci_set_bar_mask(struct pci_dev *dev, int mask)
+{
+	dev->bar_mask = mask;
+}
+
+static inline void pci_set_bar_mask_by_resource(struct pci_dev *dev,
+						unsigned long mask)
+{
+	int i, bar_mask = 0;
+	for (i = 0; i < PCI_NUM_RESOURCES; i++)
+		if (pci_resource_flags(dev, i) & mask)
+			bar_mask |= (1 << i);
+	pci_set_bar_mask(dev, bar_mask);
+}
 
 /*
  *  The world is not perfect and supplies us with broken PCI devices.



