Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277244AbRJLFoZ>; Fri, 12 Oct 2001 01:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277242AbRJLFoO>; Fri, 12 Oct 2001 01:44:14 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:17932 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S277243AbRJLFn4>;
	Fri, 12 Oct 2001 01:43:56 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200110120543.f9C5hvZ224264@saturn.cs.uml.edu>
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with
To: Paul.McKenney@us.ibm.com (Paul McKenney)
Date: Fri, 12 Oct 2001 01:43:56 -0400 (EDT)
Cc: andrea@suse.de (Andrea Arcangeli), frival@zk3.dec.com (Peter Rival),
        ink@jurassic.park.msu.ru (Ivan Kokshaysky), Jay.Estabrook@compaq.com,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        rth@twiddle.net (Richard Henderson), cardoza@zk3.dec.com,
        woodward@zk3.dec.com
In-Reply-To: <OF206EE8AA.7A83A16B-ON88256AE1.005467E3@boulder.ibm.com> from "Paul McKenney" at Oct 10, 2001 08:24:11 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul McKenney writes:

> In the meantime, Compaq's patent #6,108,737 leads me to believe that
> others in DEC/Compaq also believe it to be a feature.  The paragraph
> starting at column 2 line 20 of the body of this patent states:
>
>      In a weakly-ordered system, an order is imposed between selected
>      sets of memory reference operations, while other operations are
>      considered unordered.  One or more MB instructions are used to
>      indicate the required order.  In the case of an MB instruction
>      defined by the Alpha (R) 21264 processor instruction set, the MB
>      denotes that all memory reference instructions above the MB (i.e.,
>      pre-MB instructions) are ordered before all reference instructions
>      after the MB (i.e., post-MB instructions).  However, no order
>      is required between reference instructions that are not separated
>      by an MB.
>
> (The patent talks about the WMB instruction later on.)
>
> In other words, if there is no MB, the CPU is not required to maintain
> ordering.  Regardless of data dependencies or anything else.
>
> There is also an application note at
>
>      http://www.openvms.compaq.com/wizard/wiz_2637.html
>
> which states:
> 
>      For instance, your producer must issue a "memory barrier" instruction
>      after writing the data to shared memory and before inserting it on
>      the queue; likewise, your consumer must issue a memory barrier
>      instruction after removing an item from the queue and before reading
>      from its memory.  Otherwise, you risk seeing stale data, since,
>      while the Alpha processor does provide coherent memory, it does
>      not provide implicit ordering of reads and writes.  (That is, the
>      write of the producer's data might reach memory after the write of
>      the queue, such that the consumer might read the new item from the
>      queue but get the previous values from the item's memory.
> 
> Note that they require a memory barrier (rmb()) between the time the
> item is removed from the queue and the time that the data in the item
> is referenced, despite the fact that there is a data dependency between
> the dequeueing and the dereferencing.  So, again, data dependency does
> -not- substitute for an MB on Alpha.

This looks an awful lot like the PowerPC architecture.

In an SMP system, one would most likely mark pages as
requiring coherency. This means that stores to a memory
location from multiple processors will give sane results.
Ordering is undefined when multiple memory locations are
involved.

There is a memory barrier instruction called "eieio".
This is commonly used for IO, but is also useful for RAM.
Two separate sets of memory operations are simultaneously
and independently affected by eieio:

-- set one, generally memory-mapped IO space --
loads to uncached + guarded memory
stores to uncached + guarded memory
stores to write-through-required memory

-- set two, generally RAM on an SMP box --
stores to cached + write-back + coherent

"The eieio instruction is intended for use in managing shared data
structures ... the shared data structure and the lock that protects
it must be altered only by stores that are in the same set"
                             -- from the 32-bit ppc arch book
