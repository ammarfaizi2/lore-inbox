Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWG3Hfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWG3Hfw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 03:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWG3Hfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 03:35:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29669 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751246AbWG3Hfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 03:35:51 -0400
Date: Sun, 30 Jul 2006 00:35:27 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Benjamin Cherian <benjamin.cherian.kernel@gmail.com>
Cc: <w@1wt.eu>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: Bug with USB proc_bulk in 2.4 kernel
Message-Id: <20060730003527.19bec8ce.zaitcev@redhat.com>
In-Reply-To: <200607271521.38217.benjamin.cherian.kernel@gmail.com>
References: <mailman.1152332281.24203.linux-kernel2news@redhat.com>
	<200607201044.00739.benjamin.cherian.kernel@gmail.com>
	<20060724230732.4fdf2bf4.zaitcev@redhat.com>
	<200607271521.38217.benjamin.cherian.kernel@gmail.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2006 15:21:37 -0700, Benjamin Cherian <benjamin.cherian.kernel@gmail.com> wrote:
> On Monday 24 July 2006 23:07, Pete Zaitcev wrote:

> > Anyway, please test the attached patch. Does it do what you want?
> 
> Sorry to say that it doesnt. When calling usb_get_string_simple in libusb,
> the program segfaults with the patched kernel. I believe that 
> usb_get_string_simple eventually calls usbdev_ioctl.

Indeed, I should've tested better, sorry. How about now?

-- Pete

diff -urp -X dontdiff linux-2.4.32/drivers/usb/devices.c linux-2.4.32-wk/drivers/usb/devices.c
--- linux-2.4.32/drivers/usb/devices.c	2004-11-17 03:54:21.000000000 -0800
+++ linux-2.4.32-wk/drivers/usb/devices.c	2006-07-24 22:30:54.000000000 -0700
@@ -392,7 +392,7 @@ static char *usb_dump_desc(char *start, 
 	 * Grab device's exclusive_access mutex to prevent its driver or
 	 * devio from using this device while we are accessing it.
 	 */
-	down (&dev->exclusive_access);
+	usb_excl_lock(dev, 3, 0);
 
 	start = usb_dump_device_descriptor(start, end, &dev->descriptor);
 
@@ -411,7 +411,7 @@ static char *usb_dump_desc(char *start, 
 	}
 
 out:
-	up (&dev->exclusive_access);
+	usb_excl_unlock(dev, 3);
 	return start;
 }
 
diff -urp -X dontdiff linux-2.4.32/drivers/usb/devio.c linux-2.4.32-wk/drivers/usb/devio.c
--- linux-2.4.32/drivers/usb/devio.c	2006-04-13 19:02:30.000000000 -0700
+++ linux-2.4.32-wk/drivers/usb/devio.c	2006-07-30 00:27:13.000000000 -0700
@@ -623,7 +623,12 @@ static int proc_bulk(struct dev_state *p
 			free_page((unsigned long)tbuf);
 			return -EINVAL;
 		}
+		if (usb_excl_lock(dev, 1, 1) != 0) {
+			free_page((unsigned long)tbuf);
+			return -ERESTARTSYS;
+		}
 		i = usb_bulk_msg(dev, pipe, tbuf, len1, &len2, tmo);
+		usb_excl_unlock(dev, 1);
 		if (!i && len2) {
 			if (copy_to_user(bulk.data, tbuf, len2)) {
 				free_page((unsigned long)tbuf);
@@ -637,7 +642,12 @@ static int proc_bulk(struct dev_state *p
 				return -EFAULT;
 			}
 		}
+		if (usb_excl_lock(dev, 2, 1) != 0) {
+			free_page((unsigned long)tbuf);
+			return -ERESTARTSYS;
+		}
 		i = usb_bulk_msg(dev, pipe, tbuf, len1, &len2, tmo);
+		usb_excl_unlock(dev, 2);
 	}
 	free_page((unsigned long)tbuf);
 	if (i < 0) {
@@ -1160,12 +1170,6 @@ static int usbdev_ioctl_exclusive(struct
 			inode->i_mtime = CURRENT_TIME;
 		break;
 
-	case USBDEVFS_BULK:
-		ret = proc_bulk(ps, (void *)arg);
-		if (ret >= 0)
-			inode->i_mtime = CURRENT_TIME;
-		break;
-
 	case USBDEVFS_RESETEP:
 		ret = proc_resetep(ps, (void *)arg);
 		if (ret >= 0)
@@ -1259,8 +1263,13 @@ static int usbdev_ioctl(struct inode *in
 		ret = proc_disconnectsignal(ps, (void *)arg);
 		break;
 
-	case USBDEVFS_CONTROL:
 	case USBDEVFS_BULK:
+		ret = proc_bulk(ps, (void *)arg);
+		if (ret >= 0)
+			inode->i_mtime = CURRENT_TIME;
+		break;
+
+	case USBDEVFS_CONTROL:
 	case USBDEVFS_RESETEP:
 	case USBDEVFS_RESET:
 	case USBDEVFS_CLEAR_HALT:
@@ -1272,9 +1281,9 @@ static int usbdev_ioctl(struct inode *in
 	case USBDEVFS_RELEASEINTERFACE:
 	case USBDEVFS_IOCTL:
 		ret = -ERESTARTSYS;
-		if (down_interruptible(&ps->dev->exclusive_access) == 0) {
+		if (usb_excl_lock(ps->dev, 3, 1) == 0) {
 			ret = usbdev_ioctl_exclusive(ps, inode, cmd, arg);
-			up(&ps->dev->exclusive_access);
+			usb_excl_unlock(ps->dev, 3);
 		}
 		break;
 
diff -urp -X dontdiff linux-2.4.32/drivers/usb/storage/transport.c linux-2.4.32-wk/drivers/usb/storage/transport.c
--- linux-2.4.32/drivers/usb/storage/transport.c	2005-04-03 18:42:19.000000000 -0700
+++ linux-2.4.32-wk/drivers/usb/storage/transport.c	2006-07-24 22:58:58.000000000 -0700
@@ -628,16 +628,16 @@ void usb_stor_invoke_transport(Scsi_Cmnd
 	int result;
 
 	/*
-	 * Grab device's exclusive_access mutex to prevent libusb/usbfs from
+	 * Grab device's exclusive access lock to prevent libusb/usbfs from
 	 * sending out a command in the middle of ours (if libusb sends a
 	 * get_descriptor or something on pipe 0 after our CBW and before
 	 * our CSW, and then we get a stall, we have trouble).
 	 */
-	down(&(us->pusb_dev->exclusive_access));
+	usb_excl_lock(us->pusb_dev, 3, 0);
 
 	/* send the command to the transport layer */
 	result = us->transport(srb, us);
-	up(&(us->pusb_dev->exclusive_access));
+	usb_excl_unlock(us->pusb_dev, 3);
 
 	/* if the command gets aborted by the higher layers, we need to
 	 * short-circuit all other processing
@@ -757,9 +757,9 @@ void usb_stor_invoke_transport(Scsi_Cmnd
 		srb->use_sg = 0;
 
 		/* issue the auto-sense command */
-		down(&(us->pusb_dev->exclusive_access));
+		usb_excl_lock(us->pusb_dev, 3, 0);
 		temp_result = us->transport(us->srb, us);
-		up(&(us->pusb_dev->exclusive_access));
+		usb_excl_unlock(us->pusb_dev, 3);
 
 		/* let's clean up right away */
 		srb->request_buffer = old_request_buffer;
diff -urp -X dontdiff linux-2.4.32/drivers/usb/usb.c linux-2.4.32-wk/drivers/usb/usb.c
--- linux-2.4.32/drivers/usb/usb.c	2004-11-17 03:54:21.000000000 -0800
+++ linux-2.4.32-wk/drivers/usb/usb.c	2006-07-24 22:41:19.000000000 -0700
@@ -989,7 +989,8 @@ struct usb_device *usb_alloc_dev(struct 
 	INIT_LIST_HEAD(&dev->filelist);
 
 	init_MUTEX(&dev->serialize);
-	init_MUTEX(&dev->exclusive_access);
+	spin_lock_init(&dev->excl_lock);
+	init_waitqueue_head(&dev->excl_wait);
 
 	dev->bus->op->allocate(dev);
 
@@ -2380,6 +2381,59 @@ struct list_head *usb_bus_get_list(void)
 }
 #endif
 
+int usb_excl_lock(struct usb_device *dev, unsigned int type, int interruptible)
+{
+	DECLARE_WAITQUEUE(waita, current);
+
+	add_wait_queue(&dev->excl_wait, &waita);
+	if (interruptible)
+		set_current_state(TASK_INTERRUPTIBLE);
+	else
+		set_current_state(TASK_UNINTERRUPTIBLE);
+
+	for (;;) {
+		spin_lock_irq(&dev->excl_lock);
+		switch (type) {
+		case 1:		/* 1 - read */
+		case 2:		/* 2 - write */
+		case 3:		/* 3 - control: excludes both read and write */
+			if ((dev->excl_type & type) == 0) {
+				dev->excl_type |= type;
+				spin_unlock_irq(&dev->excl_lock);
+				set_current_state(TASK_RUNNING);
+				remove_wait_queue(&dev->excl_wait, &waita);
+				return 0;
+			}
+			break;
+		default:
+			spin_unlock_irq(&dev->excl_lock);
+			return -EINVAL;
+		}
+		spin_unlock_irq(&dev->excl_lock);
+
+		if (interruptible) {
+			schedule();
+			if (signal_pending(current)) {
+				remove_wait_queue(&dev->excl_wait, &waita);
+				return 1;
+			}
+			set_current_state(TASK_INTERRUPTIBLE);
+		} else {
+			schedule();
+			set_current_state(TASK_UNINTERRUPTIBLE);
+		}
+	}
+}
+
+void usb_excl_unlock(struct usb_device *dev, unsigned int type)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->excl_lock, flags);
+	dev->excl_type &= ~type;
+	wake_up(&dev->excl_wait);
+	spin_unlock_irqrestore(&dev->excl_lock, flags);
+}
 
 /*
  * Init
diff -urp -X dontdiff linux-2.4.32/include/linux/usb.h linux-2.4.32-wk/include/linux/usb.h
--- linux-2.4.32/include/linux/usb.h	2005-12-22 17:08:01.000000000 -0800
+++ linux-2.4.32-wk/include/linux/usb.h	2006-07-24 22:30:02.000000000 -0700
@@ -828,8 +828,19 @@ struct usb_device {
 
 	atomic_t refcnt;		/* Reference count */
 	struct semaphore serialize;
-	struct semaphore exclusive_access; /* prevent driver & proc accesses  */
-					   /* from overlapping cmds at device */
+
+	/*
+	 * This is our custom open-coded lock, similar to r/w locks in concept.
+	 * It prevents drivers and /proc access from simultaneous access.
+	 * Type:
+	 *   0 - unlocked
+	 *   1 - locked for reads
+	 *   2 - locked for writes
+	 *   3 - locked for everything
+	 */
+	wait_queue_head_t excl_wait;
+	spinlock_t excl_lock;
+	unsigned excl_type;
 
 	unsigned int toggle[2];		/* one bit for each endpoint ([0] = IN, [1] = OUT) */
 	unsigned int halted[2];		/* endpoint halts; one bit per endpoint # & direction; */
@@ -904,6 +915,8 @@ extern void usb_destroy_configuration(st
 
 int usb_get_current_frame_number (struct usb_device *usb_dev);
 
+int usb_excl_lock(struct usb_device *dev, unsigned int type, int interruptible);
+void usb_excl_unlock(struct usb_device *dev, unsigned int type);
 
 /**
  * usb_make_path - returns stable device path in the usb tree
