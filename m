Return-Path: <linux-kernel-owner+w=401wt.eu-S1751140AbXAFCgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbXAFCgA (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbXAFCdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:33:37 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36932 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751140AbXAFCdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:33:31 -0500
Message-Id: <20070106023734.211998000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:43 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Linus Torvalds <torvalds@woody.osdl.org>,
       Doug Chapman <dchapman@redhat.com>,
       Marcel Holtmann <holtmann@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: [patch 50/50] Fix incorrect user space access locking in mincore() (CVE-2006-4814)
Content-Disposition: inline; filename=fix-incorrect-user-space-access-locking-in-mincore.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Linus Torvalds <torvalds@woody.osdl.org>

Doug Chapman noticed that mincore() will doa "copy_to_user()" of the
result while holding the mmap semaphore for reading, which is a big
no-no.  While a recursive read-lock on a semaphore in the case of a page
fault happens to work, we don't actually allow them due to deadlock
schenarios with writers due to fairness issues.

Doug and Marcel sent in a patch to fix it, but I decided to just rewrite
the mess instead - not just fixing the locking problem, but making the
code smaller and (imho) much easier to understand.

Cc: Doug Chapman <dchapman@redhat.com>
Cc: Marcel Holtmann <holtmann@redhat.com>
Cc: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>
[chrisw: fold in subsequent fix: 4fb23e439ce0]
Acked-by: Hugh Dickins <hugh@veritas.com>
[chrisw: fold in subsequent fix: 825020c3866e]
Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 mm/mincore.c |  181 +++++++++++++++++++++++++----------------------------------
 1 file changed, 77 insertions(+), 104 deletions(-)

--- linux-2.6.19.1.orig/mm/mincore.c
+++ linux-2.6.19.1/mm/mincore.c
@@ -1,7 +1,7 @@
 /*
  *	linux/mm/mincore.c
  *
- * Copyright (C) 1994-1999  Linus Torvalds
+ * Copyright (C) 1994-2006  Linus Torvalds
  */
 
 /*
@@ -38,46 +38,51 @@ static unsigned char mincore_page(struct
 	return present;
 }
 
-static long mincore_vma(struct vm_area_struct * vma,
-	unsigned long start, unsigned long end, unsigned char __user * vec)
+/*
+ * Do a chunk of "sys_mincore()". We've already checked
+ * all the arguments, we hold the mmap semaphore: we should
+ * just return the amount of info we're asked for.
+ */
+static long do_mincore(unsigned long addr, unsigned char *vec, unsigned long pages)
 {
-	long error, i, remaining;
-	unsigned char * tmp;
-
-	error = -ENOMEM;
-	if (!vma->vm_file)
-		return error;
-
-	start = ((start - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
-	if (end > vma->vm_end)
-		end = vma->vm_end;
-	end = ((end - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
-
-	error = -EAGAIN;
-	tmp = (unsigned char *) __get_free_page(GFP_KERNEL);
-	if (!tmp)
-		return error;
-
-	/* (end - start) is # of pages, and also # of bytes in "vec */
-	remaining = (end - start),
+	unsigned long i, nr, pgoff;
+	struct vm_area_struct *vma = find_vma(current->mm, addr);
 
-	error = 0;
-	for (i = 0; remaining > 0; remaining -= PAGE_SIZE, i++) {
-		int j = 0;
-		long thispiece = (remaining < PAGE_SIZE) ?
-						remaining : PAGE_SIZE;
+	/*
+	 * find_vma() didn't find anything above us, or we're
+	 * in an unmapped hole in the address space: ENOMEM.
+	 */
+	if (!vma || addr < vma->vm_start)
+		return -ENOMEM;
 
-		while (j < thispiece)
-			tmp[j++] = mincore_page(vma, start++);
+	/*
+	 * Ok, got it. But check whether it's a segment we support
+	 * mincore() on. Right now, we don't do any anonymous mappings.
+	 *
+	 * FIXME: This is just stupid. And returning ENOMEM is 
+	 * stupid too. We should just look at the page tables. But
+	 * this is what we've traditionally done, so we'll just
+	 * continue doing it.
+	 */
+	if (!vma->vm_file)
+		return -ENOMEM;
 
-		if (copy_to_user(vec + PAGE_SIZE * i, tmp, thispiece)) {
-			error = -EFAULT;
-			break;
-		}
-	}
+	/*
+	 * Calculate how many pages there are left in the vma, and
+	 * what the pgoff is for our address.
+	 */
+	nr = (vma->vm_end - addr) >> PAGE_SHIFT;
+	if (nr > pages)
+		nr = pages;
+
+	pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
+	pgoff += vma->vm_pgoff;
+
+	/* And then we just fill the sucker in.. */
+	for (i = 0 ; i < nr; i++, pgoff++)
+		vec[i] = mincore_page(vma, pgoff);
 
-	free_page((unsigned long) tmp);
-	return error;
+	return nr;
 }
 
 /*
@@ -107,82 +112,50 @@ static long mincore_vma(struct vm_area_s
 asmlinkage long sys_mincore(unsigned long start, size_t len,
 	unsigned char __user * vec)
 {
-	int index = 0;
-	unsigned long end, limit;
-	struct vm_area_struct * vma;
-	size_t max;
-	int unmapped_error = 0;
-	long error;
+	long retval;
+	unsigned long pages;
+	unsigned char *tmp;
 
-	/* check the arguments */
+	/* Check the start address: needs to be page-aligned.. */
  	if (start & ~PAGE_CACHE_MASK)
-		goto einval;
-
-	limit = TASK_SIZE;
-	if (start >= limit)
-		goto enomem;
+		return -EINVAL;
 
-	if (!len)
-		return 0;
+	/* ..and we need to be passed a valid user-space range */
+	if (!access_ok(VERIFY_READ, (void __user *) start, len))
+		return -ENOMEM;
 
-	max = limit - start;
-	len = PAGE_CACHE_ALIGN(len);
-	if (len > max || !len)
-		goto enomem;
+	/* This also avoids any overflows on PAGE_CACHE_ALIGN */
+	pages = len >> PAGE_SHIFT;
+	pages += (len & ~PAGE_MASK) != 0;
 
-	end = start + len;
+	if (!access_ok(VERIFY_WRITE, vec, pages))
+		return -EFAULT;
 
-	/* check the output buffer whilst holding the lock */
-	error = -EFAULT;
-	down_read(&current->mm->mmap_sem);
-
-	if (!access_ok(VERIFY_WRITE, vec, len >> PAGE_SHIFT))
-		goto out;
-
-	/*
-	 * If the interval [start,end) covers some unmapped address
-	 * ranges, just ignore them, but return -ENOMEM at the end.
-	 */
-	error = 0;
+	tmp = (void *) __get_free_page(GFP_USER);
+	if (!tmp)
+		return -EAGAIN;
 
-	vma = find_vma(current->mm, start);
-	while (vma) {
-		/* Here start < vma->vm_end. */
-		if (start < vma->vm_start) {
-			unmapped_error = -ENOMEM;
-			start = vma->vm_start;
-		}
+	retval = 0;
+	while (pages) {
+		/*
+		 * Do at most PAGE_SIZE entries per iteration, due to
+		 * the temporary buffer size.
+		 */
+		down_read(&current->mm->mmap_sem);
+		retval = do_mincore(start, tmp, min(pages, PAGE_SIZE));
+		up_read(&current->mm->mmap_sem);
 
-		/* Here vma->vm_start <= start < vma->vm_end. */
-		if (end <= vma->vm_end) {
-			if (start < end) {
-				error = mincore_vma(vma, start, end,
-							&vec[index]);
-				if (error)
-					goto out;
-			}
-			error = unmapped_error;
-			goto out;
+		if (retval <= 0)
+			break;
+		if (copy_to_user(vec, tmp, retval)) {
+			retval = -EFAULT;
+			break;
 		}
-
-		/* Here vma->vm_start <= start < vma->vm_end < end. */
-		error = mincore_vma(vma, start, vma->vm_end, &vec[index]);
-		if (error)
-			goto out;
-		index += (vma->vm_end - start) >> PAGE_CACHE_SHIFT;
-		start = vma->vm_end;
-		vma = vma->vm_next;
+		pages -= retval;
+		vec += retval;
+		start += retval << PAGE_SHIFT;
+		retval = 0;
 	}
-
-	/* we found a hole in the area queried if we arrive here */
-	error = -ENOMEM;
-
-out:
-	up_read(&current->mm->mmap_sem);
-	return error;
-
-einval:
-	return -EINVAL;
-enomem:
-	return -ENOMEM;
+	free_page((unsigned long) tmp);
+	return retval;
 }

--
