Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154703AbQDIJIM>; Sun, 9 Apr 2000 05:08:12 -0400
Received: by vger.rutgers.edu id <S154699AbQDIJHw>; Sun, 9 Apr 2000 05:07:52 -0400
Received: from colorfullife.com ([216.156.138.34]:3107 "EHLO colorfullife.com") by vger.rutgers.edu with ESMTP id <S154695AbQDIJHi>; Sun, 9 Apr 2000 05:07:38 -0400
Message-ID: <38F048F5.1FABC033@colorfullife.com>
Date: Sun, 09 Apr 2000 11:10:13 +0200
From: Manfred Spraul <manfreds@colorfullife.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.2.14 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kanoj Sarcar <kanoj@google.engr.sgi.com>, linux-kernel@vger.rutgers.edu, linux-mm@kvack.org, torvalds@transmeta.com, davem@redhat.com
Subject: Re: zap_page_range(): TLB flush race
References: <E12e4mo-0003Pn-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Alan Cox wrote:
> 
> 
> Basically establish_pte() has to be architecture specific, as some processors
> need different orders either to avoid races or to handle cpu specific
> limitations.
> 
I don't know: IMHO we have far to many architecture specific functions
in that area:

set_pte()
establish_pte()

flush_tlb()
update_mmu_cache();
flush_cache();
flush_icache();

Can't we merge them? 

<< 1)
set_pte(vma,pte,new_val);
	* flushes the cache, changes one pte, updates the tlb.
<< 2)
set_pte_new(vma,pte,new_val);
	* sets the pte, the old value was non-present. Most cpu
	  don't need to flush the tlb. (2.3.99 never flushes the tlb)
<< 3)
prepare_ptechange_{range,mm}(vma,start,end);
for()
	__set_pte(vma,pte,new_val);
commit_ptechange_{range,mm}(vma,start,end);
	*  should be used if you change multiple pages.
<<<<<<<<<
	
I don't understand the purpose of flush_page_to_ram():
filemap_sync_pte() calls it if MS_INVALIDATE is not set, it's not called
if MS_INVALIDATE is set.
In both cases, the kernel pointer is accessed in filemap_write_page().

--
	Manfred


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
