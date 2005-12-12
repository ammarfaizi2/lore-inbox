Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbVLLAth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbVLLAth (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 19:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbVLLAth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 19:49:37 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:26566 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1750943AbVLLAtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 19:49:36 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       vatsa@in.ibm.com, Oleg Nesterov <oleg@tv-sign.ru>,
       linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: Semantics of smp_mb() [was : Re: [PATCH] Fix RCU race in access of nohz_cpu_mask ] 
In-reply-to: Your message of "Mon, 12 Dec 2005 10:45:16 +1100."
             <1134344716.5937.11.camel@localhost.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 12 Dec 2005 11:49:07 +1100
Message-ID: <18382.1134348547@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Dec 2005 10:45:16 +1100, 
Rusty Russell <rusty@rustcorp.com.au> wrote:
>On Sun, 2005-12-11 at 16:21 -0500, Andrew James Wade wrote:
>> On Sunday 11 December 2005 12:41, Srivatsa Vaddagiri wrote:
>> > We seem to be having some confusion over the exact semantics of smp_mb().
>> > 
>> > Specifically, are all stores preceding smp_mb() guaranteed to have finished
>> > (committed to memory/corresponding cache-lines on other CPUs invalidated) 
>> > *before* successive loads are issued?
>> 
>> I doubt it. That's definitely not true of smp_wmb(), which boils down to
>> __asm__ __volatile__ ("": : :"memory") on SMP i386 (which the constrains
>> how the compiler orders write instructions, but is otherwise a nop. i386
>> has in-order writes.).
>> 
>> And it makes sense that wmb() wouldn't wait for writes: RCU needs
>> constraints on the order in which writes become visible, but has very week
>> constraints on when they do. Waiting for writes to flush would hurt
>> performance.
>
>On the contrary.  I did some digging and asking and thinking about this
>for the Unreliable Guide to Kernel Locking, years ago:
>
>wmb() means all writes preceeding will complete before any writes
>following are started.
>rmb() means all reads preceeding will complete before any reads
>following are started.
>mb() means all reads and writes preceeding will complete before any
>reads and writes following are started.

FWIW, wmb() on IA64 does not require that preceding stores are flushed
to main memory.  It only requires that they be "made visible to other
processors in the coherence domain".  "visible" means that the updated
value must reach (at least) an externally snooped cache.  There is no
requirement that the preceding stores be flushed all the way to main
memory, the updates only have to get as far as a cache level that other
cpus can see.  The cache snooping takes care of flushing to main memory
when necessary.

IA64 does have a memory fence that stalls the cpu until the data is
"accepted by the external platform".  That format is expensive and is
only used for memory mapped I/O, where the data really does have to
read the memory before the cpu can perform its next operation.  For
example, in the mmiowb() case.

