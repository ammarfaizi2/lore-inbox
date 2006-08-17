Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbWHQOvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbWHQOvv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 10:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbWHQOvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 10:51:50 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:24242 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932538AbWHQOvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 10:51:48 -0400
Message-ID: <44E48281.1060504@pobox.com>
Date: Thu, 17 Aug 2006 10:51:45 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Jesse Huang <jesse@icplus.com.tw>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 5/6] IP100A correct init and close step
References: <1155841712.4532.19.camel@localhost.localdomain>
In-Reply-To: <1155841712.4532.19.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Huang wrote:
> From: Jesse Huang <jesse@icplus.com.tw>
> 
> correct init and close step
> 
> Change Logs:
>     correct init and close step
> 
> ---
> 
>  drivers/net/sundance.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
> b5e343a17f5d70d1cc9a4ba20d366bab355f64a6
> diff --git a/drivers/net/sundance.c b/drivers/net/sundance.c
> index f63871a..c7c22f0 100755
> --- a/drivers/net/sundance.c
> +++ b/drivers/net/sundance.c
> @@ -830,6 +830,11 @@ #endif
>  		iowrite8(0x01, ioaddr + DebugCtrl1);
>  	netif_start_queue(dev);
>  
> +	// 04/19/2005 Jesse fix for complete initial step
> +	spin_lock(&np->lock);
> +	reset_tx(dev);
> +	spin_unlock(&np->lock);
> +

NAK -- ineffective locking.

If you need locking here, you must use spin_lock_irqsave()


> @@ -1654,7 +1659,10 @@ static int netdev_close(struct net_devic
>  
>  	/* Disable interrupts by clearing the interrupt mask. */
>  	iowrite16(0x0000, ioaddr + IntrEnable);
> -
> +	
> +	// 04/19/2005 Jesse fix for complete initial step
> +	writew(0x500, ioaddr + DMACtrl);

NAK:

1) date and author information is already present in the kernel 
changelog.  It should not be present in the source code.

2) The comment (or patch description) fails to describe -why- this 
change is needed.  It only described what is being changes, which is 
already obvious from reading the source code.



