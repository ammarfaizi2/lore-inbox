Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbUFND10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUFND10 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 23:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUFND10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 23:27:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19112 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261763AbUFND0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 23:26:53 -0400
Date: Sun, 13 Jun 2004 20:26:44 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: <marcelo.tosatti@cyclades.com>, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Patch for USB serial in 2.4.27-pre5
Message-Id: <20040613202644.787b447c@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Work around a situation where a line discipline attempts to write
from an interrupt context and oopses when trying to take a semaphore.
This includes primarily PPP and getty, but I had people with GPS
and custom software stepping on it as well.

-- Pete

diff -urp -X dontdiff linux-2.4.27-pre5/drivers/usb/serial/usbserial.c linux-2.4.27-pre5-usb/drivers/usb/serial/usbserial.c
--- linux-2.4.27-pre5/drivers/usb/serial/usbserial.c	2003-11-29 18:53:05.000000000 -0800
+++ linux-2.4.27-pre5-usb/drivers/usb/serial/usbserial.c	2004-06-12 14:24:26.000000000 -0700
@@ -297,6 +297,7 @@
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/smp_lock.h>
+#include <linux/spinlock.h>
 #include <linux/usb.h>
 
 #ifdef CONFIG_USB_SERIAL_DEBUG
@@ -347,11 +348,29 @@ static struct usb_serial_device_type gen
 };
 #endif
 
+/*
+ * The post kludge structures and variables.
+ */
+#define POST_BSIZE	100	/* little below 128 in total */
+struct usb_serial_post_job {
+	struct list_head link;
+	struct usb_serial_port *port;
+	int len;
+	char buff[POST_BSIZE];
+};
+static spinlock_t post_lock = SPIN_LOCK_UNLOCKED;	/* Also covers ->ref */
+static struct list_head post_list = LIST_HEAD_INIT(post_list);
+static struct tq_struct post_task;
 
 /* local function prototypes */
 static int  serial_open (struct tty_struct *tty, struct file * filp);
 static void serial_close (struct tty_struct *tty, struct file * filp);
+static int __serial_write (struct usb_serial_port *port, int from_user, const unsigned char *buf, int count);
 static int  serial_write (struct tty_struct * tty, int from_user, const unsigned char *buf, int count);
+static int  serial_post_job(struct usb_serial_port *port, int from_user,
+    int gfp, const unsigned char *buf, int count);
+static int  serial_post_one(struct usb_serial_port *port, int from_user,
+    int gfp, const unsigned char *buf, int count);
 static int  serial_write_room (struct tty_struct *tty);
 static int  serial_chars_in_buffer (struct tty_struct *tty);
 static void serial_throttle (struct tty_struct * tty);
@@ -448,6 +467,63 @@ static void return_serial (struct usb_se
 	return;
 }
 
+/*
+ * The post kludge.
+ *
+ * Our component drivers are hideously buggy and written by people
+ * who have difficulty understanding the concept of spinlocks.
+ * There were so many races and lockups that Greg K-H made a watershed
+ * decision to provide what is essentially a single-threaded sandbox
+ * for component drivers, protected by a semaphore. It helped a lot, but
+ * for one little problem: when tty->low_latency is set, line disciplines
+ * can call ->write from an interrupt, where the semaphore oopses.
+ *
+ * Rather than open the whole can of worms again, we just post writes
+ * into a helper which can sleep.
+ *
+ * Kernel 2.6 has a proper fix. It replaces semaphores with proper locking.
+ */
+static void post_helper(void *arg)
+{
+	struct list_head *pos;
+	struct usb_serial_post_job *job;
+	struct usb_serial_port *port;
+	struct usb_serial *serial;
+	unsigned int flags;
+
+	spin_lock_irqsave(&post_lock, flags);
+	pos = post_list.next;
+	while (pos != &post_list) {
+		job = list_entry(pos, struct usb_serial_post_job, link);
+		port = job->port;
+		/* get_usb_serial checks port->tty, so cannot be used */
+		serial = port->serial;
+		if (port->write_busy) {
+			dbg("%s - port %d busy", __FUNCTION__, port->number);
+			pos = pos->next;
+			continue;
+		}
+		list_del(&job->link);
+		spin_unlock_irqrestore(&post_lock, flags);
+
+		down(&port->sem);
+		dbg("%s - port %d len %d backlog %d", __FUNCTION__,
+		    port->number, job->len, port->write_backlog);
+		if (port->tty != NULL)
+			__serial_write(port, 0, job->buff, job->len);
+		up(&port->sem);
+
+		spin_lock_irqsave(&post_lock, flags);
+		port->write_backlog -= job->len;
+		kfree(job);
+		if (--serial->ref == 0)
+			kfree(serial);
+		/* Have to reset because we dropped spinlock */
+		pos = post_list.next;
+	}
+	spin_unlock_irqrestore(&post_lock, flags);
+}
+
 #ifdef USES_EZUSB_FUNCTIONS
 /* EZ-USB Control and Status Register.  Bit 0 controls 8051 reset */
 #define CPUCS_REG    0x7F92
@@ -580,23 +656,34 @@ static void serial_close(struct tty_stru
 
 	/* if disconnect beat us to the punch here, there's nothing to do */
 	if (tty->driver_data) {
+		/*
+		 * XXX The right thing would be to wait for the output to drain.
+		 * But we are not sufficiently daring to experiment in 2.4.
+		 * N.B. If we do wait, no need to run post_helper here.
+		 * Normall callback mechanism wakes it up just fine.
+		 */
+#if I_AM_A_DARING_HACKER
+		tty->closing = 1;
+		up (&port->sem);
+		if (info->closing_wait != ASYNC_CLOSING_WAIT_NONE)
+			tty_wait_until_sent(tty, info->closing_wait);
+		down (&port->sem);
+		if (!tty->driver_data) /* woopsie, disconnect, now what */ ;
+#endif
 		__serial_close(port, filp);
 	}
 
 	up (&port->sem);
 }
 
-static int serial_write (struct tty_struct * tty, int from_user, const unsigned char *buf, int count)
+static int __serial_write (struct usb_serial_port *port, int from_user, const unsigned char *buf, int count)
 {
-	struct usb_serial_port *port = (struct usb_serial_port *) tty->driver_data;
 	struct usb_serial *serial = get_usb_serial (port, __FUNCTION__);
 	int retval = -EINVAL;
 
 	if (!serial)
 		return -ENODEV;
 
-	down (&port->sem);
-
 	dbg("%s - port %d, %d byte(s)", __FUNCTION__, port->number, count);
 
 	if (!port->open_count) {
@@ -611,10 +698,132 @@ static int serial_write (struct tty_stru
 		retval = generic_write(port, from_user, buf, count);
 
 exit:
-	up (&port->sem);
 	return retval;
 }
 
+static int serial_write (struct tty_struct * tty, int from_user, const unsigned char *buf, int count)
+{
+	struct usb_serial_port *port = (struct usb_serial_port *) tty->driver_data;
+	int rc;
+
+	if (!in_interrupt()) {
+		/*
+		 * Run post_list to reduce a possiblity of reordered writes.
+		 * Tasks can make keventd to sleep, sometimes for a long time.
+		 */
+		post_helper(NULL);
+
+		down(&port->sem);
+		/*
+		 * This happens when a line discipline asks how much room
+		 * we have, gets 64, then tries to perform two writes
+		 * for a byte each. First write takes whole URB, second
+		 * write hits this check.
+		 */
+		if (port->write_busy) {
+			up(&port->sem);
+			return serial_post_job(port, from_user, GFP_KERNEL,
+			    buf, count);
+		}
+
+		rc = __serial_write(port, from_user, buf, count);
+		up(&port->sem);
+		return rc;
+	}
+
+	if (from_user) {
+		/*
+		 * This is a BUG-able offense because we cannot
+		 * pagefault while in_interrupt, but we want to see
+		 * something in dmesg rather than just blinking LEDs.
+		 */
+		err("user data in interrupt write");
+		return -EINVAL;
+	}
+
+	return serial_post_job(port, 0, GFP_ATOMIC, buf, count);
+}
+
+static int serial_post_job(struct usb_serial_port *port, int from_user,
+    int gfp, const unsigned char *buf, int count)
+{
+	int done = 0, length;
+	int rc;
+
+	if (port == NULL)
+		return -EPIPE;
+
+	if (count >= 512) {
+		static int rate = 0;
+		/*
+		 * Data loss due to extreme circumstances.
+		 * It's a ususal thing on serial to lose characters, isn't it?
+		 * Neener, neener! Actually, it's probably an echo loop anyway.
+		 * Only happens when getty starts talking to Visor.
+		 */
+		if (++rate % 1000 < 3) {
+			err("too much data (%d) from %s", count,
+			    from_user? "user": "kernel");
+		}
+		count = 512;
+	}
+
+	while (done < count) {
+		length = count - done;
+		if (length > POST_BSIZE)
+			length = POST_BSIZE;
+		if (length > port->bulk_out_size)
+			length = port->bulk_out_size;
+
+		rc = serial_post_one(port, from_user, gfp, buf + done, length);
+		if (rc <= 0) {
+			if (done != 0)
+				return done;
+			return rc;
+		}
+		done += rc;
+	}
+
+	return done;
+}
+
+static int serial_post_one(struct usb_serial_port *port, int from_user,
+    int gfp, const unsigned char *buf, int count)
+{
+	struct usb_serial *serial = get_usb_serial (port, __FUNCTION__);
+	struct usb_serial_post_job *job;
+	unsigned long flags;
+
+	dbg("%s - port %d user %d count %d", __FUNCTION__, port->number, from_user, count);
+
+	job = kmalloc(sizeof(struct usb_serial_post_job), gfp);
+	if (job == NULL)
+		return -ENOMEM;
+
+	job->port = port;
+	if (count >= POST_BSIZE)
+		count = POST_BSIZE;
+	job->len = count;
+
+	if (from_user) {
+		if (copy_from_user(job->buff, buf, count)) {
+			kfree(job);
+			return -EFAULT;
+		}
+	} else {
+		memcpy(job->buff, buf, count);
+	}
+
+	spin_lock_irqsave(&post_lock, flags);
+	port->write_backlog += count;
+	list_add_tail(&job->link, &post_list);
+	serial->ref++;		/* Protect the port->sem from kfree() */
+	schedule_task(&post_task);
+	spin_unlock_irqrestore(&post_lock, flags);
+
+	return count;
+}
+
 static int serial_write_room (struct tty_struct *tty) 
 {
 	struct usb_serial_port *port = (struct usb_serial_port *) tty->driver_data;
@@ -624,6 +833,14 @@ static int serial_write_room (struct tty
 	if (!serial)
 		return -ENODEV;
 
+	if (in_interrupt()) {
+		retval = 0;
+		if (!port->write_busy && port->write_backlog == 0)
+			retval = port->bulk_out_size;
+		dbg("%s - returns %d", __FUNCTION__, retval);
+		return retval;
+	}
+
 	down (&port->sem);
 
 	dbg("%s - port %d", __FUNCTION__, port->number);
@@ -655,10 +872,8 @@ static int serial_chars_in_buffer (struc
 
 	down (&port->sem);
 
-	dbg("%s = port %d", __FUNCTION__, port->number);
-
 	if (!port->open_count) {
-		dbg("%s - port not open", __FUNCTION__);
+		dbg("%s - port %d: not open", __FUNCTION__, port->number);
 		goto exit;
 	}
 
@@ -917,18 +1132,23 @@ static int generic_write (struct usb_ser
 {
 	struct usb_serial *serial = port->serial;
 	int result;
-
-	dbg("%s - port %d", __FUNCTION__, port->number);
+	unsigned long flags;
 
 	if (count == 0) {
 		dbg("%s - write request of 0 bytes", __FUNCTION__);
 		return (0);
 	}
+	if (count < 0) {
+		err("%s - port %d: write request of %d bytes", __FUNCTION__,
+		    port->number, count);
+		return (0);
+	}
 
 	/* only do something if we have a bulk out endpoint */
 	if (serial->num_bulk_out) {
-		if (port->write_urb->status == -EINPROGRESS) {
-			dbg("%s - already writing", __FUNCTION__);
+		if (port->write_busy) {
+			/* Happens when two threads run port_helper. Watch. */
+			info("%s - already writing", __FUNCTION__);
 			return (0);
 		}
 
@@ -937,12 +1157,10 @@ static int generic_write (struct usb_ser
 		if (from_user) {
 			if (copy_from_user(port->write_urb->transfer_buffer, buf, count))
 				return -EFAULT;
-		}
-		else {
+		} else {
 			memcpy (port->write_urb->transfer_buffer, buf, count);
 		}
-
-		usb_serial_debug_data (__FILE__, __FUNCTION__, count, port->write_urb->transfer_buffer);
+		dbg("%s - port %d [%d]", __FUNCTION__, port->number, count);
 
 		/* set up our urb */
 		usb_fill_bulk_urb (port->write_urb, serial->dev,
@@ -954,10 +1172,18 @@ static int generic_write (struct usb_ser
 				     generic_write_bulk_callback), port);
 
 		/* send the data out the bulk port */
+		port->write_busy = 1;
 		result = usb_submit_urb(port->write_urb);
-		if (result)
-			err("%s - failed submitting write urb, error %d", __FUNCTION__, result);
-		else
+		if (result) {
+			err("%s - port %d: failed submitting write urb (%d)",
+			     __FUNCTION__, port->number, result);
+			port->write_busy = 0;
+			spin_lock_irqsave(&post_lock, flags);
+			if (port->write_backlog != 0)
+				schedule_task(&post_task);
+			spin_unlock_irqrestore(&post_lock, flags);
+
+		} else
 			result = count;
 
 		return result;
@@ -972,14 +1198,12 @@ static int generic_write_room (struct us
 	struct usb_serial *serial = port->serial;
 	int room = 0;
 
-	dbg("%s - port %d", __FUNCTION__, port->number);
-	
 	if (serial->num_bulk_out) {
-		if (port->write_urb->status != -EINPROGRESS)
+		if (!port->write_busy && port->write_backlog == 0)
 			room = port->bulk_out_size;
 	}
 
-	dbg("%s - returns %d", __FUNCTION__, room);
+	dbg("%s - port %d, returns %d", __FUNCTION__, port->number, room);
 	return (room);
 }
 
@@ -991,8 +1215,9 @@ static int generic_chars_in_buffer (stru
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
 	if (serial->num_bulk_out) {
-		if (port->write_urb->status == -EINPROGRESS)
-			chars = port->write_urb->transfer_buffer_length;
+		if (port->write_busy)
+			chars += port->write_urb->transfer_buffer_length;
+		chars += port->write_backlog;	/* spin_lock... Baah */
 	}
 
 	dbg("%s - returns %d", __FUNCTION__, chars);
@@ -1056,14 +1281,16 @@ static void generic_write_bulk_callback 
 
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
+	port->write_busy = 0;
+	wmb();
+
 	if (!serial) {
-		dbg("%s - bad serial pointer, exiting", __FUNCTION__);
+		err("%s - null serial pointer, exiting", __FUNCTION__);
 		return;
 	}
 
 	if (urb->status) {
 		dbg("%s - nonzero write bulk status received: %d", __FUNCTION__, urb->status);
-		return;
 	}
 
 	queue_task(&port->tqueue, &tq_immediate);
@@ -1089,12 +1316,18 @@ static void port_softint(void *private)
 	struct usb_serial_port *port = (struct usb_serial_port *)private;
 	struct usb_serial *serial = get_usb_serial (port, __FUNCTION__);
 	struct tty_struct *tty;
+	unsigned long flags;
 
 	dbg("%s - port %d", __FUNCTION__, port->number);
 	
 	if (!serial)
 		return;
 
+	spin_lock_irqsave(&post_lock, flags);
+	if (port->write_backlog != 0)
+		schedule_task(&post_task);
+	spin_unlock_irqrestore(&post_lock, flags);
+
 	tty = port->tty;
 	if (!tty)
 		return;
@@ -1108,7 +1341,6 @@ static void port_softint(void *private)
 }
 
 
-
 static void * usb_serial_probe(struct usb_device *dev, unsigned int ifnum,
 			       const struct usb_device_id *id)
 {
@@ -1132,6 +1364,7 @@ static void * usb_serial_probe(struct us
 	int num_ports;
 	int max_endpoints;
 	const struct usb_device_id *id_pattern = NULL;
+	unsigned long flags;
 
 	/* loop through our list of known serial converters, and see if this
 	   device matches. */
@@ -1342,11 +1575,15 @@ static void * usb_serial_probe(struct us
 		init_MUTEX (&port->sem);
 	}
 
+	spin_lock_irqsave(&post_lock, flags);
+	serial->ref = 1;
+	spin_unlock_irqrestore(&post_lock, flags);
+
 	/* if this device type has a startup function, call it */
 	if (type->startup) {
 		i = type->startup (serial);
 		if (i < 0)
-			goto probe_error;
+			goto startup_error;
 		if (i > 0)
 			return serial;
 	}
@@ -1361,6 +1598,12 @@ static void * usb_serial_probe(struct us
 	return serial; /* success */
 
 
+startup_error:
+	spin_lock_irqsave(&post_lock, flags);
+	if (serial->ref != 1) {
+		err("bug in component startup: ref %d\n", serial->ref);
+	}
+	spin_unlock_irqrestore(&post_lock, flags);
 probe_error:
 	for (i = 0; i < num_bulk_in; ++i) {
 		port = &serial->port[i];
@@ -1396,6 +1639,7 @@ static void usb_serial_disconnect(struct
 {
 	struct usb_serial *serial = (struct usb_serial *) ptr;
 	struct usb_serial_port *port;
+	unsigned long flags;
 	int i;
 
 	dbg ("%s", __FUNCTION__);
@@ -1453,7 +1697,10 @@ static void usb_serial_disconnect(struct
 		return_serial (serial);
 
 		/* free up any memory that we allocated */
-		kfree (serial);
+		spin_lock_irqsave(&post_lock, flags);
+		if (--serial->ref == 0)
+			kfree(serial);
+		spin_unlock_irqrestore(&post_lock, flags);
 
 	} else {
 		info("device disconnected");
@@ -1505,6 +1752,7 @@ static int __init usb_serial_init(void)
 	for (i = 0; i < SERIAL_TTY_MINORS; ++i) {
 		serial_table[i] = NULL;
 	}
+	post_task.routine = post_helper;
 
 	/* register the tty driver */
 	serial_tty_driver.init_termios          = tty_std_termios;
diff -urp -X dontdiff linux-2.4.27-pre5/drivers/usb/serial/usb-serial.h linux-2.4.27-pre5-usb/drivers/usb/serial/usb-serial.h
--- linux-2.4.27-pre5/drivers/usb/serial/usb-serial.h	2003-11-29 18:53:05.000000000 -0800
+++ linux-2.4.27-pre5-usb/drivers/usb/serial/usb-serial.h	2004-06-12 14:48:13.000000000 -0700
@@ -111,6 +111,8 @@ struct usb_serial_port {
 	int			bulk_out_size;
 	struct urb *		write_urb;
 	__u8			bulk_out_endpointAddress;
+	char			write_busy;	/* URB is active */
+	int			write_backlog;	/* Fifo used */
 
 	wait_queue_head_t	write_wait;
 	struct tq_struct	tqueue;
@@ -161,6 +163,7 @@ struct usb_serial {
 	__u16				product;
 	struct usb_serial_port		port[MAX_NUM_PORTS];
 	void *				private;
+	int				ref;
 };
 
 
