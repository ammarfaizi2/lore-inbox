Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbUKCAC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbUKCAC6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 19:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262815AbUKCACc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 19:02:32 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:5520 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263053AbUKCAA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 19:00:59 -0500
Subject: Re: [PATCH] PPC64 mmu_context_init needs to run earlier
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Anton Blanchard <anton@samba.org>, lkml <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.58.0411021406010.2187@ppc970.osdl.org>
References: <16775.5912.788675.644838@cargo.ozlabs.ibm.com>
	 <20041101221336.5f6d8534.akpm@osdl.org>
	 <1099432625.23845.93.camel@pants.austin.ibm.com>
	 <Pine.LNX.4.58.0411021406010.2187@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1099440508.23845.135.camel@pants.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 02 Nov 2004 18:08:28 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-02 at 16:10, Linus Torvalds wrote:
> On Tue, 2 Nov 2004, Nathan Lynch wrote:
> > 
> > Using idr_get_new_above in init_new_context lets us get rid of an
> > awkward init function which wasn't running early enough in boot
> > anyway.
> 
> Ok, call me stupid, but what's the difference between
> 
> 	idr_get_new(&mmu_context_idr, NULL, &index);
> 
> and
> 
> 	idr_get_new_above(&mmu_context_idr, NULL, 0, &index);
> 
> because as far as I can tell, they are exactly the same.
> 
> They both just do a "idr_get_new_above_int(idp, ptr, 0)".

Right, bad patch.  I was confused by this bit in idr.c:

/**
 * idr_get_new_above - allocate new idr entry above a start id

into thinking the new entry would be strictly greater than the start id.

Here's another attempt, using 1 instead of 0 for the start id.


Using idr_get_new_above in init_new_context lets us get rid of an
awkward init function which wasn't running early enough in boot
anyway.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>


---


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

_


