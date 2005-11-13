Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbVKMVYC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbVKMVYC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 16:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbVKMVYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 16:24:02 -0500
Received: from havoc.gtf.org ([69.61.125.42]:5767 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750711AbVKMVYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 16:24:00 -0500
Date: Sun, 13 Nov 2005 16:23:56 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] 2.6.x libata fixes
Message-ID: <20051113212356.GA2649@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following fixes:

 drivers/scsi/libata-core.c |    3 +--
 drivers/scsi/libata-scsi.c |    6 ++++++
 drivers/scsi/sata_sil24.c  |    1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

Mark Lord:
      libata: fix comments on ata_tf_from_fis()
      [libata passthru] address slave devices correctly

Tejun Heo:
      sil24: add missing ata_pad_free()

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index e51d9a8..d81db3a 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -532,8 +532,7 @@ void ata_tf_to_fis(const struct ata_task
  *	@fis: Buffer from which data will be input
  *	@tf: Taskfile to output
  *
- *	Converts a standard ATA taskfile to a Serial ATA
- *	FIS structure (Register - Host to Device).
+ *	Converts a serial ATA FIS structure to a standard ATA taskfile.
  *
  *	LOCKING:
  *	Inherited from caller.
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 261be24..0df4b68 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -2276,6 +2276,12 @@ ata_scsi_pass_thru(struct ata_queued_cmd
 		tf->device = scsicmd[8];
 		tf->command = scsicmd[9];
 	}
+	/*
+	 * If slave is possible, enforce correct master/slave bit
+	*/
+	if (qc->ap->flags & ATA_FLAG_SLAVE_POSS)
+		tf->device = qc->dev->devno ?
+			tf->device | ATA_DEV1 : tf->device & ~ATA_DEV1;
 
 	/*
 	 * Filter SET_FEATURES - XFER MODE command -- otherwise,
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index d3198d9..55e744d 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -687,6 +687,7 @@ static void sil24_port_stop(struct ata_p
 	struct sil24_port_priv *pp = ap->private_data;
 
 	sil24_cblk_free(pp, dev);
+	ata_pad_free(ap, dev);
 	kfree(pp);
 }
 
