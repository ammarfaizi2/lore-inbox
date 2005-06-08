Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262203AbVFIAAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbVFIAAA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 20:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262212AbVFHX7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 19:59:31 -0400
Received: from peabody.ximian.com ([130.57.169.10]:16058 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262203AbVFHX4f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 19:56:35 -0400
Subject: Re: PNP parallel&serial ports: module reload fails (2.6.11)?
From: Adam Belay <ambx1@neo.rr.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: matthieu castet <castet.matthieu@free.fr>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <42A75525.3050704@tls.msk.ru>
References: <20050602222400.GA8083@mut38-1-82-67-62-65.fbx.proxad.net>
	 <429FA1F3.9000001@tls.msk.ru> <42A2D37A.5050408@free.fr>
	 <42A46551.9010707@tls.msk.ru> <20050606211855.GA3289@neo.rr.com>
	 <42A4D1AB.3090508@tls.msk.ru>
	 <1118224334.3245.89.camel@localhost.localdomain>
	 <42A75525.3050704@tls.msk.ru>
Content-Type: text/plain
Date: Wed, 08 Jun 2005 19:52:41 -0400
Message-Id: <1118274762.29855.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2005 at 12:29:25AM +0400, Michael Tokarev wrote:
> Adam Belay wrote:
> []
> >>>>[ it's in http://www.corpit.ru/mjt/hpml310.dsdt - apache ships it
> >>>> as Content-Type: text/plain, for some reason.  I grabbed iasl
> >>>> and converted that stuff into .dsls, available at:
> >>>> http://www.corpit.ru/mjt/hpml310.dsl and
> >>>> http://www.corpit.ru/mjt/hpml150.dsl ]
> []
> > Hi,
> > 
> > I'm sorry for the delayed response, as this bug is very difficult to
> > track down.  The information you provided was helpful and I appreciate
> > it.  I have a theory as to what is going on, and the patch below might
> > solve your problem.  If not, it will at least give us some more
> > information.
> 
> Well, not much of info, really.. ;)
> 
> > The following would be useful:
> > 
> > 1.) a complete dmesg after initial boot with the patch
> > 2.) kernel message output after "rmmod parport_pc" and "modprobe
> > parport_pc" with the patch
> 
> Here it is.  From HP ML 150 box.  I compiled 2.6.11-rc6 with
> the patch you've sent.
> 

Sorry, I forgot to set the range length, so it looped in
acpi_rs_list_to_byte_stream forever, instead of making it to _SRS.
This rediff should fix the problem.

Thanks,
Adam

--- a/drivers/pnp/pnpacpi/core.c	2005-03-02 02:38:09.000000000 -0500
+++ b/drivers/pnp/pnpacpi/core.c	2005-06-08 19:37:12.000000000 -0400
@@ -99,17 +99,21 @@
 	int ret = 0;
 	acpi_status status;
 
+	printk (KERN_INFO "pnp: building resource template\n");
 	ret = pnpacpi_build_resource_template(handle, &buffer);
 	if (ret)
 		return ret;
+	printk (KERN_INFO "pnp: encoding resources\n");
 	ret = pnpacpi_encode_resources(res, &buffer);
 	if (ret) {
 		kfree(buffer.pointer);
 		return ret;
 	}
+	printk (KERN_INFO "pnp: setting resources\n");
 	status = acpi_set_current_resources(handle, &buffer);
 	if (ACPI_FAILURE(status))
 		ret = -EINVAL;
+	printk (KERN_INFO "pnp: _SRS worked correctly\n");
 	kfree(buffer.pointer);
 	return ret;
 }
--- a/drivers/pnp/pnpacpi/rsparser.c	2005-05-27 22:06:02.000000000 -0400
+++ b/drivers/pnp/pnpacpi/rsparser.c	2005-06-08 19:38:14.802869256 -0400
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
@@ -625,7 +631,15 @@
 	struct resource *p)
 {
 	int edge_level, active_high_low;
-	
+
+	if (p->flags & IORESOURCE_UNSET) {
+		printk(KERN_INFO "bug squashed - irq\n");
+		resource->id = ACPI_RSTYPE_IRQ;
+		resource->length = sizeof(struct acpi_resource);
+		resource->data.irq.number_of_interrupts = 0;
+		return;
+	}
+
 	decode_irq_flags(p->flags & IORESOURCE_BITS, &edge_level, 
 		&active_high_low);
 	resource->id = ACPI_RSTYPE_IRQ;
@@ -636,6 +650,18 @@
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
@@ -644,6 +670,14 @@
 	struct resource *p)
 {
 	int edge_level, active_high_low;
+
+	if (p->flags & IORESOURCE_UNSET) {
+		printk(KERN_INFO "bug squashed - irq_ext\n");
+		resource->id = ACPI_RSTYPE_EXT_IRQ;
+		resource->length = sizeof(struct acpi_resource);
+		resource->data.extended_irq.number_of_interrupts = 0;
+		return;
+	}
 	
 	decode_irq_flags(p->flags & IORESOURCE_BITS, &edge_level, 
 		&active_high_low);
@@ -663,6 +697,14 @@
 static void pnpacpi_encode_dma(struct acpi_resource *resource,
 	struct resource *p)
 {
+	if (p->flags & IORESOURCE_UNSET) {
+		printk(KERN_INFO "bug squashed - dma \n");
+		resource->id = ACPI_RSTYPE_DMA;
+		resource->length = sizeof(struct acpi_resource);
+		resource->data.dma.number_of_channels = 0;
+		return;
+	}
+
 	resource->id = ACPI_RSTYPE_DMA;
 	resource->length = sizeof(struct acpi_resource);
 	/* Note: pnp_assign_dma will copy pnp_dma->flags into p->flags */
@@ -695,7 +737,6 @@
 		ACPI_DECODE_16 : ACPI_DECODE_10; 
 	resource->data.io.min_base_address = p->start;
 	resource->data.io.max_base_address = p->end;
-	resource->data.io.alignment = 0; /* Correct? */
 	resource->data.io.range_length = p->end - p->start + 1;
 }
 
@@ -719,7 +760,6 @@
 		ACPI_READ_WRITE_MEMORY : ACPI_READ_ONLY_MEMORY;
 	resource->data.memory24.min_base_address = p->start;
 	resource->data.memory24.max_base_address = p->end;
-	resource->data.memory24.alignment = 0;
 	resource->data.memory24.range_length = p->end - p->start + 1;
 }
 
@@ -733,7 +773,6 @@
 		ACPI_READ_WRITE_MEMORY : ACPI_READ_ONLY_MEMORY;
 	resource->data.memory32.min_base_address = p->start;
 	resource->data.memory32.max_base_address = p->end;
-	resource->data.memory32.alignment = 0;
 	resource->data.memory32.range_length = p->end - p->start + 1;
 }
 


