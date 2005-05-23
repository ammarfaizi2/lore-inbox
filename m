Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVEWXpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVEWXpH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 19:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbVEWXmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 19:42:16 -0400
Received: from fire.osdl.org ([65.172.181.4]:3207 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261189AbVEWXcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 19:32:03 -0400
Date: Mon, 23 May 2005 16:31:36 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, ak@suse.de
Subject: [patch 15/16] x86_64: When checking vmalloc mappings don't use pte_page
Message-ID: <20050523233136.GA27549@shell0.pdx.osdl.net>
References: <20050523231529.GL27549@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050523231529.GL27549@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] x86_64: When checking vmalloc mappings don't use pte_page

The PTEs can point to ioremap mappings too, and these are often outside
mem_map.  The NUMA hash page lookup functions cannot handle out of bounds
accesses properly.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---

 fault.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

Index: release-2.6.11/arch/x86_64/mm/fault.c
===================================================================
--- release-2.6.11.orig/arch/x86_64/mm/fault.c
+++ release-2.6.11/arch/x86_64/mm/fault.c
@@ -236,6 +236,8 @@ static noinline void pgtable_bad(unsigne
 
 /*
  * Handle a fault on the vmalloc or module mapping area
+ *
+ * This assumes no large pages in there.
  */
 static int vmalloc_fault(unsigned long address)
 {
@@ -274,7 +276,10 @@ static int vmalloc_fault(unsigned long a
 	if (!pte_present(*pte_ref))
 		return -1;
 	pte = pte_offset_kernel(pmd, address);
-	if (!pte_present(*pte) || pte_page(*pte) != pte_page(*pte_ref))
+	/* Don't use pte_page here, because the mappings can point
+	   outside mem_map, and the NUMA hash lookup cannot handle
+	   that. */
+	if (!pte_present(*pte) || pte_pfn(*pte) != pte_pfn(*pte_ref))
 		BUG();
 	__flush_tlb_all();
 	return 0;
@@ -348,7 +353,9 @@ asmlinkage void do_page_fault(struct pt_
 	 * protection error (error_code & 1) == 0.
 	 */
 	if (unlikely(address >= TASK_SIZE)) {
-		if (!(error_code & 5)) {
+		if (!(error_code & 5) &&
+		      ((address >= VMALLOC_START && address < VMALLOC_END) ||
+		       (address >= MODULES_VADDR && address < MODULES_END))) {
 			if (vmalloc_fault(address) < 0)
 				goto bad_area_nosemaphore;
 			return;
