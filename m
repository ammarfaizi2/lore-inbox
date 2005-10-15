Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbVJOIYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbVJOIYg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 04:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbVJOIYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 04:24:36 -0400
Received: from lana.hrz.tu-chemnitz.de ([134.109.132.3]:64183 "EHLO
	lana.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S1750811AbVJOIYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 04:24:35 -0400
To: Greg KH <greg@kroah.com>
Cc: Parag Warudkar <kernel-stuff@comcast.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Chris Wright <chrisw@osdl.org>
Subject: [PATCH] Re: bug in handling of highspeed usb HID devices
References: <m34q7mwlvv.fsf@gondor.middle-earth.priv>
	<m3oe5riwib.fsf@gondor.middle-earth.priv>
	<20051014234225.GA11301@kroah.com>
	<200510142143.21944.kernel-stuff@comcast.net>
	<20051015021818.GA12951@kroah.com>
From: Christian Krause <chkr@plauener.de>
Date: Sat, 15 Oct 2005 10:24:23 +0200
Message-ID: <m3mzlbw5l4.fsf@gondor.middle-earth.priv>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Score: 0.0 (/)
X-Spam-Report: --- Start der SpamAssassin 3.1.0 Textanalyse (0.0 Punkte)
	Fragen an/questions to:  Postmaster TU Chemnitz <postmaster@tu-chemnitz.de>
	--- Ende der SpamAssassin Textanalyse
X-Scan-Signature: fd1e3f6e8aa43b9a2bd9800441c8fd81
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, 14 Oct 2005 19:18:18 -0700, Greg KH wrote:
>> > Did you try this patch out? ?It is wrong. ?Please look at the
>> > compiler warning that this change generates and redo the patch.

> Which leads me to believe that Christian never tried the patch :(

I'm very sorry, it seems that my first linux kernel patch will be a real
desaster. 

Unfortunately, Greg, you are right. To get a real clean patch without my
debug printks I've made my changes again on a clean kernel tree and so I
missed a line and I did not recompile the kernel again before submitting
the patch. I'm mortified, but I've learned the lesson - it will never
happen again. Here is the next try:

This patch compiles cleanly on a vanilla kernel 2.6.13.4 and I've tested
that it fixes the problem - the interval for highspeed HID devices is
correctly set.

explanation and patch:



During the development of an USB device I found a bug in the handling of
Highspeed HID devices in the kernel.

What happened?

Highspeed HID devices are correctly recognized and enumerated by the
kernel. But even if usbhid kernel module is loaded, no HID reports are
received by the kernel.

The output of the hardware USB analyzer told me that the host doesn't
even poll for interrupt IN transfers (even the "interrupt in" USB
transfer are polled by the host).

After some debugging in hid-core.c I've found the reason.

In case of a highspeed device, the endpoint interval is re-calculated in
driver/usb/input/hid-core.c:

line 1669:
             /* handle potential highspeed HID correctly */
             interval = endpoint->bInterval;
             if (dev->speed == USB_SPEED_HIGH)
                   interval = 1 << (interval - 1);

Basically this calculation is correct (refer to USB 2.0 spec, 9.6.6).
This new calculated value of "interval" is used as input for
usb_fill_int_urb:

line 1685:

            usb_fill_int_urb(hid->urbin, dev, pipe, hid->inbuf, 0,
                   hid_irq_in, hid, interval);

Unfortunately the same calculation as above is done a second time in 
usb_fill_int_urb in the file include/linux/usb.h:

line 933:
        if (dev->speed == USB_SPEED_HIGH)
                urb->interval = 1 << (interval - 1);
        else
                urb->interval = interval;

This means, that if the endpoint descriptor (of a high speed device)
specifies e.g. bInterval = 7, the urb->interval gets the value:

hid-core.c: interval = 1 << (7-1) = 0x40 = 64
urb->interval = 1 << (interval -1) = 1 << (63) = integer overflow

Because of this the value of urb->interval is sometimes negative and is
rejected in core/urb.c:
line 353:
                /* too small? */
                if (urb->interval <= 0)
                        return -EINVAL;

The conclusion is, that the recalculaton of the interval (which is
necessary for highspeed) should not be made twice, because this is
simply wrong. ;-)

Re-calculation in usb_fill_int_urb makes more sense, because it is the
most general approach. So it would make sense to remove it from
hid-core.c.

Because in hid-core.c the interval variable is only used for calling
usb_fill_int_urb, it is no problem to remove the highspeed
re-calculation in this file.


Signed-off-by: Christian Krause <chkr@plauener.de>


--------------------snip----------------------
--- linux-2.6.13.4/drivers/usb/input/hid-core.c.old	2005-10-15 09:24:22.000000000 +0200
+++ linux-2.6.13.4/drivers/usb/input/hid-core.c	2005-10-15 09:55:50.000000000 +0200
@@ -1667,10 +1667,7 @@ static struct hid_device *usb_hid_config
 		if ((endpoint->bmAttributes & 3) != 3)		/* Not an interrupt endpoint */
 			continue;
 
-		/* handle potential highspeed HID correctly */
 		interval = endpoint->bInterval;
-		if (dev->speed == USB_SPEED_HIGH)
-			interval = 1 << (interval - 1);
 
 		/* Change the polling interval of mice. */
 		if (hid->collection->usage == HID_GD_MOUSE && hid_mousepoll_interval > 0)
--------------------snip----------------------


Best regards,
Christian
