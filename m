Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbUDAEvr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 23:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbUDAEvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 23:51:47 -0500
Received: from ozlabs.org ([203.10.76.45]:20632 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262253AbUDAEvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 23:51:45 -0500
Date: Thu, 1 Apr 2004 14:49:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: Add useful warning message in PPC64 hugepage code
Message-ID: <20040401044924.GC13436@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply:

This patch adds a debugging message to the ppc64 hugepage code when we
attempt to open the "low" (32-bit) hugepage window on PPC64, but can't
because a (non-hugepage) mapping already exists in the region.

Index: working-2.6/arch/ppc64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hugetlbpage.c	2004-04-01 14:28:49.000000000 +1000
+++ working-2.6/arch/ppc64/mm/hugetlbpage.c	2004-04-01 14:32:30.430607144 +1000
@@ -253,8 +253,11 @@
 	/* Check no VMAs are in the region */
 	vma = find_vma(mm, TASK_HPAGE_BASE_32);
 
-	if (vma && (vma->vm_start < TASK_HPAGE_END_32))
+	if (vma && (vma->vm_start < TASK_HPAGE_END_32)) {
+		printk(KERN_DEBUG "Low HTLB region busy: PID=%d  vma @ %lx-%lx\n",
+		       current->pid, vma->vm_start, vma->vm_end);
 		return -EBUSY;
+	}
 
 	/* Clean up any leftover PTE pages in the region */
 	spin_lock(&mm->page_table_lock);

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
