Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316906AbSGCVMq>; Wed, 3 Jul 2002 17:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317232AbSGCVMp>; Wed, 3 Jul 2002 17:12:45 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:40680 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S316906AbSGCVMg>;
	Wed, 3 Jul 2002 17:12:36 -0400
Message-ID: <3D236950.5020307@colorfullife.com>
Date: Wed, 03 Jul 2002 23:14:56 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-usb-devel@lists.sourceforge.net
CC: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: usb storage cleanup
Content-Type: multipart/mixed;
 boundary="------------080101040807050004080307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080101040807050004080307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Attached is a cleanup for usb-storage.

Mainly it's an update to the synchonization: there were a few small 
races left.
I've added a complete changelog into usb.h.

The patch is vs 2.5.24-dj2. I've tested it with my SaroTech device, 
please test it with other usb storage devices.

--
	Manfred


--------------080101040807050004080307
Content-Type: text/plain;
 name="patch-usbstor-2.5.24d"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-usbstor-2.5.24d"

diff -u 2.5/drivers/usb/storage/freecom.c build-2.5/drivers/usb/storage/freecom.c
--- 2.5/drivers/usb/storage/freecom.c	Tue Jun  4 20:39:19 2002
+++ build-2.5/drivers/usb/storage/freecom.c	Wed Jul  3 20:31:14 2002
@@ -191,7 +191,7 @@
                                 result, partial);
 
 		/* has the current command been aborted? */
-		if (atomic_read(&us->sm_state) == US_STATE_ABORTING) {
+		if (us->abort_cmd) {
 			US_DEBUGP("freecom_readdata(): transfer aborted\n");
 			return US_BULK_TRANSFER_ABORTED;
 		}
@@ -232,7 +232,7 @@
                                 result, partial);
 
 		/* has the current command been aborted? */
-		if (atomic_read(&us->sm_state) == US_STATE_ABORTING) {
+		if (us->abort_cmd) {
 			US_DEBUGP("freecom_writedata(): transfer aborted\n");
 			return US_BULK_TRANSFER_ABORTED;
 		}
@@ -295,7 +295,7 @@
                                 result, partial);
 
 		/* we canceled this transfer */
-		if (atomic_read(&us->sm_state) == US_STATE_ABORTING) {
+		if (us->abort_cmd) {
 			US_DEBUGP("freecom_transport(): transfer aborted\n");
 			return US_BULK_TRANSFER_ABORTED;
 		}
@@ -310,7 +310,7 @@
         US_DEBUGP("foo Status result %d %d\n", result, partial);
 
 	/* we canceled this transfer */
-	if (atomic_read(&us->sm_state) == US_STATE_ABORTING) {
+	if (us->abort_cmd) {
 		US_DEBUGP("freecom_transport(): transfer aborted\n");
 		return US_BULK_TRANSFER_ABORTED;
 	}
@@ -348,7 +348,7 @@
 					result, partial);
 
 			/* we canceled this transfer */
-			if (atomic_read(&us->sm_state) == US_STATE_ABORTING) {
+			if (us->abort_cmd) {
 				US_DEBUGP("freecom_transport(): transfer aborted\n");
 				return US_BULK_TRANSFER_ABORTED;
 			}
@@ -363,7 +363,7 @@
 		US_DEBUGP("bar Status result %d %d\n", result, partial);
 
 		/* we canceled this transfer */
-		if (atomic_read(&us->sm_state) == US_STATE_ABORTING) {
+		if (us->abort_cmd) {
 			US_DEBUGP("freecom_transport(): transfer aborted\n");
 			return US_BULK_TRANSFER_ABORTED;
 		}
@@ -424,7 +424,7 @@
                                 FCM_PACKET_LENGTH, &partial);
 		US_DEBUG(pdump ((void *) fst, partial));
 
-		if (atomic_read(&us->sm_state) == US_STATE_ABORTING) {
+		if (us->abort_cmd) {
                         US_DEBUGP ("freecom_transport: transfer aborted\n");
                         return US_BULK_TRANSFER_ABORTED;
                 }
@@ -453,7 +453,7 @@
                 result = usb_stor_bulk_msg (us, fst, ipipe,
                                 FCM_PACKET_LENGTH, &partial);
 
-		if (atomic_read(&us->sm_state) == US_STATE_ABORTING) {
+		if (us->abort_cmd) {
                         US_DEBUGP ("freecom_transport: transfer aborted\n");
                         return US_BULK_TRANSFER_ABORTED;
                 }
diff -u 2.5/drivers/usb/storage/scsiglue.c build-2.5/drivers/usb/storage/scsiglue.c
--- 2.5/drivers/usb/storage/scsiglue.c	Tue Jun 25 20:24:18 2002
+++ build-2.5/drivers/usb/storage/scsiglue.c	Wed Jul  3 20:35:42 2002
@@ -104,6 +104,7 @@
  * NOTE: There is no contention here, because we're already deregistered
  * the driver and we're doing each virtual host in turn, not in parallel
  * Synchronization: BLK, no spinlock.
+ * The function sleeps, no need for _irqsave.
  */
 static int release(struct Scsi_Host *psh)
 {
@@ -117,7 +118,11 @@
 	 * notification that it's exited.
 	 */
 	US_DEBUGP("-- sending US_ACT_EXIT command to thread\n");
+
+	spin_lock_irq(&us->queue_exclusion);
 	us->action = US_ACT_EXIT;
+	BUG_ON(us->srb != NULL);
+	spin_unlock_irq(&us->queue_exclusion);
 	
 	up(&(us->sema));
 	wait_for_completion(&(us->notify));
@@ -150,7 +155,8 @@
 	spin_lock_irqsave(&us->queue_exclusion, flags);
 
 	/* enqueue the command */
-	us->queue_srb = srb;
+	BUG_ON(us->srb != NULL);
+	us->srb = srb;
 	srb->scsi_done = done;
 	us->action = US_ACT_COMMAND;
 
@@ -174,12 +180,9 @@
 
 	US_DEBUGP("command_abort() called\n");
 
-	if (atomic_read(&us->sm_state) == US_STATE_RUNNING) {
+	if (us->srb) {
  		scsi_unlock(srb->host);
-		usb_stor_abort_transport(us);
-
-		/* wait for us to be done */
-		wait_for_completion(&(us->notify));
+		usb_stor_abort_transport(us, 0);
  		scsi_lock(srb->host);
 		return SUCCESS;
 	}
@@ -198,16 +201,25 @@
 	US_DEBUGP("device_reset() called\n" );
 
 	/* if the device was removed, then we're already reset */
-	if (!test_bit(DEV_ATTACHED, &us->bitflags))
-		return SUCCESS;
 
 	scsi_unlock(srb->host);
 	/* lock the device pointers */
 	down(&(us->dev_semaphore));
-	us->srb = srb;
-	atomic_set(&us->sm_state, US_STATE_RESETTING);
-	result = us->transport_reset(us);
-	atomic_set(&us->sm_state, US_STATE_IDLE);
+	/* previous commands were stopped with command_abort(),
+	 * and the scsi midlayer prevents new commands from comming
+	 * in until device_reset returns.
+	 */
+	BUG_ON(us->srb != NULL);
+	BUG_ON(us->sm_state != US_STATE_IDLE);
+	if (us->pusb_dev == NULL) {
+		result = SUCCESS;
+	} else {
+		us->srb = srb;
+		us->sm_state = US_STATE_RESETTING;
+		result = us->transport_reset(us);
+		us->srb = NULL;
+		us->sm_state = US_STATE_IDLE;
+	}
 
 	/* unlock the device pointers */
 	up(&(us->dev_semaphore));
@@ -215,68 +227,18 @@
 	return result;
 }
 
-/* This resets the device port, and simulates the device
- * disconnect/reconnect for all drivers which have claimed
- * interfaces, including ourself. */
+/* FIXME: is that the best we can do? */
 static int bus_reset( Scsi_Cmnd *srb )
 {
-	struct us_data *us = (struct us_data *)srb->host->hostdata[0];
-	int i;
-	int result;
-	struct usb_device *pusb_dev_save = us->pusb_dev;
-
-	/* we use the usb_reset_device() function to handle this for us */
-	US_DEBUGP("bus_reset() called\n");
-
-	/* if the device has been removed, this worked */
-	if (!test_bit(DEV_ATTACHED, &us->bitflags)) {
-		US_DEBUGP("-- device removed already\n");
-		return SUCCESS;
-	}
-
-	/* attempt to reset the port */
-	scsi_unlock(srb->host);
-	result = usb_reset_device(pusb_dev_save);
-	US_DEBUGP("usb_reset_device returns %d\n", result);
-	if (result < 0) {
-		scsi_lock(srb->host);
-		return FAILED;
-	}
-
-	/* FIXME: This needs to lock out driver probing while it's working
-	 * or we can have race conditions */
-	/* Is that still true?  I don't see how...  AS */
-	for (i = 0; i < pusb_dev_save->actconfig->bNumInterfaces; i++) {
- 		struct usb_interface *intf =
-			&pusb_dev_save->actconfig->interface[i];
-		const struct usb_device_id *id;
-
-		/* if this is an unclaimed interface, skip it */
-		if (!intf->driver) {
-			continue;
-		}
-
-		US_DEBUGP("Examining driver %s...", intf->driver->name);
-
-		/* simulate a disconnect and reconnect for all interfaces */
-		US_DEBUGPX("simulating disconnect/reconnect.\n");
-		down(&intf->driver->serialize);
-		intf->driver->disconnect(pusb_dev_save, intf->private_data);
-		id = usb_match_id(pusb_dev_save, intf, intf->driver->id_table);
-		intf->driver->probe(pusb_dev_save, i, id);
-		up(&intf->driver->serialize);
-	}
-	US_DEBUGP("bus_reset() complete\n");
-	scsi_lock(srb->host);
-	return SUCCESS;
+	printk(KERN_INFO "usb-storage: bus_reset() requested but not implemented\n" );
+	return device_reset(srb);
 }
 
-/* FIXME: This doesn't do anything right now */
+/* FIXME: is that the best we can do? */
 static int host_reset( Scsi_Cmnd *srb )
 {
-	printk(KERN_CRIT "usb-storage: host_reset() requested but not implemented\n" );
-	bus_reset(srb);
-	return FAILED;
+	printk(KERN_INFO "usb-storage: host_reset() requested but not implemented\n" );
+	return device_reset(srb);
 }
 
 /***********************************************************************
@@ -309,7 +271,12 @@
 		us = us->next;
 	}
 
-	/* release our lock on the data structures */
+	/* Release our lock on the data structures early.
+	 * The only function that frees us structures is
+	 * usb_stor_exit(), and that happens after
+	 * scsi_unregister_host, i.e. never while the
+	 * /proc interface is in use.
+	 */
 	up(&us_list_semaphore);
 
 	/* if we couldn't find it, we return an error */
@@ -331,8 +298,7 @@
 
 	/* show the GUID of the device */
 	SPRINTF("         GUID: " GUID_FORMAT "\n", GUID_ARGS(us->guid));
-	SPRINTF("     Attached: %s\n", (test_bit(DEV_ATTACHED, &us->bitflags)
-			? "Yes" : "No"));
+	SPRINTF("     Attached: %s\n", (us->pusb_dev != NULL) ? "Yes" : "No");
 
 	/*
 	 * Calculate start of next buffer, and return value.
@@ -370,6 +336,7 @@
 	this_id:		-1,
 
 	sg_tablesize:		SG_ALL,
+	max_sectors:	128,
 	cmd_per_lun:		1,
 	present:		0,
 	unchecked_isa_dma:	FALSE,
diff -u 2.5/drivers/usb/storage/transport.c build-2.5/drivers/usb/storage/transport.c
--- 2.5/drivers/usb/storage/transport.c	Tue Jun  4 20:39:19 2002
+++ build-2.5/drivers/usb/storage/transport.c	Wed Jul  3 20:36:17 2002
@@ -357,21 +357,21 @@
  * We're very concered about races with a command abort.  Hanging this code is
  * a sure fire way to hang the kernel.
  *
- * The abort function first sets the machine state, then tries to acquire the
+ * The abort function first sets abort_cmd, then tries to acquire the
  * lock on the current_urb to abort it.
  *
- * Once a function grabs the current_urb_sem, then it -MUST- test the state to
+ * Once a function grabs the urb_sem, then it -MUST- test the state to
  * see if we just got aborted before the lock was grabbed.  If so, it's
  * essential to release the lock and return.
  *
- * The idea is that, once the current_urb_sem is held, the state can't really
+ * The idea is that, once the urb_sem is held, the state can't really
  * change anymore without also engaging the usb_unlink_urb() call _after_ the
  * URB is actually submitted.
  *
- * So, we've guaranteed that (after the sm_state test), if we do submit the
- * URB it will get aborted when we release the current_urb_sem.  And we've
+ * So, we've guaranteed that (after the abort_cmd test), if we do submit the
+ * URB it will get aborted when we release the urb_sem.  And we've
  * also guaranteed that if the abort code was called before we held the
- * current_urb_sem, we can safely get out before the URB is submitted.
+ * urb_sem, we can safely get out before the URB is submitted.
  */
 
 /* This is the completion handler which will wake us up when an URB
@@ -385,7 +385,7 @@
 }
 
 /* This is the common part of the URB message submission code
- * This function expects the current_urb_sem to be held upon entry.
+ * This function expects the dev_semaphore to be held upon entry.
  *
  * All URBs from the usb-storage driver _must_ pass through this function
  * (or something like it) for the abort mechanisms to work properly.
@@ -395,6 +395,8 @@
 	struct completion urb_done;
 	int status;
 
+	BUG_NOT_DOWN(&us->dev_semaphore);
+
 	/* set up data structures for the wakeup system */
 	init_completion(&urb_done);
 
@@ -405,16 +407,19 @@
 	us->current_urb->transfer_flags = USB_ASYNC_UNLINK;
 
 	/* submit the URB */
-	status = usb_submit_urb(us->current_urb, GFP_NOIO);
-	if (status) {
-		/* something went wrong */
-		return status;
+	down(&us->urb_sem);
+	if (us->abort_cmd) {
+		/* we are in abort mode, do not submit the new urb */
+		status = -ENOENT;
+	} else {
+		status = usb_submit_urb(us->current_urb, GFP_NOIO);
 	}
+	up(&us->urb_sem);
+	if (status)
+		return status;
 
 	/* wait for the completion of the URB */
-	up(&(us->current_urb_sem));
 	wait_for_completion(&urb_done);
-	down(&(us->current_urb_sem));
 
 	/* return the URB status */
 	return us->current_urb->status;
@@ -441,12 +446,11 @@
 	dr->wIndex = cpu_to_le16(index);
 	dr->wLength = cpu_to_le16(size);
 
-	/* lock the URB */
-	down(&(us->current_urb_sem));
+	/* is the device access locked? */
+	BUG_NOT_DOWN(&us->dev_semaphore);
 
 	/* has the current command been aborted? */
-	if (atomic_read(&us->sm_state) == US_STATE_ABORTING) {
-		up(&(us->current_urb_sem));
+	if (us->abort_cmd) {
 		return 0;
 	}
 
@@ -462,8 +466,6 @@
 	if (status >= 0)
 		status = us->current_urb->actual_length;
 
-	/* release the lock and return status */
-	up(&(us->current_urb_sem));
 	return status;
 }
 
@@ -475,14 +477,12 @@
 {
 	int status;
 
-	/* lock the URB */
-	down(&(us->current_urb_sem));
+	/* is the device access locked? */
+	BUG_NOT_DOWN(&us->dev_semaphore);
 
 	/* has the current command been aborted? */
-	if (atomic_read(&us->sm_state) == US_STATE_ABORTING) {
-		up(&(us->current_urb_sem));
+	if (us->abort_cmd)
 		return 0;
-	}
 
 	/* fill the URB */
 	FILL_BULK_URB(us->current_urb, us->pusb_dev, pipe, data, len,
@@ -494,8 +494,6 @@
 	/* return the actual length of the data transferred */
 	*act_len = us->current_urb->actual_length;
 
-	/* release the lock and return status */
-	up(&(us->current_urb_sem));
 	return status;
 }
 
@@ -571,7 +569,7 @@
 	}
 
 	/* did we abort this command? */
-	if (atomic_read(&us->sm_state) == US_STATE_ABORTING) {
+	if (us->abort_cmd) {
 		US_DEBUGP("usb_stor_transfer_partial(): transfer aborted\n");
 		return US_BULK_TRANSFER_ABORTED;
 	}
@@ -618,6 +616,9 @@
 	/* calculate how much we want to transfer */
 	transfer_amount = usb_stor_transfer_length(srb);
 
+	US_DEBUGP("usb_stor_transfer(): request for %d/%d bytes\n",
+			transfer_amount, srb->request_bufflen);
+
 	/* was someone foolish enough to request more data than available
 	 * buffer space? */
 	if (transfer_amount > srb->request_bufflen)
@@ -849,44 +850,65 @@
 		srb->sense_buffer[0] = 0x0;
 }
 
-/* Abort the currently running scsi command or device reset.
+  
+/*
+ * Abort the currently running scsi command or device reset.
+ * The function waits until the currently executing command
+ * has finished.
  */
-void usb_stor_abort_transport(struct us_data *us)
+void usb_stor_abort_transport(struct us_data *us, int call_scsidone)
 {
-	int state = atomic_read(&us->sm_state);
-
 	US_DEBUGP("usb_stor_abort_transport called\n");
 
-	/* If the current state is wrong or if there's
-	 *  no srb, then there's nothing to do */
-	BUG_ON((state != US_STATE_RUNNING && state != US_STATE_RESETTING));
-	BUG_ON(!(us->srb));
-
-	/* set state to abort */
-	atomic_set(&us->sm_state, US_STATE_ABORTING);
-
-	/* If the state machine is blocked waiting for an URB or an IRQ,
-	 * let's wake it up */
-
-	/* If we have an URB pending, cancel it.  Note that we guarantee with
-	 * the current_urb_sem that either (a) an URB has just been submitted,
-	 * or (b) the URB will never get submitted.  But, because of the use
-	 * of us->sm_state and current_urb_sem, we can't get an URB sumbitted
-	 * _after_ we set the state to US_STATE_ABORTING and this section of
-	 * code runs.  Thus we avoid deadlocks.
+	/* urb_sem is required to synchronize usb_unlink_urb()
+	 * and submit_urb():
+	 * The caller must guarantee that the urb that is 
+	 * passed to unlink_urb was submitted with submit_urb().
+	 * Without the lock, we could call unlink_urb in the middle
+	 * of submit_urb().
+	 *
+	 * urb_sem also doubles as the memory barrier that
+	 * makes the update to abort_cmd visible on all cpus in the
+	 * system.
+	 */
+	down(&us->urb_sem);
+	if (call_scsidone)
+		us->abort_cmd = ABORT_CALLSCSIDONE;
+	 else
+		us->abort_cmd = ABORT_NOSCSIDONE;
+
+	/* Check if the worker thread is processing the
+	 * command right now, abort it if yes.
 	 */
-	down(&(us->current_urb_sem));
+
 	if (us->current_urb->status == -EINPROGRESS) {
 		US_DEBUGP("-- cancelling URB\n");
 		usb_unlink_urb(us->current_urb);
 	}
-	up(&(us->current_urb_sem));
 
 	/* If we are waiting for an IRQ, simulate it */
-	if (test_bit(IP_WANTED, &us->bitflags)) {
+	if (test_and_clear_bit(IP_WANTED, &us->bitflags)) {
+		struct us_data *us = (struct us_data *)us->irq_urb->context;
 		US_DEBUGP("-- simulating missing IRQ\n");
-		usb_stor_CBI_irq(us->irq_urb);
+		/* wake up the command thread */
+		up(&us->ip_waitq);
 	}
+	up(&us->urb_sem);
+
+	spin_lock_irq(&us->queue_exclusion);
+	while (us->srb) {
+		DECLARE_WAITQUEUE(wait, current);
+		current->state = TASK_UNINTERRUPTIBLE;
+		add_wait_queue(&us->wq_cmd, &wait);
+		spin_unlock_irq(&us->queue_exclusion);
+		schedule();
+		spin_lock_irq(&us->queue_exclusion);
+		remove_wait_queue(&us->wq_cmd, &wait);
+	}
+	spin_unlock_irq(&us->queue_exclusion);
+	down(&us->urb_sem);
+	us->abort_cmd = 0;
+	up(&us->urb_sem);
 }
 
 /*
@@ -904,21 +926,6 @@
 	US_DEBUGP("-- Interrupt Status (0x%x, 0x%x)\n",
 			us->irqbuf[0], us->irqbuf[1]);
 
-	/* has the current command been aborted? */
-	if (atomic_read(&us->sm_state) == US_STATE_ABORTING) {
-
-		/* was this a wanted interrupt? */
-		if (!test_and_clear_bit(IP_WANTED, &us->bitflags)) {
-			US_DEBUGP("ERROR: Unwanted interrupt received!\n");
-			return;
-		}
-		US_DEBUGP("-- command aborted\n");
-
-		/* wake up the command thread */
-		up(&us->ip_waitq);
-		return;
-	}
-
 	/* is the device removed? */
 	if (urb->status == -ENOENT) {
 		US_DEBUGP("-- device has been removed\n");
@@ -987,7 +994,7 @@
 	}
 
 	/* did we abort this command? */
-	if (atomic_read(&us->sm_state) == US_STATE_ABORTING) {
+	if (us->abort_cmd) {
 		US_DEBUGP("usb_stor_control_msg(): transfer aborted\n");
 		return US_BULK_TRANSFER_ABORTED;
 	}
@@ -999,7 +1006,7 @@
 			usb_sndctrlpipe(us->pusb_dev, 0));
 
 		/* did we abort this command? */
-		if (atomic_read(&us->sm_state) == US_STATE_ABORTING) {
+		if (us->abort_cmd) {
 			US_DEBUGP("usb_stor_control_msg(): transfer aborted\n");
 			return US_BULK_TRANSFER_ABORTED;
 		}
@@ -1036,7 +1043,7 @@
 	down(&(us->ip_waitq));
 
 	/* has the current command been aborted? */
-	if (atomic_read(&us->sm_state) == US_STATE_ABORTING) {
+	if (us->abort_cmd) {
 		US_DEBUGP("CBI interrupt aborted\n");
 		return USB_STOR_TRANSPORT_ABORTED;
 	}
@@ -1104,7 +1111,7 @@
 	US_DEBUGP("Call to usb_stor_control_msg() returned %d\n", result);
 	if (result < 0) {
 		/* did we abort this command? */
-		if (atomic_read(&us->sm_state) == US_STATE_ABORTING) {
+		if (us->abort_cmd) {
 			US_DEBUGP("usb_stor_CB_transport(): transfer aborted\n");
 			return US_BULK_TRANSFER_ABORTED;
 		}
@@ -1116,7 +1123,7 @@
 				usb_sndctrlpipe(us->pusb_dev, 0));
 
 			/* did we abort this command? */
-			if (atomic_read(&us->sm_state) == US_STATE_ABORTING) {
+			if (us->abort_cmd) {
 				US_DEBUGP("usb_stor_CB_transport(): transfer aborted\n");
 				return US_BULK_TRANSFER_ABORTED;
 			}
@@ -1225,7 +1232,7 @@
 	US_DEBUGP("Bulk command transfer result=%d\n", result);
 
 	/* did we abort this command? */
-	if (atomic_read(&us->sm_state) == US_STATE_ABORTING) {
+	if (us->abort_cmd) {
 		US_DEBUGP("usb_stor_Bulk_transport(): transfer aborted\n");
 		return US_BULK_TRANSFER_ABORTED;
 	}
@@ -1236,7 +1243,7 @@
 		result = usb_stor_clear_halt(us, pipe);
 
 		/* did we abort this command? */
-		if (atomic_read(&us->sm_state) == US_STATE_ABORTING) {
+		if (us->abort_cmd) {
 			US_DEBUGP("usb_stor_Bulk_transport(): transfer aborted\n");
 			return US_BULK_TRANSFER_ABORTED;
 		}
@@ -1273,7 +1280,7 @@
 				   &partial);
 
 	/* did we abort this command? */
-	if (atomic_read(&us->sm_state) == US_STATE_ABORTING) {
+	if (us->abort_cmd) {
 		US_DEBUGP("usb_stor_Bulk_transport(): transfer aborted\n");
 		return US_BULK_TRANSFER_ABORTED;
 	}
@@ -1284,7 +1291,7 @@
 		result = usb_stor_clear_halt(us, pipe);
 
 		/* did we abort this command? */
-		if (atomic_read(&us->sm_state) == US_STATE_ABORTING) {
+		if (us->abort_cmd) {
 			US_DEBUGP("usb_stor_Bulk_transport(): transfer aborted\n");
 			return US_BULK_TRANSFER_ABORTED;
 		}
@@ -1295,7 +1302,7 @@
 					   US_BULK_CS_WRAP_LEN, &partial);
 
 		/* did we abort this command? */
-		if (atomic_read(&us->sm_state) == US_STATE_ABORTING) {
+		if (us->abort_cmd) {
 			US_DEBUGP("usb_stor_Bulk_transport(): transfer aborted\n");
 			return US_BULK_TRANSFER_ABORTED;
 		}
@@ -1306,7 +1313,7 @@
 			result = usb_stor_clear_halt(us, pipe);
 
 			/* did we abort this command? */
-			if (atomic_read(&us->sm_state) == US_STATE_ABORTING) {
+			if (us->abort_cmd) {
 				US_DEBUGP("usb_stor_Bulk_transport(): transfer aborted\n");
 				return US_BULK_TRANSFER_ABORTED;
 			}
@@ -1358,23 +1365,33 @@
 
 struct us_timeout {
 	struct us_data *us;
-	spinlock_t timer_lock;
+	struct completion done;
+	struct tq_struct event;
 };
 
+static void usb_stor_event_handler(void* to__)
+{
+	struct us_timeout *to = (struct us_timeout *) to__;
+	struct us_data *us = to->us;
+
+	US_DEBUGP("timeout event handler called\n");
+
+	/* abort the current request */
+	usb_stor_abort_transport(us, 1);
+
+	complete(&to->done);
+}
+
 /* The timeout event handler
  */
 static void usb_stor_timeout_handler(unsigned long to__)
 {
 	struct us_timeout *to = (struct us_timeout *) to__;
-	struct us_data *us = to->us;
 
 	US_DEBUGP("Timeout occurred\n");
 
-	/* abort the current request */
-	usb_stor_abort_transport(us);
-
-	/* let the reset routine know we have finished */
-	spin_unlock(&to->timer_lock);
+	INIT_TQUEUE(&to->event, usb_stor_event_handler, to);
+	schedule_task(&to->event);
 }
 
 /* This is the common part of the device reset code.
@@ -1389,11 +1406,12 @@
 		u16 value, u16 index, void *data, u16 size)
 {
 	int result;
-	struct us_timeout timeout_data = {us, SPIN_LOCK_UNLOCKED};
+	struct us_timeout timeout_data;
 	struct timer_list timeout_list;
 
 	/* prepare the timeout handler */
-	spin_lock(&timeout_data.timer_lock);
+	timeout_data.us = us;
+	init_completion(&timeout_data.done);
 	init_timer(&timeout_list);
 
 	/* A 20-second timeout may seem rather long, but a LaCie
@@ -1429,8 +1447,7 @@
 
 	/* prevent the timer from coming back to haunt us */
 	if (!del_timer(&timeout_list)) {
-		/* the handler has already started; wait for it to finish */
-		spin_lock(&timeout_data.timer_lock);
+		wait_for_completion(&timeout_data.done);
 		/* change the abort into a timeout */
 		if (result == -ENOENT)
 			result = -ETIMEDOUT;
diff -u 2.5/drivers/usb/storage/transport.h build-2.5/drivers/usb/storage/transport.h
--- 2.5/drivers/usb/storage/transport.h	Sun May 26 11:05:08 2002
+++ build-2.5/drivers/usb/storage/transport.h	Wed Jul  3 20:34:01 2002
@@ -149,7 +149,7 @@
 
 extern unsigned int usb_stor_transfer_length(Scsi_Cmnd*);
 extern void usb_stor_invoke_transport(Scsi_Cmnd*, struct us_data*);
-extern void usb_stor_abort_transport(struct us_data*);
+extern void usb_stor_abort_transport(struct us_data*, int call_scsidone);
 extern int usb_stor_transfer_partial(struct us_data*, char*, int);
 
 extern int usb_stor_bulk_msg(struct us_data *us, void *data, int pipe,
diff -u 2.5/drivers/usb/storage/usb.c build-2.5/drivers/usb/storage/usb.c
--- 2.5/drivers/usb/storage/usb.c	Tue Jun 25 20:28:28 2002
+++ build-2.5/drivers/usb/storage/usb.c	Wed Jul  3 22:45:47 2002
@@ -101,7 +101,7 @@
 
 /* The list of structures and the protective lock for them */
 struct us_data *us_list;
-struct semaphore us_list_semaphore;
+DECLARE_MUTEX(us_list_semaphore);
 
 static void * storage_probe(struct usb_device *dev, unsigned int ifnum,
 			    const struct usb_device_id *id);
@@ -326,6 +326,9 @@
 
 	/* set up for wakeups by new commands */
 	init_MUTEX_LOCKED(&us->sema);
+	down(&us->dev_semaphore);
+	us->sm_state = US_STATE_IDLE;
+	up(&us->dev_semaphore);
 
 	/* signal that we've started the thread */
 	complete(&(us->notify));
@@ -333,12 +336,13 @@
 	for(;;) {
 		struct Scsi_Host *host;
 		US_DEBUGP("*** thread sleeping.\n");
-		atomic_set(&us->sm_state, US_STATE_IDLE);
-		if(down_interruptible(&us->sema))
+		wake_up(&us->wq_cmd);
+		if(down_interruptible(&us->sema)) {
+			printk(KERN_ERR "Received unexpected signal in usb_stor_control_thread().\n");
 			break;
+		}
 			
 		US_DEBUGP("*** thread awakened.\n");
-		atomic_set(&us->sm_state, US_STATE_RUNNING);
 
 		/* lock access to the queue element */
 		spin_lock_irq(&us->queue_exclusion);
@@ -346,9 +350,6 @@
 		/* take the command off the queue */
 		action = us->action;
 		us->action = 0;
-		us->srb = us->queue_srb;
-		host = us->srb->host;
-
 		/* release the queue lock as fast as possible */
 		spin_unlock_irq(&us->queue_exclusion);
 
@@ -359,6 +360,8 @@
 		}
 
 		BUG_ON(action != US_ACT_COMMAND);
+		host = us->srb->host;
+
 
 		/* reject the command if the direction indicator 
 		 * is UNKNOWN
@@ -416,9 +419,10 @@
 
 		/* lock the device pointers */
 		down(&(us->dev_semaphore));
+		us->sm_state = US_STATE_RUNNING;
 
 		/* our device has gone - pretend not ready */
-		if (!test_bit(DEV_ATTACHED, &us->bitflags)) {
+		if (us->pusb_dev == NULL) {
 			US_DEBUGP("Request is for removed device\n");
 			/* For REQUEST_SENSE, it's the data.  But
 			 * for anything else, it should look like
@@ -442,7 +446,7 @@
 				       sizeof(usb_stor_sense_notready));
 				us->srb->result = CHECK_CONDITION << 1;
 			}
-		} else { /* test_bit(DEV_ATTACHED, &us->bitflags) */
+		} else { /* us->pusb_dev != NULL */
 
 			/* Handle those devices which need us to fake 
 			 * their inquiry data */
@@ -461,23 +465,22 @@
 				us->proto_handler(us->srb, us);
 			}
 		}
+		us->sm_state = US_STATE_IDLE;
 
 		/* unlock the device pointers */
 		up(&(us->dev_semaphore));
 
 		/* indicate that the command is done */
-		if (us->srb->result != DID_ABORT << 16) {
-			US_DEBUGP("scsi cmd done, result=0x%x\n", 
-				   us->srb->result);
-			scsi_lock(host);
+		scsi_lock(host);
+		US_DEBUGP("scsi cmd done, result=0x%x\n", us->srb->result);
+		if (us->abort_cmd != ABORT_NOSCSIDONE) {
+			/* If we are in error recovery mode,
+			 * no scsi_done callback needed.
+			 */
 			us->srb->scsi_done(us->srb);
-			us->srb = NULL;
-			scsi_unlock(host);
-		} else {
-			US_DEBUGP("scsi command aborted\n");
-			us->srb = NULL;
-			complete(&(us->notify));
 		}
+		us->srb = NULL;
+		scsi_unlock(host);
 	} /* for (;;) */
 
 	/* notify the exit routine that we're actually exiting now */
@@ -500,13 +503,12 @@
 
 	US_DEBUGP("Allocating IRQ for CBI transport\n");
 
-	/* lock access to the data structure */
-	down(&(ss->irq_urb_sem));
+	/* check that the device is locked properly */
+	BUG_NOT_DOWN(&ss->dev_semaphore);
 
 	/* allocate the URB */
 	ss->irq_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!ss->irq_urb) {
-		up(&(ss->irq_urb_sem));
 		US_DEBUGP("couldn't allocate interrupt URB");
 		return 1;
 	}
@@ -527,12 +529,9 @@
 	US_DEBUGP("usb_submit_urb() returns %d\n", result);
 	if (result) {
 		usb_free_urb(ss->irq_urb);
-		up(&(ss->irq_urb_sem));
 		return 2;
 	}
 
-	/* unlock the data structure and return success */
-	up(&(ss->irq_urb_sem));
 	return 0;
 }
 
@@ -569,6 +568,8 @@
 		intf[ifnum].altsetting + intf[ifnum].act_altsetting;
 	US_DEBUGP("act_altsetting is %d\n", intf[ifnum].act_altsetting);
 
+	BUG_NOT_DOWN(&usb_storage_driver.serialize);
+
 	/* clear the temporary strings */
 	memset(mf, 0, sizeof(mf));
 	memset(prod, 0, sizeof(prod));
@@ -686,10 +687,11 @@
 	 * already on the system
 	 */
 	ss = us_list;
-	while ((ss != NULL) && 
-	           (test_bit(DEV_ATTACHED, &ss->bitflags) ||
-		    !GUID_EQUAL(guid, ss->guid)))
+	while (ss != NULL) {
+		if (ss->pusb_dev == NULL && GUID_EQUAL(guid, ss->guid))
+			break;
 		ss = ss->next;
+	}
 
 	if (ss != NULL) {
 		/* Existing device -- re-connect */
@@ -701,8 +703,8 @@
 
 		/* establish the connection to the new device upon reconnect */
 		ss->ifnum = ifnum;
+		BUG_ON(ss->pusb_dev != NULL);
 		ss->pusb_dev = dev;
-		set_bit(DEV_ATTACHED, &ss->bitflags);
 
 		/* copy over the endpoint data */
 		ss->ep_in = ep_in->bEndpointAddress & 
@@ -749,9 +751,9 @@
 		init_completion(&(ss->notify));
 		init_MUTEX_LOCKED(&(ss->ip_waitq));
 		spin_lock_init(&ss->queue_exclusion);
-		init_MUTEX(&(ss->irq_urb_sem));
-		init_MUTEX(&(ss->current_urb_sem));
-		init_MUTEX(&(ss->dev_semaphore));
+		init_MUTEX(&ss->urb_sem);
+		init_MUTEX_LOCKED(&(ss->dev_semaphore));
+		init_waitqueue_head(&ss->wq_cmd);
 
 		/* copy over the subclass and protocol data */
 		ss->subclass = subclass;
@@ -969,9 +971,11 @@
 		if (unusual_dev && unusual_dev->initFunction)
 			unusual_dev->initFunction(ss);
 
+		/* Now we are ready */
+		up(&ss->dev_semaphore);
+
 		/* start up our control thread */
-		atomic_set(&ss->sm_state, US_STATE_IDLE);
-		set_bit(DEV_ATTACHED, &ss->bitflags);
+		ss->sm_state = US_STATE_BAD;
 		ss->pid = kernel_thread(usb_stor_control_thread, ss,
 					CLONE_VM);
 		if (ss->pid < 0) {
@@ -1019,20 +1023,17 @@
 	/* we come here if there are any problems */
 	BadDevice:
 	US_DEBUGP("storage_probe() failed\n");
-	down(&ss->irq_urb_sem);
 	if (ss->irq_urb) {
 		usb_unlink_urb(ss->irq_urb);
 		usb_free_urb(ss->irq_urb);
 		ss->irq_urb = NULL;
 	}
-	up(&ss->irq_urb_sem);
 	if (ss->current_urb) {
 		usb_unlink_urb(ss->current_urb);
 		usb_free_urb(ss->current_urb);
 		ss->current_urb = NULL;
 	}
 
-	clear_bit(DEV_ATTACHED, &ss->bitflags);
 	ss->pusb_dev = NULL;
 	if (new_device)
 		kfree(ss);
@@ -1050,17 +1051,21 @@
 
 	US_DEBUGP("storage_disconnect() called\n");
 
+	BUG_NOT_DOWN(&usb_storage_driver.serialize);
+
 	/* this is the odd case -- we disconnected but weren't using it */
 	if (!ss) {
 		US_DEBUGP("-- device was not in use\n");
 		return;
 	}
 
+	/* kill a pending command */
+	usb_stor_abort_transport(ss, 1);
+	
 	/* lock access to the device data structure */
 	down(&(ss->dev_semaphore));
 
 	/* release the IRQ, if we have one */
-	down(&(ss->irq_urb_sem));
 	if (ss->irq_urb) {
 		US_DEBUGP("-- releasing irq URB\n");
 		result = usb_unlink_urb(ss->irq_urb);
@@ -1068,7 +1073,6 @@
 		usb_free_urb(ss->irq_urb);
 		ss->irq_urb = NULL;
 	}
-	up(&(ss->irq_urb_sem));
 
 	/* free up the main URB for this device */
 	US_DEBUGP("-- releasing main URB\n");
@@ -1080,7 +1084,6 @@
 	/* mark the device as gone */
 	usb_put_dev(ss->pusb_dev);
 	ss->pusb_dev = NULL;
-	clear_bit(DEV_ATTACHED, &ss->bitflags);
 
 	/* unlock access to the device data structure */
 	up(&(ss->dev_semaphore));
@@ -1096,7 +1099,6 @@
 
 	/* initialize internal global data elements */
 	us_list = NULL;
-	init_MUTEX(&us_list_semaphore);
 	my_host_number = 0;
 
 	/* register the driver, return -1 if error */
diff -u 2.5/drivers/usb/storage/usb.h build-2.5/drivers/usb/storage/usb.h
--- 2.5/drivers/usb/storage/usb.h	Tue Jun 25 20:28:28 2002
+++ build-2.5/drivers/usb/storage/usb.h	Wed Jul  3 20:35:04 2002
@@ -39,6 +39,28 @@
  * You should have received a copy of the GNU General Public License along
  * with this program; if not, write to the Free Software Foundation, Inc.,
  * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Changelog:
+ * - remove the DEV_ATTACHED bitflag, it duplicates (->pusb_dev !=NULL)
+ * - make sm_state a normal variable, atomic_t do not provide synchronization
+ *   for assignments
+ * - merge queue_srb and srb, that created a hole for crashes if a device_reset()
+ *   happens too early. Add BUG_ON tests to catch errors.
+ * - device aborts happen asynchroneously, make abort_cmd a seperate variable
+ * - add BUG_ON tests to catch missing semaphore calls
+ * - bus_reset dropped for now, synchronization is too fragile, no real need for
+ *   it
+ * - restrict commands to 128 sectors, large commands cause errors with my SaroTech
+ *   USB enclosure
+ * - move urb_sem into usb_stor_msg_common(), asking the callers to lock & check for
+ *   abort_cmd is too error prone.
+ * - add an explicit waitqueue for the device reset handler, reuse of the 
+ *   completion caused deadlocks in command_abort().
+ * - move the _timeout handler for usb_stor to process context.
+ * - fixoops during module unload.
+ * - abort a possibly pending command during storage_disconnect(), could cause
+ *   excessive delays if the cable is pulled out while a command is pending.
+ * (C) Manfred Spraul <manfred@colorfullife.com> 2002
  */
 
 #ifndef _USB_H_
@@ -107,13 +129,16 @@
 
 /* kernel thread actions */
 #define US_ACT_COMMAND	1
-#define US_ACT_EXIT		5
+#define US_ACT_EXIT		2
 
-/* processing state machine states */
+/* processing state machine states
+ * For debugging only, it can be wrong because queue_command()
+ * queues new requests asynchroneously.
+ * */
+#define US_STATE_BAD		0
 #define US_STATE_IDLE		1
 #define US_STATE_RUNNING	2
 #define US_STATE_RESETTING	3
-#define US_STATE_ABORTING	4
 
 #define USB_STOR_STRING_LEN 32
 
@@ -127,9 +152,12 @@
 	struct us_data		*next;		 /* next device */
 
 	/* The device we're working with
-	 * It's important to note:
-	 *    (o) you must hold dev_semaphore to change pusb_dev
-	 *    (o) DEV_ATTACHED in bitflags should change whenever pusb_dev does
+	 * It's important to note that you must hold dev_semaphore
+	 * to change or use pusb_dev.
+	 *
+	 * Virtually the complete device access is serialized through
+	 * dev_semaphore, the only notable exception is command abortion
+	 * which is serialized by urb_sem.
 	 */
 	struct semaphore	dev_semaphore;	 /* protect pusb_dev */
 	struct usb_device	*pusb_dev;	 /* this usb_device */
@@ -166,25 +194,28 @@
 	Scsi_Cmnd		*srb;		 /* current srb		*/
 
 	/* thread information */
-	Scsi_Cmnd		*queue_srb;	 /* the single queue slot */
 	int			action;		 /* what to do		  */
 	int			pid;		 /* control thread	  */
-	atomic_t		sm_state;
+	unsigned long		sm_state;
+	wait_queue_head_t	wq_cmd;		 /* command completion queue */
+	struct semaphore	urb_sem;	 /* synchronize {unlink,submit}_urb */
+
+	unsigned long		abort_cmd;
+/* 0 means do not abort */
+#define ABORT_CALLSCSIDONE	1
+#define ABORT_NOSCSIDONE	2
 
 	/* interrupt info for CBI devices -- only good if attached */
 	struct semaphore	ip_waitq;	 /* for CBI interrupts	 */
-	unsigned long		bitflags;	 /* single-bit flags:	 */
+	unsigned long		bitflags;	 /* atomic bitflags */
 #define IP_WANTED	1			 /* is an IRQ expected?	 */
-#define DEV_ATTACHED	2			 /* is the dev. attached?*/
 
 	/* interrupt communications data */
-	struct semaphore	irq_urb_sem;	 /* to protect irq_urb	 */
 	struct urb		*irq_urb;	 /* for USB int requests */
 	unsigned char		irqbuf[2];	 /* buffer for USB IRQ	 */
 	unsigned char		irqdata[2];	 /* data from USB IRQ	 */
 
 	/* control and bulk communications data */
-	struct semaphore	current_urb_sem; /* to protect irq_urb	 */
 	struct urb		*current_urb;	 /* non-int USB requests */
 
 	/* the semaphore for sleeping the control thread */
@@ -221,4 +252,12 @@
 #define sg_address(psg)		((psg)->address)
 #endif
 
+#define BUG_NOT_DOWN(sem) \
+	do { \
+		if (!down_trylock(sem)) { \
+			up(sem); \
+			BUG(); \
+		} \
+	} while(0)
+
 #endif

--------------080101040807050004080307--

