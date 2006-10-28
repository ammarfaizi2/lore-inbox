Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751698AbWJ1D7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbWJ1D7o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 23:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbWJ1D7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 23:59:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:31971 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751698AbWJ1D7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 23:59:42 -0400
From: Andi Kleen <ak@suse.de>
To: thockin@hockin.org, vojtech@suse.cz, Jiri Bohac <jbohac@suse.cz>
Subject: Re: AMD X2 unsynced TSC fix?
Date: Fri, 27 Oct 2006 20:59:13 -0700
User-Agent: KMail/1.9.1
Cc: Luca Tettamanti <kronos.it@gmail.com>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
References: <1161969308.27225.120.camel@mindpipe> <68676e00610271700i741b949frc73bf790d38ab1f@mail.gmail.com> <20061028024638.GA16579@hockin.org>
In-Reply-To: <20061028024638.GA16579@hockin.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610272059.13753.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 October 2006 19:46, thockin@hockin.org wrote:
> On Sat, Oct 28, 2006 at 02:00:11AM +0200, Luca Tettamanti wrote:
> > I know that's it's possible to resync the TSCs, but:
> > >The catch is that, while it is monotonic, it is not guaranteed to be
> > >perfectly linear.  For many applications, this will be good enough. 
> > > Time will always move forward, and you won't be subject to the weird HZ
> > > granularity gettimeofday that unsynced TSCs can show.
> >
> > As you say you cannot use it to do timing unless you disable any power
> > management on the CPU. Otherwise you can count the elapsed ticks but
> > you cannot convert the number to anything meaningful.
>
> I fyou have a third-party clock you can get pretty darn close.

Not when powernow is involved on a multi socket system.

This means it could be probably gotten to work on a variety of systems,
but it wouldn't work on other systems because of that and I don't 
think it makes sense to try to fix an interface that will never 
work everywhere.

> Fortunately, we usually have an HPET, these days.  You can definitely
> resync and get near-linear values of RDTSC.

No we don't -- most BIOS still don't give us the HPET table 
even when it is there in hardware. In the future this will change sure
but people will still run a lot of older motherboards.

> > You may be able to emulate rdtsc for userspace but then again the
> > whole point of using rdtsc is that it should be uber-fast... if rdtsc
> > is emulated then you can just use gettimeofday (which is also
> > optimized to be *very* fast). No?
>
> We're not emulating it at all.  The vast vast vast majority of rdtsc calls
> are nothing more than the RDTSC instruction.> RDTSC is faster than 
> gettimeofday(), necessarily.  If gettimeofday() uses RDTSC, then the
> gettimeofday() vsyscall will be pretty good.

Yes.

> But, if I recall, i386 does not support vsyscall?  

There are ways to make it work there.

> 32 bit binaries on 
> x86_64 does not support vsyscall.  

And here too.

Basically you have to test for the calls in the system call vDSO
and jump off. It's a little ugly but possible. I think John had experimental
patches for this once.

> There are few problems at hand.  I'm not familiar with the patch Andi's
> talking about but it has to solve all these problems to be really useful:

It's from Jiri and Vojtech.  Basically it will allow to use RDTSC
in gettimeofday even with unsynchronized TSCs by keeping
the necessary offsets CPU local.

Drawback: for vsyscall you need RDTSCP, this means AMD F stepping
at least. But even as a syscall it will be still faster than before.

> * TSC skew across CPUs at bootup (Linux handles this already)

Just not very good. There is still a significant error when it's done.

> * TSC drift across CPUs at the "same" frequency (pretty constant, minimal)

It just adds up over time.

> * TSC drift because of PM states, such as C1 (hlt) (semi-random, severe)

TSC drift with powernow -- CPUs run at different frequencies

-Andi
