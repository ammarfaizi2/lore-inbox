Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbWBBNzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWBBNzd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 08:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWBBNzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 08:55:33 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:13469 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751075AbWBBNzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 08:55:33 -0500
Date: Thu, 2 Feb 2006 14:54:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: [lock validator] inet6_destroy_sock(): soft-safe -> soft-unsafe lock dependency
Message-ID: <20060202135402.GA30251@elte.hu>
References: <E1F2IcV-0007Iq-00@gondolin.me.apana.org.au> <20060128152204.GA13940@elte.hu> <20060131102758.GA31460@gondor.apana.org.au> <20060131.024323.83813817.davem@davemloft.net> <20060201133219.GA1435@elte.hu> <20060201202610.GA13107@gondor.apana.org.au> <20060202074627.GA6805@elte.hu> <20060202084824.GA17299@gondor.apana.org.au> <20060202105429.GA4895@elte.hu> <20060202121729.GA18620@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060202121729.GA18620@gondor.apana.org.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Thu, Feb 02, 2006 at 11:54:29AM +0100, Ingo Molnar wrote:
> > 
> > hm, i got a new one:
> > 
> > ============================================
> > [ BUG: circular locking deadlock detected! ]
> > --------------------------------------------
> > sshd/28997 is trying to acquire lock:
> >  (&sk->sk_lock.slock){-+}, at: [<c0c6be28>] packet_rcv+0xbf/0x34b
> > 
> > but task is already holding lock:
> >  (&dev->xmit_lock){-+}, at: [<c0bb04ec>] qdisc_restart+0x46/0x207
> > 
> > which lock already depends on the new lock,
> > which could lead to circular deadlocks!
> > 
> > the dependency chain (in reverse order) is:
> > -> #2 (&dev->xmit_lock){-+}: [<c0bb04ec>] qdisc_restart+0x46/0x207
> > -> #1 (&dev->queue_lock){-+}: [<c0b98137>] dev_queue_xmit+0xc3/0x21e
> > -> #0 (&sk->sk_lock.slock){-+}: [<c0c6be28>] packet_rcv+0xbf/0x34b
> 
> I believe this is a false positive and I think I can see where it went 
> wrong.  The dependency between #0 and #1 is the broken premise.
> 
> The validator is probably putting all sk_lock's in the same basket.  
> That is, it's mixing up the socket locks for TCP, UDP as well as 
> AF_PACKET.  While it is true that TCP and UDP's sk_lock may sit 
> outside queue_lock, AF_PACKET never transmits while holding its 
> sk_lock.

you are right, the validator indeed treated all these protocols as one, 
so this is a false positive. (there are two slock buckets already, 
because there is some natural lock nesting between listen sockets and 
ordinary sockets, but otherwise you are right that all net protocols 
were indeed treated as one category.)

> So the #0 => #1 dependency shouldn't exist.  Can you get the validator 
> to print out the reasoning for the #0 => #1 dependency? That should 
> clarify the problem.

the slock -> queue_lock dependency was first observed at:

-> (&sk->sk_lock.slock/1){-+}
    -> &dev->queue_lock          [<c0b98137>] dev_queue_xmit+0xc3/0x21e

so it comes from dev_queue_xmit(). No further information about where 
that was done - but i suspect it was TCP's sendmsg. af_packet.c never 
seems to be doing that.

The queue_lock -> xmit_lock dependency was first observed at:

-> (&dev->queue_lock){-+}
    -> &dev->xmit_lock           [<c0bb0827>] dev_activate+0xc8/0xe5

i think i'll solve this by splitting af_packet.c's slock into a separate 
bucket (separate lock type). (Such exceptions and locking assymetries 
can be expressed towards the validator in a pretty straightforward way, 
by initializing those locks in a special way.)

	Ingo
