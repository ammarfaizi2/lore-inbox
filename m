Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbUC3Gmg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 01:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbUC3Gmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 01:42:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:5823 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262542AbUC3Gl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 01:41:58 -0500
Date: Mon, 29 Mar 2004 22:36:04 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, greg@kroah.com, scott.feldman@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add PCI_DMA_{64,32}BIT constants
Message-Id: <20040329223604.63d981d0.rddunlap@osdl.org>
In-Reply-To: <20040323052305.GA2287@havoc.gtf.org>
References: <20040323052305.GA2287@havoc.gtf.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2004 00:23:05 -0500 Jeff Garzik <jgarzik@pobox.com> wrote:

| 
| Been meaning to do this for ages...
| 
| Another one for the janitors.

>>>Nice, I've pulled this to my pci tree and will forward it on to Linus in
>>>the next round of pci patches after 2.6.5 is out.
>>
>>Yeah well...  in the intervening time, somebody on IRC commented
>>
>>"so what is so PCI-specific about those constants?"
>>
>>They probably ought to be DMA_{32,64}BIT_MASK or somesuch.
> 
> 
> Heh, ok, care to make up another patch for this?  :)


Here's an updated patch, applies to 2.6.5-rc2-bk9.
I left the DMA_xxBIT_MASK defines in linux/pci.h, although
they aren't necessarily PCI-specific.  Would we prefer to
have them in linux/dma-mapping.h ?

--
~Randy


// linux-2.6.5-rc2-bk9
>From <jgarzik@redhat.com>

   Create DMA_{64,32]BIT_MASK constants, for use in passing to
   pci_set_{consistent_}dma_mask().
   Use them in e1000 and ixgb.

diffstat:=
 Documentation/DMA-mapping.txt  |   16 ++++++++--------
 drivers/net/e1000/e1000.h      |    2 --
 drivers/net/e1000/e1000_main.c |    4 ++--
 drivers/net/ixgb/ixgb.h        |    2 --
 drivers/net/ixgb/ixgb_main.c   |    4 ++--
 include/linux/pci.h            |    3 +++
 6 files changed, 15 insertions(+), 16 deletions(-)


diff -Naurp ./drivers/net/ixgb/ixgb.h~dma_mask ./drivers/net/ixgb/ixgb.h
--- ./drivers/net/ixgb/ixgb.h~dma_mask	2004-03-10 18:55:25.000000000 -0800
+++ ./drivers/net/ixgb/ixgb.h	2004-03-29 21:57:18.000000000 -0800
@@ -65,8 +65,6 @@ struct ixgb_adapter;
 #define BAR_0           0
 #define BAR_1           1
 #define BAR_5           5
-#define PCI_DMA_64BIT   0xffffffffffffffffULL
-#define PCI_DMA_32BIT   0x00000000ffffffffULL
 
 #include "ixgb_hw.h"
 #include "ixgb_ee.h"
diff -Naurp ./drivers/net/ixgb/ixgb_main.c~dma_mask ./drivers/net/ixgb/ixgb_main.c
--- ./drivers/net/ixgb/ixgb_main.c~dma_mask	2004-03-10 18:55:23.000000000 -0800
+++ ./drivers/net/ixgb/ixgb_main.c	2004-03-29 22:27:20.000000000 -0800
@@ -308,10 +308,10 @@ ixgb_probe(struct pci_dev *pdev, const s
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
diff -Naurp ./drivers/net/e1000/e1000_main.c~dma_mask ./drivers/net/e1000/e1000_main.c
--- ./drivers/net/e1000/e1000_main.c~dma_mask	2004-03-10 18:55:25.000000000 -0800
+++ ./drivers/net/e1000/e1000_main.c	2004-03-29 22:17:55.000000000 -0800
@@ -383,10 +383,10 @@ e1000_probe(struct pci_dev *pdev,
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
diff -Naurp ./drivers/net/e1000/e1000.h~dma_mask ./drivers/net/e1000/e1000.h
--- ./drivers/net/e1000/e1000.h~dma_mask	2004-03-10 18:55:21.000000000 -0800
+++ ./drivers/net/e1000/e1000.h	2004-03-29 21:57:18.000000000 -0800
@@ -74,8 +74,6 @@
 #define BAR_0		0
 #define BAR_1		1
 #define BAR_5		5
-#define PCI_DMA_64BIT	0xffffffffffffffffULL
-#define PCI_DMA_32BIT	0x00000000ffffffffULL
 
 
 struct e1000_adapter;
diff -Naurp ./include/linux/pci.h~dma_mask ./include/linux/pci.h
--- ./include/linux/pci.h~dma_mask	2004-03-29 21:08:11.000000000 -0800
+++ ./include/linux/pci.h	2004-03-29 21:57:18.000000000 -0800
@@ -362,6 +362,9 @@ enum pci_mmap_state {
 #define PCI_DMA_FROMDEVICE	2
 #define PCI_DMA_NONE		3
 
+#define DMA_64BIT_MASK	0xffffffffffffffffULL
+#define DMA_32BIT_MASK	0x00000000ffffffffULL
+
 #define DEVICE_COUNT_COMPATIBLE	4
 #define DEVICE_COUNT_RESOURCE	12
 
diff -Naurp ./Documentation/DMA-mapping.txt~dma_mask ./Documentation/DMA-mapping.txt
--- ./Documentation/DMA-mapping.txt~dma_mask	2004-03-29 21:08:30.000000000 -0800
+++ ./Documentation/DMA-mapping.txt	2004-03-29 21:57:18.000000000 -0800
@@ -132,7 +132,7 @@ exactly why.
 The standard 32-bit addressing PCI device would do something like
 this:
 
-	if (pci_set_dma_mask(pdev, 0xffffffff)) {
+	if (pci_set_dma_mask(pdev, DMA_32BIT_MASK)) {
 		printk(KERN_WARNING
 		       "mydev: No suitable DMA available.\n");
 		goto ignore_this_device;
@@ -151,9 +151,9 @@ all 64-bits when accessing streaming DMA
 
 	int using_dac;
 
-	if (!pci_set_dma_mask(pdev, 0xffffffffffffffff)) {
+	if (!pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {
 		using_dac = 1;
-	} else if (!pci_set_dma_mask(pdev, 0xffffffff)) {
+	} else if (!pci_set_dma_mask(pdev, DMA_32BIT_MASK)) {
 		using_dac = 0;
 	} else {
 		printk(KERN_WARNING
@@ -166,14 +166,14 @@ the case would look like this:
 
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
@@ -215,7 +215,7 @@ most specific mask.
 
 Here is pseudo-code showing how this might be done:
 
-	#define PLAYBACK_ADDRESS_BITS	0xffffffff
+	#define PLAYBACK_ADDRESS_BITS	DMA_32BIT_MASK
 	#define RECORD_ADDRESS_BITS	0x00ffffff
 
 	struct my_sound_card *card;
