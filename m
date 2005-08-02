Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVHBP7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVHBP7Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 11:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVHBP6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 11:58:07 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:42695 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S261600AbVHBP4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 11:56:04 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH] PNPACPI: fix types when decoding ACPI resources [resend]
Date: Tue, 2 Aug 2005 09:55:54 -0600
User-Agent: KMail/1.8.1
Cc: Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508020955.54844.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any objections to the patch below?  I posted it last Wednesday,
but haven't heard anything.  Once we have this fix, 8250_pnp
should have sufficient functionality that we can get rid of
8250_acpi.



Use types that match the ACPI resource structures.  Previously
the u64 value from an RSTYPE_ADDRESS64 was passed as an int,
which corrupts the value.

This is one of the things that prevents 8250_pnp from working
on HP ia64 boxes.  After 8250_pnp works, we will be able to
remove 8250_acpi.c.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work/drivers/pnp/pnpacpi/rsparser.c
===================================================================
--- work.orig/drivers/pnp/pnpacpi/rsparser.c	2005-07-25 15:04:26.000000000 -0600
+++ work/drivers/pnp/pnpacpi/rsparser.c	2005-07-27 10:02:19.000000000 -0600
@@ -73,7 +73,7 @@
 }
 
 static void
-pnpacpi_parse_allocated_irqresource(struct pnp_resource_table * res, int irq)
+pnpacpi_parse_allocated_irqresource(struct pnp_resource_table * res, u32 irq)
 {
 	int i = 0;
 	while (!(res->irq_resource[i].flags & IORESOURCE_UNSET) &&
@@ -85,13 +85,13 @@
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
@@ -103,14 +103,14 @@
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
@@ -122,14 +122,14 @@
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
@@ -141,8 +141,8 @@
 			res->mem_resource[i].flags |= IORESOURCE_DISABLED;
 			return;
 		}
-		res->mem_resource[i].start = (unsigned long) mem;
-		res->mem_resource[i].end = (unsigned long)(mem + len - 1);
+		res->mem_resource[i].start = mem;
+		res->mem_resource[i].end = mem + len - 1;
 	}
 }
 
