Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbUEVCcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUEVCcU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 22:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265244AbUEUWhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:37:48 -0400
Received: from mail.kroah.org ([65.200.24.183]:32955 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264648AbUEUWdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:33:53 -0400
Date: Fri, 21 May 2004 13:44:31 -0700
From: Greg KH <greg@kroah.com>
To: nardelli <jnardelli@infosciences.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] visor: Fix Oops on disconnect
Message-ID: <20040521204430.GA5875@kroah.com>
References: <40AD3A88.2000002@infosciences.com> <20040521043032.GA31113@kroah.com> <40AE5DBB.6030003@infosciences.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40AE5DBB.6030003@infosciences.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2004 at 03:51:23PM -0400, nardelli wrote:
> I've made all of the changes that recommended below.  If it looks like
> I've missed anything, please indicate so.
> 
> 
> 
> --- linux-2.6.6.old/drivers/usb/serial/visor.c	2004-05-09 
> 22:32:27.000000000 -0400
> +++ linux-2.6.6.new/drivers/usb/serial/visor.c	2004-05-21 
> 15:02:30.938875280 -0400

Patch is line-wrapped, so I can't apply it :(

> @@ -456,7 +460,8 @@ static void visor_close (struct usb_seri
> 		return;
> 	
> 	/* shutdown our urbs */
> -	usb_unlink_urb (port->read_urb);
> +	if (port->read_urb)
> +		usb_unlink_urb (port->read_urb);

I really do not think these extra checks for read_urb all of the place
need to be added.  We take care of it in the open() call, right?


> 	if (port->interrupt_in_urb)
> 		usb_unlink_urb (port->interrupt_in_urb);
> 
> @@ -622,15 +627,20 @@ static void visor_read_bulk_callback (st
> 	bytes_in += urb->actual_length;
> 
> 	/* Continue trying to always read  */
> -	usb_fill_bulk_urb (port->read_urb, serial->dev,
> -			   usb_rcvbulkpipe (serial->dev,
> -					    port->bulk_in_endpointAddress),
> -			   port->read_urb->transfer_buffer,
> -			   port->read_urb->transfer_buffer_length,
> -			   visor_read_bulk_callback, port);
> -	result = usb_submit_urb(port->read_urb, GFP_ATOMIC);
> -	if (result)
> -		dev_err(&port->dev, "%s - failed resubmitting read urb, 
> error %d\n", __FUNCTION__, result);
> +	if (port->read_urb) {
> +		usb_fill_bulk_urb (port->read_urb, serial->dev,
> +				usb_rcvbulkpipe (serial->dev,
> +				port->bulk_in_endpointAddress),
> +				port->read_urb->transfer_buffer,
> +				port->read_urb->transfer_buffer_length,
> +				visor_read_bulk_callback, port);
> +		result = usb_submit_urb(port->read_urb, GFP_ATOMIC);
> +		if (result)
> +			dev_err(&port->dev,
> +				"%s - failed resubmitting read urb, error 
> %d\n",
> +				__FUNCTION__, result);
> +	}
> +  
> 	return;
> }
> 
> @@ -675,7 +685,9 @@ exit:
> static void visor_throttle (struct usb_serial_port *port)
> {
> 	dbg("%s - port %d", __FUNCTION__, port->number);
> -	usb_unlink_urb (port->read_urb);
> +	if (port->read_urb) {
> +		usb_unlink_urb (port->read_urb);
> +	}
> }
> 
> 
> @@ -685,10 +697,14 @@ static void visor_unthrottle (struct usb
> 
> 	dbg("%s - port %d", __FUNCTION__, port->number);
> 
> -	port->read_urb->dev = port->serial->dev;
> -	result = usb_submit_urb(port->read_urb, GFP_ATOMIC);
> -	if (result)
> -		dev_err(&port->dev, "%s - failed submitting read urb, error 
> %d\n", __FUNCTION__, result);
> +	if (port->read_urb) {
> +		port->read_urb->dev = port->serial->dev;
> +		result = usb_submit_urb(port->read_urb, GFP_ATOMIC);
> +		if (result)
> +			dev_err(&port->dev,
> +				"%s - failed submitting read urb, error 
> %d\n",
> +				__FUNCTION__, result);
> +	}
> }
> 
> static int palm_os_3_probe (struct usb_serial *serial, const struct 
> usb_device_id *id)
> @@ -721,41 +737,55 @@ static int palm_os_3_probe (struct usb_s
> 			__FUNCTION__, retval);
> 		goto exit;
> 	}
> -		
> -	connection_info = (struct visor_connection_info *)transfer_buffer;
> -
> -	le16_to_cpus(&connection_info->num_ports);
> -	num_ports = connection_info->num_ports;
> -	/* handle devices that report invalid stuff here */
> -	if (num_ports > 2)
> -		num_ports = 2;
> -	dev_info(dev, "%s: Number of ports: %d\n", serial->type->name,
> -		connection_info->num_ports);
> -
> -	for (i = 0; i < num_ports; ++i) {
> -		switch (connection_info->connections[i].port_function_id) {
> -			case VISOR_FUNCTION_GENERIC:
> -				string = "Generic";
> -				break;
> -			case VISOR_FUNCTION_DEBUGGER:
> -				string = "Debugger";
> -				break;
> -			case VISOR_FUNCTION_HOTSYNC:
> -				string = "HotSync";
> -				break;
> -			case VISOR_FUNCTION_CONSOLE:
> -				string = "Console";
> -				break;
> -			case VISOR_FUNCTION_REMOTE_FILE_SYS:
> -				string = "Remote File System";
> -				break;
> -			default:
> -				string = "unknown";
> -				break;	
> +	else if (retval != sizeof(*connection_info)) {
> +		/* real invalid connection info handling is below */
> +		num_ports = 0;
> +	}

Change this to a "if" instead of a "else if".
Actually just set num_ports to 0 at the beginning of the function, and
then just check for a valud retval and do the code below...

> +	else {
> +	        connection_info = (struct visor_connection_info *)
> +			transfer_buffer;

<snip>

Also, don't quote the whole previous message, that's not nice...

thanks,

greg k-h
