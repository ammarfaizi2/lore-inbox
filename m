Return-Path: <linux-kernel-owner+w=401wt.eu-S1752928AbWLSX7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928AbWLSX7b (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 18:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752963AbWLSX7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 18:59:31 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:39334 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903AbWLSX7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 18:59:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type;
        b=eu/MH7NeCzYzqtOEBP5sLVmfkO+5dKdG936lIjWUvO5ouJKTpxSpTs8xtsoMEbpbLJRDchGBI/c2wznMjtZFDktO08sJGiq94Dj1oT562IQL7zVpPEBSoPjENubCuAGTRHJFMJ1cGCmQamXHE54LI20NX07Ml0Hv1Utvit3V7Xc=
Message-ID: <45887CD8.5090100@gmail.com>
Date: Wed, 20 Dec 2006 08:59:20 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: Harald Dunkel <harald.dunkel@t-online.de>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19.1, sata_sil: sata dvd writer doesn't work
References: <45841710.9040900@t-online.de> <4587F87C.2050100@gmail.com> <45883299.2050209@t-online.de>
In-Reply-To: <45883299.2050209@t-online.de>
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/mixed;
 boundary="------------090401020306030806070909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090401020306030806070909
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

* dmesg is truncated, please post the content of file /var/log/boot.msg.

* Please post the result of 'lspci -nnvvv'

* Please try the attached patch and see if it makes any difference and
post the result of 'dmesg' after trying to play a problematic dvd.

-- 
tejun

--------------090401020306030806070909
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 02b2b27..bbbec75 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1433,16 +1433,47 @@ static void ata_eh_report(struct ata_port *ap)
 	}
 
 	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
+		static const char *dma_str[] = {
+			[DMA_BIDIRECTIONAL]	= "bidi",
+			[DMA_TO_DEVICE]		= "out",
+			[DMA_FROM_DEVICE]	= "in",
+			[DMA_NONE]		= "",
+		};
 		struct ata_queued_cmd *qc = __ata_qc_from_tag(ap, tag);
+		struct ata_taskfile *cmd = &qc->tf, *res = &qc->result_tf;
+		const u8 *c = qc->cdb;
+		unsigned int nbytes;
 
 		if (!(qc->flags & ATA_QCFLAG_FAILED) || !qc->err_mask)
 			continue;
 
-		ata_dev_printk(qc->dev, KERN_ERR, "tag %d cmd 0x%x "
-			       "Emask 0x%x stat 0x%x err 0x%x (%s)\n",
-			       qc->tag, qc->tf.command, qc->err_mask,
-			       qc->result_tf.command, qc->result_tf.feature,
-			       ata_err_string(qc->err_mask));
+		nbytes = qc->nbytes;
+		if (!nbytes)
+			nbytes = qc->nsect << 9;
+
+		ata_dev_printk(qc->dev, KERN_ERR,
+			"cmd %02x/%02x:%02x:%02x:%02x:%02x/%02x:%02x:%02x:%02x:%02x/%02x "
+			"tag %d cdb 0x%x data %u %s\n         "
+			"res %02x/%02x:%02x:%02x:%02x:%02x/%02x:%02x:%02x:%02x:%02x/%02x "
+			"Emask 0x%x (%s)\n",
+			cmd->command, cmd->feature, cmd->nsect,
+			cmd->lbal, cmd->lbam, cmd->lbah,
+			cmd->hob_feature, cmd->hob_nsect,
+			cmd->hob_lbal, cmd->hob_lbam, cmd->hob_lbah,
+			cmd->device, qc->tag, qc->cdb[0], nbytes,
+			dma_str[qc->dma_dir],
+			res->command, res->feature, res->nsect,
+			res->lbal, res->lbam, res->lbah,
+			res->hob_feature, res->hob_nsect,
+			res->hob_lbal, res->hob_lbam, res->hob_lbah,
+			res->device, qc->err_mask, ata_err_string(qc->err_mask));
+
+		ata_dev_printk(qc->dev, KERN_ERR,
+			       "CDB: %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x "
+			       "%02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x p=%d\n",
+			       c[0], c[1], c[2], c[3], c[4], c[5], c[6], c[7],
+			       c[8], c[9], c[10], c[11], c[12], c[13], c[14], c[15],
+			       cmd->protocol);
 	}
 }
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 3ac4890..f018e49 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -191,6 +191,7 @@ int scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 		goto out;
 
 	req->cmd_len = COMMAND_SIZE(cmd[0]);
+	memset(req->cmd, 0, BLK_MAX_CDB); /* ATAPI hates garbage after CDB */
 	memcpy(req->cmd, cmd, req->cmd_len);
 	req->sense = sense;
 	req->sense_len = 0;

--------------090401020306030806070909--
