Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWINP2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWINP2I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 11:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWINP2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 11:28:07 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:52574 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750784AbWINP2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 11:28:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=r/0fWwnJy5KIKLWGr0YM6s6vu3Xtp4J3qZn05vYCntg3lbT4HuZ2ABJ983Wd3BbSd+N40zMIkhpJqzyA7IB8yw2yM7ouI4OQwotTBjizQvkVkS4kl5F5hKCsc0POw3tSDoopQIaI7RNF5vkgoxmu9qnLfZ2PSIFDAolGzD7+SWs=  ;
Message-ID: <450974F2.1020104@yahoo.com.au>
Date: Fri, 15 Sep 2006 01:27:46 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Arjan van de Ven <arjan@infradead.org>,
       Dong Feng <middle.fengdong@gmail.com>, ak@suse.de,
       Paul Mackerras <paulus@samba.org>, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: Why Semaphore Hardware-Dependent?
References: <45085B31.3080504@yahoo.com.au>  <45084833.4040602@yahoo.com.au> <44F395DE.10804@yahoo.com.au> <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com> <1156750249.3034.155.camel@laptopd505.fenrus.org> <11861.1156845927@warthog.cambridge.redhat.com> <22461.1158173455@warthog.cambridge.redhat.com> <21102.1158234082@warthog.cambridge.redhat.com>
In-Reply-To: <21102.1158234082@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>>From what I can read of the asm and the documentation, it is atomic. If
>>it were not atomic then it is badly broken.
> 
> It is not strictly atomic because there is no way to do it strictly atomically
> with the instruction set available on the FRV CPUs.  What I have is okay for

It is atomic. It is an indivisible operation with respect to other atomic_
instructions. I fail to see what the problem is here.

> UP, though not the most efficient, but will not work on SMP.

Maybe, but that will be a problem for your atomic operations, not code that
uses them. Your "spinlocks" don't currently work on SMP either ;)

> On SMP, atomic_cmpxchg() will have to be implemented with spinlocks unless
> Fujitsu add something more powerful than SWAP to the available instructions.
> 
> In which case, the spinlock-based rwsems are instantly better because you only
> need to take the spinlocks once, not several times, in the slow-path case.

The moment you're doing atomics with spinlocks, of course one would love to
rewrite many data structures to use spinlocks rather than atomics for best
performance. Luckily we don't see an asm-sparc/struct-page.h. You have to
draw the line somewhere.

> And on UP, the spinlocks devolve to anti-preemption controls and interrupt
> disablement[*], all of which is very quick and can be packed.
> 
> [*] Using JIT disablement; *actually* disabling the interrupts is very slow.

So you can use your virtual interrupt disabling for atomic_cmpxchg too. And
if you implement atomics with spinlocks in future then UP devolves exactly
the same way.

>>BTW. if atomic_cmpxchg is slower than a local_irq_disable+local_irq_enable
>>on your architecture then you have probably not implemented cmpxchg well
>>because you may as well just implement it with local_irq_disable.
> 
> 
> Using local_irq_disable() is not sufficient to implement cmpxchg() on anything
> but a UP system, but on a UP system, you don't actually need to do cmpxchg() at
> all.
> 
> If I have JIT disablement, and I don't have preemption enabled, then the
> spinlock wrapping on the fastpath is this:
> 
> 	andcc	gr0,gr0,gr0,icc2	// 1 cycle
> 	...
> 	oricc	gr0,#1,gr0,icc2		// 1 cycle
> 	tihi	icc2,gr0,#2		// 1 cycle if no pending interrupt
> 
> which, as long as there weren't any interrupts, is about as fast as I can get
> it.

And you could use exactly that to implement atomics too. Hence my point about
your atomic_cmpxchg not being optimal if it is worse than this.

> It occurs to me that I could possibly improve the performance of the
> spinlock-based rwsems by making use of bit 30 of the count to indicate stuff
> waiting on the queue.
> 
> 
>>I'm not so interested in counting cycles so much as consolidating duplicated
>>code
> 
> 
> There's a reason that the common parts of the code are in lib/.

Duplicated in that we have two complete implementations to do the same job.
Increasing test and review coverage is a big plus. Before x86-64, there
were really no SMP architectures that mattered using the spinlock version.
There have been subtle memory ordering bugs in there in the past, for
example.

>>and reduce complexity
> 
> 
> Not so.  The spinlock-based rwsems are less complex.

I'm talking about overall complexity. At the moment you have 2 different designs,
one of which is implemented in tricky ways in assembly by 8 architectures. Going
to a single design, all implemented in common code (no asm) is a huge reduction
in complexity.

>>and icache footprint.
> 
> 
> And smaller.

It is actually larger here.

    text    data     bss     dec     hex filename
     970       0       0     970     3ca lib/rwsem-spinlock.o
     576       0       0     576     240 kernel/spinlock.o
   =1546

    text    data     bss     dec     hex filename
    1310       0       0    1310     51e lib/rwsem.o
     193       0       0     193      c1 kernel/rwsem.o
   =1503

> And the optimised rwsems don't necessarily have a larger footprint.  After all,
> given what Ingo has done and moved them completely out-of-line, means that the
> compiler actually has to encode a call to them.  Which means that some of the
> values it currently has in registers are going to get clobbered, and it has to
> arrange for whatever to be in the right registers.  Now I grant you that this
> is very much arch dependent, and mostly applies to i386 where only three
> registers get clobbered by a call (which we can reduce to one).

My patch does nothing to move them back inline. It might be worthwhile, but
I see spinlocks and mutexes are out of line too now... I don't see the
memory trend reversing any time soon ;)

>>atomic_cmpxchg exists on all architectures.
> 
> 
> But that doesn't mean you should blindly use it without consideration of the
> consequences, or use it when there's a better way available.

Of course. Luckily, I haven't.

>>I'm happy to go with the spinlock version (it is even simpler), but I will
>>have to benchmark that. I have seen small slowdowns there in high contention
>>situations but it was improved with my rwsem scalability patch. If
>>performance is no different between the two, then the spinlock version is a
>>no brainer.
> 
> 
> Using the spinlock-based rwsems in preference to XADD, for instance, is
> potentially a source of greater contention, because (hopefully) XADD, in the
> ideal case, will touch the cacheline containing the rwsem once, and that'll be
> it, whereas with the spinlock version you have to touch the cacheline at least
> four times (spinlock grab, examine data, modify data, spinlock drop), and that
> means the cacheline can go elsewhere in between.

Yes, that's why I first chose the atomic_add_return variant for the generic
implementation.

> Using an emulated cmpxchg in preference to the spinlock-based rwsems, on the
> other hand, may be as bad in the fast path because you may have to get an
> implicit spinlock in the cmpxchg implementation, and in the slowpath it's worse
> because not only do you have to get the rwsem-spinlock overall, but you also
> have to get the cmpxchg-lock at regular intervals.  So you've got two
> cachelines potentially bouncing around.

Yep, using spinlocks for atomics sucks in general. Making a tiny speedup
to rwsems isn't going to help sparc or parisc too much.

> Note that the same arguments apply to the use of just CMPXCHG (eg: sparc) or to
> ST/LL or equivalent constructs (eg: mips, alpha, powerpc, arm6) because there's
> a gap between the store and the load, and that gives an opportunity for the
> cacheline to get stolen, and if that happens, there's a chance that the
> instruction will have to be repeated.
> 
> As far as I can tell, XADD or direct equivalent is the only one where this
> isn't true, but even that may be implemented by ST/LL-equivalents internally in
> the CPU.

Why would xadd be different from ll/sc based xadd? Or cmpxchg for that matter?

The CPU controlls the cache at this point anyway, so I'm sure if it gave any
benefit it could elect to hold onto the cacheline for a few more cycles or
until the operation completes. Leave that to the hardware designers.

> As I said before, if all you've got is CMPXCHG, you can actually do better than
> either algorithm we currently have.
> 
> 
>>my rwsem scalability patch
> 
> 
> Ummm...  I don't remember what that changed; can you send it to me again?

I'll port it and do some testing and get back to you.

> What is it you're trying to achieve anyway?  Are you trying to do
> generalisation for generalisation's sake?  If so, consider that that might not
> be the best thing, and that you might end up with something that rocks for one
> or two archs and sucks for the rest.

What we're talking about is likely to be an unmeasurable performance
difference for real workloads. And even then only on SMP archs that
implement atomic ops with spinlocks. (In fact, it is probably faster on real
workloads where the icache matters).

Don't get me wrong, I most definitely will be interested in benchmarks, even
microbenchmarks, and even on obscure architectures. If it does suck on 22
architectures of course I won't ask to merge it. My feeling is that it won't
suck. We'll see what the numbers say.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
