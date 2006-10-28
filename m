Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbWJ1GcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWJ1GcW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 02:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWJ1GcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 02:32:22 -0400
Received: from teetot.devrandom.net ([66.35.250.243]:57304 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1751014AbWJ1GcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 02:32:21 -0400
Date: Fri, 27 Oct 2006 23:32:13 -0700
From: thockin@hockin.org
To: Andi Kleen <ak@suse.de>
Cc: vojtech@suse.cz, Jiri Bohac <jbohac@suse.cz>,
       Luca Tettamanti <kronos.it@gmail.com>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: AMD X2 unsynced TSC fix?
Message-ID: <20061028063213.GB6357@hockin.org>
References: <1161969308.27225.120.camel@mindpipe> <68676e00610271700i741b949frc73bf790d38ab1f@mail.gmail.com> <20061028024638.GA16579@hockin.org> <200610272059.13753.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610272059.13753.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2006 at 08:59:13PM -0700, Andi Kleen wrote:
> > I fyou have a third-party clock you can get pretty darn close.
> 
> Not when powernow is involved on a multi socket system.

When CPUs are in different P-States, any resync effort will become
unsynced immediately.  I agree with that.  This is a further complication
that I think our code does not handle perfectly, yet.

> > Fortunately, we usually have an HPET, these days.  You can definitely
> > resync and get near-linear values of RDTSC.
> 
> No we don't -- most BIOS still don't give us the HPET table 
> even when it is there in hardware. In the future this will change sure
> but people will still run a lot of older motherboards.

If you know where the HPET base-address-register is, can't we program it
ourselves?  Even without HPET, we have PM Timer.  As long as you don't
need to resync the TSCs on most gtod(), you can still do better than not
trying.

> > There are few problems at hand.  I'm not familiar with the patch Andi's
> > talking about but it has to solve all these problems to be really useful:
> 
> It's from Jiri and Vojtech.  Basically it will allow to use RDTSC
> in gettimeofday even with unsynchronized TSCs by keeping
> the necessary offsets CPU local.

Offset from what?  With automatic clock ramping in C1, the rate is
cycling up and down a lot.

> > * TSC drift because of PM states, such as C1 (hlt) (semi-random, severe)
> 
> TSC drift with powernow -- CPUs run at different frequencies

Yeah, C1 is workaround-able, because the clock returns to full frequency,
and we never execute code in the reduced clock state.  Powernow makes it
more fun.  Not only do you need some offset, but you need some scalar.

Assume you resync TSCs to a clock (PM, HPET, whatever) any time any CPU
changes p-state.  Then you can calculate the approximate TSC for now by:

tsc_now = tsc_at_last_resync + ((rdtsc - tsc_at_last_resync) * pstate_scalar)

Something like that.  Not pretty, but still possible to get close.  And
close might be good enough.  As long as you can guarantee monotonicity and
approximate linearity, you can make most apps happy ENOUGH.

Tim
