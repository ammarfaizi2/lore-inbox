Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261755AbSKHJ7z>; Fri, 8 Nov 2002 04:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261766AbSKHJ7z>; Fri, 8 Nov 2002 04:59:55 -0500
Received: from kim.it.uu.se ([130.238.12.178]:18641 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S261755AbSKHJ7y>;
	Fri, 8 Nov 2002 04:59:54 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15819.36010.413947.840428@kim.it.uu.se>
Date: Fri, 8 Nov 2002 11:06:34 +0100
To: linux-kernel@vger.kernel.org
Subject: [BUG][PATCH] 2.5.46 ide-dma oops on boot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried 2.5.46 on my News server, and it oopsed on boot in
ide-dma.c:ide_iomio_dma(): the code dereferenced hwif->mate
even though hwif->mate was NULL.

The patch below fixes this issue for me, although this oops
may just be a consequence of some deeper problem.

I suspect this is due to the HW config of the machine in question:
onboard PIIX has nothing on ide0 and a CD-ROM as master on ide1,
the disks are on an add-on Promise Ultra100 card. The oops ocurred
at exactly this point in the boot process:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio

*************************** here ^

/Mikael

--- linux-2.5.46/drivers/ide/ide-dma.c.~1~	2002-11-08 09:29:10.000000000 +0100
+++ linux-2.5.46/drivers/ide/ide-dma.c	2002-11-08 10:05:12.000000000 +0100
@@ -926,7 +926,7 @@
 		request_region(base+16, hwif->cds->extra, hwif->cds->name);
 		hwif->dma_extra = hwif->cds->extra;
 	}
-	hwif->dma_master = (hwif->channel) ? hwif->mate->dma_base : base;
+	hwif->dma_master = (hwif->channel && hwif->mate) ? hwif->mate->dma_base : base;
 	if (hwif->dma_base2) {
 		if (!request_region(hwif->dma_base2, ports, hwif->name))
 		{
