Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272795AbTGaHRX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 03:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272802AbTGaHRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 03:17:23 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:62476 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S272795AbTGaHRV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 03:17:21 -0400
Date: Thu, 31 Jul 2003 09:17:19 +0200
From: Willy Tarreau <willy@w.ods.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: TSCs are a no-no on i386
Message-ID: <20030731071719.GA26249@alpha.home.local>
References: <20030730135623.GA1873@lug-owl.de> <20030730181006.GB21734@fs.tum.de> <20030730183033.GA970@matchmail.com> <20030730184529.GE21734@fs.tum.de> <1059595260.10447.6.camel@dhcp22.swansea.linux.org.uk> <20030730203318.GH1873@lug-owl.de> <20030731002230.GE22991@fs.tum.de> <20030731062252.GM1873@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731062252.GM1873@lug-owl.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 08:22:52AM +0200, Jan-Benedict Glaw wrote:
> > The 486 emlation patch for 386 is the way to still allow 386's to run 
> > Debian.
> 
> Okay, I'll have a look at it. Where's the 2.6.x version?

It doesn't exist, but could certainly easily be ported from 2.4.

But I think that people want to use it the wrong way. I wrote it to allow older
machines to *occasionally* run code designed for the wrong architecture. Eg,
your machine dies, you unplug the disk and puts it in another one, a smaller
one, and cross your fingers for the system to work again. In this case, I
think it's easier to compile a kernel with the right options to allow emulation
than to reinstall the system with the proper packages.

Now it seems to me that people want to use it as an excuse not to respect
architectural constraints and processors instructions sets. Of course, it's
easy to compile everything for i686 and think "well, if the machine doesn't
support this or that, then the kernel will do...". But you quickly end up in
even more slowing down small machines.

The other problem lies with the lock :
When a 486 executes "LOCK ; CMPXCHG", it locks the bus during the whole cmpxchg
instruction. If a 386 executes the same code, it will get an exception which
will be caught by the emulator. I don't see how we can do such an atomic
operation while holding a lock. At best, we would think about a global memory
based shared lock during the operation (eg: int bus_lock;), but it's not
implemented at the moment, and will only be compatible with processors sharing
the same code. Add-on processors, such as co-processors, transputer cards, or
DSPs, will know nothing about such a lock emulation. And it would result in
even poorer performance of course !

And yes, I've done intensive benchmarks on the code, as did Denis Vladensko.
I used it daily on my 386sx firewall, which avoided me to recompile my pppd
for this architecture... At this time, I had a wrong gcc+libc combinations
and always got BSWAP instructions all over the code. Although pppd did not
suffer from emulation, I have seen other programs which didn't like it at
all (gzip or bzip2 for example). CPU intensive programs optimized for i686
which use lots of CMOV for example, need about 400 cycles to do a simple CMOV !
this can slow down things to an order of more than 100 when placed in an inner
loop.

So to resume, everything can be done through emulation, but that's probably
not what we want as a standard for performance reasons. When I have time, I
may port it to 2.6, but that's not no my priority list.

Cheers,
Willy

