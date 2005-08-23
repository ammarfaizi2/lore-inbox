Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbVHWSMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbVHWSMu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 14:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbVHWSMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 14:12:50 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:37259 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932268AbVHWSMt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 14:12:49 -0400
Subject: Re: [Hugetlb x86] 3/3 Check p?d_present in huge_pte_offset()
From: Adam Litke <agl@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1124819866.4415.13.camel@localhost.localdomain>
References: <1124819866.4415.13.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Date: Tue, 23 Aug 2005 13:07:18 -0500
Message-Id: <1124820438.4415.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initial Post (Wed, 17 Aug 2005)

For demand faulting, we cannot assume that the page tables will be populated.
Do what the rest of the architectures do and test p?d_present() while walking
down the page table.

Diffed against 2.6.13-rc6

Signed-off-by: Adam Litke <agl@us.ibm.com>

---
 hugetlbpage.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)
diff -upN reference/arch/i386/mm/hugetlbpage.c current/arch/i386/mm/hugetlbpage.c
--- reference/arch/i386/mm/hugetlbpage.c
+++ current/arch/i386/mm/hugetlbpage.c
@@ -46,8 +46,11 @@ pte_t *huge_pte_offset(struct mm_struct 
 	pmd_t *pmd = NULL;
 
 	pgd = pgd_offset(mm, addr);
-	pud = pud_offset(pgd, addr);
-	pmd = pmd_offset(pud, addr);
+	if (pgd_present(*pgd)) {
+		pud = pud_offset(pgd, addr);
+		if (pud_present(*pud))
+			pmd = pmd_offset(pud, addr);
+	}
 	return (pte_t *) pmd;
 }
 


