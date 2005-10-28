Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965044AbVJ1Bhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbVJ1Bhp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 21:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbVJ1Bhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 21:37:45 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:64223 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965044AbVJ1Bho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 21:37:44 -0400
Date: Thu, 27 Oct 2005 20:37:38 -0500
From: Robin Holt <holt@sgi.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: munmap extremely slow even with untouched mapping.
Message-ID: <20051028013738.GA19727@attica.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is going out without any testing.  I got it to compile but never
even booted the kernel.

I noticed that on ia64, the following simple program would take 24
seconds to complete.  Profiling revealed I was spending all that time
in unmap_vmas.  Looking over the function, I noticed that I would only
attempt 8 pages at a time (CONFIG_PREMPT).  I then thought through this
some more.  My particular application had one large mapping which was
never touched after being mmaped.

Without this patch, we would iterate numerous times (256) to get past
a region of memory that had an empty pmd, 524,288 times to get past an
empty pud, and 1,073,741,824 to get past an empty pgd.  I had a 4-level
page table directory patch applied at the time.

Here is the test program:

#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <stdlib.h>
#include <stdio.h>

#define TMPFILE "/tmp/holt-dummy-mmap"

int main(int argc, char **argv)
{
	int fd;
	char *memmap_base;

	fd = open(TMPFILE, O_RDWR | O_CREAT | O_EXCL, 0600);
	if (fd < 0) {
		printf("Error opening " TMPFILE "\n");
		exit(1);
	}
	unlink(TMPFILE);

	memmap_base = (char *) mmap(NULL, 17592182882304,
				    PROT_READ | PROT_WRITE,
				    MAP_SHARED, fd,
				    (off_t) 0);

	if ((void *) memmap_base != MAP_FAILED)
		munmap(memmap_base, 17592182882304);
	return 0;
}


Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c	2005-10-27 20:06:45.671491763 -0500
+++ linux-2.6/mm/memory.c	2005-10-27 20:22:04.287665340 -0500
@@ -596,8 +596,9 @@ static void zap_pte_range(struct mmu_gat
 	pte_unmap(pte - 1);
 }
 
-static inline void zap_pmd_range(struct mmu_gather *tlb, pud_t *pud,
+static inline unsigned long zap_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 				unsigned long addr, unsigned long end,
+				unsigned long stop_at,
 				struct zap_details *details)
 {
 	pmd_t *pmd;
@@ -608,12 +609,15 @@ static inline void zap_pmd_range(struct 
 		next = pmd_addr_end(addr, end);
 		if (pmd_none_or_clear_bad(pmd))
 			continue;
+		next = stop_at;
 		zap_pte_range(tlb, pmd, addr, next, details);
-	} while (pmd++, addr = next, addr != end);
+	} while (pmd++, addr = next, addr < stop_at);
+	return addr;
 }
 
-static inline void zap_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
+static inline unsigned long zap_pud_range(struct mmu_gather *tlb, pgd_t *pgd,
 				unsigned long addr, unsigned long end,
+				unsigned long stop_at,
 				struct zap_details *details)
 {
 	pud_t *pud;
@@ -624,16 +628,20 @@ static inline void zap_pud_range(struct 
 		next = pud_addr_end(addr, end);
 		if (pud_none_or_clear_bad(pud))
 			continue;
-		zap_pmd_range(tlb, pud, addr, next, details);
-	} while (pud++, addr = next, addr != end);
+		next = zap_pmd_range(tlb, pud, addr, next, stop_at, details);
+	} while (pud++, addr = next, addr < stop_at);
+	return addr;
 }
 
-static void unmap_page_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+static unsigned long unmap_page_range(struct mmu_gather *tlb,
+				struct vm_area_struct *vma,
 				unsigned long addr, unsigned long end,
+				unsigned long stop_at,
 				struct zap_details *details)
 {
 	pgd_t *pgd;
 	unsigned long next;
+	unsigned long start_addr = addr;
 
 	if (details && !details->check_mapping && !details->nonlinear_vma)
 		details = NULL;
@@ -645,9 +653,10 @@ static void unmap_page_range(struct mmu_
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
-		zap_pud_range(tlb, pgd, addr, next, details);
-	} while (pgd++, addr = next, addr != end);
+		next = zap_pud_range(tlb, pgd, addr, next, stop_at, details);
+	} while (pgd++, addr = next, addr < stop_at);
 	tlb_end_vma(tlb, vma);
+	return (addr - start_addr);
 }
 
 #ifdef CONFIG_PREEMPT
@@ -722,8 +731,8 @@ unsigned long unmap_vmas(struct mmu_gath
 				unmap_hugepage_range(vma, start, end);
 			} else {
 				block = min(zap_bytes, end - start);
-				unmap_page_range(*tlbp, vma, start,
-						start + block, details);
+				block = unmap_page_range(*tlbp, vma, start,
+						end, start + block, details);
 			}
 
 			start += block;
