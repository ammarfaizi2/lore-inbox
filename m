Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161043AbWHRRJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161043AbWHRRJO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 13:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161044AbWHRRJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 13:09:14 -0400
Received: from cantor2.suse.de ([195.135.220.15]:47489 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161048AbWHRRJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 13:09:12 -0400
From: Andi Kleen <ak@suse.de>
To: Chris Leech <christopher.leech@intel.com>
Subject: Re: [PATCH 3/7] [I/OAT] Don't offload copies for loopback traffic
Date: Fri, 18 Aug 2006 20:17:18 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20060816005337.8634.70033.stgit@gitlost.site> <20060816005341.8634.10380.stgit@gitlost.site>
In-Reply-To: <20060816005341.8634.10380.stgit@gitlost.site>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608182017.19248.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> @@ -1136,7 +1137,8 @@ int tcp_recvmsg(struct kiocb *iocb, stru
>  	skb = skb_peek_tail(&sk->sk_receive_queue);
>  	if (skb)
>  		available = TCP_SKB_CB(skb)->seq + skb->len - (*seq);
> -	if ((available < target) &&
> +	dst = __sk_dst_get(sk);
> +	if ((available < target) && (!dst || (dst->dev != &loopback_dev)) &&

You just added another potential cache miss to a critical
path. A bit flag in the socket would be better.

But is it really worth this ugly special case?

-Andi
