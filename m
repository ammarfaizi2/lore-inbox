Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261950AbSJDT4o>; Fri, 4 Oct 2002 15:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262000AbSJDT4k>; Fri, 4 Oct 2002 15:56:40 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:19443 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261950AbSJDT4Z>; Fri, 4 Oct 2002 15:56:25 -0400
Date: Fri, 4 Oct 2002 13:03:06 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi error update 3/3 (door lck)
Message-ID: <20021004200306.GB14788@beaverton.ibm.com>
Mail-Followup-To: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20021004194427.GD9544@beaverton.ibm.com> <20021004195644.GA14788@beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021004195644.GA14788@beaverton.ibm.com>
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
	  was used for a door lock device. Cable pulls where done during dd's
	  to generates errors and verify recover / door re-lock.

The full patch is available at:
http://www-124.ibm.com/storageio/patches/2.5/scsi-error

-andmike
--
Michael Anderson
andmike@us.ibm.com

 drivers/scsi/scsi.h       |    1 
 drivers/scsi/scsi_error.c |   80 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/scsi_ioctl.c |   42 ++++++++++++++----------
 drivers/scsi/scsi_lib.c   |   27 ---------------
 drivers/scsi/scsi_syms.c  |    1 
 drivers/scsi/sd.c         |    4 +-
 drivers/scsi/sr_ioctl.c   |    4 +-
 include/scsi/scsi_ioctl.h |    8 ++--
 8 files changed, 115 insertions(+), 52 deletions(-)
------

diff -Nru a/drivers/scsi/scsi.h b/drivers/scsi/scsi.h
--- a/drivers/scsi/scsi.h	Fri Oct  4 08:59:02 2002
+++ b/drivers/scsi/scsi.h	Fri Oct  4 08:59:02 2002
@@ -597,6 +597,7 @@
 	unsigned changed:1;	/* Data invalid due to media change */
 	unsigned busy:1;	/* Used to prevent races */
 	unsigned lockable:1;	/* Able to prevent media removal */
+	unsigned locked:1;      /* Media removal disabled */
 	unsigned borken:1;	/* Tell the Seagate driver to be 
 				 * painfully slow on this device */
 	unsigned tagged_supported:1;	/* Supports SCSI-II tagged queuing */
diff -Nru a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
--- a/drivers/scsi/scsi_error.c	Fri Oct  4 08:59:02 2002
+++ b/drivers/scsi/scsi_error.c	Fri Oct  4 08:59:02 2002
@@ -39,6 +39,8 @@
 #include "scsi.h"
 #include "hosts.h"
 
+#include <scsi/scsi_ioctl.h> /* grr */
+
 /*
  * We must always allow SHUTDOWN_SIGS.  Even if we are not a module,
  * the host drivers that we are using may be loaded as modules, and
@@ -1361,6 +1363,75 @@
 }
 
 /**
+ * scsi_eh_lock_done - done function for eh door lock request
+ * @scmd:	SCSI command block for the door lock request
+ *
+ * Notes:
+ * 	We completed the asynchronous door lock request, and it has either
+ * 	locked the door or failed.  We must free the command structures
+ * 	associated with this request.
+ **/
+static void scsi_eh_lock_done(struct scsi_cmnd *scmd)
+{
+	struct scsi_request *sreq = scmd->sc_request;
+
+	scmd->sc_request = NULL;
+	sreq->sr_command = NULL;
+
+	scsi_release_command(scmd);
+	scsi_release_request(sreq);
+}
+
+
+/**
+ * scsi_eh_lock_door - Prevent medium removal for the specified device
+ * @sdev:	SCSI device to prevent medium removal
+ *
+ * Locking:
+ * 	We must be called from process context; scsi_allocate_request()
+ * 	may sleep.
+ *
+ * Notes:
+ * 	We queue up an asynchronous "ALLOW MEDIUM REMOVAL" request on the
+ * 	head of the devices request queue, and continue.
+ *
+ * Bugs:
+ * 	scsi_allocate_request() may sleep waiting for existing requests to
+ * 	be processed.  However, since we haven't kicked off any request
+ * 	processing for this host, this may deadlock.
+ *
+ *	If scsi_allocate_request() fails for what ever reason, we
+ *	completely forget to lock the door.
+ **/
+static void scsi_eh_lock_door(struct scsi_device *sdev)
+{
+	struct scsi_request *sreq = scsi_allocate_request(sdev);
+
+	if (sreq == NULL) {
+		printk(KERN_ERR "%s: request allocate failed,"
+		       "prevent media removal cmd not sent", __FUNCTION__);
+		return;
+	}
+
+	sreq->sr_cmnd[0] = ALLOW_MEDIUM_REMOVAL;
+	sreq->sr_cmnd[1] = (sdev->scsi_level <= SCSI_2) ? (sdev->lun << 5) : 0;
+	sreq->sr_cmnd[2] = 0;
+	sreq->sr_cmnd[3] = 0;
+	sreq->sr_cmnd[4] = SCSI_REMOVAL_PREVENT;
+	sreq->sr_cmnd[5] = 0;
+	sreq->sr_data_direction = SCSI_DATA_NONE;
+	sreq->sr_bufflen = 0;
+	sreq->sr_buffer = NULL;
+	sreq->sr_allowed = 5;
+	sreq->sr_done = scsi_eh_lock_done;
+	sreq->sr_timeout_per_command = 10 * HZ;
+	sreq->sr_cmd_len = COMMAND_SIZE(sreq->sr_cmnd[0]);
+
+	scsi_insert_special_req(sreq, 1);
+}
+
+
+/**
  * scsi_restart_operations - restart io operations to the specified host.
  * @shost:	Host we are restarting.
  *
@@ -1374,6 +1445,15 @@
 	unsigned long flags;
 
 	ASSERT_LOCK(shost->host_lock, 0);
+
+	/*
+	 * If the door was locked, we need to insert a door lock request
+	 * onto the head of the SCSI request queue for the device.  There
+	 * is no point trying to lock the door of an off-line device.
+	 */
+	for (sdev = shost->host_queue; sdev; sdev = sdev->next)
+		if (sdev->online && sdev->locked)
+			scsi_eh_lock_door(sdev);
 
 	/*
 	 * next free up anything directly waiting upon the host.  this
diff -Nru a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
--- a/drivers/scsi/scsi_ioctl.c	Fri Oct  4 08:59:02 2002
+++ b/drivers/scsi/scsi_ioctl.c	Fri Oct  4 08:59:02 2002
@@ -151,6 +151,29 @@
 	return result;
 }
 
+int scsi_set_medium_removal(Scsi_Device *dev, char state)
+{
+	char scsi_cmd[MAX_COMMAND_SIZE];
+	int ret;
+
+	if (!dev->removable || !dev->lockable)
+	       return 0;
+
+	scsi_cmd[0] = ALLOW_MEDIUM_REMOVAL;
+	scsi_cmd[1] = (dev->scsi_level <= SCSI_2) ? (dev->lun << 5) : 0;
+	scsi_cmd[2] = 0;
+	scsi_cmd[3] = 0;
+	scsi_cmd[4] = state;
+	scsi_cmd[5] = 0;
+
+	ret = ioctl_internal_command(dev, scsi_cmd, IOCTL_NORMAL_TIMEOUT, NORMAL_RETRIES);
+
+	if (ret == 0)
+		dev->locked = state == SCSI_REMOVAL_PREVENT;
+
+	return ret;
+}
+
 /*
  * This interface is deprecated - users should use the scsi generic (sg)
  * interface instead, as this is a more flexible approach to performing
@@ -448,24 +471,9 @@
 		return scsi_ioctl_send_command((Scsi_Device *) dev,
 					     (Scsi_Ioctl_Command *) arg);
 	case SCSI_IOCTL_DOORLOCK:
-		if (!dev->removable || !dev->lockable)
-			return 0;
-		scsi_cmd[0] = ALLOW_MEDIUM_REMOVAL;
-		scsi_cmd[1] = cmd_byte1;
-		scsi_cmd[2] = scsi_cmd[3] = scsi_cmd[5] = 0;
-		scsi_cmd[4] = SCSI_REMOVAL_PREVENT;
-		return ioctl_internal_command((Scsi_Device *) dev, scsi_cmd,
-				   IOCTL_NORMAL_TIMEOUT, NORMAL_RETRIES);
-		break;
+		return scsi_set_medium_removal(dev, SCSI_REMOVAL_PREVENT);
 	case SCSI_IOCTL_DOORUNLOCK:
-		if (!dev->removable || !dev->lockable)
-			return 0;
-		scsi_cmd[0] = ALLOW_MEDIUM_REMOVAL;
-		scsi_cmd[1] = cmd_byte1;
-		scsi_cmd[2] = scsi_cmd[3] = scsi_cmd[5] = 0;
-		scsi_cmd[4] = SCSI_REMOVAL_ALLOW;
-		return ioctl_internal_command((Scsi_Device *) dev, scsi_cmd,
-				   IOCTL_NORMAL_TIMEOUT, NORMAL_RETRIES);
+		return scsi_set_medium_removal(dev, SCSI_REMOVAL_ALLOW);
 	case SCSI_IOCTL_TEST_UNIT_READY:
 		scsi_cmd[0] = TEST_UNIT_READY;
 		scsi_cmd[1] = cmd_byte1;
diff -Nru a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
--- a/drivers/scsi/scsi_lib.c	Fri Oct  4 08:59:02 2002
+++ b/drivers/scsi/scsi_lib.c	Fri Oct  4 08:59:02 2002
@@ -804,33 +804,6 @@
 			SDpnt->starved = 0;
 		}
 
- 		/*
-		 * FIXME(eric)
-		 * I am not sure where the best place to do this is.  We need
-		 * to hook in a place where we are likely to come if in user
-		 * space.   Technically the error handling thread should be
-		 * doing this crap, but the error handler isn't used by
-		 * most hosts.
-		 */
-		if (SDpnt->was_reset) {
-			/*
-			 * We need to relock the door, but we might
-			 * be in an interrupt handler.  Only do this
-			 * from user space, since we do not want to
-			 * sleep from an interrupt.
-			 *
-			 * FIXME(eric) - have the error handler thread do
-			 * this work.
-			 */
-			SDpnt->was_reset = 0;
-			if (SDpnt->removable && !in_interrupt()) {
-				spin_unlock_irq(q->queue_lock);
-				scsi_ioctl(SDpnt, SCSI_IOCTL_DOORLOCK, 0);
-				spin_lock_irq(q->queue_lock);
-				continue;
-			}
-		}
-
 		/*
 		 * If we couldn't find a request that could be queued, then we
 		 * can also quit.
diff -Nru a/drivers/scsi/scsi_syms.c b/drivers/scsi/scsi_syms.c
--- a/drivers/scsi/scsi_syms.c	Fri Oct  4 08:59:02 2002
+++ b/drivers/scsi/scsi_syms.c	Fri Oct  4 08:59:02 2002
@@ -54,6 +54,7 @@
 EXPORT_SYMBOL(print_Scsi_Cmnd);
 EXPORT_SYMBOL(scsi_block_when_processing_errors);
 EXPORT_SYMBOL(scsi_ioctl_send_command);
+EXPORT_SYMBOL(scsi_set_medium_removal);
 #if defined(CONFIG_SCSI_LOGGING)	/* { */
 EXPORT_SYMBOL(scsi_logging_level);
 #endif
diff -Nru a/drivers/scsi/sd.c b/drivers/scsi/sd.c
--- a/drivers/scsi/sd.c	Fri Oct  4 08:59:02 2002
+++ b/drivers/scsi/sd.c	Fri Oct  4 08:59:02 2002
@@ -524,7 +524,7 @@
 	if (sdp->removable)
 		if (sdp->access_count==1)
 			if (scsi_block_when_processing_errors(sdp))
-				scsi_ioctl(sdp, SCSI_IOCTL_DOORLOCK, NULL);
+				scsi_set_medium_removal(sdp, SCSI_REMOVAL_PREVENT);
 
 	return 0;
 
@@ -568,7 +568,7 @@
 	if (sdp->removable) {
 		if (!sdp->access_count)
 			if (scsi_block_when_processing_errors(sdp))
-				scsi_ioctl(sdp, SCSI_IOCTL_DOORUNLOCK, NULL);
+				scsi_set_medium_removal(sdp, SCSI_REMOVAL_ALLOW);
 	}
 	if (sdp->host->hostt->module)
 		__MOD_DEC_USE_COUNT(sdp->host->hostt->module);
diff -Nru a/drivers/scsi/sr_ioctl.c b/drivers/scsi/sr_ioctl.c
--- a/drivers/scsi/sr_ioctl.c	Fri Oct  4 08:59:02 2002
+++ b/drivers/scsi/sr_ioctl.c	Fri Oct  4 08:59:02 2002
@@ -218,8 +218,8 @@
 {
 	Scsi_CD *cd = cdi->handle;
 
-	return scsi_ioctl(cd->device, lock ? SCSI_IOCTL_DOORLOCK :
-			SCSI_IOCTL_DOORUNLOCK, 0);
+	return scsi_set_medium_removal(cd->device, lock ?
+		       SCSI_REMOVAL_PREVENT : SCSI_REMOVAL_ALLOW);
 }
 
 int sr_drive_status(struct cdrom_device_info *cdi, int slot)
diff -Nru a/include/scsi/scsi_ioctl.h b/include/scsi/scsi_ioctl.h
--- a/include/scsi/scsi_ioctl.h	Fri Oct  4 08:59:02 2002
+++ b/include/scsi/scsi_ioctl.h	Fri Oct  4 08:59:02 2002
@@ -39,10 +39,10 @@
 	unsigned char host_wwn[8]; // include NULL term.
 } Scsi_FCTargAddress;
 
-extern int scsi_ioctl (Scsi_Device *dev, int cmd, void *arg);
-extern int kernel_scsi_ioctl (Scsi_Device *dev, int cmd, void *arg);
-extern int scsi_ioctl_send_command(Scsi_Device *dev,
-				   Scsi_Ioctl_Command *arg);
+extern int scsi_ioctl (Scsi_Device *, int , void *);
+extern int kernel_scsi_ioctl (Scsi_Device *, int, void *);
+extern int scsi_ioctl_send_command(Scsi_Device *, Scsi_Ioctl_Command *);
+extern int scsi_set_medium_removal(Scsi_Device *, char);
 
 #endif
 
