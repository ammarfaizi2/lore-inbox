Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283621AbRLEAy4>; Tue, 4 Dec 2001 19:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283623AbRLEAyg>; Tue, 4 Dec 2001 19:54:36 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:38130 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S283621AbRLEAy1>; Tue, 4 Dec 2001 19:54:27 -0500
Message-ID: <3C0D702D.8160CC85@mvista.com>
Date: Tue, 04 Dec 2001 16:54:05 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] improve spinlock debugging
In-Reply-To: <3C0BDC33.6E18C815@colorfullife.com> <3C0D3283.4DA4DD2B@mvista.com> <3C0D37E0.5382B42E@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> george anzinger wrote:
> >
> > Manfred Spraul wrote:
> > >
> > > CONFIG_DEBUG_SPINLOCK only adds spinlock tests for SMP builds. The
> > > attached patch adds runtime checks for uniprocessor builds.
> > >
> > > Tested on i386/UP, but it should work on all platforms. It contains
> > > runtime checks for:
> > >
> > > - missing initialization
> > > - recursive lock
> > > - double unlock
> > > - incorrect use of spin_is_locked() or spin_trylock() [both function
> > > do not work as expected on uniprocessor builds]
> > > The next step are checks for spinlock ordering mismatches.
> >
> > What do you consider an order mismatch?  I would like to see this:
> >
>         spin_lock(a);
>         spin_lock(b);
> 
> and somewhere else
>         spin_lock(b);
>         spin_lock(a);
> 
> >
> > Run time checks for xxx_irq when irq is already off seem reasonable.
> > The implication is that the xxx_unlockirq will then turn it on, which
> > most likely is an error.  Also, see above about rolling assumptions in
> > to the macro name.
> >
> Unfortuantely there are still a few special cases where spin_lock_irq()
> with already disabled interrupts is both intentional and correct^wnot
> buggy (search for sleep_on and cli() through the lkml archives).
> 
> And there are optimizations such as
>         spin_lock_bh(a);
>         spin_unlock(b);
>         spin_lock(b);
>         spin_unlock_bh(b);
> 
Dam the special case!  Full speed ahead!

But really, there will always be exceptions, but they should be noted
(and commented upon).  To hide them in obscurity, and worst yet, allow
them to dictate that we can not do better is a crime.  There are tricks
that can be used to help us in these cases, if we just set our
collective minds to it.  

-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
