Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263308AbTC0ROi>; Thu, 27 Mar 2003 12:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263328AbTC0RNt>; Thu, 27 Mar 2003 12:13:49 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5386 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263317AbTC0RNY>; Thu, 27 Mar 2003 12:13:24 -0500
Date: Thu, 27 Mar 2003 09:22:29 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: shmulik.hen@intel.com, <dane@aiinet.com>,
       <bonding-devel@lists.sourceforge.net>,
       <bonding-announce@lists.sourceforge.net>, <netdev@oss.sgi.com>,
       <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>,
       <mingo@redhat.com>, <kuznet@ms2.inr.ac.ru>
Subject: Re: BUG or not? GFP_KERNEL with interrupts disabled.
In-Reply-To: <20030327.054357.17283294.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0303270917290.29072-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Mar 2003, David S. Miller wrote:
> 
>    Further more, holding a lock_irq doesn't mean bottom halves are disabled
>    too, it just means interrupts are disabled and no *new* softirq can be
>    queued. Consider the following situation:
>    
> I think local_bh_enable() should check irqs_disabled() and honour that.
> What you are showing here, that BH's can run via local_bh_enable()
> even when IRQs are disabled, is a BUG().

I'd disagree.

I do agree that we should obviously not run bottom halves with interrupts 
disabled, but I think the _real_ bug is doing "local_bh_enable()" in the 
first place. It's a nesting bug: you must nest the "stronger" lock inside 
the weaker one, which means that the following is right:

	local_bh_disable()
		..
		local_irq_disable()
		...
		local_irq_enable()
		..
	local_bh_enable()

and this is WRONG:

	local_irq_disable() (or spinlock)
		..
		local_bh_disable()
		..
		local_bh_enable()	!BUG BUG BUG!
		..
	local_irq_enable()

So the bug is, in my opinion, not in BK handling, but in the caller.

I missed the start of this thread, so I don't know how hard this is to 
fix. But if you have a buggy sequence, the _simple_ fix may be to do 
somehting like this:

+++	local_bh_disable()
	local_irq_disable() (or spinlock)
		..
		local_bh_disable()
		..
		local_bh_enable()	! now it's a no-op and no longer a bug
		..
	local_irq_enable()
+++	local_bh_enable()

What's the code sequence?

		Linus

