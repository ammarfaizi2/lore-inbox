Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262295AbVBKSyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbVBKSyn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 13:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVBKSyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 13:54:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44696 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262295AbVBKSww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 13:52:52 -0500
From: David Howells <dhowells@redhat.com>
To: akpm@osdl.org, torvalds@osdl.org
cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix the mincore() syscall
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Fri, 11 Feb 2005 18:52:38 +0000
Message-ID: <20686.1108147958@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch fixes the mincore syscall in three ways:

 (1) It moves as much argument checking outside of the semaphore-holding
     region as possible.

 (2) It checks the region parameters against TASK_SIZE so that a 32-bit binary
     on a 64-bit platform will get the right error when calling this syscall
     on a region that overlaps the end of the 32-bit address space.

 (3) It tidies up the VMA checking loop a little.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat mincore-2611rc3bk8.diff 
 mincore.c |   50 ++++++++++++++++++++++++++++++++------------------
 1 files changed, 32 insertions(+), 18 deletions(-)

diff -uNrp linux-2.6.11-rc3-bk8/mm/mincore.c linux-2.6.11-rc3-bk8-mincore/mm/mincore.c
--- linux-2.6.11-rc3-bk8/mm/mincore.c	2005-01-04 11:13:57.000000000 +0000
+++ linux-2.6.11-rc3-bk8-mincore/mm/mincore.c	2005-02-11 18:44:25.563625998 +0000
@@ -109,39 +109,45 @@ asmlinkage long sys_mincore(unsigned lon
 	unsigned char __user * vec)
 {
 	int index = 0;
-	unsigned long end;
+	unsigned long end, limit;
 	struct vm_area_struct * vma;
+	size_t max;
 	int unmapped_error = 0;
-	long error = -EINVAL;
+	long error;
 
-	down_read(&current->mm->mmap_sem);
+	/* check the arguments */
+ 	if (start & ~PAGE_CACHE_MASK)
+		goto einval;
+
+	if (start < FIRST_USER_PGD_NR * PGDIR_SIZE)
+		goto enomem;
+
+	limit = TASK_SIZE;
+	if (start >= limit)
+		goto enomem;
+
+	max = limit - start;
+	len = PAGE_CACHE_ALIGN(len);
+	if (len > max)
+		goto einval;
 
-	if (start & ~PAGE_CACHE_MASK)
-		goto out;
-	len = (len + ~PAGE_CACHE_MASK) & PAGE_CACHE_MASK;
 	end = start + len;
-	if (end < start)
-		goto out;
 
+	/* check the output buffer whilst holding the lock */
 	error = -EFAULT;
-	if (!access_ok(VERIFY_WRITE, vec, len >> PAGE_SHIFT))
-		goto out;
+	down_read(&current->mm->mmap_sem);
 
-	error = 0;
-	if (end == start)
+	if (!access_ok(VERIFY_WRITE, vec, len >> PAGE_SHIFT))
 		goto out;
 
 	/*
 	 * If the interval [start,end) covers some unmapped address
 	 * ranges, just ignore them, but return -ENOMEM at the end.
 	 */
-	vma = find_vma(current->mm, start);
-	for (;;) {
-		/* Still start < end. */
-		error = -ENOMEM;
-		if (!vma)
-			goto out;
+	error = 0;
 
+	vma = find_vma(current->mm, start);
+	while (vma) {
 		/* Here start < vma->vm_end. */
 		if (start < vma->vm_start) {
 			unmapped_error = -ENOMEM;
@@ -169,7 +175,15 @@ asmlinkage long sys_mincore(unsigned lon
 		vma = vma->vm_next;
 	}
 
+	/* we found a hole in the area queried if we arrive here */
+	error = -ENOMEM;
+
 out:
 	up_read(&current->mm->mmap_sem);
 	return error;
+
+einval:
+	return -EINVAL;
+enomem:
+	return -ENOMEM;
 }
