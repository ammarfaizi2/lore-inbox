Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbVAHIik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbVAHIik (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 03:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVAHIea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 03:34:30 -0500
Received: from mail.kroah.org ([69.55.234.183]:5254 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261909AbVAHFsj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:39 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632644078@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:45 -0800
Message-Id: <11051632652829@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.12, 2004/12/15 16:01:46-08:00, eolson@MIT.EDU

[PATCH] ftdi_sio: Add sysfs attributes for event character and latency

Setting the event character and latency timer can greatly improve
performance for some applications which use the ftdi_sio module (a
serial->USB converter). The following patch adds sysfs attributes,
exposing these configuration registers.

Signed-off-by: Edwin Olson (eolson@mit.edu)
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/serial/ftdi_sio.c |  133 ++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/serial/ftdi_sio.h |   51 ++++++++++++++++
 2 files changed, 184 insertions(+)


diff -Nru a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
--- a/drivers/usb/serial/ftdi_sio.c	2005-01-07 15:50:00 -08:00
+++ b/drivers/usb/serial/ftdi_sio.c	2005-01-07 15:50:00 -08:00
@@ -1174,6 +1174,135 @@
 
 } /* set_serial_info */
 
+
+/*
+ * ***************************************************************************
+ * Sysfs Attribute
+ * ***************************************************************************
+ */
+
+ssize_t show_latency_timer(struct device *dev, char *buf)
+{
+	struct usb_serial_port *port = to_usb_serial_port(dev);
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	struct usb_device *udev;
+	unsigned short latency = 0;
+	int rv = 0;
+	
+	udev = to_usb_device(dev);
+	
+	dbg("%s",__FUNCTION__);
+	
+	rv = usb_control_msg(udev,
+			     usb_rcvctrlpipe(udev, 0),
+			     FTDI_SIO_GET_LATENCY_TIMER_REQUEST,
+			     FTDI_SIO_GET_LATENCY_TIMER_REQUEST_TYPE,
+			     0, priv->interface, 
+			     (char*) &latency, 1, WDR_TIMEOUT);
+	
+	if (rv < 0) {
+		dev_err(dev, "Unable to read latency timer: %i", rv);
+		return -EIO;
+	}
+	return sprintf(buf, "%i\n", latency);
+}
+
+/* Write a new value of the latency timer, in units of milliseconds. */
+ssize_t store_latency_timer(struct device *dev, const char *valbuf, size_t count)
+{
+	struct usb_serial_port *port = to_usb_serial_port(dev);
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	struct usb_device *udev;
+	char buf[1];
+	int v = simple_strtoul(valbuf, NULL, 10);
+	int rv = 0;
+	
+	udev = to_usb_device(dev);
+	
+	dbg("%s: setting latency timer = %i", __FUNCTION__, v);
+	
+	rv = usb_control_msg(udev,
+			     usb_sndctrlpipe(udev, 0),
+			     FTDI_SIO_SET_LATENCY_TIMER_REQUEST,
+			     FTDI_SIO_SET_LATENCY_TIMER_REQUEST_TYPE,
+			     v, priv->interface, 
+			     buf, 0, WDR_TIMEOUT);
+	
+	if (rv < 0) {
+		dev_err(dev, "Unable to write latency timer: %i", rv);
+		return -EIO;
+	}
+	
+	return count;
+}
+
+/* Write an event character directly to the FTDI register.  The ASCII
+   value is in the low 8 bits, with the enable bit in the 9th bit. */
+ssize_t store_event_char(struct device *dev, const char *valbuf, size_t count)
+{
+	struct usb_serial_port *port = to_usb_serial_port(dev);
+	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	struct usb_device *udev;
+	char buf[1];
+	int v = simple_strtoul(valbuf, NULL, 10);
+	int rv = 0;
+	
+	udev = to_usb_device(dev);
+	
+	dbg("%s: setting event char = %i", __FUNCTION__, v);
+	
+	rv = usb_control_msg(udev,
+			     usb_sndctrlpipe(udev, 0),
+			     FTDI_SIO_SET_EVENT_CHAR_REQUEST,
+			     FTDI_SIO_SET_EVENT_CHAR_REQUEST_TYPE,
+			     v, priv->interface, 
+			     buf, 0, WDR_TIMEOUT);
+	
+	if (rv < 0) {
+		dbg("Unable to write event character: %i", rv);
+		return -EIO;
+	}
+	
+	return count;
+}
+
+static DEVICE_ATTR(latency_timer, S_IWUGO | S_IRUGO, show_latency_timer, store_latency_timer);
+static DEVICE_ATTR(event_char, S_IWUGO, NULL, store_event_char);
+
+void create_sysfs_attrs(struct usb_serial *serial)
+{	
+	struct ftdi_private *priv;
+	struct usb_device *udev;
+
+	dbg("%s",__FUNCTION__);
+	
+	priv = usb_get_serial_port_data(serial->port[0]);
+	udev = serial->dev;
+	
+	if (priv->chip_type == FT232BM) {
+		dbg("sysfs attributes for FT232BM");
+		device_create_file(&udev->dev, &dev_attr_event_char);
+		device_create_file(&udev->dev, &dev_attr_latency_timer);
+	}
+}
+
+void remove_sysfs_attrs(struct usb_serial *serial)
+{
+	struct ftdi_private *priv;
+	struct usb_device *udev;
+
+	dbg("%s",__FUNCTION__);	
+
+	priv = usb_get_serial_port_data(serial->port[0]);
+	udev = serial->dev;
+	
+	if (priv->chip_type == FT232BM) {
+		device_remove_file(&udev->dev, &dev_attr_event_char);
+		device_remove_file(&udev->dev, &dev_attr_latency_timer);
+	}
+	
+}
+
 /*
  * ***************************************************************************
  * FTDI driver specific functions
@@ -1291,6 +1420,8 @@
 	priv->chip_type = FT232BM;
 	priv->baud_base = 48000000 / 2; /* Would be / 16, but FT232BM supports multiple of 0.125 divisor fractions! */
 	
+	create_sysfs_attrs(serial);
+
 	return (0);
 } /* ftdi_FT232BM_startup */
 
@@ -1384,6 +1515,8 @@
 
 	dbg("%s", __FUNCTION__);
 
+	remove_sysfs_attrs(serial);
+	
 	/* all open ports are closed at this point 
          *    (by usbserial.c:__serial_close, which calls ftdi_close)  
 	 */
diff -Nru a/drivers/usb/serial/ftdi_sio.h b/drivers/usb/serial/ftdi_sio.h
--- a/drivers/usb/serial/ftdi_sio.h	2005-01-07 15:50:00 -08:00
+++ b/drivers/usb/serial/ftdi_sio.h	2005-01-07 15:50:00 -08:00
@@ -249,6 +249,8 @@
 #define FTDI_SIO_GET_MODEM_STATUS	5 /* Retrieve current value of modern status register */
 #define FTDI_SIO_SET_EVENT_CHAR	6 /* Set the event character */
 #define FTDI_SIO_SET_ERROR_CHAR	7 /* Set the error character */
+#define FTDI_SIO_SET_LATENCY_TIMER	9 /* Set the latency timer */
+#define FTDI_SIO_GET_LATENCY_TIMER	10 /* Get the latency timer */
 
 /* Port interface code for FT2232C */
 #define INTERFACE_A		1
@@ -502,6 +504,55 @@
  * and the lValue field contains the XON character.
  */  
  
+/*
+ * FTDI_SIO_GET_LATENCY_TIMER
+ *
+ * Set the timeout interval. The FTDI collects data from the slave
+ * device, transmitting it to the host when either A) 62 bytes are
+ * received, or B) the timeout interval has elapsed and the buffer
+ * contains at least 1 byte.  Setting this value to a small number
+ * can dramatically improve performance for applications which send
+ * small packets, since the default value is 16ms.
+ */
+#define  FTDI_SIO_GET_LATENCY_TIMER_REQUEST FTDI_SIO_GET_LATENCY_TIMER
+#define  FTDI_SIO_GET_LATENCY_TIMER_REQUEST_TYPE 0xC0
+
+/* 
+ *  BmRequestType:   1100 0000b
+ *  bRequest:        FTDI_SIO_GET_LATENCY_TIMER
+ *  wValue:          0
+ *  wIndex:          Port
+ *  wLength:         0
+ *  Data:            latency (on return)
+ */
+
+/* 
+ * FTDI_SIO_SET_LATENCY_TIMER
+ *
+ * Set the timeout interval. The FTDI collects data from the slave
+ * device, transmitting it to the host when either A) 62 bytes are
+ * received, or B) the timeout interval has elapsed and the buffer
+ * contains at least 1 byte.  Setting this value to a small number
+ * can dramatically improve performance for applications which send
+ * small packets, since the default value is 16ms.
+ */
+#define  FTDI_SIO_SET_LATENCY_TIMER_REQUEST FTDI_SIO_SET_LATENCY_TIMER
+#define  FTDI_SIO_SET_LATENCY_TIMER_REQUEST_TYPE 0x40
+
+/* 
+ *  BmRequestType:   0100 0000b
+ *  bRequest:        FTDI_SIO_SET_LATENCY_TIMER
+ *  wValue:          Latency (milliseconds)
+ *  wIndex:          Port
+ *  wLength:         0
+ *  Data:            None
+ *
+ * wValue:
+ *   B0..7   Latency timer
+ *   B8..15  0
+ *
+ */
+
 /*
  * FTDI_SIO_SET_EVENT_CHAR 
  *

