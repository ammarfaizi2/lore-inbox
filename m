Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932565AbVLBAEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbVLBAEo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 19:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932568AbVLBAEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 19:04:44 -0500
Received: from ccerelbas02.cce.hp.com ([161.114.21.105]:9642 "EHLO
	ccerelbas02.cce.hp.com") by vger.kernel.org with ESMTP
	id S932565AbVLBAEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 19:04:43 -0500
Date: Thu, 1 Dec 2005 15:41:50 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: Nicholas Miell <nmiell@comcast.net>, Ray Bryant <raybry@mpdtxmail.amd.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org,
       perfctr-devel@lists.sourceforge.net
Subject: Re: [discuss] Re: [Perfctr-devel] Re: Enabling RDPMC in user space by default
Message-ID: <20051201234150.GE3291@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20051129151515.GG19515@wotan.suse.de> <200511291056.32455.raybry@mpdtxmail.amd.com> <20051129180903.GB6611@frankl.hpl.hp.com> <20051129181344.GN19515@wotan.suse.de> <1133300591.3271.1.camel@entropy> <20051129215207.GR19515@wotan.suse.de> <20051129221915.GA6953@frankl.hpl.hp.com> <20051129225155.GT19515@wotan.suse.de> <20051130160159.GB8511@frankl.hpl.hp.com> <20051130162314.GP19515@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051130162314.GP19515@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Wed, Nov 30, 2005 at 05:23:15PM +0100, Andi Kleen wrote:
> > to count elapsed cycles while executing a ring 0 and ring 3. The watchdog
> > works by polling on the counter and after a certain delta is reached it
> > triggers an NMI interrupt which, in turn, causes a kernel crash and the
> > (bug) report. Is that the correct behavior?
> 
> The watchdog is driven by the performance counter (this means
> it has varying frequency, but that's not a big issue for the watchdog) 
> 
> It underflows every second in the fastest case or very slowly
> (if the machine is idle). Every time it underflows it checks if 
> the per CPU timer has been ticking, and if it hasn't for some time
> it triggers an oops.

How is the checking for underflows done? Polling?

> 
> The obvious solution would be to set an underflow interrupt at 2^46 or so
> and then reset the counters. For that you would need to count down though.
> 
> > 
> > Also are you sure that the PERFCTR0/PERFSEL0 are not affected when going
> > into lower power state? I know by experience that one IA-64, for instance,
> > the counters are seriously affected.
> 
> They stop ticking in idle. Yes, that's ok if you just want to measure
> cycles because there are no cycles in idle.
> 
Ok that makes sense.

> It's not ok for timing (wall clock time) purposes, but it's also not
> intended for that. If you want time use gettimeofday
> 
I agree.

> They will also clock slower if the CPU is in a P state (runs with lower
> frequency), but for measurements that's also wanted and expected I believe.
> e.g with RDTSC on Intel right now if you are in a lower P state you will
> get wrong results.
> 
> Basically it's a good cycle timer for instruction measurements and
> nothing more.

Yes, it requires pinning and also that nothing else can run
on the processor. This is very restrictive and I wonder if
this is really useable?

> Not ticking in idle actually helps with that because it makes
> it totally clear to everybody that it's not a wall clock :)
> 
Yes, except that this is silently done. There needs to be a
STRONG warning about this somewhere.

> > As Ray mentioned, it all depends on what the user/sysdamin is after.
> > Some people maybe okay with disbaling NMI in favor of more counters.
> > Obviously others people are not.
> 
> I cannot stop them from hacking the kernel, but I don't think
> I will make it easy for them to do this in a stock kernel
> (or at least not until they provide an reliable alternative watchdog
> time source) 
> 

-- 

-Stephane
