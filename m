Return-Path: <linux-kernel-owner+w=401wt.eu-S1752263AbWLQJBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263AbWLQJBD (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 04:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752265AbWLQJBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 04:01:02 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:52293 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752263AbWLQJBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 04:01:00 -0500
Date: Sun, 17 Dec 2006 09:58:59 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Catalin Marinas <catalin.marinas@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc1 00/10] Kernel memory leak detector 0.13
Message-ID: <20061217085859.GB2938@elte.hu>
References: <20061216153346.18200.51408.stgit@localhost.localdomain> <20061216165738.GA5165@elte.hu> <b0943d9e0612161539s50fd6086v9246d6b0ffac949a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0943d9e0612161539s50fd6086v9246d6b0ffac949a@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Catalin Marinas <catalin.marinas@gmail.com> wrote:

> Hi Ingo,
> 
> On 16/12/06, Ingo Molnar <mingo@elte.hu> wrote:
> >FYI, i'm working on integrating kmemleak into -rt. Firstly, i needed the
> >fixes below when applying it ontop of 2.6.19-rt15.
> 
> Do you need these fixes to avoid a compiler error? If yes, this is 
> caused by a bug in gcc-4.x. The kmemleak container_of macro has 
> protection for non-constant offsets passed to container_of but the 
> faulty gcc always returns true for builtin_contant_p, even when this 
> is not the case. Previous versions (3.4) or one of the latest 4.x gcc 
> don't have this bug.
> 
> I wouldn't extend kmemleak to work around a gcc bug which was already 
> fixed.

correct, i needed it for gcc 4.0.2. If you want this feature upstream, 
this has to be solved - no way are we going to phase out portions of 
gcc4. It's not hard as you can see it from my patch, non-static 
container_of is very rare. We do alot of other hackery to keep older 
compilers alive, and we only drop compiler support if some important 
feature really, really needs new gcc and a sane workaround is not 
possible.

> >Secondly, i'm wondering about the following recursion:
> >
> > [<c045a7e1>] rt_spin_lock_slowlock+0x98/0x1dc
> > [<c045b16b>] rt_spin_lock+0x13/0x4b
> > [<c018f155>] kfree+0x3a/0xce
> > [<c0192e79>] hash_delete+0x58/0x5f
> > [<c019309b>] memleak_free+0xe9/0x1e6
> > [<c018ed2e>] __cache_free+0x27/0x414
> > [<c018f1d0>] kfree+0xb5/0xce
> > [<c02788dd>] acpi_ns_get_node+0xb1/0xbb
> > [<c02772fa>] acpi_ns_root_initialize+0x30f/0x31d
> > [<c0280194>] acpi_initialize_subsystem+0x58/0x87
> > [<c06a4641>] acpi_early_init+0x4f/0x12e
> > [<c06888bc>] start_kernel+0x41b/0x44b
> >
> >kfree() within kfree() ... this probably works on the upstream SLAB
> >allocator but makes it pretty nasty to sort out SLAB locking in -rt.
> 
> I test kmemleak with lockdep enabled but I eliminated all the 
> dependencies on the vanilla kernel. When kfree(hnode) is called (in 
> hash_delete), no kmemleak locks are held and hence no dependency on 
> the kmemleak locks (since kmemleak is protected against re-entrance). 
> My understanding is that slab __cache_free is re-entrant anyway 
> (noticed this when using radix-tree instead of hash in kmemleak and 
> got some lockdep reports on l3->list_lock and memleak_lock) and 
> calling it again from kmemleak doesn't seem to have any problem on the 
> vanilla kernel.
> 
> In the -rt kernel, is there any protection against a re-entrant 
> __cache_free (via cache_flusharray -> free_block -> slab_destroy) or 
> this is not needed?

the problem on -rt is the per-CPU slab buffer handling. In vanilla they 
are handled with irqs off/on - but inside is an unbound algorithm so for 
-rt i converted the local_irq_disable() logic to per-CPU locks. So this 
is an -rt only problem.

hm, even on vanilla you might run into problems in slab_destroy(), there 
we hold the l3 lock.

> >Wouldnt it be better to just preallocate the hash nodes, like lockdep
> >does, to avoid conceptual nesting? Basically debugging infrastructure
> >should rely on other infrastructure as little as possible.
> 
> It would indeed be better to avoid using the slab infrastructure (and 
> not worry about kmemleak re-entrance and lock dependecies). I'll have 
> a look on how this is done in lockdep since the preallocation size 
> isn't known. [...]

lockdep just uses a large compile-time array to allocate from and never 
grows that array.

> There are also the memleak_object structures that need to be 
> allocated/freed. To avoid any locking dependencies, I ended up 
> delaying the memleak_object structures freeing in an RCU manner. It 
> might work if I do the same with the hash nodes.

yeah, delayed RCU freeing might work better.

> >also, the number of knobs in the Kconfig is quite large:
> 
> I had some reasons and couldn't find a unified solution, [...]

i'm just saying that for upstream you have to make up your mind about 
them and have to provide a simplified configuration API. Sometimes it's 
hard, but it has to be done. Experience is that both users and 
distributors /will/ misconfigure it.

> [...] but probably only for one or two if them:
> 
> > CONFIG_DEBUG_MEMLEAK=y
> > CONFIG_DEBUG_MEMLEAK_HASH_BITS=16
> 
> For my limited configurations (an x86 laptop and several ARM embedded 
> platforms), 16 bits were enough. I'm not sure this is enough on a 
> server machine for example.

we try to never expose something like this via the config 
infrastructure. One solution here would be to use CONFIG_BASE_SMALL, 
that's the standard way of expressing that the kernel is for a small 
machine.

> > CONFIG_DEBUG_MEMLEAK_TRACE_LENGTH=4
> 
> I thought this is a user preference. I could hard-code it to 16. 
> What's the trace length used by lockdep?

lockdep saves all of them because stack traces are very useful in their 
entirety. But lockdep really allocates everything internally and puts 
out a warning and turns itself off if that pool is depleted. Also, the 
amount of memory needed for lockdep is bound by the number of unique 
lock acquire sites in the kernel, while kmemleak might need /alot/ of 
memory if there's lots of small allocations around - so the comparison 
to lockdep in this area is not valid.

	Ingo
