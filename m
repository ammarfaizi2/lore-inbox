Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293111AbSBWH4b>; Sat, 23 Feb 2002 02:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293112AbSBWH4M>; Sat, 23 Feb 2002 02:56:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11282 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293111AbSBWH4I>;
	Sat, 23 Feb 2002 02:56:08 -0500
Message-ID: <3C774AC8.5E0848A2@zip.com.au>
Date: Fri, 22 Feb 2002 23:54:48 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] only irq-safe atomic ops
In-Reply-To: <3C773C02.93C7753E@zip.com.au>,
		<1014444810.1003.53.camel@phantasy> 
		<3C773C02.93C7753E@zip.com.au> <1014449389.1003.149.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> ...
> 
> Question: if (from below) you are going to use atomic operations, why
> make it per-CPU at all?  Just have one counter and atomic_inc and
> atomic_read it.  You won't need a spin lock.

Oh that works fine.   But then it's a global counter, so each time
a CPU marks a page dirty, the counter needs to be pulled out of
another CPU's cache.   Which is not a thing I *need* to do.

As I said, it's a micro-issue.  But it's a requirement which 
may pop up elsewhere.
 
> This would be atomic and thus preempt-safe on any sane arch I know, as
> long as we are dealing with a normal type int.  Admittedly, however, we
> can't be sure what the compiler would do.
> 
> Thinking about it, you are probably going to be doing this:
> 
>         ++counter[smp_processor_id()];
> 
> and that is not preempt-safe since the whole operation certainly is not
> atomic.  The current CPU could change between calculating it and
> referencing the array.

yup.  It'd probably work - the compiler should calculate the address and
do a non-buslocked but IRQ-atomic increment on it.  But no way can we
rely on that happening.

>  But, that wouldn't matter as long as you only
> cared about the sum of the counters.

If the compiler produced code equivalent to

	counter[smp_processor_id()] = counter[smp_processor_id()] + 1;

then the counter would get trashed - a context switch could cause CPUB
to write CPUA's counter (+1) onto CPUB's counter.  It's quite possibly
illegal for the compiler to evaluate the array subscript twice in this
manner.  Dunno.

If the compiler produced code equivalent to:

	const int cpu = smp_processor_id();
	counter[cpu] = counter[cpu] + 1;

(which is much more likely) then a context switch would result
in CPUB writing CPUA's updated counter onto CPUA's counter.  Which
will work a lot more often, until CPUA happens to be updating its
counter at the same time.

> ...
> > 2: In <linux/atomic.h>,
> >
> >    #ifndef ARCH_HAS_ATOMIC_INQ_THINGIES
> >    #define atomic_inc_irq atomic_inc
> >    ...
> >    #endif
> 
> I can think up a few more uses of the irq/memory-safe atomic ops, so I
> bet this isn't that bad of an idea.  But no point doing it without a
> corresponding use.

Sure.

-
