Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262479AbVBYWG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbVBYWG0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 17:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262582AbVBYWG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 17:06:26 -0500
Received: from fire.osdl.org ([65.172.181.4]:64419 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262479AbVBYWFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 17:05:53 -0500
Date: Fri, 25 Feb 2005 14:05:43 -0800
From: Chris Wright <chrisw@osdl.org>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: hugh@veritas.com, akpm@osdl.org, chrisw@osdl.org, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: [PATCH] allow vma merging with mlock et. al.
Message-ID: <20050225220543.GC15867@shell0.pdx.osdl.net>
References: <421E74B5.3040701@us.ibm.com> <20050225171122.GE28536@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050225171122.GE28536@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Wright (chrisw@osdl.org) wrote:
> * Darren Hart (dvhltc@us.ibm.com) wrote:
> > The were a couple long standing (since at least 2.4.21) superfluous 
> > variables and two unnecessary assignments in do_mlock().  The intent of 
> > the resulting code is also more obvious.
> > 
> > Tested on a 4 way x86 box running a simple mlock test program.  No 
> > problems detected.
> 
> Did you test with multiple page ranges, and locking subsets of vmas?
> Seems that splitting could cause a problem since you now sample vm_end
> before and after fixup, where the vma could be changed in the middle.

Actually I think it winds up being fine since we don't do merging with
mlock.  But why not?  Patch below remedies that.

thanks,
-chris
--

Successive mlock/munlock calls can leave fragmented vmas because they can
be split but not merged.  Give mlock et. al. full vma merging support.

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== mm/mlock.c 1.19 vs edited =====
--- 1.19/mm/mlock.c	2005-02-11 11:07:35 -08:00
+++ edited/mm/mlock.c	2005-02-24 23:53:10 -08:00
@@ -7,18 +7,32 @@
 
 #include <linux/mman.h>
 #include <linux/mm.h>
+#include <linux/mempolicy.h>
 #include <linux/syscalls.h>
 
 
-static int mlock_fixup(struct vm_area_struct * vma, 
+static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
 	unsigned long start, unsigned long end, unsigned int newflags)
 {
 	struct mm_struct * mm = vma->vm_mm;
+	pgoff_t pgoff;
 	int pages;
 	int ret = 0;
 
-	if (newflags == vma->vm_flags)
+	if (newflags == vma->vm_flags) {
+		*prev = vma;
 		goto out;
+	}
+
+	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
+	*prev = vma_merge(mm, *prev, start, end, newflags, vma->anon_vma,
+			  vma->vm_file, pgoff, vma_policy(vma));
+	if (*prev) {
+		vma = *prev;
+		goto success;
+	}
+
+	*prev = vma;
 
 	if (start != vma->vm_start) {
 		ret = split_vma(mm, vma, start, 1);
@@ -32,6 +46,7 @@ static int mlock_fixup(struct vm_area_st
 			goto out;
 	}
 
+success:
 	/*
 	 * vm_flags is protected by the mmap_sem held in write mode.
 	 * It's okay if try_to_unmap_one unmaps a page just after we
@@ -59,7 +74,7 @@ out:
 static int do_mlock(unsigned long start, size_t len, int on)
 {
 	unsigned long nstart, end, tmp;
-	struct vm_area_struct * vma, * next;
+	struct vm_area_struct * vma, * prev;
 	int error;
 
 	len = PAGE_ALIGN(len);
@@ -68,7 +83,7 @@ static int do_mlock(unsigned long start,
 		return -EINVAL;
 	if (end == start)
 		return 0;
-	vma = find_vma(current->mm, start);
+	vma = find_vma_prev(current->mm, start, &prev);
 	if (!vma || vma->vm_start > start)
 		return -ENOMEM;
 
@@ -81,18 +96,19 @@ static int do_mlock(unsigned long start,
 		if (!on)
 			newflags &= ~VM_LOCKED;
 
-		if (vma->vm_end >= end) {
-			error = mlock_fixup(vma, nstart, end, newflags);
-			break;
-		}
-
 		tmp = vma->vm_end;
-		next = vma->vm_next;
-		error = mlock_fixup(vma, nstart, tmp, newflags);
+		if (tmp > end)
+			tmp = end;
+		error = mlock_fixup(vma, &prev, nstart, tmp, newflags);
 		if (error)
 			break;
 		nstart = tmp;
-		vma = next;
+		if (nstart < prev->vm_end)
+			nstart = prev->vm_end;
+		if (nstart >= end)
+			break;
+
+		vma = prev->vm_next;
 		if (!vma || vma->vm_start != nstart) {
 			error = -ENOMEM;
 			break;
@@ -141,7 +157,7 @@ asmlinkage long sys_munlock(unsigned lon
 
 static int do_mlockall(int flags)
 {
-	struct vm_area_struct * vma;
+	struct vm_area_struct * vma, * prev;
 	unsigned int def_flags = 0;
 
 	if (flags & MCL_FUTURE)
@@ -150,7 +166,7 @@ static int do_mlockall(int flags)
 	if (flags == MCL_FUTURE)
 		goto out;
 
-	for (vma = current->mm->mmap; vma ; vma = vma->vm_next) {
+	for (prev = vma = current->mm->mmap; vma ; vma = vma->vm_next) {
 		unsigned int newflags;
 
 		newflags = vma->vm_flags | VM_LOCKED;
@@ -158,7 +174,8 @@ static int do_mlockall(int flags)
 			newflags &= ~VM_LOCKED;
 
 		/* Ignore errors */
-		mlock_fixup(vma, vma->vm_start, vma->vm_end, newflags);
+		mlock_fixup(vma, &prev, vma->vm_start, vma->vm_end, newflags);
+		vma = prev;
 	}
 out:
 	return 0;
