Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbVHGD36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbVHGD36 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 23:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVHGD36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 23:29:58 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:59243 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750797AbVHGD35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 23:29:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=s0sSLBblw3IklOwdOrkrFnlCGQiAzbLYCjJ0KtiZ7c9ry8PdwTBuIrbWy04EGneq6Bd1tDnT25JyvTwKNjXsvKegx0ROPQiOQUOlvhLipEfJpYQxs83JSh7IaE7lO/+Dm6Suk8bcBXLQNEhR+GnU+ZNwppH277vUYAkLUyWtSBE=  ;
Message-ID: <42F5802F.3050500@yahoo.com.au>
Date: Sun, 07 Aug 2005 13:29:51 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 1/2] mm: remap ZERO_PAGE mappings
References: <42F57FCA.9040805@yahoo.com.au>
In-Reply-To: <42F57FCA.9040805@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------030508080500010800060405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030508080500010800060405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

1/2

I think this is already in -mm (and can probably go
into 2.6.14). Included here for completeness.

-- 
SUSE Labs, Novell Inc.


--------------030508080500010800060405
Content-Type: text/plain;
 name="mm-remap-ZERO_PAGE-mappings.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-remap-ZERO_PAGE-mappings.patch"

Remap ZERO_PAGE ptes when remapping memory. This is currently just an
optimisation for MIPS, which is the only architecture with multiple
zero pages - it now retains the mapping it needs for good cache performance,
and as well do_wp_page is now able to always correctly detect and
optimise zero page COW faults.

This change is required in order to be able to detect whether a pte
points to a ZERO_PAGE using only its (pte, vaddr) pair.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/mremap.c
===================================================================
--- linux-2.6.orig/mm/mremap.c
+++ linux-2.6/mm/mremap.c
@@ -141,6 +141,10 @@ move_one_page(struct vm_area_struct *vma
 			if (dst) {
 				pte_t pte;
 				pte = ptep_clear_flush(vma, old_addr, src);
+				/* ZERO_PAGE can be dependant on virtual addr */
+				if (pfn_valid(pte_pfn(pte)) &&
+					pte_page(pte) == ZERO_PAGE(old_addr))
+					pte = pte_wrprotect(mk_pte(ZERO_PAGE(new_addr), new_vma->vm_page_prot));
 				set_pte_at(mm, new_addr, dst, pte);
 			} else
 				error = -ENOMEM;

--------------030508080500010800060405--
Send instant messages to your online friends http://au.messenger.yahoo.com 
