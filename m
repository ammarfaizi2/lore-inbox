Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265434AbUBIX6y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265369AbUBIXzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:55:52 -0500
Received: from mail.kroah.org ([65.200.24.183]:63164 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265434AbUBIXWl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:22:41 -0500
Subject: Re: [PATCH] PCI Update for 2.6.3-rc1
In-Reply-To: <10763689351999@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:22:16 -0800
Message-Id: <10763689362321@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500.11.2, 2004/01/30 16:34:48-08:00, ambx1@neo.rr.com

[PATCH] PCI: Remove uneeded resource structures from pci_dev

The following patch remove irq_resource and dma_resource from pci_dev.  It
appears that the serial pci driver depends on irq_resource, however, it may be
broken portions of an old quirk.  I attempted to maintain the existing behavior
while removing irq_resource.  I changed FL_IRQRESOURCE to FL_NOIRQ.  Russell,
could you provide any comments?  irq_resource and dma_resource are most likely
remnants from when pci_dev was shared with pnp.


 drivers/serial/8250_pci.c |   27 ++++++---------------------
 include/linux/pci.h       |    2 --
 2 files changed, 6 insertions(+), 23 deletions(-)


diff -Nru a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
--- a/drivers/serial/8250_pci.c	Mon Feb  9 14:59:44 2004
+++ b/drivers/serial/8250_pci.c	Mon Feb  9 14:59:44 2004
@@ -43,20 +43,12 @@
 #define FL_BASE4		0x0004
 #define FL_GET_BASE(x)		(x & FL_BASE_MASK)
 
-#define FL_IRQ_MASK		(0x0007 << 4)
-#define FL_IRQBASE0		(0x0000 << 4)
-#define FL_IRQBASE1		(0x0001 << 4)
-#define FL_IRQBASE2		(0x0002 << 4)
-#define FL_IRQBASE3		(0x0003 << 4)
-#define FL_IRQBASE4		(0x0004 << 4)
-#define FL_GET_IRQBASE(x)	((x & FL_IRQ_MASK) >> 4)
-
 /* Use successive BARs (PCI base address registers),
    else use offset into some specified BAR */
 #define FL_BASE_BARS		0x0008
 
-/* Use the irq resource table instead of dev->irq */
-#define FL_IRQRESOURCE		0x0080
+/* do not assign an irq */
+#define FL_NOIRQ		0x0080
 
 /* Use the Base address register size to cap number of ports */
 #define FL_REGION_SZ_CAP	0x0100
@@ -850,17 +842,10 @@
 static _INLINE_ int
 get_pci_irq(struct pci_dev *dev, struct pci_board *board, int idx)
 {
-	int base_idx;
-
-	if ((board->flags & FL_IRQRESOURCE) == 0)
-		return dev->irq;
-
-	base_idx = FL_GET_IRQBASE(board->flags);
-
-	if (base_idx > DEVICE_COUNT_IRQ)
+	if (board->flags & FL_NOIRQ)
 		return 0;
-	
-	return dev->irq_resource[base_idx].start;
+	else
+		return dev->irq;
 }
 
 /*
@@ -1314,7 +1299,7 @@
 		.first_offset	= 0x10000,
 	},
 	[pbn_sgi_ioc3] = {
-		.flags		= FL_BASE0|FL_IRQRESOURCE,
+		.flags		= FL_BASE0|FL_NOIRQ,
 		.num_ports	= 1,
 		.base_baud	= 458333,
 		.uart_offset	= 8,
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Mon Feb  9 14:59:44 2004
+++ b/include/linux/pci.h	Mon Feb  9 14:59:44 2004
@@ -416,8 +416,6 @@
 	 */
 	unsigned int	irq;
 	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
-	struct resource dma_resource[DEVICE_COUNT_DMA];
-	struct resource irq_resource[DEVICE_COUNT_IRQ];
 
 	char *		slot_name;	/* pointer to dev.bus_id */
 

