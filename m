Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbVBKUHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbVBKUHw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 15:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbVBKUHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 15:07:52 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:11205 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262328AbVBKUGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 15:06:52 -0500
Date: Fri, 11 Feb 2005 20:06:08 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, William Irwin <wli@holomorphy.com>,
       "Mr. Berkley Shands" <bshands@exegy.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] general split_vma hugetlb fix
Message-ID: <Pine.LNX.4.61.0502112001070.16247@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My recent do_munmap hugetlb fix has proved inadequate.  There are
other places (madvise, mbind, mlock, mprotect) where split_vma is
called.  Only mprotect excludes a hugetlb vma: the others are in
danger of splitting at a misaligned address, causing later BUGs.

So move the ~HPAGE_MASK check from do_munmap to split_vma itself;
and fix up those places (madvise and mlock) which expect split_vma
can fail only with -ENOMEM, and wish to convert that to -EAGAIN.
(It appears genuine that some of these syscalls should be failing
with -ENOMEM and some with -EAGAIN, so respect those behaviours.)

madvise_dontneed doesn't use split_vma, but is equally in danger
of causing a hugetlb BUG via zap_page_range.  Whereas elsewhere the
patch is permissive (allowing the operation on a hugetlb vma even when
pointless, so long as it doesn't missplit it), here we must use -EINVAL
on any hugetlb vma, since a page fault would hit the BUG in its nopage.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.11-rc3-bk8/mm/madvise.c	2004-12-24 21:36:31.000000000 +0000
+++ linux/mm/madvise.c	2005-02-11 19:07:35.000000000 +0000
@@ -8,7 +8,7 @@
 #include <linux/mman.h>
 #include <linux/pagemap.h>
 #include <linux/syscalls.h>
-
+#include <linux/hugetlb.h>
 
 /*
  * We can potentially split a vm area into separate
@@ -18,18 +18,18 @@ static long madvise_behavior(struct vm_a
 			     unsigned long end, int behavior)
 {
 	struct mm_struct * mm = vma->vm_mm;
-	int error;
+	int error = 0;
 
 	if (start != vma->vm_start) {
 		error = split_vma(mm, vma, start, 1);
 		if (error)
-			return -EAGAIN;
+			goto out;
 	}
 
 	if (end != vma->vm_end) {
 		error = split_vma(mm, vma, end, 0);
 		if (error)
-			return -EAGAIN;
+			goto out;
 	}
 
 	/*
@@ -48,7 +48,10 @@ static long madvise_behavior(struct vm_a
 		break;
 	}
 
-	return 0;
+out:
+	if (error == -ENOMEM)
+		error = -EAGAIN;
+	return error;
 }
 
 /*
@@ -94,7 +97,7 @@ static long madvise_willneed(struct vm_a
 static long madvise_dontneed(struct vm_area_struct * vma,
 			     unsigned long start, unsigned long end)
 {
-	if (vma->vm_flags & VM_LOCKED)
+	if ((vma->vm_flags & VM_LOCKED) || is_vm_hugetlb_page(vma))
 		return -EINVAL;
 
 	if (unlikely(vma->vm_flags & VM_NONLINEAR)) {
--- 2.6.11-rc3-bk8/mm/mlock.c	2005-02-03 09:06:16.000000000 +0000
+++ linux/mm/mlock.c	2005-02-11 19:07:35.000000000 +0000
@@ -21,17 +21,15 @@ static int mlock_fixup(struct vm_area_st
 		goto out;
 
 	if (start != vma->vm_start) {
-		if (split_vma(mm, vma, start, 1)) {
-			ret = -EAGAIN;
+		ret = split_vma(mm, vma, start, 1);
+		if (ret)
 			goto out;
-		}
 	}
 
 	if (end != vma->vm_end) {
-		if (split_vma(mm, vma, end, 0)) {
-			ret = -EAGAIN;
+		ret = split_vma(mm, vma, end, 0);
+		if (ret)
 			goto out;
-		}
 	}
 
 	/*
@@ -53,6 +51,8 @@ static int mlock_fixup(struct vm_area_st
 
 	vma->vm_mm->locked_vm -= pages;
 out:
+	if (ret == -ENOMEM)
+		ret = -EAGAIN;
 	return ret;
 }
 
--- 2.6.11-rc3-bk8/mm/mmap.c	2005-02-11 15:49:13.000000000 +0000
+++ linux/mm/mmap.c	2005-02-11 19:07:35.000000000 +0000
@@ -1747,6 +1747,9 @@ int split_vma(struct mm_struct * mm, str
 	struct mempolicy *pol;
 	struct vm_area_struct *new;
 
+	if (is_vm_hugetlb_page(vma) && (addr & ~HPAGE_MASK))
+		return -EINVAL;
+
 	if (mm->map_count >= sysctl_max_map_count)
 		return -ENOMEM;
 
@@ -1821,20 +1824,18 @@ int do_munmap(struct mm_struct *mm, unsi
 	 * places tmp vma above, and higher split_vma places tmp vma below.
 	 */
 	if (start > mpnt->vm_start) {
-		if (is_vm_hugetlb_page(mpnt) && (start & ~HPAGE_MASK))
-			return -EINVAL;
-		if (split_vma(mm, mpnt, start, 0))
-			return -ENOMEM;
+		int error = split_vma(mm, mpnt, start, 0);
+		if (error)
+			return error;
 		prev = mpnt;
 	}
 
 	/* Does it split the last one? */
 	last = find_vma(mm, end);
 	if (last && end > last->vm_start) {
-		if (is_vm_hugetlb_page(last) && (end & ~HPAGE_MASK))
-			return -EINVAL;
-		if (split_vma(mm, last, end, 1))
-			return -ENOMEM;
+		int error = split_vma(mm, last, end, 1);
+		if (error)
+			return error;
 	}
 	mpnt = prev? prev->vm_next: mm->mmap;
 
