Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVBTHGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVBTHGu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 02:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVBTHGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 02:06:49 -0500
Received: from fire.osdl.org ([65.172.181.4]:8672 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261628AbVBTHGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 02:06:43 -0500
Date: Sat, 19 Feb 2005 23:06:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: IBM Thinkpad G41 PCMCIA problems [Was: Yenta TI: ... no PCI
 interrupts. Fish. Please report.]
In-Reply-To: <Pine.LNX.4.58.0502192201380.14927@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0502192255160.14927@ppc970.osdl.org>
References: <1108858971.8413.147.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0502191648110.14176@ppc970.osdl.org> 
 <1108863372.8413.158.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0502191757170.14706@ppc970.osdl.org>
 <1108870731.8413.163.camel@localhost.localdomain>
 <Pine.LNX.4.58.0502192201380.14927@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 Feb 2005, Linus Torvalds wrote:
> 
> Does a patch like this (instead of your version) work for you? It removes
> the Intel quirk entirely, and replaces it with the "if there's no
> resource, use the parent resource as the default fallback" code.

Here's a very very slightly changed patch. The only addition is to make 
the extra line of

	b->resource[2] = &iomem_resource;

which makes the root PCI device have "iomem_resource" for both it's 
prefetchable and non-prefetchable resource. That's damn subtle, but it 
means that it the non-prefetchable one is overridden by a half-transparent 
setup like I have, then in order to see a prefetchable area at all, you 
want that root iomem_resource to "shine through" the transparent 
prefetchable region.

Andrew, I think this should be tested in -mm. I think it will fix Stevens 
laptop, and the more I think about it, the more convinced I am that is it 
the RightThing to do.. But it could easily break something subtle.

		Linus

----
===== arch/i386/pci/fixup.c 1.24 vs edited =====
--- 1.24/arch/i386/pci/fixup.c	2005-01-11 16:42:41 -08:00
+++ edited/arch/i386/pci/fixup.c	2005-02-19 22:21:42 -08:00
@@ -197,23 +197,6 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8367_0, pci_fixup_via_northbridge_bug);
 
 /*
- * For some reasons Intel decided that certain parts of their
- * 815, 845 and some other chipsets must look like PCI-to-PCI bridges
- * while they are obviously not. The 82801 family (AA, AB, BAM/CAM,
- * BA/CA/DB and E) PCI bridges are actually HUB-to-PCI ones, according
- * to Intel terminology. These devices do forward all addresses from
- * system to PCI bus no matter what are their window settings, so they are
- * "transparent" (or subtractive decoding) from programmers point of view.
- */
-static void __devinit pci_fixup_transparent_bridge(struct pci_dev *dev)
-{
-	if ((dev->class >> 8) == PCI_CLASS_BRIDGE_PCI &&
-	    (dev->device & 0xff00) == 0x2400)
-		dev->transparent = 1;
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_fixup_transparent_bridge);
-
-/*
  * Fixup for C1 Halt Disconnect problem on nForce2 systems.
  *
  * From information provided by "Allen Martin" <AMartin@nvidia.com>:
===== drivers/pci/probe.c 1.78 vs edited =====
--- 1.78/drivers/pci/probe.c	2005-02-02 22:42:24 -08:00
+++ edited/drivers/pci/probe.c	2005-02-19 22:44:24 -08:00
@@ -241,17 +241,20 @@
 	if (!dev)		/* It's a host bus, nothing to read */
 		return;
 
+	/*
+	 * We default to the parent resources, and override them only
+	 * if this device has its own range defined.
+	 */
+	for(i = 0; i < PCI_BUS_NUM_RESOURCES; i++)
+		child->resource[i] = child->parent->resource[i];
+
 	if (dev->transparent) {
 		printk(KERN_INFO "PCI: Transparent bridge - %s\n", pci_name(dev));
-		for(i = 0; i < PCI_BUS_NUM_RESOURCES; i++)
-			child->resource[i] = child->parent->resource[i];
 		return;
 	}
 
-	for(i=0; i<3; i++)
-		child->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES+i];
-
-	res = child->resource[0];
+	/* Resource 0 - IO ports */
+	res = &dev->resource[PCI_BRIDGE_RESOURCES+0];
 	pci_read_config_byte(dev, PCI_IO_BASE, &io_base_lo);
 	pci_read_config_byte(dev, PCI_IO_LIMIT, &io_limit_lo);
 	base = (io_base_lo & PCI_IO_RANGE_MASK) << 8;
@@ -269,9 +272,11 @@
 		res->flags = (io_base_lo & PCI_IO_RANGE_TYPE_MASK) | IORESOURCE_IO;
 		res->start = base;
 		res->end = limit + 0xfff;
+		child->resource[0] = res;
 	}
 
-	res = child->resource[1];
+	/* Resource 1 - nonprefetchable memory resource */
+	res = &dev->resource[PCI_BRIDGE_RESOURCES+1];
 	pci_read_config_word(dev, PCI_MEMORY_BASE, &mem_base_lo);
 	pci_read_config_word(dev, PCI_MEMORY_LIMIT, &mem_limit_lo);
 	base = (mem_base_lo & PCI_MEMORY_RANGE_MASK) << 16;
@@ -280,9 +285,11 @@
 		res->flags = (mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) | IORESOURCE_MEM;
 		res->start = base;
 		res->end = limit + 0xfffff;
+		child->resource[1] = res;
 	}
 
-	res = child->resource[2];
+	/* Resource 2 - prefetchable memory resource */
+	res = &dev->resource[PCI_BRIDGE_RESOURCES+2];
 	pci_read_config_word(dev, PCI_PREF_MEMORY_BASE, &mem_base_lo);
 	pci_read_config_word(dev, PCI_PREF_MEMORY_LIMIT, &mem_limit_lo);
 	base = (mem_base_lo & PCI_PREF_RANGE_MASK) << 16;
@@ -314,6 +321,7 @@
 		res->flags = (mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) | IORESOURCE_MEM | IORESOURCE_PREFETCH;
 		res->start = base;
 		res->end = limit + 0xfffff;
+		child->resource[2] = res;
 	}
 }
 
@@ -912,6 +920,7 @@
 	b->number = b->secondary = bus;
 	b->resource[0] = &ioport_resource;
 	b->resource[1] = &iomem_resource;
+	b->resource[2] = &iomem_resource;
 
 	b->subordinate = pci_scan_child_bus(b);
 
