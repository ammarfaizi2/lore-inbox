Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267048AbSLXGrV>; Tue, 24 Dec 2002 01:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267049AbSLXGrV>; Tue, 24 Dec 2002 01:47:21 -0500
Received: from holomorphy.com ([66.224.33.161]:5844 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267048AbSLXGrC>;
	Tue, 24 Dec 2002 01:47:02 -0500
Date: Mon, 23 Dec 2002 22:54:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, bcrl@redhat.com, rohit.seth@intel.com, akpm@zip.com.au
Subject: [hugetlb] remove hugetlb syscalls
Message-ID: <20021224065420.GB25000@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, bcrl@redhat.com,
	rohit.seth@intel.com, akpm@zip.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove hugetlb syscalls.

Originally by bcrl, compiletested on i386; prior versions were tested
more thoroughly. Testing underway.


Bill

diff -urpN mm2-2.5.52-1/arch/i386/kernel/entry.S mm2-2.5.52-bcrl/arch/i386/kernel/entry.S
--- mm2-2.5.52-1/arch/i386/kernel/entry.S	2002-12-18 22:01:00.000000000 -0800
+++ mm2-2.5.52-bcrl/arch/i386/kernel/entry.S	2002-12-23 22:32:38.000000000 -0800
@@ -817,8 +817,8 @@ ENTRY(sys_call_table)
 	.long sys_io_getevents
 	.long sys_io_submit
 	.long sys_io_cancel
-	.long sys_alloc_hugepages /* 250 */
-	.long sys_free_hugepages
+	.long sys_ni_syscall /* 250 */
+	.long sys_ni_syscall
 	.long sys_exit_group
 	.long sys_lookup_dcookie
 	.long sys_epoll_create
diff -urpN mm2-2.5.52-1/arch/i386/kernel/sys_i386.c mm2-2.5.52-bcrl/arch/i386/kernel/sys_i386.c
--- mm2-2.5.52-1/arch/i386/kernel/sys_i386.c	2002-12-18 22:01:00.000000000 -0800
+++ mm2-2.5.52-bcrl/arch/i386/kernel/sys_i386.c	2002-12-23 22:33:32.000000000 -0800
@@ -9,7 +9,6 @@
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
-#include <linux/hugetlb.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/sem.h>
@@ -251,73 +250,3 @@ asmlinkage int sys_olduname(struct oldol
 
 	return error;
 }
-
-#ifdef CONFIG_HUGETLB_PAGE
-/* get_addr function gets the currently unused virtaul range in
- * current process's address space.  It returns the HPAGE_SIZE
- * aligned address (in cases of success).  Other kernel generic
- * routines only could gurantee that allocated address is PAGE_SIZE aligned.
- */
-static unsigned long get_addr(unsigned long addr, unsigned long len)
-{
-	struct vm_area_struct *vma;
-	if (addr) {
-		addr = (addr + HPAGE_SIZE - 1) & HPAGE_MASK;
-		vma = find_vma(current->mm, addr);
-		if (TASK_SIZE > addr + len && !(vma && addr + len >= vma->vm_start))
-			goto found_addr;
-	}
-	addr = TASK_UNMAPPED_BASE;
-	for (vma = find_vma(current->mm, addr); TASK_SIZE > addr + len; vma = vma->vm_next) {
-		if (!vma || addr + len < vma->vm_start)
-			goto found_addr;
-		addr = (vma->vm_end + HPAGE_SIZE - 1) & HPAGE_MASK;
-	}
-	return -ENOMEM;
-found_addr:
-	return addr;
-}
-
-asmlinkage unsigned long sys_alloc_hugepages(int key, unsigned long addr, unsigned long len, int prot, int flag)
-{
-	struct mm_struct *mm = current->mm;
-	unsigned long   raddr;
-	int     retval = 0;
-	extern int alloc_hugetlb_pages(int, unsigned long, unsigned long, int, int);
-	if (!cpu_has_pse || key < 0 || len & ~HPAGE_MASK)
-		return -EINVAL;
-	down_write(&mm->mmap_sem);
-	raddr = get_addr(addr, len);
-	if (raddr != -ENOMEM)
-		retval = alloc_hugetlb_pages(key, raddr, len, prot, flag);
-	up_write(&mm->mmap_sem);
-	return (retval < 0) ? (unsigned long)retval : raddr;
-}
-
-asmlinkage int sys_free_hugepages(unsigned long addr)
-{
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	int retval;
-
-	down_write(&mm->mmap_sem);
-	vma = find_vma(current->mm, addr);
-	if (!vma || !(vma->vm_flags & VM_HUGETLB) || vma->vm_start != addr) {
-		retval = -EINVAL;
-		goto out;
-	}
-	retval = do_munmap(vma->vm_mm, addr, vma->vm_end - addr);
-out:
-	up_write(&mm->mmap_sem);
-	return retval;
-}
-#else
-asmlinkage unsigned long sys_alloc_hugepages(int key, unsigned long addr, size_t len, int prot, int flag)
-{
-	return -ENOSYS;
-}
-asmlinkage int sys_free_hugepages(unsigned long addr)
-{
-	return -ENOSYS;
-}
-#endif
diff -urpN mm2-2.5.52-1/arch/i386/mm/hugetlbpage.c mm2-2.5.52-bcrl/arch/i386/mm/hugetlbpage.c
--- mm2-2.5.52-1/arch/i386/mm/hugetlbpage.c	2002-12-18 22:01:00.000000000 -0800
+++ mm2-2.5.52-bcrl/arch/i386/mm/hugetlbpage.c	2002-12-23 22:51:06.000000000 -0800
@@ -31,120 +31,6 @@ struct vm_operations_struct hugetlb_vm_o
 static LIST_HEAD(htlbpage_freelist);
 static spinlock_t htlbpage_lock = SPIN_LOCK_UNLOCKED;
 
-#define MAX_ID 	32
-
-struct hugetlb_key {
-	struct radix_tree_root tree;
-	atomic_t count;
-	spinlock_t lock;
-	int key;
-	int busy;
-	uid_t uid;
-	gid_t gid;
-	umode_t mode;
-	loff_t size;
-};
-
-static struct hugetlb_key htlbpagek[MAX_ID];
-
-static void mark_key_busy(struct hugetlb_key *hugetlb_key)
-{
-	hugetlb_key->busy = 1;
-}
-
-static void clear_key_busy(struct hugetlb_key *hugetlb_key)
-{
-	hugetlb_key->busy = 0;
-}
-
-static int key_busy(struct hugetlb_key *hugetlb_key)
-{
-	return hugetlb_key->busy;
-}
-
-static struct hugetlb_key *find_key(int key)
-{
-	int i;
-
-	for (i = 0; i < MAX_ID; i++) {
-		if (htlbpagek[i].key == key)
-			return &htlbpagek[i];
-	}
-	return NULL;
-}
-
-static int check_size_prot(struct hugetlb_key *key, unsigned long len, int prot, int flag);
-/*
- * Call without htlbpage_lock, returns with htlbpage_lock held.
- */
-struct hugetlb_key *alloc_key(int key, unsigned long len, int prot, int flag)
-{
-	struct hugetlb_key *hugetlb_key;
-
-	do {
-		spin_lock(&htlbpage_lock);
-		hugetlb_key = find_key(key);
-		if (!hugetlb_key) {
-			if (!capable(CAP_SYS_ADMIN) || !capable(CAP_IPC_LOCK) || !in_group_p(0))
-				hugetlb_key = ERR_PTR(-EPERM);
-			else if (!(flag & IPC_CREAT))
-				hugetlb_key = ERR_PTR(-ENOENT);
-			else {
-				int i;
-				for (i = 0; i < MAX_ID; ++i)
-					if (!htlbpagek[i].key)
-						break;
-				if (i == MAX_ID) {
-					hugetlb_key = ERR_PTR(-ENOMEM);
-				} else {
-					hugetlb_key = &htlbpagek[i];
-					mark_key_busy(hugetlb_key);
-					hugetlb_key->key = key;
-					INIT_RADIX_TREE(&hugetlb_key->tree, GFP_ATOMIC);
-					hugetlb_key->uid = current->fsuid;
-					hugetlb_key->gid = current->fsgid;
-					hugetlb_key->mode = prot;
-					hugetlb_key->size = len;
-				}
-			}
-		} else if (key_busy(hugetlb_key)) {
-			hugetlb_key = ERR_PTR(-EAGAIN);
-			spin_unlock(&htlbpage_lock);
-		} else if (check_size_prot(hugetlb_key, len, prot, flag) < 0) {
-			hugetlb_key = ERR_PTR(-EINVAL);
-		} 
-	} while (hugetlb_key == ERR_PTR(-EAGAIN));
-	if (!IS_ERR(hugetlb_key))
-		atomic_inc(&hugetlb_key->count);
-	return hugetlb_key;
-}
-
-void hugetlb_release_key(struct hugetlb_key *key)
-{
-	unsigned long index;
-	unsigned long max_idx;
-
-	if (!atomic_dec_and_test(&key->count)) {
-		spin_lock(&htlbpage_lock);
-		clear_key_busy(key);
-		spin_unlock(&htlbpage_lock);
-		return;	
-	}
-
-	max_idx = (key->size >> HPAGE_SHIFT);
-	for (index = 0; index < max_idx; ++index) {
-		struct page *page = radix_tree_lookup(&key->tree, index);
-		if (!page)
-			continue;
-		huge_page_release(page);
-	}
-	spin_lock(&htlbpage_lock);
-	key->key = 0;
-	clear_key_busy(key);
-	INIT_RADIX_TREE(&key->tree, GFP_ATOMIC);
-	spin_unlock(&htlbpage_lock);
-}
-
 static struct page *alloc_hugetlb_page(void)
 {
 	int i;
@@ -203,69 +89,14 @@ static void set_huge_pte(struct mm_struc
 	set_pte(page_table, entry);
 }
 
-static int anon_get_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma, int write_access, pte_t *page_table)
-{
-	struct page *page = alloc_hugetlb_page();
-	if (page)
-		set_huge_pte(mm, vma, page, page_table, write_access);
-	return page ? 1 : -1;
-}
-
-static int make_hugetlb_pages_present(unsigned long addr, unsigned long end, int flags)
-{
-	int write;
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	pte_t *pte;
-
-	vma = find_vma(mm, addr);
-	if (!vma)
-		goto out_error1;
-
-	write = (vma->vm_flags & VM_WRITE) != 0;
-	if ((vma->vm_end - vma->vm_start) & (HPAGE_SIZE - 1))
-		goto out_error1;
-	spin_lock(&mm->page_table_lock);
-	do {
-		pte = huge_pte_alloc(mm, addr);
-		if ((pte) && (pte_none(*pte))) {
-			if (anon_get_hugetlb_page(mm, vma,
-					   write ? VM_WRITE : VM_READ,
-					   pte) == -1)
-				goto out_error;
-		} else
-			goto out_error;
-		addr += HPAGE_SIZE;
-	} while (addr < end);
-	spin_unlock(&mm->page_table_lock);
-	vma->vm_flags |= (VM_HUGETLB | VM_RESERVED);
-	if (flags & MAP_PRIVATE)
-		vma->vm_flags |= VM_DONTCOPY;
-	vma->vm_ops = &hugetlb_vm_ops;
-	return 0;
-out_error:		/* Error case, remove the partial lp_resources. */
-	if (addr > vma->vm_start) {
-		vma->vm_end = addr;
-		zap_hugepage_range(vma, vma->vm_start, vma->vm_end - vma->vm_start);
-		vma->vm_end = end;
-	}
-	spin_unlock(&mm->page_table_lock);
-out_error1:
-	return -1;
-}
-
-int
-copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
+int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			struct vm_area_struct *vma)
 {
 	pte_t *src_pte, *dst_pte, entry;
 	struct page *ptepage;
 	unsigned long addr = vma->vm_start;
 	unsigned long end = vma->vm_end;
-	struct hugetlb_key *key = vma->vm_private_data;
 
-	if (key)
-		atomic_inc(&key->count);
 	while (addr < end) {
 		dst_pte = huge_pte_alloc(dst, addr);
 		if (!dst_pte)
@@ -339,14 +170,11 @@ void unmap_hugepage_range(struct vm_area
 	unsigned long address;
 	pte_t *pte;
 	struct page *page;
-	struct hugetlb_key *key = vma->vm_private_data;
 
 	BUG_ON(start & (HPAGE_SIZE - 1));
 	BUG_ON(end & (HPAGE_SIZE - 1));
 
 	spin_lock(&htlbpage_lock);
-	if (key ) 
-		mark_key_busy(key);
 	spin_unlock(&htlbpage_lock);
 	for (address = start; address < end; address += HPAGE_SIZE) {
 		pte = huge_pte_offset(mm, address);
@@ -356,8 +184,6 @@ void unmap_hugepage_range(struct vm_area
 		huge_page_release(page);
 		pte_clear(pte);
 	}
-	if (key)
-		hugetlb_release_key(key);
 	mm->rss -= (end - start) >> PAGE_SHIFT;
 	flush_tlb_range(vma, start, end);
 }
@@ -370,112 +196,6 @@ void zap_hugepage_range(struct vm_area_s
 	spin_unlock(&mm->page_table_lock);
 }
 
-static int check_size_prot(struct hugetlb_key *key, unsigned long len, int prot, int flag)
-{
-	if (key->uid != current->fsuid)
-		return -1;
-	if (key->gid != current->fsgid)
-		return -1;
-	if (key->size != len)
-		return -1;
-	return 0;
-}
-
-struct page *key_find_page(struct hugetlb_key *key, unsigned long index)
-{
-	struct page *page = radix_tree_lookup(&key->tree, index);
-	if (page)
-		get_page(page);
-	return page;
-}
-
-int key_add_page(struct page *page, struct hugetlb_key *key, unsigned long index)
-{
-	int error = radix_tree_insert(&key->tree, index, page);
-	if (!error)
-		get_page(page);
-	return error;
-}
-
-static int prefault_key(struct hugetlb_key *key, struct vm_area_struct *vma)
-{
-	struct mm_struct *mm = current->mm;
-	unsigned long addr;
-	int ret = 0;
-
-	BUG_ON(vma->vm_start & ~HPAGE_MASK);
-	BUG_ON(vma->vm_end & ~HPAGE_MASK);
-
-	spin_lock(&mm->page_table_lock);
-	spin_lock(&key->lock);
-	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
-		unsigned long idx;
-		pte_t *pte = huge_pte_alloc(mm, addr);
-		struct page *page;
-
-		if (!pte) {
-			ret = -ENOMEM;
-			goto out;
-		}
-		if (!pte_none(*pte))
-			continue;
-
-		idx = ((addr - vma->vm_start) >> HPAGE_SHIFT)
-			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
-		page = key_find_page(key, idx);
-		if (!page) {
-			page = alloc_hugetlb_page();
-			if (!page) {
-				ret = -ENOMEM;
-				goto out;
-			}
-			key_add_page(page, key, idx);
-		}
-		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
-	}
-out:
-	spin_unlock(&key->lock);
-	spin_unlock(&mm->page_table_lock);
-	return ret;
-}
-
-static int alloc_shared_hugetlb_pages(int key, unsigned long addr, unsigned long len, int prot, int flag)
-{
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	struct hugetlb_key *hugetlb_key;
-	int retval = -ENOMEM;
-
-	hugetlb_key = alloc_key(key, len, prot, flag );
-	spin_unlock(&htlbpage_lock);
-	if (IS_ERR(hugetlb_key)) 
-		return PTR_ERR(hugetlb_key);
-
-	addr = do_mmap_pgoff(NULL, addr, len, (unsigned long) prot,
-			MAP_NORESERVE|MAP_FIXED|MAP_PRIVATE|MAP_ANONYMOUS, 0);
-	if (IS_ERR((void *) addr))
-		goto out_release;
-
-	vma = find_vma(mm, addr);
-	if (!vma) {
-		retval = -EINVAL;
-		goto out_release;
-	}
-
-	retval = prefault_key(hugetlb_key, vma);
-
-	vma->vm_flags |= (VM_HUGETLB | VM_RESERVED);
-	vma->vm_ops = &hugetlb_vm_ops;
-	vma->vm_private_data = hugetlb_key;
-	spin_lock(&htlbpage_lock);
-	clear_key_busy(hugetlb_key);
-	spin_unlock(&htlbpage_lock);
-	return retval;
-out_release:
-	hugetlb_release_key(hugetlb_key);
-	return retval;
-}
-
 int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
 {
 	struct mm_struct *mm = current->mm;
@@ -517,27 +237,6 @@ out:
 	return ret;
 }
 
-static int alloc_private_hugetlb_pages(int key, unsigned long addr, unsigned long len, int prot, int flag)
-{
-	if (!capable(CAP_IPC_LOCK) && !in_group_p(0))
-		return -EPERM;
-	addr = do_mmap_pgoff(NULL, addr, len, prot,
-			MAP_NORESERVE|MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, 0);
-	if (IS_ERR((void *) addr))
-		return -ENOMEM;
-	if (make_hugetlb_pages_present(addr, (addr + len), flag) < 0) {
-		do_munmap(current->mm, addr, len);
-		return -ENOMEM;
-	}
-	return 0;
-}
-
-int alloc_hugetlb_pages(int key, unsigned long addr, unsigned long len, int prot, int flag)
-{
-	if (key > 0)
-		return alloc_shared_hugetlb_pages(key, addr, len, prot, flag);
-	return alloc_private_hugetlb_pages(key, addr, len, prot, flag);
-}
 void update_and_free_page(struct page *page)
 {
 	int j;
@@ -663,10 +362,6 @@ static int __init hugetlb_init(void)
 	}
 	htlbpage_max = htlbpagemem = htlbzone_pages = i;
 	printk("Total HugeTLB memory allocated, %ld\n", htlbpagemem);
-	for (i = 0; i < MAX_ID; ++i) {
-		atomic_set(&htlbpagek[i].count, 0);
-		spin_lock_init(&htlbpagek[i].lock);
-	}
 	return 0;
 }
 module_init(hugetlb_init);
@@ -689,7 +384,7 @@ int is_hugepage_mem_enough(size_t size)
 	return 1;
 }
 
-static struct page * hugetlb_nopage(struct vm_area_struct * area, unsigned long address, int unused)
+static struct page *hugetlb_nopage(struct vm_area_struct * area, unsigned long address, int unused)
 {
 	BUG();
 	return NULL;
diff -urpN mm2-2.5.52-1/arch/ia64/kernel/entry.S mm2-2.5.52-bcrl/arch/ia64/kernel/entry.S
--- mm2-2.5.52-1/arch/ia64/kernel/entry.S	2002-12-15 18:07:50.000000000 -0800
+++ mm2-2.5.52-bcrl/arch/ia64/kernel/entry.S	2002-12-23 22:39:22.000000000 -0800
@@ -1242,8 +1242,8 @@ sys_call_table:
 	data8 sys_sched_setaffinity
 	data8 sys_sched_getaffinity
 	data8 sys_ni_syscall
-	data8 sys_alloc_hugepages
-	data8 sys_free_hugepages		// 1235
+	data8 ia64_ni_syscall
+	data8 ia64_ni_syscall		// 1235
 	data8 sys_exit_group
 	data8 sys_lookup_dcookie
 	data8 sys_io_setup
diff -urpN mm2-2.5.52-1/arch/ia64/kernel/sys_ia64.c mm2-2.5.52-bcrl/arch/ia64/kernel/sys_ia64.c
--- mm2-2.5.52-1/arch/ia64/kernel/sys_ia64.c	2002-12-15 18:08:10.000000000 -0800
+++ mm2-2.5.52-bcrl/arch/ia64/kernel/sys_ia64.c	2002-12-23 22:44:49.000000000 -0800
@@ -9,7 +9,6 @@
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
-#include <linux/hugetlb.h>
 #include <linux/mman.h>
 #include <linux/sched.h>
 #include <linux/file.h>		/* doh, must come after sched.h... */
@@ -20,11 +19,6 @@
 #include <asm/shmparam.h>
 #include <asm/uaccess.h>
 
-#ifdef CONFIG_HUGETLB_PAGE
-# define SHMLBA_HPAGE		HPAGE_SIZE
-# define COLOR_HALIGN(addr)	(((addr) + SHMLBA_HPAGE - 1) & ~(SHMLBA_HPAGE - 1))
-# define TASK_HPAGE_BASE	((REGION_HPAGE << REGION_SHIFT) | HPAGE_SIZE)
-#endif
 
 unsigned long
 arch_get_unmapped_area (struct file *filp, unsigned long addr, unsigned long len,
@@ -243,80 +237,6 @@ sys_mmap (unsigned long addr, unsigned l
 	return addr;
 }
 
-#ifdef CONFIG_HUGETLB_PAGE
-
-asmlinkage unsigned long
-sys_alloc_hugepages (int key, unsigned long addr, size_t len, int prot, int flag)
-{
-	struct mm_struct *mm = current->mm;
-	long retval;
-	extern int alloc_hugetlb_pages (int, unsigned long, unsigned long, int, int);
-
-	if ((key < 0) || (len & (HPAGE_SIZE - 1)))
-		return -EINVAL;
-
-	if (addr && ((REGION_NUMBER(addr) != REGION_HPAGE) || (addr & (HPAGE_SIZE - 1))))
-		addr = TASK_HPAGE_BASE;
-
-	if (!addr)
-		addr = TASK_HPAGE_BASE;
-	down_write(&mm->mmap_sem);
-	{
-		retval = arch_get_unmapped_area(NULL, COLOR_HALIGN(addr), len, 0, 0);
-		if (retval != -ENOMEM)
-			retval = alloc_hugetlb_pages(key, retval, len, prot, flag);
-	}
-	up_write(&mm->mmap_sem);
-
-	if (IS_ERR((void *) retval))
-		return retval;
-
-	force_successful_syscall_return();
-	return retval;
-}
-
-asmlinkage int
-sys_free_hugepages (unsigned long  addr)
-{
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	extern int free_hugepages(struct vm_area_struct *);
-	int retval;
-
-	down_write(&mm->mmap_sem);
-	{
-		vma = find_vma(mm, addr);
-		if (!vma || !is_vm_hugetlb_page(vma) || (vma->vm_start != addr))
-			retval = -EINVAL;
-			goto out;
-
-		spin_lock(&mm->page_table_lock);
-		{
-			retval = free_hugepages(vma);
-		}
-		spin_unlock(&mm->page_table_lock);
-	}
-out:
-	up_write(&mm->mmap_sem);
-	return retval;
-}
-
-#else /* !CONFIG_HUGETLB_PAGE */
-
-asmlinkage unsigned long
-sys_alloc_hugepages (int key, size_t addr, unsigned long len, int prot, int flag)
-{
-	return -ENOSYS;
-}
-
-asmlinkage unsigned long
-sys_free_hugepages (unsigned long  addr)
-{
-	return -ENOSYS;
-}
-
-#endif /* !CONFIG_HUGETLB_PAGE */
-
 asmlinkage long
 sys_vm86 (long arg0, long arg1, long arg2, long arg3)
 {
diff -urpN mm2-2.5.52-1/arch/ia64/mm/hugetlbpage.c mm2-2.5.52-bcrl/arch/ia64/mm/hugetlbpage.c
--- mm2-2.5.52-1/arch/ia64/mm/hugetlbpage.c	2002-12-18 22:01:00.000000000 -0800
+++ mm2-2.5.52-bcrl/arch/ia64/mm/hugetlbpage.c	2002-12-23 22:46:32.000000000 -0800
@@ -26,24 +26,6 @@ extern long htlbpagemem;
 
 static void zap_hugetlb_resources (struct vm_area_struct *);
 
-#define MAX_ID 	32
-struct htlbpagekey {
-	struct inode *in;
-	int key;
-} htlbpagek[MAX_ID];
-
-static struct inode *
-find_key_inode(int key)
-{
-	int i;
-
-	for (i = 0; i < MAX_ID; i++) {
-		if (htlbpagek[i].key == key)
-			return (htlbpagek[i].in);
-	}
-	return NULL;
-}
-
 static struct page *
 alloc_hugetlb_page (void)
 {
@@ -299,193 +281,6 @@ unlink_vma (struct vm_area_struct *mpnt)
 }
 
 int
-free_hugepages (struct vm_area_struct *mpnt)
-{
-	unlink_vma(mpnt);
-	zap_hugetlb_resources(mpnt);
-	kmem_cache_free(vm_area_cachep, mpnt);
-	return 1;
-}
-
-static struct inode *
-set_new_inode (unsigned long len, int prot, int flag, int key)
-{
-	struct inode *inode;
-	int i;
-
-	for (i = 0; i < MAX_ID; i++) {
-		if (htlbpagek[i].key == 0)
-			break;
-	}
-	if (i == MAX_ID)
-		return NULL;
-	inode = kmalloc(sizeof (struct inode), GFP_ATOMIC);
-	if (inode == NULL)
-		return NULL;
-
-	inode_init_once(inode);
-	atomic_inc(&inode->i_writecount);
-	inode->i_mapping = &inode->i_data;
-	inode->i_mapping->host = inode;
-	inode->i_ino = (unsigned long) key;
-
-	htlbpagek[i].key = key;
-	htlbpagek[i].in = inode;
-	inode->i_uid = current->fsuid;
-	inode->i_gid = current->fsgid;
-	inode->i_mode = prot;
-	inode->i_size = len;
-	return inode;
-}
-
-static int
-check_size_prot (struct inode *inode, unsigned long len, int prot, int flag)
-{
-	if (inode->i_uid != current->fsuid)
-		return -1;
-	if (inode->i_gid != current->fsgid)
-		return -1;
-	if (inode->i_size != len)
-		return -1;
-	return 0;
-}
-
-int
-alloc_shared_hugetlb_pages (int key, unsigned long addr, unsigned long len, int prot, int flag)
-{
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	struct inode *inode;
-	struct address_space *mapping;
-	struct page *page;
-	int idx;
-	int retval = -ENOMEM;
-	int newalloc = 0;
-
-try_again:
-	spin_lock(&htlbpage_lock);
-	inode = find_key_inode(key);
-	if (inode == NULL) {
-		if (!capable(CAP_SYS_ADMIN)) {
-			if (!in_group_p(0)) {
-				retval = -EPERM;
-				goto out_err;
-			}
-		}
-		if (!(flag & IPC_CREAT)) {
-			retval = -ENOENT;
-			goto out_err;
-		}
-		inode = set_new_inode(len, prot, flag, key);
-		if (inode == NULL)
-			goto out_err;
-		newalloc = 1;
-	} else {
-		if (check_size_prot(inode, len, prot, flag) < 0) {
-			retval =  -EINVAL;
-			goto out_err;
-		}
-		else if (atomic_read(&inode->i_writecount)) {
-			spin_unlock(&htlbpage_lock);
-			goto try_again;
-		}
-	}
-	spin_unlock(&htlbpage_lock);
-	mapping = inode->i_mapping;
-
-	addr = do_mmap_pgoff(NULL, addr, len, (unsigned long) prot,
-			     MAP_NORESERVE|MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, 0);
-	if (IS_ERR((void *) addr))
-		goto freeinode;
-
-	vma = find_vma(mm, addr);
-	if (!vma) {
-		retval = -EINVAL;
-		goto freeinode;
-	}
-
-	spin_lock(&mm->page_table_lock);
-	do {
-		pte_t *pte = huge_pte_alloc(mm, addr);
-		if ((pte) && (pte_none(*pte))) {
-			idx = (addr - vma->vm_start) >> HPAGE_SHIFT;
-			page = find_get_page(mapping, idx);
-			if (page == NULL) {
-				page = alloc_hugetlb_page();
-				if (page == NULL)
-					goto out;
-				add_to_page_cache(page, mapping, idx);
-			}
-			set_huge_pte(mm, vma, page, pte,
-				     (vma->vm_flags & VM_WRITE));
-		} else
-			goto out;
-		addr += HPAGE_SIZE;
-	} while (addr < vma->vm_end);
-	retval = 0;
-	vma->vm_flags |= (VM_HUGETLB | VM_RESERVED);
-	vma->vm_ops = &hugetlb_vm_ops;
-	spin_unlock(&mm->page_table_lock);
-	spin_lock(&htlbpage_lock);
-	atomic_set(&inode->i_writecount, 0);
-	spin_unlock(&htlbpage_lock);
-	return retval;
-out:
-	if (addr > vma->vm_start) {
-		unsigned long raddr = vma->vm_end;
-		vma->vm_end = addr;
-		zap_hugetlb_resources(vma);
-		vma->vm_end = raddr;
-	}
-	spin_unlock(&mm->page_table_lock);
-	do_munmap(mm, vma->vm_start, len);
-	if (newalloc)
-		goto freeinode;
-	return retval;
-
-out_err:
-	spin_unlock(&htlbpage_lock);
-freeinode:
-	if (newalloc) {
-		for (idx = 0; idx < MAX_ID; idx++)
-			if (htlbpagek[idx].key == inode->i_ino) {
-				htlbpagek[idx].key = 0;
-				htlbpagek[idx].in = NULL;
-				break;
-			}
-		kfree(inode);
-	}
-	return retval;
-}
-
-static int
-alloc_private_hugetlb_pages (int key, unsigned long addr, unsigned long len, int prot, int flag)
-{
-	if (!capable(CAP_SYS_ADMIN)) {
-		if (!in_group_p(0))
-			return -EPERM;
-	}
-	addr = do_mmap_pgoff(NULL, addr, len, prot,
-			     MAP_NORESERVE | MAP_PRIVATE | MAP_FIXED | MAP_ANONYMOUS, 0);
-	if (IS_ERR((void *) addr))
-		return -ENOMEM;
-	if (make_hugetlb_pages_present(addr, (addr + len), flag) < 0) {
-		do_munmap(current->mm, addr, len);
-		return -ENOMEM;
-	}
-	return 0;
-}
-
-int
-alloc_hugetlb_pages (int key, unsigned long addr, unsigned long len, int prot, int flag)
-{
-	if (key > 0)
-		return alloc_shared_hugetlb_pages(key, addr, len, prot, flag);
-	else
-		return alloc_private_hugetlb_pages(key, addr, len, prot, flag);
-}
-
-int
 set_hugetlb_mem_size (int count)
 {
 	int j, lcount;
diff -urpN mm2-2.5.52-1/arch/sparc64/kernel/sys_sparc.c mm2-2.5.52-bcrl/arch/sparc64/kernel/sys_sparc.c
--- mm2-2.5.52-1/arch/sparc64/kernel/sys_sparc.c	2002-12-15 18:08:09.000000000 -0800
+++ mm2-2.5.52-bcrl/arch/sparc64/kernel/sys_sparc.c	2002-12-23 22:48:31.000000000 -0800
@@ -13,7 +13,6 @@
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/mm.h>
-#include <linux/hugetlb.h>
 #include <linux/sem.h>
 #include <linux/msg.h>
 #include <linux/shm.h>
@@ -682,100 +681,3 @@ sys_perfctr(int opcode, unsigned long ar
 	};
 	return err;
 }
-
-#ifdef CONFIG_HUGETLB_PAGE
-#define HPAGE_ALIGN(x)  (((unsigned long)x + (HPAGE_SIZE -1)) & HPAGE_MASK)
-extern long     sys_munmap(unsigned long, size_t);
-
-/* get_addr function gets the currently unused virtual range in
- * the current process's address space.  It returns the LARGE_PAGE_SIZE
- * aligned address (in cases of success).  Other kernel generic
- * routines only could gurantee that allocated address is PAGE_SIZE aligned.
- */
-static long get_addr(unsigned long addr, unsigned long len)
-{
-	struct vm_area_struct   *vma;
-	if (addr) {
-		addr = HPAGE_ALIGN(addr);
-		vma = find_vma(current->mm, addr);
-		if (((TASK_SIZE - len) >= addr) &&
-				(!vma || addr + len <= vma->vm_start))
-			goto found_addr;
-	}
-	addr = HPAGE_ALIGN(TASK_UNMAPPED_BASE);
-	for (vma = find_vma(current->mm, addr); ; vma = vma->vm_next) {
-		if (TASK_SIZE - len < addr)
-			return -ENOMEM;
-		if (!vma || ((addr + len) < vma->vm_start))
-			goto found_addr;
-		addr = vma->vm_end;
-	}
-found_addr:
-	addr = HPAGE_ALIGN(addr);
-	return addr;
-}
-
-extern int alloc_hugetlb_pages(int, unsigned long, unsigned long, int, int);
-
-asmlinkage long
-sys_alloc_hugepages(int key, unsigned long addr, unsigned long len, int prot, int flag)
-{
-	struct mm_struct *mm = current->mm;
-	unsigned long raddr;
-	int retval;
-
-	if (key < 0)
-		return -EINVAL;
-	if (len & (HPAGE_SIZE - 1))
-		return -EINVAL;
-	down_write(&mm->mmap_sem);
-	raddr = get_addr(addr, len);
-	retval = 0;
-	if (raddr == -ENOMEM) {
-		retval = -ENOMEM;
-		goto raddr_out;
-	}
-	retval = alloc_hugetlb_pages(key, raddr, len, prot, flag);
-
-raddr_out:
-	up_write(&mm->mmap_sem);
-	if (retval < 0)
-		return (long) retval;
-
-	return raddr;
-}
-
-extern int free_hugepages(struct vm_area_struct *);
-
-asmlinkage int
-sys_free_hugepages(unsigned long addr)
-{
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	int retval;
-
-	vma = find_vma(current->mm, addr);
-	if ((!vma) || (!is_vm_hugetlb_page(vma)) || (vma->vm_start!=addr))
-		return -EINVAL;
-	down_write(&mm->mmap_sem);
-	spin_lock(&mm->page_table_lock);
-	retval = free_hugepages(vma);
-	spin_unlock(&mm->page_table_lock);
-	up_write(&mm->mmap_sem);
-	return retval;
-}
-
-#else
-
-asmlinkage long
-sys_alloc_hugepages(int key, unsigned long addr, size_t len, int prot, int flag)
-{
-	return -ENOSYS;
-}
-asmlinkage int
-sys_free_hugepages(unsigned long addr)
-{
-	return -ENOSYS;
-}
-
-#endif
diff -urpN mm2-2.5.52-1/arch/sparc64/kernel/systbls.S mm2-2.5.52-bcrl/arch/sparc64/kernel/systbls.S
--- mm2-2.5.52-1/arch/sparc64/kernel/systbls.S	2002-12-15 18:07:54.000000000 -0800
+++ mm2-2.5.52-bcrl/arch/sparc64/kernel/systbls.S	2002-12-23 22:40:24.000000000 -0800
@@ -65,8 +65,8 @@ sys_call_table32:
 	.word sys32_ipc, sys32_sigreturn, sys_clone, sys_nis_syscall, sys32_adjtimex
 /*220*/	.word sys32_sigprocmask, sys_ni_syscall, sys32_delete_module, sys_ni_syscall, sys_getpgid
 	.word sys32_bdflush, sys32_sysfs, sys_nis_syscall, sys32_setfsuid16, sys32_setfsgid16
-/*230*/	.word sys32_select, sys_time, sys_nis_syscall, sys_stime, sys_alloc_hugepages
-	.word sys_free_hugepages, sys_llseek, sys_mlock, sys_munlock, sys_mlockall
+/*230*/	.word sys32_select, sys_time, sys_nis_syscall, sys_stime, sys_ni_syscall
+	.word sys_ni_syscall, sys_llseek, sys_mlock, sys_munlock, sys_mlockall
 /*240*/	.word sys_munlockall, sys_sched_setparam, sys_sched_getparam, sys_sched_setscheduler, sys_sched_getscheduler
 	.word sys_sched_yield, sys_sched_get_priority_max, sys_sched_get_priority_min, sys32_sched_rr_get_interval, compat_sys_nanosleep
 /*250*/	.word sys32_mremap, sys32_sysctl, sys_getsid, sys_fdatasync, sys32_nfsservctl
diff -urpN mm2-2.5.52-1/include/asm-alpha/unistd.h mm2-2.5.52-bcrl/include/asm-alpha/unistd.h
--- mm2-2.5.52-1/include/asm-alpha/unistd.h	2002-12-15 18:07:54.000000000 -0800
+++ mm2-2.5.52-bcrl/include/asm-alpha/unistd.h	2002-12-23 22:40:42.000000000 -0800
@@ -340,8 +340,6 @@
 #define __NR_io_getevents		400
 #define __NR_io_submit			401
 #define __NR_io_cancel			402
-#define __NR_alloc_hugepages		403
-#define __NR_free_hugepages		404
 #define __NR_exit_group			405
 #define __NR_lookup_dcookie		406
 #define __NR_sys_epoll_create		407
diff -urpN mm2-2.5.52-1/include/asm-i386/unistd.h mm2-2.5.52-bcrl/include/asm-i386/unistd.h
--- mm2-2.5.52-1/include/asm-i386/unistd.h	2002-12-15 18:08:12.000000000 -0800
+++ mm2-2.5.52-bcrl/include/asm-i386/unistd.h	2002-12-23 22:40:54.000000000 -0800
@@ -255,8 +255,6 @@
 #define __NR_io_getevents	247
 #define __NR_io_submit		248
 #define __NR_io_cancel		249
-#define __NR_alloc_hugepages	250
-#define __NR_free_hugepages	251
 #define __NR_exit_group		252
 #define __NR_lookup_dcookie	253
 #define __NR_epoll_create	254
diff -urpN mm2-2.5.52-1/include/asm-ia64/unistd.h mm2-2.5.52-bcrl/include/asm-ia64/unistd.h
--- mm2-2.5.52-1/include/asm-ia64/unistd.h	2002-12-15 18:07:45.000000000 -0800
+++ mm2-2.5.52-bcrl/include/asm-ia64/unistd.h	2002-12-23 22:41:10.000000000 -0800
@@ -223,8 +223,6 @@
 #define __NR_sched_setaffinity		1231
 #define __NR_sched_getaffinity		1232
 /* 1233 currently unused */
-#define __NR_alloc_hugepages		1234
-#define __NR_free_hugepages		1235
 #define __NR_exit_group			1236
 #define __NR_lookup_dcookie		1237
 #define __NR_io_setup			1238
diff -urpN mm2-2.5.52-1/include/asm-ppc/unistd.h mm2-2.5.52-bcrl/include/asm-ppc/unistd.h
--- mm2-2.5.52-1/include/asm-ppc/unistd.h	2002-12-15 18:07:48.000000000 -0800
+++ mm2-2.5.52-bcrl/include/asm-ppc/unistd.h	2002-12-23 22:41:22.000000000 -0800
@@ -236,8 +236,6 @@
 #define __NR_io_getevents	229
 #define __NR_io_submit		230
 #define __NR_io_cancel		231
-#define __NR_alloc_hugepages	232
-#define __NR_free_hugepages	233
 #define __NR_exit_group		234
 #define __NR_lookup_dcookie	235
 #define __NR_epoll_create	236
diff -urpN mm2-2.5.52-1/include/asm-ppc64/unistd.h mm2-2.5.52-bcrl/include/asm-ppc64/unistd.h
--- mm2-2.5.52-1/include/asm-ppc64/unistd.h	2002-12-15 18:07:43.000000000 -0800
+++ mm2-2.5.52-bcrl/include/asm-ppc64/unistd.h	2002-12-23 22:41:36.000000000 -0800
@@ -242,8 +242,6 @@
 #define __NR_io_getevents	229
 #define __NR_io_submit		230
 #define __NR_io_cancel		231
-#define __NR_alloc_hugepages	232
-#define __NR_free_hugepages	233
 #define __NR_exit_group		234
 #define __NR_lookup_dcookie	235
 #define __NR_sys_epoll_create	236
diff -urpN mm2-2.5.52-1/include/asm-sparc/unistd.h mm2-2.5.52-bcrl/include/asm-sparc/unistd.h
--- mm2-2.5.52-1/include/asm-sparc/unistd.h	2002-12-15 18:07:44.000000000 -0800
+++ mm2-2.5.52-bcrl/include/asm-sparc/unistd.h	2002-12-23 22:41:54.000000000 -0800
@@ -250,8 +250,6 @@
 #define __NR_time               231 /* Linux Specific                              */
 /* #define __NR_oldstat         232    Linux Specific                              */
 #define __NR_stime              233 /* Linux Specific                              */
-#define __NR_alloc_hugepages    234 /* Linux Specific                              */
-#define __NR_free_hugepages     235 /* Linux Specific                              */
 #define __NR__llseek            236 /* Linux Specific                              */
 #define __NR_mlock              237
 #define __NR_munlock            238
diff -urpN mm2-2.5.52-1/include/asm-x86_64/ia32_unistd.h mm2-2.5.52-bcrl/include/asm-x86_64/ia32_unistd.h
--- mm2-2.5.52-1/include/asm-x86_64/ia32_unistd.h	2002-12-15 18:08:12.000000000 -0800
+++ mm2-2.5.52-bcrl/include/asm-x86_64/ia32_unistd.h	2002-12-23 22:42:24.000000000 -0800
@@ -256,8 +256,6 @@
 #define __NR_ia32_io_getevents	247
 #define __NR_ia32_io_submit		248
 #define __NR_ia32_io_cancel		249
-#define __NR_ia32_alloc_hugepages		250
-#define __NR_ia32_free_hugepages		251
 #define __NR_ia32_exit_group		252
 
 #define IA32_NR_syscalls 260	/* must be > than biggest syscall! */	
