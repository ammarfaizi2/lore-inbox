Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271417AbRHPOyJ>; Thu, 16 Aug 2001 10:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271408AbRHPOyB>; Thu, 16 Aug 2001 10:54:01 -0400
Received: from office.mandrakesoft.com ([195.68.114.34]:32764 "EHLO
	office.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S271370AbRHPOxq>; Thu, 16 Aug 2001 10:53:46 -0400
To: linux-kernel@vger.kernel.org, Richard Gooch <rgooch@ras.ucalgary.ca>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] usbscanner and devfs
From: Yves Duret <yduret@mandrakesoft.com>
Date: 16 Aug 2001 16:53:37 +0200
Message-ID: <m2pu9wgioe.fsf@rouge.mandrakesoft.com>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.0.104
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


This patch adds devfs support for the usbscanner module.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
  filename=linux-2.4.8-usbscanner-devfs.patch
Content-Description: usbscanner-devfs

--- linux-2.4.8/drivers/usb/scanner.c.y	Thu Aug 16 13:27:11 2001
+++ linux-2.4.8/drivers/usb/scanner.c	Thu Aug 16 16:37:38 2001
@@ -228,6 +228,9 @@
  *    - Added Epson Perfection 1640SU and 1640SU Photo.  Thanks to
  *      Jean-Luc <f5ibh@db0bm.ampr.org>.
  *
+ * 0.4.6 08/16/2001 Yves Duret <yduret@mandrakesoft.com>
+ *    - added devfs support (from printer.c)
+ *
  *  TODO
  *
  *    - Performance
@@ -579,6 +582,100 @@
 	return ret ? ret : bytes_read;
 }
 
+#ifdef SCN_IOCTL
+static int
+ioctl_scanner(struct inode *inode, struct file *file,
+	      unsigned int cmd, unsigned long arg)
+{
+	struct usb_device *dev;
+
+	int result;
+
+	kdev_t scn_minor;
+
+	scn_minor = USB_SCN_MINOR(inode);
+
+	if (!p_scn_table[scn_minor]) {
+		err("ioctl_scanner(%d): invalid scn_minor", scn_minor);
+		return -ENODEV;
+	}
+
+	dev = p_scn_table[scn_minor]->scn_dev;
+
+	switch (cmd)
+	{
+	case IOCTL_SCANNER_VENDOR :
+		return (put_user(dev->descriptor.idVendor, (unsigned int *) arg));
+	case IOCTL_SCANNER_PRODUCT :
+		return (put_user(dev->descriptor.idProduct, (unsigned int *) arg));
+	case PV8630_IOCTL_INREQUEST :
+	{
+		struct {
+			__u8  data;
+			__u8  request;
+			__u16 value;
+			__u16 index;
+		} args;
+
+		if (copy_from_user(&args, (void *)arg, sizeof(args)))
+			return -EFAULT;
+
+		result = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
+					 args.request, USB_TYPE_VENDOR|
+					 USB_RECIP_DEVICE|USB_DIR_IN,
+					 args.value, args.index, &args.data,
+					 1, HZ*5);
+
+		dbg("ioctl_scanner(%d): inreq: args.data:%x args.value:%x args.index:%x args.request:%x\n", scn_minor, args.data, args.value, args.index, args.request);
+
+		if (copy_to_user((void *)arg, &args, sizeof(args)))
+			return -EFAULT;
+
+		dbg("ioctl_scanner(%d): inreq: result:%d\n", scn_minor, result);
+
+		return result;
+	}
+	case PV8630_IOCTL_OUTREQUEST :
+	{
+		struct {
+			__u8  request;
+			__u16 value;
+			__u16 index;
+		} args;
+
+		if (copy_from_user(&args, (void *)arg, sizeof(args)))
+			return -EFAULT;
+
+		dbg("ioctl_scanner(%d): outreq: args.value:%x args.index:%x args.request:%x\n", scn_minor, args.value, args.index, args.request);
+
+		result = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
+					 args.request, USB_TYPE_VENDOR|
+					 USB_RECIP_DEVICE|USB_DIR_OUT,
+					 args.value, args.index, NULL,
+					 0, HZ*5);
+
+		dbg("ioctl_scanner(%d): outreq: result:%d\n", scn_minor, result);
+
+		return result;
+	}
+	default:
+		return -ENOTTY;
+	}
+	return 0;
+}
+#endif /* SCN_IOCTL */
+
+static struct
+file_operations usb_scanner_fops = {
+	read:		read_scanner,
+	write:		write_scanner,
+#ifdef SCN_IOCTL
+	ioctl:		ioctl_scanner,
+#endif /* SCN_IOCTL */
+	open:		open_scanner,
+	release:	close_scanner,
+};
+
 static void *
 probe_scanner(struct usb_device *dev, unsigned int ifnum,
 	      const struct usb_device_id *id)
@@ -813,6 +910,14 @@
 
 	init_MUTEX(&(scn->gen_lock));
 
+	/* if we have devfs, create with perms=660 */
+	scn->devfs = devfs_register(usb_devfs_handle, "scanner",
+				      DEVFS_FL_DEFAULT, USB_MAJOR,
+				      SCN_BASE_MNR + scn_minor,
+				      S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP |
+				      S_IWGRP, &usb_scanner_fops, NULL);
+
+
 	return p_scn_table[scn_minor] = scn;
 }
 
@@ -828,6 +933,8 @@
         usb_driver_release_interface(&scanner_driver,
                 &scn->scn_dev->actconfig->interface[scn->ifnum]);
 
+	devfs_unregister (scn->devfs);
+
 	kfree(scn->ibuf);
 	kfree(scn->obuf);
 
@@ -836,99 +943,6 @@
 	kfree (scn);
 }
 
-#ifdef SCN_IOCTL
-static int
-ioctl_scanner(struct inode *inode, struct file *file,
-	      unsigned int cmd, unsigned long arg)
-{
-	struct usb_device *dev;
-
-	int result;
-
-	kdev_t scn_minor;
-
-	scn_minor = USB_SCN_MINOR(inode);
-
-	if (!p_scn_table[scn_minor]) {
-		err("ioctl_scanner(%d): invalid scn_minor", scn_minor);
-		return -ENODEV;
-	}
-
-	dev = p_scn_table[scn_minor]->scn_dev;
-
-	switch (cmd)
-	{
-	case IOCTL_SCANNER_VENDOR :
-		return (put_user(dev->descriptor.idVendor, (unsigned int *) arg));
-	case IOCTL_SCANNER_PRODUCT :
-		return (put_user(dev->descriptor.idProduct, (unsigned int *) arg));
-	case PV8630_IOCTL_INREQUEST :
-	{
-		struct {
-			__u8  data;
-			__u8  request;
-			__u16 value;
-			__u16 index;
-		} args;
-
-		if (copy_from_user(&args, (void *)arg, sizeof(args)))
-			return -EFAULT;
-
-		result = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
-					 args.request, USB_TYPE_VENDOR|
-					 USB_RECIP_DEVICE|USB_DIR_IN,
-					 args.value, args.index, &args.data,
-					 1, HZ*5);
-
-		dbg("ioctl_scanner(%d): inreq: args.data:%x args.value:%x args.index:%x args.request:%x\n", scn_minor, args.data, args.value, args.index, args.request);
-
-		if (copy_to_user((void *)arg, &args, sizeof(args)))
-			return -EFAULT;
-
-		dbg("ioctl_scanner(%d): inreq: result:%d\n", scn_minor, result);
-
-		return result;
-	}
-	case PV8630_IOCTL_OUTREQUEST :
-	{
-		struct {
-			__u8  request;
-			__u16 value;
-			__u16 index;
-		} args;
-
-		if (copy_from_user(&args, (void *)arg, sizeof(args)))
-			return -EFAULT;
-
-		dbg("ioctl_scanner(%d): outreq: args.value:%x args.index:%x args.request:%x\n", scn_minor, args.value, args.index, args.request);
-
-		result = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
-					 args.request, USB_TYPE_VENDOR|
-					 USB_RECIP_DEVICE|USB_DIR_OUT,
-					 args.value, args.index, NULL,
-					 0, HZ*5);
-
-		dbg("ioctl_scanner(%d): outreq: result:%d\n", scn_minor, result);
-
-		return result;
-	}
-	default:
-		return -ENOTTY;
-	}
-	return 0;
-}
-#endif /* SCN_IOCTL */
-
-static struct
-file_operations usb_scanner_fops = {
-	read:		read_scanner,
-	write:		write_scanner,
-#ifdef SCN_IOCTL
-	ioctl:		ioctl_scanner,
-#endif /* SCN_IOCTL */
-	open:		open_scanner,
-	release:	close_scanner,
-};
 
 static struct
 usb_driver scanner_driver = {
--- linux-2.4.8/drivers/usb/scanner.h.y	Thu Aug 16 13:27:18 2001
+++ linux-2.4.8/drivers/usb/scanner.h	Thu Aug 16 16:37:39 2001
@@ -5,6 +5,8 @@
  *
  * David E. Nelson (dnelson@jump.net)
  *
+ * 08/16/2001 added devfs support Yves Duret <yduret@mandrakesoft.com>
+ *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
  * published by the Free Software Foundation; either version 2 of the
@@ -31,6 +33,7 @@
 #include <linux/ioctl.h>
 #include <linux/sched.h>
 #include <linux/smp_lock.h>
+#include <linux/devfs_fs_kernel.h>
 
 // #define DEBUG
 
@@ -174,6 +177,7 @@
 
 struct scn_usb_data {
 	struct usb_device *scn_dev;
+	devfs_handle_t devfs;	/* devfs device */
 	struct urb scn_irq;
 	unsigned int ifnum;	/* Interface number of the USB device */
 	kdev_t scn_minor;	/* Scanner minor - used in disconnect() */
@@ -190,3 +194,5 @@
 static struct scn_usb_data *p_scn_table[SCN_MAX_MNR] = { NULL, /* ... */};
 
 static struct usb_driver scanner_driver;
+
+extern devfs_handle_t usb_devfs_handle; /* /dev/usb dir. */

--=-=-=


-- 
Yves Duret
yduret@mandrakesoft.com
P|-|34R |)4 R4|<317

--=-=-=--

