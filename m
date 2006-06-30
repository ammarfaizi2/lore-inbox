Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWF3HKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWF3HKi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 03:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWF3HKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 03:10:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17112 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932084AbWF3HKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 03:10:37 -0400
Date: Fri, 30 Jun 2006 00:10:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Gay <andy@andynet.net>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO
 transfers
Message-Id: <20060630001021.2b49d4bd.akpm@osdl.org>
In-Reply-To: <1151646482.3285.410.camel@tahini.andynet.net>
References: <1151646482.3285.410.camel@tahini.andynet.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2006 01:48:02 -0400
Andy Gay <andy@andynet.net> wrote:

> 
> Adapted from an earlier patch by Greg KH <gregkh@suse.de>.
> That patch added multiple read urbs and larger transfer buffers to allow
> data transfers at full EvDO speed.
> 
> This version includes additional device IDs and fixes a memory leak in
> the transfer buffer allocation.
> 
> Some (maybe all?) of the supported devices present multiple bulk endpoints,
> the additional EPs can be used for control and status functions.
> This version allocates 3 EPs by default, that can be changed using
> the 'endpoints' module parameter.
> 
> Tested with Sierra Wireless EM5625 and MC5720 embedded modules.
> 
> Device ID (0x0c88, 0x17da) for the Kyocera Wireless KPC650/Passport
> was added but is not yet tested.
> 
> ...
>
> +static void airprime_read_bulk_callback(struct urb *urb, struct pt_regs *regs)
> +{
> +	struct usb_serial_port *port = urb->context;
> +	unsigned char *data = urb->transfer_buffer;
> +	struct tty_struct *tty;
> +	int result;
> +
> +	dbg("%s - port %d", __FUNCTION__, port->number);
> +
> +	if (urb->status) {
> +		dbg("%s - nonzero read bulk status received: %d",
> +		    __FUNCTION__, urb->status);
> +		/* something happened, so free up the memory for this urb /*
> +		if (urb->transfer_buffer) {
> +			kfree (urb->transfer_buffer);
> +			urb->transfer_buffer = NULL;
> +		}
> +		return;
> +	}
> +	usb_serial_debug_data(debug, &port->dev, __FUNCTION__, urb->actual_length, data);
> +
> +	tty = port->tty;
> +	if (tty && urb->actual_length) {
> +		tty_buffer_request_room(tty, urb->actual_length);
> +		tty_insert_flip_string(tty, data, urb->actual_length);

Is it correct to ignore the return value from those two functions?

> +		tty_flip_buffer_push(tty);
> +	}
> +	/* should this use GFP_KERNEL? */
> +	result = usb_submit_urb(urb, GFP_ATOMIC);

If possible, yep.

> ...
>
> +static int airprime_open(struct usb_serial_port *port, struct file *filp)
> +{
> +	struct airprime_private *priv = usb_get_serial_port_data(port);
> +	struct usb_serial *serial = port->serial;
> +	struct urb *urb;
> +	char *buffer;
> +	int i;
> +	int result = 0;
> +
> +	dbg("%s - port %d", __FUNCTION__, port->number);
> +
> +	/* initialize our private data structure if it isn't already created */
> +	if (!priv) {
> +		priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +		if (!priv)
> +			return -ENOMEM;
> +		spin_lock_init(&priv->lock);
> +		usb_set_serial_port_data(port, priv);
> +	}
> +	/* TODO handle error conditions better, right now we leak memory */
> +	for (i = 0; i < NUM_READ_URBS; ++i) {
> +		buffer = kmalloc(buffer_size, GFP_KERNEL);
> +		if (!buffer) {
> +			dev_err(&port->dev, "%s - out of memory.\n",
> +				__FUNCTION__);
> +			return -ENOMEM;
> +		}
> +		urb = usb_alloc_urb(0, GFP_KERNEL);
> +		if (!urb) {
> +			dev_err(&port->dev, "%s - no more urbs?\n",
> +				__FUNCTION__);
> +			return -ENOMEM;
> +		}
> +		usb_fill_bulk_urb(urb, serial->dev,
> +				  usb_rcvbulkpipe(serial->dev,
> +						  port->bulk_out_endpointAddress),
> +				  buffer, buffer_size,
> +				  airprime_read_bulk_callback, port);
> +		result = usb_submit_urb(urb, GFP_KERNEL);
> +		if (result) {
> +			dev_err(&port->dev,
> +				"%s - failed submitting read urb %d for port %d, error %d\n",
> +				__FUNCTION__, i, port->number, result);
> +			return result;
> +		}
> +		/* fun with reference counting, when this urb is finished, the
> +		 * host driver will free it up automatically */
> +		/* don't do this here, we need the urb to stay around until the close
> +		   function can take care of it */
> +		//usb_free_urb (urb);
> +		/* instead remember this urb so we can kill it when the
> +		   port is closed */
> +		priv->read_urbp[i] = urb;
> +	}
> +	return result;
> +}
> +

This function leaks memory all over the place if something goes wrong.

Please redesign it to have a single `return' statement.  You'll find that'll
help avoid leaks now and during any later enhancements.


> +{
> +	struct airprime_private *priv = usb_get_serial_port_data(port);
> +	int i;
> +
> +	dbg("%s - port %d", __FUNCTION__, port->number);
> +
> +	/* killing the urb will invoke read_bulk_callback() with an error status,
> +	   so the transfer buffer will be freed there */
> +	for (i = 0; i < NUM_READ_URBS; ++i) {
> +		usb_kill_urb (priv->read_urbp[i]);
> +		usb_free_urb (priv->read_urbp[i]);
> +	}
> +
> +	/* free up private structure? */

Yes please ;)

> +}
> +
> +static int airprime_write(struct usb_serial_port *port,
> +			  const unsigned char *buf, int count)
> +{
> +	struct airprime_private *priv = usb_get_serial_port_data(port);
> +	struct usb_serial *serial = port->serial;
> +	struct urb *urb;
> +	unsigned char *buffer;
> +	unsigned long flags;
> +	int status;
> +	dbg("%s - port %d", __FUNCTION__, port->number);
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	if (priv->outstanding_urbs > NUM_WRITE_URBS) {
> +		spin_unlock_irqrestore(&priv->lock, flags);
> +		dbg("%s - write limit hit\n", __FUNCTION__);
> +		return 0;
> +	}
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +	buffer = kmalloc(count, GFP_ATOMIC);
> +	if (!buffer) {
> +		dev_err(&port->dev, "out of memory\n");
> +		return -ENOMEM;
> +	}
> +	urb = usb_alloc_urb(0, GFP_ATOMIC);
> +	if (!urb) {
> +		dev_err(&port->dev, "no more free urbs\n");
> +		kfree (buffer);
> +		return -ENOMEM;
> +	}
> +	memcpy (buffer, buf, count);
> +
> +	usb_serial_debug_data(debug, &port->dev, __FUNCTION__, count, buffer);
> +
> +	usb_fill_bulk_urb(urb, serial->dev,
> +			  usb_sndbulkpipe(serial->dev,
> +					  port->bulk_out_endpointAddress),
> +			  buffer, count,
> +			  airprime_write_bulk_callback, port);
> +
> +	/* send it down the pipe */
> +	status = usb_submit_urb(urb, GFP_ATOMIC);
> +	if (status) {
> +		dev_err(&port->dev,
> +			"%s - usb_submit_urb(write bulk) failed with status = %d\n",
> +			__FUNCTION__, status);
> +		count = status;
> +		kfree (buffer);
> +	} else {
> +		spin_lock_irqsave(&priv->lock, flags);
> +		++priv->outstanding_urbs;
> +		spin_unlock_irqrestore(&priv->lock, flags);
> +	}
> +	/* we are done with this urb, so let the host driver
> +	 * really free it when it is finished with it */
> +	usb_free_urb (urb);
> +	return count;
> +}

Is usb_serial_driver.write() really called in a context in which it is
forced to use GFP_ATOMIC?

Again, implementing this function as single-exit would make it easier to
maintain.

> +MODULE_PARM_DESC(debug, "Debug enabled or not");

Just "Debug enabled".

> +module_param(buffer_size, int, 0);
> +MODULE_PARM_DESC(buffer_size, "Size of the transfer buffers");

Units?

