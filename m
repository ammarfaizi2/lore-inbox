Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287618AbRLaTlT>; Mon, 31 Dec 2001 14:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287620AbRLaTlK>; Mon, 31 Dec 2001 14:41:10 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:4114 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287618AbRLaTk7>; Mon, 31 Dec 2001 14:40:59 -0500
Message-ID: <3C30BE70.6E5E95CE@zip.com.au>
Date: Mon, 31 Dec 2001 11:37:20 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: alad@hss.hns.com
CC: linux-kernel@vger.kernel.org
Subject: Re: locked page handling
In-Reply-To: <65256B33.0039476C.00@sandesh.hss.hns.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alad@hss.hns.com wrote:
> 
> In 2.4.16, vmscan.c::shrink_cache(), we have following piece of code -
> 
>           /*
>            * The page is locked. IO in progress?
>            * Move it to the back of the list.
>            */
>           if (unlikely(TryLockPage(page))) {
>                if (PageLaunder(page) && (gfp_mask & __GFP_FS)) {
>                     page_cache_get(page);
>                     spin_unlock(&pagemap_lru_lock);
>                     wait_on_page(page);
>                     page_cache_release(page);
>                     spin_lock(&pagemap_lru_lock);
>                }
>                continue;
>           }
> 
> 1) Who is moving the page the back of list ?

Nobody.  The comment is wrong.

Possibly the code is wrong, too.  We don't want to keep scanning
the same page all the time.

> 2) Is the locked page worth waiting for? I can understand that the page is being
>  laundered so after wait we may get a clean page but from performance
>      point of view this is involving unnecessary context switches. Also during
> high memory pressure kswapd shall sleep here when it can get more
>      clean pages on the inactive list ? What are we loosing if we don't wait on
> the page and believe that in next pass we shall free this page
> 

Well we need to wait on I/O _somewhere_ in there.  Otherwise everyone
just ends up busywaiting on IO completion.  The idea is that on the
first pass through the inactive list, we start I/O, mark the page as
PG_Launder and don't wait on the I/O.  On the second pass through the
list, when we find a PG_Launder page, we wait on it.  This has the
effect of slowing memory-requesters down to the speed of the I/O
system.  All this is for mmapped pages.  The same behaviour is
implemented for write() pages via the BH_Launder bits on its buffers
over in sync_page_buffers().

-
