Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261756AbSJCRJy>; Thu, 3 Oct 2002 13:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261758AbSJCRJy>; Thu, 3 Oct 2002 13:09:54 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:16644 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S261756AbSJCRJw>; Thu, 3 Oct 2002 13:09:52 -0400
Date: Thu, 3 Oct 2002 21:15:18 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5.40] PCI: probing read-only BARs
Message-ID: <20021003211518.A1039@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some pci devices may have base address registers locked with non-zero values.
Examples:
- AGP aperture BAR of AMD-7xx host bridges: if the AGP window disabled,
  this BAR is read-only and read as 0x00000008;
- BAR0-4 of ALi IDE controllers can be non-zero and read-only.
Obviously, we can't calculate correct size of the respective region in
this case (for AMD AGP window we'll get 4 GB resource - ouch).
So I think that we should ignore r/o BARs (let the device specific
fixups deal with them if needed).
Patch appended (note that extra write(0)/read-back pair is required,
as the BAR might be programmed with all 1s).

Ivan.

--- 2.5.40/drivers/pci/probe.c	Sat Sep 28 01:49:10 2002
+++ linux/drivers/pci/probe.c	Thu Oct  3 13:26:41 2002
@@ -46,7 +46,7 @@ static u32 pci_size(u32 base, unsigned l
 static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 {
 	unsigned int pos, reg, next;
-	u32 l, sz;
+	u32 l, l0, sz;
 	struct resource *res;
 
 	for(pos=0; pos<howmany; pos = next) {
@@ -55,10 +55,12 @@ static void pci_read_bases(struct pci_de
 		res->name = dev->name;
 		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
 		pci_read_config_dword(dev, reg, &l);
+		pci_write_config_dword(dev, reg, 0);
+		pci_read_config_dword(dev, reg, &l0);
 		pci_write_config_dword(dev, reg, ~0);
 		pci_read_config_dword(dev, reg, &sz);
 		pci_write_config_dword(dev, reg, l);
-		if (!sz || sz == 0xffffffff)
+		if (!sz || sz == 0xffffffff || sz == l0)
 			continue;
 		if (l == 0xffffffff)
 			l = 0;
