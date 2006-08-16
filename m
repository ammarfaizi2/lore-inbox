Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWHPPAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWHPPAK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 11:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWHPPAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 11:00:09 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:16365 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751200AbWHPPAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 11:00:08 -0400
Subject: Re: 2.6.18-rc3->rc4 hugetlbfs regression
From: Adam Litke <agl@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Yao Fei Zhu <zhuyaof@cn.ibm.com>,
       Suzuki Kp <suzukikp@in.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       lge@us.ibm.com, PPC External List <linuxppc-dev@ozlabs.org>,
       "ADAM G. LITKE [imap]" <agl@us.ibm.com>
In-Reply-To: <1155655344.12700.45.camel@localhost.localdomain>
References: <1155655344.12700.45.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 10:00:04 -0500
Message-Id: <1155740404.21863.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-15 at 08:22 -0700, Dave Hansen wrote:
> kernel BUG in cache_free_debugcheck at mm/slab.c:2748!

Alright, this one is only triggered when slab debugging is enabled.  The slabs
are assumed to be aligned on a HUGEPTE_TABLE_SIZE boundary.  The free path
makes use of this assumption and uses the lowest nibble to pass around an index
into an array of kmem_cache pointers.  With slab debugging turned on, the slab
is still aligned, but the "working" object pointer is not.  This would break
the assumption above that a full nibble is available for the PGF_CACHENUM_MASK.

The following patch reduces PGF_CACHENUM_MASK to cover only the two least
significant bits, which is enough to cover the current number of 4 pgtable
cache types.  Then use this constant to mask out the appropriate part of the
huge pte pointer.

Signed-off-by: Adam Litke <agl@us.ibm.com>
---
 arch/powerpc/mm/hugetlbpage.c |    2 +-
 include/asm-powerpc/pgalloc.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
diff -upN reference/arch/powerpc/mm/hugetlbpage.c current/arch/powerpc/mm/hugetlbpage.c
--- reference/arch/powerpc/mm/hugetlbpage.c
+++ current/arch/powerpc/mm/hugetlbpage.c
@@ -153,7 +153,7 @@ static void free_hugepte_range(struct mm
 	hpdp->pd = 0;
 	tlb->need_flush = 1;
 	pgtable_free_tlb(tlb, pgtable_free_cache(hugepte, HUGEPTE_CACHE_NUM,
-						 HUGEPTE_TABLE_SIZE-1));
+						 PGF_CACHENUM_MASK));
 }
 
 #ifdef CONFIG_PPC_64K_PAGES
diff -upN reference/include/asm-powerpc/pgalloc.h current/include/asm-powerpc/pgalloc.h
--- reference/include/asm-powerpc/pgalloc.h
+++ current/include/asm-powerpc/pgalloc.h
@@ -117,7 +117,7 @@ static inline void pte_free(struct page 
 	pte_free_kernel(page_address(ptepage));
 }
 
-#define PGF_CACHENUM_MASK	0xf
+#define PGF_CACHENUM_MASK	0x3
 
 typedef struct pgtable_free {
 	unsigned long val;


-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

