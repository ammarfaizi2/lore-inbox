Return-Path: <linux-kernel-owner+w=401wt.eu-S964838AbXABMKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbXABMKQ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 07:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbXABMKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 07:10:15 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:50327 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964834AbXABMKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 07:10:13 -0500
Date: Tue, 2 Jan 2007 13:06:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] fix data corruption bug in __block_write_full_page()
Message-ID: <20070102120634.GA1760@elte.hu>
References: <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org> <20061228114517.3315aee7.akpm@osdl.org> <Pine.LNX.4.64.0612281156150.4473@woody.osdl.org> <20061228.143815.41633302.davem@davemloft.net> <3d6d8711f7b892a11801d43c5996ebdf@kernel.crashing.org> <Pine.LNX.4.64.0612282155400.4473@woody.osdl.org> <20061229121946.GA17837@elte.hu> <20070102112054.GC22657@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070102112054.GC22657@infradead.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Cc:-ed lkml]

* Christoph Hellwig <hch@infradead.org> wrote:

> On Fri, Dec 29, 2006 at 01:19:46PM +0100, Ingo Molnar wrote:
> > i've extended the tracer in -rt to trace all relevant pagetable, 
> > pagecache, buffer-cache and IO events and coupled the tracer to your 
> > test.c code. The corruption happens here:
> > 
> >     test-2126  0.... 3756170us+: trace_page (cf20ebd8 b6a2c000 0)
> >  pdflush-2006  0.... 6432909us+: trace_page (cf20ebd8 b6a2c000 4200420)
> >     test-2126  0.... 8135596us+: trace_page (cf20ebd8 b6a2c000 4200420)
> >     test-2126  0D... 9012933us+: do_page_fault (8048900 4 b6a2c000)
> >     test-2126  0.... 9023278us+: trace_page (cf262f24 b6a2c000 0)
> >     test-2126  0.... 9023305us > sys_prctl (000000d8 b6a2c000 000000ac)
> 
> This tracer definitly looks interesting.  Could you send a splitout 
> patch with it to lkml for review?

Find it below - it's ontop of the tracer included in 2.6.20-rc2-rt3. 
it's very ad-hoc, based on Linus' test utility. I can write such a 
tracer in 30 minutes so i usually throw them away. I literally wrote 
dozens of tracer variants for specific bugs in the past few years.

Note: this particular one tracks page contents as well from 
kernel-space, that's how i was able to see where the corruption 
happened. That assumes that there's no highmem on the box. Also, the pte 
value tracking portion is only for i386 - etc. etc. Note: for the bug to 
be visible i didnt need the per-page tracking portion of the tracer - 
the key was to track page contents, and to track how virtual addresses 
map to physical pages, and how their IO happens.

This patch is /not/ for merging: this patch too undescores my years long 
experience that static tracepoints included in the generic kernel are 
just pointless in general - i dont want to see such cruft in the kernel, 
and they amass with time. The union of all ad-hoc tracing hacks i had in 
the past would be thousands of static tracepoints - and that's just 
/me/. If we pick only a handful they wont help us find the most 
difficult bugs and they'll only create additional 'demand' for 'more' - 
leading to an endless fight.

The best method i think is to use the source code itself (Linus used 
printks) - or if any infrastructure is to be used then ad-hoc 
"scriptlets" via SystemTap can find the really difficult bugs - and in 
the long run systemtap suits that purpose best. If systemtap were 
ubiquous we could have sent scriptlets to users who experienced the 
bugs, for them to install them dynamically. Systemtap makes it plain 
obvious that tracepoints are 1) detached from the source code and are 2) 
are temporary and ad-hoc in nature. It doesnt create undue pressure to 
include more and more static tracepoints.

	Ingo

----------->
 fs/buffer.c                       |    1 
 include/asm-i386/pgtable-2level.h |    4 +
 include/linux/mm_types.h          |   22 +++++++++
 kernel/sys.c                      |   15 ++++++
 mm/Makefile                       |    2 
 mm/memory.c                       |    2 
 mm/page-writeback.c               |   33 ++++++++++++--
 mm/page_alloc.c                   |    3 +
 mm/page_trace.c                   |   84 ++++++++++++++++++++++++++++++++++++++
 mm/rmap.c                         |    2 
 10 files changed, 159 insertions(+), 9 deletions(-)

Index: linux/fs/buffer.c
===================================================================
--- linux.orig/fs/buffer.c
+++ linux/fs/buffer.c
@@ -1590,6 +1590,7 @@ static int __block_write_full_page(struc
 	int nr_underway = 0;
 
 	BUG_ON(!PageLocked(page));
+	trace_page(page, blocksize);
 
 	last_block = (i_size_read(inode) - 1) >> inode->i_blkbits;
 
Index: linux/include/asm-i386/pgtable-2level.h
===================================================================
--- linux.orig/include/asm-i386/pgtable-2level.h
+++ linux/include/asm-i386/pgtable-2level.h
@@ -13,7 +13,9 @@
  */
 #ifndef CONFIG_PARAVIRT
 #define set_pte(pteptr, pteval) (*(pteptr) = pteval)
-#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
+struct mm_struct;
+extern void trace_set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_t pte_val);
+#define set_pte_at(mm,addr,ptep,pteval) trace_set_pte_at(mm,addr,ptep,pteval)
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
 #endif
 
Index: linux/include/linux/mm_types.h
===================================================================
--- linux.orig/include/linux/mm_types.h
+++ linux/include/linux/mm_types.h
@@ -5,9 +5,29 @@
 #include <linux/threads.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
+#include <linux/stacktrace.h>
 
 struct address_space;
 
+struct page;
+struct seq_file;
+
+#define PAGE_TRACE_DEPTH	16
+#define PAGE_TRACE_NR		20
+
+struct page_trace_entry {
+	unsigned long	timestamp;
+	char		comm[17];
+	int		pid;
+	int		nr_entries;
+	unsigned long	info;
+	unsigned long	content;
+	unsigned long	entries[PAGE_TRACE_DEPTH];
+};
+
+extern void trace_page(struct page *page, unsigned long info);
+extern void print_page_trace(struct seq_file *m, struct page *page);
+
 /*
  * Each physical page in the system has a struct page associated with
  * it to keep track of whatever it is we are using the page for at the
@@ -62,6 +82,8 @@ struct page {
 	void *virtual;			/* Kernel virtual address (NULL if
 					   not kmapped, ie. highmem) */
 #endif /* WANT_PAGE_VIRTUAL */
+	int trace_idx;
+	struct page_trace_entry trace[PAGE_TRACE_NR];
 };
 
 #endif /* _LINUX_MM_TYPES_H */
Index: linux/kernel/sys.c
===================================================================
--- linux.orig/kernel/sys.c
+++ linux/kernel/sys.c
@@ -2067,6 +2067,21 @@ asmlinkage long sys_prctl(int option, un
 {
 	long error;
 
+	if (option == 999) {
+		unsigned long addr = arg2;
+		struct vm_area_struct *vma = find_vma(current->mm, addr);
+		struct page *page = NULL;
+
+		printk("page trace, got addr %08lx, vma %p\n", addr, vma);
+		if (vma) {
+			page = follow_page(vma, addr, FOLL_GET);
+			if (page) {
+				print_page_trace(NULL, page);
+				put_page(page);
+			}
+		}
+		return 0;
+	}
 #ifdef CONFIG_EVENT_TRACE
 	if (option == PR_SET_TRACING) {
 		if (arg2)
Index: linux/mm/Makefile
===================================================================
--- linux.orig/mm/Makefile
+++ linux/mm/Makefile
@@ -9,7 +9,7 @@ mmu-$(CONFIG_MMU)	:= fremap.o highmem.o 
 
 obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
 			   page_alloc.o page-writeback.o pdflush.o \
-			   readahead.o swap.o truncate.o vmscan.o \
+			   readahead.o swap.o truncate.o vmscan.o page_trace.o \
 			   prio_tree.o util.o mmzone.o vmstat.o backing-dev.o \
 			   $(mmu-y)
 
Index: linux/mm/memory.c
===================================================================
--- linux.orig/mm/memory.c
+++ linux/mm/memory.c
@@ -451,6 +451,8 @@ struct page *vm_normal_page(struct vm_ar
 	 * The PAGE_ZERO() pages and various VDSO mappings can
 	 * cause them to exist.
 	 */
+
+	trace_page(pfn_to_page(pfn), addr);
 	return pfn_to_page(pfn);
 }
 
Index: linux/mm/page-writeback.c
===================================================================
--- linux.orig/mm/page-writeback.c
+++ linux/mm/page-writeback.c
@@ -762,8 +762,10 @@ int __set_page_dirty_nobuffers(struct pa
 		struct address_space *mapping = page_mapping(page);
 		struct address_space *mapping2;
 
-		if (!mapping)
+		if (!mapping) {
+			trace_page(page, 1);
 			return 1;
+		}
 
 		write_lock_irq(&mapping->tree_lock);
 		mapping2 = page_mapping(page);
@@ -781,8 +783,10 @@ int __set_page_dirty_nobuffers(struct pa
 			/* !PageAnon && !swapper_space */
 			__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 		}
+		trace_page(page, 1);
 		return 1;
 	}
+	trace_page(page, 0);
 	return 0;
 }
 EXPORT_SYMBOL(__set_page_dirty_nobuffers);
@@ -806,6 +810,7 @@ EXPORT_SYMBOL(redirty_page_for_writepage
 int fastcall set_page_dirty(struct page *page)
 {
 	struct address_space *mapping = page_mapping(page);
+	int ret;
 
 	if (likely(mapping)) {
 		int (*spd)(struct page *) = mapping->a_ops->set_page_dirty;
@@ -813,12 +818,17 @@ int fastcall set_page_dirty(struct page 
 		if (!spd)
 			spd = __set_page_dirty_buffers;
 #endif
-		return (*spd)(page);
+		ret = (*spd)(page);
+		trace_page(page, ret);
+		return ret;
 	}
 	if (!PageDirty(page)) {
-		if (!TestSetPageDirty(page))
+		if (!TestSetPageDirty(page)) {
+			trace_page(page, 1);
 			return 1;
+		}
 	}
+	trace_page(page, 0);
 	return 0;
 }
 EXPORT_SYMBOL(set_page_dirty);
@@ -840,6 +850,7 @@ int set_page_dirty_lock(struct page *pag
 	lock_page_nosync(page);
 	ret = set_page_dirty(page);
 	unlock_page(page);
+	trace_page(page, ret);
 	return ret;
 }
 EXPORT_SYMBOL(set_page_dirty_lock);
@@ -915,13 +926,17 @@ int test_clear_page_writeback(struct pag
 
 		write_lock_irqsave(&mapping->tree_lock, flags);
 		ret = TestClearPageWriteback(page);
-		if (ret)
+		trace_page(page, ret);
+		if (ret) {
 			radix_tree_tag_clear(&mapping->page_tree,
 						page_index(page),
 						PAGECACHE_TAG_WRITEBACK);
+			trace_page(page, ret);
+		}
 		write_unlock_irqrestore(&mapping->tree_lock, flags);
 	} else {
 		ret = TestClearPageWriteback(page);
+		trace_page(page, ret);
 	}
 	return ret;
 }
@@ -936,17 +951,23 @@ int test_set_page_writeback(struct page 
 
 		write_lock_irqsave(&mapping->tree_lock, flags);
 		ret = TestSetPageWriteback(page);
-		if (!ret)
+		trace_page(page, ret);
+		if (!ret) {
 			radix_tree_tag_set(&mapping->page_tree,
 						page_index(page),
 						PAGECACHE_TAG_WRITEBACK);
-		if (!PageDirty(page))
+			trace_page(page, ret);
+		}
+		if (!PageDirty(page)) {
 			radix_tree_tag_clear(&mapping->page_tree,
 						page_index(page),
 						PAGECACHE_TAG_DIRTY);
+			trace_page(page, ret);
+		}
 		write_unlock_irqrestore(&mapping->tree_lock, flags);
 	} else {
 		ret = TestSetPageWriteback(page);
+		trace_page(page, ret);
 	}
 	return ret;
 
Index: linux/mm/page_alloc.c
===================================================================
--- linux.orig/mm/page_alloc.c
+++ linux/mm/page_alloc.c
@@ -1420,6 +1420,8 @@ nopage:
 		show_mem();
 	}
 got_pg:
+	if (page)
+		trace_page(page, order);
 	return page;
 }
 
@@ -1468,6 +1470,7 @@ void __pagevec_free(struct pagevec *pvec
 fastcall void __free_pages(struct page *page, unsigned int order)
 {
 	if (put_page_testzero(page)) {
+		trace_page(page, order);
 		if (order == 0)
 			free_hot_page(page);
 		else
Index: linux/mm/page_trace.c
===================================================================
--- /dev/null
+++ linux/mm/page_trace.c
@@ -0,0 +1,84 @@
+
+#include <linux/seq_file.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+
+void trace_page(struct page *page, unsigned long info)
+{
+	struct page_trace_entry *entry;
+	struct stack_trace trace;
+	unsigned long flags, content;
+	unsigned long *addr;
+
+	addr = (unsigned long *)page_address(page);
+	if (addr)
+		content = *addr;
+	else
+		content = 0x12344321;
+
+	trace_special((unsigned long)page, info, content);
+	trace_special_sym();
+
+	local_irq_save(flags);
+	page->trace_idx = (page->trace_idx + 1) % PAGE_TRACE_NR;
+	entry = page->trace + page->trace_idx;
+	trace.nr_entries = 0;
+	trace.max_entries = PAGE_TRACE_DEPTH;
+	trace.entries = entry->entries;
+	trace.skip = 3;
+	trace.all_contexts = 0;
+	save_stack_trace(&trace, NULL);
+	entry->nr_entries = trace.nr_entries;
+	entry->timestamp = jiffies - INITIAL_JIFFIES;
+	entry->pid = current->pid;
+	entry->info = info;
+	entry->content = content;
+	memcpy(entry->comm, current->comm, TASK_COMM_LEN);
+	local_irq_restore(flags);
+}
+
+static void print_page_trace_entry(struct seq_file *m,
+				   struct page_trace_entry *entry, int idx)
+{
+	struct stack_trace trace;
+	SEQ_printf(m, "#%02d, %06ld.%03ld, %-16s:%d, (#%d): content: %08lx, info: %08lx\n",
+		idx, entry->timestamp / HZ, entry->timestamp % HZ, entry->comm, entry->pid,
+		entry->nr_entries, entry->content, entry->info);
+
+	trace.nr_entries = entry->nr_entries;
+	trace.entries = entry->entries;
+	print_stack_trace(&trace, 2);
+	SEQ_printf(m, "\n");
+}
+
+void print_page_trace(struct seq_file *m, struct page *page)
+{
+	int i, i0;
+
+	SEQ_printf(m, "printing page %p's events:\n", page);
+
+	i0 = i = page->trace_idx;
+	do {
+		i = (i + 1) % PAGE_TRACE_NR;
+		print_page_trace_entry(m, page->trace + i, i);
+	} while (i != i0);
+}
+
+static void trace_pte(pte_t pte, unsigned long addr)
+{
+	unsigned long pfn;
+
+	if (pte_present(pte)) {
+		pfn = pte_pfn(pte);
+		if (pfn_valid(pfn))
+			trace_page(pfn_to_page(pfn), addr);
+	}
+}
+
+void trace_set_pte_at(struct mm_struct *mm, unsigned long addr,
+		      pte_t *ptep, pte_t pteval)
+{
+	trace_pte(*ptep, addr);
+	set_pte(ptep, pteval);
+	trace_pte(pteval, addr);
+}
Index: linux/mm/rmap.c
===================================================================
--- linux.orig/mm/rmap.c
+++ linux/mm/rmap.c
@@ -452,7 +452,7 @@ static int page_mkclean_one(struct page 
 		entry = ptep_clear_flush(vma, address, pte);
 		entry = pte_wrprotect(entry);
 		entry = pte_mkclean(entry);
-		set_pte_at(vma, address, pte, entry);
+		set_pte_at(mm, address, pte, entry);
 		lazy_mmu_prot_update(entry);
 		ret = 1;
 	}
