Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264639AbSKMXj3>; Wed, 13 Nov 2002 18:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264644AbSKMXj3>; Wed, 13 Nov 2002 18:39:29 -0500
Received: from to-velocet.redhat.com ([216.138.202.10]:5872 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S264639AbSKMXjE>; Wed, 13 Nov 2002 18:39:04 -0500
Date: Wed, 13 Nov 2002 18:45:55 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [patch] remove hugetlb syscalls
Message-ID: <20021113184555.B10889@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Since the functionality of the hugetlb syscalls is now available via 
hugetlbfs with better control over permissions, could you apply the 
following patch that gets rid of a lot of duplicate and unnescessary 
code by removing the two hugetlb syscalls?  This patch was only tested 
on x86, so if people could take a look over it and see if I missed 
anything I'd appreciate it.  Thanks,

		-ben
-- 
"Do you seek knowledge in time travel?"


 arch/i386/kernel/entry.S         |    4 
 arch/i386/kernel/sys_i386.c      |   67 -----------
 arch/i386/mm/hugetlbpage.c       |  218 ---------------------------------------
 arch/ia64/kernel/entry.S         |    4 
 arch/ia64/kernel/sys_ia64.c      |   75 -------------
 arch/ia64/mm/hugetlbpage.c       |  199 -----------------------------------
 arch/sparc64/kernel/sys_sparc.c  |   97 -----------------
 arch/sparc64/kernel/systbls.S    |    4 
 include/asm-alpha/unistd.h       |    2 
 include/asm-i386/unistd.h        |    2 
 include/asm-ia64/unistd.h        |    2 
 include/asm-ppc/unistd.h         |    2 
 include/asm-ppc64/unistd.h       |    2 
 include/asm-sparc/unistd.h       |    2 
 include/asm-sparc64/unistd.h     |    2 
 include/asm-x86_64/ia32_unistd.h |    2 
 17 files changed, 6 insertions(+), 678 deletions(-)

:r v2.5.47-mm2-hugetlbcleanup.diff
diff -urN v2.5.47-mm2/arch/i386/kernel/entry.S v2.5.47-mm2-hugetlbcleanup/arch/i386/kernel/entry.S
--- v2.5.47-mm2/arch/i386/kernel/entry.S	Wed Nov 13 18:12:15 2002
+++ v2.5.47-mm2-hugetlbcleanup/arch/i386/kernel/entry.S	Wed Nov 13 18:17:05 2002
@@ -760,8 +760,8 @@
 	.long sys_io_getevents
 	.long sys_io_submit
 	.long sys_io_cancel
-	.long sys_alloc_hugepages /* 250 */
-	.long sys_free_hugepages
+	.long sys_ni_syscall	/* 250 */
+	.long sys_ni_syscall
 	.long sys_exit_group
 	.long sys_lookup_dcookie
 	.long sys_epoll_create
diff -urN v2.5.47-mm2/arch/i386/kernel/sys_i386.c v2.5.47-mm2-hugetlbcleanup/arch/i386/kernel/sys_i386.c
--- v2.5.47-mm2/arch/i386/kernel/sys_i386.c	Wed Nov 13 18:09:55 2002
+++ v2.5.47-mm2-hugetlbcleanup/arch/i386/kernel/sys_i386.c	Wed Nov 13 18:21:24 2002
@@ -9,7 +9,6 @@
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
-#include <linux/hugetlb.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <linux/sem.h>
@@ -248,69 +247,3 @@
 	return error;
 }
 
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
-	vma = find_vma(current->mm, addr);
-	if (!vma || !(vma->vm_flags & VM_HUGETLB) || vma->vm_start != addr)
-		return -EINVAL;
-	down_write(&mm->mmap_sem);
-	retval = do_munmap(vma->vm_mm, addr, vma->vm_end - addr);
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
diff -urN v2.5.47-mm2/arch/i386/mm/hugetlbpage.c v2.5.47-mm2-hugetlbcleanup/arch/i386/mm/hugetlbpage.c
--- v2.5.47-mm2/arch/i386/mm/hugetlbpage.c	Wed Nov 13 18:10:01 2002
+++ v2.5.47-mm2-hugetlbcleanup/arch/i386/mm/hugetlbpage.c	Wed Nov 13 18:33:51 2002
@@ -32,17 +32,6 @@
 	int key;
 } htlbpagek[MAX_ID];
 
-static struct inode *find_key_inode(int key)
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
 static struct page *alloc_hugetlb_page(void)
 {
 	int i;
@@ -101,57 +90,6 @@
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
-      out_error1:
-	return -1;
-}
-
 int
 copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			struct vm_area_struct *vma)
@@ -297,138 +235,6 @@
 	spin_unlock(&mm->page_table_lock);
 }
 
-static struct inode *set_new_inode(unsigned long len, int prot, int flag, int key)
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
-	inode->i_ino = (unsigned long)key;
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
-static int check_size_prot(struct inode *inode, unsigned long len, int prot, int flag)
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
-static int alloc_shared_hugetlb_pages(int key, unsigned long addr, unsigned long len, int prot, int flag)
-{
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	struct inode *inode;
-	struct address_space *mapping;
-	int idx;
-	int retval = -ENOMEM;
-	int newalloc = 0;
-
-try_again:
-	spin_lock(&htlbpage_lock);
-
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
-			retval = -EINVAL;
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
-			MAP_NORESERVE|MAP_FIXED|MAP_PRIVATE|MAP_ANONYMOUS, 0);
-	if (IS_ERR((void *) addr))
-		goto freeinode;
-
-	vma = find_vma(mm, addr);
-	if (!vma) {
-		retval = -EINVAL;
-		goto freeinode;
-	}
-
-	retval = hugetlb_prefault(mapping, vma);
-	if (retval)
-		goto out;
-
-	vma->vm_flags |= (VM_HUGETLB | VM_RESERVED);
-	vma->vm_ops = &hugetlb_vm_ops;
-	spin_unlock(&mm->page_table_lock);
-	spin_lock(&htlbpage_lock);
-	atomic_set(&inode->i_writecount, 0);
-	spin_unlock(&htlbpage_lock);
-	return retval;
-out:
-	if (addr > vma->vm_start) {
-		unsigned long raddr;
-		raddr = vma->vm_end;
-		vma->vm_end = addr;
-		zap_hugepage_range(vma, vma->vm_start, vma->vm_end - vma->vm_start);
-		vma->vm_end = raddr;
-	}
-	spin_unlock(&mm->page_table_lock);
-	do_munmap(mm, vma->vm_start, len);
-	if (newalloc)
-		goto freeinode;
-	return retval;
-out_err: spin_unlock(&htlbpage_lock);
-freeinode:
-	 if (newalloc) {
-		 for(idx=0;idx<MAX_ID;idx++)
-			 if (htlbpagek[idx].key == inode->i_ino) {
-				 htlbpagek[idx].key = 0;
-				 htlbpagek[idx].in = NULL;
-				 break;
-			 }
-		 kfree(inode);
-	 }
-	 return retval;
-}
-
 int hugetlb_prefault(struct address_space *mapping, struct vm_area_struct *vma)
 {
 	struct mm_struct *mm = current->mm;
@@ -470,30 +276,6 @@
 	return ret;
 }
 
-static int alloc_private_hugetlb_pages(int key, unsigned long addr, unsigned long len, int prot, int flag)
-{
-	if (!capable(CAP_SYS_ADMIN)) {
-		if (!in_group_p(0))
-			return -EPERM;
-	}
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
-
 int set_hugetlb_mem_size(int count)
 {
 	int j, lcount;
diff -urN v2.5.47-mm2/arch/ia64/kernel/entry.S v2.5.47-mm2-hugetlbcleanup/arch/ia64/kernel/entry.S
--- v2.5.47-mm2/arch/ia64/kernel/entry.S	Wed Nov 13 18:09:55 2002
+++ v2.5.47-mm2-hugetlbcleanup/arch/ia64/kernel/entry.S	Wed Nov 13 18:27:58 2002
@@ -1242,8 +1242,8 @@
 	data8 sys_sched_setaffinity
 	data8 sys_sched_getaffinity
 	data8 sys_security
-	data8 sys_alloc_hugepages
-	data8 sys_free_hugepages		// 1235
+	data8 ia64_ni_syscall
+	data8 ia64_ni_syscall		// 1235
 	data8 sys_exit_group
 	data8 sys_lookup_dcookie
 	data8 sys_io_setup
diff -urN v2.5.47-mm2/arch/ia64/kernel/sys_ia64.c v2.5.47-mm2-hugetlbcleanup/arch/ia64/kernel/sys_ia64.c
--- v2.5.47-mm2/arch/ia64/kernel/sys_ia64.c	Wed Nov 13 18:09:55 2002
+++ v2.5.47-mm2-hugetlbcleanup/arch/ia64/kernel/sys_ia64.c	Wed Nov 13 18:20:33 2002
@@ -9,7 +9,6 @@
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
-#include <linux/hugetlb.h>
 #include <linux/mman.h>
 #include <linux/sched.h>
 #include <linux/file.h>		/* doh, must come after sched.h... */
@@ -243,80 +242,6 @@
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
diff -urN v2.5.47-mm2/arch/ia64/mm/hugetlbpage.c v2.5.47-mm2-hugetlbcleanup/arch/ia64/mm/hugetlbpage.c
--- v2.5.47-mm2/arch/ia64/mm/hugetlbpage.c	Wed Nov 13 18:09:55 2002
+++ v2.5.47-mm2-hugetlbcleanup/arch/ia64/mm/hugetlbpage.c	Wed Nov 13 18:40:11 2002
@@ -31,18 +31,6 @@
 	int key;
 } htlbpagek[MAX_ID];
 
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
@@ -305,193 +293,6 @@
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
diff -urN v2.5.47-mm2/arch/sparc64/kernel/sys_sparc.c v2.5.47-mm2-hugetlbcleanup/arch/sparc64/kernel/sys_sparc.c
--- v2.5.47-mm2/arch/sparc64/kernel/sys_sparc.c	Wed Nov 13 18:09:56 2002
+++ v2.5.47-mm2-hugetlbcleanup/arch/sparc64/kernel/sys_sparc.c	Wed Nov 13 18:21:12 2002
@@ -13,7 +13,6 @@
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/mm.h>
-#include <linux/hugetlb.h>
 #include <linux/sem.h>
 #include <linux/msg.h>
 #include <linux/shm.h>
@@ -683,99 +682,3 @@
 	return err;
 }
 
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
diff -urN v2.5.47-mm2/arch/sparc64/kernel/systbls.S v2.5.47-mm2-hugetlbcleanup/arch/sparc64/kernel/systbls.S
--- v2.5.47-mm2/arch/sparc64/kernel/systbls.S	Wed Nov 13 18:12:16 2002
+++ v2.5.47-mm2-hugetlbcleanup/arch/sparc64/kernel/systbls.S	Wed Nov 13 18:27:21 2002
@@ -65,8 +65,8 @@
 	.word sys32_ipc, sys32_sigreturn, sys_clone, sys_nis_syscall, sys32_adjtimex
 /*220*/	.word sys32_sigprocmask, sys_ni_syscall, sys32_delete_module, sys_ni_syscall, sys_getpgid
 	.word sys32_bdflush, sys32_sysfs, sys_nis_syscall, sys32_setfsuid16, sys32_setfsgid16
-/*230*/	.word sys32_select, sys_time, sys_nis_syscall, sys_stime, sys_alloc_hugepages
-	.word sys_free_hugepages, sys_llseek, sys_mlock, sys_munlock, sys_mlockall
+/*230*/	.word sys32_select, sys_time, sys_nis_syscall, sys_stime, sys_ni_syscall
+	.word sys_ni_syscall, sys_llseek, sys_mlock, sys_munlock, sys_mlockall
 /*240*/	.word sys_munlockall, sys_sched_setparam, sys_sched_getparam, sys_sched_setscheduler, sys_sched_getscheduler
 	.word sys_sched_yield, sys_sched_get_priority_max, sys_sched_get_priority_min, sys32_sched_rr_get_interval, sys32_nanosleep
 /*250*/	.word sys32_mremap, sys32_sysctl, sys_getsid, sys_fdatasync, sys32_nfsservctl
diff -urN v2.5.47-mm2/include/asm-alpha/unistd.h v2.5.47-mm2-hugetlbcleanup/include/asm-alpha/unistd.h
--- v2.5.47-mm2/include/asm-alpha/unistd.h	Wed Nov 13 18:09:58 2002
+++ v2.5.47-mm2-hugetlbcleanup/include/asm-alpha/unistd.h	Wed Nov 13 18:23:03 2002
@@ -340,8 +340,6 @@
 #define __NR_io_getevents		400
 #define __NR_io_submit			401
 #define __NR_io_cancel			402
-#define __NR_alloc_hugepages		403
-#define __NR_free_hugepages		404
 #define __NR_exit_group			405
 #define NR_SYSCALLS			406
 
diff -urN v2.5.47-mm2/include/asm-i386/unistd.h v2.5.47-mm2-hugetlbcleanup/include/asm-i386/unistd.h
--- v2.5.47-mm2/include/asm-i386/unistd.h	Wed Nov 13 18:09:58 2002
+++ v2.5.47-mm2-hugetlbcleanup/include/asm-i386/unistd.h	Wed Nov 13 18:22:04 2002
@@ -254,8 +254,6 @@
 #define __NR_io_getevents	247
 #define __NR_io_submit		248
 #define __NR_io_cancel		249
-#define __NR_alloc_hugepages	250
-#define __NR_free_hugepages	251
 #define __NR_exit_group		252
 #define __NR_lookup_dcookie	253
 #define __NR_sys_epoll_create	254
diff -urN v2.5.47-mm2/include/asm-ia64/unistd.h v2.5.47-mm2-hugetlbcleanup/include/asm-ia64/unistd.h
--- v2.5.47-mm2/include/asm-ia64/unistd.h	Wed Nov 13 18:09:58 2002
+++ v2.5.47-mm2-hugetlbcleanup/include/asm-ia64/unistd.h	Wed Nov 13 18:24:20 2002
@@ -223,8 +223,6 @@
 #define __NR_sched_setaffinity		1231
 #define __NR_sched_getaffinity		1232
 #define __NR_security			1233
-#define __NR_alloc_hugepages		1234
-#define __NR_free_hugepages		1235
 #define __NR_exit_group			1236
 #define __NR_lookup_dcookie		1237
 #define __NR_io_setup			1238
diff -urN v2.5.47-mm2/include/asm-ppc/unistd.h v2.5.47-mm2-hugetlbcleanup/include/asm-ppc/unistd.h
--- v2.5.47-mm2/include/asm-ppc/unistd.h	Wed Nov 13 18:10:05 2002
+++ v2.5.47-mm2-hugetlbcleanup/include/asm-ppc/unistd.h	Wed Nov 13 18:24:03 2002
@@ -236,8 +236,6 @@
 #define __NR_io_getevents	229
 #define __NR_io_submit		230
 #define __NR_io_cancel		231
-#define __NR_alloc_hugepages	232
-#define __NR_free_hugepages	233
 #define __NR_exit_group		234
 #define __NR_lookup_dcookie	235
 #define __NR_sys_epoll_create	236
diff -urN v2.5.47-mm2/include/asm-ppc64/unistd.h v2.5.47-mm2-hugetlbcleanup/include/asm-ppc64/unistd.h
--- v2.5.47-mm2/include/asm-ppc64/unistd.h	Wed Nov 13 18:24:46 2002
+++ v2.5.47-mm2-hugetlbcleanup/include/asm-ppc64/unistd.h	Wed Nov 13 18:25:17 2002
@@ -241,8 +241,6 @@
 #define __NR_io_getevents	229
 #define __NR_io_submit		230
 #define __NR_io_cancel		231
-#define __NR_alloc_hugepages	232
-#define __NR_free_hugepages	233
 #define __NR_exit_group		234
 
 #define __NR(n)	#n
diff -urN v2.5.47-mm2/include/asm-sparc/unistd.h v2.5.47-mm2-hugetlbcleanup/include/asm-sparc/unistd.h
--- v2.5.47-mm2/include/asm-sparc/unistd.h	Wed Nov 13 18:10:05 2002
+++ v2.5.47-mm2-hugetlbcleanup/include/asm-sparc/unistd.h	Wed Nov 13 18:23:27 2002
@@ -249,8 +249,6 @@
 #define __NR_time               231 /* Linux Specific                              */
 /* #define __NR_oldstat         232    Linux Specific                              */
 #define __NR_stime              233 /* Linux Specific                              */
-#define __NR_alloc_hugepages    234 /* Linux Specific                              */
-#define __NR_free_hugepages     235 /* Linux Specific                              */
 #define __NR__llseek            236 /* Linux Specific                              */
 #define __NR_mlock              237
 #define __NR_munlock            238
diff -urN v2.5.47-mm2/include/asm-sparc64/unistd.h v2.5.47-mm2-hugetlbcleanup/include/asm-sparc64/unistd.h
--- v2.5.47-mm2/include/asm-sparc64/unistd.h	Wed Nov 13 18:10:05 2002
+++ v2.5.47-mm2-hugetlbcleanup/include/asm-sparc64/unistd.h	Wed Nov 13 18:23:42 2002
@@ -251,8 +251,6 @@
 #endif
 /* #define __NR_oldstat         232    Linux Specific                              */
 #define __NR_stime              233 /* Linux Specific                              */
-#define __NR_alloc_hugepages    234 /* Linux Specific                              */
-#define __NR_free_hugepages     235 /* Linux Specific                              */
 #define __NR__llseek            236 /* Linux Specific                              */
 #define __NR_mlock              237
 #define __NR_munlock            238
diff -urN v2.5.47-mm2/include/asm-x86_64/ia32_unistd.h v2.5.47-mm2-hugetlbcleanup/include/asm-x86_64/ia32_unistd.h
--- v2.5.47-mm2/include/asm-x86_64/ia32_unistd.h	Mon Nov  4 16:15:14 2002
+++ v2.5.47-mm2-hugetlbcleanup/include/asm-x86_64/ia32_unistd.h	Wed Nov 13 18:26:03 2002
@@ -256,8 +256,6 @@
 #define __NR_ia32_io_getevents	247
 #define __NR_ia32_io_submit		248
 #define __NR_ia32_io_cancel		249
-#define __NR_ia32_alloc_hugepages		250
-#define __NR_ia32_free_hugepages		251
 #define __NR_ia32_exit_group		252
 
 #define IA32_NR_syscalls 260	/* must be > than biggest syscall! */	
