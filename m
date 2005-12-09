Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbVLICcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbVLICcO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 21:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbVLICcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 21:32:14 -0500
Received: from ozlabs.org ([203.10.76.45]:28909 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751249AbVLICcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 21:32:13 -0500
Date: Fri, 9 Dec 2005 13:31:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: powerpc: Fix SLB flushing path in hugepage
Message-ID: <20051209023155.GA6517@localhost.localdomain>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Paulus, please apply and forward upstream.  This is a
potentially serious bug which should be fixed before 2.6.15.

On ppc64, when opening a new hugepage region, we need to make sure any
old normal-page SLBs for the area are flushed on all CPUs.  There was
a bug in this logic - after putting the new hugepage area masks into
the thread structure, we copied it into the paca (read by the SLB miss
handler) only on one CPU, not on all.  This could cause incorrect SLB
entries to be loaded when a multithreaded program was running
simultaneously on several CPUs.  This patch corrects the error,
copying the context information into the PACA on all CPUs using the mm
in question before flushing any existing SLB entries.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/powerpc/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/hugetlbpage.c	2005-12-09 13:13:26.000000000 +1100
+++ working-2.6/arch/powerpc/mm/hugetlbpage.c	2005-12-09 13:15:56.000000000 +1100
@@ -133,43 +133,64 @@ pte_t huge_ptep_get_and_clear(struct mm_
 	return __pte(old);
 }
 
+struct slb_flush_info {
+	struct mm_struct *mm;
+	u16 newareas;
+};
+
 static void flush_low_segments(void *parm)
 {
-	u16 areas = (unsigned long) parm;
+	struct slb_flush_info *fi = parm;
 	unsigned long i;
 
-	asm volatile("isync" : : : "memory");
+	BUILD_BUG_ON((sizeof(fi->newareas)*8) != NUM_LOW_AREAS);
+
+	if (current->mm != fi->mm)
+		return;
+
+
+	/* Only need to do anything if this CPU is working in the same
+	 * mm as the one which has changed */
 
-	BUILD_BUG_ON((sizeof(areas)*8) != NUM_LOW_AREAS);
+	/* update the paca copy of the context struct */
+	get_paca()->context = current->mm->context;
 
+	asm volatile("isync" : : : "memory");
 	for (i = 0; i < NUM_LOW_AREAS; i++) {
-		if (! (areas & (1U << i)))
+		if (! (fi->newareas & (1U << i)))
 			continue;
 		asm volatile("slbie %0"
 			     : : "r" ((i << SID_SHIFT) | SLBIE_C));
 	}
-
 	asm volatile("isync" : : : "memory");
 }
 
 static void flush_high_segments(void *parm)
 {
-	u16 areas = (unsigned long) parm;
+	struct slb_flush_info *fi = parm;
 	unsigned long i, j;
 
-	asm volatile("isync" : : : "memory");
 
-	BUILD_BUG_ON((sizeof(areas)*8) != NUM_HIGH_AREAS);
+	BUILD_BUG_ON((sizeof(fi->newareas)*8) != NUM_HIGH_AREAS);
+
+	if (current->mm != fi->mm)
+		return;
 
+	/* Only need to do anything if this CPU is working in the same
+	 * mm as the one which has changed */
+
+	/* update the paca copy of the context struct */
+	get_paca()->context = current->mm->context;
+
+	asm volatile("isync" : : : "memory");
 	for (i = 0; i < NUM_HIGH_AREAS; i++) {
-		if (! (areas & (1U << i)))
+		if (! (fi->newareas & (1U << i)))
 			continue;
 		for (j = 0; j < (1UL << (HTLB_AREA_SHIFT-SID_SHIFT)); j++)
 			asm volatile("slbie %0"
 				     :: "r" (((i << HTLB_AREA_SHIFT)
-					     + (j << SID_SHIFT)) | SLBIE_C));
+					      + (j << SID_SHIFT)) | SLBIE_C));
 	}
-
 	asm volatile("isync" : : : "memory");
 }
 
@@ -214,6 +235,7 @@ static int prepare_high_area_for_htlb(st
 static int open_low_hpage_areas(struct mm_struct *mm, u16 newareas)
 {
 	unsigned long i;
+	struct slb_flush_info fi;
 
 	BUILD_BUG_ON((sizeof(newareas)*8) != NUM_LOW_AREAS);
 	BUILD_BUG_ON((sizeof(mm->context.low_htlb_areas)*8) != NUM_LOW_AREAS);
@@ -229,19 +251,20 @@ static int open_low_hpage_areas(struct m
 
 	mm->context.low_htlb_areas |= newareas;
 
-	/* update the paca copy of the context struct */
-	get_paca()->context = mm->context;
-
 	/* the context change must make it to memory before the flush,
 	 * so that further SLB misses do the right thing. */
 	mb();
-	on_each_cpu(flush_low_segments, (void *)(unsigned long)newareas, 0, 1);
+
+	fi.mm = mm;
+	fi.newareas = newareas;
+	on_each_cpu(flush_low_segments, &fi, 0, 1);
 
 	return 0;
 }
 
 static int open_high_hpage_areas(struct mm_struct *mm, u16 newareas)
 {
+	struct slb_flush_info fi;
 	unsigned long i;
 
 	BUILD_BUG_ON((sizeof(newareas)*8) != NUM_HIGH_AREAS);
@@ -265,7 +288,10 @@ static int open_high_hpage_areas(struct 
 	/* the context change must make it to memory before the flush,
 	 * so that further SLB misses do the right thing. */
 	mb();
-	on_each_cpu(flush_high_segments, (void *)(unsigned long)newareas, 0, 1);
+
+	fi.mm = mm;
+	fi.newareas = newareas;
+	on_each_cpu(flush_high_segments, &fi, 0, 1);
 
 	return 0;
 }

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
