Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbUDOSmb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 14:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUDORbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:31:47 -0400
Received: from mail.kroah.org ([65.200.24.183]:21166 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263141AbUDORYO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:24:14 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and PCI Hotplug update for 2.6.6-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <10820498251273@kroah.com>
Date: Thu, 15 Apr 2004 10:23:45 -0700
Message-Id: <1082049825687@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1692.3.7, 2004/03/30 17:26:44-08:00, rddunlap@osdl.org

[PATCH] PCI: add DMA_{64,32}BIT constants

On Tue, 23 Mar 2004 00:23:05 -0500 Jeff Garzik <jgarzik@pobox.com> wrote:
>>Yeah well...  in the intervening time, somebody on IRC commented
>>
>>"so what is so PCI-specific about those constants?"
>>
>>They probably ought to be DMA_{32,64}BIT_MASK or somesuch.

Here's an updated patch, applies to 2.6.5-rc2-bk9.
I left the DMA_xxBIT_MASK defines in linux/pci.h, although
they aren't necessarily PCI-specific.  Would we prefer to
have them in linux/dma-mapping.h ?


 Documentation/DMA-mapping.txt  |   16 ++++++++--------
 drivers/net/e1000/e1000.h      |    2 --
 drivers/net/e1000/e1000_main.c |    4 ++--
 drivers/net/ixgb/ixgb.h        |    2 --
 drivers/net/ixgb/ixgb_main.c   |    4 ++--
 include/linux/pci.h            |    3 +++
 6 files changed, 15 insertions(+), 16 deletions(-)


diff -Nru a/Documentation/DMA-mapping.txt b/Documentation/DMA-mapping.txt
--- a/Documentation/DMA-mapping.txt	Thu Apr 15 10:05:07 2004
+++ b/Documentation/DMA-mapping.txt	Thu Apr 15 10:05:07 2004
@@ -132,7 +132,7 @@
 The standard 32-bit addressing PCI device would do something like
 this:
 
-	if (pci_set_dma_mask(pdev, 0xffffffff)) {
+	if (pci_set_dma_mask(pdev, DMA_32BIT_MASK)) {
 		printk(KERN_WARNING
 		       "mydev: No suitable DMA available.\n");
 		goto ignore_this_device;
@@ -151,9 +151,9 @@
 
 	int using_dac;
 
-	if (!pci_set_dma_mask(pdev, 0xffffffffffffffff)) {
+	if (!pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {
 		using_dac = 1;
-	} else if (!pci_set_dma_mask(pdev, 0xffffffff)) {
+	} else if (!pci_set_dma_mask(pdev, DMA_32BIT_MASK)) {
 		using_dac = 0;
 	} else {
 		printk(KERN_WARNING
@@ -166,14 +166,14 @@
 
 	int using_dac, consistent_using_dac;
 
-	if (!pci_set_dma_mask(pdev, 0xffffffffffffffff)) {
+	if (!pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {
 		using_dac = 1;
 	   	consistent_using_dac = 1;
-		pci_set_consistent_dma_mask(pdev, 0xffffffffffffffff)
-	} else if (!pci_set_dma_mask(pdev, 0xffffffff)) {
+		pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
+	} else if (!pci_set_dma_mask(pdev, DMA_32BIT_MASK)) {
 		using_dac = 0;
 		consistent_using_dac = 0;
-		pci_set_consistent_dma_mask(pdev, 0xffffffff)
+		pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
 	} else {
 		printk(KERN_WARNING
 		       "mydev: No suitable DMA available.\n");
@@ -215,7 +215,7 @@
 
 Here is pseudo-code showing how this might be done:
 
-	#define PLAYBACK_ADDRESS_BITS	0xffffffff
+	#define PLAYBACK_ADDRESS_BITS	DMA_32BIT_MASK
 	#define RECORD_ADDRESS_BITS	0x00ffffff
 
 	struct my_sound_card *card;
diff -Nru a/drivers/net/e1000/e1000.h b/drivers/net/e1000/e1000.h
--- a/drivers/net/e1000/e1000.h	Thu Apr 15 10:05:07 2004
+++ b/drivers/net/e1000/e1000.h	Thu Apr 15 10:05:07 2004
@@ -74,8 +74,6 @@
 #define BAR_0		0
 #define BAR_1		1
 #define BAR_5		5
-#define PCI_DMA_64BIT	0xffffffffffffffffULL
-#define PCI_DMA_32BIT	0x00000000ffffffffULL
 
 
 struct e1000_adapter;
diff -Nru a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
--- a/drivers/net/e1000/e1000_main.c	Thu Apr 15 10:05:07 2004
+++ b/drivers/net/e1000/e1000_main.c	Thu Apr 15 10:05:07 2004
@@ -383,10 +383,10 @@
 	if((err = pci_enable_device(pdev)))
 		return err;
 
-	if(!(err = pci_set_dma_mask(pdev, PCI_DMA_64BIT))) {
+	if(!(err = pci_set_dma_mask(pdev, DMA_64BIT_MASK))) {
 		pci_using_dac = 1;
 	} else {
-		if((err = pci_set_dma_mask(pdev, PCI_DMA_32BIT))) {
+		if((err = pci_set_dma_mask(pdev, DMA_32BIT_MASK))) {
 			E1000_ERR("No usable DMA configuration, aborting\n");
 			return err;
 		}
diff -Nru a/drivers/net/ixgb/ixgb.h b/drivers/net/ixgb/ixgb.h
--- a/drivers/net/ixgb/ixgb.h	Thu Apr 15 10:05:07 2004
+++ b/drivers/net/ixgb/ixgb.h	Thu Apr 15 10:05:07 2004
@@ -65,8 +65,6 @@
 #define BAR_0           0
 #define BAR_1           1
 #define BAR_5           5
-#define PCI_DMA_64BIT   0xffffffffffffffffULL
-#define PCI_DMA_32BIT   0x00000000ffffffffULL
 
 #include "ixgb_hw.h"
 #include "ixgb_ee.h"
diff -Nru a/drivers/net/ixgb/ixgb_main.c b/drivers/net/ixgb/ixgb_main.c
--- a/drivers/net/ixgb/ixgb_main.c	Thu Apr 15 10:05:07 2004
+++ b/drivers/net/ixgb/ixgb_main.c	Thu Apr 15 10:05:07 2004
@@ -308,10 +308,10 @@
 		return i;
 	}
 
-	if (!(i = pci_set_dma_mask(pdev, PCI_DMA_64BIT))) {
+	if (!(i = pci_set_dma_mask(pdev, DMA_64BIT_MASK))) {
 		pci_using_dac = 1;
 	} else {
-		if ((i = pci_set_dma_mask(pdev, PCI_DMA_32BIT))) {
+		if ((i = pci_set_dma_mask(pdev, DMA_32BIT_MASK))) {
 			IXGB_ERR("No usable DMA configuration, aborting\n");
 			return i;
 		}
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu Apr 15 10:05:07 2004
+++ b/include/linux/pci.h	Thu Apr 15 10:05:07 2004
@@ -433,6 +433,9 @@
 #define PCI_DMA_FROMDEVICE	2
 #define PCI_DMA_NONE		3
 
+#define DMA_64BIT_MASK	0xffffffffffffffffULL
+#define DMA_32BIT_MASK	0x00000000ffffffffULL
+
 #define DEVICE_COUNT_COMPATIBLE	4
 #define DEVICE_COUNT_RESOURCE	12
 

