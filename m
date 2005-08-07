Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbVHGMRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbVHGMRT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 08:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbVHGMRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 08:17:19 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:28939 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751214AbVHGMRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 08:17:19 -0400
Message-ID: <42F5FB9A.5000708@vmware.com>
Date: Sun, 07 Aug 2005 05:16:26 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pratap Subrahmanyam <pratap@vmware.com>
Subject: [PATCH] x86_64 Avoid some atomic operations during address space
 destruction
Content-Type: multipart/mixed;
 boundary="------------020002040000070901020104"
X-OriginalArrivalTime: 07 Aug 2005 12:16:45.0906 (UTC) FILETIME=[E0F5F320:01C59B49]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020002040000070901020104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This turned out to be a huge win on 32-bit i386 in PAE mode, but it is 
likely not as significant on x86_64; I don't know because I haven't 
actually measured the cost.  I don't have 64-bit hardware that I have 
the luxury of rebooting right now, so this patch is untested, but if 
someone wants to try this out, it might actually show a measurable win 
on fork/exit.  I lost my cycle count measurement diffs, but I don't 
think they would apply cleanly to x86_64 anyways.  This patch at least 
looks good, and compiles cleanly on 2.6.13-rc5-mm1, thus passing some 
level of testing.

Also, it might show reduced latency on pre-emptible kernels during heavy 
fork/exit activity, possibly allowing ZAP_BLOCK_SIZE to be raised for 
some architectures (I measured a ~30-50% reduction in cycle timings for 
zap_pte_range on i386 with CONFIG_PREEMPT with the analogous patch).

Zach

--------------020002040000070901020104
Content-Type: text/plain;
 name="x86_64-pte-destruction"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x86_64-pte-destruction"

Any architecture that has hardware updated A/D bits that require
synchronization against other processors during PTE operations
can benefit from doing non-atomic PTE updates during address space
destruction.  Originally done on i386, now ported to x86_64.

Doing a read/write pair instead of an xchg() operation saves the
implicit lock, which turns out to be a big win on 32-bit (esp w PAE).

Diffs-against: 2.6.13-rc5-mm1
Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13-rc5-mm1/include/asm-x86_64/pgtable.h
===================================================================
--- linux-2.6.13-rc5-mm1.orig/include/asm-x86_64/pgtable.h	2005-08-07 04:56:37.000000000 -0700
+++ linux-2.6.13-rc5-mm1/include/asm-x86_64/pgtable.h	2005-08-07 04:59:18.601856096 -0700
@@ -104,6 +104,19 @@
 ((unsigned long) __va(pud_val(pud) & PHYSICAL_PAGE_MASK))
 
 #define ptep_get_and_clear(mm,addr,xp)	__pte(xchg(&(xp)->pte, 0))
+
+static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm, unsigned long addr, pte_t *ptep, int full)
+{
+	pte_t pte;
+	if (full) {
+		pte = *ptep;
+		*ptep = __pte(0);
+	} else {
+		pte = ptep_get_and_clear(mm, addr, ptep);
+	}
+	return pte;
+}
+
 #define pte_same(a, b)		((a).pte == (b).pte)
 
 #define PMD_SIZE	(1UL << PMD_SHIFT)
@@ -433,6 +446,7 @@
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_DIRTY
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR_FULL
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define __HAVE_ARCH_PTE_SAME
 #include <asm-generic/pgtable.h>

--------------020002040000070901020104--
