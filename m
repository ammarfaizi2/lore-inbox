Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264072AbRGDLum>; Wed, 4 Jul 2001 07:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264336AbRGDLuc>; Wed, 4 Jul 2001 07:50:32 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:4113 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S264072AbRGDLuS>;
	Wed, 4 Jul 2001 07:50:18 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15171.658.185269.515838@tango.paulus.ozlabs.org>
Date: Wed, 4 Jul 2001 21:48:34 +1000 (EST)
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: about kmap_high function
In-Reply-To: <20010703163418.E28793@redhat.com>
In-Reply-To: <3620762046.20010629150601@turbolinux.com.cn>
	<20010703103809.A29868@redhat.com>
	<15169.48856.428247.217216@cargo.ozlabs.ibm.com>
	<20010703163418.E28793@redhat.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen C. Tweedie writes:

> On Tue, Jul 03, 2001 at 10:47:20PM +1000, Paul Mackerras wrote:
> > On PPC it is a bit different.  Flushing a single TLB entry is
> > relatively cheap - the hardware broadcasts the TLB invalidation on the
> > bus (in most implementations) so there are no cross-calls required.  But
> > flushing the whole TLB is expensive because we (strictly speaking)
> > have to flush the whole of the MMU hash table as well.
> 
> How much difference is there? 

Between flushing a single TLB entry and flushing the whole TLB, or
between flushing a single entry and flushing a range?

Flushing the whole TLB (including the MMU hash table) would be
extremely expensive.  Consider a machine with 1GB of RAM.  The
recommended MMU hash table size would be 16MB (1024MB/64), although we
generally run with much less, maybe a quarter of that.  That's still
4MB of memory we have to scan through in order to find and clear all
the entries in the hash table, which is what would be required for
flushing the whole hash table.

What we do at present is (a) have a bit in the linux page tables which
indicates whether there is a corresponding entry in the MMU hash table
and (b) only flush the kernel portion of the address space (0xc0000000
- 0xffffffff) in flush_tlb_all().  We have a single page table tree
for kernel addresses, shared between all processes.  That all helps
but we still have to scan through all the page table pages for kernel
addresses to do a flush_tlb_all().

I just did some measurements on a 400MHz POWER3 machine with 1GB of
RAM.  This is a 64-bit machine but running a 32-bit kernel (so both
the kernel and userspace run in 32-bit mode).  It is a 1-cpu machine
and I am running an SMP kernel with highmem enabled, with 512MB of
lowmem and 512MB of highmem.  The MMU hash table is 4MB.

The time taken inside a single flush_tlb_page call depends on whether
the linux PTE indicates that there is a hardware PTE in the hash
table.  If not, it takes about 110ns, if it does, it takes 1us (I
measured 998.5ns but I rounded it :).

A call to flush_tlb_range for 1024 pages from flush_all_zero_pkmaps
(replacing the flush_tlb_all call) takes around 1080us, which is
pretty much linear.  The time for flush_tlb_page was measured inside
the procedure whereas the time for flush_tlb_range was measured in the
caller, so the flush_tlb_range number includes procedure call and loop
overhead which the flush_tlb_page number doesn't.  I expect that
almost all the PTEs in the pkmap range would have a corresponding hash
table entry, since we would almost always touch a page that we have
kmap'd.

> We only flush once per kmap sweep, and
> we have 1024 entries in the global kmap pool, so the single tlb flush
> would have to be more than a thousand times less expensive overall
> than the global flush for that change to be worthwhile.

The time for doing a flush_tlb_all call in flush_all_zero_pkmaps was
3280us.  That is for the version which only flushes the kernel portion
of the address space.  Just doing a memset to 0 on the hash table
takes over 11ms (the memset goes at around 360MB/s but there is 4MB to
clear).  Clearing out the hash table properly would take much longer
since you are supposed to synchronize with the hardware when changing
each entry in the hash table and the memset is certainly not doing that.

So yes, the ratio is more than 1024 to 1.

> If the page flush really is _that_ much faster, then sure, this
> decision can easily be made per-architecture: the kmap_high code
> already has all of the locking and refcounting to know when a per-page
> tlb flush would be safe.

My preference would be for architectures to be able to make this
decision.  I don't mind whether it is a flush call per page inside the
loop in flush_all_zero_pkmaps or a flush_tlb_range call at the end of
the loop.  I counted the average number of pages needing to be
flushed in the loop in flush_all_zero_pkmaps - it was 1023.9 for the
workload I was using, which was a kernel compile.

Using flush_tlb_range would be fine on PPC but as I noted before some
architectures assume that flush_tlb_range is only used on user
addresses at the moment.

Paul.
