Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTEVHvs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 03:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbTEVHvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 03:51:48 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:52640 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262321AbTEVHvq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 03:51:46 -0400
Date: Thu, 22 May 2003 13:44:23 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, David Mosberger-Tang <davidm@hpl.hp.com>
Subject: Re: [PATCH 4/3] Replace dynamic percpu implementation
Message-ID: <20030522081423.GC27614@in.ibm.com>
References: <20030520043332.E80372C09D@lists.samba.org> <20030521103156.GB2861@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030521103156.GB2861@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 04:01:56PM +0530, Dipankar Sarma wrote:
>... 
> We will do some measurements with this but based on a large number
> of measurements that Kiran had done earlier, we can see a couple of things -
> 
> 1. Even though a percpu scheme using pointer arithmatic has one less memory
>    reference, the globally shared offset table is often in the cache
>    and therefore pointer arithmatic offers no added advantage.
> 
> 2. Increased sharing of cacheline helps by reducing associativity misses.
>    We see this by comparing an interlaced allocator where only same
>    sized objects share blocks vs. the current static allocator. Sharing of
>    blocks by differently sized objects also allow cache lines to be
>    kept warm as more subsystems in the kernel access them.
> 

Here is the summary of my experiments with difft per-cpu allocator methods.

The following methods were compared
1. Static per-cpu areas
2. kmalloc_percpu with NR_CPUS pointers and one extra dereference -- the
   current implementation (no interlace) (kmalloc_percpu_current)
3. kmalloc_percpu with  pointer arithmetic, but no interlace 
   (kmalloc_percpu_new)
4. alloc_percpu using Rusty's block allocator and the shared offset table
   (alloc_percpu_block)

Application used was speeding up vm_enough_memory using per-cpu counters
and reducing atomic_operataions.  Benchmark used was kernbench. Profile
ticks on vm_enough_memory was used to compare allocator methods
(vm_acct_memory was made inline).  This was on a 4 processor pIII xeon.

To summarise,
1. Static per-cpu areas was 6.5 % better  that kmalloc_percpu_current
2. kmalloc_percpu_new and static per-cpu areas had similar results.
3. alloc_percpu results were similar to static per-cpu areas and 
   kmalloc_percpu_new
4. Extra dereferences in alloc_percpu were not significant, but alloc_percpu
   was interlaced and kmalloc_percpu_new wasn't.  Insn profile seemed to
   indicate extra cost in memory dereferencing of alloc_percpu was
   offset by the interlacing/objects sharing the same cacheline part.
   but then insn profiles are only indicative...not accurate.

todo:
I have to see how a interlaced kmalloc_percpu with pointer  arithmetic 
fares in these tests (once i have it working) and the performace part
of the percpu allocators will be hopefully clear.

Thanks,
Kiran
