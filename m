Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154268AbQDJXXa>; Mon, 10 Apr 2000 19:23:30 -0400
Received: by vger.rutgers.edu id <S154414AbQDJXXB>; Mon, 10 Apr 2000 19:23:01 -0400
Received: from [216.101.162.242] ([216.101.162.242]:34266 "EHLO pizda.ninka.net") by vger.rutgers.edu with ESMTP id <S154469AbQDJXTO>; Mon, 10 Apr 2000 19:19:14 -0400
Date: Mon, 10 Apr 2000 16:12:18 -0700
Message-Id: <200004102312.QAA05115@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: sct@redhat.com
Cc: alan@lxorguk.ukuu.org.uk, kanoj@google.engr.sgi.com, manfreds@colorfullife.com, linux-kernel@vger.rutgers.edu, linux-mm@kvack.org, torvalds@transmeta.com
In-reply-to: <20000410232149.M17648@redhat.com> (sct@redhat.com)
Subject: Re: zap_page_range(): TLB flush race
References: <200004082331.QAA78522@google.engr.sgi.com> <E12e4mo-0003Pn-00@the-village.bc.nu> <20000410232149.M17648@redhat.com>
Sender: owner-linux-kernel@vger.rutgers.edu

   Date: Mon, 10 Apr 2000 23:21:49 +0100
   From: "Stephen C. Tweedie" <sct@redhat.com>

   On Sun, Apr 09, 2000 at 12:37:05AM +0100, Alan Cox wrote:
   > 
   > Basically establish_pte() has to be architecture specific, as some processors
   > need different orders either to avoid races or to handle cpu specific
   > limitations.

   What exactly do different architectures need which set_pte() doesn't 
   already allow them to do magic in?  

Doing a properly synchronized PTE update and Cache/TLB flush when the
mapping can exist on multiple processors is not most efficiently done
if we take some generic setup.

The idea is that if we encapsulate the "flush_cache; set_pte;
flush_tlb" operations into a single arch-specific routine, the
implementation can then implement the most efficient solution possible
to this SMP problem.

For example, the fastest way to atomically update an existing PTE on
an SMP system using a software TLB miss scheme is wildly different
from that on an SMP system using a hardware replaced TLB.

For example, with a software TLB miss scheme it might be something
like this:

	establish_pte() {
		capture_cpus(mm->cpu_vm_mask);
		everybody_flush_cache_page(mm->cpu_vm_mask, ...);
		atomic_set_pte(ptep, entry);
		everybody_flush_tlb_page(mm->cpu_vm_mask, ...);
		release_cpus(mm->cpu_vm_mask);
	}

With the obvious important optimizations for when mm->count is one,
etc.

The other case is when we are checking the dirty status of a pte
in vmscan, something similar is needed there as well:

	pte_t atomic_pte_check_dirty() {
		capture_cpus(mm->cpu_vm_mask);
		entry = *ptep;
		if (pte_dirty(entry)) {
			everybody_flush_cache_page(mm->cpu_vm_mask, ...);
			pte_clear(ptep);
			everybody_flush_tlb_page(mm->cpu_vm_mask, ...);
		}
		release_cpus(mm->cpu_vm_mask);
		return entry;
	}

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
