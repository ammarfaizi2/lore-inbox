Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265060AbUGCIcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbUGCIcl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 04:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265058AbUGCIck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 04:32:40 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:44749 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S265060AbUGCI3M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 04:29:12 -0400
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
Subject: Re: [linux-usb-devel] Re: USBDEVFS_RESET deadlocks USB bus.
Date: Sat, 3 Jul 2004 10:28:58 +0200
User-Agent: KMail/1.6.2
Cc: Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org,
       "David A. Desrosiers" <desrod@gnu-designs.com>
References: <20040702204756.GC3447@babylon.d2dc.net> <Pine.LNX.4.44L0.0407021700110.21819-100000@netrider.rowland.org> <20040702215253.GD3447@babylon.d2dc.net>
In-Reply-To: <20040702215253.GD3447@babylon.d2dc.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200407031029.00506.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Specificly, if you have a thread doing bulk reads on a USB device in a
> loop, and the device stops talking to you (for instance, waiting for you
> to reply), it becomes impossible to take any action on the device,
> including aborting the read or issuing a write to the device to tell it
> to keep talking until such a time as the read times out, the device
> speaks to us, or the device is physically disconnected.
> 
> Using timeouts can mediate this, but at the cost of being far less
> responsive unless you use a very short timeout.
> 
> I am unsure if the kernel provides the locking infrastructure to allow
> us to keep us from reading/writing while doing the various events, while
> also allowing us to read and write at the same time.

Hi Zephaniah, I've written a patch to do this, but I haven't finished testing
it yet.  I've put the current version below.  It doesn't (yet) fix the problem
of not being able to interrupt a read/write by sending a signal.  However
it brings things back to where they were before the extra locking went in.
It's against Greg's tree from a little while ago, so may need some fiddling
with before it applies.

Ciao,

Duncan.

===== drivers/usb/core/devio.c 1.77 vs edited =====
--- 1.77/drivers/usb/core/devio.c	2004-05-13 17:39:48 +02:00
+++ edited/drivers/usb/core/devio.c	2004-06-27 21:40:36 +02:00
@@ -45,6 +45,7 @@
 #include <linux/usbdevice_fs.h>
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
+#include <linux/moduleparam.h>
 
 #include "hcd.h"	/* for usbcore internals */
 #include "usb.h"
@@ -70,6 +71,7 @@
 			dev_info( dev , format , ## arg);	\
 	} while (0)
 
+#define MAX_BUFFER_LENGTH	16384
 
 static inline int connected (struct usb_device *dev)
 {
@@ -180,29 +182,12 @@
  * async list handling
  */
 
-static struct async *alloc_async(unsigned int numisoframes)
-{
-        unsigned int assize = sizeof(struct async) + numisoframes * sizeof(struct usb_iso_packet_descriptor);
-        struct async *as = kmalloc(assize, GFP_KERNEL);
-        if (!as)
-                return NULL;
-        memset(as, 0, assize);
-	as->urb = usb_alloc_urb(numisoframes, GFP_KERNEL);
-	if (!as->urb) {
-		kfree(as);
-		return NULL;
-	}
-        return as;
-}
-
 static void free_async(struct async *as)
 {
-        if (as->urb->transfer_buffer)
-                kfree(as->urb->transfer_buffer);
-        if (as->urb->setup_packet)
-                kfree(as->urb->setup_packet);
+	kfree(as->urb->transfer_buffer);
+	kfree(as->urb->setup_packet);
 	usb_free_urb(as->urb);
-        kfree(as);
+	kfree(as);
 }
 
 static inline void async_newpending(struct async *as)
@@ -526,225 +511,378 @@
         return 0;
 }
 
+static void wakeup_completion(struct urb *urb, struct pt_regs *regs)
+{
+	        complete((struct completion *)urb->context);
+}
+
+static void timeout_kill(unsigned long data)
+{
+	struct urb *urb = (struct urb *) data;
+        usb_unlink_urb(urb);
+}
+
+static int start_wait_urb(struct usb_device *dev, struct urb *urb, int timeout, int* actual_length)
+{
+	struct completion done;
+	struct timer_list timer;
+	int status;
+
+	init_completion(&done);
+	urb->context = &done;
+	urb->complete = wakeup_completion;
+	urb->transfer_flags |= URB_ASYNC_UNLINK;
+	urb->actual_length = 0;
+	status = usb_submit_urb(urb, GFP_NOIO);
+
+	if (status == 0) {
+		if (timeout > 0) {
+			init_timer(&timer);
+			timer.expires = jiffies + timeout;
+			timer.data = (unsigned long)urb;
+			timer.function = timeout_kill;
+			/* grr.  timeout _should_ include submit delays. */
+			add_timer(&timer);
+		}
+		up(&dev->serialize);
+		wait_for_completion(&done);
+		down(&dev->serialize);
+		status = urb->status;
+		/* note:  HCDs return ETIMEDOUT for other reasons too */
+		if (status == -ECONNRESET)
+			status = -ETIMEDOUT;
+		if (timeout > 0)
+			del_timer_sync(&timer);
+	}
+
+	if (actual_length)
+		*actual_length = urb->actual_length;
+	return status;
+}
+
 static int proc_control(struct dev_state *ps, void __user *arg)
 {
-	struct usb_device *dev = ps->dev;
 	struct usbdevfs_ctrltransfer ctrl;
-	unsigned int tmo;
-	unsigned char *tbuf;
-	int i, j, ret;
+	struct usb_device *dev = ps->dev;
+	struct usb_ctrlrequest *dr = NULL;
+	unsigned char *tbuf = NULL;
+	struct urb *urb = NULL;
+	int dir_in, j, length, ret;
+	unsigned int pipe, timeout;
 
 	if (copy_from_user(&ctrl, arg, sizeof(ctrl)))
 		return -EFAULT;
-	if ((ret = check_ctrlrecip(ps, ctrl.bRequestType, ctrl.wIndex)))
-		return ret;
-	if (ctrl.wLength > PAGE_SIZE)
+	length = ctrl.wLength;
+	if (length < 0 || length > PAGE_SIZE)
 		return -EINVAL;
 	if (!(tbuf = (unsigned char *)__get_free_page(GFP_KERNEL)))
 		return -ENOMEM;
-	tmo = (ctrl.timeout * HZ + 999) / 1000;
-	if (ctrl.bRequestType & 0x80) {
-		if (ctrl.wLength && !access_ok(VERIFY_WRITE, ctrl.data, ctrl.wLength)) {
-			free_page((unsigned long)tbuf);
-			return -EINVAL;
-		}
-		snoop(&dev->dev, "control read: bRequest=%02x bRrequestType=%02x wValue=%04x wIndex=%04x\n", 
-			ctrl.bRequest, ctrl.bRequestType, ctrl.wValue, ctrl.wIndex);
-
-		i = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0), ctrl.bRequest, ctrl.bRequestType,
-				       ctrl.wValue, ctrl.wIndex, tbuf, ctrl.wLength, tmo);
-		if ((i > 0) && ctrl.wLength) {
-			if (usbfs_snoop) {
-				dev_info(&dev->dev, "control read: data ");
-				for (j = 0; j < ctrl.wLength; ++j)
-					printk ("%02x ", (unsigned char)((char *)ctrl.data)[j]);
-				printk("\n");
-			}
-			if (copy_to_user(ctrl.data, tbuf, ctrl.wLength)) {
-				free_page((unsigned long)tbuf);
-				return -EFAULT;
-			}
+	dir_in = ctrl.bRequestType & USB_DIR_IN;
+	if (dir_in) {
+		if (length && !access_ok(VERIFY_WRITE, ctrl.data, length)) {
+			ret = -EINVAL;
+			goto out_free;
 		}
 	} else {
-		if (ctrl.wLength) {
-			if (copy_from_user(tbuf, ctrl.data, ctrl.wLength)) {
-				free_page((unsigned long)tbuf);
-				return -EFAULT;
+		if (length) {
+			if (copy_from_user(tbuf, ctrl.data, length)) {
+				ret = -EFAULT;
+				goto out_free;
 			}
 		}
-		snoop(&dev->dev, "control write: bRequest=%02x bRrequestType=%02x wValue=%04x wIndex=%04x\n", 
-			ctrl.bRequest, ctrl.bRequestType, ctrl.wValue, ctrl.wIndex);
+	}
+	snoop(&dev->dev, "control %s: bRequest=%02x bRrequestType=%02x wValue=%04x wIndex=%04x wLength=%04x\n", 
+		dir_in ? "read" : "write", ctrl.bRequest, ctrl.bRequestType, ctrl.wValue, ctrl.wIndex, ctrl.wLength);
+	if (usbfs_snoop && !dir_in) {
+		dev_info(&dev->dev, "control write: data: ");
+		for (j = 0; j < length; ++j)
+			printk ("%02x ", (unsigned char)((char *)ctrl.data)[j]);
+		printk("\n");
+	}
+	if (!(urb = usb_alloc_urb(0, GFP_KERNEL))) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+	if (!(dr = kmalloc(sizeof(struct usb_ctrlrequest), GFP_KERNEL))) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+	down(&dev->serialize);
+	if (!connected(dev)) {
+		ret = -ENODEV;
+		goto out_release;
+	}
+	if ((ret = check_ctrlrecip(ps, ctrl.bRequestType, ctrl.wIndex)))
+		goto out_release;
+	if (dir_in)
+		pipe = usb_rcvctrlpipe(dev, 0);
+	else
+		pipe = usb_sndctrlpipe(dev, 0);
+	timeout = (ctrl.timeout * HZ + 999) / 1000;
+	dr->bRequestType= ctrl.bRequestType;
+	dr->bRequest = ctrl.bRequest;
+	dr->wValue = cpu_to_le16p(&ctrl.wValue);
+	dr->wIndex = cpu_to_le16p(&ctrl.wIndex);
+	dr->wLength = cpu_to_le16p(&ctrl.wLength);
+	usb_fill_control_urb(urb, dev, pipe, (unsigned char*)dr, tbuf, length, NULL, 0);
+	ret = start_wait_urb(dev, urb, timeout, &length);
+	up(&dev->serialize);
+	if (ret < 0) {
+		dev_warn(&dev->dev, "usbfs: USBDEVFS_CONTROL failed "
+			   "cmd %s rqt %u rq %u len %u ret %d\n",
+			   current->comm, ctrl.bRequestType, ctrl.bRequest,
+			   ctrl.wLength, ret);
+		goto out_free;
+	}
+	if (dir_in && length) {
 		if (usbfs_snoop) {
-			dev_info(&dev->dev, "control write: data: ");
-			for (j = 0; j < ctrl.wLength; ++j)
-				printk ("%02x ", (unsigned char)((char *)ctrl.data)[j]);
+			dev_info(&dev->dev, "control read: data ");
+			for (j = 0; j < length; ++j)
+				printk ("%02x ", tbuf[j]);
 			printk("\n");
 		}
-		i = usb_control_msg(dev, usb_sndctrlpipe(dev, 0), ctrl.bRequest, ctrl.bRequestType,
-				       ctrl.wValue, ctrl.wIndex, tbuf, ctrl.wLength, tmo);
+		if (copy_to_user(ctrl.data, tbuf, length)) {
+			ret = -EFAULT;
+			goto out_free;
+		}
 	}
+	kfree(dr);
+	usb_free_urb(urb);
 	free_page((unsigned long)tbuf);
-	if (i<0) {
-		dev_printk(KERN_DEBUG, &dev->dev, "usbfs: USBDEVFS_CONTROL "
-			   "failed cmd %s rqt %u rq %u len %u ret %d\n",
-			   current->comm, ctrl.bRequestType, ctrl.bRequest,
-			   ctrl.wLength, i);
-	}
-	return i;
+	return ret;
+out_release:
+	up(&dev->serialize);
+out_free:
+	kfree(dr);
+	usb_free_urb(urb);
+	free_page((unsigned long)tbuf);
+	return ret;
 }
 
 static int proc_bulk(struct dev_state *ps, void __user *arg)
 {
-	struct usb_device *dev = ps->dev;
 	struct usbdevfs_bulktransfer bulk;
-	unsigned int tmo, len1, pipe;
-	int len2;
-	unsigned char *tbuf;
-	int i, ret;
+	struct usb_device *dev = ps->dev;
+	unsigned char *tbuf = NULL;
+	struct urb *urb = NULL;
+	int dir_in, length, ret;
+	unsigned int pipe, timeout;
 
 	if (copy_from_user(&bulk, arg, sizeof(bulk)))
 		return -EFAULT;
-	if ((ret = findintfep(ps->dev, bulk.ep)) < 0)
-		return ret;
-	if ((ret = checkintf(ps, ret)))
-		return ret;
-	if (bulk.ep & USB_DIR_IN)
-		pipe = usb_rcvbulkpipe(dev, bulk.ep & 0x7f);
-	else
-		pipe = usb_sndbulkpipe(dev, bulk.ep & 0x7f);
-	if (!usb_maxpacket(dev, pipe, !(bulk.ep & USB_DIR_IN)))
+	length = bulk.len;
+	if (length < 0 || length > MAX_BUFFER_LENGTH)
 		return -EINVAL;
-	len1 = bulk.len;
-	if (!(tbuf = kmalloc(len1, GFP_KERNEL)))
+	if (!(tbuf = kmalloc(length, GFP_KERNEL)))
 		return -ENOMEM;
-	tmo = (bulk.timeout * HZ + 999) / 1000;
-	if (bulk.ep & 0x80) {
-		if (len1 && !access_ok(VERIFY_WRITE, bulk.data, len1)) {
-			kfree(tbuf);
-			return -EINVAL;
-		}
-		i = usb_bulk_msg(dev, pipe, tbuf, len1, &len2, tmo);
-		if (!i && len2) {
-			if (copy_to_user(bulk.data, tbuf, len2)) {
-				kfree(tbuf);
-				return -EFAULT;
-			}
+	dir_in = bulk.ep & USB_DIR_IN;
+	if (dir_in) {
+		if (length && !access_ok(VERIFY_WRITE, bulk.data, length)) {
+			ret = -EINVAL;
+			goto out_free;
 		}
 	} else {
-		if (len1) {
-			if (copy_from_user(tbuf, bulk.data, len1)) {
-				kfree(tbuf);
-				return -EFAULT;
+		if (length) {
+			if (copy_from_user(tbuf, bulk.data, length)) {
+				ret = -EFAULT;
+				goto out_free;
 			}
 		}
-		i = usb_bulk_msg(dev, pipe, tbuf, len1, &len2, tmo);
 	}
-	kfree(tbuf);
-	if (i < 0) {
+	if (!(urb = usb_alloc_urb(0, GFP_KERNEL))) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+	down(&dev->serialize);
+	if (!connected(dev)) {
+		ret = -ENODEV;
+		goto out_release;
+	}
+	if ((ret = findintfep(ps->dev, bulk.ep)) < 0)
+		goto out_release;
+	if ((ret = checkintf(ps, ret)))
+		goto out_release;
+	if (dir_in)
+		pipe = usb_rcvbulkpipe(dev, bulk.ep & 0x7f);
+	else
+		pipe = usb_sndbulkpipe(dev, bulk.ep & 0x7f);
+	if (!usb_maxpacket(dev, pipe, !dir_in)) {
+		ret = -EINVAL;
+		goto out_release;
+	}
+	timeout = (bulk.timeout * HZ + 999) / 1000;
+	usb_fill_bulk_urb(urb, dev, pipe, tbuf, length, NULL, NULL);
+	ret = start_wait_urb(dev, urb, timeout, &length);
+	up(&dev->serialize);
+	if (ret < 0) {
 		dev_warn(&dev->dev, "usbfs: USBDEVFS_BULK failed "
-			 "ep 0x%x len %u ret %d\n", bulk.ep, bulk.len, i);
-		return i;
+			 "ep 0x%x len %u ret %d\n", bulk.ep, bulk.len, ret);
+		goto out_free;
+	}
+	if (dir_in && length) {
+		if (copy_to_user(bulk.data, tbuf, length)) {
+			ret = -EFAULT;
+			goto out_free;
+		}
 	}
-	return len2;
+	usb_free_urb(urb);
+	kfree(tbuf);
+	return length;
+out_release:
+	up(&dev->serialize);
+out_free:
+	usb_free_urb(urb);
+	kfree(tbuf);
+	return ret;
 }
 
 static int proc_resetep(struct dev_state *ps, void __user *arg)
 {
+	struct usb_device *dev = ps->dev;
 	unsigned int ep;
 	int ret;
 
 	if (get_user(ep, (unsigned int __user *)arg))
 		return -EFAULT;
+	down(&dev->serialize);
+	if (!connected(dev)) {
+		ret = -ENODEV;
+		goto out;
+	}
 	if ((ret = findintfep(ps->dev, ep)) < 0)
-		return ret;
+		goto out;
 	if ((ret = checkintf(ps, ret)))
-		return ret;
+		goto out;
 	usb_settoggle(ps->dev, ep & 0xf, !(ep & USB_DIR_IN), 0);
-	return 0;
+out:
+	up(&dev->serialize);
+	return ret;
 }
 
 static int proc_clearhalt(struct dev_state *ps, void __user *arg)
 {
+	struct usb_device *dev = ps->dev;
 	unsigned int ep;
 	int pipe;
 	int ret;
 
 	if (get_user(ep, (unsigned int __user *)arg))
 		return -EFAULT;
-	if ((ret = findintfep(ps->dev, ep)) < 0)
-		return ret;
+	down(&dev->serialize);
+	if (!connected(dev)) {
+		ret = -ENODEV;
+		goto out;
+	}
+	if ((ret = findintfep(dev, ep)) < 0)
+		goto out;
 	if ((ret = checkintf(ps, ret)))
-		return ret;
+		goto out;
 	if (ep & USB_DIR_IN)
-                pipe = usb_rcvbulkpipe(ps->dev, ep & 0x7f);
+                pipe = usb_rcvbulkpipe(dev, ep & 0x7f);
         else
-                pipe = usb_sndbulkpipe(ps->dev, ep & 0x7f);
+                pipe = usb_sndbulkpipe(dev, ep & 0x7f);
 
-	return usb_clear_halt(ps->dev, pipe);
+	ret = usb_clear_halt(dev, pipe);
+out:
+	up(&dev->serialize);
+	return ret;
 }
 		
 
 static int proc_getdriver(struct dev_state *ps, void __user *arg)
 {
 	struct usbdevfs_getdriver gd;
+	struct usb_device *dev = ps->dev;
 	struct usb_interface *intf;
-	int ret;
+	int ret = 0;
 
 	if (copy_from_user(&gd, arg, sizeof(gd)))
 		return -EFAULT;
+	down(&dev->serialize);
+	if (!connected(dev)) {
+		up(&dev->serialize);
+		return -ENODEV;
+	}
 	down_read(&usb_bus_type.subsys.rwsem);
-	intf = usb_ifnum_to_if(ps->dev, gd.interface);
+	intf = usb_ifnum_to_if(dev, gd.interface);
 	if (!intf || !intf->dev.driver)
 		ret = -ENODATA;
-	else {
-		strncpy(gd.driver, intf->dev.driver->name,
-				sizeof(gd.driver));
-		ret = (copy_to_user(arg, &gd, sizeof(gd)) ? -EFAULT : 0);
-	}
+	else
+		strncpy(gd.driver, intf->dev.driver->name, sizeof(gd.driver));
 	up_read(&usb_bus_type.subsys.rwsem);
+	up(&dev->serialize);
+	if (!ret)
+		ret = (copy_to_user(arg, &gd, sizeof(gd)) ? -EFAULT : 0);
 	return ret;
 }
 
 static int proc_connectinfo(struct dev_state *ps, void __user *arg)
 {
 	struct usbdevfs_connectinfo ci;
+	struct usb_device *dev = ps->dev;
 
-	ci.devnum = ps->dev->devnum;
-	ci.slow = ps->dev->speed == USB_SPEED_LOW;
-	if (copy_to_user(arg, &ci, sizeof(ci)))
-		return -EFAULT;
-	return 0;
+	down(&dev->serialize);
+	if (!connected(dev)) {
+		up(&dev->serialize);
+		return -ENODEV;
+	}
+	ci.devnum = dev->devnum;
+	ci.slow = dev->speed == USB_SPEED_LOW;
+	up(&dev->serialize);
+	return copy_to_user(arg, &ci, sizeof(ci)) ? -EFAULT : 0;
 }
 
 static int proc_resetdevice(struct dev_state *ps)
 {
-	return usb_reset_device(ps->dev);
+	struct usb_device *dev = ps->dev;
+	int ret;
 
+	down(&dev->serialize);
+	if (!connected(dev))
+		ret = -ENODEV;
+	else
+		ret = usb_reset_device(dev);
+	up(&dev->serialize);
+	return ret;
 }
 
 static int proc_setintf(struct dev_state *ps, void __user *arg)
 {
 	struct usbdevfs_setinterface setintf;
+	struct usb_device *dev = ps->dev;
 	int ret;
 
 	if (copy_from_user(&setintf, arg, sizeof(setintf)))
 		return -EFAULT;
+	down(&dev->serialize);
+	if (!connected(dev)) {
+		ret = -ENODEV;
+		goto out;
+	}
 	if ((ret = checkintf(ps, setintf.interface)))
-		return ret;
-	return usb_set_interface(ps->dev, setintf.interface,
-			setintf.altsetting);
+		goto out;
+	ret = usb_set_interface(dev, setintf.interface, setintf.altsetting);
+out:
+	up(&dev->serialize);
+	return ret;
 }
 
 static int proc_setconfig(struct dev_state *ps, void __user *arg)
 {
-	unsigned int u;
-	int status = 0;
+	struct usb_device *dev = ps->dev;
  	struct usb_host_config *actconfig;
+	int ret;
+	unsigned int u;
 
 	if (get_user(u, (unsigned int __user *)arg))
 		return -EFAULT;
 
- 	actconfig = ps->dev->actconfig;
+	down(&dev->serialize);
+	if (!connected(dev)) {
+		ret = -ENODEV;
+		goto out;
+	}
+ 	actconfig = dev->actconfig;
  
  	/* Don't touch the device if any interfaces are claimed.
  	 * It could interfere with other drivers' operations, and if
@@ -755,7 +893,7 @@
  
  		for (i = 0; i < actconfig->desc.bNumInterfaces; ++i) {
  			if (usb_interface_claimed(actconfig->interface[i])) {
-				dev_warn (&ps->dev->dev,
+				dev_warn (&dev->dev,
 					"usbfs: interface %d claimed "
 					"while '%s' sets config #%d\n",
 					actconfig->interface[i]
@@ -763,8 +901,8 @@
 						->desc.bInterfaceNumber,
 					current->comm, u);
 #if 0	/* FIXME:  enable in 2.6.10 or so */
- 				status = -EBUSY;
-				break;
+ 				ret = -EBUSY;
+				goto out;
 #endif
 			}
  		}
@@ -773,23 +911,24 @@
 	/* SET_CONFIGURATION is often abused as a "cheap" driver reset,
 	 * so avoid usb_set_configuration()'s kick to sysfs
 	 */
-	if (status == 0) {
-		if (actconfig && actconfig->desc.bConfigurationValue == u)
-			status = usb_reset_configuration(ps->dev);
-		else
-			status = usb_set_configuration(ps->dev, u);
-	}
+	if (actconfig && actconfig->desc.bConfigurationValue == u)
+		ret = usb_reset_configuration(dev);
+	else
+		ret = usb_set_configuration(dev, u);
 
-	return status;
+out:
+	up(&dev->serialize);
+	return ret;
 }
 
 static int proc_submiturb(struct dev_state *ps, void __user *arg)
 {
 	struct usbdevfs_urb uurb;
-	struct usbdevfs_iso_packet_desc *isopkt = NULL;
-	struct usb_endpoint_descriptor *ep_desc;
-	struct async *as;
+	struct async *as = NULL;
+	struct usb_device *dev = ps->dev;
 	struct usb_ctrlrequest *dr = NULL;
+	struct usb_endpoint_descriptor *ep_desc;
+	struct usbdevfs_iso_packet_desc *isopkt = NULL;
 	unsigned int u, totlen, isofrmlen;
 	int ret, interval = 0, ifnum = -1;
 
@@ -802,50 +941,35 @@
 		return -EINVAL;
 	if (uurb.signr != 0 && (uurb.signr < SIGRTMIN || uurb.signr > SIGRTMAX))
 		return -EINVAL;
-	if (!(uurb.type == USBDEVFS_URB_TYPE_CONTROL && (uurb.endpoint & ~USB_ENDPOINT_DIR_MASK) == 0)) {
-		if ((ifnum = findintfep(ps->dev, uurb.endpoint)) < 0)
-			return ifnum;
-		if ((ret = checkintf(ps, ifnum)))
-			return ret;
-	}
+
 	switch(uurb.type) {
 	case USBDEVFS_URB_TYPE_CONTROL:
-		if ((uurb.endpoint & ~USB_ENDPOINT_DIR_MASK) != 0) {
-			if (!(ep_desc = usb_epnum_to_ep_desc(ps->dev, uurb.endpoint)))
-				return -ENOENT;
-			if ((ep_desc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_CONTROL)
-				return -EINVAL;
-		}
 		/* min 8 byte setup packet, max arbitrary */
 		if (uurb.buffer_length < 8 || uurb.buffer_length > PAGE_SIZE)
 			return -EINVAL;
 		if (!(dr = kmalloc(sizeof(struct usb_ctrlrequest), GFP_KERNEL)))
 			return -ENOMEM;
 		if (copy_from_user(dr, uurb.buffer, 8)) {
-			kfree(dr);
-			return -EFAULT;
+			ret = -EFAULT;
+			goto out_free;
 		}
 		if (uurb.buffer_length < (le16_to_cpup(&dr->wLength) + 8)) {
-			kfree(dr);
-			return -EINVAL;
-		}
-		if ((ret = check_ctrlrecip(ps, dr->bRequestType, le16_to_cpup(&dr->wIndex)))) {
-			kfree(dr);
-			return ret;
+			ret = -EINVAL;
+			goto out_free;
 		}
 		uurb.endpoint = (uurb.endpoint & ~USB_ENDPOINT_DIR_MASK) | (dr->bRequestType & USB_ENDPOINT_DIR_MASK);
 		uurb.number_of_packets = 0;
 		uurb.buffer_length = le16_to_cpup(&dr->wLength);
 		uurb.buffer += 8;
 		if (!access_ok((uurb.endpoint & USB_DIR_IN) ?  VERIFY_WRITE : VERIFY_READ, uurb.buffer, uurb.buffer_length)) {
-			kfree(dr);
-			return -EFAULT;
+			ret = -EFAULT;
+			goto out_free;
 		}
 		break;
 
 	case USBDEVFS_URB_TYPE_BULK:
 		uurb.number_of_packets = 0;
-		if (uurb.buffer_length > 16384)
+		if (uurb.buffer_length > MAX_BUFFER_LENGTH)
 			return -EINVAL;
 		if (!access_ok((uurb.endpoint & USB_DIR_IN) ? VERIFY_WRITE : VERIFY_READ, uurb.buffer, uurb.buffer_length))
 			return -EFAULT;
@@ -855,39 +979,30 @@
 		/* arbitrary limit */
 		if (uurb.number_of_packets < 1 || uurb.number_of_packets > 128)
 			return -EINVAL;
-		if (!(ep_desc = usb_epnum_to_ep_desc(ps->dev, uurb.endpoint)))
-			return -ENOENT;
-		interval = 1 << min (15, ep_desc->bInterval - 1);
 		isofrmlen = sizeof(struct usbdevfs_iso_packet_desc) * uurb.number_of_packets;
 		if (!(isopkt = kmalloc(isofrmlen, GFP_KERNEL)))
 			return -ENOMEM;
 		if (copy_from_user(isopkt, &((struct usbdevfs_urb *)arg)->iso_frame_desc, isofrmlen)) {
-			kfree(isopkt);
-			return -EFAULT;
+			ret = -EFAULT;
+			goto out_free;
 		}
 		for (totlen = u = 0; u < uurb.number_of_packets; u++) {
 			if (isopkt[u].length > 1023) {
-				kfree(isopkt);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto out_free;
 			}
 			totlen += isopkt[u].length;
 		}
 		if (totlen > 32768) {
-			kfree(isopkt);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out_free;
 		}
 		uurb.buffer_length = totlen;
 		break;
 
 	case USBDEVFS_URB_TYPE_INTERRUPT:
 		uurb.number_of_packets = 0;
-		if (!(ep_desc = usb_epnum_to_ep_desc(ps->dev, uurb.endpoint)))
-			return -ENOENT;
-		if (ps->dev->speed == USB_SPEED_HIGH)
-			interval = 1 << min (15, ep_desc->bInterval - 1);
-		else
-			interval = ep_desc->bInterval;
-		if (uurb.buffer_length > 16384)
+		if (uurb.buffer_length > MAX_BUFFER_LENGTH)
 			return -EINVAL;
 		if (!access_ok((uurb.endpoint & USB_DIR_IN) ? VERIFY_WRITE : VERIFY_READ, uurb.buffer, uurb.buffer_length))
 			return -EFAULT;
@@ -896,21 +1011,88 @@
 	default:
 		return -EINVAL;
 	}
-	if (!(as = alloc_async(uurb.number_of_packets))) {
-		if (isopkt)
-			kfree(isopkt);
-		if (dr)
-			kfree(dr);
-		return -ENOMEM;
+
+	{
+	        unsigned int assize = sizeof(struct async) + uurb.number_of_packets * sizeof(struct usb_iso_packet_descriptor);
+
+        	if (!(as = kmalloc(assize, GFP_KERNEL))) {
+			ret = -ENOMEM;
+			goto out_free;
+		}
+        	memset(as, 0, assize);
+	}
+
+	if (!(as->urb = usb_alloc_urb(uurb.number_of_packets, GFP_KERNEL))) {
+		ret = -ENOMEM;
+		goto out_free;
 	}
+
 	if (!(as->urb->transfer_buffer = kmalloc(uurb.buffer_length, GFP_KERNEL))) {
-		if (isopkt)
-			kfree(isopkt);
-		if (dr)
-			kfree(dr);
-		free_async(as);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out_free;
 	}
+
+	if (!(uurb.endpoint & USB_DIR_IN)) {
+		if (copy_from_user(as->urb->transfer_buffer, uurb.buffer, uurb.buffer_length)) {
+			ret = -EFAULT;
+			goto out_free;
+		}
+	}
+
+	down(&dev->serialize);
+	if (!connected(dev)) {
+		ret = -ENODEV;
+		goto out_release;
+	}
+
+	if (!(uurb.type == USBDEVFS_URB_TYPE_CONTROL && (uurb.endpoint & ~USB_ENDPOINT_DIR_MASK) == 0)) {
+		if ((ifnum = findintfep(ps->dev, uurb.endpoint)) < 0) {
+			ret = ifnum;
+			goto out_release;
+		}
+		if ((ret = checkintf(ps, ifnum)))
+			goto out_release;
+	}
+
+	switch(uurb.type) {
+	case USBDEVFS_URB_TYPE_CONTROL:
+		if ((uurb.endpoint & ~USB_ENDPOINT_DIR_MASK) != 0) {
+			if (!(ep_desc = usb_epnum_to_ep_desc(ps->dev, uurb.endpoint))) {
+				ret = -ENOENT;
+				goto out_release;
+			}
+			if ((ep_desc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_CONTROL) {
+				ret = -EINVAL;
+				goto out_release;
+			}
+		}
+		if ((ret = check_ctrlrecip(ps, dr->bRequestType, le16_to_cpup(&dr->wIndex))))
+			goto out_release;
+		break;
+
+	case USBDEVFS_URB_TYPE_ISO:
+		if (!(ep_desc = usb_epnum_to_ep_desc(ps->dev, uurb.endpoint))) {
+			ret = -ENOENT;
+			goto out_release;
+		}
+		interval = 1 << min (15, ep_desc->bInterval - 1);
+		break;
+
+	case USBDEVFS_URB_TYPE_INTERRUPT:
+		if (!(ep_desc = usb_epnum_to_ep_desc(ps->dev, uurb.endpoint))) {
+			ret = -ENOENT;
+			goto out_release;
+		}
+		if (ps->dev->speed == USB_SPEED_HIGH)
+			interval = 1 << min (15, ep_desc->bInterval - 1);
+		else
+			interval = ep_desc->bInterval;
+		break;
+
+	default:
+		break;
+	}
+
         as->urb->dev = ps->dev;
         as->urb->pipe = (uurb.type << 30) | __create_pipe(ps->dev, uurb.endpoint & 0xf) | (uurb.endpoint & USB_DIR_IN);
         as->urb->transfer_flags = uurb.flags;
@@ -926,8 +1108,8 @@
 		as->urb->iso_frame_desc[u].length = isopkt[u].length;
 		totlen += isopkt[u].length;
 	}
-	if (isopkt)
-		kfree(isopkt);
+	kfree(isopkt);
+	isopkt = NULL;
 	as->ps = ps;
         as->userurb = arg;
 	if (uurb.endpoint & USB_DIR_IN)
@@ -937,31 +1119,47 @@
 	as->signr = uurb.signr;
 	as->ifnum = ifnum;
 	as->task = current;
-	if (!(uurb.endpoint & USB_DIR_IN)) {
-		if (copy_from_user(as->urb->transfer_buffer, uurb.buffer, as->urb->transfer_buffer_length)) {
-			free_async(as);
-			return -EFAULT;
-		}
-	}
         async_newpending(as);
         if ((ret = usb_submit_urb(as->urb, GFP_KERNEL))) {
 		dev_printk(KERN_DEBUG, &ps->dev->dev, "usbfs: usb_submit_urb returned %d\n", ret);
                 async_removepending(as);
-                free_async(as);
-                return ret;
+		goto out_release;
         }
+	up(&dev->serialize);
         return 0;
+
+out_release:
+	up(&dev->serialize);
+out_free:
+	if (as) {
+		if (as->urb) {
+			kfree(as->urb->transfer_buffer);
+			usb_free_urb(as->urb);
+		}
+		kfree(as);
+	}
+	kfree(isopkt);
+	kfree(dr);
+	return ret;
 }
 
 static int proc_unlinkurb(struct dev_state *ps, void __user *arg)
 {
 	struct async *as;
+	int ret = 0;
 
-	as = async_getpending(ps, arg);
-	if (!as)
-		return -EINVAL;
-	usb_unlink_urb(as->urb);
-	return 0;
+	down(&ps->dev->serialize);
+	if (!connected(ps->dev)) {
+		ret = -ENODEV;
+		goto out;
+	}
+	if ((as = async_getpending(ps, arg)))
+		usb_unlink_urb(as->urb);
+	else
+		ret = -EINVAL;
+out:
+	up(&ps->dev->serialize);
+	return ret;
 }
 
 static int processcompl(struct async *as)
@@ -1003,6 +1201,11 @@
 	struct usb_device *dev = ps->dev;
 	int ret;
 
+	down(&dev->serialize);
+	if (!connected(dev)) {
+		ret = -ENODEV;
+		goto fail;
+	}
 	add_wait_queue(&ps->wait, &wait);
 	while (connected(dev)) {
 		__set_current_state(TASK_INTERRUPTIBLE);
@@ -1016,19 +1219,20 @@
 	}
 	remove_wait_queue(&ps->wait, &wait);
 	set_current_state(TASK_RUNNING);
-	if (as) {
-		ret = processcompl(as);
-		addr = as->userurb;
-		free_async(as);
-		if (ret)
-			return ret;
-		if (put_user(addr, (void **)arg))
-			return -EFAULT;
-		return 0;
+	if (!as) {
+		ret = signal_pending(current) ? -EINTR : -EIO;
+		goto fail;
 	}
-	if (signal_pending(current))
-		return -EINTR;
-	return -EIO;
+	ret = processcompl(as);
+	addr = as->userurb;
+	free_async(as);
+	if (ret)
+		goto fail;
+	up(&dev->serialize);
+	return put_user(addr, (void **)arg) ? -EFAULT : 0;
+fail:
+	up(&dev->serialize);
+	return ret;
 }
 
 static int proc_reapurbnonblock(struct dev_state *ps, void __user *arg)
@@ -1037,16 +1241,25 @@
 	void __user *addr;
 	int ret;
 
-	if (!(as = async_getcompleted(ps)))
-		return -EAGAIN;
+	down(&ps->dev->serialize);
+	if (!connected(ps->dev)) {
+		ret = -ENODEV;
+		goto fail;
+	}
+	if (!(as = async_getcompleted(ps))) {
+		ret = -EAGAIN;
+		goto fail;
+	}
 	ret = processcompl(as);
 	addr = as->userurb;
 	free_async(as);
 	if (ret)
-		return ret;
-	if (put_user(addr, (void **)arg))
-		return -EFAULT;
-	return 0;
+		goto fail;
+	up(&ps->dev->serialize);
+	return put_user(addr, (void **)arg) ? -EFAULT : 0;
+fail:
+	up(&ps->dev->serialize);
+	return ret;
 }
 
 static int proc_disconnectsignal(struct dev_state *ps, void __user *arg)
@@ -1057,18 +1270,33 @@
 		return -EFAULT;
 	if (ds.signr != 0 && (ds.signr < SIGRTMIN || ds.signr > SIGRTMAX))
 		return -EINVAL;
+	down(&ps->dev->serialize);
+	if (!connected(ps->dev)) {
+		up(&ps->dev->serialize);
+		return -ENODEV;
+	}
 	ps->discsignr = ds.signr;
 	ps->disccontext = ds.context;
+	up(&ps->dev->serialize);
 	return 0;
 }
 
 static int proc_claiminterface(struct dev_state *ps, void __user *arg)
 {
 	unsigned int ifnum;
+	int ret;
 
 	if (get_user(ifnum, (unsigned int __user *)arg))
 		return -EFAULT;
-	return claimintf(ps, ifnum);
+	down(&ps->dev->serialize);
+	if (!connected(ps->dev)) {
+		ret = -ENODEV;
+		goto out;
+	}
+	ret = claimintf(ps, ifnum);
+out:
+	up(&ps->dev->serialize);
+	return ret;
 }
 
 static int proc_releaseinterface(struct dev_state *ps, void __user *arg)
@@ -1078,20 +1306,28 @@
 
 	if (get_user(ifnum, (unsigned int __user *)arg))
 		return -EFAULT;
-	if ((ret = releaseintf(ps, ifnum)) < 0)
-		return ret;
+	down(&ps->dev->serialize);
+	if (!connected(ps->dev)) {
+		ret = -ENODEV;
+		goto out;
+	}
+	if ((ret = releaseintf(ps, ifnum)))
+		goto out;
 	destroy_async_on_interface (ps, ifnum);
-	return 0;
+out:
+	up(&ps->dev->serialize);
+	return ret;
 }
 
 static int proc_ioctl (struct dev_state *ps, void __user *arg)
 {
 	struct usbdevfs_ioctl	ctrl;
+	void			*buf = NULL;
+	struct usb_device	*dev = ps->dev;
+	struct usb_driver       *driver = NULL;
+	struct usb_interface    *intf = NULL;
+	int			ret = 0;
 	int			size;
-	void			*buf = 0;
-	int			retval = 0;
-	struct usb_interface    *intf = 0;
-	struct usb_driver       *driver = 0;
 
 	/* get input parameters and alloc buffer */
 	if (copy_from_user(&ctrl, arg, sizeof (ctrl)))
@@ -1109,17 +1345,23 @@
 		}
 	}
 
-	if (!connected(ps->dev)) {
-		if (buf)
-			kfree(buf);
-		return -ENODEV;
+	down(&dev->serialize);
+	if (!connected(dev)) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (dev->state != USB_STATE_CONFIGURED) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (!(intf = usb_ifnum_to_if (dev, ctrl.ifno))) {
+               ret = -EINVAL;
+	       goto out;
 	}
 
-	if (ps->dev->state != USB_STATE_CONFIGURED)
-		retval = -ENODEV;
-	else if (!(intf = usb_ifnum_to_if (ps->dev, ctrl.ifno)))
-               retval = -EINVAL;
-	else switch (ctrl.ioctl_code) {
+	switch (ctrl.ioctl_code) {
 
 	/* disconnect kernel driver from interface */
 	case USBDEVFS_DISCONNECT:
@@ -1129,7 +1371,7 @@
 			dev_dbg (&intf->dev, "disconnect by usbfs\n");
 			usb_driver_release_interface(driver, intf);
 		} else
-			retval = -ENODATA;
+			ret = -ENODATA;
 		up_write(&usb_bus_type.subsys.rwsem);
 		break;
 
@@ -1144,24 +1386,25 @@
 		if (intf->dev.driver)
 			driver = to_usb_driver(intf->dev.driver);
 		if (driver == 0 || driver->ioctl == 0) {
-			retval = -ENOTTY;
+			ret = -ENOTTY;
 		} else {
-			retval = driver->ioctl (intf, ctrl.ioctl_code, buf);
-			if (retval == -ENOIOCTLCMD)
-				retval = -ENOTTY;
+			ret = driver->ioctl (intf, ctrl.ioctl_code, buf);
+			if (ret == -ENOIOCTLCMD)
+				ret = -ENOTTY;
 		}
 		up_read(&usb_bus_type.subsys.rwsem);
 	}
 
+	if (ret < 0)
+		goto out;
+
 	/* cleanup and return */
-	if (retval >= 0
-			&& (_IOC_DIR (ctrl.ioctl_code) & _IOC_READ) != 0
-			&& size > 0
-			&& copy_to_user (ctrl.data, buf, size) != 0)
-		retval = -EFAULT;
-	if (buf != 0)
-		kfree (buf);
-	return retval;
+	if ((_IOC_DIR (ctrl.ioctl_code) & _IOC_READ) != 0 && size > 0)
+	    ret = copy_to_user (ctrl.data, buf, size) ? -EFAULT : 0;
+out:
+	kfree (buf);
+	up(&dev->serialize);
+	return ret;
 }
 
 /*
@@ -1177,11 +1420,6 @@
 
 	if (!(file->f_mode & FMODE_WRITE))
 		return -EPERM;
-	down(&dev->serialize);
-	if (!connected(dev)) {
-		up(&dev->serialize);
-		return -ENODEV;
-	}
 
 	switch (cmd) {
 	case USBDEVFS_CONTROL:
@@ -1279,7 +1517,6 @@
 		ret = proc_ioctl(ps, (void __user *) arg);
 		break;
 	}
-	up(&dev->serialize);
 	if (ret >= 0)
 		inode->i_atime = CURRENT_TIME;
 	return ret;
