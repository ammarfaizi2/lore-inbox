Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbVHIXdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbVHIXdF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 19:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbVHIXdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 19:33:04 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:32232 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1750834AbVHIXdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 19:33:02 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] PNPACPI: fix IRQ and 64-bit address decoding
Date: Tue, 9 Aug 2005 17:32:52 -0600
User-Agent: KMail/1.8.1
Cc: Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
References: <200508041726.19336.bjorn.helgaas@hp.com>
In-Reply-To: <200508041726.19336.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_k0T+Cum5+RUg0MY"
Message-Id: <200508091732.52575.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_k0T+Cum5+RUg0MY
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 04 August 2005 5:26 pm, Bjorn Helgaas wrote:
> Maybe the third time's the charm :-)  Added a bugfix
> (pcibios_penalize_isa_irq()) and a workaround for HP
> HPET firmware description since last time.  The workaround
> accepts stuff that is illegal according to the spec,
> so speak up if you think this is a problem.  It seems
> fairly safe to me.

This patch is in 2.6.13-rc5-mm1 as
	pnpacpi-fix-irq-and-64-bit-address-decoding.patch
and it works fine for me.

But plain 2.6.13-rc5, with CONFIG_PNPACPI turned on, hangs
at boot on HP ia64 boxes.  This is because 8250_pnp now
knows about MMIO UARTs, so it tries to poke one using a
64-bit address corrupted by PNPACPI.

CONFIG_PNPACPI is still marked experimental, but we may
want to consider putting the PNPACPI patch in 2.6.14
to fix the hang.

The patch in -mm doesn't apply cleanly, so I rediffed
it against 2.6.13-rc5 and attached it.


--Boundary-00=_k0T+Cum5+RUg0MY
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="pnpacpi"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pnpacpi"

PNPACPI: fix IRQ and 64-bit address decoding

Use types that match the ACPI resource structures.  Previously
the u64 value from an RSTYPE_ADDRESS64 was passed as an int,
which corrupts the value.

Move pcibios_penalize_isa_irq() to pnpacpi_parse_allocated_irqresource().
Previously we passed the GSI, not the IRQ, and we did it even if parsing
the IRQ resource failed.

Parse IRQ descriptors that contain multiple interrupts.  This violates
the spec (in _CRS, only one interrupt per descriptor is allowed), but
some firmware does this.  HP rx7620 and rx8620 HPETs have this bug.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-vga/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- work-vga.orig/drivers/pnp/pnpacpi/rsparser.c	2005-08-09 16:54:57.000000000 -0600
+++ work-vga/drivers/pnp/pnpacpi/rsparser.c	2005-08-09 16:55:50.000000000 -0600
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
-		if (irq == -1) {
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

--Boundary-00=_k0T+Cum5+RUg0MY--
