Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310695AbSCHGYF>; Fri, 8 Mar 2002 01:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310696AbSCHGXz>; Fri, 8 Mar 2002 01:23:55 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:37384 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S310695AbSCHGXu>; Fri, 8 Mar 2002 01:23:50 -0500
Date: Fri, 8 Mar 2002 17:27:06 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: furwocks: Fast Userspace Read/Write Locks
Message-Id: <20020308172706.1e4d3f5e.rusty@rustcorp.com.au>
In-Reply-To: <a68htg$bc1$1@cesium.transmeta.com>
In-Reply-To: <E16iwkE-000216-00@wagner.rustcorp.com.au>
	<20020307153228.3A6773FE06@smtp.linux.ibm.com>
	<20020307104241.D24040@devserv.devel.redhat.com>
	<20020307191043.9C5F33FE15@smtp.linux.ibm.com>
	<a68htg$bc1$1@cesium.transmeta.com>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Mar 2002 12:17:52 -0800
"H. Peter Anvin" <hpa@zytor.com> wrote:

> Followup to:  <20020307191043.9C5F33FE15@smtp.linux.ibm.com>
> By author:    Hubertus Franke <frankeh@watson.ibm.com>
> In newsgroup: linux.dev.kernel
> > 
> > Take a look at Rusty's futex-1.2, the code is not that different, however
> > if its all inlined it creates additional code on the critical path 
> > and why do it if not necessary.
> > 
> > In this case the futexes are the well tested path, the rest is a cludge on
> > top of it.
> > 
> 
> Perhaps someone could give a high-level description of how these
> "futexes" work?

Certainly!  This is how Futexes IV (and Futexes V, ignoring the fairness
stuff that adds) works:

One or more userspace processes share address space, so they can both do
simple atomic operations on the same memory (hence the new PROT_SEM flag to
mmap/mprotect for architectures which need to know).  They agree that "this
address contains an integer which we use as a mutex" (aka. struct futex).

The futex starts at 1 (available).  down() looks like:
	if (atomic_dec_and_test(futex)) return 0; /* We got it! */
	else sys_futex(futex, DOWN); /* Go to kernel, wait. */

up() looks like:
	if (atomic_inc_positive(futex)) return 0; /* Noone waiting */
	else sys_futex(futex, UP); /* go to kernel, wake people */

Inside the kernel, we do what you'd expect.  For sys_futex(futex, DOWN):
	Pin the page containing the futex, for convenience.
	Hash the kernel address of the futex to get a waitqueue.
	Add ourselves to the waitqueue.
	While !atomic_dec_and_test() (ie. futex still unavailable):
		sleep
		if signal pending, break;
	Unhash from waitqueue
	unpin page.
	return success or -EINTR.

For sys_futex(futex, UP):
	Pin page for convenience.
	Hash kernel address of futex to get the waitqueue.
	set futex to 1 (ie. available).
	Wake up the first one on the waitqueue waiting for this futex.
	unpin page

The only two twists to add are that we don't keep atomic_dec_and_test'ing
in the loop forever (if it's already negative we don't bother), so counter
doesn't wrap, and we don't use actual waitqueues because we share them, but
we want to know which futex each waiter is waiting on.

Pretty simple, no?
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
