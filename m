Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263611AbTDDCAP (for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 21:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263612AbTDDCAP (for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 21:00:15 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:62971 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263611AbTDDB74 (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 20:59:56 -0500
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@digeo.com>, "David S. Miller" <davem@redhat.com>,
       Jes Sorensen <jes@trained-monkey.org>, Ralf Baechle <ralf@gnu.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] flush flush_page_to_ram
References: <Pine.LNX.4.44.0304031741130.2047-100000@localhost.localdomain>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 04 Apr 2003 11:11:10 +0900
In-Reply-To: <Pine.LNX.4.44.0304031741130.2047-100000@localhost.localdomain>
Message-ID: <buo3ckzdnb5.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> writes:
> This patch removes the long deprecated flush_page_to_ram.
...
> All architectures are updated, but the only ones where it amounts
> to more than deleting a line or two are m68k, mips, mips64 and v850.

I recently changed the v850's nb85e_cache.h to make flush_page_to_ram a
nop anyway (however since Linus hasn't applied my patch, I guess you won't
have seen that change ... HEY LINUS, PLEASE APPLY MY PATCHES!  Ahem.).

What's in the old version of nb85e_cache.h is incorrect anyway; until
recently I didn't have any working hardware, so it's basically all just
random cruft.

[To be honest, I'm not sure my new version is correct either -- just
_exactly_* what's expected from these macros is very hard to guess from the
documentation, and only a little more clear from perusing the source --
however it does seem to work in practice, unlike the old version.
* I could just make all of them flush everything, but that's very inefficient.]

> I followed a prescription from DaveM (though not to the letter), that
> those arches with non-nop flush_page_to_ram need to do what it did
> in their clear_user_page and copy_user_page and flush_dcache_page.
> 
> Dave is consterned that, in the v850 nb85e case, this patch leaves its
> flush_dcache_page as was, uses it in clear_user_page and copy_user_page,
> instead of making them all flush icache as well.

The v850 has no MMU, and thus only one address-space, so in these cases,
it's only necessary to make sure the dcache is written back, and clear the
icache (i.e., the dcache needn't be cleared).

However, it seems extra-ordinarily inefficient to do these things on a
per-page basis, as the nb85e hardware only allows one to flush the entire
icache, and doing so takes about 600 cycles!  It would be much better if
one could just wait until after all copying/clearing/whatever had been
done, and then give one big flush command.

My current hardware has a non-working dcache, so I'm only using the
icache at present; anyway, here's the flush routines I'm using now, which
at least seems to work:

   void inline nb85e_cache_flush_all (void)
   {
           clear_icache ();
           clear_dcache ();
   }

   void nb85e_cache_flush_mm (struct mm_struct *mm)
   {
           /* nothing */
   }

   void nb85e_cache_flush_range (struct mm_struct *mm,
                                 unsigned long start, unsigned long end)
   {
           /* nothing */
   }

   void nb85e_cache_flush_page (struct vm_area_struct *vma,
                                unsigned long page_addr)
   {
           /* nothing */
   }

   void nb85e_cache_flush_dcache_page (struct page *page)
   {
           /* nothing */
   }

   void nb85e_cache_flush_icache (void)
   {
           cache_exec_after_store ();
   }

   void nb85e_cache_flush_icache_range (unsigned long start, unsigned long end)
   {
           cache_exec_after_store ();
   }

   void nb85e_cache_flush_icache_page (struct vm_area_struct *vma,
                                       struct page *page)
   {
           cache_exec_after_store ();
   }

   void nb85e_cache_flush_icache_user_range (struct vm_area_struct *vma,
                                             struct page *page,
                                             unsigned long adr, int len)
   {
           cache_exec_after_store ();
   }

   void nb85e_cache_flush_sigtramp (unsigned long addr)
   {
           cache_exec_after_store ();
   }

-Miles
-- 
"Whatever you do will be insignificant, but it is very important that
 you do it."  Mahatma Ghandi
