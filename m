Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbVKWQ6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbVKWQ6Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbVKWQ6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:58:16 -0500
Received: from styx.suse.cz ([82.119.242.94]:35526 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932097AbVKWQ6P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:58:15 -0500
Date: Wed, 23 Nov 2005 17:58:13 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Hans-Christian Egtvedt <hc@mivu.no>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 2.6.14.2] Updated itmtouch kernel usb input driver (1/1)
Message-ID: <20051123165813.GA3201@ucw.cz>
References: <1132764764.6394.14.camel@charlie.egtvedt.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132764764.6394.14.camel@charlie.egtvedt.no>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 05:52:44PM +0100, Hans-Christian Egtvedt wrote:
> I have made a new release of the itmtouch driver, version 1.3.1. Basicly
> just some parameters accesable for users to ease usability and
> compatibility with X.
> 
> Attached is the patch against Linux 2.6.14.2.
> 
> For full source please download:
> http://www.mivu.no/itmtouch/itmtouch-1.3.1.tar.bz2
> http://www.mivu.no/itmtouch/itmtouch-1.3.1.tar.gz
> 
> I have testet the driver with my LG L1510SF touch screen and it works.
> Any feedback is most welcome.

Disabling input_sync() is wrong. Very wrong. If you're trying to do it
instead of debouncing, do the debouncing. While I believe processing of
events doesn't belong into the driver, fixing hardware deficiencies does
to a certain degree.

> -- 
> Best regards
> Hans-Christian Egtvedt

> --- /usr/src/linux-2.6.14.2/drivers/usb/input/itmtouch.c	2005-11-23 16:02:55.000000000 +0100
> +++ itmtouch.c	2005-11-23 17:16:09.000000000 +0100
> @@ -22,15 +22,27 @@
>   * driver. CC -- 2003/9/29
>   *
>   * History
> - * 1.0 & 1.1 2003 (CC) vojtech@suse.cz
> - *   Original version for 2.4.x kernels
> + * 1.0 & 1.1    2003 (CC) vojtech@suse.cz
> + *   - Original version for 2.4.x kernels
>   *
> - * 1.2 02/03/2005 (HCE) hc@mivu.no
> - *   Complete rewrite to support Linux 2.6.10, thanks to mtouchusb.c for hints.
> - *   Unfortunately no calibration support at this time.
> + * 1.2    02/03/2005 (HCE) hc@mivu.no
> + *   - Complete rewrite to support Linux 2.6.10, thanks to mtouchusb.c for hints.
> + *   - Unfortunately no calibration support at this time.
>   *
>   * 1.2.1  09/03/2005 (HCE) hc@mivu.no
> - *   Code cleanup and adjusting syntax to start matching kernel standards
> + *   - Code cleanup and adjusting syntax to start matching kernel standards
> + *
> + * 1.2.2  10/03/2005 (HCE) hc@mivu.no
> + *   - Code cleanup
> + *
> + * 1.3    17/03/2005 (HCE) hc@mivu.no
> + *   - Added parameter for swapping X- and Y-axis (swapxy).
> + *   - General code cleanup
> + *
> + * 1.3.1  23/11/2005 (HCE) hc@mivu.no
> + *   - Added parameter nosync for disabling input_sync. Panel is unusable
> + *     without this, but people should be able to chose.
> + *   - Added swapx and swapy to make it easier to adopt to X drivers
>   *
>   *****************************************************************************/
>  
> @@ -52,13 +64,15 @@
>  
>  /* only an 8 byte buffer necessary for a single packet */
>  #define ITM_BUFSIZE			8
> +/* support a maximum of 4 such touchscreens at once */
> +#define MAXTOUCH			4
>  #define PATH_SIZE			64
>  
>  #define USB_VENDOR_ID_ITMINC		0x0403
>  #define USB_PRODUCT_ID_TOUCHPANEL	0xf9e9
>  
>  #define DRIVER_AUTHOR "Hans-Christian Egtvedt <hc@mivu.no>"
> -#define DRIVER_VERSION "v1.2.1"
> +#define DRIVER_VERSION "v1.3.1"
>  #define DRIVER_DESC "USB ITM Inc Touch Panel Driver"
>  #define DRIVER_LICENSE "GPL"
>  
> @@ -66,14 +80,25 @@
>  MODULE_DESCRIPTION( DRIVER_DESC );
>  MODULE_LICENSE( DRIVER_LICENSE );
>  
> +static int swapxy, swapx, swapy, nosync;
> +
> +module_param(swapxy, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
> +MODULE_PARM_DESC(swapxy, "If set the X- and Y-axis are swapped.");
> +module_param(swapx, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
> +MODULE_PARM_DESC(swapx, "If set the X-axis is reversed in direction.");
> +module_param(swapy, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
> +MODULE_PARM_DESC(swapy, "If set the Y-axis is reversed in direction.");
> +module_param(nosync, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
> +MODULE_PARM_DESC(nosync, "If set input_sync is disabled.");
> +
>  struct itmtouch_dev {
>  	struct usb_device	*usbdev; /* usb device */
>  	struct input_dev	inputdev; /* input device */
>  	struct urb		*readurb; /* urb */
>  	char			rbuf[ITM_BUFSIZE]; /* data */
>  	int			users;
> -	char name[128];
> -	char phys[64];
> +	char			name[128];
> +	char			phys[64];
>  };
>  
>  static struct usb_device_id itmtouch_ids [] = {
> @@ -83,17 +108,18 @@
>  
>  static void itmtouch_irq(struct urb *urb, struct pt_regs *regs)
>  {
> -	struct itmtouch_dev * itmtouch = urb->context;
> -	unsigned char *data = urb->transfer_buffer;
> +	struct itmtouch_dev *itmtouch = urb->context;
>  	struct input_dev *dev = &itmtouch->inputdev;
> +	unsigned int x, y, abs, button;
>  	int retval;
> +	u8 *data;
>  
>  	switch (urb->status) {
>  	case 0:
>  		/* success */
>  		break;
>  	case -ETIMEDOUT:
> -		/* this urb is timing out */
> +		/* this urb is timing out, device unplugged? */
>  		dbg("%s - urb timed out - was the device unplugged?",
>  		    __FUNCTION__);
>  		return;
> @@ -110,33 +136,65 @@
>  		goto exit;
>  	}
>  
> +	data = (u8 *)(urb->transfer_buffer);
> +
> +	if (swapx)
> +		x = (data[1] & 0x1F) << 7 | (data[4] & 0x7F);
> +	else
> +		x = 4096 - ((data[1] & 0x1F) << 7 | (data[4] & 0x7F));
> +
> +	if (swapy)
> +		y = 4096 - ((data[0] & 0x1F) << 7 | (data[3] & 0x7F));
> +	else
> +		y = (data[0] & 0x1F) << 7 | (data[3] & 0x7F);
> +
> +	abs = (data[2] & 0x1) << 7 | (data[5] & 0x7F);
> +
> +	/* Value is 0x80 when pressed and 0xA0 when released */
> +	button = !(data[7] & 0x20);
> +
>  	input_regs(dev, regs);
>  
> -	/* if pressure has been released, then don't report X/Y */
> -	if (data[7] & 0x20) {
> -		input_report_abs(dev, ABS_X, (data[0] & 0x1F) << 7 | (data[3] & 0x7F));
> -		input_report_abs(dev, ABS_Y, (data[1] & 0x1F) << 7 | (data[4] & 0x7F));
> +	if (button) {
> +		if (swapxy) {
> +			input_report_abs(dev, ABS_X, y);
> +			input_report_abs(dev, ABS_Y, x);
> +		}
> +		else {
> +			input_report_abs(dev, ABS_X, x);
> +			input_report_abs(dev, ABS_Y, y);
> +		}
>  	}
>  
> -	input_report_abs(dev, ABS_PRESSURE, (data[2] & 1) << 7 | (data[5] & 0x7F));
> -	input_report_key(dev, BTN_TOUCH, ~data[7] & 0x20);
> -	input_sync(dev);
> +	input_report_abs(dev, ABS_PRESSURE, abs);
> +	input_report_key(dev, BTN_TOUCH, button);
> +
> +	/* Only use input_sync() if specified by user, this breaks the behavior
> +	 * of the panel. If you are experiencing double clicks, turn off sync. */
> +	if (!nosync)
> +		input_sync(dev);
>  
>  exit:
> -	retval = usb_submit_urb (urb, GFP_ATOMIC);
> +	retval = usb_submit_urb(urb, GFP_ATOMIC);
>  	if (retval)
>  		printk(KERN_ERR "%s - usb_submit_urb failed with result: %d",
> -				__FUNCTION__, retval);
> +		       __FUNCTION__, retval);
>  }
>  
>  static int itmtouch_open(struct input_dev *input)
>  {
>  	struct itmtouch_dev *itmtouch = input->private;
>  
> +	if (itmtouch->users++)
> +		return 0;
> +
>  	itmtouch->readurb->dev = itmtouch->usbdev;
>  
>  	if (usb_submit_urb(itmtouch->readurb, GFP_KERNEL))
> +	{
> +		itmtouch->users--;
>  		return -EIO;
> +	}
>  
>  	return 0;
>  }
> @@ -145,7 +203,8 @@
>  {
>  	struct itmtouch_dev *itmtouch = input->private;
>  
> -	usb_kill_urb(itmtouch->readurb);
> +	if (!--itmtouch->users)
> +		usb_kill_urb(itmtouch->readurb);
>  }
>  
>  static int itmtouch_probe(struct usb_interface *intf, const struct usb_device_id *id)
> @@ -158,13 +217,18 @@
>  	unsigned int maxp;
>  	char path[PATH_SIZE];
>  
> +	/* Setting interface */
>  	interface = intf->cur_altsetting;
> +
> +	/* Setting endpoint */
>  	endpoint = &interface->endpoint[0].desc;
>  
> -	if (!(itmtouch = kzalloc(sizeof(struct itmtouch_dev), GFP_KERNEL))) {
> +	/* allocate memory space */
> +	if (!(itmtouch = kmalloc(sizeof(struct itmtouch_dev), GFP_KERNEL))) {
>  		err("%s - Out of memory.", __FUNCTION__);
>  		return -ENOMEM;
>  	}
> +	memset(itmtouch, 0, sizeof(struct itmtouch_dev));
>  
>  	itmtouch->usbdev = udev;
>  
> @@ -180,7 +244,10 @@
>  
>  	itmtouch->inputdev.name = itmtouch->name;
>  	itmtouch->inputdev.phys = itmtouch->phys;
> -	usb_to_input_id(udev, &itmtouch->inputdev.id);
> +	itmtouch->inputdev.id.bustype = BUS_USB;
> +	itmtouch->inputdev.id.vendor = udev->descriptor.idVendor;
> +	itmtouch->inputdev.id.product = udev->descriptor.idProduct;
> +	itmtouch->inputdev.id.version = udev->descriptor.bcdDevice;
>  	itmtouch->inputdev.dev = &intf->dev;
>  
>  	if (!strlen(itmtouch->name))
> @@ -199,8 +266,10 @@
>  	pipe = usb_rcvintpipe(itmtouch->usbdev, endpoint->bEndpointAddress);
>  	maxp = usb_maxpacket(udev, pipe, usb_pipeout(pipe));
>  
> -	if (maxp > ITM_BUFSIZE)
> +	if (maxp > ITM_BUFSIZE) {
> +		printk(KERN_WARNING "itmtouch: WARNING: packet size > ITM_BUFSIZE\n");
>  		maxp = ITM_BUFSIZE;
> +	}
>  
>  	itmtouch->readurb = usb_alloc_urb(0, GFP_KERNEL);
>  
> @@ -210,12 +279,18 @@
>  		return -ENOMEM;
>  	}
>  
> -	usb_fill_int_urb(itmtouch->readurb, itmtouch->usbdev, pipe, itmtouch->rbuf,
> -			 maxp, itmtouch_irq, itmtouch, endpoint->bInterval);
> +	usb_fill_int_urb(itmtouch->readurb,
> +			itmtouch->usbdev,
> +			pipe,
> +			itmtouch->rbuf,
> +			maxp,
> +			itmtouch_irq,
> +			itmtouch,
> +			endpoint->bInterval);
>  
>  	input_register_device(&itmtouch->inputdev);
>  
> -	printk(KERN_INFO "itmtouch: %s registered on %s\n", itmtouch->name, path);
> +	printk(KERN_INFO "itmtouch: %s on %s\n", itmtouch->name, path);
>  	usb_set_intfdata(intf, itmtouch);
>  
>  	return 0;


-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
