Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbWGHTdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbWGHTdo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 15:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbWGHTdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 15:33:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:19299 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030235AbWGHTdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 15:33:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KBxpWDs4WjyW7QraAb6d7bqTw7cbx76MPmux+xwnUyphiJN/iJljecak5orBylykQ/IF+7dYutm0HuWOaDBj8pBSLUYhfCwIPpIRp7/79o3SjYF2kjO6u93CK1QDfCrVoYIA6viUCYGqru8mlsBwD09P8rwgSNtdKYngyGH0Yts=
Message-ID: <787b0d920607081233w3e0e99a9n706ff510c3de458b@mail.gmail.com>
Date: Sat, 8 Jul 2006 15:33:42 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: tglx@linutronix.de
Subject: Re: [patch] spinlocks: remove 'volatile'
Cc: joe.korty@ccur.com, linux-kernel@vger.kernel.org,
       "Linus Torvalds" <torvalds@osdl.org>, linux-os@analogic.com,
       khc@pm.waw.pl, mingo@elte.hu, akpm@osdl.org, arjan@infradead.org
In-Reply-To: <1152383487.24611.337.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920607072054i237eebf5g8109a100623a1070@mail.gmail.com>
	 <20060708094556.GA13254@tsunami.ccur.com>
	 <1152354244.24611.312.camel@localhost.localdomain>
	 <787b0d920607080849p322a6349g7a5fd98f78aa9f32@mail.gmail.com>
	 <1152383487.24611.337.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/06, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Sat, 2006-07-08 at 11:49 -0400, Albert Cahalan wrote:
> > On 7/8/06, Thomas Gleixner <tglx@linutronix.de> wrote:

> > > In low level system programming there is no fscking way for the compiler
> > > to figure out if this is in context of a peripheral bus, cross CPU
> > > memory or whatever. All those things have hardware dependend semantics
> > > and the only way to get them straight is to enforce the correct handling
> > > with handcrafted assembler code.
> >
> > This can work. The compiler CALLS the assembly code.
> > Nothing new here: see all the libgcc functions if you aren't
> > used to the idea of the compiler calling functions behind
> > your back.
> >
> > So we have assembly functions somewhat like this:
> >
> > __volatile_read(void*dst, void*src, size_t size);
> > __volatile_write(void*dst, void*src, size_t size);
> >
> > They probably have to look up the memory address to
> > determine if it belongs to a PCI device or not, etc.
> > For userspace code, they could even be system calls.
> >
> > Without that, gcc just isn't correct on normal hardware.
>
> 1. The volatile implementation of gcc is correct. The standard does not
> talk about busses, not even about SMP.

The standard need not. An implementation must deal
with whatever odd hardware happens to be in use.

> 2. Who is going to define what normal hardware is and what not ?
> A committee perhaps, that would at least guarantee that this feature is
> never implemented.

Oh please. Normal: the stuff we have problems with.
I could as well have said "gcc just isn't correct on any
PC currently sold by eMachines, HP, or Dell".

> > I'm not suggesting this is fast, of course. Probably the
> > right answer is something like this:
> >
> > -fvolatile=smp   # Add locks
> > -fvolatile=call   # Call custom functions
>
> What a great idea! I can imagine the necessary framework, where you need
> to register the address spaces and related access functions and make
> every access to such variables burn thousands of CPU cycles.

Damn right. This is the C standard requirement.
Not all code has Linux-like performance requirements,
and in any case, standards are standards.

Don't like the standard? Don't claim to support it.
Maybe you could even propose some improvements
and get them voted into the standard for next time.

> Again: The only thing volatile guarantees is that is does not optimize
> seemingly static variables. It reads back from memory.

"memory", yes, not just the CPU's queue of writes
and/or pending reads. Not just the nearest bus.

If memory is out over the PCI bus, then it sure isn't
a simple matter to make the access occur. Tough luck.

> Nothing else.
> It's a punctual disabling of optimizations. And this is not something
> restricted to gcc. There are _NO_ compilers which solve something else
> than this.

Perhaps the wording of the standard should be changed.
Until then, the compilers are clearly not following the
requirements of the standard. (unless perhaps they
document a "do not map PCI or similar" restriction)

> There is no reasonable automated solution for this problem, otherwise
> the compiler geeks would have implemented the
> --coded_with_brain_disabled option already.

For certain values of "reasonable", yes.
