Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbWFBU5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWFBU5v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 16:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWFBU5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 16:57:51 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:26042 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964899AbWFBU5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 16:57:50 -0400
Subject: Re: [PATCH] hugetlb: powerpc: Actively close unused htlb regions
	on vma close
From: Adam Litke <agl@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
       David Gibson <david@gibson.dropbear.id.au>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606021301300.5492@schroedinger.engr.sgi.com>
References: <1149257287.9693.6.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606021301300.5492@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Fri, 02 Jun 2006 15:57:20 -0500
Message-Id: <1149281841.9693.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-02 at 13:06 -0700, Christoph Lameter wrote:
> On Fri, 2 Jun 2006, Adam Litke wrote:
> 
> > The following patch introduces a architecture-specific vm_ops.close()
> > hook.  For all architectures besides powerpc, this is a no-op.  On
> > powerpc, the low and high segments are scanned to locate empty hugetlb
> > segments which can be made available for normal mappings.  Comments?
> 
> IA64 has similar issues and uses the hook suggested by Hugh. However, we 
> have a permanently reserved memory area. I am a bit surprised about the 
> need to make address space available for normal mappings. Is this for 32 
> bit powerpc support?

I now have a working implementation using Hugh's suggestion and
incorporating some suggestions from David Hansen... (attaching for
reference).

The real reason I want to "close" hugetlb regions (even on 64bit
platforms) is so a process can replace a previous hugetlb mapping with
normal pages when huge pages become scarce.  An example would be the
hugetlb morecore (malloc) feature in libhugetlbfs :)

[PATCH] powerpc: Close hugetlb regions when unmapping VMAs

On powerpc, each segment can contain pages of only one size.  When a hugetlb
mapping is requested, a segment is located and marked for use with huge pages.
This is a uni-directional operation -- hugetlb segments are never marked for
use again with normal pages.  For long running processes which make use of a
combination of normal and hugetlb mappings, this behavior can unduly constrain
the virtual address space.

Changes since V1:
 * Modifications limited to arch-specific code (hugetlb_free_pgd_range)
 * Only scan segments covered by the range to be unmapped

Signed-off-by: Adam Litke <agl@us.ibm.com>
---
 hugetlbpage.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+)
diff -upN reference/arch/powerpc/mm/hugetlbpage.c current/arch/powerpc/mm/hugetlbpage.c
--- reference/arch/powerpc/mm/hugetlbpage.c
+++ current/arch/powerpc/mm/hugetlbpage.c
@@ -52,6 +52,7 @@
 typedef struct { unsigned long pd; } hugepd_t;
 
 #define hugepd_none(hpd)	((hpd).pd == 0)
+void close_hugetlb_areas(struct mm_struct *mm);
 
 static inline pte_t *hugepd_page(hugepd_t hpd)
 {
@@ -303,6 +304,8 @@ void hugetlb_free_pgd_range(struct mmu_g
 			continue;
 		hugetlb_free_pud_range(*tlb, pgd, addr, next, floor, ceiling);
 	} while (pgd++, addr = next, addr != end);
+
+	close_hugetlb_areas((*tlb)->mm);
 }
 
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
@@ -518,6 +521,52 @@ int prepare_hugepage_range(unsigned long
 	return 0;
 }
 
+void close_hugetlb_areas(struct mm_struct *mm, unsigned long start,
+		unsigned long end)
+{
+	unsigned long i;
+	struct slb_flush_info fi;
+	u16 inuse, hiflush, loflush, mask;
+
+	if (!mm)
+		return;
+
+	if (start < 0x100000000UL) {
+		mask = LOW_ESID_MASK(start, end - start);
+		inuse = mm->context.low_htlb_areas;
+		for (i = 0; i < NUM_LOW_AREAS; i++) {
+			if (!(mask & (1 << i)))
+				continue;
+			if (prepare_low_area_for_htlb(mm, i) == 0)
+				inuse &= ~(1 << i);
+		}
+		loflush = inuse ^ mm->context.low_htlb_areas;
+		mm->context.low_htlb_areas = inuse;
+	}
+
+	if (end > 0x100000000UL) {
+		mask = HTLB_AREA_MASK(start, end - start);
+		inuse = mm->context.high_htlb_areas;
+		for (i = 0; i < NUM_HIGH_AREAS; i++) {
+			if (!(mask & (1 << i)))
+				continue;
+			if (prepare_high_area_for_htlb(mm, i) == 0)
+				inuse &= ~(1 << i);
+		}
+		hiflush = inuse ^ mm->context.high_htlb_areas;
+		mm->context.high_htlb_areas = inuse;
+	}
+
+	/* the context changes must make it to memory before the flush,
+	 * so that further SLB misses do the right thing. */
+	mb();
+	fi.mm = mm;
+	if ((fi.newareas = loflush))
+		on_each_cpu(flush_low_segments, &fi, 0, 1);
+	if ((fi.newareas = hiflush))
+		on_each_cpu(flush_high_segments, &fi, 0, 1);
+}
+
 struct page *
 follow_huge_addr(struct mm_struct *mm, unsigned long address, int write)
 {

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

