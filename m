Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288896AbSANTCx>; Mon, 14 Jan 2002 14:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288959AbSANTBn>; Mon, 14 Jan 2002 14:01:43 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:18673 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S288922AbSANTBP>; Mon, 14 Jan 2002 14:01:15 -0500
Message-ID: <3C432A7C.893D139@mvista.com>
Date: Mon, 14 Jan 2002 10:59:08 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: owensjc@bellatlantic.net
CC: "'Matti Aarnio'" <matti.aarnio@zmailer.org>, mingo@elte.hu,
        linux-kernel@vger.kernel.org
Subject: Re: O(1) scheduler ver H6 - more straightforward timeslice macros
In-Reply-To: <000001c19bb7$20756710$0100a8c0@jcowens.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"James C. Owens" wrote:
> 
> > -----Original Message-----
> > From: Matti Aarnio [mailto:matti.aarnio@zmailer.org]
> > Sent: Saturday, January 12, 2002 5:00 PM
> > To: James C. Owens
> > Cc: mingo@elte.hu; linux-kernel@vger.kernel.org
> > Subject: Re: O(1) scheduler ver H6 - more straightforward timeslice
> > macros
> >
> >
> > On Sat, Jan 12, 2002 at 02:16:08PM -0500, James C. Owens wrote:
> > > Ingo,
> > >
> > > I like the new scheduler. It seems like the timeslice
> > macros in sched.h
> > > could be more straighforward - i.e. instead of
> >
> >    (I quote too much, but to illustriate the point...)
> >
> > > #define PRIO_TO_TIMESLICE(p) \
> > >   (((
> > (MAX_USER_PRIO-1-USER_PRIO(p))*(MAX_TIMESLICE-MIN_TIMESLICE) + \
> > >      MAX_USER_PRIO-1) / MAX_USER_PRIO) + MIN_TIMESLICE)
> > >
> > > #define RT_PRIO_TO_TIMESLICE(p) \
> > >   ((( (MAX_RT_PRIO-(p)-1)*(MAX_TIMESLICE-MIN_TIMESLICE) + \
> > >      MAX_RT_PRIO-1) / MAX_RT_PRIO) + MIN_TIMESLICE)
> > >
> > > why not
> > >
> > > #define PRIO_TO_TIMESLICE(p) \
> > >   (MAX_TIMESLICE -
> > >    (USER_PRIO(p)/(MAX_USER_PRIO-1))*(MAX_TIMESLICE-MIN_TIMESLICE))
> > >
> > > #define RT_PRIO_TO_TIMESLICE(p) \
> > >   (MAX_TIMESLICE -
> > (p/(MAX_RT_PRIO-1))*(MAX_TIMESLICE-MIN_TIMESLICE))
> > >
> > >
> > > The second way seems simpler to me, and really illustrates
> > what you are
> > > doing in a more straightforward manner.
> >
> >    Except that the math is INTEGER, not floating-point,
> >    which means that this way you loose precission.
> >
> >    You HAVE TO do multiplications first, only then (finally)
> > the division.
> >
> >    Depending the value-spaces, small-enough value-spaces might be
> >    turnable into table mappings.  However that has lots of
> > dependencies
> >    in hardware architecture, e.g. memory access speeds, cache
> > pollution,
> >    speed of multiply/divide operations, etc.
> >
> >    If dividers/multipliers are constants, and powers of two, the math
> >    can happen with constant shifts, which are fast at all systems.
> >    If not, things get rather complicated.   (And thus a careless -1,
> >    or lack of one, may be costly.)
> >
> [snip]
> > /Matti Aarnio
> >
> 
> Point well made. How about
> 
> #define PRIO_TO_TIMESLICE(p) \
>   (MAX_TIMESLICE -
> ((USER_PRIO(p)*(MAX_TIMESLICE-MIN_TIMESLICE))/(MAX_USER_PRIO-1)))
> 
> #define RT_PRIO_TO_TIMESLICE(p) \
>   (MAX_TIMESLICE - ((p*(MAX_TIMESLICE-MIN_TIMESLICE))/(MAX_RT_PRIO-1)))
> 
> If people agree with this, I'll submit a new diff (with the right options).
> 
> Jim Owens

If performance is important here we could eliminate the "/" thusly:

#define SC 24 // Change as needed to get precision and fit in 32 bits
#define SC_USER_FACTOR
((MAX_TIMESLICE-MIN_TIMESLICE)<<SC)/(MAX_USER_PRIO-1) // a constant
#define PRIO_TO_TIMESLICE(p) \
   (MAX_TIMESLICE - ((USER_PRIO(p) * (SC_USER_FACTOR))>>SC

To eliminate the ">>" one could go to SC=32 and then just take the high
32-bits of the mpy.  Taking the high 32-bits of mpy (which gives
64-bits) requires asm, but SC_USER_FACTOR would be:
#define SC_USER_FACTOR \
(long)((long long) (MAX_TIMESLICE-MIN_TIMESLICE)<<SC)/(long
long)(MAX_USER_PRIO-1) 

SC=32 can be used as long as
(MAX_TIMESLICE-MIN_TIMESLICE)<(MAX_USER_PRIO-1)
-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
