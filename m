Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbTIMU6G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 16:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbTIMU6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 16:58:05 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:32914 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S262195AbTIMU6A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 16:58:00 -0400
Date: Sun, 14 Sep 2003 02:28:10 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Ravikiran G Thirumalai <kiran@in.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
Subject: Re: [patch] Make slab allocator work with SLAB_MUST_HWCACHE_ALIGN
Message-ID: <20030913205810.GA2184@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030910081654.GA1129@llm08.in.ibm.com> <1063208464.700.35.camel@localhost> <20030911055428.GA1140@llm08.in.ibm.com> <20030911110853.GB3700@llm08.in.ibm.com> <3F60A08A.7040504@colorfullife.com> <20030912085921.GB1128@llm08.in.ibm.com> <3F6378B0.8040606@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F6378B0.8040606@colorfullife.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 10:06:08PM +0200, Manfred Spraul wrote:
> Ravikiran G Thirumalai wrote:
> >I wouldn't be using the slab at all because using slabs would mean using
> >NR_CPUs pointers and one extra dereference which is bad as we had found out
> >earlier.  But I guess slab will have to do node local allocations for
> >other applications.
> > 
> >
> Interesting. Slab internally uses lots of large per-cpu arrays. 
> Alltogether something like around 40 kB/cpu. Right now implemented with 
> NR_CPUs pointers. In the long run I'll try to switch to your allocator.
> 
> But back to the patch that started this thread: Do you still need the 
> ability to set an explicit alignment for slab allocations? If yes, then 
> I'd polish my patch, double check all kmem_cache_create callers and then 
> send the patch to akpm. Otherwise I'd wait - the patch is not a bugfix.

This is the problem - the current dynamic per-cpu allocator
(alloc_percpu()) is broken. I uses kmalloc() to allocate each
CPU's data, but kmalloc() doesn't gurantee cache line alignment
(only SLAB_HWCACHE_ALIGN). This may result in some per-CPU statistics
bouncing between CPUs specially on the ones with large L1 cache lines.

We have a number of options -

1. Force kmalloc() to strictly align on cache line boundary, but will
   result in wastage of space elsewhere (with your strict align patch)
   but alloc_percpu() will never result in cache line sharing.
2. Make alloc_percpu() use its own caches for various sizes with your
   strictly align patch. The rest of the kernel is not affected.
3. Let alloc_percpu() use its own allocator which supports NUMA
   and does not use an offset table.

#2 and #3 has less impact in the kernel and we should consider those,
IMO.

Thanks
Dipankar
