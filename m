Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbVBJUp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbVBJUp3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 15:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbVBJUp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 15:45:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41893 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261946AbVBJUoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 15:44:22 -0500
Date: Thu, 10 Feb 2005 12:44:13 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: <marcelo.tosatti@cyclades.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: USB 2.4.30: mct_u232
Message-ID: <20050210124413.1662679d@localhost.localdomain>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that 2.6 has my changes, we can apply them to 2.4. This includes the
removal of dead code under #ifdef FIX_WRITE_RETURN_CODE_PROBLEM.

This patch fixes the endless loops on disconnect when resubmitting failed
URBs monopolizes CPU and prevents the disconnect thread from cleaning up.

Note though that because of the error code confusion, the actual technique
used in 2.4 is different from 2.6. The 2.4 version simply counts errors.
If too many are received in a row, we stop resubmitting. I consider this
relatively safe, because closing the line clears the condition, and so
in the unlikely event of a regression, users are not made to reboot.

diff -urpN -X dontdiff linux-2.4.30-pre1/drivers/usb/serial/mct_u232.c linux-2.4.30-pre1-usb/drivers/usb/serial/mct_u232.c
--- linux-2.4.30-pre1/drivers/usb/serial/mct_u232.c	2005-01-25 11:17:25.000000000 -0800
+++ linux-2.4.30-pre1-usb/drivers/usb/serial/mct_u232.c	2005-02-10 11:18:13.000000000 -0800
@@ -86,26 +86,14 @@
 #include "usb-serial.h"
 #include "mct_u232.h"
 
-
 /*
  * Version Information
  */
-#define DRIVER_VERSION "v1.2"
+#define DRIVER_VERSION "z2.0"		/* Linux in-kernel version */
 #define DRIVER_AUTHOR "Wolfgang Grandegger <wolfgang@ces.ch>"
 #define DRIVER_DESC "Magic Control Technology USB-RS232 converter driver"
 
 /*
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
-/*
  * Function prototypes
  */
 static int  mct_u232_startup	         (struct usb_serial *serial);
@@ -114,13 +102,6 @@ static int  mct_u232_open	         (stru
 					  struct file *filp);
 static void mct_u232_close	         (struct usb_serial_port *port,
 					  struct file *filp);
-#ifdef FIX_WRITE_RETURN_CODE_PROBLEM
-static int  mct_u232_write	         (struct usb_serial_port *port,
-					  int from_user,
-					  const unsigned char *buf,
-					  int count);
-static void mct_u232_write_bulk_callback (struct urb *urb);
-#endif
 static void mct_u232_read_int_callback   (struct urb *urb);
 static void mct_u232_set_termios         (struct usb_serial_port *port,
 					  struct termios * old);
@@ -147,7 +128,7 @@ MODULE_DEVICE_TABLE (usb, id_table_combi
 
 static struct usb_serial_device_type mct_u232_device = {
 	.owner =	     THIS_MODULE,
-	.name =		     "Magic Control Technology USB-RS232",
+	.name =		     "MCT U232",
 	.id_table =	     id_table_combined,
 	.num_interrupt_in =  2,
 	.num_bulk_in =	     0,
@@ -155,10 +136,6 @@ static struct usb_serial_device_type mct
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
@@ -167,9 +144,14 @@ static struct usb_serial_device_type mct
 	.shutdown =	     mct_u232_shutdown,
 };
 
+struct mct_u232_interval_kludge {
+	int ecnt;			/* Error counter */
+	int ibase;			/* Initial interval value */
+};
 
 struct mct_u232_private {
 	spinlock_t lock;
+	struct mct_u232_interval_kludge ik[2];
 	unsigned int	     control_state; /* Modem Line Setting (TIOCM) */
 	unsigned char        last_lcr;      /* Line Control Register */
 	unsigned char	     last_lsr;      /* Line Status Register */
@@ -359,17 +341,13 @@ static int mct_u232_startup (struct usb_
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
 	serial->port->private = priv;
- 
+
 	init_waitqueue_head(&serial->port->write_wait);
 
 	/* Puh, that's dirty */
@@ -383,20 +361,27 @@ static int mct_u232_startup (struct usb_
 	rport->interrupt_in_urb = NULL;
 	port->read_urb->context = port;
 
+	priv->ik[0].ibase = port->read_urb->interval;
+	priv->ik[1].ibase = port->interrupt_in_urb->interval;
+
 	return (0);
 } /* mct_u232_startup */
 
 
 static void mct_u232_shutdown (struct usb_serial *serial)
 {
+	struct mct_u232_private *priv;
 	int i;
 	
 	dbg("%s", __FUNCTION__);
 
 	for (i=0; i < serial->num_ports; ++i) {
 		/* My special items, the standard routines free my urbs */
-		if (serial->port[i].private)
-			kfree(serial->port[i].private);
+		priv = serial->port[i].private;
+		if (priv) {
+			serial->port[i].private = NULL;
+			kfree(priv);
+		}
 	}
 } /* mct_u232_shutdown */
 
@@ -448,16 +433,20 @@ static int  mct_u232_open (struct usb_se
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	port->read_urb->dev = port->serial->dev;
+	port->read_urb->interval = priv->ik[0].ibase;
 	retval = usb_submit_urb(port->read_urb);
 	if (retval) {
-		err("usb_submit_urb(read bulk) failed");
+		err("usb_submit_urb(read bulk) failed pipe 0x%x err %d",
+		    port->read_urb->pipe, retval);
 		goto exit;
 	}
 
 	port->interrupt_in_urb->dev = port->serial->dev;
+	port->interrupt_in_urb->interval = priv->ik[1].ibase;
 	retval = usb_submit_urb(port->interrupt_in_urb);
 	if (retval)
-		err(" usb_submit_urb(read int) failed");
+		err(" usb_submit_urb(read int) failed pipe 0x%x err %d",
+		    port->interrupt_in_urb->pipe, retval);
 
 exit:
 	return 0;
@@ -476,109 +465,22 @@ static void mct_u232_close (struct usb_s
 	}
 } /* mct_u232_close */
 
-
-#ifdef FIX_WRITE_RETURN_CODE_PROBLEM
-/* The generic routines work fine otherwise */
-
-static int mct_u232_write (struct usb_serial_port *port, int from_user,
-			   const unsigned char *buf, int count)
+static void mct_u232_error_step (struct urb *urb,
+    struct mct_u232_private *priv, int n)
 {
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
-		return(0);;
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
-		usb_serial_debug_data (__FILE__, __FUNCTION__, size, buf);
-		
-		if (from_user) {
-			if (copy_from_user(port->write_urb->transfer_buffer, buf, size)) {
-				return -EFAULT;
-			}
-		}
-		else {
-			memcpy (port->write_urb->transfer_buffer, buf, size);
-		}
-		
-		/* set up our urb */
-		FILL_BULK_URB(port->write_urb, serial->dev,
-			      usb_sndbulkpipe(serial->dev,
-					      port->bulk_out_endpointAddress),
-			      port->write_urb->transfer_buffer, size,
-			      ((serial->type->write_bulk_callback) ?
-			       serial->type->write_bulk_callback :
-			       mct_u232_write_bulk_callback),
-			      port);
-		
-		/* send the data out the bulk port */
-		result = usb_submit_urb(port->write_urb);
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
-static void mct_u232_write_bulk_callback (struct urb *urb)
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
+	struct mct_u232_interval_kludge *ikp = &priv->ik[n];
 
-	if (urb->status) {
-		dbg("%s - nonzero write bulk status received: %d", __FUNCTION__,
-		    urb->status);
-		return;
-	}
-
-	if (write_blocking) {
-		wake_up_interruptible(&port->write_wait);
-		tty_wakeup(tty);
+	if (ikp->ecnt >= 2) {
+		if (urb->interval)
+			err("%s - too many errors: "
+			    "status %d pipe 0x%x interval %d",
+			    __FUNCTION__,
+			    urb->status, urb->pipe, urb->interval);
+		urb->interval = 0;
 	} else {
-		/* from generic_write_bulk_callback */
-		queue_task(&port->tqueue, &tq_immediate);
-		mark_bh(IMMEDIATE_BH);
+		++ikp->ecnt;
 	}
-
-	return;
-} /* mct_u232_write_bulk_callback */
-#endif
+}
 
 static void mct_u232_read_int_callback (struct urb *urb)
 {
@@ -589,21 +491,37 @@ static void mct_u232_read_int_callback (
 	unsigned char *data = urb->transfer_buffer;
 	unsigned long flags;
 
-        dbg("%s - port %d", __FUNCTION__, port->number);
-
 	/* The urb might have been killed. */
         if (urb->status) {
-                dbg("%s - nonzero read bulk status received: %d", __FUNCTION__,
-		    urb->status);
+		dbg("%s - nonzero status %d, pipe 0x%x flags 0x%x interval %d",
+		    __FUNCTION__,
+		    urb->status, urb->pipe, urb->transfer_flags, urb->interval);
+		/*
+		 * The bad stuff happens when a device is disconnected.
+		 * This can cause us to spin while trying to resubmit.
+		 * Unfortunately, in kernel 2.4 error codes are wildly
+		 * different between controllers, so the status is useless.
+		 * Instead we just refuse to spin too much.
+		 */
+		if (urb == port->read_urb)
+			mct_u232_error_step(urb, priv, 0);
+		if (urb == port->interrupt_in_urb)
+			mct_u232_error_step(urb, priv, 1);
                 return;
         }
 	if (!serial) {
 		dbg("%s - bad serial pointer, exiting", __FUNCTION__);
 		return;
 	}
-	
+
+        dbg("%s - port %d", __FUNCTION__, port->number);
 	usb_serial_debug_data (__FILE__, __FUNCTION__, urb->actual_length, data);
 
+	if (urb == port->read_urb)
+		priv->ik[0].ecnt = 0;
+	if (urb == port->interrupt_in_urb)
+		priv->ik[1].ecnt = 0;
+
 	/*
 	 * Work-a-round: handle the 'usual' bulk-in pipe here
 	 */
@@ -660,7 +578,6 @@ static void mct_u232_read_int_callback (
 	/* INT urbs are automatically re-submitted */
 } /* mct_u232_read_int_callback */
 
-
 static void mct_u232_set_termios (struct usb_serial_port *port,
 				  struct termios *old_termios)
 {
@@ -781,6 +698,21 @@ static void mct_u232_break_ctl( struct u
 } /* mct_u232_break_ctl */
 
 
+static int mct_u232_tiocmget (struct usb_serial_port *port, struct file *file)
+{
+	struct mct_u232_private *priv = (struct mct_u232_private *)port->private;
+	unsigned int control_state;
+	unsigned long flags;
+	
+	dbg("%s", __FUNCTION__);
+
+	spin_lock_irqsave(&priv->lock, flags);
+	control_state = priv->control_state;
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return control_state;
+}
+
 static int mct_u232_ioctl (struct usb_serial_port *port, struct file * file,
 			   unsigned int cmd, unsigned long arg)
 {
@@ -794,8 +726,8 @@ static int mct_u232_ioctl (struct usb_se
 	/* Based on code from acm.c and others */
 	switch (cmd) {
 	case TIOCMGET:
-		return put_user(priv->control_state, (unsigned long *) arg);
-		break;
+		mask = mct_u232_tiocmget(port, file);
+		return put_user(mask, (unsigned long *) arg);
 
 	case TIOCMSET: /* Turns on and off the lines as specified by the mask */
 	case TIOCMBIS: /* turns on (Sets) the lines as specified by the mask */
@@ -865,12 +797,5 @@ MODULE_AUTHOR( DRIVER_AUTHOR );
 MODULE_DESCRIPTION( DRIVER_DESC );
 MODULE_LICENSE("GPL");
 
-#ifdef FIX_WRITE_RETURN_CODE_PROBLEM
-MODULE_PARM(write_blocking, "i");
-MODULE_PARM_DESC(write_blocking, 
-		 "The write function will block to write out all data");
-#endif
-
 MODULE_PARM(debug, "i");
 MODULE_PARM_DESC(debug, "Debug enabled or not");
-
