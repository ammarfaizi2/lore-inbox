Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbULBMsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbULBMsl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 07:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbULBMsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 07:48:40 -0500
Received: from users.linvision.com ([62.58.92.114]:2274 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S261599AbULBMsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 07:48:33 -0500
Date: Thu, 2 Dec 2004 13:48:31 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: kuba@mareimbrium.org, greg@kroah.com, bryder@sgi.com,
       linux-kernel@vger.kernel.org
Cc: edwin@harddisk-recovery.nl
Subject: FTDI SIO patch to allow custom vendor/product IDs. 
Message-ID: <20041202124831.GA31745@bitwizard.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


To prevent XP from hijacking devices that require a different driver,
some people flash a different Vendor/Product ID into their FTDI based
device. 

Also some "new" devices may come out which are perfectly valid to be
driven by the ftdi_sio driver, but happen to have a vendor/product
id which is not (yet) included in the driver.  I've built a patch
that allows you to tell the driver "vendor=... product=...." to 
make it accept such devices.

Does this patch make sense?

I've built this patch for 2.4.28, but I'll port it for inclusion into
2.6 if people agree that this is useful.

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ftdi_sio.patch"

diff -ur hdr/linux-2.4.28-rc1/drivers/usb/serial/ftdi_sio.c linux-2.4.28-testftdi/drivers/usb/serial/ftdi_sio.c
--- hdr/linux-2.4.28-rc1/drivers/usb/serial/ftdi_sio.c	Wed Oct 27 15:45:22 2004
+++ linux-2.4.28-testftdi/drivers/usb/serial/ftdi_sio.c	Thu Dec  2 13:25:45 2004
@@ -449,6 +449,12 @@
 };
 
 
+static struct usb_device_id id_table_userdev [] = {
+	{ USB_DEVICE(-1, -1) },
+	{ }						/* Terminating entry */
+};
+
+
 static __devinitdata struct usb_device_id id_table_combined [] = {
 	{ USB_DEVICE(FTDI_VID, FTDI_IRTRANS_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_SIO_PID) },
@@ -548,6 +554,10 @@
 #define BUFSZ 512
 #define PKTSZ 64
 
+static int vendor =-1, product = -1, baud_base = 48000000/2; 
+    /* User specified VID and Product ID and baud base.  */ 
+
+
 struct ftdi_private {
 	ftdi_chip_type_t chip_type;
 				/* type of the device, either SIO or FT8U232AM */
@@ -584,6 +594,7 @@
 static int  ftdi_FT232BM_startup	(struct usb_serial *serial);
 static int  ftdi_USB_UIRT_startup	(struct usb_serial *serial);
 static int  ftdi_HE_TIRA1_startup	(struct usb_serial *serial);
+static int  ftdi_userdev_startup	(struct usb_serial *serial);
 static void ftdi_shutdown		(struct usb_serial *serial);
 static int  ftdi_open			(struct usb_serial_port *port, struct file *filp);
 static void ftdi_close			(struct usb_serial_port *port, struct file *filp);
@@ -727,6 +738,28 @@
 
 
 
+
+static struct usb_serial_device_type ftdi_userdev_device = {
+	.owner =		THIS_MODULE,
+	.name =			"FTDI SIO compatible",
+	.id_table =		id_table_userdev,
+	.num_interrupt_in =	0,
+	.num_bulk_in =		1,
+	.num_bulk_out =		1,
+	.num_ports =		1,
+	.open =			ftdi_open,
+	.close =		ftdi_close,
+	.write =		ftdi_write,
+	.write_room =		ftdi_write_room,
+	.read_bulk_callback =	ftdi_read_bulk_callback,
+	.write_bulk_callback =	ftdi_write_bulk_callback,
+	.ioctl =		ftdi_ioctl,
+	.set_termios =		ftdi_set_termios,
+	.break_ctl =		ftdi_break_ctl,
+	.startup =		ftdi_userdev_startup,
+	.shutdown =		ftdi_shutdown,
+};
+
 #define WDR_TIMEOUT (HZ * 5 ) /* default urb timeout */
 
 /* High and low are for DTR, RTS etc etc */
@@ -1216,6 +1249,30 @@
  */
 
 
+/* Startup for the 8U232AM chip */
+static int ftdi_userdev_startup (struct usb_serial *serial)
+{
+	struct ftdi_private *priv;
+
+	priv = serial->port->private = kmalloc(sizeof(struct ftdi_private), GFP_KERNEL);
+	if (!priv){
+		err("%s- kmalloc(%Zd) failed.", __FUNCTION__, sizeof(struct ftdi_private));
+		return -ENOMEM;
+	}
+
+	priv->chip_type = FT8U232AM; /* XXX: Hmm. Keep this.... -- REW */
+	priv->baud_base = baud_base; 
+	priv->custom_divisor = 0;
+	priv->write_offset = 0;
+        init_waitqueue_head(&priv->delta_msr_wait);
+	/* This will push the characters through immediately rather
+	   than queue a task to deliver them */
+	priv->flags = ASYNC_LOW_LATENCY;
+	
+	return (0);
+}
+
+
 static void ftdi_shutdown (struct usb_serial *serial)
 { /* ftdi_shutdown */
 	
@@ -2134,6 +2191,14 @@
 	usb_serial_register (&ftdi_USB_UIRT_device);
 	usb_serial_register (&ftdi_HE_TIRA1_device);
 
+	if (vendor != -1) {
+		/* User specified USB vendor and device id */
+		/* The macro initialized "matchvendor" as the matching flags */
+		id_table_userdev[0].idVendor = vendor; 
+		id_table_userdev[0].idProduct = product;
+		usb_serial_register (&ftdi_userdev_device);
+	}
+	
 
 	info(DRIVER_VERSION ":" DRIVER_DESC);
 	return 0;
@@ -2164,3 +2229,8 @@
 MODULE_PARM(debug, "i");
 MODULE_PARM_DESC(debug, "Debug enabled or not");
 
+MODULE_PARM(vendor, "i");
+MODULE_PARM_DESC(vendor, "User specified USB idVendor");
+
+MODULE_PARM(product, "i");
+MODULE_PARM_DESC(product, "User specified USB idProduct");
Only in linux-2.4.28-testftdi/drivers/usb/serial: ftdi_sio.c.orig
Only in linux-2.4.28-testftdi/drivers/usb/serial: ftdi_sio.c.rej
Only in linux-2.4.28-testftdi/drivers/usb/serial: ftdi_sio.c~

--k1lZvvs/B4yU6o8G--
