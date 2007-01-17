Return-Path: <linux-kernel-owner+w=401wt.eu-S1751836AbXAQV52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbXAQV52 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 16:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbXAQV52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 16:57:28 -0500
Received: from mx1.suse.de ([195.135.220.2]:54887 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751825AbXAQV51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 16:57:27 -0500
Date: Wed, 17 Jan 2007 13:56:35 -0800
From: Greg KH <greg@kroah.com>
To: Kevin Lloyd <klloyd@sierrawireless.com>
Cc: gregkh@suse.de, linux-usb-devel@lists.sourceforge.net,
       linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, Peter Kucmeroski <PKucmeroski@novell.com>,
       Jason Ganovsky <JGanovsky@novell.com>
Subject: Re: [PATCH 2.6.20-rc3 01/01] usb: Sierra Wireless auto set D0
Message-ID: <20070117215635.GA14495@kroah.com>
References: <45AC2B68.9060904@sierrawireless.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45AC2B68.9060904@sierrawireless.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2007 at 05:33:28PM -0800, Kevin Lloyd wrote:
> from: Kevin Lloyd <linux@sierrawireless.com>
> 
> This patch ensures that the device is turned on when inserted into the 
> system (which mostly affects the EM5725 and MC5720. It also adds more 
> VID/PIDs and matches the N_OUT_URB with the airprime driver.
> 
> Signed-off-by: Kevin Lloyd <linux@sierrawireless.com>
> 
> ---
> 
> --- linux-2.6.20-rc5/drivers/usb/serial/sierra.c.orig	2007-01-15 
> 15:17:15.000000000 -0800
> +++ linux-2.6.20-rc5/drivers/usb/serial/sierra.c	2007-01-15 
> 15:41:56.000000000 -0800
> @@ -14,9 +14,31 @@
>   Whom based his on the Keyspan driver by Hugh Blemings <hugh@blemings.org>
> 
>   History:
> +v.1.0.6:
> + klloyd
> + Added more devices and added Vendor Specific USB message to make sure
> + that devices are in D0 state when they start. This is very important for
> + MC5720 and EM5625 modules that go between Windows and Non-Windows 
> + machines.
> +v.1.0.5:
> + Greg KH
> + This saves over 30 lines and fixes a warning from sparse and allows
> + debugging to work dynamically like all other usb-serial drivers.
> + klloyd
> + Changed versioning to v.x.y.z
> +v.1.04:
> + klloyd
> + Adds significant throughput increase to the Sierra driver (uses multiple
> + urgs for download link). This patch also updates the current sierra.c 
> + driver so that it supports both 3-port Sierra devices and 1-port legacy
> + devices and removes Sierra's references in other related files (Kconfig
> + and airprime.c).
> +v.1.03
> + klloyd
> + Adds DTR line control support and impliments urb control.

This is not needed, nor recommended.  The changelog information in the
kernel provides this information.

> 
> -#define DRIVER_VERSION "v.1.0.5"
> +#define DRIVER_VERSION "v.1.0.6"
> #define DRIVER_AUTHOR "Kevin Lloyd <linux@sierrawireless.com>"
> #define DRIVER_DESC "USB Driver for Sierra Wireless USB modems"
> 
> @@ -31,14 +53,14 @@
> 
> 
> static struct usb_device_id id_table [] = {
> +	{ USB_DEVICE(0x1199, 0x0017) },	/* Sierra Wireless EM5625 */
> 	{ USB_DEVICE(0x1199, 0x0018) },	/* Sierra Wireless MC5720 */
> 	{ USB_DEVICE(0x1199, 0x0020) },	/* Sierra Wireless MC5725 */
> -	{ USB_DEVICE(0x1199, 0x0017) },	/* Sierra Wireless EM5625 */
> 	{ USB_DEVICE(0x1199, 0x0019) },	/* Sierra Wireless AirCard 595 */
> -	{ USB_DEVICE(0x1199, 0x0218) },	/* Sierra Wireless MC5720 */

You are dropping support for this device id.  Is that correct?  Are you
sure?

It was reported to me by Peter Kucmeroski and Jason Ganovsky, and you
were CCed when the patch went into the kernel that added this id.

> @@ -123,6 +145,7 @@ static int sierra_send_setup(struct usb_
> 		return usb_control_msg(serial->dev,
> 				usb_rcvctrlpipe(serial->dev, 0),
> 				0x22,0x21,val,0,NULL,0,USB_CTRL_SET_TIMEOUT);
> +
> 	}
> 
> 	return 0;

Is this change really needed?  :)


> @@ -396,6 +419,8 @@ static int sierra_open(struct usb_serial
> 	struct usb_serial *serial = port->serial;
> 	int i, err;
> 	struct urb *urb;
> +	int result;
> +	__u16 set_mode_dzero = 0x0000; //Set mode to D0

// comments are not recommended in the kernel, especially for something
as trivial as a variable name.

> 	portdata = usb_get_serial_port_data(port);
> 
> @@ -442,6 +467,11 @@ static int sierra_open(struct usb_serial
> 
> 	port->tty->low_latency = 1;
> 
> +	//set mode to D0

Use /* */ please.

Care to resubmit this?

thanks,

greg k-h
