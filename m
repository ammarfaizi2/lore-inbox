Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbUDPERh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 00:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbUDPERh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 00:17:37 -0400
Received: from ozlabs.org ([203.10.76.45]:10136 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262224AbUDPERe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 00:17:34 -0400
Date: Fri, 16 Apr 2004 14:12:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@lists.linuxppc.org
Subject: Fix bogus get_page() calls in hugepage code
Message-ID: <20040416041231.GB13552@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

On some archs the functions used to implement follow_page() for
hugepages do a get_page().  This is unlike the normal-page path for
follow_page(), so presumably a bug.  This patch fixes it.


Index: working-2.6/arch/ppc64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hugetlbpage.c	2004-04-13 11:42:35.000000000 +1000
+++ working-2.6/arch/ppc64/mm/hugetlbpage.c	2004-04-16 13:45:22.000000000 +1000
@@ -360,10 +360,8 @@
 	BUG_ON(! pmd_hugepage(*pmd));
 
 	page = hugepte_page(*(hugepte_t *)pmd);
-	if (page) {
+	if (page)
 		page += ((address & ~HPAGE_MASK) >> PAGE_SHIFT);
-		get_page(page);
-	}
 	return page;
 }
 
Index: working-2.6/arch/i386/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/i386/mm/hugetlbpage.c	2004-04-13 11:42:35.000000000 +1000
+++ working-2.6/arch/i386/mm/hugetlbpage.c	2004-04-16 13:45:22.000000000 +1000
@@ -206,10 +206,8 @@
 	struct page *page;
 
 	page = pte_page(*(pte_t *)pmd);
-	if (page) {
+	if (page)
 		page += ((address & ~HPAGE_MASK) >> PAGE_SHIFT);
-		get_page(page);
-	}
 	return page;
 }
 #endif
Index: working-2.6/arch/ia64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/ia64/mm/hugetlbpage.c	2004-04-14 12:22:48.000000000 +1000
+++ working-2.6/arch/ia64/mm/hugetlbpage.c	2004-04-16 13:45:22.000000000 +1000
@@ -170,7 +170,6 @@
 	ptep = huge_pte_offset(mm, addr);
 	page = pte_page(*ptep);
 	page += ((addr & ~HPAGE_MASK) >> PAGE_SHIFT);
-	get_page(page);
 	return page;
 }
 int pmd_huge(pmd_t pmd)

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
