Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbVAMDwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVAMDwM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 22:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVAMDwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 22:52:12 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:37973 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261421AbVAMDwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 22:52:03 -0500
Message-ID: <41E5EF2B.3050105@yahoo.com.au>
Date: Thu, 13 Jan 2005 14:46:51 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andrew Morton <akpm@osdl.org>, clameter@sgi.com, torvalds@osdl.org,
       ak@muc.de, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: page table lock patch V15 [0/7]: overview
References: <Pine.LNX.4.44.0501130258210.4577-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0501130258210.4577-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Thu, 13 Jan 2005, Nick Piggin wrote:
> 
>>Andrew Morton wrote:
>>
>>Note that this was with my ptl removal patches. I can't see why Christoph's
>>would have _any_ extra overhead as they are, but it looks to me like they're
>>lacking in atomic ops. So I'd expect something similar for Christoph's when
>>they're properly atomic.
>>
>>
>>>Look, -7% on a 2-way versus +700% on a many-way might well be a tradeoff we
>>>agree to take.  But we need to fully understand all the costs and benefits.
>>
>>I think copy_page_range is the one to keep an eye on.
> 
> 
> Christoph's currently lack set_pte_atomics in the fault handlers, yes.
> But I don't see why they should need set_pte_atomics in copy_page_range
> (which is why I persuaded him to drop forcing set_pte to atomic).
> 
> dup_mmap has down_write of the src mmap_sem, keeping out any faults on
> that.  copy_pte_range has spin_lock of the dst page_table_lock and the
> src page_table_lock, keeping swapout away from those.  Why would atomic
> set_ptes be needed there?  Probably in yours, but not in Christoph's.
> 

I was more thinking of atomic pte reads there. I had for some reason
thought that dup_mmap only had a down_read of the mmap_sem. But even if
it did only down_read, a further look showed this wouldn't have been a
problem for Christoph anyway. That dim light-bulb probably changes things
for my patches too; I may be able to do copy_page_range with fewer atomics.

I'm still not too sure that all places read the pte atomically where needed.
But presently this is not a really big concern because it only would
really slow down i386 PAE if anything.

