Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129632AbRAIMJc>; Tue, 9 Jan 2001 07:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129773AbRAIMJO>; Tue, 9 Jan 2001 07:09:14 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:29612 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129632AbRAIMJC>; Tue, 9 Jan 2001 07:09:02 -0500
Message-ID: <3A5B00F4.55FB83FE@uow.edu.au>
Date: Tue, 09 Jan 2001 23:15:48 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <mikeg@wen-online.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [testcase] madvise->semaphore deadlock 2.4.0
In-Reply-To: <Pine.Linu.4.10.10101091113020.2510-100000@mikeg.weiden.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> 
> Greetings,
> 
> While trying to configure ftpsearch, the process hangs while running
> it's madvise confidence test below.  It appears to be taking a fault
> in madvise_fixup_middle():atomic_add(2, &vma->vm_file->f_count) and
> immediately deadlocking forever on mm->mmap_sem per IKD.  (Virgin 2.4.0
> agrees)
>

This should fix it.

We're still in disagreement with the HPUX 11 manpage though.
HP say that MADV_DONTNEED requires an underlying file,
and thus implies that MADV_WILLNEED doesn't need an
underlying file.  We have it the other way round, which
seems more sensible.


--- linux-2.4.0/mm/filemap.c	Fri Jan  5 21:37:20 2001
+++ linux-akpm/mm/filemap.c	Tue Jan  9 23:05:00 2001
@@ -1835,7 +1835,8 @@
 	n->vm_end = end;
 	setup_read_behavior(n, behavior);
 	n->vm_raend = 0;
-	get_file(n->vm_file);
+	if (n->vm_file)
+		get_file(n->vm_file);
 	if (n->vm_ops && n->vm_ops->open)
 		n->vm_ops->open(n);
 	lock_vma_mappings(vma);
@@ -1861,7 +1862,8 @@
 	n->vm_pgoff += (n->vm_start - vma->vm_start) >> PAGE_SHIFT;
 	setup_read_behavior(n, behavior);
 	n->vm_raend = 0;
-	get_file(n->vm_file);
+	if (n->vm_file)
+		get_file(n->vm_file);
 	if (n->vm_ops && n->vm_ops->open)
 		n->vm_ops->open(n);
 	lock_vma_mappings(vma);
@@ -1893,7 +1895,8 @@
 	right->vm_pgoff += (right->vm_start - left->vm_start) >> PAGE_SHIFT;
 	left->vm_raend = 0;
 	right->vm_raend = 0;
-	atomic_add(2, &vma->vm_file->f_count);
+	if (vma->vm_file)
+		atomic_add(2, &vma->vm_file->f_count);
 
 	if (vma->vm_ops && vma->vm_ops->open) {
 		vma->vm_ops->open(left);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
