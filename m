Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbVHZVnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbVHZVnW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 17:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbVHZVnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 17:43:22 -0400
Received: from [216.144.233.50] ([216.144.233.50]:16610 "EHLO
	swissweb.swissdisk.com") by vger.kernel.org with ESMTP
	id S965172AbVHZVnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 17:43:22 -0400
Date: Fri, 26 Aug 2005 13:37:52 -0700
From: Ben Collins <bcollins@debian.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] late spinlock initialization in ieee1394/ohci
Message-ID: <20050826203752.GF18327@swissdisk.com>
References: <20050825221314.GY9322@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825221314.GY9322@parcelfarce.linux.theplanet.co.uk>
Subject2: 2005-08-26
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Al. I'll commit this to our tree. Linus, feel free to apply this to
your tree.

Signed-off-by: Ben Collins <bcollins@debian.org>

On Thu, Aug 25, 2005 at 11:13:14PM +0100, Al Viro wrote:
> spinlock used in irq handler should be initialized before registering
> irq, even if we know that our device has interrupts disabled; handler
> is registered shared and taking spinlock is done unconditionally.  As
> it is, we can and do get oopsen on boot for some configuration, depending
> on irq routing - I've got a reproducer.
> 
> Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
> ----
> diff -urN RC13-rc7-base/drivers/ieee1394/ohci1394.c current/drivers/ieee1394/ohci1394.c
> --- RC13-rc7-base/drivers/ieee1394/ohci1394.c	2005-08-24 01:56:37.000000000 -0400
> +++ current/drivers/ieee1394/ohci1394.c	2005-08-25 18:02:49.000000000 -0400
> @@ -478,7 +478,6 @@
>  	int num_ports, i;
>  
>  	spin_lock_init(&ohci->phy_reg_lock);
> -	spin_lock_init(&ohci->event_lock);
>  
>  	/* Put some defaults to these undefined bus options */
>  	buf = reg_read(ohci, OHCI1394_BusOptions);
> @@ -3402,7 +3401,14 @@
>  	/* We hopefully don't have to pre-allocate IT DMA like we did
>  	 * for IR DMA above. Allocate it on-demand and mark inactive. */
>  	ohci->it_legacy_context.ohci = NULL;
> +	spin_lock_init(&ohci->event_lock);
>  
> +	/*
> +	 * interrupts are disabled, all right, but... due to SA_SHIRQ we
> +	 * might get called anyway.  We'll see no event, of course, but
> +	 * we need to get to that "no event", so enough should be initialized
> +	 * by that point.
> +	 */
>  	if (request_irq(dev->irq, ohci_irq_handler, SA_SHIRQ,
>  			 OHCI1394_DRIVER_NAME, ohci))
>  		FAIL(-ENOMEM, "Failed to allocate shared interrupt %d", dev->irq);

-- 
Ubuntu     - http://www.ubuntu.com/
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
SwissDisk  - http://www.swissdisk.com/
