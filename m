Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbTJJTEN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 15:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbTJJTEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 15:04:01 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:21917
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S262712AbTJJTDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 15:03:16 -0400
Date: Fri, 10 Oct 2003 21:03:38 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jamie Lokier <jamie@shareable.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
Message-ID: <20031010190338.GI16013@velociraptor.random>
References: <20031010182021.GF16013@velociraptor.random> <Pine.LNX.4.44.0310101126120.20420-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310101126120.20420-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 11:36:29AM -0700, Linus Torvalds wrote:
> 
> On Fri, 10 Oct 2003, Andrea Arcangeli wrote:
> > 
> > O_DIRECT only walk the pagetables, no pte mangling, no tlb flushes, the
> > TLB is preserved fully.
> 
> Yes. However, it's even _nicer_ if you don't need to walk the page tables 
> at all.
> 
> Quite a lot of operations could be done directly on the page cache. I'm 
> not a huge fan of mmap() myself - the biggest advantage of mmap is when 
> you don't know your access patterns, and you have reasonably good 
> locality. In many other cases mmap is just a total loss, because the page 
> table walking is often more expensive than even a memcpy().
> 
> That's _especially_ true if you have to move mappings around, and you have 
> to invalidate TLB's. 

agreed. that's what remap_file_pages does infact.

> memcpy() often gets a bad name. Yeah, memory is slow, but especially if 
> you copy something you just worked on, you're actually often better off 
> letting the CPU cache do its job, rather than walking page tables and 
> trying to be clever.
> 
> Just as an example: copying often means that you don't need nearly as much 
> locking and synchronization - which in turn avoids one whole big mess 
> (yes, the memcpy() will look very hot in profiles, but then doing extra 
> work to avoid the memcpy() will cause spread-out overhead that is a lot 
> worse and harder to think about).
> 
> This is why a simple read()/write() loop often _beats_ mmap approaches. 
> And often it's actually better to not even have big buffers (ie the old 
> "avoid system calls by aggregation" approach) because that just blows your 
> cache away.
> 
> Right now, the fastest way to copy a file is apparently by doing lots of
> ~8kB read/write pairs (that data may be slightly stale, but it was true at
> some point). Never mind the system call overhead - just having the extra
> buffer stay in the L1 cache and avoiding page faults from mmap is a bigger
> win.
> 
> And I don't think mmap _can_ beat that. It's fundamental. 

That's my whole point, agreed. Though using mmap would be sure cleaner
and simpler.

> In contrast, direct page cache accesses really can do so. Exactly because 
> they don't touch any page tables at all, and because they can take 
> advantage of internal kernel data structure layout and move pages around 
> without any cost..

Which basically means removing O_DIRECT from the open syscalls and still
use read/write if I understand correctly.

With todays commodity dirtcheap hardware, it has been proven that
walking the pte (NOTE: only walking, no mangling and no tlb flushing) is
much faster than doing the memcpy. More cpu is left free for the other
tasks and the cost of the I/O is the same. The different isn't
measurable in I/O bound tasks, but a database is both IO bound and cpu
bound at the same time, so for a db it's measurable. At least this is
the case for Oracle. I believe Joel has access to these numbers too, and
that's why he's interested in O_DIRECT in the first place.

With faster membus things may change of course (to the point where
there's no difference between the two models), but still I don't see how
can walking tree pointers to be more expensive than copying 512bytes of
data (assuming the smaller blocksize). And you're ignoring the CPU *has*
to walk those three pointers _anyways_ implicitly to allow the memcpy to
run. So as far as I can tell the memcpy is pure overhead that can be
avoided with O_DIRECT.

this is also why I rejected all approcches that wanted to allow
readahead via O_DIRECT by preloading data in pagecache, my argument is:
if you can't avoid the memcpy you must not use O_DIRECT. The only signle
object of O_DIRECT is to avoid the memcpy, the cache pollution avoidance
is a very minor issue, the main point is to avoid the memcpy.

I also posted a number of benchmarks at some point, where I've shown a
dramatical reduction of the cpu usage, up to 10% reduction, on a normal
cheap hardware w/o reduction of I/O bandwidth. This means 10% more cpu
to use for doing something useful in the cpu bound part of the database.

The main downside of O_DIRECT I believe conceptual, starting from the
ugliness inside the kernel, like the cache coherency handling and
i_alloc_sem need to avoid reads to run in parallel of block allocations,
etc... but the practical effect I doubt can be easily beaten in the
numbers. That said maybe we can provide a nicer API that does the same
thing internally I don't know, but certainly that can't be
remap_file_pages because that does a very different thing.

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
