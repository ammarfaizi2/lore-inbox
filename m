Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWCTNg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWCTNg7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWCTNg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:36:59 -0500
Received: from uproxy.gmail.com ([66.249.92.205]:33487 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751145AbWCTNg5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:36:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fMTKIS81R8WAf3uMkj4bmTADOB4KqQchvqlgKxxi+P4E6gCj2opHnHMR5175oWYrEpqHtMwTay2SikpkgvMqzXcT5pDgagu0xPTmhdMEK9amcKa8hYaNiWDR5gXGD7jCapqVouI0WVx87q3sTra24ZG95LXKG9OhnTbaJ8x5OLU=
Message-ID: <bc56f2f0603200536i31881135x@mail.gmail.com>
Date: Mon, 20 Mar 2006 08:36:55 -0500
From: "Stone Wang" <pwstone@gmail.com>
To: akpm@osdl.org
Subject: [PATCH][2/8] mm: Posix mlock series system calls
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add Posix(through rollback) support in sys_mlock/sys_munlock/sys_mlockall
/sys_munlockall.

Signed-off-by: Shaoping Wang <pwstone@gmail.com>

--
 mlock.c |  279 +++++++++++++++++++++++++++++++++++++++++++---------------------
 1 files changed, 189 insertions(+), 90 deletions(-)

diff -urN linux-2.6.15.orig/mm/mlock.c linux-2.6.15/mm/mlock.c
--- linux-2.6.15.orig/mm/mlock.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/mm/mlock.c	2006-03-07 10:50:52.000000000 -0500
@@ -3,6 +3,7 @@
  *
  *  (C) Copyright 1995 Linus Torvalds
  *  (C) Copyright 2002 Christoph Hellwig
+ *  (C) Copyright 2006 Shaoping Wang
  */

 #include <linux/mman.h>
@@ -10,72 +11,119 @@
 #include <linux/mempolicy.h>
 #include <linux/syscalls.h>

-
-static int mlock_fixup(struct vm_area_struct *vma, struct
vm_area_struct **prev,
-	unsigned long start, unsigned long end, unsigned int newflags)
+static int do_mlock(unsigned long start, size_t len,unsigned int jump_hole)
 {
-	struct mm_struct * mm = vma->vm_mm;
-	pgoff_t pgoff;
-	int pages;
-	int ret = 0;
+	unsigned long  end=0,vmoff=0;
+	unsigned long  pages=0;
+	struct mm_struct *mm=current->mm;
+	struct vm_area_struct * vma, *prev, **pprev,*next;
+	int ret=0;

-	if (newflags == vma->vm_flags) {
-		*prev = vma;
-		goto out;
-	}
+	len = PAGE_ALIGN(len);
+	end = start + len;
+	if (end < start)
+		return -EINVAL;
+	if (end == start)
+		return 0;

-	pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
-	*prev = vma_merge(mm, *prev, start, end, newflags, vma->anon_vma,
-			  vma->vm_file, pgoff, vma_policy(vma));
-	if (*prev) {
-		vma = *prev;
-		goto success;
+	vma = find_vma_prev(current->mm, start, &prev);
+	if (!vma || vma->vm_start > start)
+		return -ENOMEM;
+    else if (vma->vm_start < start){
+			prev=vma;
+		    ret = split_vma(mm, prev, start, 0);
+			if(!ret)
+				vma=prev->vm_next;
+			else {
+				return ret;
+			}
 	}

-	*prev = vma;
-
-	if (start != vma->vm_start) {
-		ret = split_vma(mm, vma, start, 1);
-		if (ret)
+	while(vma->vm_start < end){
+		vmoff =vma->vm_end; /* Record where we have proceeded. */
+		if (vma->vm_end > end){
+    	   	ret = split_vma(mm, vma, end, 0);
+   			if (ret)
+		   		goto out;
+		}
+		if(vma->vm_flags & VM_LOCKED)
+			goto next;
+		vma->vm_flags |= VM_LOCKED;
+		vma->vm_wire_change =1;
+		pages += (vma->vm_end-vma->vm_start) >> PAGE_SHIFT;
+
+    	if (!(vma->vm_flags & VM_IO)) {
+   			ret = make_pages_wired(vma->vm_start, vma->vm_end);
+			if(ret<0){
+				vma->vm_flags &= ~VM_LOCKED;
+				vma->vm_wire_change =0;
+				goto out;
+			}
+		}
+next:
+		if(vma->vm_end ==end)
+			break;
+		prev =vma;
+		vma =vma->vm_next;
+		
+		/* If called from do_mlockall,
+		 * we may jump over holes.
+         */
+		if(jump_hole){
+			if(vma)
+				continue;
+			else
+				goto out;
+		}
+		else if (!vma || vma->vm_start != prev->vm_end){
+			ret = -ENOMEM;
 			goto out;
+		}
 	}

-	if (end != vma->vm_end) {
-		ret = split_vma(mm, vma, end, 0);
-		if (ret)
-			goto out;
-	}
+out:
+	pprev =&prev;
+	vma = find_vma_prev(mm, start, pprev);

-success:
-	/*
-	 * vm_flags is protected by the mmap_sem held in write mode.
-	 * It's okay if try_to_unmap_one unmaps a page just after we
-	 * set VM_LOCKED, make_pages_present below will bring it back.
-	 */
-	vma->vm_flags = newflags;
-
-	/*
-	 * Keep track of amount of locked VM.
-	 */
-	pages = (end - start) >> PAGE_SHIFT;
-	if (newflags & VM_LOCKED) {
-		pages = -pages;
-		if (!(newflags & VM_IO))
-			ret = make_pages_present(start, end);
+	/* If error happened,do rollback.
+	 * Whether success or not,try to merge the vmas.
+     */
+	while( vma && vma->vm_end <= vmoff ){
+		if(vma->vm_wire_change) {
+			if(ret){
+				make_pages_unwired(mm, vma->vm_start, vma->vm_end);
+				vma->vm_flags &= ~VM_LOCKED;
+			}
+			vma->vm_wire_change =0;
+		}
+		next=vma->vm_next;
+		if(next && next->vm_wire_change) {
+			if(ret){
+				make_pages_unwired(mm, next->vm_start, next->vm_end);
+				next->vm_flags &= ~VM_LOCKED;
+			}
+			next->vm_wire_change=0;
+		}
+		*pprev=vma_merge(mm, *pprev, vma->vm_start, vma->vm_end, vma->vm_flags,
+					vma->anon_vma,vma->vm_file, vma->vm_pgoff, vma_policy(vma));
+		if(*pprev)
+			vma =*pprev;
+		vma =vma->vm_next;
 	}

-	vma->vm_mm->locked_vm -= pages;
-out:
-	if (ret == -ENOMEM)
-		ret = -EAGAIN;
+	if(!ret)
+		mm->locked_vm += pages;
 	return ret;
 }

-static int do_mlock(unsigned long start, size_t len, int on)
+
+static int do_munlock(unsigned long start, size_t len, unsigned int jump_hole)
 {
-	unsigned long nstart, end, tmp;
-	struct vm_area_struct * vma, * prev;
-	int error;
+	unsigned long  end=0,vmoff=0;
+	unsigned long  pages=0;
+	struct mm_struct *mm=current->mm;
+	struct vm_area_struct * vma, *prev, **pprev, *next;
+	int ret=0;

 	len = PAGE_ALIGN(len);
 	end = start + len;
@@ -86,38 +134,81 @@
 	vma = find_vma_prev(current->mm, start, &prev);
 	if (!vma || vma->vm_start > start)
 		return -ENOMEM;
+    else if (vma->vm_start < start){
+		prev=vma;
+	    ret = split_vma(mm, prev, start, 0);
+		if(!ret)
+			vma=prev->vm_next;
+		else
+			return ret;
+	}

-	if (start > vma->vm_start)
-		prev = vma;
+	while(vma->vm_start < end){
+		vmoff =vma->vm_end;
+    	if (vma->vm_end > end){
+    	   	ret = split_vma(mm, vma, end, 0);
+   	 		if (ret)
+	   			goto out;
+		}

-	for (nstart = start ; ; ) {
-		unsigned int newflags;
+		if(!(vma->vm_flags & VM_LOCKED))
+			goto next;

-		/* Here we know that  vma->vm_start <= nstart < vma->vm_end. */
+		vma->vm_wire_change=1;
+		pages += (vma->vm_end -vma->vm_start) >>PAGE_SHIFT;

-		newflags = vma->vm_flags | VM_LOCKED;
-		if (!on)
-			newflags &= ~VM_LOCKED;
-
-		tmp = vma->vm_end;
-		if (tmp > end)
-			tmp = end;
-		error = mlock_fixup(vma, &prev, nstart, tmp, newflags);
-		if (error)
-			break;
-		nstart = tmp;
-		if (nstart < prev->vm_end)
-			nstart = prev->vm_end;
-		if (nstart >= end)
+next:
+		if(vma->vm_end ==end)
 			break;
+		prev =vma;
+		vma =vma->vm_next;

-		vma = prev->vm_next;
-		if (!vma || vma->vm_start != nstart) {
-			error = -ENOMEM;
-			break;
+		/* If called from munlockall,
+		 * we may jump over holes.
+		 */
+		if(jump_hole){
+			if(!vma)
+				goto out;
+			else
+				continue;
+		}
+		else if (!vma || (vma->vm_start != prev->vm_end) ){
+			ret= -ENOMEM;
+			goto out;
 		}
 	}
-	return error;
+
+out:
+	pprev =&prev;
+	vma = find_vma_prev(current->mm, start, pprev);
+
+	while( vma && vma->vm_end <= vmoff ){
+			if(!ret && vma->vm_wire_change){
+	    		if (!(vma->vm_flags & VM_IO))
+					make_pages_unwired(mm, vma->vm_start, vma->vm_end);
+				vma->vm_flags &=~VM_LOCKED;
+			}
+			vma->vm_wire_change =0;
+			next = vma->vm_next;
+			if(next){
+				if(!ret && next->vm_wire_change){
+		    		if (!(next->vm_flags & VM_IO))
+						make_pages_unwired(mm, next->vm_start,next->vm_end);
+					next->vm_flags &=~VM_LOCKED;
+				}
+				next->vm_wire_change =0;
+			}
+		*pprev =vma_merge(mm, *pprev, vma->vm_start, vma->vm_end, vma->vm_flags,
+		vma->anon_vma,vma->vm_file, vma->vm_pgoff, vma_policy(vma));
+		if(*pprev)
+			vma =*pprev;
+		vma =vma->vm_next;
+	}
+
+	if(!ret)
+		mm->locked_vm -= pages;
+	
+	return ret;
 }

 asmlinkage long sys_mlock(unsigned long start, size_t len)
@@ -141,7 +232,7 @@

 	/* check against resource limits */
 	if ((locked <= lock_limit) || capable(CAP_IPC_LOCK))
-		error = do_mlock(start, len, 1);
+		error = do_mlock(start, len, 0);
 	up_write(&current->mm->mmap_sem);
 	return error;
 }
@@ -153,33 +244,41 @@
 	down_write(&current->mm->mmap_sem);
 	len = PAGE_ALIGN(len + (start & ~PAGE_MASK));
 	start &= PAGE_MASK;
-	ret = do_mlock(start, len, 0);
+	ret = do_munlock(start, len,0);
 	up_write(&current->mm->mmap_sem);
 	return ret;
 }

 static int do_mlockall(int flags)
 {
-	struct vm_area_struct * vma, * prev = NULL;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct * vma;
 	unsigned int def_flags = 0;
+	unsigned long start;
+	int ret = 0;

 	if (flags & MCL_FUTURE)
 		def_flags = VM_LOCKED;
-	current->mm->def_flags = def_flags;
+	mm->def_flags = def_flags;
 	if (flags == MCL_FUTURE)
 		goto out;
+	vma=mm->mmap;
+	start = vma->vm_start;
+	ret=do_mlock(start,TASK_SIZE,1);
+out:
+	return ret;
+}

-	for (vma = current->mm->mmap; vma ; vma = prev->vm_next) {
-		unsigned int newflags;
-
-		newflags = vma->vm_flags | VM_LOCKED;
-		if (!(flags & MCL_CURRENT))
-			newflags &= ~VM_LOCKED;
+static int do_munlockall(void)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct * vma;
+	unsigned long start;
+
+	vma=mm->mmap;
+	start = vma->vm_start;
+	do_munlock(start,TASK_SIZE,1);

-		/* Ignore errors */
-		mlock_fixup(vma, &prev, vma->vm_start, vma->vm_end, newflags);
-	}
-out:
 	return 0;
 }

@@ -214,7 +313,7 @@
 	int ret;

 	down_write(&current->mm->mmap_sem);
-	ret = do_mlockall(0);
+	ret = do_munlockall();
 	up_write(&current->mm->mmap_sem);
 	return ret;
 }
