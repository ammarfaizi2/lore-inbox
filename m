Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264054AbUEMR0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264054AbUEMR0Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 13:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264229AbUEMR0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 13:26:16 -0400
Received: from chaos.analogic.com ([204.178.40.224]:16256 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264054AbUEMR0I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 13:26:08 -0400
Date: Thu, 13 May 2004 13:26:46 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: scott douglass <scott.douglass@arm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: local_irq_save, memory clobbering and volatile
In-Reply-To: <1084465048.12767.106.camel@pc982.cambridge.arm.com>
Message-ID: <Pine.LNX.4.53.0405131313470.1787@chaos>
References: <1084465048.12767.106.camel@pc982.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2004, scott douglass wrote:

> Hello,
>
> I've searched through the mailing list archives and I've found these
> comments about volatile (albeit from a few years back):
>
> > "volatile" is _never_ a good idea, [...]
>
> and
>
> > [...] volatile is an evil keyword that is badly specified and only
> > makes the compiler generate worse code without ever fixing any real
> > bugs.
>
> But there's a lot of archive to search though and I may have missed
> something relevant.  I also looked though the Documentation directory
> without success.
>
> If I understand correctly, the arguments against volatile are/were that
> using volatile can slow down some critical regions like list traversal
> and can hide the absence of proper locking.  It seems to me that the
> "slow down some critical regions" can be handled by manually caching the
> value (in the critical region) rather than hoping the compiler would
> notice.
>

The volatile keyword is essential when interfacing with
memory-mapped hardware. The compiler doesn't 'know' that
the hardware is hardware. A control port for hardware
is just a variable in memory as far as the compiler
is concerned.

An optimizing compiler doesn't do things exactly as the
programmer has coded. The compiler is free to do anything
it wants to do as long as the logic and arithmetic is
correct after a sequence-point. So to prevent the compiler
from caching an already read hardware register value in
a register, there must be some way of telling the compiler
that it needs to read that 'variable' each time it operates
upon it.

One of the ways of doing this is to declare all hardware
registers 'extern'. Therefore, the compiler should know
that somebody else could have modified that variable. However,
compilers don't have the notion of preemption and interrupts
so, if the compiler knows that no function was called since
the last time that variable was accessed (where that public
variable could have been changed), the compiler may use the
value kept in a register. This makes broken code.

So, to prevent broken code, it is essential in at least
90% of the hardware interface code to declare those variables
volatile. So there may be 10% that don't really need to
be volatile.

Another foible of the 'C' compiler is that it is free to
access a variable as many times as it wants! Some machines
can only load and store long-words. If I need to modify
several bits in such a hardware register, the 'C' compiler
may do it in several steps. The result may be an intermediate
disallowed state, like programming a pin to be both an input
and an output, destroying the device,

So the next time your 'C' standards committee meets, you might
show your support for a new 'standard type' called "hardware".
That tells the 'C' compiler to do exactly what the programmer
wrote when dealing with that object.

In the meantime we use (and sometimes overuse) volatile. If
you have ever worked several weeks of long nights discovering
that the bug was that the 'C' compiler decided that you
really didn't need to touch that register, then you would
sprinkle 'volatile' freely throughout your interface code.
FYI, there are many hardware-interface macros in the kernel
headers that hide the 'volatile' key-word. It is still needed.


> Do I understand the arguments against volatile correctly?
>
> Is this still the official position?  If so, why is volatile used so
> much in the current kernel sources?
>
> I think the clobbering of memory by local_irq_save, et al. is not
> necessary in cases were volatile is used correctly.  The clobbering
> inhibits the compiler's ability to optimize more than volatile does.
> When memory gets clobbered the compiler can't optimize other memory
> accesses in the function even though they are not involved in the
> critical region.  As compilers do more inlining the amount of
> optimization damage done by clobbering memory grows.
>
> Existing code relies on the current clobbering instead of using volatile
> accesses, so I'm suggesting that there should be new, non-clobbering
> forms, e.g. local_irq_save_no_clobber, etc.  To use them correctly the
> accesses in the critical region must be to volatile objects, for
> example:
>
> __inline__ void atomic_clear_mask (unsigned long mask, volatile unsigned
> long *addr) {
> 	unsigned long flags;
>
> 	local_irq_save_no_clobber(flags);
> 	*addr &= ~mask;
> 	local_irq_restore_no_clobber(flags);
> }
>

Huh?  You just wrote to a variable on the stack, then
you read from it. So you clobbered memory.  This, BTW
has nothing to do with 'volatile'


The 'best' way to protect a critical region, excluding the
spin-lock part of if is:

	pushf
	cli

	do critical region code

	popf

However, when the flags were pushed onto the stack, memory was
touched. When popped off, it was touched again. The above code
won't work within a 'C' function because the compiler-calculated
variables will be offset by the size of the flags register. So,
a compromise is to save the flags in a variable that's on
the stack. You still modify memory.


> This lets the compiler know exactly which accesses are to volatile
> objects and means that functions that call atomic_clear_mask can still
> be optimized.  Some of the C definitions of atomic_clear_mask in the
> sources already have this volatile qualification.
>


You are confusing volatile with atomic. An atomic operation modifies
a memory variable, or returns its value in an un-interruptible
operation so that there are no possibilites of incomplete or incorrect
results because of two or more accesses.

FYI, all simple accesses to memory variables in ix86 are atomic.
Unfortunately the GCC compiler often converts simple accesses to
seperate load and store operations. This makes them non-atomic.
That's why we have atomic_t variables and macros, written in
assembly to access them.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


