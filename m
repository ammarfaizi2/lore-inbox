Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWFGBjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWFGBjJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 21:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWFGBjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 21:39:08 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:20096 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750759AbWFGBjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 21:39:07 -0400
Message-ID: <44862CE3.7040406@comcast.net>
Date: Tue, 06 Jun 2006 21:33:23 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060522)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] Clean-up:  TASK_UNMAPPED_BASE and mmap_base
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF45841675FD3742EB2EE5F29"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF45841675FD3742EB2EE5F29
Content-Type: multipart/mixed;
 boundary="------------090401070502080209000603"

This is a multi-part message in MIME format.
--------------090401070502080209000603
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This patch applies to 2.6.17-rc6 to replace several occurrences of
TASK_UNMAPPED_BASE with current->mm->mmap_base, mm->mmap_base, or base,
as appropriate.

I am not entirely sure what all of the code I messed with is doing, to
be quite honest.  Code that seemed to be initializing a task and setting
up the mmap() base I left with TASK_UNMAPPED_BASE; code that seemed to
be trying to figure out what the mmap() base was I replaced with
mm->mmap_base.

Because of this, I may have made a couple errors.  Could I get some
comments on whether any of this is dirty and why?  I'll make appropriate
changes and re-submit.  This only took 2 hours anyway.

--=20
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension

--------------090401070502080209000603
Content-Type: text/x-patch;
 name="patch-2.6.17-rc6-tub-mmap_base.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="patch-2.6.17-rc6-tub-mmap_base.diff"

diff -urNp linux-2.6.17-rc6/arch/alpha/kernel/osf_sys.c linux-2.6.17-rc6-=
fix_tub/arch/alpha/kernel/osf_sys.c
--- linux-2.6.17-rc6/arch/alpha/kernel/osf_sys.c	2006-06-06 19:37:52.0000=
00000 -0400
+++ linux-2.6.17-rc6-fix_tub/arch/alpha/kernel/osf_sys.c	2006-06-06 20:20=
:27.000000000 -0400
@@ -1279,8 +1279,8 @@ arch_get_unmapped_area(struct file *filp
 			return addr;
 	}
=20
-	/* Next, try allocating at TASK_UNMAPPED_BASE.  */
-	addr =3D arch_get_unmapped_area_1 (PAGE_ALIGN(TASK_UNMAPPED_BASE),
+	/* Next, try allocating at current->mm->mmap_base.  */
+	addr =3D arch_get_unmapped_area_1 (PAGE_ALIGN(current->mm->mmap_base),
 					 len, limit);
 	if (addr !=3D (unsigned long) -ENOMEM)
 		return addr;
diff -urNp linux-2.6.17-rc6/arch/arm/mm/mmap.c linux-2.6.17-rc6-fix_tub/a=
rch/arm/mm/mmap.c
--- linux-2.6.17-rc6/arch/arm/mm/mmap.c	2006-06-06 19:37:52.000000000 -04=
00
+++ linux-2.6.17-rc6-fix_tub/arch/arm/mm/mmap.c	2006-06-06 20:31:59.00000=
0000 -0400
@@ -76,7 +76,7 @@ arch_get_unmapped_area(struct file *filp
 	if (len > mm->cached_hole_size) {
 	        start_addr =3D addr =3D mm->free_area_cache;
 	} else {
-	        start_addr =3D addr =3D TASK_UNMAPPED_BASE;
+	        start_addr =3D addr =3D mm->mmap_base;
 	        mm->cached_hole_size =3D 0;
 	}
=20
@@ -93,8 +93,8 @@ full_search:
 			 * Start a new search - just in case we missed
 			 * some holes.
 			 */
-			if (start_addr !=3D TASK_UNMAPPED_BASE) {
-				start_addr =3D addr =3D TASK_UNMAPPED_BASE;
+			if (start_addr !=3D mm->mmap_base) {
+				start_addr =3D addr =3D mm->mmap_base;
 				mm->cached_hole_size =3D 0;
 				goto full_search;
 			}
diff -urNp linux-2.6.17-rc6/arch/i386/mm/hugetlbpage.c linux-2.6.17-rc6-f=
ix_tub/arch/i386/mm/hugetlbpage.c
--- linux-2.6.17-rc6/arch/i386/mm/hugetlbpage.c	2006-06-06 19:37:52.00000=
0000 -0400
+++ linux-2.6.17-rc6-fix_tub/arch/i386/mm/hugetlbpage.c	2006-06-06 20:44:=
53.000000000 -0400
@@ -126,7 +126,7 @@ static unsigned long hugetlb_get_unmappe
 	if (len > mm->cached_hole_size) {
 	        start_addr =3D mm->free_area_cache;
 	} else {
-	        start_addr =3D TASK_UNMAPPED_BASE;
+	        start_addr =3D mm->mmap_base;
 	        mm->cached_hole_size =3D 0;
 	}
=20
@@ -140,8 +140,8 @@ full_search:
 			 * Start a new search - just in case we missed
 			 * some holes.
 			 */
-			if (start_addr !=3D TASK_UNMAPPED_BASE) {
-				start_addr =3D TASK_UNMAPPED_BASE;
+			if (start_addr !=3D mm->mmap_base) {
+				start_addr =3D mm->mmap_base;
 				mm->cached_hole_size =3D 0;
 				goto full_search;
 			}
@@ -232,7 +232,7 @@ fail:
 	 * can happen with large stack limits and large mmap()
 	 * allocations.
 	 */
-	mm->free_area_cache =3D TASK_UNMAPPED_BASE;
+	mm->free_area_cache =3D base;
 	mm->cached_hole_size =3D ~0UL;
 	addr =3D hugetlb_get_unmapped_area_bottomup(file, addr0,
 			len, pgoff, flags);
diff -urNp linux-2.6.17-rc6/arch/ia64/kernel/sys_ia64.c linux-2.6.17-rc6-=
fix_tub/arch/ia64/kernel/sys_ia64.c
--- linux-2.6.17-rc6/arch/ia64/kernel/sys_ia64.c	2006-06-06 19:37:52.0000=
00000 -0400
+++ linux-2.6.17-rc6-fix_tub/arch/ia64/kernel/sys_ia64.c	2006-06-06 20:52=
:09.000000000 -0400
@@ -56,9 +56,9 @@ arch_get_unmapped_area (struct file *fil
 	for (vma =3D find_vma(mm, addr); ; vma =3D vma->vm_next) {
 		/* At this point:  (!vma || addr < vma->vm_end). */
 		if (TASK_SIZE - len < addr || RGN_MAP_LIMIT - len < REGION_OFFSET(addr=
)) {
-			if (start_addr !=3D TASK_UNMAPPED_BASE) {
+			if (start_addr !=3D mm->mmap_base) {
 				/* Start a new search --- just in case we missed some holes.  */
-				addr =3D TASK_UNMAPPED_BASE;
+				addr =3D mm->mmap_base;
 				goto full_search;
 			}
 			return -ENOMEM;
diff -urNp linux-2.6.17-rc6/arch/mips/kernel/syscall.c linux-2.6.17-rc6-f=
ix_tub/arch/mips/kernel/syscall.c
--- linux-2.6.17-rc6/arch/mips/kernel/syscall.c	2006-06-06 19:37:52.00000=
0000 -0400
+++ linux-2.6.17-rc6-fix_tub/arch/mips/kernel/syscall.c	2006-06-06 20:53:=
45.000000000 -0400
@@ -99,7 +99,7 @@ unsigned long arch_get_unmapped_area(str
 		    (!vmm || addr + len <=3D vmm->vm_start))
 			return addr;
 	}
-	addr =3D TASK_UNMAPPED_BASE;
+	addr =3D current->mm->mmap_base;
 	if (do_color_align)
 		addr =3D COLOUR_ALIGN(addr, pgoff);
 	else
diff -urNp linux-2.6.17-rc6/arch/parisc/kernel/sys_parisc.c linux-2.6.17-=
rc6-fix_tub/arch/parisc/kernel/sys_parisc.c
--- linux-2.6.17-rc6/arch/parisc/kernel/sys_parisc.c	2006-06-06 19:37:52.=
000000000 -0400
+++ linux-2.6.17-rc6-fix_tub/arch/parisc/kernel/sys_parisc.c	2006-06-06 2=
0:20:27.000000000 -0400
@@ -105,7 +105,7 @@ unsigned long arch_get_unmapped_area(str
 	if (len > TASK_SIZE)
 		return -ENOMEM;
 	if (!addr)
-		addr =3D TASK_UNMAPPED_BASE;
+		addr =3D current->mm->mmap_base;
=20
 	if (filp) {
 		addr =3D get_shared_area(filp->f_mapping, addr, len, pgoff);
diff -urNp linux-2.6.17-rc6/arch/powerpc/mm/hugetlbpage.c linux-2.6.17-rc=
6-fix_tub/arch/powerpc/mm/hugetlbpage.c
--- linux-2.6.17-rc6/arch/powerpc/mm/hugetlbpage.c	2006-06-06 19:37:52.00=
0000000 -0400
+++ linux-2.6.17-rc6-fix_tub/arch/powerpc/mm/hugetlbpage.c	2006-06-06 20:=
56:21.000000000 -0400
@@ -573,7 +573,7 @@ unsigned long arch_get_unmapped_area(str
 	if (len > mm->cached_hole_size) {
 	        start_addr =3D addr =3D mm->free_area_cache;
 	} else {
-	        start_addr =3D addr =3D TASK_UNMAPPED_BASE;
+	        start_addr =3D addr =3D mm->mmap_base;
 	        mm->cached_hole_size =3D 0;
 	}
=20
@@ -606,8 +606,8 @@ full_search:
 	}
=20
 	/* Make sure we didn't miss any holes */
-	if (start_addr !=3D TASK_UNMAPPED_BASE) {
-		start_addr =3D addr =3D TASK_UNMAPPED_BASE;
+	if (start_addr !=3D mm->mmap_base) {
+		start_addr =3D addr =3D mm->mmap_base;
 		mm->cached_hole_size =3D 0;
 		goto full_search;
 	}
@@ -721,7 +721,7 @@ fail:
 	 * can happen with large stack limits and large mmap()
 	 * allocations.
 	 */
-	mm->free_area_cache =3D TASK_UNMAPPED_BASE;
+	mm->free_area_cache =3D base;
 	mm->cached_hole_size =3D ~0UL;
 	addr =3D arch_get_unmapped_area(filp, addr0, len, pgoff, flags);
 	/*
diff -urNp linux-2.6.17-rc6/arch/powerpc/mm/slb.c linux-2.6.17-rc6-fix_tu=
b/arch/powerpc/mm/slb.c
--- linux-2.6.17-rc6/arch/powerpc/mm/slb.c	2006-06-06 19:37:52.000000000 =
-0400
+++ linux-2.6.17-rc6-fix_tub/arch/powerpc/mm/slb.c	2006-06-06 21:06:24.00=
0000000 -0400
@@ -128,11 +128,11 @@ void switch_slb(struct task_struct *tsk,
=20
 	/*
 	 * preload some userspace segments into the SLB.
+	 *=20
+	 * I'm pretty sure the task's mmap base is correct
+	 * for its processor mode (32/64 bit) --JM
 	 */
-	if (test_tsk_thread_flag(tsk, TIF_32BIT))
-		unmapped_base =3D TASK_UNMAPPED_BASE_USER32;
-	else
-		unmapped_base =3D TASK_UNMAPPED_BASE_USER64;
+	unmapped_base =3D mm->mmap_base;
=20
 	if (is_kernel_addr(pc))
 		return;
diff -urNp linux-2.6.17-rc6/arch/powerpc/mm/stab.c linux-2.6.17-rc6-fix_t=
ub/arch/powerpc/mm/stab.c
--- linux-2.6.17-rc6/arch/powerpc/mm/stab.c	2006-06-06 19:37:52.000000000=
 -0400
+++ linux-2.6.17-rc6-fix_tub/arch/powerpc/mm/stab.c	2006-06-06 21:07:39.0=
00000000 -0400
@@ -204,11 +204,12 @@ void switch_stab(struct task_struct *tsk
 	get_paca()->pgdir =3D mm->pgd;
 #endif /* CONFIG_PPC_64K_PAGES */
=20
-	/* Now preload some entries for the new task */
-	if (test_tsk_thread_flag(tsk, TIF_32BIT))
-		unmapped_base =3D TASK_UNMAPPED_BASE_USER32;
-	else
-		unmapped_base =3D TASK_UNMAPPED_BASE_USER64;
+	/*
+	 *  Now preload some entries for the new task
+	 *
+	 *  The task's current mmap base is probably right.
+	 */
+	unmapped_base =3D mm->mmap_base;
=20
 	__ste_allocate(pc, mm);
=20
diff -urNp linux-2.6.17-rc6/arch/sh/kernel/sys_sh.c linux-2.6.17-rc6-fix_=
tub/arch/sh/kernel/sys_sh.c
--- linux-2.6.17-rc6/arch/sh/kernel/sys_sh.c	2006-06-06 19:37:52.00000000=
0 -0400
+++ linux-2.6.17-rc6-fix_tub/arch/sh/kernel/sys_sh.c	2006-06-06 21:13:39.=
000000000 -0400
@@ -81,7 +81,7 @@ unsigned long arch_get_unmapped_area(str
 	}
 	if (len <=3D mm->cached_hole_size) {
 	        mm->cached_hole_size =3D 0;
-		mm->free_area_cache =3D TASK_UNMAPPED_BASE;
+		mm->free_area_cache =3D mm->mmap_base;
 	}
 	if (flags & MAP_PRIVATE)
 		addr =3D PAGE_ALIGN(mm->free_area_cache);
@@ -97,8 +97,8 @@ full_search:
 			 * Start a new search - just in case we missed
 			 * some holes.
 			 */
-			if (start_addr !=3D TASK_UNMAPPED_BASE) {
-				start_addr =3D addr =3D TASK_UNMAPPED_BASE;
+			if (start_addr !=3D mm->mmap_base) {
+				start_addr =3D addr =3D mm->mmap_base;
 				mm->cached_hole_size =3D 0;
 				goto full_search;
 			}
diff -urNp linux-2.6.17-rc6/arch/sh64/kernel/sys_sh64.c linux-2.6.17-rc6-=
fix_tub/arch/sh64/kernel/sys_sh64.c
--- linux-2.6.17-rc6/arch/sh64/kernel/sys_sh64.c	2006-06-06 19:37:52.0000=
00000 -0400
+++ linux-2.6.17-rc6-fix_tub/arch/sh64/kernel/sys_sh64.c	2006-06-06 20:20=
:27.000000000 -0400
@@ -112,7 +112,7 @@ unsigned long arch_get_unmapped_area(str
 	if (len > TASK_SIZE)
 		return -ENOMEM;
 	if (!addr)
-		addr =3D TASK_UNMAPPED_BASE;
+		addr =3D current->mm->mmap_base;
=20
 	if (flags & MAP_PRIVATE)
 		addr =3D PAGE_ALIGN(addr);
diff -urNp linux-2.6.17-rc6/arch/sparc/kernel/sys_sparc.c linux-2.6.17-rc=
6-fix_tub/arch/sparc/kernel/sys_sparc.c
--- linux-2.6.17-rc6/arch/sparc/kernel/sys_sparc.c	2006-06-06 19:37:52.00=
0000000 -0400
+++ linux-2.6.17-rc6-fix_tub/arch/sparc/kernel/sys_sparc.c	2006-06-06 20:=
20:27.000000000 -0400
@@ -56,7 +56,7 @@ unsigned long arch_get_unmapped_area(str
 	if (ARCH_SUN4C_SUN4 && len > 0x20000000)
 		return -ENOMEM;
 	if (!addr)
-		addr =3D TASK_UNMAPPED_BASE;
+		addr =3D current->mm->mmap_base;
=20
 	if (flags & MAP_SHARED)
 		addr =3D COLOUR_ALIGN(addr);
diff -urNp linux-2.6.17-rc6/arch/sparc64/kernel/sys_sparc.c linux-2.6.17-=
rc6-fix_tub/arch/sparc64/kernel/sys_sparc.c
--- linux-2.6.17-rc6/arch/sparc64/kernel/sys_sparc.c	2006-06-06 19:37:52.=
000000000 -0400
+++ linux-2.6.17-rc6-fix_tub/arch/sparc64/kernel/sys_sparc.c	2006-06-06 2=
1:16:27.000000000 -0400
@@ -155,7 +155,7 @@ unsigned long arch_get_unmapped_area(str
 	if (len > mm->cached_hole_size) {
 	        start_addr =3D addr =3D mm->free_area_cache;
 	} else {
-	        start_addr =3D addr =3D TASK_UNMAPPED_BASE;
+	        start_addr =3D addr =3D mm->mmap_base;
 	        mm->cached_hole_size =3D 0;
 	}
=20
@@ -175,8 +175,8 @@ full_search:
 			vma =3D find_vma(mm, VA_EXCLUDE_END);
 		}
 		if (unlikely(task_size < addr)) {
-			if (start_addr !=3D TASK_UNMAPPED_BASE) {
-				start_addr =3D addr =3D TASK_UNMAPPED_BASE;
+			if (start_addr !=3D mm->mmap_base) {
+				start_addr =3D addr =3D mm->mmap_base;
 				mm->cached_hole_size =3D 0;
 				goto full_search;
 			}
@@ -302,7 +302,7 @@ bottomup:
 	 * allocations.
 	 */
 	mm->cached_hole_size =3D ~0UL;
-  	mm->free_area_cache =3D TASK_UNMAPPED_BASE;
+  	mm->free_area_cache =3D mm->mmap_base;
 	addr =3D arch_get_unmapped_area(filp, addr0, len, pgoff, flags);
 	/*
 	 * Restore the topdown base:
diff -urNp linux-2.6.17-rc6/arch/sparc64/mm/hugetlbpage.c linux-2.6.17-rc=
6-fix_tub/arch/sparc64/mm/hugetlbpage.c
--- linux-2.6.17-rc6/arch/sparc64/mm/hugetlbpage.c	2006-06-06 19:37:52.00=
0000000 -0400
+++ linux-2.6.17-rc6-fix_tub/arch/sparc64/mm/hugetlbpage.c	2006-06-06 21:=
18:03.000000000 -0400
@@ -47,7 +47,7 @@ static unsigned long hugetlb_get_unmappe
 	if (len > mm->cached_hole_size) {
 	        start_addr =3D addr =3D mm->free_area_cache;
 	} else {
-	        start_addr =3D addr =3D TASK_UNMAPPED_BASE;
+	        start_addr =3D addr =3D mm->mmap_base;
 	        mm->cached_hole_size =3D 0;
 	}
=20
@@ -64,8 +64,8 @@ full_search:
 			vma =3D find_vma(mm, VA_EXCLUDE_END);
 		}
 		if (unlikely(task_size < addr)) {
-			if (start_addr !=3D TASK_UNMAPPED_BASE) {
-				start_addr =3D addr =3D TASK_UNMAPPED_BASE;
+			if (start_addr !=3D mm->mmap_base) {
+				start_addr =3D addr =3D mm->mmap_base;
 				mm->cached_hole_size =3D 0;
 				goto full_search;
 			}
@@ -149,7 +149,7 @@ bottomup:
 	 * allocations.
 	 */
 	mm->cached_hole_size =3D ~0UL;
-  	mm->free_area_cache =3D TASK_UNMAPPED_BASE;
+  	mm->free_area_cache =3D mm->mmap_base;
 	addr =3D arch_get_unmapped_area(filp, addr0, len, pgoff, flags);
 	/*
 	 * Restore the topdown base:
diff -urNp linux-2.6.17-rc6/arch/x86_64/kernel/sys_x86_64.c linux-2.6.17-=
rc6-fix_tub/arch/x86_64/kernel/sys_x86_64.c
--- linux-2.6.17-rc6/arch/x86_64/kernel/sys_x86_64.c	2006-06-06 19:37:52.=
000000000 -0400
+++ linux-2.6.17-rc6-fix_tub/arch/x86_64/kernel/sys_x86_64.c	2006-06-06 2=
1:22:39.000000000 -0400
@@ -79,7 +79,7 @@ static void find_start_end(unsigned long
 		*begin =3D 0x40000000;=20
 		*end =3D 0x80000000;	=09
 	} else {
-		*begin =3D TASK_UNMAPPED_BASE;
+		*begin =3D current->mm->mmap_base;
 		*end =3D TASK_SIZE;=20
 	}
 }=20
diff -urNp linux-2.6.17-rc6/fs/hugetlbfs/inode.c linux-2.6.17-rc6-fix_tub=
/fs/hugetlbfs/inode.c
--- linux-2.6.17-rc6/fs/hugetlbfs/inode.c	2006-06-06 19:37:52.000000000 -=
0400
+++ linux-2.6.17-rc6-fix_tub/fs/hugetlbfs/inode.c	2006-06-06 21:23:38.000=
000000 -0400
@@ -133,7 +133,7 @@ hugetlb_get_unmapped_area(struct file *f
 	start_addr =3D mm->free_area_cache;
=20
 	if (len <=3D mm->cached_hole_size)
-		start_addr =3D TASK_UNMAPPED_BASE;
+		start_addr =3D mm->mmap_base;
=20
 full_search:
 	addr =3D ALIGN(start_addr, HPAGE_SIZE);
@@ -145,8 +145,8 @@ full_search:
 			 * Start a new search - just in case we missed
 			 * some holes.
 			 */
-			if (start_addr !=3D TASK_UNMAPPED_BASE) {
-				start_addr =3D TASK_UNMAPPED_BASE;
+			if (start_addr !=3D mm->mmap_base) {
+				start_addr =3D mm->mmap_base;
 				goto full_search;
 			}
 			return -ENOMEM;
diff -urNp linux-2.6.17-rc6/kernel/fork.c linux-2.6.17-rc6-fix_tub/kernel=
/fork.c
--- linux-2.6.17-rc6/kernel/fork.c	2006-06-06 19:37:52.000000000 -0400
+++ linux-2.6.17-rc6-fix_tub/kernel/fork.c	2006-06-06 20:20:27.000000000 =
-0400
@@ -324,7 +324,7 @@ static struct mm_struct * mm_init(struct
 	spin_lock_init(&mm->page_table_lock);
 	rwlock_init(&mm->ioctx_list_lock);
 	mm->ioctx_list =3D NULL;
-	mm->free_area_cache =3D TASK_UNMAPPED_BASE;
+	mm->free_area_cache =3D mm->mmap_base;
 	mm->cached_hole_size =3D ~0UL;
=20
 	if (likely(!mm_alloc_pgd(mm))) {
diff -urNp linux-2.6.17-rc6/mm/mmap.c linux-2.6.17-rc6-fix_tub/mm/mmap.c
--- linux-2.6.17-rc6/mm/mmap.c	2006-06-06 19:37:52.000000000 -0400
+++ linux-2.6.17-rc6-fix_tub/mm/mmap.c	2006-06-06 21:25:48.000000000 -040=
0
@@ -1188,7 +1188,7 @@ arch_get_unmapped_area(struct file *filp
 	if (len > mm->cached_hole_size) {
 	        start_addr =3D addr =3D mm->free_area_cache;
 	} else {
-	        start_addr =3D addr =3D TASK_UNMAPPED_BASE;
+	        start_addr =3D addr =3D mm->mmap_base;
 	        mm->cached_hole_size =3D 0;
 	}
=20
@@ -1200,8 +1200,8 @@ full_search:
 			 * Start a new search - just in case we missed
 			 * some holes.
 			 */
-			if (start_addr !=3D TASK_UNMAPPED_BASE) {
-				addr =3D TASK_UNMAPPED_BASE;
+			if (start_addr !=3D mm->mmap_base) {
+				addr =3D mm->mmap_base;
 			        start_addr =3D addr;
 				mm->cached_hole_size =3D 0;
 				goto full_search;
@@ -1227,7 +1227,7 @@ void arch_unmap_area(struct mm_struct *m
 	/*
 	 * Is this a new hole at the lowest possible address?
 	 */
-	if (addr >=3D TASK_UNMAPPED_BASE && addr < mm->free_area_cache) {
+	if (addr >=3D mm->mmap_base && addr < mm->free_area_cache) {
 		mm->free_area_cache =3D addr;
 		mm->cached_hole_size =3D ~0UL;
 	}
@@ -1309,7 +1309,7 @@ bottomup:
 	 * allocations.
 	 */
 	mm->cached_hole_size =3D ~0UL;
-  	mm->free_area_cache =3D TASK_UNMAPPED_BASE;
+  	mm->free_area_cache =3D mm->mmap_base;
 	addr =3D arch_get_unmapped_area(filp, addr0, len, pgoff, flags);
 	/*
 	 * Restore the topdown base:

--------------090401070502080209000603--

--------------enigF45841675FD3742EB2EE5F29
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRIYs4ws1xW0HCTEFAQL3AQ/+KQTBM/fctV9B4FmQy+mnWxYVZPVCSp0W
UVLyf/c0WzVFH5SkQfozWkggOP9HWvz9k/OIuYuq0hug1XIIRmZJWsyP7YNRmI8v
ulfjlsPaE8WqjsidBgaWNrEDcbslZvfkU0Bu+977+1ixtxj2DZQl4xt7oN9mmCo2
oiR3w4gU6f7ypBA2PoDlF+Xjm1SSOnKoSaVt0Ru0Ie1MjNlNDSkjRzuL677/qt5H
JgmnA2mMpqFejGNYLOm8jXG50EmivgqX/GDnrUWrbXHi5wikLgN1Dciykyt5K0b+
oYCj4FqDfF0IQbSLKFWO452byqqxp2ldRLIgTB1iCtu7RtyYpNW86w5qhPVBKRak
i0IT+GwY2K7q8SDqh7w9dLbeG8kL8cYUG9VHhkzJZW7zVA+2Wfdg7uvlv583OXDx
LT+gNZARAOqlzWNJo1j2TP5wwRuQBY07PWlzMvOHwEj6rRQfye3v6vz85lS9wRK9
MH1Ruhscor8/ooWRx2nqgURlFXjkh360lr3FE8RUIF5KXB7PiXponHSPg1tPxU39
cgIQtWSnP8vO4a8V32K7VlEi7KXiaDN+9hBCNgpavGAXzXDWnvY74dXSwk25yhlM
WlE/NgMB7RBmywu/yUONinc33+tbqQLYHVZ3vAh2rt4weDRcpY9mRe/yzZ1PUJaX
J5PaAh8h4ms=
=EzqY
-----END PGP SIGNATURE-----

--------------enigF45841675FD3742EB2EE5F29--
