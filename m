Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269706AbTGOVPU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 17:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269698AbTGOVPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 17:15:19 -0400
Received: from mail.kroah.org ([65.200.24.183]:42719 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269736AbTGOVNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 17:13:45 -0400
Date: Tue, 15 Jul 2003 14:20:05 -0700
From: Greg KH <greg@kroah.com>
To: Michael Hunold <hunold@convergence.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Add two drivers for USB based DVB-T adapters
Message-ID: <20030715212005.GA5458@kroah.com>
References: <10582891731946@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10582891731946@convergence.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 07:12:53PM +0200, Michael Hunold wrote:
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
> +static void *ttusb_probe(struct usb_device *udev, unsigned int ifnum,
> +		  const struct usb_device_id *id)
> +{
> +	struct ttusb *ttusb;
> +	int result, channel;
> +
> +	if (ifnum != 0)
> +		return NULL;
> +
> +	dprintk("%s: TTUSB DVB connected\n", __FUNCTION__);
> +
> +	if (!(ttusb = kmalloc(sizeof(struct ttusb), GFP_KERNEL)))
> +		return NULL;
> +
> +#else
> +static int ttusb_probe(struct usb_interface *intf, const struct usb_device_id *id)
> +{
> +	struct usb_device *udev;
> +	struct ttusb *ttusb;
> +	int result, channel;
> +
> +	dprintk("%s: TTUSB DVB connected\n", __FUNCTION__);
> +
> +	udev = interface_to_usbdev(intf);
> +
> +	if (!(ttusb = kmalloc(sizeof(struct ttusb), GFP_KERNEL)))
> +		return -ENOMEM;
> +
> +#endif

Ick, you don't really want to try to support all of the USB changes in
the same driver, now do you?  Why not just live with two different
drivers.

The ALSA people eventually gave up trying to do this... :)

> +#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,69))
> +#undef devfs_remove
> +#define devfs_remove(x)	devfs_unregister(ttusb->stc_devfs_handle);
> +#endif
> +#if 0
> +	devfs_remove(TTUSB_BUDGET_NAME);
> +#endif

You end up with crud like this because of trying to support old kernels.
Why do you care about kernels prior to 2.5.69?  If so, your USB kernel
checks are wrong, as 2.5.0 didn't have those API changes :)

thanks,

greg k-h
