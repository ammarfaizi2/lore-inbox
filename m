Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310631AbSCHBKS>; Thu, 7 Mar 2002 20:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310632AbSCHBKI>; Thu, 7 Mar 2002 20:10:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15112 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310631AbSCHBKE>;
	Thu, 7 Mar 2002 20:10:04 -0500
Message-ID: <3C880EFF.A0789715@zip.com.au>
Date: Thu, 07 Mar 2002 17:08:15 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: truncate_list_pages()  BUG and confusion
In-Reply-To: <3C8809BA.4070003@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> 
> in truncate_list_pages()
> 
>    failed = TryLockPage(page);
> 
> So, the page is always locked here.
> 
>    truncate_complete_page(page);
>          remove_inode_page(page);
>               if (!PageLocked(page))
>                  PAGE_BUG(page);
> 
>          page_cache_release(page);
>              calls __free_pages_ok(page, 0);
>                  if (PageLocked(page))
>                     BUG();
> 
> It is a BUG if the page is not locked in remove_inode_page() and also a
> bug if it IS locked in __free_pages_ok().  What am I missing?

the page_cache_release() in truncate_complete_page() is just dropping
the reference count against the page which is due to that page's
presence in the pagecache.  We just took it out, so we drop the reference.

Note that the caller of truncate_complete_page() also took a reference to
the page, and undoes that reference *after* unlocking the page.  This
additional reference will prevent __free_pages_ok() from being called
by truncate_complete_page().

> ksymoopsed output follows:
>
> kernel BUG at page_alloc.c:109!

Now how did you manage that?  Looks like someone re-locked
the page after truncate_list_pages unlocked it.

-
