Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWGCWnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWGCWnd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 18:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWGCWnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 18:43:33 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:3982 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751155AbWGCWna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 18:43:30 -0400
Date: Mon, 03 Jul 2006 18:43:01 -0400
From: Andy Gay <andy@andynet.net>
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO
	transfers
In-reply-to: <20060703181621.GA8448@suse.de>
To: Greg KH <gregkh@suse.de>
Cc: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, Ken Brush <kbrush@gmail.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Message-id: <1151966582.3285.551.camel@tahini.andynet.net>
MIME-version: 1.0
X-Mailer: Evolution 2.4.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1151646482.3285.410.camel@tahini.andynet.net>
	<adad5cnderb.fsf@cisco.com> <1151872141.3285.486.camel@tahini.andynet.net>
	<20060703170040.GA15315@suse.de>
	<1151949329.3285.545.camel@tahini.andynet.net>	<20060703181621.GA8448@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-03 at 11:16 -0700, Greg KH wrote:
> On Mon, Jul 03, 2006 at 01:55:28PM -0400, Andy Gay wrote:
> > On Mon, 2006-07-03 at 10:00 -0700, Greg KH wrote:
> > > Yes, this driver is already split into 2 different ones (look in the
> > > recent -mm releases).  Sierra wants to have their devices be in their
> > > own driver, as the chip is a little different from the other ones.  This
> > > means that those devices are now controlled by a driver called "sierra"
> > > and the other devices still are working with the airprime driver.
> > > 
> > > This should hopefully fix the different endpoint issue, and allow new
> > > devices to be supported properly, as Sierra Wireless is now maintaining
> > > that driver.
> > Aha, good news. So this patch is already obsolete, for the Sierra stuff
> > anyway. And as I only have Sierra kit to work with, I reckon I should
> > drop out of this now.
> 
> No, not at all.  I'll gladly add your patch to the sierra driver, if you
> say it works for your devices.
> 
> > I did make some changes to the last patch to do the cleanup stuff in the
> > open function, do you want to see those?
> 
> Yes, please send the latest version, and I'll apply it.

OK, here it is!

-----

Adapted from an earlier patch by Greg KH <gregkh@suse.de>.
That patch added multiple read urbs and larger transfer buffers to allow
data transfers at full EvDO speed.

This version includes additional device IDs and fixes a memory leak in
the transfer buffer allocation.

Some (maybe all?) of the supported devices present multiple bulk endpoints,
the additional EPs can be used for control and status functions,
This version allocates 3 EPs by default, that can be changed using
the 'endpoints' module parameter.

Tested with Sierra Wireless EM5625 and MC5720 embedded modules.

Device ID (0x0c88, 0x17da) for the Kyocera Wireless KPC650/Passport
was added but is not yet tested.

---

Changes from previous patch:
 - fixed open function to clean up if anything goes wrong;
 - free private structure in close function;
 - add back alternate ID 0x0218 for the MC5720.

This is now reported as working for the Kyocera KPC650 (by Roland
Dreier <rdreier@cisco.com>), but as not working for the Sierra
Aircard 580 (by Ken Brush <kbrush@gmail.com>).

---

 drivers/usb/serial/airprime.c |  261 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 255 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/serial/airprime.c b/drivers/usb/serial/airprime.c
index 94b9ba0..1add380 100644
--- a/drivers/usb/serial/airprime.c
+++ b/drivers/usb/serial/airprime.c
@@ -1,36 +1,272 @@
 /*
  * AirPrime CDMA Wireless Serial USB driver
  *
- * Copyright (C) 2005 Greg Kroah-Hartman <gregkh@suse.de>
+ * Copyright (C) 2005-2006 Greg Kroah-Hartman <gregkh@suse.de>
  *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License version
  *	2 as published by the Free Software Foundation.
  */
-
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/tty.h>
+#include <linux/tty_flip.h>
 #include <linux/module.h>
 #include <linux/usb.h>
 #include "usb-serial.h"
 
 static struct usb_device_id id_table [] = {
 	{ USB_DEVICE(0x0c88, 0x17da) }, /* Kyocera Wireless KPC650/Passport */
-	{ USB_DEVICE(0xf3d, 0x0112) },  /* AirPrime CDMA Wireless PC Card */
+	{ USB_DEVICE(0x0f3d, 0x0112) },	/* AirPrime CDMA Wireless PC Card */
 	{ USB_DEVICE(0x1410, 0x1110) }, /* Novatel Wireless Merlin CDMA */
+	{ USB_DEVICE(0x1199, 0x0017) }, /* Sierra Wireless EM5625 */
+	{ USB_DEVICE(0x1199, 0x0018) }, /* Sierra Wireless MC5720 */
+	{ USB_DEVICE(0x1199, 0x0218) }, /* Sierra Wireless MC5720 (alt) */
 	{ USB_DEVICE(0x1199, 0x0112) }, /* Sierra Wireless Aircard 580 */
-	{ USB_DEVICE(0x1199, 0x0218) }, /* Sierra Wireless MC5720 */
 	{ },
 };
 MODULE_DEVICE_TABLE(usb, id_table);
+#define URB_TRANSFER_BUFFER_SIZE	4096
+#define NUM_READ_URBS			4
+#define NUM_WRITE_URBS			4
+#define NUM_BULK_EPS			3
+#define MAX_BULK_EPS			6
+
+/* if overridden by the user, then use their value for the size of the
+ * read and write urbs, and the number of endpoints */
+static int buffer_size = URB_TRANSFER_BUFFER_SIZE;
+static int endpoints = NUM_BULK_EPS;
+static int debug;
+struct airprime_private {
+	spinlock_t lock;
+	int outstanding_urbs;
+	int throttled;
+	struct urb *read_urbp[NUM_READ_URBS];
+};
+
+static void airprime_read_bulk_callback(struct urb *urb, struct pt_regs *regs)
+{
+	struct usb_serial_port *port = urb->context;
+	unsigned char *data = urb->transfer_buffer;
+	struct tty_struct *tty;
+	int result;
+
+	dbg("%s - port %d", __FUNCTION__, port->number);
+
+	if (urb->status) {
+		dbg("%s - nonzero read bulk status received: %d",
+		    __FUNCTION__, urb->status);
+		/* something happened, so free up the memory for this urb */
+		if (urb->transfer_buffer) {
+			kfree (urb->transfer_buffer);
+			urb->transfer_buffer = NULL;
+		}
+		return;
+	}
+	usb_serial_debug_data(debug, &port->dev, __FUNCTION__, urb->actual_length, data);
+
+	tty = port->tty;
+	if (tty && urb->actual_length) {
+		tty_insert_flip_string (tty, data, urb->actual_length);
+		tty_flip_buffer_push (tty);
+	}
+
+	result = usb_submit_urb (urb, GFP_ATOMIC);
+	if (result)
+		dev_err(&port->dev, "%s - failed resubmitting read urb, error %d\n",
+			__FUNCTION__, result);
+	return;
+}
+
+static void airprime_write_bulk_callback(struct urb *urb, struct pt_regs *regs)
+{
+	struct usb_serial_port *port = urb->context;
+	struct airprime_private *priv = usb_get_serial_port_data(port);
+	unsigned long flags;
+
+	dbg("%s - port %d", __FUNCTION__, port->number);
+
+	/* free up the transfer buffer, as usb_free_urb() does not do this */
+	kfree (urb->transfer_buffer);
+
+	if (urb->status)
+		dbg("%s - nonzero write bulk status received: %d",
+		    __FUNCTION__, urb->status);
+	spin_lock_irqsave(&priv->lock, flags);
+	--priv->outstanding_urbs;
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	usb_serial_port_softint(port);
+}
+
+static int airprime_open(struct usb_serial_port *port, struct file *filp)
+{
+	struct airprime_private *priv = usb_get_serial_port_data(port);
+	struct usb_serial *serial = port->serial;
+	struct urb *urb;
+	char *buffer = NULL;
+	int i;
+	int result = 0;
+
+	dbg("%s - port %d", __FUNCTION__, port->number);
+
+	/* initialize our private data structure if it isn't already created */
+	if (!priv) {
+		priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+		if (!priv) {
+			result = -ENOMEM;
+			goto out;
+		}
+		spin_lock_init(&priv->lock);
+		usb_set_serial_port_data(port, priv);
+	}
+
+	for (i = 0; i < NUM_READ_URBS; ++i) {
+		buffer = kmalloc(buffer_size, GFP_KERNEL);
+		if (!buffer) {
+			dev_err(&port->dev, "%s - out of memory.\n",
+				__FUNCTION__);
+			result = -ENOMEM;
+			goto errout;
+		}
+		urb = usb_alloc_urb(0, GFP_KERNEL);
+		if (!urb) {
+			dev_err(&port->dev, "%s - no more urbs?\n",
+				__FUNCTION__);
+			result = -ENOMEM;
+			goto errout;
+		}
+		usb_fill_bulk_urb(urb, serial->dev,
+				  usb_rcvbulkpipe(serial->dev,
+						  port->bulk_out_endpointAddress),
+				  buffer, buffer_size,
+				  airprime_read_bulk_callback, port);
+		result = usb_submit_urb(urb, GFP_KERNEL);
+		if (result) {
+			dev_err(&port->dev,
+				"%s - failed submitting read urb %d for port %d, error %d\n",
+				__FUNCTION__, i, port->number, result);
+			goto errout;
+		}
+		/* remember this urb so we can kill it when the port is closed */
+		priv->read_urbp[i] = urb;
+	}
+	goto out;
+
+ errout:
+	/* some error happened, cancel any submitted urbs and clean up anything that
+	   got allocated successfully */
+
+	for ( ; i >= 0; --i) {
+		urb = priv->read_urbp[i];
+		if (urb) {
+			/* This urb was submitted successfully. So we have to
+			   cancel it.
+			   Unlinking the urb will invoke read_bulk_callback()
+			   with an error status, so its transfer buffer will
+			   be freed there */
+			if (usb_unlink_urb (urb) != -EINPROGRESS) {
+				/* comments in drivers/usb/core/urb.c say this
+				   can only happen if the urb was never submitted,
+				   or has completed already.
+				   Either way we may have to free the transfer
+				   buffer here. */
+				if (urb->transfer_buffer) {
+					kfree (urb->transfer_buffer);
+					urb->transfer_buffer = NULL;
+				}
+			}
+			usb_free_urb (urb);
+		}
+	}
+
+ out:
+	return result;
+}
+
+static void airprime_close(struct usb_serial_port *port, struct file * filp)
+{
+	struct airprime_private *priv = usb_get_serial_port_data(port);
+	int i;
+
+	dbg("%s - port %d", __FUNCTION__, port->number);
+
+	/* killing the urb will invoke read_bulk_callback() with an error status,
+	   so the transfer buffer will be freed there */
+	for (i = 0; i < NUM_READ_URBS; ++i) {
+		usb_kill_urb (priv->read_urbp[i]);
+		usb_free_urb (priv->read_urbp[i]);
+	}
+
+	/* free up private structure */
+	kfree (priv);
+	usb_set_serial_port_data(port, NULL);
+}
+
+static int airprime_write(struct usb_serial_port *port,
+			  const unsigned char *buf, int count)
+{
+	struct airprime_private *priv = usb_get_serial_port_data(port);
+	struct usb_serial *serial = port->serial;
+	struct urb *urb;
+	unsigned char *buffer;
+	unsigned long flags;
+	int status;
+	dbg("%s - port %d", __FUNCTION__, port->number);
+
+	spin_lock_irqsave(&priv->lock, flags);
+	if (priv->outstanding_urbs > NUM_WRITE_URBS) {
+		spin_unlock_irqrestore(&priv->lock, flags);
+		dbg("%s - write limit hit\n", __FUNCTION__);
+		return 0;
+	}
+	spin_unlock_irqrestore(&priv->lock, flags);
+	buffer = kmalloc(count, GFP_ATOMIC);
+	if (!buffer) {
+		dev_err(&port->dev, "out of memory\n");
+		return -ENOMEM;
+	}
+	urb = usb_alloc_urb(0, GFP_ATOMIC);
+	if (!urb) {
+		dev_err(&port->dev, "no more free urbs\n");
+		kfree (buffer);
+		return -ENOMEM;
+	}
+	memcpy (buffer, buf, count);
+
+	usb_serial_debug_data(debug, &port->dev, __FUNCTION__, count, buffer);
+
+	usb_fill_bulk_urb(urb, serial->dev,
+			  usb_sndbulkpipe(serial->dev,
+					  port->bulk_out_endpointAddress),
+			  buffer, count,
+			  airprime_write_bulk_callback, port);
+
+	/* send it down the pipe */
+	status = usb_submit_urb(urb, GFP_ATOMIC);
+	if (status) {
+		dev_err(&port->dev,
+			"%s - usb_submit_urb(write bulk) failed with status = %d\n",
+			__FUNCTION__, status);
+		count = status;
+		kfree (buffer);
+	} else {
+		spin_lock_irqsave(&priv->lock, flags);
+		++priv->outstanding_urbs;
+		spin_unlock_irqrestore(&priv->lock, flags);
+	}
+	/* we are done with this urb, so let the host driver
+	 * really free it when it is finished with it */
+	usb_free_urb (urb);
+	return count;
+}
 
 static struct usb_driver airprime_driver = {
 	.name =		"airprime",
 	.probe =	usb_serial_probe,
 	.disconnect =	usb_serial_disconnect,
 	.id_table =	id_table,
-	.no_dynamic_id = 	1,
+	.no_dynamic_id =	1,
 };
 
 static struct usb_serial_driver airprime_device = {
@@ -42,13 +278,17 @@ static struct usb_serial_driver airprime
 	.num_interrupt_in =	NUM_DONT_CARE,
 	.num_bulk_in =		NUM_DONT_CARE,
 	.num_bulk_out =		NUM_DONT_CARE,
-	.num_ports =		1,
+	.open =			airprime_open,
+	.close =		airprime_close,
+	.write =		airprime_write,
 };
 
 static int __init airprime_init(void)
 {
 	int retval;
 
+	airprime_device.num_ports =
+		(endpoints > 0 && endpoints <= MAX_BULK_EPS) ? endpoints : NUM_BULK_EPS;
 	retval = usb_serial_register(&airprime_device);
 	if (retval)
 		return retval;
@@ -60,6 +300,8 @@ static int __init airprime_init(void)
 
 static void __exit airprime_exit(void)
 {
+	dbg("%s", __FUNCTION__);
+
 	usb_deregister(&airprime_driver);
 	usb_serial_deregister(&airprime_device);
 }
@@ -67,3 +309,10 @@ static void __exit airprime_exit(void)
 module_init(airprime_init);
 module_exit(airprime_exit);
 MODULE_LICENSE("GPL");
+
+module_param(debug, bool, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(debug, "Debug enabled");
+module_param(buffer_size, int, 0);
+MODULE_PARM_DESC(buffer_size, "Size of the transfer buffers in bytes (default 4096)");
+module_param(endpoints, int, 0);
+MODULE_PARM_DESC(endpoints, "Number of bulk EPs to configure (default 3)");




