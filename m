Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291787AbSCIAEZ>; Fri, 8 Mar 2002 19:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291759AbSCIAEQ>; Fri, 8 Mar 2002 19:04:16 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:18843 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S291729AbSCIAEK>; Fri, 8 Mar 2002 19:04:10 -0500
Date: Fri, 08 Mar 2002 16:04:04 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Dave Hansen <haveblue@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: truncate_list_pages()  BUG and confusion
Message-ID: <67550000.1015632244@flay>
In-Reply-To: <3C8932CC.761C8829@zip.com.au>
In-Reply-To: <3C880EFF.A0789715@zip.com.au>,	<3C8809BA.4070003@us.ibm.com> <3C880EFF.A0789715@zip.com.au> <17920000.1015622098@flay> <3C8932CC.761C8829@zip.com.au>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> void page_cache_release(struct page *page)
>> {
>>         if (!PageReserved(page) && put_page_testzero(page)) {
>>                 if (PageLRU(page))
>>                         lru_cache_del(page);
>>                 __free_pages_ok(page, 0);
>>         }
>> }
>> 
>> We enter page_cache_release with the supposedly locked, and its count
>> non-zero (we incremented it).  put_page_testzero does atomic_dec_and_test
>> on count which says it returns true if the result is 0, or false for all other cases.
>> 
>> So if nobody else was holding a reference to the page, we've decremented
>> it's count to 0, and put_page_testzero returns 1. We then try to free the page.
>> It's still locked. BUG.
> 
> If the page_cache_release() in truncate_complete_page() is calling
> __free_pages_ok() then something really horrid has happened.

That's exactly what's happening.
 
> Yes, it could be that the page has had its refcount incorrectly
> decremented somewhere.

I don't see you need that to make this bug happen.
Say count is 0 when we enter truncate_list_pages. We increment it.
It's now 1 when we call page_cache_release. 
put_page_testzero dec's it back to 0, and returns true.
We do a __free_pages_ok. Page is still locked. BUG.

No other process, nothing funky happening, no races, no other
refcount decrements. Or that's the way I read it.

> Or the page wasn't in the pagecache at all.

The only thing I can think of was the pagecount shouldn't have been 0
to start with (or the code path we're reading is wrong ;-) )

M.

