Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262629AbVHDX0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbVHDX0m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 19:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbVHDX0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 19:26:42 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:59052 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S262629AbVHDX0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 19:26:37 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH] PNPACPI: fix IRQ and 64-bit address decoding
Date: Thu, 4 Aug 2005 17:26:19 -0600
User-Agent: KMail/1.8.1
Cc: Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508041726.19336.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe the third time's the charm :-)  Added a bugfix
(pcibios_penalize_isa_irq()) and a workaround for HP
HPET firmware description since last time.  The workaround
accepts stuff that is illegal according to the spec,
so speak up if you think this is a problem.  It seems
fairly safe to me.



Use types that match the ACPI resource structures.  Previously
the u64 value from an RSTYPE_ADDRESS64 was passed as an int,
which corrupts the value.

Move pcibios_penalize_isa_irq() to pnpacpi_parse_allocated_irqresource().
Previously we passed the GSI, not the IRQ, and we did it even if parsing
the IRQ resource failed.

Parse IRQ descriptors that contain multiple interrupts.  This violates
the spec (in _CRS, only one interrupt per descriptor is allowed), but
some firmware, e.g., HP rx7620 and rx8620 descriptions of HPET, has this
bug.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- work-mm.orig/drivers/pnp/pnpacpi/rsparser.c	2005-08-04 16:41:04.000000000 -0600
+++ work-mm/drivers/pnp/pnpacpi/rsparser.c	2005-08-04 16:42:52.000000000 -0600
@@ -73,25 +73,35 @@
 }
 
 static void
-pnpacpi_parse_allocated_irqresource(struct pnp_resource_table * res, int irq)
+pnpacpi_parse_allocated_irqresource(struct pnp_resource_table * res, u32 gsi,
+	int edge_level, int active_high_low)
 {
 	int i = 0;
+	int irq;
+
+	if (!valid_IRQ(gsi))
+		return;
+
 	while (!(res->irq_resource[i].flags & IORESOURCE_UNSET) &&
 			i < PNP_MAX_IRQ)
 		i++;
-	if (i < PNP_MAX_IRQ) {
-		res->irq_resource[i].flags = IORESOURCE_IRQ;  //Also clears _UNSET flag
-		if (irq < 0) {
-			res->irq_resource[i].flags |= IORESOURCE_DISABLED;
-			return;
-		}
-		res->irq_resource[i].start =(unsigned long) irq;
-		res->irq_resource[i].end = (unsigned long) irq;
+	if (i >= PNP_MAX_IRQ)
+		return;
+
+	res->irq_resource[i].flags = IORESOURCE_IRQ;  // Also clears _UNSET flag
+	irq = acpi_register_gsi(gsi, edge_level, active_high_low);
+	if (irq < 0) {
+		res->irq_resource[i].flags |= IORESOURCE_DISABLED;
+		return;
 	}
+
+	res->irq_resource[i].start = irq;
+	res->irq_resource[i].end = irq;
+	pcibios_penalize_isa_irq(irq, 1);
 }
 
 static void
-pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table * res, int dma)
+pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table * res, u32 dma)
 {
 	int i = 0;
 	while (i < PNP_MAX_DMA &&
@@ -103,14 +113,14 @@
 			res->dma_resource[i].flags |= IORESOURCE_DISABLED;
 			return;
 		}
-		res->dma_resource[i].start =(unsigned long) dma;
-		res->dma_resource[i].end = (unsigned long) dma;
+		res->dma_resource[i].start = dma;
+		res->dma_resource[i].end = dma;
 	}
 }
 
 static void
 pnpacpi_parse_allocated_ioresource(struct pnp_resource_table * res,
-	int io, int len)
+	u32 io, u32 len)
 {
 	int i = 0;
 	while (!(res->port_resource[i].flags & IORESOURCE_UNSET) &&
@@ -122,14 +132,14 @@
 			res->port_resource[i].flags |= IORESOURCE_DISABLED;
 			return;
 		}
-		res->port_resource[i].start = (unsigned long) io;
-		res->port_resource[i].end = (unsigned long)(io + len - 1);
+		res->port_resource[i].start = io;
+		res->port_resource[i].end = io + len - 1;
 	}
 }
 
 static void
 pnpacpi_parse_allocated_memresource(struct pnp_resource_table * res,
-	int mem, int len)
+	u64 mem, u64 len)
 {
 	int i = 0;
 	while (!(res->mem_resource[i].flags & IORESOURCE_UNSET) &&
@@ -141,8 +151,8 @@
 			res->mem_resource[i].flags |= IORESOURCE_DISABLED;
 			return;
 		}
-		res->mem_resource[i].start = (unsigned long) mem;
-		res->mem_resource[i].end = (unsigned long)(mem + len - 1);
+		res->mem_resource[i].start = mem;
+		res->mem_resource[i].end = mem + len - 1;
 	}
 }
 
@@ -151,27 +161,28 @@
 	void *data)
 {
 	struct pnp_resource_table * res_table = (struct pnp_resource_table *)data;
+	int i;
 
 	switch (res->id) {
 	case ACPI_RSTYPE_IRQ:
-		if ((res->data.irq.number_of_interrupts > 0) &&
-			valid_IRQ(res->data.irq.interrupts[0])) {
-			pnpacpi_parse_allocated_irqresource(res_table, 
-				acpi_register_gsi(res->data.irq.interrupts[0],
-					res->data.irq.edge_level,
-					res->data.irq.active_high_low));
-			pcibios_penalize_isa_irq(res->data.irq.interrupts[0], 1);
+		/*
+		 * Per spec, only one interrupt per descriptor is allowed in
+		 * _CRS, but some firmware violates this, so parse them all.
+		 */
+		for (i = 0; i < res->data.irq.number_of_interrupts; i++) {
+			pnpacpi_parse_allocated_irqresource(res_table,
+				res->data.irq.interrupts[i],
+				res->data.irq.edge_level,
+				res->data.irq.active_high_low);
 		}
 		break;
 
 	case ACPI_RSTYPE_EXT_IRQ:
-		if ((res->data.extended_irq.number_of_interrupts > 0) &&
-			valid_IRQ(res->data.extended_irq.interrupts[0])) {
-			pnpacpi_parse_allocated_irqresource(res_table, 
-				acpi_register_gsi(res->data.extended_irq.interrupts[0],
-					res->data.extended_irq.edge_level,
-					res->data.extended_irq.active_high_low));
-			pcibios_penalize_isa_irq(res->data.extended_irq.interrupts[0], 1);
+		for (i = 0; i < res->data.extended_irq.number_of_interrupts; i++) {
+			pnpacpi_parse_allocated_irqresource(res_table,
+				res->data.extended_irq.interrupts[i],
+				res->data.extended_irq.edge_level,
+				res->data.extended_irq.active_high_low);
 		}
 		break;
 	case ACPI_RSTYPE_DMA:
