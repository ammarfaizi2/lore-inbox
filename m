Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288174AbSCHVzT>; Fri, 8 Mar 2002 16:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311159AbSCHVzL>; Fri, 8 Mar 2002 16:55:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57604 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288174AbSCHVzC>;
	Fri, 8 Mar 2002 16:55:02 -0500
Message-ID: <3C8932CC.761C8829@zip.com.au>
Date: Fri, 08 Mar 2002 13:53:16 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
CC: Dave Hansen <haveblue@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: truncate_list_pages()  BUG and confusion
In-Reply-To: <3C880EFF.A0789715@zip.com.au>,
		<3C8809BA.4070003@us.ibm.com> <3C880EFF.A0789715@zip.com.au> <17920000.1015622098@flay>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> ...
> So truncate_list_pages does a page_cache_get(page), which increments
> the count. Nowhere does it decrement the count, or do an UnlockPage
> before it gets into page_cache_release, which looks like this:

well...  truncate_list_pages _does_ unlock the page.  Let's
snip some bits:

truncate_list_pages()
{
	...
	/* Bump the refcount.  From now until the matching
	 * page_cache_release(), the page *cannot* be freed,
	 * because we hold a reference
	 */
	page_cache_get(page);

	lock_page(page);

	truncate_complete_page(page);
	-->	{
			remove_inode_page(page);	/* Remove from pagecache */
			/*
			 * We now drop the refcount which is due to
			 * presence in the pagecache.  This can't free
			 * the page, because truncate_list_pages() holds a reference
			 */
			page_cache_release(page);
		}

	<---
	UnlockPage();		/* Remember, wait_on_page() is an indirect unlock, too */

	/*
	 * Now truncate_list_pages() drops its temporary reference.
	 * The page is unlocked.  If this was the last reference
	 * (and it usually will be) then the page will now be freed.
	 */
	page_cache_release(page);
}

> void page_cache_release(struct page *page)
> {
>         if (!PageReserved(page) && put_page_testzero(page)) {
>                 if (PageLRU(page))
>                         lru_cache_del(page);
>                 __free_pages_ok(page, 0);
>         }
> }
> 
> We enter page_cache_release with the supposedly locked, and its count
> non-zero (we incremented it).  put_page_testzero does atomic_dec_and_test
> on count which says it returns true if the result is 0, or false for all other cases.
> 
> So if nobody else was holding a reference to the page, we've decremented
> it's count to 0, and put_page_testzero returns 1. We then try to free the page.
> It's still locked. BUG.

If the page_cache_release() in truncate_complete_page() is calling
__free_pages_ok() then something really horrid has happened.

Yes, it could be that the page has had its refcount incorrectly
decremented somewhere.

Or the page wasn't in the pagecache at all.

Is this happening with the dbench/ENOSPC/1k blocksize testcase?
In that case, something is clearly going wrong with the association
of buffers against the page.  And the presence of buffers at page->buffers
_also_ contributes to page->count.  So there's a commonality here.
Possibly we forgot to increment the page count when we added buffers,
or we bogusly thought the page had buffers when it didn't, and then
dropped the page refcount when we thought we removed the buffers
which weren't really there.

-
