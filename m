Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262273AbVFTWHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbVFTWHV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 18:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbVFTWHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 18:07:20 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:50872 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261711AbVFTVxw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:53:52 -0400
Subject: Re: [PATCH 1/6] new timeofday core subsystem for -mm (v.B3)
From: john stultz <johnstul@us.ibm.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <1119291034.16180.9.camel@mindpipe>
References: <1119063400.9663.2.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0506181344000.3743@scrub.home>
	 <1119287354.9947.22.camel@cog.beaverton.ibm.com>
	 <1119291034.16180.9.camel@mindpipe>
Content-Type: text/plain
Date: Mon, 20 Jun 2005 14:53:42 -0700
Message-Id: <1119304422.9947.90.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-20 at 14:10 -0400, Lee Revell wrote:
> On Mon, 2005-06-20 at 10:09 -0700, john stultz wrote:
> > As for gettimefoday() syscall performance, I one had some numbers, but
> > I
> > would need to re-create them. I'll see if I can grab a slower box and
> > give you some hard numbers. 
> 
> I ran some tests lately that showed gettimeofday() to be 50x slower than
> rdtsc() on my 600Mhz machine.  Many userspace apps that need a cheap
> high res timer have to use rdtsc now due to the excessive overhead of
> gettimeofday().  It would be more correct if these apps could use
> gettimeofday() for various reasons (cpufreq and SMP issues).

Yea, I would strongly dissuade anyone from using the rdtsc counter for
anything but statistical analysis of code performance. 


> So this patch is addressing a real problem.  I'd be interested to see if
> the performance is good enough to replace rdtsc in these cases.

Yea, honestly I doubt gettimefoday performance will ever be as good as
rdtsc. I mean, that's a single instruction vs syscall overhead +
hardware clock reading + frequency conversion + ntp adjustment. Its just
not a fair comparison. 

On the other hand, I bet reading a random 64 bits out of memory is also
a bit faster then gettimeofday() as well ;)

I don't mean to promise the world. The point of the patch is not to
improve gettimeofday performance, it is to improve the subsystem so it
is correct and manageable, so that we have the flexibility to make
future improvements (such as High-res Timers, Dynamic Ticks/Variable
system timer, and virtualization needs) without impacting performance.

The best payout for gettimeofday performance will probably be in
vsyscall implementations such as what x86-64 already has. My new
infrastructure also supports this (it had to for x86-64), and I've even
got a proof of concept patch for i386 (see the lkml archives for
details).

thanks
-john

