Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264208AbTDPCK3 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 22:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264209AbTDPCK2 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 22:10:28 -0400
Received: from holomorphy.com ([66.224.33.161]:29064 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264208AbTDPCK1 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 22:10:27 -0400
Date: Tue, 15 Apr 2003 19:21:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.67-mm3
Message-ID: <20030416022154.GF12487@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030414015313.4f6333ad.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030414015313.4f6333ad.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 01:53:13AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.67/2.5.67-mm3/
> 
> A bunch of new fixes, and a framebuffer update.  This should work a bit
> better than -mm2.

follow_hugetlb_page() behaved improperly if its starting address was
not hugepage-aligned. It looked a bit unclean too, so I rewrote it.
This fixes a bug, and more importantly, makes the thing readable by
something other than a compiler (e.g. programmers).


diff -urpN linux-2.5.67-bk6/arch/i386/mm/hugetlbpage.c htlb-2.5.67-bk6-1/arch/i386/mm/hugetlbpage.c
--- linux-2.5.67-bk6/arch/i386/mm/hugetlbpage.c	2003-04-07 10:32:49.000000000 -0700
+++ htlb-2.5.67-bk6-1/arch/i386/mm/hugetlbpage.c	2003-04-15 18:58:07.000000000 -0700
@@ -129,37 +129,45 @@ nomem:
 int
 follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		    struct page **pages, struct vm_area_struct **vmas,
-		    unsigned long *st, int *length, int i)
+		    unsigned long *position, int *length, int i)
 {
-	pte_t *ptep, pte;
-	unsigned long start = *st;
-	unsigned long pstart;
-	int len = *length;
-	struct page *page;
+	unsigned long vpfn, vaddr = *position;
+	int remainder = *length;
+
+	WARN_ON(!is_vm_hugetlb_page(vma));
 
-	do {
-		pstart = start;
-		ptep = huge_pte_offset(mm, start);
-		pte = *ptep;
+	vpfn = vaddr/PAGE_SIZE;
+	while (vaddr < vma->vm_end && remainder) {
 
-back1:
-		page = pte_page(pte);
 		if (pages) {
-			page += ((start & ~HPAGE_MASK) >> PAGE_SHIFT);
+			pte_t *pte;
+			struct page *page;
+
+			pte = huge_pte_offset(mm, vaddr);
+
+			/* hugetlb should be locked, and hence, prefaulted */
+			WARN_ON(!pte || pte_none(*pte));
+
+			page = &pte_page(*pte)[vpfn % (HPAGE_SIZE/PAGE_SIZE)];
+
+			WARN_ON(!PageCompound(page));
+
 			get_page(page);
 			pages[i] = page;
 		}
+
 		if (vmas)
 			vmas[i] = vma;
-		i++;
-		len--;
-		start += PAGE_SIZE;
-		if (((start & HPAGE_MASK) == pstart) && len &&
-				(start < vma->vm_end))
-			goto back1;
-	} while (len && start < vma->vm_end);
-	*length = len;
-	*st = start;
+
+		vaddr += PAGE_SIZE;
+		++vpfn;
+		--remainder;
+		++i;
+	}
+
+	*length = remainder;
+	*position = vaddr;
+
 	return i;
 }
 
