Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129134AbRBWUpc>; Fri, 23 Feb 2001 15:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137169AbRBWUk2>; Fri, 23 Feb 2001 15:40:28 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:25631 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132252AbRBWUj0>; Fri, 23 Feb 2001 15:39:26 -0500
Date: Fri, 23 Feb 2001 21:40:57 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac15
Message-ID: <20010223214057.A22808@athlon.random>
In-Reply-To: <971tdk$10p$1@penguin.transmeta.com> <E14Vt0b-0003qo-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E14Vt0b-0003qo-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Feb 22, 2001 at 10:29:58AM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2001 at 10:29:58AM +0000, Alan Cox wrote:
> > >We can take page faults in interrupt handlers in 2.4 so I had to use a 
> > >spinlock, but that sounds the same
> > 
> > Umm? The above doesn't really make sense.
> > 
> > We can take a page fault on the kernel region with the lazy page
> > directory filling, but that code will just set the PGD entry and exit
> > without taking any lock at all. So it basically ends up being an
> > "invisible" event.
> 
> Its only normally invisible. Mark Hemment pointed out there is currently a
> race where if both cpus go to fill in the same entry the logic goes
> 
> 	CPU1					CPU2
> 
> 	pgd present 				pgd present
> 	pmd not present
> 	load pmd
> 						pmd present
> 						Explode messily
> 

I think that can't happen. Infact I think the whole section:

		pmd = pmd_offset(pgd, address);
		pmd_k = pmd_offset(pgd_k, address);

		if (pmd_present(*pmd) || !pmd_present(*pmd_k))
			goto bad_area_nosemaphore;
		set_pmd(pmd, *pmd_k);
		return;

is superflows.

The middle pagetable is shared and the pmd_t entry is set by vmalloc itself (it
just points to the as well shared pte), it's only the pgd that is setup lazily
to simplify the locking (locking is simplified of an order of magnitude because
for example in set_64bit we don't need the lock on the bus but we just need to
do the 64bit move in a single instruction so we can't be interrupted in the
middle by an irq and all sort of similar issues that now becomes serialized
inside the local CPU).

So in short unless I'm misreading something I think all the vmalloc faults will
be handled by the:

		if (!pgd_present(*pgd)) {
			if (!pgd_present(*pgd_k))
				goto bad_area_nosemaphore;
			set_pgd(pgd, *pgd_k);
			return;
		}

Said that there are a couple of other issues with the vmalloc pgd lazy handling
but nothing specific to SMP or threads.

1) we can triple fault (page_fault -> irq -> vmalloc fault -> irq -> vmalloc fault)
   and I'm not sure if the cpu will reset after that because the three faults are interleaved
   with two irq exceptions, and it's not so easy to find the answer empirically, and
   the documentation doesn't specify that apparently. If it resets (it shouldn't if the
   cpu was well designed) then the whole vmalloc lazy design will be hardly fixable.

2) we could race with irqs locally to the CPU this way during the vmalloc handler:

	irq handler
	vmalloc_fault

	nested irq_handler
	vmalloc fault
	pgd is not present
	set_pgd
	iret

	pgd is present
	enter the pmd business and find the pmd is just set
	goto error

   and I suspect this is actually the bug triggered by Mark.

3) offtopic with the vmalloc thing but I also noticed in some place during the
   pgd/pmd/pte allocations we re-check that nobody mapped in the pagetable from
   under us. But in 2.4 we don't hold the big lock so sleeping or not sleeping during
   allocations is meaningless w.r.t. serialization, we rely only the semaphore
   and on the fact other tasks can't play with our pagetables (one of the reason
   dropping set_pgdir simplifys the locking).

So I did this patch that should be the correct cure for the vmalloc pgd irq race (2)
and that drops a few double checks that seems unnecessary (2) and hopefully (1)
is not an issue and the cpu is smart enough to understand it must not hard
reset:

diff -urN -X /home/andrea/bin/dontdiff 2.4.2/arch/i386/mm/fault.c 2.4.2aa/arch/i386/mm/fault.c
--- 2.4.2/arch/i386/mm/fault.c	Thu Feb 22 03:44:53 2001
+++ 2.4.2aa/arch/i386/mm/fault.c	Fri Feb 23 21:15:53 2001
@@ -326,23 +326,19 @@
 		int offset = __pgd_offset(address);
 		pgd_t *pgd, *pgd_k;
 		pmd_t *pmd, *pmd_k;
+		unsigned long flags;
 
 		pgd = tsk->active_mm->pgd + offset;
 		pgd_k = init_mm.pgd + offset;
 
-		if (!pgd_present(*pgd)) {
-			if (!pgd_present(*pgd_k))
-				goto bad_area_nosemaphore;
+		__save_flags(flags);
+		__cli();
+		if (!pgd_present(*pgd) && pgd_present(*pgd_k)) {
 			set_pgd(pgd, *pgd_k);
+			__restore_flags(flags);
 			return;
 		}
-
-		pmd = pmd_offset(pgd, address);
-		pmd_k = pmd_offset(pgd_k, address);
-
-		if (pmd_present(*pmd) || !pmd_present(*pmd_k))
-			goto bad_area_nosemaphore;
-		set_pmd(pmd, *pmd_k);
-		return;
+		__restore_flags(flags);
+		goto bad_area_nosemaphore;
 	}
 }
diff -urN -X /home/andrea/bin/dontdiff 2.4.2/arch/i386/mm/init.c 2.4.2aa/arch/i386/mm/init.c
--- 2.4.2/arch/i386/mm/init.c	Sat Feb 10 02:34:03 2001
+++ 2.4.2aa/arch/i386/mm/init.c	Fri Feb 23 19:09:25 2001
@@ -116,21 +116,13 @@
 	pte_t *pte;
 
 	pte = (pte_t *) __get_free_page(GFP_KERNEL);
-	if (pmd_none(*pmd)) {
-		if (pte) {
-			clear_page(pte);
-			set_pmd(pmd, __pmd(_KERNPG_TABLE + __pa(pte)));
-			return pte + offset;
-		}
-		set_pmd(pmd, __pmd(_KERNPG_TABLE + __pa(get_bad_pte_table())));
-		return NULL;
+	if (pte) {
+		clear_page(pte);
+		set_pmd(pmd, __pmd(_KERNPG_TABLE + __pa(pte)));
+		return pte + offset;
 	}
-	free_page((unsigned long)pte);
-	if (pmd_bad(*pmd)) {
-		__handle_bad_pmd_kernel(pmd);
-		return NULL;
-	}
-	return (pte_t *) pmd_page(*pmd) + offset;
+	set_pmd(pmd, __pmd(_KERNPG_TABLE + __pa(get_bad_pte_table())));
+	return NULL;
 }
 
 pte_t *get_pte_slow(pmd_t *pmd, unsigned long offset)
diff -urN -X /home/andrea/bin/dontdiff 2.4.2/include/asm-i386/pgalloc-3level.h 2.4.2aa/include/asm-i386/pgalloc-3level.h
--- 2.4.2/include/asm-i386/pgalloc-3level.h	Fri Dec  3 20:12:23 1999
+++ 2.4.2aa/include/asm-i386/pgalloc-3level.h	Fri Feb 23 19:03:14 2001
@@ -53,12 +53,9 @@
 		if (!page)
 			page = get_pmd_slow();
 		if (page) {
-			if (pgd_none(*pgd)) {
-				set_pgd(pgd, __pgd(1 + __pa(page)));
-				__flush_tlb();
-				return page + address;
-			} else
-				free_pmd_fast(page);
+			set_pgd(pgd, __pgd(1 + __pa(page)));
+			__flush_tlb();
+			return page + address;
 		} else
 			return NULL;
 	}
	


The above isn't well tested, I only did a PAE kernel compile and checked it
boots and I can insmod and run the code of some basic module.

Andrea
