Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316818AbSEVBGX>; Tue, 21 May 2002 21:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316819AbSEVBGW>; Tue, 21 May 2002 21:06:22 -0400
Received: from [129.46.51.58] ([129.46.51.58]:47359 "EHLO numenor.qualcomm.com")
	by vger.kernel.org with ESMTP id <S316818AbSEVBGV>;
	Tue, 21 May 2002 21:06:21 -0400
Message-Id: <5.1.0.14.2.20020521164157.06b68430@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 21 May 2002 18:04:21 -0700
To: Johannes Erdfelt <johannes@erdfelt.com>
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Re: What to do with all of the USB UHCI drivers in the kernel ?
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20020521165826.H2645@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>IMO, I think testing with usb-uhci.c and uhci.c is still useful, but
>testing with the -hcd variants is the most ideal since that will be the
>final code base.

Ok. Here is feedback on 2.5.17 uhci-hcd and usb-uhci-hcd.
I did not notice any difference in behavior. Both have the same 
performance, just like 2.4.19-pre8.

One-shot interrupt transfers are broken in *-hcd drivers. core/hcd.c 
returns EINVAL if urb->interval==0.
My Broadcom FW loader (uses usbdevfs) needs one-shot interrupts. So in 
order to test Broadcom devices
I changed to hcd.c to allow urb->interval==0. With that change uhci-hcd 
works just fine, I can load fw and
use the device. But usb-uhci-hcd kills the machine pretty hard (hw reset 
needed).

Here is a patch for hcd.c.

--- hcd.c.orig  Tue May 21 17:50:09 2002
+++ hcd.c       Tue May 21 17:01:44 2002
@@ -1456,11 +1456,9 @@
          * supports different values... this uses EHCI/UHCI defaults (and
          * EHCI can use smaller non-default values).
          */
-       switch (temp) {
-       case PIPE_ISOCHRONOUS:
-       case PIPE_INTERRUPT:
+       if (urb->interval && (temp == PIPE_ISOCHRONOUS || temp == 
PIPE_INTERRUPT)) {
                 /* too small? */
-               if (urb->interval <= 0)
+               if (urb->interval < 0)
                         return -EINVAL;
                 /* too big? */
                 switch (urb->dev->speed) {

usb-uhci-hcd has to be fixed.
btw It tries to round interval value even thought it's done by hcd.c

So, Bluetooth USB devices should work fine with either usb-uhci-hcd or 
uhci-hcd.
(assuming that above patch is applied and one-shot is fixed in usb-uhci-hcd)

On a side note. Why are URBs still not SLABified ?
Drivers still have those silly urb pools and stuff. I thought you guys were 
gonna fix that.

Max

