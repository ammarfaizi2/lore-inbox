Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbVH3TDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbVH3TDT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 15:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbVH3TDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 15:03:18 -0400
Received: from mailhub.lss.emc.com ([168.159.2.31]:10915 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S932346AbVH3TDQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 15:03:16 -0400
From: Brett Russ <russb@emc.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.13] Fix pio_mask values
Message-Id: <20050830190309.E14FE20F4C@lns1058.lss.emc.com>
Date: Tue, 30 Aug 2005 15:03:09 -0400 (EDT)
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.8.30.21
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='__HAS_MSGID 0, __MIME_TEXT_ONLY 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ata_get_mode_mask() has PIO modes 3 and 4 as bits 3 and 4 in the pio_mask
since the value read from the drive is shifted left by 3 bits and OR'd with
0x7 (which corresponds to PIO 2-0).  Thus, the drivers below need adjustments
to comply with the way pio_mask is used.  I left the masks in a state which
agrees with the existing comments; perhaps they all should get 0x1f to
indicate driver support for PIO4-0 but that can be done later.

Signed-off-by: Brett Russ <russb@emc.com>


Index: linux-2.6.13/drivers/scsi/ahci.c
===================================================================
--- linux-2.6.13.orig/drivers/scsi/ahci.c
+++ linux-2.6.13/drivers/scsi/ahci.c
@@ -244,7 +244,7 @@ static struct ata_port_info ahci_port_in
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO |
 				  ATA_FLAG_PIO_DMA,
-		.pio_mask	= 0x03, /* pio3-4 */
+		.pio_mask	= 0x18, /* pio3-4 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &ahci_ops,
 	},
Index: linux-2.6.13/drivers/scsi/sata_uli.c
===================================================================
--- linux-2.6.13.orig/drivers/scsi/sata_uli.c
+++ linux-2.6.13/drivers/scsi/sata_uli.c
@@ -120,7 +120,7 @@ static struct ata_port_info uli_port_inf
 	.sht            = &uli_sht,
 	.host_flags     = ATA_FLAG_SATA | ATA_FLAG_SATA_RESET |
 			  ATA_FLAG_NO_LEGACY,
-	.pio_mask       = 0x03,		//support pio mode 4 (FIXME)
+	.pio_mask       = 0x10,		//support pio mode 4 (FIXME)
 	.udma_mask      = 0x7f,		//support udma mode 6
 	.port_ops       = &uli_ops,
 };
