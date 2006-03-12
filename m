Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbWCLBbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWCLBbi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 20:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWCLBbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 20:31:38 -0500
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:15756 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751419AbWCLBbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 20:31:37 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
Subject: Re: [RFC][PATCH] USB touch screen driver, all-in-one
Date: Sat, 11 Mar 2006 20:31:35 -0500
User-Agent: KMail/1.9.1
Cc: Lanslott Gish <lanslott.gish@gmail.com>, Greg KH <greg@kroah.com>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb <linux-usb-devel@lists.sourceforge.net>, tejohnson@yahoo.com,
       hc@mivu.no, vojtech@suse.cz
References: <38c09b90603100124l1aa8cbc6qaf71718e203f3768@mail.gmail.com> <200603112155.38984.daniel.ritz-ml@swissonline.ch>
In-Reply-To: <200603112155.38984.daniel.ritz-ml@swissonline.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603112031.35989.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 March 2006 15:55, Daniel Ritz wrote:
> hi
> 
> here my merge of the USB touchscreen drivers, based on my patch from
> thursday for touchkitusb. this time it's a new driver...
> 
> and of course it's untested. i can test the egalax part next week...
> 
> [ also cc'ing the authors of the other drivers ]
> 
> the sizes for comparison:
>    text    data     bss     dec     hex filename
>    2942     724       4    3670     e56 touchkitusb.ko
>    2647     660       0    3307     ceb mtouchusb.ko
>    2448     628       0    3076     c04 itmtouch.ko
>    4097    1012       4    5113    13f9 usbtouchscreen.ko
> 
> comments?
> 

I like it.

> +
> +	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
> +	input_dev->keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
> +	input_set_abs_params(input_dev, ABS_X, type->min_xc, type->max_xc, 0, 0);
> +	input_set_abs_params(input_dev, ABS_Y, type->min_yc, type->max_yc, 0, 0);
> +	input_set_abs_params(input_dev, ABS_PRESSURE, type->min_press, type->max_press, 0, 0);
> +

Not all devices report pressure; driver should only advertise ABS_PRESSURE for
devices that actually support it.

> +	usb_fill_int_urb(usbtouch->irq, usbtouch->udev,
> +			 usb_rcvintpipe(usbtouch->udev, 0x81),
> +			 usbtouch->data, type->rept_size,
> +			 usbtouch_irq, usbtouch, endpoint->bInterval);
> +
> +	usbtouch->irq->transfer_dma = usbtouch->data_dma;
> +	usbtouch->irq->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
> +
> +	input_register_device(usbtouch->input);
> +

Please add error handling now that input_register_device() returns errors.

> +	usb_set_intfdata(intf, usbtouch);
> +
> +	/* device specific init */
> +	if (type->init)
> +		type->init(usbtouch);
> +

Should we do device-specific init before registering input device and also
handle errors here?

-- 
Dmitry
