Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbVGZIXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVGZIXu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 04:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVGZIWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 04:22:23 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:8345 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261851AbVGZIUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 04:20:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=O90mNTdyB8ghoQQRN9CXzDsqVyiflISH0A7Rc+iyNMbYhFZ4Rp8+JAY98Aps63j/+/EIYLJKC+kIVflqyOc8/Ry9BViCikgDEi/xLCgte/fXVG5PmsaOK2E4cgAvkh8/aLhn1agsPA5gZpMSF3KTIn5Voda01QY0ZmewgQKhhCk=  ;
Message-ID: <42E5F238.4020302@yahoo.com.au>
Date: Tue, 26 Jul 2005 18:20:08 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Hugh Dickins <hugh@veritas.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch 5/6] mm: remap ZERO_PAGE mappings
References: <42E5F139.70002@yahoo.com.au> <42E5F173.3010409@yahoo.com.au> <42E5F19A.6050407@yahoo.com.au> <42E5F1BF.7060604@yahoo.com.au> <42E5F21B.8090900@yahoo.com.au>
In-Reply-To: <42E5F21B.8090900@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------030604000003040609080202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030604000003040609080202
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

5/6


--------------030604000003040609080202
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

--------------030604000003040609080202--
Send instant messages to your online friends http://au.messenger.yahoo.com 
