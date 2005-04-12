Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262416AbVDLNTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbVDLNTh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 09:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbVDLNFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 09:05:07 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:5438 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262414AbVDLMwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:52:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=mYSihwZMg6gxpybQR+lzWcoboH728If5ShE91dRPgASDfYPqDQy5Lc2EFMcNQZqF8mUsfC5Cf5V0w7g74b1JKQmnIvixxL1aH2xrrvu8RhlZJFOkkHlnY5qEwNGA2zArrQ2QsmWhYF5Qx0XDaWWAOuzWXRZ7sDeBbzE7nEiQ8u8=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050412125219.88E5C1F6@htj.dyndns.org>
In-Reply-To: <20050412125219.88E5C1F6@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 05/07] scsi: move scsi_init_cmd_errh() from request_fn to prep_fn.
Message-ID: <20050412125219.D8DA0D54@htj.dyndns.org>
Date: Tue, 12 Apr 2005 21:52:46 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

05_scsi_requeue_move_init_cmd_errh.patch

	As now all non-reprepped requeue goes through
	scsi_retry_command() which clears sense buffer, there's no
	need to call scsi_init_cmd_errh() in scsi_request_fn().  Move
	scsi_init_cmd_errh() to scsi_prep_fn().

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi_lib.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

Index: scsi-reqfn-export/drivers/scsi/scsi_lib.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_lib.c	2005-04-12 21:50:11.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_lib.c	2005-04-12 21:50:12.000000000 +0900
@@ -1051,6 +1051,8 @@ static int scsi_prep_fn(struct request_q
 	if (CDB_SIZE(cmd) > sdev->host->max_cmd_len)
 		goto kill;
 
+	scsi_init_cmd_errh(cmd);
+
 	/* If SCSI-2 or lower, store the LUN value in cmnd. */
 	if (cmd->device->scsi_level <= SCSI_2)
 		cmd->cmnd[1] = (cmd->cmnd[1] & 0x1f) |
@@ -1311,9 +1313,6 @@ static void scsi_request_fn(struct reque
 			target->starget_sdev_user = sdev;
 		}
 
-		/* Once requeue path is cleaned up, init_cmd_errh can
-		 * be moved to prep_fn() where it belongs. */
-		scsi_init_cmd_errh(cmd);
 		shost->host_busy++;
 		scsi_log_send(cmd);
 		scsi_cmd_get_serial(shost, cmd);

