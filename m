Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbVFLH6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVFLH6J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 03:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbVFLH6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 03:58:09 -0400
Received: from mail1.kontent.de ([81.88.34.36]:10469 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261649AbVFLH6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 03:58:03 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Wakko Warner <wakko@animx.eu.org>
Subject: Re: Problem found: kaweth fails to work on 2.6.12-rc[456]
Date: Sun, 12 Jun 2005 09:57:55 +0200
User-Agent: KMail/1.8
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20050612004136.GA8107@animx.eu.org>
In-Reply-To: <20050612004136.GA8107@animx.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506120957.55214.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 12. Juni 2005 02:41 schrieb Wakko Warner:
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

static void int_callback(struct urb *u, struct pt_regs *regs)
is supposed to handle the link state. Maybe it fails in your case. Could you
add a printk to this callback to check linkstate?

	Regards
		Oliver
 
