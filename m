Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263006AbUDOR3Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 13:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263037AbUDOR2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:28:06 -0400
Received: from mail.kroah.org ([65.200.24.183]:17326 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263148AbUDORYH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:24:07 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and PCI Hotplug update for 2.6.6-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <1082049825923@kroah.com>
Date: Thu, 15 Apr 2004 10:23:45 -0700
Message-Id: <10820498251273@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1692.3.6, 2004/03/30 17:24:37-08:00, greg@kroah.com

Cset exclude: jgarzik@redhat.com|ChangeSet|20040323051558|61282


 Documentation/DMA-mapping.txt |   16 ++++++++--------
 drivers/net/e1000/e1000.h     |    2 ++
 drivers/net/ixgb/ixgb.h       |    2 ++
 include/linux/pci.h           |    3 ---
 4 files changed, 12 insertions(+), 11 deletions(-)


diff -Nru a/Documentation/DMA-mapping.txt b/Documentation/DMA-mapping.txt
--- a/Documentation/DMA-mapping.txt	Thu Apr 15 10:05:23 2004
+++ b/Documentation/DMA-mapping.txt	Thu Apr 15 10:05:23 2004
@@ -132,7 +132,7 @@
 The standard 32-bit addressing PCI device would do something like
 this:
 
-	if (pci_set_dma_mask(pdev, PCI_DMA_32BIT)) {
+	if (pci_set_dma_mask(pdev, 0xffffffff)) {
 		printk(KERN_WARNING
 		       "mydev: No suitable DMA available.\n");
 		goto ignore_this_device;
@@ -151,9 +151,9 @@
 
 	int using_dac;
 
-	if (!pci_set_dma_mask(pdev, PCI_DMA_64BIT)) {
+	if (!pci_set_dma_mask(pdev, 0xffffffffffffffff)) {
 		using_dac = 1;
-	} else if (!pci_set_dma_mask(pdev, PCI_DMA_32BIT)) {
+	} else if (!pci_set_dma_mask(pdev, 0xffffffff)) {
 		using_dac = 0;
 	} else {
 		printk(KERN_WARNING
@@ -166,14 +166,14 @@
 
 	int using_dac, consistent_using_dac;
 
-	if (!pci_set_dma_mask(pdev, PCI_DMA_64BIT)) {
+	if (!pci_set_dma_mask(pdev, 0xffffffffffffffff)) {
 		using_dac = 1;
 	   	consistent_using_dac = 1;
-		pci_set_consistent_dma_mask(pdev, PCI_DMA_64BIT);
-	} else if (!pci_set_dma_mask(pdev, PCI_DMA_32BIT)) {
+		pci_set_consistent_dma_mask(pdev, 0xffffffffffffffff)
+	} else if (!pci_set_dma_mask(pdev, 0xffffffff)) {
 		using_dac = 0;
 		consistent_using_dac = 0;
-		pci_set_consistent_dma_mask(pdev, PCI_DMA_32BIT);
+		pci_set_consistent_dma_mask(pdev, 0xffffffff)
 	} else {
 		printk(KERN_WARNING
 		       "mydev: No suitable DMA available.\n");
@@ -215,7 +215,7 @@
 
 Here is pseudo-code showing how this might be done:
 
-	#define PLAYBACK_ADDRESS_BITS	PCI_DMA_32BIT
+	#define PLAYBACK_ADDRESS_BITS	0xffffffff
 	#define RECORD_ADDRESS_BITS	0x00ffffff
 
 	struct my_sound_card *card;
diff -Nru a/drivers/net/e1000/e1000.h b/drivers/net/e1000/e1000.h
--- a/drivers/net/e1000/e1000.h	Thu Apr 15 10:05:23 2004
+++ b/drivers/net/e1000/e1000.h	Thu Apr 15 10:05:23 2004
@@ -74,6 +74,8 @@
 #define BAR_0		0
 #define BAR_1		1
 #define BAR_5		5
+#define PCI_DMA_64BIT	0xffffffffffffffffULL
+#define PCI_DMA_32BIT	0x00000000ffffffffULL
 
 
 struct e1000_adapter;
diff -Nru a/drivers/net/ixgb/ixgb.h b/drivers/net/ixgb/ixgb.h
--- a/drivers/net/ixgb/ixgb.h	Thu Apr 15 10:05:23 2004
+++ b/drivers/net/ixgb/ixgb.h	Thu Apr 15 10:05:23 2004
@@ -65,6 +65,8 @@
 #define BAR_0           0
 #define BAR_1           1
 #define BAR_5           5
+#define PCI_DMA_64BIT   0xffffffffffffffffULL
+#define PCI_DMA_32BIT   0x00000000ffffffffULL
 
 #include "ixgb_hw.h"
 #include "ixgb_ee.h"
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu Apr 15 10:05:23 2004
+++ b/include/linux/pci.h	Thu Apr 15 10:05:23 2004
@@ -433,9 +433,6 @@
 #define PCI_DMA_FROMDEVICE	2
 #define PCI_DMA_NONE		3
 
-#define PCI_DMA_64BIT	0xffffffffffffffffULL
-#define PCI_DMA_32BIT	0x00000000ffffffffULL
-
 #define DEVICE_COUNT_COMPATIBLE	4
 #define DEVICE_COUNT_RESOURCE	12
 

