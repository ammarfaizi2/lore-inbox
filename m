Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265209AbTLROk3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 09:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265210AbTLROk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 09:40:29 -0500
Received: from ns2.uk.superh.com ([193.128.105.170]:57847 "EHLO
	smtp.uk.superh.com") by vger.kernel.org with ESMTP id S265209AbTLROkT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 09:40:19 -0500
Date: Thu, 18 Dec 2003 14:32:36 +0000
From: Richard Curnow <Richard.Curnow@superh.com>
To: David Brownell <david-b@pacbell.net>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Handling of bounce buffers by rh_call_control
Message-ID: <20031218143236.GB20057@malvern.uk.w2k.superh.com>
Mail-Followup-To: David Brownell <david-b@pacbell.net>,
	Greg KH <greg@kroah.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20031217114125.GA20057@malvern.uk.w2k.superh.com> <3FE08470.5040801@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE08470.5040801@pacbell.net>
X-OS: Linux 2.4.22 i686
User-Agent: Mutt/1.5.4i
X-OriginalArrivalTime: 18 Dec 2003 14:33:51.0795 (UTC) FILETIME=[F4F28030:01C3C573]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

* David Brownell <david-b@pacbell.net> [2003-12-17]:
> >
> >	if (bufp) {
> >		if (urb->transfer_buffer_length < len)
> >			len = urb->transfer_buffer_length;
> >		urb->actual_length = len;
> >		// always USB_DIR_IN, toward host
> >		memcpy (ubuf, bufp, len);
> 
> Which is why that particular patch is wrong:  "ubuf" is a dma address,
> not expected to work for memcpy().

Sure, I didn't expect the patch was general but it was enough to make
things work on the platform I'm currently trying to port to, and it
illustrated the problem I was hitting.

> >in the case where bounce buffers are being used to implement PCI DMA
> >operations.  Without the patch, the subsequent pci_unmap_single copies
> >the contents of the bounce buffer over the top of urb->transfer_buffer,
> >destroying what the memcpy() put there.
> 
> A similar bug was fixed in 2.6 by a patch from Russell King.  I think
> the 2.4 version has lingered since it only affect EHCI, and most folk
> using EHCI won't use bounce buffers.

I just happened to have EHCI compiled in and put a USB 2 card into the
board.  The problem meant that the EHCI initialisation wouldn't even
complete, so I waded in to find out why.

IIRC, if I plug a USB2 device into a USB2 card but don't have the EHCI
driver active, the device is just ignored, rather than falling back to
using USB1.1 through OHCI?  We certainly have some USB2 devices we'd
like to use, even if the USB2 bandwidth might be throttled back by the
bounce buffering overhead.

> Could you look at that patch (bk revtool or bkweb will show it, early
> September 2002) and provide a 2.4 version?

I'll dig that out, if it's simple enough to backport I'll see if I can
take a stab at it.

> What changed in 2.6 was that hcd_submit_urb() has a special case for
> the root hub.  That's always PIO, so the code now bypasses all the
> DMA mapping code when an URB is destined for a root hub.

That seems like the right approach.

Cheers
Richard

-- 
Richard \\\ SH-4/SH-5 Core & Debug Architect
Curnow  \\\         SuperH (UK) Ltd, Bristol
