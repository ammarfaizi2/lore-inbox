Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbVE0Hc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVE0Hc6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 03:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVE0HcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 03:32:24 -0400
Received: from mail.dvmed.net ([216.237.124.58]:39901 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261942AbVE0H3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 03:29:35 -0400
Message-ID: <4296CC5C.5000807@pobox.com>
Date: Fri, 27 May 2005 03:29:32 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Playing with SATA NCQ
References: <20050526140058.GR1419@suse.de> <4295F87B.9070106@pobox.com> <20050527072046.GN1435@suse.de>
In-Reply-To: <20050527072046.GN1435@suse.de>
Content-Type: multipart/mixed;
 boundary="------------060805070408010400080703"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060805070408010400080703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jens Axboe wrote:
> I double checked this. If you agree to move the setting of QCFLAG_ACTIVE
> _after_ successful ap->ops->qc_issue(qc) and clear it _after_
> __ata_qc_complete(qc) then I can just use that bit and kill
> ATA_QCFLAG_ACCOUNT.
> 
> What do you think?

Fine with me.

Keep in mind that the attached patch was applied recently...

	Jeff





--------------060805070408010400080703
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

author Albert Lee <albertcc@tw.ibm.com> Fri, 29 Apr 2005 17:34:59 +0800
committer Jeff Garzik <jgarzik@pobox.com> Mon, 16 May 2005 02:46:59 -0400

[PATCH] libata: Prevent the interrupt handler from completing a command twice

Problem:
   During the libata CD-ROM stress test, sometimes the "BUG: timeout
without command" error is seen.

Root cause:
  Unexpected interrupt occurs after the ata_qc_complete() is called,
but before the SCSI error handler.  The interrupt handler is invoked
before the SCSI error handler, and it clears the command by calling
ata_qc_complete() again.  Later when the SCSI error handler is run,
the ata_queued_cmd is already gone, causing the "BUG: timeout without
command" error.

Changes:
  - Use the ATA_QCFLAG_ACTIVE flag to prevent the interrupt handler
from completing the command twice, before the scsi_error_handler.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>


diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2539,7 +2539,7 @@ static void atapi_request_sense(struct a
 	ata_sg_init_one(qc, cmd->sense_buffer, sizeof(cmd->sense_buffer));
 	qc->dma_dir = DMA_FROM_DEVICE;
 
-	memset(&qc->cdb, 0, sizeof(ap->cdb_len));
+	memset(&qc->cdb, 0, ap->cdb_len);
 	qc->cdb[0] = REQUEST_SENSE;
 	qc->cdb[4] = SCSI_SENSE_BUFFERSIZE;
 
@@ -2811,6 +2811,7 @@ void ata_qc_complete(struct ata_queued_c
 
 	/* call completion callback */
 	rc = qc->complete_fn(qc, drv_stat);
+	qc->flags &= ~ATA_QCFLAG_ACTIVE;
 
 	/* if callback indicates not to complete command (non-zero),
 	 * return immediately
@@ -3229,7 +3230,8 @@ irqreturn_t ata_interrupt (int irq, void
 			struct ata_queued_cmd *qc;
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
-			if (qc && (!(qc->tf.ctl & ATA_NIEN)))
+			if (qc && (!(qc->tf.ctl & ATA_NIEN)) &&
+			    (qc->flags & ATA_QCFLAG_ACTIVE))
 				handled |= ata_host_intr(ap, qc);
 		}
 	}

--------------060805070408010400080703--
