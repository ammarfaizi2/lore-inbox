Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270081AbUJTHGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270081AbUJTHGo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 03:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270080AbUJSXJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:09:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:59017 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269904AbUJSWqS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:18 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257393394@kroah.com>
Date: Tue, 19 Oct 2004 15:42:19 -0700
Message-Id: <1098225739880@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.59, 2004/10/06 14:02:56-07:00, greg@kroah.com

[PATCH] PCI: remove all usages of pci_dma_sync_single as it's obsolete.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/atm/idt77252.c                    |   13 +++++++------
 drivers/net/wireless/prism54/islpci_mgt.c |    4 ++--
 drivers/scsi/megaraid/megaraid_mbox.c     |    4 ++--
 include/linux/pci.h                       |    5 +----
 4 files changed, 12 insertions(+), 14 deletions(-)


diff -Nru a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
--- a/drivers/atm/idt77252.c	2004-10-19 15:22:14 -07:00
+++ b/drivers/atm/idt77252.c	2004-10-19 15:22:14 -07:00
@@ -1266,8 +1266,9 @@
 	head = IDT77252_PRV_PADDR(queue) + (queue->data - queue->head - 16);
 	tail = readl(SAR_REG_RAWCT);
 
-	pci_dma_sync_single(card->pcidev, IDT77252_PRV_PADDR(queue),
-			    queue->end - queue->head - 16, PCI_DMA_FROMDEVICE);
+	pci_dma_sync_single_for_cpu(card->pcidev, IDT77252_PRV_PADDR(queue),
+				    queue->end - queue->head - 16,
+				    PCI_DMA_FROMDEVICE);
 
 	while (head != tail) {
 		unsigned int vpi, vci, pti;
@@ -1360,10 +1361,10 @@
 			if (next) {
 				card->raw_cell_head = next;
 				queue = card->raw_cell_head;
-				pci_dma_sync_single(card->pcidev,
-						    IDT77252_PRV_PADDR(queue),
-						    queue->end - queue->data,
-						    PCI_DMA_FROMDEVICE);
+				pci_dma_sync_single_for_cpu(card->pcidev,
+							    IDT77252_PRV_PADDR(queue),
+							    queue->end - queue->data,
+							    PCI_DMA_FROMDEVICE);
 			} else {
 				card->raw_cell_head = NULL;
 				printk("%s: raw cell queue overrun\n",
diff -Nru a/drivers/net/wireless/prism54/islpci_mgt.c b/drivers/net/wireless/prism54/islpci_mgt.c
--- a/drivers/net/wireless/prism54/islpci_mgt.c	2004-10-19 15:22:14 -07:00
+++ b/drivers/net/wireless/prism54/islpci_mgt.c	2004-10-19 15:22:14 -07:00
@@ -319,8 +319,8 @@
 		}
 
 		/* Ensure the results of device DMA are visible to the CPU. */
-		pci_dma_sync_single(priv->pdev, buf->pci_addr,
-				    buf->size, PCI_DMA_FROMDEVICE);
+		pci_dma_sync_single_for_cpu(priv->pdev, buf->pci_addr,
+					    buf->size, PCI_DMA_FROMDEVICE);
 
 		/* Perform endianess conversion for PIMFOR header in-place. */
 		header = pimfor_decode_header(buf->mem, frag_len);
diff -Nru a/drivers/scsi/megaraid/megaraid_mbox.c b/drivers/scsi/megaraid/megaraid_mbox.c
--- a/drivers/scsi/megaraid/megaraid_mbox.c	2004-10-19 15:22:14 -07:00
+++ b/drivers/scsi/megaraid/megaraid_mbox.c	2004-10-19 15:22:14 -07:00
@@ -1554,7 +1554,7 @@
 
 	if (scb->dma_direction == PCI_DMA_TODEVICE) {
 		if (!scb->scp->use_sg) {	// sg list not used
-			pci_dma_sync_single(adapter->pdev, ccb->buf_dma_h,
+			pci_dma_sync_single_for_cpu(adapter->pdev, ccb->buf_dma_h,
 					scb->scp->request_bufflen,
 					PCI_DMA_TODEVICE);
 		}
@@ -2332,7 +2332,7 @@
 
 	case MRAID_DMA_WBUF:
 		if (scb->dma_direction == PCI_DMA_FROMDEVICE) {
-			pci_dma_sync_single(adapter->pdev,
+			pci_dma_sync_single_for_cpu(adapter->pdev,
 					ccb->buf_dma_h,
 					scb->scp->request_bufflen,
 					PCI_DMA_FROMDEVICE);
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2004-10-19 15:22:14 -07:00
+++ b/include/linux/pci.h	2004-10-19 15:22:14 -07:00
@@ -1,5 +1,5 @@
 /*
- *	$Id: pci.h,v 1.87 1998/10/11 15:13:12 mj Exp $
+ *	pci.h
  *
  *	PCI defines and function prototypes
  *	Copyright 1994, Drew Eckhardt
@@ -857,9 +857,6 @@
 /* Include architecture-dependent settings and functions */
 
 #include <asm/pci.h>
-
-/* Backwards compat, remove in 2.7.x */
-#define pci_dma_sync_single	pci_dma_sync_single_for_cpu
 
 /*
  *  If the system does not have PCI, clearly these return errors.  Define

