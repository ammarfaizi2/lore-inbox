Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264301AbUEDKMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264301AbUEDKMO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 06:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264302AbUEDKMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 06:12:14 -0400
Received: from ozlabs.org ([203.10.76.45]:3732 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264301AbUEDKMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 06:12:10 -0400
Date: Tue, 4 May 2004 20:08:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@lists.linuxppc.org
Subject: [PPC64] Use slbie, not slbia in hugepage code
Message-ID: <20040504100800.GK21024@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
	linuxppc64-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply:

On PPC64, when we prepare segments below 4G for use with hugepages, we
need to flush their entries from the SLB, in case SLB entries
specifying normal pages were already present.

Previously we did that by flushing the entire SLB, the patch below
changes this to individually flush each necessary segment with slbie.
The new version may well be slightly faster, but the real reason for
it is so that this code path doesn't need to be changed to reinstate
any bolted SLB entries, if we add them.  The existing version has
already caused problems (read, crashes) when combined with some
patches that add bolted SLB entries.

Index: working-2.6/arch/ppc64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hugetlbpage.c	2004-05-04 16:35:55.000000000 +1000
+++ working-2.6/arch/ppc64/mm/hugetlbpage.c	2004-05-04 20:07:00.023964800 +1000
@@ -245,9 +245,20 @@
 	return 0;
 }
 
-static void do_slbia(void *unused)
+static void flush_segments(void *parm)
 {
-	asm volatile ("isync; slbia; isync":::"memory");
+	u16 segs = (unsigned long) parm;
+	unsigned long i;
+
+	asm volatile("isync" : : : "memory");
+
+	for (i = 0; i < 16; i++) {
+		if (! (segs & (1U << i)))
+			continue;
+		asm volatile("slbie %0" : : "r" (i << SID_SHIFT));
+	}
+
+	asm volatile("isync" : : : "memory");
 }
 
 static int prepare_low_seg_for_htlb(struct mm_struct *mm, unsigned long seg)
@@ -316,10 +327,10 @@
 				return -EBUSY;
 
 	mm->context.htlb_segs |= newsegs;
-	/* the context change must make it to memory before the slbia,
+	/* the context change must make it to memory before the flush,
 	 * so that further SLB misses do the right thing. */
 	mb();
-	on_each_cpu(do_slbia, NULL, 0, 1);
+	on_each_cpu(flush_segments, (void *)(unsigned long)newsegs, 0, 1);
 
 	return 0;
 }


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
