Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274920AbRJALjv>; Mon, 1 Oct 2001 07:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274951AbRJALjl>; Mon, 1 Oct 2001 07:39:41 -0400
Received: from bart.one-2-one.net ([195.94.80.12]:16907 "EHLO
	bart.one-2-one.net") by vger.kernel.org with ESMTP
	id <S274920AbRJALjd>; Mon, 1 Oct 2001 07:39:33 -0400
Date: Mon, 1 Oct 2001 13:42:08 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] yet another yenta resource allocation fix
In-Reply-To: <Pine.LNX.4.21.0110010104290.746-100000@notebook.diehl.home>
Message-ID: <Pine.LNX.4.21.0110011327330.941-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Oct 2001, Martin Diehl wrote:

> On Mon, 1 Oct 2001, Alan Cox wrote:
> 
> > Would a generic
> > 
> > 	pci_fixup_device()
> > 
> > type function not be more appropriate
> 
> IIRC there was some discussion on l-k some time ago, whether such fixups
> should stay close to were the issue appeared or better be placed at
> generic pci quirk location. In this particular case I personally tend to
> the latter one as well, particularly because there may be other BIOS'
> doing similar things with non-cardbus memory bar's.

Just to follow-up myself, seems the general pci-quirk approach is superior
because there is no need to release-modify-reclaim the bad resource when
fixing during pci header scan. Furthermore, there is already a cardbus
specific fixup (disabling legacy registers) in drivers/pci/quirks.c.
So I've just moved and adjusted the stuff to the same location.

Improved patch vs. 2.4.10 below. Successfully tested on my OB-800 where
the "featured" BIOS maps the cardbus bar at 0xe6000.

Regards,
Martin

-------------------------

--- linux-2.4.10/drivers/pci/quirks.c	Sun Sep 30 15:55:13 2001
+++ v2.4.10-md/drivers/pci/quirks.c	Mon Oct  1 12:48:41 2001
@@ -412,6 +412,57 @@
 }
 
 
+/* BIOS might have mapped the cardbus memory resource to a bogus location
+ * in legacy memory area and the hostbridge somehow looses this window
+ * after pm-suspend (seen on OB800).
+ * We try to detect and fix this by re-assigning the resource if we
+ * find it mapped to legacy area <1M. But we don't try, if the obsolete
+ * MEM_TYPE_1M flag is set, just in case...
+ */
+
+static void __init quirk_cardbus_bar(struct pci_dev *dev)
+{
+	unsigned long	oldstart;
+	u32		temp, extend;
+	struct resource	*res;
+
+	if ((PCI_CLASS_BRIDGE_CARDBUS << 8) ^ dev->class)
+		return;
+
+	if (!(dev->resource[0].flags&IORESOURCE_MEM))	/* not cardbus memory BAR */
+		return;
+
+	oldstart = dev->resource[0].start;
+	if (oldstart >= 0x00100000UL)		/* mapped above 1MB legacy area - fine! */
+		return;
+
+	pci_read_config_dword(dev, PCI_BASE_ADDRESS_0, &temp);
+	if (temp & PCI_BASE_ADDRESS_MEM_TYPE_1M) {
+		printk(KERN_DEBUG "%s: cardbus memory has obsolete 1M flag set?\n",
+			__FUNCTION__);
+		return;
+	}
+
+	/* re-read required size and flags from device */
+
+	pci_write_config_dword(dev, PCI_BASE_ADDRESS_0, 0xffffffff);
+	pci_read_config_dword(dev, PCI_BASE_ADDRESS_0, &temp);
+	if (temp & PCI_BASE_ADDRESS_SPACE_IO) {	/* paranoia */
+		pci_write_config_dword(dev, PCI_BASE_ADDRESS_0, oldstart);
+		printk(KERN_WARNING "%s: cardbus memory mutated to io?\n",
+			__FUNCTION__);
+		return;
+	}
+	extend = ~(u32)(temp & PCI_BASE_ADDRESS_MEM_MASK);
+
+	res = &dev->resource[0];
+	res->start = 0;
+	res->end = res->start + extend;
+	res->flags = IORESOURCE_MEM;
+	if (temp & PCI_BASE_ADDRESS_MEM_PREFETCH)
+		res->flags |= IORESOURCE_PREFETCH;
+}
+
 /*
  *  The main table of quirks.
  */
@@ -462,6 +513,7 @@
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C586_2,	quirk_via_irqpic },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_5,	quirk_via_irqpic },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C686_6,	quirk_via_irqpic },
+	{ PCI_FIXUP_HEADER,	PCI_ANY_ID,		PCI_ANY_ID,			quirk_cardbus_bar },
 
 	{ 0 }
 };

