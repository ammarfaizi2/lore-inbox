Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310660AbSCHC46>; Thu, 7 Mar 2002 21:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310662AbSCHC4q>; Thu, 7 Mar 2002 21:56:46 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:1682 "EHLO mail3.aracnet.com")
	by vger.kernel.org with ESMTP id <S310660AbSCHCzh>;
	Thu, 7 Mar 2002 21:55:37 -0500
Date: Thu, 07 Mar 2002 18:55:55 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrew Morton <akpm@zip.com.au>, Dave Hansen <haveblue@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: truncate_list_pages()  BUG and confusion
Message-ID: <1044120155.1015527354@[10.10.2.3]>
In-Reply-To: <3C880EFF.A0789715@zip.com.au>
In-Reply-To: <3C880EFF.A0789715@zip.com.au>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Thursday, March 07, 2002 5:08 PM -0800 Andrew Morton <akpm@zip.com.au> wrote:

> Dave Hansen wrote:
>> 
>> in truncate_list_pages()
>> 
>>    failed = TryLockPage(page);
>> 
>> So, the page is always locked here.
>> 
>>    truncate_complete_page(page);
>>          remove_inode_page(page);
>>               if (!PageLocked(page))
>>                  PAGE_BUG(page);
>> 
>>          page_cache_release(page);
>>              calls __free_pages_ok(page, 0);
>>                  if (PageLocked(page))
>>                     BUG();
>> 
>> It is a BUG if the page is not locked in remove_inode_page() and also a
>> bug if it IS locked in __free_pages_ok().  What am I missing?
> 
> the page_cache_release() in truncate_complete_page() is just dropping
> the reference count against the page which is due to that page's
> presence in the pagecache.  We just took it out, so we drop the reference.
> 
> Note that the caller of truncate_complete_page() also took a reference to
> the page, and undoes that reference *after* unlocking the page.  This
> additional reference will prevent __free_pages_ok() from being called
> by truncate_complete_page().
> 
>> ksymoopsed output follows:
>> 
>> kernel BUG at page_alloc.c:109!
> 
> Now how did you manage that?  Looks like someone re-locked
> the page after truncate_list_pages unlocked it.

Where did truncate_list_pages unlock it? It doesn't do that
until after it's called truncate_complete_page, which (indirectly)
frees the page ... ?

Dave & I must be missing something, as this could never work
the way we're reading it, but I can't see what ;-)

M.


