Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287588AbSALWT0>; Sat, 12 Jan 2002 17:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287598AbSALWTQ>; Sat, 12 Jan 2002 17:19:16 -0500
Received: from [206.46.170.237] ([206.46.170.237]:12419 "EHLO
	pop010pub.verizon.net") by vger.kernel.org with ESMTP
	id <S287588AbSALWTM>; Sat, 12 Jan 2002 17:19:12 -0500
Reply-To: <owensjc@bellatlantic.net>
From: "James C. Owens" <owensjc@bellatlantic.net>
To: "'Matti Aarnio'" <matti.aarnio@zmailer.org>
Cc: <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: O(1) scheduler ver H6 - more straightforward timeslice macros
Date: Sat, 12 Jan 2002 17:18:50 -0500
Message-ID: <000001c19bb7$20756710$0100a8c0@jcowens.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
In-Reply-To: <20020112235945.G1914@mea-ext.zmailer.org>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Matti Aarnio [mailto:matti.aarnio@zmailer.org]
> Sent: Saturday, January 12, 2002 5:00 PM
> To: James C. Owens
> Cc: mingo@elte.hu; linux-kernel@vger.kernel.org
> Subject: Re: O(1) scheduler ver H6 - more straightforward timeslice
> macros
>
>
> On Sat, Jan 12, 2002 at 02:16:08PM -0500, James C. Owens wrote:
> > Ingo,
> >
> > I like the new scheduler. It seems like the timeslice
> macros in sched.h
> > could be more straighforward - i.e. instead of
>
>    (I quote too much, but to illustriate the point...)
>
> > #define PRIO_TO_TIMESLICE(p) \
> >   (((
> (MAX_USER_PRIO-1-USER_PRIO(p))*(MAX_TIMESLICE-MIN_TIMESLICE) + \
> >      MAX_USER_PRIO-1) / MAX_USER_PRIO) + MIN_TIMESLICE)
> >
> > #define RT_PRIO_TO_TIMESLICE(p) \
> >   ((( (MAX_RT_PRIO-(p)-1)*(MAX_TIMESLICE-MIN_TIMESLICE) + \
> >      MAX_RT_PRIO-1) / MAX_RT_PRIO) + MIN_TIMESLICE)
> >
> > why not
> >
> > #define PRIO_TO_TIMESLICE(p) \
> >   (MAX_TIMESLICE -
> >    (USER_PRIO(p)/(MAX_USER_PRIO-1))*(MAX_TIMESLICE-MIN_TIMESLICE))
> >
> > #define RT_PRIO_TO_TIMESLICE(p) \
> >   (MAX_TIMESLICE -
> (p/(MAX_RT_PRIO-1))*(MAX_TIMESLICE-MIN_TIMESLICE))
> >
> >
> > The second way seems simpler to me, and really illustrates
> what you are
> > doing in a more straightforward manner.
>
>    Except that the math is INTEGER, not floating-point,
>    which means that this way you loose precission.
>
>    You HAVE TO do multiplications first, only then (finally)
> the division.
>
>    Depending the value-spaces, small-enough value-spaces might be
>    turnable into table mappings.  However that has lots of
> dependencies
>    in hardware architecture, e.g. memory access speeds, cache
> pollution,
>    speed of multiply/divide operations, etc.
>
>    If dividers/multipliers are constants, and powers of two, the math
>    can happen with constant shifts, which are fast at all systems.
>    If not, things get rather complicated.   (And thus a careless -1,
>    or lack of one, may be costly.)
>
[snip]
> /Matti Aarnio
>

Point well made. How about

#define PRIO_TO_TIMESLICE(p) \
  (MAX_TIMESLICE -
((USER_PRIO(p)*(MAX_TIMESLICE-MIN_TIMESLICE))/(MAX_USER_PRIO-1)))

#define RT_PRIO_TO_TIMESLICE(p) \
  (MAX_TIMESLICE - ((p*(MAX_TIMESLICE-MIN_TIMESLICE))/(MAX_RT_PRIO-1)))

If people agree with this, I'll submit a new diff (with the right options).

Jim Owens


