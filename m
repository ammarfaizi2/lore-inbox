Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbUKBWC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbUKBWC2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 17:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbUKBVxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 16:53:14 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:57806 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261929AbUKBVtu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 16:49:50 -0500
Subject: Re: [PATCH] PPC64 mmu_context_init needs to run earlier
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, torvalds@osdl.org,
       Anton Blanchard <anton@samba.org>, lkml <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20041101221336.5f6d8534.akpm@osdl.org>
References: <16775.5912.788675.644838@cargo.ozlabs.ibm.com>
	 <20041101221336.5f6d8534.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1099432625.23845.93.camel@pants.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 02 Nov 2004 15:57:05 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-02 at 00:13, Andrew Morton wrote:
> Paul Mackerras <paulus@samba.org> wrote:
> >
> > This patch changes mmu_context_init to be called as a core_initcall
> >  rather than an arch_initcall, since mmu_context_init needs to run
> >  before we try to run any userspace processes, and arch_initcall was
> >  found to be too late.
> 
> Here we go again...
> 
> I don't see why your patch fixes the problem.  do_basic_setup() calls
> driver_init() prior to any initcalls being run, and driver_init() can call
> /sbin/hotplug.

My original submission was more of a "works for me, not sure it's
correct" sort of thing.  Sorry I wasn't clear.

How about this instead:


Using idr_get_new_above in init_new_context lets us get rid of an
awkward init function which wasn't running early enough in boot
anyway.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>


---


diff -puN arch/ppc64/mm/init.c~ppc64-mmu-context-use-idr_get_new_above arch/ppc64/mm/init.c
--- linux-2.6.10-rc1-bk12/arch/ppc64/mm/init.c~ppc64-mmu-context-use-idr_get_new_above	2004-11-02 14:22:23.000000000 -0600
+++ linux-2.6.10-rc1-bk12-nathanl/arch/ppc64/mm/init.c	2004-11-02 14:29:09.000000000 -0600
@@ -489,7 +489,7 @@ again:
 		return -ENOMEM;
 
 	spin_lock(&mmu_context_lock);
-	err = idr_get_new(&mmu_context_idr, NULL, &index);
+	err = idr_get_new_above(&mmu_context_idr, NULL, 0, &index);
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


