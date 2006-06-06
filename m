Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWFFUrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWFFUrk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 16:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWFFUrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 16:47:40 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:38079 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751081AbWFFUrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 16:47:40 -0400
Date: Tue, 6 Jun 2006 22:47:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: lock validator [2.6.18 -mm merge plans]
Message-ID: <20060606204705.GA17787@elte.hu>
References: <20060604135011.decdc7c9.akpm@osdl.org> <20060606145337.GC29798@elte.hu> <20060606090258.004e6f5f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060606090258.004e6f5f.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> - I think we still have a problem with the raid/bdev changes in
>   block_dev.c.

> - the changes to block_dev.c _do_ impact non-lockdep kernels

yes, there are a few more functions that do things explicitly. If you 
worry about the stack footprint, there should be little if any impact: 
the stack footprint you looked at yesterday was on a kernel that 
included patches that are not in -mm (the -fno-sibling-calls patch) and 
the lockdep tracer (-pg) which both increase stack footprint.

> - we need to take a second look to see which other
>   dont-affect-non-lockdep-kernels patches are in fact affecting 
>   non-lockdep kernels

there should be no change to the logic of non-lockdep kernels. There 
might be some minimal impact to the code built. Wanna have an explicit 
list of what the affected functions are? [but unless you think it causes 
problems i dont think we should worry about it - we do changes all the 
time that affect the generated code but dont affect the logic. The 
inlining overhead thing is a red herring i believe.]

> - the changes to block_dev.c were pretty awful anyway

yeah - but it just matches the code there. I'll think about finding 
better ways.

> - did the various review comments I sent get disposed of in some 
>   fashion?

they were not forgotten at all (and there are others too who have sent 
feedback), they are next on my list.

> My overarching concern is the rate at which false-positive workaround 
> patches are piling up. [...]

i feel a bit frustrated that my arguments regarding these "false 
positives" remain apparently unanswered. I expressed it lots of times 
that i find most of the semantics restrictions a necessary step towards 
having a more robust kernel. The restrictions are:

 - unordered unlocks. I still think we want to document all of them. 
   They pointed to real bugs multiple times. They pointed to suboptimal 
   code. There has been _one_ case so far that i'd declare a true false 
   positive. Nevertheless i gave up resistance and implemented the 
   CONFIG_DEBUG_NON_NESTED_UNLOCKS (default-off) option, which makes 
   these messages totally voluntary.

 - stealth locking via disable_irq(). We know that this is both wrong 
   and dangerous. It's wrong because it affects all other handlers on 
   the same IRQ line, for a possibly long period of time. This also 
   uncovered the real deadlock and design flaw related to irqpoll.

 - nested locking of the same lock-type. These are not broken,
   nevertheless it's useful to extend validation to these categories too 
   - it found real bugs (about 5) in the networking code for example - 
   some of them were in core networking code. The majority of these are 
   related to i_mutex: here too i think we want to document all the
   locking rules.

(and there are some other restrictions too, which i started enforcing 
via earlier cleanups of the locking code. As i mentioned in the big 
mutex flamewar^H^H^H^Hdiscussion, restriction of semantics to a natural 
model is what i believe leads to a kernel that can be trusted more.)

> (I'm actually quite surprised at how few real bugs this checker has 
> revealed.  We must rock, or something).

The number of deadlocks found was actually much higher (and happened 
much sooner) than i expected. I expected there to be less than 10 bugs 
left, which would trickle in the timeframe of weeks. (because we thought 
we covered alot of code in our testing) What happened is that we are 
well above 10 deadlocks found so far, in just a few days.

The focus of the validator is on _new code_. Lock dependencies can now 
reach near-perfect quality almost immediately, while they needed to sit 
in the kernel for many months before. (and even then the validator found 
deadlock bugs that were years old) The fact that we now check and 
document the existing and pretty well-tested kernel too is just an added 
bonus.

Also, the validator was in the works for months and we fixed a bunch of 
bugs before we posted the patches. In fact in the past month it was 
based on -mm and was tested on an allyesconfig bzImage bootup which 
further decreased the rate of detection. I guess i should quote Davem's 
blog:

   http://vger.kernel.org/~davem/cgi-bin/blog.cgi

  "[...] I've known about this for some time, because as he was writing 
   it Ingo passed along some networking locking bugs that this sucker 
   has found. "

The networking code is the subsystem with probably the best locking 
design in place. It's nearly half a million lines of code (not counting 
drivers) and needed only about 5 annotations so far.

Another thing that also reduced the number of deadlock bugs is the 
effect of the -rt kernel's deadlock checker and agressive preemption 
model: we found dozens of deadlocks there too. The -rt kernel's deadlock 
checker covers all lock types too. (while the upstream kernel only 
covered about 50% of all locking APIs via in-situ deadlock checking.)

So there has been alot of focus on the locking APIs in the past year or 
so, so dont be surprised that the quality of locking in existing kernel 
code isnt all that bad.

Regarding annotations, my current estimation is that we'll have at most 
~0.2% rate of explicit annotations (== 'false positives'), which with 
the ~50,000 locking APIs will be at most 100 places.

The deadlock rate for newly released locking code is at least 0.5%-2%, 
and we introduce about 2000 new locking API uses per kernel release 
(about 5% of all the existing locking code in the kernel), which means 
the validator can find 10-40 new deadlocks per kernel release, at the 
price of 2 new annotations. (where 90% of the annotations are trivial, 
and the rest is only difficult because no-one knows/remembers the 
locking rules anymore ...) Furthermore, chances are that problematic 
locking constructs will be introduced with a lower probability due to 
the validator. Also, code around existing annotations could be cleaned 
up too. (as it happened in a number of cases already) So maybe the 
annotation rate will go down as well.

Furtermore, untold amount of developer time is wasted on finding 
deadlocks. The fresher the code is, the more likely it is that it has a 
deadlock bug. The bug rate of lock uses could be as high as 10% in 
totally new code. With the validator, many of these bugs will be found 
_much_ earlier, improving productivity - and putting less crap into your 
tree! That will also mean that we wont see most of those bugs.

Plus Linux support engineers at sw/hw vendors are spending significant 
amount of time fixing deadlocks. This has the added twist that changing 
locking code is always risky in a product, and it's not bad to have some 
good proof in place that the code they trigger during re-QA is actually 
correct in terms of locking dependencies.

Users also get totally frustrated at deadlocks. If something doesnt work 
as expected that's an usually an annoyance, but if the box locks up 
totally which necessiates the destruction of its current volatile data 
(its memory, via a hard reset) that's a complete and immediate 
showstopper. If you look at the kind of bugs that annoy users most 
you'll find 'lockups' really high on the list.

The validator found bugs in my _own code_ that i thought to be 
production quality, and i thought i can write correct locking code. We 
should really let the computer do this job.

	Ingo
