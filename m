Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277423AbRJJVvo>; Wed, 10 Oct 2001 17:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277432AbRJJVve>; Wed, 10 Oct 2001 17:51:34 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:21934 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S277423AbRJJVvR>; Wed, 10 Oct 2001 17:51:17 -0400
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with
 insertion
To: Andrea Arcangeli <andrea@suse.de>
Cc: cardoza@zk3.dec.com, Peter Rival <frival@zk3.dec.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Jay.Estabrook@compaq.com,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        Richard Henderson <rth@twiddle.net>, woodward@zk3.dec.com
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF946C8E35.379C9B9A-ON88256AE1.0077613F@boulder.ibm.com>
From: "Paul McKenney" <Paul.McKenney@us.ibm.com>
Date: Wed, 10 Oct 2001 14:44:18 -0700
X-MIMETrack: Serialize by Router on D03NM045/03/M/IBM(Release 5.0.8 |June 18, 2001) at
 10/10/2001 03:51:35 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is very explicit indeed.
>
> In short I guess what happens is that the reader may have old data in
> its cache, and the rmb() makes sure the cache used after the rmb() is
> not older than the cache used before the rmb().

Yep!  This is what the Alpha architects eventually beat into my head
when I first encountered this issue.  ;-)

> However the more I think about it the more I suspect we'd better use
> rmb() in all readers in the common code, rather than defining rmbdd with
> IPI on alpha, maybe alpha after all isn't the only one that needs the
> rmb() but it's the only one defining the behaviour in detail? I can very
> well imagine other archs also not invalidating all caches of all other
> cpus after a write followed by wmb, the synchronization can be delayed
> safely if the other cpus are readers, and they didn't issued an explicit
> rmb. So what alpha is doing can really be seen as a "feature" that
> allows to delay synchronization of caches after writes and wmb, unless
> an explicit order is requested by the reader via rmb (or better mb on
alpha).

As I understand it, this "feature" allows the CPU to avoid stalling as
often, thereby increasing performance.  Which is presumably somewhat offset
by extra rmb()s on Alpha.

> The fact is that if there's old data in cache, a data dependency isn't
> different than non data dependency if the cpu caches aren't synchronized
> or invalidated during wmb run by the producer.

Right, and omitting this synchronization between CPU and cache presumably
decreases stalls and increases performance.

Here is my scorecard thus far on CPUs that run SMP Linux:

     SMP CPU        Data dependencies create implicit rmb()?

     Alpha          No
     i386      Yes
     IA64      Yes
     MIPS      Yes *
     MIPS64         Yes *
     PA-RISC        Yes *
     PPC       Yes
     S390      Yes
     S390X          Yes
     SPARC          Yes

     *MIPS & MIPS64: Still don't have my MIPS manual, basing this on
          earlier experience with MIPS.  Any comments from the SGI
          guys?

     *PA-RISC: Based on my reading of the PA RISC architecture manual,
          particularly the SYNC instruction and definition of the
          memory model.  However, this manual is not completely
          unambiguous.  Comments from someone in the know at HP?

     Non-SMP CPUs include: arm, cris, m68k, sh

So unless I missed something, Alpha stands alone here, as the only CPU
that does not provide some way for data dependencies to act as implicit
rmb()s.

Don't get me wrong -- I am quite impressed with the way Alpha avoids
stalls in many cases, while getting a level of synchronization that is
useful in many cases.  I just wish that they had also provided more heavy
weight memory barriers so that we aren't forced to choose between IPIs for
Alpha and lots of rmb()s sprinkled through the code, uglifying it and
slowing down all the other SMP CPUs.

Given the discussion on this topic over the past few days, and on earlier
discussions, I would argue that the Alpha semantics for wmb() and rmb()
are strongly counter-intuitive.  People seem to expect a wmb()-like
primitive that allows read-side data dependencies to act as implicit
rmb() instructions.  All the CPUs except for Alpha provide an instruction
that can act as such a wmb()-like instruction, and Alpha can simulate
such an instruction with IPIs.

And this line of reasoning lead me to send out the wmbdd() patch.  ;-)

Thoughts?

                              Thanx, Paul

