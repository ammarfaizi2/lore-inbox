Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWF3Qhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWF3Qhj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 12:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWF3Qhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 12:37:39 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:27901 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751286AbWF3Qhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 12:37:38 -0400
Date: Fri, 30 Jun 2006 12:35:30 -0400
From: Andy Gay <andy@andynet.net>
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO
	transfers
In-reply-to: <20060630001021.2b49d4bd.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       Pete Zaitcev <zaitcev@redhat.com>
Message-id: <1151685331.3285.454.camel@tahini.andynet.net>
MIME-version: 1.0
X-Mailer: Evolution 2.4.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1151646482.3285.410.camel@tahini.andynet.net>
	<20060630001021.2b49d4bd.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-30 at 00:10 -0700, Andrew Morton wrote:

> > 
> > ...
> >
> > +static void airprime_read_bulk_callback(struct urb *urb, struct pt_regs *regs)
> > +{
...

> > +	tty = port->tty;
> > +	if (tty && urb->actual_length) {
> > +		tty_buffer_request_room(tty, urb->actual_length);
> > +		tty_insert_flip_string(tty, data, urb->actual_length);
> 
> Is it correct to ignore the return value from those two functions?
Not my code :) - generic.c and several other drivers do the same
thing... Not that that's an excuse, of course :)
Actually though, I think it's OK to ignore the tty_insert_flip_string
result. These adapters are used at layer 1 for ppp connection, the
higher layers will attempt to recover.

I will remove the tty_buffer_request_room() call though, as suggested by
Sergei Organov and Alan Cox.

> 
> > +		tty_flip_buffer_push(tty);
> > +	}
> > +	/* should this use GFP_KERNEL? */
> > +	result = usb_submit_urb(urb, GFP_ATOMIC);
> 
> If possible, yep.
Oops - that was a comment to myself I left in by mistake. As pointed out
by Pete Zaitcev, this is a callback function. I think it has to be
GFP_ATOMIC here, doesn't it?

> 
> > ...
> >
> > +static int airprime_open(struct usb_serial_port *port, struct file *filp)
> > +{
> > +	struct airprime_private *priv = usb_get_serial_port_data(port);
> > +	struct usb_serial *serial = port->serial;
> > +	struct urb *urb;
> > +	char *buffer;
> > +	int i;
> > +	int result = 0;
> > +
> > +	dbg("%s - port %d", __FUNCTION__, port->number);
> > +
> > +	/* initialize our private data structure if it isn't already created */
> > +	if (!priv) {
> > +		priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> > +		if (!priv)
> > +			return -ENOMEM;
> > +		spin_lock_init(&priv->lock);
> > +		usb_set_serial_port_data(port, priv);
> > +	}
> > +	/* TODO handle error conditions better, right now we leak memory */
> > +	for (i = 0; i < NUM_READ_URBS; ++i) {
> > +		buffer = kmalloc(buffer_size, GFP_KERNEL);
> > +		if (!buffer) {
> > +			dev_err(&port->dev, "%s - out of memory.\n",
> > +				__FUNCTION__);
> > +			return -ENOMEM;
> > +		}
> > +		urb = usb_alloc_urb(0, GFP_KERNEL);
> > +		if (!urb) {
> > +			dev_err(&port->dev, "%s - no more urbs?\n",
> > +				__FUNCTION__);
> > +			return -ENOMEM;
> > +		}
> > +		usb_fill_bulk_urb(urb, serial->dev,
> > +				  usb_rcvbulkpipe(serial->dev,
> > +						  port->bulk_out_endpointAddress),
> > +				  buffer, buffer_size,
> > +				  airprime_read_bulk_callback, port);
> > +		result = usb_submit_urb(urb, GFP_KERNEL);
> > +		if (result) {
> > +			dev_err(&port->dev,
> > +				"%s - failed submitting read urb %d for port %d, error %d\n",
> > +				__FUNCTION__, i, port->number, result);
> > +			return result;
> > +		}
> > +		/* fun with reference counting, when this urb is finished, the
> > +		 * host driver will free it up automatically */
> > +		/* don't do this here, we need the urb to stay around until the close
> > +		   function can take care of it */
> > +		//usb_free_urb (urb);
> > +		/* instead remember this urb so we can kill it when the
> > +		   port is closed */
> > +		priv->read_urbp[i] = urb;
> > +	}
> > +	return result;
> > +}
> > +
> 
> This function leaks memory all over the place if something goes wrong.
Indeed. Hence the TODO comment.

> 
> Please redesign it to have a single `return' statement.  You'll find that'll
> help avoid leaks now and during any later enhancements.
OK, I'll work on that.
> 
> 
> > +{
> > +	struct airprime_private *priv = usb_get_serial_port_data(port);
> > +	int i;
> > +
> > +	dbg("%s - port %d", __FUNCTION__, port->number);
> > +
> > +	/* killing the urb will invoke read_bulk_callback() with an error status,
> > +	   so the transfer buffer will be freed there */
> > +	for (i = 0; i < NUM_READ_URBS; ++i) {
> > +		usb_kill_urb (priv->read_urbp[i]);
> > +		usb_free_urb (priv->read_urbp[i]);
> > +	}
> > +
> > +	/* free up private structure? */
> 
> Yes please ;)
Easily done. But we'd need another one next time the port is opened. Why
not just allocate it once and keep reusing it?

> 
> > +}
> > +
> > +static int airprime_write(struct usb_serial_port *port,
> > +			  const unsigned char *buf, int count)
> > +{
> > +	struct airprime_private *priv = usb_get_serial_port_data(port);
> > +	struct usb_serial *serial = port->serial;
> > +	struct urb *urb;
> > +	unsigned char *buffer;
> > +	unsigned long flags;
> > +	int status;
> > +	dbg("%s - port %d", __FUNCTION__, port->number);
> > +
> > +	spin_lock_irqsave(&priv->lock, flags);
> > +	if (priv->outstanding_urbs > NUM_WRITE_URBS) {
> > +		spin_unlock_irqrestore(&priv->lock, flags);
> > +		dbg("%s - write limit hit\n", __FUNCTION__);
> > +		return 0;
> > +	}
> > +	spin_unlock_irqrestore(&priv->lock, flags);
> > +	buffer = kmalloc(count, GFP_ATOMIC);
> > +	if (!buffer) {
> > +		dev_err(&port->dev, "out of memory\n");
> > +		return -ENOMEM;
> > +	}
> > +	urb = usb_alloc_urb(0, GFP_ATOMIC);
> > +	if (!urb) {
> > +		dev_err(&port->dev, "no more free urbs\n");
> > +		kfree (buffer);
> > +		return -ENOMEM;
> > +	}
> > +	memcpy (buffer, buf, count);
> > +
> > +	usb_serial_debug_data(debug, &port->dev, __FUNCTION__, count, buffer);
> > +
> > +	usb_fill_bulk_urb(urb, serial->dev,
> > +			  usb_sndbulkpipe(serial->dev,
> > +					  port->bulk_out_endpointAddress),
> > +			  buffer, count,
> > +			  airprime_write_bulk_callback, port);
> > +
> > +	/* send it down the pipe */
> > +	status = usb_submit_urb(urb, GFP_ATOMIC);
> > +	if (status) {
> > +		dev_err(&port->dev,
> > +			"%s - usb_submit_urb(write bulk) failed with status = %d\n",
> > +			__FUNCTION__, status);
> > +		count = status;
> > +		kfree (buffer);
> > +	} else {
> > +		spin_lock_irqsave(&priv->lock, flags);
> > +		++priv->outstanding_urbs;
> > +		spin_unlock_irqrestore(&priv->lock, flags);
> > +	}
> > +	/* we are done with this urb, so let the host driver
> > +	 * really free it when it is finished with it */
> > +	usb_free_urb (urb);
> > +	return count;
> > +}
> 
> Is usb_serial_driver.write() really called in a context in which it is
> forced to use GFP_ATOMIC?
No idea. Safer to leave this as is, I think.

> 
> Again, implementing this function as single-exit would make it easier to
> maintain.
OK.

> 
> > +MODULE_PARM_DESC(debug, "Debug enabled or not");
> 
> Just "Debug enabled".
> 
> > +module_param(buffer_size, int, 0);
> > +MODULE_PARM_DESC(buffer_size, "Size of the transfer buffers");
> 
> Units?
> 
I'll fix these.
Thanks for reviewing this.


