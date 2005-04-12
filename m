Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262444AbVDLM66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbVDLM66 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 08:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbVDLM4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 08:56:47 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:34889 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262428AbVDLMwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:52:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=m4Mx2BpslYKWKE0b1oajM6jrpGQBPLFvTPHS4EgtPtDQhzeDCc95r3HDIbWS5qzvSE57Yn9nyDfIvl6/09zYP/Wh9oAvGhAbMtTHi2Aarm110aspGwHzJR+45WI8Ixqjh22M0qPK5WJ00TbJpF2LKn4Z9bgXFhcTKYq++IDpASQ=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050412125219.88E5C1F6@htj.dyndns.org>
In-Reply-To: <20050412125219.88E5C1F6@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 02/07] scsi: make scsi_retry_command() use scsi_requeue_command()
Message-ID: <20050412125219.9CE3E027@htj.dyndns.org>
Date: Tue, 12 Apr 2005 21:52:31 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

02_scsi_requeue_use_scsi_requeue_command_in_scsi_retry_command.patch

	scsi_retry_command() orignally used scsi_queue_insert() for
	requeueing.  This patch makes it use scsi_retry_command()
	instead.  Adding a call to scsi_device_unbusy() is sufficient
	and the change also makes scsi_retry_command() symmetric with
	scsi_finish_command() in how it unbusies the command.  Also as
	there's nothing to return, make the function void.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi.c      |    8 ++++++--
 scsi_priv.h |    2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

Index: scsi-reqfn-export/drivers/scsi/scsi.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi.c	2005-04-12 21:50:11.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi.c	2005-04-12 21:50:11.000000000 +0900
@@ -669,8 +669,12 @@ static void scsi_softirq(struct softirq_
  *              level drivers should not become re-entrant as a result of
  *              this.
  */
-int scsi_retry_command(struct scsi_cmnd *cmd)
+void scsi_retry_command(struct scsi_cmnd *cmd)
 {
+	SCSI_LOG_MLQUEUE(1, printk("Retrying command %p\n", cmd));
+
+	scsi_device_unbusy(cmd->device);
+
 	/*
 	 * Restore the SCSI command state.
 	 */
@@ -682,7 +686,7 @@ int scsi_retry_command(struct scsi_cmnd 
          */
 	memset(cmd->sense_buffer, 0, sizeof(cmd->sense_buffer));
 
-	return scsi_queue_insert(cmd, SCSI_MLQUEUE_EH_RETRY);
+	scsi_requeue_command(cmd);
 }
 
 /*
Index: scsi-reqfn-export/drivers/scsi/scsi_priv.h
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_priv.h	2005-04-12 21:50:11.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_priv.h	2005-04-12 21:50:11.000000000 +0900
@@ -60,7 +60,7 @@ extern void scsi_exit_hosts(void);
 extern int scsi_setup_command_freelist(struct Scsi_Host *shost);
 extern void scsi_destroy_command_freelist(struct Scsi_Host *shost);
 extern void scsi_done(struct scsi_cmnd *cmd);
-extern int scsi_retry_command(struct scsi_cmnd *cmd);
+extern void scsi_retry_command(struct scsi_cmnd *cmd);
 extern int scsi_insert_special_req(struct scsi_request *sreq, int);
 extern void scsi_init_cmd_from_req(struct scsi_cmnd *cmd,
 		struct scsi_request *sreq);

