Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbUC3XIs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 18:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbUC3WpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 17:45:25 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:58293 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261528AbUC3Woc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 17:44:32 -0500
Date: Tue, 30 Mar 2004 23:44:29 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/6] mremap copy_one_pte
In-Reply-To: <Pine.LNX.4.44.0403302340220.24019-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0403302343460.24019-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up mremap move's copy_one_pte:
- get_one_pte_map_nested already weeded out the pte_none case,
  now don't even call copy_one_pte if it has nothing to do.
- check pfn_valid before passing page to page_remove_rmap.

--- mremap1/mm/mremap.c	2004-02-18 03:00:07.000000000 +0000
+++ mremap2/mm/mremap.c	2004-03-30 21:24:37.254145312 +0100
@@ -79,31 +79,21 @@ static inline pte_t *alloc_one_pte_map(s
 	return pte;
 }
 
-static int
+static void
 copy_one_pte(struct vm_area_struct *vma, unsigned long old_addr,
 	     pte_t *src, pte_t *dst, struct pte_chain **pte_chainp)
 {
-	int error = 0;
-	pte_t pte;
-	struct page *page = NULL;
-
-	if (pte_present(*src))
-		page = pte_page(*src);
+	pte_t pte = ptep_clear_flush(vma, old_addr, src);
+	set_pte(dst, pte);
 
-	if (!pte_none(*src)) {
-		if (page)
+	if (pte_present(pte)) {
+		unsigned long pfn = pte_pfn(pte);
+		if (pfn_valid(pfn)) {
+			struct page *page = pfn_to_page(pfn);
 			page_remove_rmap(page, src);
-		pte = ptep_clear_flush(vma, old_addr, src);
-		if (!dst) {
-			/* No dest?  We must put it back. */
-			dst = src;
-			error++;
-		}
-		set_pte(dst, pte);
-		if (page)
 			*pte_chainp = page_add_rmap(page, dst, *pte_chainp);
+		}
 	}
-	return error;
 }
 
 static int
@@ -140,8 +130,11 @@ move_one_page(struct vm_area_struct *vma
 		 * page_table_lock, we should re-check the src entry...
 		 */
 		if (src) {
-			error = copy_one_pte(vma, old_addr, src,
+			if (dst)
+				copy_one_pte(vma, old_addr, src,
 						dst, &pte_chain);
+			else
+				error = -ENOMEM;
 			pte_unmap_nested(src);
 		}
 		pte_unmap(dst);

