Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265165AbUD3Uop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265165AbUD3Uop (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 16:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUD3Uop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 16:44:45 -0400
Received: from zero.aec.at ([193.170.194.10]:26381 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S265165AbUD3UjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 16:39:08 -0400
To: Ulrich Drepper <drepper@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: NUMA API
References: <1QAMU-4gf-15@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
In-Reply-To: <1QAMU-4gf-15@gated-at.bofh.it> (Ulrich Drepper's message of
 "Fri, 30 Apr 2004 09:40:08 +0200")
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
Date: Fri, 30 Apr 2004 22:39:05 +0200
Message-ID: <m3llkd9p5i.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper <drepper@redhat.com> writes:

[my apologies if this turns up twice. I have had some problems with
the mailer]

>In the last weeks I have been working on designing a new API for a NUMA
>support library.  I am aware of the code in libnuma by ak but this code
>has many shortcomings:

> ~ a completely unacceptable library interface (e.g., global variables as
> part of the API, WTF?)

You mean numa_no_nodes et.al. ? 

This is essentially static data that never changes (like in6addr_any).
numa_all_nodes could maybe in future change with node hotplug support,
but even then it will be a global property.

Everything else is thread local.

> ~ inadequate topology discovery

I believe it is good enough for current machines, at least 
until there is enough experience to really figure out what
node discovery is needed.. I have seen some proposals
for complex graph based descriptions, but so far I have seen
nothing that could really take advantage of something so fancy.
If it should be really needed it can be added later.

IMHO we just do not know enough right now to design a good topology
discovery interface. Until that is fixed it is best to err on the
side of simplicity.

> ~ fixed cpu set size

That is wrong. The latest version does not have fixed cpu set size.

> ~ no inclusion of SMT/multicore in the cpu hierarchy

Not sure why you would care about that. NUMA is only about "what CPUs
belong to which memory block". While multicore can affect the number
of CPUs in a node the actually shared packages only have cache
effects, but not "sticky memory" effects.  To handle cache effects all
you need to do is to change scheduling, not NUMA policy. Supporting
cache policy in the NUMA policy would result in a quite complex
optimization problem on how to tune the scheduler. But the whole point
why at least I started libnuma initially was to avoid this complex
problem, and just use simple hints. For this reasons putting cache
policy into the memory policy is imho quite misguided.

> As specified, the implementation of the interface is designed with only
> the requirements of a program on NUMA hardware in mind.  I have paid no
> attention to the currently proposed kernel extensions.  If the latter do
> not really allow implementing the functionality programmers need then it
> is wasted efforts.

Well, I spent a lot of time talking to various users; and IMHO
it matches the needs of a lot of them. I did not add all the features
everybody wanted, but that was simply not possible and still comming
up with a reasonable design.

> For instance, I think the way memory allocated in interleaved fashion is
> not "ideal".  Interleaved allocation is a property of a specific
> allocation.  Global states for processes (or threads) are a terrible way
> to handle this and other properties since it requires the programmer to
> constantly switch the mode back and forth since any part of the runtime
> might be NUMA aware and reset the mode.

If you do not want per process state just use the allocation function
in libnuma instead. They use mbind() and have no per thread state,
only per VMA state.

The per process state is needed for numactl though.

I kept the support for this visible in libnuma to make it easier to convert
old code to this (just wrap some code with a policy) For designed from 
scratch programs it is probably better to use the allocation functions
with mbind directly.

> Also, the concept of hard/soft sets for CPUs is useful.  Likewise
> "spilling" over to other memory nodes.  Usually using NUMA means hinting
> the desired configuration to the system.  It'll be used whenever
> possible.  If it is not possible (for instance, if a given processor is
> not available) it is mostly no good idea to completely fail the

Agreed. That is why prefered and bind are different policies
and you can switch between them in libnuma. 

> execution.  Instead a less optimal resource should be used.  For memory
> it is hard to know how much memory on which node is in use etc.

numa_node_size()

> Another missing feature in libnuma and the current kernel design is
> support for changes in the configuration.  CPUs might be added or
> removed, likewise memory.  Additional interconnects between NUMA blocks
> might be added etc.

It is version 1.0. So far all the CPU hotplug code seems to be
still too far in flux to really do something good about it. I expect 
once all this settles down libnuma will also grow some support
for dynamic reconfiguration. 

Comments on some (not all of your criticisms):

>
> Comparison with libnuma
> =======================
>
> nodemask_t:
>
>   Unlike nodemask_t, cpu_set_t is already in use in glibc.  The affinity
>   interfaces use it so there is not need to duplicate the functionality
>   and no need to define other versions of the affinity interfaces.
>
>   Furthermore, the nodemask_t type is of fixed size.  The cpu_set_t
>   has a convenience version which is of fixed size but can be of
>   arbitrary size.  This is important has a bit of math shows:
>
>     Assume a processor with four cores and 4 threads each
>
>     Four such processors on a single NUMA node
>
>     That's a total of 64 virtual processors for one node.  With 32 such
>     nodes the 1024 processors of cpu_set_t would be filled.  And we do
>     not want to mention the total of 64 supported processors in libnuma's
>     nodemask_t.  To be future safe the bitset size must be variable.

nodemask_t has nothing to do with virtual CPUs, only with nodes
(= memory controllers) 

There is no fixed size in the current version for CPUs.
There was in some earlier version, but I quickly dropped that because
it was indeed a bad idea.

There is a fixed size nodemask type though, although its upper limit
is extremly high (4096 nodes on IA64).  I traded this limit 
for simplicity of use.


> numa_bind()    --> NUMA_mem_set_home() or NUMA_mem_set_home_thread()
>                   or NUMA_aff_set_cpu(() or NUMA_aff_set_cpu_thread()
>
>  numa_bind() misses A LOT of flexibility.  First, memory and CPU need
>  node be the same nodes. Second, thread handling is missing.  Third,
>  hard versus soft requirements are not handled for CPU usage.

Correct. That is why lower level functions exist too. numa_bind is
merely a comfortable high level utility function to make libnuma more
pleasant to use for many (but not all) users. It trades some
flexibility to cater to the common case.

> numa_police_memory()  -->  nothing yet
> 
 > I don't see why this is necessary.  Yes, address space allocation and
 > the actual allocation of memory are two steps.  But this should be
 > taken case of by the allocation functions (if necessary).  To support
 > memory allocation with other interfaces then those described here and
 > magically treat them in the "NUMA-way" seems dumb.

You need process policy for command line policy. To make converting
old programs easier I opted to expose it in libnuma too. For new programs
I agree it is better to just use the allocator functions.

> numa_set_bind_policy() --> too coarse grained
>
>  This cannot be a process property.  And it must be possible to change

It is a per thread property.

-Andi

