Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbWGHTNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbWGHTNc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 15:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbWGHTNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 15:13:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59873 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964961AbWGHTNb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 15:13:31 -0400
Date: Sat, 8 Jul 2006 12:13:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: joe.korty@ccur.com, linux-kernel@vger.kernel.org, linux-os@analogic.com,
       khc@pm.waw.pl, mingo@elte.hu, akpm@osdl.org, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
In-Reply-To: <p731wswp5cd.fsf@verdi.suse.de>
Message-ID: <Pine.LNX.4.64.0607081154480.3869@g5.osdl.org>
References: <787b0d920607072054i237eebf5g8109a100623a1070@mail.gmail.com>
 <20060708094556.GA13254@tsunami.ccur.com> <p731wswp5cd.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 8 Jul 2006, Andi Kleen wrote:
> 
> How do you define reference? While you could do locked mem++ you can't
> do locked mem *= 2 (or any other non trivial operation that doesn't
> direct map to an memory operand x86 instruction which allows lock
> prefixes)

Actually, this is one reason why I don't like "volatile".

The compiler has exactly the same problems saying "what can you do", so if 
you do

	extern int a;
	extern volatile int b;

	void testfn(void)
	{
		a++;
		b++;
	}

the compiler will generally generate _worse_ code for "b++" than for 
"a++".

There's really no _reason_ not to do

	addl $1,a
	addl $1,b

for the above on x86 (or any other architecture that does memory 
operations), but the compiler will almost certainly be totally paranoid 
about the fact that "b" was marked volatile, and it won't dare combine 
_any_ operations on it, even though they are obviously equivalent.

So try the above on gcc, and you'll see something like this:

	testfn:
	        movl    b, %eax
	        addl    $1, a
	        addl    $1, %eax
	        movl    %eax, b
	        ret

where the "volatile" on b means that the code generated was 
_fundamentally_ more expensive, for absolutely zero gain.

Btw, this also shows another weakness with "volatile", which is very 
fundamental, and very much a problem: look where the read-vs-write of "b" 
takes place.

It _reads_ the old value of "b" before it reads and updates "a", and 
_writes_ the new value of "b" after it has updated "a".

Why? It's perfectly correct code as far as the compiler is concerned: the 
"volatile" was only on the "b", and accesses to "a" were not constrained, 
so the compiler is perfectly correct in moving the access to "a" around, 
since that one doesn't have any "side effects" as far as the definition of 
the C language is concerned.

Now, people should realize what this means when it comes to things like 
locking: even in the _absense_ of the CPU re-ordering accesses, and even 
in a single-threaded program with signals, there is some real re-ordering 
by the compiler going on.

> IMHO the "barrier model" used by Linux and implemented by gcc is much
> more useful for multithreaded programming, and MMIO needs other
> mechanisms anyways.
> 
> I wish the C standard would adopt barriers.

The problem ends up being that you really can have a _lot_ of different 
kinds of barriers.

For example, if you really want to implement spinlocks in some kinf of 
"smart C" without needing inline assembly, different architectures will 
want different barriers. In many architectures the barriers are not 
stand-alone things, but are tied to the accesses themselves.

That's _not_ just the x86 kind of "locked instructions", btw, and it's not 
even just an "ugly special case". Some locking models are _defined_ as 
having the barriers not be separate from the operations, and in fact, 
those locking models tend to be the BEST ONES.

So you either need to do barriers on a high level (ie "spinlock", "mutex" 
etc) or you need to be able to describe things on a very low level indeed. 
The low level is very hard to come to grips with, but the high level has 
the problem that different classes of programs need totally different 
kinds of high-level barriers, so it's almost impossible to do them as 
somethng that the compiler can generate directly.

For example, the kernel kind of spinlocks are basically useless in user 
space, because signals (the equivalent of an "interrupt" in user space) 
are hard to block, so "spin_lock_irq()" is hard. Also, since there is some 
external entity that does scheduling, the "I'm holding a spinlock, don't 
schedule me away" kind of thing doesn't work. In the kernel, we just 
increment the preemption count. In user space, you need to do something 
different.

So the power of C is really that it makes the easy things easy, and the 
hard things are _possible_ using valid ways to break the model. Notably, 
you have type-casts to break the type model (and hey, many of the things 
you can do when you break the type model may not be portable any more), 
and you have inline assembly when you need to break the "abstract CPU 
model".

Yeah, inline assembly is a "cop-out" in the sense that it's just admitting 
that the language doesn't cover every possibility. But hey, _no_ language 
can cover every single possibility, so the fact that C _does_ have a 
cop-out is actually one of its biggest strengths. Many other languages 
don't have that capability at all, and are strictly weaker as a result.

			Linus
