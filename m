Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVBRTyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVBRTyP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 14:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVBRTwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 14:52:49 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:19462 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261472AbVBRTuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 14:50:35 -0500
Date: Fri, 18 Feb 2005 14:50:29 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: [patch libata-dev-2.6 1/5] libata: fix command queue leak when xlat_func fails
Message-ID: <20050218195027.GB3197@tuxdriver.com>
Mail-Followup-To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	jgarzik@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ata_scsi_translate allocates from the libata command queue by calling
ata_scsi_qc_new.  If xlat_func returns non-zero, control jumps to
err_out which fails to free the allocated command.  Fix is to add a
new API to free unused commands.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/scsi/libata-core.c |   18 ++++++++++++++++++
 drivers/scsi/libata-scsi.c |    1 +
 drivers/scsi/libata.h      |    1 +
 3 files changed, 20 insertions(+)

--- sata-smart-2.6/drivers/scsi/libata-scsi.c.bugfix	2005-02-17 16:47:04.992924055 -0500
+++ sata-smart-2.6/drivers/scsi/libata-scsi.c	2005-02-17 16:48:48.265138198 -0500
@@ -967,6 +967,7 @@ static void ata_scsi_translate(struct at
 	return;
 
 err_out:
+	ata_qc_free(qc);
 	ata_bad_cdb(cmd, done);
 	DPRINTK("EXIT - badcmd\n");
 }
--- sata-smart-2.6/drivers/scsi/libata-core.c.bugfix	2005-02-17 16:46:44.659638355 -0500
+++ sata-smart-2.6/drivers/scsi/libata-core.c	2005-02-17 16:48:48.269137664 -0500
@@ -2687,6 +2687,24 @@ static void __ata_qc_complete(struct ata
 }
 
 /**
+ *	ata_qc_free - free unused ata_queued_cmd
+ *	@qc: Command to complete
+ *
+ *	Designed to free unused ata_queued_cmd object
+ *	in case something prevents using it.
+ *
+ *	LOCKING:
+ *
+ */
+void ata_qc_free(struct ata_queued_cmd *qc)
+{
+	assert(qc != NULL);	/* ata_qc_from_tag _might_ return NULL */
+	assert(qc->waiting == NULL);	/* nothing should be waiting */
+
+	__ata_qc_complete(qc);
+}
+
+/**
  *	ata_qc_complete - Complete an active ATA command
  *	@qc: Command to complete
  *	@drv_stat: ATA status register contents
--- sata-smart-2.6/drivers/scsi/libata.h.bugfix	2005-02-17 16:46:47.630241808 -0500
+++ sata-smart-2.6/drivers/scsi/libata.h	2005-02-17 16:48:48.306132726 -0500
@@ -37,6 +37,7 @@ struct ata_scsi_args {
 /* libata-core.c */
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
 				      struct ata_device *dev);
+extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern int ata_qc_issue(struct ata_queued_cmd *qc);
 extern int ata_check_atapi_dma(struct ata_queued_cmd *qc);
 extern int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg);
-- 
John W. Linville
linville@tuxdriver.com
