Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262121AbVFHXyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbVFHXyz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 19:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVFHXyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 19:54:06 -0400
Received: from fire.osdl.org ([65.172.181.4]:3718 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261408AbVFHXxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 19:53:01 -0400
Date: Wed, 8 Jun 2005 16:52:06 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       William Lee Irwin III <wli@holomorphy.com>
Subject: [patch 01/09] try_to_unmap_cluster() passes out-of-bounds pte to pte_unmap()
Message-ID: <20050608235206.GH13152@shell0.pdx.osdl.net>
References: <20050608234637.GG13152@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608234637.GG13152@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

try_to_unmap_cluster() does:
        for (pte = pte_offset_map(pmd, address);
                        address < end; pte++, address += PAGE_SIZE) {
		...
	}

	pte_unmap(pte);

It may take a little staring to notice, but pte can actually fall off the
end of the pte page in this iteration, which makes life difficult for
kmap_atomic() and the users not expecting it to BUG().  Of course, we're
somewhat lucky in that arithmetic elsewhere in the function guarantees that
at least one iteration is made, lest this force larger rearrangements to be
made.  This issue and patch also apply to non-mm mainline and with trivial
adjustments, at least two related kernels.

Discovered during internal testing at Oracle.

Signed-off-by: William Irwin <wli@holomorphy.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

--- gregkh-2.6.11.10.orig/mm/rmap.c	2005-05-16 10:51:55.000000000 -0700
+++ gregkh-2.6.11.10/mm/rmap.c	2005-05-26 22:01:49.000000000 -0700
@@ -641,7 +641,7 @@
 	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd;
-	pte_t *pte;
+	pte_t *pte, *original_pte;
 	pte_t pteval;
 	struct page *page;
 	unsigned long address;
@@ -673,7 +673,7 @@
 	if (!pmd_present(*pmd))
 		goto out_unlock;
 
-	for (pte = pte_offset_map(pmd, address);
+	for (original_pte = pte = pte_offset_map(pmd, address);
 			address < end; pte++, address += PAGE_SIZE) {
 
 		if (!pte_present(*pte))
@@ -710,7 +710,7 @@
 		(*mapcount)--;
 	}
 
-	pte_unmap(pte);
+	pte_unmap(original_pte);
 
 out_unlock:
 	spin_unlock(&mm->page_table_lock);

