Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318269AbSHUNHG>; Wed, 21 Aug 2002 09:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318270AbSHUNHG>; Wed, 21 Aug 2002 09:07:06 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:32560 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318269AbSHUNHG>; Wed, 21 Aug 2002 09:07:06 -0400
Date: Wed, 21 Aug 2002 15:12:23 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, john stultz <johnstul@us.ibm.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Leah Cunningham <leahc@us.ibm.com>,
       wilhelm.nuesser@sap.com, paramjit@us.ibm.com, msw@redhat.com
Subject: Re: [PATCH] tsc-disable_B9
Message-ID: <20020821131223.GB1117@dualathlon.random>
References: <1028771615.22918.188.camel@cog> <1028812663.28883.32.camel@irongate.swansea.linux.org.uk> <1028860246.1117.34.camel@cog> <20020815165617.GE14394@dualathlon.random> <1029496559.31487.48.camel@irongate.swansea.linux.org.uk> <15708.64483.439939.850493@kim.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15708.64483.439939.850493@kim.it.uu.se>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2002 at 03:19:31PM +0200, Mikael Pettersson wrote:
> Alan Cox writes:
>  > On Thu, 2002-08-15 at 17:56, Andrea Arcangeli wrote:
>  > > sorry but I don't see the point of badtsc only in kernel.
>  > > 
>  > > If the TSC is bad that will be in particular bad from userspace where
>  > > there's no hope to know what CPU you're running on.
>  > 
>  > You can still do meaningful measurements for things like profiling
>  > because the cpu hop is statistically uninteresting.
> 
> There are kernel extensions around that handle process migration across
> CPUs while providing virtualised per-process TSC counts, and for which
> the TSCs do NOT need to be in perfect sync.

you mean trapping the instruction fault and emulating the tsc with a
gettimeofday? In such case you should run gettimeofday in the first
place. that's the whole point. rdtsc means rdtsc, not a software
emulation of it. If you don't want to bind your userspace to a certain
system that has tsc in sync, you should use gettimeofday since the first
place so it'll run on non x86 too.

Infact returning an instruction fault is probably one of the best way to
allow a program to autodetect if the tsc is useful. Otherwise if you
left the tsc enabled, it'll be hard for userspace to guess if the tsc
are in sync (you could with cpu binding but only if you have
privilegies, normal programs wouldn't be capable of probing that).

> Disabling user-space RDTSC just because the TSCs aren't in sync is stupid.

what you mean as non stupid has to be to still disable it (so figure out
how much disabling it is stupid) and to trap the instruction fault and
software emulate the tsc so that userspace will think the TSC aren't
disabled while they're are infact disabled.

However here the point is that the TSC was left _enabled_ (not disabled
and emulated as you are advocating) despite it was not in sync. That
cannot make any sense, except if you use the tsc as a random number
generator.

Andrea
