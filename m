Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263198AbVFWIT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263198AbVFWIT2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbVFWIR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:17:28 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:28791 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262622AbVFWHIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 03:08:00 -0400
Message-ID: <42BA5FC8.9020501@yahoo.com.au>
Date: Thu, 23 Jun 2005 17:07:52 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
CC: Hugh Dickins <hugh@veritas.com>, Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [patch][rfc] 4/5: remap ZERO_PAGE mappings
References: <42BA5F37.6070405@yahoo.com.au> <42BA5F5C.3080101@yahoo.com.au> <42BA5F7B.30904@yahoo.com.au> <42BA5FA8.7080905@yahoo.com.au>
In-Reply-To: <42BA5FA8.7080905@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------050204080603020303060408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050204080603020303060408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

4/5

--------------050204080603020303060408
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

In future, this becomes required in order to always be able to detect
whether a pte points to a ZERO_PAGE using only the pte, vaddr pair.

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

--------------050204080603020303060408--
Send instant messages to your online friends http://au.messenger.yahoo.com 
