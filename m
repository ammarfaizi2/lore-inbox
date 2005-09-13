Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932619AbVIMMBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbVIMMBO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 08:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbVIMMBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 08:01:14 -0400
Received: from ns1.suse.de ([195.135.220.2]:38846 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932619AbVIMMBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 08:01:13 -0400
From: Andi Kleen <ak@suse.de>
To: stable@kernel.org
Subject: [PATCH] [for 2.6.13-stable] Fix MPOL_F_VERIFY
Date: Tue, 13 Sep 2005 14:01:08 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509131401.08764.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix MPOL_F_VERIFY

There was a pretty bad bug in there that the code would
always check the full VMA, not the range the user requested.

When the VMA to be checked was merged with the previous VMA this
could lead to spurious failures.

Signed-off-by: Andi Kleen <ak@suse.de>

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
