Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbVI2RvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbVI2RvW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 13:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVI2RvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 13:51:21 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:29139 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932283AbVI2RvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 13:51:21 -0400
Subject: Re: inconsistent mmap and get_user_pages with hugetlbfs on ppc64
From: Adam Litke <agl@us.ibm.com>
To: "Sexton, Matt" <sexton@mc.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <92CB67C83EE773499A7F2F6EA7E3FC940F0E99@ad-email1.ad.mc.com>
References: <92CB67C83EE773499A7F2F6EA7E3FC940F0E99@ad-email1.ad.mc.com>
Content-Type: text/plain
Organization: IBM
Date: Thu, 29 Sep 2005 12:50:52 -0500
Message-Id: <1128016252.3768.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-16 at 18:52 -0400, Sexton, Matt wrote:
> On a ppc64 platform running 2.6.13-1, the virtual to physical mapping
> established by mmap'ing a hugetlbfs file does not seem to match the
> mapping described by get_user_pages().

Matt, you might want to try with something newer like 2.6.14-rc2-git6
and the following patch from Ben Herrenschmidt.  We found a few issues
with the hardware hash table and they should be fixed now (with the
patch below).  Is the system you are testing on LPAR or native?  Power4
or 5?

--- snip ---

My previous patch fixing invalidation of huge PTEs wasn't good enough,
we still had an issue if a PTE invalidation batch contained both small
and large pages. This patch fixes this by making sure the batch is
flushed if the page size fed to it changes.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc64/mm/hash_native.c
===================================================================
--- linux-work.orig/arch/ppc64/mm/hash_native.c	2005-09-27 11:43:27.000000000 +1000
+++ linux-work/arch/ppc64/mm/hash_native.c	2005-09-27 11:48:06.000000000 +1000
@@ -343,7 +343,7 @@
 	hpte_t *hptep;
 	unsigned long hpte_v;
 	struct ppc64_tlb_batch *batch = &__get_cpu_var(ppc64_tlb_batch);
-	unsigned long large;
+	unsigned long large = batch->large;
 
 	local_irq_save(flags);
 
@@ -356,7 +356,6 @@
 
 		va = (vsid << 28) | (batch->addr[i] & 0x0fffffff);
 		batch->vaddr[j] = va;
-		large = pte_huge(batch->pte[i]);
 		if (large)
 			vpn = va >> HPAGE_SHIFT;
 		else
@@ -406,7 +405,7 @@
 		asm volatile("ptesync":::"memory");
 
 		for (i = 0; i < j; i++)
-			__tlbie(batch->vaddr[i], 0);
+			__tlbie(batch->vaddr[i], large);
 
 		asm volatile("eieio; tlbsync; ptesync":::"memory");
 
Index: linux-work/arch/ppc64/mm/tlb.c
===================================================================
--- linux-work.orig/arch/ppc64/mm/tlb.c	2005-09-27 11:43:27.000000000 +1000
+++ linux-work/arch/ppc64/mm/tlb.c	2005-09-27 11:47:35.000000000 +1000
@@ -143,7 +143,8 @@
 	 * up scanning and resetting referenced bits then our batch context
 	 * will change mid stream.
 	 */
-	if (unlikely(i != 0 && context != batch->context)) {
+	if (i != 0 && (context != batch->context ||
+		       batch->large != pte_huge(pte))) {
 		flush_tlb_pending();
 		i = 0;
 	}
@@ -151,6 +152,7 @@
 	if (i == 0) {
 		batch->context = context;
 		batch->mm = mm;
+		batch->large = pte_huge(pte);
 	}
 	batch->pte[i] = __pte(pte);
 	batch->addr[i] = addr;
Index: linux-work/include/asm-ppc64/tlbflush.h
===================================================================
--- linux-work.orig/include/asm-ppc64/tlbflush.h	2005-09-27 11:43:27.000000000 +1000
+++ linux-work/include/asm-ppc64/tlbflush.h	2005-09-27 11:45:09.000000000 +1000
@@ -25,6 +25,7 @@
 	pte_t pte[PPC64_TLB_BATCH_NR];
 	unsigned long addr[PPC64_TLB_BATCH_NR];
 	unsigned long vaddr[PPC64_TLB_BATCH_NR];
+	unsigned int large;
 };
 DECLARE_PER_CPU(struct ppc64_tlb_batch, ppc64_tlb_batch);
 

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

