Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937211AbWLDXCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937211AbWLDXCp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 18:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937444AbWLDXCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 18:02:45 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:45021 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937211AbWLDXCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 18:02:43 -0500
Message-ID: <4574A90E.5010801@us.ibm.com>
Date: Mon, 04 Dec 2006 15:02:38 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM LTC
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: libata: Simulate REPORT LUNS for ATAPI devices when not supported
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Quantum GoVault SATAPI removable disk device returns ATA_ERR in
response to a REPORT LUNS packet.  If this happens to an ATAPI device
that is attached to a SAS controller (this is the case with sas_ata),
the device does not load because SCSI won't touch a "SCSI device"
that won't report its LUNs.  If we see this command fail, we should
simulate a response that indicates the presence of LUN 0.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/ata/libata-core.c |   36 ++++++++++++++++++++++++++++++++----
 drivers/ata/libata-scsi.c |    4 ++--
 include/linux/libata.h    |    2 ++
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 915a55a..a3d6217 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4455,6 +4455,35 @@ void ata_qc_complete(struct ata_queued_c
 {
 	struct ata_port *ap = qc->ap;
 
+	/*
+	 * If this is an ATAPI device that fails a REPORT LUN issued by SCSI,
+	 * assume that LUN 0 exists and fake the return buffer as appropriate.
+	 * ATA devices have REPORT LUN simulated for them.
+	 */
+	if (is_atapi_taskfile(&qc->tf) &&
+	    qc->scsicmd &&
+	    qc->cdb[0] == REPORT_LUNS &&
+	    qc->err_mask) {
+		unsigned int buflen;
+		struct scsi_cmnd *cmd = qc->scsicmd;
+		u8 *buf = NULL;
+
+		buflen = ata_scsi_rbuf_get(cmd, &buf);
+		memset(buf, 0, buflen);
+		buf[3] = 8;
+		ata_scsi_rbuf_put(cmd, buf);
+		
+		qc->err_mask = 0;
+
+		/* read result TF if requested */
+		if (qc->flags & ATA_QCFLAG_RESULT_TF)
+			ap->ops->tf_read(ap, &qc->result_tf);
+		qc->result_tf.command &= ~ATA_ERR;
+		qc->flags &= ~ATA_QCFLAG_RESULT_TF;
+
+		goto finish_qc;
+	}
+
 	/* XXX: New EH and old EH use different mechanisms to
 	 * synchronize EH with regular execution path.
 	 *
@@ -4486,8 +4515,6 @@ void ata_qc_complete(struct ata_queued_c
 		/* read result TF if requested */
 		if (qc->flags & ATA_QCFLAG_RESULT_TF)
 			ap->ops->tf_read(ap, &qc->result_tf);
-
-		__ata_qc_complete(qc);
 	} else {
 		if (qc->flags & ATA_QCFLAG_EH_SCHEDULED)
 			return;
@@ -4495,9 +4522,10 @@ void ata_qc_complete(struct ata_queued_c
 		/* read result TF if failed or requested */
 		if (qc->err_mask || qc->flags & ATA_QCFLAG_RESULT_TF)
 			ap->ops->tf_read(ap, &qc->result_tf);
-
-		__ata_qc_complete(qc);
 	}
+
+finish_qc:
+	__ata_qc_complete(qc);
 }
 
 /**
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 47ea111..da013a7 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1639,7 +1639,7 @@ defer:
  *	Length of response buffer.
  */
 
-static unsigned int ata_scsi_rbuf_get(struct scsi_cmnd *cmd, u8 **buf_out)
+unsigned int ata_scsi_rbuf_get(struct scsi_cmnd *cmd, u8 **buf_out)
 {
 	u8 *buf;
 	unsigned int buflen;
@@ -1670,7 +1670,7 @@ static unsigned int ata_scsi_rbuf_get(st
  *	spin_lock_irqsave(host lock)
  */
 
-static inline void ata_scsi_rbuf_put(struct scsi_cmnd *cmd, u8 *buf)
+void ata_scsi_rbuf_put(struct scsi_cmnd *cmd, u8 *buf)
 {
 	if (cmd->use_sg) {
 		struct scatterlist *sg;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index abd2deb..b37b21f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -723,6 +723,8 @@ extern int ata_scsi_detect(struct scsi_h
 extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
 extern int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *));
 extern int ata_scsi_release(struct Scsi_Host *host);
+unsigned int ata_scsi_rbuf_get(struct scsi_cmnd *cmd, u8 **buf_out);
+void ata_scsi_rbuf_put(struct scsi_cmnd *cmd, u8 *buf);
 extern void ata_sas_port_destroy(struct ata_port *);
 extern struct ata_port *ata_sas_port_alloc(struct ata_host *,
 					   struct ata_port_info *, struct Scsi_Host *);

