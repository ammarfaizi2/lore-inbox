Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262099AbVCRWTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbVCRWTQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 17:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbVCRWRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 17:17:14 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:8929 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262402AbVCRWPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 17:15:33 -0500
Message-ID: <423B52FE.6030101@us.ibm.com>
Date: Fri, 18 Mar 2005 14:15:26 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: linux-kernel@vger.kernel.org, Linux Memory Management <linux-mm@kvack.org>,
       "Bligh, Martin J." <mbligh@aracnet.com>
Subject: Re: Bug in __alloc_pages()?
References: <4238D1DC.8070004@us.ibm.com> <4238D8C1.3080805@yahoo.com.au>
In-Reply-To: <4238D8C1.3080805@yahoo.com.au>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050400000600040906020806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050400000600040906020806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Nick Piggin wrote:
> Matthew Dobson wrote:
> 
>> While looking at some bugs related to OOM handling in 2.6, Martin 
>> Bligh and I noticed some order 0 page allocation failures from kswapd:
>>
 >> <snip>
>>
>> If, while the system is under memory pressure, something attempts to 
>> allocate a page from interrupt context while current == kswapd we will 
>> obviously fail the !in_interrupt() check and fall through.  If this 
>> allocation request was made with __GFP_WAIT set then we'll fall 
>> through the next !wait check.  We will then set the PF_MEMALLOC flag 
>> and set p->reclaim_state to point to __alloc_pages() local 
>> reclaim_state structure.  kswapd alread has it's own reclaim_state and 
>> already has PF_MEMALLOC set, which would then be lost when, after 
>> try_to_free_pages(), we unconditionally set the reclaim_state to NULL 
>> and turn off the PF_MEMALLOC flag.
>>
>> I'm not 100% sure that this potential bug is even possible (ie: can we 
>> have an in_interrupt() page request that has __GFP_WAIT set?), or is 
>> the cause of the 0-order page allocation failures we see, but it does 
>> seem like potentially dangerous code.  I have attatched a patch 
>> (against 2.6.11-mm4) to check whether the current task has it's own 
>> reclaim_state or already has PF_MEMALLOC set and if so, no longer 
>> throws away this data.
>>
> 
> I don't think in_interrupt allocations can have __GFP_WAIT set, so
> this should probably be OK.
> 
> Nick

Agreed.  It seems unlikely, but not entirely impossible.  All it would take 
is one sloppily coded driver, right?  How about this patch instead?

-Matt

--------------050400000600040906020806
Content-Type: text/plain;
 name="fix-__alloc_pages.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-__alloc_pages.patch"

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.11-mm4/mm/page_alloc.c linux-2.6.11-mm4+fix-__alloc_pages/mm/page_alloc.c
--- linux-2.6.11-mm4/mm/page_alloc.c	2005-03-16 16:07:49.000000000 -0800
+++ linux-2.6.11-mm4+fix-__alloc_pages/mm/page_alloc.c	2005-03-18 14:10:27.433667720 -0800
@@ -957,8 +957,10 @@ rebalance:
 	cond_resched();
 
 	/* We now go into synchronous reclaim */
+	BUG_ON(p->flags & PF_MEMALLOC);
 	p->flags |= PF_MEMALLOC;
 	reclaim_state.reclaimed_slab = 0;
+	BUG_ON(p->reclaim_state);
 	p->reclaim_state = &reclaim_state;
 
 	did_some_progress = try_to_free_pages(zones, gfp_mask, order);

--------------050400000600040906020806--
