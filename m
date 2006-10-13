Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752008AbWJMX43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbWJMX43 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 19:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbWJMX42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 19:56:28 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:50618 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752002AbWJMX41
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 19:56:27 -0400
Message-ID: <453027A9.3060606@us.ibm.com>
Date: Fri, 13 Oct 2006 16:56:25 -0700
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM LTC
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>
CC: Mike Anderson <andmike@us.ibm.com>
Subject: [PATCH] libsas: support NCQ for SATA disks
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds SATAII NCQ support to libsas.  Both the use_ncq and the
dma_xfer flags in ata_task must be set for NCQ to work correctly on the
Adaptec SAS controller.  The rest of the patch adds ATA_FLAG_NCQ to
sata_port_info and sets up ap->scsi_host so that ata_setup_ncq doesn't
crash.  Please note that this patch is against the aic94xx-sas git tree,
not scsi-misc.  Thanks also to James Bottomley for providing an earlier
version of this patch from which to work.

I've tested this patch on a x206m with a ST380819AS SATA2 disk plugged
into the Adaptec SAS controller.  The drive came up with a queue depth
of 31, and I successfully ran an I/O flood test to coerce libata into
sending multiple commands simultaneously.  A kernel probe recorded the
maximum tag number that had been seen before and after the flood test;
before the test it was 2 and after it was 30, as I expected.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

--

diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 60d13b1..77a9be8 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -673,8 +673,14 @@ static unsigned int sas_ata_qc_issue(str
 	task->ata_task.retry_count = 1;
 	task->task_state_flags = SAS_TASK_STATE_PENDING;
 
-	if (qc->tf.protocol == ATA_PROT_DMA)
+	switch (qc->tf.protocol) {
+	case ATA_PROT_NCQ:
+		task->ata_task.use_ncq = 1;
+		/* fall through */
+	case ATA_PROT_DMA:
 		task->ata_task.dma_xfer = 1;
+		break;
+	}
 
 	if (sas_ha->lldd_max_execute_num < 2)
 		res = i->dft->lldd_execute_task(task, 1, GFP_ATOMIC);
@@ -807,7 +813,7 @@ static struct ata_port_operations sas_sa
 
 static struct ata_port_info sata_port_info = {
 	.flags = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY | ATA_FLAG_SATA_RESET |
-		ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA,
+		ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA | ATA_FLAG_NCQ,
 	.pio_mask = 0x1f, /* PIO0-4 */
 	.mwdma_mask = 0x07, /* MWDMA0-2 */
 	.udma_mask = ATA_UDMA6,
@@ -875,6 +881,7 @@ int sas_target_alloc(struct scsi_target 
 
 		ap->private_data = found_dev;
 		ap->cbl = ATA_CBL_SATA;
+		ap->scsi_host = shost;
 		found_dev->sata_dev.ap = ap;
 	}
 
