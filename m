Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264251AbUFXKvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbUFXKvU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 06:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUFXKvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 06:51:20 -0400
Received: from mail4.speakeasy.net ([216.254.0.204]:43476 "EHLO
	mail4.speakeasy.net") by vger.kernel.org with ESMTP id S264236AbUFXKvC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 06:51:02 -0400
Date: Thu, 24 Jun 2004 03:50:59 -0700
Message-Id: <200406241050.i5OAoxKC032703@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Fcc: ~/Mail/linus
Subject: [PATCH] fix x86-64 ptrace access to 32-bit vsyscall page
X-Zippy-Says: Yow!  It's a hole all the way to downtown Burbank!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I made get_user_pages support looking up a pte for the "gate" area, I
assumed it would be part of the kernel's fixed mappings.  On x86-64 running
a 32-bit task, the 32-bit vsyscall DSO page still has no vma but has its
pte allocated in the user mm in the normal fashion.  This patch makes it
use the generic page-table lookup calls rather than the shortcuts.
With this, ptrace on x86-64 can access a 32-bit process's vsyscall page.
The behavior on x86 is unchanged.

Signed-off-by: Roland McGrath <roland@redhat.com>


Thanks,
Roland


Index: linux-2.6/mm/memory.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/mm/memory.c,v
retrieving revision 1.172
diff -p -u -r1.172 memory.c
--- linux-2.6/mm/memory.c 5 Jun 2004 17:52:06 -0000 1.172
+++ linux-2.6/mm/memory.c 24 Jun 2004 10:37:12 -0000
@@ -718,19 +718,24 @@ int get_user_pages(struct task_struct *t
 			pte_t *pte;
 			if (write) /* user gate pages are read-only */
 				return i ? : -EFAULT;
-			pgd = pgd_offset_k(pg);
+			pgd = pgd_offset(mm, pg);
 			if (!pgd)
 				return i ? : -EFAULT;
 			pmd = pmd_offset(pgd, pg);
 			if (!pmd)
 				return i ? : -EFAULT;
-			pte = pte_offset_kernel(pmd, pg);
-			if (!pte || !pte_present(*pte))
+			pte = pte_offset_map(pmd, pg);
+			if (!pte)
 				return i ? : -EFAULT;
+			if (!pte_present(*pte)) {
+				pte_unmap(pte);
+				return i ? : -EFAULT;
+			}
 			if (pages) {
 				pages[i] = pte_page(*pte);
 				get_page(pages[i]);
 			}
+			pte_unmap(pte);
 			if (vmas)
 				vmas[i] = gate_vma;
 			i++;
