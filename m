Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268004AbTBYPsT>; Tue, 25 Feb 2003 10:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268007AbTBYPsT>; Tue, 25 Feb 2003 10:48:19 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:1213 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S268004AbTBYPsQ>;
	Tue, 25 Feb 2003 10:48:16 -0500
Date: Tue, 25 Feb 2003 08:44:50 -0700
From: yodaiken@fsmlabs.com
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, yodaiken@fsmlabs.com,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@digeo.com>, lm@work.bitmover.com,
       mbligh@aracnet.com, davidsen@tmr.com, greearb@candelatech.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030225084450.B8282@hq.fsmlabs.com>
References: <20030224075430.GN10411@holomorphy.com> <20030224080052.GA4764@gnuppy.monkey.org> <20030224004005.5e46758d.akpm@digeo.com> <20030224085031.GP10411@holomorphy.com> <20030224091758.A11805@hq.fsmlabs.com> <20030224231341.GQ10411@holomorphy.com> <20030224162754.A24766@hq.fsmlabs.com> <20030225021736.GB4507@gnuppy.monkey.org> <1046187058.4096.12.camel@irongate.swansea.linux.org.uk> <20030225145912.GA4162@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030225145912.GA4162@gnuppy.monkey.org>; from billh@gnuppy.monkey.org on Tue, Feb 25, 2003 at 06:59:12AM -0800
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 06:59:12AM -0800, Bill Huey wrote:
> latency characteristics by what seems like some mild changes to the Linux
> kernel. I recently start to investigate their stuff, took a clue from them
> and became convince that this approach was very neat and elegant. MontaVista
> apparently uses this approach over other groups that run Linux as a thread
> in another RT kernel. Whether this, static analysis tools doing rate{deadline}-monotonic
> analysis and scheduler "reservations" (born from that RT theory I believe)
> are unclear to me at this moment. I just find this particular track neat
> and reminiscent of some FreeBSD ideals that I'd like to see fully working in
> an open source kernel.

There are two easy tests:
	1) Run a millisecond period real-time task on a system under
	heave load (not just compute load) and ping flood
	 and find worst case jitter.
	In our experience tests run for less than 24 hours are worthless.
	(I've seen a lot of numbers based on 1million interrupts -
	do the math and laugh)
	It's not fair to throttle the network to make the numbers come
	out better. Please also make clear how much of the kernel you
	had to rewrite to get your numbers: e.g. specially configured
	network drivers are nice, but have an impact on usability.

	BTW: a version of this test is distributed with RTLinux . 
	2) Run the same real-time task and run a known compute/I/O load
	such as the standard kernel compile to see the overhead of 
	real-time. Remember:
		hard cli:
		run RT code only
		
	produces great numbers for  (1) at the expense of (2) so
	no reconfiguration allowed between these tests.

	Now try these on some embedded processors that run under 
	1GHz and 1G memory.

FWIW: RTLinux numbers are 18microseconds jitter and about 15 seconds 
slowdown of a 5 minute kernel compile on a kinda wimpy P3.  On a 2.4Ghz
we do slightly better. I got 12 microseconds on a K7, the drop for 
embedded processors is low. PowerPCs are generally excellent. The 
second test requires a little more work on things like StrongArms
because nobody has the patience to time a kernel compile on those.

As for RMA, it's a nice trick, but of limited use. Instead of 
test (and design for testability) you get a formula for calculating
schedulability from the computation times of the tasks. But since we 
have no good way to estimate compute times of code without test, it
has the result of moving ignorance instead of removing it. Also, the
idea that frequency and priority are lock-step is simply incorrect
for many applications. When you start dealing with really esoteric
concepts: like demand driven tasks and shared resources,
RMA wheezes mightily.

Pre-allocation of resources is good for RT, although not especially
revolutionary. Traditional RT systems were written using cyclic 
schedulers. Many of our simulation customers use a "slot" or 
"frame" scheduler. Fortunately, these are really old ideas so I 
know about them.

Probably because of the well advertised low level of my knowledge and 
abilities, I advocate that RT systems be designed with simplicity and
testability in mind. We have found that exceptionally complex RT 
control systems can be developed on such a basis. Making the tools more
complicated does not seem to improve reliability or performance: 
the application performance is more interesting than features of the
OS.

You can see a nice illustration of the differences
between RTLinux and the TimeSys approach in my paper on priority
inheritance http://www.fsmlabs.com/articles/inherit/inherit.html
(Orignally http://www.linuxdevices.com/articles/AT7168794919.html)
and Doug Locke's response 
	http://www.linuxdevices.com/articles/AT5698775833.html

	


> 
> Top level link to many papers:
> 	http://linuxdevices.com/articles/AT6476691775.html
> 
> A paper I've take interest in recently from the top-level link:
> 	http://www.linuxdevices.com/articles/AT6078481804.html
> 
> People I originally talked to that influence my view on this:
> 	http://www-2.cs.cmu.edu/~rajkumar/linux-rk.html
> 
> > Its called engineering. There are multiple ways to build most things, each
> > with different advantages, there are multiple ways to model it each with
> > more accuracy in some areas. Knowing how to use the right tool is a lot 
> > more important than having some religion about it.
> 
> Yes, I agree. I'm not trying to make a religious assertion and I don't
> function that way. I just want things to work smoother and explore some
> interesting ideas that I think eventually will be highly relevant to a
> very broad embedded arena.
> 
> bill
>  

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
www.fsmlabs.com  www.rtlinux.com
1+ 505 838 9109

