Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWCFBwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWCFBwK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 20:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWCFBwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 20:52:09 -0500
Received: from ozlabs.org ([203.10.76.45]:29078 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751114AbWCFBwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 20:52:08 -0500
Date: Mon, 6 Mar 2006 12:51:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: powerpc: Make pmd_bad() and pud_bad() checks non-trivial
Message-ID: <20060306015129.GA21408@localhost.localdomain>
Mail-Followup-To: Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@osdl.org>, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulus, please apply.

At present, the powerpc pmd_bad() and pud_bad() macros return false
unless the fiven pmd or pud is zero.  This patch makes these tests
more thorough, checking if the given pmd or pud looks like a plausible
pte page or pmd page pointer respectively.  This can result in helpful
error messages when messing with the pagetable code.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/include/asm-powerpc/pgtable.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/pgtable.h	2006-03-06 11:38:45.000000000 +1100
+++ working-2.6/include/asm-powerpc/pgtable.h	2006-03-06 12:51:14.000000000 +1100
@@ -188,9 +188,13 @@ static inline pte_t pfn_pte(unsigned lon
 #define pte_pfn(x)		((unsigned long)((pte_val(x)>>PTE_RPN_SHIFT)))
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
 
+#define PMD_BAD_BITS		(PTE_TABLE_SIZE-1)
+#define PUD_BAD_BITS		(PMD_TABLE_SIZE-1)
+
 #define pmd_set(pmdp, pmdval) 	(pmd_val(*(pmdp)) = (pmdval))
 #define pmd_none(pmd)		(!pmd_val(pmd))
-#define	pmd_bad(pmd)		(pmd_val(pmd) == 0)
+#define	pmd_bad(pmd)		(!is_kernel_addr(pmd_val(pmd)) \
+				 || (pmd_val(pmd) & PMD_BAD_BITS))
 #define	pmd_present(pmd)	(pmd_val(pmd) != 0)
 #define	pmd_clear(pmdp)		(pmd_val(*(pmdp)) = 0)
 #define pmd_page_kernel(pmd)	(pmd_val(pmd) & ~PMD_MASKED_BITS)
@@ -198,7 +202,8 @@ static inline pte_t pfn_pte(unsigned lon
 
 #define pud_set(pudp, pudval)	(pud_val(*(pudp)) = (pudval))
 #define pud_none(pud)		(!pud_val(pud))
-#define pud_bad(pud)		((pud_val(pud)) == 0)
+#define	pud_bad(pud)		(!is_kernel_addr(pud_val(pud)) \
+				 || (pud_val(pud) & PUD_BAD_BITS))
 #define pud_present(pud)	(pud_val(pud) != 0)
 #define pud_clear(pudp)		(pud_val(*(pudp)) = 0)
 #define pud_page(pud)		(pud_val(pud) & ~PUD_MASKED_BITS)

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
