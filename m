Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265283AbUETXJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265283AbUETXJP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 19:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265292AbUETXJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 19:09:15 -0400
Received: from [141.156.69.115] ([141.156.69.115]:25252 "EHLO
	mail.infosciences.com") by vger.kernel.org with ESMTP
	id S265283AbUETXI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 19:08:56 -0400
Message-ID: <40AD3A88.2000002@infosciences.com>
Date: Thu, 20 May 2004 19:08:56 -0400
From: nardelli <jnardelli@infosciences.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] visor: Fix Oops on disconnect
Content-Type: multipart/mixed;
 boundary="------------080300050207050505090000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080300050207050505090000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here is a proposed patch for Oops on disconnect in the visor module.
For details of the problem, please see
http://bugzilla.kernel.org/show_bug.cgi?id=2289

I would really appreciate it if anyone that uses this module could please
try this patch to make sure that it works as intended.  Also, as this is
the first patch that I've submitted, please feel free to be brutally
honest regarding content, formatting, etc.



-- 
Joe Nardelli
jnardelli@infosciences.com

--------------080300050207050505090000
Content-Type: text/plain;
 name="patch.treo"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.treo"

--- old/linux-2.6.6/drivers/usb/serial/visor.c	2004-05-09 22:32:27.000000000 -0400
+++ new/linux-2.6.6/drivers/usb/serial/visor.c	2004-05-20 18:04:24.000000000 -0400
@@ -12,6 +12,13 @@
  *
  * See Documentation/usb/usb-serial.txt for more information on using this driver
  *
+ * (5/20/2004) Joe Nardelli
+ *	Reduced possibility for unitialized data access in palm_os_3_probe.
+ *	Modified workaround for treo endpoint setup in treo_attach.
+ *	Removed assumptions that port->read_urb was always valid (is not true
+ *	for usb serial devices with more bulk out or interrupt endpoints than
+ *	bulk in endpoints).
+ *
  * (06/03/2003) Judd Montgomery <judd at jpilot.org>
  *     Added support for module parameter options for untested/unknown
  *     devices.
@@ -398,7 +405,8 @@
 	
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
-	if (!port->read_urb) {
+	if ((serial->dev->descriptor.idVendor != SONY_VENDOR_ID && !port->read_urb))
+	{
 		/* this is needed for some brain dead Sony devices */
 		dev_err(&port->dev, "Device lied about number of ports, please use a lower one.\n");
 		return -ENODEV;
@@ -416,17 +424,19 @@
 		port->tty->low_latency = 1;
 
 	/* Start reading from the device */
-	usb_fill_bulk_urb (port->read_urb, serial->dev,
-			   usb_rcvbulkpipe (serial->dev, 
-					    port->bulk_in_endpointAddress),
-			   port->read_urb->transfer_buffer,
-			   port->read_urb->transfer_buffer_length,
-			   visor_read_bulk_callback, port);
-	result = usb_submit_urb(port->read_urb, GFP_KERNEL);
-	if (result) {
-		dev_err(&port->dev, "%s - failed submitting read urb, error %d\n",
-			__FUNCTION__, result);
-		goto exit;
+	if (port->read_urb) {
+		usb_fill_bulk_urb (port->read_urb, serial->dev,
+			usb_rcvbulkpipe (serial->dev, 
+				port->bulk_in_endpointAddress),
+			port->read_urb->transfer_buffer,
+			port->read_urb->transfer_buffer_length,
+			visor_read_bulk_callback, port);
+		result = usb_submit_urb(port->read_urb, GFP_KERNEL);
+		if (result) {
+			dev_err(&port->dev, "%s - failed submitting read urb, error %d\n",
+				__FUNCTION__, result);
+			goto exit;
+		}
 	}
 	
 	if (port->interrupt_in_urb) {
@@ -456,7 +466,8 @@
 		return;
 	
 	/* shutdown our urbs */
-	usb_unlink_urb (port->read_urb);
+	if (port->read_urb)
+		usb_unlink_urb (port->read_urb);
 	if (port->interrupt_in_urb)
 		usb_unlink_urb (port->interrupt_in_urb);
 
@@ -622,15 +633,18 @@
 	bytes_in += urb->actual_length;
 
 	/* Continue trying to always read  */
-	usb_fill_bulk_urb (port->read_urb, serial->dev,
-			   usb_rcvbulkpipe (serial->dev,
-					    port->bulk_in_endpointAddress),
-			   port->read_urb->transfer_buffer,
-			   port->read_urb->transfer_buffer_length,
-			   visor_read_bulk_callback, port);
-	result = usb_submit_urb(port->read_urb, GFP_ATOMIC);
-	if (result)
-		dev_err(&port->dev, "%s - failed resubmitting read urb, error %d\n", __FUNCTION__, result);
+	if (port->read_urb) {
+		usb_fill_bulk_urb (port->read_urb, serial->dev,
+			usb_rcvbulkpipe (serial->dev,
+			port->bulk_in_endpointAddress),
+			port->read_urb->transfer_buffer,
+			port->read_urb->transfer_buffer_length,
+			visor_read_bulk_callback, port);
+		result = usb_submit_urb(port->read_urb, GFP_ATOMIC);
+		if (result)
+			dev_err(&port->dev, "%s - failed resubmitting read urb, error %d\n", __FUNCTION__, result);
+	}
+  
 	return;
 }
 
@@ -675,7 +689,9 @@
 static void visor_throttle (struct usb_serial_port *port)
 {
 	dbg("%s - port %d", __FUNCTION__, port->number);
-	usb_unlink_urb (port->read_urb);
+	if (port->read_urb) {
+		usb_unlink_urb (port->read_urb);
+	}
 }
 
 
@@ -685,10 +701,12 @@
 
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
-	port->read_urb->dev = port->serial->dev;
-	result = usb_submit_urb(port->read_urb, GFP_ATOMIC);
-	if (result)
-		dev_err(&port->dev, "%s - failed submitting read urb, error %d\n", __FUNCTION__, result);
+	if (port->read_urb) {
+		port->read_urb->dev = port->serial->dev;
+		result = usb_submit_urb(port->read_urb, GFP_ATOMIC);
+		if (result)
+			dev_err(&port->dev, "%s - failed submitting read urb, error %d\n", __FUNCTION__, result);
+	}
 }
 
 static int palm_os_3_probe (struct usb_serial *serial, const struct usb_device_id *id)
@@ -710,6 +728,13 @@
 		return -ENOMEM;
 	}
 
+	/*
+	* We don't know how much data gets written into transfer_buffer, so let's
+	* at least set it all to 0 to avoid putting random data into num_ports
+	* (which causes unitialized, and possibly unallocated data to be accessed)
+	*/
+	memset (transfer_buffer, 0, sizeof(*connection_info));
+  
 	/* send a get connection info request */
 	retval = usb_control_msg (serial->dev,
 				  usb_rcvctrlpipe(serial->dev, 0),
@@ -726,11 +751,20 @@
 
 	le16_to_cpus(&connection_info->num_ports);
 	num_ports = connection_info->num_ports;
-	/* handle devices that report invalid stuff here */
-	if (num_ports > 2)
+	/*
+	* Handle devices that report invalid stuff here.  I think that this will
+	* work for both big and little endian architectures that do not report
+	* back valid connect info, but I'd still like to verify this on a big
+	* endian machine.  Any testers?
+	*/
+	if (num_ports <= 0 || num_ports > 2) {
+		dev_warn (dev, "%s: No valid connect info available\n",
+			serial->type->name);
 		num_ports = 2;
+	}
+  
 	dev_info(dev, "%s: Number of ports: %d\n", serial->type->name,
-		connection_info->num_ports);
+		num_ports);
 
 	for (i = 0; i < num_ports; ++i) {
 		switch (connection_info->connections[i].port_function_id) {
@@ -887,8 +921,7 @@
  
 static int treo_attach (struct usb_serial *serial)
 {
-	struct usb_serial_port *port;
-	int i;
+	struct usb_serial_port swap_port;
 
 	/* Only do this endpoint hack for the Handspring devices with
 	 * interrupt in endpoints, which for now are the Treo devices. */
@@ -898,31 +931,32 @@
 
 	dbg("%s", __FUNCTION__);
 
-	/* Ok, this is pretty ugly, but these devices want to use the
-	 * interrupt endpoint as paired up with a bulk endpoint for a
-	 * "virtual serial port".  So let's force the endpoints to be
-	 * where we want them to be. */
-	for (i = serial->num_bulk_in; i < serial->num_ports; ++i) {
-		port = serial->port[i];
-		port->read_urb = serial->port[0]->read_urb;
-		port->bulk_in_endpointAddress = serial->port[0]->bulk_in_endpointAddress;
-		port->bulk_in_buffer = serial->port[0]->bulk_in_buffer;
-	}
-
-	for (i = serial->num_bulk_out; i < serial->num_ports; ++i) {
-		port = serial->port[i];
-		port->write_urb = serial->port[0]->write_urb;
-		port->bulk_out_size = serial->port[0]->bulk_out_size;
-		port->bulk_out_endpointAddress = serial->port[0]->bulk_out_endpointAddress;
-		port->bulk_out_buffer = serial->port[0]->bulk_out_buffer;
-	}
-
-	for (i = serial->num_interrupt_in; i < serial->num_ports; ++i) {
-		port = serial->port[i];
-		port->interrupt_in_urb = serial->port[0]->interrupt_in_urb;
-		port->interrupt_in_endpointAddress = serial->port[0]->interrupt_in_endpointAddress;
-		port->interrupt_in_buffer = serial->port[0]->interrupt_in_buffer;
-	}
+	/*
+	* It appears that Treos want to use the 1st interrupt endpoint to communicate
+	* with the 2nd bulk out endpoint, so let's swap the 1st and 2nd bulk in
+	* and interrupt endpoints.  Note that swapping the bulk out endpoints would
+	* break lots of apps that want to communicate on the second port.
+	*/
+	swap_port.read_urb = serial->port[0]->read_urb;
+	swap_port.bulk_in_endpointAddress = serial->port[0]->bulk_in_endpointAddress;
+	swap_port.bulk_in_buffer = serial->port[0]->bulk_in_buffer;
+	swap_port.interrupt_in_urb = serial->port[0]->interrupt_in_urb;
+	swap_port.interrupt_in_endpointAddress = serial->port[0]->interrupt_in_endpointAddress;
+	swap_port.interrupt_in_buffer = serial->port[0]->interrupt_in_buffer;
+ 
+	serial->port[0]->read_urb = serial->port[1]->read_urb;
+	serial->port[0]->bulk_in_endpointAddress = serial->port[1]->bulk_in_endpointAddress;
+	serial->port[0]->bulk_in_buffer = serial->port[1]->bulk_in_buffer;
+	serial->port[0]->interrupt_in_urb = serial->port[1]->interrupt_in_urb;
+	serial->port[0]->interrupt_in_endpointAddress = serial->port[1]->interrupt_in_endpointAddress;
+	serial->port[0]->interrupt_in_buffer = serial->port[1]->interrupt_in_buffer;
+
+	serial->port[1]->read_urb = swap_port.read_urb;
+	serial->port[1]->bulk_in_endpointAddress = swap_port.bulk_in_endpointAddress;
+	serial->port[1]->bulk_in_buffer = swap_port.bulk_in_buffer;
+	serial->port[1]->interrupt_in_urb = swap_port.interrupt_in_urb;
+	serial->port[1]->interrupt_in_endpointAddress = swap_port.interrupt_in_endpointAddress;
+	serial->port[1]->interrupt_in_buffer = swap_port.interrupt_in_buffer;
 
 	return 0;
 }

--------------080300050207050505090000--
