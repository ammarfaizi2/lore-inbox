Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263945AbTLJVsd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 16:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263983AbTLJVsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 16:48:33 -0500
Received: from mail.kroah.org ([65.200.24.183]:5772 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263945AbTLJVsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 16:48:25 -0500
Date: Wed, 10 Dec 2003 13:28:07 -0800
From: Greg KH <greg@kroah.com>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPP over ttyUSB (visor.o, Treo)
Message-ID: <20031210212807.GA8784@kroah.com>
References: <20031210165540.B26394@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031210165540.B26394@fi.muni.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 04:55:41PM +0100, Jan Kasprzak wrote:
> 	Hello @subscribers,
> 
> does anybody have working PPP over ttyUSB device in 2.6 kernels?
> When I connect the Handspring Treo to the 2.6.0-test11 machine,
> I am able to synchronize it, but not to run PPP to it (it can work
> as modem). I am able to dial the modem connection using AT commands,
> but I am not able to run PPP over it. Firstly the chat(1) program
> complains about not being able to get terminal attributes (TCGETATTR,
> from strace output), and then pppd(8) complains about not being able
> to set terminal attributes (TCSETATTR from the strace output).
> In 2.4 the same setup works OK.
> 
> 	Any hints? (Kernel config and other details are available
> on request). Thanks,

Can you try the patch below?  I think it will fix the problem.

thanks,

greg k-h



diff -Nru a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
--- a/drivers/usb/serial/usb-serial.c	Wed Dec 10 13:28:31 2003
+++ b/drivers/usb/serial/usb-serial.c	Wed Dec 10 13:28:31 2003
@@ -493,12 +493,15 @@
 	return retval;
 }
 
-static void __serial_close(struct usb_serial_port *port, struct file *filp)
+static void serial_close(struct tty_struct *tty, struct file * filp)
 {
-	if (!port->open_count) {
-		dbg ("%s - port not opened", __FUNCTION__);
+	struct usb_serial_port *port = (struct usb_serial_port *) tty->driver_data;
+	struct usb_serial *serial = get_usb_serial (port, __FUNCTION__);
+
+	if (!serial)
 		return;
-	}
+
+	dbg("%s - port %d", __FUNCTION__, port->number);
 
 	--port->open_count;
 	if (port->open_count <= 0) {
@@ -506,30 +509,18 @@
 		 * port is being closed by the last owner */
 		port->serial->type->close(port, filp);
 		port->open_count = 0;
+
+		if (port->tty) {
+			if (port->tty->driver_data)
+				port->tty->driver_data = NULL;
+			port->tty = NULL;
+		}
 	}
 
 	module_put(port->serial->type->owner);
 	kobject_put(&port->serial->kobj);
 }
 
-static void serial_close(struct tty_struct *tty, struct file * filp)
-{
-	struct usb_serial_port *port = (struct usb_serial_port *) tty->driver_data;
-	struct usb_serial *serial = get_usb_serial (port, __FUNCTION__);
-
-	if (!serial)
-		return;
-
-	dbg("%s - port %d", __FUNCTION__, port->number);
-
-	/* if disconnect beat us to the punch here, there's nothing to do */
-	if (tty && tty->driver_data) {
-		__serial_close(port, filp);
-		tty->driver_data = NULL;
-	}
-	port->tty = NULL;
-}
-
 static int serial_write (struct tty_struct * tty, int from_user, const unsigned char *buf, int count)
 {
 	struct usb_serial_port *port = (struct usb_serial_port *) tty->driver_data;
@@ -848,19 +839,6 @@
 	dbg ("%s - %s", __FUNCTION__, kobj->name);
 
 	serial = to_usb_serial(kobj);
-
-	/* fail all future close/read/write/ioctl/etc calls */
-	for (i = 0; i < serial->num_ports; ++i) {
-		port = serial->port[i];
-		if (port->tty != NULL) {
-			port->tty->driver_data = NULL;
-			while (port->open_count > 0) {
-				__serial_close(port, NULL);
-			}
-			port->tty = NULL;
-		}
-	}
-
 	serial_shutdown (serial);
 
 	/* return the minor range that this device had */
@@ -1242,7 +1220,7 @@
 	/* register all of the individual ports with the driver core */
 	for (i = 0; i < num_ports; ++i) {
 		port = serial->port[i];
-		port->dev.parent = &serial->dev->dev;
+		port->dev.parent = &interface->dev;
 		port->dev.driver = NULL;
 		port->dev.bus = &usb_serial_bus_type;
 		port->dev.release = &port_release;
