Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266745AbUHMSRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266745AbUHMSRb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 14:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266545AbUHMSRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 14:17:31 -0400
Received: from albireo.ucw.cz ([81.27.203.89]:45956 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S266775AbUHMSRZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 14:17:25 -0400
Date: Fri, 13 Aug 2004 20:17:25 +0200
From: Martin Mares <mj@ucw.cz>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Message-ID: <20040813181725.GD5685@ucw.cz>
References: <88056F38E9E48644A0F562A38C64FB600296D33C@scsmsx403.amr.corp.intel.com> <20040812022229.23100.qmail@web14929.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040812022229.23100.qmail@web14929.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Just a couple of notes about your patch:

+unsigned char *
+pci_map_rom(struct pci_dev *dev, size_t *size) {
+	struct resource *res = &dev->resource[PCI_ROM_RESOURCE];
+	loff_t start;
+	unsigned char *rom;
+	
+	if (res->flags & PCI_ROM_SHADOW) {	/* PCI_ROM_SHADOW only set on x86 */
+		start = (loff_t)0xC0000; 	/* primary video rom always starts here */
+		*size = 0x20000;		/* cover C000:0 through E000:0 */

Shouldn't we do this only if we find that the device has a ROM resource?

+	} else if (res->flags & PCI_ROM_COPY) {
+		*size = pci_resource_len(dev, PCI_ROM_RESOURCE);
+		return (unsigned char *)pci_resource_start(dev, PCI_ROM_RESOURCE);
+	} else {
+		start = pci_resource_start(dev, PCI_ROM_RESOURCE);
+		*size = pci_resource_len(dev, PCI_ROM_RESOURCE);
+		if (*size == 0)
+			return NULL;
+		
+		/* Enable ROM space decodes */
+		pci_enable_rom(dev);
+	}

This seems to be wrong -- before enabling a resource, you must call
request_resource() on it and make sure that the ROM (1) has an address
allocated, and (2) the address is not used by anything else.

+	/* If the device has a ROM, try to expose it in sysfs. */
+	if (pci_resource_len(pdev, PCI_ROM_RESOURCE)) {
+		unsigned char *rom;
+		struct bin_attribute *rom_attr;
+		
+		pdev->rom_attr = NULL;
+		rom_attr = kmalloc(sizeof(*rom_attr), GFP_ATOMIC);
+		if (rom_attr) {
+			/* set default size */
+			rom_attr->size = pci_resource_len(pdev, PCI_ROM_RESOURCE);
+			/* get true size if possible */
+			rom = pci_map_rom(pdev, &rom_attr->size);

As we can never be sure about the decoder sharing, it is very wise not to
touch the ROM BAR until somebody accesses the sysfs file. Using size according
to the PCI config space (i.e., the resource) does not harm anybody.

+	if (dev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
+		res = &dev->resource[PCI_ROM_RESOURCE];
+		if (res->flags & PCI_ROM_COPY) {
+			kfree((void*)res->start);
+			res->flags &= !PCI_ROM_COPY;

~, not !

+			res->start = 0;
+			res->end = 0;
+		}
+	}

This should better be handled in a separate function in the same source
file as the rest of the ROM handling code.

Also, what about ROMs in the other header types? Wouldn't it be better to
scan all resources for the COPY flag instead?

 #define PCI_SUBSYSTEM_ID	0x2e  
 #define PCI_ROM_ADDRESS		0x30	/* Bits 31..11 are address, 10..1 reserved */
 #define  PCI_ROM_ADDRESS_ENABLE	0x01
+#define  PCI_ROM_SHADOW		0x02	/* resource flag, ROM is copy at C000:0 */
+#define  PCI_ROM_COPY		0x04	/* resource flag, ROM is alloc'd copy */
 #define PCI_ROM_ADDRESS_MASK	(~0x7ffUL)

This does not belong here! This part of pci.h describes the configuration
space, not stuff internal to the kernel. Better introduce a new resource
flag in <linux/ioport.h>.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"Oh no, not again!"  -- The bowl of petunias
