Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWEQRCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWEQRCE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 13:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWEQRCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 13:02:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2502 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750728AbWEQRCC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 13:02:02 -0400
Subject: [PATCH] Fix do_mlock so page alignment is to hugepage boundries
	when needed
From: Eric Paris <eparis@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: wli@holomorphy.com, discuss@x86-64.org, linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Wed, 17 May 2006 13:01:56 -0400
Message-Id: <1147885316.26468.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sys_m{,un}lock and do_mlock all align memory references and the length
of the mlock given by userspace to page boundaries.  If the page being
mlocked is a hugepage instead of a normal page the start and finish of
the mlock will still only be aligned to normal page boundaries.
Ultimately upon the process exiting we will eventually call unmap_vmas
which will call unmap_hugepage_range for all of the ranges.
unmap_hugepage_range checks to make sure the beginning and the end of
the range are actually hugepage aligned and if not will BUG().  Since we
only aligned to a normal page boundary the end of the first range and
the beginning of the second will likely (unless userspace passed of
values already hugepage aligned) not be hugepage aligned and thus we
bomb.

To recreate (on any arch with hugepages) just create a hugepage and
allow shared memory segments to be at least as large as a hugepage.
Attach to that hugepage and then mlock on a non hugepage aligned
boundary when you call exit() the kernel will panic with a BUG() in
unmap_hugepage_range because the end of the range being unmapped is not
aligned properly.  Part of a quick reproducer program for i686 where
PAGE_SIZE=1024*4 and HPAGE_SIZE=4*1024*1024 is below.  

shmflg = SHM_HUGETLB | IPC_CREAT | SHM_R | SHM_W;
shmid = shmget (IPC_PRIVATE, 4*1024*1024, shmflg);
a = shmat(shmid, NULL, shmflg);
ret = mlock(a, 1024*4); // 1024*4 is PAGE_ALIGN'ed but this is a hugepage
exit(0)

This will panic because the end of the area to be unmapped will be 4k
(the regular pace boundary) not 4M (the hugepage page boundary on this
arch)

To fix this I created 2 new macros in mlock.c and a new macro in all of
the page.h files that defined HPAGE_SIZE.  I also had to move the
resource limit checks from sys_mlock to do_mlock.  The reason for this
is that we can't tell if it is a hugepage unless we have the vma.  And
so we don't know how long the mlock length will be unless we know how to
round the length to the correct page length.  Thus resource checking
can't be done until after we have the vma in question.

The two macros in mlock.c will, only on systems compiled with
CONFIG_HUGETLB_PAGE, check if the page being locked or unlocked is a
hugepage and if so ALIGN it to hugepage boundaries rather than normal
page boundaries.  If the vma is not for a hugepage it will use the same
methods as before for alignment.  The macro addition to page.h copies
the PAGE_ALIGN macro but uses HPAGE_SIZE and HPAGE_MASK.  I created this
HPAGE_ALIGN macro on the i386, x86_64, ia64, sh, sh64, sparc64, parisc
and powerpc archs.  Since they appear to be the all arches that
implement HPAGE_SIZE.  Two points of oddity, x86_64 seems to have
HPAGE_SIZE defined irrespective of CONFIG_HUGETLB_PAGE so my new
HPAGE_ALIGN macro is always defined as well.  It will still only get
used if CONFIG_HUGETLB_PAGE is set.

The other point of oddity that I don't know if it is right is the
definition on powerpc.  include/asm-powerpc/page_64.h does not quite
follow the same layout as the other arches so I think it's in the right
place but don't have a good place to test.  So if a person with power pc
is willing to test for me please just let me know if it is either fixed
or if it doesn't compile correctly.  I think it's right, but I'm not
100%.

Signed-off-by: Eric Paris <eparis@redhat.com>

 include/asm-i386/page.h       |    2 +
 include/asm-ia64/page.h       |    2 +
 include/asm-parisc/page.h     |    2 +
 include/asm-powerpc/page_64.h |    2 +
 include/asm-sh/page.h         |    2 +
 include/asm-sh64/page.h       |    2 +
 include/asm-sparc64/page.h    |    2 +
 include/asm-x86_64/page.h     |    2 +
 mm/mlock.c                    |   54 ++++++++++++++++++++++++------------------
 9 files changed, 48 insertions(+), 22 deletions(-)

--- linux-2.6.16.14/include/asm-sparc64/page.h.paris
+++ linux-2.6.16.14/include/asm-sparc64/page.h
@@ -104,6 +104,8 @@ typedef unsigned long pgprot_t;
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
 #define ARCH_HAS_SETCLEAR_HUGE_PTE
 #define ARCH_HAS_HUGETLB_PREFAULT_HOOK
+/* to align the pointer to the (next) page boundary when dealing with hugepages*/
+#define HPAGE_ALIGN(addr)       (((addr)+HPAGE_SIZE-1)&HPAGE_MASK)
 #endif
 
 #define TASK_UNMAPPED_BASE	(test_thread_flag(TIF_32BIT) ? \
--- linux-2.6.16.14/include/asm-i386/page.h.paris
+++ linux-2.6.16.14/include/asm-i386/page.h
@@ -68,6 +68,8 @@ typedef struct { unsigned long pgprot; }
 #define HPAGE_MASK	(~(HPAGE_SIZE - 1))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
 #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
+/* to align the pointer to the (next) page boundary when dealing with hugepages*/
+#define HPAGE_ALIGN(addr)       (((addr)+HPAGE_SIZE-1)&HPAGE_MASK)
 #endif
 
 #define pgd_val(x)	((x).pgd)
--- linux-2.6.16.14/include/asm-sh64/page.h.paris
+++ linux-2.6.16.14/include/asm-sh64/page.h
@@ -42,6 +42,8 @@
 #define HPAGE_MASK		(~(HPAGE_SIZE-1))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT-PAGE_SHIFT)
 #define ARCH_HAS_SETCLEAR_HUGE_PTE
+/* to align the pointer to the (next) page boundary when dealing with hugepages*/
+#define HPAGE_ALIGN(addr)       (((addr)+HPAGE_SIZE-1)&HPAGE_MASK)
 #endif
 
 #ifdef __KERNEL__
--- linux-2.6.16.14/include/asm-sh/page.h.paris
+++ linux-2.6.16.14/include/asm-sh/page.h
@@ -32,6 +32,8 @@
 #define HPAGE_MASK		(~(HPAGE_SIZE-1))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT-PAGE_SHIFT)
 #define ARCH_HAS_SETCLEAR_HUGE_PTE
+/* to align the pointer to the (next) page boundary when dealing with hugepages*/
+#define HPAGE_ALIGN(addr)       (((addr)+HPAGE_SIZE-1)&HPAGE_MASK)
 #endif
 
 #ifdef __KERNEL__
--- linux-2.6.16.14/include/asm-x86_64/page.h.paris
+++ linux-2.6.16.14/include/asm-x86_64/page.h
@@ -40,6 +40,8 @@
 #define HPAGE_SIZE	((1UL) << HPAGE_SHIFT)
 #define HPAGE_MASK	(~(HPAGE_SIZE - 1))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
+/* to align the pointer to the (next) page boundary when dealing with hugepages*/
+#define HPAGE_ALIGN(addr)       (((addr)+HPAGE_SIZE-1)&HPAGE_MASK)
 
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
--- linux-2.6.16.14/include/asm-parisc/page.h.paris
+++ linux-2.6.16.14/include/asm-parisc/page.h
@@ -140,6 +140,8 @@ extern int npmem_ranges;
 #define HPAGE_SIZE      	((1UL) << HPAGE_SHIFT)
 #define HPAGE_MASK		(~(HPAGE_SIZE - 1))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
+/* to align the pointer to the (next) page boundary when dealing with hugepages*/
+#define HPAGE_ALIGN(addr)       (((addr)+HPAGE_SIZE-1)&HPAGE_MASK)
 #endif
 
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
--- linux-2.6.16.14/include/asm-ia64/page.h.paris
+++ linux-2.6.16.14/include/asm-ia64/page.h
@@ -57,6 +57,8 @@
 
 # define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 # define ARCH_HAS_HUGEPAGE_ONLY_RANGE
+/* to align the pointer to the (next) page boundary when dealing with hugepages*/
+#define HPAGE_ALIGN(addr)       (((addr)+HPAGE_SIZE-1)&HPAGE_MASK)
 #endif /* CONFIG_HUGETLB_PAGE */
 
 #ifdef __ASSEMBLY__
--- linux-2.6.16.14/include/asm-powerpc/page_64.h.paris
+++ linux-2.6.16.14/include/asm-powerpc/page_64.h
@@ -85,6 +85,8 @@ extern unsigned int HPAGE_SHIFT;
 #define HPAGE_SIZE		((1UL) << HPAGE_SHIFT)
 #define HPAGE_MASK		(~(HPAGE_SIZE - 1))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
+/* to align the pointer to the (next) page boundary when dealing with hugepages*/
+#define HPAGE_ALIGN(addr)       (((addr)+HPAGE_SIZE-1)&HPAGE_MASK)
 
 #endif /* __ASSEMBLY__ */
 
--- linux-2.6.16.14/mm/mlock.c.paris
+++ linux-2.6.16.14/mm/mlock.c
@@ -11,6 +11,13 @@
 #include <linux/mempolicy.h>
 #include <linux/syscalls.h>
 
+#ifdef CONFIG_HUGETLB_PAGE
+#define MLOCK_PAGE_ALIGN(len,vma) (((vma)->vm_flags & VM_HUGETLB) ?  HPAGE_ALIGN(len) : PAGE_ALIGN(len))
+#define MLOCK_PAGE_MASK(vma) (((vma)->vm_flags & VM_HUGETLB) ?  HPAGE_MASK : PAGE_MASK)
+#else
+#define MLOCK_PAGE_ALIGN(len,vma) PAGE_ALIGN(len)
+#define MLOCK_PAGE_MASK(vma) PAGE_MASK
+#endif
 
 static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
 	unsigned long start, unsigned long end, unsigned int newflags)
@@ -78,19 +85,37 @@ static int do_mlock(unsigned long start,
 	struct vm_area_struct * vma, * prev;
 	int error;
 
-	len = PAGE_ALIGN(len);
-	end = start + len;
-	if (end < start)
-		return -EINVAL;
-	if (end == start)
-		return 0;
 	vma = find_vma_prev(current->mm, start, &prev);
 	if (!vma || vma->vm_start > start)
 		return -ENOMEM;
 
+	len = MLOCK_PAGE_ALIGN((len + (start & ~MLOCK_PAGE_MASK(vma))), vma);
+	start = start & MLOCK_PAGE_MASK(vma);
+
 	if (start > vma->vm_start)
 		prev = vma;
 
+	end = start + len;
+	if (end < start)
+		return -EINVAL;
+	if (end == start)
+		return 0;
+
+	if (on) {
+		unsigned long locked;
+		unsigned long lock_limit;
+
+		locked = len >> PAGE_SHIFT;
+		locked += current->mm->locked_vm;
+
+		lock_limit = current->signal->rlim[RLIMIT_MEMLOCK].rlim_cur;
+		lock_limit >>= PAGE_SHIFT;
+
+		/* check against resource limits */
+		if ((locked > lock_limit) && !capable(CAP_IPC_LOCK))
+			return -ENOMEM;
+	}
+
 	for (nstart = start ; ; ) {
 		unsigned int newflags;
 
@@ -123,26 +148,13 @@ static int do_mlock(unsigned long start,
 
 asmlinkage long sys_mlock(unsigned long start, size_t len)
 {
-	unsigned long locked;
-	unsigned long lock_limit;
 	int error = -ENOMEM;
 
 	if (!can_do_mlock())
 		return -EPERM;
 
 	down_write(&current->mm->mmap_sem);
-	len = PAGE_ALIGN(len + (start & ~PAGE_MASK));
-	start &= PAGE_MASK;
-
-	locked = len >> PAGE_SHIFT;
-	locked += current->mm->locked_vm;
-
-	lock_limit = current->signal->rlim[RLIMIT_MEMLOCK].rlim_cur;
-	lock_limit >>= PAGE_SHIFT;
-
-	/* check against resource limits */
-	if ((locked <= lock_limit) || capable(CAP_IPC_LOCK))
-		error = do_mlock(start, len, 1);
+	error = do_mlock(start, len, 1);
 	up_write(&current->mm->mmap_sem);
 	return error;
 }
@@ -152,8 +164,6 @@ asmlinkage long sys_munlock(unsigned lon
 	int ret;
 
 	down_write(&current->mm->mmap_sem);
-	len = PAGE_ALIGN(len + (start & ~PAGE_MASK));
-	start &= PAGE_MASK;
 	ret = do_mlock(start, len, 0);
 	up_write(&current->mm->mmap_sem);
 	return ret;


