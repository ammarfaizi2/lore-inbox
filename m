Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132220AbRCYVwS>; Sun, 25 Mar 2001 16:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132223AbRCYVwK>; Sun, 25 Mar 2001 16:52:10 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:28037 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S132220AbRCYVwF>; Sun, 25 Mar 2001 16:52:05 -0500
Message-Id: <l03130326b6e4150a1de0@[192.168.239.101]>
In-Reply-To: <4.3.2.7.2.20010325123201.00be27d0@mail.fluent-access.com>
In-Reply-To: <3ABE0F32.5255DF30@evision-ventures.com>
 <E14gVQf-00056B-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="============_-1226565419==_============"
Date: Sun, 25 Mar 2001 22:51:09 +0100
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
From: Jonathan Morton <chromi@cyberspace.org>
Subject: [PATCH] non-overcommit memory, improved OOM handling, safety
 margin (was Re: Prevent OOM from killing init)
Cc: douglas@fang.demon.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--============_-1226565419==_============
Content-Type: text/plain; charset="us-ascii"

The attached patch is against 2.4.1 and incorporates the following:

- More optimistic OOM checking, and slightly improved OOM-kill algorithm,
as per my previous patch.

- Accounting of reserved memory, allowing for...

- Non-overcommittal of memory if sysctl_overcommit_memory < 0, enforced
even for root if < -1 (as per old non-overcommittal patch for 2.3.99, but
fixed).

- Behaviour when sysctl_overcommit_memory == 0 or 1 is as per my original
patch (eg. soft-limited overcommittal and full overcommittal respectively).
Defaults to -1.

- If a process is larger than 4 times the free VM on the system, it is not
allowed to allocate or reserve any more, unless overcomittal is allowed as
above.  Note that root may have less privilege to hog memory when
sysctl_overcommit_memory == 0 than when == -1.

- As part of the above, a new function vm_invalidate_totalmem() is
available which should be called whenever the total amount of VM changes -
at the moment this is done in sys_swap{on,off}().  This is to avoid having
to recalculate the amount of available memory and swap whenever an
allocation is needed.  If someone knows a better way, let me know.

--============_-1226565419==_============
Content-Type: text/plain; name="oom-patch.2.diff"; charset="us-ascii"
Content-Disposition: attachment; filename="oom-patch.2.diff"

diff -ur -x via-rhine* linux-2.4.1.orig/fs/exec.c linux/fs/exec.c
---
linux-2.4.1.orig/fs/exec.c	Tue Jan 30 07:10:58 2001
+++
linux/fs/exec.c	Sun Mar 25 17:05:03 2001
@@ -385,19 +385,27 @@
 static int
exec_mmap(void)
 {
 	struct mm_struct * mm, * old_mm;
+	struct
task_struct * tsk = current;
+	unsigned long reserved = 0;
 
-	old_mm =
current->mm;
+	old_mm = tsk->mm;
 	if (old_mm &&
atomic_read(&old_mm->mm_users) == 1) {
+	        /* Keep old stack
reservation */
 		mm_release();
 		exit_mmap(old_mm);

		return 0;
 	}
 
+	reserved =
vm_enough_memory(tsk->rlim[RLIMIT_STACK].rlim_cur >> 
+
	    PAGE_SHIFT);
+	if(!reserved)
+	        return -ENOMEM;
+

	mm = mm_alloc();
 	if (mm) {
-		struct mm_struct
*active_mm = current->active_mm;
+		struct mm_struct *active_mm
= tsk->active_mm;
 
-		if (init_new_context(current, mm)) {
+
	if (init_new_context(tsk, mm)) {

	mmdrop(mm);
 			return -ENOMEM;

	}
@@ -422,6 +430,8 @@
 		mmdrop(active_mm);

	return 0;
 	}
+
+	vm_release_memory(reserved);
 	return
-ENOMEM;
 }
 
diff -ur -x via-rhine* linux-2.4.1.orig/fs/proc/proc_misc.c
linux/fs/proc/proc_misc.c
--- linux-2.4.1.orig/fs/proc/proc_misc.c	Tue
Nov  7 19:08:09 2000
+++ linux/fs/proc/proc_misc.c	Sun Mar 25 16:57:07
2001
@@ -175,7 +175,9 @@
                 "LowTotal:     %8lu kB\n"

"LowFree:      %8lu kB\n"
                 "SwapTotal:    %8lu kB\n"
-
"SwapFree:     %8lu kB\n",
+                "SwapFree:  %8lu kB\n"
+
"VMTotal:   %8lu kB\n"
+                "VMReserved:%8lu kB\n",

K(i.totalram),
                 K(i.freeram),

K(i.sharedram),
@@ -190,7 +192,9 @@

K(i.totalram-i.totalhigh),
                 K(i.freeram-i.freehigh),

K(i.totalswap),
-                K(i.freeswap));
+
K(i.freeswap),
+                K(vm_total()), 
+
K(vm_reserved));
 
 	return proc_calc_metrics(page, start, off, count,
eof, len);
 #undef B
diff -ur -x via-rhine*
linux-2.4.1.orig/include/linux/mm.h linux/include/linux/mm.h
---
linux-2.4.1.orig/include/linux/mm.h	Tue Jan 30 07:24:56 2001
+++
linux/include/linux/mm.h	Sun Mar 25 16:57:07 2001
@@ -24,6 +24,13
@@
 #include <asm/atomic.h>
 
 /*
+ * These are used to prevent VM
overcommit.
+ */
+extern unsigned long vm_reserved;
+extern spinlock_t
vm_lock;
+extern inline unsigned long vm_total(void);
+
+/*
  * Linux
kernel virtual memory manager primitives.
  * The idea being to have a
"virtual" mm in the same way
  * we have a virtual fs - giving a cleaner
interface to the
@@ -444,6 +451,14 @@
 extern unsigned long do_brk(unsigned
long, unsigned long);
 
 struct zone_t;
+
+extern long
vm_enough_memory(long pages);
+extern inline void vm_release_memory(long
pages) {
+       int flags;
+       spin_lock_irqsave(&vm_lock, flags);
+
vm_reserved -= pages;
+       spin_unlock_irqrestore(&vm_lock, flags);
+}

/* filemap.c */
 extern void remove_inode_page(struct page *);
 extern
unsigned long page_unuse(struct page *);
diff -ur -x via-rhine*
linux-2.4.1.orig/include/linux/sched.h linux/include/linux/sched.h
---
linux-2.4.1.orig/include/linux/sched.h	Tue Jan 30 07:24:56 2001
+++
linux/include/linux/sched.h	Sun Mar 25 16:57:07 2001
@@ -424,9 +424,9
@@
 
 /*
  * Limit the stack by to some sane default: root can always
- *
increase this limit if needed..  8MB seems reasonable.
+ * increase this
limit if needed..  2MB should be more than enough.
  */
-#define _STK_LIM
	(8*1024*1024)
+#define _STK_LIM       (2*1024*1024)
 
 #define
DEF_COUNTER	(10*HZ/100)	/* 100 ms time slice */
 #define
MAX_COUNTER	(20*HZ/100)
diff -ur -x via-rhine*
linux-2.4.1.orig/kernel/exit.c linux/kernel/exit.c
---
linux-2.4.1.orig/kernel/exit.c	Thu Jan  4 09:00:35 2001
+++
linux/kernel/exit.c	Sun Mar 25 17:29:57 2001
@@ -305,6 +305,11 @@

	mm_release();
 	if (mm) {

	atomic_inc(&mm->mm_count);
+		if
(atomic_read(&mm->mm_users) == 1) {
+		/* Only release stack if
we're the last one using this mm */
+
	vm_release_memory(tsk->rlim[RLIMIT_STACK].rlim_cur >>
+
		PAGE_SHIFT);
+		}
 		if (mm != tsk->active_mm) BUG();
 		/*
more a memory barrier than a real lock */

	task_lock(tsk);
diff -ur -x via-rhine*
linux-2.4.1.orig/kernel/fork.c linux/kernel/fork.c
---
linux-2.4.1.orig/kernel/fork.c	Mon Jan 22 23:54:06 2001
+++
linux/kernel/fork.c	Sun Mar 25 18:23:35 2001
@@ -125,6 +125,7 @@

static inline int dup_mmap(struct mm_struct * mm)
 {
 	struct
vm_area_struct * mpnt, *tmp, **pprev;
+	unsigned long reserved = 0;
 	int
retval;
 
 	flush_cache_mm(current->mm);
@@ -142,6 +143,15 @@

	retval = -ENOMEM;
 		if(mpnt->vm_flags & VM_DONTCOPY)

			continue;
+
+		reserved = 0;
+
	if((mpnt->vm_flags & (VM_GROWSDOWN | VM_WRITE | VM_SHARED)) ==
VM_WRITE) {
+			unsigned long npages = mpnt->vm_end -
mpnt->vm_start;
+			reserved = vm_enough_memory(npages
>> PAGE_SHIFT);
+			if(!reserved)
+
	goto fail_nomem;
+		}
+
 		tmp =
kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 		if (!tmp)

			goto fail_nomem;
@@ -280,6 +290,7 @@
 static int
copy_mm(unsigned long clone_flags, struct task_struct * tsk)
 {

	struct mm_struct * mm, *oldmm;
+	unsigned long reserved;

	int retval;
 
 	tsk->min_flt = tsk->maj_flt = 0;
@@ -305,6 +316,10
@@
 	}
 
 	retval = -ENOMEM;
+	reserved =
vm_enough_memory(tsk->rlim[RLIMIT_STACK].rlim_cur >> PAGE_SHIFT);
+
	if(!reserved)
+		goto fail_nomem;
+
 	mm =
allocate_mm();
 	if (!mm)
 		goto fail_nomem;
@@ -349,6
+364,8 @@
 free_pt:
 	mmput(mm);
 fail_nomem:
+	if (reserved)
+
	vm_release_memory(reserved);
 	return retval;
 }
 
diff -ur -x
via-rhine* linux-2.4.1.orig/kernel/sys.c linux/kernel/sys.c
---
linux-2.4.1.orig/kernel/sys.c	Mon Oct 16 20:58:51 2000
+++
linux/kernel/sys.c	Sun Mar 25 16:57:07 2001
@@ -1060,6 +1060,7 @@

asmlinkage long sys_setrlimit(unsigned int resource, struct rlimit *rlim)

{
 	struct rlimit new_rlim, *old_rlim;
+       struct task_struct
*tsk;
 
 	if (resource >= RLIM_NLIMITS)
 		return -EINVAL;
@@
-1067,7 +1068,8 @@
 		return -EFAULT;
 	if
(new_rlim.rlim_cur < 0 || new_rlim.rlim_max < 0)
 		return
-EINVAL;
-	old_rlim = current->rlim + resource;
+       tsk =
current;
+       old_rlim = tsk->rlim + resource;
 	if
(((new_rlim.rlim_cur > old_rlim->rlim_max) ||
 	     (new_rlim.rlim_max >
old_rlim->rlim_max)) &&
 	    !capable(CAP_SYS_RESOURCE))
@@ -1075,6
+1077,17 @@
 	if (resource == RLIMIT_NOFILE) {
 		if
(new_rlim.rlim_cur > NR_OPEN || new_rlim.rlim_max > NR_OPEN)

	return -EPERM;
+       }
+       /* if PF_VFORK is set we're just
borrowing the VM so don't touch it */
+       if (resource == RLIMIT_STACK
&& !(tsk->flags & PF_VFORK)) {
+               long newpages =
+
((long)(new_rlim.rlim_cur - old_rlim->rlim_cur) >>
+
PAGE_SHIFT);
+               if (newpages > 0 &&
!vm_enough_memory(newpages))
+                       /* We should really
return EAGAIN or ENOMEM. */
+                       return -EPERM;
+
if (newpages < 0)
+                       vm_release_memory(-newpages);

	}
 	*old_rlim = new_rlim;
 	return 0;
diff -ur -x via-rhine*
linux-2.4.1.orig/mm/mmap.c linux/mm/mmap.c
--- linux-2.4.1.orig/mm/mmap.c
	Mon Jan 29 16:10:41 2001
+++ linux/mm/mmap.c	Sun Mar 25 21:06:08
2001
@@ -36,12 +36,42 @@
 	__S000, __S001, __S010, __S011, __S100,
__S101, __S110, __S111
 };
 
-int sysctl_overcommit_memory;
+int
sysctl_overcommit_memory = -1;
+
+/* Unfortunately these need to be longs
so we need a spinlock. */
+unsigned long vm_reserved = 0;
+unsigned long
totalvm = 0;
+spinlock_t vm_lock = SPIN_LOCK_UNLOCKED;
+
+void
vm_invalidate_totalmem(void)
+{
+	int flags;
+
+
	spin_lock_irqsave(&vm_lock, flags);
+	totalvm = 0;
+
	spin_unlock_irqrestore(&vm_lock, flags);
+}
+
+unsigned long
vm_total(void) 
+{
+	int flags;
+
+	spin_lock_irqsave(&vm_lock,
flags);
+	if(!totalvm) {
+		struct sysinfo i;
+
	si_meminfo(&i);
+		si_swapinfo(&i);
+
	totalvm = i.totalram + i.totalswap;
+	}
+
	spin_unlock_irqrestore(&vm_lock, flags);	
+
+	return
totalvm;
+}
 
 /* Check that a process has enough memory to allocate a
  *
new virtual mapping.
  */
-int vm_enough_memory(long pages)
+long
vm_enough_memory(long pages)
 {
 	/* Stupid algorithm to decide if we
have enough memory: while
 	 * simple, it hopefully works in most
obvious cases.. Easy to
@@ -52,18 +82,44 @@
 	 * (buffers+cache), use the
minimum values.  Allow an extra 2%
 	 * of num_physpages for safety
margin.
 	 */
+	/* From non-overcommit patch: only allow
vm_reserved to exceed
+	 * vm_total if we're root.
+	 */
 
-	long
free;
+	int flags;
+	long free = 0;
 	
-        /* Sometimes we
want to use more memory than we have. */
-	if
(sysctl_overcommit_memory)
-	    return 1;
-
-	free =
atomic_read(&buffermem_pages);
-	free +=
atomic_read(&page_cache_size);
-	free += nr_free_pages();
-
	free += nr_swap_pages;
-	return free > pages;
+
	spin_lock_irqsave(&vm_lock, flags);
+	if(sysctl_overcommit_memory
< 0)
+		free = vm_total() - vm_reserved;
+	else {
+
	free = atomic_read(&buffermem_pages);
+		free +=
atomic_read(&page_cache_size);
+		free += nr_free_pages();
+
		free += nr_swap_pages;
+	}
+
+	/* Attempt to
curtail memory allocations before hard OOM occurs.
+	 * Based on current
process size, which is hopefully a good and fast heuristic.
+	 * Also fix
bug where the real OOM limit of (free == freepages.min) is not taken into
account.
+	 * In fact, we use freepages.high as the threshold to make
sure there's still room for buffers+cache.
+	 *
+	 * -- Jonathan
"Chromatix" Morton, 24th March 2001
+	 */
+
+	if(current->mm)
+
free -= (current->mm->total_vm / 4);
+	free -= freepages.high;
+
+
	if(pages > free)
+		if( !(sysctl_overcommit_memory ==
-1 && current->uid == 0)
+				&&
sysctl_overcommit_memory != 1)
+			pages = 0;
+
+
	vm_reserved += pages;
+	spin_unlock_irqrestore(&vm_lock,
flags);
+
+	return pages;
 }
 
 /* Remove one vm structure from the
inode's i_mapping address space. */
@@ -148,10 +204,6 @@
 	if
(find_vma_intersection(mm, oldbrk, newbrk+PAGE_SIZE))
 		goto out;


-	/* Check if we have enough memory.. */
-	if
(!vm_enough_memory((newbrk-oldbrk) >> PAGE_SHIFT))
-		goto
out;
-
 	/* Ok, looks good - let it rip. */
 	if (do_brk(oldbrk,
newbrk-oldbrk) != oldbrk)
 		goto out;
@@ -190,6 +242,7 @@
 {

	struct mm_struct * mm = current->mm;
 	struct vm_area_struct *
vma;
+	long reserved = 0;
 	int correct_wcount = 0;
 	int error;


@@ -317,7 +370,7 @@
 	/* Private writable mapping? Check memory
availability.. */
 	if ((vma->vm_flags & (VM_SHARED | VM_WRITE)) ==
VM_WRITE &&
 	    !(flags & MAP_NORESERVE)
&&
-	    !vm_enough_memory(len >> PAGE_SHIFT))
+           !(reserved =
vm_enough_memory(len >> PAGE_SHIFT)))
 		goto free_vma;
 
 	if
(file) {
@@ -367,6 +420,7 @@
 	zap_page_range(mm, vma->vm_start,
vma->vm_end - vma->vm_start);
 	flush_tlb_range(mm, vma->vm_start,
vma->vm_end);
 free_vma:
+       vm_release_memory(reserved);

	kmem_cache_free(vm_area_cachep, vma);
 	return error;
 }
@@ -546,6
+600,9 @@
 	area->vm_mm->total_vm -= len >> PAGE_SHIFT;
 	if
(area->vm_flags & VM_LOCKED)
 		area->vm_mm->locked_vm -= len >>
PAGE_SHIFT;
+       if ((area->vm_flags & (VM_GROWSDOWN | VM_WRITE |
VM_SHARED)) 
+               == VM_WRITE)
+
vm_release_memory(len >> PAGE_SHIFT);
 
 	/* Unmapping the whole
area. */
 	if (addr == area->vm_start && end == area->vm_end) {
@@
-781,7 +838,7 @@
 {
 	struct mm_struct * mm = current->mm;
 	struct
vm_area_struct * vma;
-	unsigned long flags, retval;
+	unsigned long
flags, retval, reserved = 0;
 
 	len = PAGE_ALIGN(len);
 	if
(!len)
@@ -812,7 +869,7 @@
 	if (mm->map_count > MAX_MAP_COUNT)

	return -ENOMEM;
 
-	if (!vm_enough_memory(len >> PAGE_SHIFT))
+
	if (!(reserved = vm_enough_memory(len >> PAGE_SHIFT)))

	return -ENOMEM;
 
 	flags =
vm_flags(PROT_READ|PROT_WRITE|PROT_EXEC,
@@ -836,8 +893,10 @@
 	 * create a
vma struct for an anonymous mapping
 	 */
 	vma =
kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
-	if (!vma)
+	if
(!vma) {
+		vm_release_memory(reserved);
 		return
-ENOMEM;
+	}
 
 	vma->vm_mm = mm;
 	vma->vm_start = addr;
@@
-900,6 +959,9 @@
 		zap_page_range(mm, start, size);

	if (mpnt->vm_file)
 			fput(mpnt->vm_file);
+
if ((mpnt->vm_flags & (VM_GROWSDOWN | VM_WRITE | VM_SHARED)) 
+
== VM_WRITE)
+                       vm_release_memory(size >>
PAGE_SHIFT);
 		kmem_cache_free(vm_area_cachep, mpnt);

	mpnt = next;
 	}
diff -ur -x via-rhine*
linux-2.4.1.orig/mm/mremap.c linux/mm/mremap.c
---
linux-2.4.1.orig/mm/mremap.c	Fri Dec 29 22:07:24 2000
+++
linux/mm/mremap.c	Sun Mar 25 16:57:07 2001
@@ -13,8 +13,6 @@

#include <asm/uaccess.h>
 #include <asm/pgalloc.h>
 
-extern int
vm_enough_memory(long pages);
-
 static inline pte_t *get_one_pte(struct
mm_struct *mm, unsigned long addr)
 {
 	pgd_t * pgd;
@@ -168,7 +166,7 @@

	unsigned long flags, unsigned long new_addr)
 {
 	struct
vm_area_struct *vma;
-	unsigned long ret = -EINVAL;
+       unsigned long
ret = -EINVAL, reserved = 0;
 
 	if (flags & ~(MREMAP_FIXED |
MREMAP_MAYMOVE))
 		goto out;
@@ -240,7 +238,7 @@
 	/* Private
writable mapping? Check memory availability.. */
 	if ((vma->vm_flags
& (VM_SHARED | VM_WRITE)) == VM_WRITE &&
 	    !(flags &
MAP_NORESERVE)				 &&
-
!vm_enough_memory((new_len - old_len) >> PAGE_SHIFT))
+
!(reserved = vm_enough_memory((new_len - old_len) >> PAGE_SHIFT)))

	goto out;
 
 	/* old_len exactly to the end of the area..
@@
-265,6 +263,7 @@
 						   addr +
new_len);
 			}
 			ret = addr;
+
reserved = 0;
 			goto out;
 		}
 	}
@@ -281,8
+280,12 @@
 				goto out;
 		}

	ret = move_vma(vma, addr, old_len, new_len, new_addr);
+
if (ret != -ENOMEM) 
+                       reserved = 0;
 	}
 out:
+
if (reserved)
+               vm_release_memory(reserved);
 	return
ret;
 }
 
diff -ur -x via-rhine* linux-2.4.1.orig/mm/oom_kill.c
linux/mm/oom_kill.c
--- linux-2.4.1.orig/mm/oom_kill.c	Tue Nov 14 18:56:46
2000
+++ linux/mm/oom_kill.c	Sat Mar 24 23:27:59 2001
@@ -76,7 +76,9 @@

	run_time = (jiffies - p->start_time) >> (SHIFT_HZ + 10);
 

	points /= int_sqrt(cpu_time);
-	points /=
int_sqrt(int_sqrt(run_time));
+
+	/* Long-running processes are
*very* important, so don't take the 4th root */
+	points /=
run_time;
 
 	/*
 	 * Niced processes are most likely less important,
so double
@@ -93,6 +95,10 @@
 				p->uid == 0 ||
p->euid == 0)
 		points /= 4;
 
+	/* Much the same goes for
processes with low UIDs */
+	if(p->uid < 100 || p->euid < 100)
+
points /= 2;
+
 	/*
 	 * We don't want to kill a process with
direct hardware access.
 	 * Not only could that mess up the
hardware, but usually users
@@ -192,17 +198,24 @@
 int out_of_memory(void)

{
 	struct sysinfo swp_info;
+	long free;
 
 	/* Enough free
memory?  Not OOM. */
-	if (nr_free_pages() > freepages.min)
+	free =
nr_free_pages();
+	if (free > freepages.min)
+		return
0;
+
+	if (free + nr_inactive_clean_pages() > freepages.low)

	return 0;
 
-	if (nr_free_pages() + nr_inactive_clean_pages() >
freepages.low)
+	/* Buffers and caches can be freed up (Jonathan
"Chromatix" Morton) */
+	free += atomic_read(&buffermem_pages);
+
	free += atomic_read(&page_cache_size);
+	if (free >
freepages.low)
 		return 0;
 
 	/* Enough swap space left?
Not OOM. */
-	si_swapinfo(&swp_info);
-	if (swp_info.freeswap >
0)
+	if (nr_swap_pages > 0)
 		return 0;
 
 	/* Else...
*/
diff -ur -x via-rhine* linux-2.4.1.orig/mm/shmem.c linux/mm/shmem.c
---
linux-2.4.1.orig/mm/shmem.c	Sun Jan 28 03:50:08 2001
+++
linux/mm/shmem.c	Sun Mar 25 18:31:56 2001
@@ -844,7 +844,6 @@

	struct inode * inode;
 	struct dentry *dentry, *root;
 	struct qstr
this;
-	int vm_enough_memory(long pages);
 
 	error = -ENOMEM;
 	if
(!vm_enough_memory((size) >> PAGE_SHIFT))
diff -ur -x via-rhine*
linux-2.4.1.orig/mm/swapfile.c linux/mm/swapfile.c
---
linux-2.4.1.orig/mm/swapfile.c	Fri Dec 29 22:07:24 2000
+++
linux/mm/swapfile.c	Sun Mar 25 20:45:06 2001
@@ -17,6 +17,9 @@
 

#include <asm/pgtable.h>
 
+extern int sysctl_overcommit_memory;
+extern
void vm_invalidate_totalmem(void);
+
 spinlock_t swaplock =
SPIN_LOCK_UNLOCKED;
 unsigned int nr_swapfiles;
 
@@ -403,7 +406,7 @@
 {

	struct swap_info_struct * p = NULL;
 	struct nameidata nd;
-	int
i, type, prev;
+	int i, type, prev, flags;
 	int err;
 	

	if (!capable(CAP_SYS_ADMIN))
@@ -448,7 +451,18 @@

	nr_swap_pages -= p->pages;
 	swap_list_unlock();
 	p->flags =
SWP_USED;
-	err = try_to_unuse(type);
+
+       /* Don't allow removal of
swap if it will cause overcommit */
+       spin_lock_irqsave(&vm_lock,
flags);
+       if ((sysctl_overcommit_memory < 0) && 
+
(vm_reserved > vm_total())) {
+
spin_unlock_irqrestore(&vm_lock, flags);
+               err = -ENOMEM;
+
} else {
+               spin_unlock_irqrestore(&vm_lock, flags);
+
err = try_to_unuse(type);
+       }
+
 	if (err) {
 		/*
re-insert swap space back into swap_list */

	swap_list_lock();
@@ -483,6 +497,7 @@
 	unlock_kernel();

	path_release(&nd);
 out:
+	vm_invalidate_totalmem();

	return err;
 }
 
@@ -557,6 +572,7 @@
 	unsigned long maxpages;

	int swapfilesize;
 	struct block_device *bdev = NULL;
+
int flags;
 	
 	if (!capable(CAP_SYS_ADMIN))
 		return
-EPERM;
@@ -787,6 +803,7 @@
 out:
 	if (swap_header)

	free_page((long) swap_header);
+	vm_invalidate_totalmem();

	unlock_kernel();
 	return error;
 }

--============_-1226565419==_============
Content-Type: text/plain; charset="us-ascii"

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----

--============_-1226565419==_============--

