Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265139AbUADDSa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 22:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265136AbUADDSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 22:18:30 -0500
Received: from esperance.ozonline.com.au ([203.23.159.248]:52168 "EHLO
	ozonline.com.au") by vger.kernel.org with ESMTP id S265130AbUADDSZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 22:18:25 -0500
Date: Sun, 4 Jan 2004 14:21:41 +1100
From: Davin McCall <davmac@ozonline.com.au>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] fix issues with loading PCI ide drivers as modules
 (linux 2.6.0)
Message-Id: <20040104142141.2bf4f230.davmac@ozonline.com.au>
In-Reply-To: <200401040256.57419.bzolnier@elka.pw.edu.pl>
References: <20040103152802.6e27f5c5.davmac@ozonline.com.au>
	<200401040256.57419.bzolnier@elka.pw.edu.pl>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jan 2004 02:56:57 +0100
Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:

> Are you aware that your change brakes "idex=base", "idex=base,ctl"
> and "idex=base,ctl,irq" kernel parameters?  If these parameters are used
> hwif->chipset is also set to ide_generic.  Now if controller is a PCI one
> and PCI IDE support is compiled in hwif->chipset will be set to
> ide_pci_takeover and drives won't be probed.

Ok. I see the problem.

> When it fails controller+drives are not being programmed correctly
> (because probe_hwif() returns early).  "takeover" is not supported because
> you need to reprogram controller/drive to do DMA, but probing code
> (which does also reprogramming) can race with actual data transfer.

... So basically, it's not nearly as simple as I had hoped.

However, there are still two genuine but easily solveable problems that I can see:

1) unless "idex=base,ctl,irq" is used, the hwif->chipset is left as "ide_unknown"
   (this means for that the hwif can get re-allocated in setup-pci.c - ide_match_hwif() -
    and clobbered)
2) if "idex=base,ctl,irq" IS used, the hwif structure will still get clobbered when a PCI
   chipset module is loaded.

What about this is a solution to these problems:
 - set hwif->chipset to "ide_generic" instead of leaving it as "ide_unknown" (ide-probe.c);
 - if ide_match_hwif() returns an already allocated hwif, do not clobber it in ide_hwif_configure() (setup-pci.c)

Two individual patches below; again any comments appreciated!

Davin



--- ide-probe.c.orig	Sun Jan  4 14:17:22 2004
+++ ide-probe.c	Sun Jan  4 13:58:44 2004
@@ -1343,6 +1343,7 @@
 			int unit;
 			if (!hwif->present)
 				continue;
+			if (hwif->chipset == ide_unknown) hwif_chipset = ide_generic;
 			for (unit = 0; unit < MAX_DRIVES; ++unit)
 				if (hwif->drives[unit].present)
 					ata_attach(&hwif->drives[unit]);


--- setup-pci.c.orig	Sun Jan  4 14:17:30 2004
+++ setup-pci.c	Sun Jan  4 14:12:23 2004
@@ -441,6 +441,9 @@
 	}
 	if ((hwif = ide_match_hwif(base, d->bootable, d->name)) == NULL)
 		return NULL;	/* no room in ide_hwifs[] */
+	if (hwif->chipset != ide_unknown)
+		return NULL;  /* clash with already allocated hwif */
+
 	if (hwif->io_ports[IDE_DATA_OFFSET] != base) {
 fixup_address:
 		ide_init_hwif_ports(&hwif->hw, base, (ctl | 2), NULL);


