Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265290AbTLGA0X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 19:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265292AbTLGA0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 19:26:23 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:39122 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S265290AbTLGA0D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 19:26:03 -0500
From: Duncan Sands <baldrick@free.fr>
To: Vince <fuzzy77@free.fr>
Subject: Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Sun, 7 Dec 2003 01:25:56 +0100
User-Agent: KMail/1.5.4
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, mfedyk@matchmail.com,
       zwane@holomorphy.com, linux-kernel@vger.kernel.org
References: <3FC4E8C8.4070902@free.fr> <200312050838.58349.baldrick@free.fr> <3FD059BD.1090704@free.fr>
In-Reply-To: <3FD059BD.1090704@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312070125.56251.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 December 2003 11:11, Vince wrote:
> Duncan Sands wrote:
> > On Thursday 04 December 2003 17:57, Randy.Dunlap wrote:
> >>On Thu, 4 Dec 2003 12:14:33 +0100 Duncan Sands <baldrick@free.fr> wrote:
> >>| > EIP is at releaseintf+0x62/0x80 [usbcore]
> >>|
> >>| I haven't found time to work on this, sorry -
> >>| I'm really busy with my real jobs right now.
> >>|
> >>| > <0>Fatal exception: panic in 5 seconds
> >>|
> >>| What is this, by the way?  I never saw it.
> >>
> >>That comes from setting the sysctl "panic_on_oops" so that an oops
> >>goes straight to a panic condition.
> >
> > That explains why this relatively harmless Oops was
> > freezing Vince's box.  I guess he should turn it off.
>
> Well, I don't find this oops harmless at all : my box is usually
> freezing while in a huge of other oopses that directly follow this one,
> and then nothing makes it into the logs. I had to set this sysctl once
> in order to get the first oops, but that's not related to the other
> freeze...

Does this help?  It isn't finished - it represents the current state of my fix.
Warning: have barf bag ready.

Ciao,

Duncan.

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
