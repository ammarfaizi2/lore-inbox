Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288005AbSAHMqd>; Tue, 8 Jan 2002 07:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288007AbSAHMqY>; Tue, 8 Jan 2002 07:46:24 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:51217 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S288005AbSAHMqL>;
	Tue, 8 Jan 2002 07:46:11 -0500
Date: Tue, 8 Jan 2002 10:45:52 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: <linux-mm@kvack.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH *] rmap based VM  #11a
Message-ID: <Pine.LNX.4.33L.0201081045030.872-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The first maintenance release of the 11th version of the reverse
mapping based VM is now available. It fixes agpgart_be and the
OOM killer. Tests on diskless machines are especially appreciated.

This is an attempt at making a more robust and flexible VM
subsystem, while cleaning up a lot of code at the same time.
The patch is available from:

           http://surriel.com/patches/2.4/2.4.17-rmap-11a
and        http://linuxvm.bkbits.net/


My big TODO items for a next release are:
  - fix page_launder() so it doesn't submit the whole
    inactive_dirty list for writeout in one go

rmap 11a:
  - don't let refill_inactive() progress count for OOM    (me)
  - after an OOM kill, wait 5 seconds for the next kill   (me)
  - agpgart_be fix for hashed waitqueues                  (William Lee Irwin)
rmap 11:
  - fix stupid logic inversion bug in wakeup_kswapd()     (Andrew Morton)
  - fix it again in the morning                           (me)
  - add #ifdef BROKEN_PPC_PTE_ALLOC_ONE to rmap.h, it
    seems PPC calls pte_alloc() before mem_map[] init     (me)
  - disable the debugging code in rmap.c ... the code
    is working and people are running benchmarks          (me)
  - let the slab cache shrink functions return a value
    to help prevent early OOM killing                     (Ed Tomlinson)
  - also, don't call the OOM code if we have enough
    free pages                                            (me)
  - move the call to lru_cache_del into __free_pages_ok   (Ben LaHaise)
  - replace the per-page waitqueue with a hashed
    waitqueue, reduces size of struct page from 64
    bytes to 52 bytes (48 bytes on non-highmem machines)  (William Lee Irwin)
rmap 10:
  - fix the livelock for real (yeah right), turned out
    to be a stupid bug in page_launder_zone()             (me)
  - to make sure the VM subsystem doesn't monopolise
    the CPU, let kswapd and some apps sleep a bit under
    heavy stress situations                               (me)
  - let __GFP_HIGH allocations dig a little bit deeper
    into the free page pool, the SCSI layer seems fragile (me)
rmap 9:
  - improve comments all over the place                   (Michael Cohen)
  - don't panic if page_remove_rmap() cannot find the
    rmap in question, it's possible that the memory was
    PG_reserved and belonging to a driver, but the driver
    exited and cleared the PG_reserved bit                (me)
  - fix the VM livelock by replacing > by >= in a few
    critical places in the pageout code                   (me)
  - treat the reclaiming of an inactive_clean page like
    allocating a new page, calling try_to_free_pages()
    and/or fixup_freespace() if required                  (me)
  - when low on memory, don't make things worse by
    doing swapin_readahead                                (me)
rmap 8:
  - add ANY_ZONE to the balancing functions to improve
    kswapd's balancing a bit                              (me)
  - regularize some of the maximum loop bounds in
    vmscan.c for cosmetic purposes                        (William Lee Irwin)
  - move page_address() to architecture-independent
    code, now the removal of page->virtual is portable    (William Lee Irwin)
  - speed up free_area_init_core() by doing a single
    pass over the pages and not using atomic ops          (William Lee Irwin)
  - documented the buddy allocator in page_alloc.c        (William Lee Irwin)
rmap 7:
  - clean up and document vmscan.c                        (me)
  - reduce size of page struct, part one                  (William Lee Irwin)
  - add rmap.h for other archs (untested, not for ARM)    (me)
rmap 6:
  - make the active and inactive_dirty list per zone,
    this is finally possible because we can free pages
    based on their physical address                       (William Lee Irwin)
  - cleaned up William's code a bit                       (me)
  - turn some defines into inlines and move those to
    mm_inline.h (the includes are a mess ...)             (me)
  - improve the VM balancing a bit                        (me)
  - add back inactive_target to /proc/meminfo             (me)
rmap 5:
  - fixed recursive buglet, introduced by directly
    editing the patch for making rmap 4 ;)))              (me)
rmap 4:
  - look at the referenced bits in page tables            (me)
rmap 3:
  - forgot one FASTCALL definition                        (me)
rmap 2:
  - teach try_to_unmap_one() about mremap()               (me)
  - don't assign swap space to pages with buffers         (me)
  - make the rmap.c functions FASTCALL / inline           (me)
rmap 1:
  - fix the swap leak in rmap 0                           (Dave McCracken)
rmap 0:
  - port of reverse mapping VM to 2.4.16                  (me)

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

