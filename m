Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbVJZPD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbVJZPD1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 11:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbVJZPD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 11:03:27 -0400
Received: from ns2.suse.de ([195.135.220.15]:15305 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964777AbVJZPD0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 11:03:26 -0400
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] kill massive wireless-related log spam
Date: Wed, 26 Oct 2005 17:04:14 +0200
User-Agent: KMail/1.8.2
Cc: Linus Torvalds <torvalds@osdl.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, jketreno@linux.intel.com,
       Andrew Morton <akpm@osdl.org>
References: <20051026042827.GA22836@havoc.gtf.org>
In-Reply-To: <20051026042827.GA22836@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510261704.15366.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 October 2005 06:28, Jeff Garzik wrote:

> Change this to printing out the message once, per kernel boot.

It doesn't do that. It prints it once every 2^32 calls. Also
the ++ causes unnecessary dirty cache lines in normal operation.

-Andi
> 
> diff --git a/net/core/wireless.c b/net/core/wireless.c
> index d17f158..271ddb3 100644
> --- a/net/core/wireless.c
> +++ b/net/core/wireless.c
> @@ -455,10 +455,15 @@ static inline struct iw_statistics *get_
>  
>  	/* Old location, field to be removed in next WE */
>  	if(dev->get_wireless_stats) {
> -		printk(KERN_DEBUG "%s (WE) : Driver using old /proc/net/wireless support, please fix driver !\n",
> -		       dev->name);
> +		static int printed_message;
> +
> +		if (!printed_message++)
> +			printk(KERN_DEBUG "%s (WE) : Driver using old /proc/net/wireless support, please fix driver !\n",
> +				dev->name);
> +
>  		return dev->get_wireless_stats(dev);
>  	}
> +
