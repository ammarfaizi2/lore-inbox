Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318142AbSGWRZK>; Tue, 23 Jul 2002 13:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318153AbSGWRZJ>; Tue, 23 Jul 2002 13:25:09 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:57932 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S318142AbSGWRZC>; Tue, 23 Jul 2002 13:25:02 -0400
Date: Tue, 23 Jul 2002 18:28:10 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Robert Love <rml@tech9.net>, David Mosberger <davidm@hpl.hp.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] VM accounting 2/3 fixes
In-Reply-To: <Pine.LNX.4.21.0207231823470.10982-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0207231827210.10982-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

do_mmap_pgoff's (file == NULL) check was incorrect: it caused shared
MAP_ANONYMOUS objects to be counted twice (again in shmem_file_setup),
and again on fork(); whereas the equivalent shared /dev/zero objects
were correctly counted.  Conversely, a private readonly file mapping
was (correctly) not counted, but still not counted when mprotected to
writable: replaced mprotect_fixup's "#ifdef COMPLETE_BOLLOCKS" block
(rc3-ac3 patch to mprotect.c nothing but bloat: charged remains 0).

There's also a perfectly correct (flags & MAP_SHARED) test, not
peculiar to -ac, that I changed to test (vm_flags & VM_SHARED):
merely because do_mmap_pgoff is generally dealing with vm_flags
rather than the input flags by that stage.

Second of three patches, against 2.4.19-rc3-ac3 + vmacct1:

diff -urN vmacct1/Documentation/vm/overcommit-accounting vmacct2/Documentation/vm/overcommit-accounting
--- vmacct1/Documentation/vm/overcommit-accounting	Tue Jul 23 15:33:22 2002
+++ vmacct2/Documentation/vm/overcommit-accounting	Tue Jul 23 16:11:10 2002
@@ -40,12 +40,11 @@
 
 For a file backed map
 	SHARED or READ only	-	0 cost (the file is the map not swap)
+	PRIVATE WRITABLE	-	size of mapping per instance
 
-	WRITABLE SHARED		-	size of mapping per instance
-
-For a direct map
-	SHARED or READ only	-	size of mapping
-	PRIVATE WRITEABLE	-	size of mapping per instance
+For an anonymous or /dev/zero map
+	SHARED			-	size of mapping
+	PRIVATE			-	size of mapping per instance
 
 Additional accounting
 	Pages made writable copies by mmap
@@ -68,6 +67,3 @@
 To Do
 -----
 o	Account ptrace pages (this is hard)
-o	Disable MAP_NORESERVE in mode 2/3
-o	Account for shared anonymous mappings properly
-	- right now we account them per instance
diff -urN vmacct1/kernel/fork.c vmacct2/kernel/fork.c
--- vmacct1/kernel/fork.c	Tue Jul 23 15:33:34 2002
+++ vmacct2/kernel/fork.c	Tue Jul 23 16:11:10 2002
@@ -174,9 +174,7 @@
 		if(mpnt->vm_flags & VM_DONTCOPY)
 			continue;
 	
-		/* FIXME: shared writable map accounting should be one off */
-		if(mpnt->vm_flags & VM_ACCOUNT)
-		{
+		if(mpnt->vm_flags & VM_ACCOUNT) {
 			unsigned int len = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
 			if(!vm_enough_memory(len))
 				goto fail_nomem;
diff -urN vmacct1/mm/mmap.c vmacct2/mm/mmap.c
--- vmacct1/mm/mmap.c	Tue Jul 23 15:48:24 2002
+++ vmacct2/mm/mmap.c	Tue Jul 23 16:11:10 2002
@@ -574,7 +574,7 @@
 munmap_back:
 	vma = find_vma_prepare(mm, addr, &prev, &rb_link, &rb_parent);
 	if (vma && vma->vm_start < addr + len) {
-		if (do_munmap(mm, addr, len, 1))
+		if (do_munmap(mm, addr, len))
 			return -ENOMEM;
 		goto munmap_back;
 	}
@@ -584,18 +584,14 @@
 	    > current->rlim[RLIMIT_AS].rlim_cur)
 		return -ENOMEM;
 
-	if (vm_accounts_strictly())
-		flags &= ~MAP_NORESERVE;
-	
-	/* Private writable mapping? Check memory availability.. */
-
-	if ((((vm_flags & (VM_SHARED | VM_WRITE)) == VM_WRITE) || (file == NULL)) 
- 		&& !(flags & MAP_NORESERVE))
-	{
-		charged = len >> PAGE_SHIFT;
-		if(!vm_enough_memory(charged))
-			return -ENOMEM;
-		vm_flags |= VM_ACCOUNT;
+	if (!(flags & MAP_NORESERVE) || vm_accounts_strictly()) {
+		if ((vm_flags & (VM_SHARED|VM_WRITE)) == VM_WRITE) {
+			/* Private writable mapping: check memory availability */
+			charged = len >> PAGE_SHIFT;
+			if (!vm_enough_memory(charged))
+				return -ENOMEM;
+			vm_flags |= VM_ACCOUNT;
+		}
 	}
 
 	/* Can we just expand an old anonymous mapping? */
@@ -638,7 +634,7 @@
 		error = file->f_op->mmap(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
-	} else if (flags & MAP_SHARED) {
+	} else if (vm_flags & VM_SHARED) {
 		error = shmem_zero_setup(vma);
 		if (error)
 			goto free_vma;
diff -urN vmacct1/mm/mprotect.c vmacct2/mm/mprotect.c
--- vmacct1/mm/mprotect.c	Tue Jul 23 15:33:35 2002
+++ vmacct2/mm/mprotect.c	Tue Jul 23 16:11:10 2002
@@ -265,25 +265,21 @@
 		return 0;
 	}
 
-#ifdef COMPLETE_BOLLOCKS
 	/*
-	 *	If we take an anonymous mapped vma writable we
-	 *	increase our commit (was one page per file now one page
-	 *	per writable private instance)
-	 *	FIXME: shared private mapping R/O versus R/W accounting
+	 * If we make a private mapping writable we increase our commit;
+	 * but (without finer accounting) cannot reduce our commit if we
+	 * make it unwritable again.
+	 *
+	 * FIXME? We haven't defined a VM_NORESERVE flag, so mprotecting
+	 * a MAP_NORESERVE private mapping to writable will now reserve.
 	 */
-	if(vma->vm_file != NULL && 
-	  ((vma->vm_flags & (VM_ACCOUNT|VM_SHARED)) == (VM_ACCOUNT|VM_SHARED)) && 
-	  ((newflags & PROT_WRITE) != (vma->vm_flags & PROT_WRITE)))
-	{
+	if ((newflags & VM_WRITE) &&
+	    !(vma->vm_flags & (VM_ACCOUNT|VM_WRITE|VM_SHARED))) {
 		charged = (end - start) >> PAGE_SHIFT;
-		if(newflags & PROT_WRITE)
-		{
-			if(!vm_enough_memory(charged))
-				return -ENOMEM;
-		}
+		if (!vm_enough_memory(charged))
+			return -ENOMEM;
+		newflags |= VM_ACCOUNT;
 	}
-#endif	
 	newprot = protection_map[newflags & 0xf];
 	if (start == vma->vm_start) {
 		if (end == vma->vm_end)
@@ -294,17 +290,10 @@
 		error = mprotect_fixup_end(vma, pprev, start, newflags, newprot);
 	else
 		error = mprotect_fixup_middle(vma, pprev, start, end, newflags, newprot);
-
-	if (error)
-	{
-		if(newflags & PROT_WRITE)
-			vm_unacct_memory(charged);
+	if (error) {
+		vm_unacct_memory(charged);
 		return error;
 	}
-	/* Delayed accounting for reduction of memory use - done last to
-	   avoid allocation races */
-	if (charged && !(newflags & PROT_WRITE))
-		vm_unacct_memory(charged);
 	change_protection(start, end, newprot);
 	return 0;
 }

