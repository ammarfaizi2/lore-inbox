Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267390AbSLLAnb>; Wed, 11 Dec 2002 19:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267392AbSLLAnb>; Wed, 11 Dec 2002 19:43:31 -0500
Received: from packet.digeo.com ([12.110.80.53]:40425 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267390AbSLLAna>;
	Wed, 11 Dec 2002 19:43:30 -0500
Message-ID: <3DF7DD73.182E44E2@digeo.com>
Date: Wed, 11 Dec 2002 16:50:59 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: jt@hpl.hp.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Benjamin Reed <breed@users.sourceforge.net>,
       Jeff Garzik <jgarzik@mandrakesoft.com>, dahinds@users.sourceforge.net
Subject: Re: Status new-modules + 802.11b/IrDA
References: Your message of "Wed, 11 Dec 2002 09:43:05 -0800."
	             <20021211174305.GB11264@bougret.hpl.hp.com> <20021212003733.2AF922C0E0@lists.samba.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Dec 2002 00:50:59.0973 (UTC) FILETIME=[89CB1350:01C2A178]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> In message <20021211174305.GB11264@bougret.hpl.hp.com> you write:
> > On Wed, Dec 11, 2002 at 07:34:53PM +1100, Rusty Russell wrote:
> > > >   o removal of airo_cs : "Uninitialised timer!/nThis is a
> > > > warning. Your computer is OK". Call trace on demand. Also, the module
> > > > airo not removed (probably due to problem with airo_cs).
> > >
> > > That, in itself, should be harmless.
> >
> >       Yes, but this is new and I don't really like it. I suspect
> > something is wrong in the Pcmcia code itself. Last I tried was 2.5.46
> > and I see some suspicious init_timer() added where I would not expect,
> > and some missing where they would be needed.
> >       Hum... Who is in charge ?
> 
> Well, Andrew Morton made the change that required timers to be
> initialized, and the check which locates ones which are not.  As to
> who is responsible for airo_cs, I'm guessing Ben Reed, as author.

wakes up.
 
> >       I personally believe the timer thingy is important and cause
> > of problems.
> 
> I disagree: the warning is supposed to silently fix it up.
> 

yes.  It goes like this:

1: The new super-scalable SMP timers code had a locking problem which
   made 8-ways go oops.
2: The fix was to add a spinlock to struct timer_list.
3: spinlocks need to be initialised.
3a: struct timer_list needs to be initialised.

This is a problem, because it has traditionally been the case that
an all-zeroes struct timer_list is "initialised".  That is no longer
the case.  All timers must now be prepared with init_timer() or
TIMER_INITIALIZER()

So debugging code was added to the timer layer to detect when someone
passes an uninitialised timer into the core timer functions.  That debug
code generates a warning, a backtrace and then initialises the timer
for you, so things run happily.

I did an audit and fixed up probably a hundred or so uninitialised timers,
but there will be a few leftovers.

The intent is that people will report these leftovers, they get fixed up
and then one day we pull out the debug code.
