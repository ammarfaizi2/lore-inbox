Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288653AbSADOrg>; Fri, 4 Jan 2002 09:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288654AbSADOrQ>; Fri, 4 Jan 2002 09:47:16 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:38258 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S288653AbSADOrN>; Fri, 4 Jan 2002 09:47:13 -0500
Date: Fri, 4 Jan 2002 15:45:00 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: David Lang <david.lang@digitalinsight.com>,
        Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
Message-ID: <20020104154500.N1561@athlon.random>
In-Reply-To: <20020104143659.I1561@athlon.random> <Pine.LNX.4.33.0201041641320.7409-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33.0201041641320.7409-100000@localhost.localdomain>; from mingo@elte.hu on Fri, Jan 04, 2002 at 04:44:32PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2002 at 04:44:32PM +0100, Ingo Molnar wrote:
> 
> On Fri, 4 Jan 2002, Andrea Arcangeli wrote:
> 
> > +	{
> > +		int counter = current->counter;
> > +		p->counter = (counter + 1) >> 1;
> > +		current->counter = counter >> 1;
> > +		p->policy &= ~SCHED_YIELD;
> > +		current->policy |= SCHED_YIELD;
> >  		current->need_resched = 1;
> > +	}
> 
> yep - good, this means that applications got some fair testing already.

yes :).

> What i mentioned in the previous email is that on SMP this solution is
> still not the optimal one under the current scheduler, because the wakeup
> of the child process might end up pushing the process to another (idle)
> CPU - worsening the COW effect with SMP-interlocking effects. This is why
> i introduced wake_up_forked_process() that knows about this distinction
> and keeps the child on the current CPU.

The right thing to do is not obvious here. If you keep the parent on the
current CPU, it will be the parent that will be rescheduled on another
(idle) cpu. But then the parent could be the "real" app, or something
that would better not migrate over and over to all cpus (better to run
the child in another cpu in such case). Of course we cannot avoid child
and parent to run in parallel if there are idle cpus or we risk to waste
a whole timeslice worth of cpu cycles. But, at the very least we should
avoid to set need_resched to 1 in the parent if the child is getting
migrated, so at least that bit can be optimized away with an aware
wake_up_forked_process.

Andrea
