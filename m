Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVBFTSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVBFTSi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 14:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVBFTSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 14:18:36 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:8686 "EHLO suse.de")
	by vger.kernel.org with ESMTP id S261284AbVBFTHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 14:07:06 -0500
Date: Sun, 6 Feb 2005 20:07:24 +0100
From: Vojtech Pavlik <vojtech@suse.de>
To: Mikkel Krautz <krautz@gmail.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH] hid-core: Configurable USB HID Mouse Interrupt Polling Interval
Message-ID: <20050206190724.GL23126@ucw.cz>
References: <1103335970.15567.15.camel@localhost> <20041218012725.GB25628@kroah.com> <41C46B4D.5040506@gmail.com> <20041218165331.GA7737@kroah.com> <d4b385204121817521b0df40f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4b385204121817521b0df40f@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 19, 2004 at 01:52:06AM +0000, Mikkel Krautz wrote:
> On Sat, 18 Dec 2004 08:53:31 -0800, Greg KH <greg@kroah.com> wrote:
> > On Sat, Dec 18, 2004 at 05:39:25PM +0000, Mikkel Krautz wrote:
> > > On Fri, 17 Dec 2004 18:59:48 -0800, Greg KH <greg@kroah.com> wrote:
> > > > What about makeing it a module paramater then, that is exported to
> > > > sysfs?  That makes it easier to adjust on the fly (before the mouse is
> > > > inserted), and doesn't require the kernel to be rebuilt.
> > >
> > > I really like the idea. I'm start to think that this is the ideal way to
> > > accomplish this.
> > >
> > > Here's a new patch. Let's hope it doesn't wrap!
> > 
> > It was eaten :(
> > 
> > > module_init(hid_init);
> > > module_exit(hid_exit);
> > > +module_param(hid_mouse_polling_interval, int, 644);
> > 
> > 0644, or use the proper #defines instead.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Here's an updated version, with your and Marcel's suggestions:

Some more suggestions:

A MODULE_PARM_DESC() would be good, as well as a patch to
kernel-parameters.txt.

Also, it'd be better instead of changing the bInterval in the endpoint
descriptor to change the "interval" variable. This way one wouldn't need
to think about whether the device is Full-speed or High-speed when
setting the parameter. Also the endpoint descriptor should be considered
read only. 

> Signed-off-by: Mikkel Krautz <krautz@gmail.com>
> ---
> 
> 
>  hid-core.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletion(-)
> 
> 
> --- clean/drivers/usb/input/hid-core.c
> +++ dirty/drviers/usb/input/hid-core.c
> @@ -37,11 +37,12 @@
>   * Version Information
>   */
>  
> -#define DRIVER_VERSION "v2.0"
> +#define DRIVER_VERSION "v2.01"
>  #define DRIVER_AUTHOR "Andreas Gal, Vojtech Pavlik"
>  #define DRIVER_DESC "USB HID core driver"
>  #define DRIVER_LICENSE "GPL"
>  
> +static unsigned int hid_mousepoll_interval;
>  static char *hid_types[] = {"Device", "Pointer", "Mouse", "Device", "Joystick",
>  				"Gamepad", "Keyboard", "Keypad", "Multi-Axis Controller"};
>  
> @@ -1663,6 +1664,11 @@
>  		if ((endpoint->bmAttributes & 3) != 3)		/* Not an interrupt endpoint */
>  			continue;
>  
> +		/* Change the polling interval of mice. */
> +		if (hid->collection->usage == HID_GD_MOUSE
> +				&& hid_mousepoll_interval > 0)
> +			endpoint->bInterval = hid_mousepoll_interval;
> +		
>  		/* handle potential highspeed HID correctly */
>  		interval = endpoint->bInterval;
>  		if (dev->speed == USB_SPEED_HIGH)
> @@ -1910,6 +1916,7 @@
>  
>  module_init(hid_init);
>  module_exit(hid_exit);
> +module_param_named(mousepoll, hid_mousepoll_interval, uint, 0644);
>  
>  MODULE_AUTHOR(DRIVER_AUTHOR);
>  MODULE_DESCRIPTION(DRIVER_DESC);
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
