Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbUB1UuP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 15:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbUB1UuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 15:50:14 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:36579 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261912AbUB1UuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 15:50:04 -0500
Subject: Re: [PATCH/RFT] libata "DMA timeout" fix
From: James Bottomley <James.Bottomley@steeleye.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <4040E7B5.4020709@pobox.com>
References: <4040E7B5.4020709@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 28 Feb 2004 14:49:15 -0600
Message-Id: <1078001357.2020.90.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-02-28 at 13:10, Jeff Garzik wrote:
> ===== drivers/scsi/libata-core.c 1.19 vs edited =====
> --- 1.19/drivers/scsi/libata-core.c	Wed Feb 25 22:41:13 2004
> +++ edited/drivers/scsi/libata-core.c	Sat Feb 28 14:03:18 2004
> @@ -2130,6 +2130,14 @@
>  				cmd->result = SAM_STAT_CHECK_CONDITION;
>  			else
>  				ata_to_sense_error(qc);
> +
> +			/* hack alert! we need this to get past the
> +			 * first check in scsi_done().  libata is the
> +			 * -only- user of ->eh_strategy_handler() in
> +			 * any kernel tree, which exposes some incorrect
> +			 * assumptions in the SCSI layer.
> +			 */
> +			scsi_add_timer(cmd, 2000 * HZ, NULL);
>  		} else {
>  			cmd->result = SAM_STAT_GOOD;
>  		}

You can't do this.  Supposing there command's delayed, the timer fires
and then the command returns with a sense error?  The done will go
through automatically completing the command, but your strategy handler
will still think it has a failed command to handle.

The correct fix is this, I think (uncompiled, but you get the idea):

===== libata-core.c 1.19 vs edited =====
--- 1.19/drivers/scsi/libata-core.c	Wed Feb 25 21:41:13 2004
+++ edited/libata-core.c	Sat Feb 28 14:46:17 2004
@@ -1972,6 +1972,11 @@
 	/* FIXME */
 }
 
+static void ata_eng_timeout_done(struct scsi_cmnd *cmnd)
+{
+	scsi_finish_command(cmnd);
+}
+
 /**
  *	ata_eng_timeout - Handle timeout of queued command
  *	@ap: Port on which timed-out command is active
@@ -2005,6 +2010,7 @@
 		goto out;
 	}
 
+	qc->scsidone = ata_eng_timeout_done;
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA_READ:
 	case ATA_PROT_DMA_WRITE:

James


