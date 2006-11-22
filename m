Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161854AbWKVIFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161854AbWKVIFi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 03:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161859AbWKVIFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 03:05:38 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:26263 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161840AbWKVIFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 03:05:36 -0500
Message-ID: <456404EF.3090902@jp.fujitsu.com>
Date: Wed, 22 Nov 2006 17:06:07 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Cc: Greg KH <greg@kroah.com>, Grant Grundler <grundler@parisc-linux.org>,
       Andrew Morton <akpm@osdl.org>, e1000-devel@lists.sourceforge.net,
       linux-scsi@vger.kernel.org,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH 2/5] PCI : Move pci_fixup_device and is_enabled
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the following changes into generic PCI code especially
for PCI legacy I/O port free drivers.

    - Moved the following two things from pci_enable_device() into
      pci_enable_device_bars(). Already some drivers are using
      pci_enable_device_bars() to enable only the specific regions,
      but they had no chance to be fixup and to up is_enabled flag.

          o Call pci_fixup_device() on the device
          o Checking & Setting dev->is_enabled

    - Trivial cleanup

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

---
 drivers/pci/pci.c |   20 ++++++++------------
 1 files changed, 8 insertions(+), 12 deletions(-)

Index: linux-2.6.19-rc6/drivers/pci/pci.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/pci/pci.c
+++ linux-2.6.19-rc6/drivers/pci/pci.c
@@ -558,12 +558,18 @@
 {
 	int err;

+	if (dev->is_enabled)
+		return 0;
+
 	err = pci_set_power_state(dev, PCI_D0);
 	if (err < 0 && err != -EIO)
 		return err;
 	err = pcibios_enable_device(dev, bars);
 	if (err < 0)
 		return err;
+
+	pci_fixup_device(pci_fixup_enable, dev);
+	dev->is_enabled = 1;
 	return 0;
 }

@@ -578,17 +584,7 @@
 int
 pci_enable_device(struct pci_dev *dev)
 {
-	int err;
-
-	if (dev->is_enabled)
-		return 0;
-
-	err = pci_enable_device_bars(dev, (1 << PCI_NUM_RESOURCES) - 1);
-	if (err)
-		return err;
-	pci_fixup_device(pci_fixup_enable, dev);
-	dev->is_enabled = 1;
-	return 0;
+	return pci_enable_device_bars(dev, (1 << PCI_NUM_RESOURCES) - 1);
 }

 /**
@@ -737,7 +733,7 @@
 {
 	if (pci_resource_len(pdev, bar) == 0)
 		return 0;
-		
+
 	if (pci_resource_flags(pdev, bar) & IORESOURCE_IO) {
 		if (!request_region(pci_resource_start(pdev, bar),
 			    pci_resource_len(pdev, bar), res_name))

