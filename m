Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263985AbTJFF3c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 01:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263984AbTJFF3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 01:29:32 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:49609 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263987AbTJFF3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 01:29:21 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][v850]  Move `ptrinfo' function from mm/slab.c to mm/memory.c
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20031006052905.2481A3732@mcspd15.ucom.lsi.nec.co.jp>
Date: Mon,  6 Oct 2003 14:29:05 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

This function doesn't compile on non-MMU systems, so put it in a place
where it won't cause problems (mm/memory.c is only compiled if
CONFIG_MMU is defined).

diff -ruN -X../cludes linux-2.6.0-test6-moo/mm/memory.c linux-2.6.0-test6-moo-v850-20031006/mm/memory.c
--- linux-2.6.0-test6-moo/mm/memory.c	2003-09-29 13:19:22.000000000 +0900
+++ linux-2.6.0-test6-moo-v850-20031006/mm/memory.c	2003-10-06 14:07:08.000000000 +0900
@@ -1685,3 +1685,76 @@
 	}
 	return page;
 }
+
+void ptrinfo(unsigned long addr)
+{
+	struct page *page;
+
+	printk("Dumping data about address %p.\n", (void*)addr);
+	if (!virt_addr_valid((void*)addr)) {
+		printk("virt addr invalid.\n");
+		return;
+	}
+	do {
+		pgd_t *pgd = pgd_offset_k(addr);
+		pmd_t *pmd;
+		if (pgd_none(*pgd)) {
+			printk("No pgd.\n");
+			break;
+		}
+		pmd = pmd_offset(pgd, addr);
+		if (pmd_none(*pmd)) {
+			printk("No pmd.\n");
+			break;
+		}
+#ifdef CONFIG_X86
+		if (pmd_large(*pmd)) {
+			printk("Large page.\n");
+			break;
+		}
+#endif
+		printk("normal page, pte_val 0x%llx\n",
+		  (unsigned long long)pte_val(*pte_offset_kernel(pmd, addr)));
+	} while(0);
+
+	page = virt_to_page((void*)addr);
+	printk("struct page at %p, flags %lxh.\n", page, page->flags);
+	if (PageSlab(page)) {
+		kmem_cache_t *c;
+		struct slab *s;
+		unsigned long flags;
+		int objnr;
+		void *objp;
+
+		c = GET_PAGE_CACHE(page);
+		printk("belongs to cache %s.\n",c->name);
+
+		spin_lock_irqsave(&c->spinlock, flags);
+		s = GET_PAGE_SLAB(page);
+		printk("slabp %p with %d inuse objects (from %d).\n",
+			s, s->inuse, c->num);
+		check_slabp(c,s);
+
+		objnr = (addr-(unsigned long)s->s_mem)/c->objsize;
+		objp = s->s_mem+c->objsize*objnr;
+		printk("points into object no %d, starting at %p, len %d.\n",
+			objnr, objp, c->objsize);
+		if (objnr >= c->num) {
+			printk("Bad obj number.\n");
+		} else {
+			kernel_map_pages(virt_to_page(objp),
+					c->objsize/PAGE_SIZE, 1);
+
+			if (c->flags & SLAB_RED_ZONE)
+				printk("redzone: 0x%lx/0x%lx.\n",
+					*dbg_redzone1(c, objp),
+					*dbg_redzone2(c, objp));
+
+			if (c->flags & SLAB_STORE_USER)
+				printk("Last user: %p.\n",
+					*dbg_userword(c, objp));
+		}
+		spin_unlock_irqrestore(&c->spinlock, flags);
+
+	}
+}
diff -ruN -X../cludes linux-2.6.0-test6-moo/mm/slab.c linux-2.6.0-test6-moo-v850-20031006/mm/slab.c
--- linux-2.6.0-test6-moo/mm/slab.c	2003-09-29 13:19:22.000000000 +0900
+++ linux-2.6.0-test6-moo-v850-20031006/mm/slab.c	2003-10-03 16:53:56.000000000 +0900
@@ -2739,76 +2739,3 @@
 
 	return size;
 }
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
-
-	page = virt_to_page((void*)addr);
-	printk("struct page at %p, flags %lxh.\n", page, page->flags);
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
-			if (c->flags & SLAB_RED_ZONE)
-				printk("redzone: 0x%lx/0x%lx.\n",
-					*dbg_redzone1(c, objp),
-					*dbg_redzone2(c, objp));
-
-			if (c->flags & SLAB_STORE_USER)
-				printk("Last user: %p.\n",
-					*dbg_userword(c, objp));
-		}
-		spin_unlock_irqrestore(&c->spinlock, flags);
-
-	}
-}
