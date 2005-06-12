Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVFLBV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVFLBV3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 21:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVFLBV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 21:21:29 -0400
Received: from animx.eu.org ([216.98.75.249]:27329 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261867AbVFLBVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 21:21:24 -0400
Date: Sat, 11 Jun 2005 21:16:46 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Problem found: kaweth fails to work on 2.6.12-rc[456]
Message-ID: <20050612011646.GA8181@animx.eu.org>
Mail-Followup-To: linux-usb-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20050612004136.GA8107@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050612004136.GA8107@animx.eu.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner wrote:
> After doing some testing, I believe a patch that went into rc4 broke kaweth.
> The kaweth driver itself did not change from rc2 through rc6.
> 
> As a test, I reverted a patch that went into rc4 which modified
> net/core/link_watch.c.  Once I compiled the kernel, my netgear EA101 works
> again.
> 
> The following is the patch that caused it to stop working:
> --- BEGIN PATCH ---
> diff -urN linux-2.6.12-rc3/net/core/link_watch.c linux-2.6.12-rc4/net/core/link_watch.c
> --- linux-2.6.12-rc3/net/core/link_watch.c	2005-03-01 23:37:30.000000000 -0800
> +++ linux-2.6.12-rc4/net/core/link_watch.c	2005-05-06 22:59:27.439802792 -0700
> @@ -74,6 +75,12 @@
>  		clear_bit(__LINK_STATE_LINKWATCH_PENDING, &dev->state);
>  
>  		if (dev->flags & IFF_UP) {
> +			if (netif_carrier_ok(dev)) {
> +				WARN_ON(dev->qdisc_sleeping == &noop_qdisc);
> +				dev_activate(dev);
> +			} else
> +				dev_deactivate(dev);
> +
>  			netdev_state_change(dev);
>  		}
>  
> --- END PATCH ---
> The above is not cut'n'paste.  There was 1 other addition (an include) that
> I removed from the patch inorder to revert it.  The patch above was applied
> to 2.6.12-rc6 using -Rp1.  This is why I believe that kaweth is broken. 
> With my limited understanding of the kernel, it would appear that kaweth
> doesn't support netif_carrier_ok properly.  
> Anyway, I found what caused it to break, but at this point, I do not have
> the required knowledge to do a proper fix.

Actually, removing the above broke my e1000 card.  So I added
dev_activate(dev) back in and all works now!

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
