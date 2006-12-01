Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161735AbWLAVSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161735AbWLAVSO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 16:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161748AbWLAVSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 16:18:13 -0500
Received: from ns.suse.de ([195.135.220.2]:13537 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161735AbWLAVSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 16:18:12 -0500
Date: Fri, 1 Dec 2006 13:18:01 -0800
From: Greg KH <greg@kroah.com>
To: David Lopez <dave.l.lopez@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] USB: add driver for LabJack USB DAQ devices
Message-ID: <20061201211801.GA448@kroah.com>
References: <571a92f0612011237p35e00be5w832fafb3f824b97a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <571a92f0612011237p35e00be5w832fafb3f824b97a@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 01:37:22PM -0700, David Lopez wrote:
> From: David Lopez <dave.l.lopez@gmail.com>

Please CC: linux-usb-devel for new usb drivers.

> 
> This driver adds support for LabJack U3 and UE9 USB DAQ devices.
> 
> Signed-off-by: David Lopez <dave.l.lopez@gmail.com>
> ---
> Patch against stable 2.6.19 kernel.
> 
> Kconfig  |   15 +
> Makefile |    1
> ljusb.c  |  584 
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 
> diff -uprN -X linux-2.6.19-vanilla/Documentation/dontdiff
> linux-2.6.19-vanilla/drivers/usb/misc/Kconfig
> linux-2.6.19/drivers/usb/misc/Kconfig
> --- linux-2.6.19-vanilla/drivers/usb/misc/Kconfig	2006-11-29
> 14:57:37.000000000 -0700

The patch seems linewrapped, which doesn't make it easy to apply :(

Can you resend this?

> +/* Private defines */
> +#define MAX_TRANSFER			( PAGE_SIZE - 512 )

Any specific reason for this size limit?

> +#define BULK_IN_TIMEOUT			1000	/* default bulk in 
> read timeout */

What units is this timeout in?


> +/**
> + *	ljusb_delete
> + */
> +static void ljusb_delete(struct kref *kref)
> +{	

You have trailing spaces in a number of places.  My tools will strip
them out, but you should be aware of it in the future.

> +	int i;
> +	struct usb_ljusb *dev = to_ljusb_dev(kref);
> +
> +	usb_put_dev(dev->udev);
> +	
> +	for(i = 0; i < N_BULK_IN_ENDPOINTS; ++i)
> +		kfree (dev->bulk_in_buffer[i]);
> +	kfree (dev);

Minor style point.  Please put a space after the "for", but not before
the function call.

So those lines should be redone as:
	for (i = 0; i < N_BULK_IN_ENDPOINTS; ++i)
		kfree(dev->bulk_in_buffer[i]);
	kfree(dev);

Yes, not all portions of the kernel abide by this, but for new code we
are trying to be stricter.

> +static void ljusb_write_bulk_callback(struct urb *urb)
> +{
> +	struct usb_ljusb *dev;
> +
> +	dev = (struct usb_ljusb *)urb->context;
> +
> +	/* sync/async unlink faults aren't errors */
> +	if (urb->status &&
> +	    !(urb->status == -ENOENT ||
> +	      urb->status == -ECONNRESET ||
> +	      urb->status == -ESHUTDOWN)) {
> +		dbg("%s - nonzero write bulk status received: %d",
> +		    __FUNCTION__, urb->status);
> +	}

A switch statement might work a bit better here.  It will let you handle
the different values you might get in a saner way.

> +	/* free up our allocated buffer */
> +	usb_buffer_free(urb->dev, urb->transfer_buffer_length,
> +			urb->transfer_buffer, urb->transfer_dma);
> +	up(&dev->sem);

You hold the semaphore over the urb lifecycle?  Why?  That seems a bit
"odd".

Or is this a bug?

Can't that semaphore be a mutex instead?

> +/**
> + *	ljusb_ioctl
> + */
> +static int ljusb_ioctl (struct inode *inode, struct file *file,
> unsigned int cmd, unsigned long arg)

New ioctls are pretty much frowned apon to add.  Do you _really_ need
these?

Can you use sysfs instead?

> +	/* driver specific commands */
> +	switch (cmd) {
> +		/* Sets the timeout for usb_bulk_msg reads transfers in ms 
> from an integer
> +		 * argument.  If the timeout is set to zero, reads will wait 
> forever */
> +		case IOCTL_LJ_SET_BULK_IN_TIMEOUT:
> +			data = (void __user *) arg;
> +			if (data == NULL)
> +				break;
> +
> +			if (copy_from_user(&timeout, data, sizeof(int))) {
> +				retval = -EFAULT;
> +				break;
> +			}
> +
> +			if(timeout < 0)
> +				retval = -EINVAL;
> +			else
> +				dev->bulk_in_timeout = timeout;
> +				
> +			break;

Is this really needed to be modified?

> +		/* Gets the Product ID for the device */
> +		case IOCTL_LJ_GET_PRODUCT_ID:
> +			retval = put_user(dev->udev->descriptor.idProduct,
> +						(unsigned int __user *)arg);
> +			break;

You can get this from sysfs or usbfs today.  Don't duplicate it please.

> +		/* Sets the bulk in endpoint for the next read from an 
> integer argument.
> +		 * There are two bulk endpoints, which are endpoints 0 and 1 
> when
> +		 * setting the integer argument. */
> +		case IOCTL_LJ_SET_BULK_IN_ENDPOINT:
> +			data = (void __user *) arg;
> +			if (data == NULL)
> +				break;
> +			
> +			if (copy_from_user(&ep, data, sizeof(int))) {
> +				retval = -EFAULT;
> +				break;
> +			}
> +			
> +			if(ep > N_BULK_IN_ENDPOINTS || ep < 0)
> +				retval = -EINVAL;
> +			else
> +				dev->next_bulk_in_endpoint = ep;
> +			break;

Why is this needed?

> +		if(j < N_BULK_IN_ENDPOINTS)
> +		{

{ should be on the same line as the 'if'.  Also please add a space after
the 'if', like you did on the next line:

> +			if (!dev->bulk_in_endpointAddr[j] &&
> +				((endpoint->bEndpointAddress & 
> USB_ENDPOINT_DIR_MASK)
> +						== USB_DIR_IN) &&
> +			    	((endpoint->bmAttributes & 
> USB_ENDPOINT_XFERTYPE_MASK)
> +						== USB_ENDPOINT_XFER_BULK)) {

We have functions to check for direction and endpoint type now.  Please
use them instead.

thanks,

greg k-h
