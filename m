Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbUCYRDi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 12:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263455AbUCYRDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 12:03:23 -0500
Received: from hellhawk.shadowen.org ([212.13.208.175]:51465 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S263407AbUCYQ4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 11:56:44 -0500
Date: Thu, 25 Mar 2004 17:00:03 +0000
From: Andy Whitcroft <apw@shadowen.org>
To: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>
cc: Andi Kleen <ak@suse.de>, raybry@sgi.com, lse-tech@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: [PATCH] [3/6] HUGETLB memory commitment
Message-ID: <18759855.1080234003@42.150.104.212.access.eclipse.net.uk>
In-Reply-To: <18429360.1080233672@42.150.104.212.access.eclipse.net.uk>
References: <18429360.1080233672@42.150.104.212.access.eclipse.net.uk>
X-Mailer: Mulberry/3.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[060-mem_acctdom_commitments]

Split vm_commited_space per domain

Currently only normal page commitments are tracked.  This patch
provides a framework for tracking page commitments in multiple
independent domains.  With this patch vm_commited_space becomes a

---
 fs/proc/proc_misc.c      |    2 +-
 include/linux/mm.h       |   13 +++++++++++--
 include/linux/mman.h     |   12 ++++++------
 kernel/fork.c            |    8 +++-----
 mm/memory.c              |   12 +++++++++---
 mm/mmap.c                |   23 ++++++++++++-----------
 mm/mprotect.c            |    5 ++---
 mm/mremap.c              |   12 ++++++------
 mm/nommu.c               |    3 ++-
 mm/shmem.c               |   13 +++++++------
 mm/swap.c                |   17 +++++++++++++----
 mm/swapfile.c            |    4 +++-
 security/commoncap.c     |   10 +++++-----
 security/dummy.c         |   10 +++++-----
 security/selinux/hooks.c |   10 +++++-----
 15 files changed, 90 insertions(+), 64 deletions(-)

diff -upN reference/fs/proc/proc_misc.c current/fs/proc/proc_misc.c
--- reference/fs/proc/proc_misc.c	2004-03-25 15:03:28.000000000 +0000
+++ current/fs/proc/proc_misc.c	2004-03-25 15:03:32.000000000 +0000
@@ -174,7 +174,7 @@ static int meminfo_read_proc(char *page,
 #define K(x) ((x) << (PAGE_SHIFT - 10))
 	si_meminfo(&i);
 	si_swapinfo(&i);
-	committed = atomic_read(&vm_committed_space);
+	committed = atomic_read(&vm_committed_space[VM_AD_DEFAULT]);
 
 	vmtot = (VMALLOC_END-VMALLOC_START)>>10;
 	vmi = get_vmalloc_info();
diff -upN reference/include/linux/mman.h current/include/linux/mman.h
--- reference/include/linux/mman.h	2004-01-09 06:59:09.000000000 +0000
+++ current/include/linux/mman.h	2004-03-25 15:03:32.000000000 +0000
@@ -12,20 +12,20 @@
 
 extern int sysctl_overcommit_memory;
 extern int sysctl_overcommit_ratio;
-extern atomic_t vm_committed_space;
+extern atomic_t vm_committed_space[];
 
 #ifdef CONFIG_SMP
-extern void vm_acct_memory(long pages);
+extern void vm_acct_memory(int domain, long pages);
 #else
-static inline void vm_acct_memory(long pages)
+static inline void vm_acct_memory(int domain, long pages)
 {
-	atomic_add(pages, &vm_committed_space);
+	atomic_add(pages, &vm_committed_space[domain]);
 }
 #endif
 
-static inline void vm_unacct_memory(long pages)
+static inline void vm_unacct_memory(int domain, long pages)
 {
-	vm_acct_memory(-pages);
+	vm_acct_memory(domain, -pages);
 }
 
 /*
diff -upN reference/include/linux/mm.h current/include/linux/mm.h
--- reference/include/linux/mm.h	2004-03-25 15:03:32.000000000 +0000
+++ current/include/linux/mm.h	2004-03-25 15:03:32.000000000 +0000
@@ -117,7 +117,16 @@ struct vm_area_struct {
 #define VM_ACCTDOM(vma) (!!((vma)->vm_flags & VM_HUGETLB))
 #define VM_AD_DEFAULT	0
 #define VM_AD_HUGETLB	1
-
+typedef struct {
+	long vec[VM_ACCTDOM_NR];
+} madv_t;
+#define MADV_NONE { {[0 ... VM_ACCTDOM_NR-1] =  0UL} }
+static inline void madv_add(madv_t *madv, int domain, long size)
+{
+	madv->vec[domain] += size;
+}
+void vm_unacct_memory_domains(madv_t *madv);
+  
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
 #endif
@@ -446,7 +455,7 @@ void zap_page_range(struct vm_area_struc
 			unsigned long size);
 int unmap_vmas(struct mmu_gather **tlbp, struct mm_struct *mm,
 		struct vm_area_struct *start_vma, unsigned long start_addr,
-		unsigned long end_addr, unsigned long *nr_accounted);
+		unsigned long end_addr, madv_t *nr_accounted);
 void unmap_page_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			unsigned long address, unsigned long size);
 void clear_page_tables(struct mmu_gather *tlb, unsigned long first, int nr);
diff -upN reference/kernel/fork.c current/kernel/fork.c
--- reference/kernel/fork.c	2004-03-25 15:03:32.000000000 +0000
+++ current/kernel/fork.c	2004-03-25 15:03:32.000000000 +0000
@@ -267,7 +267,7 @@ static inline int dup_mmap(struct mm_str
 	struct vm_area_struct * mpnt, *tmp, **pprev;
 	struct rb_node **rb_link, *rb_parent;
 	int retval;
-	unsigned long charge = 0;
+	madv_t charge = MADV_NONE;
 
 	down_write(&oldmm->mmap_sem);
 	flush_cache_mm(current->mm);
@@ -303,8 +303,7 @@ static inline int dup_mmap(struct mm_str
 			unsigned int len = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
 			if (security_vm_enough_memory(VM_ACCTDOM(mpnt), len))
 				goto fail_nomem;
-			if (VM_ACCTDOM(mpnt) == VM_AD_DEFAULT)
-				charge += len;
+ 			madv_add(&charge, VM_ACCTDOM(mpnt), len);
 		}
 		tmp = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 		if (!tmp)
@@ -359,8 +358,7 @@ out:
 fail_nomem:
 	retval = -ENOMEM;
 fail:
-	if (charge)
-		vm_unacct_memory(charge);
+	vm_unacct_memory_domains(&charge);
 	goto out;
 }
 static inline int mm_alloc_pgd(struct mm_struct * mm)
diff -upN reference/mm/memory.c current/mm/memory.c
--- reference/mm/memory.c	2004-03-25 15:03:32.000000000 +0000
+++ current/mm/memory.c	2004-03-25 15:03:32.000000000 +0000
@@ -524,7 +524,7 @@ void unmap_page_range(struct mmu_gather 
  */
 int unmap_vmas(struct mmu_gather **tlbp, struct mm_struct *mm,
 		struct vm_area_struct *vma, unsigned long start_addr,
-		unsigned long end_addr, unsigned long *nr_accounted)
+		unsigned long end_addr, madv_t *nr_accounted)
 {
 	unsigned long zap_bytes = ZAP_BLOCK_SIZE;
 	unsigned long tlb_start = 0;	/* For tlb_finish_mmu */
@@ -553,7 +553,8 @@ int unmap_vmas(struct mmu_gather **tlbp,
 
 		/* We assume that only accountable VMAs are VM_ACCOUNT. */
 		if (vma->vm_flags & VM_ACCOUNT)
-			*nr_accounted += (end - start) >> PAGE_SHIFT;
+			madv_add(nr_accounted,
+				VM_ACCTDOM(vma), (end - start) >> PAGE_SHIFT);
 
 		ret++;
 		while (start != end) {
@@ -602,7 +603,12 @@ void zap_page_range(struct vm_area_struc
 	struct mm_struct *mm = vma->vm_mm;
 	struct mmu_gather *tlb;
 	unsigned long end = address + size;
-	unsigned long nr_accounted = 0;
+	madv_t nr_accounted = MADV_NONE;
+
+	/* XXX: we seem to avoid thinking about the memory accounting
+	 * for both the hugepages where don't bother even tracking it and
+	 * in the normal path where we figure it out and do nothing with it??
+	 */
 
 	might_sleep();
 
diff -upN reference/mm/mmap.c current/mm/mmap.c
--- reference/mm/mmap.c	2004-03-25 15:03:32.000000000 +0000
+++ current/mm/mmap.c	2004-03-25 15:03:32.000000000 +0000
@@ -54,7 +54,8 @@ pgprot_t protection_map[16] = {
 
 int sysctl_overcommit_memory = 0;	/* default is heuristic overcommit */
 int sysctl_overcommit_ratio = 50;	/* default is 50% */
-atomic_t vm_committed_space = ATOMIC_INIT(0);
+atomic_t vm_committed_space[VM_ACCTDOM_NR] = 
+     { [ 0 ... VM_ACCTDOM_NR-1 ] = ATOMIC_INIT(0) };
 
 EXPORT_SYMBOL(sysctl_overcommit_memory);
 EXPORT_SYMBOL(sysctl_overcommit_ratio);
@@ -611,8 +612,8 @@ munmap_back:
 	    > current->rlim[RLIMIT_AS].rlim_cur)
 		return -ENOMEM;
 
-	if (acctdom == VM_AD_DEFAULT && (!(flags & MAP_NORESERVE) || 
-	    sysctl_overcommit_memory > 1)) {
+	if (!(flags & MAP_NORESERVE) || 
+	    (acctdom == VM_AD_DEFAULT && sysctl_overcommit_memory > 1)) {
 		if (vm_flags & VM_SHARED) {
 			/* Check memory availability in shmem_file_setup? */
 			vm_flags |= VM_ACCOUNT;
@@ -730,7 +731,7 @@ free_vma:
 	kmem_cache_free(vm_area_cachep, vma);
 unacct_error:
 	if (charged)
-		vm_unacct_memory(charged);
+		vm_unacct_memory(acctdom, charged);
 	return error;
 }
 
@@ -940,7 +941,7 @@ int expand_stack(struct vm_area_struct *
 			((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) >
 			current->rlim[RLIMIT_AS].rlim_cur) {
 		spin_unlock(&vma->vm_mm->page_table_lock);
-		vm_unacct_memory(grow);
+		vm_unacct_memory(VM_AD_DEFAULT, grow);
 		return -ENOMEM;
 	}
 	vma->vm_end = address;
@@ -994,7 +995,7 @@ int expand_stack(struct vm_area_struct *
 			((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) >
 			current->rlim[RLIMIT_AS].rlim_cur) {
 		spin_unlock(&vma->vm_mm->page_table_lock);
-		vm_unacct_memory(grow);
+		vm_unacct_memory(VM_AD_DEFAULT, grow);
 		return -ENOMEM;
 	}
 	vma->vm_start = address;
@@ -1152,12 +1153,12 @@ static void unmap_region(struct mm_struc
 	unsigned long end)
 {
 	struct mmu_gather *tlb;
-	unsigned long nr_accounted = 0;
+	madv_t nr_accounted = MADV_NONE;
 
 	lru_add_drain();
 	tlb = tlb_gather_mmu(mm, 0);
 	unmap_vmas(&tlb, mm, vma, start, end, &nr_accounted);
-	vm_unacct_memory(nr_accounted);
+	vm_unacct_memory_domains(&nr_accounted);
 
 	if (is_hugepage_only_range(start, end - start))
 		hugetlb_free_pgtables(tlb, prev, start, end);
@@ -1397,7 +1398,7 @@ unsigned long do_brk(unsigned long addr,
 	 */
 	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 	if (!vma) {
-		vm_unacct_memory(len >> PAGE_SHIFT);
+		vm_unacct_memory(VM_AD_DEFAULT, len >> PAGE_SHIFT);
 		return -ENOMEM;
 	}
 
@@ -1430,7 +1431,7 @@ void exit_mmap(struct mm_struct *mm)
 {
 	struct mmu_gather *tlb;
 	struct vm_area_struct *vma;
-	unsigned long nr_accounted = 0;
+	madv_t nr_accounted = MADV_NONE;
 
 	profile_exit_mmap(mm);
  
@@ -1443,7 +1444,7 @@ void exit_mmap(struct mm_struct *mm)
 	/* Use ~0UL here to ensure all VMAs in the mm are unmapped */
 	mm->map_count -= unmap_vmas(&tlb, mm, mm->mmap, 0,
 					~0UL, &nr_accounted);
-	vm_unacct_memory(nr_accounted);
+	vm_unacct_memory_domains(&nr_accounted);
 	BUG_ON(mm->map_count);	/* This is just debugging */
 	clear_page_tables(tlb, FIRST_USER_PGD_NR, USER_PTRS_PER_PGD);
 	tlb_finish_mmu(tlb, 0, MM_VM_SIZE(mm));
diff -upN reference/mm/mprotect.c current/mm/mprotect.c
--- reference/mm/mprotect.c	2004-03-25 15:03:32.000000000 +0000
+++ current/mm/mprotect.c	2004-03-25 15:03:32.000000000 +0000
@@ -173,8 +173,7 @@ mprotect_fixup(struct vm_area_struct *vm
 	 * a MAP_NORESERVE private mapping to writable will now reserve.
 	 */
 	if (newflags & VM_WRITE) {
-		if (!(vma->vm_flags & (VM_ACCOUNT|VM_WRITE|VM_SHARED)) &&
-				VM_ACCTDOM(vma) == VM_AD_DEFAULT) {
+		if (!(vma->vm_flags & (VM_ACCOUNT|VM_WRITE|VM_SHARED))) {
 			charged = (end - start) >> PAGE_SHIFT;
 			if (security_vm_enough_memory(VM_ACCTDOM(vma), charged))
 				return -ENOMEM;
@@ -218,7 +217,7 @@ success:
 	return 0;
 
 fail:
-	vm_unacct_memory(charged);
+	vm_unacct_memory(VM_ACCTDOM(vma), charged);
 	return error;
 }
 
diff -upN reference/mm/mremap.c current/mm/mremap.c
--- reference/mm/mremap.c	2004-03-25 15:03:32.000000000 +0000
+++ current/mm/mremap.c	2004-03-25 15:03:32.000000000 +0000
@@ -401,7 +401,7 @@ unsigned long do_mremap(unsigned long ad
 	if (vma->vm_flags & VM_ACCOUNT) {
 		charged = (new_len - old_len) >> PAGE_SHIFT;
 		if (security_vm_enough_memory(VM_ACCTDOM(vma), charged))
-			goto out_nc;
+			goto out;
 	}
   
 	/* old_len exactly to the end of the area..
@@ -426,7 +426,7 @@ unsigned long do_mremap(unsigned long ad
 						   addr + new_len);
 			}
 			ret = addr;
-			goto out;
+			goto out_commited;
 		}
 	}
 
@@ -445,14 +445,14 @@ unsigned long do_mremap(unsigned long ad
 						vma->vm_pgoff, map_flags);
 			ret = new_addr;
 			if (new_addr & ~PAGE_MASK)
-				goto out;
+				goto out_commited;
 		}
 		ret = move_vma(vma, addr, old_len, new_len, new_addr);
 	}
-out:
+out_commited:
 	if (ret & ~PAGE_MASK)
-		vm_unacct_memory(charged);
-out_nc:
+		vm_unacct_memory(VM_ACCTDOM(vma), charged);
+out:
 	return ret;
 }
 
diff -upN reference/mm/nommu.c current/mm/nommu.c
--- reference/mm/nommu.c	2004-02-04 15:09:16.000000000 +0000
+++ current/mm/nommu.c	2004-03-25 15:03:32.000000000 +0000
@@ -29,7 +29,8 @@ struct page *mem_map;
 unsigned long max_mapnr;
 unsigned long num_physpages;
 unsigned long askedalloc, realalloc;
-atomic_t vm_committed_space = ATOMIC_INIT(0);
+atomic_t vm_committed_space[VM_ACCTDOM_NR] = 
+     { [ 0 ... VM_ACCTDOM_NR-1 ] = ATOMIC_INIT(0) };
 int sysctl_overcommit_memory; /* default is heuristic overcommit */
 int sysctl_overcommit_ratio = 50; /* default is 50% */
 
diff -upN reference/mm/shmem.c current/mm/shmem.c
--- reference/mm/shmem.c	2004-03-25 15:03:32.000000000 +0000
+++ current/mm/shmem.c	2004-03-25 15:03:32.000000000 +0000
@@ -529,7 +529,7 @@ static int shmem_notify_change(struct de
 			if (security_vm_enough_memory(VM_AD_DEFAULT, change))
 				return -ENOMEM;
 		} else if (attr->ia_size < inode->i_size) {
-			vm_unacct_memory(-change);
+			vm_unacct_memory(VM_AD_DEFAULT, -change);
 			/*
 			 * If truncating down to a partial page, then
 			 * if that page is already allocated, hold it
@@ -564,7 +564,7 @@ static int shmem_notify_change(struct de
 	if (page)
 		page_cache_release(page);
 	if (error)
-		vm_unacct_memory(change);
+		vm_unacct_memory(VM_AD_DEFAULT, change);
 	return error;
 }
 
@@ -578,7 +578,7 @@ static void shmem_delete_inode(struct in
 		list_del(&info->list);
 		spin_unlock(&shmem_ilock);
 		if (info->flags & VM_ACCOUNT)
-			vm_unacct_memory(VM_ACCT(inode->i_size));
+			vm_unacct_memory(VM_AD_DEFAULT, VM_ACCT(inode->i_size));
 		inode->i_size = 0;
 		shmem_truncate(inode);
 	}
@@ -1271,7 +1271,8 @@ shmem_file_write(struct file *file, cons
 
 	/* Short writes give back address space */
 	if (inode->i_size != maxpos)
-		vm_unacct_memory(VM_ACCT(maxpos) - VM_ACCT(inode->i_size));
+		vm_unacct_memory(VM_AD_DEFAULT, VM_ACCT(maxpos) -
+			VM_ACCT(inode->i_size));
 out:
 	up(&inode->i_sem);
 	return err;
@@ -1558,7 +1559,7 @@ static int shmem_symlink(struct inode *d
 		}
 		error = shmem_getpage(inode, 0, &page, SGP_WRITE, NULL);
 		if (error) {
-			vm_unacct_memory(VM_ACCT(1));
+			vm_unacct_memory(VM_AD_DEFAULT, VM_ACCT(1));
 			iput(inode);
 			return error;
 		}
@@ -1988,7 +1989,7 @@ put_dentry:
 	dput(dentry);
 put_memory:
 	if (flags & VM_ACCOUNT)
-		vm_unacct_memory(VM_ACCT(size));
+		vm_unacct_memory(VM_AD_DEFAULT, VM_ACCT(size));
 	return ERR_PTR(error);
 }
 
diff -upN reference/mm/swap.c current/mm/swap.c
--- reference/mm/swap.c	2004-03-25 02:43:43.000000000 +0000
+++ current/mm/swap.c	2004-03-25 15:03:32.000000000 +0000
@@ -368,17 +368,18 @@ unsigned int pagevec_lookup(struct pagev
  */
 #define ACCT_THRESHOLD	max(16, NR_CPUS * 2)
 
-static DEFINE_PER_CPU(long, committed_space) = 0;
+/* XXX: zero this????? */
+static DEFINE_PER_CPU(long, committed_space[VM_ACCTDOM_NR]);
 
-void vm_acct_memory(long pages)
+void vm_acct_memory(int domain, long pages)
 {
 	long *local;
 
 	preempt_disable();
-	local = &__get_cpu_var(committed_space);
+	local = &__get_cpu_var(committed_space[domain]);
 	*local += pages;
 	if (*local > ACCT_THRESHOLD || *local < -ACCT_THRESHOLD) {
-		atomic_add(*local, &vm_committed_space);
+		atomic_add(*local, &vm_committed_space[domain]);
 		*local = 0;
 	}
 	preempt_enable();
@@ -416,6 +417,14 @@ static int cpu_swap_callback(struct noti
 #endif /* CONFIG_HOTPLUG_CPU */
 #endif /* CONFIG_SMP */
 
+void vm_unacct_memory_domains(madv_t *adv)
+{
+	if (adv->vec[0])
+		vm_unacct_memory(VM_AD_DEFAULT, adv->vec[0]);
+	if (adv->vec[1])
+		vm_unacct_memory(VM_AD_DEFAULT, adv->vec[1]);
+}
+
 #ifdef CONFIG_SMP
 void percpu_counter_mod(struct percpu_counter *fbc, long amount)
 {
diff -upN reference/mm/swapfile.c current/mm/swapfile.c
--- reference/mm/swapfile.c	2004-03-25 15:03:32.000000000 +0000
+++ current/mm/swapfile.c	2004-03-25 15:03:32.000000000 +0000
@@ -1048,8 +1048,10 @@ asmlinkage long sys_swapoff(const char _
 		swap_list_unlock();
 		goto out_dput;
 	}
+	/* There is an assumption here that we only may have swapped things
+	 * from the default memory accounting domain to this device. */
 	if (!security_vm_enough_memory(VM_AD_DEFAULT, p->pages))
-		vm_unacct_memory(p->pages);
+		vm_unacct_memory(VM_AD_DEFAULT, p->pages);
 	else {
 		err = -ENOMEM;
 		swap_list_unlock();
diff -upN reference/security/commoncap.c current/security/commoncap.c
--- reference/security/commoncap.c	2004-03-25 15:03:32.000000000 +0000
+++ current/security/commoncap.c	2004-03-25 15:03:32.000000000 +0000
@@ -312,14 +312,14 @@ int cap_vm_enough_memory(int domain, lon
 {
 	unsigned long free, allowed;
 
+	vm_acct_memory(domain, pages);
+
 	/* We only account for the default memory domain, assume overcommit
 	 * for all others.
 	 */
 	if (domain != VM_AD_DEFAULT)
 		return 0;
 
-	vm_acct_memory(pages);
-
         /*
 	 * Sometimes we want to use more memory than we have
 	 */
@@ -360,17 +360,17 @@ int cap_vm_enough_memory(int domain, lon
 
 		if (free > pages)
 			return 0;
-		vm_unacct_memory(pages);
+		vm_unacct_memory(domain, pages);
 		return -ENOMEM;
 	}
 
 	allowed = totalram_pages * sysctl_overcommit_ratio / 100;
 	allowed += total_swap_pages;
 
-	if (atomic_read(&vm_committed_space) < allowed)
+	if (atomic_read(&vm_committed_space[domain]) < allowed)
 		return 0;
 
-	vm_unacct_memory(pages);
+	vm_unacct_memory(domain, pages);
 
 	return -ENOMEM;
 }
diff -upN reference/security/dummy.c current/security/dummy.c
--- reference/security/dummy.c	2004-03-25 15:03:32.000000000 +0000
+++ current/security/dummy.c	2004-03-25 15:03:32.000000000 +0000
@@ -113,14 +113,14 @@ static int dummy_vm_enough_memory(int do
 {
 	unsigned long free, allowed;
 
+	vm_acct_memory(domain, pages);
+
 	/* We only account for the default memory domain, assume overcommit
 	 * for all others.
 	 */
 	if (domain != VM_AD_DEFAULT)
 		return 0;
 
-	vm_acct_memory(pages);
-
         /*
 	 * Sometimes we want to use more memory than we have
 	 */
@@ -148,17 +148,17 @@ static int dummy_vm_enough_memory(int do
 
 		if (free > pages)
 			return 0;
-		vm_unacct_memory(pages);
+		vm_unacct_memory(domain, pages);
 		return -ENOMEM;
 	}
 
 	allowed = totalram_pages * sysctl_overcommit_ratio / 100;
 	allowed += total_swap_pages;
 
-	if (atomic_read(&vm_committed_space) < allowed)
+	if (atomic_read(&vm_committed_space[domain]) < allowed)
 		return 0;
 
-	vm_unacct_memory(pages);
+	vm_unacct_memory(domain, pages);
 
 	return -ENOMEM;
 }
diff -upN reference/security/selinux/hooks.c current/security/selinux/hooks.c
--- reference/security/selinux/hooks.c	2004-03-25 15:03:32.000000000 +0000
+++ current/security/selinux/hooks.c	2004-03-25 15:03:32.000000000 +0000
@@ -1502,14 +1502,14 @@ static int selinux_vm_enough_memory(int 
 	int rc;
 	struct task_security_struct *tsec = current->security;
 
+	vm_acct_memory(domain, pages);
+
 	/* We only account for the default memory domain, assume overcommit
 	 * for all others.
 	 */
 	if (domain != VM_AD_DEFAULT)
 		return 0;
 
-	vm_acct_memory(pages);
-
         /*
 	 * Sometimes we want to use more memory than we have
 	 */
@@ -1546,17 +1546,17 @@ static int selinux_vm_enough_memory(int 
 
 		if (free > pages)
 			return 0;
-		vm_unacct_memory(pages);
+		vm_unacct_memory(domain, pages);
 		return -ENOMEM;
 	}
 
 	allowed = totalram_pages * sysctl_overcommit_ratio / 100;
 	allowed += total_swap_pages;
 
-	if (atomic_read(&vm_committed_space) < allowed)
+	if (atomic_read(&vm_committed_space[domain]) < allowed)
 		return 0;
 
-	vm_unacct_memory(pages);
+	vm_unacct_memory(domain, pages);
 
 	return -ENOMEM;
 }

