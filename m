Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVBTGv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVBTGv0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 01:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVBTGv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 01:51:26 -0500
Received: from fire.osdl.org ([65.172.181.4]:27358 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261665AbVBTGvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 01:51:12 -0500
Date: Sat, 19 Feb 2005 22:51:26 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>
Subject: Re: IBM Thinkpad G41 PCMCIA problems [Was: Yenta TI: ... no PCI
 interrupts. Fish. Please report.]
In-Reply-To: <1108870731.8413.163.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0502192201380.14927@ppc970.osdl.org>
References: <1108858971.8413.147.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0502191648110.14176@ppc970.osdl.org> 
 <1108863372.8413.158.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0502191757170.14706@ppc970.osdl.org>
 <1108870731.8413.163.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 Feb 2005, Steven Rostedt wrote:
>
> +	    /* the 2448 bridge is not transparent */
> +	    dev->device != 0x2448)

Btw, I've got a laptop with the exact same bridge chip PCI ID (well, mine
is "rev 83", while yours claims to be "rev 81"), and mine definitely _is_ 
transparent.

On my machine, "lspci -vvn -s 0:1e.0" gives:

        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: 90000000-901fffff
        Prefetchable memory behind bridge: fff00000-000fffff

ie the IO and prefetchable memory ranges have actually been _disabled_
(that is, if we actually care about the PCI specs), yet it definitely
forwards them.

It looks to me like the Intel bridges have this magic behaviour where if 
you disable a range, it turns into a subtractive decode.

Now, that's not hard to handle, and in fact, making the PCI bridge 
handling in Linux match that kind of behaviour actually simplifies some 
code.

Does a patch like this (instead of your version) work for you? It removes
the Intel quirk entirely, and replaces it with the "if there's no
resource, use the parent resource as the default fallback" code.

This seems to work on my laptop, which has the "transparent" case
(actually, it's "interesting" on my laptop, since it's only
half-transparent after this change: the non-prefetchable range is now put
in the 0x90000000 area).

Does it work for the non-transparent case too? It should, but..

Damn. I think this might be the right thing to do, but I also suspect it's 
not worth doing for 2.6.11, if only because it needs more testing. In 
particular, the partial transparency case is a bit unnerving.

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
+++ edited/drivers/pci/probe.c	2005-02-19 22:16:33 -08:00
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
 
