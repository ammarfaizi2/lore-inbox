Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbUDEHph (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 03:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbUDEHph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 03:45:37 -0400
Received: from ozlabs.org ([203.10.76.45]:44422 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261791AbUDEHoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 03:44:15 -0400
Date: Mon, 5 Apr 2004 17:41:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@lists.linuxppc.org
Subject: Fix bug in PPC64 hugepage support
Message-ID: <20040405074120.GA13844@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
	linuxppc64-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply.  Came across this nasty bug while working on
some hugepage extensions.

The PPC64 version of is_aligned_hugepage_range() is buggy.  It is
supposed to test not only that the given range is hugepage aligned,
but that it lies within the address space allowed for hugepages.  We
were checking only that the given range intersected the hugepage
range, not that it lay entirely within it.  This patch fixes the
problem and changes the name of some macros to make it less likely to
make that misunderstanding again.


Index: working-2.6/arch/ppc64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hugetlbpage.c	2004-04-05 14:04:36.000000000 +1000
+++ working-2.6/arch/ppc64/mm/hugetlbpage.c	2004-04-05 17:29:59.477683088 +1000
@@ -230,7 +230,8 @@
 		return -EINVAL;
 	if (addr & ~HPAGE_MASK)
 		return -EINVAL;
-	if (! is_hugepage_only_range(addr, len))
+	if (! (within_hugepage_low_range(addr, len)
+	       || within_hugepage_high_range(addr, len)) )
 		return -EINVAL;
 	return 0;
 }
@@ -300,9 +301,9 @@
 
 int prepare_hugepage_range(unsigned long addr, unsigned long len)
 {
-	if (is_hugepage_high_range(addr, len))
+	if (within_hugepage_high_range(addr, len))
 		return 0;
-	else if (is_hugepage_low_range(addr, len))
+	else if (within_hugepage_low_range(addr, len))
 		return open_32bit_htlbpage_range(current->mm);
 
 	return -EINVAL;
Index: working-2.6/include/asm-ppc64/page.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/page.h	2004-04-05 15:36:38.440651616 +1000
+++ working-2.6/include/asm-ppc64/page.h	2004-04-05 17:23:02.572693960 +1000
@@ -40,15 +40,19 @@
 #define ARCH_HAS_HUGEPAGE_ONLY_RANGE
 #define ARCH_HAS_PREPARE_HUGEPAGE_RANGE
 
-#define is_hugepage_low_range(addr, len) \
+#define touches_hugepage_low_range(addr, len) \
 	(((addr) > (TASK_HPAGE_BASE_32-(len))) && ((addr) < TASK_HPAGE_END_32))
-#define is_hugepage_high_range(addr, len) \
+#define touches_hugepage_high_range(addr, len) \
 	(((addr) > (TASK_HPAGE_BASE-(len))) && ((addr) < TASK_HPAGE_END))
+#define within_hugepage_low_range(addr, len) (((addr) >= TASK_HPAGE_BASE_32) \
+	  && ((addr)+(len) <= TASK_HPAGE_END_32) && ((addr)+(len) >= (addr)))
+#define within_hugepage_high_range(addr, len) (((addr) >= TASK_HPAGE_BASE) \
+	  && ((addr)+(len) <= TASK_HPAGE_END) && ((addr)+(len) >= (addr)))
 
 #define is_hugepage_only_range(addr, len) \
-	(is_hugepage_high_range((addr), (len)) || \
+	(touches_hugepage_high_range((addr), (len)) || \
 	 (current->mm->context.low_hpages \
-	  && is_hugepage_low_range((addr), (len))))
+	  && touches_hugepage_low_range((addr), (len))))
 #define hugetlb_free_pgtables free_pgtables
 #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 



-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
