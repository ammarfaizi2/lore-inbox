Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWDZWE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWDZWE7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 18:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWDZWE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 18:04:59 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:16654 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932405AbWDZWE6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 18:04:58 -0400
Date: Wed, 26 Apr 2006 15:03:52 -0700
Message-Id: <200604262203.k3QM3qOC009581@zach-dev.vmware.com>
Subject: [PATCH 2/2] I386 convert pae wmb to non smp
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.com>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Jan Beulich <jbeulich@novell.com>,
       Keir Fraser <Keir.Fraser@cl.cam.ac.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 26 Apr 2006 22:04:57.0833 (UTC) FILETIME=[74D12590:01C6697D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the last bug, on set_pte, we don't want the compiler to re-order
the write of the PTE, even in non-SMP configurations, since if the write of
the low word occurs first, the TLB could prefetch a bad highmem mapping which
has been aliased into low memory.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.17-rc/include/asm-i386/pgtable-3level.h
===================================================================
--- linux-2.6.17-rc.orig/include/asm-i386/pgtable-3level.h	2006-04-26 08:38:57.000000000 -0700
+++ linux-2.6.17-rc/include/asm-i386/pgtable-3level.h	2006-04-26 14:45:12.000000000 -0700
@@ -53,7 +53,7 @@ static inline int pte_exec_kernel(pte_t 
 static inline void set_pte(pte_t *ptep, pte_t pte)
 {
 	ptep->pte_high = pte.pte_high;
-	smp_wmb();
+	wmb();
 	ptep->pte_low = pte.pte_low;
 }
 #define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
