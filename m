Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264001AbSJVPyO>; Tue, 22 Oct 2002 11:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264614AbSJVPyO>; Tue, 22 Oct 2002 11:54:14 -0400
Received: from va.cs.wm.edu ([128.239.2.31]:47364 "EHLO va.cs.wm.edu")
	by vger.kernel.org with ESMTP id <S264001AbSJVPyM>;
	Tue, 22 Oct 2002 11:54:12 -0400
From: "Bruce B. Lowekamp" <lowekamp@CS.WM.EDU>
Date: Tue, 22 Oct 2002 11:59:45 -0400
Message-Id: <200210221559.g9MFxjf24244@in.cs.wm.edu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.20-pre11 fix pdc20265 to off_board
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, lowekamp@CS.WM.EDU
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the bug with auxilliary on-MB pdc20265 RAID
controllers erroneously receiving ide0 and ide1 that was introduced
with 2.4.19.  This is a patch to 2.4.20-pre11 to change the PDC20265
from ON_BOARD to OFF_BOARD.  It is needed for compatibility with
kernels prior to 2.4.19 and compatibility with 2.5.x kernels.  If the
2.5 ide merge in 2.4.20-pre10-ac2 is incorporated into 2.4.20, it is
irrelevant.

There may be a very small number of motherboards that this patch
causes problems for.  These MBs are, however, significantly fewer than
the number for whom the current ON_BOARD config causes major problems.
Among these is the ASUS A7v266-E and any other board with the 20265 on
the MB as a RAID controller and appearing first in the bus scanning
order.  Without this patch, hda drives appear as hde because ide0 and
ide1 are swapped with ide2 and ide3.

For those MBs that this patch causes a problem for, using ide0=X and
ide1=Y is a sure cure for this problem.  Identifying X and Y is,
unfortunately, almost impossible with the current kernel messages, and
for this reason I include a second patch that would make this task much
easier by printing the addresses the devices are located at as part of
the ide boot-up sequence.

Bruce Lowekamp



--- linux-2.4.20-pre11/drivers/ide/ide-pci.c	Tue Oct 22 10:36:12 2002
+++ linux-2.4.20-pre11-pdc-ext/drivers/ide/ide-pci.c	Tue Oct 22 10:43:01 2002
@@ -405,7 +405,7 @@
 #ifndef CONFIG_PDC202XX_FORCE
         {DEVID_PDC20246,"PDC20246",	PCI_PDC202XX,	NULL,		INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	16 },
         {DEVID_PDC20262,"PDC20262",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	48 },
-        {DEVID_PDC20265,"PDC20265",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	ON_BOARD,	48 },
+        {DEVID_PDC20265,"PDC20265",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	48 },
         {DEVID_PDC20267,"PDC20267",	PCI_PDC202XX,	ATA66_PDC202XX,	INIT_PDC202XX,	NULL,		{{0x00,0x00,0x00}, {0x00,0x00,0x00}},	OFF_BOARD,	48 },
 #else /* !CONFIG_PDC202XX_FORCE */
 	{DEVID_PDC20246,"PDC20246",	PCI_PDC202XX,	NULL,		INIT_PDC202XX,	NULL,		{{0x50,0x02,0x02}, {0x50,0x04,0x04}}, 	OFF_BOARD,	16 },



adds message to help with ideN=X selection:
--- linux-2.4.20-pre11-pdc-ext/drivers/ide/ide-pci.c	Tue Oct 22 10:43:01 2002
+++ linux-2.4.20-pre11-multi-message/drivers/ide/ide-pci.c	Tue Oct 22 10:45:31 2002
@@ -764,6 +764,7 @@
 			base = port ? 0x170 : 0x1f0;	/* use default value */
 		if ((hwif = ide_match_hwif(base, d->bootable, d->name)) == NULL)
 			continue;	/* no room in ide_hwifs[] */
+		printk("    %s: located at 0x%04lx\n", hwif->name, base);
 		if (hwif->io_ports[IDE_DATA_OFFSET] != base) {
 			ide_init_hwif_ports(&hwif->hw, base, (ctl | 2), NULL);
 			memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
