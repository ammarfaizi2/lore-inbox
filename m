Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752259AbWCEMAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbWCEMAW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 07:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752257AbWCEMAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 07:00:15 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29447 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1752255AbWCEMAN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 07:00:13 -0500
Date: Sat, 4 Mar 2006 16:39:44 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Chris Leech <christopher.leech@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 8/8] [I/OAT] TCP recv offload to I/OAT
Message-ID: <20060304163943.GA2724@ucw.cz>
References: <20060303214036.11908.10499.stgit@gitlost.site> <20060303214236.11908.98881.stgit@gitlost.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060303214236.11908.98881.stgit@gitlost.site>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -262,6 +262,9 @@
>  #include <net/tcp.h>
>  #include <net/xfrm.h>
>  #include <net/ip.h>
> +#ifdef CONFIG_NET_DMA
> +#include <net/netdma.h>
> +#endif
>  

Remove the ifdefs, move them inside .h if needed.

> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 7625eaf..9b6290d 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -71,6 +71,9 @@
>  #include <net/inet_common.h>
>  #include <linux/ipsec.h>
>  #include <asm/unaligned.h>
> +#ifdef CONFIG_NET_DMA
> +#include <net/netdma.h>
> +#endif

Here, too.

> +#ifdef CONFIG_NET_DMA
> +			if (copied_early)
> +				__skb_queue_tail(&sk->sk_async_wait_queue, skb);
> +			else
> +#endif
>  			if (eaten)
>  				__kfree_skb(skb);
>  			else

Could you #define copied_early to 0 and avoid ifdefs?

> @@ -1091,8 +1094,18 @@ process:
>  	bh_lock_sock(sk);
>  	ret = 0;
>  	if (!sock_owned_by_user(sk)) {
> -		if (!tcp_prequeue(sk, skb))
> +#ifdef CONFIG_NET_DMA
> +		struct tcp_sock *tp = tcp_sk(sk);
> +		if (!tp->ucopy.dma_chan && tp->ucopy.locked_list)
> +			tp->ucopy.dma_chan = get_softnet_dma();
> +		if (tp->ucopy.dma_chan)
> +			ret = tcp_v4_do_rcv(sk, skb);
> +		else
> +#endif
> +		{
> +			if (!tcp_prequeue(sk, skb))
>  			ret = tcp_v4_do_rcv(sk, skb);
> +		}
>  	} else

Wrong indentation...
								Pavel
-- 
Thanks, Sharp!
