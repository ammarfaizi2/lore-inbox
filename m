Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315779AbSGKUXL>; Thu, 11 Jul 2002 16:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315805AbSGKUXK>; Thu, 11 Jul 2002 16:23:10 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:31996 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S315779AbSGKUXH>;
	Thu, 11 Jul 2002 16:23:07 -0400
Message-ID: <3D2DE9B2.70A21F7E@mvista.com>
Date: Thu, 11 Jul 2002 13:25:22 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mbs <mbs@mc.com>
CC: dank@kegel.com,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Periodic clock tick considered harmful (was: Re: HZ, preferably as  
 small as possible)
References: <3D2DB5F3.3C0EF4A2@kegel.com> <3D2DD734.5A3CA6EB@mvista.com> <200207111916.PAA08197@mc.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mbs wrote:
> 
> george,
> 
>         with the HRT is there any reason to have 10 timer interrupts per process
> quantum anymore? (10 ms ticks, 100 ms proc quantum)

First blush is HELL YES!  The issue is accounting.  When you
ask how long a program ran, you are looking at the
accounting that happens on a tick.  This is where one of two
counters gets bumped (one for system, the other for user,
depending on what was interrupted).  This information could,
of course, be gathered every system call/ exit and every
context switch, BUT, there are FAR more system calls and
context switches than 1/HZ ticks.  Thus collecting
accounting info this way adds overhead as the system load
increases, a VERY BAD thing IMHO.

A second point is that tasks only run for a quantum IF they
never block or get preempted.  Most tasks will have some
fraction of a quantum remaining when they are scheduled.

-g
> 
> On Thursday 11 July 2002 15:06, george anzinger wrote:
> > Ah, but you haven't looked at all that happens on a 1/HZ
> > tick.  The high-res-timers patch does NOT eliminate the 1/HZ
> > tick.  That tick is used to do a LOT of accounting activity
> > which IMHO is best done by a periodic tick.  In particular,
> > the time slice and execution time management depend on the
> > periodic tick.  As a test we put together a tickless system,
> > much as suggested above, and put enough stuff in it to see
> > what the overhead was and how it changed.  The conclusion
> > was that the timer over head increased far beyond the
> > current overhead as soon as the system load (actually the
> > number of context switches per second) increased beyond what
> > a moderately busy system experiences.  In other words, the
> > system was overload prone.  The current accounting activity
> > is flat WRT to context switching which is IMHO just what it
> > should be.  For those who want to know, a patch to put that
> > test system together is still on the HRT sourceforge site.
> >
> > -g
> >
> > > OK, so I'm just an ignorant member of the peanut gallery, but
> > > I'd like to hear a real kernel hacker explain why this isn't
> > > the way to go.
> > >
> > > - Dan
> 
> --
> /**************************************************
> **   Mark Salisbury       ||      mbs@mc.com     **
> ** If you would like to sponsor me for the       **
> ** Mass Getaway, a 150 mile bicycle ride to for  **
> ** MS, contact me to donate by cash or check or  **
> ** click the link below to donate by credit card **
> **************************************************/
> https://www.nationalmssociety.org/pledge/pledge.asp?participantid=86736

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
