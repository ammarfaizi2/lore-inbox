Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262430AbVBYEO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbVBYEO4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 23:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVBYEO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 23:14:56 -0500
Received: from ozlabs.org ([203.10.76.45]:36256 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262430AbVBYEOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 23:14:53 -0500
Date: Fri, 25 Feb 2005 15:14:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Adam Litke <agl@us.ibm.com>, Paul Mackerras <paulus@samba.org>,
       Anton Blanchard <anton@samba.org>, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: [PPC64] Hugepage hash flushing bugfix
Message-ID: <20050225041446.GC10725@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	Adam Litke <agl@us.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, linuxppc64-dev@lists.linuxppc.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Linus, please apply:

Fix a potentially bad (although very rarely triggered) bug in the
ppc64 hugepage code.  hpte_update() did not correctly calculate the
address for hugepages, so pte_clear() (which we use for hugepage ptes
as well as normal ones) would not correctly flush the hash page table
entry.  Under the right circumstances this could potentially lead to
duplicate hash entries, which is very bad.

davem's upcoming patch to pass the virtual address directly to
set_pte() and its ilk will obsolete this, but this is bad enough it
should probably be fixed in the meantime.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/arch/ppc64/mm/tlb.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/tlb.c	2004-09-09 09:59:49.000000000 +1000
+++ working-2.6/arch/ppc64/mm/tlb.c	2005-02-25 14:56:47.000000000 +1100
@@ -85,8 +85,12 @@
 
 	ptepage = virt_to_page(ptep);
 	mm = (struct mm_struct *) ptepage->mapping;
-	addr = ptepage->index +
-		(((unsigned long)ptep & ~PAGE_MASK) * PTRS_PER_PTE);
+	addr = ptepage->index;
+	if (pte_huge(pte))
+		addr +=  ((unsigned long)ptep & ~PAGE_MASK)
+			/ sizeof(*ptep) * HPAGE_SIZE;
+	else
+		addr += ((unsigned long)ptep & ~PAGE_MASK) * PTRS_PER_PTE;
 
 	if (REGION_ID(addr) == USER_REGION_ID)
 		context = mm->context.id;


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson
