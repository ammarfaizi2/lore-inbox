Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261803AbRESNzy>; Sat, 19 May 2001 09:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261805AbRESNzp>; Sat, 19 May 2001 09:55:45 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:28522 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261803AbRESNze>; Sat, 19 May 2001 09:55:34 -0400
Date: Sat, 19 May 2001 15:55:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010519155502.A16482@athlon.random>
In-Reply-To: <20010518214617.A701@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010518214617.A701@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Fri, May 18, 2001 at 09:46:17PM +0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2001 at 09:46:17PM +0400, Ivan Kokshaysky wrote:
> The most interesting thing here is the pyxis "tbia" fix.
> Whee! I can now copy files from SCSI to bus-master IDE, or
> between two IDE drives on separate channels, or do other nice
> things without hanging lx/sx164. :-)
> The pyxis "tbia" turned out to be broken in a more nastier way
> than one could expect - tech details are commented in the patch.
> 
> Another problem, I think, is that we need extra locking in
> pci_unmap_xx(). It seems to be possible that after the scatter-gather
> table "wraps" and some SG ptes get free, these ptes might be
> immediately allocated and next_entry pointer advanced by pci_map_xx()
> from interrupt or another CPU *before* the test for mv_pci_tbi().
> In this case we'd have stale TLB entries.
> 
> Also small compile fix for 2.4.5-pre3.
> 

I fixed the same race condition in the unmap (not flushed pte after
next_entry was visible) two days ago and it's ovbiosuly correct, but it
was not nearly enough here, there was a very nasty other race condition
that triggers at least on all ds10 ds20 es40 tsunami/clibber based
boards that is necessary to fix too to make the machine stable (fixed
yesterday and getting tested today).

Reading the tsunami specs I learnt 1 tlb entry caches 8 pagetables (not 1)
so the tlb flush will be invalidate immediatly by any PCI DMA run after
the flush on any of the other 7 mappings cached in the same tlb entry.


This is the fix:

diff -urN alpha-ref/arch/alpha/kernel/pci_iommu.c
alpha-works/arch/alpha/kernel/pci_iommu.c
--- alpha-ref/arch/alpha/kernel/pci_iommu.c	Sun Apr  1 01:17:07 2001
+++ alpha-works/arch/alpha/kernel/pci_iommu.c	Fri May 18 18:07:40 2001
@@ -69,7 +69,7 @@
 
 	/* Align allocations to a multiple of a page size.  Not needed
 	   unless there are chip bugs.  */
-	arena->align_entry = 1;
+	arena->align_entry = 8;
 
 	return arena;
 }
@@

However thsi is just the production fix, the real fix will only change
that for the tsunami chipset

since I didn't wanted to deal with the optimizations yet I also disabled
the optimizations (I will audit the optimizations shortly). Then I fixed
at least the eppro100 driver to check if it runs of pci map entries (all
drivers out there are broken, they don't check the retval from pci_map*
etc...).

then I also enlarged the pci SG space to 1G beause runing out of entries
right now breaks the whole world:

@@ -358,7 +360,7 @@
 	 * address range.
 	 */
 	hose->sg_isa = iommu_arena_new(hose, 0x00800000, 0x00800000, 0);
-	hose->sg_pci = iommu_arena_new(hose, 0xc0000000, 0x08000000, 0);
+	hose->sg_pci = iommu_arena_new(hose, 0xc0000000, 0x40000000, 0);
 	__direct_map_base = 0x40000000;
 	__direct_map_size = 0x80000000;
 
diff

With all this stuff plus the same fix you posted the es40 8g runs rock
solid on top of 2.4.5pre3aa1.

I was going to wait to cleanup all those fixes but I'm posting this half
curroputed email here now just so we don't duplicate further efforts ;)

Andrea
