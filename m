Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293503AbSCGGr2>; Thu, 7 Mar 2002 01:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293521AbSCGGrU>; Thu, 7 Mar 2002 01:47:20 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:57871 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S293503AbSCGGrD>;
	Thu, 7 Mar 2002 01:47:03 -0500
Date: Wed, 6 Mar 2002 22:39:05 -0800
From: Greg KH <greg@kroah.com>
To: James Curbo <jcurbo@acm.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: a couple of USB related Oopses
Message-ID: <20020307063905.GA18676@kroah.com>
In-Reply-To: <20020305184604.GA4590@carthage> <20020305192307.GB10151@kroah.com> <20020305193317.GA5339@carthage> <20020305193732.GC10151@kroah.com> <20020306050349.GA1152@carthage>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020306050349.GA1152@carthage>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 07 Feb 2002 02:14:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 11:03:49PM -0600, James Curbo wrote:
> Ah, I tried it with 2.5.6-pre2 and usb-uhci.. still got a panic, when I
> tried to print to the printer (which is what I was doing before too) 
> Also, got these in my kernel log...

Crud, missed another driver.  Can you please try the patch below and let
me know if it fixes the problem for you?

thanks,

greg k-h


diff -Nru a/drivers/usb/printer.c b/drivers/usb/printer.c
--- a/drivers/usb/printer.c	Wed Mar  6 22:46:17 2002
+++ b/drivers/usb/printer.c	Wed Mar  6 22:46:17 2002
@@ -91,7 +91,7 @@
 	struct usb_device 	*dev;			/* USB device */
 	devfs_handle_t		devfs;			/* devfs device */
 	struct semaphore	sem;			/* locks this struct, especially "dev" */
-	struct urb		readurb, writeurb;	/* The urbs */
+	struct urb		*readurb, *writeurb;	/* The urbs */
 	wait_queue_head_t	wait;			/* Zzzzz ... */
 	int			readcount;		/* Counter for reads */
 	int			ifnum;			/* Interface number */
@@ -253,15 +253,15 @@
 	usblp->used = 1;
 	file->private_data = usblp;
 
-	usblp->writeurb.transfer_buffer_length = 0;
-	usblp->writeurb.status = 0;
+	usblp->writeurb->transfer_buffer_length = 0;
+	usblp->writeurb->status = 0;
 	usblp->wcomplete = 1; /* we begin writeable */
 	usblp->rcomplete = 0;
 
 	if (usblp->bidir) {
 		usblp->readcount = 0;
-		usblp->readurb.dev = usblp->dev;
-		if (usb_submit_urb(&usblp->readurb, GFP_KERNEL) < 0) {
+		usblp->readurb->dev = usblp->dev;
+		if (usb_submit_urb(usblp->readurb, GFP_KERNEL) < 0) {
 			retval = -EIO;
 			usblp->used = 0;
 			file->private_data = NULL;
@@ -278,8 +278,10 @@
 	usblp_table [usblp->minor] = NULL;
 	info ("usblp%d: removed", usblp->minor);
 
-	kfree (usblp->writeurb.transfer_buffer);
+	kfree (usblp->writeurb->transfer_buffer);
 	kfree (usblp->device_id_string);
+	usb_free_urb(usblp->writeurb);
+	usb_free_urb(usblp->readurb);
 	kfree (usblp);
 }
 
@@ -292,8 +294,8 @@
 	usblp->used = 0;
 	if (usblp->dev) {
 		if (usblp->bidir)
-			usb_unlink_urb(&usblp->readurb);
-		usb_unlink_urb(&usblp->writeurb);
+			usb_unlink_urb(usblp->readurb);
+		usb_unlink_urb(usblp->writeurb);
 		up(&usblp->sem);
 	} else 		/* finish cleanup from disconnect */
 		usblp_cleanup (usblp);
@@ -306,8 +308,8 @@
 {
 	struct usblp *usblp = file->private_data;
 	poll_wait(file, &usblp->wait, wait);
- 	return ((!usblp->bidir || usblp->readurb.status  == -EINPROGRESS) ? 0 : POLLIN  | POLLRDNORM)
- 			       | (usblp->writeurb.status == -EINPROGRESS  ? 0 : POLLOUT | POLLWRNORM);
+ 	return ((!usblp->bidir || usblp->readurb->status  == -EINPROGRESS) ? 0 : POLLIN  | POLLRDNORM)
+ 			       | (usblp->writeurb->status == -EINPROGRESS  ? 0 : POLLOUT | POLLWRNORM);
 }
 
 static int usblp_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
@@ -423,12 +425,12 @@
 			return -ENODEV;
 		}
 
-		if (usblp->writeurb.status != 0) {
+		if (usblp->writeurb->status != 0) {
 			if (usblp->quirks & USBLP_QUIRK_BIDIR) {
 				if (!usblp->wcomplete)
 					err("usblp%d: error %d writing to printer",
-						usblp->minor, usblp->writeurb.status);
-				err = usblp->writeurb.status;
+						usblp->minor, usblp->writeurb->status);
+				err = usblp->writeurb->status;
 			} else
 				err = usblp_check_status(usblp, err);
 			up (&usblp->sem);
@@ -440,23 +442,23 @@
 			continue;
 		}
 
-		writecount += usblp->writeurb.transfer_buffer_length;
-		usblp->writeurb.transfer_buffer_length = 0;
+		writecount += usblp->writeurb->transfer_buffer_length;
+		usblp->writeurb->transfer_buffer_length = 0;
 
 		if (writecount == count) {
 			up (&usblp->sem);
 			break;
 		}
 
-		usblp->writeurb.transfer_buffer_length = (count - writecount) < USBLP_BUF_SIZE ?
-							 (count - writecount) : USBLP_BUF_SIZE;
+		usblp->writeurb->transfer_buffer_length = (count - writecount) < USBLP_BUF_SIZE ?
+							  (count - writecount) : USBLP_BUF_SIZE;
 
-		if (copy_from_user(usblp->writeurb.transfer_buffer, buffer + writecount,
-				usblp->writeurb.transfer_buffer_length)) return -EFAULT;
+		if (copy_from_user(usblp->writeurb->transfer_buffer, buffer + writecount,
+				usblp->writeurb->transfer_buffer_length)) return -EFAULT;
 
-		usblp->writeurb.dev = usblp->dev;
+		usblp->writeurb->dev = usblp->dev;
 		usblp->wcomplete = 0;
-		if (usb_submit_urb(&usblp->writeurb, GFP_KERNEL)) {
+		if (usb_submit_urb(usblp->writeurb, GFP_KERNEL)) {
 			count = -EIO;
 			up (&usblp->sem);
 			break;
@@ -516,29 +518,29 @@
 		goto done;
 	}
 
-	if (usblp->readurb.status) {
+	if (usblp->readurb->status) {
 		err("usblp%d: error %d reading from printer",
-			usblp->minor, usblp->readurb.status);
-		usblp->readurb.dev = usblp->dev;
+			usblp->minor, usblp->readurb->status);
+		usblp->readurb->dev = usblp->dev;
  		usblp->readcount = 0;
-		usb_submit_urb(&usblp->readurb, GFP_KERNEL);
+		usb_submit_urb(usblp->readurb, GFP_KERNEL);
 		count = -EIO;
 		goto done;
 	}
 
-	count = count < usblp->readurb.actual_length - usblp->readcount ?
-		count :	usblp->readurb.actual_length - usblp->readcount;
+	count = count < usblp->readurb->actual_length - usblp->readcount ?
+		count :	usblp->readurb->actual_length - usblp->readcount;
 
-	if (copy_to_user(buffer, usblp->readurb.transfer_buffer + usblp->readcount, count)) {
+	if (copy_to_user(buffer, usblp->readurb->transfer_buffer + usblp->readcount, count)) {
 		count = -EFAULT;
 		goto done;
 	}
 
-	if ((usblp->readcount += count) == usblp->readurb.actual_length) {
+	if ((usblp->readcount += count) == usblp->readurb->actual_length) {
 		usblp->readcount = 0;
-		usblp->readurb.dev = usblp->dev;
+		usblp->readurb->dev = usblp->dev;
 		usblp->rcomplete = 0;
-		if (usb_submit_urb(&usblp->readurb, GFP_KERNEL)) {
+		if (usb_submit_urb(usblp->readurb, GFP_KERNEL)) {
 			count = -EIO;
 			goto done;
 		}
@@ -668,24 +670,42 @@
 
 	init_waitqueue_head(&usblp->wait);
 
+	usblp->writeurb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!usblp->writeurb) {
+		err("out of memory");
+		kfree(usblp);
+		return NULL;
+	}
+	usblp->readurb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!usblp->readurb) {
+		err("out of memory");
+		usb_free_urb(usblp->writeurb);
+		kfree(usblp);
+		return NULL;
+	}
+
 	if (!(buf = kmalloc(USBLP_BUF_SIZE * (bidir ? 2 : 1), GFP_KERNEL))) {
 		err("out of memory");
+		usb_free_urb(usblp->writeurb);
+		usb_free_urb(usblp->readurb);
 		kfree(usblp);
 		return NULL;
 	}
 
 	if (!(usblp->device_id_string = kmalloc(DEVICE_ID_SIZE, GFP_KERNEL))) {
 		err("out of memory");
+		usb_free_urb(usblp->writeurb);
+		usb_free_urb(usblp->readurb);
 		kfree(usblp);
 		kfree(buf);
 		return NULL;
 	}
 
-	FILL_BULK_URB(&usblp->writeurb, dev, usb_sndbulkpipe(dev, epwrite->bEndpointAddress),
+	FILL_BULK_URB(usblp->writeurb, dev, usb_sndbulkpipe(dev, epwrite->bEndpointAddress),
 		buf, 0, usblp_bulk_write, usblp);
 
 	if (bidir)
-		FILL_BULK_URB(&usblp->readurb, dev, usb_rcvbulkpipe(dev, epread->bEndpointAddress),
+		FILL_BULK_URB(usblp->readurb, dev, usb_rcvbulkpipe(dev, epread->bEndpointAddress),
 			buf + USBLP_BUF_SIZE, USBLP_BUF_SIZE, usblp_bulk_read, usblp);
 
 	/* Get the device_id string if possible. FIXME: Could make this kmalloc(length). */
@@ -737,9 +757,9 @@
 	lock_kernel();
 	usblp->dev = NULL;
 
-	usb_unlink_urb(&usblp->writeurb);
+	usb_unlink_urb(usblp->writeurb);
 	if (usblp->bidir)
-		usb_unlink_urb(&usblp->readurb);
+		usb_unlink_urb(usblp->readurb);
 
 	if (!usblp->used)
 		usblp_cleanup (usblp);
