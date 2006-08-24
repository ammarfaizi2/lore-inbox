Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbWHXP1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbWHXP1V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 11:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965064AbWHXP1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 11:27:21 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:18605 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965009AbWHXP1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 11:27:19 -0400
Subject: [PATCH 3/4] Add __global tag where needed.
From: David Woodhouse <dwmw2@infradead.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1156429585.3012.58.camel@pmac.infradead.org>
References: <1156429585.3012.58.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 16:26:52 +0100
Message-Id: <1156433212.3012.120.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch just adds the __global tag to functions and variables which
are used from outside the directory in which they're provided, to
prevent -fwhole-program from eating them.

If we just define __global as a dummy for now, then there's no harm in
applying this patch as-is -- but it's largely pointless without the
Makefile changes.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/arch/i386/mm/extable.c b/arch/i386/mm/extable.c
index de03c54..68a2409 100644
--- a/arch/i386/mm/extable.c
+++ b/arch/i386/mm/extable.c
@@ -6,7 +6,7 @@ #include <linux/module.h>
 #include <linux/spinlock.h>
 #include <asm/uaccess.h>
 
-int fixup_exception(struct pt_regs *regs)
+int __global fixup_exception(struct pt_regs *regs)
 {
 	const struct exception_table_entry *fixup;
 
diff --git a/arch/i386/mm/fault.c b/arch/i386/mm/fault.c
index f727946..f8f90b2 100644
--- a/arch/i386/mm/fault.c
+++ b/arch/i386/mm/fault.c
@@ -32,13 +32,13 @@ extern void die(const char *,struct pt_r
 
 #ifdef CONFIG_KPROBES
 ATOMIC_NOTIFIER_HEAD(notify_page_fault_chain);
-int register_page_fault_notifier(struct notifier_block *nb)
+int __global register_page_fault_notifier(struct notifier_block *nb)
 {
 	vmalloc_sync_all();
 	return atomic_notifier_chain_register(&notify_page_fault_chain, nb);
 }
 
-int unregister_page_fault_notifier(struct notifier_block *nb)
+int __global unregister_page_fault_notifier(struct notifier_block *nb)
 {
 	return atomic_notifier_chain_unregister(&notify_page_fault_chain, nb);
 }
@@ -325,8 +325,8 @@ static inline int vmalloc_fault(unsigned
  *	bit 3 == 1 means use of reserved bit detected
  *	bit 4 == 1 means fault was an instruction fetch
  */
-fastcall void __kprobes do_page_fault(struct pt_regs *regs,
-				      unsigned long error_code)
+fastcall void __kprobes __global do_page_fault(struct pt_regs *regs,
+					       unsigned long error_code)
 {
 	struct task_struct *tsk;
 	struct mm_struct *mm;
@@ -626,7 +626,7 @@ do_sigbus:
 }
 
 #ifndef CONFIG_X86_PAE
-void vmalloc_sync_all(void)
+void __global vmalloc_sync_all(void)
 {
 	/*
 	 * Note that races in the updates of insync and start aren't
diff --git a/arch/i386/mm/hugetlbpage.c b/arch/i386/mm/hugetlbpage.c
index 1719a81..2820b17 100644
--- a/arch/i386/mm/hugetlbpage.c
+++ b/arch/i386/mm/hugetlbpage.c
@@ -17,7 +17,7 @@ #include <asm/mman.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
-pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
+pte_t * __global huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	pud_t *pud;
@@ -32,7 +32,7 @@ pte_t *huge_pte_alloc(struct mm_struct *
 	return pte;
 }
 
-pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
+pte_t * __global huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
 	pud_t *pud;
@@ -48,7 +48,7 @@ pte_t *huge_pte_offset(struct mm_struct 
 }
 
 #if 0	/* This is just for testing */
-struct page *
+struct page * __global
 follow_huge_addr(struct mm_struct *mm, unsigned long address, int write)
 {
 	unsigned long start = address;
@@ -87,18 +87,18 @@ follow_huge_pmd(struct mm_struct *mm, un
 
 #else
 
-struct page *
+struct page * __global
 follow_huge_addr(struct mm_struct *mm, unsigned long address, int write)
 {
 	return ERR_PTR(-EINVAL);
 }
 
-int pmd_huge(pmd_t pmd)
+int __global pmd_huge(pmd_t pmd)
 {
 	return !!(pmd_val(pmd) & _PAGE_PSE);
 }
 
-struct page *
+struct page * __global
 follow_huge_pmd(struct mm_struct *mm, unsigned long address,
 		pmd_t *pmd, int write)
 {
@@ -245,7 +245,7 @@ fail:
 	return addr;
 }
 
-unsigned long
+unsigned long __global
 hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
diff --git a/arch/i386/mm/init.c b/arch/i386/mm/init.c
index 89e8486..89661e2 100644
--- a/arch/i386/mm/init.c
+++ b/arch/i386/mm/init.c
@@ -43,9 +43,9 @@ #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 #include <asm/sections.h>
 
-unsigned int __VMALLOC_RESERVE = 128 << 20;
+unsigned int __global __VMALLOC_RESERVE = 128 << 20;
 
-DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
+__global DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 unsigned long highstart_pfn, highend_pfn;
 
 static int noinline do_test_wp_bit(void);
@@ -329,7 +329,7 @@ #endif /* CONFIG_HIGHMEM */
 
 unsigned long long __PAGE_KERNEL = _PAGE_KERNEL;
 EXPORT_SYMBOL(__PAGE_KERNEL);
-unsigned long long __PAGE_KERNEL_EXEC = _PAGE_KERNEL_EXEC;
+unsigned long long __global __PAGE_KERNEL_EXEC = _PAGE_KERNEL_EXEC;
 
 #ifdef CONFIG_NUMA
 extern void __init remap_numa_kva(void);
@@ -390,7 +390,7 @@ #if defined(CONFIG_SOFTWARE_SUSPEND) || 
  * Swap suspend & friends need this for resume because things like the intel-agp
  * driver might have split up a kernel 4MB mapping.
  */
-char __nosavedata swsusp_pg_dir[PAGE_SIZE]
+char __nosavedata __global swsusp_pg_dir[PAGE_SIZE]
 	__attribute__ ((aligned (PAGE_SIZE)));
 
 static inline void save_pg_dir(void)
@@ -435,7 +435,7 @@ u64 __supported_pte_mask __read_mostly =
  * on      Enable
  * off     Disable
  */
-void __init noexec_setup(const char *str)
+void __init __global noexec_setup(const char *str)
 {
 	if (!strncmp(str, "on",2) && cpu_has_nx) {
 		__supported_pte_mask |= _PAGE_NX;
@@ -446,7 +446,7 @@ void __init noexec_setup(const char *str
 	}
 }
 
-int nx_enabled = 0;
+int __global nx_enabled = 0;
 #ifdef CONFIG_X86_PAE
 
 static void __init set_nx(void)
@@ -501,7 +501,7 @@ #endif
  * This routines also unmaps the page at virtual kernel address 0, so
  * that we can trap those pesky NULL-reference errors in the kernel.
  */
-void __init paging_init(void)
+void __init __global paging_init(void)
 {
 #ifdef CONFIG_X86_PAE
 	set_nx();
@@ -566,7 +566,7 @@ #endif
 
 static struct kcore_list kcore_mem, kcore_vmalloc; 
 
-void __init mem_init(void)
+void __init __global mem_init(void)
 {
 	extern int ppro_with_ram_bug(void);
 	int codesize, reservedpages, datasize, initsize;
@@ -674,7 +674,7 @@ #endif
 kmem_cache_t *pgd_cache;
 kmem_cache_t *pmd_cache;
 
-void __init pgtable_cache_init(void)
+void __init __global pgtable_cache_init(void)
 {
 	if (PTRS_PER_PMD > 1) {
 		pmd_cache = kmem_cache_create("pmd",
@@ -725,7 +725,7 @@ static int noinline do_test_wp_bit(void)
 
 #ifdef CONFIG_DEBUG_RODATA
 
-void mark_rodata_ro(void)
+void __global mark_rodata_ro(void)
 {
 	unsigned long addr = (unsigned long)__start_rodata;
 
@@ -745,7 +745,7 @@ void mark_rodata_ro(void)
 }
 #endif
 
-void free_init_pages(char *what, unsigned long begin, unsigned long end)
+void __global free_init_pages(char *what, unsigned long begin, unsigned long end)
 {
 	unsigned long addr;
 
@@ -759,7 +759,7 @@ void free_init_pages(char *what, unsigne
 	printk(KERN_INFO "Freeing %s: %ldk freed\n", what, (end - begin) >> 10);
 }
 
-void free_initmem(void)
+void __global free_initmem(void)
 {
 	free_init_pages("unused kernel memory",
 			(unsigned long)(&__init_begin),
@@ -767,7 +767,7 @@ void free_initmem(void)
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
+void __global free_initrd_mem(unsigned long start, unsigned long end)
 {
 	free_init_pages("initrd memory", start, end);
 }
diff --git a/arch/i386/mm/ioremap.c b/arch/i386/mm/ioremap.c
index 247fde7..5340869 100644
--- a/arch/i386/mm/ioremap.c
+++ b/arch/i386/mm/ioremap.c
@@ -280,7 +280,7 @@ void iounmap(volatile void __iomem *addr
 }
 EXPORT_SYMBOL(iounmap);
 
-void __init *bt_ioremap(unsigned long phys_addr, unsigned long size)
+void __init __global *bt_ioremap(unsigned long phys_addr, unsigned long size)
 {
 	unsigned long offset, last_addr;
 	unsigned int nrpages;
@@ -324,7 +324,7 @@ void __init *bt_ioremap(unsigned long ph
 	return (void*) (offset + fix_to_virt(FIX_BTMAP_BEGIN));
 }
 
-void __init bt_iounmap(void *addr, unsigned long size)
+void __init __global bt_iounmap(void *addr, unsigned long size)
 {
 	unsigned long virt_addr;
 	unsigned long offset;
diff --git a/arch/i386/mm/mmap.c b/arch/i386/mm/mmap.c
index e4730a1..ec8f27e 100644
--- a/arch/i386/mm/mmap.c
+++ b/arch/i386/mm/mmap.c
@@ -56,7 +56,7 @@ static inline unsigned long mmap_base(st
  * This function, called very early during the creation of a new
  * process VM image, sets up which VM layout function to use:
  */
-void arch_pick_mmap_layout(struct mm_struct *mm)
+void __global arch_pick_mmap_layout(struct mm_struct *mm)
 {
 	/*
 	 * Fall back to the standard layout if the personality
diff --git a/arch/i386/mm/pgtable.c b/arch/i386/mm/pgtable.c
index bd98768..6161dd9 100644
--- a/arch/i386/mm/pgtable.c
+++ b/arch/i386/mm/pgtable.c
@@ -21,7 +21,7 @@ #include <asm/e820.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
-void show_mem(void)
+void __global show_mem(void)
 {
 	int total = 0, reserved = 0;
 	int shared = 0, cached = 0;
@@ -137,7 +137,7 @@ void set_pmd_pfn(unsigned long vaddr, un
 	__flush_tlb_one(vaddr);
 }
 
-void __set_fixmap (enum fixed_addresses idx, unsigned long phys, pgprot_t flags)
+void __global __set_fixmap (enum fixed_addresses idx, unsigned long phys, pgprot_t flags)
 {
 	unsigned long address = __fix_to_virt(idx);
 
@@ -148,12 +148,12 @@ void __set_fixmap (enum fixed_addresses 
 	set_pte_pfn(address, phys >> PAGE_SHIFT, flags);
 }
 
-pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
+pte_t * __global pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
 	return (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
 }
 
-struct page *pte_alloc_one(struct mm_struct *mm, unsigned long address)
+struct page * __global pte_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	struct page *pte;
 
@@ -234,7 +234,7 @@ void pgd_dtor(void *pgd, kmem_cache_t *c
 	spin_unlock_irqrestore(&pgd_lock, flags);
 }
 
-pgd_t *pgd_alloc(struct mm_struct *mm)
+pgd_t * __global pgd_alloc(struct mm_struct *mm)
 {
 	int i;
 	pgd_t *pgd = kmem_cache_alloc(pgd_cache, GFP_KERNEL);
@@ -257,7 +257,7 @@ out_oom:
 	return NULL;
 }
 
-void pgd_free(pgd_t *pgd)
+void __global pgd_free(pgd_t *pgd)
 {
 	int i;
 
diff --git a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
index ebf961f..d6f5437 100644
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1056,7 +1056,7 @@ pmac_ide_get_irq(unsigned long base)
 
 static int ide_majors[] = { 3, 22, 33, 34, 56, 57 };
 
-dev_t __init
+dev_t __init __global
 pmac_find_ide_boot(char *bootdevice, int n)
 {
 	int i;
diff --git a/drivers/md/md.c b/drivers/md/md.c
index b6d1602..11cc13a 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2887,7 +2887,7 @@ static struct kobj_type md_ktype = {
 	.default_attrs	= md_default_attrs,
 };
 
-int mdp_major = 0;
+int __global mdp_major = 0;
 
 static struct kobject *md_probe(dev_t dev, int *part, void *data)
 {
@@ -5578,13 +5578,12 @@ #ifndef MODULE
 static dev_t detected_devices[128];
 static int dev_cnt;
 
-void md_autodetect_dev(dev_t dev)
+void __global md_autodetect_dev(dev_t dev)
 {
 	if (dev_cnt >= 0 && dev_cnt < 127)
 		detected_devices[dev_cnt++] = dev;
 }
 
-
 static void autostart_arrays(int part)
 {
 	mdk_rdev_t *rdev;
diff --git a/drivers/video/fbcvt.c b/drivers/video/fbcvt.c
index b549899..baac324 100644
--- a/drivers/video/fbcvt.c
+++ b/drivers/video/fbcvt.c
@@ -301,7 +301,7 @@ static void fb_cvt_convert_to_mode(struc
  * DESCRIPTION:
  * Computes video timings using VESA(TM) Coordinated Video Timings
  */
-int fb_find_mode_cvt(struct fb_videomode *mode, int margins, int rb)
+int __global fb_find_mode_cvt(struct fb_videomode *mode, int margins, int rb)
 {
 	struct fb_cvt_data cvt;
 
diff --git a/fs/aio.c b/fs/aio.c
index 9506301..3290a73 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -42,8 +42,8 @@ #endif
 
 /*------ sysctl variables----*/
 static DEFINE_SPINLOCK(aio_nr_lock);
-unsigned long aio_nr;		/* current system wide number of aio requests */
-unsigned long aio_max_nr = 0x10000; /* system wide maximum number of aio requests */
+unsigned long __global aio_nr;		/* current system wide number of aio requests */
+unsigned long __global aio_max_nr = 0x10000; /* system wide maximum number of aio requests */
 /*----end sysctl variables---*/
 
 static kmem_cache_t	*kiocb_cachep;
@@ -332,7 +332,7 @@ ssize_t fastcall wait_on_sync_kiocb(stru
  * go away, they will call put_ioctx and release any pinned memory
  * associated with the request (held via struct page * references).
  */
-void fastcall exit_aio(struct mm_struct *mm)
+void fastcall __global exit_aio(struct mm_struct *mm)
 {
 	struct kioctx *ctx = mm->ioctx_list;
 	mm->ioctx_list = NULL;
diff --git a/fs/bio.c b/fs/bio.c
index 6a0b9ad..049afc4 100644
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -745,9 +746,9 @@ struct bio *bio_map_user(request_queue_t
  *	Map the user space address into a bio suitable for io to a block
  *	device. Returns an error pointer in case of error.
  */
-struct bio *bio_map_user_iov(request_queue_t *q, struct block_device *bdev,
-			     struct sg_iovec *iov, int iov_count,
-			     int write_to_vm)
+struct bio * __global bio_map_user_iov(request_queue_t *q, struct block_device *bdev,
+				       struct sg_iovec *iov, int iov_count,
+				       int write_to_vm)
 {
 	struct bio *bio;
 	int len = 0, i;
@@ -917,7 +918,7 @@ struct bio *bio_map_kern(request_queue_t
 /*
  * bio_set_pages_dirty() will mark all the bio's pages as dirty.
  */
-void bio_set_pages_dirty(struct bio *bio)
+void __global bio_set_pages_dirty(struct bio *bio)
 {
 	struct bio_vec *bvec = bio->bi_io_vec;
 	int i;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 3753457..de38fb4 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -388,7 +388,7 @@ struct block_device *bdget(dev_t dev)
 
 EXPORT_SYMBOL(bdget);
 
-long nr_blockdev_pages(void)
+long __global nr_blockdev_pages(void)
 {
 	struct list_head *p;
 	long ret = 0;
diff --git a/fs/buffer.c b/fs/buffer.c
index 71649ef..4073846 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -284,7 +284,7 @@ asmlinkage long sys_sync(void)
 	return 0;
 }
 
-void emergency_sync(void)
+void __global emergency_sync(void)
 {
 	pdflush_operation(do_sync, 0);
 }
@@ -318,7 +318,7 @@ int file_fsync(struct file *filp, struct
 	return ret;
 }
 
-long do_fsync(struct file *file, int datasync)
+long __global do_fsync(struct file *file, int datasync)
 {
 	int ret;
 	int err;
@@ -1630,7 +1630,7 @@ out:
 }
 EXPORT_SYMBOL(block_invalidatepage);
 
-void do_invalidatepage(struct page *page, unsigned long offset)
+void __global do_invalidatepage(struct page *page, unsigned long offset)
 {
 	void (*invalidatepage)(struct page *, unsigned long);
 	invalidatepage = page->mapping->a_ops->invalidatepage ? :
@@ -3061,7 +3061,7 @@ static kmem_cache_t *bh_cachep;
  */
 static int max_buffer_heads;
 
-int buffer_heads_over_limit;
+int __global buffer_heads_over_limit;
 
 struct bh_accounting {
 	int nr;			/* Number of live bh's */
@@ -3141,7 +3141,7 @@ static int buffer_cpu_notify(struct noti
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
-void __init buffer_init(void)
+void __init __global buffer_init(void)
 {
 	int nrpages;
 
diff --git a/fs/char_dev.c b/fs/char_dev.c
index 3483d3c..236a7d1 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -46,7 +46,7 @@ static inline int major_to_index(int maj
 
 #ifdef CONFIG_PROC_FS
 
-void chrdev_show(struct seq_file *f, off_t offset)
+void __global chrdev_show(struct seq_file *f, off_t offset)
 {
 	struct char_device_struct *cd;
 
diff --git a/fs/compat.c b/fs/compat.c
index e31e9cf..b635d8f 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -55,7 +55,7 @@ #include <asm/ioctls.h>
 
 extern void sigset_from_compat(sigset_t *set, compat_sigset_t *compat);
 
-int compat_log = 1;
+int __global compat_log = 1;
 
 int compat_printk(const char *fmt, ...)
 {
@@ -1503,7 +1503,7 @@ #endif /* CONFIG_MMU */
  * compat_do_execve() is mostly a copy of do_execve(), with the exception
  * that it processes 32 bit argv and envp pointers.
  */
-int compat_do_execve(char * filename,
+int __global compat_do_execve(char * filename,
 	compat_uptr_t __user *argv,
 	compat_uptr_t __user *envp,
 	struct pt_regs * regs)
diff --git a/fs/dcache.c b/fs/dcache.c
index 1b4a3a3..c9e20bb 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -63,7 +63,7 @@ static struct hlist_head *dentry_hashtab
 static LIST_HEAD(dentry_unused);
 
 /* Statistics gathering. */
-struct dentry_stat_t dentry_stat = {
+struct dentry_stat_t __global dentry_stat = {
 	.age_limit = 45,
 };
 
@@ -1120,7 +1120,7 @@ next:
  *
  * On hash failure or on lookup failure NULL is returned.
  */
-struct dentry *d_hash_and_lookup(struct dentry *dir, struct qstr *name)
+struct dentry * __global d_hash_and_lookup(struct dentry *dir, struct qstr *name)
 {
 	struct dentry *dentry = NULL;
 
@@ -1745,13 +1745,13 @@ EXPORT_SYMBOL(d_genocide);
 extern void bdev_cache_init(void);
 extern void chrdev_init(void);
 
-void __init vfs_caches_init_early(void)
+void __init __global vfs_caches_init_early(void)
 {
 	dcache_init_early();
 	inode_init_early();
 }
 
-void __init vfs_caches_init(unsigned long mempages)
+void __init __global vfs_caches_init(unsigned long mempages)
 {
 	unsigned long reserve;
 
diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index f7aef5b..3b9f019 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -156,7 +156,7 @@ static struct dentry *get_node(int num)
 	return lookup_one_len(s, root, sprintf(s, "%d", num));
 }
 
-int devpts_pty_new(struct tty_struct *tty)
+int __global devpts_pty_new(struct tty_struct *tty)
 {
 	int number = tty->index;
 	struct tty_driver *driver = tty->driver;
@@ -188,7 +188,7 @@ int devpts_pty_new(struct tty_struct *tt
 	return 0;
 }
 
-struct tty_struct *devpts_get_tty(int number)
+struct tty_struct * __global devpts_get_tty(int number)
 {
 	struct dentry *dentry = get_node(number);
 	struct tty_struct *tty;
@@ -205,7 +205,7 @@ struct tty_struct *devpts_get_tty(int nu
 	return tty;
 }
 
-void devpts_pty_kill(int number)
+void __global devpts_pty_kill(int number)
 {
 	struct dentry *dentry = get_node(number);
 
diff --git a/fs/dnotify.c b/fs/dnotify.c
index f932591..c6c7ae3 100644
--- a/fs/dnotify.c
+++ b/fs/dnotify.c
@@ -21,7 +21,7 @@ #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 
-int dir_notify_enable __read_mostly = 1;
+int dir_notify_enable __global __read_mostly = 1;
 
 static kmem_cache_t *dn_cache __read_mostly;
 
diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 4e47623..dfc591b 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -10,7 +10,7 @@ #include <linux/sysctl.h>
 #include <linux/gfp.h>
 
 /* A global variable is a bit ugly, but it keeps the code simple */
-int sysctl_drop_caches;
+int __global sysctl_drop_caches;
 
 static void drop_pagecache_sb(struct super_block *sb)
 {
@@ -54,7 +54,7 @@ void drop_slab(void)
 	} while (nr_objects > 10);
 }
 
-int drop_caches_sysctl_handler(ctl_table *table, int write,
+int __global drop_caches_sysctl_handler(ctl_table *table, int write,
 	struct file *file, void __user *buffer, size_t *length, loff_t *ppos)
 {
 	proc_dointvec_minmax(table, write, file, buffer, length, ppos);
diff --git a/fs/exec.c b/fs/exec.c
index 8344ba7..d14f122 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -57,8 +57,8 @@ #ifdef CONFIG_KMOD
 #include <linux/kmod.h>
 #endif
 
-int core_uses_pid;
-char core_pattern[65] = "core";
+int __global core_uses_pid;
+char __global core_pattern[65] = "core";
 int suid_dumpable = 0;
 
 EXPORT_SYMBOL(suid_dumpable);
@@ -805,7 +805,7 @@ static void flush_old_files(struct files
 	spin_unlock(&files->file_lock);
 }
 
-void get_task_comm(char *buf, struct task_struct *tsk)
+void __global get_task_comm(char *buf, struct task_struct *tsk)
 {
 	/* buf must be at least sizeof(tsk->comm) in size */
 	task_lock(tsk);
@@ -813,7 +813,7 @@ void get_task_comm(char *buf, struct tas
 	task_unlock(tsk);
 }
 
-void set_task_comm(struct task_struct *tsk, char *buf)
+void __global set_task_comm(struct task_struct *tsk, char *buf)
 {
 	task_lock(tsk);
 	strlcpy(tsk->comm, buf, sizeof(tsk->comm));
@@ -1131,7 +1131,7 @@ EXPORT_SYMBOL(search_binary_handler);
 /*
  * sys_execve() executes a new program.
  */
-int do_execve(char * filename,
+int __global do_execve(char * filename,
 	char __user *__user *argv,
 	char __user *__user *envp,
 	struct pt_regs * regs)
@@ -1465,7 +1465,7 @@ fail:
 	return core_waiters;
 }
 
-int do_coredump(long signr, int exit_code, struct pt_regs * regs)
+int __global do_coredump(long signr, int exit_code, struct pt_regs * regs)
 {
 	char corename[CORENAME_MAX_SIZE + 1];
 	struct mm_struct *mm = current->mm;
diff --git a/fs/fcntl.c b/fs/fcntl.c
index d35cbc6..5f1c0eb 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -23,7 +23,7 @@ #include <asm/poll.h>
 #include <asm/siginfo.h>
 #include <asm/uaccess.h>
 
-void fastcall set_close_on_exec(unsigned int fd, int flag)
+void fastcall __global set_close_on_exec(unsigned int fd, int flag)
 {
 	struct files_struct *files = current->files;
 	struct fdtable *fdt;
@@ -467,7 +467,7 @@ static void send_sigio_to_task(struct ta
 	}
 }
 
-void send_sigio(struct fown_struct *fown, int fd, int band)
+void __global send_sigio(struct fown_struct *fown, int fd, int band)
 {
 	struct task_struct *p;
 	int pid;
@@ -500,7 +500,7 @@ static void send_sigurg_to_task(struct t
 		group_send_sig_info(SIGURG, SEND_SIG_PRIV, p);
 }
 
-int send_sigurg(struct fown_struct *fown)
+int __global send_sigurg(struct fown_struct *fown)
 {
 	struct task_struct *p;
 	int pid, ret = 0;
diff --git a/fs/file.c b/fs/file.c
index b3c6b82..af0fff5 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -50,7 +50,7 @@ struct file ** alloc_fd_array(int num)
 	return new_fds;
 }
 
-void free_fd_array(struct file **array, int num)
+void __global free_fd_array(struct file **array, int num)
 {
 	int size = num * sizeof(struct file *);
 
@@ -154,7 +154,7 @@ static void free_fdtable_rcu(struct rcu_
 	}
 }
 
-void free_fdtable(struct fdtable *fdt)
+void __global free_fdtable(struct fdtable *fdt)
 {
 	if (fdt->free_files ||
 		fdt->max_fdset > EMBEDDED_FD_SET_SIZE ||
@@ -219,7 +219,7 @@ fd_set * alloc_fdset(int num)
 	return new_fdset;
 }
 
-void free_fdset(fd_set *array, int num)
+void __global free_fdset(fd_set *array, int num)
 {
 	if (num <= EMBEDDED_FD_SET_SIZE) /* Don't free an embedded fdset */
 		return;
@@ -336,7 +336,7 @@ out:
  * Return <0 on error; 0 nothing done; 1 files expanded, we may have blocked.
  * Should be called with the files->file_lock spinlock held for write.
  */
-int expand_files(struct files_struct *files, int nr)
+int __global expand_files(struct files_struct *files, int nr)
 {
 	int err, expand = 0;
 	struct fdtable *fdt;
diff --git a/fs/file_table.c b/fs/file_table.c
index 0131ba0..3e795f3 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -25,12 +25,12 @@ #include <linux/percpu_counter.h>
 #include <asm/atomic.h>
 
 /* sysctl tunables... */
-struct files_stat_struct files_stat = {
+struct files_stat_struct __global files_stat = {
 	.max_files = NR_FILE
 };
 
 /* public. Not pretty! */
-__cacheline_aligned_in_smp DEFINE_SPINLOCK(files_lock);
+__global __cacheline_aligned_in_smp DEFINE_SPINLOCK(files_lock);
 
 static struct percpu_counter nr_files __cacheline_aligned_in_smp;
 
@@ -67,14 +67,14 @@ EXPORT_SYMBOL_GPL(get_max_files);
  * Handle nr_files sysctl
  */
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_PROC_FS)
-int proc_nr_files(ctl_table *table, int write, struct file *filp,
+int __global proc_nr_files(ctl_table *table, int write, struct file *filp,
                      void __user *buffer, size_t *lenp, loff_t *ppos)
 {
 	files_stat.nr_files = get_nr_files();
 	return proc_dointvec(table, write, filp, buffer, lenp, ppos);
 }
 #else
-int proc_nr_files(ctl_table *table, int write, struct file *filp,
+int __global proc_nr_files(ctl_table *table, int write, struct file *filp,
                      void __user *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
@@ -210,7 +210,7 @@ EXPORT_SYMBOL(fget);
  * and a flag is returned to be passed to the corresponding fput_light().
  * There must not be a cloning between an fget_light/fput_light pair.
  */
-struct file fastcall *fget_light(unsigned int fd, int *fput_needed)
+struct file fastcall * __global fget_light(unsigned int fd, int *fput_needed)
 {
 	struct file *file;
 	struct files_struct *files = current->files;
@@ -235,7 +235,7 @@ struct file fastcall *fget_light(unsigne
 }
 
 
-void put_filp(struct file *file)
+void __global put_filp(struct file *file)
 {
 	if (atomic_dec_and_test(&file->f_count)) {
 		security_file_free(file);
@@ -244,7 +244,7 @@ void put_filp(struct file *file)
 	}
 }
 
-void file_move(struct file *file, struct list_head *list)
+void __global file_move(struct file *file, struct list_head *list)
 {
 	if (!list)
 		return;
@@ -253,7 +253,7 @@ void file_move(struct file *file, struct
 	file_list_unlock();
 }
 
-void file_kill(struct file *file)
+void __global file_kill(struct file *file)
 {
 	if (!list_empty(&file->f_u.fu_list)) {
 		file_list_lock();
diff --git a/fs/filesystems.c b/fs/filesystems.c
index 9f10728..2b338c6 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -198,7 +198,7 @@ asmlinkage long sys_sysfs(int option, un
 	return retval;
 }
 
-int get_filesystem_list(char * buf)
+int __global get_filesystem_list(char * buf)
 {
 	int len = 0;
 	struct file_system_type * tmp;
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 892643d..c3a2e2b 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -409,7 +409,7 @@ sync_sb_inodes(struct super_block *sb, s
  * sync_sb_inodes will seekout the blockdev which matches `bdi'.  Maybe not
  * super-efficient but we're about to do a ton of I/O...
  */
-void
+void __global
 writeback_inodes(struct writeback_control *wbc)
 {
 	struct super_block *sb;
@@ -678,7 +678,7 @@ int writeback_acquire(struct backing_dev
  *
  * Determine whether there is writeback in progress against a backing device.
  */
-int writeback_in_progress(struct backing_dev_info *bdi)
+int __global writeback_in_progress(struct backing_dev_info *bdi)
 {
 	return test_bit(BDI_pdflush, &bdi->state);
 }
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index c3920c9..5062ca1 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -44,7 +44,7 @@ static struct backing_dev_info hugetlbfs
 	.capabilities	= BDI_CAP_NO_ACCT_DIRTY | BDI_CAP_NO_WRITEBACK,
 };
 
-int sysctl_hugetlb_shm_group;
+int __global sysctl_hugetlb_shm_group;
 
 static void huge_pagevec_release(struct pagevec *pvec)
 {
@@ -562,7 +562,7 @@ static void init_once(void *foo, kmem_ca
 		inode_init_once(&ei->vfs_inode);
 }
 
-const struct file_operations hugetlbfs_file_operations = {
+const __global struct file_operations hugetlbfs_file_operations = {
 	.mmap			= hugetlbfs_file_mmap,
 	.fsync			= simple_sync_file,
 	.get_unmapped_area	= hugetlb_get_unmapped_area,
@@ -691,7 +691,7 @@ out_free:
 	return -ENOMEM;
 }
 
-int hugetlb_get_quota(struct address_space *mapping)
+int __global hugetlb_get_quota(struct address_space *mapping)
 {
 	int ret = 0;
 	struct hugetlbfs_sb_info *sbinfo = HUGETLBFS_SB(mapping->host->i_sb);
@@ -708,7 +708,7 @@ int hugetlb_get_quota(struct address_spa
 	return ret;
 }
 
-void hugetlb_put_quota(struct address_space *mapping)
+void __global hugetlb_put_quota(struct address_space *mapping)
 {
 	struct hugetlbfs_sb_info *sbinfo = HUGETLBFS_SB(mapping->host->i_sb);
 
@@ -740,7 +740,7 @@ static int can_do_hugetlb_shm(void)
 			can_do_mlock());
 }
 
-struct file *hugetlb_zero_setup(size_t size)
+struct file * __global hugetlb_zero_setup(size_t size)
 {
 	int error = -ENOMEM;
 	struct file *file;
diff --git a/fs/inode.c b/fs/inode.c
index 0bf9f04..0ed00e2 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -71,7 +71,7 @@ static unsigned int i_hash_shift __read_
  */
 
 LIST_HEAD(inode_in_use);
-LIST_HEAD(inode_unused);
+__global LIST_HEAD(inode_unused);
 static struct hlist_head *inode_hashtable __read_mostly;
 
 /*
@@ -80,7 +80,7 @@ static struct hlist_head *inode_hashtabl
  * NOTE! You also have to own the lock if you change
  * the i_state of an inode while it is in use..
  */
-DEFINE_SPINLOCK(inode_lock);
+__global DEFINE_SPINLOCK(inode_lock);
 
 /*
  * iprune_mutex provides exclusion between the kswapd or try_to_free_pages
@@ -95,7 +95,7 @@ static DEFINE_MUTEX(iprune_mutex);
 /*
  * Statistics gathering..
  */
-struct inodes_stat_t inodes_stat;
+struct inodes_stat_t __global inodes_stat;
 
 static kmem_cache_t * inode_cachep __read_mostly;
 
@@ -169,7 +169,7 @@ #endif
 	return inode;
 }
 
-void destroy_inode(struct inode *inode) 
+void __global destroy_inode(struct inode *inode) 
 {
 	BUG_ON(inode_has_buffers(inode));
 	security_inode_free(inode);
diff --git a/fs/inotify_user.c b/fs/inotify_user.c
index 017cb0f..a7997c2 100644
--- a/fs/inotify_user.c
+++ b/fs/inotify_user.c
@@ -112,7 +112,7 @@ #include <linux/sysctl.h>
 
 static int zero;
 
-ctl_table inotify_table[] = {
+ctl_table __global inotify_table[] = {
 	{
 		.ctl_name	= INOTIFY_MAX_USER_INSTANCES,
 		.procname	= "max_user_instances",
diff --git a/fs/jffs2/Makefile b/fs/jffs2/Makefile
diff --git a/fs/jffs2/read.c b/fs/jffs2/read.c
diff --git a/fs/locks.c b/fs/locks.c
index b0b41a6..e4ef939 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -133,8 +133,8 @@ #define IS_POSIX(fl)	(fl->fl_flags & FL_
 #define IS_FLOCK(fl)	(fl->fl_flags & FL_FLOCK)
 #define IS_LEASE(fl)	(fl->fl_flags & FL_LEASE)
 
-int leases_enable = 1;
-int lease_break_time = 45;
+int __global leases_enable = 1;
+int __global lease_break_time = 45;
 
 #define for_each_lock(inode, lockp) \
 	for (lockp = &inode->i_flock; *lockp != NULL; lockp = &(*lockp)->fl_next)
@@ -1072,7 +1072,7 @@ EXPORT_SYMBOL(posix_lock_file_wait);
  * Searches the inode's list of locks to find any POSIX locks which conflict.
  * This function is called from locks_verify_locked() only.
  */
-int locks_mandatory_locked(struct inode *inode)
+int __global locks_mandatory_locked(struct inode *inode)
 {
 	fl_owner_t owner = current->files;
 	struct file_lock *fl;
@@ -2110,7 +2110,7 @@ static void move_lock_status(char **p, o
  *	@length: how much to read
  */
 
-int get_locks_status(char *buffer, char **start, off_t offset, int length)
+int __global get_locks_status(char *buffer, char **start, off_t offset, int length)
 {
 	struct list_head *tmp;
 	char *q = buffer;
diff --git a/fs/namei.c b/fs/namei.c
index 55a1312..dee817e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -322,7 +322,7 @@ int get_write_access(struct inode * inod
 	return 0;
 }
 
-int deny_write_access(struct file * file)
+int __global deny_write_access(struct file * file)
 {
 	struct inode *inode = file->f_dentry->d_inode;
 
@@ -1040,7 +1040,7 @@ static int __emul_lookup_dentry(const ch
 	return 1;
 }
 
-void set_fs_altroot(void)
+void __global set_fs_altroot(void)
 {
 	char *emul = __emul_prefix();
 	struct nameidata nd;
diff --git a/fs/namespace.c b/fs/namespace.c
index fa7ed6a..eed31ac 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -38,7 +38,7 @@ static inline int sysfs_init(void)
 #endif
 
 /* spinlock for vfsmount related operations, inplace of dcache_lock */
-__cacheline_aligned_in_smp DEFINE_SPINLOCK(vfsmount_lock);
+__global __cacheline_aligned_in_smp DEFINE_SPINLOCK(vfsmount_lock);
 
 static int event;
 
@@ -400,7 +400,7 @@ static int show_vfsmnt(struct seq_file *
 	return err;
 }
 
-struct seq_operations mounts_op = {
+struct seq_operations __global mounts_op = {
 	.start	= m_start,
 	.next	= m_next,
 	.stop	= m_stop,
@@ -438,7 +438,7 @@ static int show_vfsstat(struct seq_file 
 	return err;
 }
 
-struct seq_operations mountstats_op = {
+struct seq_operations __global mountstats_op = {
 	.start	= m_start,
 	.next	= m_next,
 	.stop	= m_stop,
@@ -1447,7 +1447,7 @@ dput_out:
  * Allocate a new namespace structure and populate it with contents
  * copied from the namespace of the passed in task structure.
  */
-struct namespace *dup_namespace(struct task_struct *tsk, struct fs_struct *fs)
+struct namespace * __global dup_namespace(struct task_struct *tsk, struct fs_struct *fs)
 {
 	struct namespace *namespace = tsk->namespace;
 	struct namespace *new_ns;
@@ -1514,7 +1514,7 @@ struct namespace *dup_namespace(struct t
 	return new_ns;
 }
 
-int copy_namespace(int flags, struct task_struct *tsk)
+int __global copy_namespace(int flags, struct task_struct *tsk)
 {
 	struct namespace *namespace = tsk->namespace;
 	struct namespace *new_ns;
@@ -1867,7 +1867,7 @@ void __init mnt_init(unsigned long mempa
 	init_mount_tree();
 }
 
-void __put_namespace(struct namespace *namespace)
+void __global __put_namespace(struct namespace *namespace)
 {
 	struct vfsmount *root = namespace->root;
 	LIST_HEAD(umount_list);
diff --git a/fs/pipe.c b/fs/pipe.c
index 2035257..eaa60a7 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -822,7 +822,7 @@ struct pipe_inode_info * alloc_pipe_info
 	return pipe;
 }
 
-void __free_pipe_info(struct pipe_inode_info *pipe)
+void __global __free_pipe_info(struct pipe_inode_info *pipe)
 {
 	int i;
 
@@ -890,7 +890,7 @@ fail_inode:
 	return NULL;
 }
 
-int do_pipe(int *fd)
+int __global do_pipe(int *fd)
 {
 	struct qstr this;
 	char name[32];
diff --git a/fs/proc/base.c b/fs/proc/base.c
index fe8d55f..687c944 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1975,7 +1975,7 @@ static struct inode_operations proc_self
  *       that no dcache entries will exist at process exit time it
  *       just makes it very unlikely that any will persist.
  */
-void proc_flush_task(struct task_struct *task)
+void __global proc_flush_task(struct task_struct *task)
 {
 	struct dentry *dentry, *leader, *dir;
 	char buf[PROC_NUMBUF];
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 4ba0300..dbfdf4a 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -32,7 +32,7 @@ static loff_t proc_file_lseek(struct fil
 
 DEFINE_SPINLOCK(proc_subdir_lock);
 
-int proc_match(int len, const char *name, struct proc_dir_entry *de)
+int __global proc_match(int len, const char *name, struct proc_dir_entry *de)
 {
 	if (de->namelen != len)
 		return 0;
diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 6a984f6..7e4296c 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -54,7 +54,7 @@ struct memelfnote
 static struct kcore_list *kclist;
 static DEFINE_RWLOCK(kclist_lock);
 
-void
+void __global
 kclist_add(struct kcore_list *new, void *addr, size_t size)
 {
 	new->addr = (unsigned long)addr;
diff --git a/fs/proc/proc_devtree.c b/fs/proc/proc_devtree.c
index abdf068..cb53138 100644
--- a/fs/proc/proc_devtree.c
+++ b/fs/proc/proc_devtree.c
@@ -77,18 +77,18 @@ __proc_device_tree_add_prop(struct proc_
 }
 
 
-void proc_device_tree_add_prop(struct proc_dir_entry *pde, struct property *prop)
+void  __global proc_device_tree_add_prop(struct proc_dir_entry *pde, struct property *prop)
 {
 	__proc_device_tree_add_prop(pde, prop, prop->name);
 }
 
-void proc_device_tree_remove_prop(struct proc_dir_entry *pde,
+void __global proc_device_tree_remove_prop(struct proc_dir_entry *pde,
 				  struct property *prop)
 {
 	remove_proc_entry(prop->name, pde);
 }
 
-void proc_device_tree_update_prop(struct proc_dir_entry *pde,
+void __global proc_device_tree_update_prop(struct proc_dir_entry *pde,
 				  struct property *newprop,
 				  struct property *oldprop)
 {
@@ -172,8 +172,8 @@ retry:
 /*
  * Process a node, adding entries for its children and its properties.
  */
-void proc_device_tree_add_node(struct device_node *np,
-			       struct proc_dir_entry *de)
+void __global proc_device_tree_add_node(struct device_node *np,
+					struct proc_dir_entry *de)
 {
 	struct property *pp;
 	struct proc_dir_entry *ent;
diff --git a/fs/proc/proc_tty.c b/fs/proc/proc_tty.c
index 15c4455..c874f53 100644
--- a/fs/proc/proc_tty.c
+++ b/fs/proc/proc_tty.c
@@ -182,7 +182,7 @@ static int tty_ldiscs_read_proc(char *pa
  * This function is called by tty_register_driver() to handle
  * registering the driver's /proc handler into /proc/tty/driver/<foo>
  */
-void proc_tty_register_driver(struct tty_driver *driver)
+void __global proc_tty_register_driver(struct tty_driver *driver)
 {
 	struct proc_dir_entry *ent;
 		
@@ -205,7 +205,7 @@ void proc_tty_register_driver(struct tty
 /*
  * This function is called by tty_unregister_driver()
  */
-void proc_tty_unregister_driver(struct tty_driver *driver)
+void __global proc_tty_unregister_driver(struct tty_driver *driver)
 {
 	struct proc_dir_entry *ent;
 
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 8901c65..7b99f88 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -22,7 +22,7 @@ #include "internal.h"
 struct proc_dir_entry *proc_net, *proc_net_stat, *proc_bus, *proc_root_fs, *proc_root_driver;
 
 #ifdef CONFIG_SYSCTL
-struct proc_dir_entry *proc_sys_root;
+struct proc_dir_entry * __global proc_sys_root;
 #endif
 
 static int proc_get_sb(struct file_system_type *fs_type,
@@ -37,7 +37,7 @@ static struct file_system_type proc_fs_t
 	.kill_sb	= kill_anon_super,
 };
 
-void __init proc_root_init(void)
+void __init __global proc_root_init(void)
 {
 	int err = proc_init_inodecache();
 	if (err)
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index b967733..9bd963d 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -222,7 +222,7 @@ static void __exit exit_ramfs_fs(void)
 module_init(init_ramfs_fs)
 module_exit(exit_ramfs_fs)
 
-int __init init_rootfs(void)
+int __init __global init_rootfs(void)
 {
 	return register_filesystem(&rootfs_fs_type);
 }
diff --git a/fs/splice.c b/fs/splice.c
index 684bca3..78500fc 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -707,7 +707,7 @@ out_nomem:
  * key here is the 'actor' worker passed in that actually moves the data
  * to the wanted destination. See pipe_to_file/pipe_to_sendpage above.
  */
-ssize_t splice_from_pipe(struct pipe_inode_info *pipe, struct file *out,
+ssize_t __global splice_from_pipe(struct pipe_inode_info *pipe, struct file *out,
 			 loff_t *ppos, size_t len, unsigned int flags,
 			 splice_actor *actor)
 {
diff --git a/fs/super.c b/fs/super.c
index 6d4e817..ffa2854 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -45,7 +45,7 @@ void put_filesystem(struct file_system_t
 struct file_system_type *get_fs_type(const char *name);
 
 LIST_HEAD(super_blocks);
-DEFINE_SPINLOCK(sb_lock);
+__global DEFINE_SPINLOCK(sb_lock);
 
 /**
  *	alloc_super	-	create new superblock
@@ -347,7 +347,7 @@ static inline void write_super(struct su
  * hold up the sync while mounting a device. (The newly
  * mounted device won't need syncing.)
  */
-void sync_supers(void)
+void __global sync_supers(void)
 {
 	struct super_block *sb;
 
@@ -592,7 +592,7 @@ static void do_emergency_remount(unsigne
 	printk("Emergency Remount complete\n");
 }
 
-void emergency_remount(void)
+void __global emergency_remount(void)
 {
 	pdflush_operation(do_emergency_remount, 0);
 }
@@ -646,7 +646,7 @@ void kill_anon_super(struct super_block 
 
 EXPORT_SYMBOL(kill_anon_super);
 
-void __init unnamed_dev_init(void)
+void __init __global unnamed_dev_init(void)
 {
 	idr_init(&unnamed_dev_idr);
 }
diff --git a/init/calibrate.c b/init/calibrate.c
index d206c75..938f200 100644
--- a/init/calibrate.c
+++ b/init/calibrate.c
@@ -112,7 +112,7 @@ #endif
  */
 #define LPS_PREC 8
 
-void __devinit calibrate_delay(void)
+void __devinit __global calibrate_delay(void)
 {
 	unsigned long ticks, loopbit;
 	int lps_precision = LPS_PREC;
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 94aeec7..621bf15 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -17,13 +17,13 @@ #include "do_mounts.h"
 
 extern int get_filesystem_list(char * buf);
 
-int __initdata rd_doload;	/* 1 = load RAM disk, 0 = don't load */
+int __initdata __global rd_doload;	/* 1 = load RAM disk, 0 = don't load */
 
-int root_mountflags = MS_RDONLY | MS_SILENT;
+int __global root_mountflags = MS_RDONLY | MS_SILENT;
 char * __initdata root_device_name;
 static char __initdata saved_root_name[64];
 
-dev_t ROOT_DEV;
+dev_t __global ROOT_DEV;
 
 static int __init load_ramdisk(char *str)
 {
@@ -133,7 +133,7 @@ fail:
  *	is mounted on rootfs /sys.
  */
 
-dev_t name_to_dev_t(char *name)
+dev_t __global name_to_dev_t(char *name)
 {
 	char s[32];
 	char *p;
@@ -393,7 +393,7 @@ #endif
 /*
  * Prepare the namespace - decide what/where to mount, load ramdisks, etc.
  */
-void __init prepare_namespace(void)
+void __init __global prepare_namespace(void)
 {
 	int is_floppy;
 
@@ -430,4 +430,3 @@ out:
 	sys_chroot(".");
 	security_sb_post_mountroot();
 }
-
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index a06f037..6386990 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -10,9 +10,10 @@ #include <linux/sched.h>
 
 #include "do_mounts.h"
 
-unsigned long initrd_start, initrd_end;
-int initrd_below_start_ok;
-unsigned int real_root_dev;	/* do_proc_dointvec cannot handle kdev_t */
+unsigned long __global initrd_start;
+unsigned long __global initrd_end;
+int __global initrd_below_start_ok;
+unsigned int __global real_root_dev;	/* do_proc_dointvec cannot handle kdev_t */
 static int __initdata old_fd, root_fd;
 static int __initdata mount_initrd = 1;
 
diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index ed652f4..4ef0705 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -12,7 +12,7 @@ #include "do_mounts.h"
 
 #define BUILD_CRAMDISK
 
-int __initdata rd_prompt = 1;/* 1 = prompt for RAM disk, 0 = don't prompt */
+int __initdata __global rd_prompt = 1;/* 1 = prompt for RAM disk, 0 = don't prompt */
 
 static int __init prompt_ramdisk(char *str)
 {
@@ -21,7 +21,7 @@ static int __init prompt_ramdisk(char *s
 }
 __setup("prompt_ramdisk=", prompt_ramdisk);
 
-int __initdata rd_image_start;		/* starting block # of image */
+int __initdata __global rd_image_start;		/* starting block # of image */
 
 static int __init ramdisk_start_setup(char *str)
 {
diff --git a/init/main.c b/init/main.c
index 8651a72..735b3f3 100644
--- a/init/main.c
+++ b/init/main.c
@@ -104,7 +104,7 @@ #ifdef CONFIG_TC
 extern void tc_init(void);
 #endif
 
-enum system_states system_state;
+enum system_states __global system_state;
 EXPORT_SYMBOL(system_state);
 
 /*
@@ -115,11 +115,11 @@ #define MAX_INIT_ENVS CONFIG_INIT_ENV_AR
 
 extern void time_init(void);
 /* Default late time init is NULL. archs can override this later. */
-void (*late_time_init)(void);
+void __global (*late_time_init)(void);
 extern void softirq_init(void);
 
 /* Untouched command line (eg. for /proc) saved by arch-specific code. */
-char saved_command_line[COMMAND_LINE_SIZE];
+char __global saved_command_line[COMMAND_LINE_SIZE];
 
 static char *execute_command;
 static char *ramdisk_execute_command;
@@ -188,7 +188,7 @@ static int __init obsolete_checksetup(ch
  * This should be approx 2 Bo*oMips to start (note initial shift), and will
  * still work even if initially too large, it will just take slightly longer
  */
-unsigned long loops_per_jiffy = (1<<12);
+unsigned long __global loops_per_jiffy = (1<<12);
 
 EXPORT_SYMBOL(loops_per_jiffy);
 
@@ -422,7 +422,7 @@ static int __init do_early_param(char *p
 }
 
 /* Arch code calls this early on, or if not, just before other parsing. */
-void __init parse_early_param(void)
+void __init __global parse_early_param(void)
 {
 	static __initdata int done = 0;
 	static __initdata char tmp_cmdline[COMMAND_LINE_SIZE];
@@ -453,7 +453,7 @@ void __init __attribute__((weak)) smp_se
 {
 }
 
-asmlinkage void __init start_kernel(void)
+asmlinkage void __init __global start_kernel(void)
 {
 	char * command_line;
 	extern struct kernel_param __start___param[], __stop___param[];
@@ -596,7 +596,7 @@ static int __init initcall_debug_setup(c
 }
 __setup("initcall_debug", initcall_debug_setup);
 
-struct task_struct *child_reaper = &init_task;
+struct task_struct * __global child_reaper = &init_task;
 
 extern initcall_t __initcall_start[], __initcall_end[];
 
diff --git a/ipc/compat.c b/ipc/compat.c
index 4d20cfd..3ff09e5 100644
--- a/ipc/compat.c
+++ b/ipc/compat.c
@@ -234,7 +234,7 @@ static inline int put_compat_semid_ds(st
 	return err;
 }
 
-long compat_sys_semctl(int first, int second, int third, void __user *uptr)
+long __global compat_sys_semctl(int first, int second, int third, void __user *uptr)
 {
 	union semun fourth;
 	u32 pad;
@@ -305,7 +305,7 @@ long compat_sys_semctl(int first, int se
 	return err;
 }
 
-long compat_sys_msgsnd(int first, int second, int third, void __user *uptr)
+long __global compat_sys_msgsnd(int first, int second, int third, void __user *uptr)
 {
 	struct msgbuf __user *p;
 	struct compat_msgbuf __user *up = uptr;
@@ -325,7 +325,7 @@ long compat_sys_msgsnd(int first, int se
 	return sys_msgsnd(first, p, second, third);
 }
 
-long compat_sys_msgrcv(int first, int second, int msgtyp, int third,
+long __global compat_sys_msgrcv(int first, int second, int msgtyp, int third,
 			   int version, void __user *uptr)
 {
 	struct msgbuf __user *p;
@@ -424,7 +424,7 @@ static inline int put_compat_msqid_ds(st
 	return err;
 }
 
-long compat_sys_msgctl(int first, int second, void __user *uptr)
+long __global compat_sys_msgctl(int first, int second, void __user *uptr)
 {
 	int err, err2;
 	struct msqid64_ds m64;
@@ -476,7 +476,7 @@ long compat_sys_msgctl(int first, int se
 	return err;
 }
 
-long compat_sys_shmat(int first, int second, compat_uptr_t third, int version,
+long __global compat_sys_shmat(int first, int second, compat_uptr_t third, int version,
 			void __user *uptr)
 {
 	int err;
@@ -592,7 +592,7 @@ static inline int put_compat_shm_info(st
 	return err;
 }
 
-long compat_sys_shmctl(int first, int second, void __user *uptr)
+long __global compat_sys_shmctl(int first, int second, void __user *uptr)
 {
 	void __user *p;
 	struct shmid64_ds s64;
@@ -671,7 +671,7 @@ long compat_sys_shmctl(int first, int se
 	return err;
 }
 
-long compat_sys_semtimedop(int semid, struct sembuf __user *tsems,
+long __global compat_sys_semtimedop(int semid, struct sembuf __user *tsems,
 		unsigned nsops, const struct compat_timespec __user *timeout)
 {
 	struct timespec __user *ts64 = NULL;
diff --git a/ipc/msg.c b/ipc/msg.c
index 2b4fccf..eeb2030 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -37,9 +37,9 @@ #include <asm/uaccess.h>
 #include "util.h"
 
 /* sysctl: */
-int msg_ctlmax = MSGMAX;
-int msg_ctlmnb = MSGMNB;
-int msg_ctlmni = MSGMNI;
+int __global msg_ctlmax = MSGMAX;
+int __global msg_ctlmnb = MSGMNB;
+int __global msg_ctlmni = MSGMNI;
 
 /*
  * one msg_receiver structure for each sleeping receiver:
diff --git a/ipc/sem.c b/ipc/sem.c
index 6013c75..6b744e1 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -110,7 +110,7 @@ #define SEMOPM_FAST	64  /* ~ 372 bytes o
  *	
  */
 
-int sem_ctls[4] = {SEMMSL, SEMMNS, SEMOPM, SEMMNI};
+int __global sem_ctls[4] = {SEMMSL, SEMMNS, SEMOPM, SEMMNI};
 #define sc_semmsl	(sem_ctls[0])
 #define sc_semmns	(sem_ctls[1])
 #define sc_semopm	(sem_ctls[2])
@@ -1234,7 +1234,7 @@ asmlinkage long sys_semop (int semid, st
  * because of the reasoning in the comment above unlock_semundo.
  */
 
-int copy_semundo(unsigned long clone_flags, struct task_struct *tsk)
+int __global copy_semundo(unsigned long clone_flags, struct task_struct *tsk)
 {
 	struct sem_undo_list *undo_list;
 	int error;
@@ -1263,7 +1263,7 @@ int copy_semundo(unsigned long clone_fla
  * The current implementation does not do so. The POSIX standard
  * and SVID should be consulted to determine what behavior is mandated.
  */
-void exit_sem(struct task_struct *tsk)
+void __global exit_sem(struct task_struct *tsk)
 {
 	struct sem_undo_list *undo_list;
 	struct sem_undo *u, **up;
diff --git a/ipc/shm.c b/ipc/shm.c
index 940b0c9..4d1dd3a 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -55,9 +55,9 @@ #ifdef CONFIG_PROC_FS
 static int sysvipc_shm_proc_show(struct seq_file *s, void *it);
 #endif
 
-size_t	shm_ctlmax = SHMMAX;
-size_t 	shm_ctlall = SHMALL;
-int 	shm_ctlmni = SHMMNI;
+size_t	__global shm_ctlmax = SHMMAX;
+size_t 	__global shm_ctlall = SHMALL;
+int 	__global shm_ctlmni = SHMMNI;
 
 static int shm_tot; /* total number of shared memory pages */
 
@@ -688,7 +688,7 @@ out:
  * "raddr" thing points to kernel space, and there has to be a wrapper around
  * this.
  */
-long do_shmat(int shmid, char __user *shmaddr, int shmflg, ulong *raddr)
+long __global do_shmat(int shmid, char __user *shmaddr, int shmflg, ulong *raddr)
 {
 	struct shmid_kernel *shp;
 	unsigned long addr;
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 6991bec..59a13da 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -1,4 +1,5 @@
 
+#include <linux/compiler.h>
 #include <linux/linkage.h>
 #include <linux/errno.h>
 
diff --git a/net/core/dev.c b/net/core/dev.c
index d95e262..1c08754 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -405,7 +405,7 @@ int netdev_boot_setup_check(struct net_d
  *	later in the device probing.
  *	Returns 0 if no settings found.
  */
-unsigned long netdev_boot_base(const char *prefix, int unit)
+unsigned long __global netdev_boot_base(const char *prefix, int unit)
 {
 	const struct netdev_boot_setup *s = dev_boot_setup;
 	char name[IFNAMSIZ];
@@ -429,7 +429,7 @@ unsigned long netdev_boot_base(const cha
 /*
  * Saves at boot time configured settings for any netdevice.
  */
-int __init netdev_boot_setup(char *str)
+int __init __global netdev_boot_setup(char *str)
 {
 	int ints[5];
 	struct ifmap map;
@@ -1330,7 +1330,7 @@ static int dev_gso_segment(struct sk_buf
 	return 0;
 }
 
-int dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
+int __global dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	if (likely(!skb->next)) {
 		if (netdev_nit)
@@ -1538,7 +1538,7 @@ int netdev_max_backlog = 1000;
 int netdev_budget = 300;
 int weight_p = 64;            /* old backlog weight */
 
-DEFINE_PER_CPU(struct netif_rx_stats, netdev_rx_stat) = { 0, };
+__global DEFINE_PER_CPU(struct netif_rx_stats, netdev_rx_stat) = { 0, };
 
 /**
  *	netif_rx	-	post buffer to the network code
@@ -2646,7 +2645,7 @@ static int dev_ifsioc(struct ifreq *ifr,
  *	positive or a negative errno code on error.
  */
 
-int dev_ioctl(unsigned int cmd, void __user *arg)
+int __global dev_ioctl(unsigned int cmd, void __user *arg)
 {
 	struct ifreq ifr;
 	int ret;
diff --git a/net/core/dv.c b/net/core/dv.c
index 29ee77f..6569d40 100644
--- a/net/core/dv.c
+++ b/net/core/dv.c
@@ -186,7 +186,7 @@ #else
 #define	DVDBG(a)
 #endif
 
-int divert_ioctl(unsigned int cmd, struct divert_cf __user *arg)
+int __global divert_ioctl(unsigned int cmd, struct divert_cf __user *arg)
 {
 	struct divert_cf	div_cf;
 	struct divert_blk	*div_blk;
@@ -434,7 +434,6 @@ int divert_ioctl(unsigned int cmd, struc
 	return 0;
 }
 
-
 /*
  * Check if packet should have its dest mac address set to the box itself
  * for diversion
diff --git a/net/core/flow.c b/net/core/flow.c
index 2191af5..fe4240b 100644
--- a/net/core/flow.c
+++ b/net/core/flow.c
@@ -285,7 +285,7 @@ static void flow_cache_flush_per_cpu(voi
 	tasklet_schedule(tasklet);
 }
 
-void flow_cache_flush(void)
+void __global flow_cache_flush(void)
 {
 	struct flow_flush_info info;
 	static DEFINE_MUTEX(flow_flush_sem);
diff --git a/net/core/iovec.c b/net/core/iovec.c
index 65e4b56..e562e7d 100644
--- a/net/core/iovec.c
+++ b/net/core/iovec.c
@@ -37,7 +37,8 @@ #include <net/sock.h>
  *	in any case.
  */
 
-int verify_iovec(struct msghdr *m, struct iovec *iov, char *address, int mode)
+int __global verify_iovec(struct msghdr *m, struct iovec *iov, char *address,
+			  int mode)
 {
 	int size, err, ct;
 	
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 5130d2e..1afcc7b 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -499,8 +499,8 @@ out:
 }
 
 
-int pneigh_delete(struct neigh_table *tbl, const void *pkey,
-		  struct net_device *dev)
+int __global pneigh_delete(struct neigh_table *tbl, const void *pkey,
+			   struct net_device *dev)
 {
 	struct pneigh_entry *n, **np;
 	int key_len = tbl->key_len;
diff --git a/net/core/request_sock.c b/net/core/request_sock.c
index 79ebd75..8a9c3aa 100644
--- a/net/core/request_sock.c
+++ b/net/core/request_sock.c
@@ -31,7 +31,7 @@ #include <net/request_sock.h>
  * (<=32Mb of memory) and to 1024 on normal or better ones (>=256Mb).
  * Further increasing requires to change hash table size.
  */
-int sysctl_max_syn_backlog = 256;
+int __global sysctl_max_syn_backlog = 256;
 
 int reqsk_queue_alloc(struct request_sock_queue *queue,
 		      const int nr_table_entries)
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 20e5bb7..0c35f52 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -155,7 +155,7 @@ size_t rtattr_strlcpy(char *dest, const 
 	return ret;
 }
 
-int rtnetlink_send(struct sk_buff *skb, u32 pid, unsigned group, int echo)
+int __global rtnetlink_send(struct sk_buff *skb, u32 pid, unsigned group, int echo)
 {
 	int err = 0;
 
@@ -777,7 +777,7 @@ static struct notifier_block rtnetlink_d
 	.notifier_call	= rtnetlink_event,
 };
 
-void __init rtnetlink_init(void)
+void __init __global rtnetlink_init(void)
 {
 	int i;
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 022d889..7502897 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2039,7 +2039,7 @@ err:
 
 EXPORT_SYMBOL_GPL(skb_segment);
 
-void __init skb_init(void)
+void __init __global skb_init(void)
 {
 	skbuff_head_cache = kmem_cache_create("skbuff_head_cache",
 					      sizeof(struct sk_buff),
diff --git a/net/core/sock.c b/net/core/sock.c
index 51fcfbc..96db5f9 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -636,8 +636,8 @@ #endif
 }
 
 
-int sock_getsockopt(struct socket *sock, int level, int optname,
-		    char __user *optval, int __user *optlen)
+int __global sock_getsockopt(struct socket *sock, int level, int optname,
+			     char __user *optval, int __user *optlen)
 {
 	struct sock *sk = sock->sk;
 	
@@ -983,7 +983,7 @@ out:
 
 EXPORT_SYMBOL_GPL(sk_clone);
 
-void __init sk_init(void)
+void __init __global sk_init(void)
 {
 	if (num_physpages <= 4096) {
 		sysctl_wmem_max = 32767;
@@ -1065,8 +1065,8 @@ struct sk_buff *sock_wmalloc(struct sock
 /*
  * Allocate a skb from the socket's receive buffer.
  */ 
-struct sk_buff *sock_rmalloc(struct sock *sk, unsigned long size, int force,
-			     gfp_t priority)
+struct sk_buff * __global sock_rmalloc(struct sock *sk, unsigned long size,
+				       int force, gfp_t priority)
 {
 	if (force || atomic_read(&sk->sk_rmem_alloc) < sk->sk_rcvbuf) {
 		struct sk_buff *skb = alloc_skb(size, priority);
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 0253413..1316556 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -30,7 +30,7 @@ extern u32 sysctl_xfrm_aevent_etime;
 extern u32 sysctl_xfrm_aevent_rseqth;
 #endif
 
-ctl_table core_table[] = {
+ctl_table __global core_table[] = {
 #ifdef CONFIG_NET
 	{
 		.ctl_name	= NET_CORE_WMEM_MAX,
diff --git a/net/core/user_dma.c b/net/core/user_dma.c
index 248a6b6..676efe0 100644
--- a/net/core/user_dma.c
+++ b/net/core/user_dma.c
@@ -33,7 +33,7 @@ #include <net/netdma.h>
 
 #define NET_DMA_DEFAULT_COPYBREAK 4096
 
-int sysctl_tcp_dma_copybreak = NET_DMA_DEFAULT_COPYBREAK;
+int __global sysctl_tcp_dma_copybreak = NET_DMA_DEFAULT_COPYBREAK;
 
 /**
  *	dma_skb_copy_datagram_iovec - Copy a datagram to an iovec.
@@ -45,7 +45,7 @@ int sysctl_tcp_dma_copybreak = NET_DMA_D
  *
  *	Note: the iovec is modified during the copy.
  */
-int dma_skb_copy_datagram_iovec(struct dma_chan *chan,
+int __global dma_skb_copy_datagram_iovec(struct dma_chan *chan,
 			struct sk_buff *skb, int offset, struct iovec *to,
 			size_t len, struct dma_pinned_list *pinned_list)
 {
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 95fac55..944595e 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -27,7 +27,7 @@ #include <net/ip.h>
  * Allocate and initialize a new local port bind bucket.
  * The bindhash mutex for snum's hash chain must be held here.
  */
-struct inet_bind_bucket *inet_bind_bucket_create(kmem_cache_t *cachep,
+struct inet_bind_bucket * __global inet_bind_bucket_create(kmem_cache_t *cachep,
 						 struct inet_bind_hashbucket *head,
 						 const unsigned short snum)
 {
@@ -53,7 +53,7 @@ void inet_bind_bucket_destroy(kmem_cache
 	}
 }
 
-void inet_bind_hash(struct sock *sk, struct inet_bind_bucket *tb,
+void __global inet_bind_hash(struct sock *sk, struct inet_bind_bucket *tb,
 		    const unsigned short snum)
 {
 	inet_sk(sk)->num = snum;
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 70cea9d..583acc3 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -129,7 +129,7 @@ static int sysctl_tcp_congestion_control
 }
 
 
-ctl_table ipv4_table[] = {
+ctl_table __global ipv4_table[] = {
         {
 		.ctl_name	= NET_IPV4_TCP_TIMESTAMPS,
 		.procname	= "tcp_timestamps",
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 7c1bde3..67af642 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -431,7 +431,7 @@ static void tcp_synack_timer(struct sock
 				   TCP_TIMEOUT_INIT, TCP_RTO_MAX);
 }
 
-void tcp_set_keepalive(struct sock *sk, int val)
+void __global tcp_set_keepalive(struct sock *sk, int val)
 {
 	if ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))
 		return;
@@ -442,7 +442,6 @@ void tcp_set_keepalive(struct sock *sk, 
 		inet_csk_delete_keepalive_timer(sk);
 }
 
-
 static void tcp_keepalive_timer (unsigned long data)
 {
 	struct sock *sk = (struct sock *) data;
diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index 5d29d5e..13af457 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -245,7 +245,7 @@ struct proc_dir_entry *proc_net_netfilte
 EXPORT_SYMBOL(proc_net_netfilter);
 #endif
 
-void __init netfilter_init(void)
+void __init __global netfilter_init(void)
 {
 	int i, h;
 	for (i = 0; i < NPROTO; i++) {
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 0834c2e..f897dc3 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -182,7 +182,7 @@ requeue:
 	return q->q.qlen;
 }
 
-void __qdisc_run(struct net_device *dev)
+void __global __qdisc_run(struct net_device *dev)
 {
 	if (unlikely(dev->qdisc == &noop_qdisc))
 		goto out;
@@ -535,7 +535,7 @@ void qdisc_destroy(struct Qdisc *qdisc)
 	call_rcu(&qdisc->q_rcu, __qdisc_destroy);
 }
 
-void dev_activate(struct net_device *dev)
+void __global dev_activate(struct net_device *dev)
 {
 	/* No queueing discipline is attached to device;
 	   create default one i.e. pfifo_fast for devices,
@@ -575,7 +575,7 @@ void dev_activate(struct net_device *dev
 	spin_unlock_bh(&dev->queue_lock);
 }
 
-void dev_deactivate(struct net_device *dev)
+void __global dev_deactivate(struct net_device *dev)
 {
 	struct Qdisc *qdisc;
 
@@ -602,7 +602,7 @@ void dev_deactivate(struct net_device *d
 	}
 }
 
-void dev_init_scheduler(struct net_device *dev)
+void __global dev_init_scheduler(struct net_device *dev)
 {
 	qdisc_lock_tree(dev);
 	dev->qdisc = &noop_qdisc;
@@ -613,7 +613,7 @@ void dev_init_scheduler(struct net_devic
 	dev_watchdog_init(dev);
 }
 
-void dev_shutdown(struct net_device *dev)
+void __global dev_shutdown(struct net_device *dev)
 {
 	struct Qdisc *qdisc;
 
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index f35bc67..e436c99 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -748,7 +748,7 @@ static struct xfrm_policy *clone_policy(
 	return newp;
 }
 
-int __xfrm_sk_clone_policy(struct sock *sk)
+int __global __xfrm_sk_clone_policy(struct sock *sk)
 {
 	struct xfrm_policy *p0 = sk->sk_policy[0],
 			   *p1 = sk->sk_policy[1];
@@ -1438,7 +1438,7 @@ static void __init xfrm_policy_init(void
 	register_netdevice_notifier(&xfrm_dev_notifier);
 }
 
-void __init xfrm_init(void)
+void __init __global xfrm_init(void)
 {
 	xfrm_state_init();
 	xfrm_policy_init();
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index a300702..1eaaa94 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -686,7 +686,7 @@ void avc_audit(u32 ssid, u32 tsid,
  * @perms based on @tclass.  Returns %0 on success or
  * -%ENOMEM if insufficient memory exists to add the callback.
  */
-int avc_add_callback(int (*callback)(u32 event, u32 ssid, u32 tsid,
+int __global avc_add_callback(int (*callback)(u32 event, u32 ssid, u32 tsid,
                                      u16 tclass, u32 perms,
                                      u32 *out_retained),
                      u32 events, u32 ssid, u32 tsid,
@@ -797,7 +797,7 @@ out:
  * avc_ss_reset - Flush the cache and revalidate migrated permissions.
  * @seqno: policy sequence number
  */
-int avc_ss_reset(u32 seqno)
+int __global avc_ss_reset(u32 seqno)
 {
 	struct avc_callback_node *c;
 	int i, rc = 0, tmprc;
diff --git a/security/selinux/exports.c b/security/selinux/exports.c
index 9d7737d..39ab9a5 100644
--- a/security/selinux/exports.c
+++ b/security/selinux/exports.c
@@ -21,7 +21,7 @@ #include <linux/ipc.h>
 #include "security.h"
 #include "objsec.h"
 
-void selinux_task_ctxid(struct task_struct *tsk, u32 *ctxid)
+void __global selinux_task_ctxid(struct task_struct *tsk, u32 *ctxid)
 {
 	struct task_security_struct *tsec = tsk->security;
 	if (selinux_enabled)
@@ -30,7 +30,7 @@ void selinux_task_ctxid(struct task_stru
 		*ctxid = 0;
 }
 
-int selinux_ctxid_to_string(u32 ctxid, char **ctx, u32 *ctxlen)
+int __global selinux_ctxid_to_string(u32 ctxid, char **ctx, u32 *ctxlen)
 {
 	if (selinux_enabled)
 		return security_sid_to_context(ctxid, ctx, ctxlen);
@@ -42,7 +42,7 @@ int selinux_ctxid_to_string(u32 ctxid, c
 	return 0;
 }
 
-void selinux_get_inode_sid(const struct inode *inode, u32 *sid)
+void __global selinux_get_inode_sid(const struct inode *inode, u32 *sid)
 {
 	if (selinux_enabled) {
 		struct inode_security_struct *isec = inode->i_security;
@@ -52,7 +52,7 @@ void selinux_get_inode_sid(const struct 
 	*sid = 0;
 }
 
-void selinux_get_ipc_sid(const struct kern_ipc_perm *ipcp, u32 *sid)
+void __global selinux_get_ipc_sid(const struct kern_ipc_perm *ipcp, u32 *sid)
 {
 	if (selinux_enabled) {
 		struct ipc_security_struct *isec = ipcp->security;
@@ -62,7 +62,7 @@ void selinux_get_ipc_sid(const struct ke
 	*sid = 0;
 }
 
-void selinux_get_task_sid(struct task_struct *tsk, u32 *sid)
+void __global selinux_get_task_sid(struct task_struct *tsk, u32 *sid)
 {
 	if (selinux_enabled) {
 		struct task_security_struct *tsec = tsk->security;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5d1b8c7..50e0269 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -83,7 +83,7 @@ extern int selinux_nlmsg_lookup(u16 scla
 extern int selinux_compat_net;
 
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
-int selinux_enforcing = 0;
+int __global selinux_enforcing = 0;
 
 static int __init enforcing_setup(char *str)
 {
@@ -4683,7 +4683,7 @@ #endif
 	return 0;
 }
 
-void selinux_complete_init(void)
+void __global selinux_complete_init(void)
 {
 	printk(KERN_INFO "SELinux:  Completing initialization.\n");
 
diff --git a/security/selinux/netlink.c b/security/selinux/netlink.c
index e203883..dcb1ec4 100644
--- a/security/selinux/netlink.c
+++ b/security/selinux/netlink.c
@@ -97,7 +97,7 @@ void selnl_notify_setenforce(int val)
 	selnl_notify(SELNL_MSG_SETENFORCE, &val);
 }
 
-void selnl_notify_policyload(u32 seqno)
+void __global selnl_notify_policyload(u32 seqno)
 {
 	selnl_notify(SELNL_MSG_POLICYLOAD, &seqno);
 }
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index f03960e..3ed702f 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -45,7 +45,7 @@ static char *symtab_name[SYM_NUM] = {
 };
 #endif
 
-int selinux_mls_enabled = 0;
+int __global selinux_mls_enabled = 0;
 
 static unsigned int symtab_sizes[SYM_NUM] = {
 	2,
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 85e4298..58bd308 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -42,7 +42,7 @@ #include "conditional.h"
 #include "mls.h"
 
 extern void selnl_notify_policyload(u32 seqno);
-unsigned int policydb_loaded_version;
+unsigned int __global policydb_loaded_version;
 
 static DEFINE_RWLOCK(policy_rwlock);
 #define POLICY_RDLOCK read_lock(&policy_rwlock)
@@ -56,7 +56,7 @@ #define LOAD_UNLOCK mutex_unlock(&load_m
 
 static struct sidtab sidtab;
 struct policydb policydb;
-int ss_initialized = 0;
+int __global ss_initialized = 0;
 
 /*
  * The largest sequence number that has been used when
@@ -397,7 +397,7 @@ out:
 	return -EPERM;
 }
 
-int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
+int __global security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
                                  u16 tclass)
 {
 	struct context *ocontext;
@@ -484,7 +484,7 @@ out:
  * Return -%EINVAL if any of the parameters are invalid or %0
  * if the access vector decisions were computed successfully.
  */
-int security_compute_av(u32 ssid,
+int __global security_compute_av(u32 ssid,
 			u32 tsid,
 			u16 tclass,
 			u32 requested,
@@ -583,7 +583,7 @@ #include "initial_sid_to_string.h"
  * into a dynamically allocated string of the correct size.  Set @scontext
  * to point to this string and set @scontext_len to the length of the string.
  */
-int security_sid_to_context(u32 sid, char **scontext, u32 *scontext_len)
+int __global security_sid_to_context(u32 sid, char **scontext, u32 *scontext_len)
 {
 	struct context *context;
 	int rc = 0;
@@ -749,7 +749,7 @@ out:
  * Returns -%EINVAL if the context is invalid, -%ENOMEM if insufficient
  * memory is available, or 0 on success.
  */
-int security_context_to_sid(char *scontext, u32 scontext_len, u32 *sid)
+int __global security_context_to_sid(char *scontext, u32 scontext_len, u32 *sid)
 {
 	return security_context_to_sid_core(scontext, scontext_len,
 	                                    sid, SECSID_NULL);
@@ -772,7 +772,7 @@ int security_context_to_sid(char *sconte
  * Returns -%EINVAL if the context is invalid, -%ENOMEM if insufficient
  * memory is available, or 0 on success.
  */
-int security_context_to_sid_default(char *scontext, u32 scontext_len, u32 *sid, u32 def_sid)
+int __global security_context_to_sid_default(char *scontext, u32 scontext_len, u32 *sid, u32 def_sid)
 {
 	return security_context_to_sid_core(scontext, scontext_len,
 	                                    sid, def_sid);
@@ -959,7 +959,7 @@ out:
  * if insufficient memory is available, or %0 if the new SID was
  * computed successfully.
  */
-int security_transition_sid(u32 ssid,
+int __global security_transition_sid(u32 ssid,
 			    u32 tsid,
 			    u16 tclass,
 			    u32 *out_sid)
@@ -980,7 +980,7 @@ int security_transition_sid(u32 ssid,
  * if insufficient memory is available, or %0 if the SID was
  * computed successfully.
  */
-int security_member_sid(u32 ssid,
+int __global security_member_sid(u32 ssid,
 			u32 tsid,
 			u16 tclass,
 			u32 *out_sid)
@@ -1001,7 +1001,7 @@ int security_member_sid(u32 ssid,
  * if insufficient memory is available, or %0 if the SID was
  * computed successfully.
  */
-int security_change_sid(u32 ssid,
+int __global security_change_sid(u32 ssid,
 			u32 tsid,
 			u16 tclass,
 			u32 *out_sid)
@@ -1210,7 +1210,7 @@ extern void selinux_complete_init(void);
  * This function will flush the access vector cache after
  * loading the new policy.
  */
-int security_load_policy(void *data, size_t len)
+int __global security_load_policy(void *data, size_t len)
 {
 	struct policydb oldpolicydb, newpolicydb;
 	struct sidtab oldsidtab, newsidtab;
@@ -1314,7 +1314,7 @@ err:
  * @port: port number
  * @out_sid: security identifier
  */
-int security_port_sid(u16 domain,
+int __global security_port_sid(u16 domain,
 		      u16 type,
 		      u8 protocol,
 		      u16 port,
@@ -1358,7 +1358,7 @@ out:
  * @if_sid: interface SID
  * @msg_sid: default SID for received packets
  */
-int security_netif_sid(char *name,
+int __global security_netif_sid(char *name,
 		       u32 *if_sid,
 		       u32 *msg_sid)
 {
@@ -1419,7 +1419,7 @@ static int match_ipv6_addrmask(u32 *inpu
  * @addrlen: address length in bytes
  * @out_sid: security identifier
  */
-int security_node_sid(u16 domain,
+int __global security_node_sid(u16 domain,
 		      void *addrp,
 		      u32 addrlen,
 		      u32 *out_sid)
@@ -1502,7 +1502,7 @@ #define SIDS_NEL 25
  * number of elements in the array.
  */
 
-int security_get_user_sids(u32 fromsid,
+int __global security_get_user_sids(u32 fromsid,
 	                   char *username,
 			   u32 **sids,
 			   u32 *nel)
@@ -1605,7 +1605,7 @@ out:
  * cannot support xattr or use a fixed labeling behavior like
  * transition SIDs or task SIDs.
  */
-int security_genfs_sid(const char *fstype,
+int __global security_genfs_sid(const char *fstype,
 	               char *path,
 		       u16 sclass,
 		       u32 *sid)
@@ -1662,7 +1662,7 @@ out:
  * @behavior: labeling behavior
  * @sid: SID for filesystem (superblock)
  */
-int security_fs_use(
+int __global security_fs_use(
 	const char *fstype,
 	unsigned int *behavior,
 	u32 *sid)
@@ -1704,7 +1704,7 @@ out:
 	return rc;
 }
 
-int security_get_bools(int *len, char ***names, int **values)
+int __global security_get_bools(int *len, char ***names, int **values)
 {
 	int i, rc = -ENOMEM;
 
@@ -1750,7 +1750,7 @@ err:
 }
 
 
-int security_set_bools(int len, int *values)
+int __global security_set_bools(int len, int *values)
 {
 	int i, rc = 0;
 	int lenp, seqno = 0;
@@ -1798,7 +1798,7 @@ out:
 	return rc;
 }
 
-int security_get_bool_value(int bool)
+int __global security_get_bool_value(int bool)
 {
 	int rc = 0;
 	int len;
@@ -1822,7 +1822,7 @@ struct selinux_audit_rule {
 	struct context au_ctxt;
 };
 
-void selinux_audit_rule_free(struct selinux_audit_rule *rule)
+void __global selinux_audit_rule_free(struct selinux_audit_rule *rule)
 {
 	if (rule) {
 		context_destroy(&rule->au_ctxt);
@@ -1830,7 +1830,7 @@ void selinux_audit_rule_free(struct seli
 	}
 }
 
-int selinux_audit_rule_init(u32 field, u32 op, char *rulestr,
+int __global selinux_audit_rule_init(u32 field, u32 op, char *rulestr,
                             struct selinux_audit_rule **rule)
 {
 	struct selinux_audit_rule *tmprule;
@@ -1923,7 +1923,7 @@ int selinux_audit_rule_init(u32 field, u
 	return rc;
 }
 
-int selinux_audit_rule_match(u32 ctxid, u32 field, u32 op,
+int __global selinux_audit_rule_match(u32 ctxid, u32 field, u32 op,
                              struct selinux_audit_rule *rule,
                              struct audit_context *actx)
 {
@@ -2060,7 +2060,7 @@ static int __init aurule_init(void)
 }
 __initcall(aurule_init);
 
-void selinux_audit_set_callback(int (*callback)(void))
+void __global selinux_audit_set_callback(int (*callback)(void))
 {
 	aurule_callback = callback;
 }
diff --git a/sound/core/sound_oss.c b/sound/core/sound_oss.c

-- 
dwmw2

