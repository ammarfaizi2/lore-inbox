Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVBJXto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVBJXto (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 18:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbVBJXto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 18:49:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24462 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261915AbVBJXtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 18:49:40 -0500
Date: Thu, 10 Feb 2005 15:49:37 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: <marcelo.tosatti@cyclades.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: USB 2.4.30: ftdi_sio
Message-ID: <20050210154937.58ecd419@localhost.localdomain>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Granted, this is a cleanup, and we don't like cleanups in 2.4. But I really
dislike how the comment managed to detach from the function it described.
The idiotic error message is quite annoying, too.

diff -urpN -X dontdiff linux-2.4.30-pre1/drivers/usb/serial/ftdi_sio.c linux-2.4.30-pre1-usb/drivers/usb/serial/ftdi_sio.c
--- linux-2.4.30-pre1/drivers/usb/serial/ftdi_sio.c	2005-01-25 11:17:25.000000000 -0800
+++ linux-2.4.30-pre1-usb/drivers/usb/serial/ftdi_sio.c	2005-02-10 11:18:12.000000000 -0800
@@ -737,8 +737,6 @@ static struct usb_serial_device_type ftd
 };
 
 
-
-
 static struct usb_serial_device_type ftdi_userdev_device = {
 	.owner =		THIS_MODULE,
 	.name =			"FTDI SIO compatible",
@@ -1240,15 +1238,6 @@ static int ftdi_HE_TIRA1_startup (struct
 } /* ftdi_HE_TIRA1_startup */
 
 
-/* ftdi_shutdown is called from usbserial:usb_serial_disconnect 
- *   it is called when the usb device is disconnected
- *
- *   usbserial:usb_serial_disconnect
- *      calls __serial_close for each open of the port
- *      shutdown is called then (ie ftdi_shutdown)
- */
-
-
 /* Startup for the 8U232AM chip */
 static int ftdi_userdev_startup (struct usb_serial *serial)
 {
@@ -1273,6 +1262,14 @@ static int ftdi_userdev_startup (struct 
 }
 
 
+/* ftdi_shutdown is called from usbserial:usb_serial_disconnect 
+ *   it is called when the usb device is disconnected
+ *
+ *   usbserial:usb_serial_disconnect
+ *      calls __serial_close for each open of the port
+ *      shutdown is called then (ie ftdi_shutdown)
+ */
+
 static void ftdi_shutdown (struct usb_serial *serial)
 { /* ftdi_shutdown */
 	
@@ -1382,6 +1379,7 @@ static void ftdi_close (struct usb_seria
 	struct usb_serial *serial;
 	unsigned int c_cflag = port->tty->termios->c_cflag;
 	char buf[1];
+	int err;
 
 	dbg("%s", __FUNCTION__);
 
@@ -1412,8 +1410,9 @@ static void ftdi_close (struct usb_seria
 
 		/* shutdown our bulk read */
 		if (port->read_urb) {
-			if(usb_unlink_urb (port->read_urb)<0)
-				err("Error unlinking urb");
+			err = usb_unlink_urb (port->read_urb);
+			if (err < 0 && err != -ENODEV)
+				err("Error unlinking urb (%d)", err);
 		}
 		/* unlink the running write urbs */
 
