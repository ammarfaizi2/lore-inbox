Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129065AbRBXExU>; Fri, 23 Feb 2001 23:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129108AbRBXExJ>; Fri, 23 Feb 2001 23:53:09 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:36928 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129065AbRBXEwk>; Fri, 23 Feb 2001 23:52:40 -0500
Date: Sat, 24 Feb 2001 05:54:08 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac15
Message-ID: <20010224055408.B32367@athlon.random>
In-Reply-To: <20010223214057.A22808@athlon.random> <Pine.LNX.4.10.10102231306140.21515-100000@penguin.transmeta.com> <20010224050402.A32367@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010224050402.A32367@athlon.random>; from andrea@suse.de on Sat, Feb 24, 2001 at 05:04:02AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This new one should be better. Using the spinlock for the SMP serialization is
ok because that's an extremely slow path.

diff -urN -X /home/andrea/bin/dontdiff 2.4.2/arch/i386/mm/fault.c 2.4.2aa/arch/i386/mm/fault.c
--- 2.4.2/arch/i386/mm/fault.c	Thu Feb 22 03:44:53 2001
+++ 2.4.2aa/arch/i386/mm/fault.c	Sat Feb 24 05:41:11 2001
@@ -326,23 +326,27 @@
 		int offset = __pgd_offset(address);
 		pgd_t *pgd, *pgd_k;
 		pmd_t *pmd, *pmd_k;
+		static spinlock_t lazy_vmalloc_lock = SPIN_LOCK_UNLOCKED;
+		unsigned long flags;
 
 		pgd = tsk->active_mm->pgd + offset;
 		pgd_k = init_mm.pgd + offset;
 
-		if (!pgd_present(*pgd)) {
-			if (!pgd_present(*pgd_k))
-				goto bad_area_nosemaphore;
+		spin_lock_irqsave(&lazy_vmalloc_lock, flags);
+		if (!pgd_present(*pgd) && pgd_present(*pgd_k)) {
 			set_pgd(pgd, *pgd_k);
+			spin_unlock_irqrestore(&lazy_vmalloc_lock, flags);
 			return;
 		}
-
 		pmd = pmd_offset(pgd, address);
 		pmd_k = pmd_offset(pgd_k, address);
 
-		if (pmd_present(*pmd) || !pmd_present(*pmd_k))
-			goto bad_area_nosemaphore;
-		set_pmd(pmd, *pmd_k);
-		return;
+		if (!pmd_present(*pmd) && pmd_present(*pmd_k)) {
+			set_pmd(pmd, *pmd_k);
+			spin_unlock_irqrestore(&lazy_vmalloc_lock, flags);
+			return;
+		}
+		spin_unlock_irqrestore(&lazy_vmalloc_lock, flags);
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


non pae mode is still untested but it should now have a chance to work.

Andrea
