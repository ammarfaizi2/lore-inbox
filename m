Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751518AbVJLTzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbVJLTzq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 15:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbVJLTzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 15:55:46 -0400
Received: from john.hrz.tu-chemnitz.de ([134.109.132.2]:10170 "EHLO
	john.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S1751521AbVJLTzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 15:55:45 -0400
To: linux-kernel@vger.kernel.org
Subject: bug in handling of highspeed usb HID devices
From: Christian Krause <chkr@plauener.de>
Date: Wed, 12 Oct 2005 21:55:32 +0200
Message-ID: <m34q7mwlvv.fsf@gondor.middle-earth.priv>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Score: 0.0 (/)
X-Spam-Report: --- Start der SpamAssassin 3.1.0 Textanalyse (0.0 Punkte)
	Fragen an/questions to:  Postmaster TU Chemnitz <postmaster@tu-chemnitz.de>
	--- Ende der SpamAssassin Textanalyse
X-Scan-Signature: a9b0c11fa57e65d288d1a9e86fed51cf
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
                if ((endpoint->bmAttributes & 3) != 3)          /* Not an interrupt endpoint */
                        continue;
 
-               /* handle potential highspeed HID correctly */
-               interval = endpoint->bInterval;
-               if (dev->speed == USB_SPEED_HIGH)
-                       interval = 1 << (interval - 1);
-
                /* Change the polling interval of mice. */
                if (hid->collection->usage == HID_GD_MOUSE && hid_mousepoll_interval > 0)
                        interval = hid_mousepoll_interval;

----------------------------

Please review my investigation and if you come to the same conclusion
please apply this patch in the next kernel versions. If not, please tell
me why. ;-)


Best regards,
Christian
