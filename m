Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbWJKWsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbWJKWsl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 18:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965228AbWJKWsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 18:48:41 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:25248 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964994AbWJKWsk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 18:48:40 -0400
Subject: Re: [PATCH] i386 Time: Avoid PIT SMP lockups
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20061011142646.eb41fac3.akpm@osdl.org>
References: <1160596462.5973.12.camel@localhost.localdomain>
	 <20061011142646.eb41fac3.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 11 Oct 2006 15:48:31 -0700
Message-Id: <1160606911.5973.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-11 at 14:26 -0700, Andrew Morton wrote:
> On Wed, 11 Oct 2006 12:54:21 -0700
> john stultz <johnstul@us.ibm.com> wrote:
> > Andrew: I think this is 2.6.19 material, but probably should go through an -mm or two.
> > 
> > 
> > This patch avoids possible PIT livelock issues seen on SMP systems (and
> > reported by Andi), by not allowing it as a clocksource on SMP boxes.
> > 
> > However, since the PIT may no longer be present, we have to properly
> > handle the cases where SMP systems have TSC skew and fall back from the
> > TSC. Since the PIT isn't there, it would "fall back" to the TSC again.
> > So this changes the jiffies rating to 1, and the TSC-bad rating value to
> > 0.
> > 
> > Thus you will get the following behavior priority on i386 systems:
> > 
> > tsc		[if present & stable]
> > hpet		[if present]
> > cyclone		[if present]
> > acpi_pm		[if present]
> > pit		[if UP]
> > jiffies
> > 
> > Rather then the current more complicated:
> > tsc		[if present & stable]
> > hpet		[if present]
> > cyclone		[if present]
> > acpi_pm		[if present]
> > pit		[if cpus < 4]
> 
> Actually <=4, and that matters: there are a lot of 4-ways.

Yes, you're right.

> 
> > tsc		[if present & unstable]
> > jiffies
> > 
> 
> So this patch has the potential to screw up people who have 2-way or 4-way,
> no hpet/pm-timer and dodgy TSCs.

Indeed. Although I believe the number of TSC screwy SMP boxes w/o an
ACPI PM or HPET is quite small (NUMAQ being the one I'm familiar with,
but it already was using jiffies in multi-node configs).

And by "screw up", it would mean pretty course(tick) granular time.
Otherwise the systems should still function correctly, but I recognize
the loss in granularity could be seen as a regression. The trade off
being that a hang (which would be seen otherwise) isn't acceptable
either.

> Wouldn't it be better to fix the livelock?  What's causing it?

I spent a few days trying to narrow this down, and I haven't been able
to do so to my satisfaction.

At this point, my suspicion is that because the PIT io-read is very slow
(~18us), and done while holding a lock. It would be possible that one
cpu calling gettimeofday would do the following:

grab xtime sequence read lock
grab i8253 spin lock
do port io (very slow)
release i8253 spin lock
realize xtime has been grabed and repeat

While another cpu does the following after in a timer interrupt:
Grabs xtime sequence write lock
spins trying to grab i8253 spin lock

Assuming the first thread can reacquire the i8253 lock before the
second, you could have both threads potentially spinning forever.

I've not yet been able to prove this. alt-sysrq-t usually doesn't have
*any* threads in gettimeofday/timer_interrupt, but removing the
expensive port io in pit_read() causes the hang to go away.

I'm open to digging on this more, but I wanted to get the fix out so
others didn't hit the hang in the meantime.

thanks
-john

