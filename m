Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbWEaUkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbWEaUkd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 16:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbWEaUkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 16:40:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:32233 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964921AbWEaUkc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 16:40:32 -0400
Date: Wed, 31 May 2006 13:38:03 -0700
From: Greg KH <gregkh@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH RFC] maxSize option for usb-serial to increase max endpoint buffer size
Message-ID: <20060531203803.GA7735@suse.de>
References: <447DFBC5.70200@goop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <447DFBC5.70200@goop.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 31, 2006 at 01:25:41PM -0700, Jeremy Fitzhardinge wrote:
> People using 1xEV-DO devices report that usb-serial must be changed to 
> allow an increased buffer size in order to get good throughput a full 
> data-rate.
> 
> There's a page at 
> http://www.junxion.com/opensource/linux_highspeed_usbserial.html which 
> describes the problem and solution, but the patch they offer for 2.6 
> kernels seems broken, because it drops a call to le16_to_cpu(), which 
> will presumably cause problems on big-endian systems.
> 
> I don't know if this patch is 1) really necessary, or 2) really 
> correct.  This patch certainly works for me, but I haven't exercised it 
> much.

Not correct or needed at all.  What needs to happen is the airprime
driver should be changed to handle bigger buffer sizes in it, not to
mess with the usb-serial core.

I've been working with Ken on getting this driver to work better
(meaning faster).  Here's the latest version (without your new device id
added).  Care to test it out and let me know if it works or not?

thanks,

greg k-h

--7AUc2qLy4jB3hD7Z
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="airprime.c"

/*
 * AirPrime CDMA Wireless Serial USB driver
 *
 * Copyright (C) 2005-2006 Greg Kroah-Hartman <gregkh@suse.de>
 *
 *	This program is free software; you can redistribute it and/or
 *	modify it under the terms of the GNU General Public License version
 *	2 as published by the Free Software Foundation.
 */

#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/tty.h>
#include <linux/tty_flip.h>
#include <linux/module.h>
#include <linux/usb.h>
#include "usb-serial.h"

static struct usb_device_id id_table [] = {
	{ USB_DEVICE(0xf3d, 0x0112) },  /* AirPrime CDMA Wireless PC Card */
	{ USB_DEVICE(0x1410, 0x1110) }, /* Novatel Wireless Merlin CDMA */
	{ USB_DEVICE(0x1199, 0x0112) }, /* Sierra Wireless Aircard 580 */
	{ },
};
MODULE_DEVICE_TABLE(usb, id_table);

#define URB_TRANSFER_BUFFER_SIZE	4096
#define NUM_READ_URBS			4
#define NUM_WRITE_URBS			4

/* if overridden by the user, then use their value for the size of the
 * read and write urbs */
static int buffer_size = URB_TRANSFER_BUFFER_SIZE;
static int debug;

struct airprime_private {
	spinlock_t lock;
	int outstanding_urbs;
	int throttled;
};

static void airprime_read_bulk_callback(struct urb *urb, struct pt_regs *regs)
{
	struct usb_serial_port *port = urb->context;
	unsigned char *data = urb->transfer_buffer;
	struct tty_struct *tty;
	int result;

	dbg("%s - port %d", __FUNCTION__, port->number);

	if (urb->status) {
		dbg("%s - nonzero read bulk status received: %d",
		    __FUNCTION__, urb->status);
		/* something happened, so free up the memory for this urb (the
		 * urb will go away automatically when we return due to the
		 * reference count drop. */
		kfree(urb->transfer_buffer);
		return;
	}

	usb_serial_debug_data(debug, &port->dev, __FUNCTION__, urb->actual_length, data);

	tty = port->tty;
	if (tty && urb->actual_length) {
		tty_buffer_request_room(tty, urb->actual_length);
		tty_insert_flip_string(tty, data, urb->actual_length);
		tty_flip_buffer_push(tty);
	}

	result = usb_submit_urb(urb, GFP_ATOMIC);
	if (result)
		dev_err(&port->dev, "%s - failed resubmitting read urb, error %d\n",
			__FUNCTION__, result);
	return;
}

static void airprime_write_bulk_callback(struct urb *urb, struct pt_regs *regs)
{
	struct usb_serial_port *port = urb->context;
	struct airprime_private *priv = usb_get_serial_port_data(port);
	unsigned long flags;

	/* free up the transfer buffer, as usb_free_urb() does not do this */
	kfree (urb->transfer_buffer);

	dbg("%s - port %d", __FUNCTION__, port->number);

	if (urb->status)
		dbg("%s - nonzero write bulk status received: %d",
		    __FUNCTION__, urb->status);

	spin_lock_irqsave(&priv->lock, flags);
	--priv->outstanding_urbs;
	spin_unlock_irqrestore(&priv->lock, flags);

	usb_serial_port_softint(port);
}

static int airprime_open(struct usb_serial_port *port, struct file *filp)
{
	struct airprime_private *priv = usb_get_serial_port_data(port);
	struct usb_serial *serial = port->serial;
	struct urb *urb;
	char *buffer;
	int i;
	int result = 0;

	dbg("%s - port %d", __FUNCTION__, port->number);

	/* initialize our private data structure if it isn't already created */
	if (!priv) {
		priv = kzalloc(sizeof(*priv), GFP_KERNEL);
		if (!priv)
			return -ENOMEM;
		spin_lock_init(&priv->lock);
		usb_set_serial_port_data(port, priv);
	}

	/* TODO handle error conditions better, right now we leak memory */
	for (i = 0; i < NUM_READ_URBS; ++i) {
		buffer = kmalloc(buffer_size, GFP_KERNEL);
		if (!buffer) {
			dev_err(&port->dev, "%s - out of memory.\n",
				__FUNCTION__);
			return -ENOMEM;
		}
		urb = usb_alloc_urb(0, GFP_KERNEL);
		if (!urb) {
			dev_err(&port->dev, "%s - no more urbs?\n",
				__FUNCTION__);
			return -ENOMEM;
		}
		usb_fill_bulk_urb(urb, serial->dev,
				  usb_rcvbulkpipe(serial->dev,
				  		  port->bulk_out_endpointAddress),
				  buffer, buffer_size,
				  airprime_read_bulk_callback, port);
		result = usb_submit_urb(urb, GFP_KERNEL);
		if (result) {
			dev_err(&port->dev,
				"%s - failed submitting read urb, error %d\n",
				__FUNCTION__, result);
			return result;
		}
		/* fun with reference counting, when this urb is finished, the
		 * host driver will free it up automatically */
		usb_free_urb (urb);
	}

	return result;
}

static void airprime_close(struct usb_serial_port *port, struct file * filp)
{
	/* free up private structure? */
}

static int airprime_write(struct usb_serial_port *port,
			  const unsigned char *buf, int count)
{
	struct airprime_private *priv = usb_get_serial_port_data(port);
	struct usb_serial *serial = port->serial;
	struct urb *urb;
	unsigned char *buffer;
	unsigned long flags;
	int status;

	dbg("%s - port %d", __FUNCTION__, port->number);

	spin_lock_irqsave(&priv->lock, flags);
	if (priv->outstanding_urbs > NUM_WRITE_URBS) {
		spin_unlock_irqrestore(&priv->lock, flags);
		dbg("%s - write limit hit\n", __FUNCTION__);
		return 0;
	}
	spin_unlock_irqrestore(&priv->lock, flags);

	buffer = kmalloc(count, GFP_ATOMIC);
	if (!buffer) {
		dev_err(&port->dev, "out of memory\n");
		return -ENOMEM;
	}

	urb = usb_alloc_urb(0, GFP_ATOMIC);
	if (!urb) {
		dev_err(&port->dev, "no more free urbs\n");
		kfree (buffer);
		return -ENOMEM;
	}

	memcpy (buffer, buf, count);

	usb_serial_debug_data(debug, &port->dev, __FUNCTION__, count, buffer);

	usb_fill_bulk_urb(urb, serial->dev,
			  usb_sndbulkpipe(serial->dev,
					  port->bulk_out_endpointAddress),
			  buffer, count,
			  airprime_write_bulk_callback, port);

	/* send it down the pipe */
	status = usb_submit_urb(urb, GFP_ATOMIC);
	if (status) {
		dev_err(&port->dev, "%s - usb_submit_urb(write bulk) failed with status = %d\n",
			__FUNCTION__, status);
		count = status;
		kfree (buffer);
	} else {
		spin_lock_irqsave(&priv->lock, flags);
		++priv->outstanding_urbs;
		spin_unlock_irqrestore(&priv->lock, flags);
	}

	/* we are done with this urb, so let the host driver
	 * really free it when it is finished with it */
	usb_free_urb (urb);

	return count;
}


static struct usb_driver airprime_driver = {
	.name =		"airprime",
	.probe =	usb_serial_probe,
	.disconnect =	usb_serial_disconnect,
	.id_table =	id_table,
	.no_dynamic_id = 	1,
};

static struct usb_serial_driver airprime_device = {
	.driver = {
		.owner =	THIS_MODULE,
		.name =		"airprime",
	},
	.id_table =		id_table,
	.num_interrupt_in =	NUM_DONT_CARE,
	.num_bulk_in =		NUM_DONT_CARE,
	.num_bulk_out =		NUM_DONT_CARE,
	.num_ports =		1,
	.open =			airprime_open,
	.close =		airprime_close,
	.write =		airprime_write,
};

static int __init airprime_init(void)
{
	int retval;

	retval = usb_serial_register(&airprime_device);
	if (retval)
		return retval;
	retval = usb_register(&airprime_driver);
	if (retval)
		usb_serial_deregister(&airprime_device);
	return retval;
}

static void __exit airprime_exit(void)
{
	usb_deregister(&airprime_driver);
	usb_serial_deregister(&airprime_device);
}

module_init(airprime_init);
module_exit(airprime_exit);
MODULE_LICENSE("GPL");

module_param(debug, bool, S_IRUGO | S_IWUSR);
MODULE_PARM_DESC(debug, "Debug enabled or not");
module_param(buffer_size, int, 0);
MODULE_PARM_DESC(buffer_size, "Size of the transfer buffers");

--7AUc2qLy4jB3hD7Z--
