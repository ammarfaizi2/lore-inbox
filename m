Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWFKHdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWFKHdN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 03:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbWFKHdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 03:33:13 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:55712 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751569AbWFKHdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 03:33:12 -0400
Date: Sun, 11 Jun 2006 09:32:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Neil Brown <neilb@suse.de>, Jeff Garzik <jeff@garzik.org>,
       Theodore Tso <tytso@mit.edu>, Kyle Moffett <mrmacman_g4@mac.com>,
       Chase Venters <chase.venters@clientec.com>,
       Alex Tomas <alex@clusterfs.com>, Andreas Dilger <adilger@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: Stable/devel policy - was Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060611073214.GB11558@elte.hu>
References: <Pine.LNX.4.64.0606091137340.5498@g5.osdl.org> <Pine.LNX.4.64.0606091347590.5541@turbotaz.ourhouse> <4489C580.7080001@garzik.org> <17D07BC0-4B41-4981-80F5-7AAEC0BB6CC8@mac.com> <Pine.LNX.4.64.0606101238110.5498@g5.osdl.org> <Pine.LNX.4.64.0606101248030.5498@g5.osdl.org> <20060610212624.GD6641@thunk.org> <448B45ED.1040209@garzik.org> <17547.40585.982575.7069@cse.unsw.edu.au> <Pine.LNX.4.64.0606102207030.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606102207030.5498@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5409]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> And even more interestingly (at least to me), the question might 
> become one of "how does that affect the tools and build and 
> configuration infrastructure", and just the general flow of 
> development.
> 
> I don't think one or two filesystems (and a few drivers) splitting is 
> anythign new, but if this ends up becoming _more_ common, maybe that 
> implies a new model entirely..

at least for core kernel stuff, it's hard to split things in any 
manageable way (as you mentioned it as well) - so higher flux is 
inevitable.

So what i've been focusing on more in the past year or so is to enable 
the core kernel to take more development flux, via kernel features.

Instead of adding more features to the kernel, i'm quite interested in 
seeing more technologies that make a higher development flux safer: to
make the kernel more debuggable, to make bugs more reportable for users,
to make the effects of bugs less harmful, and to make the kernel itself
notice more bugs by itself.

To be able to handle a higher development flux in core code, i think we 
need the following policies wrt. core kernel changes:

 - More code consolidation between architectures and subsystems.

   Core kernel changes impact "non-mainstream" architectures the most - 
   while some of our best technologies root from non-mainstream 
   technologies. So it's a net loss to only concentrate on the 
   mainstream, because developer and technology distribution does not 
   follow user distribution.

   The generic irq subsystem, spinlock and semaphore/mutex consolidation 
   are all efforts in this direction. I consider the Generic Time Of Day 
   (GTOD) effort a similarly important item, for the same reasons. There 
   are other good examples too, for example klibc is a good step towards 
   a more consolidated boot process. The Xen subarch work triggers 
   consolidation too - etc. Andrew's policy of "you must not break _any_ 
   architecture in -mm" is very important too.

   And we should do consolidation even in cases where there's some
   minimal runtime cost. Being able to handle higher flux is more 
   important than getting the last cycle out of the system. This does
   not mean we should reject patches that do get those last cycles, this 
   only means we should not reject consolidation patches on the grounds 
   that they _lose_ a few cycles. I dont think this is a common problem 
   for consolidation projects right now - but it could happen in the 
   future.

 - Even more cleanups.

   We always preferred cleanups but it now becomes critical: i strongly 
   believe that cleanups must take precedence over feature work. [with a 
   few rare and temporary exceptions perhaps, like hardware-enablement 
   or really critical features.] It's much easier to spot bugs in clean 
   code, plus it's much easier for automated correctness validators to 
   find bugs in clean code.

   (My own examples here include spinlock-init cleanups, which directly
   enabled things like the lock validator. But pure code cleanups apply 
   too. )

 - More automated correctness-checking tools and kernel features.

   While the preferred mode of avoiding bugs should be a clean 
   design and clean code, higher flux introduces higher noise and bugs 
   are inevitable. So the importance of automated tools (both static and 
   dynamic analysis) increased.

   Sparse annotations are one good example. My own examples here are the
   lock validator, the mutex debugging code, the consolidated
   spinlock debugging code. Some of these are direct feature-enablers: 
   for example the smp_processor_id() debugging code directly enabled a 
   safe and painless migration to PREEMPT_BKL. One nice feature in the 
   works that can find hard-to-spot bugs is kmemleak.

 - Coding style police!

   With higher development flux it is becoming even more important for 
   kernel developers to review other developer's work. But that is very 
   hard if the coding style varies too much. This is a fundamentally 
   human problem, and the only sane solution is brutal: the _strict_ 
   Linus coding style must be used in all high-flux subsystems.

 - More debuggability, reportability.

   In this area we still suck quite a bit, and this affects userspace
   too: currently we have nothing equivalent to things like Dr Watson,
   in Linux most of the info about the first userspace crash almost 
   always gets lost! (and even afterwards, once debug packages are 
   downloaded and the app is run in gdb, it's still too painful for the 
   user, so we lose lots of feedback.)

   Some of the GUIs try to do something about this and automate crash 
   reporting, but it doesnt cover most of the app crashes and userspace 
   clearly needs kernel help, because ptrace is too inflexible for this 
   purpose. (help is on the way though, there's a next-gen ptrace 
   project that solves these problems very cleanly.)

   There are a number of important projects going on in this area - for 
   example the dwarf unwinder for x86_64 to improve the quality of 
   kernel oopses, and kgdb (or bits of NLKD) if it gets clean enough.

my own impression is that things are going in the right direction, but
that there should be more awareness of these principles. I think if we
add a couple of more key technologies then we can take the higher kernel
development flux just fine, without compromising quality. Even though
Linux has lots of developers, we should be more economic with that
development power and should waste less of that on unnecessarily complex
debugging tasks.

I do consider the forking of a subsystem the "easy way out" - the hard 
and more correct approach is i think to turn every drastic rewrite into 
small manageable steps. That's much easier said than done, and it's 
sometimes 10 times the work but it's alot safer - and the end result is 
often wildly different (and alot cleaner!) from what one would do via a 
drastic rewrite. A dumb 'cp -a' copying of a subsystem will preserve 
most of the legacies and architectural inefficiencies. Even an 
intelligent drastic rewrite preserves most of the legacies - there's 
just so much of change users can take at once, and _eventually_ a new 
subsystem has to be exposed to real users - at which point the 
compatibility constraints apply again. I have yet to see a single case 
of hard physical necessity to throw away an old subsystem due to 
legacies. I think the prime example to follow is how Al Viro works - 
he's beein maintaining the VFS for many years without having to 
duplicate functionality, without breaking the world, but he still 
managed to turn the VFS upside down, inside out, in small, manageable 
steps. It _is_ possible in almost every case, for all but the most 
spaghetti pieces of code.

	Ingo
