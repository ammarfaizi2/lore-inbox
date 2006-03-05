Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752088AbWCEHc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbWCEHc3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 02:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbWCEHc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 02:32:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27319 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751910AbWCEHc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 02:32:28 -0500
Date: Sat, 4 Mar 2006 23:30:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Leech <christopher.leech@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 8/8] [I/OAT] TCP recv offload to I/OAT
Message-Id: <20060304233053.46325e65.akpm@osdl.org>
In-Reply-To: <20060303214236.11908.98881.stgit@gitlost.site>
References: <20060303214036.11908.10499.stgit@gitlost.site>
	<20060303214236.11908.98881.stgit@gitlost.site>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Leech <christopher.leech@intel.com> wrote:
>
> Locks down user pages and sets up for DMA in tcp_recvmsg, then calls
> dma_async_try_early_copy in tcp_v4_do_rcv
> 

+#ifdef CONFIG_NET_DMA
+#ifdef CONFIG_NET_DMA
+#ifdef CONFIG_NET_DMA
+#ifdef CONFIG_NET_DMA
+#ifdef CONFIG_NET_DMA
+#ifdef CONFIG_NET_DMA
+#ifdef CONFIG_NET_DMA
+#ifdef CONFIG_NET_DMA
+#ifdef CONFIG_NET_DMA
+#ifdef CONFIG_NET_DMA
+#ifdef CONFIG_NET_DMA
+#ifdef CONFIG_NET_DMA
+#ifdef CONFIG_NET_DMA
+#ifdef CONFIG_NET_DMA
+#ifdef CONFIG_NET_DMA
+#ifdef CONFIG_NET_DMA

waaay too many ifdefs.   There are various tricks we use to minimise them.

> +#ifdef CONFIG_NET_DMA
> +	tp->ucopy.dma_chan = NULL;
> +	if ((len > sysctl_tcp_dma_copybreak) && !(flags & MSG_PEEK) && !sysctl_tcp_low_latency && __get_cpu_var(softnet_data.net_dma))
> +		dma_lock_iovec_pages(msg->msg_iov, len, &tp->ucopy.locked_list);
> +#endif

Please try to fit code into 80 columns.

That's decimal 80 ;)

> @@ -1328,13 +1342,39 @@ do_prequeue:
>  		}
>  
>  		if (!(flags & MSG_TRUNC)) {
> -			err = skb_copy_datagram_iovec(skb, offset,
> -						      msg->msg_iov, used);
> -			if (err) {
> -				/* Exception. Bailout! */
> -				if (!copied)
> -					copied = -EFAULT;
> -				break;
> +#ifdef CONFIG_NET_DMA
> +			if (!tp->ucopy.dma_chan && tp->ucopy.locked_list)
> +				tp->ucopy.dma_chan = get_softnet_dma();
> +
> +			if (tp->ucopy.dma_chan) {
> +				tp->ucopy.dma_cookie = dma_skb_copy_datagram_iovec(
> +					tp->ucopy.dma_chan, skb, offset,
> +					msg->msg_iov, used,
> +					tp->ucopy.locked_list);
> +
> +				if (tp->ucopy.dma_cookie < 0) {
> +
> +					printk(KERN_ALERT "dma_cookie < 0\n");
> +
> +					/* Exception. Bailout! */
> +					if (!copied)
> +						copied = -EFAULT;
> +					break;
> +				}
> +				if ((offset + used) == skb->len)
> +					copied_early = 1;
> +

Consider trimming some of those blank lines.  I don't think they add any
value?

> +			} else
> +#endif
> +			{

These games with ifdefs and else statements aren't at all pleasant. 
Sometimes they're hard to avoid, but you'll probably find that some code
rearrangemnt (in a preceding patch) makes it easier.  Like, split this
function into several.

> @@ -1354,15 +1394,33 @@ skip_copy:
>  
>  		if (skb->h.th->fin)
>  			goto found_fin_ok;
> -		if (!(flags & MSG_PEEK))
> -			sk_eat_skb(sk, skb);
> +		if (!(flags & MSG_PEEK)) {
> +			if (!copied_early)
> +				sk_eat_skb(sk, skb);
> +#ifdef CONFIG_NET_DMA
> +			else {
> +				__skb_unlink(skb, &sk->sk_receive_queue);
> +				__skb_queue_tail(&sk->sk_async_wait_queue, skb);
> +				copied_early = 0;
> +			}
> +#endif
> ...
> -			sk_eat_skb(sk, skb);
> +		if (!(flags & MSG_PEEK)) {
> +			if (!copied_early)
> +				sk_eat_skb(sk, skb);
> +#ifdef CONFIG_NET_DMA
> +			else {
> +				__skb_unlink(skb, &sk->sk_receive_queue);
> +				__skb_queue_tail(&sk->sk_async_wait_queue, skb);
> +				copied_early = 0;
> +			}
> +#endif
> +		}

etc.

> +#ifdef CONFIG_NET_DMA
> +			if (copied_early)
> +				__skb_queue_tail(&sk->sk_async_wait_queue, skb);
> +			else
> +#endif
>  			if (eaten)
>  				__kfree_skb(skb);
>  			else

etc.

> @@ -4049,6 +4067,52 @@ discard:
>  	return 0;
>  }
>  
> +#ifdef CONFIG_NET_DMA
> +int dma_async_try_early_copy(struct sock *sk, struct sk_buff *skb, int hlen)
> +{
> +	struct tcp_sock *tp = tcp_sk(sk);
> +	int chunk = skb->len - hlen;
> +	int dma_cookie;
> +	int copied_early = 0;
> +
> +	if (tp->ucopy.wakeup)
> +          	goto out;

In this case a simple

		return 0;

would be fine.  We haven't done anything yet.

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

etc.

> +#ifdef CONFIG_NET_DMA
> +                struct tcp_sock *tp = tcp_sk(sk);
> +                if (tp->ucopy.dma_chan)
> +                        ret = tcp_v6_do_rcv(sk, skb);
> +                else
> +#endif
> +		{
> +			if (!tcp_prequeue(sk, skb))
> +				ret = tcp_v6_do_rcv(sk, skb);
> +		}
>  	} else

ow, my eyes!
