Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264477AbTLQQXU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 11:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264481AbTLQQXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 11:23:20 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:50334 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S264477AbTLQQXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 11:23:17 -0500
Message-ID: <3FE08470.5040801@pacbell.net>
Date: Wed, 17 Dec 2003 08:29:36 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Richard Curnow <Richard.Curnow@superh.com>
CC: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Handling of bounce buffers by rh_call_control
References: <20031217114125.GA20057@malvern.uk.w2k.superh.com>
In-Reply-To: <20031217114125.GA20057@malvern.uk.w2k.superh.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Richard Curnow wrote:
> The following patch
> 
> ===== drivers/usb/hcd.c 1.10 vs edited =====
> --- 1.10/drivers/usb/hcd.c      Mon Mar 31 14:22:42 2003
> +++ edited/drivers/usb/hcd.c    Wed Dec 17 11:26:53 2003
> @@ -323,7 +323,7 @@
>         struct usb_ctrlrequest *cmd = (struct usb_ctrlrequest *) urb->setup_packet;
>         u16             typeReq, wValue, wIndex, wLength;
>         const u8        *bufp = 0;
> -       u8              *ubuf = urb->transfer_buffer;
> +       u8              *ubuf = (u8 *) urb->transfer_dma;
>         int             len = 0;
>  
>         typeReq  = (cmd->bRequestType << 8) | cmd->bRequest;
> 
> seems to be needed to make the following code later in the function work
> 
> 	if (bufp) {
> 		if (urb->transfer_buffer_length < len)
> 			len = urb->transfer_buffer_length;
> 		urb->actual_length = len;
> 		// always USB_DIR_IN, toward host
> 		memcpy (ubuf, bufp, len);

Which is why that particular patch is wrong:  "ubuf" is a dma address,
not expected to work for memcpy().


> 	}
> 
> in the case where bounce buffers are being used to implement PCI DMA
> operations.  Without the patch, the subsequent pci_unmap_single copies
> the contents of the bounce buffer over the top of urb->transfer_buffer,
> destroying what the memcpy() put there.

A similar bug was fixed in 2.6 by a patch from Russell King.  I think
the 2.4 version has lingered since it only affect EHCI, and most folk
using EHCI won't use bounce buffers.

Could you look at that patch (bk revtool or bkweb will show it, early
September 2002) and provide a 2.4 version?


> My USB knowledge is pretty limited, so I've no idea whether this patch
> adversely affects anything else in rh_call_control.
> 
> The patch is against 2.4.23-pre-something, but I see the code's the same
> in 2.6.

What changed in 2.6 was that hcd_submit_urb() has a special case for
the root hub.  That's always PIO, so the code now bypasses all the
DMA mapping code when an URB is destined for a root hub.  The original
code accidentally assumed no bounce buffering would go on.

- Dave


