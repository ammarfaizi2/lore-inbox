Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWEPO3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWEPO3N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 10:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWEPO3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 10:29:12 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44726 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751148AbWEPO3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 10:29:12 -0400
Subject: PATCH: Fix broken PIO with libata
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, Tejun Heo <htejun@gmail.com>,
       jgarzik@pobox.com, torvalds@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 16 May 2006 15:39:53 +0100
Message-Id: <1147790393.2151.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The revaldiation in 2.6.17-rc has broken support for PIO only devices.
This is fairly unusual in the SATA world but showed up rather more
promptly with the added PATA drivers.

The patch fixes two specific problem cases

#1	If you issue a DMA command via pass through the libata core blindly
issues a DMA command and calls DMA methods that are not present on PIO
only controllers causing an Oops. The patch does a simple check and
reject of a DMA command in PIO only cases.

#2	The core sets ATA_DFLAG_PIO to indicate PIO commands should be used
on this channel. This same information is available in dev->dma_mode but
for some reason we get two sources of the info. The ATA_DFLAG_PIO is set
once during setup and then cleared but not re-computed by the revalidate
function. This causes DMA commands to be issued when PIO would be and
usually an Oops or hang

Also contains a related bracketing fix


Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.17-rc4/drivers/scsi/libata-core.c linux-2.6.17-rc4/drivers/scsi/libata-core.c
--- linux.vanilla-2.6.17-rc4/drivers/scsi/libata-core.c	2006-05-15 15:46:04.000000000 +0100
+++ linux-2.6.17-rc4/drivers/scsi/libata-core.c	2006-05-16 14:52:17.459504416 +0100
@@ -1757,6 +1763,10 @@
 		return rc;
 	}
 
+	/* This is cleared by the revalidation */
+	if (dev->xfer_shift == ATA_SHIFT_PIO)
+		dev->flags |= ATA_DFLAG_PIO;
+
 	DPRINTK("xfer_shift=%u, xfer_mode=0x%x\n",
 		dev->xfer_shift, (int)dev->xfer_mode);
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.17-rc4/drivers/scsi/libata-scsi.c linux-2.6.17-rc4/drivers/scsi/libata-scsi.c
--- linux.vanilla-2.6.17-rc4/drivers/scsi/libata-scsi.c	2006-05-15 15:46:04.000000000 +0100
+++ linux-2.6.17-rc4/drivers/scsi/libata-scsi.c	2006-05-16 12:56:06.212295080 +0100
@@ -1944,7 +1944,7 @@
 		return 0;
 
 	dpofua = 0;
-	if (ata_dev_supports_fua(args->id) && dev->flags & ATA_DFLAG_LBA48 &&
+	if (ata_dev_supports_fua(args->id) && (dev->flags & ATA_DFLAG_LBA48) &&
 	    (!(dev->flags & ATA_DFLAG_PIO) || dev->multi_count))
 		dpofua = 1 << 4;
 
@@ -2414,9 +2414,15 @@
 {
 	struct ata_taskfile *tf = &(qc->tf);
 	struct scsi_cmnd *cmd = qc->scsicmd;
+	struct ata_device *dev = qc->dev;
+	struct ata_port *ap = qc->ap;
 
 	if ((tf->protocol = ata_scsi_map_proto(scsicmd[1])) == ATA_PROT_UNKNOWN)
 		goto invalid_fld;
+		
+	/* We may not issue DMA commands if no DMA mode is set */
+	if (tf->protocol == ATA_PROT_DMA && dev->dma_mode == 0)
+		goto invalid_fld;
 
 	if (scsicmd[1] & 0xe0)
 		/* PIO multi not supported yet */

