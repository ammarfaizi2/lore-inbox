Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263396AbTEISzm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 14:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263397AbTEISzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 14:55:42 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:35045 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S263396AbTEISzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 14:55:38 -0400
Message-ID: <3EBBFC33.7050702@pacbell.net>
Date: Fri, 09 May 2003 12:06:27 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Max Krasnyansky <maxk@qualcomm.com>
CC: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: [Bluetooth] HCI USB driver update.   Support
 for SCO over HCI USB.
References: <200304290317.h3T3HOdA027579@hera.kernel.org> <200304290317.h3T3HOdA027579@hera.kernel.org> <5.1.0.14.2.20030429131303.10d7f330@unixmail.qualcomm.com> <5.1.0.14.2.20030429145523.10c52e50@unixmail.qualcomm.com> <5.1.0.14.2.20030508123858.01c004f8@unixmail.qualcomm.com>
Content-Type: multipart/mixed;
 boundary="------------070709080204000103000307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070709080204000103000307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Max,

> Do you think we can add this 
>         struct urb {
>                 ...
>                 struct list_head drv_list;
>                 char drv_cb[X];
>                 char hcd_cb[X]; 
>                 ...
>         };

Only with kerneldoc ... :)

I'd certainly like the list_head.  Patch attached,
in case Greg agrees enough.  On x86, this makes
sizeof(struct urb) == 120, so it's using space
that was previously wasted.


As for the skb->cb analogue(s), details need working.

  - What should "X" be?  skb->cb is 48 bytes.

  - Should the cb[] arrays be "long"?  They tend to
    be used for pointers...

  - The HCDs want different amounts of per-urb data.
    Sizes on x86:
      * UHCI wants a lot -- 60 bytes!
      * OHCI typically uses 16 bytes, but more for
        multi-TD urbs (control 24 bytes, ISO often 36).
      * EHCI doesn't allocate such extra data.

  - The HCDs would need conversion to use hcd_cb[].
    I once had a patch that did that, but it's not
    current.  It made urb->cb replace urb->hcpriv.

I suppose X=60 for hcd_cb[] will be enough, at least
on 32 bit CPUs.  But you start to see why in the
new "USB Gadget" API, the analogue of "urb" gets
allocated by the USB (device) controller rather
than by generic code:  so that in typical cases,
no additional per-request allocations are needed.

- Dave





--------------070709080204000103000307
Content-Type: text/plain;
 name="urb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="urb.patch"

--- 1.139/include/linux/usb.h	Wed May  7 00:02:43 2003
+++ edited/include/linux/usb.h	Thu May  8 20:06:31 2003
@@ -511,6 +511,8 @@
 /**
  * struct urb - USB Request Block
  * @urb_list: For use by current owner of the URB.
+ * @dev_list: For use by device driver, even while the URB is owned by
+ * 	usbcore and the HCD.  Th device driver must initialize this list.
  * @pipe: Holds endpoint number, direction, type, and more.
  *	Create these values with the eight macros available;
  *	usb_{snd,rcv}TYPEpipe(dev,endpoint), where the type is "ctrl"
@@ -669,7 +671,8 @@
 	spinlock_t lock;		/* lock for the URB */
 	atomic_t count;			/* reference count of the URB */
 	void *hcpriv;			/* private data for host controller */
-	struct list_head urb_list;	/* list pointer to all active urbs */
+	struct list_head urb_list;	/* private data for usbcore */
+	struct list_head dev_list;	/* private data for device driver */
 	struct usb_device *dev; 	/* (in) pointer to associated device */
 	unsigned int pipe;		/* (in) pipe information */
 	int status;			/* (return) non-ISO status */

--------------070709080204000103000307--


