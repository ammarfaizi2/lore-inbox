Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316574AbSHJDVa>; Fri, 9 Aug 2002 23:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316576AbSHJDVa>; Fri, 9 Aug 2002 23:21:30 -0400
Received: from hdfdns02.hd.intel.com ([192.52.58.11]:29647 "EHLO
	mail2.hd.intel.com") by vger.kernel.org with ESMTP
	id <S316574AbSHJDVV>; Fri, 9 Aug 2002 23:21:21 -0400
Message-ID: <25282B06EFB8D31198BF00508B66D4FA03EA570E@fmsmsx114.fm.intel.com>
From: "Seth, Rohit" <rohit.seth@intel.com>
To: "'Andrew Morton'" <akpm@zip.com.au>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: large page patch (fwd) (fwd) ==>hugetlb page patch
Date: Fri, 9 Aug 2002 20:24:52 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached is the updated Large Page (now onwards called hugetlb page) patch.
This is basically the upport from original 2.4.18.  I've tried to
incorporate some of the comments that have been made on the mailing list so
far.  

Though the config option is still named CONFIG_LARGE_PAGE, but there are lot
of other pieces that I've started renaming as "hugetlb"  Eventually
CONFIG_LARGE_PAGE will be changed to CONFIG_HUGETLB_PAGE.  Following are the
fixes/changes from the previous (2.4.18) patch:

1) Only two system calls (Instead of 4 that were there in earlier patch).
These are 
sys_alloc_hugepages(int key, unsigned long addr, unsigned long len, int
prot, int flag)
and
sys_free_hugepages(unsigned long addr)

Key will be equal to zero if  user wants these huge pages as private.  A
positive int value will be used for unrelated apps to share the same
physcial huge pages.

2) munmap skips over the hugetlb regions (that is this function will not
unmap the huge tlb regions)

3) mprotect and mremap will return error if they happen to be touching
hugetlb region

4) /proc/sys/kernel/numhugepages: A positive value written to this will set
the configured hugepage pool to that updated value.  Though I have also left
the provision so that negative values just decrease the current configured
hugetlb pool by that amount.

5) There are couple of upport changes for 2.5.30


diff -Naru linux-2.5.30.org/arch/i386/config.in
linux-2.5.30.lp/arch/i386/config.in
--- linux-2.5.30.org/arch/i386/config.in	Thu Aug  1 14:16:18 2002
+++ linux-2.5.30.lp/arch/i386/config.in	Thu Aug  8 19:08:29 2002
@@ -153,6 +153,8 @@
    define_bool CONFIG_X86_OOSTORE y
 fi
 
+bool 'IA-32 Large Page Support (if available on processor)'
CONFIG_LARGE_PAGE
+
 bool 'Symmetric multi-processing support' CONFIG_SMP
 bool 'Preemptible Kernel' CONFIG_PREEMPT
 if [ "$CONFIG_SMP" != "y" ]; then
diff -Naru linux-2.5.30.org/arch/i386/kernel/entry.S
linux-2.5.30.lp/arch/i386/kernel/entry.S
--- linux-2.5.30.org/arch/i386/kernel/entry.S	Thu Aug  1 14:16:15 2002
+++ linux-2.5.30.lp/arch/i386/kernel/entry.S	Fri Aug  9 15:06:39 2002
@@ -753,6 +753,8 @@
 	.long sys_sched_setaffinity
 	.long sys_sched_getaffinity
 	.long sys_set_thread_area
+	.long sys_alloc_hugepages
+	.long sys_free_hugepages /* 245 */
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
diff -Naru linux-2.5.30.org/arch/i386/kernel/sys_i386.c
linux-2.5.30.lp/arch/i386/kernel/sys_i386.c
--- linux-2.5.30.org/arch/i386/kernel/sys_i386.c	Thu Aug  1 14:16:22
2002
+++ linux-2.5.30.lp/arch/i386/kernel/sys_i386.c	Fri Aug  9 19:55:28 2002
@@ -246,3 +246,83 @@
 
 	return error;
 }
+
+#ifdef CONFIG_LARGE_PAGE
+#define LPAGE_ALIGN(x)  (((unsigned long)x + (LPAGE_SIZE -1)) & LPAGE_MASK)
+extern long     sys_munmap(unsigned long, size_t);
+/* get_addr function gets the currently unused virtaul range in
+ * current process's address space.  It returns the LARGE_PAGE_SIZE
+ * aligned address (in cases of success).  Other kernel generic
+ * routines only could gurantee that allocated address is PAGE_SIZSE
aligned.
+ */
+unsigned long
+get_addr(unsigned long addr, unsigned long len)
+{
+	struct vm_area_struct   *vma;
+	if (addr) {
+		addr = LPAGE_ALIGN(addr);
+		vma = find_vma(current->mm, addr);
+		if (((TASK_SIZE - len) >= addr) &&
+				(!vma || addr + len <= vma->vm_start))
+			goto found_addr;
+	}
+	addr = LPAGE_ALIGN(TASK_UNMAPPED_BASE);
+	for (vma = find_vma(current->mm, addr); ; vma = vma->vm_next) {
+		if (TASK_SIZE - len < addr)
+			return -ENOMEM;
+		if (!vma || ((addr + len) < vma->vm_start))
+			goto found_addr;
+		addr = vma->vm_end;
+	}
+found_addr:
+	addr = LPAGE_ALIGN(addr);
+	return addr;
+}
+
+asmlinkage unsigned long
+sys_alloc_hugepages(int key, unsigned long addr, unsigned long len, int
prot, int flag)
+{
+	unsigned long   raddr;
+	int     retval;
+	extern int alloc_hugetlb_pages(int, unsigned long *, unsigned long,
int, int);
+	if (!(cpu_has_pse))
+		return -EINVAL;
+	if (key < 0)
+		return -EINVAL;
+	if (len & (LPAGE_SIZE - 1))
+		return -EINVAL;
+	raddr = get_addr(addr, len);
+	if (raddr == -ENOMEM)
+		return raddr;
+	retval = alloc_hugetlb_pages(key, &raddr, len, prot, flag);
+	if (retval < 0)
+		return (unsigned long) retval;
+	return raddr;
+}
+
+asmlinkage int
+sys_free_hugepages(unsigned long addr)
+{
+	struct vm_area_struct   *vma;
+	extern int free_hugepages(struct vm_area_struct *);
+
+	vma = find_vma(current->mm, addr);
+	if ((!vma) || (!is_vm_hugetlb_page(vma)) || (vma->vm_start!=addr))
+		return -EINVAL;
+	return free_hugepages(vma);
+}
+
+#else
+
+asmlinkage unsigned long
+sys_alloc_hugepages(int key, unsigned long addr, size_t len, int prot, int
flag)
+{
+	return -ENOSYS;
+}
+asmlinkage int
+sys_free_hugepages(unsigned long addr)
+{
+	return -ENOSYS;
+}
+
+#endif
diff -Naru linux-2.5.30.org/arch/i386/mm/Makefile
linux-2.5.30.lp/arch/i386/mm/Makefile
--- linux-2.5.30.org/arch/i386/mm/Makefile	Thu Aug  1 14:16:15 2002
+++ linux-2.5.30.lp/arch/i386/mm/Makefile	Thu Aug  8 18:37:27 2002
@@ -11,5 +11,6 @@
 
 obj-y	 := init.o pgtable.o fault.o ioremap.o extable.o pageattr.o 
 export-objs := pageattr.o
+obj-$(CONFIG_LARGE_PAGE) += lpage.o
 
 include $(TOPDIR)/Rules.make
diff -Naru linux-2.5.30.org/arch/i386/mm/init.c
linux-2.5.30.lp/arch/i386/mm/init.c
--- linux-2.5.30.org/arch/i386/mm/init.c	Thu Aug  1 14:16:13 2002
+++ linux-2.5.30.lp/arch/i386/mm/init.c	Fri Aug  9 14:59:11 2002
@@ -406,6 +406,13 @@
 	}
 }
 	
+#ifdef CONFIG_LARGE_PAGE
+long    lpagemem = 0;
+int     lp_max;
+long    lpzone_pages;
+extern struct   list_head lpage_freelist;
+#endif
+
 void __init mem_init(void)
 {
 	extern int ppro_with_ram_bug(void);
@@ -472,6 +479,30 @@
 #ifndef CONFIG_SMP
 	zap_low_mappings();
 #endif
+#ifdef CONFIG_LARGE_PAGE
+	{
+		long	i, j;
+		struct	page	*page, *map;
+		/*For now reserve quarter for large_pages.*/
+		lpzone_pages = (max_low_pfn >> ((LPAGE_SHIFT - PAGE_SHIFT) +
2)) ;
+		/*Will make this kernel command line. */
+		INIT_LIST_HEAD(&lpage_freelist);
+		for (i=0; i<lpzone_pages; i++) {
+			page = alloc_pages(GFP_ATOMIC, HUGETLB_PAGE_ORDER);
+			if (page == NULL)
+				break;
+			map = page;
+			for (j=0; j<(LPAGE_SIZE/PAGE_SIZE); j++) {
+				SetPageReserved(map);
+				map++;
+			}
+			list_add(&page->list, &lpage_freelist);
+		}
+		printk("Total Large_page memory pages allocated %ld\n", i);
+		lpzone_pages = lpagemem = i;
+		lp_max = i;
+	}
+#endif
 }
 
 #if CONFIG_X86_PAE
diff -Naru linux-2.5.30.org/arch/i386/mm/lpage.c
linux-2.5.30.lp/arch/i386/mm/lpage.c
--- linux-2.5.30.org/arch/i386/mm/lpage.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.30.lp/arch/i386/mm/lpage.c	Fri Aug  9 19:54:48 2002
@@ -0,0 +1,516 @@
+/*
+ * IA-32 Large Page Support for Kernel.
+ *
+ * Copyright (C) 2002, Rohit Seth <rohit.seth@intel.com>
+ */
+
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/devfs_fs_kernel.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/file.h>
+#include <linux/swap.h>
+#include <linux/pagemap.h>
+#include <linux/string.h>
+#include <linux/smp_lock.h>
+#include <linux/slab.h>
+
+#include <asm/uaccess.h>
+#include <asm/mman.h>
+
+static struct vm_operations_struct	hugetlb_vm_ops;
+struct list_head 			lpage_freelist;
+spinlock_t				lpage_lock = SPIN_LOCK_UNLOCKED;
+extern	long 				lpagemem;
+
+void zap_hugetlb_resources(struct vm_area_struct *);
+
+#define MAX_ID 	32
+struct lpkey {
+	struct inode *in;
+	int			key;
+} lpk[MAX_ID];
+
+static struct inode *
+find_key_inode(int key)
+{
+	int				i;
+
+	for (i=0; i<MAX_ID; i++) {
+		if (lpk[i].key == key) 
+			return (lpk[i].in);
+	}
+	return NULL;
+}
+static struct page *
+alloc_hugetlb_page(void)
+{
+	struct list_head	*curr, *head;
+	struct page			*page;
+
+	spin_lock(&lpage_lock);
+
+	head = &lpage_freelist;
+	curr = head->next;
+
+	if (curr == head)  {
+		spin_unlock(&lpage_lock);
+		return NULL;
+	}
+	page = list_entry(curr, struct page, list);
+	list_del(curr);
+	lpagemem--;
+	spin_unlock(&lpage_lock);
+	set_page_count(page, 1);
+	memset(page_address(page), 0, LPAGE_SIZE);
+	return page;
+}
+
+static void
+free_hugetlb_page(struct page *page)
+{
+	if ((page->mapping != NULL) && (page_count(page) == 2)) {
+		struct inode *inode = page->mapping->host;
+		int 	i;
+
+		lru_cache_del(page);
+		remove_inode_page(page);
+		set_page_count(page, 1);
+		if ((inode->i_size -= LPAGE_SIZE) == 0) {
+			for (i=0;i<MAX_ID;i++)
+				if (lpk[i].key == inode->i_ino) {
+					lpk[i].key = 0;
+					break;
+			}
+			kfree(inode);
+		}
+	}
+	if (put_page_testzero(page)) {
+		spin_lock(&lpage_lock);
+		list_add(&page->list, &lpage_freelist);
+		lpagemem++;
+		spin_unlock(&lpage_lock);
+	}
+}
+
+static pte_t *
+huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
+{
+	pgd_t			*pgd;
+	pmd_t			*pmd = NULL;
+
+	pgd = pgd_offset(mm, addr);
+	pmd = pmd_alloc(mm, pgd, addr);
+	return (pte_t *)pmd;
+}
+
+static pte_t *
+huge_pte_offset(struct mm_struct *mm, unsigned long addr)
+{
+	pgd_t			*pgd;
+	pmd_t			*pmd = NULL;
+	
+	pgd =pgd_offset(mm, addr);
+	pmd = pmd_offset(pgd, addr);
+	return (pte_t *)pmd;
+}
+
+#define mk_pte_huge(entry) {entry.pte_low |= (_PAGE_PRESENT | _PAGE_PSE);}
+	
+static void
+set_huge_pte(struct mm_struct *mm, struct vm_area_struct *vma, struct page
*page, pte_t *page_table, int write_access)
+{
+	pte_t           entry;
+
+	mm->rss += (LPAGE_SIZE/PAGE_SIZE);
+	if (write_access) {
+		entry = pte_mkwrite(pte_mkdirty(mk_pte(page,
vma->vm_page_prot)));
+	} else
+		entry = pte_wrprotect(mk_pte(page, vma->vm_page_prot));
+	entry = pte_mkyoung(entry);
+	mk_pte_huge(entry);
+	set_pte(page_table, entry);
+	return;
+}
+
+static int
+anon_get_lpage(struct mm_struct *mm, struct vm_area_struct *vma, int
write_access, pte_t *page_table)
+{
+	struct	page *page;
+
+	page = alloc_hugetlb_page();
+	if (page == NULL) 
+		return -1;
+	set_huge_pte(mm, vma, page, page_table, write_access);
+	return 1;
+}
+
+int
+make_hugetlb_pages_present(unsigned long addr, unsigned long end, int
flags)
+{
+	int write;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct * vma;
+	pte_t	*pte;
+
+	vma = find_vma(mm, addr);
+	if (!vma)
+		goto out_error1;
+
+	write = (vma->vm_flags & VM_WRITE) != 0;
+	if ((vma->vm_end - vma->vm_start) & (LPAGE_SIZE-1))
+		goto out_error1;
+	spin_lock(&mm->page_table_lock);
+	do {    
+		pte = huge_pte_alloc(mm, addr);
+		if ((pte) && (pte_none(*pte))) {
+			if (anon_get_lpage(mm, vma, 
+				write ? VM_WRITE : VM_READ, pte) == -1)
+				goto out_error;
+		} else
+			goto out_error;
+		addr += LPAGE_SIZE;
+	} while (addr < end); 
+	spin_unlock(&mm->page_table_lock);
+	vma->vm_flags |= (VM_HUGETLB | VM_RESERVED);
+	if (flags & MAP_PRIVATE )
+		vma->vm_flags |= VM_DONTCOPY;
+	vma->vm_ops = &hugetlb_vm_ops;
+	return 0;
+out_error: /*Error case, remove the partial lp_resources. */
+	if (addr > vma->vm_start) { 
+	   	vma->vm_end = addr ;
+	   	zap_hugetlb_resources(vma);
+	   	vma->vm_end = end;
+	}
+	spin_unlock(&mm->page_table_lock);
+out_error1:
+	return -1;
+}
+
+int
+copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
struct vm_area_struct *vma)
+{
+	pte_t *src_pte, *dst_pte, entry;
+	struct page 	*ptepage;
+	unsigned long addr = vma->vm_start;
+	unsigned long end = vma->vm_end;
+
+		while (addr < end) {
+			dst_pte = huge_pte_alloc(dst, addr);
+			if (!dst_pte)
+				goto nomem;
+			src_pte = huge_pte_offset(src, addr);
+			entry = *src_pte;
+			ptepage = pte_page(entry);
+			get_page(ptepage);
+			set_pte(dst_pte, entry);
+			dst->rss += (LPAGE_SIZE/PAGE_SIZE);
+			addr += LPAGE_SIZE; 
+		}
+    return 0;
+
+nomem:
+    return -ENOMEM;
+}
+int
+follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
struct page **pages, struct vm_area_struct **vmas, unsigned long *st, int
*length, int i)
+{
+	pte_t			*ptep, pte;
+	unsigned long	start = *st;
+	unsigned long	pstart;
+	int				len = *length;
+	struct page		*page;
+
+	do {
+		pstart = start;
+		ptep = huge_pte_offset(mm, start);
+		pte = *ptep;
+
+back1:
+		page = pte_page(pte);
+		if (pages) {
+			page += ((start & ~LPAGE_MASK) >> PAGE_SHIFT);
+			pages[i] = page;
+			page_cache_get(page);
+		}
+		if (vmas)
+			vmas[i] = vma;
+		i++;
+		len--;
+		start += PAGE_SIZE;
+		if (((start & LPAGE_MASK) == pstart) && len && (start <
vma->vm_end))
+			goto back1;
+	} while (len && start < vma->vm_end);
+	*length = len;
+	*st = start;
+	return i;
+}
+
+void
+zap_hugetlb_resources(struct vm_area_struct *mpnt)
+{
+	struct mm_struct *mm = mpnt->vm_mm;
+	unsigned long 	len, addr, end;
+	pte_t			*ptep;
+	struct page		*page;
+
+	addr = mpnt->vm_start;
+	end = mpnt->vm_end;
+	len = end - addr;
+	do {
+		ptep = huge_pte_offset(mm, addr);
+		page = pte_page(*ptep);
+		pte_clear(ptep);
+		free_hugetlb_page(page);
+		addr += LPAGE_SIZE;
+	} while (addr < end);
+	mm->rss -= (len >> PAGE_SHIFT);
+	mpnt->vm_ops = NULL;
+}
+
+static void
+unlink_vma(struct vm_area_struct *mpnt)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct	*vma;
+
+	vma = mm->mmap;
+	if (vma == mpnt) {
+		mm->mmap = vma->vm_next;
+	}
+	else {
+		while (vma->vm_next != mpnt) {
+			vma = vma->vm_next;
+		}
+		vma->vm_next = mpnt->vm_next;
+	}
+	rb_erase(&mpnt->vm_rb, &mm->mm_rb);
+	mm->mmap_cache = NULL;
+	mm->map_count--;
+}
+
+int
+free_hugepages(struct vm_area_struct *mpnt)
+{
+	struct mm_struct *mm = current->mm;
+
+	unlink_vma(mpnt);
+	spin_lock(&mm->page_table_lock);
+	zap_hugetlb_resources(mpnt);
+	spin_unlock(&mm->page_table_lock);
+	kmem_cache_free(vm_area_cachep, mpnt);
+	return 1;
+}
+
+static struct inode *
+set_new_inode(unsigned long len, int prot, int flag, int key)
+{
+	struct inode	*inode;
+	int	i;
+
+	for (i=0; i<MAX_ID; i++) {
+		if (lpk[i].key == 0)
+			break;
+	}
+	if (i == MAX_ID)
+		return NULL;
+	inode = kmalloc(sizeof(struct inode), GFP_ATOMIC);
+	if (inode == NULL)
+		return NULL;
+	
+	memset(inode, 0, sizeof(struct inode));
+	INIT_LIST_HEAD(&inode->i_hash);
+	inode->i_mapping = &inode->i_data;
+	inode->i_mapping->host = inode;
+	INIT_LIST_HEAD(&inode->i_data.clean_pages);
+	INIT_LIST_HEAD(&inode->i_data.dirty_pages);
+	INIT_LIST_HEAD(&inode->i_data.locked_pages);
+	INIT_LIST_HEAD(&inode->i_data.io_pages);
+	INIT_LIST_HEAD(&inode->i_dentry);
+	INIT_LIST_HEAD(&inode->i_devices);
+	sema_init(&inode->i_sem, 1);
+	INIT_RADIX_TREE(&inode->i_data.page_tree, GFP_ATOMIC);
+	rwlock_init(&inode->i_data.page_lock);
+	INIT_LIST_HEAD(&inode->i_data.private_list);
+	spin_lock_init(&inode->i_data.private_lock);
+	INIT_LIST_HEAD(&inode->i_data.i_mmap);
+	INIT_LIST_HEAD(&inode->i_data.i_mmap_shared);
+	spin_lock_init(&inode->i_data.i_shared_lock);
+	inode->i_ino = (unsigned long)key;
+
+	lpk[i].key = key;
+	lpk[i].in = inode;
+	inode->i_uid = current->fsuid;
+	inode->i_gid = current->fsgid;
+	inode->i_mode = prot;
+	inode->i_size = len;
+	return inode;
+}
+
+static int
+check_size_prot(struct inode *inode, unsigned long len, int prot, int flag)
+{
+	if (inode->i_uid != current->fsuid)
+		return -1;
+	if (inode->i_gid != current->fsgid)
+		return -1;
+	if (inode->i_size != len)
+		return -1;
+	return 0;
+}
+
+static int
+alloc_shared_hugetlb_pages(int key, unsigned long *raddr, unsigned long
len, int prot, int flag)
+{
+	struct	mm_struct		*mm = current->mm;
+	struct	vm_area_struct	*vma;
+	struct	inode			*inode;
+	struct	address_space	*mapping;
+	struct	page			*page;
+	unsigned long 			addr = *raddr;
+	int		idx;
+	int 	retval = -ENOMEM;
+
+	if (len & (LPAGE_SIZE -1))
+		return -EINVAL;
+
+	inode = find_key_inode(key);
+	if (inode == NULL) {
+		if (!(flag & IPC_CREAT))
+			return -ENOENT;
+		inode = set_new_inode(len, prot, flag, key);
+		if (inode == NULL) 
+			return -ENOMEM;
+	}
+	else
+		if (check_size_prot(inode, len, prot, flag) < 0)
+			return -EINVAL;
+	mapping = inode->i_mapping;
+
+	addr = do_mmap_pgoff(NULL, addr, len, (unsigned long)prot, 
+			MAP_FIXED|MAP_PRIVATE | MAP_ANONYMOUS, 0);
+	if (IS_ERR((void *)addr)) 
+		return -ENOMEM; 
+
+	vma = find_vma(mm, addr);
+	if (!vma)
+		return -EINVAL;
+	
+	*raddr = addr;
+	spin_lock(&mm->page_table_lock);
+	do {
+		pte_t * pte = huge_pte_alloc(mm, addr);
+		if ((pte) && (pte_none(*pte))) {
+			idx = (addr - vma->vm_start) >> LPAGE_SHIFT;
+			page = find_get_page(mapping, idx);
+			if (page == NULL) {
+				page = alloc_hugetlb_page();	
+				if (page == NULL) 
+					goto out;	
+				add_to_page_cache(page, mapping, idx);
+			}
+			set_huge_pte(mm, vma, page, pte, (vma->vm_flags &
VM_WRITE));
+		} else 
+			goto out;
+		addr += LPAGE_SIZE;
+	} while (addr < vma->vm_end); 
+	retval = 0;
+	vma->vm_flags |= (VM_HUGETLB | VM_RESERVED);
+	vma->vm_ops = &hugetlb_vm_ops;
+	spin_unlock(&mm->page_table_lock);
+	return retval;
+out:
+	if (addr > vma->vm_start) {
+		raddr = vma->vm_end;
+		vma->vm_end = addr;
+		zap_hugetlb_resources(vma);
+		vma->vm_end = raddr;
+	}
+	spin_unlock(&mm->page_table_lock);
+	return retval;
+}
+
+static int
+alloc_private_hugetlb_pages(int key, unsigned long *raddr, unsigned long
len, int prot, int flag)
+{
+	unsigned long addr = *raddr;
+
+	addr = do_mmap_pgoff(NULL, addr, len, prot,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, 0);
+	if (IS_ERR((void *)addr)) 
+		return -ENOMEM; 
+	if (addr & (LPAGE_SIZE -1)) { /*Should not happen. */
+		sys_munmap(addr, len);
+		return -ENOMEM;
+	}
+	if (make_hugetlb_pages_present(addr, (addr+len), flag) < 0) {
+		sys_munmap(addr, len);
+		return -ENOMEM;
+	}
+	*raddr = addr;
+	return 0;
+}
+
+int
+alloc_hugetlb_pages(int key, unsigned long *raddr, unsigned long len, int
prot, int flag)
+{
+	if (key > 0) 
+		return alloc_shared_hugetlb_pages(key, raddr, len, prot,
flag);
+	else
+		return alloc_private_hugetlb_pages(key, raddr, len, prot,
flag);
+}
+
+int
+set_hugetlb_page_size(int count)
+{
+	int j, lcount;
+	struct page     *page, *map;
+	extern long        lpzone_pages;
+	extern struct list_head lpage_freelist;
+
+	if (count < 0)
+		lcount = count;
+	else 
+		lcount = count - lpzone_pages;
+
+	if (lcount > 0) {/*Increase the mem size. */
+		while (lcount--) {
+			page = alloc_pages(GFP_ATOMIC, HUGETLB_PAGE_ORDER);
+			if (page == NULL)
+				break;
+			map = page;
+			for (j=0; j<(LPAGE_SIZE/PAGE_SIZE); j++) {
+				SetPageReserved(map);
+				map++;
+			}
+			spin_lock(&lpage_lock);
+			list_add(&page->list, &lpage_freelist);
+			lpagemem++;
+			lpzone_pages++;
+			spin_unlock(&lpage_lock);
+		}
+		return (int)lpzone_pages;
+	}
+	/*Shrink the memory size. */
+	while (lcount++) {
+		page = alloc_hugetlb_page();
+		if (page == NULL)
+			break;
+		spin_lock(&lpage_lock);
+		lpzone_pages--;
+		spin_unlock(&lpage_lock);
+		map = page;
+		for (j=0; j<(LPAGE_SIZE/PAGE_SIZE); j++) {
+			ClearPageReserved(map);
+			map++;
+		}
+		__free_pages(page, HUGETLB_PAGE_ORDER);
+	}
+	return (int)lpzone_pages;
+}
+static struct vm_operations_struct	hugetlb_vm_ops = {
+	close: zap_hugetlb_resources,
+};
diff -Naru linux-2.5.30.org/fs/proc/array.c linux-2.5.30.lp/fs/proc/array.c
--- linux-2.5.30.org/fs/proc/array.c	Thu Aug  1 14:16:28 2002
+++ linux-2.5.30.lp/fs/proc/array.c	Fri Aug  9 16:01:55 2002
@@ -487,7 +487,18 @@
 		while (vma) {
 			pgd_t *pgd = pgd_offset(mm, vma->vm_start);
 			int pages = 0, shared = 0, dirty = 0, total = 0;
+			if (is_vm_hugetlb_page(vma)) {
+				int num_pages = ((vma->vm_end -
vma->vm_start)/PAGE_SIZE);
 
+				resident += num_pages;
+				if (!(vma->vm_flags & VM_DONTCOPY))
+					share += num_pages;
+				if (vma->vm_flags & VM_WRITE)
+					dt += num_pages;
+				drs += num_pages;
+				vma = vma->vm_next;
+				continue;
+			}
 			statm_pgd_range(pgd, vma->vm_start, vma->vm_end,
&pages, &shared, &dirty, &total);
 			resident += pages;
 			share += shared;
diff -Naru linux-2.5.30.org/fs/proc/proc_misc.c
linux-2.5.30.lp/fs/proc/proc_misc.c
--- linux-2.5.30.org/fs/proc/proc_misc.c	Thu Aug  1 14:16:08 2002
+++ linux-2.5.30.lp/fs/proc/proc_misc.c	Thu Aug  8 18:32:22 2002
@@ -186,6 +186,15 @@
 		ps.nr_reverse_maps
 		);
 
+#ifdef CONFIG_LARGE_PAGE
+	{
+		extern  unsigned long lpagemem, lpzone_pages;
+		len += sprintf(page+len,"Total # of LargePages:
%8lu\t\tAvailable: %8lu\n"
+				"LargePageSize: %8lu(0x%xKB)\n",
+				lpzone_pages, lpagemem, LPAGE_SIZE,
(LPAGE_SIZE/1024));
+	}
+
+#endif
 	return proc_calc_metrics(page, start, off, count, eof, len);
 #undef K
 }
diff -Naru linux-2.5.30.org/include/asm-i386/page.h
linux-2.5.30.lp/include/asm-i386/page.h
--- linux-2.5.30.org/include/asm-i386/page.h	Thu Aug  1 14:16:10 2002
+++ linux-2.5.30.lp/include/asm-i386/page.h	Fri Aug  9 14:48:38 2002
@@ -44,14 +44,22 @@
 typedef struct { unsigned long long pmd; } pmd_t;
 typedef struct { unsigned long long pgd; } pgd_t;
 #define pte_val(x)	((x).pte_low | ((unsigned long long)(x).pte_high <<
32))
+#define LPAGE_SHIFT	21
 #else
 typedef struct { unsigned long pte_low; } pte_t;
 typedef struct { unsigned long pmd; } pmd_t;
 typedef struct { unsigned long pgd; } pgd_t;
 #define pte_val(x)	((x).pte_low)
+#define LPAGE_SHIFT	22
 #endif
 #define PTE_MASK	PAGE_MASK
 
+#ifdef CONFIG_LARGE_PAGE
+#define LPAGE_SIZE	((1UL) << LPAGE_SHIFT)
+#define LPAGE_MASK	(~(LPAGE_SIZE - 1))
+#define HUGETLB_PAGE_ORDER	(LPAGE_SHIFT - PAGE_SHIFT)
+#endif
+
 typedef struct { unsigned long pgprot; } pgprot_t;
 
 #define pmd_val(x)	((x).pmd)
diff -Naru linux-2.5.30.org/include/linux/mm.h
linux-2.5.30.lp/include/linux/mm.h
--- linux-2.5.30.org/include/linux/mm.h	Thu Aug  1 14:16:04 2002
+++ linux-2.5.30.lp/include/linux/mm.h	Fri Aug  9 13:54:32 2002
@@ -104,6 +104,7 @@
 #define VM_DONTEXPAND	0x00040000	/* Cannot expand with mremap() */
 #define VM_RESERVED	0x00080000	/* Don't unmap it from swap_out */
 #define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
+#define VM_HUGETLB	0x00200000	/* Large_Page VM */
 
 #define VM_STACK_FLAGS	(0x00000100 | VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT)
 
@@ -360,6 +361,17 @@
 int __set_page_dirty_buffers(struct page *page);
 int __set_page_dirty_nobuffers(struct page *page);
 
+#ifdef CONFIG_LARGE_PAGE
+#define is_vm_hugetlb_page(vma) (vma->vm_flags & VM_HUGETLB)
+extern int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *,
struct vm_area_struct *);
+extern int follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
struct page **, struct vm_area_struct **, unsigned long *, int *, int);
+#else
+#define is_vm_hugetlb_page(vma) (0)
+#define follow_hugetlb_page(mm, vma, pages, vmas, start, len, i) (0)
+#define copy_hugetlb_page_range(dst, src, vma) (0)
+#endif
+
+
 /*
  * If the mapping doesn't provide a set_page_dirty a_op, then
  * just fall through and assume that it wants buffer_heads.
diff -Naru linux-2.5.30.org/include/linux/mmzone.h
linux-2.5.30.lp/include/linux/mmzone.h
--- linux-2.5.30.org/include/linux/mmzone.h	Thu Aug  1 14:16:02 2002
+++ linux-2.5.30.lp/include/linux/mmzone.h	Thu Aug  8 18:13:21 2002
@@ -14,7 +14,7 @@
  */
 
 #ifndef CONFIG_FORCE_MAX_ZONEORDER
-#define MAX_ORDER 10
+#define MAX_ORDER 15
 #else
 #define MAX_ORDER CONFIG_FORCE_MAX_ZONEORDER
 #endif
diff -Naru linux-2.5.30.org/include/linux/sysctl.h
linux-2.5.30.lp/include/linux/sysctl.h
--- linux-2.5.30.org/include/linux/sysctl.h	Thu Aug  1 14:16:02 2002
+++ linux-2.5.30.lp/include/linux/sysctl.h	Fri Aug  9 14:24:59 2002
@@ -127,6 +127,7 @@
 	KERN_CORE_USES_PID=52,		/* int: use core or core.%pid */
 	KERN_TAINTED=53,	/* int: various kernel tainted flags */
 	KERN_CADPID=54,		/* int: PID of the process to notify on CAD
*/
+	KERN_HUGETLB_PAGE_NUM=55, /* int: Number of Huge Pages currently
configured. */
 };
 
 
diff -Naru linux-2.5.30.org/kernel/sysctl.c linux-2.5.30.lp/kernel/sysctl.c
--- linux-2.5.30.org/kernel/sysctl.c	Thu Aug  1 14:16:07 2002
+++ linux-2.5.30.lp/kernel/sysctl.c	Fri Aug  9 17:33:17 2002
@@ -97,6 +97,11 @@
 extern int acct_parm[];
 #endif
 
+#ifdef CONFIG_LARGE_PAGE
+extern	int	lp_max;
+extern	int	set_hugetlb_page_size(int);
+#endif
+
 static int parse_table(int *, int, void *, size_t *, void *, size_t,
 		       ctl_table *, void **);
 static int proc_doutsstring(ctl_table *table, int write, struct file *filp,
@@ -255,6 +260,10 @@
 	{KERN_S390_USER_DEBUG_LOGGING,"userprocess_debug",
 	 &sysctl_userprocess_debug,sizeof(int),0644,NULL,&proc_dointvec},
 #endif
+#ifdef CONFIG_LARGE_PAGE
+	 {KERN_HUGETLB_PAGE_NUM, "numhugepages", &lp_max, sizeof(int), 0644,
NULL, 
+	  &proc_dointvec},
+#endif
 	{0}
 };
 
@@ -894,6 +903,10 @@
 				val = -val;
 			buffer += len;
 			left -= len;
+#ifdef CONFIG_LARGE_PAGE
+			if (i == &lp_max)
+				val = set_hugetlb_page_size(val);
+#endif
 			switch(op) {
 			case OP_SET:	*i = val; break;
 			case OP_AND:	*i &= val; break;
diff -Naru linux-2.5.30.org/mm/memory.c linux-2.5.30.lp/mm/memory.c
--- linux-2.5.30.org/mm/memory.c	Thu Aug  1 14:16:23 2002
+++ linux-2.5.30.lp/mm/memory.c	Fri Aug  9 13:57:33 2002
@@ -208,6 +208,9 @@
 	unsigned long end = vma->vm_end;
 	unsigned long cow = (vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) ==
VM_MAYWRITE;
 
+	if (is_vm_hugetlb_page(vma))
+		return copy_hugetlb_page_range(dst, src, vma);
+
 	src_pgd = pgd_offset(src, address)-1;
 	dst_pgd = pgd_offset(dst, address)-1;
 
@@ -506,6 +509,10 @@
 		if ( !vma || !(flags & vma->vm_flags) )
 			return i ? : -EFAULT;
 
+		if (is_vm_hugetlb_page(vma)) {
+			i += follow_hugetlb_page(mm, vma, pages, vmas,
&start, &len, i);
+			continue;
+		}
 		spin_lock(&mm->page_table_lock);
 		do {
 			struct page *map;
diff -Naru linux-2.5.30.org/mm/mmap.c linux-2.5.30.lp/mm/mmap.c
--- linux-2.5.30.org/mm/mmap.c	Thu Aug  1 14:16:05 2002
+++ linux-2.5.30.lp/mm/mmap.c	Fri Aug  9 19:49:34 2002
@@ -987,10 +987,12 @@
 	touched = NULL;
 	do {
 		struct vm_area_struct *next = mpnt->vm_next;
-		mpnt->vm_next = touched;
-		touched = mpnt;
-		mm->map_count--;
-		rb_erase(&mpnt->vm_rb, &mm->mm_rb);
+		if (!(is_vm_hugetlb_page(mpnt))) {
+			mpnt->vm_next = touched;
+			touched = mpnt;
+			mm->map_count--;
+			rb_erase(&mpnt->vm_rb, &mm->mm_rb);
+		}
 		mpnt = next;
 	} while (mpnt && mpnt->vm_start < end);
 	*npp = mpnt;
@@ -1229,7 +1231,10 @@
 			vm_unacct_memory((end - start) >> PAGE_SHIFT);
 
 		mm->map_count--;
-		unmap_page_range(tlb, mpnt, start, end);
+		if (!(is_vm_hugetlb_page(mpnt)))
+			unmap_page_range(tlb, mpnt, start, end);
+		else
+			mpnt->vm_ops->close(mpnt);
 		mpnt = mpnt->vm_next;
 	}
 
diff -Naru linux-2.5.30.org/mm/mprotect.c linux-2.5.30.lp/mm/mprotect.c
--- linux-2.5.30.org/mm/mprotect.c	Thu Aug  1 14:16:21 2002
+++ linux-2.5.30.lp/mm/mprotect.c	Fri Aug  9 13:49:29 2002
@@ -321,6 +321,11 @@
 
 		/* Here we know that  vma->vm_start <= nstart < vma->vm_end.
*/
 
+		if (is_vm_hugetlb_page(vma)) {
+			error = -EACCES;
+			goto out;
+		}
+
 		newflags = prot | (vma->vm_flags & ~(PROT_READ | PROT_WRITE
| PROT_EXEC));
 		if ((newflags & ~(newflags >> 4)) & 0xf) {
 			error = -EACCES;
diff -Naru linux-2.5.30.org/mm/mremap.c linux-2.5.30.lp/mm/mremap.c
--- linux-2.5.30.org/mm/mremap.c	Thu Aug  1 14:16:27 2002
+++ linux-2.5.30.lp/mm/mremap.c	Fri Aug  9 13:49:12 2002
@@ -311,6 +311,10 @@
 	vma = find_vma(current->mm, addr);
 	if (!vma || vma->vm_start > addr)
 		goto out;
+	if (is_vm_hugetlb_page(vma)) {
+		ret = -EINVAL;
+		goto out;
+	}
 	/* We can't remap across vm area boundaries */
 	if (old_len > vma->vm_end - addr)
 		goto out;
