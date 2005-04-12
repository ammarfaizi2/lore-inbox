Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262401AbVDLNy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262401AbVDLNy4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 09:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbVDLNx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 09:53:26 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:13335 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262411AbVDLMxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:53:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=cG9lBpZmY+3zdiQggoZhNLPFtZcaSHWRH3DIBLJgTd+HRP+L5TJlVtOtdOCHufwbgAR7ejiRg8PDhgnuN6KqnpMU/hUeiddSVqp5GK+eJsNj5yOHFtXhy6hrGZUEjp480rvWFgmEhX+Yh5oPLYakzH4xE03t8gSzEhwZKOimfF4=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050412125219.88E5C1F6@htj.dyndns.org>
In-Reply-To: <20050412125219.88E5C1F6@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 07/07] scsi: consolidate scsi_cmd_retry() calls
Message-ID: <20050412125219.424C8BE3@htj.dyndns.org>
Date: Tue, 12 Apr 2005 21:52:56 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

07_scsi_requeue_consolidate_setup_cmd_retry_calls_in_eh.patch

	scsi_setup_cmd_retry() is needed because scsi eh may alter
	scsi_cmnd to issue eh commands.  Consolidate calls to
	scsi_setup_cmd_retry() to one place in scsi_eh_flush_done_q().
	This change makes scsi_retry_command() more symmetrical with
	scsi_finish_command().

Signed-off-by: Tejun Heo <htejun@gmail.com>

 scsi.c       |    5 -----
 scsi_error.c |   31 +++++++------------------------
 2 files changed, 7 insertions(+), 29 deletions(-)

Index: scsi-reqfn-export/drivers/scsi/scsi.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi.c	2005-04-12 21:50:12.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi.c	2005-04-12 21:50:12.000000000 +0900
@@ -677,11 +677,6 @@ void scsi_retry_command(struct scsi_cmnd
 	scsi_device_unbusy(cmd->device);
 
 	/*
-	 * Restore the SCSI command state.
-	 */
-	scsi_setup_cmd_retry(cmd);
-
-	/*
 	 * Zero the sense information and result code from the last
 	 * time we tried this command.
 	 */
Index: scsi-reqfn-export/drivers/scsi/scsi_error.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_error.c	2005-04-12 21:50:11.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_error.c	2005-04-12 21:50:12.000000000 +0900
@@ -586,11 +586,6 @@ static int scsi_request_sense(struct scs
 
 	kfree(scsi_result);
 
-	/*
-	 * when we eventually call scsi_finish, we really wish to complete
-	 * the original request, so let's restore the original data. (db)
-	 */
-	scsi_setup_cmd_retry(scmd);
 	scmd->result = saved_result;
 	return rtn;
 }
@@ -612,14 +607,7 @@ static void scsi_eh_finish_cmd(struct sc
 {
 	scmd->device->host->host_failed--;
 	scmd->state = SCSI_STATE_BHQUEUE;
-
 	scsi_eh_eflags_clr_all(scmd);
-
-	/*
-	 * set this back so that the upper level can correctly free up
-	 * things.
-	 */
-	scsi_setup_cmd_retry(scmd);
 	list_move_tail(&scmd->eh_entry, done_q);
 }
 
@@ -756,12 +744,6 @@ retry_tur:
 	rtn = scsi_send_eh_cmnd(scmd, SENSE_TIMEOUT);
 
 	/*
-	 * when we eventually call scsi_finish, we really wish to complete
-	 * the original request, so let's restore the original data. (db)
-	 */
-	scsi_setup_cmd_retry(scmd);
-
-	/*
 	 * hey, we are done.  let's look to see what happened.
 	 */
 	SCSI_LOG_ERROR_RECOVERY(3, printk("%s: scmd %p rtn %x\n",
@@ -884,12 +866,6 @@ static int scsi_eh_try_stu(struct scsi_c
 	rtn = scsi_send_eh_cmnd(scmd, START_UNIT_TIMEOUT);
 
 	/*
-	 * when we eventually call scsi_finish, we really wish to complete
-	 * the original request, so let's restore the original data. (db)
-	 */
-	scsi_setup_cmd_retry(scmd);
-
-	/*
 	 * hey, we are done.  let's look to see what happened.
 	 */
 	SCSI_LOG_ERROR_RECOVERY(3, printk("%s: scmd %p rtn %x\n",
@@ -1515,6 +1491,13 @@ static void scsi_eh_flush_done_q(struct 
 	list_for_each_safe(lh, lh_sf, done_q) {
 		scmd = list_entry(lh, struct scsi_cmnd, eh_entry);
 		list_del_init(lh);
+
+		/*
+		 * Restore the SCSI command state such that we retry
+		 * or finish the original command.
+		 */
+		scsi_setup_cmd_retry(scmd);
+
 		if (scsi_device_online(scmd->device) &&
 		    !blk_noretry_request(scmd->request) &&
 		    (++scmd->retries < scmd->allowed)) {

