Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311130AbSCHVP0>; Fri, 8 Mar 2002 16:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311131AbSCHVPR>; Fri, 8 Mar 2002 16:15:17 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:5780 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S311130AbSCHVPL>;
	Fri, 8 Mar 2002 16:15:11 -0500
Date: Fri, 08 Mar 2002 13:14:58 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrew Morton <akpm@zip.com.au>, Dave Hansen <haveblue@us.ibm.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: truncate_list_pages()  BUG and confusion
Message-ID: <17920000.1015622098@flay>
In-Reply-To: <3C880EFF.A0789715@zip.com.au>
In-Reply-To: <3C8809BA.4070003@us.ibm.com> <3C880EFF.A0789715@zip.com.au>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, Dave and I went through this again, and we're both still confused.
Hopefully you still have the patience to keep explaining this to us ;-)
There must be something wrong here, otherwise we wouldn't get the
panic. It looks like the real problem here is to do with the page's count
rather than the locked stuff .... which fits in with the other panics Dave
has been seeing.

> the page_cache_release() in truncate_complete_page() is just dropping
> the reference count against the page which is due to that page's
> presence in the pagecache.  We just took it out, so we drop the reference.
> 
> Note that the caller of truncate_complete_page() also took a reference to
> the page, and undoes that reference *after* unlocking the page.  This
> additional reference will prevent __free_pages_ok() from being called
> by truncate_complete_page().

OK, I'd missed a whole bit here, which I now understand (or think I do ;-)). 
So truncate_list_pages does a page_cache_get(page), which increments 
the count. Nowhere does it decrement the count, or do an UnlockPage 
before it gets into page_cache_release, which looks like this:

void page_cache_release(struct page *page)
{
        if (!PageReserved(page) && put_page_testzero(page)) {
                if (PageLRU(page))
                        lru_cache_del(page);
                __free_pages_ok(page, 0);
        }
}

We enter page_cache_release with the supposedly locked, and its count
non-zero (we incremented it).  put_page_testzero does atomic_dec_and_test
on count which says it returns true if the result is 0, or false for all other cases.

So if nobody else was holding a reference to the page, we've decremented
it's count to 0, and put_page_testzero returns 1. We then try to free the page.
It's still locked. BUG.

John Stultz also pointed out that on return to the flow of truncate_list_pages
we call page_cache release again, which looks really odd. Something is 
wrong here .....

>> ksymoopsed output follows:
>> 
>> kernel BUG at page_alloc.c:109!
> 
> Now how did you manage that?  Looks like someone re-locked
> the page after truncate_list_pages unlocked it.> Where did truncate_list_pages unlock it?


> 
>                                 if (*partial && (offset + 1) == start) {
>                                         truncate_partial_page(page, *partial);
>                                         *partial = 0;
>                                 } else 
>                                         truncate_complete_page(page);
>  
>                                UnlockPage(page);
>                         } else
>                                 wait_on_page(page);
> 
> It's either unlocked directly, or we wait for whoever locked
> it (presumably I/O) to unlock it.

But that's all *after* we call truncate_complete_page, so it's
irrelevant, no ??

M.
