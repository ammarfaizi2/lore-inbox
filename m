Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315806AbSF0UE6>; Thu, 27 Jun 2002 16:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315883AbSF0UE5>; Thu, 27 Jun 2002 16:04:57 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:10633 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S315806AbSF0UEz>;
	Thu, 27 Jun 2002 16:04:55 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200206272005.AAA16804@sex.inr.ac.ru>
Subject: Re: Fragment flooding in 2.4.x/2.5.x
To: trond.myklebust@fys.uio.no (Trond Myklebust)
Date: Fri, 28 Jun 2002 00:05:08 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200206271900.22602.trond.myklebust@fys.uio.no> from "Trond Myklebust" at Jun 27, 2 07:00:22 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > Did you not solve this problem using right write_space?
> 
> Sure, I can add specific checks for (atomic_read(&sk->wmem_alloc) < 
> sk->sndbuf) in the RPC layer,

But it is there now.

static void
udp_write_space(struct sock *sk)
{
	struct rpc_xprt *xprt;

	if (!(xprt = xprt_from_sock(sk)))
		return;
	if (xprt->shutdown)
		return;

	/* Wait until we have enough socket memory. */
	if (sock_writeable(sk))
		return;

So, I do not understand what you speak about.



>		    	 Sending partial messages isn't a feature 
> that sounds like it would be particularly useful for any other applications 
> either.

The thing, which is really useless, is that your patch preparing skbs
and dropping them in the next line. With the same success you could
trigger BUG() there. :-) Right application just should not reach
this condition.

Anyway, I have to repeat:

>>Better way exists. Just use forced sock_wmalloc instead of
>>sock_alloc_send_skb on non-blocking send of all the fragments
>>but the first.


> However what if the actual call to alloc_skb() fails?

The same as if it would be lost by network.

Alexey
