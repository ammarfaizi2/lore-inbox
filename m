Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265083AbTLHSAM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 13:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265079AbTLHSAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 13:00:11 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:36802 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S265456AbTLHR7G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 12:59:06 -0500
From: Duncan Sands <baldrick@free.fr>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Mon, 8 Dec 2003 18:59:03 +0100
User-Agent: KMail/1.5.4
Cc: David Brownell <david-b@pacbell.net>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, <mfedyk@matchmail.com>,
       <zwane@holomorphy.com>, <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0312081127080.1043-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0312081127080.1043-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312081859.03773.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 December 2003 17:31, Alan Stern wrote:
> On Mon, 8 Dec 2003, Duncan Sands wrote:
> > On Monday 08 December 2003 17:03, David Brownell wrote:
> > > Duncan Sands wrote:
> > > > Hi Vince, I'm not sure, but it looks like a bug in the USB core.
> > > > I was kind of expecting this :)  My patch causes devio.c to hold
> > > > a reference to the usb_device maybe long after the device has
> > > > been disconnected.  This is supposed to be OK, but from your
> > >
> > > ... no, that's not supposed to be OK.  Returning from disconnect()
> > > means that a device driver is no longer referencing the interface
> > > the driver bound to, or ep0.
> >
> > Well, I thought Greg wanted it to be OK :)  Anyway, I don't use
> > the device after disconnect except to take the semaphore
> > (dev->serialize), check for disconnection (dev->state), and
> > of course to execute a usb_put_dev.  Surely this usage should
> > be OK?
>
> As long as your disconnect routine doesn't do usb_put_dev, so that it
> maintains its reference, I don't see a problem.  But why do you want to
> check dev->state later on?  Once your disconnect routine has returned, you
> should be totally through with the device.  You should no longer care
> whether it's attached or not.

Hi Alan, this is for usbfs, not a normal driver.  Recall that I want to replace
use of ps->devsem with ps->dev->serialize.  Currently ps->dev is set to NULL in
the devio.c usbfs disconnect method (if some interface is claimed) or in
inode.c on device disconnect, making it hard to lock with ps->dev->serialize :)
Thus disconnect should no longer be signalled by setting ps->dev to NULL.
For the same reason ps->dev should not be freed on disconnect.  It follows
that I should hold a reference to ps->dev until ps goes down.  And this is
what I do.  By the way, rather than introducing a new flag to indicate
disconnection, ps->dev->state will do.

> And of course, remember that there are valid reasons for your disconnect
> routine to be called even when the device remains attached.  (rmmod is a
> good example.)

Sure.

All the best,

Duncan.

PS: Here is the patch that fixed the original usbfs Oops, but gained the new
one Vince reported:

diff -Nru a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
--- a/drivers/usb/core/devio.c	Sun Dec  7 01:20:31 2003
+++ b/drivers/usb/core/devio.c	Sun Dec  7 01:20:31 2003
@@ -87,17 +87,15 @@
 static ssize_t usbdev_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 {
 	struct dev_state *ps = (struct dev_state *)file->private_data;
+	struct usb_device *dev = ps->dev;
 	ssize_t ret = 0;
 	unsigned len;
 	loff_t pos;
 	int i;
 
 	pos = *ppos;
-	down_read(&ps->devsem);
-	if (!ps->dev) {
-		ret = -ENODEV;
-		goto err;
-	} else if (pos < 0) {
+	down(&dev->serialize);
+	if (pos < 0) {
 		ret = -EINVAL;
 		goto err;
 	}
@@ -106,7 +104,7 @@
 		len = sizeof(struct usb_device_descriptor) - pos;
 		if (len > nbytes)
 			len = nbytes;
-		if (copy_to_user(buf, ((char *)&ps->dev->descriptor) + pos, len)) {
+		if (copy_to_user(buf, ((char *)&dev->descriptor) + pos, len)) {
 			ret = -EFAULT;
 			goto err;
 		}
@@ -118,9 +116,9 @@
 	}
 
 	pos = sizeof(struct usb_device_descriptor);
-	for (i = 0; nbytes && i < ps->dev->descriptor.bNumConfigurations; i++) {
+	for (i = 0; nbytes && i < dev->descriptor.bNumConfigurations; i++) {
 		struct usb_config_descriptor *config =
-			(struct usb_config_descriptor *)ps->dev->rawdescriptors[i];
+			(struct usb_config_descriptor *)dev->rawdescriptors[i];
 		unsigned int length = le16_to_cpu(config->wTotalLength);
 
 		if (*ppos < pos + length) {
@@ -129,7 +127,7 @@
 				len = nbytes;
 
 			if (copy_to_user(buf,
-			    ps->dev->rawdescriptors[i] + (*ppos - pos), len)) {
+			    dev->rawdescriptors[i] + (*ppos - pos), len)) {
 				ret = -EFAULT;
 				goto err;
 			}
@@ -144,7 +142,7 @@
 	}
 
 err:
-	up_read(&ps->devsem);
+	up(&dev->serialize);
 	return ret;
 }
 
@@ -324,22 +322,18 @@
 static void driver_disconnect(struct usb_interface *intf)
 {
 	struct dev_state *ps = usb_get_intfdata (intf);
+	unsigned int ifnum = intf->altsetting->desc.bInterfaceNumber;
 
 	if (!ps)
 		return;
 
-	/* this waits till synchronous requests complete */
-	down_write (&ps->devsem);
-
 	/* prevent new I/O requests */
-	ps->dev = 0;
-	ps->ifclaimed = 0;
 	usb_set_intfdata (intf, NULL);
+	if (ifnum < 8*sizeof(ps->ifclaimed))
+		clear_bit(ifnum, &ps->ifclaimed);
 
 	/* force async requests to complete */
-	destroy_all_async (ps);
-
-	up_write (&ps->devsem);
+	destroy_async_on_interface (ps, ifnum);
 }
 
 struct usb_driver usbdevfs_driver = {
@@ -355,21 +349,18 @@
 	struct usb_interface *iface;
 	int err;
 
-	if (intf >= 8*sizeof(ps->ifclaimed) || !dev
-			|| intf >= dev->actconfig->desc.bNumInterfaces)
+	if (intf >= 8*sizeof(ps->ifclaimed) || intf >= dev->actconfig->desc.bNumInterfaces)
 		return -EINVAL;
-	/* already claimed */
-	if (test_bit(intf, &ps->ifclaimed))
-		return 0;
-	iface = dev->actconfig->interface[intf];
+	if (test_and_set_bit(intf, &ps->ifclaimed))
+		return 0; /* already claimed */
 	err = -EBUSY;
-	lock_kernel();
+	iface = dev->actconfig->interface[intf]; /* change to usb_ifnum_to_if here and elsewhere? */
 	if (!usb_interface_claimed(iface)) {
 		usb_driver_claim_interface(&usbdevfs_driver, iface, ps);
-		set_bit(intf, &ps->ifclaimed);
 		err = 0;
 	}
-	unlock_kernel();
+	if (err)
+		clear_bit(intf, &ps->ifclaimed);
 	return err;
 }
 
@@ -383,13 +374,13 @@
 		return -EINVAL;
 	err = -EINVAL;
 	dev = ps->dev;
-	down(&dev->serialize);
+
+	/* the configuration cannot change under us if we have a claimed interface */
 	if (test_and_clear_bit(intf, &ps->ifclaimed)) {
 		iface = dev->actconfig->interface[intf];
-		usb_driver_release_interface(&usbdevfs_driver, iface);
+		usb_driver_release_interface(&usbdevfs_driver, iface); /* may sleep - beware for BKL! */
 		err = 0;
 	}
-	up(&dev->serialize);
 	return err;
 }
 
@@ -492,7 +483,7 @@
 
 	lock_kernel();
 	ret = -ENOENT;
-	dev = inode->u.generic_ip;
+	dev = usb_get_dev (inode->u.generic_ip);
 	if (!dev) {
 		kfree(ps);
 		goto out;
@@ -504,7 +495,6 @@
 	INIT_LIST_HEAD(&ps->async_pending);
 	INIT_LIST_HEAD(&ps->async_completed);
 	init_waitqueue_head(&ps->wait);
-	init_rwsem(&ps->devsem);
 	ps->discsignr = 0;
 	ps->disctask = current;
 	ps->disccontext = NULL;
@@ -521,18 +511,21 @@
 static int usbdev_release(struct inode *inode, struct file *file)
 {
 	struct dev_state *ps = (struct dev_state *)file->private_data;
+	struct usb_device *dev = ps->dev;
 	unsigned int i;
 
-	lock_kernel();
+	/* the only race is with driver_disconnect */
+	down(&dev->serialize);
 	list_del_init(&ps->list);
 
-	if (ps->dev) {
+	if (dev->state != USB_STATE_NOTATTACHED)
 		for (i = 0; ps->ifclaimed && i < 8*sizeof(ps->ifclaimed); i++)
 			if (test_bit(i, &ps->ifclaimed))
-				releaseintf(ps, i);
-	}
-	unlock_kernel();
+				releaseintf(ps, i); /* may sleep - makes the BKL problematic */
 	destroy_all_async(ps);
+	up(&dev->serialize);
+	usb_put_dev (ps->dev);
+	ps->dev = NULL;
 	kfree(ps);
         return 0;
 }
@@ -712,22 +705,32 @@
 
 static int proc_resetdevice(struct dev_state *ps)
 {
+	struct usb_device *dev = ps->dev;
 	int i, ret;
 
-	ret = usb_reset_device(ps->dev);
+	up(&dev->serialize);
+	ret = usb_reset_device(dev);
+	down(&dev->serialize);
+	if (!ret && dev->state == USB_STATE_NOTATTACHED)
+		ret = -ENODEV;
 	if (ret < 0)
 		return ret;
 
-	for (i = 0; i < ps->dev->actconfig->desc.bNumInterfaces; i++) {
-		struct usb_interface *intf = ps->dev->actconfig->interface[i];
+	for (i = 0; i < dev->actconfig->desc.bNumInterfaces; i++) {
+		struct usb_interface *intf = dev->actconfig->interface[i];
 
 		/* Don't simulate interfaces we've claimed */
 		if (test_bit(i, &ps->ifclaimed))
 			continue;
 
 		err ("%s - this function is broken", __FUNCTION__);
-		if (intf->driver && ps->dev) {
+		if (intf->driver) {
+			up(&dev->serialize);
 			usb_probe_interface (&intf->dev);
+			down(&dev->serialize);
+		}
+		if (dev->state == USB_STATE_NOTATTACHED) {
+			return -ENODEV;
 		}
 	}
 
@@ -976,18 +979,19 @@
         DECLARE_WAITQUEUE(wait, current);
 	struct async *as = NULL;
 	void __user *addr;
+	struct usb_device *dev = ps->dev;
 	int ret;
 
 	add_wait_queue(&ps->wait, &wait);
-	while (ps->dev) {
+	while (dev->state != USB_STATE_NOTATTACHED) {
 		__set_current_state(TASK_INTERRUPTIBLE);
 		if ((as = async_getcompleted(ps)))
 			break;
 		if (signal_pending(current))
 			break;
-		up_read(&ps->devsem);
+		up(&dev->serialize);
 		schedule();
-		down_read(&ps->devsem);
+		down(&dev->serialize);
 	}
 	remove_wait_queue(&ps->wait, &wait);
 	set_current_state(TASK_RUNNING);
@@ -1089,57 +1093,53 @@
 		}
 	}
 
-       if (!ps->dev)
-               retval = -ENODEV;
-       else if (!(ifp = usb_ifnum_to_if (ps->dev, ctrl.ifno)))
+       if (!(ifp = usb_ifnum_to_if (ps->dev, ctrl.ifno)))
                retval = -EINVAL;
-       else switch (ctrl.ioctl_code) {
-
-       /* disconnect kernel driver from interface, leaving it unbound.  */
-       /* maybe unbound - you get no guarantee it stays unbound */
-       case USBDEVFS_DISCONNECT:
-		/* this function is misdesigned - retained for compatibility */
+	else {
 		lock_kernel();
-		driver = ifp->driver;
-		if (driver) {
-			dbg ("disconnect '%s' from dev %d interface %d",
-			     driver->name, ps->dev->devnum, ctrl.ifno);
-			usb_unbind_interface(&ifp->dev);
-		} else
-			retval = -ENODATA;
-		unlock_kernel();
-		break;
+		up(&ps->dev->serialize);
+		switch (ctrl.ioctl_code) {
 
-	/* let kernel drivers try to (re)bind to the interface */
-	case USBDEVFS_CONNECT:
-		lock_kernel();
-		retval = usb_probe_interface (&ifp->dev);
-		unlock_kernel();
-		break;
+		/* disconnect kernel driver from interface, leaving it unbound.  */
+		/* maybe unbound - you get no guarantee it stays unbound */
+		case USBDEVFS_DISCONNECT:
+			/* this function is misdesigned - retained for compatibility */
+			driver = ifp->driver;
+			if (driver) {
+				dbg ("disconnect '%s' from dev %d interface %d",
+					driver->name, ps->dev->devnum, ctrl.ifno);
+				usb_unbind_interface(&ifp->dev);
+			} else
+				retval = -ENODATA;
+			break;
 
-	/* talk directly to the interface's driver */
-	default:
-		/* BKL used here to protect against changing the binding
-		 * of this driver to this device, as well as unloading its
-		 * driver module.
-		 */
-		lock_kernel ();
-		driver = ifp->driver;
-		if (driver == 0 || driver->ioctl == 0) {
-			unlock_kernel();
-			retval = -ENOSYS;
-		} else {
-			if (!try_module_get (driver->owner)) {
-				unlock_kernel();
+		/* let kernel drivers try to (re)bind to the interface */
+		case USBDEVFS_CONNECT:
+			retval = usb_probe_interface (&ifp->dev);
+			break;
+
+		/* talk directly to the interface's driver */
+		default:
+			/* BKL used here to protect against changing the binding
+			* of this driver to this device, as well as unloading its
+			* driver module.
+			*/
+			driver = ifp->driver;
+			if (driver == 0 || driver->ioctl == 0) {
 				retval = -ENOSYS;
-				break;
+			} else {
+				if (!try_module_get (driver->owner)) {
+					retval = -ENOSYS;
+					break;
+				}
+				retval = driver->ioctl (ifp, ctrl.ioctl_code, buf);
+				if (retval == -ENOIOCTLCMD)
+					retval = -ENOTTY;
+				module_put (driver->owner);
 			}
-			unlock_kernel ();
-			retval = driver->ioctl (ifp, ctrl.ioctl_code, buf);
-			if (retval == -ENOIOCTLCMD)
-				retval = -ENOTTY;
-			module_put (driver->owner);
 		}
+		down(&ps->dev->serialize);
+		unlock_kernel();
 	}
 
 	/* cleanup and return */
@@ -1161,13 +1161,15 @@
 static int usbdev_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct dev_state *ps = (struct dev_state *)file->private_data;
+	struct usb_device *dev = ps->dev;
 	int ret = -ENOTTY;
 
 	if (!(file->f_mode & FMODE_WRITE))
 		return -EPERM;
-	down_read(&ps->devsem);
-	if (!ps->dev) {
-		up_read(&ps->devsem);
+
+	down(&dev->serialize);
+	if (dev->state == USB_STATE_NOTATTACHED) {
+		up(&dev->serialize);
 		return -ENODEV;
 	}
 	switch (cmd) {
@@ -1212,7 +1214,9 @@
 		break;
 
 	case USBDEVFS_SETCONFIGURATION:
+		up(&dev->serialize);
 		ret = proc_setconfig(ps, (void __user *)arg);
+		down(&dev->serialize);
 		break;
 
 	case USBDEVFS_SUBMITURB:
@@ -1233,6 +1237,10 @@
 		ret = proc_reapurbnonblock(ps, (void __user *)arg);
 		break;
 
+	case USBDEVFS_RELEASEINTERFACE:
+		ret = proc_releaseinterface(ps, (void __user *)arg);
+		break;
+
 	case USBDEVFS_DISCSIGNAL:
 		ret = proc_disconnectsignal(ps, (void __user *)arg);
 		break;
@@ -1241,15 +1249,12 @@
 		ret = proc_claiminterface(ps, (void __user *)arg);
 		break;
 
-	case USBDEVFS_RELEASEINTERFACE:
-		ret = proc_releaseinterface(ps, (void __user *)arg);
-		break;
-
 	case USBDEVFS_IOCTL:
 		ret = proc_ioctl(ps, (void __user *) arg);
-		break;
+	break;
 	}
-	up_read(&ps->devsem);
+	up(&dev->serialize);
+
 	if (ret >= 0)
 		inode->i_atime = CURRENT_TIME;
 	return ret;
@@ -1264,7 +1269,7 @@
 	poll_wait(file, &ps->wait, wait);
 	if (file->f_mode & FMODE_WRITE && !list_empty(&ps->async_completed))
 		mask |= POLLOUT | POLLWRNORM;
-	if (!ps->dev)
+	if (ps->dev->state == USB_STATE_NOTATTACHED)
 		mask |= POLLERR | POLLHUP;
 	return mask;
 }
diff -Nru a/drivers/usb/core/inode.c b/drivers/usb/core/inode.c
--- a/drivers/usb/core/inode.c	Sun Dec  7 01:20:31 2003
+++ b/drivers/usb/core/inode.c	Sun Dec  7 01:20:31 2003
@@ -717,9 +717,9 @@
 	while (!list_empty(&dev->filelist)) {
 		ds = list_entry(dev->filelist.next, struct dev_state, list);
 		list_del_init(&ds->list);
-		down_write(&ds->devsem);
-		ds->dev = NULL;
-		up_write(&ds->devsem);
+//		down_write(&ds->devsem);
+//		ds->dev = NULL;
+//		up_write(&ds->devsem);
 		if (ds->discsignr) {
 			sinfo.si_signo = SIGPIPE;
 			sinfo.si_errno = EPIPE;
diff -Nru a/include/linux/usbdevice_fs.h b/include/linux/usbdevice_fs.h
--- a/include/linux/usbdevice_fs.h	Sun Dec  7 01:20:31 2003
+++ b/include/linux/usbdevice_fs.h	Sun Dec  7 01:20:31 2003
@@ -154,7 +154,6 @@
 
 struct dev_state {
 	struct list_head list;      /* state list */
-	struct rw_semaphore devsem; /* protects modifications to dev (dev == NULL indicating disconnect) */ 
 	struct usb_device *dev;
 	struct file *file;
 	spinlock_t lock;            /* protects the async urb lists */
