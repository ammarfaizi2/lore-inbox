Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUICVJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUICVJy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 17:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267457AbUICVJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 17:09:54 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:34804 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262279AbUICVJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 17:09:50 -0400
Subject: Re: [RFC] New Time of day proposal (updated 9/2/04)
From: john stultz <johnstul@us.ibm.com>
To: Dominik Brodowski <linux@dominikbrodowski.de>
Cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, clameter@sgi.com,
       Len Brown <len.brown@intel.com>, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <20040903202615.GA18255@dominikbrodowski.de>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>
	 <20040903095435.GA11572@dominikbrodowski.de>
	 <1094240482.14662.525.camel@cog.beaverton.ibm.com>
	 <20040903202615.GA18255@dominikbrodowski.de>
Content-Type: text/plain
Message-Id: <1094245529.14662.608.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 03 Sep 2004 14:05:29 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-03 at 13:26, Dominik Brodowski wrote:
> On Fri, Sep 03, 2004 at 12:41:22PM -0700, john stultz wrote:
> > > - cpufreq hooks to tsc.c and i386_tsc.c[*] can easily be added. For them to
> > >   work _better_ than current code: can timeofday_hook() be called (with IRQs
> > >   disabled) _anywhen_ from kernel context? 
> > >    [*] actually, only one of them needs the notifier, AFAICS...
> > 
> > Yep, that's on my list. I'm trying to keep to just cleaning up one thing
> > at a time, but since I've got to re-work the timer_tsc.c code anyway, I
> > figured I'd try to organize all the TSC related functions
> > (synchronization, cpufreq, get_cycles(), tsc_delay maybe?) into tsc.c.
> > This will simplify things if we ever get around to correctly fixing the
> > SMP systems w/ different speed cpus issue. 
> 
> What about removing cpu_freq_khz you have in your patch, adding a per-CPU 
> value, and just use the value of the boot CPU for the other CPUs if
> !CONFIG_DIFFERENT_CPU_SPEEDS or something like that?

Well, for now I just want to re-implement what we already provide. If I
can fix something simple while I'm doing I will, but I don't want to
change behavior too much in order to simplify testing (if vanilla works
fine, and my patch breaks then I want it to be a core bug rather then a
"I changed the semantics of something slightly" issue). 

Once I'm having to manage less code, I'll be very much interested in
fixing those outstanding issues. One thing at a time, and all.

> > > - what about keeping lower-priority timesources still "active" in some sort to
> > >   a) enable loading _and_ unloading timsources (even modularizing them
> > > 	becoms possible which should make testing easier...),
> > >   b) call them every couple of seconds to verify the currently used
> > > 	timesource is still sane (and if not, call cpufreq_delayed_get() for
> > > 	example or disable the timesource). This would mean that e.g. pmtmr 
> > > 	and pit can be used to "verify" and "backup" tsc, or otherwise... 
> > > 	The "clock=tsc" override would only affect the priority of the 
> > > 	timesource then, making it so large that no other timesource can 
> > > 	"preempt" it, but doesn't avoid making other timesources available
> > > 	for backup and verification purposes.
> > 
> > That's totally the plan, although I want to put the control into sysfs.
> 
> Even better. Thought about that too, but was worried you'd dislike the sysfs
> overhead.

Overhead? Not sure I see where that'd be a problem. The available
timesource management code needs to be split off into a timesource.c,
but I'll get to that later.

thanks
-john

