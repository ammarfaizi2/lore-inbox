Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262362AbVAUNsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbVAUNsj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 08:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbVAUNsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 08:48:39 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:30176 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262362AbVAUNrg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 08:47:36 -0500
Message-ID: <41F116DB.3BA37CEB@tv-sign.ru>
Date: Fri, 21 Jan 2005 17:51:07 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix put_user under mmap_sem in sys_get_mempolicy()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

sys_get_mempolicy() accesses user memory with mmap_sem held.
If I understand correctly, this can cause deadlock:

sys_get_mempolicy:		Another thread, same mm:

down_read(mmap_sem);
				down_write(mmap_sem);
put_user();
do_page_fault:
down_read(mmap_sem);

Compile tested only, I have no NUMA machine.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.11-rc1/mm/mempolicy.c~	Wed Jan 12 11:44:55 2005
+++ 2.6.11-rc1/mm/mempolicy.c	Fri Jan 21 17:41:47 2005
@@ -482,26 +482,38 @@ asmlinkage long sys_get_mempolicy(int __
 				  unsigned long maxnode,
 				  unsigned long addr, unsigned long flags)
 {
-	int err, pval;
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma = NULL;
+	int err, pval = 0; /* make compiler happy */
 	struct mempolicy *pol = current->mempolicy;
 
 	if (flags & ~(unsigned long)(MPOL_F_NODE|MPOL_F_ADDR))
 		return -EINVAL;
 	if (nmask != NULL && maxnode < MAX_NUMNODES)
 		return -EINVAL;
+
 	if (flags & MPOL_F_ADDR) {
+		struct mm_struct *mm = current->mm;
+		struct vm_area_struct *vma;
+
+		err = 0;
 		down_read(&mm->mmap_sem);
 		vma = find_vma_intersection(mm, addr, addr+1);
-		if (!vma) {
-			up_read(&mm->mmap_sem);
-			return -EFAULT;
+		if (!vma)
+			err = -EFAULT;
+		else {
+			if (vma->vm_ops && vma->vm_ops->get_policy)
+				pol = vma->vm_ops->get_policy(vma, addr);
+			else
+				pol = vma->vm_policy;
+
+			if (flags & MPOL_F_NODE) {
+				pval = lookup_node(mm, addr);
+				if (pval < 0)
+					err = pval;
+			}
 		}
-		if (vma->vm_ops && vma->vm_ops->get_policy)
-			pol = vma->vm_ops->get_policy(vma, addr);
-		else
-			pol = vma->vm_policy;
+		up_read(&mm->mmap_sem);
+		if (err)
+			goto out;
 	} else if (addr)
 		return -EINVAL;
 
@@ -509,17 +521,14 @@ asmlinkage long sys_get_mempolicy(int __
 		pol = &default_policy;
 
 	if (flags & MPOL_F_NODE) {
-		if (flags & MPOL_F_ADDR) {
-			err = lookup_node(mm, addr);
-			if (err < 0)
+		if (!(flags & MPOL_F_ADDR)) {
+			if (pol == current->mempolicy &&
+					pol->policy == MPOL_INTERLEAVE) {
+				pval = current->il_next;
+			} else {
+				err = -EINVAL;
 				goto out;
-			pval = err;
-		} else if (pol == current->mempolicy &&
-				pol->policy == MPOL_INTERLEAVE) {
-			pval = current->il_next;
-		} else {
-			err = -EINVAL;
-			goto out;
+			}
 		}
 	} else
 		pval = pol->policy;
@@ -534,10 +543,7 @@ asmlinkage long sys_get_mempolicy(int __
 		get_zonemask(pol, nodes);
 		err = copy_nodes_to_user(nmask, maxnode, nodes, sizeof(nodes));
 	}
-
- out:
-	if (vma)
-		up_read(&current->mm->mmap_sem);
+out:
 	return err;
 }
