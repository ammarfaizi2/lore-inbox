Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbVCVGlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbVCVGlQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 01:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVCVGhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 01:37:41 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:36994 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262572AbVCVGdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 01:33:37 -0500
Message-ID: <423FBC32.80608@yahoo.com.au>
Date: Tue, 22 Mar 2005 17:33:22 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: "David S. Miller" <davem@davemloft.net>, tony.luck@intel.com,
       akpm@osdl.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
References: <B8E391BBE9FE384DAA4C5C003888BE6F03210DD4@scsmsx401.amr.corp.intel.com>     <20050321150205.4af39064.davem@davemloft.net>     <1111464894.5125.34.camel@npiggin-nld.site>     <20050321212955.6a0f2b61.davem@davemloft.net> <Pine.LNX.4.61.0503220548250.5484@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0503220548250.5484@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Mon, 21 Mar 2005, David S. Miller wrote:
> 
>>On Tue, 22 Mar 2005 15:14:54 +1100
>>Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>>
>>
>>>Question, Dave: flush_tlb_pgtables after Hugh's patch is also
>>>possibly not being called with enough range to cover all page
>>>tables that have been freed.
> 
> 
> Good question from Nick.
> 
> 
>>>For example, you may have a single page (start,end) address range
>>>to free, but if this is enclosed by a large enough (floor,ceiling)
>>>then it may free an entire pgd entry.
>>>
>>>I assume the intention of the API would be to provide the full
>>>pgd width in that case?
>>
>>It just wants the range of page tables liberated.  I guess
>>essentially PMD_SIZE is the granularity.
> 
> 
> I _think_ that answer means that my current code is fine in this respect.
> But I'm not entirely convinced.  Since sparc64 is the only architecture
> which implements a flush_tlb_pgtables which actually uses start,end,
> we do need to suit your needs there - informed reassurance welcome!
> 

But Hugh I think you may still be freeing pgd (PGDIR_SIZE)
regions that you don't quite cover with flush_tlb_pgtables?

I would have thought you'd need something like this:

	if (!tlb_is_full_mm(tlb)) {
		/* This is the full range of page tables we could possibly free */
		start = max(start & PGDIR_SIZE, (floor + PMD_SIZE - 1) & PMD_SIZE);
		end = min((end + PGDIR_SIZE - 1) & PGDIR_SIZE, ceiling & PMD_SIZE);
		flush_tlb_pgtables(tlb->mm, start, end);
	}

But I'll have to go away and look at it more...

