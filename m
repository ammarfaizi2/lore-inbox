Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264716AbSJOV6m>; Tue, 15 Oct 2002 17:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264727AbSJOV6m>; Tue, 15 Oct 2002 17:58:42 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:53753 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S264716AbSJOV6j>;
	Tue, 15 Oct 2002 17:58:39 -0400
Message-ID: <3DAC90C4.823D87DF@mvista.com>
Date: Tue, 15 Oct 2002 15:03:48 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
CC: jim.houston@ccur.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] High-res-timers part 2 (x86 platform code) take 5.1
References: <3DAA8571.5439.26F0B5@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Windl wrote:
> 
> On 12 Oct 2002, at 18:03, Jim Houston wrote:
> 
> >
> > >> This patch, in conjunction with the "core" high-res-timers
> > >> patch implements high resolution timers on the i386
> > >> platforms.
> > >
> > > I really don't get the notion of partial ticks, and quite frankly, this
> > > isn't going into my tree until some major distribution kicks me in the
> > > head and explains to me why the hell we have partial ticks instead of just
> > > making the ticks shorter.
> > >
> > >                Linus
> >
> > Hi Linus,
> >
> > Concurrent has been using previous versions of the Posix timers patch
> > in our 2.4.18 based kernel.  I like this interface and would like to
> > see it included in your kernel.
> 
> Hi,
> 
> I think nobody objects seeing the interface implemented. Maybe just how
> it's implemented. I did not have a close look, but the concept seems
> odd at first sight.
> 
> Using a individial timer as interrupt source may be a different idea
> (if avaliable for the particular hardware), but the there must be a
> balance between busy looping in the kernel and setting up of such an
> individual interrupt.
> 
> The other thing is how to correlate it with the wall clock.

Ah, yes, that is it in a nut shell.  If you try to put the
high res timers in a "special" list and not in the same list
as the low res stuff, you have ordering issues.  It becomes
real easy to have the timers expire in the incorrect order. 

As to interrupt source and time, the biggest issue is that
we don't really have timers that interrupt in "nice" units
of time.  The PIT, for example, has a tick time (i.e. each
count) of 0.838095239 micro seconds.  So how are we to
figure time from such a tick if we want to use an integer
value for HZ.

What my patch suggests is that we use the higher resolution
TSC or pm timer (or what ever is available) and just use the
PIT to remind us to look at the clock, AND that we keep time
in units of that clock.  In some ways we already do this,
but we are not consistent.  For example we advance the time
by less than 1 ms each tick, but we still assume that a tick
is 1 ms when we set up timers.  This leads to standards
failures such as that illustrated by:

time sleep 60

which on a 2.5 system will sleep for less than 60 seconds
because of this.  

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
