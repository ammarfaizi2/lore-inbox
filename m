Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316674AbSFQD0d>; Sun, 16 Jun 2002 23:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316675AbSFQD0c>; Sun, 16 Jun 2002 23:26:32 -0400
Received: from mx2.elte.hu ([157.181.151.9]:4069 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S316674AbSFQD0b>;
	Sun, 16 Jun 2002 23:26:31 -0400
Date: Mon, 17 Jun 2002 05:24:30 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Robert Love <rml@mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.4.19-pre10-ac2: O(1) scheduler merge, -A3.
In-Reply-To: <1024271844.1476.26.camel@sinai>
Message-ID: <Pine.LNX.4.44.0206170503380.2941-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 16 Jun 2002, Robert Love wrote:

> > +int idle_cpu(int cpu)
> > +{
> > +	return cpu_curr(cpu) == cpu_rq(cpu)->idle;
> > +}
> > +
> 
> I did not include this in my original O(1) backport update because
> nothing in 2.4-ac seems to use it... so why include it?

i have planned to submit the irqbalance patch for 2.4-ac real soon, which
needs this function - current IRQ distribution on P4 SMP boxes is a
showstopper.

> >  - sched_setaffinity() & sched_getaffinity() syscalls on x86.
>
> Do we want to introduce this into 2.4 now?  I realize 2.4-ac is not 2.4
> proper, but if there is a chance this interface could change...

the setaffinity()/getaffinity() interface looks pretty robust, i dont
expect any changes - there's just so many ways to set an affinity mask for
an opaque set of CPUs. And being able to set affinities is something that
was frequently asked for by application developers.

> > -	BUG_ON(in_interrupt());
> > -
> > +	if (unlikely(in_interrupt()))
> > +		BUG();
> 
> Eh, why do this?  BUG_ON is the same effect and it is more readable to
> me... seems better that 2.5 gets 2.4-ac's behavior instead of the other
> way around.

IMO BUG_ON() is just an ugly way of doing an assert(), i dont like code
with magic conditionals embedded within. But, the main reason was that
2.5-mainline has the code so that's being used.

> >  	/*
> >  	 * Valid priorities for SCHED_FIFO and SCHED_RR are
> > -	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_OTHER is 0.
> > +	 * 1..MAX_USER_RT_PRIO, valid priority for SCHED_OTHER is 0.
> >  	 */
> 
> Another case of 2.4-ac being right: the priority range is
> 1..MAX_USER_RT_PRIO-1 (i.e. 1 to 99, inclusive).

like above, 2.5 is the reference base. Especially for 100% nonfunctional
things like this it makes no sense to apply them to 2.4-ac only. But i
agree that existing comment fixes should be forward ported into 2.5, i've
applied them to my tree.

	Ingo

