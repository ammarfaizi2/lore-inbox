Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262130AbSLFKh1>; Fri, 6 Dec 2002 05:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbSLFKh1>; Fri, 6 Dec 2002 05:37:27 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:64772 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S262130AbSLFKhZ>; Fri, 6 Dec 2002 05:37:25 -0500
Date: Fri, 6 Dec 2002 13:44:34 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, andre@linux-ide.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: ali15x3 on alpha dies in 2.4.21-BK
Message-ID: <20021206134434.A2626@jurassic.park.msu.ru>
References: <3DF00951.1070104@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DF00951.1070104@pobox.com>; from jgarzik@pobox.com on Thu, Dec 05, 2002 at 09:20:01PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 09:20:01PM -0500, Jeff Garzik wrote:
> ali15x3: not 100% native mode, will probe irqs later
>   ide0: bm-dma at 0x8420-0x8427, bios settings: hda:pio, hdb:pio
>   ide1: bm-dma at 0x8428-0x842f, bios settings: hdc:pio, hdd:pio
> hdc:hdc: status timeout: status=0xff {busy}

Fixed in 2.5-ac two months ago... ;-)

Well, in addition to true legacy and native modes, the ALi chip supports
"intermediate" one which is utterly broken wrt PCI spec.
In this mode
BAR0 = 0x1f1
BAR1 = 0x3f5
BAR2 = 0x171
BAR3 = 0x375

and these BARs are *read-only*. This causes a lot of confusion:
a) sizes calculated by pci_read_bases() for these IO ranges are
   incorrect;
b) generic resource allocation code assumes that these BARs
   can be reassigned, and this actually happens on Alpha.

As there are other PCI devices with the same problem, I prefer
generic solution instead of individual quirk routines.

Here's the patch re-diffed vs. 2.4.

Ivan.

--- 2.4bk/drivers/pci/pci.c	Fri Dec  6 11:07:52 2002
+++ linux/drivers/pci/pci.c	Fri Dec  6 11:09:23 2002
@@ -1039,13 +1039,20 @@ static inline unsigned int pci_calc_reso
 }
 
 /*
- * Find the extent of a PCI decode..
+ * Find the extent of a PCI decode, do sanity checks.
  */
-static u32 pci_size(u32 base, unsigned long mask)
+static u32 pci_size(u32 base, u32 maxbase, unsigned long mask)
 {
-	u32 size = mask & base;		/* Find the significant bits */
+	u32 size = mask & maxbase;	/* Find the significant bits */
+	if (!size)
+		return 0;
 	size = size & ~(size-1);	/* Get the lowest of them to find the decode size */
-	return size-1;			/* extent = size - 1 */
+	size -= 1;			/* extent = size - 1 */
+	if (base == maxbase && ((base | size) & mask) != mask)
+		return 0;		/* base == maxbase can be valid only
+					   if the BAR has been already
+					   programmed with all 1s */
+	return size;
 }
 
 static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
@@ -1068,13 +1075,17 @@ static void pci_read_bases(struct pci_de
 		if (l == 0xffffffff)
 			l = 0;
 		if ((l & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_MEMORY) {
+			sz = pci_size(l, sz, PCI_BASE_ADDRESS_MEM_MASK);
+			if (!sz)
+				continue;
 			res->start = l & PCI_BASE_ADDRESS_MEM_MASK;
 			res->flags |= l & ~PCI_BASE_ADDRESS_MEM_MASK;
-			sz = pci_size(sz, PCI_BASE_ADDRESS_MEM_MASK);
 		} else {
+			sz = pci_size(l, sz, PCI_BASE_ADDRESS_IO_MASK & 0xffff);
+			if (!sz)
+				continue;
 			res->start = l & PCI_BASE_ADDRESS_IO_MASK;
 			res->flags |= l & ~PCI_BASE_ADDRESS_IO_MASK;
-			sz = pci_size(sz, PCI_BASE_ADDRESS_IO_MASK & 0xffff);
 		}
 		res->end = res->start + (unsigned long) sz;
 		res->flags |= pci_calc_resource_flags(l);
@@ -1104,6 +1115,7 @@ static void pci_read_bases(struct pci_de
 	if (rom) {
 		dev->rom_base_reg = rom;
 		res = &dev->resource[PCI_ROM_RESOURCE];
+		res->name = dev->name;
 		pci_read_config_dword(dev, rom, &l);
 		pci_write_config_dword(dev, rom, ~PCI_ROM_ADDRESS_ENABLE);
 		pci_read_config_dword(dev, rom, &sz);
@@ -1111,13 +1123,14 @@ static void pci_read_bases(struct pci_de
 		if (l == 0xffffffff)
 			l = 0;
 		if (sz && sz != 0xffffffff) {
+			sz = pci_size(l, sz, PCI_ROM_ADDRESS_MASK);
+			if (!sz)
+				return;
 			res->flags = (l & PCI_ROM_ADDRESS_ENABLE) |
 			  IORESOURCE_MEM | IORESOURCE_PREFETCH | IORESOURCE_READONLY | IORESOURCE_CACHEABLE;
 			res->start = l & PCI_ROM_ADDRESS_MASK;
-			sz = pci_size(sz, PCI_ROM_ADDRESS_MASK);
 			res->end = res->start + (unsigned long) sz;
 		}
-		res->name = dev->name;
 	}
 }
 
