Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265254AbUFHQMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265254AbUFHQMX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 12:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265253AbUFHQMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 12:12:22 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:40621
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265254AbUFHQMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 12:12:16 -0400
Date: Tue, 8 Jun 2004 17:44:38 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: downgrade_write replacement in remap_file_pages
Message-ID: <20040608154438.GK18083@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently downgrade_write deadlocks the kernel in the mmap_sem
under load. I suspect some rwsem bug. Anyways it's matter of time before
in my tree I replace the rwsem implementation with my spinlock based
common code implementation again that I can understand trivially (unlike
the current code). I don't mind a microoptimization when the code is so
complicated, so I don't mind too much to fix whatever current bug in
downgrade_write.

In the meantime to workaround the deadlock (and to verify if this make
the deadlock go away, which returned a positive result) I implemented
this patch: this doesn't fix downgrade_wite, but I'm posting it here
because I believe it's much better code regardless of the
downgrade_write issue.  With this patch we'll never run down_write again
in production, the down_write will be taken only once when the db or the
simulator startup (during the very first page fault) and never again, in
turn providing (at least in theory) better runtime scalability.

Index: linux-2.5/mm/fremap.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/mm/fremap.c,v
retrieving revision 1.24
diff -u -p -r1.24 fremap.c
--- linux-2.5/mm/fremap.c	23 May 2004 05:07:26 -0000	1.24
+++ linux-2.5/mm/fremap.c	8 Jun 2004 15:38:21 -0000
@@ -161,6 +161,7 @@ asmlinkage long sys_remap_file_pages(uns
 	unsigned long end = start + size;
 	struct vm_area_struct *vma;
 	int err = -EINVAL;
+	int has_write_lock = 0;
 
 	if (__prot)
 		return err;
@@ -181,7 +182,8 @@ asmlinkage long sys_remap_file_pages(uns
 #endif
 
 	/* We need down_write() to change vma->vm_flags. */
-	down_write(&mm->mmap_sem);
+	down_read(&mm->mmap_sem);
+ retry:
 	vma = find_vma(mm, start);
 
 	/*
@@ -198,8 +200,13 @@ asmlinkage long sys_remap_file_pages(uns
 				end <= vma->vm_end) {
 
 		/* Must set VM_NONLINEAR before any pages are populated. */
-		if (pgoff != linear_page_index(vma, start) &&
-		    !(vma->vm_flags & VM_NONLINEAR)) {
+		if (unlikely(pgoff != linear_pgoff && !(vma->vm_flags & VM_NONLINEAR))) {
+			if (!has_write_lock) {
+				up_read(&mm->mmap_sem);
+				down_write(&mm->mmap_sem);
+				has_write_lock = 1;
+				goto retry;
+			}
 			mapping = vma->vm_file->f_mapping;
 			spin_lock(&mapping->i_mmap_lock);
 			flush_dcache_mmap_lock(mapping);
@@ -212,8 +219,6 @@ asmlinkage long sys_remap_file_pages(uns
 			spin_unlock(&mapping->i_mmap_lock);
 		}
 
-		/* ->populate can take a long time, so downgrade the lock. */
-		downgrade_write(&mm->mmap_sem);
 		err = vma->vm_ops->populate(vma, start, size,
 					    vma->vm_page_prot,
 					    pgoff, flags & MAP_NONBLOCK);
@@ -223,10 +228,11 @@ asmlinkage long sys_remap_file_pages(uns
 		 * it after ->populate completes, and that would prevent
 		 * downgrading the lock.  (Locks can't be upgraded).
 		 */
+	}
+	if (likely(!has_write_lock))
 		up_read(&mm->mmap_sem);
-	} else {
+	else
 		up_write(&mm->mmap_sem);
-	}
 
 	return err;
 }
