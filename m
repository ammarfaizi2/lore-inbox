Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWINLlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWINLlu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 07:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWINLlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 07:41:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29645 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751224AbWINLlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 07:41:49 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <45085B31.3080504@yahoo.com.au> 
References: <45085B31.3080504@yahoo.com.au>  <45084833.4040602@yahoo.com.au> <44F395DE.10804@yahoo.com.au> <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com> <1156750249.3034.155.camel@laptopd505.fenrus.org> <11861.1156845927@warthog.cambridge.redhat.com> <22461.1158173455@warthog.cambridge.redhat.com> 
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: David Howells <dhowells@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Dong Feng <middle.fengdong@gmail.com>, ak@suse.de,
       Paul Mackerras <paulus@samba.org>, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: Why Semaphore Hardware-Dependent? 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 14 Sep 2006 12:41:22 +0100
Message-ID: <21102.1158234082@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> > NAK for FRV.  Do not use atomic_cmpxchg() there as it isn't strictly
> > atomic (FRV only has one strictly atomic operation: SWAP).  Please leave
> > FRV as using the spinlock version which is more efficient on UP.
> 
> From what I can read of the asm and the documentation, it is atomic. If
> it were not atomic then it is badly broken.

It is not strictly atomic because there is no way to do it strictly atomically
with the instruction set available on the FRV CPUs.  What I have is okay for
UP, though not the most efficient, but will not work on SMP.

On SMP, atomic_cmpxchg() will have to be implemented with spinlocks unless
Fujitsu add something more powerful than SWAP to the available instructions.

In which case, the spinlock-based rwsems are instantly better because you only
need to take the spinlocks once, not several times, in the slow-path case.

And on UP, the spinlocks devolve to anti-preemption controls and interrupt
disablement[*], all of which is very quick and can be packed.

[*] Using JIT disablement; *actually* disabling the interrupts is very slow.

> BTW. if atomic_cmpxchg is slower than a local_irq_disable+local_irq_enable
> on your architecture then you have probably not implemented cmpxchg well
> because you may as well just implement it with local_irq_disable.

Using local_irq_disable() is not sufficient to implement cmpxchg() on anything
but a UP system, but on a UP system, you don't actually need to do cmpxchg() at
all.

If I have JIT disablement, and I don't have preemption enabled, then the
spinlock wrapping on the fastpath is this:

	andcc	gr0,gr0,gr0,icc2	// 1 cycle
	...
	oricc	gr0,#1,gr0,icc2		// 1 cycle
	tihi	icc2,gr0,#2		// 1 cycle if no pending interrupt

which, as long as there weren't any interrupts, is about as fast as I can get
it.

It occurs to me that I could possibly improve the performance of the
spinlock-based rwsems by making use of bit 30 of the count to indicate stuff
waiting on the queue.

> I'm not so interested in counting cycles so much as consolidating duplicated
> code

There's a reason that the common parts of the code are in lib/.

> and reduce complexity

Not so.  The spinlock-based rwsems are less complex.

> and icache footprint.

And smaller.

And the optimised rwsems don't necessarily have a larger footprint.  After all,
given what Ingo has done and moved them completely out-of-line, means that the
compiler actually has to encode a call to them.  Which means that some of the
values it currently has in registers are going to get clobbered, and it has to
arrange for whatever to be in the right registers.  Now I grant you that this
is very much arch dependent, and mostly applies to i386 where only three
registers get clobbered by a call (which we can reduce to one).

> atomic_cmpxchg exists on all architectures.

But that doesn't mean you should blindly use it without consideration of the
consequences, or use it when there's a better way available.

> I'm happy to go with the spinlock version (it is even simpler), but I will
> have to benchmark that. I have seen small slowdowns there in high contention
> situations but it was improved with my rwsem scalability patch. If
> performance is no different between the two, then the spinlock version is a
> no brainer.

Using the spinlock-based rwsems in preference to XADD, for instance, is
potentially a source of greater contention, because (hopefully) XADD, in the
ideal case, will touch the cacheline containing the rwsem once, and that'll be
it, whereas with the spinlock version you have to touch the cacheline at least
four times (spinlock grab, examine data, modify data, spinlock drop), and that
means the cacheline can go elsewhere in between.

Using an emulated cmpxchg in preference to the spinlock-based rwsems, on the
other hand, may be as bad in the fast path because you may have to get an
implicit spinlock in the cmpxchg implementation, and in the slowpath it's worse
because not only do you have to get the rwsem-spinlock overall, but you also
have to get the cmpxchg-lock at regular intervals.  So you've got two
cachelines potentially bouncing around.

Note that the same arguments apply to the use of just CMPXCHG (eg: sparc) or to
ST/LL or equivalent constructs (eg: mips, alpha, powerpc, arm6) because there's
a gap between the store and the load, and that gives an opportunity for the
cacheline to get stolen, and if that happens, there's a chance that the
instruction will have to be repeated.

As far as I can tell, XADD or direct equivalent is the only one where this
isn't true, but even that may be implemented by ST/LL-equivalents internally in
the CPU.

As I said before, if all you've got is CMPXCHG, you can actually do better than
either algorithm we currently have.

> my rwsem scalability patch

Ummm...  I don't remember what that changed; can you send it to me again?


What is it you're trying to achieve anyway?  Are you trying to do
generalisation for generalisation's sake?  If so, consider that that might not
be the best thing, and that you might end up with something that rocks for one
or two archs and sucks for the rest.

Look at the genirq thing for an example of that... :-)

David
