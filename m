Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317869AbSGKTEL>; Thu, 11 Jul 2002 15:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317870AbSGKTEK>; Thu, 11 Jul 2002 15:04:10 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:38387 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317869AbSGKTEJ>;
	Thu, 11 Jul 2002 15:04:09 -0400
Message-ID: <3D2DD734.5A3CA6EB@mvista.com>
Date: Thu, 11 Jul 2002 12:06:28 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: dank@kegel.com
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Periodic clock tick considered harmful (was: Re: HZ, preferably as 
 small as possible)
References: <3D2DB5F3.3C0EF4A2@kegel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dank@kegel.com wrote:
> 
> Mark Mielke <mark@mark.mielke.cc> wrote:
> >
> > On Wed, Jul 10, 2002 at 04:09:21PM -0600, Cort Dougan wrote:
> > > Yes, please do make it a config option.  10x interrupt overhead makes me
> > > worry.  It lets users tailor the kernel to their expected load.
> >
> > All this talk is getting to me.
> >
> > I thought we recently (1 month ago? 2 months ago?) concluded that
> > increases in interrupt frequency only affects performance by a very
> > small amount, but generates an increase in responsiveness. The only
> > real argument against that I have seen, is the 'power conservation'
> > argument. The idea was, that the scheduler itself did not execute
> > on most interrupts. The clock is updated, and that is about all.
> 
> On UML and mainframe Linux, *any* periodic clock tick
> is heavy overhead when you have a large number of
> (mostly idle) instances of Linux running, isn't it?
> I think I once heard those architectures went to great lengths
> to avoid periodic clock ticks.  (My memory is rusty, though.)
> 
> How about this: let's apply the high-resolution timer patch,
> which adds explicit timer events inbetween the normal 100 Hz
> events when needed to satisfy precise sleep requests.  Then
> let's increase the interval between the normal periodic clock
> events from 10ms to infinity.  Everything will keep working,
> as the high-resolution timer patch code will schedule timer
> events as needed -- but suddenly we'll have power consumption
> as low as possible, snappier performance, and the thousands-of-instances
> case will no longer have this huge drain on performance from
> periodic timer events that do nothing but update jiffiers.

Ah, but you haven't looked at all that happens on a 1/HZ
tick.  The high-res-timers patch does NOT eliminate the 1/HZ
tick.  That tick is used to do a LOT of accounting activity
which IMHO is best done by a periodic tick.  In particular,
the time slice and execution time management depend on the
periodic tick.  As a test we put together a tickless system,
much as suggested above, and put enough stuff in it to see
what the overhead was and how it changed.  The conclusion
was that the timer over head increased far beyond the
current overhead as soon as the system load (actually the
number of context switches per second) increased beyond what
a moderately busy system experiences.  In other words, the
system was overload prone.  The current accounting activity
is flat WRT to context switching which is IMHO just what it
should be.  For those who want to know, a patch to put that
test system together is still on the HRT sourceforge site.

-g
> 
> OK, so I'm just an ignorant member of the peanut gallery, but
> I'd like to hear a real kernel hacker explain why this isn't
> the way to go.
> 
> - Dan

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
