Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUDJC7z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 22:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbUDJC7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 22:59:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60632 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261867AbUDJC7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 22:59:47 -0400
Date: Fri, 9 Apr 2004 19:59:43 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: <stern@rowland.harvard.edu>
Cc: mdharm@one-eyed-alien.net, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Patch for usb-storage in 2.4
Message-Id: <20040409195943.0dac2f5a.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys,

this works dandy for us in RHL and RHEL, *especially* on bigger SMP boxes.
It does not fix all the bugs in that code, but I consider it a good start,
and unless someone speaks up, it goes to Marcelo after 2.4.26 is out.
Or maybe before, depending how long it takes him to release 2.4.26.
Please review, test, etc.

I am working on two new bugs in usb-storage right now, but I'd like
to have things going in gradually, in self-contained chunks, Viro style.
Those two are not fixed yet anyway.

-- Pete

diff -urN -X dontdiff linux-2.4.26-rc2/drivers/usb/storage/scsiglue.c linux-2.4.26-rc2-nip/drivers/usb/storage/scsiglue.c
--- linux-2.4.26-rc2/drivers/usb/storage/scsiglue.c	2004-04-09 17:28:30.000000000 -0700
+++ linux-2.4.26-rc2-nip/drivers/usb/storage/scsiglue.c	2004-04-09 17:31:44.000000000 -0700
@@ -218,7 +218,14 @@
 	US_DEBUGP("device_reset() called\n" );
 
 	spin_unlock_irq(&io_request_lock);
+	down(&(us->dev_semaphore));
+	if (!us->pusb_dev) {
+		up(&(us->dev_semaphore));
+		spin_lock_irq(&io_request_lock);
+		return SUCCESS;
+	}
 	rc = us->transport_reset(us);
+	up(&(us->dev_semaphore));
 	spin_lock_irq(&io_request_lock);
 	return rc;
 }
@@ -235,27 +242,32 @@
 	/* we use the usb_reset_device() function to handle this for us */
 	US_DEBUGP("bus_reset() called\n");
 
+	spin_unlock_irq(&io_request_lock);
+
+	down(&(us->dev_semaphore));
+
 	/* if the device has been removed, this worked */
 	if (!us->pusb_dev) {
 		US_DEBUGP("-- device removed already\n");
+		up(&(us->dev_semaphore));
+		spin_lock_irq(&io_request_lock);
 		return SUCCESS;
 	}
 
-	spin_unlock_irq(&io_request_lock);
-
 	/* release the IRQ, if we have one */
-	down(&(us->irq_urb_sem));
 	if (us->irq_urb) {
 		US_DEBUGP("-- releasing irq URB\n");
 		result = usb_unlink_urb(us->irq_urb);
 		US_DEBUGP("-- usb_unlink_urb() returned %d\n", result);
 	}
-	up(&(us->irq_urb_sem));
 
 	/* attempt to reset the port */
 	if (usb_reset_device(us->pusb_dev) < 0) {
-		spin_lock_irq(&io_request_lock);
-		return FAILED;
+		/*
+		 * Do not return errors, or else the error handler might
+		 * invoke host_reset, which is not implemented.
+		 */
+		goto bail_out;
 	}
 
 	/* FIXME: This needs to lock out driver probing while it's working
@@ -286,28 +298,36 @@
 		up(&intf->driver->serialize);
 	}
 
+bail_out:
 	/* re-allocate the IRQ URB and submit it to restore connectivity
 	 * for CBI devices
 	 */
 	if (us->protocol == US_PR_CBI) {
-		down(&(us->irq_urb_sem));
 		us->irq_urb->dev = us->pusb_dev;
 		result = usb_submit_urb(us->irq_urb);
 		US_DEBUGP("usb_submit_urb() returns %d\n", result);
-		up(&(us->irq_urb_sem));
 	}
-	
+
+	up(&(us->dev_semaphore));
+
 	spin_lock_irq(&io_request_lock);
 
 	US_DEBUGP("bus_reset() complete\n");
 	return SUCCESS;
 }
 
-/* FIXME: This doesn't do anything right now */
 static int host_reset( Scsi_Cmnd *srb )
 {
-	printk(KERN_CRIT "usb-storage: host_reset() requested but not implemented\n" );
-	return FAILED;
+	struct us_data *us = (struct us_data *)srb->host->hostdata[0];
+
+	spin_unlock_irq(&io_request_lock);
+	down(&(us->dev_semaphore));
+        printk(KERN_CRIT "usb-storage: host_reset() requested but hardly implemented\n" );
+	up(&(us->dev_semaphore));
+	spin_lock_irq(&io_request_lock);
+	US_DEBUGP("host_reset() complete\n");
+
+	return SUCCESS;
 }
 
 /***********************************************************************
diff -urN -X dontdiff linux-2.4.26-rc2/drivers/usb/storage/usb.c linux-2.4.26-rc2-nip/drivers/usb/storage/usb.c
--- linux-2.4.26-rc2/drivers/usb/storage/usb.c	2004-02-26 14:09:59.000000000 -0800
+++ linux-2.4.26-rc2-nip/drivers/usb/storage/usb.c	2004-04-09 17:31:45.000000000 -0700
@@ -501,6 +501,9 @@
  * strucuture is current.  This includes the ep_int field, which gives us
  * the endpoint for the interrupt.
  * Returns non-zero on failure, zero on success
+ *
+ * ss->dev_semaphore is expected taken, except for a newly minted,
+ * unregistered device.
  */ 
 static int usb_stor_allocate_irq(struct us_data *ss)
 {
@@ -510,13 +513,9 @@
 
 	US_DEBUGP("Allocating IRQ for CBI transport\n");
 
-	/* lock access to the data structure */
-	down(&(ss->irq_urb_sem));
-
 	/* allocate the URB */
 	ss->irq_urb = usb_alloc_urb(0);
 	if (!ss->irq_urb) {
-		up(&(ss->irq_urb_sem));
 		US_DEBUGP("couldn't allocate interrupt URB");
 		return 1;
 	}
@@ -537,12 +536,9 @@
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
 
@@ -772,7 +768,6 @@
 		init_completion(&(ss->notify));
 		init_MUTEX_LOCKED(&(ss->ip_waitq));
 		spin_lock_init(&(ss->queue_exclusion));
-		init_MUTEX(&(ss->irq_urb_sem));
 		init_MUTEX(&(ss->current_urb_sem));
 		init_MUTEX(&(ss->dev_semaphore));
 
@@ -1063,7 +1058,6 @@
 	down(&(ss->dev_semaphore));
 
 	/* release the IRQ, if we have one */
-	down(&(ss->irq_urb_sem));
 	if (ss->irq_urb) {
 		US_DEBUGP("-- releasing irq URB\n");
 		result = usb_unlink_urb(ss->irq_urb);
@@ -1071,7 +1065,6 @@
 		usb_free_urb(ss->irq_urb);
 		ss->irq_urb = NULL;
 	}
-	up(&(ss->irq_urb_sem));
 
 	/* free up the main URB for this device */
 	US_DEBUGP("-- releasing main URB\n");
diff -urN -X dontdiff linux-2.4.26-rc2/drivers/usb/storage/usb.h linux-2.4.26-rc2-nip/drivers/usb/storage/usb.h
--- linux-2.4.26-rc2/drivers/usb/storage/usb.h	2003-11-29 19:23:15.000000000 -0800
+++ linux-2.4.26-rc2-nip/drivers/usb/storage/usb.h	2004-04-09 17:51:44.000000000 -0700
@@ -116,7 +116,7 @@
 	struct us_data		*next;		 /* next device */
 
 	/* the device we're working with */
-	struct semaphore	dev_semaphore;	 /* protect pusb_dev */
+	struct semaphore	dev_semaphore;	 /* protect many things */
 	struct usb_device	*pusb_dev;	 /* this usb_device */
 
 	unsigned int		flags;		 /* from filter initially */
@@ -162,7 +162,6 @@
 	atomic_t		ip_wanted[1];	 /* is an IRQ expected?	 */
 
 	/* interrupt communications data */
-	struct semaphore	irq_urb_sem;	 /* to protect irq_urb	 */
 	struct urb		*irq_urb;	 /* for USB int requests */
 	unsigned char		irqbuf[2];	 /* buffer for USB IRQ	 */
 	unsigned char		irqdata[2];	 /* data from USB IRQ	 */
