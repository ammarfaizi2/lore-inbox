Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932066AbWFDTs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWFDTs5 (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 15:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWFDTs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 15:48:56 -0400
Received: from wx-out-0102.google.com ([66.249.82.201]:2889 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932066AbWFDTsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 15:48:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MyZwbFKDtVNHp8uIs9FfqCw4GLREpGKoSxvEVO79tl68t0bPNKv4bu1t9G2IwqCpsjrpXOLuZ3WTA5rzqYqgRHbLZXZWs159o6euP9h2ToIh0w5RXLhYr5JZe9r/5N5PXTBv1GpVfQrbeFvMHiiC4HLHY/T+8p5PPJHotVSXRzo=
Message-ID: <1925ef8a0606041248i56b99f5s5fb93c6d92a6a9fc@mail.gmail.com>
Date: Sun, 4 Jun 2006 23:48:54 +0400
From: "Vitja Makarov" <vitja.makarov@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: [PATCH] ftdi_sio patch
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've found that ftdi_sio driver have problems it could ran out of memory,
or lead kernel panic. The problem is in ftdi_write function, it
allocates new urb structure each time write() is called.

The following patch fixes this problems. Code is mostly based on pl2303 code.
I moved buffer code into separate file serial-buf.h as it could be
userful for other drivers.

Signed-off-by: Vitja Makarov <vitja.makarov@gmail.com>

vitja.

diff -uprN orig/drivers/usb/serial/ftdi_sio.c new/drivers/usb/serial/ftdi_sio.c
--- orig/drivers/usb/serial/ftdi_sio.c	2006-03-28 01:05:57.000000000 +0400
+++ new/drivers/usb/serial/ftdi_sio.c	2006-05-28 23:58:50.000000000 +0400
@@ -260,6 +260,7 @@
 #include <linux/serial.h>
 #include "usb-serial.h"
 #include "ftdi_sio.h"
+#include "serial-buf.h"

 /*
  * Version Information
@@ -268,6 +269,8 @@
 #define DRIVER_AUTHOR "Greg Kroah-Hartman <greg@kroah.com>, Bill
Ryder <bryder@sgi.com>, Kuba Ober <kuba@mareimbrium.org>"
 #define DRIVER_DESC "USB FTDI Serial Converters Driver"

+#define MIN(a,b) ((a)>(b)?(b):(a))
+
 static int debug;
 static __u16 vendor = FTDI_VID;
 static __u16 product;
@@ -545,6 +548,11 @@ struct ftdi_private {

 	int force_baud;		/* if non-zero, force the baud rate to this value */
 	int force_rtscts;	/* if non-zero, force RTS-CTS to always be enabled */
+
+	spinlock_t lock;		   /* private lock */
+	
+	struct serial_buf *buf; /* write buffer */
+	int write_urb_in_use;   /* write urb in use indicator */
 };

 /* Used for TIOCMIWAIT */
@@ -562,6 +570,7 @@ static void ftdi_shutdown		(struct usb_s
 static int  ftdi_open			(struct usb_serial_port *port, struct file *filp);
 static void ftdi_close			(struct usb_serial_port *port, struct file *filp);
 static int  ftdi_write			(struct usb_serial_port *port, const
unsigned char *buf, int count);
+static void ftdi_send                   (struct usb_serial_port *port);
 static int  ftdi_write_room		(struct usb_serial_port *port);
 static int  ftdi_chars_in_buffer	(struct usb_serial_port *port);
 static void ftdi_write_bulk_callback	(struct urb *urb, struct pt_regs *regs);
@@ -1066,6 +1075,8 @@ static ssize_t store_event_char(struct d
 			     v, priv->interface,
 			     buf, 0, WDR_TIMEOUT);
 	
+	
+	
 	if (rv < 0) {
 		dbg("Unable to write event character: %i", rv);
 		return -EIO;
@@ -1138,6 +1149,7 @@ static int ftdi_sio_attach (struct usb_s
 	struct usb_serial_port *port = serial->port[0];
 	struct ftdi_private *priv;
 	struct ftdi_sio_quirk *quirk;
+	unsigned char *transfer_buffer;
 	
 	dbg("%s",__FUNCTION__);

@@ -1147,6 +1159,7 @@ static int ftdi_sio_attach (struct usb_s
 		return -ENOMEM;
 	}
 	memset(priv, 0, sizeof(*priv));
+	spin_lock_init(&priv->lock);

 	spin_lock_init(&priv->rx_lock);
         init_waitqueue_head(&priv->delta_msr_wait);
@@ -1167,14 +1180,22 @@ static int ftdi_sio_attach (struct usb_s
 	}

 	INIT_WORK(&priv->rx_work, ftdi_process_read, port);
+
+	/* Try to increase the size of write buffer */
+	transfer_buffer = (unsigned char *) kmalloc(SERIAL_BUF_SIZE, GFP_KERNEL);
+
+	if (transfer_buffer) {
+                port->write_urb->transfer_buffer = transfer_buffer;
+                port->write_urb->transfer_buffer_length = SERIAL_BUF_SIZE;
+	}

 	/* Free port's existing write urb and transfer buffer. */
-	if (port->write_urb) {
-		usb_free_urb (port->write_urb);
-		port->write_urb = NULL;
+	priv->buf = serial_buf_alloc(SERIAL_BUF_SIZE);
+	if (priv->buf == NULL) {
+		kfree(port->bulk_in_buffer);
+		kfree(priv);
+		return -ENOMEM;
 	}
-	kfree(port->bulk_out_buffer);
-	port->bulk_out_buffer = NULL;

 	usb_set_serial_port_data(serial->port[0], priv);

@@ -1246,6 +1267,7 @@ static void ftdi_shutdown (struct usb_se
 	 */

 	if (priv) {
+		serial_buf_free(priv->buf);
 		usb_set_serial_port_data(port, NULL);
 		kfree(priv);
 	}
@@ -1345,128 +1367,137 @@ static void ftdi_close (struct usb_seria
 	/* shutdown our bulk read */
 	if (port->read_urb)
 		usb_kill_urb(port->read_urb);
+
+	/* shutdown our bulk write */
+	if (port->write_urb)	
+	    usb_kill_urb(port->write_urb);
+
 } /* ftdi_close */

+static int ftdi_write(struct usb_serial_port *port, const unsigned
char *buf, int count)
+{
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	unsigned long flags;
+	
+	dbg("%s - port %d, %d bytes", __FUNCTION__, port->number, count);

-
-/* The SIO requires the first byte to have:
- *  B0 1
- *  B1 0
- *  B2..7 length of message excluding byte 0
- *
- * The new devices do not require this byte
- */
-static int ftdi_write (struct usb_serial_port *port,
-			   const unsigned char *buf, int count)
-{ /* ftdi_write */
+	if (!count)
+		return count;
+	
+	spin_lock_irqsave(&priv->lock, flags);
+	count = serial_buf_put(priv->buf, buf, count);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	ftdi_send(port);
+
+	return count;
+} /* ftdi_write */
+
+
+static void ftdi_send(struct usb_serial_port *port)
+{
+	int count, result;
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
-	struct urb *urb;
-	unsigned char *buffer;
+	unsigned long flags;
 	int data_offset ;       /* will be 1 for the SIO and 0 otherwise */
-	int status;
-	int transfer_size;

-	dbg("%s port %d, %d bytes", __FUNCTION__, port->number, count);
+	dbg("%s - port %d", __FUNCTION__, port->number);
+
+	spin_lock_irqsave(&priv->lock, flags);

-	if (count == 0) {
-		dbg("write request of 0 bytes");
-		return 0;
+	if (priv->write_urb_in_use) {
+		spin_unlock_irqrestore(&priv->lock, flags);
+		return;
 	}
-	
+
 	data_offset = priv->write_offset;
         dbg("data_offset set to %d",data_offset);

-	/* Determine total transfer size */
-	transfer_size = count;
-	if (data_offset > 0) {
-		/* Original sio needs control bytes too... */
-		transfer_size += (data_offset *
-				((count + (PKTSZ - 1 - data_offset)) /
-				 (PKTSZ - data_offset)));
-	}

-	buffer = kmalloc (transfer_size, GFP_ATOMIC);
-	if (!buffer) {
-		err("%s ran out of kernel memory for urb ...", __FUNCTION__);
-		return -ENOMEM;
+        if (data_offset > 0) {
+                int len = port->bulk_out_size;
+		unsigned char *first_byte = port->write_urb->transfer_buffer;
+
+                count = 0;
+
+                while (serial_buf_data_avail(priv->buf) && len > 1) {
+                        int toget = MIN(len - data_offset, PKTSZ -
data_offset);
+                        int cnt;
+
+        	        cnt = serial_buf_get(priv->buf, first_byte + data_offset,
+		                                toget);
+                        *first_byte |= 1 | (cnt << 2);
+                        first_byte += cnt + data_offset;
+                        len -= cnt + data_offset;
+                        count += cnt + data_offset;
+                }
+        } else {
+	        count = serial_buf_get(priv->buf, port->write_urb->transfer_buffer,
+		                            port->bulk_out_size);
 	}

-	urb = usb_alloc_urb(0, GFP_ATOMIC);
-	if (!urb) {
-		err("%s - no more free urbs", __FUNCTION__);
-		kfree (buffer);
-		return -ENOMEM;
+	if (count == 0) {
+		spin_unlock_irqrestore(&priv->lock, flags);
+		return;
 	}

-	/* Copy data */
-	if (data_offset > 0) {
-		/* Original sio requires control byte at start of each packet. */
-		int user_pktsz = PKTSZ - data_offset;
-		int todo = count;
-		unsigned char *first_byte = buffer;
-		const unsigned char *current_position = buf;
-
-		while (todo > 0) {
-			if (user_pktsz > todo) {
-				user_pktsz = todo;
-			}
-			/* Write the control byte at the front of the packet*/
-			*first_byte = 1 | ((user_pktsz) << 2);
-			/* Copy data for packet */
-			memcpy (first_byte + data_offset,
-				current_position, user_pktsz);
-			first_byte += user_pktsz + data_offset;
-			current_position += user_pktsz;
-			todo -= user_pktsz;
-		}
-	} else {
-		/* No control byte required. */
-		/* Copy in the data to send */
-		memcpy (buffer, buf, count);
-	}
+	priv->write_urb_in_use = 1;

-	usb_serial_debug_data(debug, &port->dev, __FUNCTION__, transfer_size, buffer);
+	spin_unlock_irqrestore(&priv->lock, flags);

-	/* fill the buffer and send it */
-	usb_fill_bulk_urb(urb, port->serial->dev,
-		      usb_sndbulkpipe(port->serial->dev, port->bulk_out_endpointAddress),
-		      buffer, transfer_size,
-		      ftdi_write_bulk_callback, port);
+	usb_serial_debug_data(debug, &port->dev, __FUNCTION__, count,
port->write_urb->transfer_buffer);

-	status = usb_submit_urb(urb, GFP_ATOMIC);
-	if (status) {
-		err("%s - failed submitting write urb, error %d", __FUNCTION__, status);
-		count = status;
-		kfree (buffer);
+	port->write_urb->transfer_buffer_length = count;
+	port->write_urb->dev = port->serial->dev;
+	result = usb_submit_urb (port->write_urb, GFP_ATOMIC);
+	if (result) {
+		dev_err(&port->dev, "%s - failed submitting write urb, error %d\n",
__FUNCTION__, result);
+		priv->write_urb_in_use = 0;
+		// TODO: reschedule pl2303_send
 	}

-	/* we are done with this urb, so let the host driver
-	 * really free it when it is finished with it */
-	usb_free_urb (urb);
-
-	dbg("%s write returning: %d", __FUNCTION__, count);
-	return count;
-} /* ftdi_write */
-
+	schedule_work(&port->work);
+}

-/* This function may get called when the device is closed */

 static void ftdi_write_bulk_callback (struct urb *urb, struct pt_regs *regs)
 {
-	struct usb_serial_port *port = (struct usb_serial_port *)urb->context;
-
-	/* free up the transfer buffer, as usb_free_urb() does not do this */
-	kfree (urb->transfer_buffer);
+	struct usb_serial_port *port = (struct usb_serial_port *) urb->context;
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	int result;

 	dbg("%s - port %d", __FUNCTION__, port->number);
-	
-	if (urb->status) {
-		dbg("nonzero write bulk status received: %d", urb->status);
+
+	switch (urb->status) {
+	case 0:
+		/* success */
+		break;
+	case -ECONNRESET:
+	case -ENOENT:
+	case -ESHUTDOWN:
+		/* this urb is terminated, clean up */
+		dbg("%s - urb shutting down with status: %d", __FUNCTION__, urb->status);
+		priv->write_urb_in_use = 0;
 		return;
+	default:
+		/* error in the urb, so we have to resubmit it */
+		dbg("%s - Overflow in write", __FUNCTION__);
+		dbg("%s - nonzero write bulk status received: %d", __FUNCTION__,
urb->status);
+		port->write_urb->transfer_buffer_length = 1;
+		port->write_urb->dev = port->serial->dev;
+		result = usb_submit_urb (port->write_urb, GFP_ATOMIC);
+		if (result)
+			dev_err(&urb->dev->dev, "%s - failed resubmitting write urb, error
%d\n", __FUNCTION__, result);
+		else
+			return;
 	}

-	schedule_work(&port->work);
-} /* ftdi_write_bulk_callback */
+	priv->write_urb_in_use = 0;
+
+	/* send any buffered data */
+	ftdi_send(port);
+}
+


 static int ftdi_write_room( struct usb_serial_port *port )
diff -uprN orig/drivers/usb/serial/serial-buf.h
new/drivers/usb/serial/serial-buf.h
--- orig/drivers/usb/serial/serial-buf.h	1970-01-01 03:00:00.000000000 +0300
+++ new/drivers/usb/serial/serial-buf.h	2006-05-28 23:58:50.000000000 +0400
@@ -0,0 +1,211 @@
+#ifndef __LINUX_USB_SERIAL_BUF_H
+#define __LINUX_USB_SERIAL_BUF_H
+
+/*****************************************************************************
+ * Write buffer functions - buffering code from pl2303 used
+ *****************************************************************************/
+
+#ifndef SERIAL_BUF_SIZE
+# define SERIAL_BUF_SIZE		1024
+#endif
+
+struct serial_buf {
+	unsigned int	buf_size;
+	char		*buf_buf;
+	char		*buf_get;
+	char		*buf_put;
+};
+
+/* write buffer functions */
+static struct serial_buf *serial_buf_alloc(unsigned int size);
+static void 		  serial_buf_free(struct serial_buf *cb);
+static void		  serial_buf_clear(struct serial_buf *cb);
+static unsigned int	  serial_buf_data_avail(struct serial_buf *cb);
+static unsigned int	  serial_buf_space_avail(struct serial_buf *cb);
+static unsigned int	  serial_buf_put(struct serial_buf *cb, const
char *buf, unsigned int count);
+static unsigned int	  serial_buf_get(struct serial_buf *cb, char
*buf, unsigned int count);
+
+
+
+/*
+ * serial_buf_alloc
+ *
+ * Allocate a circular buffer and all associated memory.
+ */
+
+static inline struct serial_buf *serial_buf_alloc(unsigned int size)
+{
+
+	struct serial_buf *cb;
+
+
+	if (size == 0)
+		return NULL;
+
+	cb = (struct serial_buf *)kmalloc(sizeof(struct serial_buf), GFP_KERNEL);
+	if (cb == NULL)
+		return NULL;
+
+	cb->buf_buf = kmalloc(size, GFP_KERNEL);
+	if (cb->buf_buf == NULL) {
+		kfree(cb);
+		return NULL;
+	}
+
+	cb->buf_size = size;
+	cb->buf_get = cb->buf_put = cb->buf_buf;
+
+	return cb;
+
+}
+
+
+/*
+ * serial_buf_free
+ *
+ * Free the buffer and all associated memory.
+ */
+
+static inline void serial_buf_free(struct serial_buf *cb)
+{
+	if (cb) {
+		kfree(cb->buf_buf);
+		kfree(cb);
+	}
+}
+
+
+/*
+ * serial_buf_clear
+ *
+ * Clear out all data in the circular buffer.
+ */
+
+static inline void serial_buf_clear(struct serial_buf *cb)
+{
+	if (cb != NULL)
+		cb->buf_get = cb->buf_put;
+		/* equivalent to a get of all data available */
+}
+
+
+/*
+ * serial_buf_data_avail
+ *
+ * Return the number of bytes of data available in the circular
+ * buffer.
+ */
+
+static inline unsigned int serial_buf_data_avail(struct serial_buf *cb)
+{
+	if (cb != NULL)
+		return ((cb->buf_size + cb->buf_put - cb->buf_get) % cb->buf_size);
+	else
+		return 0;
+}
+
+
+/*
+ * serial_buf_space_avail
+ *
+ * Return the number of bytes of space available in the circular
+ * buffer.
+ */
+
+static inline unsigned int serial_buf_space_avail(struct serial_buf *cb)
+{
+	if (cb != NULL)
+		return ((cb->buf_size + cb->buf_get - cb->buf_put - 1) % cb->buf_size);
+	else
+		return 0;
+}
+
+
+/*
+ * serial_buf_put
+ *
+ * Copy data data from a user buffer and put it into the circular buffer.
+ * Restrict to the amount of space available.
+ *
+ * Return the number of bytes copied.
+ */
+
+static inline unsigned int serial_buf_put(struct serial_buf *cb,
const char *buf,
+	unsigned int count)
+{
+
+	unsigned int len;
+
+
+	if (cb == NULL)
+		return 0;
+
+	len  = serial_buf_space_avail(cb);
+	if (count > len)
+		count = len;
+
+	if (count == 0)
+		return 0;
+
+	len = cb->buf_buf + cb->buf_size - cb->buf_put;
+	if (count > len) {
+		memcpy(cb->buf_put, buf, len);
+		memcpy(cb->buf_buf, buf+len, count - len);
+		cb->buf_put = cb->buf_buf + count - len;
+	} else {
+		memcpy(cb->buf_put, buf, count);
+		if (count < len)
+			cb->buf_put += count;
+		else /* count == len */
+			cb->buf_put = cb->buf_buf;
+	}
+
+	return count;
+
+}
+
+
+/*
+ * serial_buf_get
+ *
+ * Get data from the circular buffer and copy to the given buffer.
+ * Restrict to the amount of data available.
+ *
+ * Return the number of bytes copied.
+ */
+
+static inline unsigned int serial_buf_get(struct serial_buf *cb, char *buf,
+	unsigned int count)
+{
+
+	unsigned int len;
+
+
+	if (cb == NULL)
+		return 0;
+
+	len = serial_buf_data_avail(cb);
+	if (count > len)
+		count = len;
+
+	if (count == 0)
+		return 0;
+
+	len = cb->buf_buf + cb->buf_size - cb->buf_get;
+	if (count > len) {
+		memcpy(buf, cb->buf_get, len);
+		memcpy(buf+len, cb->buf_buf, count - len);
+		cb->buf_get = cb->buf_buf + count - len;
+	} else {
+		memcpy(buf, cb->buf_get, count);
+		if (count < len)
+			cb->buf_get += count;
+		else /* count == len */
+			cb->buf_get = cb->buf_buf;
+	}
+
+	return count;
+
+}
+
+#endif /* ifdef __LINUX_USB_SERIAL_BUF_H */
