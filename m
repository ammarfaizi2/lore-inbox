Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154478AbQDHWqX>; Sat, 8 Apr 2000 18:46:23 -0400
Received: by vger.rutgers.edu id <S154322AbQDHWqL>; Sat, 8 Apr 2000 18:46:11 -0400
Received: from colorfullife.com ([216.156.138.34]:3051 "EHLO colorfullife.com") by vger.rutgers.edu with ESMTP id <S154565AbQDHWpe>; Sat, 8 Apr 2000 18:45:34 -0400
Message-ID: <38EFB6B7.F737B82A@colorfullife.com>
Date: Sun, 09 Apr 2000 00:46:15 +0200
From: Manfred Spraul <manfreds@colorfullife.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.2.14 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Kanoj Sarcar <kanoj@google.engr.sgi.com>
Cc: linux-kernel@vger.rutgers.edu, linux-mm@kvack.org
Subject: Re: zap_page_range(): TLB flush race
References: <200004082111.OAA73647@google.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Kanoj Sarcar wrote:
> 
> >
> > it seems we have a smp race in zap_page_range():
> >
> > When we remove a page from the page tables, we must call:
> >
> >       flush_cache_page();
> >       pte_clear();
> >       flush_tlb_page();
> >       free_page();
> >
> > We must not free the page before we have called flush_tlb_xy(),
> > otherwise the second cpu could access memory that already freed.
> >
> > but zap_page_range() calls free_page() before the flush_tlb() call.
> >
> > Is that really a bug, has anyone a good idea how to fix that?
> 
> Why do you think this is a bug? After the pte_clear, we need to flush
> tlb, so that if anyone wants to drag in the mapping (by accessing the
> virtual address), he will fault (since translation is not in tlb) and
> wait on mmap_sem.

Because the second cpu can use a stale tlb entry. We must free the page
_after_ the flush, not before the flush.

Example:
cpu1, cpu2: execute 2 threads from one process.
cpu3: unrelated thread that allocates a new page.

cpu1:
1) writes to one page in a tight loop. The tlb entry won't be discared
by the cpu without an explicit flush.

cpu2:
2) sys_munmap()
* zap_page_range(): calls free_page() for each page in the area.
do_munmap() for a 500 MB block will take a few milliseconds.

cpu3:
3) somewhere: get_free_page(). Now it gets a pointer to a page that cpu1
still writes to.

cpu2:
4) zap_page_range() returns, now the tlb is flushed.

cpu1:
5) received the ipi, the local tlb is flushed, page fault.
* but: cpu1 stomped on the page that was allocated by cpu3.


> 
> But a race does exist in establish_pte(), when the flush_tlb happens
> _before_ the set_pte(), another thread might drag in the old translation
> on a different cpu.
> 

Yes, establish_pte() is broken. We should reverse the calls:

	set_pte(); /* update the kernel page tables */
	update_mmu(); /* update architecture specific page tables. */
	flush_tlb();  /* and flush the hardware tlb */


> > 
> > filemap_sync() calls flush_tlb_page() for each page, but IMHO this is a
> > really bad idea, the performance will suck with multi-threaded apps on
> > SMP.
> 
> The best you can do probably is a flush_tlb_range?

filemap_sync() calls both flush_tlb_range() and flush_tlb_page() on each
page, I just don't know which call I should remove :-/

Btw, I couldn't find an update_mmu_range() function, what's the exact
purpose of update_mmu_cache()? mips64 uses this function.

Can't we merge update_mmu_cache() with flush_tlb_page()?

--
	Manfred


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
