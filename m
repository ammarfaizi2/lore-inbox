Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030310AbVIOBE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030310AbVIOBE5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 21:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbVIOBEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 21:04:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27329 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030308AbVIOBEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 21:04:42 -0400
Message-Id: <20050915010410.499747000@localhost.localdomain>
References: <20050915010343.577985000@localhost.localdomain>
Date: Wed, 14 Sep 2005 18:03:52 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Andi Kleen <ak@suse.de>,
       Chris Wright <chrisw@osdl.org>
Subject: [PATCH 09/11] [PATCH] Fix MPOL_F_VERIFY
Content-Disposition: inline; filename=fix-MPOL_F_VERIFY.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

There was a pretty bad bug in there that the code would
always check the full VMA, not the range the user requested.

When the VMA to be checked was merged with the previous VMA this
could lead to spurious failures.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 mm/mempolicy.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

Index: linux-2.6.13.y/mm/mempolicy.c
===================================================================
--- linux-2.6.13.y.orig/mm/mempolicy.c
+++ linux-2.6.13.y/mm/mempolicy.c
@@ -333,8 +333,13 @@ check_range(struct mm_struct *mm, unsign
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

--
