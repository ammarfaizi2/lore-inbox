Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263944AbUEXVp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263944AbUEXVp3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 17:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264577AbUEXVp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 17:45:28 -0400
Received: from [141.156.69.115] ([141.156.69.115]:46769 "EHLO
	mail.infosciences.com") by vger.kernel.org with ESMTP
	id S263944AbUEXVpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 17:45:18 -0400
Message-ID: <40B26C5E.9060001@infosciences.com>
Date: Mon, 24 May 2004 17:42:54 -0400
From: nardelli <jnardelli@infosciences.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] visor: Fix Oops on disconnect
References: <40AD3A88.2000002@infosciences.com> <20040521043032.GA31113@kroah.com> <40AE5DBB.6030003@infosciences.com> <20040521204430.GA5875@kroah.com> <40AE7829.9060105@infosciences.com> <40AE7CFE.5060805@infosciences.com> <20040521223024.GA7399@kroah.com> <40B22EED.4080808@infosciences.com> <20040524200805.GD4558@kroah.com>
In-Reply-To: <20040524200805.GD4558@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> 
> 
> Today, that call does fail:
> 
>         if (!port->read_urb) {
>                 /* this is needed for some brain dead Sony devices */
>                 dev_err(&port->dev, "Device lied about number of ports, please use a lower one.\n");
>                 return -ENODEV;
>         }
> 
> Let's not change that logic please.
> 

OK.


Here's another patch.  The differences between this one and the last are:

1) Removal of extra checks to verify that port->read_urb is valid
2) Modified num_ports initialization and return value checking in palm_os_3_probe


I made this patch against 2.6.6.  Would you prefer it against 2.6.7-rc1?



--- linux-2.6.6.old/drivers/usb/serial/visor.c	2004-05-09 22:32:27.000000000 -0400
+++ linux-2.6.6.new/drivers/usb/serial/visor.c	2004-05-24 16:44:03.435277632 -0400
@@ -699,7 +699,7 @@ static int palm_os_3_probe (struct usb_s
 	char *string;
 	int retval = 0;
 	int i;
-	int num_ports;
+	int num_ports = 0;
 
 	dbg("%s", __FUNCTION__);
 
@@ -721,41 +721,52 @@ static int palm_os_3_probe (struct usb_s
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
-
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
+	if (retval == sizeof(*connection_info)) {
+	        connection_info = (struct visor_connection_info *)
+			transfer_buffer;
+
+		le16_to_cpus(&connection_info->num_ports);
+		num_ports = connection_info->num_ports;
+
+		for (i = 0; i < num_ports; ++i) {
+			switch (connection_info->connections[i].
+					port_function_id) {
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
+				serial->type->name, connection_info->
+				connections[i].port, string);
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
@@ -887,8 +898,7 @@ static int clie_3_5_startup (struct usb_
  
 static int treo_attach (struct usb_serial *serial)
 {
-	struct usb_serial_port *port;
-	int i;
+	struct usb_serial_port swap_port;
 
 	/* Only do this endpoint hack for the Handspring devices with
 	 * interrupt in endpoints, which for now are the Treo devices. */
@@ -898,31 +908,40 @@ static int treo_attach (struct usb_seria
 
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
+	swap_port.read_urb = serial->port[0]->read_urb;
+	swap_port.bulk_in_endpointAddress = serial->port[0]->
+		bulk_in_endpointAddress;
+	swap_port.bulk_in_buffer = serial->port[0]->bulk_in_buffer;
+	swap_port.interrupt_in_urb = serial->port[0]->interrupt_in_urb;
+	swap_port.interrupt_in_endpointAddress = serial->port[0]->
+		interrupt_in_endpointAddress;
+	swap_port.interrupt_in_buffer = serial->port[0]->interrupt_in_buffer;
+ 
+	serial->port[0]->read_urb = serial->port[1]->read_urb;
+	serial->port[0]->bulk_in_endpointAddress = serial->port[1]->
+		bulk_in_endpointAddress;
+	serial->port[0]->bulk_in_buffer = serial->port[1]->bulk_in_buffer;
+	serial->port[0]->interrupt_in_urb = serial->port[1]->interrupt_in_urb;
+	serial->port[0]->interrupt_in_endpointAddress = serial->port[1]->
+		interrupt_in_endpointAddress;
+	serial->port[0]->interrupt_in_buffer = serial->port[1]->
+		interrupt_in_buffer;
+
+	serial->port[1]->read_urb = swap_port.read_urb;
+	serial->port[1]->bulk_in_endpointAddress = swap_port.
+		bulk_in_endpointAddress;
+	serial->port[1]->bulk_in_buffer = swap_port.bulk_in_buffer;
+	serial->port[1]->interrupt_in_urb = swap_port.interrupt_in_urb;
+	serial->port[1]->interrupt_in_endpointAddress = swap_port.
+		interrupt_in_endpointAddress;
+	serial->port[1]->interrupt_in_buffer = swap_port.interrupt_in_buffer;
 
 	return 0;
 }



-- 
Joe Nardelli
jnardelli@infosciences.com
