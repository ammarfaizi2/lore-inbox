Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264142AbTKSSIw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 13:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264181AbTKSSIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 13:08:52 -0500
Received: from nagatino-gw.corbina.net ([195.14.53.90]:10485 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S264142AbTKSSId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 13:08:33 -0500
Subject: [RFC] use-after-free hunter
From: Alex Tomas <alex@clusterfs.com>
Cc: Alex Tomas <alex@clusterfs.com>
To: linux-kernel@vger.kernel.org
Organization: HOME
Date: Wed, 19 Nov 2003 21:11:52 +0300
Message-ID: <m3k75w6xef.fsf@bzzz.home.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

probably someone find this useful. the patch works following way:

1) upon boot allocate space (not real pages!) for N pages
   (32768 by default) in [VMALLOC_START; VMALLOC_END]. let's
   call this space UAFSPACE
2) selected slab requests can be forwarded into specific uaf_alloc()
   and usf_free()
3) uaf_alloc() finds no-yet-mapped (via special bitmap) space in 
   UAFSPACE, allocates free page and maps it there. space is used
   in round-robin manner. thus address are unlikely to be reused
   right after freeing
4) uaf_free() unmaps page and free it
5) echo "on <slabname>" >/proc/uafinfo enables uaf_alloc() on
   a specified slab cache. echo "off ..." disables.
6) UAFSPACE size can be specified by uaf= boot param
7) CONFIG_DEBUG_UAF should be set in .config

tested on UP/SMP P3

any comments?

thanks, Alex

PS. I've already catched couple bugs using this
PPS. this is for i386 arch only, sorry :)


%patch
Index: linux-2.6.0-test5/mm/slab.c
===================================================================
--- linux-2.6.0-test5.orig/mm/slab.c	2003-11-19 20:49:10.000000000 +0300
+++ linux-2.6.0-test5/mm/slab.c	2003-11-19 21:06:01.000000000 +0300
@@ -96,6 +96,8 @@
 #include	<asm/cacheflush.h>
 #include	<asm/tlbflush.h>
 
+#include	<linux/vmalloc.h>
+
 /*
  * DEBUG	- 1 for kmem_cache_create() to honour; SLAB_DEBUG_INITIAL,
  *		  SLAB_RED_ZONE & SLAB_POISON.
@@ -1903,6 +1905,12 @@
 	return objp;
 }
 
+#ifdef CONFIG_DEBUG_UAF
+void * uaf_alloc(kmem_cache_t *, int gfp_mask);
+int uaf_cache_free(kmem_cache_t *, void *addr);
+int uaf_free(void *addr);
+struct page *uaf_vaddr_to_page(void *obj);
+#endif
 
 static inline void * __cache_alloc (kmem_cache_t *cachep, int flags)
 {
@@ -1910,6 +1918,20 @@
 	void* objp;
 	struct array_cache *ac;
 
+#ifdef CONFIG_DEBUG_UAF
+	/* try to use uaf-allocator first */
+	objp = uaf_alloc(cachep, flags);
+	if (objp) {
+		if (cachep->ctor) {
+			unsigned long ctor_flags;
+			ctor_flags = SLAB_CTOR_CONSTRUCTOR;
+			if (!(flags & __GFP_WAIT))
+				ctor_flags |= SLAB_CTOR_ATOMIC;
+			cachep->ctor(objp, cachep, ctor_flags);
+		}
+		return objp;
+	}
+#endif
 	cache_alloc_debugcheck_before(cachep, flags);
 
 	local_irq_save(save_flags);
@@ -2171,6 +2193,10 @@
 {
 	unsigned long flags;
 
+#ifdef CONFIG_DEBUG_UAF
+	if (uaf_cache_free(cachep, objp))
+		return;
+#endif
 	local_irq_save(flags);
 	__cache_free(cachep, objp);
 	local_irq_restore(flags);
@@ -2192,6 +2218,10 @@
 
 	if (!objp)
 		return;
+#ifdef CONFIG_DEBUG_UAF
+	if (uaf_free((void *) objp))
+		return;
+#endif
 	local_irq_save(flags);
 	kfree_debugcheck(objp);
 	c = GET_PAGE_CACHE(virt_to_page(objp));
@@ -2837,3 +2867,438 @@
 
 	}
 }
+
+
+#ifdef CONFIG_DEBUG_UAF
+
+#define MAX_UAF_OBJ_SIZE	1	/* in pages */
+
+struct uaf_stats {
+	atomic_t uaf_allocated;
+	atomic_t uaf_allocations;
+	atomic_t uaf_failed;
+};
+
+static int uaf_max = 32768;
+static void *uaf_bitmap = NULL;
+static spinlock_t uaf_lock;
+static int uaf_last_found = 0;
+static int uaf_used = 0;
+static struct vm_struct *uaf_area = NULL;
+static struct uaf_stats uaf_stats[MAX_UAF_OBJ_SIZE + 1];
+
+static int __init uaf_setup(char *str)
+{
+        uaf_max = simple_strtoul(str, NULL, 0);
+        return 1;
+}
+
+__setup("uaf=", uaf_setup);
+
+static void uaf_unmap(unsigned long address, unsigned long size);
+
+void uaf_init(void)
+{
+	struct page *page = NULL;
+	unsigned long addr;
+	int size, i;
+
+	printk("UAF: total vmalloc-space - %lu\n",
+			VMALLOC_END - VMALLOC_START);
+
+	uaf_area = get_vm_area(PAGE_SIZE * uaf_max, VM_ALLOC);
+	if (!uaf_area) {
+		printk(KERN_ALERT "UAF: can't reserve %lu bytes in KVA\n",
+				PAGE_SIZE * uaf_max);
+		return;
+	}
+	
+	printk("UAF: reserved %lu bytes in KVA at 0x%p\n",
+			PAGE_SIZE * uaf_max, uaf_area->addr);
+
+	/* how many bytes we need to track space usage? */
+	size = uaf_max / 8 + 8;
+
+	uaf_bitmap = vmalloc(size);
+	if (!uaf_bitmap) {
+		printk(KERN_ALERT
+			"UAF: can't allocate %d bytes for bitmap\n", size);
+		goto out;
+	}
+	memset(uaf_bitmap, 0, size);
+	spin_lock_init(&uaf_lock);
+	memset(uaf_stats, 0, sizeof(uaf_stats));
+
+	printk("UAF: allocated %d for bitmap\n", size);
+	
+	/* we have to allocate all needed page table because we gonna
+	 * call map_vm_are() with interrupts disabled */
+	page = alloc_page(GFP_KERNEL);
+	if (!page) {
+		printk(KERN_ALERT "UAF: can't allocate page!\n");
+		goto out;
+	}
+	addr = (unsigned long) uaf_area->addr;
+	for (i = 0; i < uaf_max; i++, addr += PAGE_SIZE) {
+		struct page *ptrs[1];
+		struct vm_struct area;
+		struct page **pages;
+		int err;
+
+		area.addr = (void *) addr;
+		area.size = PAGE_SIZE * 2;
+		ptrs[0] = page;
+		pages = (struct page **) ptrs;
+		err = map_vm_area(&area, PAGE_KERNEL, &pages);
+		if (err) {
+			printk(KERN_ALERT "UAF: can't map at 0x%lx\n", addr);
+			goto out;
+		}
+		uaf_unmap(addr, PAGE_SIZE);
+		
+	}
+	__free_page(page);
+	return;
+
+out:
+	if (uaf_bitmap)
+		vfree(uaf_bitmap);
+	if (page)
+		__free_page(page);
+	uaf_bitmap = NULL;
+}
+
+static inline int uaf_find(int len)
+{
+	int i;
+
+	i = find_next_zero_bit(uaf_bitmap, uaf_max, uaf_last_found);
+	if (i >= uaf_max) {
+		i = find_next_zero_bit(uaf_bitmap, uaf_max, 0);
+		if (i >= uaf_max)
+			return -1;
+	}
+
+	/* found! */
+	uaf_last_found = i + 1;
+	if (uaf_last_found >= uaf_max)
+		uaf_last_found = 0;
+	return i;
+}
+
+void * uaf_alloc(kmem_cache_t *cachep, int gfp_mask)
+{
+	struct page *ptrs[MAX_UAF_OBJ_SIZE];
+	int size = cachep->objsize;
+	struct vm_struct area;
+	struct page **pages;
+	unsigned long flags;
+	unsigned long addr;
+	int i, j, err = -2000;
+
+	if (uaf_bitmap == NULL)
+		return NULL;
+
+	if (!(cachep->flags & SLAB_USE_UAF))
+		return NULL;
+
+	pages = (struct page **) ptrs;
+	size = (size + (PAGE_SIZE - 1)) / PAGE_SIZE;
+	if (size > MAX_UAF_OBJ_SIZE) {
+		printk(KERN_ALERT "size is too big: %d\n", size);
+		return NULL;
+	}
+
+	if (uaf_used == uaf_max) {
+		atomic_inc(&uaf_stats[size].uaf_failed);
+		return NULL;
+	}
+
+	spin_lock_irqsave(&uaf_lock, flags);
+	i = uaf_find(size);
+	if (i < 0) {
+		spin_unlock_irqrestore(&uaf_lock, flags);
+		atomic_inc(&uaf_stats[size].uaf_failed);
+		return NULL;
+	}
+	for (j = 0; j < size; j++) {
+		BUG_ON(test_bit(i + j, uaf_bitmap));
+		set_bit(i + j, uaf_bitmap);
+		uaf_used++;
+	}
+	spin_unlock_irqrestore(&uaf_lock, flags);
+
+	/* OK. we've found free space, let's allocate pages */
+	addr = ((unsigned long) uaf_area->addr) + (PAGE_SIZE * i);
+	memset(pages, 0, sizeof(struct page *) * MAX_UAF_OBJ_SIZE);
+	for (j = 0; j < size; j++) {
+		pages[j] = alloc_page(gfp_mask);
+		if (pages[j] == NULL)
+			goto nomem;
+	}
+
+	/* time to map just allocated pages */
+	area.addr = (void *) addr;
+	area.size = PAGE_SIZE * size + PAGE_SIZE;
+
+	/* map_vm_area(), holding page_table_lock, -> IRQ -> a driver ->
+	 *  -> kmalloc -> uaf_alloc ->map_vm_area() try to acquire
+	 * page_table_lock -> deadlock. therefore, disable irqs */
+	local_irq_save(flags);
+	local_irq_disable();
+	err = map_vm_area(&area, PAGE_KERNEL, &pages);
+	local_irq_restore(flags);
+	pages = (struct page **) ptrs;
+	if (err == 0) {
+		/* put slab cache pointer in first page */
+		ptrs[0]->list.next = (void *) cachep;
+		atomic_inc(&uaf_stats[size].uaf_allocated);
+		atomic_inc(&uaf_stats[size].uaf_allocations);
+		if (!irqs_disabled() && !in_interrupt() && !in_softirq())
+			flush_tlb_kernel_range((unsigned long) area->addr, end);
+		else
+			local_flush_tlb();
+		return (void *) addr;
+	}
+
+nomem:
+	for (j = 0; j < size; j++)
+		if (pages[j])
+			__free_page(pages[j]);
+
+	/* can't find free pages */
+	spin_lock_irqsave(&uaf_lock, flags);
+	for (j = 0; j < size; j++) {
+		clear_bit(i + j, uaf_bitmap);
+		uaf_used--;
+	}
+	spin_unlock_irqrestore(&uaf_lock, flags);
+	atomic_inc(&uaf_stats[size].uaf_failed);
+
+	return NULL;
+}
+
+extern void unmap_area_pmd(pgd_t *dir, unsigned long address,
+				  unsigned long size);
+static void uaf_unmap(unsigned long address, unsigned long size)
+{
+	unsigned long end = (address + size);
+	pgd_t *dir;
+
+	dir = pgd_offset_k(address);
+	flush_cache_vunmap(address, end);
+	do {
+		unmap_area_pmd(dir, address, end - address);
+		address = (address + PGDIR_SIZE) & PGDIR_MASK;
+		dir++;
+	} while (address && (address < end));
+
+	/*
+	 * we must not call smp_call_function() with interrtups disabled
+	 * otherwise we can get into deadlock
+	 */
+	if (!irqs_disabled() && !in_interrupt() && !in_softirq())
+		flush_tlb_kernel_range((unsigned long) area->addr, end);
+	else
+		local_flush_tlb();
+}
+
+/*
+ * returns 1 if free was successfull
+ */
+int uaf_cache_free(kmem_cache_t *cachep, void *addr)
+{
+	struct page *pages[MAX_UAF_OBJ_SIZE];
+	int size = cachep->objsize;
+	unsigned long flags;
+	int i, j;
+
+	size = (size + (PAGE_SIZE - 1)) / PAGE_SIZE;
+	if (size > MAX_UAF_OBJ_SIZE)
+		return 0;
+
+	if (uaf_bitmap == NULL)
+		return 0;
+
+	/* first, check is address is in UAF space */
+	if ((unsigned) addr < (unsigned) uaf_area->addr ||
+		(unsigned) addr >= (unsigned) uaf_area->addr + uaf_area->size)
+		return 0;
+	
+	/* calculate placement in bitmap */
+	BUG_ON((unsigned long) addr & ~PAGE_MASK);
+	i = (unsigned) addr - (unsigned) uaf_area->addr;
+	i = i / PAGE_SIZE;
+
+	/* collect all the pages */
+	/* NOTE: we need not page_table_lock here. bits in bitmap
+	 * protect those pte's from to be reused */
+	for (j = 0; j < size; j++) {
+		unsigned long address;
+		address = ((unsigned long) addr) + (PAGE_SIZE * j);
+		pages[j] = vmalloc_to_page((void *) address);
+	}
+	
+	/* now unmap underlying page */
+	uaf_unmap((unsigned long) addr, PAGE_SIZE * size);
+
+	/* free all the pages */
+	for (j = 0; j < size; j++)
+		__free_page(pages[j]);
+
+	spin_lock_irqsave(&uaf_lock, flags);
+	for (j = 0; j < size; j++) {
+		BUG_ON(i+j < 0 && i+j >= uaf_max);
+		BUG_ON(!test_bit(i+j, uaf_bitmap));
+		/* now free space in UAF */
+		clear_bit(i+j, uaf_bitmap);
+		uaf_used--;
+	}
+	spin_unlock_irqrestore(&uaf_lock, flags);
+	atomic_dec(&uaf_stats[size].uaf_allocated);
+
+	return 1;
+}
+
+struct page *uaf_vaddr_to_page(void *obj)
+{
+	if (uaf_bitmap == NULL)
+		return 0;
+
+	/* first, check is address is in UAF space */
+	if ((unsigned) obj < (unsigned) uaf_area->addr ||
+		(unsigned) obj >= (unsigned) uaf_area->addr + uaf_area->size)
+		return 0;
+	
+	return vmalloc_to_page(obj);
+}
+
+int uaf_free(void *obj)
+{
+	struct page *page = uaf_vaddr_to_page((void *) obj);
+	kmem_cache_t *c;
+
+	if (!page)
+		return 0;
+
+	c = GET_PAGE_CACHE(page);
+	return uaf_cache_free(c, (void *) obj);
+}
+
+int uaf_is_allocated(void *obj)
+{
+	unsigned long addr = (unsigned long) obj;
+	int i;
+
+	if (uaf_bitmap == NULL)
+		return 0;
+
+	addr &= PAGE_MASK;
+	/* first, check is address is in UAF space */
+	if (addr < (unsigned long) uaf_area->addr ||
+			addr >= (unsigned long) uaf_area->addr + uaf_area->size)
+		return 0;
+
+	/* calculate placement in bitmap */
+	i = (unsigned) addr - (unsigned) uaf_area->addr;
+	i = i / PAGE_SIZE;
+	return test_bit(i, uaf_bitmap);
+}
+
+static void *uaf_s_start(struct seq_file *m, loff_t *pos)
+{
+	loff_t n = *pos;
+
+	if (!n)
+		seq_printf(m, "size(pgs) allocated failed allocations. "
+				"%d reserved, %d in use, %d last\n",
+				uaf_max, uaf_used, uaf_last_found);
+	else if (n > MAX_UAF_OBJ_SIZE)
+		return NULL;
+
+	*pos = 1;
+	return (void *) 1;
+}
+
+static void *uaf_s_next(struct seq_file *m, void *p, loff_t *pos)
+{
+	unsigned long n = *pos;
+	++*pos;
+	if (n + 1 > MAX_UAF_OBJ_SIZE)
+		return NULL;
+	return (void *) (n + 1);
+}
+
+static void uaf_s_stop(struct seq_file *m, void *p)
+{
+}
+
+static int uaf_s_show(struct seq_file *m, void *p)
+{
+	int n = (int) p;
+
+	if (n > MAX_UAF_OBJ_SIZE)
+		return 0;
+	seq_printf(m, "%d  %d  %d %d\n", n, 
+			atomic_read(&uaf_stats[n].uaf_allocated),
+			atomic_read(&uaf_stats[n].uaf_failed),
+			atomic_read(&uaf_stats[n].uaf_allocations));
+	return 0;
+}
+
+struct seq_operations uafinfo_op = {
+	.start	= uaf_s_start,
+	.next	= uaf_s_next,
+	.stop	= uaf_s_stop,
+	.show	= uaf_s_show,
+};
+
+ssize_t uafinfo_write(struct file *file, const char __user *buffer,
+				size_t count, loff_t *ppos)
+{
+	char kbuf[MAX_SLABINFO_WRITE+1], *tmp;
+	char *key, *name;
+	int res;
+	struct list_head *p;
+	
+	if (count > MAX_SLABINFO_WRITE)
+		return -EINVAL;
+	if (copy_from_user(&kbuf, buffer, count))
+		return -EFAULT;
+	kbuf[MAX_SLABINFO_WRITE] = '\0'; 
+
+	tmp = kbuf;
+	key = strsep(&tmp, " \t\n");
+	if (!key)
+		return -EINVAL;
+	if (!strcmp(key, "on"))
+		res = 1;
+	else if (!strcmp(key, "off"))
+		res = 0;
+	else
+		return -EINVAL;
+
+	name = strsep(&tmp, " \t\n");
+	if (!name)
+		return -EINVAL;
+
+	/* Find the cache in the chain of caches. */
+	down(&cache_chain_sem);
+	list_for_each(p,&cache_chain) {
+		kmem_cache_t *cachep = list_entry(p, kmem_cache_t, next);
+
+		if (!strcmp(cachep->name, name)) {
+			if (res) {
+				printk("UAF: use on %s\n", cachep->name);
+				cachep->flags |= SLAB_USE_UAF;
+			} else {
+				printk("UAF: dont use on %s\n", cachep->name);
+				cachep->flags &= ~SLAB_USE_UAF;
+			}
+			break;
+		}
+	}
+	up(&cache_chain_sem);
+	return count;
+}
+#endif
Index: linux-2.6.0-test5/init/main.c
===================================================================
--- linux-2.6.0-test5.orig/init/main.c	2003-11-19 20:49:10.000000000 +0300
+++ linux-2.6.0-test5/init/main.c	2003-11-19 20:50:47.000000000 +0300
@@ -466,6 +466,9 @@
 	 */
 	init_idle(current, smp_processor_id());
 
+#ifdef CONFIG_DEBUG_UAF
+	uaf_init();
+#endif
 	/* Do the rest non-__init'ed, we're now alive */
 	rest_init();
 }
Index: linux-2.6.0-test5/arch/i386/Kconfig
===================================================================
--- linux-2.6.0-test5.orig/arch/i386/Kconfig	2003-11-19 20:47:59.000000000 +0300
+++ linux-2.6.0-test5/arch/i386/Kconfig	2003-11-19 20:50:47.000000000 +0300
@@ -1145,6 +1145,11 @@
 	  allocation as well as poisoning memory on free to catch use of freed
 	  memory.
 
+config DEBUG_UAF
+	bool "Debug memory allocations (use-after-free)"
+	depends on DEBUG_SLAB
+	help
+
 config DEBUG_IOVIRT
 	bool "Memory mapped I/O debugging"
 	depends on DEBUG_KERNEL
Index: linux-2.6.0-test5/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.0-test5.orig/fs/proc/proc_misc.c	2003-11-19 20:47:53.000000000 +0300
+++ linux-2.6.0-test5/fs/proc/proc_misc.c	2003-11-19 20:50:47.000000000 +0300
@@ -356,6 +356,22 @@
 	.release	= seq_release,
 };
 
+#ifdef CONFIG_DEBUG_UAF
+extern struct seq_operations uafinfo_op;
+extern ssize_t uafinfo_write(struct file *, const char __user *, size_t, loff_t *);
+static int uafinfo_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &uafinfo_op);
+}
+static struct file_operations proc_uafinfo_operations = {
+	.open		= uafinfo_open,
+	.read		= seq_read,
+	.write		= uafinfo_write,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+#endif
+
 int show_stat(struct seq_file *p, void *v)
 {
 	int i;
@@ -679,6 +695,9 @@
 	create_seq_entry("stat", 0, &proc_stat_operations);
 	create_seq_entry("interrupts", 0, &proc_interrupts_operations);
 	create_seq_entry("slabinfo",S_IWUSR|S_IRUGO,&proc_slabinfo_operations);
+#ifdef CONFIG_DEBUG_UAF
+	create_seq_entry("uafinfo",S_IWUSR|S_IRUGO,&proc_uafinfo_operations);
+#endif
 	create_seq_entry("buddyinfo",S_IRUGO, &fragmentation_file_operations);
 	create_seq_entry("vmstat",S_IRUGO, &proc_vmstat_file_operations);
 	create_seq_entry("diskstats", 0, &proc_diskstats_operations);
Index: linux-2.6.0-test5/include/linux/slab.h
===================================================================
--- linux-2.6.0-test5.orig/include/linux/slab.h	2003-07-24 15:52:31.000000000 +0400
+++ linux-2.6.0-test5/include/linux/slab.h	2003-11-19 20:50:47.000000000 +0300
@@ -46,6 +46,7 @@
 #define SLAB_STORE_USER		0x00010000UL	/* store the last owner for bug hunting */
 #define SLAB_RECLAIM_ACCOUNT	0x00020000UL	/* track pages allocated to indicate
 						   what is reclaimable later*/
+#define SLAB_USE_UAF		0x00040000UL	/* use UAF allocator */
 
 /* flags passed to a constructor func */
 #define	SLAB_CTOR_CONSTRUCTOR	0x001UL		/* if not set, then deconstructor */
Index: linux-2.6.0-test5/include/asm-i386/page.h
===================================================================
--- linux-2.6.0-test5.orig/include/asm-i386/page.h	2003-05-15 20:10:04.000000000 +0400
+++ linux-2.6.0-test5/include/asm-i386/page.h	2003-11-19 20:52:20.000000000 +0300
@@ -132,7 +132,19 @@
 #define page_to_pfn(page)	((unsigned long)((page) - mem_map))
 #define pfn_valid(pfn)		((pfn) < max_mapnr)
 #endif /* !CONFIG_DISCONTIGMEM */
+#ifndef CONFIG_DEBUG_UAF
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
+#else
+#define virt_to_page(ka) ({							\
+				struct page *_p;				\
+				if ((unsigned long)(ka) >= VMALLOC_START) {	\
+					_p = vmalloc_to_page((void *)(ka));	\
+					BUG_ON(!_p);				\
+				} else 						\
+					_p = mem_map+(__pa(ka) >> PAGE_SHIFT);	\
+				(_p);						\
+			})
+#endif
 
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 
Index: linux-2.6.0-test5/include/asm-i386/io.h
===================================================================
--- linux-2.6.0-test5.orig/include/asm-i386/io.h	2003-05-15 20:09:43.000000000 +0400
+++ linux-2.6.0-test5/include/asm-i386/io.h	2003-11-19 20:50:47.000000000 +0300
@@ -43,6 +43,7 @@
 
 #ifdef __KERNEL__
 
+#include <linux/mm.h>
 #include <linux/vmalloc.h>
 
 /*
@@ -71,6 +72,16 @@
  
 static inline unsigned long virt_to_phys(volatile void * address)
 {
+#ifdef CONFIG_DEBUG_UAF
+	unsigned long addr = (unsigned long) address;
+	if (vmlist && addr >= VMALLOC_START && addr < VMALLOC_END) {
+		struct page *page = vmalloc_to_page((void *) address);
+		if (page) {
+			unsigned long offset = addr & ~PAGE_MASK;
+			address = page_address(page) + offset;
+		}
+	}
+#endif
 	return __pa(address);
 }
 
Index: linux-2.6.0-test5/mm/vmalloc.c
===================================================================
--- linux-2.6.0-test5.orig/mm/vmalloc.c	2003-11-19 20:48:01.000000000 +0300
+++ linux-2.6.0-test5/mm/vmalloc.c	2003-11-19 21:05:35.000000000 +0300
@@ -57,7 +57,7 @@
 	} while (address < end);
 }
 
-static void unmap_area_pmd(pgd_t *dir, unsigned long address,
+void unmap_area_pmd(pgd_t *dir, unsigned long address,
 				  unsigned long size)
 {
 	unsigned long end;

%diffstat
 arch/i386/Kconfig       |    5 
 fs/proc/proc_misc.c     |   19 +
 include/asm-i386/io.h   |   11 +
 include/asm-i386/page.h |   12 +
 include/linux/slab.h    |    1 
 init/main.c             |    3 
 mm/slab.c               |  465 ++++++++++++++++++++++++++++++++++++++++++++++++
 mm/vmalloc.c            |    2 
 8 files changed, 517 insertions(+), 1 deletion(-)


