Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263507AbTEIWXP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 18:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263511AbTEIWXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 18:23:14 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:42695 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id S263507AbTEIWXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 18:23:13 -0400
Subject: Re: [linux-usb-devel] Re: [Bluetooth] HCI USB driver update.  
	Support for SCO over HCI USB.
From: Max Krasnyansky <maxk@qualcomm.com>
To: David Brownell <david-b@pacbell.net>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <3EBBFC33.7050702@pacbell.net>
References: <200304290317.h3T3HOdA027579@hera.kernel.org>
	 <200304290317.h3T3HOdA027579@hera.kernel.org>
	 <5.1.0.14.2.20030429131303.10d7f330@unixmail.qualcomm.com>
	 <5.1.0.14.2.20030429145523.10c52e50@unixmail.qualcomm.com>
	 <5.1.0.14.2.20030508123858.01c004f8@unixmail.qualcomm.com>
	 <3EBBFC33.7050702@pacbell.net>
Content-Type: text/plain
Organization: 
Message-Id: <1052517124.10458.199.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 May 2003 15:35:36 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-09 at 12:06, David Brownell wrote:
> Hi Max,
> 
> > Do you think we can add this 
> >         struct urb {
> >                 ...
> >                 struct list_head drv_list;
> >                 char drv_cb[X];
> >                 char hcd_cb[X]; 
> >                 ...
> >         };
> 
> Only with kerneldoc ... :)
> 
:) 

> I'd certainly like the list_head.  Patch attached,
> in case Greg agrees enough.  On x86, this makes
> sizeof(struct urb) == 120, so it's using space
> that was previously wasted.
> 
> 
> As for the skb->cb analogue(s), details need working.
> 
>   - What should "X" be?  skb->cb is 48 bytes.
I'd say 16 will be enough for drivers. 

>   - Should the cb[] arrays be "long"?  They tend to
>     be used for pointers...
Probably doesn't matter as long as ->cb is aligned.

>   - The HCDs want different amounts of per-urb data.
>     Sizes on x86:
>       * UHCI wants a lot -- 60 bytes!
>       * OHCI typically uses 16 bytes, but more for
>         multi-TD urbs (control 24 bytes, ISO often 36).
>       * EHCI doesn't allocate such extra data.
> 
>   - The HCDs would need conversion to use hcd_cb[].
>     I once had a patch that did that, but it's not
>     current.  It made urb->cb replace urb->hcpriv.
>
> I suppose X=60 for hcd_cb[] will be enough, at least
> on 32 bit CPUs.  But you start to see why in the
> new "USB Gadget" API, the analogue of "urb" gets
> allocated by the USB (device) controller rather
> than by generic code:  so that in typical cases,
> no additional per-request allocations are needed.

Ok. Sounds like it should be
	uint32_t hcd_cb[16]; // 64 bytes for internal use by HCD
	uint32_t drv_cb[2];  // 8  bytes for internal use by USB driver

?

Max



