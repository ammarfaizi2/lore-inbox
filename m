Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263925AbTIIOsY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 10:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264125AbTIIOsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 10:48:24 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:6278 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S263925AbTIIOsR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 10:48:17 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>
Subject: Re: Scaling noise
Date: Tue, 9 Sep 2003 02:11:15 -0400
User-Agent: KMail/1.5
Cc: CaT <cat@zip.com.au>, Larry McVoy <lm@bitmover.com>,
       Anton Blanchard <anton@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030903040327.GA10257@work.bitmover.com> <20030906150817.GB3944@openzaurus.ucw.cz> <1063028321.21050.28.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1063028321.21050.28.camel@dhcp23.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309090211.16136.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 September 2003 09:38, Alan Cox wrote:
> On Sad, 2003-09-06 at 16:08, Pavel Machek wrote:
> > Hi!
> >
> > > Maybe this is a better way to get my point across.  Think about more
> > > CPUs on the same memory subsystem.  I've been trying to make this
> > > scaling point
> >
> > The point of hyperthreading is that more virtual CPUs on same memory
> > subsystem can actually help stuff.
>
> Its a way of exposing asynchronicity keeping the old instruction set.
> Its trying to make better use of the bandwidth available by having
> something else to schedule into stalls. Thats why HT is really good for
> code which is full of polling I/O, badly coded memory accesses but is
> worthless on perfectly tuned hand coded stuff which doesnt stall.

<rant>

I wouldn't call it worthless.  "Proof of concept", maybe.

Modern processors (Athlon and P4 both, I believe) have three execution cores, 
and so are trying to dispatch three instructions per clock.  With 
speculation, lookahead, branch prediction, register renaming, instruction 
reordering, magic pixie dust, happy thoughts, a tailwind, and 8 zillion other 
related things, they can just about do it too, but not even close to 100% of 
the time.  Extracting three parallel instructions from one instruction stream 
is doable, but not fun, and not consistent.

The third core is unavoidably idle some of the time.  Trying to keep four 
cores bus would be a nightmare.  (All the VLIW guys keep trying to unload 
this on the compiler.  Don't ask me how a compiler is supposed to do branch 
prediction and speculative execution.  I suppose having to recompile your 
binaries for more cores isn't TOO big a problem these days, but the boxed 
mainstream desktop apps people wouldn't like it at all.)

Transistor budgets keep going up as manufacturing die sizes shrink, and the 
engineers keep wanting to throw transistors at the problem.  The first really 
easy way to turn transistors into performance are a bigger L1 cache, but 
somewhere between 256k and one megabyte per running process you hit some 
serious diminishing returns since your working set is in cache and your far 
accesses to big datasets (or streaming data) just aren't going to be helped 
by more L1 cache.

The other obvious way to turn transistors into performance is to build 
execution cores out of them.  (Yeah, you can also pipeline yourself to death 
to do less per clock for marketing reasons, but there's serious diminishing 
returns there too.)  With more execution cores, you can (theoretically) 
execute more instructions per clock.  Except that keeping 3 cores busy out of 
one instruction stream is really hard, and 4 would be a nightmare...

Hyperthreading is just a neat hack to keep multiple cores busy.  Having 
another point of execution to schedule instructions from means you're 
guaranteed to keep 1 core busy all the time for each point of execution 
(barring memory access latency on "branch to mars" conditions), and with 3 
cores and 2 pointes of execution they can fight over the middle core, which 
should just about never be idle when the system is loaded.

With hyperthreading (SMT, whatever you wanna call it), the move to 4 execution 
cores becomes a no-brainer.  (Keeping 2 cores busy from one instruction 
stream is relatively trivial), and even 5 (since keeping 3 cores busy is a 
solved problem, although it's not busy all the time, but the two threads can 
fight for the extra core when they actually have something for it to do...)

And THAT is where SMT starts showing real performance benefits, when you get 
to 4 or 5 cores.  It's cheaper than SMP on a die because they can share all 
sorts of hardware (not the least of which being L1 cache, and you can even 
expand L1 cache a bit because you now have the working sets of 2 processes to 
stick in it)...

Intel's been desperate for a way to make use of its transistor budget for a 
while; manufacturing is what it does better than AMD< not clever processor 
design.  The original Itanic, case in point, had more than 3 instruction 
execution cores in each chip: 3 VLIW, a HP-PA Risc, and a brain-damaged 
Pentium (which itself had a couple execution cores)...  The long list of 
reasons Itanic sucked started with the fact that it had 3 different modes and 
whichever one you were in circuitry for the other 2 wouldn't contribute a 
darn thing to your performance (although it did not stop there, and in fact 
didn't even slow down...)

Of course since power is now the third variable along with price/performance, 
sooner or later you'll see chips that individually power down cores as they 
go dormant.  Possibly even a banked L1 cache; who knows?  (It's another 
alternative to clocking down the whole chip; power down individual functional 
units of the chip.  Dunno who might actually do that, or when, but it's nice 
to have options...)

</rant>

In brief: hyper threading is cool.

> Its great feature is that HT gets *more* not less useful as the CPU gets
> faster..

Excution point 1 stalls waiting for memory, so execution point 2 gets extra 
cores.  The classic tale of overlapping processing and I/O, only this time 
with the memory bus being the slow device you have to wait for...

Rob


