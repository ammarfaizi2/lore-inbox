Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbUKDEBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbUKDEBd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 23:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbUKDEBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 23:01:33 -0500
Received: from ozlabs.org ([203.10.76.45]:45528 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261591AbUKDEBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 23:01:30 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16777.39326.794227.106863@cargo.ozlabs.ibm.com>
Date: Thu, 4 Nov 2004 13:53:18 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, nathanl@austin.ibm.com, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64 mmu_context_init needs to run earlier
In-Reply-To: <20041103150438.05d6c913.akpm@osdl.org>
References: <16775.5912.788675.644838@cargo.ozlabs.ibm.com>
	<20041103150438.05d6c913.akpm@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> This all seemed to peter out.  Did we end up with a more convincing patch?

Yes, the one from Nathan Lynch that uses idr_get_new_above with an
argument of 1 rather than 0.  Here is the patch:

Using idr_get_new_above in init_new_context lets us get rid of an
awkward init function which wasn't running early enough in boot
anyway.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -puN arch/ppc64/mm/init.c~ppc64-mmu-context-use-idr_get_new_above
arch/ppc64/mm/init.c
---
linux-2.6.10-rc1-bk12/arch/ppc64/mm/init.c~ppc64-mmu-context-use-idr_get_new_above	2004-11-02 16:28:57.000000000 -0600
+++ linux-2.6.10-rc1-bk12-nathanl/arch/ppc64/mm/init.c	2004-11-02
17:49:08.000000000 -0600
@@ -489,7 +489,7 @@ again:
 		return -ENOMEM;
 
 	spin_lock(&mmu_context_lock);
-	err = idr_get_new(&mmu_context_idr, NULL, &index);
+	err = idr_get_new_above(&mmu_context_idr, NULL, 1, &index);
 	spin_unlock(&mmu_context_lock);
 
 	if (err == -EAGAIN)
@@ -518,19 +518,6 @@ void destroy_context(struct mm_struct *m
 	hugetlb_mm_free_pgd(mm);
 }
 
-static int __init mmu_context_init(void)
-{
-	int index;
-
-	/* Reserve the first (invalid) context*/
-	idr_pre_get(&mmu_context_idr, GFP_KERNEL);
-	idr_get_new(&mmu_context_idr, NULL, &index);
-	BUG_ON(0 != index);
-
-	return 0;
-}
-arch_initcall(mmu_context_init);
-
 /*
  * Do very early mm setup.
  */
