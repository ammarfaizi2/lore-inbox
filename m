Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319572AbSIHHc0>; Sun, 8 Sep 2002 03:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319575AbSIHHc0>; Sun, 8 Sep 2002 03:32:26 -0400
Received: from packet.digeo.com ([12.110.80.53]:49050 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319572AbSIHHcY>;
	Sun, 8 Sep 2002 03:32:24 -0400
Message-ID: <3D7B0177.6A35FE9B@digeo.com>
Date: Sun, 08 Sep 2002 00:51:19 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>, linux-kernel@vger.kernel.org
Subject: Re: LMbench2.0 results
References: <20020907121854.10290.qmail@linuxmail.org> <3D7A2768.E5C85EB@digeo.com> <20020907200334.GI888@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Sep 2002 07:36:58.0860 (UTC) FILETIME=[839402C0:01C2570A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> Paolo Ciarrocchi wrote:
> >> Hi all,
> >> I've just ran lmbench2.0 on my laptop.
> >> Here the results (again, 2.5.33 seems to be "slow", I don't know why...)
> 
> On Sat, Sep 07, 2002 at 09:20:56AM -0700, Andrew Morton wrote:
> > The fork/exec/mmap slowdown is the rmap overhead.  I have some stuff
> > which partialy improves it.
> 
> Hmm, Where does it enter the mmap() path? PTE instantiation is only done
> for the VM_LOCKED case IIRC. Otherwise it should be invisible.
> 

lat_mmap seems to do a mmap, faults in ten pages and then
a munmap().  Most of the CPU cost is in cache misses against
the pagetables in munmap().

c012d54c 153      0.569493    do_mmap_pgoff           
c012db5c 158      0.588104    find_vma                
c01301ec 172      0.640214    filemap_nopage          
c0134e84 172      0.640214    release_pages           
c0114744 184      0.684881    smp_apic_timer_interrupt 
c012ce3c 248      0.9231      handle_mm_fault         
c012f738 282      1.04965     find_get_page           
c013e2b0 356      1.32509     __set_page_dirty_buffers 
c0116294 377      1.40326     do_page_fault           
c013e72c 383      1.42559     page_add_rmap           
c013e8bc 398      1.48143     page_remove_rmap        
c012cb10 425      1.58193     do_no_page              
c0109d70 629      2.34125     page_fault              
c012b2f4 1036     3.85618     zap_pte_range           
c0107048 20205    75.2066     poll_idle               

(Multiply everything by four - it's a quad)

Instruction-level profile for -mm5:

c012b2f4 1036     3.85618     0        0           zap_pte_range           /usr/src/25/mm/memory.c:325 
 c012b2f5 2        0.19305     0        0           /usr/src/25/mm/memory.c:325 
 c012b2fd 1        0.0965251   0        0           /usr/src/25/mm/memory.c:325 
 c012b300 2        0.19305     0        0           /usr/src/25/mm/memory.c:325 
 c012b306 1        0.0965251   0        0           /usr/src/25/mm/memory.c:329 
 c012b309 1        0.0965251   0        0           /usr/src/25/mm/memory.c:329 
 c012b30f 1        0.0965251   0        0           /usr/src/25/mm/memory.c:331 
 c012b319 1        0.0965251   0        0           /usr/src/25/mm/memory.c:331 
 c012b340 1        0.0965251   0        0           /usr/src/25/mm/memory.c:336 
 c012b348 1        0.0965251   0        0           /usr/src/25/include/asm/highmem.h:80 
 c012b350 1        0.0965251   0        0           /usr/src/25/include/asm/thread_info.h:75 
 c012b35a 2        0.19305     0        0           /usr/src/25/include/asm/highmem.h:85 
 c012b365 2        0.19305     0        0           /usr/src/25/include/asm/highmem.h:86 
 c012b3c3 2        0.19305     0        0           /usr/src/25/mm/memory.c:337 
 c012b3d6 1        0.0965251   0        0           /usr/src/25/mm/memory.c:338 
 c012b3e9 3        0.289575    0        0           /usr/src/25/mm/memory.c:341 
 c012b3f5 106      10.2317     0        0           /usr/src/25/mm/memory.c:342 
 c012b3f8 2        0.19305     0        0           /usr/src/25/mm/memory.c:342 
 c012b3fa 26       2.50965     0        0           /usr/src/25/mm/memory.c:343 
 c012b3fc 124      11.9691     0        0           /usr/src/25/mm/memory.c:343 
 c012b405 13       1.25483     0        0           /usr/src/25/mm/memory.c:345 
 c012b40b 1        0.0965251   0        0           /usr/src/25/mm/memory.c:346 
 c012b410 2        0.19305     0        0           /usr/src/25/mm/memory.c:348 
 c012b412 1        0.0965251   0        0           /usr/src/25/mm/memory.c:348 
 c012b414 62       5.98456     0        0           /usr/src/25/mm/memory.c:349 
 c012b41b 1        0.0965251   0        0           /usr/src/25/mm/memory.c:350 
 c012b421 21       2.02703     0        0           /usr/src/25/mm/memory.c:350 
 c012b427 2        0.19305     0        0           /usr/src/25/mm/memory.c:351 
 c012b432 2        0.19305     0        0           /usr/src/25/include/asm/bitops.h:244 
 c012b434 10       0.965251    0        0           /usr/src/25/mm/memory.c:352 
 c012b437 1        0.0965251   0        0           /usr/src/25/mm/memory.c:352 
 c012b43d 5        0.482625    0        0           /usr/src/25/mm/memory.c:353 
 c012b446 7        0.675676    0        0           /usr/src/25/include/linux/mm.h:389 
 c012b44b 1        0.0965251   0        0           /usr/src/25/include/linux/mm.h:392 
 c012b44e 1        0.0965251   0        0           /usr/src/25/include/linux/mm.h:392 
 c012b451 7        0.675676    0        0           /usr/src/25/include/linux/mm.h:393 
 c012b453 2        0.19305     0        0           /usr/src/25/include/linux/mm.h:393 
 c012b461 6        0.579151    0        0           /usr/src/25/include/linux/mm.h:396 
 c012b466 8        0.772201    0        0           /usr/src/25/include/linux/mm.h:396 
 c012b46f 6        0.579151    0        0           /usr/src/25/mm/memory.c:356 
 c012b476 15       1.44788     0        0           /usr/src/25/include/asm-generic/tlb.h:105 
 c012b481 3        0.289575    0        0           /usr/src/25/include/asm-generic/tlb.h:106 
 c012b490 5        0.482625    0        0           /usr/src/25/include/asm-generic/tlb.h:110 
 c012b493 7        0.675676    0        0           /usr/src/25/include/asm-generic/tlb.h:110 
 c012b49a 1        0.0965251   0        0           /usr/src/25/include/asm-generic/tlb.h:110 
 c012b49d 3        0.289575    0        0           /usr/src/25/include/asm-generic/tlb.h:110 
 c012b4a0 1        0.0965251   0        0           /usr/src/25/include/asm-generic/tlb.h:110 
 c012b4a3 8        0.772201    0        0           /usr/src/25/include/asm-generic/tlb.h:111 
 c012b4aa 13       1.25483     0        0           /usr/src/25/include/asm-generic/tlb.h:111 
 c012b500 128      12.3552     0        0           /usr/src/25/mm/memory.c:341 
 c012b504 108      10.4247     0        0           /usr/src/25/mm/memory.c:341 
 c012b50b 111      10.7143     0        0           /usr/src/25/mm/memory.c:341 
 c012b50e 99       9.55598     0        0           /usr/src/25/mm/memory.c:341 
 c012b511 86       8.30116     0        0           /usr/src/25/mm/memory.c:341 
 c012b51c 4        0.3861      0        0           /usr/src/25/include/asm/thread_info.h:75 
 c012b521 3        0.289575    0        0           /usr/src/25/mm/memory.c:366 
 c012b525 1        0.0965251   0        0           /usr/src/25/mm/memory.c:366 
 c012b526 1        0.0965251   0        0           /usr/src/25/mm/memory.c:366 

So it's a bit of rmap in there.  I'd have to compare with a 2.4
profile and fiddle a few kernel parameters.  But I'm not sure
that munmap of extremely sparsely populated pagtetables is very
interesting?
