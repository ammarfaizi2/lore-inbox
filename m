Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751486AbWGaJGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbWGaJGI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 05:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWGaJGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 05:06:07 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:14095 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751460AbWGaJGG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 05:06:06 -0400
Date: Mon, 31 Jul 2006 19:04:33 +1000
To: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@infradead.org>,
       Matt Domsch <Matt_Domsch@dell.com>
Cc: David Miller <davem@davemloft.net>, yoshfuji@linux-ipv6.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [IPV6]: Audit all ip6_dst_lookup/ip6_dst_store calls
Message-ID: <20060731090433.GA25192@gondor.apana.org.au>
References: <20060728194531.GA17744@lists.us.dell.com> <20060729043325.GA7035@gondor.apana.org.au> <20060730.154416.121293840.davem@davemloft.net> <20060731033210.GD31083@humbolt.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060731033210.GD31083@humbolt.us.dell.com>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 10:32:10PM -0500, Matt Domsch wrote:
> 
> I applied this on 2.6.18-rc3, and it panics immediately as the first
> IPv6 TCP (ssh) session is initiated to the system.

Executive summary:

1) We resolved one lockdep warning only to stumble onto another lockdep
validator bug.  

2) There is something broken in the x86_64 unwind code which is causing
it to panic just about everytime somebody calls dump_stack().

Andi, this is the second time I've seen a report where an otherwise
harmless dump_stack call (the other one was caused by a WARN_ON) gets
turned into a panic by the stack unwind code on x86_64.  This particular
report is with 2.6.18-rc3 so it looks like whatever bug is causing it
hasn't been fixed yet.

Could you please have a look at it? Thanks.

> =============================================
> [ INFO: possible recursive locking detected ]
> ---------------------------------------------
> swapper/0 is trying to acquire lock:
>  (slock-AF_INET6){-+..}, at: [<ffffffff80414fda>] sk_clone+0xd2/0x3a8
> 
> but task is already holding lock:
>  (slock-AF_INET6){-+..}, at: [<ffffffff883d71a8>] tcp_v6_rcv+0x30e/0x76e [ipv6]
> 
> other info that might help us debug this:
> 1 lock held by swapper/0:
>  #0:  (slock-AF_INET6){-+..}, at: [<ffffffff883d71a8>] tcp_v6_rcv+0x30e/0x76e [ipv6]
> 
> stack backtrace:
> 
> Call Trace:
>  [<ffffffff8026f861>] show_trace+0xae/0x30e
>  [<ffffffff8026fad6>] dump_stack+0x15/0x17
>  [<ffffffff802a73d4>] __lock_acquire+0x12e/0xa18
>  [<ffffffff802a8232>] lock_acquire+0x4b/0x69
>  [<ffffffff8026883b>] _spin_lock+0x25/0x31
>  [<ffffffff80414fda>] sk_clone+0xd2/0x3a8
>  [<ffffffff8043c8a7>] inet_csk_clone+0x11/0x6f
>  [<ffffffff80445615>] tcp_create_openreq_child+0x24/0x49c
>  [<ffffffff883d5d85>] :ipv6:tcp_v6_syn_recv_sock+0x2c5/0x6be
>  [<ffffffff80445c5e>] tcp_check_req+0x1d1/0x326
>  [<ffffffff883d4f0e>] :ipv6:tcp_v6_do_rcv+0x15d/0x372
>  [<ffffffff883d75b9>] :ipv6:tcp_v6_rcv+0x71f/0x76e
>  [<ffffffff883ba49f>] :ipv6:ip6_input+0x223/0x315
>  [<ffffffff883bab4d>] :ipv6:ipv6_rcv+0x254/0x2af
>  [<ffffffff80221883>] netif_receive_skb+0x260/0x2dd
>  [<ffffffff88101292>] :e1000:e1000_clean_rx_irq+0x423/0x4c2
>  [<ffffffff880ff752>] :e1000:e1000_clean+0x88/0x17d
>  [<ffffffff8020caed>] net_rx_action+0xac/0x1d1
>  [<ffffffff80212809>] __do_softirq+0x68/0xf5
>  [<ffffffff802626fa>] call_softirq+0x1e/0x28

Now let's move onto the lockdep validator bug :)

Ingo/Arjen, I thought we've already fixed this before but somehow I
can't find anything in the email archives so perhaps I'm mixing it up
with another recursive lock false-positive.

The problem here is really quite simple: when we accept a TCP connection
there are two sockets involved.  The listening socket which existed before
the connection came in and the socket we construct for the newly arrived
connection.

The code works something like this:

* Take slock on listening socket.
* Construct child socket.
* Take slock on child socket.

As we never do the locking in the opposite direction (child followed by
listening socket) this is safe.

So perhaps we need to add some extra annotation in sk_clone?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
