Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316623AbSGGXM3>; Sun, 7 Jul 2002 19:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316629AbSGGXM2>; Sun, 7 Jul 2002 19:12:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61456 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316623AbSGGXM2>;
	Sun, 7 Jul 2002 19:12:28 -0400
Message-ID: <3D28CCF5.197E909C@zip.com.au>
Date: Sun, 07 Jul 2002 16:21:25 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: truncate_list_pages() page lock confusion and BUG
References: <3C88087A.2030704@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> 
> I'm getting BUG()s from page_alloc.c:109 in 2.5.6-pre2
> 
> truncate_list_pages() contains
> 
> failed = TryLockPage(page);
> 
> The page should always be locked when I get past there
> 
> shortly after this, truncate_complete_page() can be called
> 
> truncate_complete_page() calls:
>          remove_inode_page(page);
>               if (!PageLocked(page))
>                  PAGE_BUG(page);
> followed immediately by
>          page_cache_release(page);
>              calls __free_pages_ok(page, 0);
>                  if (PageLocked(page))
>                     BUG();
> 
> So, it appears that when truncate_complete_page() is called, it is a BUG
> if the page is unlocked in remove_inode_page(), or locked in
> page_cache_release().   What am I missing?  Actual bug follows:
> 

The page should not be actually freed by truncate_complete_page().
See how truncate_list_pages() has bumped its refcount?

If the page is successfully truncated then the actual freeing
occurs in the page_cache_release() in truncate_list_pages(),
after the page has been unlocked.

Looks like the page refcount has suffered an extra decrement
somewhere.  You're hitting this on the not-very-tested 
generic_file_write() error path.  But it all looks to be OK.


2.5.6 is awfully ancient.

-
