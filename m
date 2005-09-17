Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbVIQBAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbVIQBAJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 21:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVIQBAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 21:00:09 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:27018 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750797AbVIQBAH (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 21:00:07 -0400
Date: Sat, 17 Sep 2005 02:59:50 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH 2/5] atomic: introduce atomic_inc_not_zero
In-Reply-To: <20050914232106.H30746@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0509170234180.3743@scrub.home>
References: <43283825.7070309@yahoo.com.au> <4328387E.6050701@yahoo.com.au>
 <Pine.LNX.4.61.0509141814220.3743@scrub.home> <43285374.3020806@yahoo.com.au>
 <Pine.LNX.4.61.0509141906040.3728@scrub.home> <20050914230049.F30746@flint.arm.linux.org.uk>
 <Pine.LNX.4.61.0509150010100.3728@scrub.home> <20050914232106.H30746@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 14 Sep 2005, Russell King wrote:

> > 
> > > > 	do {
> > > > 		old = atomic_load_locked(v);
> > > > 		if (!old)
> > > > 			break;
> > > > 		new = old + 1;
> > > > 	} while (!atomic_store_lock(v, old, new));
> > > 
> 
> What you're asking architectures to do is:
> 
> retry:
> 	load
> 	operation
> 	save interrupts
> 	load
> 	compare
> 	store if equal
> 	restore interrupts
> 	goto retry if not equal
> 
> whereas they could have done the far simpler version of:
> 
> 	save interrupts
> 	load
> 	operation
> 	store
> 	restore interrupts
> 
> which they do today.

So modify it this way:

	atomic_lock(flags);
	do {
		old = atomic_load_locked(v);
		if (!old)
			break;
		new = old + 1;
	} while (!atomic_store_locked(v, old, new));
	atomic_unlock(flags);

> The whole point about architecture specific includes is not to provide
> a frenzied feeding ground for folk who like to "clean code up" but to
> allow architectures to do things in the most efficient way for them
> without polluting the kernel too much.

In this case it's massively repeated code which only differs slighty. My 
biggest problem here is the lack of gcc support to get the condition code 
out of an asm. Especially architectures with locked load/store instruction 
could then have just a single implementation in asm-generic.

A long time ago I was playing with something like this:

#define atomic_exchange(ptr, old, new) ({		\
	old = *(ptr);					\
	asm volatile ("1:"				\
		: "=&a" (old), "=m" (*(ptr))		\
		: "0" (old), "m" (*(ptr))		\
		: "memory");				\
	asm volatile (__LOCK "cmpxchg %2,%0; jne 1b"	\
		: "=m" (*(ptr)), "=&a" (old)		\
		: "r" (new), "m" (*(ptr)), "1" (old)	\
		: "memory");				\
})

so e.g. an atomic_add_return() would be atomic_exchange(ptr, old, old + 
val), but I guess gcc people would kill me for that. :-)

bye, Roman
