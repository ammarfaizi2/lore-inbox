Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162268AbWKPSrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162268AbWKPSrT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 13:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162280AbWKPSrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 13:47:18 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:59868 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S1162268AbWKPSrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 13:47:17 -0500
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: Holger Schurig <hs4233@mail.mn-solutions.de>
Subject: Re: [PATCH] usb: Support for DMC TSC-10 (take 2)
Date: Thu, 16 Nov 2006 19:45:50 +0100
User-Agent: KMail/1.7.2
Cc: daniel.ritz@gmx.ch, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <200611160917.35828.hs4233@mail.mn-solutions.de>
In-Reply-To: <200611160917.35828.hs4233@mail.mn-solutions.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611161945.51499.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-01.tornado.cablecom.ch-Metrics: smtp-02.tornado.cablecom.ch 1377;
	Body=4 Fuz1=4 Fuz2=4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

On Thursday 16 November 2006 09.17, Holger Schurig wrote:
> From: Holger Schurig <hs4233@mail.mn-solutions.de>
> 
> Basic support support for the USB-based DMC TSC-10 touchscreen 
> controller.
> 
> Signed-off-by: Holger Schrig <hs4233@mail.mn-solutions.de>
> 
> ---
> 
> The previous patch was word-wrapped, sorry.
> 
> 
> Please review this patch and schedule it for inclusion once 
> 2.6.19 comes out.

looks good so far, just a few minor things...

> 
> The DMC TSC-10 comes in various configuration, e.g. with and 
> without EEPROM for handling calibration data. My device doesn't 
> have this EEPROM, so calibration must be handled by userspace, 
> not by hardware. That's not really a limitation, as the other 
> touchscreen drivers in usbtouchscreen.c need user-space 
> calibration, too.
> 
> However, is someone is inclined to add "hardware" calibration, 
> then vender technical documentation for this device can be 
> accessed at
> 
>    http://www.dmccoltd.com/files/controler/tsc10usb_pi_e.pdf.
> 
> This patch adds support for the USB based DMC TSC-10 touchscreen controller.
> 
> Signed-off-by: Holger Schrig <hs4233@mail.mn-solutions.de>
> 
> --- linux.orig/drivers/usb/input/Kconfig
> +++ linux/drivers/usb/input/Kconfig
> @@ -211,6 +211,7 @@
>  	  - ITM
>  	  - some other eTurboTouch
>  	  - Gunze AHL61
> +	  - DMC TSC-10

make that DMC TSC-10/TSC-25. they're the same from SW point of view.
(even the same USB ID)

>  
>  	  Have a look at <http://linux.chapter7.ch/touchkit/> for
>  	  a usage description and the required user-space stuff.
> @@ -218,6 +219,11 @@
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called usbtouchscreen.
>  
> +config USB_TOUCHSCREEN_DMC_TSC10
> +	default y
> +	bool "DMC TSC-10 device support" if EMBEDDED

	bool "DMC TSC-10/TSC-25 device support" if EMBEDDED

> +	depends on USB_TOUCHSCREEN
> +
>  config USB_TOUCHSCREEN_EGALAX
>  	default y
>  	bool "eGalax, eTurboTouch CT-410/510/700 device support" if EMBEDDED
> --- linux.orig/drivers/usb/input/usbtouchscreen.c
> +++ linux/drivers/usb/input/usbtouchscreen.c
> @@ -8,6 +8,7 @@
>   *  - PanJit TouchSet
>   *  - eTurboTouch
>   *  - Gunze AHL61
> + *  - DMC TSC-10 (Holger Schurig, hs4233@mail.mn-solutions.de)

 *  - DMC TSC-10/TSC-25 (Holger Schurig, hs4233@mail.mn-solutions.de)

>   *
>   * Copyright (C) 2004-2006 by Daniel Ritz <daniel.ritz@gmx.ch>
>   * Copyright (C) by Todd E. Johnson (mtouchusb.c)
> @@ -44,7 +45,7 @@
>  #include <linux/usb/input.h>
>  
>  
> -#define DRIVER_VERSION		"v0.4"
> +#define DRIVER_VERSION		"v0.5"
>  #define DRIVER_AUTHOR		"Daniel Ritz <daniel.ritz@gmx.ch>"
>  #define DRIVER_DESC		"USB Touchscreen Driver"
>  
> @@ -103,6 +104,7 @@
>  	DEVTYPE_ITM,
>  	DEVTYPE_ETURBO,
>  	DEVTYPE_GUNZE,
> +	DEVTYPE_DMC_TSC10,
>  };
>  
>  static struct usb_device_id usbtouch_devices[] = {
> @@ -139,6 +141,10 @@
>  	{USB_DEVICE(0x0637, 0x0001), .driver_info = DEVTYPE_GUNZE},
>  #endif
>  
> +#ifdef CONFIG_USB_TOUCHSCREEN_DMC_TSC10
> +	{USB_DEVICE(0x0afa, 0x03e8), .driver_info = DEVTYPE_DMC_TSC10},
> +#endif
> +
>  	{}
>  };
>  
> @@ -313,6 +319,81 @@
>  #endif
>  
>  /*****************************************************************************
> + * DMC TSC-10 Part
> + *
> + * Documentation about the controller and it's protocol can be found
> + * at http://www.dmccoltd.com/files/controler/tsc10usb_pi_e.pdf

and http://www.dmccoltd.com/files/controler/tsc25_usb_e.pdf ...

> + */
> +#ifdef CONFIG_USB_TOUCHSCREEN_DMC_TSC10
> +
> +/* At which rate should coordinates transferred? This list goes from
> + * slowest rate to fastest rate. */
> +#define TSC10_RATE_POINT 0x50
> +#define TSC10_RATE_30    0x40
> +#define TSC10_RATE_50    0x41
> +#define TSC10_RATE_80    0x42
> +#define TSC10_RATE_100   0x43
> +#define TSC10_RATE_130   0x44
> +#define TSC10_RATE_150   0x45
> +
> +/* Some commands that we send */
> +#define TSC10_CMD_RESET  0x55
> +#define TSC10_CMD_RATE   0x05
> +#define TSC10_CMD_DATA1  0x01
> +
> +static void dmc_tsc10_control(struct usbtouch_usb *usbtouch,
> +                          __u8 requesttype, __u8 request, __u16 value,
> +                          __u16 retlen)
> +{
> +	struct usb_device *dev = usbtouch->udev;
> +	int ret;
> +	unsigned char buf[2];
> +
> +	/* Note: retlen > is NOT supported. However, dmc_tsc10_init() is
                    ^^  ? retlen > what? just drop the whole comment
> +	 * only caller and makes sure by itself that this won't ever happen. */
> +
> +	buf[0] = buf[1] = 0xFF;
> +	//dbg("bmRequest %02x bRequest %02x wValue %04x wLength %04x", requesttype, request, value, retlen);

remove commented out code

> +	ret = usb_control_msg(dev, usb_rcvctrlpipe (dev, 0),
> +	                      request, requesttype, value, 0,
> +	                      buf, retlen, 2*HZ);
                                      ^^^^^^ timeout is in msecs, so HZ is wrong.
> +	//if (retlen)
> +	//	dbg("returns %02x %02x", buf[0], buf[1]);

remove commented out code.
please drop the whole wrapper around usb_control_msg(). it's pointless

> +}
> +
> +
> +static int dmc_tsc10_init(struct usbtouch_usb *usbtouch)
> +{
> +	// Reset 0xC0
> +	dmc_tsc10_control(usbtouch, USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
> +	                  TSC10_CMD_RESET, 0, 2);
> +
> +	// Set Coordinate output rate setting
> +	dmc_tsc10_control(usbtouch, USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
> +	                  TSC10_CMD_RATE, TSC10_RATE_130, 2);
> +
> +	// Coordinate data send start
> +	dmc_tsc10_control(usbtouch, USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
> +	                  TSC10_CMD_DATA1, 0, 0);
> +

just open-code like this:

	// control message timeout in msecs
	#define TSC10_CMD_TIMEOUT	2000
...

	int ret;
	unsigned char buf[2];
	buf[0] = buf[1] = 0xFF;

	// reset
	ret = usb_control_msg(dev, usb_rcvctrlpipe (dev, 0),
	                USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
	                TSC10_CMD_RESET,
	                0,
	                buf, 2, TSC10_CMD_TIMEOUT);
	if (ret < 0)
		return ret;

	....

so yes, you have to check for errors.

about the timeout: there's also USB_CTRL_SET_TIMEOUT which is 5 seconds...
maybe just use that one?


> +	return 0;
> +}
> +
> +
> +static int dmc_tsc10_read_data(unsigned char *pkt, int *x, int *y, int *touch, int *press)
> +{
> +	*x = ((pkt[2] & 0x03) << 8) | pkt[1];
> +	*y = ((pkt[4] & 0x03) << 8) | pkt[3];
> +	*touch = pkt[0] & 0x01;
> +
> +	//printk("tsc10: %d %d,%d\n", *touch, *x,*y);

drop comment...

otherwise looks fine! just correct those few minior things and i'll pipe
it through for upstream inclusion.

thanks, rgds
-daniel
