Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbTESGCa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 02:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbTESGCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 02:02:30 -0400
Received: from dp.samba.org ([66.70.73.150]:41127 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262312AbTESGC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 02:02:28 -0400
Date: Mon, 19 May 2003 16:15:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>
Subject: [PATCH] rename and extend check_valid_hugepage_range()
Message-ID: <20030519061525.GA4140@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	Anton Blanchard <anton@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply:

check_valid_hugepage_range() is a terrible name, because what it's
actually used to check is whether a range is invalid for normal pages,
rather than whether it's valid for hugepages.  It returns 0
(i.e. normal pages are ok) uniformly on all existing hugepage
implementations.  The patch below renames it to
"is_hugepage_only_range()".

Due to segment insanity, we'll need to override this function for the
ppc64 implementation of hugetlbfs which I'm working on.  However,
we'll need access to the mm_struct to do it.  This patch also adds
that.

diff -urN linux-congo/include/linux/hugetlb.h linux-hugepage/include/linux/hugetlb.h
--- linux-congo/include/linux/hugetlb.h	2003-03-10 08:16:21.000000000 +1100
+++ linux-hugepage/include/linux/hugetlb.h	2003-05-19 16:02:13.000000000 +1000
@@ -37,8 +37,8 @@
 		mm->used_hugetlb = 1;
 }
 
-#ifndef ARCH_HAS_VALID_HUGEPAGE_RANGE
-#define check_valid_hugepage_range(addr, len)	0
+#ifndef ARCH_HAS_HUGEPAGE_ONLY_RANGE
+#define is_hugepage_only_range(mm, addr, len)	0
 #endif
 
 #else /* !CONFIG_HUGETLB_PAGE */
@@ -62,7 +62,7 @@
 #define follow_huge_pmd(mm, addr, pmd, write)	0
 #define is_aligned_hugepage_range(addr, len)	0
 #define pmd_huge(x)	0
-#define check_valid_hugepage_range(addr, len)	0
+#define is_hugepage_only_range(mm, addr, len)	0
 
 #ifndef HPAGE_MASK
 #define HPAGE_MASK	0		/* Keep the compiler happy */
diff -urN linux-congo/mm/mmap.c linux-hugepage/mm/mmap.c
--- linux-congo/mm/mmap.c	2003-04-24 18:54:37.000000000 +1000
+++ linux-hugepage/mm/mmap.c	2003-05-19 16:02:21.000000000 +1000
@@ -829,7 +829,7 @@
 			 * reserved hugepage range.  For some archs like IA-64,
 			 * there is a separate region for hugepages.
 			 */
-			ret = check_valid_hugepage_range(addr, len);
+			ret = is_hugepage_only_range(mm, addr, len);
 		}
 		if (ret)
 			return ret;


-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
