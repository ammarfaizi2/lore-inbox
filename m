Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264804AbUEVCW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264804AbUEVCW3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 22:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264706AbUEUWjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:39:13 -0400
Received: from mail.kroah.org ([65.200.24.183]:32955 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265007AbUEUWdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:33:54 -0400
Date: Thu, 20 May 2004 21:30:32 -0700
From: Greg KH <greg@kroah.com>
To: nardelli <jnardelli@infosciences.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] visor: Fix Oops on disconnect
Message-ID: <20040521043032.GA31113@kroah.com>
References: <40AD3A88.2000002@infosciences.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40AD3A88.2000002@infosciences.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2004 at 07:08:56PM -0400, nardelli wrote:
> Here is a proposed patch for Oops on disconnect in the visor module.
> For details of the problem, please see
> http://bugzilla.kernel.org/show_bug.cgi?id=2289
> 
> I would really appreciate it if anyone that uses this module could please
> try this patch to make sure that it works as intended.  Also, as this is
> the first patch that I've submitted, please feel free to be brutally
> honest regarding content, formatting, etc.

Ok, I'll be brutal, but remember, you asked :)

First off, read Documentation/SubmittingPatches and
Documentation/CodingStyle to see the proper way to make patches, and how
to format the code.

> --- old/linux-2.6.6/drivers/usb/serial/visor.c	2004-05-09 22:32:27.000000000 -0400
> +++ new/linux-2.6.6/drivers/usb/serial/visor.c	2004-05-20 18:04:24.000000000 -0400

I need to be able to apply this patch by using a -p1 in the kernel
directory.  So the patch should be one directory up and look like:

--- linux-2.6.6/drivers/usb/serial/visor.c	2004-05-09 22:32:27.000000000 -0400
+++ linux-2.6.6/drivers/usb/serial/visor.c	2004-05-20 18:04:24.000000000 -0400


> @@ -12,6 +12,13 @@
>   *
>   * See Documentation/usb/usb-serial.txt for more information on using this driver
>   *
> + * (5/20/2004) Joe Nardelli
> + *	Reduced possibility for unitialized data access in palm_os_3_probe.
> + *	Modified workaround for treo endpoint setup in treo_attach.
> + *	Removed assumptions that port->read_urb was always valid (is not true
> + *	for usb serial devices with more bulk out or interrupt endpoints than
> + *	bulk in endpoints).

I'm trying not to add new stuff to the changelog at the beginning of the
file, but this is not really a big deal.

> -	if (!port->read_urb) {
> +	if ((serial->dev->descriptor.idVendor != SONY_VENDOR_ID && !port->read_urb))
> +	{

Wrong formatting style for the '{'

Your patch says that we might not have a read_urb for the given port?
How could that be true?  The check here in open() will catch any devices
that this might not be correct for.  So that portion of this patch is
not needed, right?

>  static int palm_os_3_probe (struct usb_serial *serial, const struct usb_device_id *id)
> @@ -710,6 +728,13 @@
>  		return -ENOMEM;
>  	}
>  
> +	/*
> +	* We don't know how much data gets written into transfer_buffer, so let's
> +	* at least set it all to 0 to avoid putting random data into num_ports
> +	* (which causes unitialized, and possibly unallocated data to be accessed)
> +	*/
> +	memset (transfer_buffer, 0, sizeof(*connection_info));

Um, we ask for a set ammount of data, and we should get it.  But we
should check the size of the data returned to make sure of this, right?

>  	/* send a get connection info request */
>  	retval = usb_control_msg (serial->dev,
>  				  usb_rcvctrlpipe(serial->dev, 0),
> @@ -726,11 +751,20 @@
>  
>  	le16_to_cpus(&connection_info->num_ports);
>  	num_ports = connection_info->num_ports;
> -	/* handle devices that report invalid stuff here */
> -	if (num_ports > 2)
> +	/*
> +	* Handle devices that report invalid stuff here.  I think that this will
> +	* work for both big and little endian architectures that do not report
> +	* back valid connect info, but I'd still like to verify this on a big
> +	* endian machine.  Any testers?
> +	*/

The call above to le16_to_cpus() will handle the endian issue here.
This comment can be removed.

> +	if (num_ports <= 0 || num_ports > 2) {

I like the idea of this check, but you are trying to test for a negative
value on a __u16 variable, which is always unsigned.  So that check will
never be true :)

> +		dev_warn (dev, "%s: No valid connect info available\n",
> +			serial->type->name);
>  		num_ports = 2;
> +	}
> +  
>  	dev_info(dev, "%s: Number of ports: %d\n", serial->type->name,
> -		connection_info->num_ports);
> +		num_ports);
>  
>  	for (i = 0; i < num_ports; ++i) {
>  		switch (connection_info->connections[i].port_function_id) {
> @@ -887,8 +921,7 @@
>   
>  static int treo_attach (struct usb_serial *serial)
>  {
> -	struct usb_serial_port *port;
> -	int i;
> +	struct usb_serial_port swap_port;
>  
>  	/* Only do this endpoint hack for the Handspring devices with
>  	 * interrupt in endpoints, which for now are the Treo devices. */
> @@ -898,31 +931,32 @@
>  
>  	dbg("%s", __FUNCTION__);
>  
> -	/* Ok, this is pretty ugly, but these devices want to use the
> -	 * interrupt endpoint as paired up with a bulk endpoint for a
> -	 * "virtual serial port".  So let's force the endpoints to be
> -	 * where we want them to be. */
> -	for (i = serial->num_bulk_in; i < serial->num_ports; ++i) {
> -		port = serial->port[i];
> -		port->read_urb = serial->port[0]->read_urb;
> -		port->bulk_in_endpointAddress = serial->port[0]->bulk_in_endpointAddress;
> -		port->bulk_in_buffer = serial->port[0]->bulk_in_buffer;
> -	}
> -
> -	for (i = serial->num_bulk_out; i < serial->num_ports; ++i) {
> -		port = serial->port[i];
> -		port->write_urb = serial->port[0]->write_urb;
> -		port->bulk_out_size = serial->port[0]->bulk_out_size;
> -		port->bulk_out_endpointAddress = serial->port[0]->bulk_out_endpointAddress;
> -		port->bulk_out_buffer = serial->port[0]->bulk_out_buffer;
> -	}
> -
> -	for (i = serial->num_interrupt_in; i < serial->num_ports; ++i) {
> -		port = serial->port[i];
> -		port->interrupt_in_urb = serial->port[0]->interrupt_in_urb;
> -		port->interrupt_in_endpointAddress = serial->port[0]->interrupt_in_endpointAddress;
> -		port->interrupt_in_buffer = serial->port[0]->interrupt_in_buffer;
> -	}
> +	/*
> +	* It appears that Treos want to use the 1st interrupt endpoint to communicate
> +	* with the 2nd bulk out endpoint, so let's swap the 1st and 2nd bulk in
> +	* and interrupt endpoints.  Note that swapping the bulk out endpoints would
> +	* break lots of apps that want to communicate on the second port.
> +	*/
> +	swap_port.read_urb = serial->port[0]->read_urb;
> +	swap_port.bulk_in_endpointAddress = serial->port[0]->bulk_in_endpointAddress;
> +	swap_port.bulk_in_buffer = serial->port[0]->bulk_in_buffer;
> +	swap_port.interrupt_in_urb = serial->port[0]->interrupt_in_urb;
> +	swap_port.interrupt_in_endpointAddress = serial->port[0]->interrupt_in_endpointAddress;
> +	swap_port.interrupt_in_buffer = serial->port[0]->interrupt_in_buffer;
> + 
> +	serial->port[0]->read_urb = serial->port[1]->read_urb;
> +	serial->port[0]->bulk_in_endpointAddress = serial->port[1]->bulk_in_endpointAddress;
> +	serial->port[0]->bulk_in_buffer = serial->port[1]->bulk_in_buffer;
> +	serial->port[0]->interrupt_in_urb = serial->port[1]->interrupt_in_urb;
> +	serial->port[0]->interrupt_in_endpointAddress = serial->port[1]->interrupt_in_endpointAddress;
> +	serial->port[0]->interrupt_in_buffer = serial->port[1]->interrupt_in_buffer;
> +
> +	serial->port[1]->read_urb = swap_port.read_urb;
> +	serial->port[1]->bulk_in_endpointAddress = swap_port.bulk_in_endpointAddress;
> +	serial->port[1]->bulk_in_buffer = swap_port.bulk_in_buffer;
> +	serial->port[1]->interrupt_in_urb = swap_port.interrupt_in_urb;
> +	serial->port[1]->interrupt_in_endpointAddress = swap_port.interrupt_in_endpointAddress;
> +	serial->port[1]->interrupt_in_buffer = swap_port.interrupt_in_buffer;

Now this is the meat of the patch.  Is that all that is needed, just
swaping the info?  That makes more sense than the hack of assigning the
same port data to both ports.  Does this work properly on disconnect
too?

Thanks a lot for doing this, with some cleanups I'll be glad to accept
this patch.

thanks,

greg k-h
