Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932645AbWAKXmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645AbWAKXmN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 18:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932639AbWAKXmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 18:42:13 -0500
Received: from gate.crashing.org ([63.228.1.57]:56533 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932637AbWAKXmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 18:42:12 -0500
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple
	PowerBooks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org,
       linux-kernel@killerfox.forkbomb.ch, Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <20060111232651.GI6617@hansmi.ch>
References: <20051225212041.GA6094@hansmi.ch>
	 <200512252304.32830.dtor_core@ameritech.net>
	 <1135575997.14160.4.camel@localhost.localdomain>
	 <d120d5000601111307x451db79aqf88725e7ecec79d2@mail.gmail.com>
	 <20060111232651.GI6617@hansmi.ch>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 10:41:40 +1100
Message-Id: <1137022900.5138.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 00:26 +0100, Michael Hanselmann wrote:

>   * This is the global environment of the parser. This information is
> @@ -431,6 +433,14 @@ struct hid_device {							/* device repo
>  	void (*ff_exit)(struct hid_device*);                            /* Called by hid_exit_ff(hid) */
>  	int (*ff_event)(struct hid_device *hid, struct input_dev *input,
>  			unsigned int type, unsigned int code, int value);
> +
> +#ifdef CONFIG_USB_HIDINPUT_POWERBOOK
> +	/* We do this here because it's only relevant for the
> +	 * USB devices, not for all input_dev's.
> +	 */
> +	unsigned long pb_fn[NBITS(KEY_MAX)];
> +	unsigned long pb_numlock[NBITS(KEY_MAX)];
> +#endif
>  };

I don't understand the comment above ? You are adding this to all struct
hid_device ? There can be only one of those keyboards plugged at one
point in time, I don't think there is any problem having the above
static in the driver rather than in the hid_device structure.

  .../...

>  
> +	if ((hid->quirks & HID_QUIRK_POWERBOOK_HAS_FN) &&
> +	    hidinput_pb_event(hid, input, usage, value)) {
> +		return;
> +	}
> +

Dimitry might disagree but it's generally considered bad taste to have
{ and } for a single statement :)

>  	if (usage->hat_min < usage->hat_max || usage->hat_dir) {
>  		int hat_dir = usage->hat_dir;
>  		if (!hat_dir)
> diff -upr linux-2.6.15.orig/drivers/usb/input/Kconfig linux-2.6.15/drivers/usb/input/Kconfig
> --- linux-2.6.15.orig/drivers/usb/input/Kconfig	2006-01-11 23:59:40.000000000 +0100
> +++ linux-2.6.15/drivers/usb/input/Kconfig	2006-01-08 11:53:35.000000000 +0100
> @@ -37,6 +37,16 @@ config USB_HIDINPUT
>  
>  	  If unsure, say Y.
>  
> +config USB_HIDINPUT_POWERBOOK
> +	bool "Enable support for iBook/PowerBook special keys"
> +	default n
> +	depends on USB_HIDINPUT
> +	help
> +	  Say Y here if you want support for the special keys (Fn, Numlock) on
> +	  Apple iBooks and PowerBooks.
> +
> +	  If unsure, say N.
> +
>  config HID_FF
>  	bool "Force feedback support (EXPERIMENTAL)"
>  	depends on USB_HIDINPUT && EXPERIMENTAL

