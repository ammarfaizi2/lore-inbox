Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWJ1Q41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWJ1Q41 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 12:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWJ1Q41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 12:56:27 -0400
Received: from mail.first.fraunhofer.de ([194.95.169.2]:7371 "EHLO
	mail.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751098AbWJ1Q40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 12:56:26 -0400
Subject: Re: usb initialization order (usbhid vs. appletouch)
From: Soeren Sonnenburg <kernel@nn7.de>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb-devel@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200610261436.47463.oliver@neukum.org>
References: <1161856438.5214.2.camel@no.intranet.wo.rk>
	 <200610261220.05707.oliver@neukum.org>
	 <1161863380.18657.38.camel@no.intranet.wo.rk>
	 <200610261436.47463.oliver@neukum.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 28 Oct 2006 18:56:16 +0200
Message-Id: <1162054576.3769.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-26 at 14:36 +0200, Oliver Neukum wrote:
> Am Donnerstag, 26. Oktober 2006 13:49 schrieb Soeren Sonnenburg:
> > On Thu, 2006-10-26 at 12:20 +0200, Oliver Neukum wrote:
> > > Am Donnerstag, 26. Oktober 2006 11:53 schrieb Soeren Sonnenburg:
> > > > Dear all,
> > > > 
> > > > I've noticed that the appletouch driver needs to be loaded *before* the
> > > > usbhid driver to function. This is currently impossible when built into
> > > > the kernel (and not modules). So I wonder how one can change the
> > > > ordering of when the usb drivers are loaded.
> > > > 
> > > > Suggestions ?
> > > 
> > > Add a quirk to HID. Messing around with probing orders is not
> > > a sure thing.
> > 
> > what do you have in mind ? if appletouch is turned on ignore IDs that
> > appear in appletouch ?
> 
> Yes, or even make it unconditional. There is a specific driver for a device.
> It exists for a reason.

OK, so I tried adding all of them to the HID_QUIRK_IGNORE LIST, i.e.


#define USB_DEVICE_ID_APPLE_GEYSER_ANSI 0x0214
#define USB_DEVICE_ID_APPLE_GEYSER_ISO  0x0215
#define USB_DEVICE_ID_APPLE_GEYSER_JIS  0x0216
#define USB_DEVICE_ID_APPLE_GEYSER3_ANSI    0x0217
#define USB_DEVICE_ID_APPLE_GEYSER3_ISO     0x0218
#define USB_DEVICE_ID_APPLE_GEYSER3_JIS     0x0219


    { USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ANSI, HID_QUIRK_IGNORE },
    { USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ISO, HID_QUIRK_IGNORE },
    { USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_JIS, HID_QUIRK_IGNORE },
    { USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ANSI, HID_QUIRK_IGNORE },
    { USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ISO, HID_QUIRK_IGNORE },
    { USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_JIS, HID_QUIRK_IGNORE },
    { USB_VENDOR_ID_APPLE, 0x020E, HID_QUIRK_IGNORE },
    { USB_VENDOR_ID_APPLE, 0x020F, HID_QUIRK_IGNORE },
    { USB_VENDOR_ID_APPLE, 0x030A, HID_QUIRK_IGNORE },
    { USB_VENDOR_ID_APPLE, 0x030B, HID_QUIRK_IGNORE },


however this did (and cannot) work, as the product id stands for both
keyboard AND mouse. 

It will however work for the internal infrared receiver (which is also
affected).

#define USB_DEVICE_ID_APPLE_IR  0x8240

{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IR, HID_QUIRK_IGNORE },

Could someone please add this to the quirk list in hid-core.c in git ?
Please note that one can even do this from userspace via

        libhid-detach-device 05ac:8240
        modprobe appleir


Anyways, back to the above problem. Can one somehow tell the hid-core to
load the appletouch driver when it detects any of these devices and then
initialize on top of that ? The appletouch driver is completely ignored
(doesn't even enter the atp_prope function as usb_register registers
with device/product tuples that are already taken by hid....

Any ideas ?

Soeren
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.
