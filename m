Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbTIKVR1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 17:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbTIKVR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 17:17:27 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:32517 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S261489AbTIKVRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 17:17:24 -0400
Date: Thu, 11 Sep 2003 23:18:43 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Russell King <rmk@arm.linux.org.uk>
cc: Jon Fairbairn <Jon.Fairbairn@cl.cam.ac.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Omnibook PCMCIA slots unusable after suspend.
In-Reply-To: <20030910234538.S30046@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0309110828490.16165-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Sep 2003, Russell King wrote:

> On Wed, Sep 10, 2003 at 10:22:32PM +0100, Jon Fairbairn wrote:
> > In short: I'm using an HP Ombibook 800CT, have started using
> > a Carbus PCMCIA network card and am losing the card after
> > suspends.

I had a similar problem with my OB800. It turned out the problem is the 
BIOS maps the yenta memory window into legacy address range below 1MB.
What happens next is the host bridge doesn't restore the access to the 
legacy area on pci. IIRC Linus' comment was it's not the hostbridge's 
fault because mapping pci memory resource to legacy area would be bogus in 
the first place.

> > but after "apm --suspend" I get the same except:
> > 
> > Sep  6 23:23:55 graffito kernel: Socket status: 66012d18
> > ...
> > Sep  6 23:23:55 graffito kernel: Socket status: 2a035c8a
> 
> It looks like the cardbus controller configuration wasn't correctly
> restored.

Yep, this is what happens fo me in the sitation above. And the next time 
one inserts/ejects any card the box dies in interrupt storm because the 
irq cannot be acknoledged.

The patch below is how I work around this issue: fixup to force the kernel 
to forget the bogus mapping and create a new sane one. Works for me since 
ages (2.4-test IIRC). Maybe it would help here too.

Martin

-----------------------

--- linux-2.6.0-test3/drivers/pci/quirks.c	Sat Aug  9 10:01:57 2003
+++ v2.6.0-test3-md-ob/drivers/pci/quirks.c	Sat Aug  9 11:49:26 2003
@@ -490,6 +490,54 @@
 	pci_write_config_dword(dev, PCI_CB_LEGACY_MODE_BASE, 0);
 }
 
+/* BIOS might have mapped the cardbus memory resource to a bogus location
+ * in legacy memory area and the hostbridge somehow loses this window
+ * after pm-suspend (seen on OB800).
+ * We try to detect and fix this by re-assigning the resource if we
+ * find it mapped to legacy area <1M. But we don't try, if the (obsolete)
+ * MEM_TYPE_1M flag is set, just in case...
+ */
+
+static void __devinit quirk_cardbus_map(struct pci_dev *dev)
+{
+	u32		temp, extend;
+	struct resource	*res;
+
+	if (dev->class != (PCI_CLASS_BRIDGE_CARDBUS << 8))
+		return;
+
+	res = &dev->resource[0];
+	if (!(res->flags & IORESOURCE_MEM))
+		return; 		/* not cardbus memory map */
+
+	/* done if already mapped above 1MB legacy area */
+	if (res->start >= 0x00100000UL)
+		return;
+
+	pci_read_config_dword(dev, PCI_BASE_ADDRESS_0, &temp);
+
+	if (temp & PCI_BASE_ADDRESS_MEM_TYPE_64)
+		return;		/* don't touch 64-bit mappings */
+
+	if (temp & PCI_BASE_ADDRESS_MEM_TYPE_1M) {
+		printk(KERN_DEBUG "%s: cardbus memory with obsolete 1M flag\n",
+			__FUNCTION__);
+		return;
+	}
+
+	/* re-read required size and flags from device */
+
+	pci_write_config_dword(dev, PCI_BASE_ADDRESS_0, ~0UL);
+	pci_read_config_dword(dev, PCI_BASE_ADDRESS_0, &temp);
+	extend = ~(u32)(temp & PCI_BASE_ADDRESS_MEM_MASK);
+
+	res->start = 0;			/* will be mapped to new sane location */
+	res->end = res->start + extend;
+	res->flags = IORESOURCE_MEM;
+	if (temp & PCI_BASE_ADDRESS_MEM_PREFETCH)
+		res->flags |= IORESOURCE_PREFETCH;
+}
+
 /*
  * Following the PCI ordering rules is optional on the AMD762. I'm not
  * sure what the designers were smoking but let's not inhale...
@@ -807,6 +855,7 @@
 	{ PCI_FIXUP_HEADER,     PCI_ANY_ID,             PCI_ANY_ID,                     quirk_ide_bases },
 	{ PCI_FIXUP_HEADER,     PCI_VENDOR_ID_VIA,	PCI_ANY_ID,                     quirk_via_bridge },
 	{ PCI_FIXUP_FINAL,	PCI_ANY_ID,		PCI_ANY_ID,			quirk_cardbus_legacy },
+	{ PCI_FIXUP_HEADER,	PCI_ANY_ID,		PCI_ANY_ID,			quirk_cardbus_map },
 
 #ifdef CONFIG_X86_IO_APIC 
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686,	quirk_via_ioapic },

