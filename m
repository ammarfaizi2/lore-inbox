Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVHBMbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVHBMbq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 08:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVHBM3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 08:29:16 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:38529 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261488AbVHBM2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 08:28:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=gygmM62QyxGO4hmlY5dPh4ExcyR8+lggQBkkB7Xc1pifXArAh58Jd0/LnYRrO6VNjAVVsKTExmG+bvop7DoJAIqfWMMYh4VKmyjAypr868V6ihsHgLM8jhN3VRRyVqH+QesgnJazupr2J6T1sFI9YctaE6+UDXqa6WTCU7myar8=  ;
Message-ID: <42EF66D7.5040001@yahoo.com.au>
Date: Tue, 02 Aug 2005 22:28:07 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Robin Holt <holt@sgi.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, Ingo Molnar <mingo@elte.hu>,
       Roland McGrath <roland@redhat.com>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
References: <OF3BCB86B7.69087CF8-ON42257051.003DCC6C-42257051.00420E16@de.ibm.com> <Pine.LNX.4.61.0508021309470.3005@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0508021309470.3005@goblin.wat.veritas.com>
Content-Type: multipart/mixed;
 boundary="------------070804070606000105020806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070804070606000105020806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hugh Dickins wrote:
> On Tue, 2 Aug 2005, Martin Schwidefsky wrote:

>>With the additional !pte_write(pte) check (and if I haven't overlooked
>>something which is not unlikely) s390 should work fine even without the
>>software-dirty bit hack.
> 
> 
> I agree the pte_write check ought to go back in next to the pte_dirty
> check, and that will leave s390 handling most uses of get_user_pages
> correctly, but still failing to handle the peculiar case of strace
> modifying a page to which the user does not currently have write access
> (e.g. setting a breakpoint in readonly text).
> 

Oh, here is the patch I sent Linus and forgot to CC
everyone else.

-- 
SUSE Labs, Novell Inc.


--------------070804070606000105020806
Content-Type: text/plain;
 name="mm-opt-gup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-opt-gup.patch"

Allow __follow_page to succeed when encountering a clean, writeable
pte. Requires reintroduction of the direct page dirtying. Means
get_user_pages doesn't have to drop the page_table_lock and enter
the page fault handler for every clean, writeable pte it encounters
(when being called for write).

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c
+++ linux-2.6/mm/memory.c
@@ -811,15 +811,18 @@ static struct page *__follow_page(struct
 	pte = *ptep;
 	pte_unmap(ptep);
 	if (pte_present(pte)) {
-		if (write && !pte_dirty(pte))
+		if (write && !pte_write(pte) && !pte_dirty(pte))
 			goto out;
 		if (read && !pte_read(pte))
 			goto out;
 		pfn = pte_pfn(pte);
 		if (pfn_valid(pfn)) {
 			page = pfn_to_page(pfn);
-			if (accessed)
+			if (accessed) {
+				if (write && !pte_dirty(pte)&& !PageDirty(page))
+					set_page_dirty(page);
 				mark_page_accessed(page);
+			}
 			return page;
 		}
 	}

--------------070804070606000105020806--
Send instant messages to your online friends http://au.messenger.yahoo.com 
