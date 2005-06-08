Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbVFHJ43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbVFHJ43 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 05:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbVFHJ43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 05:56:29 -0400
Received: from peabody.ximian.com ([130.57.169.10]:18869 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262144AbVFHJ4K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 05:56:10 -0400
Subject: Re: PNP parallel&serial ports: module reload fails (2.6.11)?
From: Adam Belay <ambx1@neo.rr.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: matthieu castet <castet.matthieu@free.fr>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <42A4D1AB.3090508@tls.msk.ru>
References: <20050602222400.GA8083@mut38-1-82-67-62-65.fbx.proxad.net>
	 <429FA1F3.9000001@tls.msk.ru> <42A2D37A.5050408@free.fr>
	 <42A46551.9010707@tls.msk.ru> <20050606211855.GA3289@neo.rr.com>
	 <42A4D1AB.3090508@tls.msk.ru>
Content-Type: text/plain
Date: Wed, 08 Jun 2005 05:52:13 -0400
Message-Id: <1118224334.3245.89.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-07 at 02:43 +0400, Michael Tokarev wrote:
> Adam Belay wrote:
> 
> Hmm.. Strange I haven't received your email.  Looking at our
> maillog, looks like your host is listed in SORBS DUHL --
> cpe-24-93-172-51.neo.res.rr.com[24.93.172.51].  Is it really
> dynamic IP?  I'm sorry for the noise, but it's a real PITA
> to handle email and spam properly nowadays... ;)

Yeah, it was a dynamic IP :).  I'm sending from a different server this
time.

> 
> > On Mon, Jun 06, 2005 at 07:01:37PM +0400, Michael Tokarev wrote:
> > 
> []
> >>[ it's in http://www.corpit.ru/mjt/hpml310.dsdt - apache ships it
> >>  as Content-Type: text/plain, for some reason.  I grabbed iasl
> >>  and converted that stuff into .dsls, available at:
> >>  http://www.corpit.ru/mjt/hpml310.dsl and
> >>  http://www.corpit.ru/mjt/hpml150.dsl ]
> >>
> []
> > I've been looking into the parport issue.
> > 
> > Your ACPI _PRS method does look a little unusual (and possibly broken), but
> > it might work if we assume that all of the other resources not mentioned are
> > to be disabled.
> 
> Broken - is it a broken bios (so I will ask HP for an update),
> or is it just how things works? ;)

Hi,

I'm sorry for the delayed response, as this bug is very difficult to
track down.  The information you provided was helpful and I appreciate
it.  I have a theory as to what is going on, and the patch below might
solve your problem.  If not, it will at least give us some more
information.

The following would be useful:

1.) a complete dmesg after initial boot with the patch
2.) kernel message output after "rmmod parport_pc" and "modprobe
parport_pc" with the patch

I designed this patch to fix both "hpml150.dsl" and "hpml310.dsl".  If
you have time, could you test it on both platforms?  This is a hack, so
if it works, I'll give a more complete explanation and an official fix.

Thanks,
Adam

--- a/drivers/pnp/pnpacpi/rsparser.c	2005-05-27 22:06:02.000000000 -0400
+++ b/drivers/pnp/pnpacpi/rsparser.c	2005-06-08 05:36:57.410599288 -0400
@@ -178,6 +178,8 @@
 		if (res->data.dma.number_of_channels > 0)
 			pnpacpi_parse_allocated_dmaresource(res_table, 
 					res->data.dma.channels[0]);
+		else
+			printk(KERN_INFO "pnp: skipping dma from _CRS\n");
 		break;
 	case ACPI_RSTYPE_IO:
 		pnpacpi_parse_allocated_ioresource(res_table, 
@@ -242,8 +244,10 @@
 	int i;
 	struct pnp_dma * dma;
 
-	if (p->number_of_channels == 0)
+	if (p->number_of_channels == 0) {
+		printk(KERN_INFO "pnp: broken dma code, fix me\n");
 		return;
+	}
 	dma = pnpacpi_kmalloc(sizeof(struct pnp_dma), GFP_KERNEL);
 	if (!dma)
 		return;
@@ -298,8 +302,10 @@
 	int i;
 	struct pnp_irq * irq;
 	
-	if (p->number_of_interrupts == 0)
+	if (p->number_of_interrupts == 0) {
+		printk(KERN_INFO "pnp: broken irq code, fix me\n");
 		return;
+	}
 	irq = pnpacpi_kmalloc(sizeof(struct pnp_irq), GFP_KERNEL);
 	if (!irq)
 		return;
@@ -625,7 +631,12 @@
 	struct resource *p)
 {
 	int edge_level, active_high_low;
-	
+
+	if (p->flags & IORESOURCE_UNSET) {
+		printk(KERN_INFO "bug squashed - irq\n");
+		return;
+	}
+
 	decode_irq_flags(p->flags & IORESOURCE_BITS, &edge_level, 
 		&active_high_low);
 	resource->id = ACPI_RSTYPE_IRQ;
@@ -636,6 +647,18 @@
 		resource->data.irq.shared_exclusive = ACPI_EXCLUSIVE;
 	else
 		resource->data.irq.shared_exclusive = ACPI_SHARED;
+
+	if (ACPI_EDGE_SENSITIVE == resource->data.irq.edge_level &&
+		ACPI_ACTIVE_HIGH == resource->data.irq.active_high_low &&
+		ACPI_EXCLUSIVE == resource->data.irq.shared_exclusive) {
+		printk(KERN_INFO "pnp: irq flags are correct\n");
+	} else {
+		printk(KERN_INFO "pnp: attempting to fix irq flags\n");
+		resource->data.irq.edge_level = ACPI_EDGE_SENSITIVE;
+		resource->data.irq.active_high_low = ACPI_ACTIVE_HIGH;
+		resource->data.irq.shared_exclusive = ACPI_EXCLUSIVE;
+	}
+
 	resource->data.irq.number_of_interrupts = 1;
 	resource->data.irq.interrupts[0] = p->start;
 }
@@ -644,6 +667,11 @@
 	struct resource *p)
 {
 	int edge_level, active_high_low;
+
+	if (p->flags & IORESOURCE_UNSET) {
+		printk(KERN_INFO "bug squashed - irq_ext\n");
+		return;
+	}
 	
 	decode_irq_flags(p->flags & IORESOURCE_BITS, &edge_level, 
 		&active_high_low);
@@ -663,6 +691,11 @@
 static void pnpacpi_encode_dma(struct acpi_resource *resource,
 	struct resource *p)
 {
+	if (p->flags & IORESOURCE_UNSET) {
+		printk(KERN_INFO "bug squashed - dma \n");
+		return;
+	}
+
 	resource->id = ACPI_RSTYPE_DMA;
 	resource->length = sizeof(struct acpi_resource);
 	/* Note: pnp_assign_dma will copy pnp_dma->flags into p->flags */
@@ -695,7 +728,6 @@
 		ACPI_DECODE_16 : ACPI_DECODE_10; 
 	resource->data.io.min_base_address = p->start;
 	resource->data.io.max_base_address = p->end;
-	resource->data.io.alignment = 0; /* Correct? */
 	resource->data.io.range_length = p->end - p->start + 1;
 }
 
@@ -719,7 +751,6 @@
 		ACPI_READ_WRITE_MEMORY : ACPI_READ_ONLY_MEMORY;
 	resource->data.memory24.min_base_address = p->start;
 	resource->data.memory24.max_base_address = p->end;
-	resource->data.memory24.alignment = 0;
 	resource->data.memory24.range_length = p->end - p->start + 1;
 }
 
@@ -733,7 +764,6 @@
 		ACPI_READ_WRITE_MEMORY : ACPI_READ_ONLY_MEMORY;
 	resource->data.memory32.min_base_address = p->start;
 	resource->data.memory32.max_base_address = p->end;
-	resource->data.memory32.alignment = 0;
 	resource->data.memory32.range_length = p->end - p->start + 1;
 }
 


