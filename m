Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261771AbSJDTjU>; Fri, 4 Oct 2002 15:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261841AbSJDTjT>; Fri, 4 Oct 2002 15:39:19 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:57587 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261771AbSJDTjA>; Fri, 4 Oct 2002 15:39:00 -0400
Date: Fri, 4 Oct 2002 12:44:27 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi error update 1/3
Message-ID: <20021004194427.GD9544@beaverton.ibm.com>
Mail-Followup-To: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

 scsi_error.c |   78 +++++++++++++++++++++++++++++------------------------------
 1 files changed, 39 insertions(+), 39 deletions(-)
-----

diff -Nru a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
--- a/drivers/scsi/scsi_error.c	Fri Oct  4 08:04:49 2002
+++ b/drivers/scsi/scsi_error.c	Fri Oct  4 08:04:49 2002
@@ -91,9 +91,9 @@
 	scmd->eh_timeout.expires = jiffies + timeout;
 	scmd->eh_timeout.function = (void (*)(unsigned long)) complete;
 
-	SCSI_LOG_ERROR_RECOVERY(5, printk("Adding timer for command %p at"
-					  "%d (%p)\n", scmd, timeout,
-					  complete));
+	SCSI_LOG_ERROR_RECOVERY(5, printk("%s: scmd: %p, time:"
+					  " %d, (%p)\n", __FUNCTION__,
+					  scmd, timeout, complete));
 
 	add_timer(&scmd->eh_timeout);
 
@@ -116,8 +116,9 @@
 
 	rtn = del_timer(&scmd->eh_timeout);
 
-	SCSI_LOG_ERROR_RECOVERY(5, printk("Clearing timer for command %p"
-					 " %d\n", scmd, rtn));
+	SCSI_LOG_ERROR_RECOVERY(5, printk("%s: scmd: %p,"
+					 " rtn: %d\n", __FUNCTION__,
+					 scmd, rtn));
 
 	scmd->eh_timeout.data = (unsigned long) NULL;
 	scmd->eh_timeout.function = NULL;
@@ -150,7 +151,7 @@
 	scsi_host_failed_inc_and_test(scmd->host);
 
 	SCSI_LOG_TIMEOUT(3, printk("Command timed out active=%d busy=%d "
-				   "failed=%d\n",
+				   " failed=%d\n",
 				   atomic_read(&scmd->host->host_active),
 				   scmd->host->host_busy,
 				   scmd->host->host_failed));
@@ -173,7 +174,7 @@
 
 	SCSI_SLEEP(&sdev->host->host_wait, sdev->host->in_recovery);
 
-	SCSI_LOG_ERROR_RECOVERY(5, printk("Open returning %d\n",
+	SCSI_LOG_ERROR_RECOVERY(5, printk("%s: rtn: %d\n", __FUNCTION__,
 					  sdev->online));
 
 	return sdev->online;
@@ -209,10 +210,10 @@
 
 		if (cmd_timed_out || cmd_failed) {
 			SCSI_LOG_ERROR_RECOVERY(3,
-				printk("scsi_eh: %d:%d:%d:%d cmds failed: %d,"
-				       "timedout: %d\n",
-				       shost->host_no, sdev->channel,
-				       sdev->id, sdev->lun,
+				printk("%s: %d:%d:%d:%d cmds failed: %d,"
+				       " timedout: %d\n",
+				       __FUNCTION__, shost->host_no,
+				       sdev->channel, sdev->id, sdev->lun,
 				       cmd_failed, cmd_timed_out));
 			cmd_timed_out = 0;
 			cmd_failed = 0;
@@ -220,8 +221,8 @@
 		}
 	}
 
-	SCSI_LOG_ERROR_RECOVERY(2, printk("Total of %d commands on %d "
-					  "devices require eh work\n",
+	SCSI_LOG_ERROR_RECOVERY(2, printk("Total of %d commands on %d"
+					  " devices require eh work\n",
 				  total_failures, devices_failed));
 }
 #endif
@@ -265,10 +266,10 @@
 				 * queued and will be finished along the
 				 * way.
 				 */
-				SCSI_LOG_ERROR_RECOVERY(1, printk("Error hdlr "
-							  "prematurely woken "
-							  "cmds still active "
-							  "(%p %x %d)\n",
+				SCSI_LOG_ERROR_RECOVERY(1, printk("Error hdlr"
+							  " prematurely woken"
+							  " cmds still active"
+							  " (%p %x %d)\n",
 					       scmd, scmd->state,
 					       scmd->target));
 				}
@@ -440,12 +441,13 @@
 static void scsi_eh_times_out(Scsi_Cmnd *scmd)
 {
 	scsi_eh_eflags_set(scmd, SCSI_EH_REC_TIMEOUT);
-	SCSI_LOG_ERROR_RECOVERY(3, printk("in scsi_eh_times_out %p\n", scmd));
+	SCSI_LOG_ERROR_RECOVERY(3, printk("%s: scmd:%p\n", __FUNCTION__,
+					  scmd));
 
 	if (scmd->host->eh_action != NULL)
 		up(scmd->host->eh_action);
 	else
-		printk("missing scsi error handler thread\n");
+		printk("%s: eh_action NULL\n", __FUNCTION__);
 }
 
 /**
@@ -471,8 +473,8 @@
 
 	scmd->owner = SCSI_OWNER_ERROR_HANDLER;
 
-	SCSI_LOG_ERROR_RECOVERY(3, printk("in eh_done %p result:%x\n", scmd,
-					  scmd->result));
+	SCSI_LOG_ERROR_RECOVERY(3, printk("%s scmd: %p result: %x\n",
+					  __FUNCTION__, scmd, scmd->result));
 
 	if (scmd->host->eh_action != NULL)
 		up(scmd->host->eh_action);
@@ -552,9 +554,8 @@
 			
 			rtn = FAILED;
 		}
-		SCSI_LOG_ERROR_RECOVERY(3, printk("%s: %p rtn:%x\n",
-						  __FUNCTION__, scmd,
-						  rtn));
+		SCSI_LOG_ERROR_RECOVERY(3, printk("%s: scmd: %p, rtn:%x\n",
+						  __FUNCTION__, scmd, rtn));
 	} else {
 		int temp;
 
@@ -622,7 +623,7 @@
 	    ? &scsi_result0[0] : kmalloc(512, GFP_ATOMIC | GFP_DMA);
 
 	if (scsi_result == NULL) {
-		printk("cannot allocate scsi_result in scsi_request_sense.\n");
+		printk("%s: cannot allocate scsi_result.\n", __FUNCTION__);
 		return FAILED;
 	}
 	/*
@@ -758,14 +759,14 @@
 			continue;
 
 		SCSI_LOG_ERROR_RECOVERY(2, printk("%s: requesting sense"
-						  "for %d\n", __FUNCTION__,
-						  scmd->target));
+						  " for tgt: %d\n",
+						  __FUNCTION__, scmd->target));
 		rtn = scsi_request_sense(scmd);
 		if (rtn != SUCCESS)
 			continue;
 
 		SCSI_LOG_ERROR_RECOVERY(3, printk("sense requested for %p"
-						  "- result %x\n", scmd,
+						  " result %x\n", scmd,
 						  scmd->result));
 		SCSI_LOG_ERROR_RECOVERY(3, print_sense("bh", scmd));
 
@@ -929,7 +930,7 @@
 
 		rtn = scsi_try_to_abort_cmd(scmd);
 		if (rtn == SUCCESS) {
-			if (scsi_eh_tur(scmd)) {
+			if (!scsi_eh_tur(scmd)) {
 				rtn = scsi_eh_retry_cmd(scmd);
 				if (rtn == SUCCESS)
 					scsi_eh_finish_cmd(scmd, shost);
@@ -999,7 +1000,7 @@
 		 * a bus device reset to it.
 		 */
 		rtn = scsi_try_bus_device_reset(scmd);
-		if ((rtn == SUCCESS) && (scsi_eh_tur(scmd)))
+		if ((rtn == SUCCESS) && (!scsi_eh_tur(scmd)))
 				for (scmd = sc_todo; scmd; scmd = scmd->bh_next)
 					if ((scmd->device == sdev) &&
 					    scsi_eh_eflags_chk(scmd, SCSI_EH_CMD_ERR)) {
@@ -1141,7 +1142,7 @@
 				if (!scsi_eh_eflags_chk(scmd, SCSI_EH_CMD_ERR)
 				    || channel != scmd->channel)
 					continue;
-				if (scsi_eh_tur(scmd)) {
+				if (!scsi_eh_tur(scmd)) {
 					rtn = scsi_eh_retry_cmd(scmd);
 
 					if (rtn == SUCCESS)
@@ -1168,10 +1169,10 @@
 		if (!scsi_eh_eflags_chk(scmd, SCSI_EH_CMD_ERR))
 			continue;
 
-		printk(KERN_INFO "%s: Device set offline - not"
-				"ready or command retry failed"
-				"after error recovery: host"
-				"%d channel %d id %d lun %d\n",
+		printk(KERN_INFO "%s: Device offlined - not"
+				" ready or command retry failed"
+				" after error recovery: host"
+				" %d channel %d id %d lun %d\n",
 				__FUNCTION__, shost->host_no,
 				scmd->device->channel,
 				scmd->device->id,
@@ -1243,7 +1244,7 @@
 	 */
 	if (scmd->device->online == FALSE) {
 		SCSI_LOG_ERROR_RECOVERY(5, printk("%s: device offline - report"
-						  "as SUCCESS\n",
+						  " as SUCCESS\n",
 						  __FUNCTION__));
 		return SUCCESS;
 	}
@@ -1362,7 +1363,7 @@
 		goto maybe_retry;
 
 	case RESERVATION_CONFLICT:
-		printk("scsi%d (%d,%d,%d) : reservation conflict\n", 
+		printk("scsi%d (%d,%d,%d) : reservation conflict\n",
 		       scmd->host->host_no, scmd->channel,
 		       scmd->device->id, scmd->device->lun);
 		return SUCCESS; /* causes immediate i/o error */
@@ -1558,8 +1559,7 @@
 	/*
 	 * Wake up the thread that created us.
 	 */
-	SCSI_LOG_ERROR_RECOVERY(3, printk("Wake up parent %d\n",
-					  shost->eh_notify->count.counter));
+	SCSI_LOG_ERROR_RECOVERY(3, printk("Wake up parent \n"));
 
 	up(shost->eh_notify);
 
