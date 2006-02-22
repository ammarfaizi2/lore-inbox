Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbWBVX0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbWBVX0z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 18:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030356AbWBVX0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 18:26:55 -0500
Received: from ozlabs.org ([203.10.76.45]:53911 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030353AbWBVX0y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 18:26:54 -0500
Date: Thu, 23 Feb 2006 10:26:14 +1100
From: "'David Gibson'" <david@gibson.dropbear.id.au>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: IA64 non-contiguous memory space bugs
Message-ID: <20060222232614.GA25108@localhost.localdomain>
Mail-Followup-To: 'David Gibson' <david@gibson.dropbear.id.au>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060222001359.GA23574@localhost.localdomain> <200602221619.k1MGJog18578@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602221619.k1MGJog18578@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 08:19:51AM -0800, Chen, Kenneth W wrote:
> David Gibson wrote on Tuesday, February 21, 2006 4:14 PM
> > --- working-2.6.orig/include/linux/mm.h	2004-09-07 10:38:00.000000000 +1000
> > +++ working-2.6/include/linux/mm.h	2004-09-24 15:02:18.172776168 +1000
> > @@ -41,6 +41,13 @@
> >  #define MM_VM_SIZE(mm)	TASK_SIZE
> >  #endif
> >  
> > +#ifndef REGION_MAX
> > +#define REGION_MAX(addr)	TASK_SIZE
> > +#endif
> > +
> > +#define GOOD_TASK_VM_RANGE(addr, len) \
> > +	( ((addr)+(len) >= (addr)) || ((addr)+(len) <= TASK_SIZE) \
> > +	  || ((addr)+(len) <= REGION_MAX(addr)) )
> 
> Looks like the logic is reversed, should be && instead of ||.

Ah, yes indeed.  Looks like I screwed up my de Morgan's when I changed
it from BAD_TASK_VM_RANGE().  This and another reject fixed in the
version below.  Mind you it's been a long time since I wrote this, so
it should probably be checked for any new places where the tests need
to be changed.  I'm probably not the best person to do that, since I
don't have an ia64 machine to test on.

Index: working-2.6/mm/mremap.c
===================================================================
--- working-2.6.orig/mm/mremap.c	2006-01-16 13:02:29.000000000 +1100
+++ working-2.6/mm/mremap.c	2006-02-23 09:54:52.000000000 +1100
@@ -278,7 +278,7 @@ unsigned long do_mremap(unsigned long ad
 		if (!(flags & MREMAP_MAYMOVE))
 			goto out;
 
-		if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
+		if (! GOOD_TASK_VM_RANGE(new_addr, new_len))
 			goto out;
 
 		/* Check if the location we're moving into overlaps the
@@ -355,6 +355,8 @@ unsigned long do_mremap(unsigned long ad
 	    !((flags & MREMAP_FIXED) && (addr != new_addr)) &&
 	    (old_len != new_len || !(flags & MREMAP_MAYMOVE))) {
 		unsigned long max_addr = TASK_SIZE;
+		if (max_addr > REGION_MAX(vma->vm_start))
+			max_addr = REGION_MAX(vma->vm_start);
 		if (vma->vm_next)
 			max_addr = vma->vm_next->vm_start;
 		/* can we just expand the current mapping? */
Index: working-2.6/mm/mmap.c
===================================================================
--- working-2.6.orig/mm/mmap.c	2006-02-23 09:54:43.000000000 +1100
+++ working-2.6/mm/mmap.c	2006-02-23 10:00:08.000000000 +1100
@@ -1345,7 +1345,7 @@ get_unmapped_area(struct file *file, uns
 			return addr;
 	}
 
-	if (addr > TASK_SIZE - len)
+	if (! GOOD_TASK_VM_RANGE(addr, len))
 		return -ENOMEM;
 	if (addr & ~PAGE_MASK)
 		return -EINVAL;
@@ -1757,7 +1757,7 @@ int do_munmap(struct mm_struct *mm, unsi
 	unsigned long end;
 	struct vm_area_struct *vma, *prev, *last;
 
-	if ((start & ~PAGE_MASK) || start > TASK_SIZE || len > TASK_SIZE-start)
+	if ((start & ~PAGE_MASK) || !GOOD_TASK_VM_RANGE(start, len))
 		return -EINVAL;
 
 	if ((len = PAGE_ALIGN(len)) == 0)
@@ -1851,7 +1851,7 @@ unsigned long do_brk(unsigned long addr,
 	if (!len)
 		return addr;
 
-	if ((addr + len) > TASK_SIZE || (addr + len) < addr)
+	if (! GOOD_TASK_VM_RANGE(addr, len))
 		return -EINVAL;
 
 	/*
Index: working-2.6/include/asm-ia64/page.h
===================================================================
--- working-2.6.orig/include/asm-ia64/page.h	2006-01-16 13:02:29.000000000 +1100
+++ working-2.6/include/asm-ia64/page.h	2006-02-23 09:54:52.000000000 +1100
@@ -142,6 +142,8 @@ typedef union ia64_va {
 #define REGION_NUMBER(x)	({ia64_va _v; _v.l = (long) (x); _v.f.reg;})
 #define REGION_OFFSET(x)	({ia64_va _v; _v.l = (long) (x); _v.f.off;})
 
+#define REGION_MAX(x)	((REGION_NUMBER(x)<<61) + RGN_MAP_LIMIT)
+
 #ifdef CONFIG_HUGETLB_PAGE
 # define htlbpage_to_page(x)	(((unsigned long) REGION_NUMBER(x) << 61)			\
 				 | (REGION_OFFSET(x) >> (HPAGE_SHIFT-PAGE_SHIFT)))
Index: working-2.6/include/linux/mm.h
===================================================================
--- working-2.6.orig/include/linux/mm.h	2006-02-20 10:55:12.000000000 +1100
+++ working-2.6/include/linux/mm.h	2006-02-23 10:01:51.000000000 +1100
@@ -41,6 +41,13 @@ extern int sysctl_legacy_va_layout;
 
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 
+#ifndef REGION_MAX
+#define REGION_MAX(addr)	TASK_SIZE
+#endif
+
+#define GOOD_TASK_VM_RANGE(addr, len) \
+	( ((addr)+(len) >= (addr)) && ((addr)+(len) <= TASK_SIZE) \
+	  && ((addr)+(len) <= REGION_MAX(addr)) )
 /*
  * Linux kernel virtual memory manager primitives.
  * The idea being to have a "virtual" mm in the same way
Index: working-2.6/fs/binfmt_elf.c
===================================================================
--- working-2.6.orig/fs/binfmt_elf.c	2006-01-16 13:08:42.000000000 +1100
+++ working-2.6/fs/binfmt_elf.c	2006-02-23 09:54:52.000000000 +1100
@@ -86,7 +86,8 @@ static struct linux_binfmt elf_format = 
 		.min_coredump	= ELF_EXEC_PAGESIZE
 };
 
-#define BAD_ADDR(x)	((unsigned long)(x) > TASK_SIZE)
+#define BAD_ADDR(x)	(((unsigned long)(x) > TASK_SIZE) \
+		 || ((unsigned long)(x) >= REGION_MAX((unsigned long)x)) )
 
 static int set_brk(unsigned long start, unsigned long end)
 {
@@ -389,8 +390,8 @@ static unsigned long load_elf_interp(str
 	     * <= p_memsize so it is only necessary to check p_memsz.
 	     */
 	    k = load_addr + eppnt->p_vaddr;
-	    if (k > TASK_SIZE || eppnt->p_filesz > eppnt->p_memsz ||
-		eppnt->p_memsz > TASK_SIZE || TASK_SIZE - eppnt->p_memsz < k) {
+	    if ((eppnt->p_filesz > eppnt->p_memsz) ||
+		! GOOD_TASK_VM_RANGE(k, eppnt->p_memsz)) {
 	        error = -ENOMEM;
 		goto out_close;
 	    }
@@ -871,9 +872,8 @@ static int load_elf_binary(struct linux_
 		 * allowed task size. Note that p_filesz must always be
 		 * <= p_memsz so it is only necessary to check p_memsz.
 		 */
-		if (k > TASK_SIZE || elf_ppnt->p_filesz > elf_ppnt->p_memsz ||
-		    elf_ppnt->p_memsz > TASK_SIZE ||
-		    TASK_SIZE - elf_ppnt->p_memsz < k) {
+		if (elf_ppnt->p_filesz > elf_ppnt->p_memsz ||
+		    ! GOOD_TASK_VM_RANGE(k, elf_ppnt->p_memsz)) {
 			/* set_brk can never work.  Avoid overflows.  */
 			send_sig(SIGKILL, current, 0);
 			goto out_free_dentry;
Index: working-2.6/arch/ia64/kernel/sys_ia64.c
===================================================================
--- working-2.6.orig/arch/ia64/kernel/sys_ia64.c	2006-01-16 13:02:16.000000000 +1100
+++ working-2.6/arch/ia64/kernel/sys_ia64.c	2006-02-23 09:54:52.000000000 +1100
@@ -189,17 +189,6 @@ do_mmap2 (unsigned long addr, unsigned l
 		goto out;
 	}
 
-	/*
-	 * Don't permit mappings into unmapped space, the virtual page table of a region,
-	 * or across a region boundary.  Note: RGN_MAP_LIMIT is equal to 2^n-PAGE_SIZE
-	 * (for some integer n <= 61) and len > 0.
-	 */
-	roff = REGION_OFFSET(addr);
-	if ((len > RGN_MAP_LIMIT) || (roff > (RGN_MAP_LIMIT - len))) {
-		addr = -EINVAL;
-		goto out;
-	}
-
 	down_write(&current->mm->mmap_sem);
 	addr = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
 	up_write(&current->mm->mmap_sem);


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
