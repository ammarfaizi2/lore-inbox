Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbWGHS2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbWGHS2j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 14:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbWGHS2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 14:28:39 -0400
Received: from www.osadl.org ([213.239.205.134]:14250 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S964944AbWGHS2i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 14:28:38 -0400
Subject: Re: [patch] spinlocks: remove 'volatile'
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Albert Cahalan <acahalan@gmail.com>
Cc: joe.korty@ccur.com, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, linux-os@analogic.com,
       khc@pm.waw.pl, mingo@elte.hu, akpm@osdl.org, arjan@infradead.org
In-Reply-To: <787b0d920607080849p322a6349g7a5fd98f78aa9f32@mail.gmail.com>
References: <787b0d920607072054i237eebf5g8109a100623a1070@mail.gmail.com>
	 <20060708094556.GA13254@tsunami.ccur.com>
	 <1152354244.24611.312.camel@localhost.localdomain>
	 <787b0d920607080849p322a6349g7a5fd98f78aa9f32@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 20:31:26 +0200
Message-Id: <1152383487.24611.337.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 11:49 -0400, Albert Cahalan wrote:
> On 7/8/06, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Sat, 2006-07-08 at 05:45 -0400, Joe Korty wrote:
> > > On Fri, Jul 07, 2006 at 11:54:10PM -0400, Albert Cahalan wrote:
> > > > That's all theoretical though. Today, gcc's volatile does
> > > > not follow the C standard on modern hardware. Bummer.
> > > > It'd be low-performance anyway though.
> > >
> > > But gcc would follow the standard if it emitted a 'lock'
> > > insn on every volatile reference.  It should at least
> > > have an option to do that.
> 
> That would do for x86 without MMIO.

Great. And it still is not following the standard. The standard tells
nothing about PCI, MMIO or whatever. volatile is _NOT_ about
serialization.

> > volatile works fine on trivial microcontrollers and for the basic C
> > course lesson, but there is no way for the compiler to decide which of
> > the 'lock' mechanisms should be used in complex situations.
> >
> > In low level system programming there is no fscking way for the compiler
> > to figure out if this is in context of a peripheral bus, cross CPU
> > memory or whatever. All those things have hardware dependend semantics
> > and the only way to get them straight is to enforce the correct handling
> > with handcrafted assembler code.
> 
> This can work. The compiler CALLS the assembly code.
> Nothing new here: see all the libgcc functions if you aren't
> used to the idea of the compiler calling functions behind
> your back.
> 
> So we have assembly functions somewhat like this:
> 
> __volatile_read(void*dst, void*src, size_t size);
> __volatile_write(void*dst, void*src, size_t size);
> 
> They probably have to look up the memory address to
> determine if it belongs to a PCI device or not, etc.
> For userspace code, they could even be system calls.
> 
> Without that, gcc just isn't correct on normal hardware.

1. The volatile implementation of gcc is correct. The standard does not
talk about busses, not even about SMP.

2. Who is going to define what normal hardware is and what not ?
A committee perhaps, that would at least guarantee that this feature is
never implemented.

> I'm not suggesting this is fast, of course. Probably the
> right answer is something like this:
> 
> -fvolatile=smp   # Add locks
> -fvolatile=call   # Call custom functions

What a great idea! I can imagine the necessary framework, where you need
to register the address spaces and related access functions and make
every access to such variables burn thousands of CPU cycles.

Again: The only thing volatile guarantees is that is does not optimize
seemingly static variables. It reads back from memory. Nothing else.
It's a punctual disabling of optimizations. And this is not something
restricted to gcc. There are _NO_ compilers which solve something else
than this.

There is no reasonable automated solution for this problem, otherwise
the compiler geeks would have implemented the
--coded_with_brain_disabled option already.

	tglx


