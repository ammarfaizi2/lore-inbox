Return-Path: <linux-kernel-owner+w=401wt.eu-S932833AbXASSth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932833AbXASSth (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 13:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932842AbXASSth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 13:49:37 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:59971 "EHLO
	ausmtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932833AbXASStg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 13:49:36 -0500
Message-ID: <45B112B6.9060806@linux.vnet.ibm.com>
Date: Sat, 20 Jan 2007 00:19:26 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Organization: IBM
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Aubrey Li <aubreylee@gmail.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: [RPC][PATCH 2.6.20-rc5] limit total vfs page cache
References: <6d6a94c50701171923g48c8652ayd281a10d1cb5dd95@mail.gmail.com> <45B0DB45.4070004@linux.vnet.ibm.com> <6d6a94c50701190805saa0c7bbgbc59d2251bed8537@mail.gmail.com>
In-Reply-To: <6d6a94c50701190805saa0c7bbgbc59d2251bed8537@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Aubrey Li wrote:
> On 1/19/07, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> wrote:
>>
>> Hi Aubrey,
>>
>> The idea of creating separate flag for pagecache in page_alloc is
>> interesting.  The good part is that you flag watermark low and the
>> zone reclaimer will do the rest of the job.
>>
>> However when the zone reclaimer starts to reclaim pages, it will
>> remove all cold pages and not specifically pagecache pages.  This
>> may affect performance of applications.
>>
>> One possible solution to this reclaim is to use scan control fields
>> and ask the shrink_page_list() and shrink_active_list() routines to
>> target only pagecache pages.  Pagecache pages are not mapped and
>> they are easy to find on the LRU list.
>>
>> Please review my patch at http://lkml.org/lkml/2007/01/17/96
>>
> 
> So you mean the existing reclaimer has the same issue, doesn't it?

Well, the existing reclaimer will do the right job if the kernel
really runs out of memory and need to recover pages for new
allocations.  The pages to be removed will be the coldest page in
the system.  However now with the introduction of pagecache limit,
we are artificially creating a memory scarcity and forcing the
reclaimer to throw away some pages while we actually have free
usable RAM.  In this context the choice of pages picked by the
present reclaimer may not be the best ones.

If pagecache is overlimit, we expect old (cold) pagecache pages to
be thrown out and reused for new file data.  We do not expect to
drop a few text or data pages to make room for new pagecache.

> In your and Roy's patch, balance_pagecache() routine is called on file
> backed access.
> So you still want to add this checking? or change the current
> reclaimer completely?

The balance_pagecache() routine is called for file backed access
since that is when we would probably exceed the pagecache limit.
The routine check if the limit has exceeded and calls the reclaimer.
The reclaimer is an extension of the present reclaimer with more
checks to remove only pagecache pages and not try to unmap any
mapped pages and potentially affect application performance.

I am open to suggestions on reclaim logic.  My view is that we need
to selectively reclaim pagecache pages and not just call the
traditional reclaimer to freeup arbitrary type of pages.

--Vaidy

> -Aubrey
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
