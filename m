Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266117AbUIAKHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266117AbUIAKHO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 06:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265970AbUIAKG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 06:06:56 -0400
Received: from verein.lst.de ([213.95.11.210]:59272 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S265930AbUIAKCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 06:02:30 -0400
Date: Wed, 1 Sep 2004 12:02:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove ptrinfo
Message-ID: <20040901100223.GA23951@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it's defined in slab.c but not used anywhere


--- 1.34/include/linux/slab.h	2004-09-01 06:07:01 +02:00
+++ edited/include/linux/slab.h	2004-09-01 11:14:11 +02:00
@@ -117,8 +117,6 @@
 extern kmem_cache_t	*sighand_cachep;
 extern kmem_cache_t	*bio_cachep;
 
-void ptrinfo(unsigned long addr);
-
 extern atomic_t slab_reclaim_pages;
 
 #endif	/* __KERNEL__ */
--- 1.144/mm/slab.c	2004-08-27 22:24:14 +02:00
+++ edited/mm/slab.c	2004-09-01 11:14:11 +02:00
@@ -3023,73 +3024,4 @@
 	}
 
 	return size;
-}
-
-void ptrinfo(unsigned long addr)
-{
-	struct page *page;
-
-	printk("Dumping data about address %p.\n", (void*)addr);
-	if (!virt_addr_valid((void*)addr)) {
-		printk("virt addr invalid.\n");
-		return;
-	}
-#ifdef CONFIG_MMU
-	do {
-		pgd_t *pgd = pgd_offset_k(addr);
-		pmd_t *pmd;
-		if (pgd_none(*pgd)) {
-			printk("No pgd.\n");
-			break;
-		}
-		pmd = pmd_offset(pgd, addr);
-		if (pmd_none(*pmd)) {
-			printk("No pmd.\n");
-			break;
-		}
-#ifdef CONFIG_X86
-		if (pmd_large(*pmd)) {
-			printk("Large page.\n");
-			break;
-		}
-#endif
-		printk("normal page, pte_val 0x%llx\n",
-		  (unsigned long long)pte_val(*pte_offset_kernel(pmd, addr)));
-	} while(0);
-#endif
-
-	page = virt_to_page((void*)addr);
-	printk("struct page at %p, flags %08lx\n",
-			page, (unsigned long)page->flags);
-	if (PageSlab(page)) {
-		kmem_cache_t *c;
-		struct slab *s;
-		unsigned long flags;
-		int objnr;
-		void *objp;
-
-		c = GET_PAGE_CACHE(page);
-		printk("belongs to cache %s.\n",c->name);
-
-		spin_lock_irqsave(&c->spinlock, flags);
-		s = GET_PAGE_SLAB(page);
-		printk("slabp %p with %d inuse objects (from %d).\n",
-			s, s->inuse, c->num);
-		check_slabp(c,s);
-
-		objnr = (addr-(unsigned long)s->s_mem)/c->objsize;
-		objp = s->s_mem+c->objsize*objnr;
-		printk("points into object no %d, starting at %p, len %d.\n",
-			objnr, objp, c->objsize);
-		if (objnr >= c->num) {
-			printk("Bad obj number.\n");
-		} else {
-			kernel_map_pages(virt_to_page(objp),
-					c->objsize/PAGE_SIZE, 1);
-
-			print_objinfo(c, objp, 2);
-		}
-		spin_unlock_irqrestore(&c->spinlock, flags);
-
-	}
 }
