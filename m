Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVFIQsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVFIQsj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 12:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVFIQsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 12:48:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:28597 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261555AbVFIQpD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 12:45:03 -0400
Cc: abbotti@mev.co.uk
Subject: [PATCH] USB: ftdi_sio: avoid losing received data in tty-ldisc
In-Reply-To: <1118335493872@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 9 Jun 2005 09:44:54 -0700
Message-Id: <11183354941899@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] USB: ftdi_sio: avoid losing received data in tty-ldisc

ftdi_sio: Avoid losing bytes at tty-ldisc.

This patch was originally developed by Daniel Smertnig.  I
(Ian Abbott) made a few changes.  It has been tested by both
Daniel and I, at least for raw, non-canonical receive data
processing.

Here is Daniel's original description of the patch:

===
During a project in which I was using a FTDI 232BM to
transmit data at relative high speeds (625kBit/s), I
noticed a problem where data was lost even if flow
control was enabled: The FTDI-Driver receives 512 Bytes
of data over USB at a time, which consists of 8 64-Byte
packets. Subtracting the 2 bytes of status information
included in each packet this gives 496 "real" data
bytes per read.

This data is passed (indirectly, via the flip buffers)
to the tty line discipline which takes care of
throttling when there the free buffer space reaches
TTY_THRESHOLD_THROTTLE (128). Because the FTDI driver
processes up to 496 bytes at a time, throttling won't
happen in time and the line discipline will discard the
remaining bytes.

To avoid this the patch passes data in 62-byte blocks
to the tty layer and checks the available space in the
ldisc-buffers. If there isn't enough free space,
processing the rest of the data is delayed using a
workqueue.

Note: The original problem should be easily
reproducible with a userspace program which does slow &
small reads.
===

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Daniel Smertnig <daniel.smertnig@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 76854ceac3ef3408ab9a50a2521147fb14779f58
tree 130700c6871e73269bfad0b9f0439d51e0c353a3
parent 9f793d2c77ec5818679e4747c554d9333cecf476
author Ian Abbott <abbotti@mev.co.uk> Thu, 02 Jun 2005 10:34:11 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 09 Jun 2005 01:38:15 -0700

 drivers/usb/serial/ftdi_sio.c |  118 ++++++++++++++++++++++++++++++++---------
 1 files changed, 91 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -264,7 +264,7 @@
 /*
  * Version Information
  */
-#define DRIVER_VERSION "v1.4.1"
+#define DRIVER_VERSION "v1.4.2"
 #define DRIVER_AUTHOR "Greg Kroah-Hartman <greg@kroah.com>, Bill Ryder <bryder@sgi.com>, Kuba Ober <kuba@mareimbrium.org>"
 #define DRIVER_DESC "USB FTDI Serial Converters Driver"
 
@@ -687,6 +687,8 @@ struct ftdi_private {
  	char prev_status, diff_status;        /* Used for TIOCMIWAIT */
 	__u8 rx_flags;		/* receive state flags (throttling) */
 	spinlock_t rx_lock;	/* spinlock for receive state */
+	struct work_struct rx_work;
+	int rx_processed;
 
 	__u16 interface;	/* FT2232C port interface (0 for FT232/245) */
 
@@ -717,7 +719,7 @@ static int  ftdi_write_room		(struct usb
 static int  ftdi_chars_in_buffer	(struct usb_serial_port *port);
 static void ftdi_write_bulk_callback	(struct urb *urb, struct pt_regs *regs);
 static void ftdi_read_bulk_callback	(struct urb *urb, struct pt_regs *regs);
-static void ftdi_process_read		(struct usb_serial_port *port);
+static void ftdi_process_read		(void *param);
 static void ftdi_set_termios		(struct usb_serial_port *port, struct termios * old);
 static int  ftdi_tiocmget               (struct usb_serial_port *port, struct file *file);
 static int  ftdi_tiocmset		(struct usb_serial_port *port, struct file * file, unsigned int set, unsigned int clear);
@@ -1387,6 +1389,8 @@ static int ftdi_common_startup (struct u
 		port->read_urb->transfer_buffer_length = BUFSZ;
 	}
 
+	INIT_WORK(&priv->rx_work, ftdi_process_read, port);
+
 	/* Free port's existing write urb and transfer buffer. */
 	if (port->write_urb) {
 		usb_free_urb (port->write_urb);
@@ -1617,6 +1621,7 @@ static int  ftdi_open (struct usb_serial
 	spin_unlock_irqrestore(&priv->rx_lock, flags);
 
 	/* Start reading from the device */
+	priv->rx_processed = 0;
 	usb_fill_bulk_urb(port->read_urb, dev,
 		      usb_rcvbulkpipe(dev, port->bulk_in_endpointAddress),
 		      port->read_urb->transfer_buffer, port->read_urb->transfer_buffer_length,
@@ -1667,6 +1672,10 @@ static void ftdi_close (struct usb_seria
 			err("Error from RTS LOW urb");
 		}
 	} /* Note change no line if hupcl is off */
+
+	/* cancel any scheduled reading */
+	cancel_delayed_work(&priv->rx_work);
+	flush_scheduled_work();
 	
 	/* shutdown our bulk read */
 	if (port->read_urb)
@@ -1862,23 +1871,14 @@ static void ftdi_read_bulk_callback (str
 		return;
 	}
 
-	/* If throttled, delay receive processing until unthrottled. */
-	spin_lock(&priv->rx_lock);
-	if (priv->rx_flags & THROTTLED) {
-		dbg("Deferring read urb processing until unthrottled");
-		priv->rx_flags |= ACTUALLY_THROTTLED;
-		spin_unlock(&priv->rx_lock);
-		return;
-	}
-	spin_unlock(&priv->rx_lock);
-
 	ftdi_process_read(port);
 
 } /* ftdi_read_bulk_callback */
 
 
-static void ftdi_process_read (struct usb_serial_port *port)
+static void ftdi_process_read (void *param)
 { /* ftdi_process_read */
+	struct usb_serial_port *port = (struct usb_serial_port*)param;
 	struct urb *urb;
 	struct tty_struct *tty;
 	struct ftdi_private *priv;
@@ -1889,6 +1889,7 @@ static void ftdi_process_read (struct us
 	int result;
 	int need_flip;
 	int packet_offset;
+	unsigned long flags;
 
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
@@ -1915,12 +1916,18 @@ static void ftdi_process_read (struct us
 
 	data = urb->transfer_buffer;
 
-        /* The first two bytes of every read packet are status */
-	if (urb->actual_length > 2) {
-		usb_serial_debug_data(debug, &port->dev, __FUNCTION__, urb->actual_length, data);
+	if (priv->rx_processed) {
+		dbg("%s - already processed: %d bytes, %d remain", __FUNCTION__,
+				priv->rx_processed,
+				urb->actual_length - priv->rx_processed);
 	} else {
-                dbg("Status only: %03oo %03oo",data[0],data[1]);
-        }
+		/* The first two bytes of every read packet are status */
+		if (urb->actual_length > 2) {
+			usb_serial_debug_data(debug, &port->dev, __FUNCTION__, urb->actual_length, data);
+		} else {
+			dbg("Status only: %03oo %03oo",data[0],data[1]);
+		}
+	}
 
 
 	/* TO DO -- check for hung up line and handle appropriately: */
@@ -1929,8 +1936,12 @@ static void ftdi_process_read (struct us
 	/* if CD is dropped and the line is not CLOCAL then we should hangup */
 
 	need_flip = 0;
-	for (packet_offset=0; packet_offset < urb->actual_length; packet_offset += PKTSZ) {
+	for (packet_offset = priv->rx_processed; packet_offset < urb->actual_length; packet_offset += PKTSZ) {
+		int length;
+
 		/* Compare new line status to the old one, signal if different */
+		/* N.B. packet may be processed more than once, but differences
+		 * are only processed once.  */
 		if (priv != NULL) {
 			char new_status = data[packet_offset+0] & FTDI_STATUS_B0_MASK;
 			if (new_status != priv->prev_status) {
@@ -1940,6 +1951,35 @@ static void ftdi_process_read (struct us
 			}
 		}
 
+		length = min(PKTSZ, urb->actual_length-packet_offset)-2;
+		if (length < 0) {
+			err("%s - bad packet length: %d", __FUNCTION__, length+2);
+			length = 0;
+		}
+
+		/* have to make sure we don't overflow the buffer
+		   with tty_insert_flip_char's */
+		if (tty->flip.count+length > TTY_FLIPBUF_SIZE) {
+			tty_flip_buffer_push(tty);
+			need_flip = 0;
+
+			if (tty->flip.count != 0) {
+				/* flip didn't work, this happens when ftdi_process_read() is
+				 * called from ftdi_unthrottle, because TTY_DONT_FLIP is set */
+				dbg("%s - flip buffer push failed", __FUNCTION__);
+				break;
+			}
+		}
+		if (priv->rx_flags & THROTTLED) {
+			dbg("%s - throttled", __FUNCTION__);
+			break;
+		}
+		if (tty->ldisc.receive_room(tty)-tty->flip.count < length) {
+			/* break out & wait for throttling/unthrottling to happen */
+			dbg("%s - receive room low", __FUNCTION__);
+			break;
+		}
+
 		/* Handle errors and break */
 		error_flag = TTY_NORMAL;
 		/* Although the device uses a bitmask and hence can have multiple */
@@ -1962,13 +2002,8 @@ static void ftdi_process_read (struct us
 			error_flag = TTY_FRAME;
 			dbg("FRAMING error");
 		}
-		if (urb->actual_length > packet_offset + 2) {
-			for (i = 2; (i < PKTSZ) && ((i+packet_offset) < urb->actual_length); ++i) {
-				/* have to make sure we don't overflow the buffer
-				  with tty_insert_flip_char's */
-				if(tty->flip.count >= TTY_FLIPBUF_SIZE) {
-					tty_flip_buffer_push(tty);
-				}
+		if (length > 0) {
+			for (i = 2; i < length+2; i++) {
 				/* Note that the error flag is duplicated for 
 				   every character received since we don't know
 				   which character it applied to */
@@ -2005,6 +2040,35 @@ static void ftdi_process_read (struct us
 		tty_flip_buffer_push(tty);
 	}
 
+	if (packet_offset < urb->actual_length) {
+		/* not completely processed - record progress */
+		priv->rx_processed = packet_offset;
+		dbg("%s - incomplete, %d bytes processed, %d remain",
+				__FUNCTION__, packet_offset,
+				urb->actual_length - packet_offset);
+		/* check if we were throttled while processing */
+		spin_lock_irqsave(&priv->rx_lock, flags);
+		if (priv->rx_flags & THROTTLED) {
+			priv->rx_flags |= ACTUALLY_THROTTLED;
+			spin_unlock_irqrestore(&priv->rx_lock, flags);
+			dbg("%s - deferring remainder until unthrottled",
+					__FUNCTION__);
+			return;
+		}
+		spin_unlock_irqrestore(&priv->rx_lock, flags);
+		/* if the port is closed stop trying to read */
+		if (port->open_count > 0){
+			/* delay processing of remainder */
+			schedule_delayed_work(&priv->rx_work, 1);
+		} else {
+			dbg("%s - port is closed", __FUNCTION__);
+		}
+		return;
+	}
+
+	/* urb is completely processed */
+	priv->rx_processed = 0;
+
 	/* if the port is closed stop trying to read */
 	if (port->open_count > 0){
 		/* Continue trying to always read  */
@@ -2444,7 +2508,7 @@ static void ftdi_unthrottle (struct usb_
 	spin_unlock_irqrestore(&priv->rx_lock, flags);
 
 	if (actually_throttled)
-		ftdi_process_read(port);
+		schedule_work(&priv->rx_work);
 }
 
 static int __init ftdi_init (void)
abbotti@mev.co.uk
[PATCH] USB: ftdi_sio: avoid losing received data in tty-ldisc
[PATCH] USB: ftdi_sio: avoid losing received data in tty-ldisc

ftdi_sio: Avoid losing bytes at tty-ldisc.

This patch was originally developed by Daniel Smertnig.  I
(Ian Abbott) made a few changes.  It has been tested by both
Daniel and I, at least for raw, non-canonical receive data
processing.

Here is Daniel's original description of the patch:

===
During a project in which I was using a FTDI 232BM to
transmit data at relative high speeds (625kBit/s), I
noticed a problem where data was lost even if flow
control was enabled: The FTDI-Driver receives 512 Bytes
of data over USB at a time, which consists of 8 64-Byte
packets. Subtracting the 2 bytes of status information
included in each packet this gives 496 "real" data
bytes per read.

This data is passed (indirectly, via the flip buffers)
to the tty line discipline which takes care of
throttling when there the free buffer space reaches
TTY_THRESHOLD_THROTTLE (128). Because the FTDI driver
processes up to 496 bytes at a time, throttling won't
happen in time and the line discipline will discard the
remaining bytes.

To avoid this the patch passes data in 62-byte blocks
to the tty layer and checks the available space in the
ldisc-buffers. If there isn't enough free space,
processing the rest of the data is delayed using a
workqueue.

Note: The original problem should be easily
reproducible with a userspace program which does slow &
small reads.
===

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Daniel Smertnig <daniel.smertnig@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 76854ceac3ef3408ab9a50a2521147fb14779f58
tree 130700c6871e73269bfad0b9f0439d51e0c353a3
parent 9f793d2c77ec5818679e4747c554d9333cecf476
author Ian Abbott <abbotti@mev.co.uk> Thu, 02 Jun 2005 10:34:11 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 09 Jun 2005 01:38:15 -0700

 drivers/usb/serial/ftdi_sio.c |  118 ++++++++++++++++++++++++++++++++---------
 1 files changed, 91 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -264,7 +264,7 @@
 /*
  * Version Information
  */
-#define DRIVER_VERSION "v1.4.1"
+#define DRIVER_VERSION "v1.4.2"
 #define DRIVER_AUTHOR "Greg Kroah-Hartman <greg@kroah.com>, Bill Ryder <bryder@sgi.com>, Kuba Ober <kuba@mareimbrium.org>"
 #define DRIVER_DESC "USB FTDI Serial Converters Driver"
 
@@ -687,6 +687,8 @@ struct ftdi_private {
  	char prev_status, diff_status;        /* Used for TIOCMIWAIT */
 	__u8 rx_flags;		/* receive state flags (throttling) */
 	spinlock_t rx_lock;	/* spinlock for receive state */
+	struct work_struct rx_work;
+	int rx_processed;
 
 	__u16 interface;	/* FT2232C port interface (0 for FT232/245) */
 
@@ -717,7 +719,7 @@ static int  ftdi_write_room		(struct usb
 static int  ftdi_chars_in_buffer	(struct usb_serial_port *port);
 static void ftdi_write_bulk_callback	(struct urb *urb, struct pt_regs *regs);
 static void ftdi_read_bulk_callback	(struct urb *urb, struct pt_regs *regs);
-static void ftdi_process_read		(struct usb_serial_port *port);
+static void ftdi_process_read		(void *param);
 static void ftdi_set_termios		(struct usb_serial_port *port, struct termios * old);
 static int  ftdi_tiocmget               (struct usb_serial_port *port, struct file *file);
 static int  ftdi_tiocmset		(struct usb_serial_port *port, struct file * file, unsigned int set, unsigned int clear);
@@ -1387,6 +1389,8 @@ static int ftdi_common_startup (struct u
 		port->read_urb->transfer_buffer_length = BUFSZ;
 	}
 
+	INIT_WORK(&priv->rx_work, ftdi_process_read, port);
+
 	/* Free port's existing write urb and transfer buffer. */
 	if (port->write_urb) {
 		usb_free_urb (port->write_urb);
@@ -1617,6 +1621,7 @@ static int  ftdi_open (struct usb_serial
 	spin_unlock_irqrestore(&priv->rx_lock, flags);
 
 	/* Start reading from the device */
+	priv->rx_processed = 0;
 	usb_fill_bulk_urb(port->read_urb, dev,
 		      usb_rcvbulkpipe(dev, port->bulk_in_endpointAddress),
 		      port->read_urb->transfer_buffer, port->read_urb->transfer_buffer_length,
@@ -1667,6 +1672,10 @@ static void ftdi_close (struct usb_seria
 			err("Error from RTS LOW urb");
 		}
 	} /* Note change no line if hupcl is off */
+
+	/* cancel any scheduled reading */
+	cancel_delayed_work(&priv->rx_work);
+	flush_scheduled_work();
 	
 	/* shutdown our bulk read */
 	if (port->read_urb)
@@ -1862,23 +1871,14 @@ static void ftdi_read_bulk_callback (str
 		return;
 	}
 
-	/* If throttled, delay receive processing until unthrottled. */
-	spin_lock(&priv->rx_lock);
-	if (priv->rx_flags & THROTTLED) {
-		dbg("Deferring read urb processing until unthrottled");
-		priv->rx_flags |= ACTUALLY_THROTTLED;
-		spin_unlock(&priv->rx_lock);
-		return;
-	}
-	spin_unlock(&priv->rx_lock);
-
 	ftdi_process_read(port);
 
 } /* ftdi_read_bulk_callback */
 
 
-static void ftdi_process_read (struct usb_serial_port *port)
+static void ftdi_process_read (void *param)
 { /* ftdi_process_read */
+	struct usb_serial_port *port = (struct usb_serial_port*)param;
 	struct urb *urb;
 	struct tty_struct *tty;
 	struct ftdi_private *priv;
@@ -1889,6 +1889,7 @@ static void ftdi_process_read (struct us
 	int result;
 	int need_flip;
 	int packet_offset;
+	unsigned long flags;
 
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
@@ -1915,12 +1916,18 @@ static void ftdi_process_read (struct us
 
 	data = urb->transfer_buffer;
 
-        /* The first two bytes of every read packet are status */
-	if (urb->actual_length > 2) {
-		usb_serial_debug_data(debug, &port->dev, __FUNCTION__, urb->actual_length, data);
+	if (priv->rx_processed) {
+		dbg("%s - already processed: %d bytes, %d remain", __FUNCTION__,
+				priv->rx_processed,
+				urb->actual_length - priv->rx_processed);
 	} else {
-                dbg("Status only: %03oo %03oo",data[0],data[1]);
-        }
+		/* The first two bytes of every read packet are status */
+		if (urb->actual_length > 2) {
+			usb_serial_debug_data(debug, &port->dev, __FUNCTION__, urb->actual_length, data);
+		} else {
+			dbg("Status only: %03oo %03oo",data[0],data[1]);
+		}
+	}
 
 
 	/* TO DO -- check for hung up line and handle appropriately: */
@@ -1929,8 +1936,12 @@ static void ftdi_process_read (struct us
 	/* if CD is dropped and the line is not CLOCAL then we should hangup */
 
 	need_flip = 0;
-	for (packet_offset=0; packet_offset < urb->actual_length; packet_offset += PKTSZ) {
+	for (packet_offset = priv->rx_processed; packet_offset < urb->actual_length; packet_offset += PKTSZ) {
+		int length;
+
 		/* Compare new line status to the old one, signal if different */
+		/* N.B. packet may be processed more than once, but differences
+		 * are only processed once.  */
 		if (priv != NULL) {
 			char new_status = data[packet_offset+0] & FTDI_STATUS_B0_MASK;
 			if (new_status != priv->prev_status) {
@@ -1940,6 +1951,35 @@ static void ftdi_process_read (struct us
 			}
 		}
 
+		length = min(PKTSZ, urb->actual_length-packet_offset)-2;
+		if (length < 0) {
+			err("%s - bad packet length: %d", __FUNCTION__, length+2);
+			length = 0;
+		}
+
+		/* have to make sure we don't overflow the buffer
+		   with tty_insert_flip_char's */
+		if (tty->flip.count+length > TTY_FLIPBUF_SIZE) {
+			tty_flip_buffer_push(tty);
+			need_flip = 0;
+
+			if (tty->flip.count != 0) {
+				/* flip didn't work, this happens when ftdi_process_read() is
+				 * called from ftdi_unthrottle, because TTY_DONT_FLIP is set */
+				dbg("%s - flip buffer push failed", __FUNCTION__);
+				break;
+			}
+		}
+		if (priv->rx_flags & THROTTLED) {
+			dbg("%s - throttled", __FUNCTION__);
+			break;
+		}
+		if (tty->ldisc.receive_room(tty)-tty->flip.count < length) {
+			/* break out & wait for throttling/unthrottling to happen */
+			dbg("%s - receive room low", __FUNCTION__);
+			break;
+		}
+
 		/* Handle errors and break */
 		error_flag = TTY_NORMAL;
 		/* Although the device uses a bitmask and hence can have multiple */
@@ -1962,13 +2002,8 @@ static void ftdi_process_read (struct us
 			error_flag = TTY_FRAME;
 			dbg("FRAMING error");
 		}
-		if (urb->actual_length > packet_offset + 2) {
-			for (i = 2; (i < PKTSZ) && ((i+packet_offset) < urb->actual_length); ++i) {
-				/* have to make sure we don't overflow the buffer
-				  with tty_insert_flip_char's */
-				if(tty->flip.count >= TTY_FLIPBUF_SIZE) {
-					tty_flip_buffer_push(tty);
-				}
+		if (length > 0) {
+			for (i = 2; i < length+2; i++) {
 				/* Note that the error flag is duplicated for 
 				   every character received since we don't know
 				   which character it applied to */
@@ -2005,6 +2040,35 @@ static void ftdi_process_read (struct us
 		tty_flip_buffer_push(tty);
 	}
 
+	if (packet_offset < urb->actual_length) {
+		/* not completely processed - record progress */
+		priv->rx_processed = packet_offset;
+		dbg("%s - incomplete, %d bytes processed, %d remain",
+				__FUNCTION__, packet_offset,
+				urb->actual_length - packet_offset);
+		/* check if we were throttled while processing */
+		spin_lock_irqsave(&priv->rx_lock, flags);
+		if (priv->rx_flags & THROTTLED) {
+			priv->rx_flags |= ACTUALLY_THROTTLED;
+			spin_unlock_irqrestore(&priv->rx_lock, flags);
+			dbg("%s - deferring remainder until unthrottled",
+					__FUNCTION__);
+			return;
+		}
+		spin_unlock_irqrestore(&priv->rx_lock, flags);
+		/* if the port is closed stop trying to read */
+		if (port->open_count > 0){
+			/* delay processing of remainder */
+			schedule_delayed_work(&priv->rx_work, 1);
+		} else {
+			dbg("%s - port is closed", __FUNCTION__);
+		}
+		return;
+	}
+
+	/* urb is completely processed */
+	priv->rx_processed = 0;
+
 	/* if the port is closed stop trying to read */
 	if (port->open_count > 0){
 		/* Continue trying to always read  */
@@ -2444,7 +2508,7 @@ static void ftdi_unthrottle (struct usb_
 	spin_unlock_irqrestore(&priv->rx_lock, flags);
 
 	if (actually_throttled)
-		ftdi_process_read(port);
+		schedule_work(&priv->rx_work);
 }
 
 static int __init ftdi_init (void)

