Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317836AbSHPBLc>; Thu, 15 Aug 2002 21:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317845AbSHPBLc>; Thu, 15 Aug 2002 21:11:32 -0400
Received: from [195.223.140.120] ([195.223.140.120]:51269 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317836AbSHPBLZ>; Thu, 15 Aug 2002 21:11:25 -0400
Date: Thu, 15 Aug 2002 18:56:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Leah Cunningham <leahc@us.ibm.com>,
       wilhelm.nuesser@sap.com, paramjit@us.ibm.com, msw@redhat.com
Subject: Re: [PATCH] tsc-disable_B9
Message-ID: <20020815165617.GE14394@dualathlon.random>
References: <1028771615.22918.188.camel@cog> <1028812663.28883.32.camel@irongate.swansea.linux.org.uk> <1028860246.1117.34.camel@cog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1028860246.1117.34.camel@cog>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2002 at 07:30:46PM -0700, john stultz wrote:
> On Thu, 2002-08-08 at 06:17, Alan Cox wrote:
> > On Thu, 2002-08-08 at 02:53, john stultz wrote:
> > > already seen on another cpu. This patch allows people compiling w/
> > > 'Multi-node NUMA support' to pass "notsc" or "bad-tsc" as boot
> > > parameters. "notsc" disables rdtsc calls, and forces the kernel to use
> > > the PIT for gettimeofday calucluations (as normally expected w/ i386
> > > compiled kernels). While "bad-tsc" forces the kernel to use the PIT for
> > > gettimeofday, but does not disable TSC access. 
> > 
> > I've done a version of this for -ac which uses the NUMA autodetect, and
> > also provides the hook so I can disable tsc on split on x86 smp with
> > variable multipliers some time. The only comment I really have is please
> 
> Not sure I followed that, do you mean per-cpu TSC management for
> gettimeofday? 
> 
> > use "badtsc" not "bad-tsc" - to match "notsc"
> 
> Sounds good. Changed in my tree.

sorry but I don't see the point of badtsc only in kernel.

If the TSC is bad that will be in particular bad from userspace where
there's no hope to know what CPU you're running on.

If the TSC is bad userspace is the one that must not be allowed to read
the tsc at all, the tsc in userspace could only have a function of a
random number generator.

So I suggest to drop the badtsc and to only have the notsc that disables
the tsc globally for both kernel and userspace. That's what I'm doing in
my tree for the above reasons at least.

> > This is how I did it - barring the code that is -ac specific to automatically flip
> > the mode when NUMA hw is detected
> 
> Interesting. See my comments below.  Auto-detection has been on my list
> for the last week, so I'm eagerly awaiting a peek at the next ac release
> :)

How do you detect the NUMA hw? That would be a nice addition so the
numa-Q users won't be required to add notsc to the append lilo line.

My current preferred status for this patch is here:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc5aa1/94_numaq-tsc-4

I'm fine to drop the #ifdefs and to allow notsc to be significant
always if you like, however also requiring a numa compilation like now
should be fine, no? At least unless you can detect the badtsc
dynamically also in kernels with numa disabled, which isn't the case
right now I guess.

But still the "allowing badtsc in userspace" in the last patches looks
obviously wrong to me, the "emulate tsc in inst fault" was better, but
even that sounds not the best, all programs should have a fallback to
use gettimeofday so it's better to get the instruction fault immediatly
rather that running slow because of the flood of exceptions that happens
silenty.

Andrea
