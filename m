Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262297AbSJDTvC>; Fri, 4 Oct 2002 15:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262289AbSJDTvC>; Fri, 4 Oct 2002 15:51:02 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:30956 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262286AbSJDTuC>; Fri, 4 Oct 2002 15:50:02 -0400
Date: Fri, 4 Oct 2002 12:56:44 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi error update 2/3 (enh)
Message-ID: <20021004195644.GA14788@beaverton.ibm.com>
Mail-Followup-To: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20021004194427.GD9544@beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021004194427.GD9544@beaverton.ibm.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This series of patches is an update to scsi error handling.

00_scsi-error-base-1.diff:
	- Fix bug on incorrect check of scsi_eh_tur return value.
	- Fix debug printk format problems.
	- Removed ref to arch specific semaphore value in debug printk

01_scsi-error-enh-1.diff:
	- Forward port of Russell King's retry scsi cmd restore.
	- Adjustment of BUS_RESET_SETTLE_TIME from 5 seconds to 10 seconds
	  to provide increase time post bus_reset to allow door lock
	  command to succeed. This should be exported to driverfs so that
	  it can be adjusted if needed.
	- Error Policy change: Error recovery command retry is now not
	  based on failed command retry value.
	- Error Policy change: Failed command is not retried if retry
	  count is expired.

02_scsi-error-dr-lck-1.diff:
	- Forward port of Russell King's door lock changes.

Testing:
	- Current patches where tested on a SPI interconnect using both in
	  kernel and new versions of the aic driver. A Plextor SCSI cd-rom
	  was used for a door lock device. Cables where done during dd's
	  to generates errors and verify recover / door re-lock.

The full patch is available at:
http://www-124.ibm.com/storageio/patches/2.5/scsi-error

-andmike
--
Michael Anderson
andmike@us.ibm.com

 scsi.c       |   12 ++----
 scsi.h       |    1 
 scsi_error.c |  117 +++++++++++++++++++++++------------------------------------
 scsi_lib.c   |   26 ++++++++++++-
 4 files changed, 76 insertions(+), 80 deletions(-)
-----
diff -Nru a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
--- a/drivers/scsi/scsi.c	Fri Oct  4 08:37:58 2002
+++ b/drivers/scsi/scsi.c	Fri Oct  4 08:37:58 2002
@@ -1345,14 +1345,10 @@
  */
 int scsi_retry_command(Scsi_Cmnd * SCpnt)
 {
-	memcpy((void *) SCpnt->cmnd, (void *) SCpnt->data_cmnd,
-	       sizeof(SCpnt->data_cmnd));
-	SCpnt->request_buffer = SCpnt->buffer;
-	SCpnt->request_bufflen = SCpnt->bufflen;
-	SCpnt->use_sg = SCpnt->old_use_sg;
-	SCpnt->cmd_len = SCpnt->old_cmd_len;
-	SCpnt->sc_data_direction = SCpnt->sc_old_data_direction;
-	SCpnt->underflow = SCpnt->old_underflow;
+	/*
+	 * Restore the SCSI command state.
+	 */
+	scsi_setup_cmd_retry(SCpnt);
 
         /*
          * Zero the sense information from the last time we tried
diff -Nru a/drivers/scsi/scsi.h b/drivers/scsi/scsi.h
--- a/drivers/scsi/scsi.h	Fri Oct  4 08:37:58 2002
+++ b/drivers/scsi/scsi.h	Fri Oct  4 08:37:58 2002
@@ -467,6 +467,7 @@
 				   int sectors);
 extern struct Scsi_Device_Template *scsi_get_request_dev(struct request *);
 extern int scsi_init_cmd_errh(Scsi_Cmnd * SCpnt);
+extern void scsi_setup_cmd_retry(Scsi_Cmnd *SCpnt);
 extern int scsi_insert_special_cmd(Scsi_Cmnd * SCpnt, int);
 extern void scsi_io_completion(Scsi_Cmnd * SCpnt, int good_sectors,
 			       int block_sectors);
diff -Nru a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
--- a/drivers/scsi/scsi_error.c	Fri Oct  4 08:37:58 2002
+++ b/drivers/scsi/scsi_error.c	Fri Oct  4 08:37:58 2002
@@ -8,6 +8,10 @@
  *
  *	Restructured scsi_unjam_host and associated functions.
  *	September 04, 2002 Mike Anderson (andmike@us.ibm.com)
+ *
+ *	Forward port of Russell King's (rmk@arm.linux.org.uk) changes and
+ *	minor  cleanups.
+ *	September 30, 2002 Mike Anderson (andmike@us.ibm.com)
  */
 
 #include <linux/module.h>
@@ -59,7 +63,7 @@
  * These should *probably* be handled by the host itself.
  * Since it is allowed to sleep, it probably should.
  */
-#define BUS_RESET_SETTLE_TIME   5*HZ
+#define BUS_RESET_SETTLE_TIME   10*HZ
 #define HOST_RESET_SETTLE_TIME  10*HZ
 
 /**
@@ -279,12 +283,17 @@
 
 	SCSI_LOG_ERROR_RECOVERY(1, scsi_eh_prt_fail_stats(*sc_list, shost));
 
-	BUG_ON(shost->host_failed != found);
+	if (shost->host_failed != found)
+		printk(KERN_ERR "%s: host_failed: %d != found: %d\n", 
+		       __FUNCTION__, shost->host_failed, found);
 }
 
 /**
  * scsi_check_sense - Examine scsi cmd sense
  * @scmd:	Cmd to have sense checked.
+ *
+ * Return value:
+ * 	SUCCESS or FAILED or NEEDS_RETRY
  **/
 static int scsi_check_sense(Scsi_Cmnd *scmd)
 {
@@ -354,7 +363,6 @@
  **/
 static int scsi_eh_completed_normally(Scsi_Cmnd *scmd)
 {
-	int rtn;
 
 	/*
 	 * first check the host byte, to see if there is anything in there
@@ -370,7 +378,7 @@
 			 * SUCCESS.
 			 */
 			scmd->flags &= ~IS_RESETTING;
-			goto maybe_retry;
+			return NEEDS_RETRY;
 		}
 		/*
 		 * rats.  we are already in the error handler, so we now
@@ -378,10 +386,7 @@
 		 * is valid, we have a pretty good idea of what to do.
 		 * if not, we mark it as FAILED.
 		 */
-		rtn = scsi_check_sense(scmd);
-		if (rtn == NEEDS_RETRY)
-			goto maybe_retry;
-		return rtn;
+		return scsi_check_sense(scmd);
 	}
 	if (host_byte(scmd->result) != DID_OK) {
 		return FAILED;
@@ -401,10 +406,7 @@
 	case COMMAND_TERMINATED:
 		return SUCCESS;
 	case CHECK_CONDITION:
-		rtn = scsi_check_sense(scmd);
-		if (rtn == NEEDS_RETRY)
-			goto maybe_retry;
-		return rtn;
+		return scsi_check_sense(scmd);
 	case CONDITION_GOOD:
 	case INTERMEDIATE_GOOD:
 	case INTERMEDIATE_C_GOOD:
@@ -419,14 +421,6 @@
 		return FAILED;
 	}
 	return FAILED;
-
- maybe_retry:
-	if ((++scmd->retries) < scmd->allowed) {
-		return NEEDS_RETRY;
-	} else {
-		/* no more retries - report this one back to upper level */
-		return SUCCESS;
-	}
 }
 
 /**
@@ -490,7 +484,7 @@
  *    this case, and furthermore, there is a different completion handler
  *    vs scsi_dispatch_cmd.
  * Return value:
- *    SUCCESS/FAILED
+ *    SUCCESS or FAILED or NEEDS_RETRY
  **/
 static int scsi_send_eh_cmnd(Scsi_Cmnd *scmd, int timeout)
 {
@@ -500,7 +494,6 @@
 
 	ASSERT_LOCK(host->host_lock, 0);
 
-retry:
 	/*
 	 * we will use a queued command if possible, otherwise we will
 	 * emulate the queuing and calling of completion function ourselves.
@@ -577,16 +570,15 @@
 	 * actually did complete normally.
 	 */
 	if (rtn == SUCCESS) {
-		int ret = scsi_eh_completed_normally(scmd);
+		int rtn = scsi_eh_completed_normally(scmd);
 		SCSI_LOG_ERROR_RECOVERY(3,
 			printk("%s: scsi_eh_completed_normally %x\n",
-			       __FUNCTION__, ret));
-		switch (ret) {
+			       __FUNCTION__, rtn));
+		switch (rtn) {
 		case SUCCESS:
-			break;
 		case NEEDS_RETRY:
-			goto retry;
 		case FAILED:
+			break;
 		default:
 			rtn = FAILED;
 			break;
@@ -658,15 +650,8 @@
 	 * when we eventually call scsi_finish, we really wish to complete
 	 * the original request, so let's restore the original data. (db)
 	 */
-	memcpy((void *) scmd->cmnd, (void *) scmd->data_cmnd,
-	       sizeof(scmd->data_cmnd));
+	scsi_setup_cmd_retry(scmd);
 	scmd->result = saved_result;
-	scmd->request_buffer = scmd->buffer;
-	scmd->request_bufflen = scmd->bufflen;
-	scmd->use_sg = scmd->old_use_sg;
-	scmd->cmd_len = scmd->old_cmd_len;
-	scmd->sc_data_direction = scmd->sc_old_data_direction;
-	scmd->underflow = scmd->old_underflow;
 
 	/*
 	 * hey, we are done.  let's look to see what happened.
@@ -684,16 +669,16 @@
  **/
 static int scsi_eh_retry_cmd(Scsi_Cmnd *scmd)
 {
-	memcpy((void *) scmd->cmnd, (void *) scmd->data_cmnd,
-	       sizeof(scmd->data_cmnd));
-	scmd->request_buffer = scmd->buffer;
-	scmd->request_bufflen = scmd->bufflen;
-	scmd->use_sg = scmd->old_use_sg;
-	scmd->cmd_len = scmd->old_cmd_len;
-	scmd->sc_data_direction = scmd->sc_old_data_direction;
-	scmd->underflow = scmd->old_underflow;
+	int rtn = SUCCESS;
+
+	for (; scmd->retries < scmd->allowed; scmd->retries++) {
+		scsi_setup_cmd_retry(scmd);
+		rtn = scsi_send_eh_cmnd(scmd, scmd->timeout_per_command);
+		if (rtn != NEEDS_RETRY)
+			break;
+	}
 
-	return scsi_send_eh_cmnd(scmd, scmd->timeout_per_command);
+	return rtn;
 }
 
 /**
@@ -718,9 +703,7 @@
 	 * set this back so that the upper level can correctly free up
 	 * things.
 	 */
-	scmd->use_sg = scmd->old_use_sg;
-	scmd->sc_data_direction = scmd->sc_old_data_direction;
-	scmd->underflow = scmd->old_underflow;
+	scsi_setup_cmd_retry(scmd);
 }
 
 /**
@@ -848,7 +831,9 @@
 	static unsigned char tur_command[6] =
 	{TEST_UNIT_READY, 0, 0, 0, 0, 0};
 	int rtn;
+	int retry_cnt = 1;
 
+retry_tur:
 	memcpy((void *) scmd->cmnd, (void *) tur_command,
 	       sizeof(tur_command));
 
@@ -874,32 +859,18 @@
 	 * when we eventually call scsi_finish, we really wish to complete
 	 * the original request, so let's restore the original data. (db)
 	 */
-	memcpy((void *) scmd->cmnd, (void *) scmd->data_cmnd,
-	       sizeof(scmd->data_cmnd));
-	scmd->request_buffer = scmd->buffer;
-	scmd->request_bufflen = scmd->bufflen;
-	scmd->use_sg = scmd->old_use_sg;
-	scmd->cmd_len = scmd->old_cmd_len;
-	scmd->sc_data_direction = scmd->sc_old_data_direction;
-	scmd->underflow = scmd->old_underflow;
+	scsi_setup_cmd_retry(scmd);
 
 	/*
 	 * hey, we are done.  let's look to see what happened.
 	 */
-	SCSI_LOG_ERROR_RECOVERY(3,
-		printk("%s: scmd %p rtn %x\n",
+	SCSI_LOG_ERROR_RECOVERY(3, printk("%s: scmd %p rtn %x\n",
 		__FUNCTION__, scmd, rtn));
-	if ((rtn == SUCCESS) && scmd->result) {
-		if (((driver_byte(scmd->result) & DRIVER_SENSE) ||
-		     (status_byte(scmd->result) & CHECK_CONDITION)) &&
-		    (SCSI_SENSE_VALID(scmd))) {
-			if (((scmd->sense_buffer[2] & 0xf) != NOT_READY) &&
-			    ((scmd->sense_buffer[2] & 0xf) != UNIT_ATTENTION) &&
-			    ((scmd->sense_buffer[2] & 0xf) != ILLEGAL_REQUEST)) {
-				return 0;
-			}
-		}
-	}
+	if (rtn == SUCCESS)
+		return 0;
+	else if (rtn == NEEDS_RETRY)
+		if (retry_cnt--)
+			goto retry_tur;
 	return 1;
 }
 
@@ -964,6 +935,11 @@
 	rtn = scmd->host->hostt->eh_device_reset_handler(scmd);
 	spin_unlock_irqrestore(scmd->host->host_lock, flags);
 
+	if (rtn == SUCCESS) {
+		scmd->device->was_reset = 1;
+		scmd->device->expecting_cc_ua = 1;
+	}
+
 	return rtn;
 }
 
@@ -1422,8 +1398,7 @@
 		if ((shost->can_queue > 0 &&
 		     (shost->host_busy >= shost->can_queue))
 		    || (shost->host_blocked)
-		    || (shost->host_self_blocked)
-		    || (sdev->device_blocked)) {
+		    || (shost->host_self_blocked)) {
 			break;
 		}
 
@@ -1471,7 +1446,7 @@
 	if (scsi_eh_get_sense(sc_todo, shost))
 		if (scsi_eh_abort_cmd(sc_todo, shost))
 			if (scsi_eh_bus_device_reset(sc_todo, shost))
-				if(scsi_eh_bus_host_reset(sc_todo, shost))
+				if (scsi_eh_bus_host_reset(sc_todo, shost))
 					scsi_eh_offline_sdevs(sc_todo, shost);
 
 	BUG_ON(shost->host_failed);
diff -Nru a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
--- a/drivers/scsi/scsi_lib.c	Fri Oct  4 08:37:58 2002
+++ b/drivers/scsi/scsi_lib.c	Fri Oct  4 08:37:58 2002
@@ -160,6 +160,30 @@
 }
 
 /*
+ * Function:   scsi_setup_cmd_retry()
+ *
+ * Purpose:    Restore the command state for a retry
+ *
+ * Arguments:  SCpnt   - command to be restored
+ *
+ * Returns:    Nothing
+ *
+ * Notes:      Immediately prior to retrying a command, we need
+ *             to restore certain fields that we saved above.
+ */
+void scsi_setup_cmd_retry(Scsi_Cmnd *SCpnt)
+{
+	memcpy((void *) SCpnt->cmnd, (void *) SCpnt->data_cmnd,
+		sizeof(SCpnt->data_cmnd));
+	SCpnt->request_buffer = SCpnt->buffer;
+	SCpnt->request_bufflen = SCpnt->bufflen;
+	SCpnt->use_sg = SCpnt->old_use_sg;
+	SCpnt->cmd_len = SCpnt->old_cmd_len;
+	SCpnt->sc_data_direction = SCpnt->sc_old_data_direction;
+	SCpnt->underflow = SCpnt->old_underflow;
+}
+
+/*
  * Function:    scsi_queue_next_request()
  *
  * Purpose:     Handle post-processing of completed commands.
@@ -614,7 +638,7 @@
 			printk("scsi%d: ERROR on channel %d, id %d, lun %d, CDB: ",
 			       SCpnt->host->host_no, (int) SCpnt->channel,
 			       (int) SCpnt->target, (int) SCpnt->lun);
-			print_command(SCpnt->cmnd);
+			print_command(SCpnt->data_cmnd);
 			print_sense("sd", SCpnt);
 			SCpnt = scsi_end_request(SCpnt, 0, block_sectors);
 			return;
