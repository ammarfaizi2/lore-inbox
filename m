Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268001AbUI1SOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268001AbUI1SOS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 14:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268008AbUI1SOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 14:14:18 -0400
Received: from granny.lievin.net ([81.56.184.74]:52877 "EHLO granny.chezmoi")
	by vger.kernel.org with ESMTP id S268001AbUI1SN4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 14:13:56 -0400
Date: Tue, 28 Sep 2004 20:13:47 +0200
From: Romain Lievin <lkml@lievin.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg Kroah <greg@kroah.com>
Subject: [PATCH] tiglusb.c: add direct USB support on some new TI handhelds {Scanned}
Message-ID: <20040928181347.GA18401@lievin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040722i
X-FamilleLievin-MailScanner-Information: Please contact postmaster@lievin.net for more information
X-FamilleLievin-MailScanner: Found to be clean
X-MailScanner-From: lkml@lievin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have extended my driver to add support of the embedded USB port provided by
some new Texas Instruments' handhelds. Things are the same except for the
maximum packet size.

Comments are welcome... Otherwise, please apply.

Thanks, Romain.
====================[cut here]=======================
diff -Naur linux-2.6.8.1/Documentation/usb/silverlink.txt linux/Documentation/usb/silverlink.txt
--- linux-2.6.8.1/Documentation/usb/silverlink.txt	2004-08-14 12:55:10.000000000 +0200
+++ linux/Documentation/usb/silverlink.txt	2004-09-26 15:16:15.000000000 +0200
@@ -1,5 +1,6 @@
 -------------------------------------------------------------------------
 Readme for Linux device driver for the Texas Instruments SilverLink cable
+and direct USB cable provided by some TI's handhelds.
 -------------------------------------------------------------------------
 
 Author: Romain Liévin & Julien Blache
@@ -9,7 +10,8 @@
 
 This is a driver for the TI-GRAPH LINK USB (aka SilverLink) cable, a cable 
 designed by TI for connecting their TI8x/9x calculators to a computer 
-(PC or Mac usually).
+(PC or Mac usually). It has been extended to support the USB port offered by
+some latest TI handhelds (TI84+ and TI89 Titanium).
 
 If you need more information, please visit the 'SilverLink drivers' homepage 
 at the above URL.
@@ -73,4 +75,4 @@
 CREDITS:
 
 The code is based on dabusb.c, printer.c and scanner.c !
-The driver has been developed independently of Texas Instruments.
+The driver has been developed independently of Texas Instruments Inc.
diff -Naur linux-2.6.8.1/drivers/usb/misc/tiglusb.c linux/drivers/usb/misc/tiglusb.c
--- linux-2.6.8.1/drivers/usb/misc/tiglusb.c	2004-08-14 12:54:47.000000000 +0200
+++ linux/drivers/usb/misc/tiglusb.c	2004-09-26 15:39:34.000000000 +0200
@@ -4,7 +4,7 @@
  * Target: Texas Instruments graphing calculators (http://lpg.ticalc.org).
  *
  * Copyright (C) 2001-2004:
- *   Romain Lievin <roms@lpg.ticalc.org>
+ *   Romain Lievin <roms@tilp.info>
  *   Julien BLACHE <jb@technologeek.org>
  * under the terms of the GNU General Public License.
  *
@@ -14,7 +14,7 @@
  * and the website at:  http://lpg.ticalc.org/prj_usb/
  * for more info.
  *
- * History :
+ * History:
  *   1.0x, Romain & Julien: initial submit.
  *   1.03, Greg Kroah: modifications.
  *   1.04, Julien: clean-up & fixes; Romain: 2.4 backport.
@@ -22,6 +22,7 @@
  *   1.06, Romain: synched with 2.5, version/firmware changed (confusing).
  *   1.07, Romain: fixed bad use of usb_clear_halt (invalid argument);
  *          timeout argument checked in ioctl + clean-up.
+ *   1.08, Romain: added support of USB port embedded on some TI's handhelds.
  */
 
 #include <linux/module.h>
@@ -41,7 +42,7 @@
 /*
  * Version Information
  */
-#define DRIVER_VERSION "1.07"
+#define DRIVER_VERSION "1.08"
 #define DRIVER_AUTHOR  "Romain Lievin <roms@tilp.info> & Julien Blache <jb@jblache.org>"
 #define DRIVER_DESC    "TI-GRAPH LINK USB (aka SilverLink) driver"
 #define DRIVER_LICENSE "GPL"
@@ -177,11 +178,11 @@
 	if (!s->dev)
 		return -EIO;
 
-	buffer = kmalloc(BULK_RCV_MAX, GFP_KERNEL);
+	buffer = kmalloc (s->max_ps, GFP_KERNEL);
 	if (!buffer)
 		return -ENOMEM;
 
-	bytes_to_read = (count >= BULK_RCV_MAX) ? BULK_RCV_MAX : count;
+	bytes_to_read = (count >= s->max_ps) ? s->max_ps : count;
 
 	pipe = usb_rcvbulkpipe (s->dev, 1);
 	result = usb_bulk_msg (s->dev, pipe, buffer, bytes_to_read,
@@ -234,11 +235,11 @@
 	if (!s->dev)
 		return -EIO;
 
-	buffer = kmalloc(BULK_SND_MAX, GFP_KERNEL);
+	buffer = kmalloc (s->max_ps, GFP_KERNEL);
 	if (!buffer)
 		return -ENOMEM;
 
-	bytes_to_write = (count >= BULK_SND_MAX) ? BULK_SND_MAX : count;
+	bytes_to_write = (count >= s->max_ps) ? s->max_ps : count;
 	if (copy_from_user (buffer, buf, bytes_to_write)) {
 		ret = -EFAULT;
 		goto out;
@@ -308,6 +309,15 @@
 		if (clear_pipes (s->dev))
 			ret = -EIO;
 		break;
+	case IOCTL_TIUSB_GET_MAXPS:
+                if (copy_to_user((int *) arg, &s->max_ps, sizeof(int)))
+                        return -EFAULT;
+                break;
+        case IOCTL_TIUSB_GET_DEVID:
+                if (copy_to_user((int *) arg, &s->dev->descriptor.idProduct,
+                                 sizeof(int)))
+                        return -EFAULT;
+                break;
 	default:
 		ret = -ENOTTY;
 		break;
@@ -340,6 +350,9 @@
 	int minor = -1;
 	int i, err = 0;
 	ptiglusb_t s;
+	struct usb_host_config *conf;
+       struct usb_host_interface *ifdata = NULL;
+       int max_ps;
 
 	dbg ("probing vendor id 0x%x, device id 0x%x",
 	     dev->descriptor.idVendor, dev->descriptor.idProduct);
@@ -354,19 +367,31 @@
 		goto out;
 	}
 
-	if ((dev->descriptor.idProduct != 0xe001)
-	    && (dev->descriptor.idVendor != 0x451)) {
+	if (dev->descriptor.idVendor != 0x451) {
 		err = -ENODEV;
 		goto out;
 	}
 
-	// NOTE:  it's already in this config, this shouldn't be needed.
-	// is this working around some hardware bug?
-	if (usb_reset_configuration (dev) < 0) {
-		err ("tiglusb_probe: reset_configuration failed");
-		err = -ENODEV;
-		goto out;
-	}
+	if ((dev->descriptor.idProduct != 0xe001) &&
+            (dev->descriptor.idProduct != 0xe004) &&
+            (dev->descriptor.idProduct != 0xe008)) {
+                err = -ENODEV;
+                goto out;
+        }
+
+	/*
+         * TI introduced some new handhelds with embedded USB port.
+         * Port advertises same config as SilverLink cable but with a 
+	 * different maximum packet size (64 rather than 32).
+         */
+
+        conf = dev->actconfig;
+        ifdata = conf->interface[0]->cur_altsetting;
+        max_ps = ifdata->endpoint[0].desc.wMaxPacketSize;
+
+        info("max packet size of %d/%d bytes\n",
+             ifdata->endpoint[0].desc.wMaxPacketSize,
+             ifdata->endpoint[1].desc.wMaxPacketSize);
 
 	/*
 	 * Find a tiglusb struct
@@ -389,6 +414,7 @@
 	down (&s->mutex);
 	s->remove_pending = 0;
 	s->dev = dev;
+	s->max_ps = max_ps;
 	up (&s->mutex);
 	dbg ("bound to interface");
 
diff -Naur linux-2.6.8.1/drivers/usb/misc/tiglusb.h linux/drivers/usb/misc/tiglusb.h
--- linux-2.6.8.1/drivers/usb/misc/tiglusb.h	2004-08-14 12:56:23.000000000 +0200
+++ linux/drivers/usb/misc/tiglusb.h	2004-09-26 15:27:17.000000000 +0200
@@ -18,12 +18,6 @@
 #define MAXTIGL		16
 
 /*
- * Max. packetsize for IN and OUT pipes
- */
-#define BULK_RCV_MAX	32
-#define BULK_SND_MAX	32
-
-/*
  * The driver context...
  */
 
@@ -42,6 +36,8 @@
 	driver_state_t	state;			/* started/stopped */
 	int		opened;			/* tru if open */
 	int	remove_pending;
+
+	int             max_ps;                 /* max packet size */
 } tiglusb_t, *ptiglusb_t;
 
 #endif
diff -Naur linux-2.6.8.1/include/linux/ticable.h linux/include/linux/ticable.h
--- linux-2.6.8.1/include/linux/ticable.h	2004-08-14 12:56:00.000000000 +0200
+++ linux/include/linux/ticable.h	2004-09-26 15:25:53.000000000 +0200
@@ -38,5 +38,7 @@
 #define IOCTL_TIUSB_TIMEOUT        _IOW('N', 0x20, int) /* set timeout */
 #define IOCTL_TIUSB_RESET_DEVICE   _IOW('N', 0x21, int) /* reset device */
 #define IOCTL_TIUSB_RESET_PIPES    _IOW('N', 0x22, int) /* reset both pipes*/
+#define IOCTL_TIUSB_GET_MAXPS      _IOR('N', 0x23, int) /* max packet size */
+#define IOCTL_TIUSB_GET_DEVID      _IOR('N', 0x24, int) /* get device type */
 
 #endif /* TICABLE_H */
-- 
Romain Liévin :		<roms@lievin.net>
Web site :		http://www.lievin.net
"Linux, y'a moins bien mais c'est plus cher !"






