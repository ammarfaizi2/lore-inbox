Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130338AbRBZRJn>; Mon, 26 Feb 2001 12:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130342AbRBZRJd>; Mon, 26 Feb 2001 12:09:33 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:16144 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130338AbRBZRJ2>; Mon, 26 Feb 2001 12:09:28 -0500
Date: Mon, 26 Feb 2001 18:10:49 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rico Tudor <rico@patrec.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 64GB option broken in 2.4.2
Message-ID: <20010226181049.G29254@athlon.random>
In-Reply-To: <E14XCWa-0000Hc-00@the-village.bc.nu> <20010226084403.10459.qmail@pc7.prs.nunet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010226084403.10459.qmail@pc7.prs.nunet.net>; from rico@patrec.com on Mon, Feb 26, 2001 at 02:44:03AM -0600
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2001 at 02:44:03AM -0600, Rico Tudor wrote:
> > Hypthesis#2 The bounce buffer code in the Linus tree is known to be
> > imperfect. Does 2.4.2ac3 do the same ?
> > 
> No improvement.  (In fact, 2.4.2ac3 breaks 3ware IDE RAID support.)

The highmem changes in 2.4.2ac3 has a couple of bugs, one relevant 
that can generate deadlocks (re-enable interrupts with io_request_lock
acquired).

Then the fix isn't complete, for example it doesn't unplug the queue while
waiting I/O completion (we wait the emergency pool to be refilled at I/O
completion).

Can you try this patch against official 2.4.2 and see if you can deadlock
again? If you can please try SYSRQ+P and SYSRQ+T and send resolved traces.

Thanks.

diff -urN -X /home/andrea/bin/dontdiff 2.4.2/arch/i386/config.in 2.4.2-bounce/arch/i386/config.in
--- 2.4.2/arch/i386/config.in	Sat Feb 10 02:34:03 2001
+++ 2.4.2-bounce/arch/i386/config.in	Mon Feb 26 17:22:27 2001
@@ -366,4 +366,7 @@
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+if [ "$CONFIG_HIGHMEM" = "y" ]; then
+   bool 'Debug HIGHMEM on lowmem machines' CONFIG_HIGHMEM_DEBUG
+fi
 endmenu
diff -urN -X /home/andrea/bin/dontdiff 2.4.2/arch/i386/kernel/setup.c 2.4.2-bounce/arch/i386/kernel/setup.c
--- 2.4.2/arch/i386/kernel/setup.c	Thu Feb 22 03:44:53 2001
+++ 2.4.2-bounce/arch/i386/kernel/setup.c	Mon Feb 26 17:23:50 2001
@@ -648,7 +648,19 @@
  */
 #define VMALLOC_RESERVE	(unsigned long)(128 << 20)
 #define MAXMEM		(unsigned long)(-PAGE_OFFSET-VMALLOC_RESERVE)
+#ifdef CONFIG_HIGHMEM_DEBUG
+#define MAXMEM_PFN				\
+({						\
+	int __max_pfn;				\
+	if (max_pfn > PFN_DOWN(MAXMEM))		\
+	     __max_pfn = PFN_DOWN(MAXMEM);	\
+	else					\
+	     __max_pfn = max_pfn / 2;		\
+	__max_pfn;				\
+})
+#else
 #define MAXMEM_PFN	PFN_DOWN(MAXMEM)
+#endif
 #define MAX_NONPAE_PFN	(1 << 20)
 
 	/*
diff -urN -X /home/andrea/bin/dontdiff 2.4.2/arch/i386/mm/fault.c 2.4.2-bounce/arch/i386/mm/fault.c
--- 2.4.2/arch/i386/mm/fault.c	Thu Feb 22 03:44:53 2001
+++ 2.4.2-bounce/arch/i386/mm/fault.c	Mon Feb 26 16:28:42 2001
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
diff -urN -X /home/andrea/bin/dontdiff 2.4.2/arch/i386/mm/init.c 2.4.2-bounce/arch/i386/mm/init.c
--- 2.4.2/arch/i386/mm/init.c	Sat Feb 10 02:34:03 2001
+++ 2.4.2-bounce/arch/i386/mm/init.c	Mon Feb 26 16:28:42 2001
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
diff -urN -X /home/andrea/bin/dontdiff 2.4.2/fs/buffer.c 2.4.2-bounce/fs/buffer.c
--- 2.4.2/fs/buffer.c	Thu Feb 22 03:45:09 2001
+++ 2.4.2-bounce/fs/buffer.c	Mon Feb 26 03:15:55 2001
@@ -762,7 +762,12 @@
 	balance_dirty(NODEV);
 	if (free_shortage())
 		page_launder(GFP_BUFFER, 0);
-	grow_buffers(size);
+	if (!grow_buffers(size)) {
+		wakeup_bdflush(1);
+		current->policy |= SCHED_YIELD;
+		__set_current_state(TASK_RUNNING);
+		schedule();
+	}
 }
 
 void init_buffer(struct buffer_head *bh, bh_end_io_t *handler, void *private)
diff -urN -X /home/andrea/bin/dontdiff 2.4.2/include/asm-i386/pgalloc-3level.h 2.4.2-bounce/include/asm-i386/pgalloc-3level.h
--- 2.4.2/include/asm-i386/pgalloc-3level.h	Fri Dec  3 20:12:23 1999
+++ 2.4.2-bounce/include/asm-i386/pgalloc-3level.h	Mon Feb 26 16:28:42 2001
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
diff -urN -X /home/andrea/bin/dontdiff 2.4.2/mm/highmem.c 2.4.2-bounce/mm/highmem.c
--- 2.4.2/mm/highmem.c	Thu Dec 14 22:34:14 2000
+++ 2.4.2-bounce/mm/highmem.c	Mon Feb 26 17:38:42 2001
@@ -159,6 +159,19 @@
 	spin_unlock(&kmap_lock);
 }
 
+#define POOL_SIZE 32
+
+/*
+ * This lock gets no contention at all, normally.
+ */
+static spinlock_t emergency_lock = SPIN_LOCK_UNLOCKED;
+
+int nr_emergency_pages;
+static LIST_HEAD(emergency_pages);
+
+int nr_emergency_bhs;
+static LIST_HEAD(emergency_bhs);
+
 /*
  * Simple bounce buffer support for highmem pages.
  * This will be moved to the block layer in 2.5.
@@ -203,13 +216,67 @@
 
 static inline void bounce_end_io (struct buffer_head *bh, int uptodate)
 {
+	struct page *page;
 	struct buffer_head *bh_orig = (struct buffer_head *)(bh->b_private);
+	unsigned long flags;
 
 	bh_orig->b_end_io(bh_orig, uptodate);
-	__free_page(bh->b_page);
-	kmem_cache_free(bh_cachep, bh);
+
+	page = bh->b_page;
+
+	spin_lock_irqsave(&emergency_lock, flags);
+	if (nr_emergency_pages >= POOL_SIZE)
+		__free_page(page);
+	else {
+		/*
+		 * We are abusing page->list to manage
+		 * the highmem emergency pool:
+		 */
+		list_add(&page->list, &emergency_pages);
+		nr_emergency_pages++;
+	}
+	
+	if (nr_emergency_bhs >= POOL_SIZE)
+		kmem_cache_free(bh_cachep, bh);
+	else {
+		/*
+		 * Ditto in the bh case, here we abuse b_inode_buffers:
+		 */
+		list_add(&bh->b_inode_buffers, &emergency_bhs);
+		nr_emergency_bhs++;
+	}
+	spin_unlock_irqrestore(&emergency_lock, flags);
 }
 
+static int init_emergency_pool(void)
+{
+	spin_lock_irq(&emergency_lock);
+	while (nr_emergency_pages < POOL_SIZE) {
+		struct page * page = alloc_page(GFP_ATOMIC);
+		if (!page) {
+			printk("couldn't refill highmem emergency pages");
+			break;
+		}
+		list_add(&page->list, &emergency_pages);
+		nr_emergency_pages++;
+	}
+	while (nr_emergency_bhs < POOL_SIZE) {
+		struct buffer_head * bh = kmem_cache_alloc(bh_cachep, SLAB_ATOMIC);
+		if (!bh) {
+			printk("couldn't refill highmem emergency bhs");
+			break;
+		}
+		list_add(&bh->b_inode_buffers, &emergency_bhs);
+		nr_emergency_bhs++;
+	}
+	spin_unlock_irq(&emergency_lock);
+	printk("allocated %d pages and %d bhs reserved for the highmem bounces\n",
+	       nr_emergency_pages, nr_emergency_bhs);
+
+	return 0;
+}
+__initcall(init_emergency_pool);
+
 static void bounce_end_io_write (struct buffer_head *bh, int uptodate)
 {
 	bounce_end_io(bh, uptodate);
@@ -224,6 +291,82 @@
 	bounce_end_io(bh, uptodate);
 }
 
+struct page *alloc_bounce_page (void)
+{
+	struct list_head *tmp;
+	struct page *page;
+
+repeat_alloc:
+	page = alloc_page(GFP_BUFFER);
+	if (page)
+		return page;
+	/*
+	 * No luck. First, kick the VM so it doesnt idle around while
+	 * we are using up our emergency rations.
+	 */
+	wakeup_bdflush(0);
+
+	/*
+	 * Try to allocate from the emergency pool.
+	 */
+	tmp = &emergency_pages;
+	spin_lock_irq(&emergency_lock);
+	if (!list_empty(tmp)) {
+		page = list_entry(tmp->next, struct page, list);
+		list_del(tmp->next);
+		nr_emergency_pages--;
+	}
+	spin_unlock_irq(&emergency_lock);
+	if (page)
+		return page;
+
+	/* we need to wait I/O completion */
+	run_task_queue(&tq_disk);
+
+	current->policy |= SCHED_YIELD;
+	__set_current_state(TASK_RUNNING);
+	schedule();
+	goto repeat_alloc;
+}
+
+struct buffer_head *alloc_bounce_bh (void)
+{
+	struct list_head *tmp;
+	struct buffer_head *bh;
+
+repeat_alloc:
+	bh = kmem_cache_alloc(bh_cachep, SLAB_BUFFER);
+	if (bh)
+		return bh;
+	/*
+	 * No luck. First, kick the VM so it doesnt idle around while
+	 * we are using up our emergency rations.
+	 */
+	wakeup_bdflush(0);
+
+	/*
+	 * Try to allocate from the emergency pool.
+	 */
+	tmp = &emergency_bhs;
+	spin_lock_irq(&emergency_lock);
+	if (!list_empty(tmp)) {
+		bh = list_entry(tmp->next, struct buffer_head, b_inode_buffers);
+		list_del(tmp->next);
+		nr_emergency_bhs--;
+	}
+	spin_unlock_irq(&emergency_lock);
+	if (bh)
+		return bh;
+
+	/* we need to wait I/O completion */
+	run_task_queue(&tq_disk);
+
+	current->policy |= SCHED_YIELD;
+	__set_current_state(TASK_RUNNING);
+	schedule();
+	goto repeat_alloc;
+}
+
 struct buffer_head * create_bounce(int rw, struct buffer_head * bh_orig)
 {
 	struct page *page;
@@ -232,24 +375,15 @@
 	if (!PageHighMem(bh_orig->b_page))
 		return bh_orig;
 
-repeat_bh:
-	bh = kmem_cache_alloc(bh_cachep, SLAB_BUFFER);
-	if (!bh) {
-		wakeup_bdflush(1);  /* Sets task->state to TASK_RUNNING */
-		goto repeat_bh;
-	}
+	bh = alloc_bounce_bh();
 	/*
 	 * This is wasteful for 1k buffers, but this is a stopgap measure
 	 * and we are being ineffective anyway. This approach simplifies
 	 * things immensly. On boxes with more than 4GB RAM this should
 	 * not be an issue anyway.
 	 */
-repeat_page:
-	page = alloc_page(GFP_BUFFER);
-	if (!page) {
-		wakeup_bdflush(1);  /* Sets task->state to TASK_RUNNING */
-		goto repeat_page;
-	}
+	page = alloc_bounce_page();
+
 	set_bh_page(bh, page, 0);
 
 	bh->b_next = NULL;

Andrea
