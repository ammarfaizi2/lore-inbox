Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293109AbSBWHaC>; Sat, 23 Feb 2002 02:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293110AbSBWH3x>; Sat, 23 Feb 2002 02:29:53 -0500
Received: from zero.tech9.net ([209.61.188.187]:18441 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S293109AbSBWH3l>;
	Sat, 23 Feb 2002 02:29:41 -0500
Subject: Re: [PATCH] only irq-safe atomic ops
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C773C02.93C7753E@zip.com.au>
In-Reply-To: <1014444810.1003.53.camel@phantasy> 
	<3C773C02.93C7753E@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 23 Feb 2002 02:29:48 -0500
Message-Id: <1014449389.1003.149.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-02-23 at 01:51, Andrew Morton wrote:

> Thanks, Robert.

You are welcome.

> Some background here - for the delayed allocation code which I'm
> cooking up I need to globally count the number of dirty pages in the
> machine.  Currently that's done with atomic_inc(&nr_dirty_pages)
> in SetPageDirty().
> 
> But this counter (which is used for when-to-start-writeback decisions)
> is unavoidably approximate.   It would be nice to make it a per-CPU
> array.  So on the rare occasions when the dirty-page count is needed,
> I can just whizz across the per-cpu counters adding them all up.

Question: if (from below) you are going to use atomic operations, why
make it per-CPU at all?  Just have one counter and atomic_inc and
atomic_read it.  You won't need a spin lock.

> But how to increment or decrement a per-cpu counter?  The options
> are:
> 
> - per_cpu_integer++;
> 
>   This is *probably* OK on all architectures.  But there are no
>   guarantees that the compiler won't play games, and that this
>   operation is preempt-safe.

This would be atomic and thus preempt-safe on any sane arch I know, as
long as we are dealing with a normal type int.  Admittedly, however, we
can't be sure what the compiler would do.

Thinking about it, you are probably going to be doing this:

	++counter[smp_processor_id()];

and that is not preempt-safe since the whole operation certainly is not
atomic.  The current CPU could change between calculating it and
referencing the array.  But, that wouldn't matter as long as you only
cared about the sum of the counters.

> - preempt_disable(); per_cpu_counter++; preempt_enable();
> 
>   A bit heavyweight for add-one-to-i.

Agreed, although I bet its not noticeable.

> - atomic_inc
> 
>   A buslocked operation where it is not needed - we only need
>   a preempt-locked operation here.  But it's per-cpu data, and
>   the buslocked rmw won't be too costly.
> 
> I can't believe how piddling this issue is :)
> 
> But if there's a general need for such a micro-optimisation
> then we need to:
> 
> 1: Create <linux/atomic.h> (for heavens sake!)
> 
> 2: In <linux/atomic.h>,
> 
>    #ifndef ARCH_HAS_ATOMIC_INQ_THINGIES
>    #define atomic_inc_irq atomic_inc
>    ...
>    #endif

I can think up a few more uses of the irq/memory-safe atomic ops, so I
bet this isn't that bad of an idea.  But no point doing it without a
corresponding use.

> But for now, I suggest we not bother.  I'll just use atomic_inc().

	Robert Love

