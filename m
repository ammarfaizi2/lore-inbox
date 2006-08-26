Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422945AbWHZRqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422945AbWHZRqN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 13:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422972AbWHZRmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 13:42:46 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:52861 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1422951AbWHZRmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 13:42:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=5cxgT352IHIPB9hWZvPzNpF/q8D2maIUz6oanuKl31T9viZ74+wHUKNt9djdfPg5i3Uk0/YJ3Y6JcEOtQVGba9/leq+hqLGwkzTgKK2sLtvUWkUvrHmjTFYCIh3f/PNm9Cc6KPiVsaNnQKKbSX7F3yC1yslPC1krcSPVhlE3zgg=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH RFP-V4 07/13] RFP prot support: enhance syscall interface
Date: Sat, 26 Aug 2006 19:42:32 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-Id: <20060826174232.14790.45163.stgit@memento.home.lan>
In-Reply-To: <200608261933.36574.blaisorblade@yahoo.it>
References: <200608261933.36574.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Enable the 'prot' parameter for shared-writable mappings (the ones which are
the primary target for remap_file_pages), without breaking up the vma.

This contains simply the changes to the syscall code, based on Ingo's patch.
Differently from his one, I've *not* added a new syscall, choosing to add a
new flag (MAP_CHGPROT) which the application must specify to get the new
behavior (prot != 0 is accepted and prot == 0 means PROT_NONE).

Upon Hugh's suggestion, simplify the permission checking on the VMA, reusing
mprotect()'s trick.
---

 mm/fremap.c |   39 +++++++++++++++++++++++++++++++--------
 1 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/mm/fremap.c b/mm/fremap.c
index dfe5d71..e62dc15 100644
--- a/mm/fremap.c
+++ b/mm/fremap.c
@@ -4,6 +4,10 @@
  * Explicit pagetable population and nonlinear (random) mappings support.
  *
  * started by Ingo Molnar, Copyright (C) 2002, 2003
+ *
+ * support of nonuniform remappings:
+ * Copyright (C) 2004 Ingo Molnar
+ * Copyright (C) 2005 Paolo 'Blaisorblade' Giarrusso
  */
 
 #include <linux/mm.h>
@@ -133,18 +137,14 @@ out:
  *                        file within an existing vma.
  * @start: start of the remapped virtual memory range
  * @size: size of the remapped virtual memory range
- * @prot: new protection bits of the range
+ * @prot: new protection bits of the range, must be 0 if not using MAP_CHGPROT
  * @pgoff: to be mapped page of the backing store file
- * @flags: 0 or MAP_NONBLOCKED - the later will cause no IO.
+ * @flags: bits MAP_CHGPROT or MAP_NONBLOCKED - the later will cause no IO.
  *
  * this syscall works purely via pagetables, so it's the most efficient
  * way to map the same (large) file into a given virtual window. Unlike
  * mmap()/mremap() it does not create any new vmas. The new mappings are
  * also safe across swapout.
- *
- * NOTE: the 'prot' parameter right now is ignored, and the vma's default
- * protection is used. Arbitrary protections might be implemented in the
- * future.
  */
 asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
 	unsigned long prot, unsigned long pgoff, unsigned long flags)
@@ -157,7 +157,7 @@ asmlinkage long sys_remap_file_pages(uns
 	int has_write_lock = 0;
 	pgprot_t pgprot;
 
-	if (prot)
+	if (prot && !(flags & MAP_CHGPROT))
 		goto out;
 	/*
 	 * Sanitize the syscall parameters:
@@ -200,7 +200,19 @@ retry:
 	if (end <= start || start < vma->vm_start || end > vma->vm_end)
 		goto out_unlock;
 
-	pgprot = vma->vm_page_prot;
+	if (flags & MAP_CHGPROT) {
+		unsigned long vm_prots = calc_vm_prot_bits(prot);
+
+		/* vma->vm_flags >> 4 shifts VM_MAY% in place of VM_% */
+		if ((vm_prots & ~(vma->vm_flags >> 4)) &
+				(VM_READ | VM_WRITE | VM_EXEC)) {
+			err = -EPERM;
+			goto out_unlock;
+		}
+
+		pgprot = protection_map[vm_prots | VM_SHARED];
+	} else
+		pgprot = vma->vm_page_prot;
 
 	if (!vma->vm_private_data || (vma->vm_flags & VM_NONLINEAR)) {
 		/* Must set VM_NONLINEAR before any pages are populated. */
@@ -222,6 +234,17 @@ retry:
 			spin_unlock(&mapping->i_mmap_lock);
 		}
 
+		if (pgprot_val(pgprot) != pgprot_val(vma->vm_page_prot) &&
+				!(vma->vm_flags & VM_MANYPROTS)) {
+			if (!has_write_lock) {
+				up_read(&mm->mmap_sem);
+				down_write(&mm->mmap_sem);
+				has_write_lock = 1;
+				goto retry;
+			}
+			vma->vm_flags |= VM_MANYPROTS;
+		}
+
 		err = vma->vm_ops->populate(vma, start, size, pgprot, pgoff,
 				flags & MAP_NONBLOCK);
 
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
