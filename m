Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262301AbVAEJMC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbVAEJMC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 04:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbVAEJMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 04:12:02 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52395 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262317AbVAEJJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 04:09:12 -0500
Date: Wed, 5 Jan 2005 01:08:40 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: USB: Add user defined IDs to ftdi
Message-ID: <20050105010840.3b16fa11@lembas.zaitcev.lan>
In-Reply-To: <20041203133744.GA2240@dmt.cyclades>
References: <20041203133744.GA2240@dmt.cyclades>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should be self-evident. Patch by Rogier Wolff.

diff -urp -X dontdiff linux-2.4.29-pre3/drivers/usb/serial/ftdi_sio.c linux-2.4.29-pre3-sx3/drivers/usb/serial/ftdi_sio.c
--- linux-2.4.29-pre3/drivers/usb/serial/ftdi_sio.c	2004-08-10 13:43:36.000000000 -0700
+++ linux-2.4.29-pre3-sx3/drivers/usb/serial/ftdi_sio.c	2005-01-05 00:41:54.744764124 -0800
@@ -449,6 +449,12 @@ static struct usb_device_id id_table_HE_
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
@@ -548,6 +554,10 @@ MODULE_DEVICE_TABLE (usb, id_table_combi
 #define BUFSZ 512
 #define PKTSZ 64
 
+static int vendor =-1, product = -1, baud_base = 48000000/2; 
+    /* User specified VID and Product ID and baud base.  */ 
+
+
 struct ftdi_private {
 	ftdi_chip_type_t chip_type;
 				/* type of the device, either SIO or FT8U232AM */
@@ -584,6 +594,7 @@ static int  ftdi_8U232AM_startup	(struct
 static int  ftdi_FT232BM_startup	(struct usb_serial *serial);
 static int  ftdi_USB_UIRT_startup	(struct usb_serial *serial);
 static int  ftdi_HE_TIRA1_startup	(struct usb_serial *serial);
+static int  ftdi_userdev_startup	(struct usb_serial *serial);
 static void ftdi_shutdown		(struct usb_serial *serial);
 static int  ftdi_open			(struct usb_serial_port *port, struct file *filp);
 static void ftdi_close			(struct usb_serial_port *port, struct file *filp);
@@ -727,6 +738,28 @@ static struct usb_serial_device_type ftd
 
 
 
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
@@ -1216,6 +1249,30 @@ static int ftdi_HE_TIRA1_startup (struct
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
 	
@@ -2134,6 +2191,14 @@ static int __init ftdi_init (void)
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
@@ -2164,3 +2229,8 @@ MODULE_LICENSE("GPL");
 MODULE_PARM(debug, "i");
 MODULE_PARM_DESC(debug, "Debug enabled or not");
 
+MODULE_PARM(vendor, "i");
+MODULE_PARM_DESC(vendor, "User specified USB idVendor");
+
+MODULE_PARM(product, "i");
+MODULE_PARM_DESC(product, "User specified USB idProduct");
