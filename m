Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317994AbSG2WJ3>; Mon, 29 Jul 2002 18:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318084AbSG2WJ0>; Mon, 29 Jul 2002 18:09:26 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:54330 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S317994AbSG2WIv>; Mon, 29 Jul 2002 18:08:51 -0400
Date: Mon, 29 Jul 2002 23:12:18 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Love <rml@tech9.net>,
       Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH] vmacct6/9 fix shared and private accounting
In-Reply-To: <Pine.LNX.4.21.0207292257001.1184-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0207292310320.1184-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

do_mmap_pgoff's (file == NULL) check was incorrect: it caused shared
MAP_ANONYMOUS objects to be counted twice (again in shmem_file_setup),
and again on fork(); whereas the equivalent shared /dev/zero objects
were correctly counted.  Conversely, a private readonly file mapping
was (correctly) not counted, but still not counted when mprotected to
writable: mprotect_fixup had pointless "charged = 0" changes, now it
does vm_enough_memory checking when private is first made writable
(but later we may want to refine behaviour on a noreserve mapping).

Also changed correct (flags & MAP_SHARED) test in do_mmap_pgoff to
equivalent (vm_flags & VM_SHARED) test: because do_mmap_pgoff is
dealing with vm_flags rather than the input flags by that stage.

--- vmacct5/mm/mmap.c	Mon Jul 29 19:23:46 2002
+++ vmacct6/mm/mmap.c	Mon Jul 29 19:23:46 2002
@@ -527,16 +527,14 @@
 	    > current->rlim[RLIMIT_AS].rlim_cur)
 		return -ENOMEM;
 
-	if (sysctl_overcommit_memory > 1)
-		flags &= ~MAP_NORESERVE;
-
-	/* Private writable mapping? Check memory availability.. */
-	if ((((vm_flags & (VM_SHARED | VM_WRITE)) == VM_WRITE) ||
-			(file == NULL)) && !(flags & MAP_NORESERVE)) {
-		charged = len >> PAGE_SHIFT;
-		if (!vm_enough_memory(charged))
-			return -ENOMEM;
-		vm_flags |= VM_ACCOUNT;
+	if (!(flags & MAP_NORESERVE) || sysctl_overcommit_memory > 1) {
+		if ((vm_flags & (VM_SHARED|VM_WRITE)) == VM_WRITE) {
+			/* Private writable mapping: check memory availability */
+			charged = len >> PAGE_SHIFT;
+			if (!vm_enough_memory(charged))
+				return -ENOMEM;
+			vm_flags |= VM_ACCOUNT;
+		}
 	}
 
 	/* Can we just expand an old anonymous mapping? */
@@ -579,7 +577,7 @@
 		error = file->f_op->mmap(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
-	} else if (flags & MAP_SHARED) {
+	} else if (vm_flags & VM_SHARED) {
 		error = shmem_zero_setup(vma);
 		if (error)
 			goto free_vma;
--- vmacct5/mm/mprotect.c	Mon Jul 29 11:48:04 2002
+++ vmacct6/mm/mprotect.c	Mon Jul 29 19:23:46 2002
@@ -257,6 +257,22 @@
 		*pprev = vma;
 		return 0;
 	}
+
+	/*
+	 * If we make a private mapping writable we increase our commit;
+	 * but (without finer accounting) cannot reduce our commit if we
+	 * make it unwritable again.
+	 *
+	 * FIXME? We haven't defined a VM_NORESERVE flag, so mprotecting
+	 * a MAP_NORESERVE private mapping to writable will now reserve.
+	 */
+	if ((newflags & VM_WRITE) &&
+	    !(vma->vm_flags & (VM_ACCOUNT|VM_WRITE|VM_SHARED))) {
+		charged = (end - start) >> PAGE_SHIFT;
+		if (!vm_enough_memory(charged))
+			return -ENOMEM;
+		newflags |= VM_ACCOUNT;
+	}
 	newprot = protection_map[newflags & 0xf];
 	if (start == vma->vm_start) {
 		if (end == vma->vm_end)
@@ -267,19 +283,10 @@
 		error = mprotect_fixup_end(vma, pprev, start, newflags, newprot);
 	else
 		error = mprotect_fixup_middle(vma, pprev, start, end, newflags, newprot);
-
 	if (error) {
-		if (newflags & PROT_WRITE)
-			vm_unacct_memory(charged);
+		vm_unacct_memory(charged);
 		return error;
 	}
-
-	/*
-	 * Delayed accounting for reduction of memory use - done last to
-	 * avoid allocation races
-	 */
-	if (charged && !(newflags & PROT_WRITE))
-		vm_unacct_memory(charged);
 	change_protection(vma, start, end, newprot);
 	return 0;
 }

