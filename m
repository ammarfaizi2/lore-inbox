Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136662AbREARK6>; Tue, 1 May 2001 13:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136666AbREARKk>; Tue, 1 May 2001 13:10:40 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:305 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S136662AbREARK1>; Tue, 1 May 2001 13:10:27 -0400
Date: Tue, 1 May 2001 19:09:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: kuznet@ms2.inr.ac.ru
Cc: davem@redhat.com, ralf@nyren.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.4: Kernel crash, possibly tcp related
Message-ID: <20010501190942.B31373@athlon.random>
In-Reply-To: <20010501124756.B805@athlon.random> <200105011644.UAA32621@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200105011644.UAA32621@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Tue, May 01, 2001 at 08:44:52PM +0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2001 at 08:44:52PM +0400, kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> > this is the strict fix:
> 
> Andrea, you caught the problem!
> 
> The fix is not right though (it is equivalent to straight
> tp->send_head=NULL, as you noticed. It also corrupts queue in
> an opposite manner.) Right fix is appended.
> 
> Explanation: in do_fault we must undo effect of enqueueing new segment
> in the case the segment remained empty. tp->send_head points to
> the first unsent skb in queue and it is NULL when and only when
> all the skbs are already sent. (Invariant is: tp->send_head==NULL ||
> tp->send_head->seq == tp->snd_nxt)
> I crapped this case except for the case when queue is completely empty,
> so that the last sent skb was accounted in packets_out twice...

I understsand the explanation but I don't think my patch is wrong, I
think it's simpler and faster instead.

My argument is very simple, if send_head points to skb and skb->len is
zero and we are running in such slow path, it is obvious the send_head
_was_ NULL when we entered the critical section, so it's perfectly fine
to set send_head back to null and to unlink the skb as the only actions
to undo the skb_entail. That's all. I don't see how my patch can fail.
If I'm missing something I'd love a further explanation indeed. Thanks!

> 
> Damn, what a silly mistake was it... shame.
> 
> Alexey
> 
> 
> --- ../vger3-010426/linux/net/ipv4/tcp.c	Wed Apr 25 21:02:18 2001
> +++ linux/net/ipv4/tcp.c	Tue May  1 20:38:44 2001
> @@ -1185,7 +1187,7 @@
>  	if (skb->len==0) {
>  		if (tp->send_head == skb) {
>  			tp->send_head = skb->prev;
> -			if (tp->send_head == (struct sk_buff*)&sk->write_queue)
> +			if (TCP_SKB_CB(skb)->seq == tp->snd_nxt)
>  				tp->send_head = NULL;
>  		}
>  		__skb_unlink(skb, skb->list);


Andrea
