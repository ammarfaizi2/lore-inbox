Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293087AbSBWGxc>; Sat, 23 Feb 2002 01:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293090AbSBWGxW>; Sat, 23 Feb 2002 01:53:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51985 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293087AbSBWGxF>;
	Sat, 23 Feb 2002 01:53:05 -0500
Message-ID: <3C773C02.93C7753E@zip.com.au>
Date: Fri, 22 Feb 2002 22:51:46 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] only irq-safe atomic ops
In-Reply-To: <1014444810.1003.53.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> The following patch implements i386 versions of atomic_inc and
> atomic_dec that are LOCK-less but provide IRQ-atomicity and act as a
> memory-barrier.
> 
> An applicable use would be data that needs to be IRQ-safe but not
> SMP-safe (or, more likely, is already SMP-safe for some other reason).
> 
> Additionally, these variants could prevent having to use
> preempt_disable/enable or "full" atomic ops around per-CPU data with a
> preemptible kernel.
> 

Thanks, Robert.

Some background here - for the delayed allocation code which I'm
cooking up I need to globally count the number of dirty pages in the
machine.  Currently that's done with atomic_inc(&nr_dirty_pages)
in SetPageDirty().

But this counter (which is used for when-to-start-writeback decisions)
is unavoidably approximate.   It would be nice to make it a per-CPU
array.  So on the rare occasions when the dirty-page count is needed,
I can just whizz across the per-cpu counters adding them all up.

But how to increment or decrement a per-cpu counter?  The options
are:

- per_cpu_integer++;

  This is *probably* OK on all architectures.  But there are no
  guarantees that the compiler won't play games, and that this
  operation is preempt-safe.

- preempt_disable(); per_cpu_counter++; preempt_enable();

  A bit heavyweight for add-one-to-i.

- atomic_inc

  A buslocked operation where it is not needed - we only need
  a preempt-locked operation here.  But it's per-cpu data, and
  the buslocked rmw won't be too costly.

I can't believe how piddling this issue is :)

But if there's a general need for such a micro-optimisation
then we need to:

1: Create <linux/atomic.h> (for heavens sake!)

2: In <linux/atomic.h>,

   #ifndef ARCH_HAS_ATOMIC_INQ_THINGIES
   #define atomic_inc_irq atomic_inc
   ...
   #endif

But for now, I suggest we not bother.  I'll just use atomic_inc().

-
