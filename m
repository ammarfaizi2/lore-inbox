Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261346AbSLHQif>; Sun, 8 Dec 2002 11:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261354AbSLHQif>; Sun, 8 Dec 2002 11:38:35 -0500
Received: from 5-106.ctame701-1.telepar.net.br ([200.193.163.106]:16333 "EHLO
	5-106.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261346AbSLHQie>; Sun, 8 Dec 2002 11:38:34 -0500
Date: Sun, 8 Dec 2002 14:45:38 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Anton Blanchard <anton@samba.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.50-BK + 24 CPUs
In-Reply-To: <Pine.LNX.4.50L.0212081246570.21756-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.50L.0212081444350.21756-100000@imladris.surriel.com>
References: <20021208130908.GE19698@krispykreme>
 <Pine.LNX.4.50L.0212081246570.21756-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Dec 2002, Rik van Riel wrote:
> On Mon, 9 Dec 2002, Anton Blanchard wrote:
>
> > profile:
> >  66260 total
> >  54227 cpu_idle
> >   1000 page_remove_rmap
> >    909 __get_page_state
> >    830 page_add_rmap
>
> Looks like the bitflag locking in rmap is hurting you.
> How does it work with a real spinlock in the struct page
> instead of using a bit in page->flags ?

In particular, something like the (completely untested) patch
below.  Yes, this patch is on the wrong side of the space/time
tradeoff for machines with highmem, but it might be worth it
for 64 bit machines, especially those with slow bitops.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>


===== include/linux/mm.h 1.97 vs edited =====
--- 1.97/include/linux/mm.h	Thu Nov  7 08:48:53 2002
+++ edited/include/linux/mm.h	Sun Dec  8 14:36:44 2002
@@ -169,6 +169,7 @@
 					 * protected by PG_chainlock */
 		pte_addr_t direct;
 	} pte;
+	spinlock_t ptechain_lock;	/* Lock for pte.chain and pte.direct */
 	unsigned long private;		/* mapping-private opaque data */

 	/*
===== include/linux/rmap-locking.h 1.1 vs edited =====
--- 1.1/include/linux/rmap-locking.h	Sun Sep  1 17:56:32 2002
+++ edited/include/linux/rmap-locking.h	Sun Dec  8 14:37:49 2002
@@ -14,20 +14,10 @@
 	 * busywait with less bus contention for a good time to
 	 * attempt to acquire the lock bit.
 	 */
-	preempt_disable();
-#ifdef CONFIG_SMP
-	while (test_and_set_bit(PG_chainlock, &page->flags)) {
-		while (test_bit(PG_chainlock, &page->flags))
-			cpu_relax();
-	}
-#endif
+	spin_lock(&page->ptechain_lock);
 }

 static inline void pte_chain_unlock(struct page *page)
 {
-#ifdef CONFIG_SMP
-	smp_mb__before_clear_bit();
-	clear_bit(PG_chainlock, &page->flags);
-#endif
-	preempt_enable();
+	spin_unlock(&page->ptechain_lock);
 }
===== mm/page_alloc.c 1.135 vs edited =====
--- 1.135/mm/page_alloc.c	Mon Dec  2 18:31:01 2002
+++ edited/mm/page_alloc.c	Sun Dec  8 14:39:06 2002
@@ -1129,6 +1129,7 @@
 			struct page *page = lmem_map + local_offset + i;
 			set_page_zone(page, nid * MAX_NR_ZONES + j);
 			set_page_count(page, 0);
+			page->ptechain_lock = SPIN_LOCK_UNLOCKED;
 			SetPageReserved(page);
 			INIT_LIST_HEAD(&page->list);
 #ifdef WANT_PAGE_VIRTUAL
