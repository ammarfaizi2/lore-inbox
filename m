Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262869AbVBDUVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262869AbVBDUVT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 15:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266373AbVBDURL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 15:17:11 -0500
Received: from holomorphy.com ([66.93.40.71]:38374 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265819AbVBDUQo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 15:16:44 -0500
Date: Fri, 4 Feb 2005 12:16:36 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Mr. Berkley Shands" <berkley@exegy.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: 2.6.10 Kernel BUG at hugetlbpage:212 (x86_64 and i386)
Message-ID: <20050204201636.GP24805@holomorphy.com>
References: <42023352.9040309@dssimail.com> <Pine.LNX.4.61.0502041634090.10535@goblin.wat.veritas.com> <20050204194255.GO24805@holomorphy.com> <4203D5AD.8030108@cse.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4203D5AD.8030108@cse.wustl.edu>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 02:06:05PM -0600, Mr. Berkley Shands wrote:
> Sorry, but I still crash. This time it hung the kernel so bad I had to 
> powerfail to restart.

Well, that fix is needed anyway.

On Fri, Feb 04, 2005 at 02:06:05PM -0600, Mr. Berkley Shands wrote:
> Feb  4 13:43:19 eclipse kernel: RIP: 0010:[<ffffffff8011e3cb>] 
> <ffffffff8011e3cb>{unmap_hugepage_range+75}

Could you try this?


-- wli


Index: mm2-2.6.11-rc2/arch/i386/mm/hugetlbpage.c
===================================================================
--- mm2-2.6.11-rc2.orig/arch/i386/mm/hugetlbpage.c	2005-01-29 01:13:39.000000000 -0800
+++ mm2-2.6.11-rc2/arch/i386/mm/hugetlbpage.c	2005-02-04 12:05:12.000000000 -0800
@@ -209,14 +209,17 @@
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
-	pte_t pte;
+	pte_t pte, *ptep;
 	struct page *page;
 
 	BUG_ON(start & (HPAGE_SIZE - 1));
 	BUG_ON(end & (HPAGE_SIZE - 1));
 
 	for (address = start; address < end; address += HPAGE_SIZE) {
-		pte = ptep_get_and_clear(huge_pte_offset(mm, address));
+		ptep = huge_pte_offset(mm, address);
+		if (!ptep)
+			continue;
+		pte = ptep_get_and_clear(ptep);
 		if (pte_none(pte))
 			continue;
 		page = pte_page(pte);
