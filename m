Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbVLKRku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbVLKRku (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 12:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbVLKRkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 12:40:49 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:51360 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750744AbVLKRkt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 12:40:49 -0500
Date: Sun, 11 Dec 2005 23:11:14 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Semantics of smp_mb() [was : Re: [PATCH] Fix RCU race in access of nohz_cpu_mask ]
Message-ID: <20051211174114.GA4883@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <439889FA.BB08E5E1@tv-sign.ru> <20051209024623.GA14844@in.ibm.com> <4399D852.47E0BB4E@tv-sign.ru> <20051210151951.GA2798@in.ibm.com> <439B24A7.E2508AAE@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <439B24A7.E2508AAE@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Changed the subject line to be more generic in the interest of wider audience]

We seem to be having some confusion over the exact semantics of smp_mb().

Specifically, are all stores preceding smp_mb() guaranteed to have finished
(committed to memory/corresponding cache-lines on other CPUs invalidated) 
*before* successive loads are issued?


>From IA-32 manual (download.intel.com/design/Pentium4/manuals/25366817.pdf
Page 271):

"Memory mapped devices and other I/O devices on the bus are often sensitive to 
the order of writes to their I/O buffers. I/O instructions can be used to (the 
IN and OUT instructions) impose strong write ordering on such accesses as 
follows. Prior to executing an I/O instruction, the processor waits for all 
						___________________________
previous instructions in the program to complete and for all buffered
_____________________________________________________________________
writes to drain to memory. Only instruction fetch and page tables walks can 
_________________________
pass I/O instructions. Execution of subsequent instructions do not begin until 
the processor determines that the I/O instruction has been completed."

Synchronization mechanisms in multiple-processor systems may depend upon a 
strong memory-ordering model. Here, a program can use a locking instruction 
such as the XCHG instruction or the LOCK prefix to insure that a 
read-modify-write operation on memory is carried out atomically. Locking 
operations typically operate like I/O operations in that they wait for all 
							 _________________
previous instructions to complete and for all buffered writes to drain to 
_________________________________________________________________________
memory (see Section 7.1.2, “Bus Locking”).
______

Program synchronization can also be carried out with serializing instructions 
(see Section 7.4). These instructions are typically used at critical procedure 
or task boundaries to force completion of all previous instructions before a 
jump to a new section of code or a context switch occurs. Like the I/O and 
locking instructions, the processor waits until all previous instructions have
		      ________________________________________________________
been completed and all buffered writes have been drained to memory before 
_________________________________________________________________________
executing the serializing instruction."
_____________________________________


>From this, looks like we can interpret that IA-32 processor will wait for all 
writes to drain to memory (implies cache invalidation on other CPUs?) *before* 
executing the synchronizing instruction?

Question is can this be generalized for other CPUs too?


On Sat, Dec 10, 2005 at 09:55:35PM +0300, Oleg Nesterov wrote:
> Srivatsa Vaddagiri wrote:
> > 
> > On Fri, Dec 09, 2005 at 10:17:38PM +0300, Oleg Nesterov wrote:
> > > >         rcp->cur++;     /* New GP */
> > > >
> > > >         smp_mb();
> > >
> > > I think I need some education on memory barriers.
> > >
> > > Does this mb() garantees that the new value of ->cur will be visible
> > > on other cpus immediately after smp_mb() (so that rcu_pending() will
> > > notice it) ?
> > 
> > AFAIK the new value of ->cur should be visible to other CPUs when smp_mb()
> > returns. Here's a definition of smp_mb() from Paul's article:
> > 
> > smp_mb(): "memory barrier" that orders both loads and stores. This means loads
> > and stores preceding the memory barrier are committed to memory before any
> > loads and stores following the memory barrier.
> 
> Thanks, but this definition talks about ordering, it does not say
> anything about the time when stores are really commited to memory
> (and does it mean also that cache-lines are invalidated on other
> cpus ?).
> 
> > [ http://www.linuxjournal.com/article/8211 ]
> 
> And thanks for this link, now I have some understanding about
> read_barrier_depends() ...
> 
> Oleg.

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
