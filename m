Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293119AbSBWLjs>; Sat, 23 Feb 2002 06:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293121AbSBWLjj>; Sat, 23 Feb 2002 06:39:39 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:24326 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S293119AbSBWLjg>;
	Sat, 23 Feb 2002 06:39:36 -0500
Date: Sat, 23 Feb 2002 04:38:15 -0700
From: yodaiken@fsmlabs.com
To: Andrew Morton <akpm@zip.com.au>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] only irq-safe atomic ops
Message-ID: <20020223043815.B29874@hq.fsmlabs.com>
In-Reply-To: <3C773C02.93C7753E@zip.com.au>, <1014444810.1003.53.camel@phantasy> <3C773C02.93C7753E@zip.com.au> <1014449389.1003.149.camel@phantasy> <3C774AC8.5E0848A2@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3C774AC8.5E0848A2@zip.com.au>; from akpm@zip.com.au on Fri, Feb 22, 2002 at 11:54:48PM -0800
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 11:54:48PM -0800, Andrew Morton wrote:
> Robert Love wrote:
> > Thinking about it, you are probably going to be doing this:
> > 
> >         ++counter[smp_processor_id()];
> > 
> > and that is not preempt-safe since the whole operation certainly is not
> > atomic.  The current CPU could change between calculating it and
> > referencing the array.
> 
> yup.  It'd probably work - the compiler should calculate the address and
> do a non-buslocked but IRQ-atomic increment on it.  But no way can we
> rely on that happening.
> 
> >  But, that wouldn't matter as long as you only
> > cared about the sum of the counters.
> 
> If the compiler produced code equivalent to
> 
> 	counter[smp_processor_id()] = counter[smp_processor_id()] + 1;
> 
> then the counter would get trashed - a context switch could cause CPUB
> to write CPUA's counter (+1) onto CPUB's counter.  It's quite possibly
> illegal for the compiler to evaluate the array subscript twice in this
> manner.  Dunno.
> 
> If the compiler produced code equivalent to:
> 
> 	const int cpu = smp_processor_id();
> 	counter[cpu] = counter[cpu] + 1;
> 
> (which is much more likely) then a context switch would result
> in CPUB writing CPUA's updated counter onto CPUA's counter.  Which
> will work a lot more often, until CPUA happens to be updating its
> counter at the same time.

So without preemption in the kernel
	maybe 4 instructions: calculate cpuid, inc; all local no cache ping
	code is easy to read and understand.

with preemption in the kernel
	a design problem. a slippery synchronization issue that 
	involves the characteristic preemption error - code that works
	most of the time.




	
-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

