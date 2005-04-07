Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262571AbVDGT0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbVDGT0P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 15:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbVDGT0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 15:26:15 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:6598 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S262571AbVDGT0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 15:26:13 -0400
Date: Thu, 7 Apr 2005 14:26:05 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@blarg.somerset.sps.mot.com
To: Andrew Morton <akpm@osdl.org>
cc: linuxppc-dev@ozlabs.org, linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ppc32: Allow adjust of pfn offset in pte
Message-ID: <Pine.LNX.4.61.0504071414230.5277@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Allow the pfn to be offset by more than just PAGE_SHIFT in the pte.  
Today, PAGE_SHIFT tends to allow us to have 12-bits of flags in the pte.  
In the future if we have a larger pte we can allocate more bits for flags 
by offsetting the pfn even further.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---

diff -Nru a/include/asm-ppc/pgtable.h b/include/asm-ppc/pgtable.h
--- a/include/asm-ppc/pgtable.h	2005-04-07 14:25:07 -05:00
+++ b/include/asm-ppc/pgtable.h	2005-04-07 14:25:07 -05:00
@@ -431,10 +431,15 @@
  * Conversions between PTE values and page frame numbers.
  */
 
-#define pte_pfn(x)		(pte_val(x) >> PAGE_SHIFT)
+/* in some case we want to additionaly adjust where the pfn is in the pte to
+ * allow room for more flags */
+#define PFN_SHIFT_OFFSET	(PAGE_SHIFT)
+
+#define pte_pfn(x)		(pte_val(x) >> PFN_SHIFT_OFFSET)
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
 
-#define pfn_pte(pfn, prot)	__pte(((pte_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
+#define pfn_pte(pfn, prot)	__pte(((pte_basic_t)(pfn) << PFN_SHIFT_OFFSET) |\
+					pgprot_val(prot))
 #define mk_pte(page, prot)	pfn_pte(page_to_pfn(page), prot)
 
 /*
