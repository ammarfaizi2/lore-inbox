Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262162AbSJNVAq>; Mon, 14 Oct 2002 17:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262460AbSJNVAq>; Mon, 14 Oct 2002 17:00:46 -0400
Received: from holomorphy.com ([66.224.33.161]:23441 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262162AbSJNVA3>;
	Mon, 14 Oct 2002 17:00:29 -0400
Date: Mon, 14 Oct 2002 14:02:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [patch, feature] nonlinear mappings, prefaulting support, 2.5.42-F8
Message-ID: <20021014210234.GE4488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <Pine.LNX.4.44.0210141739510.8792-100000@localhost.localdomain> <Pine.LNX.4.44.0210141800160.9302-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210141800160.9302-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 06:02:30PM +0200, Ingo Molnar wrote:
>> if this is really an issue then we could force vma->vm_page_prot to
>> PROT_NONE within remap_file_pages(), so at least all subsequent faults
>> will be PROT_NONE and the user would have to explicitly re-mprotect()
>> the vma again to change this.
> i've added this to the -G1 patch at:
>         http://redhat.com/~mingo/remap-file-pages-patches/
>     Ingo

Okay, if PROT_NONE is in there, my last remaining concern would be
solved by invalidating the pte's of failed nonblocking prefaults.

A nonblocking remapping done "over the top" of a preexisting mapping
(such as would occur with MAP_LOCKED) may fail at unpredictable times,
which is fine from the kernel point of view but leaves userspace with
no way of telling which pages that it requested to be prefaulted
actually made it in, and which pages are residue from the prior mapping.

Basically something like this would solve this API semantics issue
(totally untested). Against mpopulate-2.5.42-G1


diff -urpN mpop-2.5.42/include/linux/mm.h wlipop-2.5.42/include/linux/mm.h
--- mpop-2.5.42/include/linux/mm.h	2002-10-14 11:43:03.000000000 -0700
+++ wlipop-2.5.42/include/linux/mm.h	2002-10-14 12:26:27.000000000 -0700
@@ -424,6 +424,7 @@ static inline pmd_t *pmd_alloc(struct mm
 	return pmd_offset(pgd, address);
 }
 
+extern void zap_pte(struct mm_struct *, pte_t *);
 extern void free_area_init(unsigned long * zones_size);
 extern void free_area_init_node(int nid, pg_data_t *pgdat, struct page *pmap,
 	unsigned long * zones_size, unsigned long zone_start_pfn, 
diff -urpN mpop-2.5.42/mm/filemap.c wlipop-2.5.42/mm/filemap.c
--- mpop-2.5.42/mm/filemap.c	2002-10-14 11:43:03.000000000 -0700
+++ wlipop-2.5.42/mm/filemap.c	2002-10-14 12:12:08.000000000 -0700
@@ -1286,9 +1286,27 @@ repeat:
 		return -EINVAL;
 
 	page = filemap_getpage(file, pgoff, nonblock);
-	if (!page && !nonblock)
-		return -ENOMEM;
-	if (page) {
+
+	if (!page) {
+		pgd_t *pgd;
+
+		if (!nonblock)
+			return -ENOMEM;
+
+		spin_lock(&mm->page_table_lock);
+		pgd = pgd_offset(mm, addr);
+		if (!pgd_none(*pgd) && !pgd_bad(*pgd)) {
+			pmd_t *pmd = pmd_offset(pgd, addr);
+			if (!pmd_none(*pmd) && !pmd_bad(*pmd)) {
+				pte_t *pte = pte_offset_map(pmd, addr);
+				if (pte) {
+					zap_pte(mm, pte);
+					pte_unmap(pte);
+				}
+			}
+		}
+		spin_unlock(&mm->page_table_lock);
+	} else {
 		err = install_page(mm, vma, addr, page, prot);
 		if (err)
 			return err;
diff -urpN mpop-2.5.42/mm/fremap.c wlipop-2.5.42/mm/fremap.c
--- mpop-2.5.42/mm/fremap.c	2002-10-14 11:43:03.000000000 -0700
+++ wlipop-2.5.42/mm/fremap.c	2002-10-14 12:26:37.000000000 -0700
@@ -13,7 +13,7 @@
 #include <linux/swapops.h>
 #include <asm/mmu_context.h>
 
-static inline void zap_pte(struct mm_struct *mm, pte_t *ptep)
+void zap_pte(struct mm_struct *mm, pte_t *ptep)
 {
 	pte_t pte = *ptep;
 
