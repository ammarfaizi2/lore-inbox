Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWDZPo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWDZPo2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 11:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbWDZPo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 11:44:28 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:41732 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S964823AbWDZPo1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 11:44:27 -0400
Message-ID: <444F955A.6050206@vmware.com>
Date: Wed, 26 Apr 2006 08:44:26 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: Hugh Dickins <hugh@veritas.com>, Jan Beulich <jbeulich@novell.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: PAE entries must have their low word cleared first
References: <444F95D8.76E4.0078.0@novell.com> <Pine.LNX.4.64.0604261538260.9915@blonde.wat.veritas.com> <946b367619cfd3dcd3ba547e216e494b@cl.cam.ac.uk>
In-Reply-To: <946b367619cfd3dcd3ba547e216e494b@cl.cam.ac.uk>
Content-Type: multipart/mixed;
 boundary="------------010609020307020005010900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010609020307020005010900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Keir Fraser wrote:
>
> We cannot use pte_clear() unless we redefine it for PAE. Currently it 
> reduces to set_pte() which explicitly uses the wrong ordering (sets 
> high *then* low, because it's normally used to introduce a mapping).

Yes, that means pte_clear() has the same bug.  Why don't we redefine 
pte_clear for PAE?  Then the ifdef can go away.

> Also, I think wmb() should be used in PAE's set_pte(), rather than the 
> current smp_wmb(). They reduce to the same thing, but wmb() makes it 
> clear this is is not an issue specific to SMP systems. 

I agree with that.  The problem is not related to SMP at all.  I would 
propose this approach.

--------------010609020307020005010900
Content-Type: text/plain;
 name="fix-pte-clear"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-pte-clear"

Proposed fix for ptep_get_and_clear_full PAE bug.  Pte_clear had the same
bug, so use the same fix for both.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.17-rc/include/asm-i386/pgtable.h
===================================================================
--- linux-2.6.17-rc.orig/include/asm-i386/pgtable.h	2006-04-25 15:41:06.000000000 -0700
+++ linux-2.6.17-rc/include/asm-i386/pgtable.h	2006-04-26 08:39:42.000000000 -0700
@@ -204,7 +204,6 @@ extern unsigned long long __PAGE_KERNEL,
 extern unsigned long pg0[];
 
 #define pte_present(x)	((x).pte_low & (_PAGE_PRESENT | _PAGE_PROTNONE))
-#define pte_clear(mm,addr,xp)	do { set_pte_at(mm, addr, xp, __pte(0)); } while (0)
 
 /* To avoid harmful races, pmd_none(x) should check only the lower when PAE */
 #define pmd_none(x)	(!(unsigned long)pmd_val(x))
@@ -268,7 +267,7 @@ static inline pte_t ptep_get_and_clear_f
 	pte_t pte;
 	if (full) {
 		pte = *ptep;
-		*ptep = __pte(0);
+		pte_clear(mm, addr, ptep);
 	} else {
 		pte = ptep_get_and_clear(mm, addr, ptep);
 	}
Index: linux-2.6.17-rc/include/asm-i386/pgtable-3level.h
===================================================================
--- linux-2.6.17-rc.orig/include/asm-i386/pgtable-3level.h	2006-04-25 15:41:06.000000000 -0700
+++ linux-2.6.17-rc/include/asm-i386/pgtable-3level.h	2006-04-26 08:38:57.000000000 -0700
@@ -85,6 +85,13 @@ static inline void pud_clear (pud_t * pu
 #define pmd_offset(pud, address) ((pmd_t *) pud_page(*(pud)) + \
 			pmd_index(address))
 
+static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
+{
+	ptep->pte_low = 0;
+	wmb();
+	ptep->pte_high = 0;
+}
+
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	pte_t res;
Index: linux-2.6.17-rc/include/asm-i386/pgtable-2level.h
===================================================================
--- linux-2.6.17-rc.orig/include/asm-i386/pgtable-2level.h	2006-04-25 15:41:06.000000000 -0700
+++ linux-2.6.17-rc/include/asm-i386/pgtable-2level.h	2006-04-26 08:37:34.000000000 -0700
@@ -18,6 +18,8 @@
 #define set_pte_atomic(pteptr, pteval) set_pte(pteptr,pteval)
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
 
+#define pte_clear(mm,addr,xp)	do { set_pte_at(mm, addr, xp, __pte(0)); } while (0)
+
 #define ptep_get_and_clear(mm,addr,xp)	__pte(xchg(&(xp)->pte_low, 0))
 #define pte_same(a, b)		((a).pte_low == (b).pte_low)
 #define pte_page(x)		pfn_to_page(pte_pfn(x))

--------------010609020307020005010900--
