Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154557AbQDHXXo>; Sat, 8 Apr 2000 19:23:44 -0400
Received: by vger.rutgers.edu id <S154385AbQDHXXe>; Sat, 8 Apr 2000 19:23:34 -0400
Received: from sgi.SGI.COM ([192.48.153.1]:22793 "EHLO sgi.com") by vger.rutgers.edu with ESMTP id <S154322AbQDHXXQ>; Sat, 8 Apr 2000 19:23:16 -0400
From: kanoj@google.engr.sgi.com (Kanoj Sarcar)
Message-Id: <200004082331.QAA78522@google.engr.sgi.com>
Subject: Re: zap_page_range(): TLB flush race
To: manfreds@colorfullife.com (Manfred Spraul)
Date: Sat, 8 Apr 2000 16:31:38 -0700 (PDT)
Cc: linux-kernel@vger.rutgers.edu, linux-mm@kvack.org, torvalds@transmeta.com, davem@redhat.com, alan@lxorguk.ukuu.org.uk
In-Reply-To: <38EFB6B7.F737B82A@colorfullife.com> from "Manfred Spraul" at Apr 09, 2000 12:46:15 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

> 
> Kanoj Sarcar wrote:
> > 
> > >
> > > it seems we have a smp race in zap_page_range():
> > >
> > > When we remove a page from the page tables, we must call:
> > >
> > >       flush_cache_page();
> > >       pte_clear();
> > >       flush_tlb_page();
> > >       free_page();
> > >
> > > We must not free the page before we have called flush_tlb_xy(),
> > > otherwise the second cpu could access memory that already freed.
> > >
> > > but zap_page_range() calls free_page() before the flush_tlb() call.
> > >
> > > Is that really a bug, has anyone a good idea how to fix that?
> > 
> > Why do you think this is a bug? After the pte_clear, we need to flush
> > tlb, so that if anyone wants to drag in the mapping (by accessing the
> > virtual address), he will fault (since translation is not in tlb) and
> > wait on mmap_sem.
> 
> Because the second cpu can use a stale tlb entry. We must free the page
> _after_ the flush, not before the flush.
> 
> Example:
> cpu1, cpu2: execute 2 threads from one process.
> cpu3: unrelated thread that allocates a new page.
> 
> cpu1:
> 1) writes to one page in a tight loop. The tlb entry won't be discared
> by the cpu without an explicit flush.
> 
> cpu2:
> 2) sys_munmap()
> * zap_page_range(): calls free_page() for each page in the area.
> do_munmap() for a 500 MB block will take a few milliseconds.
> 
> cpu3:
> 3) somewhere: get_free_page(). Now it gets a pointer to a page that cpu1
> still writes to.
> 
> cpu2:
> 4) zap_page_range() returns, now the tlb is flushed.
> 
> cpu1:
> 5) received the ipi, the local tlb is flushed, page fault.
> * but: cpu1 stomped on the page that was allocated by cpu3.
> 

Yup, you got it, I had forgotten this issue. Btw, a bunch of people are 
aware of the pte handling races in Linux (Linus, Alan, David M etc). In 
fact, around 2.2.10 timeframe, Alan and I did a quick study of such races. 
I posted a patch, we had some conversation, but ultimately we have not 
fixed any of these races. 

If you are interested, you can read a discussion and the patch at
http://reality.sgi.com/kanoj_engr/smppte.patch

The above race that you point out is covered in a somewhat different 
fashion: "1. During munmap, clones should be restricted while the file
pages are being written out to disk, else some writes are not synced
to disk at unmap time."

> 
> > 
> > But a race does exist in establish_pte(), when the flush_tlb happens
> > _before_ the set_pte(), another thread might drag in the old translation
> > on a different cpu.
> > 
> 
> Yes, establish_pte() is broken. We should reverse the calls:
> 
> 	set_pte(); /* update the kernel page tables */
> 	update_mmu(); /* update architecture specific page tables. */
> 	flush_tlb();  /* and flush the hardware tlb */
>

People are aware of this too, it was introduced during the 390 merge. 
I tried talking to the IBM guy about this, I didn't see a response from
him ...

I think what we now need is a critical mass, something that will make us
go "okay, lets just fix these races once and for all".

> 
> > > 
> > > filemap_sync() calls flush_tlb_page() for each page, but IMHO this is a
> > > really bad idea, the performance will suck with multi-threaded apps on
> > > SMP.
> > 
> > The best you can do probably is a flush_tlb_range?
> 
> filemap_sync() calls both flush_tlb_range() and flush_tlb_page() on each
> page, I just don't know which call I should remove :-/

Hmm, this is related to the above race I quoted... see the patch in this
regard.

Kanoj

> 
> Btw, I couldn't find an update_mmu_range() function, what's the exact
> purpose of update_mmu_cache()? mips64 uses this function.
> 
> Can't we merge update_mmu_cache() with flush_tlb_page()?
> 
> --
> 	Manfred
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux.eu.org/Linux-MM/
> 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
