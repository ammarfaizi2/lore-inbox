Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVBGQRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVBGQRp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 11:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVBGQRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 11:17:44 -0500
Received: from fire.osdl.org ([65.172.181.4]:31458 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261174AbVBGQRl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 11:17:41 -0500
Message-ID: <42079052.1050904@osdl.org>
Date: Mon, 07 Feb 2005 07:59:14 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikkel Krautz <krautz@gmail.com>
CC: vojtech@ucw.cz, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH] hid-core: Configurable USB HID Mouse Interrupt Polling
 Interval
References: <20050207154424.GB4742@omnipotens.localhost>
In-Reply-To: <20050207154424.GB4742@omnipotens.localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikkel Krautz wrote:
> And, here's an updated version of hid-core.c:
> 
> Signed-off-by: Mikkel Krautz <krautz@gmail.com>
> ---
> --- clean/drivers/usb/input/hid-core.c
> +++ dirty/drivers/usb/input/hid-core.c
> @@ -37,13 +37,20 @@
>   * Version Information
>   */
>  
> -#define DRIVER_VERSION "v2.0"
> +#define DRIVER_VERSION "v2.01"
>  #define DRIVER_AUTHOR "Andreas Gal, Vojtech Pavlik"
>  #define DRIVER_DESC "USB HID core driver"
>  #define DRIVER_LICENSE "GPL"
>  
>  static char *hid_types[] = {"Device", "Pointer", "Mouse", "Device", "Joystick",
>  				"Gamepad", "Keyboard", "Keypad", "Multi-Axis Controller"};
> +/*
> + * Module parameters.
> + */
> +
> +static unsigned int hid_mousepoll_interval;
> +module_param_named(mousepoll, hid_mousepoll_interval, uint, 0644);

Why is it writable by root?  IOW, will writing a new value to it
change the operational value dynamically?

Also, from the kernel-parameters.txt patch:
+	usbhid.mousepoll=
+		[USBHID] The interval at wich mice are to be polled at.

(a) "which"
(b) drop one of the "at"s... either one.

> +MODULE_PARM_DESC(mousepoll, "Polling interval of mice");
>  
>  /*
>   * Register a new report for a device.
> @@ -1695,6 +1702,12 @@
>  		if (dev->speed == USB_SPEED_HIGH)
>  			interval = 1 << (interval - 1);
>  
> +		/* Change the polling interval of mice. */
> +		if (hid->collection->usage == HID_GD_MOUSE && hid_mousepoll_interval > 0)
> +			interval = hid_mousepoll_interval;
> +		else
> +			hid_mousepoll_interval = interval;
> +		
>  		if (endpoint->bEndpointAddress & USB_DIR_IN) {
>  			if (hid->urbin)
>  				continue;


-- 
~Randy
