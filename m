Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264715AbSJ3QE7>; Wed, 30 Oct 2002 11:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264718AbSJ3QE7>; Wed, 30 Oct 2002 11:04:59 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:40849 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S264715AbSJ3QE5>;
	Wed, 30 Oct 2002 11:04:57 -0500
Date: Wed, 30 Oct 2002 17:11:17 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Zephaniah E. Hull" <warp@mercury.d2dc.net>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Problem with mousedev.c
Message-ID: <20021030171117.A12597@ucw.cz>
References: <20021027010538.GA1690@babylon.d2dc.net> <20021028184008.B32183@ucw.cz> <20021030153257.GA27585@babylon.d2dc.net> <20021030165922.A12505@ucw.cz> <20021030160440.GA27563@babylon.d2dc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021030160440.GA27563@babylon.d2dc.net>; from warp@mercury.d2dc.net on Wed, Oct 30, 2002 at 11:04:40AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 11:04:40AM -0500, Zephaniah E. Hull wrote:

> On Wed, Oct 30, 2002 at 04:59:22PM +0100, Vojtech Pavlik wrote:
> > On Wed, Oct 30, 2002 at 10:32:57AM -0500, Zephaniah E. Hull wrote:
> > > Sadly, if PS/2 mice are any indication, mouse makers /will/ manage to
> > > fuck things up on enough popular mice under USB as well, and there needs
> > > to be a place to shove the dirty hacks needed to make things Just Work
> > > for users..
> > 
> > That place would be hid-input.c and psmouse.c. NOT mousedev.c.
> 
> Agreed, at the moment my patch for dealing with the A4 mouse hits three
> files in the HID layer, and is not the cleanest, however it is attached
> for reference.

The patch is quite OK, it should not report BTN_BACK to userspace,
though, and also it should not depend on the hid-input.c assigning
BTN_BACK to the button which specifies the wheel.

> Now if I could only find (better) documentation on the various PS2
> protocols to find one that has in the spec itself handling for multiple
> wheels..
> 
> -- 
> 	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
> 	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
> 	    CCs of replies from mailing lists are requested.
> 
> "I would rather spend 10 hours reading someone else's source code than
> 10 minutes listening to Musak waiting for technical support which
> isn't."
> (By Dr. Greg Wettstein, Roger Maris Cancer Center)

> diff -ur linux.orig/drivers/usb/hid-core.c linux/drivers/usb/hid-core.c
> --- linux.orig/drivers/usb/hid-core.c	2002-10-26 20:31:21.000000000 -0400
> +++ linux/drivers/usb/hid-core.c	2002-10-27 01:45:04.000000000 -0400
> @@ -1086,6 +1086,8 @@
>  #define USB_DEVICE_ID_ATEN_2PORTKVM	0x2204
>  #define USB_DEVICE_ID_ATEN_4PORTKVM	0x2205
>  
> +#define USB_VENDOR_ID_A4TECH		0x09DA
> +#define USB_DEVICE_ID_A4TECH_WCP32PU	0x0006
>  struct hid_blacklist {
>  	__u16 idVendor;
>  	__u16 idProduct;
> @@ -1115,6 +1117,7 @@
>  	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS124U, HID_QUIRK_NOGET },
>  	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_2PORTKVM, HID_QUIRK_NOGET },
>  	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVM, HID_QUIRK_NOGET },
> +	{ USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_WCP32PU, HID_QUIRK_2WHEEL_MOUSE_HACK },
>  	{ 0, 0 }
>  };
>  
> diff -ur linux.orig/drivers/usb/hid-input.c linux/drivers/usb/hid-input.c
> --- linux.orig/drivers/usb/hid-input.c	2001-11-11 13:09:37.000000000 -0500
> +++ linux/drivers/usb/hid-input.c	2002-10-27 03:36:52.000000000 -0500
> @@ -269,6 +269,11 @@
>  	}
>  
>  	set_bit(usage->type, input->evbit);
> +	if ((usage->type == EV_REL)
> +			&& (device->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK)
> +			&& (usage->code == REL_WHEEL)) {
> +		set_bit(REL_HWHEEL, bit);
> +	}
>  
>  	while (usage->code <= max && test_and_set_bit(usage->code, bit)) {
>  		usage->code = find_next_zero_bit(bit, max + 1, usage->code);
> @@ -303,6 +308,20 @@
>  	struct input_dev *input = &hid->input;
>  	int *quirks = &hid->quirks;
>  
> +	if ((hid->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK)
> +			&& (usage->code == BTN_BACK)) {
> +		if (value)
> +			hid->quirks |= HID_QUIRK_2WHEEL_MOUSE_HACK_ON;
> +		else
> +			hid->quirks &= ~HID_QUIRK_2WHEEL_MOUSE_HACK_ON;
> +		return;
> +	}
> +	if ((hid->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK_ON)
> +			&& (usage->code == REL_WHEEL)) {
> +		input_event(input, usage->type, REL_HWHEEL, value);
> +		return;
> +	}
> +
>  	if (usage->hat_min != usage->hat_max) {
>  		value = (value - usage->hat_min) * 8 / (usage->hat_max - usage->hat_min + 1) + 1;
>  		if (value < 0 || value > 8) value = 0;
> diff -ur linux.orig/drivers/usb/hid.h linux/drivers/usb/hid.h
> --- linux.orig/drivers/usb/hid.h	2002-10-26 20:31:21.000000000 -0400
> +++ linux/drivers/usb/hid.h	2002-10-27 01:43:23.000000000 -0400
> @@ -186,6 +186,8 @@
>  #define HID_QUIRK_NOTOUCH	0x02
>  #define HID_QUIRK_IGNORE	0x04
>  #define HID_QUIRK_NOGET		0x08
> +#define HID_QUIRK_2WHEEL_MOUSE_HACK	0x10
> +#define HID_QUIRK_2WHEEL_MOUSE_HACK_ON	0x20
>  
>  /*
>   * This is the global enviroment of the parser. This information is




-- 
Vojtech Pavlik
SuSE Labs
