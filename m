Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751644AbWJ1Cqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbWJ1Cqp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 22:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbWJ1Cqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 22:46:45 -0400
Received: from teetot.devrandom.net ([66.35.250.243]:19626 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1751413AbWJ1Cqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 22:46:44 -0400
Date: Fri, 27 Oct 2006 19:46:39 -0700
From: thockin@hockin.org
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, john stultz <johnstul@us.ibm.com>
Subject: Re: AMD X2 unsynced TSC fix?
Message-ID: <20061028024638.GA16579@hockin.org>
References: <1161969308.27225.120.camel@mindpipe> <20061027201820.GA8394@dreamland.darkstar.lan> <20061027230458.GA27976@hockin.org> <68676e00610271700i741b949frc73bf790d38ab1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68676e00610271700i741b949frc73bf790d38ab1f@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2006 at 02:00:11AM +0200, Luca Tettamanti wrote:

> I know that's it's possible to resync the TSCs, but:
> 
> >The catch is that, while it is monotonic, it is not guaranteed to be
> >perfectly linear.  For many applications, this will be good enough.  Time
> >will always move forward, and you won't be subject to the weird HZ
> >granularity gettimeofday that unsynced TSCs can show.
> 
> As you say you cannot use it to do timing unless you disable any power
> management on the CPU. Otherwise you can count the elapsed ticks but
> you cannot convert the number to anything meaningful.

I fyou have a third-party clock you can get pretty darn close.
Fortunately, we usually have an HPET, these days.  You can definitely
resync and get near-linear values of RDTSC.

> You may be able to emulate rdtsc for userspace but then again the
> whole point of using rdtsc is that it should be uber-fast... if rdtsc
> is emulated then you can just use gettimeofday (which is also
> optimized to be *very* fast). No?

We're not emulating it at all.  The vast vast vast majority of rdtsc calls
are nothing more than the RDTSC instruction.  RDTSC is faster than
gettimeofday(), necessarily.  If gettimeofday() uses RDTSC, then the
gettimeofday() vsyscall will be pretty good.

But, if I recall, i386 does not support vsyscall?  32 bit binaries on
x86_64 does not support vsyscall.  There is still a need for very fast
pure RDTSC.

There are few problems at hand.  I'm not familiar with the patch Andi's
talking about but it has to solve all these problems to be really useful:

* TSC skew across CPUs at bootup (Linux handles this already)
* TSC drift across CPUs at the "same" frequency (pretty constant, minimal)
* TSC drift because of PM states, such as C1 (hlt) (semi-random, severe)

Anyway, I hope that all solutions will be considered.  And I hope this
patch comes soon.

Tim
