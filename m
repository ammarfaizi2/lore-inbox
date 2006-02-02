Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbWBBMRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbWBBMRh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 07:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWBBMRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 07:17:37 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:14862 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1750944AbWBBMRg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 07:17:36 -0500
Date: Thu, 2 Feb 2006 23:17:29 +1100
To: Ingo Molnar <mingo@elte.hu>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: [lock validator] inet6_destroy_sock(): soft-safe -> soft-unsafe lock dependency
Message-ID: <20060202121729.GA18620@gondor.apana.org.au>
References: <E1F2IcV-0007Iq-00@gondolin.me.apana.org.au> <20060128152204.GA13940@elte.hu> <20060131102758.GA31460@gondor.apana.org.au> <20060131.024323.83813817.davem@davemloft.net> <20060201133219.GA1435@elte.hu> <20060201202610.GA13107@gondor.apana.org.au> <20060202074627.GA6805@elte.hu> <20060202084824.GA17299@gondor.apana.org.au> <20060202105429.GA4895@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060202105429.GA4895@elte.hu>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 11:54:29AM +0100, Ingo Molnar wrote:
> 
> hm, i got a new one:
> 
> ============================================
> [ BUG: circular locking deadlock detected! ]
> --------------------------------------------
> sshd/28997 is trying to acquire lock:
>  (&sk->sk_lock.slock){-+}, at: [<c0c6be28>] packet_rcv+0xbf/0x34b
> 
> but task is already holding lock:
>  (&dev->xmit_lock){-+}, at: [<c0bb04ec>] qdisc_restart+0x46/0x207
> 
> which lock already depends on the new lock,
> which could lead to circular deadlocks!
> 
> the dependency chain (in reverse order) is:
> -> #2 (&dev->xmit_lock){-+}: [<c0bb04ec>] qdisc_restart+0x46/0x207
> -> #1 (&dev->queue_lock){-+}: [<c0b98137>] dev_queue_xmit+0xc3/0x21e
> -> #0 (&sk->sk_lock.slock){-+}: [<c0c6be28>] packet_rcv+0xbf/0x34b

I believe this is a false positive and I think I can see where it went
wrong.  The dependency between #0 and #1 is the broken premise.

The validator is probably putting all sk_lock's in the same basket.
That is, it's mixing up the socket locks for TCP, UDP as well as
AF_PACKET.  While it is true that TCP and UDP's sk_lock may sit
outside queue_lock, AF_PACKET never transmits while holding its
sk_lock.

So the #0 => #1 dependency shouldn't exist.  Can you get the validator
to print out the reasoning for the #0 => #1 dependency? That should
clarify the problem.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
