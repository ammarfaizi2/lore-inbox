Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbVIJL7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbVIJL7P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 07:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbVIJL6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 07:58:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:49104 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750761AbVIJL6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 07:58:50 -0400
Date: Sat, 10 Sep 2005 13:58:49 +0200
From: "Andi Kleen" <ak@suse.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [1/3] {PREFIX:-x86_64}: Fix MPOL_F_VERIFY
Message-ID: <4322CA79.mailAO011ADRR@suse.de>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix MPOL_F_VERIFY

There was a pretty bad bug in there that the code would
always check the full VMA, not the range the user requested.

When the VMA to be checked was merged with the previous VMA this
could lead to spurious failures.

Index: linux-2.6.13-work/mm/mempolicy.c
===================================================================
--- linux-2.6.13-work.orig/mm/mempolicy.c
+++ linux-2.6.13-work/mm/mempolicy.c
@@ -338,8 +338,13 @@ check_range(struct mm_struct *mm, unsign
 		if (prev && prev->vm_end < vma->vm_start)
 			return ERR_PTR(-EFAULT);
 		if ((flags & MPOL_MF_STRICT) && !is_vm_hugetlb_page(vma)) {
+			unsigned long endvma = vma->vm_end; 
+			if (endvma > end)
+				endvma = end;
+			if (vma->vm_start > start)
+				start = vma->vm_start;
 			err = check_pgd_range(vma->vm_mm,
-					   vma->vm_start, vma->vm_end, nodes);
+					   start, endvma, nodes);
 			if (err) {
 				first = ERR_PTR(err);
 				break;
