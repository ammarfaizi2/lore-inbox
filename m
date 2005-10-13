Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbVJMTxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbVJMTxt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbVJMTxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:53:49 -0400
Received: from sccrmhc14.comcast.net ([63.240.76.49]:43739 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1751101AbVJMTxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:53:48 -0400
From: kernel-stuff@comcast.net
To: Christian Krause <chkr@plauener.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, chrisw@osdl.org
Subject: [PATCH] Re: bug in handling of highspeed usb HID devices
Date: Thu, 13 Oct 2005 19:53:42 +0000
Message-Id: <101320051953.12930.434EBB460007F30B0000328222007589429D0E050B9A9D0E99@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: d2FydWRrYXJAY29tY2FzdC5uZXQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ok, then only one question remains: How do I get this patch applied to
> the official kernel tree?
> 
> Thanks & best regards,
> Christian

I already forwarded your patch to linux-usb-devel@lists.sf.net. 
No one seems to have picked it up till now.

This seems to be -stable material since it's a clear cut bug with bad
consequences. 

Chris Wright - is the below patch acceptable for -stable?

If no one else cares, there is always Andrew Morton and -mm ! :)

Parag



----------------------  Forwarded Message:  ---------------------
From:    Christian Krause <chkr@plauener.de>
To:      linux-kernel@vger.kernel.org
Subject: bug in handling of highspeed usb HID devices
Date:    Wed, 12 Oct 2005 19:56:16 +0000

Hi folks,

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

Here is a small patch which solves the whole problem:

--------------------------
--- hid-core.c.old      2005-10-12 21:29:29.000000000 +0200
+++ hid-core.c  2005-10-12 21:31:02.000000000 +0200
@@ -1667,11 +1667,6 @@
                if ((endpoint->bmAttributes & 3) != 3)          /* Not an 
interrupt endpoint */
                        continue;
 
-               /* handle potential highspeed HID correctly */
-               interval = endpoint->bInterval;
-               if (dev->speed == USB_SPEED_HIGH)
-                       interval = 1 << (interval - 1);
-
                /* Change the polling interval of mice. */
                if (hid->collection->usage == HID_GD_MOUSE && 
hid_mousepoll_interval > 0)
                        interval = hid_mousepoll_interval;

----------------------------

Please review my investigation and if you come to the same conclusion
please apply this patch in the next kernel versions. If not, please tell
me why. ;-)


Best regards,
Christian
