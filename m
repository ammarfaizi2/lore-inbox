Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423816AbWKPLAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423816AbWKPLAx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 06:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423822AbWKPLAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 06:00:53 -0500
Received: from mx2.cs.washington.edu ([128.208.2.105]:63445 "EHLO
	mx2.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1423816AbWKPLAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 06:00:52 -0500
Date: Thu, 16 Nov 2006 03:00:43 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: ak@suse.de
cc: clameter@sgi.com, linux-kernel@vger.kernel.org
Subject: [PATCH] mempolicy: use vma_policy and vma_set_policy macros
Message-ID: <Pine.LNX.4.64N.0611160253510.3429@attu4.cs.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use vma_policy() and vma_set_policy() macros provided in 
include/linux/mempolicy.h.

Cc: Andi Kleen <ak@suse.de>
Cc: Christoph Lameter <clameter@sgi.com>
Signed-off-by: David Rientjes <rientjes@cs.washington.edu>
---
 mm/mempolicy.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 617fb31..99e6560 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -379,7 +379,7 @@ check_range(struct mm_struct *mm, unsign
 static int policy_vma(struct vm_area_struct *vma, struct mempolicy *new)
 {
 	int err = 0;
-	struct mempolicy *old = vma->vm_policy;
+	struct mempolicy *old = vma_policy(vma);
 
 	PDprintk("vma %lx-%lx/%lx vm_ops %p vm_file %p set_policy %p\n",
 		 vma->vm_start, vma->vm_end, vma->vm_pgoff,
@@ -390,7 +390,7 @@ static int policy_vma(struct vm_area_str
 		err = vma->vm_ops->set_policy(vma, new);
 	if (!err) {
 		mpol_get(new);
-		vma->vm_policy = new;
+		vma_set_policy(vma, new);
 		mpol_free(old);
 	}
 	return err;
@@ -542,7 +542,7 @@ long do_get_mempolicy(int *policy, nodem
 		if (vma->vm_ops && vma->vm_ops->get_policy)
 			pol = vma->vm_ops->get_policy(vma, addr);
 		else
-			pol = vma->vm_policy;
+			pol = vma_policy(vma);
 	} else if (addr)
 		return -EINVAL;
 
@@ -1078,9 +1078,9 @@ static struct mempolicy * get_vma_policy
 	if (vma) {
 		if (vma->vm_ops && vma->vm_ops->get_policy)
 			pol = vma->vm_ops->get_policy(vma, addr);
-		else if (vma->vm_policy &&
-				vma->vm_policy->policy != MPOL_DEFAULT)
-			pol = vma->vm_policy;
+		else if (vma_policy(vma) &&
+				vma_policy(vma)->policy != MPOL_DEFAULT)
+			pol = vma_policy(vma);
 	}
 	if (!pol)
 		pol = &default_policy;
@@ -1697,7 +1697,7 @@ void mpol_rebind_mm(struct mm_struct *mm
 
 	down_write(&mm->mmap_sem);
 	for (vma = mm->mmap; vma; vma = vma->vm_next)
-		mpol_rebind_policy(vma->vm_policy, new);
+		mpol_rebind_policy(vma_policy(vma), new);
 	up_write(&mm->mmap_sem);
 }
 
