Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030644AbVIBBxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030644AbVIBBxj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 21:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030642AbVIBBxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 21:53:39 -0400
Received: from mailhub.lss.emc.com ([168.159.2.31]:17757 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP
	id S1030640AbVIBBxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 21:53:38 -0400
From: Brett Russ <russb@emc.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.13] libata: fix pio_mask values (take 2)
References: <20050830190309.E14FE20F4C@lns1058.lss.emc.com>
In-Reply-To: <20050830190309.E14FE20F4C@lns1058.lss.emc.com>
Message-Id: <20050902015334.1ED2520F96@lns1058.lss.emc.com>
Date: Thu,  1 Sep 2005 21:53:34 -0400 (EDT)
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.9.1.37
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='__HAS_MSGID 0, __MIME_TEXT_ONLY 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ata_get_mode_mask() uses bits 3 and 4 in the pio_mask to represent PIO
modes 3 and 4.  The value read from the drive, which reports support
for PIO3 and PIO4 in bits 0 and 1, is shifted left by 3 bits and OR'd
with 0x7 (which then corresponds to PIO 2-0 in libata).  Thus, the
drivers below need adjustments to comply with the way pio_mask is
used.  I changed the masks from the commented values to all support
PIO4-0, since the spec mandates that PIO0-2 are supported and there's
no reason not to support PIO3 IMO.

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
+		.pio_mask	= 0x1f, /* pio4-0 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &ahci_ops,
 	},
Index: linux-2.6.13/drivers/scsi/sata_uli.c
===================================================================
--- linux-2.6.13.orig/drivers/scsi/sata_uli.c
+++ linux-2.6.13/drivers/scsi/sata_uli.c
@@ -120,8 +120,8 @@ static struct ata_port_info uli_port_inf
 	.sht            = &uli_sht,
 	.host_flags     = ATA_FLAG_SATA | ATA_FLAG_SATA_RESET |
 			  ATA_FLAG_NO_LEGACY,
-	.pio_mask       = 0x03,		//support pio mode 4 (FIXME)
-	.udma_mask      = 0x7f,		//support udma mode 6
+	.pio_mask       = 0x1f,		/* pio4-0 */
+	.udma_mask      = 0x7f,		/* udma6-0 */
 	.port_ops       = &uli_ops,
 };
 
