Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317366AbSHBAgm>; Thu, 1 Aug 2002 20:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317371AbSHBAgm>; Thu, 1 Aug 2002 20:36:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41738 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317366AbSHBAgd>;
	Thu, 1 Aug 2002 20:36:33 -0400
Message-ID: <3D49D45A.D68CCFB4@zip.com.au>
Date: Thu, 01 Aug 2002 17:37:46 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
CC: "Seth, Rohit" <rohit.seth@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
Subject: large page patch
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a large-page support patch from Rohit Seth, forwarded
with his permission (thanks!).



> Attached is the large_page support for IA-32.  For most part there are no
> changes over IA-64 patch.  System calls and their semantics remain the
> same. Though there are still some little parts of code that are arch
> specfic (like for IA-64 there is seperate region for large_pages whereas
> on IA-32 it is the same linear address space etc.) I will appreciate if
> you all could provide your input and any issues that you think we need to
> resolve.
> 
> Attached is the large_page patch including the following support: 1-
> Private and Shared Anonymous large pages(This is the earlier patch +
> Anonymous share Large_page support).  Private Anonymous large_pages stay
> with the particular process and vm segments corresponding to these get
> VM_DONTCOPY attribute.  Shared Anonymous pages get shared by children.
> (Children share the same physical large_pages with parent.)  Allocation
> and deallocation of this is done using the following two system calls:
> 
>    sys_get_large_pages (unsigned long addr, unsigned long len, int prot, int flags)
>         where prot could be PROT_READ, PROT_WRITE, PROT_EXEC and flags
>         is MAP_PRIVATE or MAP_SHARE
>    sys_free_large_pages(unsigned long addr)
> 
> 2- Shared Large Pages across different processes.  Allocation and
> deallocation of large_pages that a process can share and unshare across
> different procecess is using follwoign two systm calls:
> 
>    sys_share_large_pages(int key, unsigned long addr, unsigned long len, int prot, int flag)
> 
> where key is the system wide unique identifier that processes use to share
> pages.  This should be non-zero positive number. prot is identical as in
> above cases.  flag could be set to IPC_CREAT so that if the segment
> corresponding to key is not already there then it is created (Else -ENOENT
> is returned if there is no existing segment).
> 
>    sys_unshare_large_pages(unsigned long addr)
> 
> is used to unshare the large_pages from process's address space.  The
> large_pages are put on lpage_freelist only when the last user has sent the
> request for unsharing it (kind of SHM_DEST attribute).
> 
> Most of the support needed for above two cases (Anonymous and Sharing
> across processes) is quite similar in kernel except for binding of
> large_pages to key and temporary inode structure.
> 
> 3) Currently the large_page memory is dynamically configurable through
> /proc/sys/kernel/numlargepages User can specify the number (negative
> meaning shrink) that the number of large_page pages need to change.  For
> e.g. a value of -2 will reduce the number of large_page pages currently
> configured in system by 2.  Note that this change will depend on the
> availability of free large_pages. If none is available then the value
> remains same.  (Any cleaner suggestions?)

Some observations which have been made thus far:

- Minimal impact on the VM and MM layers

- Delegates most of it to the arch layer

- Generic code is not tied to pagetables so (for example) PPC could
  implement the system calls with BAT registers

- The change to MAX_ORDER is unneeded

- swapping of large pages and making them pagecache-coherent is
  unpopular.

- may be better to implement the shm API with fd's, not keys.

- an ia64 implementation is available


diff -Naru linux.org/arch/i386/config.in linux.lp/arch/i386/config.in
--- linux.org/arch/i386/config.in	Mon Feb 25 11:37:52 2002
+++ linux.lp/arch/i386/config.in	Tue Jul  2 17:49:15 2002
@@ -184,6 +184,8 @@
 
 bool 'Math emulation' CONFIG_MATH_EMULATION
 bool 'MTRR (Memory Type Range Register) support' CONFIG_MTRR
+bool 'IA-32 Large Page Support (if available on processor)' CONFIG_LARGE_PAGE
+
 bool 'Symmetric multi-processing support' CONFIG_SMP
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Local APIC support on uniprocessors' CONFIG_X86_UP_APIC
@@ -205,7 +207,6 @@
 
 mainmenu_option next_comment
 comment 'General setup'
-
 bool 'Networking support' CONFIG_NET
 
 # Visual Workstation support is utterly broken.
diff -Naru linux.org/arch/i386/kernel/entry.S linux.lp/arch/i386/kernel/entry.S
--- linux.org/arch/i386/kernel/entry.S	Mon Feb 25 11:37:53 2002
+++ linux.lp/arch/i386/kernel/entry.S	Tue Jul  2 15:12:23 2002
@@ -634,6 +634,10 @@
 	.long SYMBOL_NAME(sys_ni_syscall)	/* 235 reserved for removexattr */
 	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for lremovexattr */
 	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for fremovexattr */
+	.long SYMBOL_NAME(sys_get_large_pages)	/* Get large_page pages */
+	.long SYMBOL_NAME(sys_free_large_pages)	/* Free large_page pages */
+	.long SYMBOL_NAME(sys_share_large_pages)/* Share large_page pages */
+	.long SYMBOL_NAME(sys_unshare_large_pages)/* UnShare large_page pages */
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)
diff -Naru linux.org/arch/i386/kernel/sys_i386.c linux.lp/arch/i386/kernel/sys_i386.c
--- linux.org/arch/i386/kernel/sys_i386.c	Mon Mar 19 12:35:09 2001
+++ linux.lp/arch/i386/kernel/sys_i386.c	Wed Jul  3 14:28:16 2002
@@ -254,3 +254,126 @@
 	return -ERESTARTNOHAND;
 }
 
+#ifdef CONFIG_LARGE_PAGE
+#define LPAGE_ALIGN(x)	(((unsigned long)x + (LPAGE_SIZE -1)) & LPAGE_MASK)
+extern long	sys_munmap(unsigned long, size_t);
+
+/* get_addr function gets the currently unused virtaul range in 
+ * current process's address space.  It returns the LARGE_PAGE_SIZE 
+ * aligned address (in cases of success).  Other kernel generic 
+ * routines only could gurantee that allocated address is PAGE_SIZSE aligned.
+ */
+unsigned long
+get_addr(unsigned long addr, unsigned long len)
+{
+	struct vm_area_struct	*vma;
+	if (addr) {
+		addr = LPAGE_ALIGN(addr);
+		vma = find_vma(current->mm, addr);
+		if (((TASK_SIZE - len) >= addr) &&
+		      (!vma || addr + len <= vma->vm_start))
+			goto found_addr;
+	}
+	addr = LPAGE_ALIGN(TASK_UNMAPPED_BASE);
+	 for (vma = find_vma(current->mm, addr); ; vma = vma->vm_next) {
+		 if (TASK_SIZE - len < addr)
+			 return -ENOMEM;
+		 if (!vma || ((addr + len) < vma->vm_start))
+			 goto found_addr;
+		 addr = vma->vm_end;
+	}
+found_addr:
+	addr = LPAGE_ALIGN(addr);
+	return addr;
+}
+
+asmlinkage unsigned long
+sys_get_large_pages(unsigned long addr, unsigned long len, int prot, int flags)
+{
+	extern int make_lpages_present(unsigned long, unsigned long, int);
+	int	temp;
+
+	if (!(cpu_has_pse))
+		return -EINVAL;
+	if (len & (LPAGE_SIZE - 1)) 
+		return -EINVAL;
+	addr = get_addr(addr, len);
+	if (addr  ==  -ENOMEM)
+		return addr;
+	temp = MAP_SHARED | MAP_ANONYMOUS |MAP_FIXED;
+	addr = do_mmap_pgoff(NULL, addr, len, prot, temp, 0);
+	printk("Returned addr %x\n", addr);
+	if (!(addr & (LPAGE_SIZE -1))) {
+		 if (make_lpages_present(addr, (addr+len), flags) < 0) {
+			 addr = sys_munmap(addr, len);
+			 return -ENOMEM;
+		}
+	}
+	return addr;
+}
+
+asmlinkage unsigned long 
+sys_share_large_pages(int key, unsigned long addr, unsigned long len, int prot, int flag)
+{
+	unsigned long	raddr;
+	int	retval;
+	extern int set_lp_shm_seg(int, unsigned long *, unsigned long, int, int);
+	if (!(cpu_has_pse))
+		return -EINVAL;
+	if (key <= 0) 
+		return -EINVAL;
+	if (len & (LPAGE_SIZE - 1)) 
+		return -EINVAL;
+	raddr = get_addr(addr, len);
+	if (raddr == -ENOMEM)
+		return raddr;
+	retval = set_lp_shm_seg(key, &raddr, len, prot, flag);
+	if (retval < 0) 
+		return (unsigned long) retval;
+	return raddr;
+}
+
+asmlinkage int
+sys_free_large_pages(unsigned long addr)
+{
+	struct vm_area_struct	*vma;
+	extern int unmap_large_pages(struct vm_area_struct *);
+
+	vma = find_vma(current->mm, addr);
+	if ((!vma) || (!(vma->vm_flags & VM_LARGEPAGE)) || 
+		(vma->vm_start!=addr)) 
+		return -EINVAL;
+	return unmap_large_pages(vma);
+}
+
+asmlinkage int
+sys_unshare_large_pages(unsigned long addr)
+{
+	return sys_free_large_pages(addr);
+}
+
+#else
+asmlinkage unsigned long
+sys_get_large_pages(unsigned long addr, size_t len, int prot, int flags)
+{
+	return -ENOSYS;
+}
+
+asmlinkage unsigned long 
+sys_share_large_apges(int key, unsigned long addr, size_t len, int prot, int flag)
+{
+	return -ENOSYS;
+}
+
+asmlinkage int
+sys_free_large_apges(unsigned long addr)
+{
+	return -ENOSYS;
+}
+
+asmlinkage int
+sys_unshare_large_pages(unsigned long addr)
+{
+	return -ENOSYS;
+}
+#endif
diff -Naru linux.org/arch/i386/mm/Makefile linux.lp/arch/i386/mm/Makefile
--- linux.org/arch/i386/mm/Makefile	Fri Dec 29 14:07:20 2000
+++ linux.lp/arch/i386/mm/Makefile	Tue Jul  2 16:55:53 2002
@@ -10,5 +10,6 @@
 O_TARGET := mm.o
 
 obj-y	 := init.o fault.o ioremap.o extable.o
+obj-$(CONFIG_LARGE_PAGE) += lpage.o
 
 include $(TOPDIR)/Rules.make
diff -Naru linux.org/arch/i386/mm/init.c linux.lp/arch/i386/mm/init.c
--- linux.org/arch/i386/mm/init.c	Fri Dec 21 09:41:53 2001
+++ linux.lp/arch/i386/mm/init.c	Tue Jul  2 18:39:13 2002
@@ -447,6 +447,12 @@
 	return 0;
 }
 	
+#ifdef CONFIG_LARGE_PAGE
+long	lpagemem = 0;
+int	lp_max;
+long	lpzone_pages;
+extern struct	list_head lpage_freelist;
+#endif
 void __init mem_init(void)
 {
 	extern int ppro_with_ram_bug(void);
@@ -532,6 +538,32 @@
 	zap_low_mappings();
 #endif
 
+#ifdef CONFIG_LARGE_PAGE
+	{
+	long	i;
+	long	j;
+	struct page	*page, *map;
+	
+	/*For now reserve quarter for large_pages.*/
+	lpzone_pages = (max_low_pfn >> ((LPAGE_SHIFT - PAGE_SHIFT) + 2)) ; 
+		/*Will make this kernel command line. */
+	INIT_LIST_HEAD(&lpage_freelist);
+	for (i=0; i<lpzone_pages; i++) {
+		page = alloc_pages(GFP_ATOMIC, LARGE_PAGE_ORDER);
+		if (page == NULL)
+			break;
+		map = page;
+		for (j=0; j<(LPAGE_SIZE/PAGE_SIZE); j++) {
+			SetPageReserved(map);
+			map++;
+		}
+		list_add(&page->list, &lpage_freelist);
+	}
+	printk("Total Large_page memory pages allocated %ld\n", i);
+	lpzone_pages = lpagemem = i;
+	lp_max = i;
+	}
+#endif
 }
 
 /* Put this after the callers, so that it cannot be inlined */
diff -Naru linux.org/arch/i386/mm/lpage.c linux.lp/arch/i386/mm/lpage.c
--- linux.org/arch/i386/mm/lpage.c	Wed Dec 31 16:00:00 1969
+++ linux.lp/arch/i386/mm/lpage.c	Wed Jul  3 16:09:59 2002
@@ -0,0 +1,475 @@
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
+#include <linux/locks.h>
+#include <linux/smp_lock.h>
+#include <linux/slab.h>
+
+#include <asm/uaccess.h>
+#include <asm/mman.h>
+
+static struct vm_operations_struct	lp_vm_ops;
+struct list_head 			lpage_freelist;
+spinlock_t				lpage_lock = SPIN_LOCK_UNLOCKED;
+extern	long 				lpagemem;
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
+alloc_large_page(void)
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
+free_large_page(struct page *page)
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
+lp_pte_alloc(struct mm_struct *mm, unsigned long addr)
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
+lp_pte_offset(struct mm_struct *mm, unsigned long addr)
+{
+	pgd_t			*pgd;
+	pmd_t			*pmd = NULL;
+	
+	pgd =pgd_offset(mm, addr);
+	pmd = pmd_offset(pgd, addr);
+	return (pte_t *)pmd;
+}
+
+#define mk_pte_large(entry) {entry.pte_low |= (_PAGE_PRESENT | _PAGE_PSE);}
+	
+static void
+set_lp_pte(struct mm_struct *mm, struct vm_area_struct *vma, struct page *page, pte_t *page_table, int write_access)
+{
+	pte_t           entry;
+
+	mm->rss += (LPAGE_SIZE/PAGE_SIZE);
+	if (write_access) {
+		entry = pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
+	} else
+		entry = pte_wrprotect(mk_pte(page, vma->vm_page_prot));
+	entry = pte_mkyoung(entry);
+	mk_pte_large(entry);
+	set_pte(page_table, entry);
+	printk("VIRTUAL_ADDRESS_OF_LPAGE IS %p\n", page->virtual);
+	return;
+}
+
+static int
+anon_get_lpage(struct mm_struct *mm, struct vm_area_struct *vma, int write_access, pte_t *page_table)
+{
+	struct	page *page;
+
+	page = alloc_large_page();
+	if (page == NULL) 
+		return -1;
+	set_lp_pte(mm, vma, page, page_table, write_access);
+	return 1;
+}
+
+int
+make_lpages_present(unsigned long addr, unsigned long end, int flags)
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
+		pte = lp_pte_alloc(mm, addr);
+		if ((pte) && (pte_none(*pte))) {
+			if (anon_get_lpage(mm, vma, 
+				write ? VM_WRITE : VM_READ, pte) == -1)
+				goto out_error;
+		} else
+			goto out_error;
+		addr += LPAGE_SIZE;
+	} while (addr < end); 
+	spin_unlock(&mm->page_table_lock);
+	vma->vm_flags |= (VM_LARGEPAGE | VM_RESERVED);
+	if (flags & MAP_PRIVATE )
+		vma->vm_flags |= VM_DONTCOPY;
+	vma->vm_ops = &lp_vm_ops;
+	return 0;
+out_error: /*Error case, remove the partial lp_resources. */
+	if (addr > vma->vm_start) { 
+	   	vma->vm_end = addr ;
+	   	zap_lp_resources(vma);
+	   	vma->vm_end = end;
+	}
+	spin_unlock(&mm->page_table_lock);
+out_error1:
+	return -1;
+}
+
+int
+copy_lpage_range(struct mm_struct *dst, struct mm_struct *src, struct vm_area_struct *vma)
+{
+	pte_t *src_pte, *dst_pte, entry;
+	struct page 	*ptepage;
+	unsigned long addr = vma->vm_start;
+	unsigned long end = vma->vm_end;
+
+		while (addr < end) {
+			dst_pte = lp_pte_alloc(dst, addr);
+			if (!dst_pte)
+				goto nomem;
+			src_pte = lp_pte_offset(src, addr);
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
+follow_large_page(struct mm_struct *mm, struct vm_area_struct *vma, struct page **pages, struct vm_area_struct **vmas, unsigned long *st, int *length, int i)
+{
+	pte_t			*ptep, pte;
+	unsigned long	start = *st;
+	unsigned long	pstart;
+	int				len = *length;
+	struct page		*page;
+
+	do {
+		pstart = start;
+		ptep = lp_pte_offset(mm, start);
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
+		if (((start & LPAGE_MASK) == pstart) && len && (start < vma->vm_end))
+			goto back1;
+	} while (len && start < vma->vm_end);
+	*length = len;
+	*st = start;
+	return i;
+}
+
+static void
+zap_lp_resources(struct vm_area_struct *mpnt)
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
+		ptep = lp_pte_offset(mm, addr);
+		page = pte_page(*ptep);
+		pte_clear(ptep);
+		free_large_page(page);
+		addr += LPAGE_SIZE;
+	} while (addr < end);
+	mm->rss -= (len >> PAGE_SHIFT);
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
+unmap_large_pages(struct vm_area_struct *mpnt)
+{
+	struct mm_struct *mm = current->mm;
+
+	unlink_vma(mpnt);
+	spin_lock(&mm->page_table_lock);
+	zap_lp_resources(mpnt);
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
+	if (inode->i_mode != prot)
+		return -1;
+	if (inode->i_size != len)
+		return -1;
+	return 0;
+}
+
+int
+set_lp_shm_seg(int key, unsigned long *raddr, unsigned long len, int prot, int flag)
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
+		pte_t * pte = lp_pte_alloc(mm, addr);
+		if ((pte) && (pte_none(*pte))) {
+			idx = (addr - vma->vm_start) >> LPAGE_SHIFT;
+			page = find_get_page(mapping, idx);
+			if (page == NULL) {
+				page = alloc_large_page();	
+				if (page == NULL) 
+					goto out;	
+				add_to_page_cache(page, mapping, idx);
+			}
+			set_lp_pte(mm, vma, page, pte, (vma->vm_flags & VM_WRITE));
+		} else 
+			goto out;
+		addr += LPAGE_SIZE;
+	} while (addr < vma->vm_end); 
+	retval = 0;
+	vma->vm_flags |= (VM_LARGEPAGE | VM_RESERVED);
+	vma->vm_ops = &lp_vm_ops;
+	spin_unlock(&mm->page_table_lock);
+	return retval;
+out:
+	if (addr > vma->vm_start) {
+		raddr = vma->vm_end;
+		vma->vm_end = addr;
+		zap_lp_resources(vma);
+		vma->vm_end = raddr;
+	}
+	spin_unlock(&mm->page_table_lock);
+	return retval;
+}
+
+int
+change_large_page_mem_size(int count)
+{
+	int j;
+	struct page     *page, *map;
+	extern long        lpzone_pages;
+	extern struct list_head lpage_freelist;
+
+	if (count == 0)
+		return (int)lpzone_pages;
+	if (count > 0) {/*Increase the mem size. */
+		while (count--) {
+			page = alloc_pages(GFP_ATOMIC, LARGE_PAGE_ORDER);
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
+	while (count++) {
+		page = alloc_large_page();
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
+		__free_pages(page, LARGE_PAGE_ORDER);
+	}
+	return (int)lpzone_pages;
+}
+static struct vm_operations_struct	lp_vm_ops = {
+	close: zap_lp_resources,
+};
diff -Naru linux.org/fs/proc/array.c linux.lp/fs/proc/array.c
--- linux.org/fs/proc/array.c	Thu Oct 11 09:00:01 2001
+++ linux.lp/fs/proc/array.c	Wed Jul  3 16:59:09 2002
@@ -486,6 +486,17 @@
 			pgd_t *pgd = pgd_offset(mm, vma->vm_start);
 			int pages = 0, shared = 0, dirty = 0, total = 0;
 
+			if (is_vm_large_page(vma)) {
+				int num_pages = ((vma->vm_end - vma->vm_start)/PAGE_SIZE);
+				resident += num_pages;
+				if ((vma->vm_flags & VM_DONTCOPY))
+					share += num_pages;
+				if (vma->vm_flags & VM_WRITE)
+					dt += num_pages;
+				drs += num_pages;
+				vma = vma->vm_next;
+				continue;
+			}
 			statm_pgd_range(pgd, vma->vm_start, vma->vm_end, &pages, &shared, &dirty, &total);
 			resident += pages;
 			share += shared;
diff -Naru linux.org/fs/proc/proc_misc.c linux.lp/fs/proc/proc_misc.c
--- linux.org/fs/proc/proc_misc.c	Tue Nov 20 21:29:09 2001
+++ linux.lp/fs/proc/proc_misc.c	Wed Jul  3 10:48:21 2002
@@ -151,6 +151,14 @@
 		B(i.sharedram), B(i.bufferram),
 		B(pg_size), B(i.totalswap),
 		B(i.totalswap-i.freeswap), B(i.freeswap));
+#ifdef CONFIG_LARGE_PAGE
+	{
+		extern  unsigned long lpagemem, lpzone_pages;
+		len += sprintf(page+len,"Total # of LargePages: %8lu\t\tAvailable: %8lu\n"
+		"LargePageSize: %8lu(0x%xKB)\n",
+		lpzone_pages, lpagemem, LPAGE_SIZE, (LPAGE_SIZE/1024));
+	}
+#endif
 	/*
 	 * Tagged format, for easy grepping and expansion.
 	 * The above will go away eventually, once the tools
diff -Naru linux.org/include/asm-i386/page.h linux.lp/include/asm-i386/page.h
--- linux.org/include/asm-i386/page.h	Mon Feb 25 11:38:12 2002
+++ linux.lp/include/asm-i386/page.h	Wed Jul  3 10:49:54 2002
@@ -41,14 +41,22 @@
 typedef struct { unsigned long long pmd; } pmd_t;
 typedef struct { unsigned long long pgd; } pgd_t;
 #define pte_val(x)	((x).pte_low | ((unsigned long long)(x).pte_high << 32))
+#define	LPAGE_SHIFT	21
 #else
 typedef struct { unsigned long pte_low; } pte_t;
 typedef struct { unsigned long pmd; } pmd_t;
 typedef struct { unsigned long pgd; } pgd_t;
 #define pte_val(x)	((x).pte_low)
+#define	LPAGE_SHIFT	22
 #endif
 #define PTE_MASK	PAGE_MASK
 
+#ifdef CONFIG_LARGE_PAGE
+#define LPAGE_SIZE 	((1UL) << LPAGE_SHIFT)
+#define	LPAGE_MASK	(~(LPAGE_SIZE - 1))
+#define LARGE_PAGE_ORDER	(LPAGE_SHIFT - PAGE_SHIFT)
+#endif
+
 typedef struct { unsigned long pgprot; } pgprot_t;
 
 #define pmd_val(x)	((x).pmd)
diff -Naru linux.org/include/linux/mm.h linux.lp/include/linux/mm.h
--- linux.org/include/linux/mm.h	Fri Dec 21 09:42:03 2001
+++ linux.lp/include/linux/mm.h	Wed Jul  3 10:49:54 2002
@@ -103,6 +103,7 @@
 #define VM_DONTEXPAND	0x00040000	/* Cannot expand with mremap() */
 #define VM_RESERVED	0x00080000	/* Don't unmap it from swap_out */
 
+#define VM_LARGEPAGE	0x00400000	/* Large_Page mapping. */
 #define VM_STACK_FLAGS	0x00000177
 
 #define VM_READHINTMASK			(VM_SEQ_READ | VM_RAND_READ)
@@ -425,6 +426,16 @@
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, unsigned long start,
 		int len, int write, int force, struct page **pages, struct vm_area_struct **vmas);
 
+#ifdef CONFIG_LARGE_PAGE
+#define is_vm_large_page(vma) (vma->vm_flags & VM_LARGEPAGE)
+extern int	copy_large_page(struct mm_struct *, struct mm_struct *, struct vm_area_struct *);
+extern int	follow_large_page(struct mm_struct *, struct vm_area_struct *, struct page **, struct vm_area_struct **, unsigned long *, int *, int);
+#else
+#define	is_vm_large_page(vma)	(0)
+#define	follow_large_page(mm, vma, pages, vmas, &start, &len, i) (0)
+#define	copy_large_page(dst, src, vma) (0)
+#endif 
+
 /*
  * On a two-level page table, this ends up being trivial. Thus the
  * inlining and the symmetry break with pte_alloc() that does all
diff -Naru linux.org/include/linux/mmzone.h linux.lp/include/linux/mmzone.h
--- linux.org/include/linux/mmzone.h	Thu Nov 22 11:46:19 2001
+++ linux.lp/include/linux/mmzone.h	Wed Jul  3 10:49:54 2002
@@ -13,7 +13,7 @@
  */
 
 #ifndef CONFIG_FORCE_MAX_ZONEORDER
-#define MAX_ORDER 10
+#define MAX_ORDER 15
 #else
 #define MAX_ORDER CONFIG_FORCE_MAX_ZONEORDER
 #endif
diff -Naru linux.org/include/linux/sysctl.h linux.lp/include/linux/sysctl.h
--- linux.org/include/linux/sysctl.h	Mon Nov 26 05:29:17 2001
+++ linux.lp/include/linux/sysctl.h	Wed Jul  3 10:49:54 2002
@@ -124,6 +124,7 @@
 	KERN_CORE_USES_PID=52,		/* int: use core or core.%pid */
 	KERN_TAINTED=53,	/* int: various kernel tainted flags */
 	KERN_CADPID=54,		/* int: PID of the process to notify on CAD */
+	KERN_LARGE_PAGE_MEM=55,	/* Number of large_page pages configured */
 };
 
 
diff -Naru linux.org/kernel/sysctl.c linux.lp/kernel/sysctl.c
--- linux.org/kernel/sysctl.c	Fri Dec 21 09:42:04 2001
+++ linux.lp/kernel/sysctl.c	Tue Jul  2 14:07:28 2002
@@ -96,6 +96,10 @@
 extern int acct_parm[];
 #endif
 
+#ifdef CONFIG_LARGE_PAGE
+extern int	lp_max;
+extern int	change_large_page_mem_size(int );
+#endif
 extern int pgt_cache_water[];
 
 static int parse_table(int *, int, void *, size_t *, void *, size_t,
@@ -256,6 +260,10 @@
 	{KERN_S390_USER_DEBUG_LOGGING,"userprocess_debug",
 	 &sysctl_userprocess_debug,sizeof(int),0644,NULL,&proc_dointvec},
 #endif
+#ifdef CONFIG_LARGE_PAGE
+	{KERN_LARGE_PAGE_MEM, "numlargepages", &lp_max, sizeof(int), 0644, NULL,
+	&proc_dointvec},
+#endif
 	{0}
 };
 
@@ -866,6 +874,10 @@
 				val = -val;
 			buffer += len;
 			left -= len;
+#if CONFIG_LARGE_PAGE
+			if (i == &lp_max)
+				val = change_large_page_mem_size(val);
+#endif
 			switch(op) {
 			case OP_SET:	*i = val; break;
 			case OP_AND:	*i &= val; break;
diff -Naru linux.org/mm/memory.c linux.lp/mm/memory.c
--- linux.org/mm/memory.c	Mon Feb 25 11:38:13 2002
+++ linux.lp/mm/memory.c	Wed Jul  3 16:14:01 2002
@@ -179,6 +179,9 @@
 	unsigned long end = vma->vm_end;
 	unsigned long cow = (vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
 
+	if (is_vm_large_page(vma) )
+		return copy_lpage_range(dst, src, vma);
+
 	src_pgd = pgd_offset(src, address)-1;
 	dst_pgd = pgd_offset(dst, address)-1;
 
@@ -471,6 +474,10 @@
 		if ( !vma || (pages && vma->vm_flags & VM_IO) || !(flags & vma->vm_flags) )
 			return i ? : -EFAULT;
 
+		if (is_vm_large_page(vma)) {
+			i += follow_large_page(mm, vma, pages, vmas, &start, &len, i);
+			continue;
+		}
 		spin_lock(&mm->page_table_lock);
 		do {
 			struct page *map;
@@ -1360,6 +1367,8 @@
 {
 	pgd_t *pgd;
 	pmd_t *pmd;
+	if (is_vm_large_page(vma) )
+		return -1;
 
 	current->state = TASK_RUNNING;
 	pgd = pgd_offset(mm, address);
diff -Naru linux.org/mm/mmap.c linux.lp/mm/mmap.c
--- linux.org/mm/mmap.c	Mon Feb 25 11:38:14 2002
+++ linux.lp/mm/mmap.c	Tue Jul  2 14:15:50 2002
@@ -917,6 +917,9 @@
 	if (mpnt->vm_start >= addr+len)
 		return 0;
 
+	if (is_vm_large_page(mpnt)) /*Large pages can not be unmapped like this. */
+		return -EINVAL;
+
 	/* If we'll make "hole", check the vm areas limit */
 	if ((mpnt->vm_start < addr && mpnt->vm_end > addr+len)
 	    && mm->map_count >= MAX_MAP_COUNT)
diff -Naru linux.org/mm/mprotect.c linux.lp/mm/mprotect.c
--- linux.org/mm/mprotect.c	Mon Sep 17 15:30:23 2001
+++ linux.lp/mm/mprotect.c	Tue Jul  2 14:18:13 2002
@@ -287,6 +287,8 @@
 	error = -EFAULT;
 	if (!vma || vma->vm_start > start)
 		goto out;
+	if (is_vm_large_page(vma))
+		return -EINVAL; /* Cann't change protections on large_page mappings. */
 
 	for (nstart = start ; ; ) {
 		unsigned int newflags;
diff -Naru linux.org/mm/mremap.c linux.lp/mm/mremap.c
--- linux.org/mm/mremap.c	Thu Sep 20 20:31:26 2001
+++ linux.lp/mm/mremap.c	Tue Jul  2 14:20:05 2002
@@ -267,6 +267,10 @@
 	vma = find_vma(current->mm, addr);
 	if (!vma || vma->vm_start > addr)
 		goto out;
+	if (is_vm_large_page(vma)) {
+		ret = -EINVAL; /* Cann't remap large_page mappings. */
+		goto out;
+	}
 	/* We can't remap across vm area boundaries */
 	if (old_len > vma->vm_end - addr)
 		goto out;
