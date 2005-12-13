Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbVLMQjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbVLMQjV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 11:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbVLMQjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 11:39:21 -0500
Received: from havoc.gtf.org ([69.61.125.42]:38276 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932172AbVLMQjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 11:39:19 -0500
Date: Tue, 13 Dec 2005 11:39:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patch] libata ATAPI fix
Message-ID: <20051213163919.GA23659@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following updates:

 drivers/scsi/libata-scsi.c  |    7 +++++--
 drivers/scsi/sata_mv.c      |    3 ++-
 drivers/scsi/sata_promise.c |   12 ++++++------
 drivers/scsi/sata_sx4.c     |    3 ++-
 include/linux/libata.h      |    1 +
 5 files changed, 16 insertions(+), 10 deletions(-)

Jeff Garzik:
      [libata] mark certain hardware (or drivers) with a no-atapi flag

diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 379e870..72ddba9 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -2173,9 +2173,12 @@ ata_scsi_find_dev(struct ata_port *ap, c
 	if (unlikely(!ata_dev_present(dev)))
 		return NULL;
 
-	if (!atapi_enabled) {
-		if (unlikely(dev->class == ATA_DEV_ATAPI))
+	if (!atapi_enabled || (ap->flags & ATA_FLAG_NO_ATAPI)) {
+		if (unlikely(dev->class == ATA_DEV_ATAPI)) {
+			printk(KERN_WARNING "ata%u(%u): WARNING: ATAPI is %s, device ignored.\n",
+			       ap->id, dev->devno, atapi_enabled ? "not supported with this driver" : "disabled");
 			return NULL;
+		}
 	}
 
 	return dev;
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index ab7432a..9321cdf 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -86,7 +86,8 @@ enum {
 	MV_FLAG_DUAL_HC		= (1 << 30),  /* two SATA Host Controllers */
 	MV_FLAG_IRQ_COALESCE	= (1 << 29),  /* IRQ coalescing capability */
 	MV_COMMON_FLAGS		= (ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				   ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO),
+				   ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO |
+				   ATA_FLAG_NO_ATAPI),
 	MV_6XXX_FLAGS		= MV_FLAG_IRQ_COALESCE,
 
 	CRQB_FLAG_READ		= (1 << 0),
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index 8a8e3e3..2691625 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -70,6 +70,9 @@ enum {
 	PDC_HAS_PATA		= (1 << 1), /* PDC20375 has PATA */
 
 	PDC_RESET		= (1 << 11), /* HDMA reset */
+
+	PDC_COMMON_FLAGS	= ATA_FLAG_NO_LEGACY | ATA_FLAG_SRST |
+				  ATA_FLAG_MMIO | ATA_FLAG_NO_ATAPI,
 };
 
 
@@ -162,8 +165,7 @@ static struct ata_port_info pdc_port_inf
 	/* board_2037x */
 	{
 		.sht		= &pdc_ata_sht,
-		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
+		.host_flags	= PDC_COMMON_FLAGS | ATA_FLAG_SATA,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
@@ -173,8 +175,7 @@ static struct ata_port_info pdc_port_inf
 	/* board_20319 */
 	{
 		.sht		= &pdc_ata_sht,
-		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
+		.host_flags	= PDC_COMMON_FLAGS | ATA_FLAG_SATA,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
@@ -184,8 +185,7 @@ static struct ata_port_info pdc_port_inf
 	/* board_20619 */
 	{
 		.sht		= &pdc_ata_sht,
-		.host_flags	= ATA_FLAG_NO_LEGACY | ATA_FLAG_SRST |
-				  ATA_FLAG_MMIO | ATA_FLAG_SLAVE_POSS,
+		.host_flags	= PDC_COMMON_FLAGS | ATA_FLAG_SLAVE_POSS,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index dcc3ad9..ac7b0d8 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -220,7 +220,8 @@ static struct ata_port_info pdc_port_inf
 	{
 		.sht		= &pdc_sata_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
+				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
+				  ATA_FLAG_NO_ATAPI,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index f2dbb68..41ea7db 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -122,6 +122,7 @@ enum {
 	ATA_FLAG_NOINTR		= (1 << 9), /* FIXME: Remove this once
 					     * proper HSM is in place. */
 	ATA_FLAG_DEBUGMSG	= (1 << 10),
+	ATA_FLAG_NO_ATAPI	= (1 << 11), /* No ATAPI support */
 
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
