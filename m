Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318294AbSHUO2H>; Wed, 21 Aug 2002 10:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318295AbSHUO2H>; Wed, 21 Aug 2002 10:28:07 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:2366 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318294AbSHUO2G>; Wed, 21 Aug 2002 10:28:06 -0400
Date: Wed, 21 Aug 2002 16:33:23 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, john stultz <johnstul@us.ibm.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Leah Cunningham <leahc@us.ibm.com>,
       wilhelm.nuesser@sap.com, paramjit@us.ibm.com, msw@redhat.com
Subject: Re: [PATCH] tsc-disable_B9
Message-ID: <20020821143323.GF1117@dualathlon.random>
References: <1028771615.22918.188.camel@cog> <1028812663.28883.32.camel@irongate.swansea.linux.org.uk> <1028860246.1117.34.camel@cog> <20020815165617.GE14394@dualathlon.random> <1029496559.31487.48.camel@irongate.swansea.linux.org.uk> <15708.64483.439939.850493@kim.it.uu.se> <20020821131223.GB1117@dualathlon.random> <1029939024.26425.49.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1029939024.26425.49.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2002 at 03:10:24PM +0100, Alan Cox wrote:
> On Wed, 2002-08-21 at 14:12, Andrea Arcangeli wrote:
> > However here the point is that the TSC was left _enabled_ (not disabled
> > and emulated as you are advocating) despite it was not in sync. That
> > cannot make any sense, except if you use the tsc as a random number
> > generator.
> 
> Totally untrue. When you are doing profiling the data is very useful
> because CPU switches are trivial to filter and statistically rare

You can use statistic to guess what are the measurements that you've to
filter agreed, however this mostly applies to hot cache measurements
(likely to return many times the same result if there's no error) and in
particular where you are allowed to waste cpu time in repeating many
times the same workload before you say "ok this is the right measure".

Filtering out the errors is not feasible in all the cases, even if you
are allowed to repeat the same measurement multiple times. And it also
depends if you have a 3-way pipe communication in background.

And you'll keep to silenty break in all other applications that uses
rdtsc to know how much time has passed, that can hardly understand if
they can use the tsc or not unless we tell it to them from the kernel.

If you want to use the tsc in a controlled manner using statistic for
just profiling of a certain piece of code where it is easy to
demonstrate the absolute most frequent result is the correct one (as
said it's not always the case, when you do measurements out of hot cpu
cache the masurements vary significantly all the time, you are very well
aware about it), at the very least it should be a  privilegied sysctl or
a non privilegied prctl (prctl however requires a slowdown of
swithc_to). Infact if we add a branch to switch_to we could even
automatically allow it for processes that are bind to a single cpu (or
to a single NUMA node adding some more internal knowledge about the numa
topology).

But silenty breaking apps and not allowing in any way to apps to learn
if the tsc is returning random or if it's returning something
significant (I understand that's the way you did it in -ac) is a no-way
by default IMHO.

Andrea
