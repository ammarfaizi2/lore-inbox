Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWFGFEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWFGFEZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 01:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbWFGFEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 01:04:25 -0400
Received: from gate.crashing.org ([63.228.1.57]:23684 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750860AbWFGFEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 01:04:24 -0400
Subject: Re: mutex vs. local irqs (Was: 2.6.18 -mm merge plans)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <20060606212930.364b43fa.akpm@osdl.org>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <1149652378.27572.109.camel@localhost.localdomain>
	 <20060606212930.364b43fa.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 07 Jun 2006 15:04:07 +1000
Message-Id: <1149656647.27572.128.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> A couple of cycles repeated a zillion times per second for the entire
> uptime, just because we cannot get our act together in the first few
> seconds of booting.  How much does that suc

I don't follow you... what would you call "getting our act together"
then ? Being able to initialize half of the kernel data structures
without ever going near a mutex ?

The current stuff is just crap.

> And how much does it suck that we require that an attempt to take a
> sleeping lock must keep local interrupts disabled if the lock wasn't
> contended?

That is a more interesting point :)

> Fortunately, it only happens (or at least, is only _known_ to happen) when
> mutex debugging is enabled, so the performance loss is moot.
> 
> I do not know where the offending mutex_lock()s are occuring (although it
> would be super-simple to find out).

And even if we fix those, we'll ultimately get more. 

> By far the best solution to this would be to remove this requirement that
> local interrupts remain disabled for impractical amounts of time during boot.

That is not possible in any remotely sane way accross the board.

> Either whack the PIC in setup_arch() or reorganise start_kernel() in some
> appropriate manner.

Neither would be satisfactory. Whacking the PIC means accessing
hardware, which for a lot of architectures means having page tables up,
some kind of ioremap, etc... Hence the bunch of workarounds done by
various archs like having their PTE allocation function do horrors like
if (mem_init_done) kmalloc() else alloc_bootmem().

It's just too ugly for words.

As you said, we need to get our act together. That means having basic
kernel services that do _not_ rely on any hardware (interrupts, timer,
whatever...) be initialized first before we start needing ioremap's and
friends. That means having things like init_IRQ() which has to handle
allocating and initializing PICs all over the range and all sorts of
data structures that are related to interrupt handling, be able to use
said kernel services instead of having dodgy things like do half init
now, and another half later from a hook somewhere or an initcall while
hopeing that nobody will get in the middle.

It would make so much more sense to have the init code do something
like:

 setup_arch();
 init_basic_kernel_services(); <--- that's the blob you spotted with mem
init, slab init, ...
 init_arch(); <--- new arch hook

and later on, as part of the various inits, you get init_IRQ() and so
on...

In my example, init_arch() would be where the arch code moves the bits
currently in setup_arch() that do things like ioremap system devices and
do things that may want to use the slab etc... thus leaving setup_arch()
to very basic initialisations.

Not being able to do all of those because we have this
hyper-optimized-mutex-blah thing that hard enables interrupt all over
the place seems like a stupid thing to me. In fact, as you mentioned, it
only affects a debug code path which thus could perfectly take the
performance hit.

> But I'll be merging
> work-around-ppc64-bootup-bug-by-making-mutex-debugging-save-restore-irqs.patch
> so we'll just continue to suck I guess.

How so ? Can you tell me how making the mutex debug code path do
something sane makes it 'suck' ? Don't argue about the couple of cycles
benefit, as you mentionned yourself, it's a debug code path.

Ben.


