Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbTJ3Vtw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 16:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbTJ3Vtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 16:49:52 -0500
Received: from chaos.analogic.com ([204.178.40.224]:5520 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263014AbTJ3Vtu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 16:49:50 -0500
Date: Thu, 30 Oct 2003 16:52:24 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: George Anzinger <george@mvista.com>
cc: Peter Chubb <peter@chubb.wattle.id.au>,
       Stephen Hemminger <shemminger@osdl.org>,
       Gabriel Paubert <paubert@iram.es>, john stultz <johnstul@us.ibm.com>,
       Joe Korty <joe.korty@ccur.com>, Linus Torvalds <torvalds@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: gettimeofday resolution seriously degraded in test9
In-Reply-To: <3FA1838C.3060909@mvista.com>
Message-ID: <Pine.LNX.4.53.0310301645170.16005@chaos>
References: <20031027234447.GA7417@rudolph.ccur.com>
 <1067300966.1118.378.camel@cog.beaverton.ibm.com> <20031027171738.1f962565.shemminger@osdl.org>
 <20031028115558.GA20482@iram.es> <20031028102120.01987aa4.shemminger@osdl.org>
 <20031029100745.GA6674@iram.es> <20031029113850.047282c4.shemminger@osdl.org>
 <16288.17470.778408.883304@wombat.chubb.wattle.id.au> <3FA1838C.3060909@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Oct 2003, George Anzinger wrote:

> Peter Chubb wrote:
> >>>>>>"Stephen" == Stephen Hemminger <shemminger@osdl.org> writes:
> >
> >
> > Stephen> On Wed, 29 Oct 2003 11:07:45 +0100 Gabriel Paubert
> > Stephen> <paubert@iram.es> wrote:
> >
> >>>for example.
> >
> >
> > Stephen> The suggestion of using time interpolation (like ia64) would
> > Stephen> make the discontinuities smaller, but still relying on fine
> > Stephen> grain gettimeofday for controlling servo loops with NTP
> > Stephen> running seems risky. Perhaps what you want to use is the
> > Stephen> monotonic_clock which gives better resolution (nanoseconds)
> > Stephen> and doesn't get hit by NTP.
> >
> > monotonic_clock:
> > 	-- isn't implemented for most architectures
> > 	-- even for X86 only works for some timing sources
> > 	-- and for the most common case is variable rate because of
> > 	   power management functions changing the TSC clock rate.
> >
> > As far as I know, there isn't a constant-rate monotonic clock
> > available at present for all architectures in the linux kernel.  The
> > nearest thing is scheduler_clock().
>
> What you want is the POSIX clocks and timers CLOCK_MONOTONIC which is available
> on all archs (as of 2.6).  The call is:
>
>        cc [ flag ... ] file -lrt [ library ... ]
>
>         #include <time.h>
>
>         int clock_gettime(clockid_t which_clock, struct timespec *setting);
>
> where you want "which_clock" to be CLOCK_MONOTONIC.
>

But there is a more basic problem. Let's say I need time in microseconds,
but the only hardware tick I have is in milliseconds. If I can call
the routine in zero time, it takes 1000 calls before the microsecond
value will change.

There isn't any magic that can solve this problem. It turns out
that with later Intel CPUs, one can get CPU-clock resolution
from rdtsc. However, this is hardware-specific. If somebody
modifies the gettimeofday() and the POSIX clock routines to
use rdtsc when available, a lot of problems will go away.



Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


