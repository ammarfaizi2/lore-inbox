Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266559AbUA3GEL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 01:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266563AbUA3GEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 01:04:11 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:64900 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S266559AbUA3GEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 01:04:02 -0500
Date: Fri, 30 Jan 2004 00:48:41 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: greg@kroah.com, Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] Remove uneeded resource structures from pci_dev
Message-ID: <20040130004841.GA12473@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, greg@kroah.com,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch remove irq_resource and dma_resource from pci_dev.  It
appears that the serial pci driver depends on irq_resource, however, it may be
broken portions of an old quirk.  I attempted to maintain the existing behavior
while removing irq_resource.  I changed FL_IRQRESOURCE to FL_NOIRQ.  Russell,
could you provide any comments?  irq_resource and dma_resource are most likely
remnants from when pci_dev was shared with pnp.

Thanks,
Adam

This patch has only been tested for compilation.

--- a/drivers/serial/8250_pci.c	2004-01-09 06:59:55.000000000 +0000
+++ b/drivers/serial/8250_pci.c	2004-01-30 00:41:49.000000000 +0000
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
--- a/include/linux/pci.h	2004-01-09 06:59:33.000000000 +0000
+++ b/include/linux/pci.h	2004-01-30 00:09:47.000000000 +0000
@@ -416,8 +416,6 @@
 	 */
 	unsigned int	irq;
 	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
-	struct resource dma_resource[DEVICE_COUNT_DMA];
-	struct resource irq_resource[DEVICE_COUNT_IRQ];
 
 	char *		slot_name;	/* pointer to dev.bus_id */
 
