Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbUEGGL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbUEGGL0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 02:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263225AbUEGGL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 02:11:26 -0400
Received: from ozlabs.org ([203.10.76.45]:23182 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263001AbUEGGLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 02:11:22 -0400
Date: Fri, 7 May 2004 16:07:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andy Whitworth <apw@shadowen.org>,
       Adam Litke <agl@us.ibm.com>, linuxppc64-dev@lists.linuxppc.org
Subject: Minor hugepage bugfix
Message-ID: <20040507060706.GE16901@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Andy Whitworth <apw@shadowen.org>, Adam Litke <agl@us.ibm.com>,
	linuxppc64-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

add_to_page_cache() locks the given page if and only if it suceeds.
The hugepage code (every arch), however, does an unlock_page() after
add_to_page_cache() before checking the return code, which could trip
the BUG() in unlock_page() if add_to_page_cache() failed.

In practice we've never hit this bug, because the only ways
add_to_page_cache() can fail are when we fail to allocate a radix tree
node (very rare), or when there is already a page at that offset in
the radix tree, which never happens during prefault, obviously.  We
should probably fix it anyway, though.

The analagous bug in some of the patches floating about to
demand-allocation of hugepages is more of a problem, because multiple
processes can race to instantiate a particular page in the radix tree
- that's been hit at least once (which is how I found this).

Index: working-2.6/arch/ppc64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hugetlbpage.c	2004-05-05 10:05:52.000000000 +1000
+++ working-2.6/arch/ppc64/mm/hugetlbpage.c	2004-05-07 15:52:28.536883064 +1000
@@ -452,8 +452,9 @@
 				goto out;
 			}
 			ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
-			unlock_page(page);
-			if (ret) {
+			if (! ret) {
+				unlock_page(page);
+			} else {
 				hugetlb_put_quota(mapping);
 				free_huge_page(page);
 				goto out;
Index: working-2.6/arch/i386/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/i386/mm/hugetlbpage.c	2004-04-28 09:37:18.000000000 +1000
+++ working-2.6/arch/i386/mm/hugetlbpage.c	2004-05-07 15:52:28.537882912 +1000
@@ -264,8 +264,9 @@
 				goto out;
 			}
 			ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
-			unlock_page(page);
-			if (ret) {
+			if (! ret) {
+				unlock_page(page);
+			} else {
 				hugetlb_put_quota(mapping);
 				free_huge_page(page);
 				goto out;
Index: working-2.6/arch/ia64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/ia64/mm/hugetlbpage.c	2004-04-28 09:37:18.000000000 +1000
+++ working-2.6/arch/ia64/mm/hugetlbpage.c	2004-05-07 15:53:19.858935352 +1000
@@ -293,8 +293,9 @@
 				goto out;
 			}
 			ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
-			unlock_page(page);
-			if (ret) {
+			if (! ret) {
+				unlock_page(page);
+			} else {
 				hugetlb_put_quota(mapping);
 				free_huge_page(page);
 				goto out;
Index: working-2.6/arch/sparc64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/sparc64/mm/hugetlbpage.c	2004-04-28 09:37:19.000000000 +1000
+++ working-2.6/arch/sparc64/mm/hugetlbpage.c	2004-05-07 15:53:54.482863760 +1000
@@ -244,8 +244,9 @@
 				goto out;
 			}
 			ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
-			unlock_page(page);
-			if (ret) {
+			if (! ret) {
+				unlock_page(page);
+			} else {
 				hugetlb_put_quota(mapping);
 				free_huge_page(page);
 				goto out;
Index: working-2.6/arch/sh/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/sh/mm/hugetlbpage.c	2004-04-28 09:37:19.000000000 +1000
+++ working-2.6/arch/sh/mm/hugetlbpage.c	2004-05-07 15:54:19.282954200 +1000
@@ -248,8 +248,9 @@
 				goto out;
 			}
 			ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
-			unlock_page(page);
-			if (ret) {
+			if (! ret) {
+				unlock_page(page);
+			} else {
 				hugetlb_put_quota(mapping);
 				free_huge_page(page);
 				goto out;



-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
