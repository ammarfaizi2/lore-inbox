Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbUK1Bjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbUK1Bjv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 20:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbUK1Bjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 20:39:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44701 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261385AbUK1Bg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 20:36:57 -0500
Date: Sat, 27 Nov 2004 17:35:58 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: greg@kroah.com
Cc: linux-usb-devel@lists.sourceforge.net, zaitcev@redhat.com,
       <rwhite@casabyte.com>, linux-kernel@vger.kernel.org,
       <kingst@eecs.umich.edu>, <paulkf@microgate.com>,
       <Oleksiy@kharkiv.com.ua>, reg@dwf.com, clemens@dwf.com
Subject: Little rework of usbserial in 2.4
Message-ID: <20041127173558.4011b177@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.13; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg, hi, guys:

Here's what I'd like to see in current round of 2.4 with Marcelo.
A few problems were addressed:

#1. A long standing annoyance with quick close and reopen after a disconnect
_and a reconnect_ would sometimes fail. Once it fails, nothing ever helps,
only disconnecting and reconnecting again. This is fixed with the move of
open counting into the ->close from disconnect.

The #1 needs testing. Before, if an open device were disconnected, close
was called before shutdown, but now it's reversed. Most drivers do not care,
they usually just have a refcount anyway. But who knows.

#2. Added drain on close. I forgot, who asked for it, it was a while ago.

#3. Moved paranoya in-line;

#4. My mct_u232 would make a lockup on unplug. It turned out that it
would receive an error in interrupt URB, do nothing and return. The HC
driver resubmits, fails, calls back. The khubd thread gets no CPU and thus
delivers no disconnects, and URB is not unlinked.

The 2.6 solves it right. For some error codes the URB is not re-submitted.
In 2.4 we have errors overlapping, and also I'd need to cancel. Canceling
from an interrupt has to be asynchronous, but I know that it doesn't work
too well with OHCI we have in 2.4. So, I just set urb->interval to zero if
we get hammered with errors.

#5. The tty_hangup. I have to say, I made a mistake associating this with
the #1 refcount rework. Robert White's patch was correct. If this bigger
rework falls through, I'll just use his thing.

Some work is not done yet.

Not done #1: I asked Paul Fulghum to experiment with dropping a private
implementation of write callback from pl2303 and have Oleksy to test it.
I guess I have to do it myself some time.

Not done #2: Sam King's setthrottle patch is not in yet.

Not done #3: The drain on close uncovered something which I suspect always
was there. Sometimes, after a disconnect, it would hang waiting for the writes
to finish. When this happens, _module_ reference count leaks (of all things!)
This is quite strange.

I'd like review and comments.

-- Pete

diff -urpN -X dontdiff linux-2.4.28-bk3/drivers/usb/serial/mct_u232.c linux-2.4.28-bk3-sx4/drivers/usb/serial/mct_u232.c
--- linux-2.4.28-bk3/drivers/usb/serial/mct_u232.c	2004-08-10 13:43:36.000000000 -0700
+++ linux-2.4.28-bk3-sx4/drivers/usb/serial/mct_u232.c	2004-11-27 16:42:19.833581331 -0800
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
@@ -477,112 +466,22 @@ static void mct_u232_close (struct usb_s
 } /* mct_u232_close */
 
 
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
+	struct mct_u232_interval_kludge *ikp = &priv->ik[n];
 
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
-
-	if (urb->status) {
-		dbg("%s - nonzero write bulk status received: %d", __FUNCTION__,
-		    urb->status);
-		return;
-	}
-
-	if (write_blocking) {
-		wake_up_interruptible(&port->write_wait);
-		if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
-		    tty->ldisc.write_wakeup)
-			(tty->ldisc.write_wakeup)(tty);
-		wake_up_interruptible(&tty->write_wait);
-		
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
@@ -593,21 +492,37 @@ static void mct_u232_read_int_callback (
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
@@ -664,7 +579,6 @@ static void mct_u232_read_int_callback (
 	/* INT urbs are automatically re-submitted */
 } /* mct_u232_read_int_callback */
 
-
 static void mct_u232_set_termios (struct usb_serial_port *port,
 				  struct termios *old_termios)
 {
@@ -785,6 +699,21 @@ static void mct_u232_break_ctl( struct u
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
@@ -798,8 +727,8 @@ static int mct_u232_ioctl (struct usb_se
 	/* Based on code from acm.c and others */
 	switch (cmd) {
 	case TIOCMGET:
-		return put_user(priv->control_state, (unsigned long *) arg);
-		break;
+		mask = mct_u232_tiocmget(port, file);
+		return put_user(mask, (unsigned long *) arg);
 
 	case TIOCMSET: /* Turns on and off the lines as specified by the mask */
 	case TIOCMBIS: /* turns on (Sets) the lines as specified by the mask */
@@ -869,12 +798,5 @@ MODULE_AUTHOR( DRIVER_AUTHOR );
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
diff -urpN -X dontdiff linux-2.4.28-bk3/drivers/usb/serial/usbserial.c linux-2.4.28-bk3-sx4/drivers/usb/serial/usbserial.c
--- linux-2.4.28-bk3/drivers/usb/serial/usbserial.c	2004-11-22 23:04:19.000000000 -0800
+++ linux-2.4.28-bk3-sx4/drivers/usb/serial/usbserial.c	2004-11-27 10:36:49.000000000 -0800
@@ -408,6 +408,25 @@ static struct usb_serial	*serial_table[S
 static LIST_HEAD(usb_serial_driver_list);
 
 
+struct usb_serial *usb_serial_get_serial(struct usb_serial_port *port,
+    const char *function) 
+{
+
+	/* if no port was specified, or it fails a paranoia check */
+	if (!port || 
+	    port_paranoia_check (port, function) ||
+	    serial_paranoia_check (port->serial, function)) {
+		return NULL;
+	}
+
+	/* disconnected, cut off all operations */
+	if (port->serial->dev == NULL)
+		return NULL;
+
+	return port->serial;
+}
+
+
 static struct usb_serial *get_serial_by_minor (unsigned int minor)
 {
 	return serial_table[minor];
@@ -495,7 +514,7 @@ static void post_helper(void *arg)
 	while (pos != &post_list) {
 		job = list_entry(pos, struct usb_serial_post_job, link);
 		port = job->port;
-		/* get_usb_serial checks port->tty, so cannot be used */
+		/* get_usb_serial checks serial->dev, so cannot be used */
 		serial = port->serial;
 		if (port->write_busy) {
 			dbg("%s - port %d busy", __FUNCTION__, port->number);
@@ -508,7 +527,7 @@ static void post_helper(void *arg)
 		down(&port->sem);
 		dbg("%s - port %d len %d backlog %d", __FUNCTION__,
 		    port->number, job->len, port->write_backlog);
-		if (port->tty != NULL) {
+		if (serial->dev != NULL) {
 			int rc;
 			int sent = 0;
 			while (sent < job->len) {
@@ -590,7 +609,7 @@ static int serial_open (struct tty_struc
 	/* get the serial object associated with this tty pointer */
 	serial = get_serial_by_minor (MINOR(tty->device));
 
-	if (serial_paranoia_check (serial, __FUNCTION__))
+	if (serial_paranoia_check (serial, __FUNCTION__) || serial->dev == NULL)
 		return -ENODEV;
 
 	/* set up our port structure making the tty driver remember our port object, and us it */
@@ -600,7 +619,7 @@ static int serial_open (struct tty_struc
 
 	down (&port->sem);
 	port->tty = tty;
-	 
+
 	/* lock this module before we call it */
 	if (serial->type->owner)
 		__MOD_INC_USE_COUNT(serial->type->owner);
@@ -622,13 +641,15 @@ static int serial_open (struct tty_struc
 	}
 
 	up (&port->sem);
+/* P3 */ err("%s - port %d: opened with %d", __FUNCTION__, MINOR(tty->device), retval);
 	return retval;
 }
 
 static void __serial_close(struct usb_serial_port *port, struct file *filp)
 {
+
 	if (!port->open_count) {
-		dbg ("%s - port not opened", __FUNCTION__);
+		err("%s - port %d: not open", __FUNCTION__, port->number);
 		return;
 	}
 
@@ -653,36 +674,34 @@ static void __serial_close(struct usb_se
 
 static void serial_close(struct tty_struct *tty, struct file * filp)
 {
-	struct usb_serial_port *port = (struct usb_serial_port *) tty->driver_data;
-	struct usb_serial *serial = get_usb_serial (port, __FUNCTION__);
+	struct usb_serial_port *port;
+	struct usb_serial *serial;
 
-	if (!serial)
+	if ((port = tty->driver_data) == NULL) {
+		/* This happens if someone opened us with O_NDELAY */
+	/* P3 */
+		err("%s - port %d: none", __FUNCTION__, MINOR(tty->device));
 		return;
-
-	down (&port->sem);
+	}
+	if ((serial = port->serial) == NULL) {
+		err("%s - port %d: not open", __FUNCTION__, port->number);
+		return;
+	}
 
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
-	/* if disconnect beat us to the punch here, there's nothing to do */
-	if (tty->driver_data) {
-		/*
-		 * XXX The right thing would be to wait for the output to drain.
-		 * But we are not sufficiently daring to experiment in 2.4.
-		 * N.B. If we do wait, no need to run post_helper here.
-		 * Normall callback mechanism wakes it up just fine.
-		 */
-#if I_AM_A_DARING_HACKER
-		tty->closing = 1;
-		up (&port->sem);
-		if (info->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-			tty_wait_until_sent(tty, info->closing_wait);
-		down (&port->sem);
-		if (!tty->driver_data) /* woopsie, disconnect, now what */ ;
-#endif
-		__serial_close(port, filp);
+	tty->closing = 1;
+	if (serial->dev != NULL) {
+		/* In most drivers, this is set with setserial */
+		/** if (info->closing_wait != ASYNC_CLOSING_WAIT_NONE) **/
+		tty_wait_until_sent(tty, /** info->closing_wait **/ 30*HZ);
 	}
 
+	down (&port->sem);
+	__serial_close(port, filp);
 	up (&port->sem);
+
+	tty->closing = 0;
 }
 
 static int __serial_write (struct usb_serial_port *port, int from_user, const unsigned char *buf, int count)
@@ -696,7 +715,7 @@ static int __serial_write (struct usb_se
 	dbg("%s - port %d, %d byte(s)", __FUNCTION__, port->number, count);
 
 	if (!port->open_count) {
-		dbg("%s - port not opened", __FUNCTION__);
+		dbg("%s - port not open", __FUNCTION__);
 		goto exit;
 	}
 
@@ -803,6 +822,9 @@ static int serial_post_one(struct usb_se
 	struct usb_serial_post_job *job;
 	unsigned long flags;
 
+	if (!serial)
+		return -ENODEV;
+
 	dbg("%s - port %d user %d count %d", __FUNCTION__, port->number, from_user, count);
 
 	job = kmalloc(sizeof(struct usb_serial_post_job), gfp);
@@ -1236,24 +1258,25 @@ static int generic_chars_in_buffer (stru
 static void generic_read_bulk_callback (struct urb *urb)
 {
 	struct usb_serial_port *port = (struct usb_serial_port *)urb->context;
-	struct usb_serial *serial = get_usb_serial (port, __FUNCTION__);
+	struct usb_serial *serial = port->serial;
 	struct tty_struct *tty;
 	unsigned char *data = urb->transfer_buffer;
 	int i;
 	int result;
 
-	dbg("%s - port %d", __FUNCTION__, port->number);
-
 	if (!serial) {
-		dbg("%s - bad serial pointer, exiting", __FUNCTION__);
+		err("%s - null serial pointer, exiting", __FUNCTION__);
 		return;
 	}
 
 	if (urb->status) {
-		dbg("%s - nonzero read bulk status received: %d", __FUNCTION__, urb->status);
+		dbg("%s - nonzero read bulk status received: %d, pipe 0x%x",
+		    __FUNCTION__, urb->status, urb->pipe);
 		return;
 	}
 
+	dbg("%s - port %d", __FUNCTION__, port->number);
+
 	usb_serial_debug_data (__FILE__, __FUNCTION__, urb->actual_length, data);
 
 	tty = port->tty;
@@ -1269,6 +1292,9 @@ static void generic_read_bulk_callback (
 	  	tty_flip_buffer_push(tty);
 	}
 
+	if (serial->dev == NULL)
+		return;
+
 	/* Continue trying to always read  */
 	usb_fill_bulk_urb (port->read_urb, serial->dev,
 			   usb_rcvbulkpipe (serial->dev,
@@ -1286,18 +1312,12 @@ static void generic_read_bulk_callback (
 static void generic_write_bulk_callback (struct urb *urb)
 {
 	struct usb_serial_port *port = (struct usb_serial_port *)urb->context;
-	struct usb_serial *serial = get_usb_serial (port, __FUNCTION__);
 
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
 	port->write_busy = 0;
 	wmb();
 
-	if (!serial) {
-		err("%s - null serial pointer, exiting", __FUNCTION__);
-		return;
-	}
-
 	if (urb->status) {
 		dbg("%s - nonzero write bulk status received: %d", __FUNCTION__, urb->status);
 	}
@@ -1653,21 +1673,18 @@ static void usb_serial_disconnect(struct
 
 	dbg ("%s", __FUNCTION__);
 	if (serial) {
-		/* fail all future close/read/write/ioctl/etc calls */
 		for (i = 0; i < serial->num_ports; ++i) {
 			port = &serial->port[i];
 			down (&port->sem);
 			if (port->tty != NULL)
-				while (port->open_count > 0)
-					__serial_close(port, NULL);
+				tty_hangup(port->tty);
 			up (&port->sem);
 		}
-
-		serial->dev = NULL;
 		serial_shutdown (serial);
 
-		for (i = 0; i < serial->num_ports; ++i)
-			serial->port[i].open_count = 0;
+		/* fail all future close/read/write/ioctl/etc calls */
+		serial->dev = NULL;
+		wmb();
 
 		for (i = 0; i < serial->num_bulk_in; ++i) {
 			port = &serial->port[i];
@@ -1803,6 +1820,12 @@ static void __exit usb_serial_exit(void)
 	
 	usb_deregister(&usb_serial_driver);
 	tty_unregister_driver(&serial_tty_driver);
+
+	while (!list_empty(&usb_serial_driver_list)) {
+		err("%s - module is in use, hanging...\n", __FUNCTION__);
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(5*HZ);
+	}
 }
 
 
@@ -1852,7 +1875,7 @@ EXPORT_SYMBOL(usb_serial_deregister);
 	EXPORT_SYMBOL(ezusb_writememory);
 	EXPORT_SYMBOL(ezusb_set_reset);
 #endif
-
+EXPORT_SYMBOL(usb_serial_get_serial);
 
 /* Module information */
 MODULE_AUTHOR( DRIVER_AUTHOR );
diff -urpN -X dontdiff linux-2.4.28-bk3/drivers/usb/serial/usb-serial.h linux-2.4.28-bk3-sx4/drivers/usb/serial/usb-serial.h
--- linux-2.4.28-bk3/drivers/usb/serial/usb-serial.h	2004-11-23 10:18:06.000000000 -0800
+++ linux-2.4.28-bk3-sx4/drivers/usb/serial/usb-serial.h	2004-11-27 16:57:51.753828286 -0800
@@ -308,20 +308,9 @@ static inline int port_paranoia_check (s
 	return 0;
 }
 
-
-static inline struct usb_serial* get_usb_serial (struct usb_serial_port *port, const char *function) 
-{ 
-	/* if no port was specified, or it fails a paranoia check */
-	if (!port || 
-		port_paranoia_check (port, function) ||
-		serial_paranoia_check (port->serial, function)) {
-		/* then say that we don't have a valid usb_serial thing, which will
-		 * end up genrating -ENODEV return values */ 
-		return NULL;
-	}
-
-	return port->serial;
-}
+#define get_usb_serial(p, f)	usb_serial_get_serial(p, f)
+extern struct usb_serial *usb_serial_get_serial(struct usb_serial_port *port,
+    const char *function_name);
 
 
 static inline void usb_serial_debug_data (const char *file, const char *function, int size, const unsigned char *data)
