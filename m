Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264928AbTLFBlV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 20:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264927AbTLFBk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 20:40:27 -0500
Received: from mail.kroah.org ([65.200.24.183]:44769 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264920AbTLFBkC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 20:40:02 -0500
Date: Fri, 5 Dec 2003 17:38:44 -0800
From: Greg KH <greg@kroah.com>
To: Mike Gorse <mgorse@mgorse.dhs.org>
Cc: Maneesh Soni <maneesh@in.ibm.com>, linux-kernel@vger.kernel.org,
       mochel@digitalimplant.org
Subject: Re: Oops w/sysfs when closing a disconnected usb serial device
Message-ID: <20031206013844.GA16844@kroah.com>
References: <Pine.LNX.4.58.0311301900110.32493@mgorse.dhs.org> <20031201093804.GA6918@in.ibm.com> <Pine.LNX.4.58.0312011849050.9617@mgorse.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312011849050.9617@mgorse.dhs.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 01, 2003 at 06:55:38PM -0500, Mike Gorse wrote:
> Hi Maneesh,
> 
> On Mon, 1 Dec 2003, Maneesh Soni wrote:
> 
> > IMO d->d_inode is not expected to be NULL at this point. The only
> > place it can become NULL is in d_delete(d) call, but as the dentry ref.
> > count will be atleast 2, even this will not make d_inode NULL and it should
> > only unhash the dentry. Probably it will become more clear if you post
> > the oops message.
> > 
> It is trying to delete a directory which is gone already.  I'll post the 
> oops below.
> 
> > Mean while, I think kobject_del should not remove corresponding sysfs directory
> > until all the other references to kobject has gone. There can be references
> > taken in sysfs_open_file() from user space. The following patch moves the  
> > sysfs_remove_dir() call, to kobject_cleanup() and I think it may solve your 
> > problem also. It will be nice if you can test it.
> > 
> I wish your patch solved things in itself, but, without the added sysfs 
> check, I now get a new oops when disconnecting the device, even if no 
> applications are using it.

Try the patch below.  With your sysfs patch I don't get any oopses
anymore.  I still need to beat on this patch a lot more before I think
it solves all of the current issues.  Can you let me know if it works
for you or not?

thanks,

greg k-h

diff -Nru a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
--- a/drivers/usb/serial/usb-serial.c	Fri Dec  5 17:37:16 2003
+++ b/drivers/usb/serial/usb-serial.c	Fri Dec  5 17:37:16 2003
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
