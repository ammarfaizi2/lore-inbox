Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbUCWFXU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 00:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUCWFXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 00:23:20 -0500
Received: from havoc.gtf.org ([216.162.42.101]:9356 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262003AbUCWFXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 00:23:08 -0500
Date: Tue, 23 Mar 2004 00:23:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Cc: scott.feldman@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH] add PCI_DMA_{64,32}BIT constants
Message-ID: <20040323052305.GA2287@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Been meaning to do this for ages...

Another one for the janitors.

Please do a

	bk pull bk://kernel.bkbits.net/jgarzik/pci-dma-mask-2.6

This will update the following files:

 Documentation/DMA-mapping.txt |   16 ++++++++--------
 drivers/net/e1000/e1000.h     |    2 --
 drivers/net/ixgb/ixgb.h       |    2 --
 include/linux/pci.h           |    3 +++
 4 files changed, 11 insertions(+), 12 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (04/03/23 1.1849)
   Create PCI_DMA_{64,32]BIT constants, for use in passing to
   pci_set_{consistent_}dma_mask().
   
   Use them in e1000 and ixgb.

diff -Nru a/Documentation/DMA-mapping.txt b/Documentation/DMA-mapping.txt
--- a/Documentation/DMA-mapping.txt	Tue Mar 23 00:19:17 2004
+++ b/Documentation/DMA-mapping.txt	Tue Mar 23 00:19:17 2004
@@ -132,7 +132,7 @@
 The standard 32-bit addressing PCI device would do something like
 this:
 
-	if (pci_set_dma_mask(pdev, 0xffffffff)) {
+	if (pci_set_dma_mask(pdev, PCI_DMA_32BIT)) {
 		printk(KERN_WARNING
 		       "mydev: No suitable DMA available.\n");
 		goto ignore_this_device;
@@ -151,9 +151,9 @@
 
 	int using_dac;
 
-	if (!pci_set_dma_mask(pdev, 0xffffffffffffffff)) {
+	if (!pci_set_dma_mask(pdev, PCI_DMA_64BIT)) {
 		using_dac = 1;
-	} else if (!pci_set_dma_mask(pdev, 0xffffffff)) {
+	} else if (!pci_set_dma_mask(pdev, PCI_DMA_32BIT)) {
 		using_dac = 0;
 	} else {
 		printk(KERN_WARNING
@@ -166,14 +166,14 @@
 
 	int using_dac, consistent_using_dac;
 
-	if (!pci_set_dma_mask(pdev, 0xffffffffffffffff)) {
+	if (!pci_set_dma_mask(pdev, PCI_DMA_64BIT)) {
 		using_dac = 1;
 	   	consistent_using_dac = 1;
-		pci_set_consistent_dma_mask(pdev, 0xffffffffffffffff)
-	} else if (!pci_set_dma_mask(pdev, 0xffffffff)) {
+		pci_set_consistent_dma_mask(pdev, PCI_DMA_64BIT);
+	} else if (!pci_set_dma_mask(pdev, PCI_DMA_32BIT)) {
 		using_dac = 0;
 		consistent_using_dac = 0;
-		pci_set_consistent_dma_mask(pdev, 0xffffffff)
+		pci_set_consistent_dma_mask(pdev, PCI_DMA_32BIT);
 	} else {
 		printk(KERN_WARNING
 		       "mydev: No suitable DMA available.\n");
@@ -215,7 +215,7 @@
 
 Here is pseudo-code showing how this might be done:
 
-	#define PLAYBACK_ADDRESS_BITS	0xffffffff
+	#define PLAYBACK_ADDRESS_BITS	PCI_DMA_32BIT
 	#define RECORD_ADDRESS_BITS	0x00ffffff
 
 	struct my_sound_card *card;
diff -Nru a/drivers/net/e1000/e1000.h b/drivers/net/e1000/e1000.h
--- a/drivers/net/e1000/e1000.h	Tue Mar 23 00:19:17 2004
+++ b/drivers/net/e1000/e1000.h	Tue Mar 23 00:19:17 2004
@@ -74,8 +74,6 @@
 #define BAR_0		0
 #define BAR_1		1
 #define BAR_5		5
-#define PCI_DMA_64BIT	0xffffffffffffffffULL
-#define PCI_DMA_32BIT	0x00000000ffffffffULL
 
 
 struct e1000_adapter;
diff -Nru a/drivers/net/ixgb/ixgb.h b/drivers/net/ixgb/ixgb.h
--- a/drivers/net/ixgb/ixgb.h	Tue Mar 23 00:19:17 2004
+++ b/drivers/net/ixgb/ixgb.h	Tue Mar 23 00:19:17 2004
@@ -65,8 +65,6 @@
 #define BAR_0           0
 #define BAR_1           1
 #define BAR_5           5
-#define PCI_DMA_64BIT   0xffffffffffffffffULL
-#define PCI_DMA_32BIT   0x00000000ffffffffULL
 
 #include "ixgb_hw.h"
 #include "ixgb_ee.h"
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Tue Mar 23 00:19:17 2004
+++ b/include/linux/pci.h	Tue Mar 23 00:19:17 2004
@@ -362,6 +362,9 @@
 #define PCI_DMA_FROMDEVICE	2
 #define PCI_DMA_NONE		3
 
+#define PCI_DMA_64BIT	0xffffffffffffffffULL
+#define PCI_DMA_32BIT	0x00000000ffffffffULL
+
 #define DEVICE_COUNT_COMPATIBLE	4
 #define DEVICE_COUNT_RESOURCE	12
 
