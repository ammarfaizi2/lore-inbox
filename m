Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269027AbUIHDjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269027AbUIHDjP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 23:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269028AbUIHDjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 23:39:15 -0400
Received: from ozlabs.org ([203.10.76.45]:24733 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269027AbUIHDjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 23:39:04 -0400
Date: Wed, 8 Sep 2004 13:26:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: Fix declaration order in asm-ppc64/tlb.h
Message-ID: <20040908032654.GB31597@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc64-dev@lists.linuxppc.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

In asm-ppc64/tlb.h, tlb_flush() is defined as inline after the
#include of asm-generic/tlb.h which uses it, defeating the inline
directive.  gcc-3.4 exposes this problem, causing a compile failure.
This patch reorders the file to fix the problem.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/include/asm-ppc64/tlb.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/tlb.h	2004-08-09 09:52:53.000000000 +1000
+++ working-2.6/include/asm-ppc64/tlb.h	2004-09-02 13:13:29.693032208 +1000
@@ -15,7 +15,14 @@
 #include <asm/tlbflush.h>
 
 struct mmu_gather;
-static inline void tlb_flush(struct mmu_gather *tlb);
+
+extern void pte_free_finish(void);
+
+static inline void tlb_flush(struct mmu_gather *tlb)
+{
+	flush_tlb_pending();
+	pte_free_finish();
+}
 
 /* Avoid pulling in another include just for this */
 #define check_pgt_cache()	do { } while (0)
@@ -29,12 +36,4 @@
 
 #define __tlb_remove_tlb_entry(tlb, pte, address) do { } while (0)
 
-extern void pte_free_finish(void);
-
-static inline void tlb_flush(struct mmu_gather *tlb)
-{
-	flush_tlb_pending();
-	pte_free_finish();
-}
-
 #endif /* _PPC64_TLB_H */


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
