Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbVK2Wv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbVK2Wv5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 17:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbVK2Wv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 17:51:57 -0500
Received: from ns1.suse.de ([195.135.220.2]:19856 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932447AbVK2Wv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 17:51:57 -0500
Date: Tue, 29 Nov 2005 23:51:55 +0100
From: Andi Kleen <ak@suse.de>
To: Stephane Eranian <eranian@hpl.hp.com>
Cc: Andi Kleen <ak@suse.de>, Nicholas Miell <nmiell@comcast.net>,
       Ray Bryant <raybry@mpdtxmail.amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
Subject: Re: [discuss] Re: [Perfctr-devel] Re: Enabling RDPMC in user space by default
Message-ID: <20051129225155.GT19515@wotan.suse.de>
References: <20051129151515.GG19515@wotan.suse.de> <200511291056.32455.raybry@mpdtxmail.amd.com> <20051129180903.GB6611@frankl.hpl.hp.com> <20051129181344.GN19515@wotan.suse.de> <1133300591.3271.1.camel@entropy> <20051129215207.GR19515@wotan.suse.de> <20051129221915.GA6953@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051129221915.GA6953@frankl.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 02:19:15PM -0800, Stephane Eranian wrote:
> Andi,
> 
> On Tue, Nov 29, 2005 at 10:52:07PM +0100, Andi Kleen wrote:
> > On Tue, Nov 29, 2005 at 01:43:11PM -0800, Nicholas Miell wrote:
> > > On Tue, 2005-11-29 at 19:13 +0100, Andi Kleen wrote:
> > > > > Where did you see that PMC0 (PERSEL0/PERFCTR0) can only be programmed
> > > > > to count cpu cycles (i.e. cpu_clk_unhalted)? As far as I can tell from
> > > > > the documentation, the 4 counters are symetrical and can measure
> > > > > any event that the processor offers.
> > > > 
> > > > Linux NMI watchdog does that.
> > > > 
> > > > All other perfctr users are supposed to keep their fingers away 
> > > > from the watchdog (it looks like oprofile doesn't but not for much
> > > > longer ...) 
> > > 
> > > Why? Hardcoding PMC 0 to be a cycle counter seems to be a waste of a
> > > perfectly usable performance counter. What if I want to profile four
> > > things, none of them requiring a cycle count?
> > 
> 
> On AMD you only have 4 counters. That's not a lot for some measurements.

Disabling the NMI watchdog for that is out of question. It's a important
debugging device and without it kernel bug reports are much worse.
It increased the quality of x86-64 bug reports over the years
considerably and I'm unwilling to give that up.

I didn't realize oprofile did this so far, but I plan to definitely 
fix this.

> The other thing is that PERCTR0 is not like the TSC. It can count cycles
> but it does only implement 47bits. At a high clock rate, this can wrap
> around fairly rapidly. It all depends on what is the intended usage model.

TSC also doesn't count cycles in many circumstances (different frequency 
depending on P states or not synchronized over CPUs, even running
at completely different frequencies etc.) 

> Suppose you would have a "stable" performance monitoring interface.

Then you don't use TSC because it's not stable (or conversely
too stable for many performance measurements because it doesn't
follow the P states) 

> One could just use that interface to measure time only when needed.

Good debugging infrastructure has priority imho - and NMI watchdog
is important. You will need to live with three counters.

This means there is one alternative - some of the newer chipsets
have external watchdogs that could be also used (using the ACPI WDOG
table).  If someone writes a nice NMI driver for these then on system
with working WDOG it could replace the perfctr based timeout and free
the perfctr. That would need some code to allocate and deallocate
perfctrs though.

The older IOAPIC watchdog is no alternative because it runs too often (at HZ) 
and has too much overhead.

-Andi

