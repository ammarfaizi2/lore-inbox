Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965313AbWADWnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965313AbWADWnp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965311AbWADWnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:43:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4028 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965312AbWADWno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:43:44 -0500
Date: Wed, 4 Jan 2006 14:37:19 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       Adrian Bunk <bunk@stusta.de>, mingo@elte.hu, tim@physik3.uni-rostock.de,
       arjan@infradead.org, davej@redhat.com, linux-kernel@vger.kernel.org,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
In-Reply-To: <43BB6255.2030903@mbligh.org>
Message-ID: <Pine.LNX.4.64.0601041356200.3668@g5.osdl.org>
References: <1135897092.2935.81.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de>
 <20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de>
 <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de>
 <20060102103721.GA8701@elte.hu> <20060102134228.GC17398@stusta.de>
 <20060102102824.4c7ff9ad.akpm@osdl.org> <43BB0B8B.1000703@mbligh.org>
 <20060104042822.GA3356@waste.org> <43BB6255.2030903@mbligh.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 3 Jan 2006, Martin J. Bligh wrote:
>
> Well, it's not just one function, is it? It'd seem that if you unlined
> a whole bunch of stuff (according to this theory) then normal
> macro-benchmarks would go faster? Otherwise it's all just rather
> theoretical, is it not?

One of the problems with code size optimizations is that they 
fundamentally show much less impact under pretty much any traditional 
benchmark.

In user space, for example, the biggest impact of size optimization tends 
to be in things like load time and low-memory situations. Yet, that's 
never what is benchmarked (yeah, people will benchmark some low-memory 
kernel situations by compating different swap-out algorithms etc against 
each other - but they'll almost never compare the perceived speed of your 
desktop when you start swapping).

Now, I'll happily also admit that code and data _layout_ is often a lot 
more effective than just code size optimizations. That's especially true 
with low-memory situations where the page size being larger than many of 
the code sequences, you can make a bigger impact by changing utilization 
than by changing absolute size.

But even then it's actually really hard to measure. Cache effects tend to 
be hard _anyway_ to measure, it's really hard when the interesting case is 
the cold-cache case and can't even do simple microbenchmarks that repeat a 
million times to get stable results.

So the best we can usually do is "microbenchmarks don't show any 
noticeable _worse_ behaviour, and code size went down by 10%".

Just as an example: there's an old paper on the impact of the OS design on 
the memory subsystem, and one of the tables is about how many cycles per 
instruction is spent on cache effects (this was Ultrix vs Mach, the load 
was the average of a workload that was either specint or looked a lot 
like it).

			I$	D$

	Ultrix user:	0.07	0.08
	Mach user:	0.07	0.08
	Ultrix system:	0.43	0.23
	Mach system:	0.57	0.29

Now, that's an oldish paper, and we really don't care about Ultrix vs Mach 
nor about the particular hw (Decstation), but the same kind of basic 
numbers have been repeated over an over. Namely that system code tends to 
have very different behaviour from user code wrt caches. Caches may have 
gotten better, but code has gotten bigger, and cores have gotten faster.

And in particular, they tend to be _much_ worse. Something you'll seldom 
see as clearly in micro-benchmarks, if only because under those benchmarks 
things will generally be more cached - especially on the I$ side.

So I should probably try to find something slightly more modern, but what 
it boils down to is that at least one well-cited paper that is fairly easy 
to find claims that about _half_a_cycle_ for each instruction was spent on 
I$ misses in system code on a perfectly regular mix of programs. And that 
the cost of I$ was actually higher than the cost of D$ misses.

Now, most of the _time_ tends to be spent in user mode. That is probably 
part of the reason for why system mode gets higher cache misses (another 
is that obviously you'd hope that the user program can optimize for its 
particular memory usage, while the kernel can't). But the result remains: 
I$ miss time is a noticeable portion of system time.

Now, I claim that I$ miss overhead on a system would probably tend to have 
a pretty linear relationship with the size of the static code. There 
aren't that many big hot loops or small code that fits in the I$ to skew 
that trivial rule.

So at a total guess, and taking the above numbers (that are questionable, 
but hey, they should be ok as a starting point for WAGging), reducing code 
size by 10% should give about 0.007 cycles per instruction in user space. 
Whee. Not very noticeable. But on system code (the only thing the kernel 
can help), it's actually a much more visible 0.05 CPI.

Yeah, the math is bogus, the numbers may be irrelevant, but it does show 
why I$ should matter, even though it's much harder to measure.

			Linus
