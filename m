Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130164AbRAMOFq>; Sat, 13 Jan 2001 09:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130157AbRAMOFf>; Sat, 13 Jan 2001 09:05:35 -0500
Received: from styx.suse.cz ([195.70.145.226]:47349 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129983AbRAMOF2>;
	Sat, 13 Jan 2001 09:05:28 -0500
Date: Sat, 13 Jan 2001 15:00:46 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
Message-ID: <20010113150046.E1155@suse.cz>
In-Reply-To: <20010112212427.A2829@suse.cz> <Pine.LNX.4.10.10101121604080.8097-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101121604080.8097-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Jan 12, 2001 at 04:09:22PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 12, 2001 at 04:09:22PM -0800, Linus Torvalds wrote:

> On Fri, 12 Jan 2001, Vojtech Pavlik wrote:
> > 
> > However - Alan's IDE patch for 2.2 kills autodma on ALL VIA chipsets.
> > That's because all VIA chipsets starting from vt82c586 to vt82c686b
> > (UDMA100), share the same PCI ID.
> > 
> > Would you prefer to filter just vt82c586 and vt82c586a as the comment in
> > Alan's code says or simply unconditionally kill autodma on all of VIA
> > chipsets, as Alan's code does?
> 
> Right now, for 2.4.1, I'd rather have the patch to just do the same as
> 2.2.x. We can figure it out better when we get a better idea of exactly
> what the bug is, and whether there is some other work-around, and whether
> it is 100% certain that it is just those two controllers (maybe the other
> ones are buggy too, but the 2.2.x tests basically cured their symptoms too
> and peopl ehaven't reported them because they are "fixed").
> 
> 		Linus

Ok, here goes the patch.

Note that with this patch, all VIA users will get IDE transferrates
about 3 MB/sec as opposed to about 20 MB/sec without it (and with
UDMA66). 

This patch disables automatic DMA on all VIA chipsets, including the
ancient 82c561 for 486's, and up to the 686a UDMA66 chipset.

Also note that enabling the DMA later with hdparm -X66 -d1 or similar
command is not safe, and usually works by pure luck on VIA chipsets.
This however, would need some non-minor changes to the generic code to
fix.

But perhaps it's still worth ...

-- 
Vojtech Pavlik
SuSE Labs

--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via-no-autodma.diff"

diff -urN linux-old/drivers/ide/ide-pci.c linux/drivers/ide/ide-pci.c
--- linux-old/drivers/ide/ide-pci.c	Wed Jan  3 01:58:45 2001
+++ linux/drivers/ide/ide-pci.c	Sat Jan 13 14:54:53 2001
@@ -663,7 +663,9 @@
 		if (IDE_PCI_DEVID_EQ(d->devid, DEVID_SIS5513) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_AEC6260) ||
 		    IDE_PCI_DEVID_EQ(d->devid, DEVID_PIIX4NX) ||
-		    IDE_PCI_DEVID_EQ(d->devid, DEVID_HPT34X))
+		    IDE_PCI_DEVID_EQ(d->devid, DEVID_HPT34X)  ||
+		    IDE_PCI_DEVID_EQ(d->devid, DEVID_VIA_IDE) ||
+		    IDE_PCI_DEVID_EQ(d->devid, DEVID_VP_IDE))
 			autodma = 0;
 		if (autodma)
 			hwif->autodma = 1;
diff -urN linux-old/drivers/ide/via82cxxx.c linux/drivers/ide/via82cxxx.c
--- linux-old/drivers/ide/via82cxxx.c	Tue Nov  7 20:02:24 2000
+++ linux/drivers/ide/via82cxxx.c	Sat Jan 13 14:52:26 2001
@@ -602,7 +602,6 @@
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (hwif->dma_base) {
 		hwif->dmaproc = &via82cxxx_dmaproc;
-		hwif->autodma = 1;
 	}
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 }

--mP3DRpeJDSE+ciuQ--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
