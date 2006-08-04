Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161585AbWHDXxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161585AbWHDXxa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 19:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161493AbWHDXxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 19:53:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63143 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161585AbWHDXx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 19:53:29 -0400
Date: Fri, 4 Aug 2006 16:53:05 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: w@1wt.eu
Cc: zaitcev@redhat.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: usb 2.4: Little Rework for usbserial
Message-Id: <20060804165305.5f78cda5.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes various hangs and oopses which happen if serial devices
are handled roughly (e.g. disconnected while open), open-close-open
races and hangs, and issues with getty running on ttyUSBx.

Finally, I got rid of the "#ifdef I_AM_A_DARING_HACKER". Originally,
I thought it would be there for a week or two, and it was stuck in the
code for two years.

Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>

---

This patch was around for a while, but I was unable to find a critical
number of people willing to test. So, it languished in RHEL test kernels
for a couple of years.

Now we finally shipped it with RHEL 3 U8, so it would be dumb not
to let everyone to benefit. Also, Ben Cheridan demonstrated that people
still use 2.4 outside of vendor kernels.

diff -urp -X dontdiff linux-2.4.33-rc3/drivers/usb/serial/usbserial.c linux-2.4.33-rc3-u/drivers/usb/serial/usbserial.c
--- linux-2.4.33-rc3/drivers/usb/serial/usbserial.c	2006-08-04 14:28:49.000000000 -0700
+++ linux-2.4.33-rc3-u/drivers/usb/serial/usbserial.c	2006-08-04 14:35:15.000000000 -0700
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
@@ -467,6 +486,23 @@ static void return_serial (struct usb_se
 }
 
 /*
+ * A regular foo_put(), except a) it's open-coded without kref, and
+ * b) it's not the only place which does --serial->ref (due to locking).
+ *
+ * This does not do an equivalent of return_serial() because serial_table[]
+ * has a lifetime from probe to disconnect.
+ */
+static void serial_put(struct usb_serial *serial)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&post_lock, flags);
+	if (--serial->ref == 0)
+		kfree(serial);
+	spin_unlock_irqrestore(&post_lock, flags);
+}
+
+/*
  * The post kludge.
  *
  * Our component drivers are hideously buggy and written by people
@@ -495,7 +531,7 @@ static void post_helper(void *arg)
 	while (pos != &post_list) {
 		job = list_entry(pos, struct usb_serial_post_job, link);
 		port = job->port;
-		/* get_usb_serial checks port->tty, so cannot be used */
+		/* get_usb_serial checks serial->dev, so cannot be used */
 		serial = port->serial;
 		if (port->write_busy) {
 			dbg("%s - port %d busy", __FUNCTION__, port->number);
@@ -508,7 +544,7 @@ static void post_helper(void *arg)
 		down(&port->sem);
 		dbg("%s - port %d len %d backlog %d", __FUNCTION__,
 		    port->number, job->len, port->write_backlog);
-		if (port->tty != NULL) {
+		if (serial->dev != NULL) {
 			int rc;
 			int sent = 0;
 			while (sent < job->len) {
@@ -581,17 +617,25 @@ static int serial_open (struct tty_struc
 	struct usb_serial_port *port;
 	unsigned int portNumber;
 	int retval = 0;
-	
+	unsigned long flags;
+
 	dbg("%s", __FUNCTION__);
 
 	/* initialize the pointer incase something fails */
 	tty->driver_data = NULL;
 
+	/*
+	 * In a sane refcounting system, this would've been called serial_get().
+	 */
+	spin_lock_irqsave(&post_lock, flags);
 	/* get the serial object associated with this tty pointer */
 	serial = get_serial_by_minor (MINOR(tty->device));
-
-	if (serial_paranoia_check (serial, __FUNCTION__))
+	if (serial_paranoia_check(serial, __FUNCTION__) || serial->dev == NULL) {
+		spin_unlock_irqrestore(&post_lock, flags);
 		return -ENODEV;
+	}
+	serial->ref++;		/* Protect the port->sem from kfree() */
+	spin_unlock_irqrestore(&post_lock, flags);
 
 	/* set up our port structure making the tty driver remember our port object, and us it */
 	portNumber = MINOR(tty->device) - serial->minor;
@@ -600,7 +644,7 @@ static int serial_open (struct tty_struc
 
 	down (&port->sem);
 	port->tty = tty;
-	 
+
 	/* lock this module before we call it */
 	if (serial->type->owner)
 		__MOD_INC_USE_COUNT(serial->type->owner);
@@ -622,13 +666,16 @@ static int serial_open (struct tty_struc
 	}
 
 	up (&port->sem);
+	if (retval)
+		serial_put(serial);
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
 
@@ -653,36 +700,33 @@ static void __serial_close(struct usb_se
 
 static void serial_close(struct tty_struct *tty, struct file * filp)
 {
-	struct usb_serial_port *port = (struct usb_serial_port *) tty->driver_data;
-	struct usb_serial *serial = get_usb_serial (port, __FUNCTION__);
+	struct usb_serial_port *port;
+	struct usb_serial *serial;
 
-	if (!serial)
+	if ((port = tty->driver_data) == NULL) {
+		/* This happens if someone opened us with O_NDELAY */
 		return;
-
-	down (&port->sem);
+	}
+	if ((serial = port->serial) == NULL) {
+		err("%s - port %d: not open (count %d)", __FUNCTION__, port->number, port->open_count);
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
+	serial_put(serial);
+	tty->closing = 0;
 }
 
 static int __serial_write (struct usb_serial_port *port, int from_user, const unsigned char *buf, int count)
@@ -696,7 +740,7 @@ static int __serial_write (struct usb_se
 	dbg("%s - port %d, %d byte(s)", __FUNCTION__, port->number, count);
 
 	if (!port->open_count) {
-		dbg("%s - port not opened", __FUNCTION__);
+		dbg("%s - port not open", __FUNCTION__);
 		goto exit;
 	}
 
@@ -806,6 +850,9 @@ static int serial_post_one(struct usb_se
 	struct usb_serial_post_job *job;
 	unsigned long flags;
 
+	if (!serial)
+		return -ENODEV;
+
 	dbg("%s - port %d user %d count %d", __FUNCTION__, port->number, from_user, count);
 
 	job = kmalloc(sizeof(struct usb_serial_post_job), gfp);
@@ -1239,24 +1286,25 @@ static int generic_chars_in_buffer (stru
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
@@ -1272,6 +1320,9 @@ static void generic_read_bulk_callback (
 	  	tty_flip_buffer_push(tty);
 	}
 
+	if (serial->dev == NULL)
+		return;
+
 	/* Continue trying to always read  */
 	usb_fill_bulk_urb (port->read_urb, serial->dev,
 			   usb_rcvbulkpipe (serial->dev,
@@ -1289,18 +1340,12 @@ static void generic_read_bulk_callback (
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
@@ -1658,26 +1703,22 @@ static void usb_serial_disconnect(struct
 {
 	struct usb_serial *serial = (struct usb_serial *) ptr;
 	struct usb_serial_port *port;
-	unsigned long flags;
 	int i;
 
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
@@ -1716,10 +1757,7 @@ static void usb_serial_disconnect(struct
 		return_serial (serial);
 
 		/* free up any memory that we allocated */
-		spin_lock_irqsave(&post_lock, flags);
-		if (--serial->ref == 0)
-			kfree(serial);
-		spin_unlock_irqrestore(&post_lock, flags);
+		serial_put (serial);
 
 	} else {
 		info("device disconnected");
@@ -1813,6 +1851,11 @@ static void __exit usb_serial_exit(void)
 	
 	usb_deregister(&usb_serial_driver);
 	tty_unregister_driver(&serial_tty_driver);
+
+	while (!list_empty(&usb_serial_driver_list)) {
+		err("%s - module is in use, hanging...", __FUNCTION__);
+		msleep(5000);
+	}
 }
 
 
@@ -1862,7 +1905,7 @@ EXPORT_SYMBOL(usb_serial_deregister);
 	EXPORT_SYMBOL(ezusb_writememory);
 	EXPORT_SYMBOL(ezusb_set_reset);
 #endif
-
+EXPORT_SYMBOL(usb_serial_get_serial);
 
 /* Module information */
 MODULE_AUTHOR( DRIVER_AUTHOR );
diff -urp -X dontdiff linux-2.4.33-rc3/drivers/usb/serial/usb-serial.h linux-2.4.33-rc3-u/drivers/usb/serial/usb-serial.h
--- linux-2.4.33-rc3/drivers/usb/serial/usb-serial.h	2004-08-07 16:26:05.000000000 -0700
+++ linux-2.4.33-rc3-u/drivers/usb/serial/usb-serial.h	2006-08-04 15:21:46.000000000 -0700
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
