Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbWAFV5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWAFV5U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 16:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbWAFV5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 16:57:20 -0500
Received: from kanga.kvack.org ([66.96.29.28]:35050 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932472AbWAFV5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 16:57:19 -0500
Date: Fri, 6 Jan 2006 16:53:32 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] use local_t for page statistics
Message-ID: <20060106215332.GH8979@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below converts the mm page_states counters to use local_t.  
mod_page_state shows up in a few profiles on x86 and x86-64 due to the 
disable/enable interrupts operations touching the flags register.  On 
both my laptop (Pentium M) and P4 test box this results in about 10 
additional /bin/bash -c exit 0 executions per second (P4 went from ~759/s 
to ~771/s).  Tested on x86 and x86-64.  Oh, also add a pgcow statistic 
for the number of COW page faults.

Signed-off-by: Benjamin LaHaise <benjamin.c.lahaise@intel.com>

diff --git a/arch/i386/mm/pgtable.c b/arch/i386/mm/pgtable.c
index 9db3242..293ba9a 100644
--- a/arch/i386/mm/pgtable.c
+++ b/arch/i386/mm/pgtable.c
@@ -59,11 +59,11 @@ void show_mem(void)
 	printk(KERN_INFO "%d pages swap cached\n", cached);
 
 	get_page_state(&ps);
-	printk(KERN_INFO "%lu pages dirty\n", ps.nr_dirty);
-	printk(KERN_INFO "%lu pages writeback\n", ps.nr_writeback);
-	printk(KERN_INFO "%lu pages mapped\n", ps.nr_mapped);
-	printk(KERN_INFO "%lu pages slab\n", ps.nr_slab);
-	printk(KERN_INFO "%lu pages pagetables\n", ps.nr_page_table_pages);
+	printk(KERN_INFO "%lu pages dirty\n", local_read(&ps.nr_dirty));
+	printk(KERN_INFO "%lu pages writeback\n", local_read(&ps.nr_writeback));
+	printk(KERN_INFO "%lu pages mapped\n", local_read(&ps.nr_mapped));
+	printk(KERN_INFO "%lu pages slab\n", local_read(&ps.nr_slab));
+	printk(KERN_INFO "%lu pages pagetables\n", local_read(&ps.nr_page_table_pages));
 }
 
 /*
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 16c513a..5ae1ead 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -81,10 +81,10 @@ static ssize_t node_read_meminfo(struct 
 		       nid, K(i.freehigh),
 		       nid, K(i.totalram - i.totalhigh),
 		       nid, K(i.freeram - i.freehigh),
-		       nid, K(ps.nr_dirty),
-		       nid, K(ps.nr_writeback),
-		       nid, K(ps.nr_mapped),
-		       nid, K(ps.nr_slab));
+		       nid, K(local_read(&ps.nr_dirty)),
+		       nid, K(local_read(&ps.nr_writeback)),
+		       nid, K(local_read(&ps.nr_mapped)),
+		       nid, K(local_read(&ps.nr_slab)));
 	n += hugetlb_report_node_meminfo(nid, buf + n);
 	return n;
 }
diff --git a/fs/proc/proc_misc.c b/fs/proc/proc_misc.c
index 5b6b0b6..e76b11f 100644
--- a/fs/proc/proc_misc.c
+++ b/fs/proc/proc_misc.c
@@ -135,7 +135,7 @@ static int meminfo_read_proc(char *page,
 /*
  * display in kilobytes.
  */
-#define K(x) ((x) << (PAGE_SHIFT - 10))
+#define K(x) ((unsigned long)(x) << (PAGE_SHIFT - 10))
 	si_meminfo(&i);
 	si_swapinfo(&i);
 	committed = atomic_read(&vm_committed_space);
@@ -188,13 +188,13 @@ static int meminfo_read_proc(char *page,
 		K(i.freeram-i.freehigh),
 		K(i.totalswap),
 		K(i.freeswap),
-		K(ps.nr_dirty),
-		K(ps.nr_writeback),
-		K(ps.nr_mapped),
-		K(ps.nr_slab),
+		K(local_read(&ps.nr_dirty)),
+		K(local_read(&ps.nr_writeback)),
+		K(local_read(&ps.nr_mapped)),
+		K(local_read(&ps.nr_slab)),
 		K(allowed),
 		K(committed),
-		K(ps.nr_page_table_pages),
+		K(local_read(&ps.nr_page_table_pages)),
 		(unsigned long)VMALLOC_TOTAL >> 10,
 		vmi.used >> 10,
 		vmi.largest_chunk >> 10
diff --git a/include/asm-x86_64/local.h b/include/asm-x86_64/local.h
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index d52999c..1d95d05 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -8,6 +8,7 @@
 #include <linux/percpu.h>
 #include <linux/cache.h>
 #include <asm/pgtable.h>
+#include <asm/local.h>
 
 /*
  * Various page->flags bits:
@@ -77,7 +78,7 @@
 #define PG_uncached		19	/* Page has been mapped as uncached */
 
 /*
- * Global page accounting.  One instance per CPU.  Only unsigned longs are
+ * Global page accounting.  One instance per CPU.  Only local_ts are
  * allowed.
  *
  * - Fields can be modified with xxx_page_state and xxx_page_state_zone at
@@ -90,65 +91,66 @@
  * In this case, the field should be commented here.
  */
 struct page_state {
-	unsigned long nr_dirty;		/* Dirty writeable pages */
-	unsigned long nr_writeback;	/* Pages under writeback */
-	unsigned long nr_unstable;	/* NFS unstable pages */
-	unsigned long nr_page_table_pages;/* Pages used for pagetables */
-	unsigned long nr_mapped;	/* mapped into pagetables.
+	local_t nr_dirty;		/* Dirty writeable pages */
+	local_t nr_writeback;		/* Pages under writeback */
+	local_t nr_unstable;		/* NFS unstable pages */
+	local_t nr_page_table_pages;	/* Pages used for pagetables */
+	local_t nr_mapped;		/* mapped into pagetables.
 					 * only modified from process context */
-	unsigned long nr_slab;		/* In slab */
+	local_t nr_slab;		/* In slab */
 #define GET_PAGE_STATE_LAST nr_slab
 
 	/*
 	 * The below are zeroed by get_page_state().  Use get_full_page_state()
 	 * to add up all these.
 	 */
-	unsigned long pgpgin;		/* Disk reads */
-	unsigned long pgpgout;		/* Disk writes */
-	unsigned long pswpin;		/* swap reads */
-	unsigned long pswpout;		/* swap writes */
-
-	unsigned long pgalloc_high;	/* page allocations */
-	unsigned long pgalloc_normal;
-	unsigned long pgalloc_dma32;
-	unsigned long pgalloc_dma;
-
-	unsigned long pgfree;		/* page freeings */
-	unsigned long pgactivate;	/* pages moved inactive->active */
-	unsigned long pgdeactivate;	/* pages moved active->inactive */
-
-	unsigned long pgfault;		/* faults (major+minor) */
-	unsigned long pgmajfault;	/* faults (major only) */
-
-	unsigned long pgrefill_high;	/* inspected in refill_inactive_zone */
-	unsigned long pgrefill_normal;
-	unsigned long pgrefill_dma32;
-	unsigned long pgrefill_dma;
-
-	unsigned long pgsteal_high;	/* total highmem pages reclaimed */
-	unsigned long pgsteal_normal;
-	unsigned long pgsteal_dma32;
-	unsigned long pgsteal_dma;
-
-	unsigned long pgscan_kswapd_high;/* total highmem pages scanned */
-	unsigned long pgscan_kswapd_normal;
-	unsigned long pgscan_kswapd_dma32;
-	unsigned long pgscan_kswapd_dma;
-
-	unsigned long pgscan_direct_high;/* total highmem pages scanned */
-	unsigned long pgscan_direct_normal;
-	unsigned long pgscan_direct_dma32;
-	unsigned long pgscan_direct_dma;
-
-	unsigned long pginodesteal;	/* pages reclaimed via inode freeing */
-	unsigned long slabs_scanned;	/* slab objects scanned */
-	unsigned long kswapd_steal;	/* pages reclaimed by kswapd */
-	unsigned long kswapd_inodesteal;/* reclaimed via kswapd inode freeing */
-	unsigned long pageoutrun;	/* kswapd's calls to page reclaim */
-	unsigned long allocstall;	/* direct reclaim calls */
-
-	unsigned long pgrotated;	/* pages rotated to tail of the LRU */
-	unsigned long nr_bounce;	/* pages for bounce buffers */
+	local_t pgpgin;			/* Disk reads */
+	local_t pgpgout;		/* Disk writes */
+	local_t pswpin;			/* swap reads */
+	local_t pswpout;		/* swap writes */
+
+	local_t pgalloc_high;		/* page allocations */
+	local_t pgalloc_normal;
+	local_t pgalloc_dma32;
+	local_t pgalloc_dma;
+
+	local_t pgfree;			/* page freeings */
+	local_t pgactivate;		/* pages moved inactive->active */
+	local_t pgdeactivate;		/* pages moved active->inactive */
+
+	local_t pgfault;		/* faults (major+minor) */
+	local_t pgmajfault;		/* faults (major only) */
+
+	local_t pgrefill_high;		/* inspected in refill_inactive_zone */
+	local_t pgrefill_normal;
+	local_t pgrefill_dma32;
+	local_t pgrefill_dma;
+
+	local_t pgsteal_high;		/* total highmem pages reclaimed */
+	local_t pgsteal_normal;
+	local_t pgsteal_dma32;
+	local_t pgsteal_dma;
+
+	local_t pgscan_kswapd_high;	/* total highmem pages scanned */
+	local_t pgscan_kswapd_normal;
+	local_t pgscan_kswapd_dma32;
+	local_t pgscan_kswapd_dma;
+
+	local_t pgscan_direct_high;	/* total highmem pages scanned */
+	local_t pgscan_direct_normal;
+	local_t pgscan_direct_dma32;
+	local_t pgscan_direct_dma;
+
+	local_t pginodesteal;		/* pages reclaimed via inode freeing */
+	local_t slabs_scanned;		/* slab objects scanned */
+	local_t kswapd_steal;		/* pages reclaimed by kswapd */
+	local_t kswapd_inodesteal;	/* reclaimed via kswapd inode freeing */
+	local_t pageoutrun;		/* kswapd's calls to page reclaim */
+	local_t allocstall;		/* direct reclaim calls */
+
+	local_t pgrotated;		/* pages rotated to tail of the LRU */
+	local_t nr_bounce;		/* pages for bounce buffers */
+	local_t pgcow;			/* COW page copies */
 };
 
 extern void get_page_state(struct page_state *ret);
diff --git a/mm/memory.c b/mm/memory.c
index 7197f9b..db3faea 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1410,6 +1410,7 @@ static inline void cow_user_page(struct 
 		return;
 		
 	}
+	inc_page_state(pgcow);
 	copy_user_highpage(dst, src, va);
 }
 
@@ -2067,6 +2068,7 @@ retry:
 		page = alloc_page_vma(GFP_HIGHUSER, vma, address);
 		if (!page)
 			goto oom;
+		inc_page_state(pgcow);
 		copy_user_highpage(page, new_page, address);
 		page_cache_release(new_page);
 		new_page = page;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fd47494..6f47e27 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1191,7 +1191,7 @@ static void show_node(struct zone *zone)
  * The result is unavoidably approximate - it can change
  * during and after execution of this function.
  */
-static DEFINE_PER_CPU(struct page_state, page_states) = {0};
+static DEFINE_PER_CPU(struct page_state, page_states);
 
 atomic_t nr_pagecache = ATOMIC_INIT(0);
 EXPORT_SYMBOL(nr_pagecache);
@@ -1207,18 +1207,19 @@ static void __get_page_state(struct page
 
 	cpu = first_cpu(*cpumask);
 	while (cpu < NR_CPUS) {
-		unsigned long *in, *out, off;
+		local_t *in, *out;
+		int off;
 
-		in = (unsigned long *)&per_cpu(page_states, cpu);
+		in = (local_t *)&per_cpu(page_states, cpu);
 
 		cpu = next_cpu(cpu, *cpumask);
 
 		if (cpu < NR_CPUS)
 			prefetch(&per_cpu(page_states, cpu));
 
-		out = (unsigned long *)ret;
+		out = (local_t *)ret;
 		for (off = 0; off < nr; off++)
-			*out++ += *in++;
+			local_add(local_read(in++), out++);
 	}
 }
 
@@ -1228,7 +1229,7 @@ void get_page_state_node(struct page_sta
 	cpumask_t mask = node_to_cpumask(node);
 
 	nr = offsetof(struct page_state, GET_PAGE_STATE_LAST);
-	nr /= sizeof(unsigned long);
+	nr /= sizeof(local_t);
 
 	__get_page_state(ret, nr+1, &mask);
 }
@@ -1239,7 +1240,7 @@ void get_page_state(struct page_state *r
 	cpumask_t mask = CPU_MASK_ALL;
 
 	nr = offsetof(struct page_state, GET_PAGE_STATE_LAST);
-	nr /= sizeof(unsigned long);
+	nr /= sizeof(local_t);
 
 	__get_page_state(ret, nr + 1, &mask);
 }
@@ -1248,7 +1249,7 @@ void get_full_page_state(struct page_sta
 {
 	cpumask_t mask = CPU_MASK_ALL;
 
-	__get_page_state(ret, sizeof(*ret) / sizeof(unsigned long), &mask);
+	__get_page_state(ret, sizeof(*ret) / sizeof(local_t), &mask);
 }
 
 unsigned long read_page_state_offset(unsigned long offset)
@@ -1257,10 +1258,10 @@ unsigned long read_page_state_offset(uns
 	int cpu;
 
 	for_each_cpu(cpu) {
-		unsigned long in;
+		local_t *in;
 
-		in = (unsigned long)&per_cpu(page_states, cpu) + offset;
-		ret += *((unsigned long *)in);
+		in = (void *)&per_cpu(page_states, cpu) + offset;
+		ret += local_read(in);
 	}
 	return ret;
 }
@@ -1270,19 +1271,16 @@ void __mod_page_state_offset(unsigned lo
 	void *ptr;
 
 	ptr = &__get_cpu_var(page_states);
-	*(unsigned long *)(ptr + offset) += delta;
+	local_add(delta, (local_t *)(ptr + offset));
 }
 EXPORT_SYMBOL(__mod_page_state_offset);
 
 void mod_page_state_offset(unsigned long offset, unsigned long delta)
 {
-	unsigned long flags;
 	void *ptr;
 
-	local_irq_save(flags);
 	ptr = &__get_cpu_var(page_states);
-	*(unsigned long *)(ptr + offset) += delta;
-	local_irq_restore(flags);
+	local_add(delta, (local_t *)(ptr + offset));
 }
 EXPORT_SYMBOL(mod_page_state_offset);
 
@@ -1402,13 +1400,13 @@ void show_free_areas(void)
 		"unstable:%lu free:%u slab:%lu mapped:%lu pagetables:%lu\n",
 		active,
 		inactive,
-		ps.nr_dirty,
-		ps.nr_writeback,
-		ps.nr_unstable,
+		(unsigned long)local_read(&ps.nr_dirty),
+		(unsigned long)local_read(&ps.nr_writeback),
+		(unsigned long)local_read(&ps.nr_unstable),
 		nr_free_pages(),
-		ps.nr_slab,
-		ps.nr_mapped,
-		ps.nr_page_table_pages);
+		(unsigned long)local_read(&ps.nr_slab),
+		(unsigned long)local_read(&ps.nr_mapped),
+		(unsigned long)local_read(&ps.nr_page_table_pages));
 
 	for_each_zone(zone) {
 		int i;
@@ -2320,6 +2318,7 @@ static char *vmstat_text[] = {
 
 	"pgrotated",
 	"nr_bounce",
+	"pgcow",
 };
 
 static void *vmstat_start(struct seq_file *m, loff_t *pos)
@@ -2334,9 +2333,10 @@ static void *vmstat_start(struct seq_fil
 	if (!ps)
 		return ERR_PTR(-ENOMEM);
 	get_full_page_state(ps);
-	ps->pgpgin /= 2;		/* sectors -> kbytes */
-	ps->pgpgout /= 2;
-	return (unsigned long *)ps + *pos;
+	/* sectors -> kbytes */
+	local_set(&ps->pgpgin, local_read(&ps->pgpgin) / 2);
+	local_set(&ps->pgpgout, local_read(&ps->pgpgout) / 2);
+	return (local_t *)ps + *pos;
 }
 
 static void *vmstat_next(struct seq_file *m, void *arg, loff_t *pos)
@@ -2344,15 +2344,16 @@ static void *vmstat_next(struct seq_file
 	(*pos)++;
 	if (*pos >= ARRAY_SIZE(vmstat_text))
 		return NULL;
-	return (unsigned long *)m->private + *pos;
+	return (local_t *)m->private + *pos;
 }
 
 static int vmstat_show(struct seq_file *m, void *arg)
 {
-	unsigned long *l = arg;
-	unsigned long off = l - (unsigned long *)m->private;
+	local_t *l = arg;
+	unsigned long off = l - (local_t *)m->private;
 
-	seq_printf(m, "%s %lu\n", vmstat_text[off], *l);
+	seq_printf(m, "%s %lu\n", vmstat_text[off],
+		   (unsigned long)local_read(l));
 	return 0;
 }
 
@@ -2377,7 +2378,7 @@ static int page_alloc_cpu_notify(struct 
 {
 	int cpu = (unsigned long)hcpu;
 	long *count;
-	unsigned long *src, *dest;
+	local_t *src, *dest;
 
 	if (action == CPU_DEAD) {
 		int i;
@@ -2388,18 +2389,17 @@ static int page_alloc_cpu_notify(struct 
 		*count = 0;
 		local_irq_disable();
 		__drain_pages(cpu);
+		local_irq_enable();
 
 		/* Add dead cpu's page_states to our own. */
-		dest = (unsigned long *)&__get_cpu_var(page_states);
-		src = (unsigned long *)&per_cpu(page_states, cpu);
+		dest = (local_t *)&__get_cpu_var(page_states);
+		src = (local_t *)&per_cpu(page_states, cpu);
 
-		for (i = 0; i < sizeof(struct page_state)/sizeof(unsigned long);
+		for (i = 0; i < sizeof(struct page_state)/sizeof(local_t);
 				i++) {
-			dest[i] += src[i];
-			src[i] = 0;
+			local_add(local_read(src + i), dest + i);
+			local_set(src + i, 0);
 		}
-
-		local_irq_enable();
 	}
 	return NOTIFY_OK;
 }
