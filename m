Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161157AbWBQVl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161157AbWBQVl1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 16:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161159AbWBQVl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 16:41:26 -0500
Received: from havoc.gtf.org ([69.61.125.42]:33680 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1161157AbWBQVlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 16:41:25 -0500
Date: Fri, 17 Feb 2006 16:41:24 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] libata fixes
Message-ID: <20060217214124.GA24280@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following updates:

 drivers/scsi/libata-core.c |    7 ++++---
 drivers/scsi/sata_mv.c     |    1 +
 drivers/scsi/sata_vsc.c    |   30 +++++++++++++++++++++++++++++-
 3 files changed, 34 insertions(+), 4 deletions(-)

Albert Lee:
      libata: minor fix for 2.6.16-rc3

Dan Williams:
      Necessary evil to get sata_vsc to initialize with Intel iq3124h hba

Jens Axboe:
      Add missing FUA write to sata_mv dma command list

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 46c4cdb..7ddd5a6 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -614,7 +614,7 @@ int ata_rwcmd_protocol(struct ata_queued
 	} else if (lba48 && (qc->ap->flags & ATA_FLAG_PIO_LBA48)) {
 		/* Unable to use DMA due to host limitation */
 		tf->protocol = ATA_PROT_PIO;
-		index = dev->multi_count ? 0 : 4;
+		index = dev->multi_count ? 0 : 8;
 	} else {
 		tf->protocol = ATA_PROT_DMA;
 		index = 16;
@@ -3357,11 +3357,12 @@ static void ata_pio_error(struct ata_por
 {
 	struct ata_queued_cmd *qc;
 
-	printk(KERN_WARNING "ata%u: PIO error\n", ap->id);
-
 	qc = ata_qc_from_tag(ap, ap->active_tag);
 	assert(qc != NULL);
 
+	if (qc->tf.command != ATA_CMD_PACKET)
+		printk(KERN_WARNING "ata%u: PIO error\n", ap->id);
+
 	/* make sure qc->err_mask is available to 
 	 * know what's wrong and recover
 	 */
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 6fddf17..2770005 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -997,6 +997,7 @@ static void mv_qc_prep(struct ata_queued
 	case ATA_CMD_READ_EXT:
 	case ATA_CMD_WRITE:
 	case ATA_CMD_WRITE_EXT:
+	case ATA_CMD_WRITE_FUA_EXT:
 		mv_crqb_pack_cmd(cw++, tf->hob_nsect, ATA_REG_NSECT, 0);
 		break;
 #ifdef LIBATA_NCQ		/* FIXME: remove this line when NCQ added */
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index 2e2c3b7..e484e8d 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -81,6 +81,19 @@
 /* Port stride */
 #define VSC_SATA_PORT_OFFSET		0x200
 
+/* Error interrupt status bit offsets */
+#define VSC_SATA_INT_ERROR_E_OFFSET	2
+#define VSC_SATA_INT_ERROR_P_OFFSET	4
+#define VSC_SATA_INT_ERROR_T_OFFSET	5
+#define VSC_SATA_INT_ERROR_M_OFFSET	1
+#define is_vsc_sata_int_err(port_idx, int_status) \
+	 (int_status & ((1 << (VSC_SATA_INT_ERROR_E_OFFSET + (8 * port_idx))) | \
+		        (1 << (VSC_SATA_INT_ERROR_P_OFFSET + (8 * port_idx))) | \
+		        (1 << (VSC_SATA_INT_ERROR_T_OFFSET + (8 * port_idx))) | \
+		        (1 << (VSC_SATA_INT_ERROR_M_OFFSET + (8 * port_idx)))   \
+		       )\
+ 	 )
+
 
 static u32 vsc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
@@ -201,13 +214,28 @@ static irqreturn_t vsc_sata_interrupt (i
 			struct ata_port *ap;
 
 			ap = host_set->ports[i];
+
+			if (is_vsc_sata_int_err(i, int_status)) {
+				u32 err_status;
+				printk(KERN_DEBUG "%s: ignoring interrupt(s)\n", __FUNCTION__);
+				err_status = ap ? vsc_sata_scr_read(ap, SCR_ERROR) : 0;
+				vsc_sata_scr_write(ap, SCR_ERROR, err_status);
+				handled++;
+			}
+
 			if (ap && !(ap->flags &
 				    (ATA_FLAG_PORT_DISABLED|ATA_FLAG_NOINTR))) {
 				struct ata_queued_cmd *qc;
 
 				qc = ata_qc_from_tag(ap, ap->active_tag);
-				if (qc && (!(qc->tf.ctl & ATA_NIEN)))
+				if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
 					handled += ata_host_intr(ap, qc);
+				} else {
+					printk(KERN_DEBUG "%s: ignoring interrupt(s)\n", __FUNCTION__);
+					ata_chk_status(ap);
+					handled++;
+				}
+
 			}
 		}
 	}
