Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVDJStu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVDJStu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 14:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVDJSsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 14:48:19 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:12704 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261566AbVDJSpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 14:45:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=mGxRfZ+b7tRPnbXdEw/nG2fmS4xGuxGLdWCfKPCGn838YxF8Pkm5Lm5gkbtxNji//5PENZCXjVfptzSt2vZhv1H/uOxfNFQt+Nva1oup1deJtWXwgJLF+n3lwkN/VhSB4BP84xpYLTB/B6BJ3K+g0H/xgUdMiXpRatsdMOE1dbU=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050410184214.4AAD0992@htj.dyndns.org>
In-Reply-To: <20050410184214.4AAD0992@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 02/07] scsi: make scsi_send_eh_cmnd use its own timer instead of scmd->eh_timeout
Message-ID: <20050410184214.B68C4CBA@htj.dyndns.org>
Date: Mon, 11 Apr 2005 03:45:16 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

02_scsi_timer_eh_timer_fix.patch

	scmd->eh_timeout is used to resolve the race between command
	completion and timeout.  However, during error handling,
	scsi_send_eh_cmnd uses scmd->eh_timeout.  This creates a race
	condition between eh and normal completion for a request which
	has timed out and in the process of error handling.  If the
	request completes while scmd->eh_timeout is being used by eh,
	eh timeout is lost and the command will be handled by both eh
	and completion path.  This patch fixes the race by making
	scsi_send_eh_cmnd() use its own timer.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi_error.c |   64 ++++++++++++++++++-----------------------------------------
 scsi_priv.h  |    1 
 2 files changed, 20 insertions(+), 45 deletions(-)

Index: scsi-reqfn-export/drivers/scsi/scsi_error.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_error.c	2005-04-11 03:42:11.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_error.c	2005-04-11 03:42:11.000000000 +0900
@@ -420,46 +420,12 @@ static int scsi_eh_completed_normally(st
 }
 
 /**
- * scsi_eh_times_out - timeout function for error handling.
- * @scmd:	Cmd that is timing out.
- *
- * Notes:
- *    During error handling, the kernel thread will be sleeping waiting
- *    for some action to complete on the device.  our only job is to
- *    record that it timed out, and to wake up the thread.
- **/
-static void scsi_eh_times_out(struct scsi_cmnd *scmd)
-{
-	scsi_eh_eflags_set(scmd, SCSI_EH_REC_TIMEOUT);
-	SCSI_LOG_ERROR_RECOVERY(3, printk("%s: scmd:%p\n", __FUNCTION__,
-					  scmd));
-
-	if (scmd->device->host->eh_action)
-		up(scmd->device->host->eh_action);
-}
-
-/**
  * scsi_eh_done - Completion function for error handling.
  * @scmd:	Cmd that is done.
  **/
 static void scsi_eh_done(struct scsi_cmnd *scmd)
 {
-	/*
-	 * if the timeout handler is already running, then just set the
-	 * flag which says we finished late, and return.  we have no
-	 * way of stopping the timeout handler from running, so we must
-	 * always defer to it.
-	 */
-	if (del_timer(&scmd->eh_timeout)) {
-		scmd->request->rq_status = RQ_SCSI_DONE;
-		scmd->owner = SCSI_OWNER_ERROR_HANDLER;
-
-		SCSI_LOG_ERROR_RECOVERY(3, printk("%s scmd: %p result: %x\n",
-					   __FUNCTION__, scmd, scmd->result));
-
-		if (scmd->device->host->eh_action)
-			up(scmd->device->host->eh_action);
-	}
+	up(scmd->device->host->eh_action);
 }
 
 /**
@@ -478,6 +444,7 @@ static int scsi_send_eh_cmnd(struct scsi
 {
 	struct scsi_device *sdev = scmd->device;
 	struct Scsi_Host *shost = sdev->host;
+	struct timer_list timer;
 	DECLARE_MUTEX_LOCKED(sem);
 	unsigned long flags;
 	int rtn = SUCCESS;
@@ -492,7 +459,11 @@ static int scsi_send_eh_cmnd(struct scsi
 		scmd->cmnd[1] = (scmd->cmnd[1] & 0x1f) |
 			(sdev->lun << 5 & 0xe0);
 
-	scsi_add_timer(scmd, timeout, scsi_eh_times_out);
+	init_timer(&timer);
+	timer.expires = jiffies + timeout;
+	timer.function = (void (*)(unsigned long))scsi_eh_done;
+	timer.data = (unsigned long)scmd;
+	add_timer(&timer);
 
 	/*
 	 * set up the semaphore so we wait for the command to complete.
@@ -508,14 +479,19 @@ static int scsi_send_eh_cmnd(struct scsi
 	down(&sem);
 	scsi_log_completion(scmd, SUCCESS);
 
-	shost->eh_action = NULL;
-
-	/*
-	 * see if timeout.  if so, tell the host to forget about it.
-	 * in other words, we don't want a callback any more.
-	 */
-	if (scsi_eh_eflags_chk(scmd, SCSI_EH_REC_TIMEOUT)) {
-		scsi_eh_eflags_clr(scmd,  SCSI_EH_REC_TIMEOUT);
+	if (del_timer(&timer)) {
+		SCSI_LOG_ERROR_RECOVERY(3,
+			printk("scsi_eh_done scmd: %p result: %x\n",
+			       scmd, scmd->result));
+		scmd->request->rq_status = RQ_SCSI_DONE;
+		scmd->owner = SCSI_OWNER_ERROR_HANDLER;
+	} else {
+		/*
+		 * Timed out.  Tell the host to forget about it.  In
+		 * other words, we don't want a callback any more.
+		 */
+		SCSI_LOG_ERROR_RECOVERY(3,
+			printk("scsi_eh_times_out scmd: %p\n", scmd));
 		scmd->owner = SCSI_OWNER_LOWLEVEL;
 
 		/*
Index: scsi-reqfn-export/drivers/scsi/scsi_priv.h
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_priv.h	2005-04-11 03:42:10.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_priv.h	2005-04-11 03:42:11.000000000 +0900
@@ -42,7 +42,6 @@ struct Scsi_Host;
 	(scp->eh_eflags = 0)
 
 #define SCSI_EH_CANCEL_CMD	0x0001	/* Cancel this cmd */
-#define SCSI_EH_REC_TIMEOUT	0x0002	/* EH retry timed out */
 
 #define SCSI_SENSE_VALID(scmd) \
 	(((scmd)->sense_buffer[0] & 0x70) == 0x70)

