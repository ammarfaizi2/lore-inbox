Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422976AbWHZRnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422976AbWHZRnG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 13:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422951AbWHZRmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 13:42:50 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:50557 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1422943AbWHZRmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 13:42:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=GQSzruphRKMzASfckksygyGDpBCCgPeC7uh9wnZw/eHHU35ZpTnrKaPAFAU6vf9PBMKK8PTzJLh6eemGD5k+rb0OOCCyyHeFwGDLD8bJdz9KOOgxFZ3xjctlB+Z+XsdkqbBc2CcDF1+W23lFXZSHNWHbqVxHMFGvUzLFZI9hUGQ=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH RFP-V4 06/13] RFP prot support: cleanup syscall checks
Date: Sat, 26 Aug 2006 19:42:29 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-Id: <20060826174229.14790.15931.stgit@memento.home.lan>
In-Reply-To: <200608261933.36574.blaisorblade@yahoo.it>
References: <200608261933.36574.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This patch reorganizes the code only, without differences in behaviour. It
makes the code more readable on its own, and is needed for next patches. I've
split this out to avoid cluttering real patches.

*) remap_file_pages protection support: use EOVERFLOW ret code

Use -EOVERFLOW ("Value too large for defined data type") rather than -EINVAL
when we cannot store the file offset in the PTE.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 mm/fremap.c |   44 +++++++++++++++++++++++++++++---------------
 1 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/mm/fremap.c b/mm/fremap.c
index f57cd6d..dfe5d71 100644
--- a/mm/fremap.c
+++ b/mm/fremap.c
@@ -147,7 +147,7 @@ out:
  * future.
  */
 asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
-	unsigned long __prot, unsigned long pgoff, unsigned long flags)
+	unsigned long prot, unsigned long pgoff, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
 	struct address_space *mapping;
@@ -155,9 +155,10 @@ asmlinkage long sys_remap_file_pages(uns
 	struct vm_area_struct *vma;
 	int err = -EINVAL;
 	int has_write_lock = 0;
+	pgprot_t pgprot;
 
-	if (__prot)
-		return err;
+	if (prot)
+		goto out;
 	/*
 	 * Sanitize the syscall parameters:
 	 */
@@ -166,17 +167,19 @@ asmlinkage long sys_remap_file_pages(uns
 
 	/* Does the address range wrap, or is the span zero-sized? */
 	if (start + size <= start)
-		return err;
+		goto out;
 
 	/* Can we represent this offset inside this architecture's pte's? */
 #if PTE_FILE_MAX_BITS < BITS_PER_LONG
-	if (pgoff + (size >> PAGE_SHIFT) >= (1UL << PTE_FILE_MAX_BITS))
-		return err;
+	if (pgoff + (size >> PAGE_SHIFT) >= (1UL << PTE_FILE_MAX_BITS)) {
+		err = -EOVERFLOW;
+		goto out;
+	}
 #endif
 
 	/* We need down_write() to change vma->vm_flags. */
 	down_read(&mm->mmap_sem);
- retry:
+retry:
 	vma = find_vma(mm, start);
 
 	/*
@@ -185,12 +188,21 @@ #endif
 	 * the single existing vma.  vm_private_data is used as a
 	 * swapout cursor in a VM_NONLINEAR vma.
 	 */
-	if (vma && (vma->vm_flags & VM_SHARED) &&
-		(!vma->vm_private_data || (vma->vm_flags & VM_NONLINEAR)) &&
-		vma->vm_ops && vma->vm_ops->populate &&
-			end > start && start >= vma->vm_start &&
-				end <= vma->vm_end) {
+	if (!vma)
+		goto out_unlock;
+
+	if (!(vma->vm_flags & VM_SHARED))
+		goto out_unlock;
 
+	if (!vma->vm_ops || !vma->vm_ops->populate)
+		goto out_unlock;
+
+	if (end <= start || start < vma->vm_start || end > vma->vm_end)
+		goto out_unlock;
+
+	pgprot = vma->vm_page_prot;
+
+	if (!vma->vm_private_data || (vma->vm_flags & VM_NONLINEAR)) {
 		/* Must set VM_NONLINEAR before any pages are populated. */
 		if (pgoff != linear_page_index(vma, start) &&
 		    !(vma->vm_flags & VM_NONLINEAR)) {
@@ -210,9 +222,8 @@ #endif
 			spin_unlock(&mapping->i_mmap_lock);
 		}
 
-		err = vma->vm_ops->populate(vma, start, size,
-					    vma->vm_page_prot,
-					    pgoff, flags & MAP_NONBLOCK);
+		err = vma->vm_ops->populate(vma, start, size, pgprot, pgoff,
+				flags & MAP_NONBLOCK);
 
 		/*
 		 * We would like to clear VM_NONLINEAR, in the case when
@@ -221,11 +232,14 @@ #endif
 		 * successful populate, and have no way to upgrade sem.
 		 */
 	}
+
+out_unlock:
 	if (likely(!has_write_lock))
 		up_read(&mm->mmap_sem);
 	else
 		up_write(&mm->mmap_sem);
 
+out:
 	return err;
 }
 
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
