Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318934AbSG1HYv>; Sun, 28 Jul 2002 03:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318933AbSG1HXo>; Sun, 28 Jul 2002 03:23:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57861 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318924AbSG1HV2>;
	Sun, 28 Jul 2002 03:21:28 -0400
Message-ID: <3D439E37.647FBA85@zip.com.au>
Date: Sun, 28 Jul 2002 00:33:11 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 9/13] strict overcommit
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan's overcommit patch, brought to 2.5 by Robert Love.

Can't say I've tested its functionality at all, but it doesn't crash,
it has been in -ac and RH kernels for some time and I haven't observed
any of its functions on profiles.

"So what is strict VM overcommit?  We introduce new overcommit
 policies that attempt to never succeed an allocation that can not be
 fulfilled by the backing store and consequently never OOM.  This is
 achieved through strict accounting of the committed address space and
 a policy to allow/refuse allocations based on that accounting.

 In the strictest of modes, it should be impossible to allocate more
 memory than available and impossible to OOM.  All memory failures
 should be pushed down to the allocation routines -- malloc, mmap, etc.

 The new modes are available via sysctl (same as before).  See
 Documentation/vm/overcommit-accounting for more information."




 Documentation/sysctl/vm.txt            |   16 ++
 Documentation/vm/overcommit-accounting |   70 ++++++++++
 fs/exec.c                              |    9 +
 fs/proc/proc_misc.c                    |    7 -
 include/linux/mm.h                     |   32 ----
 include/linux/mman.h                   |    3 
 include/linux/sysctl.h                 |    1 
 ipc/shm.c                              |    2 
 kernel/fork.c                          |   18 ++
 kernel/sysctl.c                        |    4 
 mm/mmap.c                              |  219 ++++++++++++++++++++++++---------
 mm/mprotect.c                          |   17 ++
 mm/mremap.c                            |   37 +++--
 mm/shmem.c                             |   61 ++++++++-
 14 files changed, 386 insertions(+), 110 deletions(-)

--- 2.5.29/Documentation/sysctl/vm.txt~overcommit	Sat Jul 27 23:39:09 2002
+++ 2.5.29-akpm/Documentation/sysctl/vm.txt	Sat Jul 27 23:39:09 2002
@@ -78,7 +78,21 @@ This feature can be very useful because 
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
 
--- /dev/null	Thu Aug 30 13:30:55 2001
+++ 2.5.29-akpm/Documentation/vm/overcommit-accounting	Sat Jul 27 23:39:09 2002
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
--- 2.5.29/fs/exec.c~overcommit	Sat Jul 27 23:39:09 2002
+++ 2.5.29-akpm/fs/exec.c	Sat Jul 27 23:39:09 2002
@@ -313,8 +313,13 @@ int setup_arg_pages(struct linux_binprm 
 
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
--- 2.5.29/fs/proc/proc_misc.c~overcommit	Sat Jul 27 23:39:09 2002
+++ 2.5.29-akpm/fs/proc/proc_misc.c	Sat Jul 27 23:39:09 2002
@@ -126,11 +126,13 @@ static int uptime_read_proc(char *page, 
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
@@ -140,6 +142,7 @@ static int meminfo_read_proc(char *page,
 #define K(x) ((x) << (PAGE_SHIFT - 10))
 	si_meminfo(&i);
 	si_swapinfo(&i);
+	committed = atomic_read(&vm_committed_space);
 
 	/*
 	 * Tagged format, for easy grepping and expansion.
@@ -160,6 +163,7 @@ static int meminfo_read_proc(char *page,
 		"SwapFree:     %8lu kB\n"
 		"Dirty:        %8lu kB\n"
 		"Writeback:    %8lu kB\n"
+		"Committed_AS: %8u kB\n"
 		"PageTables:   %8lu kB\n"
 		"ReverseMaps:  %8lu\n",
 		K(i.totalram),
@@ -177,6 +181,7 @@ static int meminfo_read_proc(char *page,
 		K(i.freeswap),
 		K(ps.nr_dirty),
 		K(ps.nr_writeback),
+		K(committed),
 		K(ps.nr_page_table_pages),
 		ps.nr_reverse_maps
 		);
--- 2.5.29/include/linux/mman.h~overcommit	Sat Jul 27 23:39:09 2002
+++ 2.5.29-akpm/include/linux/mman.h	Sat Jul 27 23:39:09 2002
@@ -6,4 +6,7 @@
 #define MREMAP_MAYMOVE	1
 #define MREMAP_FIXED	2
 
+extern int vm_enough_memory(long pages);
+extern void vm_unacct_memory(long pages);
+
 #endif /* _LINUX_MMAN_H */
--- 2.5.29/include/linux/mm.h~overcommit	Sat Jul 27 23:39:09 2002
+++ 2.5.29-akpm/include/linux/mm.h	Sat Jul 27 23:39:09 2002
@@ -103,8 +103,9 @@ struct vm_area_struct {
 #define VM_DONTCOPY	0x00020000      /* Do not copy this vma on fork */
 #define VM_DONTEXPAND	0x00040000	/* Cannot expand with mremap() */
 #define VM_RESERVED	0x00080000	/* Don't unmap it from swap_out */
+#define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
 
-#define VM_STACK_FLAGS	(0x00000100 | VM_DATA_DEFAULT_FLAGS)
+#define VM_STACK_FLAGS	(0x00000100 | VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT)
 
 #define VM_READHINTMASK			(VM_SEQ_READ | VM_RAND_READ)
 #define VM_ClearReadHint(v)		(v)->vm_flags &= ~VM_READHINTMASK
@@ -429,7 +430,7 @@ out:
 	return ret;
 }
 
-extern int do_munmap(struct mm_struct *, unsigned long, size_t);
+extern int do_munmap(struct mm_struct *, unsigned long, size_t, int);
 
 extern unsigned long do_brk(unsigned long, unsigned long);
 
@@ -471,31 +472,8 @@ void page_cache_readahead(struct file *f
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
--- 2.5.29/include/linux/sysctl.h~overcommit	Sat Jul 27 23:39:09 2002
+++ 2.5.29-akpm/include/linux/sysctl.h	Sat Jul 27 23:39:09 2002
@@ -149,6 +149,7 @@ enum
 	VM_DIRTY_WB_CS=14,	/* dirty_writeback_centisecs */
 	VM_DIRTY_EXPIRE_CS=15,	/* dirty_expire_centisecs */
 	VM_NR_PDFLUSH_THREADS=16, /* nr_pdflush_threads */
+	VM_OVERCOMMIT_RATIO=17, /* percent of RAM to allow overcommit in */
 };
 
 
--- 2.5.29/ipc/shm.c~overcommit	Sat Jul 27 23:39:09 2002
+++ 2.5.29-akpm/ipc/shm.c	Sat Jul 27 23:39:09 2002
@@ -671,7 +671,7 @@ asmlinkage long sys_shmdt (char *shmaddr
 		shmdnext = shmd->vm_next;
 		if (shmd->vm_ops == &shm_vm_ops
 		    && shmd->vm_start - (shmd->vm_pgoff << PAGE_SHIFT) == (ulong) shmaddr) {
-			do_munmap(mm, shmd->vm_start, shmd->vm_end - shmd->vm_start);
+			do_munmap(mm, shmd->vm_start, shmd->vm_end - shmd->vm_start, 1);
 			retval = 0;
 		}
 	}
--- 2.5.29/kernel/fork.c~overcommit	Sat Jul 27 23:39:09 2002
+++ 2.5.29-akpm/kernel/fork.c	Sat Jul 27 23:39:09 2002
@@ -23,6 +23,7 @@
 #include <linux/personality.h>
 #include <linux/file.h>
 #include <linux/binfmts.h>
+#include <linux/mman.h>
 #include <linux/fs.h>
 #include <linux/security.h>
 
@@ -181,6 +182,7 @@ static inline int dup_mmap(struct mm_str
 {
 	struct vm_area_struct * mpnt, *tmp, **pprev;
 	int retval;
+	unsigned long charge = 0;
 
 	flush_cache_mm(current->mm);
 	mm->locked_vm = 0;
@@ -208,6 +210,17 @@ static inline int dup_mmap(struct mm_str
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
@@ -248,9 +261,12 @@ static inline int dup_mmap(struct mm_str
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
--- 2.5.29/kernel/sysctl.c~overcommit	Sat Jul 27 23:39:09 2002
+++ 2.5.29-akpm/kernel/sysctl.c	Sat Jul 27 23:39:09 2002
@@ -45,6 +45,7 @@
 extern int panic_timeout;
 extern int C_A_D;
 extern int sysctl_overcommit_memory;
+extern int sysctl_overcommit_ratio;
 extern int max_threads;
 extern atomic_t nr_queued_signals;
 extern int max_queued_signals;
@@ -268,6 +269,9 @@ static int one_hundred = 100;
 static ctl_table vm_table[] = {
 	{VM_OVERCOMMIT_MEMORY, "overcommit_memory", &sysctl_overcommit_memory,
 	 sizeof(sysctl_overcommit_memory), 0644, NULL, &proc_dointvec},
+	{VM_OVERCOMMIT_RATIO, "overcommit_ratio",
+	 &sysctl_overcommit_ratio, sizeof(sysctl_overcommit_ratio), 0644,
+	 NULL, &proc_dointvec},
 	{VM_PAGERDAEMON, "kswapd",
 	 &pager_daemon, sizeof(pager_daemon_t), 0644, NULL, &proc_dointvec},
 	{VM_PAGE_CLUSTER, "page-cluster", 
--- 2.5.29/mm/mmap.c~overcommit	Sat Jul 27 23:39:09 2002
+++ 2.5.29-akpm/mm/mmap.c	Sat Jul 27 23:39:09 2002
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
@@ -49,52 +52,91 @@ pgprot_t protection_map[16] = {
 	__S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
 };
 
-int sysctl_overcommit_memory;
+int sysctl_overcommit_memory = 0;	/* default is heuristic overcommit */
+int sysctl_overcommit_ratio = 50;	/* default is 50% */
+atomic_t vm_committed_space = ATOMIC_INIT(0);
+
+inline void vm_unacct_memory(long pages)
+{	
+	atomic_sub(pages, &vm_committed_space);
+}
 
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
+		vm_unacct_memory(pages);
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
 
-	return free > pages;
+	if (atomic_read(&vm_committed_space) < allowed)
+		return 1;
+
+	vm_unacct_memory(pages);
+
+	return 0;
+}
+
+void vm_unacct_vma(struct vm_area_struct *vma)
+{
+	int len = vma->vm_end - vma->vm_start;
+	if (vma->vm_flags & VM_ACCOUNT)
+		vm_unacct_memory(len >> PAGE_SHIFT);
 }
 
 /* Remove one vm structure from the inode's i_mapping address space. */
@@ -163,7 +205,7 @@ asmlinkage unsigned long sys_brk(unsigne
 
 	/* Always allow shrinking brk. */
 	if (brk <= mm->brk) {
-		if (!do_munmap(mm, newbrk, oldbrk-newbrk))
+		if (!do_munmap(mm, newbrk, oldbrk-newbrk, 1))
 			goto set_brk;
 		goto out;
 	}
@@ -177,10 +219,6 @@ asmlinkage unsigned long sys_brk(unsigne
 	if (find_vma_intersection(mm, oldbrk, newbrk+PAGE_SIZE))
 		goto out;
 
-	/* Check if we have enough memory.. */
-	if (!vm_enough_memory((newbrk-oldbrk) >> PAGE_SHIFT))
-		goto out;
-
 	/* Ok, looks good - let it rip. */
 	if (do_brk(oldbrk, newbrk-oldbrk) != oldbrk)
 		goto out;
@@ -386,8 +424,9 @@ static int vma_merge(struct mm_struct * 
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
@@ -395,6 +434,7 @@ unsigned long do_mmap_pgoff(struct file 
 	int correct_wcount = 0;
 	int error;
 	rb_node_t ** rb_link, * rb_parent;
+	unsigned long charged = 0;
 
 	if (file && (!file->f_op || !file->f_op->mmap))
 		return -ENODEV;
@@ -485,7 +525,7 @@ unsigned long do_mmap_pgoff(struct file 
 munmap_back:
 	vma = find_vma_prepare(mm, addr, &prev, &rb_link, &rb_parent);
 	if (vma && vma->vm_start < addr + len) {
-		if (do_munmap(mm, addr, len))
+		if (do_munmap(mm, addr, len, 1))
 			return -ENOMEM;
 		goto munmap_back;
 	}
@@ -495,11 +535,17 @@ munmap_back:
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
@@ -511,8 +557,9 @@ munmap_back:
 	 * not unmapped, but the maps are removed from the list.
 	 */
 	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+	error = -ENOMEM;
 	if (!vma)
-		return -ENOMEM;
+		goto unacct_error;
 
 	vma->vm_mm = mm;
 	vma->vm_start = addr;
@@ -575,6 +622,9 @@ unmap_and_free_vma:
 	zap_page_range(vma, vma->vm_start, vma->vm_end - vma->vm_start);
 free_vma:
 	kmem_cache_free(vm_area_cachep, vma);
+unacct_error:
+	if (charged)
+		vm_unacct_memory(charged);
 	return error;
 }
 
@@ -704,6 +754,45 @@ struct vm_area_struct * find_vma_prev(st
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
@@ -829,7 +918,6 @@ static void unmap_vma(struct mm_struct *
 	kmem_cache_free(vm_area_cachep, area);
 }
 
-
 /*
  * Update the VMA and inode share lists.
  *
@@ -856,19 +944,25 @@ static void unmap_region(struct mm_struc
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
@@ -946,7 +1040,7 @@ static int splitvma(struct mm_struct *mm
  * work.  This now handles partial unmappings.
  * Jeremy Fitzhardine <jeremy@sw.oz.au>
  */
-int do_munmap(struct mm_struct *mm, unsigned long start, size_t len)
+int do_munmap(struct mm_struct *mm, unsigned long start, size_t len, int acct)
 {
 	unsigned long end;
 	struct vm_area_struct *mpnt, *prev, *last;
@@ -990,7 +1084,7 @@ int do_munmap(struct mm_struct *mm, unsi
 	 */
 	spin_lock(&mm->page_table_lock);
 	mpnt = touched_by_munmap(mm, mpnt, prev, end);
-	unmap_region(mm, mpnt, prev, start, end);
+	unmap_region(mm, mpnt, prev, start, end, acct);
 	spin_unlock(&mm->page_table_lock);
 
 	/* Fix up all other VM information */
@@ -1005,7 +1099,7 @@ asmlinkage long sys_munmap(unsigned long
 	struct mm_struct *mm = current->mm;
 
 	down_write(&mm->mmap_sem);
-	ret = do_munmap(mm, addr, len);
+	ret = do_munmap(mm, addr, len, 1);
 	up_write(&mm->mmap_sem);
 	return ret;
 }
@@ -1042,7 +1136,7 @@ unsigned long do_brk(unsigned long addr,
  munmap_back:
 	vma = find_vma_prepare(mm, addr, &prev, &rb_link, &rb_parent);
 	if (vma && vma->vm_start < addr + len) {
-		if (do_munmap(mm, addr, len))
+		if (do_munmap(mm, addr, len, 1))
 			return -ENOMEM;
 		goto munmap_back;
 	}
@@ -1058,7 +1152,7 @@ unsigned long do_brk(unsigned long addr,
 	if (!vm_enough_memory(len >> PAGE_SHIFT))
 		return -ENOMEM;
 
-	flags = VM_DATA_DEFAULT_FLAGS | mm->def_flags;
+	flags = VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
 
 	/* Can we just expand an old anonymous mapping? */
 	if (rb_parent && vma_merge(mm, prev, rb_parent, addr, addr + len, flags))
@@ -1068,8 +1162,10 @@ unsigned long do_brk(unsigned long addr,
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
@@ -1125,6 +1221,13 @@ void exit_mmap(struct mm_struct * mm)
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
--- 2.5.29/mm/mprotect.c~overcommit	Sat Jul 27 23:39:09 2002
+++ 2.5.29-akpm/mm/mprotect.c	Sat Jul 27 23:39:09 2002
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
@@ -248,6 +251,7 @@ static int mprotect_fixup(struct vm_area
 {
 	pgprot_t newprot;
 	int error;
+	unsigned long charged = 0;
 
 	if (newflags == vma->vm_flags) {
 		*pprev = vma;
@@ -264,9 +268,18 @@ static int mprotect_fixup(struct vm_area
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
--- 2.5.29/mm/mremap.c~overcommit	Sat Jul 27 23:39:09 2002
+++ 2.5.29-akpm/mm/mremap.c	Sat Jul 27 23:39:09 2002
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
@@ -209,7 +210,11 @@ static inline unsigned long move_vma(str
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
@@ -224,6 +229,8 @@ static inline unsigned long move_vma(str
 	return -ENOMEM;
 }
 
+extern int sysctl_overcommit_memory;	/* FIXME!! */
+
 /*
  * Expand (or shrink) an existing mapping, potentially moving it at the
  * same time (controlled by the MREMAP_MAYMOVE flag and available VM space)
@@ -237,6 +244,7 @@ unsigned long do_mremap(unsigned long ad
 {
 	struct vm_area_struct *vma;
 	unsigned long ret = -EINVAL;
+	unsigned long charged = 0;
 
 	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE))
 		goto out;
@@ -266,16 +274,17 @@ unsigned long do_mremap(unsigned long ad
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
@@ -305,11 +314,14 @@ unsigned long do_mremap(unsigned long ad
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
@@ -356,6 +368,9 @@ unsigned long do_mremap(unsigned long ad
 		ret = move_vma(vma, addr, old_len, new_len, new_addr);
 	}
 out:
+	if (ret & ~PAGE_MASK)
+		vm_unacct_memory(charged);
+out_nc:
 	return ret;
 }
 
--- 2.5.29/mm/shmem.c~overcommit	Sat Jul 27 23:39:09 2002
+++ 2.5.29-akpm/mm/shmem.c	Sat Jul 27 23:39:09 2002
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
@@ -358,10 +360,41 @@ static void shmem_truncate (struct inode
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
+		long change;
+
+		change = ((attr->ia_size + PAGE_SIZE - 1) >> PAGE_SHIFT) -
+			((inode->i_size + PAGE_SIZE - 1 ) >> PAGE_SHIFT);
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
@@ -824,6 +857,7 @@ shmem_file_write(struct file *file,const
 	unsigned long	written;
 	long		status;
 	int		err;
+	loff_t		maxpos;
 
 	if ((ssize_t) count < 0)
 		return -EINVAL;
@@ -836,12 +870,12 @@ shmem_file_write(struct file *file,const
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
@@ -849,6 +883,15 @@ shmem_file_write(struct file *file,const
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
@@ -938,6 +981,10 @@ unlock:
 
 	err = written ? written : status;
 out:
+	/* Short writes give back address space */
+	if (inode->i_size != maxpos)
+		vm_unacct_memory((maxpos - inode->i_size) >> PAGE_SHIFT);
+out_nc:
 	up(&inode->i_sem);
 	return err;
 fail_write:
@@ -1477,6 +1524,7 @@ static struct file_operations shmem_file
 
 static struct inode_operations shmem_inode_operations = {
 	truncate:	shmem_truncate,
+	setattr:	shmem_notify_change,
 };
 
 static struct inode_operations shmem_dir_inode_operations = {
@@ -1600,12 +1648,11 @@ module_exit(exit_shmem_fs)
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
@@ -1619,7 +1666,7 @@ struct file *shmem_file_setup(char * nam
 	root = shm_mnt->mnt_root;
 	dentry = d_alloc(root, &this);
 	if (!dentry)
-		return ERR_PTR(-ENOMEM);
+		goto put_memory;
 
 	error = -ENFILE;
 	file = get_empty_filp();
@@ -1645,6 +1692,8 @@ close_file:
 	put_filp(file);
 put_dentry:
 	dput (dentry);
+put_memory:
+	vm_unacct_memory((size) >> PAGE_CACHE_SHIFT);
 	return ERR_PTR(error);	
 }
 /*

.
