Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbTDVWJf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 18:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263884AbTDVWJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 18:09:35 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:62226 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263880AbTDVWJd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 18:09:33 -0400
Date: Tue, 22 Apr 2003 18:16:29 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@redhat.com>
cc: Rick Lindsley <ricklind@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: several messages
In-Reply-To: <Pine.LNX.4.44.0304220622570.24063-100000@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.3.96.1030422180002.31749C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Apr 2003, Dave Jones wrote:

> On Mon, Apr 21, 2003 at 03:13:31PM -0400, Ingo Molnar wrote:
> 
>  > +/*
>  > + * Is there a way to do this via Kconfig?
>  > + */
>  > +#if CONFIG_NR_SIBLINGS_2
>  > +# define CONFIG_NR_SIBLINGS 2
>  > +#elif CONFIG_NR_SIBLINGS_4
>  > +# define CONFIG_NR_SIBLINGS 4
>  > +#else
>  > +# define CONFIG_NR_SIBLINGS 0
>  > +#endif
>  > +
> 
> Maybe this would be better resolved at runtime ?
> With the above patch, you'd need three seperate kernel images
> to run optimally on a system in each of the cases.
> The 'vendor kernel' scenario here looks ugly to me.
> 
>  > +#if CONFIG_NR_SIBLINGS
>  > +# define CONFIG_SHARE_RUNQUEUE 1
>  > +#else
>  > +# define CONFIG_SHARE_RUNQUEUE 0
>  > +#endif
> 
> And why can't this just be a
> 
> 	if (ht_enabled)
> 		shared_runqueue = 1;
> 
> Dumping all this into the config system seems to be the
> wrong direction IMHO. The myriad of runtime knobs in the
> scheduler already is bad enough, without introducing
> compile time ones as well.

May I add my "I don't understand this, either" at this point? It seems
desirable to have this particular value determined at runtime. 

On Tue, 22 Apr 2003, Ingo Molnar wrote:

> 
> On Tue, 22 Apr 2003, Rick Lindsley wrote:

> > [...] Are we assuming that because both a physical processor and its
> > sibling are not idle, that it is better to move a task from the sibling
> > to a physical processor?  In other words, we are presuming that the case
> > where the task on the physical processor and the task(s) on the
> > sibling(s) are actually benefitting from the relationship is rare?
> 
> yes. This 'un-sharing' of contexts happens unconditionally, whenever we
> notice the situation. (ie. whenever a CPU goes completely idle and notices
> an overloaded physical CPU.) On the HT system i have i have measure this
> to be a beneficial move even for the most trivial things like infinite
> loop-counting.
> 
> the more per-logical-CPU cache a given SMT implementation has, the less
> beneficial this move becomes - in that case the system should rather be
> set up as a NUMA topology and scheduled via the NUMA scheduler.

Have you done any tests with a threaded process running on a single CPU in
the siblings? If they are sharing data and locks in the same cache it's
not obvious (to me at least) that it would be faster in two CPUs having to
do updates. That's a question, not an implication that it is significantly
better in just one, a threaded program with only two threads is not as
likely to be doing the same thing in both, perhaps.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

