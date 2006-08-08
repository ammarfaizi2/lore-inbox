Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbWHHVRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbWHHVRN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbWHHVRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:17:13 -0400
Received: from postel.suug.ch ([194.88.212.233]:37251 "EHLO postel.suug.ch")
	by vger.kernel.org with ESMTP id S1030266AbWHHVRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:17:11 -0400
Date: Tue, 8 Aug 2006 23:17:32 +0200
From: Thomas Graf <tgraf@suug.ch>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Daniel Phillips <phillips@google.com>
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
Message-ID: <20060808211731.GR14627@postel.suug.ch>
References: <20060808193325.1396.58813.sendpatchset@lappy> <20060808193345.1396.16773.sendpatchset@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060808193345.1396.16773.sendpatchset@lappy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <a.p.zijlstra@chello.nl> 2006-08-08 21:33
> +struct sk_buff *__netdev_alloc_skb(struct net_device *dev,
> +		unsigned length, gfp_t gfp_mask)
> +{
> +	struct sk_buff *skb;
> +
> +	if (dev && (dev->flags & IFF_MEMALLOC)) {
> +		WARN_ON(gfp_mask & (__GFP_NOMEMALLOC | __GFP_MEMALLOC));
> +		gfp_mask &= ~(__GFP_NOMEMALLOC | __GFP_MEMALLOC);
> +
> +		if ((skb = ___netdev_alloc_skb(dev, length,
> +					       gfp_mask | __GFP_NOMEMALLOC)))
> +			goto done;
> +		if (dev_reserve_used(dev) >= dev->rx_reserve)
> +			goto out;
> +		if (!(skb = ___netdev_alloc_skb(dev, length,
> +						gfp_mask | __GFP_MEMALLOC)))
> +			goto out;
> +		atomic_inc(&dev->rx_reserve_used);
> +	} else
> +		if (!(skb = ___netdev_alloc_skb(dev, length, gfp_mask)))
> +			goto out;
> +
> +done:
> +	skb->dev = dev;
> +out:
> +	return skb;
> +}
> +

>  void __kfree_skb(struct sk_buff *skb)
>  {
> +	struct net_device *dev = skb->dev;
> +
>  	dst_release(skb->dst);
>  #ifdef CONFIG_XFRM
>  	secpath_put(skb->sp);
> @@ -389,6 +480,8 @@ void __kfree_skb(struct sk_buff *skb)
>  #endif
>  
>  	kfree_skbmem(skb);
> +	if (dev && (dev->flags & IFF_MEMALLOC))
> +		dev_unreserve_skb(dev);
>  }

skb->dev is not guaranteed to still point to the "allocating" device
once the skb is freed again so reserve/unreserve isn't symmetric.
You'd need skb->alloc_dev or something.
