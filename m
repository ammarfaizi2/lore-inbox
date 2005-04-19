Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVDSOmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVDSOmP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 10:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVDSOcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 10:32:12 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:665 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261558AbVDSObL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 10:31:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=Y+0TbZwd8XiVCtGrWcv/cWve+6BdvOBgFdxcM0WybrEeIBHGeMMlfx37mEf9MR1KOJUDORh13p3IwSwGPiWjK2OxgjxWavYNafycLiZ+v//xLbKvmrnlk9JQF1zk/Hqt554gYvE7yI1ZaJuah1BSu/JVSUObSP4YYfyzL5xgGCQ=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050419143100.E231523D@htj.dyndns.org>
In-Reply-To: <20050419143100.E231523D@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 01/04] scsi: make scsi_send_eh_cmnd use its own timer instead of scmd->eh_timeout
Message-ID: <20050419143100.0F9A8C3B@htj.dyndns.org>
Date: Tue, 19 Apr 2005 23:31:06 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

01_scsi_timer_eh_timer_fix.patch

	scmd->eh_timeout is used to resolve the race between command
	completion and timeout.  However, during error handling,
	scsi_send_eh_cmnd uses scmd->eh_timeout.  This creates a race
	condition between eh and normal completion for a request which
	has timed out and in the process of error handling.  If the
	request completes while scmd->eh_timeout is being used by eh,
	eh timeout is lost and the command will be handled by both eh
	and completion path.  This patch fixes the race by making
	scsi_send_eh_cmnd() use its own timer.

	This patch adds shost->eh_timeout field.  The name of the
	field equals scmd->eh_timeout which is used for normal command
	timeout.  As this can be confusing, renaming scmd->eh_timeout
	to something like scmd->cmd_timeout would be good.

	Reworked such that timeout race window is kept at minimal
	level as pointed out by James Bottomley.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/scsi/scsi_error.c |   26 ++++++++++++++++++++------
 include/scsi/scsi_host.h  |    1 +
 2 files changed, 21 insertions(+), 6 deletions(-)

Index: scsi-reqfn-export/drivers/scsi/scsi_error.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_error.c	2005-04-19 23:28:33.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_error.c	2005-04-19 23:30:57.000000000 +0900
@@ -428,8 +428,10 @@ static int scsi_eh_completed_normally(st
  *    for some action to complete on the device.  our only job is to
  *    record that it timed out, and to wake up the thread.
  **/
-static void scsi_eh_times_out(struct scsi_cmnd *scmd)
+static void scsi_eh_times_out(unsigned long arg)
 {
+	struct scsi_cmnd *scmd = (void *)arg;
+
 	scsi_eh_eflags_set(scmd, SCSI_EH_REC_TIMEOUT);
 	SCSI_LOG_ERROR_RECOVERY(3, printk("%s: scmd:%p\n", __FUNCTION__,
 					  scmd));
@@ -448,9 +450,11 @@ static void scsi_eh_done(struct scsi_cmn
 	 * if the timeout handler is already running, then just set the
 	 * flag which says we finished late, and return.  we have no
 	 * way of stopping the timeout handler from running, so we must
-	 * always defer to it.
+	 * always defer to it.  note that by doing timer removal here
+	 * the window in which normally completed commands are treated
+	 * as timed out is kept at minimal level.
 	 */
-	if (del_timer(&scmd->eh_timeout)) {
+	if (del_timer(scmd->device->host->eh_timeout)) {
 		scmd->request->rq_status = RQ_SCSI_DONE;
 		scmd->owner = SCSI_OWNER_ERROR_HANDLER;
 
@@ -478,6 +482,7 @@ static int scsi_send_eh_cmnd(struct scsi
 {
 	struct scsi_device *sdev = scmd->device;
 	struct Scsi_Host *shost = sdev->host;
+	struct timer_list timer;
 	DECLARE_MUTEX_LOCKED(sem);
 	unsigned long flags;
 	int rtn = SUCCESS;
@@ -492,7 +497,15 @@ static int scsi_send_eh_cmnd(struct scsi
 		scmd->cmnd[1] = (scmd->cmnd[1] & 0x1f) |
 			(sdev->lun << 5 & 0xe0);
 
-	scsi_add_timer(scmd, timeout, scsi_eh_times_out);
+	/*
+	 * set up eh timer.
+	 */
+	shost->eh_timeout = &timer;
+	init_timer(&timer);
+	timer.expires = jiffies + timeout;
+	timer.function = scsi_eh_times_out;
+	timer.data = (unsigned long)scmd;
+	add_timer(&timer);
 
 	/*
 	 * set up the semaphore so we wait for the command to complete.
@@ -508,8 +521,6 @@ static int scsi_send_eh_cmnd(struct scsi
 	down(&sem);
 	scsi_log_completion(scmd, SUCCESS);
 
-	shost->eh_action = NULL;
-
 	/*
 	 * see if timeout.  if so, tell the host to forget about it.
 	 * in other words, we don't want a callback any more.
@@ -539,6 +550,9 @@ static int scsi_send_eh_cmnd(struct scsi
 		rtn = FAILED;
 	}
 
+	shost->eh_action = NULL;
+	shost->eh_timeout = NULL;
+
 	SCSI_LOG_ERROR_RECOVERY(3, printk("%s: scmd: %p, rtn:%x\n",
 					  __FUNCTION__, scmd, rtn));
 
Index: scsi-reqfn-export/include/scsi/scsi_host.h
===================================================================
--- scsi-reqfn-export.orig/include/scsi/scsi_host.h	2005-04-19 23:28:33.000000000 +0900
+++ scsi-reqfn-export/include/scsi/scsi_host.h	2005-04-19 23:30:57.000000000 +0900
@@ -442,6 +442,7 @@ struct Scsi_Host {
 	struct completion     * eh_notify; /* wait for eh to begin or end */
 	struct semaphore      * eh_action; /* Wait for specific actions on the
                                           host. */
+	struct timer_list     * eh_timeout;  /* Used to timeout eh commands */
 	unsigned int            eh_active:1; /* Indicates the eh thread is awake and active if
                                           this is true. */
 	unsigned int            eh_kill:1; /* set when killing the eh thread */

