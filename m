Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbUKZTU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbUKZTU1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 14:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbUKZTUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:20:24 -0500
Received: from zeus.kernel.org ([204.152.189.113]:62401 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262298AbUKZTTq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:19:46 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] Ohci-hcd: fix endless loop
Date: Fri, 26 Nov 2004 08:38:10 -0800
User-Agent: KMail/1.7.1
Cc: Colin Leroy <colin@colino.net>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>
References: <20041125191726.5ca95299@jack.colino.net>
In-Reply-To: <20041125191726.5ca95299@jack.colino.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411260838.10508.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 November 2004 10:17, Colin Leroy wrote:
> Hi, 
> 
> Following patch fixes an endless loop that happens after having
> slept and resumed my iBook with a linux-wlan-ng controller plugged in,
> removed the stick and plugged it back (getting "IRQ lossage" message).

The infinite loop means that something trashed the stack, yes?

The "limit-- < -1000" test below should never be able to succeed
unless the previous "limit-- == 0" test got trashed by having
something obliterate the stack.  Possibly the driver for that WLAN
adapter.  Once that happens, all kinds of things will misbehave...

If you got the "IRQ INTR_SF lossage" diagnostic, there's clearly
some problem with IRQ handling after the resume ... is the iBook
firmware (or hardware) doing wierd stuff so that the normal PCI
IRQ calls stopped working?

And for that matter, "limit" is unsigned, so you must be getting
(and ignoring) some compiler warnings too.

This is not a good patch; not accepted.

- Dave


> Signed-off-by: Colin Leroy <colin@colino.net>
> --- a/drivers/usb/host/ohci-hcd.c	2004-11-25 19:00:25.000000000 +0100
> +++ b/drivers/usb/host/ohci-hcd.c	2004-11-25 19:08:59.000000000 +0100
> @@ -375,6 +375,11 @@
>  		spin_unlock_irqrestore (&ohci->lock, flags);
>  		set_current_state (TASK_UNINTERRUPTIBLE);
>  		schedule_timeout (1);
> +		if (limit-- < -1000) {
> +			ohci_warn (ohci, "Couldn't recover\n");
> +			ohci_restart(ohci);
> +			goto bail;
> +		}
>  		goto rescan;
>  	case ED_IDLE:		/* fully unlinked */
>  		if (list_empty (&ed->td_list)) {
> @@ -396,6 +401,7 @@
>  	dev->ep [epnum] = NULL;
>  done:
>  	spin_unlock_irqrestore (&ohci->lock, flags);
> +bail:
>  	return;
>  }
>  
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now. 
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> linux-usb-devel@lists.sourceforge.net
> To unsubscribe, use the last form field at:
> https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
> 
