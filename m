Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266365AbRGJOCK>; Tue, 10 Jul 2001 10:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266347AbRGJOBv>; Tue, 10 Jul 2001 10:01:51 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:1222 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S266326AbRGJOBs>; Tue, 10 Jul 2001 10:01:48 -0400
Message-ID: <3B4B0B1F.92EC5C0E@uow.edu.au>
Date: Wed, 11 Jul 2001 00:03:11 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: msync() bug
In-Reply-To: <20010709170835.J1594@athlon.random> <20010711012524.A31799@weta.f00f.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> 
> (cc' list snipped)
> 
> This stuff is gold.
> 
> Anyone clueful want to comment things so this will end up in the
> documentation when you do a make docbook or something?
> 

One can but try.

Linus included the test for non-null page->mapping
as well.  I wonder why.

Also, the change means that the TLB flush is not performed
for invalid or reserved pages.  Is this correct?  (Why is there
a TLB flush there in the first place?)

There's a flush_tlb_range() down in filemap_sync() as well, so
we appear to end up flushing the affected TLBs twice?


--- linux-2.4.7-pre5/mm/memory.c	Tue Jul 10 22:32:53 2001
+++ linux-akpm/mm/memory.c	Tue Jul 10 23:37:45 2001
@@ -766,6 +766,8 @@ int zeromap_page_range(unsigned long add
  * maps a range of physical memory into the requested pages. the old
  * mappings are removed. any references to nonexistent pages results
  * in null mappings (currently treated as "copy-on-access")
+ * We forbid mapping of valid, unreserved pages because that would
+ * allow corruption of their reference counts via this additional mapping.
  */
 static inline void remap_pte_range(pte_t * pte, unsigned long address, unsigned long size,
 	unsigned long phys_addr, pgprot_t prot)
--- linux-2.4.7-pre5/mm/filemap.c	Tue Jul 10 22:32:53 2001
+++ linux-akpm/mm/filemap.c	Tue Jul 10 23:45:28 2001
@@ -1643,6 +1643,8 @@ page_not_uptodate:
 
 /* Called with mm->page_table_lock held to protect against other
  * threads/the swapper from ripping pte's out from under us.
+ * Mappings from remap_pte_range() can cover invalid or reserved
+ * pages, so we must check for that here.
  */
 static inline int filemap_sync_pte(pte_t * ptep, struct vm_area_struct *vma,
 	unsigned long address, unsigned int flags)
