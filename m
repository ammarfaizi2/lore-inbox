Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311092AbSCTBjO>; Tue, 19 Mar 2002 20:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311121AbSCTBi5>; Tue, 19 Mar 2002 20:38:57 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:17012 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S311092AbSCTBif>; Tue, 19 Mar 2002 20:38:35 -0500
Date: Wed, 20 Mar 2002 02:40:08 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scalability problem (kmap_lock) with -aa kernels
Message-ID: <20020320024008.A4268@dualathlon.random>
In-Reply-To: <47390000.1016511942@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2002 at 08:25:42PM -0800, Martin J. Bligh wrote:
> OK, I finally got the -aa kernel series running in conjunction with the
> NUMA-Q discontigmem stuff. For some reason which I haven't debugged
> yet 2.4.19-pre3-aa2 won't boot on the NUMA-Q even without the discontigmem

If you have PIII cpus pre3 mainline has a bug in the machine check code,
this one liner will fix it:

diff -urN 2.4.19pre3/arch/i386/kernel/bluesmoke.c mcheck/arch/i386/kernel/bluesmoke.c
--- 2.4.19pre3/arch/i386/kernel/bluesmoke.c	Tue Mar 12 00:07:06 2002
+++ mcheck/arch/i386/kernel/bluesmoke.c	Thu Mar 14 12:45:05 2002
@@ -169,7 +169,7 @@
 	if(l&(1<<8))
 		wrmsr(MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
 	banks = l&0xff;
-	for(i=0;i<banks;i++)
+	for(i=1;i<banks;i++)
 	{
 		wrmsr(MSR_IA32_MC0_CTL+4*i, 0xffffffff, 0xffffffff);
 	}


> stuff in ... so I went back to 2.4.19-pre1-aa1, which I knew worked from
> last time around (thanks again for that patch).
> 
> So just comparing aa+discontigmem to standard 2.4.18+discontigmem, I see
> kernel compile times are about 35s vs 26.5s .... hmmm. Looking at the top
> part of the profiles, I see this:
> 
> standard:
> 
>  23991 total                                      0.0257
>   7679 default_idle                             147.6731
>   3044 _text_lock_dcache                          8.7221
>   2340 _text_lock_swap                           43.3333
>   1160 do_anonymous_page                          3.4940
>    776 d_lookup                                   2.8116
>    650 __free_pages_ok                            1.2405
>    627 lru_cache_add                              6.8152
>    608 do_generic_file_read                       0.5468
>    498 __generic_copy_from_user                   4.7885
>    480 lru_cache_del                             21.8182
>    437 atomic_dec_and_lock                        6.0694
>    426 schedule                                   0.3017
>    402 _text_lock_dec_and_lock                   16.7500
> ...   
>    109 kmap_high                                  0.3028
>     46 _text_lock_highmem                  0.4071
> 
> andrea:    
>  38549 total                                      0.0405
>  13102 _text_lock_highmem                       108.2810
>   8627 default_idle                             165.9038
>   2578 kunmap_high                               14.3222
>   2556 kmap_high                                  6.0857

One thing I see is not only a scalability problem with the locking, but
it seems kmap_high is also spending an huge amount of time in kernel
compared to the "standard" profiling.  That maybe  because I increased
too much the size of the pool (the algorithm is O(N)). Can you try again
with this incremental patch applied?

--- 2.4.19pre3aa3/include/asm-i386/highmem.h.~1~	Thu Mar 14 12:48:11 2002
+++ 2.4.19pre3aa3/include/asm-i386/highmem.h	Wed Mar 20 01:31:42 2002
@@ -47,7 +47,7 @@
 	KM_NR_SERIES,
 };
 
-#define LAST_PKMAP 1024
+#define LAST_PKMAP 128
 #define PKMAP_SIZE ((LAST_PKMAP*KM_NR_SERIES) << PAGE_SHIFT)
 #define PKMAP_BASE (FIXADDR_START - PKMAP_SIZE - PAGE_SIZE) /* left a page in between */
 #define PKMAP_NR(virt)  (((virt)-PKMAP_BASE) >> PAGE_SHIFT)


If kmap_high was dogslow, all cpus had to stall for a very long time
into _text_lock_highmem (OTOH also kunmap_high has a quite high rate,
infact it has an higher rate, that doesn't make much sense).

> Andrea - is this your new highmem pte stuff doing this?

The pte-highmem stuff has nothing to do with the kmap_high O(N)
complexity that maybe the real reason of this slowdown. (the above patch
decreases N of an order of magnitude and so we'll see if that was the
real problem or not)

However avoiding completly persistent kmaps would definitely give you an
additional scalability at the cost of an additional tlb overhead and
uglier code. I never questioned this point. If you want to run a 1024
CPU system then you don't want the persistent kmaps, period.

So avoiding persistent kmaps in the pte handling would in turn you give
you additional scalability __if__ your workload is very pagetable
intensive (a kernel compile is very pagetable intensive incidentally),
but the very same scalability problem you can find with the pagetables
you will have it also for the cache in different workloads because all
the pagecache is in highmem too and every time you execute a read
syscall you will also need to kmap-persistent a pagecache.

So I will never agree that avoiding the persistent kmaps in the
pagetable handling is a final solution, if the persistent kmaps are a
bottleneck they have to be removed completly, not just from the
pagetable handling. 512 pages = 2M of cache being cached isn't enough if
it doesn't work well for the pagetables (infact such pool of mapped
pages sounds much nicer for the pagetables, where the ram footprint is
much smaller than for the pagecache, and also thanks to the quicklist
that will make more likely to have page->virtual just in cache, btw
removing the quicklist from 2.5 was a bad idea, the global allocator
affinity can be completly polluted under high I/O loads, and the
quicklist was still useful as an active list, but this is totally
offtopic here, it just happened to be broken in 2.5 with the high-pte
patch and that's why it came to mind).

Avoiding persistent kmaps for the whole pagetable handling doesn't
guarantee your scalability problem will go away, you will run in the
_very_same_scalability_problem_ with a just little different workload,
it depends completly on the workload, and lots of common applications
are going to be hurted by the pagecache I/O the same or more than the
pagetable kmaps.

The 2.5 kernel avoids using persistent kmaps for pagetables, that's the
only interesting difference with pte-highmem in 2.4 (all other
differences are not interesting and I prefer pte-highmem for all other
parts for sure), but note that you will still have to pay for an hit if
you want the feature compared to the "standard" 2.4 that you benchmarked
against: in 2.5 the CPU will have to walk pagetables for the kmap areas
after every new kmap because the kmap will be forced to flush the tlb
entry without persistence. The pagetables relative to the kmap atomic
area are shared across all cpus and the cpu issues locked cycles to walk
them.

The whole persistent kmap design is superior in common machines where
people doesn't need to scale up to 16-way and it allows us to write
simpler code compared to the atomic kmaps. It wasn't really designed for
16-way machines. It's not a matter of pte-highmem vs high-pte, it's a
matter of persistent kmaps vs atomic kmaps, not just for the pagetables
but for everything. If you need to avoid the global spinlock you don't
want the persistent kmaps, no matter where they came from
(pagetable/pagecache).

As soon as I'll get your result for the above patch, we'll be able to
choose if the right thing is to remove all persistent kmaps from
pte-highmem (removing them from the pagecache would be too complicated
in 2.4 because it would break the fs API, while just for pte-highmem is
doable in a few hours).  It will be a choice oriented for the very high
end 32bit x86 though, my 2-way x86 doesn't showup any locking problem in
the profiles yet.

Many thanks for the useful feedback.

Andrea
