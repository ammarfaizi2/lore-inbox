Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265018AbUEYSbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265018AbUEYSbq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 14:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265028AbUEYSbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 14:31:46 -0400
Received: from mail.kroah.org ([65.200.24.183]:35786 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265018AbUEYSbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 14:31:39 -0400
Date: Tue, 25 May 2004 11:30:34 -0700
From: Greg KH <greg@kroah.com>
To: nardelli <jnardelli@infosciences.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] visor: Fix Oops on disconnect
Message-ID: <20040525183033.GB12919@kroah.com>
References: <40AD3A88.2000002@infosciences.com> <20040521043032.GA31113@kroah.com> <40AE5DBB.6030003@infosciences.com> <20040521204430.GA5875@kroah.com> <40AE7829.9060105@infosciences.com> <40AE7CFE.5060805@infosciences.com> <20040521223024.GA7399@kroah.com> <40B22EED.4080808@infosciences.com> <20040524200805.GD4558@kroah.com> <40B26C5E.9060001@infosciences.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B26C5E.9060001@infosciences.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2004 at 05:42:54PM -0400, nardelli wrote:
> Greg KH wrote:
> >
> >
> >Today, that call does fail:
> >
> >        if (!port->read_urb) {
> >                /* this is needed for some brain dead Sony devices */
> >                dev_err(&port->dev, "Device lied about number of ports, 
> >                please use a lower one.\n");
> >                return -ENODEV;
> >        }
> >
> >Let's not change that logic please.
> >
> 
> OK.
> 
> 
> Here's another patch.  The differences between this one and the last are:
> 
> 1) Removal of extra checks to verify that port->read_urb is valid
> 2) Modified num_ports initialization and return value checking in 
> palm_os_3_probe
> 
> 
> I made this patch against 2.6.6.  Would you prefer it against 2.6.7-rc1?

Nah, this is good enough.  I've tweaked the patch a bit to keep from
creating a big structure on the stack, and reduced the copy port logic
to something a bit more readable and applied this version.  I'll send it
off to Linus in a day or so.

Thanks a lot for your work on this.

greg k-h



--- 1.110/drivers/usb/serial/visor.c	2004-05-15 08:48:18 -07:00
+++ edited/drivers/usb/serial/visor.c	2004-05-25 11:19:19 -07:00
@@ -680,7 +680,7 @@
 	char *string;
 	int retval = 0;
 	int i;
-	int num_ports;
+	int num_ports = 0;
 
 	dbg("%s", __FUNCTION__);
 
@@ -702,41 +702,50 @@
 			__FUNCTION__, retval);
 		goto exit;
 	}
-		
-	connection_info = (struct visor_connection_info *)transfer_buffer;
 
-	le16_to_cpus(&connection_info->num_ports);
-	num_ports = connection_info->num_ports;
-	/* handle devices that report invalid stuff here */
-	if (num_ports > 2)
-		num_ports = 2;
-	dev_info(dev, "%s: Number of ports: %d\n", serial->type->name,
-		connection_info->num_ports);
+	if (retval == sizeof(*connection_info)) {
+	        connection_info = (struct visor_connection_info *)transfer_buffer;
+
+		le16_to_cpus(&connection_info->num_ports);
+		num_ports = connection_info->num_ports;
 
-	for (i = 0; i < num_ports; ++i) {
-		switch (connection_info->connections[i].port_function_id) {
-			case VISOR_FUNCTION_GENERIC:
-				string = "Generic";
-				break;
-			case VISOR_FUNCTION_DEBUGGER:
-				string = "Debugger";
-				break;
-			case VISOR_FUNCTION_HOTSYNC:
-				string = "HotSync";
-				break;
-			case VISOR_FUNCTION_CONSOLE:
-				string = "Console";
-				break;
-			case VISOR_FUNCTION_REMOTE_FILE_SYS:
-				string = "Remote File System";
-				break;
-			default:
-				string = "unknown";
-				break;	
+		for (i = 0; i < num_ports; ++i) {
+			switch (connection_info->connections[i].port_function_id) {
+				case VISOR_FUNCTION_GENERIC:
+					string = "Generic";
+					break;
+				case VISOR_FUNCTION_DEBUGGER:
+					string = "Debugger";
+					break;
+				case VISOR_FUNCTION_HOTSYNC:
+					string = "HotSync";
+					break;
+				case VISOR_FUNCTION_CONSOLE:
+					string = "Console";
+					break;
+				case VISOR_FUNCTION_REMOTE_FILE_SYS:
+					string = "Remote File System";
+					break;
+				default:
+					string = "unknown";
+					break;
+			}
+			dev_info(dev, "%s: port %d, is for %s use\n",
+				serial->type->name,
+				connection_info->connections[i].port, string);
 		}
-		dev_info(dev, "%s: port %d, is for %s use\n", serial->type->name,
-			 connection_info->connections[i].port, string);
 	}
+	/*
+	* Handle devices that report invalid stuff here.
+	*/
+	if (num_ports == 0 || num_ports > 2) {
+		dev_warn (dev, "%s: No valid connect info available\n",
+			serial->type->name);
+		num_ports = 2;
+	}
+  
+	dev_info(dev, "%s: Number of ports: %d\n", serial->type->name,
+		num_ports);
 
 	/*
 	 * save off our num_ports info so that we can use it in the
@@ -868,8 +877,7 @@
  
 static int treo_attach (struct usb_serial *serial)
 {
-	struct usb_serial_port *port;
-	int i;
+	struct usb_serial_port *swap_port;
 
 	/* Only do this endpoint hack for the Handspring devices with
 	 * interrupt in endpoints, which for now are the Treo devices. */
@@ -879,31 +887,28 @@
 
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
+	* It appears that Treos want to use the 1st interrupt endpoint to
+	* communicate with the 2nd bulk out endpoint, so let's swap the 1st
+	* and 2nd bulk in and interrupt endpoints.  Note that swapping the
+	* bulk out endpoints would break lots of apps that want to communicate
+	* on the second port.
+	*/
+#define COPY_PORT(dest, src)						\
+	dest->read_urb = src->read_urb;					\
+	dest->bulk_in_endpointAddress = src->bulk_in_endpointAddress;	\
+	dest->bulk_in_buffer = src->bulk_in_buffer;			\
+	dest->interrupt_in_urb = src->interrupt_in_urb;			\
+	dest->interrupt_in_endpointAddress = src->interrupt_in_endpointAddress;	\
+	dest->interrupt_in_buffer = src->interrupt_in_buffer;
+
+	swap_port = kmalloc(sizeof(*swap_port), GFP_KERNEL);
+	if (!swap_port)
+		return -ENOMEM;
+	COPY_PORT(swap_port, serial->port[0]);
+	COPY_PORT(serial->port[0], serial->port[1]);
+	COPY_PORT(serial->port[1], swap_port);
+	kfree(swap_port);
 
 	return 0;
 }
