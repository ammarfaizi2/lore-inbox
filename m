Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310424AbSCBSzw>; Sat, 2 Mar 2002 13:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310423AbSCBSzg>; Sat, 2 Mar 2002 13:55:36 -0500
Received: from host194.steeleye.com ([216.33.1.194]:64521 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S310422AbSCBSzT>; Sat, 2 Mar 2002 13:55:19 -0500
Message-Id: <200203021855.g22ItAV11167@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [BK PATCH 2.5.6-pre2] Upport SCSI reset/reservation fixes from 
 2.4.19-pre2
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-10156000790"
Date: Sat, 02 Mar 2002 12:55:10 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-10156000790
Content-Type: text/plain; charset=us-ascii

The attached represents a straight port of the reset/reservation handling 
fixes that went into 2.4.19-pre2, except for the removal of calls into the old 
error handler.

James Bottomley


--==_Exmh_-10156000790
Content-Type: text/plain ; name="scsi-reset-2.5.6-pre2.diff"; charset=us-ascii
Content-Description: scsi-reset-2.5.6-pre2.diff
Content-Disposition: attachment; filename="scsi-reset-2.5.6-pre2.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.454   -> 1.455  
#	drivers/scsi/scsi_error.c	1.8     -> 1.9    
#	 drivers/scsi/scsi.h	1.9     -> 1.10   
#	drivers/scsi/scsi_syms.c	1.7     -> 1.8    
#	 drivers/scsi/scsi.c	1.24    -> 1.26   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/03/01	jejb@mulgrave.(none)	1.134.1.1
# scsi-reset-2.4.18.diff
# 
# SCSI reservation/reset handling
# 
# - Make both the old and the new error handlers respond correctly
#   to reservation conflicts (i.e. return an I/O error).
# 
# - Add a scsi_reset_provider() function for use by the sg driver
#   SCSI reset facility.
# --------------------------------------------
# 02/03/02	jejb@mulgrave.(none)	1.369.12.1
# Merge to 2.5.5
# --------------------------------------------
# 02/03/02	jejb@mulgrave.(none)	1.369.12.2
# SCSI reservation/reset handling
# 
# Tidy up and eliminate remaining references to old error handler.
# --------------------------------------------
# 02/03/02	jejb@mulgrave.(none)	1.455
# Merge mulgrave.(none):/home/jejb/BK/linux-2.5
# into mulgrave.(none):/home/jejb/BK/scsi-2.5
# --------------------------------------------
#
diff -Nru a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
--- a/drivers/scsi/scsi.c	Sat Mar  2 12:49:05 2002
+++ b/drivers/scsi/scsi.c	Sat Mar  2 12:49:05 2002
@@ -165,6 +165,11 @@
 void scsi_build_commandblocks(Scsi_Device * SDpnt);
 
 /*
+ * Private interface into the new error handling code.
+ */
+extern int scsi_new_reset(Scsi_Cmnd *SCpnt, unsigned int flag);
+
+/*
  * Function:    scsi_initialize_queue()
  *
  * Purpose:     Selects queue handler function for a device.
@@ -2660,6 +2665,94 @@
          */
 	scsi_release_commandblocks(SDpnt);
         kfree(SDpnt);
+}
+
+/*
+ * Function:	scsi_reset_provider_done_command
+ *
+ * Purpose:	Dummy done routine.
+ *
+ * Notes:	Some low level drivers will call scsi_done and end up here,
+ *		others won't bother.
+ *		We don't want the bogus command used for the bus/device
+ *		reset to find its way into the mid-layer so we intercept
+ *		it here.
+ */
+static void
+scsi_reset_provider_done_command(Scsi_Cmnd *SCpnt)
+{
+}
+
+/*
+ * Function:	scsi_reset_provider
+ *
+ * Purpose:	Send requested reset to a bus or device at any phase.
+ *
+ * Arguments:	device	- device to send reset to
+ *		flag - reset type (see scsi.h)
+ *
+ * Returns:	SUCCESS/FAILURE.
+ *
+ * Notes:	This is used by the SCSI Generic driver to provide
+ *		Bus/Device reset capability.
+ */
+int
+scsi_reset_provider(Scsi_Device *dev, int flag)
+{
+	Scsi_Cmnd SC, *SCpnt = &SC;
+	int rtn;
+
+	memset(&SCpnt->eh_timeout, 0, sizeof(SCpnt->eh_timeout));
+	SCpnt->host                    	= dev->host;
+	SCpnt->device                  	= dev;
+	SCpnt->target                  	= dev->id;
+	SCpnt->lun                     	= dev->lun;
+	SCpnt->channel                 	= dev->channel;
+	SCpnt->request.rq_status       	= RQ_SCSI_BUSY;
+	SCpnt->request.waiting        	= NULL;
+	SCpnt->use_sg                  	= 0;
+	SCpnt->old_use_sg              	= 0;
+	SCpnt->old_cmd_len             	= 0;
+	SCpnt->underflow               	= 0;
+	SCpnt->transfersize            	= 0;
+	SCpnt->resid			= 0;
+	SCpnt->serial_number           	= 0;
+	SCpnt->serial_number_at_timeout	= 0;
+	SCpnt->host_scribble           	= NULL;
+	SCpnt->next                    	= NULL;
+	SCpnt->state                   	= SCSI_STATE_INITIALIZING;
+	SCpnt->owner	     		= SCSI_OWNER_MIDLEVEL;
+    
+	memset(&SCpnt->cmnd, '\0', sizeof(SCpnt->cmnd));
+    
+	SCpnt->scsi_done		= scsi_reset_provider_done_command;
+	SCpnt->done			= NULL;
+	SCpnt->reset_chain		= NULL;
+        
+	SCpnt->buffer			= NULL;
+	SCpnt->bufflen			= 0;
+	SCpnt->request_buffer		= NULL;
+	SCpnt->request_bufflen		= 0;
+
+	SCpnt->internal_timeout		= NORMAL_TIMEOUT;
+	SCpnt->abort_reason		= DID_ABORT;
+
+	SCpnt->cmd_len			= 0;
+
+	SCpnt->sc_data_direction	= SCSI_DATA_UNKNOWN;
+	SCpnt->sc_request		= NULL;
+	SCpnt->sc_magic			= SCSI_CMND_MAGIC;
+
+	/*
+	 * Sometimes the command can get back into the timer chain,
+	 * so use the pid as an identifier.
+	 */
+	SCpnt->pid			= 0;
+
+        rtn = scsi_new_reset(SCpnt, flag);
+
+	scsi_delete_timer(SCpnt);
+	return rtn;
 }
 
 /*
diff -Nru a/drivers/scsi/scsi.h b/drivers/scsi/scsi.h
--- a/drivers/scsi/scsi.h	Sat Mar  2 12:49:05 2002
+++ b/drivers/scsi/scsi.h	Sat Mar  2 12:49:05 2002
@@ -834,6 +834,16 @@
 	current->state = TASK_RUNNING;	\
     }; }
 
+/*
+ * old style reset request from external source
+ * (private to sg.c and scsi_error.c, supplied by scsi_obsolete.c)
+ */
+#define SCSI_TRY_RESET_DEVICE	1
+#define SCSI_TRY_RESET_BUS	2
+#define SCSI_TRY_RESET_HOST	3
+
+extern int scsi_reset_provider(Scsi_Device *, int);
+
 #endif
 
 /*
diff -Nru a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
--- a/drivers/scsi/scsi_error.c	Sat Mar  2 12:49:05 2002
+++ b/drivers/scsi/scsi_error.c	Sat Mar  2 12:49:05 2002
@@ -979,15 +979,24 @@
 	case DID_SOFT_ERROR:
 		goto maybe_retry;
 
+	case DID_ERROR:
+		if (msg_byte(SCpnt->result) == COMMAND_COMPLETE &&
+		    status_byte(SCpnt->result) == RESERVATION_CONFLICT)
+			/*
+			 * execute reservation conflict processing code
+			 * lower down
+			 */
+			break;
+		/* FALLTHROUGH */
+
 	case DID_BUS_BUSY:
 	case DID_PARITY:
-	case DID_ERROR:
 		goto maybe_retry;
 	case DID_TIME_OUT:
 		/*
-		   * When we scan the bus, we get timeout messages for
-		   * these commands if there is no device available.
-		   * Other hosts report DID_NO_CONNECT for the same thing.
+		 * When we scan the bus, we get timeout messages for
+		 * these commands if there is no device available.
+		 * Other hosts report DID_NO_CONNECT for the same thing.
 		 */
 		if ((SCpnt->cmnd[0] == TEST_UNIT_READY ||
 		     SCpnt->cmnd[0] == INQUIRY)) {
@@ -1048,8 +1057,13 @@
 		 */
 		return SUCCESS;
 	case BUSY:
-	case RESERVATION_CONFLICT:
 		goto maybe_retry;
+
+	case RESERVATION_CONFLICT:
+		printk("scsi%d (%d,%d,%d) : RESERVATION CONFLICT\n", 
+		       SCpnt->host->host_no, SCpnt->channel,
+		       SCpnt->device->id, SCpnt->device->lun);
+		return SUCCESS; /* causes immediate I/O error */
 	default:
 		return FAILED;
 	}
@@ -1947,6 +1961,45 @@
 	 */
 	if (host->eh_notify != NULL)
 		up(host->eh_notify);
+}
+
+/*
+ * Function:	scsi_new_reset
+ *
+ * Purpose:	Send requested reset to a bus or device at any phase.
+ *
+ * Arguments:	SCpnt	- command ptr to send reset with (usually a dummy)
+ *		flag - reset type (see scsi.h)
+ *
+ * Returns:	SUCCESS/FAILURE.
+ *
+ * Notes:	This is used by the SCSI Generic driver to provide
+ *		Bus/Device reset capability.
+ */
+int
+scsi_new_reset(Scsi_Cmnd *SCpnt, int flag)
+{
+	int rtn;
+
+	switch(flag) {
+	case SCSI_TRY_RESET_DEVICE:
+		rtn = scsi_try_bus_device_reset(SCpnt, 0);
+		if (rtn == SUCCESS)
+			break;
+		/* FALLTHROUGH */
+	case SCSI_TRY_RESET_BUS:
+		rtn = scsi_try_bus_reset(SCpnt);
+		if (rtn == SUCCESS)
+			break;
+		/* FALLTHROUGH */
+	case SCSI_TRY_RESET_HOST:
+		rtn = scsi_try_host_reset(SCpnt);
+		break;
+	default:
+		rtn = FAILED;
+	}
+
+	return rtn;
 }
 
 /*
diff -Nru a/drivers/scsi/scsi_syms.c b/drivers/scsi/scsi_syms.c
--- a/drivers/scsi/scsi_syms.c	Sat Mar  2 12:49:05 2002
+++ b/drivers/scsi/scsi_syms.c	Sat Mar  2 12:49:05 2002
@@ -81,6 +81,11 @@
 EXPORT_SYMBOL(scsi_deregister_blocked_host);
 
 /*
+ * This symbol is for the highlevel drivers (e.g. sg) only.
+ */
+EXPORT_SYMBOL(scsi_reset_provider);
+
+/*
  * These are here only while I debug the rest of the scsi stuff.
  */
 EXPORT_SYMBOL(scsi_hostlist);

--==_Exmh_-10156000790
Content-Type: text/plain ; name="scsi-reset-2.5.6-pre2.BK"; charset=us-ascii
Content-Description: scsi-reset-2.5.6-pre2.BK
Content-Disposition: attachment; filename="scsi-reset-2.5.6-pre2.BK"

This BitKeeper patch contains the following changesets:
jejb@mulgrave.(none)|ChangeSet|20020302165845|33739
jejb@mulgrave.(none)|ChangeSet|20020302154055|34605
jejb@mulgrave.(none)|ChangeSet|20020302152614|34592
jejb@mulgrave.(none)|ChangeSet|20020302014116|59227
## Wrapped with gzip_uu ##


begin 664 bkpatch11112
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
58S@=GRNF.M#[U!#_!RJQNINC0```
`
end

--==_Exmh_-10156000790--


