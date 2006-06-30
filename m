Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbWF3Odn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWF3Odn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 10:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWF3Odn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 10:33:43 -0400
Received: from mx1.suse.de ([195.135.220.2]:26333 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964802AbWF3Odm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 10:33:42 -0400
From: Andi Kleen <ak@suse.de>
To: eranian@hpl.hp.com
Subject: Re: [PATCH 10/17] 2.6.17.1 perfmon2 patch for review: PMU context switch
Date: Fri, 30 Jun 2006 16:33:35 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200606230913.k5N9D73v032387@frankl.hpl.hp.com> <200606301541.22928.ak@suse.de> <20060630141248.GC22381@frankl.hpl.hp.com>
In-Reply-To: <20060630141248.GC22381@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606301633.35818.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 June 2006 16:12, Stephane Eranian wrote:
> Andi,
> 
> On Fri, Jun 30, 2006 at 03:41:22PM +0200, Andi Kleen wrote:
> > 
> > > So why do we need care about context switch in cpu-wide mode?
> > > It is because we support a mode where the idle thread is excluded
> > > from cpu-wide monitoring. This is very useful to distinguish 
> > > 'useful kernel work' from 'idle'. 
> > 
> 
> The exclude-idle feature is an option you select when you create
> your cpu-wide session. By default, it is off.
> 
> > I don't quite see the point because on x86 the PMU doesn't run
> > during C states anyways. So you get idle excluded automatically.
> > 
> Yes, but that may not necessarily be troe of all architectures.
> At least with the option, the interfaces provides some guarantee.

I don't think it makes sense to complicate the software if the
hardware already guarantees it. So please remove it.

If there is ever an PMU which ticks in C states you could readd
it, but it would surprise me if that will ever happen because
it would conflict with power saving.

Actually there is one reason to use idle notifiers anyways for the PMU -
it can be used to correct for the not ticking PMU in C. So e.g. 
you could synthesize an artificial counter out of CPU_CLK_UNHALTED
(and equivalents) + RDTSC measurements before/after idle
(+ correcting the overflows for lost time). With that people
can get full accounting including idle without doing nasty
things like idle=poll

I wanted to do that for oprofile at some point but never got
around to it. But that was one of the reasons the idle notifiers
got added.

But without that I don't think you should special case idle
at all.

> 
> > And on the other hand a lot of people especially want idle
> > accounting too and boot with idle=poll. Your explicit 
> > code would likely defeat that.
> > 
> > > As you realize, that means 
> > > that we need to turn off when the idle thread is context switched
> > > in and turn it back on when it is switched off.
> > 
> > Also x86-64 has idle notifiers for this if you really wanted
> > to do it properly.
> > 
> That looks like a useful feature I could leverage but why is it just
> on x86-64 at the moment?

s390 has it too (I stole it from there) Others could add it I guess
if there is a good case.

-Andi
