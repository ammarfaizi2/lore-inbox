Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWFNHmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWFNHmi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 03:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWFNHmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 03:42:38 -0400
Received: from ns2.suse.de ([195.135.220.15]:1998 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750968AbWFNHmh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 03:42:37 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: FOR REVIEW: New x86-64 vsyscall vgetcpu()
Date: Wed, 14 Jun 2006 09:42:31 +0200
User-Agent: KMail/1.9.3
Cc: libc-alpha@sourceware.org, vojtech@suse.cz
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606140942.31150.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got several requests over the years to provide a fast way to get
the current CPU and node on x86-64.  That is useful for a couple of things:

- The kernel gets a lot of benefit from using per CPU data to get better
cache locality and avoid cache line bouncing. This is currently
not quite possible for user programs. With a fast way to know the current
CPU user space can use per CPU data that is likely in cache already.
Locking is still needed of course - after all the thread might switch
to a different CPU - but at least the memory should be already in cache
and locking on cached memory is much cheaper.

- For NUMA optimization in user space you really need to know the current
node to find out where to allocate memory from.
If you allocate a fresh page from the kernel the kernel will give you
one in the current node, but if you keep your own pools like most programs
do you need to know this to select the right pool.
On single threaded programs it is usually not a big issue because they
tend to start on one node, allocate all their memory there and then eventually
use it there too, but on multithreaded programs where threads can
run on different nodes it's a bigger problem to make sure the threads
can get node local memory for best performance.

At first look such a call still looks like a bad idea - after all the kernel can 
switch a process at any time to other CPUs so any result of this call might 
be wrong as soon as it returns.

But at a closer look it really makes sense:
- The kernel has strong thread affinity and usually keeps a process on the 
same CPU. So switching CPUs is rare. This makes it an useful optimization.

The alternative is usually to bind the process to a specific CPU - then it
"know" where it is - but the problem is that this is nasty to use and 
requires user configuration. The kernel often can make better decisions on 
where to schedule. And doing it automatically makes it just work.

This cannot be done effectively in user space because only the kernel
knows how to get this information from the CPUs because it  requires
translating local APIC numbers to Linux CPU numbers.

Doing it in a syscall is too slow so doing it in a vsyscall makes sense.

I have patches now in my tree from Vojtech
ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/getcpu-vsyscall
(note doesn't apply on its own, needs earlier patches in the quilt set) 

The prototype is 

long vgetcpu(int *cpu, int *node, unsigned long *tcache)

cpu gets the current CPU number if not NULL.
node gets the current node number if not NULL
tcache is a pointer to a two element long array, can be also NULL. Described below.
Return is always 0.

[I modified the prototype a bit over Vojtech's original implementation
to be more foolproof and add the caching mechanism]

Unfortunately all ways to get this information from the CPU are still relatively slow:
it supports RDTSCP on CPUs that support it and CPUID(1) otherwise. Unfortunately
they both are relatively slow.
 
They stall the pipeline and add some overhead
so I added a special caching mechanism. The idea is that if it's a little
slow then user space would likely cache the information anyways. The problem
with caching is that you need a way to find if it's out of date. User space
cannot do this because it doesn't have a fast way to access a time stamp.

But the x86-64 vsyscall implementation happens to incidentally - vgettimeofday()
already has access to jiffies, that can be just used as a timestamp to
invalidate the cache. The vsyscall cannot cache this information by itself
though - it doesn't have any storage. The idea is that the user would pass a 
TLS variable in there which is then used for storage.  With that the information
can be at best a jiffie out of date, which is good enough.

The contents of the cache are theoretically supposed to be opaque (although I'm 
sure user programs  will soon abuse that because it will such a convenient way 
to get at jiffies ..). I've considered xoring it with a value to make it clear
it's not, but that is probably overkill (?). Might be still safer because
jiffies is unsafe to use in user space because the unit might change.

The array is slightly ugly - one open possibility is to replace it with 
a structure. Shouldn't make much difference to the general semantics of the syscall though.

Some numbers:  (the getpid is to compare syscall cost)

AMD RevF (with RDTSCP support):
getpid 162 cycles
vgetcpu 145 cycles
vgetcpu rdtscp 32 cycles
vgetcpu cached 14 cycles

Intel Pentium-D (Smithfield): 
getpid 719 cycles
vgetcpu 535 cycles
vgetcpu cached 27 cycles

AMD RevE:
getpid 162 cycles
vgetcpu 185 cycles
vgetcpu cached 15 cycles

As you can see CPUID(1) is always very slow, but usually narrowly wins
against the syscall still, except on AMD E stepping. The difference
is very small there and while it would have been possible to implement
a third mode for this that uses a real syscall I ended not too because it 
has some other implications.

With the caching mechanism it really flies though and should be fast enough
for most uses.

My eventual hope is that glibc will be start using this to implement a NUMA aware
malloc() in user space that tries to allocate local memory preferably.
I would say that's the biggest gap we still have in "general purpose" NUMA tuning 
on Linux. Of course it will be likely useful for a lot of other scalable
code too.

Comments on the general mechanism are welcome. If someone is interested in using 
this in user space for SMP or NUMA tuning please let me know.

I haven't quite made of my mind yet if it's 2.6.18 material or not.

-Andi
