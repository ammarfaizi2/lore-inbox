Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932684AbWBTWlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbWBTWlz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 17:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbWBTWly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 17:41:54 -0500
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:45221 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932684AbWBTWlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 17:41:53 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [PATCH] sched: Consolidated and improved smpnice patch
Date: Tue, 21 Feb 2006 09:41:22 +1100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, npiggin@suse.de,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <43F94D71.1040109@bigpond.net.au> <200602202102.14003.kernel@kolivas.org> <43FA444B.20903@bigpond.net.au>
In-Reply-To: <43FA444B.20903@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602210941.23352.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 February 2006 09:35, Peter Williams wrote:
> Con Kolivas wrote:
> > On Monday 20 February 2006 16:02, Peter Williams wrote:
> > [snip description]
> >
> > Hi peter, I've had a good look and have just a couple of comments:
> >
> > ---
> >  #endif
> >         int prio, static_prio;
> > +#ifdef CONFIG_SMP
> > +       int load_weight;        /* for load balancing purposes */
> > +#endif
> > ---
> >
> > Can this be moved up to be part of the other ifdef CONFIG_SMP? Not highly
> > significant since it's in a .h file but looks a tiny bit nicer.
>
> I originally put it where it is to be near prio and static_prio which
> are referenced at the same time as it BUT that doesn't happen often
> enough to justify it anymore so I guess it can be moved.

Well it is just before prio instead of just after it now and I understand the 
legacy of the position.

> > ---
> > +/*
> > + * Priority weight for load balancing ranges from 1/20 (nice==19) to
> > 459/20 (RT
> > + * priority of 100).
> > + */
> > +#define NICE_TO_LOAD_PRIO(nice) \
> > +       ((nice >= 0) ? (20 - (nice)) : (20 + (nice) * (nice)))
> > +#define LOAD_WEIGHT(lp) \
> > +       (((lp) * SCHED_LOAD_SCALE) / NICE_TO_LOAD_PRIO(0))
> > +#define NICE_TO_LOAD_WEIGHT(nice)     
> > LOAD_WEIGHT(NICE_TO_LOAD_PRIO(nice)) +#define PRIO_TO_LOAD_WEIGHT(prio)
> > NICE_TO_LOAD_WEIGHT(PRIO_TO_NICE(prio))
> > +#define RTPRIO_TO_LOAD_WEIGHT(rp) \
> > +       LOAD_WEIGHT(NICE_TO_LOAD_PRIO(-20) + (rp))
> > ---
> >
> > The weighting seems not related to anything in particular apart from
> > saying that -nice values are more heavily weighted.
>
> The idea (for the change from the earlier model) was to actually give
> equal weight to negative and positive nices.  Under the old (purely
> linear) model a nice=19 task has 1/20th the weight of a nice==0 task but
> a nice==-20 task only has twice the weight of a nice==0 so that system
> is heavily weighted against negative nices.  With this new mapping a
> nice=19 has 1/20th and a nice==-19 has 20 times the weight of a nice==0
> task and to me that is symmetric.  Does that make sense to you?

Yes but what I meant is it's still an arbitrary algorithm which is why I 
suggested proportional to tasks' timeslice because then it should scale with 
the theoretically allocated cpu resource.

> Should I add a comment to explain the mapping?
>
> > Since you only do this when
> > setting the priority of tasks can you link it to the scale of
> > (SCHED_NORMAL) tasks' timeslice instead even though that will take a
> > fraction more calculation? RTPRIO_TO_LOAD_WEIGHT is fine since there
> > isn't any obvious cpu proportion relationship to rt_prio level.
>
> Interesting idea.  I'll look at this more closely.

Would be just a matter of using task_timeslice(p) and making it proportional 
to some baseline ensuring the baseline works at any HZ.

Cheers,
Con
