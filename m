Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbWIKM6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWIKM6b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 08:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWIKM6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 08:58:31 -0400
Received: from havoc.gtf.org ([69.61.125.42]:9859 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751440AbWIKM6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 08:58:30 -0400
Date: Mon, 11 Sep 2006 08:58:29 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] libata fixes
Message-ID: <20060911125829.GA3904@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Changes:
* On sata_mv machines with a certain hardware errata, the errata
  workaround was broken.  Apply the obvious fix.
* Get PATA working properly on ICH7M.  Documentation malfunction.

Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 drivers/scsi/ata_piix.c |   36 ++++++++++++++++++++++++++++++++++--
 drivers/scsi/sata_mv.c  |    3 +--
 2 files changed, 35 insertions(+), 4 deletions(-)

Andres Salomon:
      [libata] sata_mv: errata check buglet fix

Tejun Heo:
      ata_piix: add map 01b for ICH7M

diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 2d20caf..a9bb3cb 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -123,7 +123,8 @@ enum {
 	ich6_sata		= 4,
 	ich6_sata_ahci		= 5,
 	ich6m_sata_ahci		= 6,
-	ich8_sata_ahci		= 7,
+	ich7m_sata_ahci		= 7,
+	ich8_sata_ahci		= 8,
 
 	/* constants for mapping table */
 	P0			= 0,  /* port 0 */
@@ -188,7 +189,7 @@ #endif
 	/* 82801GB/GR/GH (ICH7, identical to ICH6) */
 	{ 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
 	/* 2801GBM/GHM (ICH7M, identical to ICH6M) */
-	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6m_sata_ahci },
+	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich7m_sata_ahci },
 	/* Enterprise Southbridge 2 (where's the datasheet?) */
 	{ 0x8086, 0x2680, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
 	/* SATA Controller 1 IDE (ICH8, no datasheet yet) */
@@ -336,6 +337,24 @@ static const struct piix_map_db ich6m_ma
 	},
 };
 
+static const struct piix_map_db ich7m_map_db = {
+	.mask = 0x3,
+	.port_enable = 0x5,
+	.present_shift = 4,
+
+	/* Map 01b isn't specified in the doc but some notebooks use
+	 * it anyway.  ATM, the only case spotted carries subsystem ID
+	 * 1025:0107.  This is the only difference from ich6m.
+	 */
+	.map = {
+		/* PM   PS   SM   SS       MAP */
+		{  P0,  P2,  RV,  RV }, /* 00b */
+		{ IDE, IDE,  P1,  P3 }, /* 01b */
+		{  P0,  P2, IDE, IDE }, /* 10b */
+		{  RV,  RV,  RV,  RV },
+	},
+};
+
 static const struct piix_map_db ich8_map_db = {
 	.mask = 0x3,
 	.port_enable = 0x3,
@@ -355,6 +374,7 @@ static const struct piix_map_db *piix_ma
 	[ich6_sata]		= &ich6_map_db,
 	[ich6_sata_ahci]	= &ich6_map_db,
 	[ich6m_sata_ahci]	= &ich6m_map_db,
+	[ich7m_sata_ahci]	= &ich7m_map_db,
 	[ich8_sata_ahci]	= &ich8_map_db,
 };
 
@@ -444,6 +464,18 @@ #endif
 		.port_ops	= &piix_sata_ops,
 	},
 
+	/* ich7m_sata_ahci */
+	{
+		.sht		= &piix_sht,
+		.host_flags	= ATA_FLAG_SATA |
+				  PIIX_FLAG_CHECKINTR | PIIX_FLAG_SCR |
+				  PIIX_FLAG_AHCI,
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= 0x7f,	/* udma0-6 */
+		.port_ops	= &piix_sata_ops,
+	},
+
 	/* ich8_sata_ahci */
 	{
 		.sht		= &piix_sht,
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 1053c7c..fa38a41 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -1961,8 +1961,7 @@ comreset_retry:
 	timeout = jiffies + msecs_to_jiffies(200);
 	do {
 		sata_scr_read(ap, SCR_STATUS, &sstatus);
-		sstatus &= 0x3;
-		if ((sstatus == 3) || (sstatus == 0))
+		if (((sstatus & 0x3) == 3) || ((sstatus & 0x3) == 0))
 			break;
 
 		__msleep(1, can_sleep);
