Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbVAHGLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbVAHGLX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 01:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVAHGJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 01:09:23 -0500
Received: from mail.kroah.org ([69.55.234.183]:20357 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261809AbVAHFr6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:47:58 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <1105163268703@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:48 -0800
Message-Id: <11051632684120@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.38, 2004/12/17 16:11:38-08:00, zaitcev@redhat.com

[PATCH] Clean mct_u232 in 2.6.10-rc2

I would like to clean up mct_u232 a little bit, although primarily to make
my fixes to 2.4 branch look better. The attached patch does this:
 - zeroes whole private structure
 - zaps dangling pointer (or why do we check it then)
 - removes unused code for FIX_WRITE_RETURN_CODE_PROBLEM
 - changes version
 - makes the diagnostic name not quite as pompous
 - makes debugging printouts a little more informative

From: Pete Zaitcev <zaitcev@redhat.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/serial/mct_u232.c |  148 +++---------------------------------------
 1 files changed, 12 insertions(+), 136 deletions(-)


diff -Nru a/drivers/usb/serial/mct_u232.c b/drivers/usb/serial/mct_u232.c
--- a/drivers/usb/serial/mct_u232.c	2005-01-07 15:44:27 -08:00
+++ b/drivers/usb/serial/mct_u232.c	2005-01-07 15:44:27 -08:00
@@ -82,21 +82,10 @@
 /*
  * Version Information
  */
-#define DRIVER_VERSION "v1.2"
+#define DRIVER_VERSION "z2.0"		/* Linux in-kernel version */
 #define DRIVER_AUTHOR "Wolfgang Grandegger <wolfgang@ces.ch>"
 #define DRIVER_DESC "Magic Control Technology USB-RS232 converter driver"
 
-/*
- * Some not properly written applications do not handle the return code of
- * write() correctly. This can result in character losses. A work-a-round
- * can be compiled in with the following definition. This work-a-round
- * should _NOT_ be part of an 'official' kernel release, of course!
- */
-#undef FIX_WRITE_RETURN_CODE_PROBLEM
-#ifdef FIX_WRITE_RETURN_CODE_PROBLEM
-static int write_blocking; /* disabled by default */
-#endif
-
 static int debug;
 
 /*
@@ -108,12 +97,6 @@
 					  struct file *filp);
 static void mct_u232_close	         (struct usb_serial_port *port,
 					  struct file *filp);
-#ifdef FIX_WRITE_RETURN_CODE_PROBLEM
-static int  mct_u232_write	         (struct usb_serial_port *port,
-					  const unsigned char *buf,
-					  int count);
-static void mct_u232_write_bulk_callback (struct urb *urb, struct pt_regs *regs);
-#endif
 static void mct_u232_read_int_callback   (struct urb *urb, struct pt_regs *regs);
 static void mct_u232_set_termios         (struct usb_serial_port *port,
 					  struct termios * old);
@@ -151,7 +134,7 @@
 
 static struct usb_serial_device_type mct_u232_device = {
 	.owner =	     THIS_MODULE,
-	.name =		     "Magic Control Technology USB-RS232",
+	.name =		     "MCT U232",
 	.short_name =	     "mct_u232",
 	.id_table =	     id_table_combined,
 	.num_interrupt_in =  2,
@@ -160,10 +143,6 @@
 	.num_ports =	     1,
 	.open =		     mct_u232_open,
 	.close =	     mct_u232_close,
-#ifdef FIX_WRITE_RETURN_CODE_PROBLEM
-	.write =	     mct_u232_write,
-	.write_bulk_callback = mct_u232_write_bulk_callback,
-#endif
 	.read_int_callback = mct_u232_read_int_callback,
 	.ioctl =	     mct_u232_ioctl,
 	.set_termios =	     mct_u232_set_termios,
@@ -366,15 +345,11 @@
 	struct mct_u232_private *priv;
 	struct usb_serial_port *port, *rport;
 
-	/* allocate the private data structure */
 	priv = kmalloc(sizeof(struct mct_u232_private), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
-	/* set initial values for control structures */
+	memset(priv, 0, sizeof(struct mct_u232_private));
 	spin_lock_init(&priv->lock);
-	priv->control_state = 0;
-	priv->last_lsr = 0;
-	priv->last_msr = 0;
 	usb_set_serial_port_data(serial->port[0], priv);
 
 	init_waitqueue_head(&serial->port[0]->write_wait);
@@ -404,8 +379,10 @@
 	for (i=0; i < serial->num_ports; ++i) {
 		/* My special items, the standard routines free my urbs */
 		priv = usb_get_serial_port_data(serial->port[i]);
-		if (priv)
+		if (priv) {
+			usb_set_serial_port_data(serial->port[i], NULL);
 			kfree(priv);
+		}
 	}
 } /* mct_u232_shutdown */
 
@@ -459,14 +436,16 @@
 	port->read_urb->dev = port->serial->dev;
 	retval = usb_submit_urb(port->read_urb, GFP_KERNEL);
 	if (retval) {
-		err("usb_submit_urb(read bulk) failed");
+		err("usb_submit_urb(read bulk) failed pipe 0x%x err %d",
+		    port->read_urb->pipe, retval);
 		goto exit;
 	}
 
 	port->interrupt_in_urb->dev = port->serial->dev;
 	retval = usb_submit_urb(port->interrupt_in_urb, GFP_KERNEL);
 	if (retval)
-		err(" usb_submit_urb(read int) failed");
+		err(" usb_submit_urb(read int) failed pipe 0x%x err %d",
+		    port->interrupt_in_urb->pipe, retval);
 
 exit:
 	return 0;
@@ -486,101 +465,6 @@
 } /* mct_u232_close */
 
 
-#ifdef FIX_WRITE_RETURN_CODE_PROBLEM
-/* The generic routines work fine otherwise */
-
-static int mct_u232_write (struct usb_serial_port *port,
-			   const unsigned char *buf, int count)
-{
-	struct usb_serial *serial = port->serial;
-	int result, bytes_sent, size;
-
-	dbg("%s - port %d", __FUNCTION__, port->number);
-
-	if (count == 0) {
-		dbg("%s - write request of 0 bytes", __FUNCTION__);
-		return (0);
-	}
-
-	/* only do something if we have a bulk out endpoint */
-	if (!serial->num_bulk_out)
-		return(0);
-	
-	/* another write is still pending? */
-	if (port->write_urb->status == -EINPROGRESS) {
-		dbg("%s - already writing", __FUNCTION__);
-		return (0);
-	}
-		
-	bytes_sent = 0;
-	while (count > 0) {
-		size = (count > port->bulk_out_size) ? port->bulk_out_size : count;
-		
-		usb_serial_debug_data(debug, &port->dev, __FUNCTION__, size, buf);
-		
-		memcpy (port->write_urb->transfer_buffer, buf, size);
-		
-		/* set up our urb */
-		usb_fill_bulk_urb(port->write_urb, serial->dev,
-			      usb_sndbulkpipe(serial->dev,
-					      port->bulk_out_endpointAddress),
-			      port->write_urb->transfer_buffer, size,
-			      ((serial->type->write_bulk_callback) ?
-			       serial->type->write_bulk_callback :
-			       mct_u232_write_bulk_callback),
-			      port);
-		
-		/* send the data out the bulk port */
-		result = usb_submit_urb(port->write_urb, GFP_ATOMIC);
-		if (result) {
-			err("%s - failed submitting write urb, error %d", __FUNCTION__, result);
-			return result;
-		}
-
-		bytes_sent += size;
-		if (write_blocking)
-			interruptible_sleep_on(&port->write_wait);
-		else
-			break;
-
-		buf += size;
-		count -= size;
-	}
-	
-	return bytes_sent;
-} /* mct_u232_write */
-
-static void mct_u232_write_bulk_callback (struct urb *urb, struct pt_regs *regs)
-{
-	struct usb_serial_port *port = (struct usb_serial_port *)urb->context;
-	struct usb_serial *serial = port->serial;
-       	struct tty_struct *tty = port->tty;
-
-	dbg("%s - port %d", __FUNCTION__, port->number);
-	
-	if (!serial) {
-		dbg("%s - bad serial pointer, exiting", __FUNCTION__);
-		return;
-	}
-
-	if (urb->status) {
-		dbg("%s - nonzero write bulk status received: %d", __FUNCTION__,
-		    urb->status);
-		return;
-	}
-
-	if (write_blocking) {
-		wake_up_interruptible(&port->write_wait);
-		tty_wakeup(tty);
-	} else {
-		/* from generic_write_bulk_callback */
-		schedule_work(&port->work);
-	}
-
-	return;
-} /* mct_u232_write_bulk_callback */
-#endif
-
 static void mct_u232_read_int_callback (struct urb *urb, struct pt_regs *regs)
 {
 	struct usb_serial_port *port = (struct usb_serial_port *)urb->context;
@@ -591,8 +475,6 @@
 	int status;
 	unsigned long flags;
 
-        dbg("%s - port %d", __FUNCTION__, port->number);
-
 	switch (urb->status) {
 	case 0:
 		/* success */
@@ -612,7 +494,8 @@
 		dbg("%s - bad serial pointer, exiting", __FUNCTION__);
 		return;
 	}
-	
+
+        dbg("%s - port %d", __FUNCTION__, port->number);
 	usb_serial_debug_data(debug, &port->dev, __FUNCTION__, urb->actual_length, data);
 
 	/*
@@ -893,12 +776,5 @@
 MODULE_DESCRIPTION( DRIVER_DESC );
 MODULE_LICENSE("GPL");
 
-#ifdef FIX_WRITE_RETURN_CODE_PROBLEM
-module_param(write_blocking, int, 0);
-MODULE_PARM_DESC(write_blocking, 
-		 "The write function will block to write out all data");
-#endif
-
 module_param(debug, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(debug, "Debug enabled or not");
-

