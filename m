Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317923AbSGKW0A>; Thu, 11 Jul 2002 18:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317924AbSGKWZ7>; Thu, 11 Jul 2002 18:25:59 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:63481 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317923AbSGKWZq>; Thu, 11 Jul 2002 18:25:46 -0400
Subject: [PATCH] strict VM overcommit
From: Robert Love <rml@tech9.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, riel@conectiva.com.br, alan@redhat.com
Content-Type: multipart/mixed; boundary="=-znq7Phf304U/4+qOU/nN"
X-Mailer: Ximian Evolution 1.0.8 
Date: 11 Jul 2002 15:28:30 -0700
Message-Id: <1026426511.1244.321.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-znq7Phf304U/4+qOU/nN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The attached patch implements strict VM overcommit on top of the rmap
VM.

The basis for this is Alan Cox's work in 2.4-ac.  This is a port of the
strict VM overcommit out of 2.4-ac and into the standard kernel with the
following changes:

	- one or two bugfixes (have sent/will send to Alan)
	- some cleanups, mostly for coding style
	- I did not bring over the debugging code
	- new overcommit policy for swapless machines

So what is strict VM overcommit?  We introduce new overcommit policies
that attempt to never succeed an allocation that can not be fulfilled by
the backing store and consequently never OOM.  This is achieved through
strict accounting of the committed address space and a policy to
allow/refuse allocations based on that accounting.

In the strictest of modes, it should be impossible to allocate more
memory than available and impossible to OOM.  All memory failures should
be pushed down to the allocation routines -- malloc, mmap, etc.

The new modes are available via sysctl (same as before).  See
Documentation/vm/overcommit-accounting for more information.

Again, Alan deserves the credit for the design of all this.

The patch is against 2.4.19-pre7-rmap13b but should apply to later
releases with little trouble.

Enjoy,

	Robert Love


--=-znq7Phf304U/4+qOU/nN
Content-Disposition: attachment; filename=vm-strict-overcommit-rml-2.4.19-pre7-rmap-1.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=vm-strict-overcommit-rml-2.4.19-pre7-rmap-1.patch;
	charset=ISO-8859-1

diff -urN linux-2.4.19-pre7-rmap/Documentation/sysctl/vm.txt linux/Document=
ation/sysctl/vm.txt
--- linux-2.4.19-pre7-rmap/Documentation/sysctl/vm.txt	Wed Jul  3 14:13:29 =
2002
+++ linux/Documentation/sysctl/vm.txt	Thu Jul 11 14:00:49 2002
@@ -167,7 +167,11 @@
 programs that malloc() huge amounts of memory "just-in-case"
 and don't use much of it.
=20
-Look at: mm/mmap.c::vm_enough_memory() for more information.
+Flag values of 2 - 4 introduce a new "strict overcommit"
+policy that attempt to prevent any overcommit of memory.
+
+See Documentation/vm/overcommit-accounting and
+mm/mmap.c::vm_enough_memory() for more information.
=20
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
diff -urN linux-2.4.19-pre7-rmap/Documentation/vm/overcommit-accounting lin=
ux/Documentation/vm/overcommit-accounting
--- linux-2.4.19-pre7-rmap/Documentation/vm/overcommit-accounting	Wed Dec 3=
1 16:00:00 1969
+++ linux/Documentation/vm/overcommit-accounting	Thu Jul 11 14:00:57 2002
@@ -0,0 +1,77 @@
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
+2	-	(NEW) swapless strict overcommit. The total address space
+		commit for the system is not permitted to exceed 90% of
+		free memory. This mode utilizes the new stricter accounting
+		but does not impose a very strict rule.  It is possible that
+		the system could kill a process accessing pages in certain
+		cases.  If mode 3 is too strict when no swap is	present
+		this is the best you can do.
+
+3	-	(NEW) strict overcommit. The total address space commit
+		for the system is not permitted to exceed swap + half ram.
+		In almost all situations this means a process will not be
+		killed while accessing pages but only by malloc failures
+		that are reported back by the kernel mmap/brk code.
+
+4	-	(NEW) paranoid overcommit. The total address space commit
+		for the system is not permitted to exceed swap. The machine
+		will never kill a process accessing pages it has mapped
+		except due to a bug (ie report it!).
+
+Gotchas
+-------
+
+The C language stack growth does an implicit mremap. If you want absolute
+guarantees and run close to the edge you MUST mmap your stack for the=20
+largest size you think you will need. For typical stack usage is does
+not matter much but its a corner case if you really really care
+
+In modes 2 and 3 the MAP_NORESERVE flag is ignored.=20
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
diff -urN linux-2.4.19-pre7-rmap/fs/exec.c linux/fs/exec.c
--- linux-2.4.19-pre7-rmap/fs/exec.c	Wed Jul  3 14:14:49 2002
+++ linux/fs/exec.c	Thu Jul 11 14:00:49 2002
@@ -308,8 +308,13 @@
=20
 	mpnt =3D kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 	if (!mpnt)=20
-		return -ENOMEM;=20
-=09
+		return -ENOMEM;
+
+	if (!vm_enough_memory((STACK_TOP - (PAGE_MASK & (unsigned long) bprm->p))=
 >> PAGE_SHIFT,1)) {
+		kmem_cache_free(vm_area_cachep, mpnt);
+		return -ENOMEM;
+	}
+
 	down_write(&current->mm->mmap_sem);
 	{
 		mpnt->vm_mm =3D current->mm;
diff -urN linux-2.4.19-pre7-rmap/fs/proc/proc_misc.c linux/fs/proc/proc_mis=
c.c
--- linux-2.4.19-pre7-rmap/fs/proc/proc_misc.c	Wed Jul  3 14:14:52 2002
+++ linux/fs/proc/proc_misc.c	Thu Jul 11 14:00:49 2002
@@ -131,12 +131,14 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
=20
+extern atomic_t vm_committed_space;
+
 static int meminfo_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
 	struct sysinfo i;
 	int len;
-	int pg_size ;
+	int pg_size, committed;
=20
 /*
  * display in kilobytes.
@@ -146,6 +148,7 @@
 	si_meminfo(&i);
 	si_swapinfo(&i);
 	pg_size =3D atomic_read(&page_cache_size) - i.bufferram ;
+	committed =3D atomic_read(&vm_committed_space);
=20
 	len =3D sprintf(page, "        total:    used:    free:  shared: buffers:=
  cached:\n"
 		"Mem:  %8Lu %8Lu %8Lu %8Lu %8Lu %8Lu\n"
@@ -175,7 +178,8 @@
 		"LowTotal:     %8lu kB\n"
 		"LowFree:      %8lu kB\n"
 		"SwapTotal:    %8lu kB\n"
-		"SwapFree:     %8lu kB\n",
+		"SwapFree:     %8lu kB\n"
+		"Committed_AS: %8u kB\n",
 		K(i.totalram),
 		K(i.freeram),
 		K(i.sharedram),
@@ -191,7 +195,8 @@
 		K(i.totalram-i.totalhigh),
 		K(i.freeram-i.freehigh),
 		K(i.totalswap),
-		K(i.freeswap));
+		K(i.freeswap),
+		K(committed));
=20
 	return proc_calc_metrics(page, start, off, count, eof, len);
 #undef B
diff -urN linux-2.4.19-pre7-rmap/include/linux/mm.h linux/include/linux/mm.=
h
--- linux-2.4.19-pre7-rmap/include/linux/mm.h	Wed Jul  3 14:14:52 2002
+++ linux/include/linux/mm.h	Thu Jul 11 14:00:49 2002
@@ -100,8 +100,9 @@
 #define VM_DONTCOPY	0x00020000      /* Do not copy this vma on fork */
 #define VM_DONTEXPAND	0x00040000	/* Cannot expand with mremap() */
 #define VM_RESERVED	0x00080000	/* Don't unmap it from swap_out */
+#define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
=20
-#define VM_STACK_FLAGS	0x00000177
+#define VM_STACK_FLAGS	(0x00000177 | VM_ACCOUNT)
=20
 #define VM_READHINTMASK			(VM_SEQ_READ | VM_RAND_READ)
 #define VM_ClearReadHint(v)		(v)->vm_flags &=3D ~VM_READHINTMASK
@@ -603,7 +604,7 @@
 	return ret;
 }
=20
-extern int do_munmap(struct mm_struct *, unsigned long, size_t);
+extern int do_munmap(struct mm_struct *, unsigned long, size_t, int);
=20
 extern unsigned long do_brk(unsigned long, unsigned long);
=20
@@ -671,33 +672,8 @@
 	return gfp_mask;
 }
 =09
-/* vma is the first one with  address < vma->vm_end,
- * and even  address < vma->vm_start. Have to extend vma. */
-static inline int expand_stack(struct vm_area_struct * vma, unsigned long =
address)
-{
-	unsigned long grow;
-
-	/*
-	 * vma->vm_start/vm_end cannot change under us because the caller is requ=
ired
-	 * to hold the mmap_sem in write mode. We need to get the spinlock only
-	 * before relocating the vma range ourself.
-	 */
-	address &=3D PAGE_MASK;
- 	spin_lock(&vma->vm_mm->page_table_lock);
-	grow =3D (vma->vm_start - address) >> PAGE_SHIFT;
-	if (vma->vm_end - address > current->rlim[RLIMIT_STACK].rlim_cur ||
-	    ((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) > current->rlim[RLIMIT_=
AS].rlim_cur) {
-		spin_unlock(&vma->vm_mm->page_table_lock);
-		return -ENOMEM;
-	}
-	vma->vm_start =3D address;
-	vma->vm_pgoff -=3D grow;
-	vma->vm_mm->total_vm +=3D grow;
-	if (vma->vm_flags & VM_LOCKED)
-		vma->vm_mm->locked_vm +=3D grow;
-	spin_unlock(&vma->vm_mm->page_table_lock);
-	return 0;
-}
+/* Do stack extension */=09
+extern int expand_stack(struct vm_area_struct * vma, unsigned long address=
);
=20
 /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
 extern struct vm_area_struct * find_vma(struct mm_struct * mm, unsigned lo=
ng addr);
diff -urN linux-2.4.19-pre7-rmap/include/linux/mman.h linux/include/linux/m=
man.h
--- linux-2.4.19-pre7-rmap/include/linux/mman.h	Wed Jul  3 14:00:16 2002
+++ linux/include/linux/mman.h	Thu Jul 11 14:00:50 2002
@@ -6,4 +6,8 @@
 #define MREMAP_MAYMOVE	1
 #define MREMAP_FIXED	2
=20
+extern int vm_enough_memory(long pages, int charge);
+extern void vm_unacct_memory(long pages);
+extern void vm_unacct_vma(struct vm_area_struct *vma);
+
 #endif /* _LINUX_MMAN_H */
diff -urN linux-2.4.19-pre7-rmap/ipc/shm.c linux/ipc/shm.c
--- linux-2.4.19-pre7-rmap/ipc/shm.c	Wed Jul  3 14:13:56 2002
+++ linux/ipc/shm.c	Thu Jul 11 14:00:50 2002
@@ -679,7 +679,7 @@
 		shmdnext =3D shmd->vm_next;
 		if (shmd->vm_ops =3D=3D &shm_vm_ops
 		    && shmd->vm_start - (shmd->vm_pgoff << PAGE_SHIFT) =3D=3D (ulong) sh=
maddr) {
-			do_munmap(mm, shmd->vm_start, shmd->vm_end - shmd->vm_start);
+			do_munmap(mm, shmd->vm_start, shmd->vm_end - shmd->vm_start, 1);
 			retval =3D 0;
 		}
 	}
diff -urN linux-2.4.19-pre7-rmap/kernel/fork.c linux/kernel/fork.c
--- linux-2.4.19-pre7-rmap/kernel/fork.c	Wed Jul  3 14:14:52 2002
+++ linux/kernel/fork.c	Thu Jul 11 14:00:50 2002
@@ -21,6 +21,7 @@
 #include <linux/completion.h>
 #include <linux/namespace.h>
 #include <linux/personality.h>
+#include <linux/mman.h>
=20
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -132,6 +133,7 @@
 {
 	struct vm_area_struct * mpnt, *tmp, **pprev;
 	int retval;
+	unsigned long charge =3D 0;
=20
 	flush_cache_mm(current->mm);
 	mm->locked_vm =3D 0;
@@ -159,6 +161,17 @@
 		retval =3D -ENOMEM;
 		if(mpnt->vm_flags & VM_DONTCOPY)
 			continue;
+
+		/*
+		 * FIXME: shared writable map accounting should be one off
+		 */
+		if (mpnt->vm_flags & VM_ACCOUNT) {
+			unsigned int len =3D (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
+			if (!vm_enough_memory(len, 1))
+				goto fail_nomem;
+			charge +=3D len;
+		}
+
 		tmp =3D kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 		if (!tmp)
 			goto fail_nomem;
@@ -203,9 +216,12 @@
 	retval =3D 0;
 	build_mmap_rb(mm);
=20
-fail_nomem:
+out:
 	flush_tlb_mm(current->mm);
 	return retval;
+fail_nomem:
+	vm_unacct_memory(charge);
+	goto out;
 }
=20
 spinlock_t mmlist_lock __cacheline_aligned =3D SPIN_LOCK_UNLOCKED;
diff -urN linux-2.4.19-pre7-rmap/mm/mmap.c linux/mm/mmap.c
--- linux-2.4.19-pre7-rmap/mm/mmap.c	Wed Jul  3 14:13:56 2002
+++ linux/mm/mmap.c	Thu Jul 11 14:00:50 2002
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
@@ -46,51 +49,97 @@
=20
 int sysctl_overcommit_memory;
 int max_map_count =3D DEFAULT_MAX_MAP_COUNT;
+atomic_t vm_committed_space =3D ATOMIC_INIT(0);
=20
-/* Check that a process has enough memory to allocate a
- * new virtual mapping.
+/*
+ * Check that a process has enough memory to allocate a new virtual
+ * mapping. 1 means there is enough memory for the allocation to
+ * succeed and 0 implies there is not.
+ *
+ * We currently support four overcommit policies, which are set via the
+ * overcommit_memory sysctl.  See Documentation/vm/overcommit-acounting
+ *
+ * Strict overcommit modes added 2002 Feb 26 by Alan Cox.
  */
-int vm_enough_memory(long pages)
+int vm_enough_memory(long pages, int charge)
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
=20
-	unsigned long free;
-=09
-        /* Sometimes we want to use more memory than we have. */
-	if (sysctl_overcommit_memory)
-	    return 1;
-
-	/* The page cache contains buffer pages these days.. */
-	free =3D atomic_read(&page_cache_size);
-	free +=3D nr_free_pages();
-	free +=3D nr_swap_pages;
+	if (charge)
+		atomic_add(pages, &vm_committed_space);
=20
-	/*
-	 * This double-counts: the nrpages are both in the page-cache
-	 * and in the swapper space. At the same time, this compensates
-	 * for the swap-space over-allocation (ie "nr_swap_pages" being
-	 * too small.
+        /*
+	 * Sometimes we want to use more memory than we have
 	 */
-	free +=3D swapper_space.nrpages;
+	if (sysctl_overcommit_memory =3D=3D 1)
+		return 1;
=20
-	/*
-	 * The code below doesn't account for free space in the inode
-	 * and dentry slab cache, slab cache fragmentation, inodes and
-	 * dentries which will become freeable under VM load, etc.
-	 * Lets just hope all these (complex) factors balance out...
-	 */
-	free +=3D (dentry_stat.nr_unused * sizeof(struct dentry)) >> PAGE_SHIFT;
-	free +=3D (inodes_stat.nr_unused * sizeof(struct inode)) >> PAGE_SHIFT;
+	if (sysctl_overcommit_memory =3D=3D 0) {
+		free =3D atomic_read(&page_cache_size);
+		free +=3D nr_free_pages();
+		free +=3D nr_swap_pages;
+
+		/*
+		 * This double-counts: the nrpages are both in the
+		 * page-cache and in the swapper space. At the same time,
+		 * this compensates for the swap-space over-allocation
+		 * (ie "nr_swap_pages" being too small).
+		 */
+		free +=3D swapper_space.nrpages;
+
+		/*
+		 * The code below doesn't account for free space in the
+		 * inode and dentry slab cache, slab cache fragmentation,
+		 * inodes and dentries which will become freeable under
+		 * VM load, etc. Lets just hope all these (complex)
+		 * factors balance out...
+		 */
+		free +=3D (dentry_stat.nr_unused * sizeof(struct dentry)) >>
+			PAGE_SHIFT;
+		free +=3D (inodes_stat.nr_unused * sizeof(struct inode)) >>
+			PAGE_SHIFT;
+
+		if (free > pages)
+			return 1;
+		if (charge)
+			atomic_sub(pages, &vm_committed_space);
+		return 0;
+	}
=20
-	return free > pages;
+	if (sysctl_overcommit_memory =3D=3D 2) {
+		/*
+		 * FIXME: need to add arch hooks to get the bits we need
+		 * without the higher overhead crap
+		 */
+		struct sysinfo i;
+		si_meminfo(&i);
+		allowed =3D i.totalram - (i.totalram / 20);
+	} else if (sysctl_overcommit_memory =3D=3D 3) {
+		struct sysinfo i;
+		si_meminfo(&i);=09
+		allowed =3D total_swap_pages + (i.totalram >> 1);
+	} else  /* sysctl_overcommit_memory =3D=3D 4 */
+		allowed =3D total_swap_pages;
+
+	if (atomic_read(&vm_committed_space) < allowed)
+		return 1;
+
+	if (charge)
+		atomic_sub(pages, &vm_committed_space);
+
+	return 0;
+}
+
+void inline vm_unacct_memory(long pages)
+{=09
+	atomic_sub(pages, &vm_committed_space);
+}
+
+void vm_unacct_vma(struct vm_area_struct *vma)
+{
+	int len =3D vma->vm_end - vma->vm_start;
+	if (vma->vm_flags & VM_ACCOUNT)
+		vm_unacct_memory(len >> PAGE_SHIFT);
 }
=20
 /* Remove one vm structure from the inode's i_mapping address space. */
@@ -161,7 +210,7 @@
=20
 	/* Always allow shrinking brk. */
 	if (brk <=3D mm->brk) {
-		if (!do_munmap(mm, newbrk, oldbrk-newbrk))
+		if (!do_munmap(mm, newbrk, oldbrk-newbrk, 1))
 			goto set_brk;
 		goto out;
 	}
@@ -175,8 +224,11 @@
 	if (find_vma_intersection(mm, oldbrk, newbrk+PAGE_SIZE))
 		goto out;
=20
-	/* Check if we have enough memory.. */
-	if (!vm_enough_memory((newbrk-oldbrk) >> PAGE_SHIFT))
+	/*
+	 * Check if we have enough memory..
+	 * FIXME: this seems to be checked in do_brk ...
+	 */
+	if (!vm_enough_memory((newbrk-oldbrk) >> PAGE_SHIFT, 0))
 		goto out;
=20
 	/* Ok, looks good - let it rip. */
@@ -390,8 +442,9 @@
 	return 0;
 }
=20
-unsigned long do_mmap_pgoff(struct file * file, unsigned long addr, unsign=
ed long len,
-	unsigned long prot, unsigned long flags, unsigned long pgoff)
+unsigned long do_mmap_pgoff(struct file * file, unsigned long addr,
+			unsigned long len, unsigned long prot,
+			unsigned long flags, unsigned long pgoff)
 {
 	struct mm_struct * mm =3D current->mm;
 	struct vm_area_struct * vma, * prev;
@@ -399,16 +452,20 @@
 	int correct_wcount =3D 0;
 	int error;
 	rb_node_t ** rb_link, * rb_parent;
+	unsigned long charged =3D 0;
=20
 	if (file && (!file->f_op || !file->f_op->mmap))
 		return -ENODEV;
=20
-	if ((len =3D PAGE_ALIGN(len)) =3D=3D 0)
+	if (!len)
 		return addr;
=20
 	if (len > TASK_SIZE)
 		return -EINVAL;
=20
+	/* This cannot be zero now */
+	len =3D PAGE_ALIGN(len);
+
 	/* offset overflow? */
 	if ((pgoff + (len >> PAGE_SHIFT)) < pgoff)
 		return -EINVAL;
@@ -482,7 +539,7 @@
 munmap_back:
 	vma =3D find_vma_prepare(mm, addr, &prev, &rb_link, &rb_parent);
 	if (vma && vma->vm_start < addr + len) {
-		if (do_munmap(mm, addr, len))
+		if (do_munmap(mm, addr, len, 1))
 			return -ENOMEM;
 		goto munmap_back;
 	}
@@ -492,11 +549,17 @@
 	    > current->rlim[RLIMIT_AS].rlim_cur)
 		return -ENOMEM;
=20
+	if (sysctl_overcommit_memory > 1)
+		vm_flags &=3D ~MAP_NORESERVE;
+
 	/* Private writable mapping? Check memory availability.. */
-	if ((vm_flags & (VM_SHARED | VM_WRITE)) =3D=3D VM_WRITE &&
-	    !(flags & MAP_NORESERVE)				 &&
-	    !vm_enough_memory(len >> PAGE_SHIFT))
-		return -ENOMEM;
+	if ((((vm_flags & (VM_SHARED | VM_WRITE)) =3D=3D VM_WRITE) ||
+			(file =3D=3D NULL)) && !(flags & MAP_NORESERVE)) {
+		charged =3D len >> PAGE_SHIFT;
+		if (!vm_enough_memory(charged, 1))
+			return -ENOMEM;
+		vm_flags |=3D VM_ACCOUNT;
+	}
=20
 	/* Can we just expand an old anonymous mapping? */
 	if (!file && !(vm_flags & VM_SHARED) && rb_parent)
@@ -508,8 +571,9 @@
 	 * not unmapped, but the maps are removed from the list.
 	 */
 	vma =3D kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+	error =3D -ENOMEM;
 	if (!vma)
-		return -ENOMEM;
+		goto unacct_error;
=20
 	vma->vm_mm =3D mm;
 	vma->vm_start =3D addr;
@@ -557,12 +621,13 @@
 		 */
 		struct vm_area_struct * stale_vma;
 		/* Since addr changed, we rely on the mmap op to prevent=20
-		 * collisions with existing vmas and just use find_vma_prepare=20
-		 * to update the tree pointers.
+		 * collisions with existing vmas and just use
+		 * find_vma_prepare to update the tree pointers.
 		 */
 		addr =3D vma->vm_start;
 		stale_vma =3D find_vma_prepare(mm, addr, &prev,
 						&rb_link, &rb_parent);
+
 		/*
 		 * Make sure the lowlevel driver did its job right.
 		 */
@@ -595,6 +660,9 @@
 	zap_page_range(mm, vma->vm_start, vma->vm_end - vma->vm_start);
 free_vma:
 	kmem_cache_free(vm_area_cachep, vma);
+unacct_error:
+	if (charged)
+		vm_unacct_memory(charged);
 	return error;
 }
=20
@@ -737,6 +805,45 @@
 	return NULL;
 }
=20
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
+	address &=3D PAGE_MASK;
+ 	spin_lock(&vma->vm_mm->page_table_lock);
+	grow =3D (vma->vm_start - address) >> PAGE_SHIFT;
+
+	/* Overcommit.. */
+	if(!vm_enough_memory(grow, 1)) {
+		spin_unlock(&vma->vm_mm->page_table_lock);
+		return -ENOMEM;
+	}
+=09
+	if (vma->vm_end - address > current->rlim[RLIMIT_STACK].rlim_cur ||
+			((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) >
+			current->rlim[RLIMIT_AS].rlim_cur) {
+		spin_unlock(&vma->vm_mm->page_table_lock);
+		vm_unacct_memory(grow);
+		return -ENOMEM;
+	}
+	vma->vm_start =3D address;
+	vma->vm_pgoff -=3D grow;
+	vma->vm_mm->total_vm +=3D grow;
+	if (vma->vm_flags & VM_LOCKED)
+		vma->vm_mm->locked_vm +=3D grow;
+	spin_unlock(&vma->vm_mm->page_table_lock);
+	return 0;
+}
+
 struct vm_area_struct * find_extend_vma(struct mm_struct * mm, unsigned lo=
ng addr)
 {
 	struct vm_area_struct * vma;
@@ -784,7 +891,7 @@
  */
 static struct vm_area_struct * unmap_fixup(struct mm_struct *mm,=20
 	struct vm_area_struct *area, unsigned long addr, size_t len,=20
-	struct vm_area_struct *extra)
+	struct vm_area_struct *extra, int acct)
 {
 	struct vm_area_struct *mpnt;
 	unsigned long end =3D addr + len;
@@ -799,10 +906,15 @@
 			area->vm_ops->close(area);
 		if (area->vm_file)
 			fput(area->vm_file);
+		if (acct)
+			vm_unacct_vma(area);
 		kmem_cache_free(vm_area_cachep, area);
 		return extra;
 	}
=20
+	if (acct && (area->vm_flags & VM_ACCOUNT))
+		vm_unacct_memory(len >> PAGE_SHIFT);
+
 	/* Work out to one of the ends. */
 	if (end =3D=3D area->vm_end) {
 		/*
@@ -917,7 +1029,7 @@
  * work.  This now handles partial unmappings.
  * Jeremy Fitzhardine <jeremy@sw.oz.au>
  */
-int do_munmap(struct mm_struct *mm, unsigned long addr, size_t len)
+int do_munmap(struct mm_struct *mm, unsigned long addr, size_t len, int ac=
ct)
 {
 	struct vm_area_struct *mpnt, *prev, **npp, *free, *extra;
=20
@@ -993,9 +1105,10 @@
 		zap_page_range(mm, st, size);
=20
 		/*
-		 * Fix the mapping, and free the old area if it wasn't reused.
+		 * Fix the mapping, and free the old area if it was not
+		 * reused.
 		 */
-		extra =3D unmap_fixup(mm, mpnt, st, size, extra);
+		extra =3D unmap_fixup(mm, mpnt, st, size, extra, acct);
 		if (file)
 			atomic_inc(&file->f_dentry->d_inode->i_writecount);
 	}
@@ -1016,7 +1129,7 @@
 	struct mm_struct *mm =3D current->mm;
=20
 	down_write(&mm->mmap_sem);
-	ret =3D do_munmap(mm, addr, len);
+	ret =3D do_munmap(mm, addr, len, 1);
 	up_write(&mm->mmap_sem);
 	return ret;
 }
@@ -1053,7 +1166,7 @@
  munmap_back:
 	vma =3D find_vma_prepare(mm, addr, &prev, &rb_link, &rb_parent);
 	if (vma && vma->vm_start < addr + len) {
-		if (do_munmap(mm, addr, len))
+		if (do_munmap(mm, addr, len, 1))
 			return -ENOMEM;
 		goto munmap_back;
 	}
@@ -1066,10 +1179,10 @@
 	if (mm->map_count > max_map_count)
 		return -ENOMEM;
=20
-	if (!vm_enough_memory(len >> PAGE_SHIFT))
+	if (!vm_enough_memory(len >> PAGE_SHIFT, 1))
 		return -ENOMEM;
=20
-	flags =3D VM_DATA_DEFAULT_FLAGS | mm->def_flags;
+	flags =3D VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
=20
 	/* Can we just expand an old anonymous mapping? */
 	if (rb_parent && vma_merge(mm, prev, rb_parent, addr, addr + len, flags))
@@ -1079,8 +1192,10 @@
 	 * create a vma struct for an anonymous mapping
 	 */
 	vma =3D kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
-	if (!vma)
+	if (!vma) {
+		vm_unacct_memory(len >> PAGE_SHIFT);
 		return -ENOMEM;
+	}
=20
 	vma->vm_mm =3D mm;
 	vma->vm_start =3D addr;
@@ -1141,10 +1256,18 @@
 		unsigned long end =3D mpnt->vm_end;
 		unsigned long size =3D end - start;
=20
+		/*
+		 * If the VMA has been charged for, account for its
+		 * removal
+		 */
+		if (mpnt->vm_flags & VM_ACCOUNT)
+			vm_unacct_vma(mpnt);
+
 		if (mpnt->vm_ops) {
 			if (mpnt->vm_ops->close)
 				mpnt->vm_ops->close(mpnt);
 		}
+
 		mm->map_count--;
 		remove_shared_vm_struct(mpnt);
 		zap_page_range(mm, start, size);
diff -urN linux-2.4.19-pre7-rmap/mm/mprotect.c linux/mm/mprotect.c
--- linux-2.4.19-pre7-rmap/mm/mprotect.c	Wed Jul  3 14:13:56 2002
+++ linux/mm/mprotect.c	Thu Jul 11 14:00:50 2002
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
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
@@ -241,6 +244,7 @@
 {
 	pgprot_t newprot;
 	int error;
+	unsigned long charged =3D 0;
=20
 	if (newflags =3D=3D vma->vm_flags) {
 		*pprev =3D vma;
@@ -257,9 +261,18 @@
 	else
 		error =3D mprotect_fixup_middle(vma, pprev, start, end, newflags, newpro=
t);
=20
-	if (error)
+	if (error) {
+		if(newflags & PROT_WRITE)
+			vm_unacct_memory(charged);
 		return error;
+	}
=20
+	/*
+	 * Delayed accounting for reduction of memory use - done last to
+	 * avoid allocation races
+	 */
+	if (charged && !(newflags & PROT_WRITE))
+		vm_unacct_memory(charged);
 	change_protection(start, end, newprot);
 	return 0;
 }
diff -urN linux-2.4.19-pre7-rmap/mm/mremap.c linux/mm/mremap.c
--- linux-2.4.19-pre7-rmap/mm/mremap.c	Wed Jul  3 14:14:52 2002
+++ linux/mm/mremap.c	Thu Jul 11 14:00:50 2002
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
=20
 #include <linux/slab.h>
@@ -13,8 +16,6 @@
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
=20
-extern int vm_enough_memory(long pages);
-
 static inline pte_t *get_one_pte(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t * pgd;
@@ -197,7 +198,11 @@
 				new_vma->vm_ops->open(new_vma);
 			insert_vm_struct(current->mm, new_vma);
 		}
-		do_munmap(current->mm, addr, old_len);
+		/*
+		 * The old VMA has been accounted for,
+		 * don't double account
+		 */
+		do_munmap(current->mm, addr, old_len, 0);
 		current->mm->total_vm +=3D new_len >> PAGE_SHIFT;
 		if (new_vma->vm_flags & VM_LOCKED) {
 			current->mm->locked_vm +=3D new_len >> PAGE_SHIFT;
@@ -212,6 +217,8 @@
 	return -ENOMEM;
 }
=20
+extern int sysctl_overcommit_memory;	/* FIXME!! */
+
 /*
  * Expand (or shrink) an existing mapping, potentially moving it at the
  * same time (controlled by the MREMAP_MAYMOVE flag and available VM space=
)
@@ -225,6 +232,7 @@
 {
 	struct vm_area_struct *vma;
 	unsigned long ret =3D -EINVAL;
+	unsigned long charged =3D 0;
=20
 	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE))
 		goto out;
@@ -254,16 +262,17 @@
 		if ((addr <=3D new_addr) && (addr+old_len) > new_addr)
 			goto out;
=20
-		do_munmap(current->mm, new_addr, new_len);
+		do_munmap(current->mm, new_addr, new_len, 1);
 	}
=20
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
+	 * do_munmap does all the needed commit accounting
 	 */
 	ret =3D addr;
 	if (old_len >=3D new_len) {
-		do_munmap(current->mm, addr+new_len, old_len - new_len);
+		do_munmap(current->mm, addr+new_len, old_len - new_len, 1);
 		if (!(flags & MREMAP_FIXED) || (new_addr =3D=3D addr))
 			goto out;
 	}
@@ -293,11 +302,14 @@
 	if ((current->mm->total_vm << PAGE_SHIFT) + (new_len - old_len)
 	    > current->rlim[RLIMIT_AS].rlim_cur)
 		goto out;
-	/* Private writable mapping? Check memory availability.. */
-	if ((vma->vm_flags & (VM_SHARED | VM_WRITE)) =3D=3D VM_WRITE &&
-	    !(flags & MAP_NORESERVE)				 &&
-	    !vm_enough_memory((new_len - old_len) >> PAGE_SHIFT))
-		goto out;
+
+	if (sysctl_overcommit_memory > 1)
+		flags &=3D ~MAP_NORESERVE;
+	if (vma->vm_flags & VM_ACCOUNT) {
+		charged =3D (new_len - old_len) >> PAGE_SHIFT;
+		if (!vm_enough_memory(charged, 1))
+			goto out_nc;
+	}
=20
 	/* old_len exactly to the end of the area..
 	 * And we're not relocating the area.
@@ -344,6 +356,9 @@
 		ret =3D move_vma(vma, addr, old_len, new_len, new_addr);
 	}
 out:
+	if (ret & ~PAGE_MASK)
+		vm_unacct_memory(charged);
+out_nc:
 	return ret;
 }
=20
diff -urN linux-2.4.19-pre7-rmap/mm/shmem.c linux/mm/shmem.c
--- linux-2.4.19-pre7-rmap/mm/shmem.c	Wed Jul  3 14:13:56 2002
+++ linux/mm/shmem.c	Thu Jul 11 14:00:50 2002
@@ -5,7 +5,8 @@
  *		 2000 Transmeta Corp.
  *		 2000-2001 Christoph Rohland
  *		 2000-2001 SAP AG
- *=20
+ *		 2002 Red Hat Inc.
+ *
  * This file is released under the GPL.
  */
=20
@@ -21,6 +22,7 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
+#include <linux/mman.h>
 #include <linux/file.h>
 #include <linux/swap.h>
 #include <linux/pagemap.h>
@@ -330,10 +332,38 @@
 	up(&info->sem);
 }
=20
+static int shmem_notify_change(struct dentry * dentry, struct iattr *attr)
+{
+	struct inode *inode =3D dentry->d_inode;
+	int error;
+
+	if (attr->ia_valid & ATTR_SIZE) {
+		/*
+	 	 * Account swap file usage based on new file size=09
+	 	 */
+		long change =3D (attr->ia_size>>PAGE_SHIFT) - (inode->i_size >> PAGE_SHI=
FT);
+
+		if (attr->ia_size > inode->i_size) {
+			if (!vm_enough_memory(change,1))
+				return -ENOMEM;
+		} else
+			vm_unacct_memory(-change);
+	}
+
+	error =3D inode_change_ok(inode, attr);
+	if (!error)
+		error =3D inode_setattr(inode, attr);
+
+	return error;
+}
+
+
 static void shmem_delete_inode(struct inode * inode)
 {
 	struct shmem_sb_info *sbinfo =3D SHMEM_SB(inode->i_sb);
=20
+	vm_unacct_memory((inode->i_size) >> PAGE_SHIFT);
+
 	inode->i_size =3D 0;
 	if (inode->i_op->truncate =3D=3D shmem_truncate){=20
 		spin_lock (&shmem_ilock);
@@ -751,6 +781,7 @@
 	unsigned long	written;
 	long		status;
 	int		err;
+	loff_t		maxpos;
=20
 	if ((ssize_t) count < 0)
 		return -EINVAL;
@@ -763,12 +794,12 @@
 	pos =3D *ppos;
 	err =3D -EINVAL;
 	if (pos < 0)
-		goto out;
+		goto out_nc;
=20
 	err =3D file->f_error;
 	if (err) {
 		file->f_error =3D 0;
-		goto out;
+		goto out_nc;
 	}
=20
 	written =3D 0;
@@ -776,6 +807,15 @@
 	if (file->f_flags & O_APPEND)
 		pos =3D inode->i_size;
=20
+	maxpos =3D inode->i_size;
+	if (pos + count > inode->i_size) {
+		maxpos =3D pos + count;
+		if (!vm_enough_memory((maxpos - inode->i_size) >> PAGE_SHIFT, 1)) {
+			err =3D -ENOMEM;
+			goto out_nc;
+		}
+	}
+
 	/*
 	 * Check whether we've reached the file size limit.
 	 */
@@ -865,6 +905,10 @@
=20
 	err =3D written ? written : status;
 out:
+	/* Short writes give back address space */
+	if (inode->i_size !=3D maxpos)
+		vm_unacct_memory((maxpos - inode->i_size) >> PAGE_SHIFT);
+out_nc:
 	up(&inode->i_sem);
 	return err;
 fail_write:
@@ -1350,6 +1394,7 @@
=20
 static struct inode_operations shmem_inode_operations =3D {
 	truncate:	shmem_truncate,
+	setattr:	shmem_notify_change,
 };
=20
 static struct file_operations shmem_dir_operations =3D {
@@ -1448,17 +1493,16 @@
  */
 struct file *shmem_file_setup(char * name, loff_t size)
 {
-	int error;
+	int error =3D -ENOMEM;
 	struct file *file;
 	struct inode * inode;
 	struct dentry *dentry, *root;
 	struct qstr this;
-	int vm_enough_memory(long pages);
=20
 	if (size > (unsigned long long) SHMEM_MAX_BLOCKS << PAGE_CACHE_SHIFT)
 		return ERR_PTR(-EINVAL);
=20
-	if (!vm_enough_memory((size) >> PAGE_CACHE_SHIFT))
+	if (!vm_enough_memory((size) >> PAGE_CACHE_SHIFT, 1))
 		return ERR_PTR(-ENOMEM);
=20
 	this.name =3D name;
@@ -1467,7 +1511,7 @@
 	root =3D shm_mnt->mnt_root;
 	dentry =3D d_alloc(root, &this);
 	if (!dentry)
-		return ERR_PTR(-ENOMEM);
+		goto put_memory;
=20
 	error =3D -ENFILE;
 	file =3D get_empty_filp();
@@ -1493,6 +1537,8 @@
 	put_filp(file);
 put_dentry:
 	dput (dentry);
+put_memory:
+	vm_unacct_memory((size) >> PAGE_CACHE_SHIFT);
 	return ERR_PTR(error);=09
 }
 /*

--=-znq7Phf304U/4+qOU/nN--

