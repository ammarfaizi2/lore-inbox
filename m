Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbVIYQAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbVIYQAY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 12:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbVIYQAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 12:00:24 -0400
Received: from silver.veritas.com ([143.127.12.111]:55990 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932237AbVIYQAX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 12:00:23 -0400
Date: Sun, 25 Sep 2005 16:59:56 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: "David S. Miller" <davem@davemloft.net>,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 12/21] mm: tlb_gather_mmu get_cpu_var
In-Reply-To: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0509251657200.3490@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0509251644100.3490@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 25 Sep 2005 16:00:23.0109 (UTC) FILETIME=[3C7A6750:01C5C1EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tlb_gather_mmu dates from before kernel preemption was allowed, and uses
smp_processor_id or __get_cpu_var to find its per-cpu mmu_gather.  That
works because it's currently only called after getting page_table_lock,
which is not dropped until after the matching tlb_finish_mmu.  But don't
rely on that, it will soon change: now disable preemption internally by
proper get_cpu_var in tlb_gather_mmu, put_cpu_var in tlb_finish_mmu.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 include/asm-arm/tlb.h     |    5 +++--
 include/asm-arm26/tlb.h   |    7 ++++---
 include/asm-generic/tlb.h |   10 +++++-----
 include/asm-ia64/tlb.h    |    6 ++++--
 include/asm-sparc64/tlb.h |    4 +++-
 5 files changed, 19 insertions(+), 13 deletions(-)

--- mm11/include/asm-arm/tlb.h	2005-06-17 20:48:29.000000000 +0100
+++ mm12/include/asm-arm/tlb.h	2005-09-24 19:28:56.000000000 +0100
@@ -39,8 +39,7 @@ DECLARE_PER_CPU(struct mmu_gather, mmu_g
 static inline struct mmu_gather *
 tlb_gather_mmu(struct mm_struct *mm, unsigned int full_mm_flush)
 {
-	int cpu = smp_processor_id();
-	struct mmu_gather *tlb = &per_cpu(mmu_gathers, cpu);
+	struct mmu_gather *tlb = &get_cpu_var(mmu_gathers);
 
 	tlb->mm = mm;
 	tlb->freed = 0;
@@ -65,6 +64,8 @@ tlb_finish_mmu(struct mmu_gather *tlb, u
 
 	/* keep the page table cache within bounds */
 	check_pgt_cache();
+
+	put_cpu_var(mmu_gathers);
 }
 
 static inline unsigned int tlb_is_full_mm(struct mmu_gather *tlb)
--- mm11/include/asm-arm26/tlb.h	2005-06-17 20:48:29.000000000 +0100
+++ mm12/include/asm-arm26/tlb.h	2005-09-24 19:28:56.000000000 +0100
@@ -17,13 +17,12 @@ struct mmu_gather {
         unsigned int            avoided_flushes;
 };
 
-extern struct mmu_gather mmu_gathers[NR_CPUS];
+DECLARE_PER_CPU(struct mmu_gather, mmu_gathers);
 
 static inline struct mmu_gather *
 tlb_gather_mmu(struct mm_struct *mm, unsigned int full_mm_flush)
 {
-        int cpu = smp_processor_id();
-        struct mmu_gather *tlb = &mmu_gathers[cpu];
+        struct mmu_gather *tlb = &get_cpu_var(mmu_gathers);
 
         tlb->mm = mm;
         tlb->freed = 0;
@@ -52,6 +51,8 @@ tlb_finish_mmu(struct mmu_gather *tlb, u
 
         /* keep the page table cache within bounds */
         check_pgt_cache();
+
+        put_cpu_var(mmu_gathers);
 }
 
 
--- mm11/include/asm-generic/tlb.h	2005-09-21 12:16:48.000000000 +0100
+++ mm12/include/asm-generic/tlb.h	2005-09-24 19:28:56.000000000 +0100
@@ -35,9 +35,7 @@
 #endif
 
 /* struct mmu_gather is an opaque type used by the mm code for passing around
- * any data needed by arch specific code for tlb_remove_page.  This structure
- * can be per-CPU or per-MM as the page table lock is held for the duration of
- * TLB shootdown.
+ * any data needed by arch specific code for tlb_remove_page.
  */
 struct mmu_gather {
 	struct mm_struct	*mm;
@@ -57,7 +55,7 @@ DECLARE_PER_CPU(struct mmu_gather, mmu_g
 static inline struct mmu_gather *
 tlb_gather_mmu(struct mm_struct *mm, unsigned int full_mm_flush)
 {
-	struct mmu_gather *tlb = &per_cpu(mmu_gathers, smp_processor_id());
+	struct mmu_gather *tlb = &get_cpu_var(mmu_gathers);
 
 	tlb->mm = mm;
 
@@ -85,7 +83,7 @@ tlb_flush_mmu(struct mmu_gather *tlb, un
 
 /* tlb_finish_mmu
  *	Called at the end of the shootdown operation to free up any resources
- *	that were required.  The page table lock is still held at this point.
+ *	that were required.
  */
 static inline void
 tlb_finish_mmu(struct mmu_gather *tlb, unsigned long start, unsigned long end)
@@ -101,6 +99,8 @@ tlb_finish_mmu(struct mmu_gather *tlb, u
 
 	/* keep the page table cache within bounds */
 	check_pgt_cache();
+
+	put_cpu_var(mmu_gathers);
 }
 
 static inline unsigned int
--- mm11/include/asm-ia64/tlb.h	2005-06-17 20:48:29.000000000 +0100
+++ mm12/include/asm-ia64/tlb.h	2005-09-24 19:28:56.000000000 +0100
@@ -129,7 +129,7 @@ ia64_tlb_flush_mmu (struct mmu_gather *t
 static inline struct mmu_gather *
 tlb_gather_mmu (struct mm_struct *mm, unsigned int full_mm_flush)
 {
-	struct mmu_gather *tlb = &__get_cpu_var(mmu_gathers);
+	struct mmu_gather *tlb = &get_cpu_var(mmu_gathers);
 
 	tlb->mm = mm;
 	/*
@@ -154,7 +154,7 @@ tlb_gather_mmu (struct mm_struct *mm, un
 
 /*
  * Called at the end of the shootdown operation to free up any resources that were
- * collected.  The page table lock is still held at this point.
+ * collected.
  */
 static inline void
 tlb_finish_mmu (struct mmu_gather *tlb, unsigned long start, unsigned long end)
@@ -174,6 +174,8 @@ tlb_finish_mmu (struct mmu_gather *tlb, 
 
 	/* keep the page table cache within bounds */
 	check_pgt_cache();
+
+	put_cpu_var(mmu_gathers);
 }
 
 static inline unsigned int
--- mm11/include/asm-sparc64/tlb.h	2005-06-17 20:48:29.000000000 +0100
+++ mm12/include/asm-sparc64/tlb.h	2005-09-24 19:28:56.000000000 +0100
@@ -44,7 +44,7 @@ extern void flush_tlb_pending(void);
 
 static inline struct mmu_gather *tlb_gather_mmu(struct mm_struct *mm, unsigned int full_mm_flush)
 {
-	struct mmu_gather *mp = &__get_cpu_var(mmu_gathers);
+	struct mmu_gather *mp = &get_cpu_var(mmu_gathers);
 
 	BUG_ON(mp->tlb_nr);
 
@@ -97,6 +97,8 @@ static inline void tlb_finish_mmu(struct
 
 	/* keep the page table cache within bounds */
 	check_pgt_cache();
+
+	put_cpu_var(mmu_gathers);
 }
 
 static inline unsigned int tlb_is_full_mm(struct mmu_gather *mp)
