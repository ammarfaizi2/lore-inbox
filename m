Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261283AbTCFX35>; Thu, 6 Mar 2003 18:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261277AbTCFX3X>; Thu, 6 Mar 2003 18:29:23 -0500
Received: from hera.cwi.nl ([192.16.191.8]:38787 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261258AbTCFX11>;
	Thu, 6 Mar 2003 18:27:27 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 7 Mar 2003 00:37:57 +0100 (MET)
Message-Id: <UTC200303062337.h26Nbv714178.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] scsi_error fix
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below:
imm.c: spelling
scsi.h: remove old and now incorrect comment
scsi_scan.c: remove superfluous final return
scsi_error.c: apart from similar trivialities the only change:

    If a command fails (e.g. because it belongs to a newer
    SCSI version than the device), it is fed to
    scsi_decide_disposition(). That routine must return
    SUCCESS, unless the error handler should be invoked.

    In the situation where host_byte is DID_OK, and message_byte
    is COMMAND_COMPLETE, and status is CHECK_CONDITION, there is
    no reason at all to invoke aborts and resets. The situation
    is normal. I see here UNIT ATTENTION, Power on occurred
    and ILLEGAL REQUEST, Invalid field in cdb.

    The 2.5.64 code does not return SUCCESS, but it returns the
    return code of scsi_check_sense(), and that may be FAILED
    in case we do not have valid sense.

    Further discussion is possible here, but I changed the return
    into "return SUCCESS" and 2.5.64 boots fine.

Andries

[Further discussion and things I did not yet investigate:
What was changed to make this fail first in 2.5.63?
Experience shows that we get into a loop when something else
than SUCCESS is returned here. Probably that is a bug elsewhere.
Probably the commands that cause problems should never have been
sent in the first place.]

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/scsi/imm.c b/drivers/scsi/imm.c
--- a/drivers/scsi/imm.c	Sat Feb 15 20:41:59 2003
+++ b/drivers/scsi/imm.c	Thu Mar  6 23:50:31 2003
@@ -174,6 +174,7 @@
 	    parport_unregister_device(imm_hosts[i].dev);
 	    continue;
 	}
+
 	/* now the glue ... */
 	switch (imm_hosts[i].mode) {
 	case IMM_NIBBLE:
@@ -218,7 +219,7 @@
 
 /* This is to give the imm driver a way to modify the timings (and other
  * parameters) by writing to the /proc/scsi/imm/0 file.
- * Very simple method really... (To simple, no error checking :( )
+ * Very simple method really... (Too simple, no error checking :( )
  * Reason: Kernel hackers HATE having to unload and reload modules for
  * testing...
  * Also gives a method to use a script to obtain optimum timings (TODO)
@@ -948,7 +949,7 @@
     unsigned char l = 0, h = 0;
     int retv, x;
 
-    /* First check for any errors that may of occurred
+    /* First check for any errors that may have occurred
      * Here we check for internal errors
      */
     if (tmp->failed)
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/scsi/scsi.h b/drivers/scsi/scsi.h
--- a/drivers/scsi/scsi.h	Wed Mar  5 10:47:26 2003
+++ b/drivers/scsi/scsi.h	Thu Mar  6 23:50:31 2003
@@ -280,26 +280,7 @@
 #define SCSI_SET_IOCTL_LOGGING(LEVEL)  \
         SCSI_SET_LOGGING(SCSI_LOG_IOCTL_SHIFT, SCSI_LOG_IOCTL_BITS, LEVEL);
 
-/*
- *  the return of the status word will be in the following format :
- *  The low byte is the status returned by the SCSI command, 
- *  with vendor specific bits masked.
- *  
- *  The next byte is the message which followed the SCSI status.
- *  This allows a stos to be used, since the Intel is a little
- *  endian machine.
- *  
- *  The final byte is a host return code, which is one of the following.
- *  
- *  IE 
- *  lsb     msb
- *  status  msg host code   
- *  
- *  Our errors returned by OUR driver, NOT SCSI message.  Or'd with
- *  SCSI message passed back to driver <IF any>.
- */
-
-
+/* host byte codes */
 #define DID_OK          0x00	/* NO error                                */
 #define DID_NO_CONNECT  0x01	/* Couldn't connect before timeout period  */
 #define DID_BUS_BUSY    0x02	/* BUS stayed busy through time out period */
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
--- a/drivers/scsi/scsi_error.c	Mon Feb 24 23:02:52 2003
+++ b/drivers/scsi/scsi_error.c	Thu Mar  6 23:50:31 2003
@@ -92,10 +92,8 @@
  *
  * Notes:
  *    This should be turned into an inline function.  Each scsi command
- *    has it's own timer, and as it is added to the queue, we set up the
- *    timer.  When the command completes, we cancel the timer.  Pretty
- *    simple, really, especially compared to the old way of handling this
- *    crap.
+ *    has its own timer, and as it is added to the queue, we set up the
+ *    timer.  When the command completes, we cancel the timer.
  **/
 void scsi_add_timer(struct scsi_cmnd *scmd, int timeout,
 		    void (*complete)(struct scsi_cmnd *))
@@ -249,6 +247,7 @@
 {
 	if (!SCSI_SENSE_VALID(scmd))
 		return FAILED;
+
 	if (scmd->sense_buffer[2] & 0xe0)
 		return SUCCESS;
 
@@ -1193,12 +1192,12 @@
  * Notes:
  *    This is *only* called when we are examining the status after sending
  *    out the actual data command.  any commands that are queued for error
- *    recovery (i.e. test_unit_ready) do *not* come through here.
+ *    recovery (e.g. test_unit_ready) do *not* come through here.
  *
  *    When this routine returns failed, it means the error handler thread
- *    is woken.  in cases where the error code indicates an error that
+ *    is woken.  In cases where the error code indicates an error that
  *    doesn't require the error handler read (i.e. we don't need to
- *    abort/reset), then this function should return SUCCESS.
+ *    abort/reset), this function should return SUCCESS.
  **/
 int scsi_decide_disposition(struct scsi_cmnd *scmd)
 {
@@ -1214,11 +1213,11 @@
 						  __FUNCTION__));
 		return SUCCESS;
 	}
+
 	/*
 	 * first check the host byte, to see if there is anything in there
 	 * that would indicate what we need to do.
 	 */
-
 	switch (host_byte(scmd->result)) {
 	case DID_PASSTHROUGH:
 		/*
@@ -1296,11 +1295,11 @@
 	/*
 	 * next, check the message byte.
 	 */
-	if (msg_byte(scmd->result) != COMMAND_COMPLETE) {
+	if (msg_byte(scmd->result) != COMMAND_COMPLETE)
 		return FAILED;
-	}
+
 	/*
-	 * now, check the status byte to see if this indicates anything special.
+	 * check the status byte to see if this indicates anything special.
 	 */
 	switch (status_byte(scmd->result)) {
 	case QUEUE_FULL:
@@ -1321,10 +1320,11 @@
 		return SUCCESS;
 	case CHECK_CONDITION:
 		rtn = scsi_check_sense(scmd);
-		if (rtn == NEEDS_RETRY) {
+		if (rtn == NEEDS_RETRY)
 			goto maybe_retry;
-		}
-		return rtn;
+		/* if rtn == FAILED, we have no sense information */
+		/* was: return rtn; */
+		return SUCCESS;
 	case CONDITION_GOOD:
 	case INTERMEDIATE_GOOD:
 	case INTERMEDIATE_C_GOOD:
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
--- a/drivers/scsi/scsi_scan.c	Wed Mar  5 10:47:26 2003
+++ b/drivers/scsi/scsi_scan.c	Fri Mar  7 00:02:09 2003
@@ -960,7 +960,6 @@
 	SCSI_LOG_SCAN_BUS(3, printk(KERN_INFO "scsi scan: host %d channel %d"
 	    " id %d lun %d name/id: '%s'\n", sdev->host->host_no,
 	    sdev->channel, sdev->id, sdev->lun, sdev->sdev_driverfs_dev.name));
-	return;
 }
 
 /**
