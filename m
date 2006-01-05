Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWAFAEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWAFAEL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWAFAEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:04:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26092 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932297AbWAFAEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:04:07 -0500
Date: Thu, 5 Jan 2006 15:54:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Martin Bligh <mbligh@mbligh.org>, Matt Mackall <mpm@selenic.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Chuck Ebbert <76306.1226@compuserve.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
In-Reply-To: <20060105233049.GA3441@elte.hu>
Message-ID: <Pine.LNX.4.64.0601051548290.3169@g5.osdl.org>
References: <200601041959_MC3-1-B550-5EE2@compuserve.com> <43BC716A.5080204@mbligh.org>
 <1136463553.2920.22.camel@laptopd505.fenrus.org> <20060105170255.GK3356@waste.org>
 <43BD5E6F.1040000@mbligh.org> <Pine.LNX.4.64.0601051112070.3169@g5.osdl.org>
 <Pine.LNX.4.64.0601051126570.3169@g5.osdl.org> <43BD784F.4040804@mbligh.org>
 <Pine.LNX.4.64.0601051208510.3169@g5.osdl.org> <Pine.LNX.4.64.0601051213270.3169@g5.osdl.org>
 <20060105233049.GA3441@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Jan 2006, Ingo Molnar wrote:
> 
> i frequently validate branches in performance-critical kernel code like 
> the scheduler (and the mutex code ;), via instruction-granularity 
> profiling, driven by a high-frequency (10-100 KHz) NMI interrupt. A bad 
> branch layout shows up pretty clearly in annotated assembly listings:

Yes, but we only do this for routines that we look at anyway.

Also, the profiles can be misleading at times: you often get instructions 
with zero hits, because they always schedule together with another 
instruction. So parsing things and then matching them up (correctly) with 
the source code in order to annotate them is probably pretty nontrivial.

But starting with the code-paths that get literally zero profile events is 
definitely the way to go.

> Especially with 64 or 128 byte L1 cachelines our codepaths are really 
> fragmented and we can easily have 3-4 times of the optimal icache 
> footprint, for a given syscall. We very often have cruft in the hotpath, 
> and we often have functions that belong together ripped apart by things 
> like e.g. __sched annotators. I havent seen many cases of wrongly judged 
> likely/unlikely hints, what happens typically is that there's no 
> annotation and the default compiler guess is wrong.

We don't have likely()/unlikely() that often, and at least in my case it's 
partly because the syntax is a pain (it would probably have been better to 
include the "if ()" part in the syntax - the millions of parenthesis just 
drive me wild).

So yeah, we tend to put likely/unlikely only on really obvious stuff, and 
only on functions where we think about it. So we probably don't get it 
wrong that often.

> the dcache footprint of the kernel is much better, mostly because it's 
> so easy to control it in C. The icache footprint is alot more elusive.  
> (and also alot more critical to execution speed on nontrivial workloads)
> 
> so i think there are two major focus areas to improve our icache 
> footprint:
> 
>  - reduce code size
>  - reduce fragmentation of the codepath
> 
> fortunately both are hard and technically challenging projects

That's an interesting use of "fortunately". I tend to prefer the form 
where it means "fortunately, we can trivially fix this with a two-line 
solution that is obviously correct" ;)

		Linus
