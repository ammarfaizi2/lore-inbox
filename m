Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbVDJSzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVDJSzv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 14:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVDJSuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 14:50:18 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:45864 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261572AbVDJSpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 14:45:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=CFy+7jXxbH3fscpQgQkp1t3lEihuX0LjnfaDCUidimoGh/tjMJIs6cX+6kDwdvlZPTUBW00Hn4GjMwrNkpcmQnDZ0DlZ+9tyjsu60bVVtVgfgy786k2OofDPkvFtbTPA2M7/j0T7Ah7n01h4T+AptGVEaMvKfF234tykze4QMjU=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com, axboe@suse.de,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050410184214.4AAD0992@htj.dyndns.org>
In-Reply-To: <20050410184214.4AAD0992@htj.dyndns.org>
Subject: Re: [PATCH scsi-misc-2.6 05/07] scsi: unexport scsi_{add|delete}_timer()
Message-ID: <20050410184214.B4CD5D43@htj.dyndns.org>
Date: Mon, 11 Apr 2005 03:45:31 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

05_scsi_timer_unexport_timer_functions.patch

	SCSI cmd timer has specific synchronization/semantic
	requirements and shouldn't be directly used outside SCSI
	midlayer.  With aic7xxx driver updated, there's no user left.
	This patch unexports scsi_{add|delete}_timer() routines and
	also removes @complete argument from scsi_add_timer().  The
	change makes the use of scsi_times_out() confined in
	scsi_error.c, so move it upward such that no prototype is
	needed and make it static.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/scsi/scsi.c       |    2 -
 drivers/scsi/scsi_error.c |   80 +++++++++++++++++++++-------------------------
 drivers/scsi/scsi_priv.h  |    3 +
 include/scsi/scsi_eh.h    |    3 -
 4 files changed, 41 insertions(+), 47 deletions(-)

Index: scsi-reqfn-export/drivers/scsi/scsi.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi.c	2005-04-11 03:42:12.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi.c	2005-04-11 03:42:12.000000000 +0900
@@ -600,7 +600,7 @@ int scsi_dispatch_cmd(struct scsi_cmnd *
 	 * AK: unlikely race here: for some reason the timer could
 	 * expire before the serial number is set up below.
 	 */
-	scsi_add_timer(cmd, cmd->timeout_per_command, scsi_times_out);
+	scsi_add_timer(cmd, cmd->timeout_per_command);
 
 	scsi_log_send(cmd);
 
Index: scsi-reqfn-export/drivers/scsi/scsi_error.c
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_error.c	2005-04-11 03:42:12.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_error.c	2005-04-11 03:42:12.000000000 +0900
@@ -88,6 +88,42 @@ int scsi_eh_scmd_add(struct scsi_cmnd *s
 }
 
 /**
+ * scsi_times_out - Timeout function for normal scsi commands.
+ * @scmd:	Cmd that is timing out.
+ *
+ * Notes:
+ *     We do not need to lock this.  There is the potential for a race
+ *     only in that the normal completion handling might run, but if the
+ *     normal completion function determines that the timer has already
+ *     fired, then it mustn't do anything.
+ **/
+static void scsi_times_out(struct scsi_cmnd *scmd)
+{
+	scsi_log_completion(scmd, TIMEOUT_ERROR);
+
+	if (scmd->device->host->hostt->eh_timed_out)
+		switch (scmd->device->host->hostt->eh_timed_out(scmd)) {
+		case EH_HANDLED:
+			__scsi_done(scmd);
+			return;
+		case EH_RESET_TIMER:
+			/* This allows a single retry even of a command
+			 * with allowed == 0 */
+			if (scmd->retries++ > scmd->allowed)
+				break;
+			scsi_add_timer(scmd, scmd->timeout_per_command);
+			return;
+		case EH_NOT_HANDLED:
+			break;
+		}
+
+	if (unlikely(!scsi_eh_scmd_add(scmd, SCSI_EH_CANCEL_CMD))) {
+		panic("Error handler thread not present at %p %p %s %d",
+		      scmd, scmd->device->host, __FILE__, __LINE__);
+	}
+}
+
+/**
  * scsi_add_timer - Start timeout timer for a single scsi command.
  * @scmd:	scsi command that is about to start running.
  * @timeout:	amount of time to allow this command to run.
@@ -98,8 +134,7 @@ int scsi_eh_scmd_add(struct scsi_cmnd *s
  *    has its own timer, and as it is added to the queue, we set up the
  *    timer.  When the command completes, we cancel the timer.
  **/
-void scsi_add_timer(struct scsi_cmnd *scmd, int timeout,
-		    void (*complete)(struct scsi_cmnd *))
+void scsi_add_timer(struct scsi_cmnd *scmd, int timeout)
 {
 
 	/*
@@ -112,7 +147,7 @@ void scsi_add_timer(struct scsi_cmnd *sc
 
 	scmd->eh_timeout.data = (unsigned long)scmd;
 	scmd->eh_timeout.expires = jiffies + timeout;
-	scmd->eh_timeout.function = (void (*)(unsigned long)) complete;
+	scmd->eh_timeout.function = (void (*)(unsigned long))scsi_times_out;
 
 	SCSI_LOG_ERROR_RECOVERY(5, printk("%s: scmd: %p, time:"
 					  " %d, (%p)\n", __FUNCTION__,
@@ -120,7 +155,6 @@ void scsi_add_timer(struct scsi_cmnd *sc
 
 	add_timer(&scmd->eh_timeout);
 }
-EXPORT_SYMBOL(scsi_add_timer);
 
 /**
  * scsi_delete_timer - Delete/cancel timer for a given function.
@@ -148,44 +182,6 @@ int scsi_delete_timer(struct scsi_cmnd *
 
 	return rtn;
 }
-EXPORT_SYMBOL(scsi_delete_timer);
-
-/**
- * scsi_times_out - Timeout function for normal scsi commands.
- * @scmd:	Cmd that is timing out.
- *
- * Notes:
- *     We do not need to lock this.  There is the potential for a race
- *     only in that the normal completion handling might run, but if the
- *     normal completion function determines that the timer has already
- *     fired, then it mustn't do anything.
- **/
-void scsi_times_out(struct scsi_cmnd *scmd)
-{
-	scsi_log_completion(scmd, TIMEOUT_ERROR);
-
-	if (scmd->device->host->hostt->eh_timed_out)
-		switch (scmd->device->host->hostt->eh_timed_out(scmd)) {
-		case EH_HANDLED:
-			__scsi_done(scmd);
-			return;
-		case EH_RESET_TIMER:
-			/* This allows a single retry even of a command
-			 * with allowed == 0 */
-			if (scmd->retries++ > scmd->allowed)
-				break;
-			scsi_add_timer(scmd, scmd->timeout_per_command,
-				       scsi_times_out);
-			return;
-		case EH_NOT_HANDLED:
-			break;
-		}
-
-	if (unlikely(!scsi_eh_scmd_add(scmd, SCSI_EH_CANCEL_CMD))) {
-		panic("Error handler thread not present at %p %p %s %d",
-		      scmd, scmd->device->host, __FILE__, __LINE__);
-	}
-}
 
 /**
  * scsi_block_when_processing_errors - Prevent cmds from being queued.
Index: scsi-reqfn-export/drivers/scsi/scsi_priv.h
===================================================================
--- scsi-reqfn-export.orig/drivers/scsi/scsi_priv.h	2005-04-11 03:42:11.000000000 +0900
+++ scsi-reqfn-export/drivers/scsi/scsi_priv.h	2005-04-11 03:42:12.000000000 +0900
@@ -84,7 +84,8 @@ extern int __init scsi_init_devinfo(void
 extern void scsi_exit_devinfo(void);
 
 /* scsi_error.c */
-extern void scsi_times_out(struct scsi_cmnd *cmd);
+extern void scsi_add_timer(struct scsi_cmnd *scmd, int timeout);
+extern int scsi_delete_timer(struct scsi_cmnd *scmd);
 extern int scsi_error_handler(void *host);
 extern int scsi_decide_disposition(struct scsi_cmnd *cmd);
 extern void scsi_eh_wakeup(struct Scsi_Host *shost);
Index: scsi-reqfn-export/include/scsi/scsi_eh.h
===================================================================
--- scsi-reqfn-export.orig/include/scsi/scsi_eh.h	2005-04-11 03:42:10.000000000 +0900
+++ scsi-reqfn-export/include/scsi/scsi_eh.h	2005-04-11 03:42:12.000000000 +0900
@@ -27,9 +27,6 @@ struct scsi_sense_hdr {		/* See SPC-3 se
 };
 
 
-extern void scsi_add_timer(struct scsi_cmnd *, int,
-		void (*)(struct scsi_cmnd *));
-extern int scsi_delete_timer(struct scsi_cmnd *);
 extern void scsi_report_bus_reset(struct Scsi_Host *, int);
 extern void scsi_report_device_reset(struct Scsi_Host *, int, int);
 extern int scsi_block_when_processing_errors(struct scsi_device *);

