Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264757AbUDWIWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264757AbUDWIWq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 04:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264756AbUDWIWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 04:22:46 -0400
Received: from ozlabs.org ([203.10.76.45]:1980 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264757AbUDWIVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 04:21:50 -0400
Date: Fri, 23 Apr 2004 18:18:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: apw@shadowen.org, agl@us.ibm.com, mbligh@us.ibm.com,
       linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: put_page() tries to handle hugepages but fails
Message-ID: <20040423081856.GJ9243@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, apw@shadowen.org, agl@us.ibm.com,
	mbligh@us.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc64-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply.

The code of put_page() is misleading, in that it appears to have code
handling PageCompound pages (i.e. hugepages).  However it won't
actually handle them correctly - __page_cache_release() will not work
properly on a compound.  Instead, hugepages should be and are released
with huge_page_release() from mm/hugetlb.c.  This patch removes the
broken PageCompound path from put_page(), replacing it with a
BUG_ON().  This also removes the initialization of page[1].mapping
from compoound pages, which was only ever used in this broken code
path.

Index: working-2.6/mm/swap.c
===================================================================
--- working-2.6.orig/mm/swap.c	2004-04-14 12:22:49.000000000 +1000
+++ working-2.6/mm/swap.c	2004-04-23 18:13:53.932263936 +1000
@@ -38,17 +38,7 @@
 
 void put_page(struct page *page)
 {
-	if (unlikely(PageCompound(page))) {
-		page = (struct page *)page->private;
-		if (put_page_testzero(page)) {
-			if (page[1].mapping) {	/* destructor? */
-				(*(void (*)(struct page *))page[1].mapping)(page);
-			} else {
-				__page_cache_release(page);
-			}
-		}
-		return;
-	}
+	BUG_ON(PageCompound(page));
 	if (!PageReserved(page) && put_page_testzero(page))
 		__page_cache_release(page);
 }
Index: working-2.6/mm/page_alloc.c
===================================================================
--- working-2.6.orig/mm/page_alloc.c	2004-04-13 11:42:42.000000000 +1000
+++ working-2.6/mm/page_alloc.c	2004-04-23 18:18:06.799295248 +1000
@@ -118,7 +118,6 @@
 	int i;
 	int nr_pages = 1 << order;
 
-	page[1].mapping = 0;
 	page[1].index = order;
 	for (i = 0; i < nr_pages; i++) {
 		struct page *p = page + i;




-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
