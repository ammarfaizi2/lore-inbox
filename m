Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318065AbSGYA1B>; Wed, 24 Jul 2002 20:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318097AbSGYA1B>; Wed, 24 Jul 2002 20:27:01 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:25081 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S318065AbSGYA0j>; Wed, 24 Jul 2002 20:26:39 -0400
Subject: [PATCH] 2.5.28: VM strict overcommit
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com, akpm@zip.com.au
Cc: riel@conectiva.com.br, linux-kernel@vger.kernel.org, alan@redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 24 Jul 2002 17:29:43 -0700
Message-Id: <1027556984.3581.1643.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew and Linus,

Here again is a port of Alan's VM strict overcommit to the 2.5 kernel,
with the new policy design Alan and I discussed.

This adds strict address-space accounting to enforce address-space
limits and consequently never OOM.  All memory failures should be pushed
to the allocation routines.

Obviously overcommit is preferred for most so the default is the
standard behavior.  Strict overcommit is controllable via sysctl.  See
the included documentation.

I would like to get this into 2.5 to see more testing and provide a base
for some of the shmem / overcommit fixes Hugh Dickins as been working
on.  In the default configuration, behavior should be unchanged.

Patch is against 2.5.28, please apply.

	Robert Love

diff -urN linux-2.5.28/Documentation/sysctl/vm.txt linux/Documentation/sysctl/vm.txt
--- linux-2.5.28/Documentation/sysctl/vm.txt	Wed Jul 24 14:03:30 2002
+++ linux/Documentation/sysctl/vm.txt	Wed Jul 24 16:22:30 2002
@@ -78,7 +78,21 @@
 programs that malloc() huge amounts of memory "just-in-case"
 and don't use much of it.
 
-Look at: mm/mmap.c::vm_enough_memory() for more information.
+A value  of 2 introduces a new "strict overcommit" policy
+that attempts to prevent any overcommit of memory.
+
+The default value is 0.
+
+See Documentation/vm/overcommit-accounting and
+mm/mmap.c::vm_enough_memory() for more information.
+
+==============================================================
+
+overcommit_ratio:
+
+When overcommit_memory is set to 2, the committed address
+space is not permitted to exceed swap plus this percentage
+of physical RAM.  See above.
 
 ==============================================================
 
diff -urN linux-2.5.28/Documentation/vm/overcommit-accounting linux/Documentation/vm/overcommit-accounting
--- linux-2.5.28/Documentation/vm/overcommit-accounting	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/vm/overcommit-accounting	Wed Jul 24 16:22:30 2002
@@ -0,0 +1,70 @@
+The Linux kernel supports four overcommit handling modes
+
+0	-	Heuristic overcommit handling. Obvious overcommits of
+		address space are refused. Used for a typical system. It
+		ensures a seriously wild allocation fails while allowing
+		overcommit to reduce swap usage.  This is the default.
+
+1	-	No overcommit handling. Appropriate for some scientific
+		applications.
+
+2	-	(NEW) strict overcommit. The total address space commit
+		for the system is not permitted to exceed swap + a
+		configurable percentage (default is 50) of physical RAM.
+		Depending on the percentage you use, in most situations
+		this means a process will not be killed while accessing
+		pages but will receive errors on memory allocation as
+		appropriate.
+
+The overcommit policy is set via the sysctl `vm.overcommit_memory'.
+
+The overcommit percentage is set via `vm.overcommit_ratio'.
+
+Gotchas
+-------
+
+The C language stack growth does an implicit mremap. If you want absolute
+guarantees and run close to the edge you MUST mmap your stack for the 
+largest size you think you will need. For typical stack usage is does
+not matter much but its a corner case if you really really care
+
+In mode 2 the MAP_NORESERVE flag is ignored. 
+
+
+How It Works
+------------
+
+The overcommit is based on the following rules
+
+For a file backed map
+	SHARED or READ only	-	0 cost (the file is the map not swap)
+
+	WRITABLE SHARED		-	size of mapping per instance
+
+For a direct map
+	SHARED or READ only	-	size of mapping
+	PRIVATE WRITEABLE	-	size of mapping per instance
+
+Additional accounting
+	Pages made writable copies by mmap
+	shmfs memory drawn from the same pool
+
+Status
+------
+
+o	We account mmap memory mappings
+o	We account mprotect changes in commit
+o	We account mremap changes in size
+o	We account brk
+o	We account munmap
+o	We report the commit status in /proc
+o	Account and check on fork
+o	Review stack handling/building on exec
+o	SHMfs accounting
+o	Implement actual limit enforcement
+
+To Do
+-----
+o	Account ptrace pages (this is hard)
+o	Account for shared anonymous mappings properly
+	- right now we account them per instance
diff -urN linux-2.5.28/fs/exec.c linux/fs/exec.c
--- linux-2.5.28/fs/exec.c	Wed Jul 24 14:03:25 2002
+++ linux/fs/exec.c	Wed Jul 24 16:22:30 2002
@@ -313,8 +313,13 @@
 
 	mpnt = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 	if (!mpnt) 
-		return -ENOMEM; 
-	
+		return -ENOMEM;
+
+	if (!vm_enough_memory((STACK_TOP - (PAGE_MASK & (unsigned long) bprm->p))>>PAGE_SHIFT)) {
+		kmem_cache_free(vm_area_cachep, mpnt);
+		return -ENOMEM;
+	}
+
 	down_write(&current->mm->mmap_sem);
 	{
 		mpnt->vm_mm = current->mm;
diff -urN linux-2.5.28/fs/proc/proc_misc.c linux/fs/proc/proc_misc.c
--- linux-2.5.28/fs/proc/proc_misc.c	Wed Jul 24 14:03:21 2002
+++ linux/fs/proc/proc_misc.c	Wed Jul 24 16:22:30 2002
@@ -126,11 +126,13 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
+extern atomic_t vm_committed_space;
+
 static int meminfo_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
 	struct sysinfo i;
-	int len;
+	int len, committed;
 	struct page_state ps;
 
 	get_page_state(&ps);
@@ -140,6 +142,7 @@
 #define K(x) ((x) << (PAGE_SHIFT - 10))
 	si_meminfo(&i);
 	si_swapinfo(&i);
+	committed = atomic_read(&vm_committed_space);
 
 	/*
 	 * Tagged format, for easy grepping and expansion.
@@ -160,6 +163,7 @@
 		"SwapFree:     %8lu kB\n"
 		"Dirty:        %8lu kB\n"
 		"Writeback:    %8lu kB\n"
+		"Committed_AS: %8u kB\n"
 		"PageTables:   %8lu kB\n"
 		"PteChainTot:  %8lu kB\n"
 		"PteChainUsed: %8lu kB\n",
@@ -178,6 +182,7 @@
 		K(i.freeswap),
 		K(ps.nr_dirty),
 		K(ps.nr_writeback),
+		K(committed),
 		K(ps.nr_page_table_pages),
 		K(ps.nr_pte_chain_pages),
 		ps.used_pte_chains_bytes >> 10
diff -urN linux-2.5.28/include/linux/mm.h linux/include/linux/mm.h
--- linux-2.5.28/include/linux/mm.h	Wed Jul 24 14:03:18 2002
+++ linux/include/linux/mm.h	Wed Jul 24 16:22:30 2002
@@ -103,8 +103,9 @@
 #define VM_DONTCOPY	0x00020000      /* Do not copy this vma on fork */
 #define VM_DONTEXPAND	0x00040000	/* Cannot expand with mremap() */
 #define VM_RESERVED	0x00080000	/* Don't unmap it from swap_out */
+#define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
 
-#define VM_STACK_FLAGS	(0x00000100 | VM_DATA_DEFAULT_FLAGS)
+#define VM_STACK_FLAGS	(0x00000100 | VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT)
 
 #define VM_READHINTMASK			(VM_SEQ_READ | VM_RAND_READ)
 #define VM_ClearReadHint(v)		(v)->vm_flags &= ~VM_READHINTMASK
@@ -430,7 +431,7 @@
 	return ret;
 }
 
-extern int do_munmap(struct mm_struct *, unsigned long, size_t);
+extern int do_munmap(struct mm_struct *, unsigned long, size_t, int);
 
 extern unsigned long do_brk(unsigned long, unsigned long);
 
@@ -472,31 +473,8 @@
 void page_cache_readaround(struct file *file, unsigned long offset);
 void handle_ra_miss(struct file *file);
 
-/* vma is the first one with  address < vma->vm_end,
- * and even  address < vma->vm_start. Have to extend vma. */
-static inline int expand_stack(struct vm_area_struct * vma, unsigned long address)
-{
-	unsigned long grow;
-
-	/*
-	 * vma->vm_start/vm_end cannot change under us because the caller is required
-	 * to hold the mmap_sem in write mode. We need to get the spinlock only
-	 * before relocating the vma range ourself.
-	 */
-	address &= PAGE_MASK;
-	grow = (vma->vm_start - address) >> PAGE_SHIFT;
-	if (vma->vm_end - address > current->rlim[RLIMIT_STACK].rlim_cur ||
-	    ((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) > current->rlim[RLIMIT_AS].rlim_cur)
-		return -ENOMEM;
-	spin_lock(&vma->vm_mm->page_table_lock);
-	vma->vm_start = address;
-	vma->vm_pgoff -= grow;
-	vma->vm_mm->total_vm += grow;
-	if (vma->vm_flags & VM_LOCKED)
-		vma->vm_mm->locked_vm += grow;
-	spin_unlock(&vma->vm_mm->page_table_lock);
-	return 0;
-}
+/* Do stack extension */
+extern int expand_stack(struct vm_area_struct * vma, unsigned long address);
 
 /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
 extern struct vm_area_struct * find_vma(struct mm_struct * mm, unsigned long addr);
diff -urN linux-2.5.28/include/linux/mman.h linux/include/linux/mman.h
--- linux-2.5.28/include/linux/mman.h	Wed Jul 24 14:03:20 2002
+++ linux/include/linux/mman.h	Wed Jul 24 16:22:30 2002
@@ -6,4 +6,7 @@
 #define MREMAP_MAYMOVE	1
 #define MREMAP_FIXED	2
 
+extern int vm_enough_memory(long pages);
+extern void vm_unacct_memory(long pages);
+
 #endif /* _LINUX_MMAN_H */
diff -urN linux-2.5.28/include/linux/sysctl.h linux/include/linux/sysctl.h
--- linux-2.5.28/include/linux/sysctl.h	Wed Jul 24 14:03:17 2002
+++ linux/include/linux/sysctl.h	Wed Jul 24 16:22:30 2002
@@ -149,6 +149,7 @@
 	VM_DIRTY_WB_CS=14,	/* dirty_writeback_centisecs */
 	VM_DIRTY_EXPIRE_CS=15,	/* dirty_expire_centisecs */
 	VM_NR_PDFLUSH_THREADS=16, /* nr_pdflush_threads */
+	VM_OVERCOMMIT_RATIO=17, /* percent of RAM to allow overcommit in */
 };
 

diff -urN linux-2.5.28/ipc/shm.c linux/ipc/shm.c
--- linux-2.5.28/ipc/shm.c	Wed Jul 24 14:03:28 2002
+++ linux/ipc/shm.c	Wed Jul 24 16:22:30 2002
@@ -671,7 +671,7 @@
 		shmdnext = shmd->vm_next;
 		if (shmd->vm_ops == &shm_vm_ops
 		    && shmd->vm_start - (shmd->vm_pgoff << PAGE_SHIFT) == (ulong) shmaddr) {
-			do_munmap(mm, shmd->vm_start, shmd->vm_end - shmd->vm_start);
+			do_munmap(mm, shmd->vm_start, shmd->vm_end - shmd->vm_start, 1);
 			retval = 0;
 		}
 	}
diff -urN linux-2.5.28/kernel/fork.c linux/kernel/fork.c
--- linux-2.5.28/kernel/fork.c	Wed Jul 24 14:03:20 2002
+++ linux/kernel/fork.c	Wed Jul 24 16:22:30 2002
@@ -23,6 +23,7 @@
 #include <linux/personality.h>
 #include <linux/file.h>
 #include <linux/binfmts.h>
+#include <linux/mman.h>
 #include <linux/fs.h>
 #include <linux/security.h>
 
@@ -181,6 +182,7 @@
 {
 	struct vm_area_struct * mpnt, *tmp, **pprev;
 	int retval;
+	unsigned long charge = 0;
 
 	flush_cache_mm(current->mm);
 	mm->locked_vm = 0;
@@ -208,6 +210,17 @@
 		retval = -ENOMEM;
 		if(mpnt->vm_flags & VM_DONTCOPY)
 			continue;
+
+		/*
+		 * FIXME: shared writable map accounting should be one off
+		 */
+		if (mpnt->vm_flags & VM_ACCOUNT) {
+			unsigned int len = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
+			if (!vm_enough_memory(len))
+				goto fail_nomem;
+			charge += len;
+		}
+
 		tmp = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 		if (!tmp)
 			goto fail_nomem;
@@ -248,9 +261,12 @@
 	retval = 0;
 	build_mmap_rb(mm);
 
-fail_nomem:
+out:
 	flush_tlb_mm(current->mm);
 	return retval;
+fail_nomem:
+	vm_unacct_memory(charge);
+	goto out;
 }
 
 spinlock_t mmlist_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
diff -urN linux-2.5.28/kernel/sysctl.c linux/kernel/sysctl.c
--- linux-2.5.28/kernel/sysctl.c	Wed Jul 24 14:03:20 2002
+++ linux/kernel/sysctl.c	Wed Jul 24 16:22:30 2002
@@ -45,6 +45,7 @@
 extern int panic_timeout;
 extern int C_A_D;
 extern int sysctl_overcommit_memory;
+extern int sysctl_overcommit_ratio;
 extern int max_threads;
 extern atomic_t nr_queued_signals;
 extern int max_queued_signals;
@@ -268,6 +269,9 @@
 static ctl_table vm_table[] = {
 	{VM_OVERCOMMIT_MEMORY, "overcommit_memory", &sysctl_overcommit_memory,
 	 sizeof(sysctl_overcommit_memory), 0644, NULL, &proc_dointvec},
+	{VM_OVERCOMMIT_RATIO, "overcommit_ratio",
+	 &sysctl_overcommit_ratio, sizeof(sysctl_overcommit_ratio), 0644,
+	 NULL, &proc_dointvec},
 	{VM_PAGERDAEMON, "kswapd",
 	 &pager_daemon, sizeof(pager_daemon_t), 0644, NULL, &proc_dointvec},
 	{VM_PAGE_CLUSTER, "page-cluster", 
diff -urN linux-2.5.28/mm/mmap.c linux/mm/mmap.c
--- linux-2.5.28/mm/mmap.c	Wed Jul 24 14:03:19 2002
+++ linux/mm/mmap.c	Wed Jul 24 16:22:30 2002
@@ -1,8 +1,11 @@
 /*
- *	linux/mm/mmap.c
+ * mm/mmap.c
  *
  * Written by obz.
+ *
+ * Address space accounting code	<alan@redhat.com>
  */
+
 #include <linux/slab.h>
 #include <linux/shm.h>
 #include <linux/mman.h>
@@ -48,52 +51,91 @@
 	__S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
 };
 
-int sysctl_overcommit_memory;
+int sysctl_overcommit_memory = 0;	/* default is heuristic overcommit */
+int sysctl_overcommit_ratio = 50;	/* default is 50% */
+atomic_t vm_committed_space = ATOMIC_INIT(0);
 
-/* Check that a process has enough memory to allocate a
- * new virtual mapping.
+/*
+ * Check that a process has enough memory to allocate a new virtual
+ * mapping. 1 means there is enough memory for the allocation to
+ * succeed and 0 implies there is not.
+ *
+ * We currently support three overcommit policies, which are set via the
+ * vm.overcommit_memory sysctl.  See Documentation/vm/overcommit-acounting
+ *
+ * Strict overcommit modes added 2002 Feb 26 by Alan Cox.
+ * Additional code 2002 Jul 20 by Robert Love.
  */
 int vm_enough_memory(long pages)
 {
-	/* Stupid algorithm to decide if we have enough memory: while
-	 * simple, it hopefully works in most obvious cases.. Easy to
-	 * fool it, but this should catch most mistakes.
-	 */
-	/* 23/11/98 NJC: Somewhat less stupid version of algorithm,
-	 * which tries to do "TheRightThing".  Instead of using half of
-	 * (buffers+cache), use the minimum values.  Allow an extra 2%
-	 * of num_physpages for safety margin.
-	 */
+	unsigned long free, allowed;
+	struct sysinfo i;
 
-	unsigned long free;
-	
-        /* Sometimes we want to use more memory than we have. */
-	if (sysctl_overcommit_memory)
-	    return 1;
-
-	/* The page cache contains buffer pages these days.. */
-	free = get_page_cache_size();
-	free += nr_free_pages();
-	free += nr_swap_pages;
+	atomic_add(pages, &vm_committed_space);
 
-	/*
-	 * This double-counts: the nrpages are both in the page-cache
-	 * and in the swapper space. At the same time, this compensates
-	 * for the swap-space over-allocation (ie "nr_swap_pages" being
-	 * too small.
+        /*
+	 * Sometimes we want to use more memory than we have
 	 */
-	free += swapper_space.nrpages;
+	if (sysctl_overcommit_memory == 1)
+		return 1;
+
+	if (sysctl_overcommit_memory == 0) {
+		free = get_page_cache_size();
+		free += nr_free_pages();
+		free += nr_swap_pages;
+
+		/*
+		 * This double-counts: the nrpages are both in the
+		 * page-cache and in the swapper space. At the same time,
+		 * this compensates for the swap-space over-allocation
+		 * (ie "nr_swap_pages" being too small).
+		 */
+		free += swapper_space.nrpages;
+
+		/*
+		 * The code below doesn't account for free space in the
+		 * inode and dentry slab cache, slab cache fragmentation,
+		 * inodes and dentries which will become freeable under
+		 * VM load, etc. Lets just hope all these (complex)
+		 * factors balance out...
+		 */
+		free += (dentry_stat.nr_unused * sizeof(struct dentry)) >>
+			PAGE_SHIFT;
+		free += (inodes_stat.nr_unused * sizeof(struct inode)) >>
+			PAGE_SHIFT;
+
+		if (free > pages)
+			return 1;
+		atomic_sub(pages, &vm_committed_space);
+		return 0;
+	}
 
 	/*
-	 * The code below doesn't account for free space in the inode
-	 * and dentry slab cache, slab cache fragmentation, inodes and
-	 * dentries which will become freeable under VM load, etc.
-	 * Lets just hope all these (complex) factors balance out...
+	 * FIXME: need to add arch hooks to get the bits we need
+	 * without this higher overhead crap
 	 */
-	free += (dentry_stat.nr_unused * sizeof(struct dentry)) >> PAGE_SHIFT;
-	free += (inodes_stat.nr_unused * sizeof(struct inode)) >> PAGE_SHIFT;
+	si_meminfo(&i);
+	allowed = i.totalram * sysctl_overcommit_ratio / 100;
+	allowed += total_swap_pages;
+
+	if (atomic_read(&vm_committed_space) < allowed)
+		return 1;
+
+	atomic_sub(pages, &vm_committed_space);
+
+	return 0;
+}
 
-	return free > pages;
+void inline vm_unacct_memory(long pages)
+{	
+	atomic_sub(pages, &vm_committed_space);
+}
+
+void vm_unacct_vma(struct vm_area_struct *vma)
+{
+	int len = vma->vm_end - vma->vm_start;
+	if (vma->vm_flags & VM_ACCOUNT)
+		vm_unacct_memory(len >> PAGE_SHIFT);
 }
 
 /* Remove one vm structure from the inode's i_mapping address space. */
@@ -162,7 +204,7 @@
 
 	/* Always allow shrinking brk. */
 	if (brk <= mm->brk) {
-		if (!do_munmap(mm, newbrk, oldbrk-newbrk))
+		if (!do_munmap(mm, newbrk, oldbrk-newbrk, 1))
 			goto set_brk;
 		goto out;
 	}
@@ -176,10 +218,6 @@
 	if (find_vma_intersection(mm, oldbrk, newbrk+PAGE_SIZE))
 		goto out;
 
-	/* Check if we have enough memory.. */
-	if (!vm_enough_memory((newbrk-oldbrk) >> PAGE_SHIFT))
-		goto out;
-
 	/* Ok, looks good - let it rip. */
 	if (do_brk(oldbrk, newbrk-oldbrk) != oldbrk)
 		goto out;
@@ -385,8 +423,9 @@
 	return 0;
 }
 
-unsigned long do_mmap_pgoff(struct file * file, unsigned long addr, unsigned long len,
-	unsigned long prot, unsigned long flags, unsigned long pgoff)
+unsigned long do_mmap_pgoff(struct file * file, unsigned long addr,
+			unsigned long len, unsigned long prot,
+			unsigned long flags, unsigned long pgoff)
 {
 	struct mm_struct * mm = current->mm;
 	struct vm_area_struct * vma, * prev;
@@ -394,6 +433,7 @@
 	int correct_wcount = 0;
 	int error;
 	rb_node_t ** rb_link, * rb_parent;
+	unsigned long charged = 0;
 
 	if (file && (!file->f_op || !file->f_op->mmap))
 		return -ENODEV;
@@ -480,7 +520,7 @@
 munmap_back:
 	vma = find_vma_prepare(mm, addr, &prev, &rb_link, &rb_parent);
 	if (vma && vma->vm_start < addr + len) {
-		if (do_munmap(mm, addr, len))
+		if (do_munmap(mm, addr, len, 1))
 			return -ENOMEM;
 		goto munmap_back;
 	}
@@ -490,11 +530,17 @@
 	    > current->rlim[RLIMIT_AS].rlim_cur)
 		return -ENOMEM;
 
+	if (sysctl_overcommit_memory > 1)
+		vm_flags &= ~MAP_NORESERVE;
+
 	/* Private writable mapping? Check memory availability.. */
-	if ((vm_flags & (VM_SHARED | VM_WRITE)) == VM_WRITE &&
-	    !(flags & MAP_NORESERVE)				 &&
-	    !vm_enough_memory(len >> PAGE_SHIFT))
-		return -ENOMEM;
+	if ((((vm_flags & (VM_SHARED | VM_WRITE)) == VM_WRITE) ||
+			(file == NULL)) && !(flags & MAP_NORESERVE)) {
+		charged = len >> PAGE_SHIFT;
+		if (!vm_enough_memory(charged))
+			return -ENOMEM;
+		vm_flags |= VM_ACCOUNT;
+	}
 
 	/* Can we just expand an old anonymous mapping? */
 	if (!file && !(vm_flags & VM_SHARED) && rb_parent)
@@ -506,8 +552,9 @@
 	 * not unmapped, but the maps are removed from the list.
 	 */
 	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+	error = -ENOMEM;
 	if (!vma)
-		return -ENOMEM;
+		goto unacct_error;
 
 	vma->vm_mm = mm;
 	vma->vm_start = addr;
@@ -570,6 +617,9 @@
 	zap_page_range(vma, vma->vm_start, vma->vm_end - vma->vm_start);
 free_vma:
 	kmem_cache_free(vm_area_cachep, vma);
+unacct_error:
+	if (charged)
+		vm_unacct_memory(charged);
 	return error;
 }
 
@@ -699,6 +749,45 @@
 	return prev ? prev->vm_next : vma;
 }
 
+/*
+ * vma is the first one with  address < vma->vm_end,
+ * and even address < vma->vm_start. Have to extend vma.
+ */
+int expand_stack(struct vm_area_struct * vma, unsigned long address)
+{
+	unsigned long grow;
+
+	/*
+	 * vma->vm_start/vm_end cannot change under us because the caller
+	 * is required to hold the mmap_sem in write mode. We need to get
+	 * the spinlock only before relocating the vma range ourself.
+	 */
+	address &= PAGE_MASK;
+ 	spin_lock(&vma->vm_mm->page_table_lock);
+	grow = (vma->vm_start - address) >> PAGE_SHIFT;
+
+	/* Overcommit.. */
+	if(!vm_enough_memory(grow)) {
+		spin_unlock(&vma->vm_mm->page_table_lock);
+		return -ENOMEM;
+	}
+	
+	if (vma->vm_end - address > current->rlim[RLIMIT_STACK].rlim_cur ||
+			((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) >
+			current->rlim[RLIMIT_AS].rlim_cur) {
+		spin_unlock(&vma->vm_mm->page_table_lock);
+		vm_unacct_memory(grow);
+		return -ENOMEM;
+	}
+	vma->vm_start = address;
+	vma->vm_pgoff -= grow;
+	vma->vm_mm->total_vm += grow;
+	if (vma->vm_flags & VM_LOCKED)
+		vma->vm_mm->locked_vm += grow;
+	spin_unlock(&vma->vm_mm->page_table_lock);
+	return 0;
+}
+
 #ifdef ARCH_STACK_GROWSUP
 struct vm_area_struct * find_extend_vma(struct mm_struct * mm, unsigned long addr)
 {
@@ -824,7 +913,6 @@
 	kmem_cache_free(vm_area_cachep, area);
 }
 
-
 /*
  * Update the VMA and inode share lists.
  *
@@ -851,19 +939,25 @@
 	struct vm_area_struct *mpnt,
 	struct vm_area_struct *prev,
 	unsigned long start,
-	unsigned long end)
+	unsigned long end,
+	int acct)
 {
 	mmu_gather_t *tlb;
 
 	tlb = tlb_gather_mmu(mm, 0);
 
 	do {
-		unsigned long from, to;
+		unsigned long from, to, len;
 
 		from = start < mpnt->vm_start ? mpnt->vm_start : start;
 		to = end > mpnt->vm_end ? mpnt->vm_end : end;
 
 		unmap_page_range(tlb, mpnt, from, to);
+
+		if (acct && (mpnt->vm_flags & VM_ACCOUNT)) {
+			len = to - from;
+			vm_unacct_memory(len >> PAGE_SHIFT);
+		}
 	} while ((mpnt = mpnt->vm_next) != NULL);
 
 	free_pgtables(tlb, prev, start, end);
@@ -941,7 +1035,7 @@
  * work.  This now handles partial unmappings.
  * Jeremy Fitzhardine <jeremy@sw.oz.au>
  */
-int do_munmap(struct mm_struct *mm, unsigned long start, size_t len)
+int do_munmap(struct mm_struct *mm, unsigned long start, size_t len, int acct)
 {
 	unsigned long end;
 	struct vm_area_struct *mpnt, *prev, *last;
@@ -985,7 +1079,7 @@
 	 */
 	spin_lock(&mm->page_table_lock);
 	mpnt = touched_by_munmap(mm, mpnt, prev, end);
-	unmap_region(mm, mpnt, prev, start, end);
+	unmap_region(mm, mpnt, prev, start, end, acct);
 	spin_unlock(&mm->page_table_lock);
 
 	/* Fix up all other VM information */
@@ -1000,7 +1094,7 @@
 	struct mm_struct *mm = current->mm;
 
 	down_write(&mm->mmap_sem);
-	ret = do_munmap(mm, addr, len);
+	ret = do_munmap(mm, addr, len, 1);
 	up_write(&mm->mmap_sem);
 	return ret;
 }
@@ -1037,7 +1131,7 @@
  munmap_back:
 	vma = find_vma_prepare(mm, addr, &prev, &rb_link, &rb_parent);
 	if (vma && vma->vm_start < addr + len) {
-		if (do_munmap(mm, addr, len))
+		if (do_munmap(mm, addr, len, 1))
 			return -ENOMEM;
 		goto munmap_back;
 	}
@@ -1053,7 +1147,7 @@
 	if (!vm_enough_memory(len >> PAGE_SHIFT))
 		return -ENOMEM;
 
-	flags = VM_DATA_DEFAULT_FLAGS | mm->def_flags;
+	flags = VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
 
 	/* Can we just expand an old anonymous mapping? */
 	if (rb_parent && vma_merge(mm, prev, rb_parent, addr, addr + len, flags))
@@ -1063,8 +1157,10 @@
 	 * create a vma struct for an anonymous mapping
 	 */
 	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
-	if (!vma)
+	if (!vma) {
+		vm_unacct_memory(len >> PAGE_SHIFT);
 		return -ENOMEM;
+	}
 
 	vma->vm_mm = mm;
 	vma->vm_start = addr;
@@ -1120,6 +1216,13 @@
 		unsigned long start = mpnt->vm_start;
 		unsigned long end = mpnt->vm_end;
 
+		/*
+		 * If the VMA has been charged for, account for its
+		 * removal
+		 */
+		if (mpnt->vm_flags & VM_ACCOUNT)
+			vm_unacct_vma(mpnt);
+
 		mm->map_count--;
 		unmap_page_range(tlb, mpnt, start, end);
 		mpnt = mpnt->vm_next;
diff -urN linux-2.5.28/mm/mprotect.c linux/mm/mprotect.c
--- linux-2.5.28/mm/mprotect.c	Wed Jul 24 14:03:26 2002
+++ linux/mm/mprotect.c	Wed Jul 24 16:22:30 2002
@@ -1,7 +1,10 @@
 /*
- *	linux/mm/mprotect.c
+ *  mm/mprotect.c
  *
  *  (C) Copyright 1994 Linus Torvalds
+ *
+ *  Address space accounting code	<alan@redhat.com>
+ *  (C) Copyright 2002 Red Hat Inc, All Rights Reserved
  */
 #include <linux/mm.h>
 #include <linux/slab.h>
@@ -247,6 +250,7 @@
 {
 	pgprot_t newprot;
 	int error;
+	unsigned long charged = 0;
 
 	if (newflags == vma->vm_flags) {
 		*pprev = vma;
@@ -263,9 +267,18 @@
 	else
 		error = mprotect_fixup_middle(vma, pprev, start, end, newflags, newprot);
 
-	if (error)
+	if (error) {
+		if (newflags & PROT_WRITE)
+			vm_unacct_memory(charged);
 		return error;
+	}
 
+	/*
+	 * Delayed accounting for reduction of memory use - done last to
+	 * avoid allocation races
+	 */
+	if (charged && !(newflags & PROT_WRITE))
+		vm_unacct_memory(charged);
 	change_protection(vma, start, end, newprot);
 	return 0;
 }
diff -urN linux-2.5.28/mm/mremap.c linux/mm/mremap.c
--- linux-2.5.28/mm/mremap.c	Wed Jul 24 14:03:28 2002
+++ linux/mm/mremap.c	Wed Jul 24 16:22:30 2002
@@ -1,7 +1,10 @@
 /*
- *	linux/mm/remap.c
+ *	mm/remap.c
  *
  *	(C) Copyright 1996 Linus Torvalds
+ *
+ *	Address space accounting code	<alan@redhat.com>
+ *	(C) Copyright 2002 Red Hat Inc, All Rights Reserved
  */
 
 #include <linux/mm.h>
@@ -18,8 +21,6 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
-extern int vm_enough_memory(long pages);
-
 static inline pte_t *get_one_pte_map_nested(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t * pgd;
@@ -209,7 +210,11 @@
 				new_vma->vm_ops->open(new_vma);
 			insert_vm_struct(current->mm, new_vma);
 		}
-		do_munmap(current->mm, addr, old_len);
+		/*
+		 * The old VMA has been accounted for,
+		 * don't double account
+		 */
+		do_munmap(current->mm, addr, old_len, 0);
 		current->mm->total_vm += new_len >> PAGE_SHIFT;
 		if (new_vma->vm_flags & VM_LOCKED) {
 			current->mm->locked_vm += new_len >> PAGE_SHIFT;
@@ -224,6 +229,8 @@
 	return -ENOMEM;
 }
 
+extern int sysctl_overcommit_memory;	/* FIXME!! */
+
 /*
  * Expand (or shrink) an existing mapping, potentially moving it at the
  * same time (controlled by the MREMAP_MAYMOVE flag and available VM space)
@@ -237,6 +244,7 @@
 {
 	struct vm_area_struct *vma;
 	unsigned long ret = -EINVAL;
+	unsigned long charged = 0;
 
 	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE))
 		goto out;
@@ -266,16 +274,17 @@
 		if ((addr <= new_addr) && (addr+old_len) > new_addr)
 			goto out;
 
-		do_munmap(current->mm, new_addr, new_len);
+		do_munmap(current->mm, new_addr, new_len, 1);
 	}
 
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
+	 * do_munmap does all the needed commit accounting
 	 */
 	ret = addr;
 	if (old_len >= new_len) {
-		do_munmap(current->mm, addr+new_len, old_len - new_len);
+		do_munmap(current->mm, addr+new_len, old_len - new_len, 1);
 		if (!(flags & MREMAP_FIXED) || (new_addr == addr))
 			goto out;
 	}
@@ -305,11 +314,14 @@
 	if ((current->mm->total_vm << PAGE_SHIFT) + (new_len - old_len)
 	    > current->rlim[RLIMIT_AS].rlim_cur)
 		goto out;
-	/* Private writable mapping? Check memory availability.. */
-	if ((vma->vm_flags & (VM_SHARED | VM_WRITE)) == VM_WRITE &&
-	    !(flags & MAP_NORESERVE)				 &&
-	    !vm_enough_memory((new_len - old_len) >> PAGE_SHIFT))
-		goto out;
+
+	if (sysctl_overcommit_memory > 1)
+		flags &= ~MAP_NORESERVE;
+	if (vma->vm_flags & VM_ACCOUNT) {
+		charged = (new_len - old_len) >> PAGE_SHIFT;
+		if (!vm_enough_memory(charged))
+			goto out_nc;
+	}
 
 	/* old_len exactly to the end of the area..
 	 * And we're not relocating the area.
@@ -356,6 +368,9 @@
 		ret = move_vma(vma, addr, old_len, new_len, new_addr);
 	}
 out:
+	if (ret & ~PAGE_MASK)
+		vm_unacct_memory(charged);
+out_nc:
 	return ret;
 }
 
diff -urN linux-2.5.28/mm/shmem.c linux/mm/shmem.c
--- linux-2.5.28/mm/shmem.c	Wed Jul 24 14:03:26 2002
+++ linux/mm/shmem.c	Wed Jul 24 16:22:30 2002
@@ -5,7 +5,8 @@
  *		 2000 Transmeta Corp.
  *		 2000-2001 Christoph Rohland
  *		 2000-2001 SAP AG
- * 
+ *		 2002 Red Hat Inc.
+ *
  * This file is released under the GPL.
  */
 
@@ -21,6 +22,7 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
+#include <linux/mman.h>
 #include <linux/file.h>
 #include <linux/swap.h>
 #include <linux/pagemap.h>
@@ -358,10 +360,38 @@
 	up(&info->sem);
 }
 
+static int shmem_notify_change(struct dentry * dentry, struct iattr *attr)
+{
+	struct inode *inode = dentry->d_inode;
+	int error;
+
+	if (attr->ia_valid & ATTR_SIZE) {
+		/*
+	 	 * Account swap file usage based on new file size	
+	 	 */
+		long change = (attr->ia_size>>PAGE_SHIFT) - (inode->i_size >> PAGE_SHIFT);
+
+		if (attr->ia_size > inode->i_size) {
+			if (!vm_enough_memory(change))
+				return -ENOMEM;
+		} else
+			vm_unacct_memory(-change);
+	}
+
+	error = inode_change_ok(inode, attr);
+	if (!error)
+		error = inode_setattr(inode, attr);
+
+	return error;
+}
+
+
 static void shmem_delete_inode(struct inode * inode)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 
+	vm_unacct_memory((inode->i_size) >> PAGE_SHIFT);
+
 	inode->i_size = 0;
 	if (inode->i_op->truncate == shmem_truncate){ 
 		spin_lock (&shmem_ilock);
@@ -824,6 +854,7 @@
 	unsigned long	written;
 	long		status;
 	int		err;
+	loff_t		maxpos;
 
 	if ((ssize_t) count < 0)
 		return -EINVAL;
@@ -836,12 +867,12 @@
 	pos = *ppos;
 	err = -EINVAL;
 	if (pos < 0)
-		goto out;
+		goto out_nc;
 
 	err = file->f_error;
 	if (err) {
 		file->f_error = 0;
-		goto out;
+		goto out_nc;
 	}
 
 	written = 0;
@@ -849,6 +880,15 @@
 	if (file->f_flags & O_APPEND)
 		pos = inode->i_size;
 
+	maxpos = inode->i_size;
+	if (pos + count > inode->i_size) {
+		maxpos = pos + count;
+		if (!vm_enough_memory((maxpos - inode->i_size) >> PAGE_SHIFT)) {
+			err = -ENOMEM;
+			goto out_nc;
+		}
+	}
+
 	/*
 	 * Check whether we've reached the file size limit.
 	 */
@@ -938,6 +978,10 @@
 
 	err = written ? written : status;
 out:
+	/* Short writes give back address space */
+	if (inode->i_size != maxpos)
+		vm_unacct_memory((maxpos - inode->i_size) >> PAGE_SHIFT);
+out_nc:
 	up(&inode->i_sem);
 	return err;
 fail_write:
@@ -1477,6 +1521,7 @@
 
 static struct inode_operations shmem_inode_operations = {
 	truncate:	shmem_truncate,
+	setattr:	shmem_notify_change,
 };
 
 static struct inode_operations shmem_dir_inode_operations = {
@@ -1600,12 +1645,11 @@
  */
 struct file *shmem_file_setup(char * name, loff_t size)
 {
-	int error;
+	int error = -ENOMEM;
 	struct file *file;
 	struct inode * inode;
 	struct dentry *dentry, *root;
 	struct qstr this;
-	int vm_enough_memory(long pages);
 
 	if (size > (unsigned long long) SHMEM_MAX_BLOCKS << PAGE_CACHE_SHIFT)
 		return ERR_PTR(-EINVAL);
@@ -1619,7 +1663,7 @@
 	root = shm_mnt->mnt_root;
 	dentry = d_alloc(root, &this);
 	if (!dentry)
-		return ERR_PTR(-ENOMEM);
+		goto put_memory;
 
 	error = -ENFILE;
 	file = get_empty_filp();
@@ -1645,6 +1689,8 @@
 	put_filp(file);
 put_dentry:
 	dput (dentry);
+put_memory:
+	vm_unacct_memory((size) >> PAGE_CACHE_SHIFT);
 	return ERR_PTR(error);	
 }
 /*


