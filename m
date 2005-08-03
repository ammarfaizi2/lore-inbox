Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262395AbVHCS3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbVHCS3W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 14:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbVHCS3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 14:29:22 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:27617 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S262395AbVHCS3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 14:29:20 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [ACPI] [PATCH] PNPACPI: fix types when decoding ACPI resources [resend]
Date: Wed, 3 Aug 2005 12:29:05 -0600
User-Agent: KMail/1.8.1
Cc: Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <200508020955.54844.bjorn.helgaas@hp.com> <42F0185A.7060901@jp.fujitsu.com>
In-Reply-To: <42F0185A.7060901@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508031229.05343.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 August 2005 7:05 pm, Kenji Kaneshige wrote:
> This breaks the following patch that is already included into -mm
> tree.
> 
> http://sourceforge.net/mailarchive/forum.php?thread_id=7844247&forum_id=6102
> 
> I think we need to check if acpi_register_gsi() succeeded or not.

You're absolutely right.  I was just based off a Linus tree, non -mm,
and didn't notice that your patch conflicted.  How about the following
(based on 2.6.13-rc4-mm1)?  I moved the acpi_register_gsi() into
pnpacpi_parse_allocated_irqresource(), which I think is nice because
the test for failure is right next to the call.



PNPACPI: fix types when decoding ACPI resources

Use types that match the ACPI resource structures.  Previously
the u64 value from an RSTYPE_ADDRESS64 was passed as an int,
which corrupts the value.

This is one of the things that prevents 8250_pnp from working
on HP ia64 boxes.  After 8250_pnp works, we will be able to
remove 8250_acpi.c.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- work-mm.orig/drivers/pnp/pnpacpi/rsparser.c	2005-08-02 09:39:25.000000000 -0600
+++ work-mm/drivers/pnp/pnpacpi/rsparser.c	2005-08-03 09:31:05.000000000 -0600
@@ -73,25 +73,28 @@
 }
 
 static void
-pnpacpi_parse_allocated_irqresource(struct pnp_resource_table * res, int irq)
+pnpacpi_parse_allocated_irqresource(struct pnp_resource_table * res, u32 gsi,
+	int edge_level, int active_high_low)
 {
 	int i = 0;
+	int irq;
 	while (!(res->irq_resource[i].flags & IORESOURCE_UNSET) &&
 			i < PNP_MAX_IRQ)
 		i++;
 	if (i < PNP_MAX_IRQ) {
 		res->irq_resource[i].flags = IORESOURCE_IRQ;  //Also clears _UNSET flag
+		irq = acpi_register_gsi(gsi, edge_level, active_high_low);
 		if (irq < 0) {
 			res->irq_resource[i].flags |= IORESOURCE_DISABLED;
 			return;
 		}
-		res->irq_resource[i].start =(unsigned long) irq;
-		res->irq_resource[i].end = (unsigned long) irq;
+		res->irq_resource[i].start = irq;
+		res->irq_resource[i].end = irq;
 	}
 }
 
 static void
-pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table * res, int dma)
+pnpacpi_parse_allocated_dmaresource(struct pnp_resource_table * res, u32 dma)
 {
 	int i = 0;
 	while (i < PNP_MAX_DMA &&
@@ -103,14 +106,14 @@
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
@@ -122,14 +125,14 @@
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
@@ -141,8 +144,8 @@
 			res->mem_resource[i].flags |= IORESOURCE_DISABLED;
 			return;
 		}
-		res->mem_resource[i].start = (unsigned long) mem;
-		res->mem_resource[i].end = (unsigned long)(mem + len - 1);
+		res->mem_resource[i].start = mem;
+		res->mem_resource[i].end = mem + len - 1;
 	}
 }
 
@@ -156,10 +159,10 @@
 	case ACPI_RSTYPE_IRQ:
 		if ((res->data.irq.number_of_interrupts > 0) &&
 			valid_IRQ(res->data.irq.interrupts[0])) {
-			pnpacpi_parse_allocated_irqresource(res_table, 
-				acpi_register_gsi(res->data.irq.interrupts[0],
-					res->data.irq.edge_level,
-					res->data.irq.active_high_low));
+			pnpacpi_parse_allocated_irqresource(res_table,
+				res->data.irq.interrupts[0],
+				res->data.irq.edge_level,
+				res->data.irq.active_high_low);
 			pcibios_penalize_isa_irq(res->data.irq.interrupts[0], 1);
 		}
 		break;
@@ -167,10 +170,10 @@
 	case ACPI_RSTYPE_EXT_IRQ:
 		if ((res->data.extended_irq.number_of_interrupts > 0) &&
 			valid_IRQ(res->data.extended_irq.interrupts[0])) {
-			pnpacpi_parse_allocated_irqresource(res_table, 
-				acpi_register_gsi(res->data.extended_irq.interrupts[0],
-					res->data.extended_irq.edge_level,
-					res->data.extended_irq.active_high_low));
+			pnpacpi_parse_allocated_irqresource(res_table,
+				res->data.extended_irq.interrupts[0],
+				res->data.extended_irq.edge_level,
+				res->data.extended_irq.active_high_low);
 			pcibios_penalize_isa_irq(res->data.extended_irq.interrupts[0], 1);
 		}
 		break;
