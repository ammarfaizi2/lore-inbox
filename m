Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965172AbWIEGQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbWIEGQO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 02:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965174AbWIEGQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 02:16:14 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:10860 "EHLO
	asav12.insightbb.com") by vger.kernel.org with ESMTP
	id S965172AbWIEGQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 02:16:13 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FAIyy/ESBToldLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Adam Buchbinder <adam.buchbinder@gmail.com>
Subject: Re: [PATCH 2.6.17.11] xpad: dance pad support
Date: Tue, 5 Sep 2006 02:16:09 -0400
User-Agent: KMail/1.9.3
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       linux-input@atrey.karlin.mff.cuni.cz
References: <44FBB387.6090705@gmail.com>
In-Reply-To: <44FBB387.6090705@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609050216.10383.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 September 2006 01:03, Adam Buchbinder wrote:
> +
> +config USB_XPAD_DPAD_MAPPING
> +        bool "Map d-pad to axes for unkown xbox pads"
> +        default y
> +        depends on USB_XPAD

This should be a module parameter, not compile-time option.

> + *
> + * 2005-03-15 - 0.0.6 : Dom's patch: d-pad handling for dance style pads
> + *  - old handler mapped d-pad to axes, but some dance style games
> + *    need to know when you are pressing both left+right or up+down
> + *  - mapping of d-pad to buttons or axes now done
> + *    on the fly via product/vendor ID's
> + *  - for (known) dance pads, the mapping is d-pads to buttons, for all
> + *    others, mapping defaults to axes to make things easier.
> + *  - added 'Redoctane Xbox Dance Pad' USB ID's (props to helpful techs)
> + *  - added 'Microsoft smaller Xbox Pad' USB ID's
>   */

Please kill changelog from the source code - we have SCM to fetch this data
from.
>  
>  #include <linux/config.h>
> @@ -64,26 +75,44 @@
>  #include <linux/usb.h>
>  #include <linux/usb_input.h>
>  
> -#define DRIVER_VERSION "v0.0.5"
> +#define DRIVER_VERSION "v0.0.6"
>  #define DRIVER_AUTHOR "Marko Friedemann <mfr@bmx-chemnitz.de>"
>  #define DRIVER_DESC "X-Box pad driver"
>  
> +
> +

Extra whitespace?

>  #define XPAD_PKT_LEN 32
>  
> +/* xbox d-pads should map to buttons, as is required for DDR pads
> +   but we map them to axes when possible to simplify things */
> +#define MAP_DPAD_TO_BUTTONS    0
> +#define MAP_DPAD_TO_AXES       1
> +#define MAP_DPAD_DEFAULT       CONFIG_USB_XPAD_DPAD_MAPPING    /* from
> config */
> +
> +#define FAKE_ENTRY             -2
> +
>  static const struct xpad_device {
>          u16 idVendor;
>          u16 idProduct;
>          char *name;
> +        int dpad_mapping;
>  } xpad_device[] = {
> -        { 0x045e, 0x0202, "Microsoft X-Box pad (US)" },
> -        { 0x045e, 0x0285, "Microsoft X-Box pad (Japan)" },
> -        { 0x05fd, 0x107a, "InterAct 'PowerPad Pro' X-Box pad (Germany)" },
> -        { 0x0000, 0x0000, "X-Box pad" }
> +        { 0x045e, 0x0202, "Microsoft X-Box pad v1 (US)",
> MAP_DPAD_TO_AXES },

Patch still wordwrapped :(

> +        { 0x045e, 0x0289, "Microsoft X-Box pad v2 (US)",
> MAP_DPAD_TO_AXES },
> +        { 0x045e, 0x0285, "Microsoft X-Box pad (Japan)",
> MAP_DPAD_TO_AXES },
> +        { 0x05fd, 0x107a, "InterAct 'PowerPad Pro' X-Box pad
> (Germany)", MAP_DPAD_TO_AXES },
> +        { 0x0c12, 0x8809, "RedOctane Xbox Dance Pad",
> MAP_DPAD_TO_BUTTONS },
> +        { 0x0000, 0x0000, "Generic X-Box pad", MAP_DPAD_DEFAULT }
>  };
>  
>  static const signed short xpad_btn[] = {
>          BTN_A, BTN_B, BTN_C, BTN_X, BTN_Y, BTN_Z,        /* "analog"
> buttons */
>          BTN_START, BTN_BACK, BTN_THUMBL, BTN_THUMBR,        /*
> start/back/sticks */
> +        FAKE_ENTRY,                                     /* (break entry) */
> +                                                        /* only used if
> MAP_DPAD_TO_BUTTONS */
> +
> +        BTN_LEFT, BTN_RIGHT,                            /* d-pad left,
> right */
> +        BTN_0, BTN_1,                                   /* d-pad up,
> down (XXX names??) */
>          -1                                                /*
> terminating entry */
>  };
>  
> @@ -92,7 +121,11 @@ static const signed short xpad_abs[] = {
>          ABS_RX, ABS_RY,                /* right stick */
>          ABS_Z, ABS_RZ,                /* triggers left/right */
>          ABS_HAT0X, ABS_HAT0Y,        /* digital pad */
> -        -1                        /* terminating entry */
> +        FAKE_ENTRY,             /* (break entry) */
> +                                /* only used if MAP_DPAD_TO_AXES */
> +
> +        ABS_HAT0X, ABS_HAT0Y,   /* d-pad axes */
> +        -1                      /* terminating entry */
>  };
>  
>  static struct usb_device_id xpad_table [] = {
> @@ -111,6 +144,8 @@ struct usb_xpad {
>          dma_addr_t idata_dma;
>  
>          char phys[65];                                /* physical
> device path */
> +        
> +        int dpad_mapping;                       /* whether to map d-pad
> to buttons or axes */
>  };
>  
>  /*
> @@ -142,8 +177,15 @@ static void xpad_process_packet(struct u
>          input_report_abs(dev, ABS_RZ, data[11]);
>  
>          /* digital pad */
> -        input_report_abs(dev, ABS_HAT0X, !!(data[2] & 0x08) -
> !!(data[2] & 0x04));
> -        input_report_abs(dev, ABS_HAT0Y, !!(data[2] & 0x02) -
> !!(data[2] & 0x01));
> +        if (xpad->dpad_mapping == MAP_DPAD_TO_AXES) {
> +                input_report_abs(dev, ABS_HAT0X, !!(data[2] & 0x08) -
> !!(data[2] & 0x04));
> +                input_report_abs(dev, ABS_HAT0Y, !!(data[2] & 0x02) -
> !!(data[2] & 0x01));
> +        } else if (xpad->dpad_mapping == MAP_DPAD_TO_BUTTONS) {

That second if test is not needed (there is only 2 mapping modes, right?)

> +                input_report_key(dev, BTN_LEFT, (data[2] & 0x04) >> 2);

No need to shift the result. input_report_key expects 0/non-0 argument.

> // left

Comment is not needed (one can infer that we dealing with left button
from BTN_LEFT constant)

> +                input_report_key(dev, BTN_RIGHT,(data[2] & 0x08) >> 3);
> // right
> +                input_report_key(dev, BTN_0,    (data[2] & 0x01)); // up
> +                input_report_key(dev, BTN_1,    (data[2] & 0x02) >> 1);
> // down
> +        }
>  
>          /* start/back buttons and stick press left/right */
>          input_report_key(dev, BTN_START, (data[2] & 0x10) >> 4);
> @@ -240,6 +282,7 @@ static int xpad_probe(struct usb_interfa
>                  goto fail2;
>  
>          xpad->udev = udev;
> +        xpad->dpad_mapping = xpad_device[i].dpad_mapping;
>          xpad->dev = input_dev;
>          usb_make_path(udev, xpad->phys, sizeof(xpad->phys));
>          strlcat(xpad->phys, "/input0", sizeof(xpad->phys));
> @@ -254,29 +297,39 @@ static int xpad_probe(struct usb_interfa
>  
>          input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
>  
> -        for (i = 0; xpad_btn[i] >= 0; i++)
> -                set_bit(xpad_btn[i], input_dev->keybit);
> -
> -        for (i = 0; xpad_abs[i] >= 0; i++) {
> -
> -                signed short t = xpad_abs[i];
> +        /* set up buttons */
> +        for (i = 0; (xpad_btn[i] >= 0) ||
> +                (xpad->dpad_mapping == MAP_DPAD_TO_BUTTONS &&
> xpad_btn[i] == FAKE_ENTRY);

This is yucky... Can we have an additional map instead of separating one
with FAKE_ENTRY?

>  
>          input_register_device(xpad->dev);
> +        printk(KERN_INFO "input: %s on %s (dpad-to-axes=%u)\n",
> +                        xpad->dev->name, xpad->phys, xpad->dpad_mapping);

No printks here please. Input core does all printing necessary; mapping
can be found from a number of different places (sysfs,
/proc/bus/input/devices, etc).

-- 
Dmitry
