Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWABUal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWABUal (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 15:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWABUal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 15:30:41 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:45019 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750753AbWABUak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 15:30:40 -0500
Date: Mon, 2 Jan 2006 21:30:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, bunk@stusta.de, arjan@infradead.org,
       tim@physik3.uni-rostock.de, torvalds@osdl.org, davej@redhat.com,
       linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20060102203028.GA1131@elte.hu>
References: <20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de> <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de> <20060102103721.GA8701@elte.hu> <1136198902.2936.20.camel@laptopd505.fenrus.org> <20060102134345.GD17398@stusta.de> <20060102140511.GA2968@elte.hu> <m3ek3qcvwt.fsf@defiant.localdomain> <20060102110341.03636720.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060102110341.03636720.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Either way, we need to go all over the tree.  In practice, we'll only 
> bother going over the bits which we most care about (core kernel, core 
> networking, a handful of net and block drivers).  I suspect many of 
> the bad inlining decisions are in poorly-maintained code - we've been 
> pretty careful about this for several years.

i've gone over quite many inlining decisions, and i have to say that 
even for my _own code_, most of the historic inlining decisions were 
wrong. What seems simple on the C level, can be quite bloaty on the 
assembly level - even if you are well aware of how C maps to assembly!

furthermore, there's also a new CPU-architecture argument: the cost of 
icache misses has gone up disproportionally over the past couple of 
years, because on the first hand lots of instruction-scheduling 
'metadata' got embedded into the L1 cache (like what used to be the BTB 
cache), and secondly because the (physical) latency gap between L1 cache 
and L2 cache has increased. Thirdly, CPUs are much better at untangling 
data dependencies, hence more compact but also more complex code can 
still perform well. So the L1 icache is more important than it used to 
be, and small code size is more important than raw cycle count - _and_ 
small code has less of a speed hit than it used to have. x86 CPUs have 
become simple JIT compilers, and code size reductions tend to become the 
best way to inform the CPU of what operations we want to compute.

So as an end-result, most of the historic inlining decisions _even in 
well-maintained core code_ are mostly incorrect these days. We really 
only want to inline things where the inlining results in _smaller_ code 
(due to less clobbering of function-call related caller-saved 
registers). That pretty much only leaves the truly trivial 1-2 
instructions code sequences like get_current() and the __always_inline 
stuff like kmalloc() or memset(). All the rest wants to be a function 
call these days.

	Ingo
