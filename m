Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268299AbUHFVAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268299AbUHFVAm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 17:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268291AbUHFU6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 16:58:46 -0400
Received: from fmr03.intel.com ([143.183.121.5]:40335 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S268299AbUHFU4P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 16:56:15 -0400
Message-Id: <200408062055.i76KtcY08296@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Hirokazu Takahashi'" <taka@valinux.co.jp>
Cc: <wli@holomorphy.com>, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>, "Seth, Rohit" <rohit.seth@intel.com>
Subject: RE: Hugetlb demanding paging for -mm tree
Date: Fri, 6 Aug 2004 13:55:38 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcR7CpiRO5L3Ta0STvi8XV0xji5onwA7LdvQ
In-Reply-To: <20040806.013522.74731251.taka@valinux.co.jp>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hirokazu Takahashi wrote on Thursday, August 05, 2004 9:35 AM
> >
> > ---------------------
> > 00.demandpaging.patch
> > ---------------------
>
> I noticed some problems in your patch.
>
>   - unmap_hugepage_range() may over-decrease mm->rss, since
>     some pte's may not assigned pages yet.
>
>   - Some architectures may require to call update_mmu_cache() right after
>     a pte is updated.

Thanks for review.  Updated incremental patch for all arch.

diff -Nurp linux-2.6.7/arch/i386/mm/hugetlbpage.c linux-2.6.7.hugetlb/arch/i386/mm/hugetlbpage.c
--- linux-2.6.7/arch/i386/mm/hugetlbpage.c	2004-08-06 11:44:59.000000000 -0700
+++ linux-2.6.7.hugetlb/arch/i386/mm/hugetlbpage.c	2004-08-06 13:03:58.000000000 -0700
@@ -234,7 +234,7 @@ void unmap_hugepage_range(struct vm_area
 			continue;
 		page = pte_page(pte);
 		put_page(page);
+		mm->rss -= (HPAGE_SIZE / PAGE_SIZE);
 	}
-	mm->rss -= (end - start) >> PAGE_SHIFT;
 	flush_tlb_range(vma, start, end);
 }
diff -Nurp linux-2.6.7/arch/ia64/mm/hugetlbpage.c linux-2.6.7.hugetlb/arch/ia64/mm/hugetlbpage.c
--- linux-2.6.7/arch/ia64/mm/hugetlbpage.c	2004-08-06 11:44:59.000000000 -0700
+++ linux-2.6.7.hugetlb/arch/ia64/mm/hugetlbpage.c	2004-08-06 13:03:38.000000000 -0700
@@ -249,8 +249,8 @@ void unmap_hugepage_range(struct vm_area
 		page = pte_page(*pte);
 		put_page(page);
 		pte_clear(pte);
+		mm->rss -= (HPAGE_SIZE / PAGE_SIZE);
 	}
-	mm->rss -= (end - start) >> PAGE_SHIFT;
 	flush_tlb_range(vma, start, end);
 }

diff -Nurp linux-2.6.7/arch/ppc64/mm/hugetlbpage.c linux-2.6.7.hugetlb/arch/ppc64/mm/hugetlbpage.c
--- linux-2.6.7/arch/ppc64/mm/hugetlbpage.c	2004-08-06 11:44:59.000000000 -0700
+++ linux-2.6.7.hugetlb/arch/ppc64/mm/hugetlbpage.c	2004-08-06 13:10:28.000000000 -0700
@@ -407,10 +407,9 @@ void unmap_hugepage_range(struct vm_area
 					    pte, local);

 		put_page(page);
+		mm->rss -= (HPAGE_SIZE / PAGE_SIZE);
 	}
 	put_cpu();
-
-	mm->rss -= (end - start) >> PAGE_SHIFT;
 }

 /* Because we have an exclusive hugepage region which lies within the
diff -Nurp linux-2.6.7/arch/sh/mm/hugetlbpage.c linux-2.6.7.hugetlb/arch/sh/mm/hugetlbpage.c
--- linux-2.6.7/arch/sh/mm/hugetlbpage.c	2004-08-06 11:44:59.000000000 -0700
+++ linux-2.6.7.hugetlb/arch/sh/mm/hugetlbpage.c	2004-08-06 13:04:20.000000000 -0700
@@ -204,7 +204,7 @@ void unmap_hugepage_range(struct vm_area
 			pte_clear(pte);
 			pte++;
 		}
+		mm->rss -= (HPAGE_SIZE / PAGE_SIZE);
 	}
-	mm->rss -= (end - start) >> PAGE_SHIFT;
 	flush_tlb_range(vma, start, end);
 }
diff -Nurp linux-2.6.7/arch/sparc64/mm/hugetlbpage.c linux-2.6.7.hugetlb/arch/sparc64/mm/hugetlbpage.c
--- linux-2.6.7/arch/sparc64/mm/hugetlbpage.c	2004-08-06 11:44:59.000000000 -0700
+++ linux-2.6.7.hugetlb/arch/sparc64/mm/hugetlbpage.c	2004-08-06 13:04:38.000000000 -0700
@@ -201,7 +201,7 @@ void unmap_hugepage_range(struct vm_area
 			pte_clear(pte);
 			pte++;
 		}
+		mm->rss -= (HPAGE_SIZE / PAGE_SIZE);
 	}
-	mm->rss -= (end - start) >> PAGE_SHIFT;
 	flush_tlb_range(vma, start, end);
 }
diff -Nurp linux-2.6.7/mm/hugetlb.c linux-2.6.7.hugetlb/mm/hugetlb.c
--- linux-2.6.7/mm/hugetlb.c	2004-08-06 11:44:59.000000000 -0700
+++ linux-2.6.7.hugetlb/mm/hugetlb.c	2004-08-06 13:15:24.000000000 -0700
@@ -276,9 +276,10 @@ retry:
 	}

 	spin_lock(&mm->page_table_lock);
-	if (pte_none(*pte))
+	if (pte_none(*pte)) {
 		set_huge_pte(mm, vma, page, pte, vma->vm_flags & VM_WRITE);
-	else
+		update_mmu_cache(vma, addr, *pte);
+	} else
 		put_page(page);
 out:
 	spin_unlock(&mm->page_table_lock);


