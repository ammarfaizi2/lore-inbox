Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265940AbUFEAUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265940AbUFEAUX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 20:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264471AbUFEAUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 20:20:23 -0400
Received: from mail.kroah.org ([65.200.24.183]:25734 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266119AbUFEATx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 20:19:53 -0400
Date: Fri, 4 Jun 2004 17:18:32 -0700
From: Greg KH <greg@kroah.com>
To: Ian Abbott <abbotti@mev.co.uk>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] Memory leak in visor.c and ftdi_sio.c
Message-ID: <20040605001832.GA28502@kroah.com>
References: <40C08E6D.8080606@infosciences.com> <c9q8a6$hga$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9q8a6$hga$1@sea.gmane.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 05:34:41PM +0100, Ian Abbott wrote:
> On 04/06/2004 15:59, nardelli wrote:
> >Note that I have not verified any of the below on
> >hardware associated with drivers/usb/serial/ftdi_sio.c,
> >only with drivers/usb/serial/visor.c.  If anyone has
> >hardware for this device, I would appreciate your comments.
> >
> >A memory leak occurs in both drivers/usb/serial/ftdi_sio.c
> >and drivers/usb/serial/visor.c when the usb device is
> >unplugged while data is being written to the device.  This
> >patch should clear that up.
> 
> The change to ftdi_sio.c looks correct to me.
> 
> I made the original change to ftdi_sio.c to allocate the write urbs 
> and their transfer buffers dynamically (instead of using a 
> preallocated pool) and I copied that technique from visor.c!
> 
> A related problem with the current implementation is that is easy to 
> run out of memory by running something similar to this:
> 
>  # cat /dev/zero > /dev/ttyUSB0
> 
> That affects both the ftdi_sio and visor drivers.

Care to try out the following (build test only) patch to the visor
driver to see if it prevents this from happening?  I don't have a
working visor right now to test it out myself :(

Oops, ignore the fact that we never free the structure on disconnect, I
see that now...

thanks,

greg k-h


===== drivers/usb/serial/visor.c 1.114 vs edited =====
--- 1.114/drivers/usb/serial/visor.c	Fri Jun  4 07:13:10 2004
+++ edited/drivers/usb/serial/visor.c	Fri Jun  4 17:12:53 2004
@@ -387,10 +387,17 @@
 	.read_bulk_callback =	visor_read_bulk_callback,
 };
 
+struct visor_private {
+	spinlock_t lock;
+	int bytes_in;
+	int bytes_out;
+	int outstanding_urbs;
+};
 
-static int bytes_in;
-static int bytes_out;
+/* number of outstanding urbs to prevent userspace DoS from happening */
+#define URB_UPPER_LIMIT	42
 
+static int stats;
 
 /******************************************************************************
  * Handspring Visor specific driver functions
@@ -398,6 +405,8 @@
 static int visor_open (struct usb_serial_port *port, struct file *filp)
 {
 	struct usb_serial *serial = port->serial;
+	struct visor_private *priv = usb_get_serial_port_data(port);
+	unsigned long flags;
 	int result = 0;
 
 	dbg("%s - port %d", __FUNCTION__, port->number);
@@ -408,8 +417,11 @@
 		return -ENODEV;
 	}
 
-	bytes_in = 0;
-	bytes_out = 0;
+	spin_lock_irqsave(&priv->lock, flags);
+	priv->bytes_in = 0;
+	priv->bytes_out = 0;
+	priv->outstanding_urbs = 0;
+	spin_unlock_irqrestore(&priv->lock, flags);
 
 	/*
 	 * Force low_latency on so that our tty_push actually forces the data
@@ -447,6 +459,7 @@
 
 static void visor_close (struct usb_serial_port *port, struct file * filp)
 {
+	struct visor_private *priv = usb_get_serial_port_data(port);
 	unsigned char *transfer_buffer;
 
 	dbg("%s - port %d", __FUNCTION__, port->number);
@@ -467,20 +480,32 @@
 		kfree (transfer_buffer);
 	}
 
-	/* Uncomment the following line if you want to see some statistics in your syslog */
-	/* dev_info (&port->dev, "Bytes In = %d  Bytes Out = %d\n", bytes_in, bytes_out); */
+	if (stats)
+		dev_info(&port->dev, "Bytes In = %d  Bytes Out = %d\n",
+			 priv->bytes_in, priv->bytes_out);
 }
 
 
 static int visor_write (struct usb_serial_port *port, int from_user, const unsigned char *buf, int count)
 {
+	struct visor_private *priv = usb_get_serial_port_data(port);
 	struct usb_serial *serial = port->serial;
 	struct urb *urb;
 	unsigned char *buffer;
+	unsigned long flags;
 	int status;
 
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
+	spin_lock_irqsave(&priv->lock, flags);
+	if (priv->outstanding_urbs > URB_UPPER_LIMIT) {
+		spin_unlock_irqrestore(&priv->lock, flags);
+		dev_dbg(&port->dev, "write limit hit\n");
+		return 0;
+	}
+	++priv->outstanding_urbs;
+	spin_unlock_irqrestore(&priv->lock, flags);
+
 	buffer = kmalloc (count, GFP_ATOMIC);
 	if (!buffer) {
 		dev_err(&port->dev, "out of memory\n");
@@ -520,7 +545,10 @@
 		count = status;
 		kfree (buffer);
 	} else {
-		bytes_out += count;
+		spin_lock_irqsave(&priv->lock, flags);
+		++priv->outstanding_urbs;
+		priv->bytes_out += count;
+		spin_unlock_irqrestore(&priv->lock, flags);
 	}
 
 	/* we are done with this urb, so let the host driver
@@ -561,6 +589,8 @@
 static void visor_write_bulk_callback (struct urb *urb, struct pt_regs *regs)
 {
 	struct usb_serial_port *port = (struct usb_serial_port *)urb->context;
+	struct visor_private *priv = usb_get_serial_port_data(port);
+	unsigned long flags;
 
 	/* free up the transfer buffer, as usb_free_urb() does not do this */
 	kfree (urb->transfer_buffer);
@@ -571,6 +601,10 @@
 		dbg("%s - nonzero write bulk status received: %d",
 		    __FUNCTION__, urb->status);
 
+	spin_lock_irqsave(&priv->lock, flags);
+	--priv->outstanding_urbs;
+	spin_unlock_irqrestore(&priv->lock, flags);
+
 	schedule_work(&port->work);
 }
 
@@ -578,8 +612,10 @@
 static void visor_read_bulk_callback (struct urb *urb, struct pt_regs *regs)
 {
 	struct usb_serial_port *port = (struct usb_serial_port *)urb->context;
-	struct tty_struct *tty;
+	struct visor_private *priv = usb_get_serial_port_data(port);
 	unsigned char *data = urb->transfer_buffer;
+	struct tty_struct *tty;
+	unsigned long flags;
 	int i;
 	int result;
 
@@ -604,7 +640,9 @@
 		}
 		tty_flip_buffer_push(tty);
 	}
-	bytes_in += urb->actual_length;
+	spin_lock_irqsave(&priv->lock, flags);
+	priv->bytes_in += urb->actual_length;
+	spin_unlock_irqrestore(&priv->lock, flags);
 
 	/* Continue trying to always read  */
 	usb_fill_bulk_urb (port->read_urb, port->serial->dev,
@@ -837,6 +875,22 @@
 	return num_ports;
 }
 
+static int generic_startup(struct usb_serial *serial)
+{
+	struct visor_private *priv;
+	int i;
+
+	for (i = 0; i < serial->num_ports; ++i) {
+		priv = kmalloc (sizeof(*priv), GFP_KERNEL);
+		if (!priv)
+			return -ENOMEM;
+		memset (priv, 0x00, sizeof(*priv));
+		spin_lock_init(&priv->lock);
+		usb_set_serial_port_data(serial->port[i], priv);
+	}
+	return 0;
+}
+
 static int clie_3_5_startup (struct usb_serial *serial)
 {
 	struct device *dev = &serial->dev->dev;
@@ -876,7 +930,7 @@
 		return -EIO;
 	}
 
-	return 0;
+	return generic_startup(serial);
 }
  
 static int treo_attach (struct usb_serial *serial)
@@ -915,7 +969,7 @@
 	COPY_PORT(serial->port[1], swap_port);
 	kfree(swap_port);
 
-	return 0;
+	return generic_startup(serial);
 }
 
 static int clie_5_attach (struct usb_serial *serial)
@@ -936,7 +990,7 @@
 	/* port 0 now uses the modified endpoint Address */
 	serial->port[0]->bulk_out_endpointAddress = serial->port[1]->bulk_out_endpointAddress;
 
-	return 0;
+	return generic_startup(serial);
 }
 
 static void visor_shutdown (struct usb_serial *serial)
@@ -1092,8 +1146,11 @@
 
 module_param(debug, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(debug, "Debug enabled or not");
+module_param(stats, bool, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(stats, "Enables statistics or not");
 
 module_param(vendor, ushort, 0);
 MODULE_PARM_DESC(vendor, "User specified vendor ID");
 module_param(product, ushort, 0);
 MODULE_PARM_DESC(product, "User specified product ID");
+
