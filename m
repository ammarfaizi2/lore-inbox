Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261554AbSJPXup>; Wed, 16 Oct 2002 19:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261555AbSJPXup>; Wed, 16 Oct 2002 19:50:45 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:22217 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S261554AbSJPXuo>; Wed, 16 Oct 2002 19:50:44 -0400
Date: Thu, 17 Oct 2002 00:57:30 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Matthew Wilcox <willy@debian.org>
cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] shmem missing cache flush
In-Reply-To: <20021016192630.L15163@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0210170033320.1476-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2002, Matthew Wilcox wrote:
> 
> Really, this should be a clear_user_page(), but we can't reasonable get
> a user address all the way down to it, so let's just flush it instead.
> Note that 2.4 needs an equivalent fix.
> 
> diff -urpNX build-tools/dontdiff linus-2.5/mm/shmem.c parisc-2.5/mm/shmem.c
> --- linus-2.5/mm/shmem.c	Tue Oct  8 10:54:20 2002
> +++ parisc-2.5/mm/shmem.c	Tue Oct  8 16:49:24 2002
> @@ -848,6 +848,7 @@ repeat:
>  		info->alloced++;
>  		spin_unlock(&info->lock);
>  		clear_highpage(page);
> +		flush_dcache_page(page);
>  		SetPageUptodate(page);
>  	}

I expect you're right - even though that page is not yet mapped into
any user address space?  I'm currently preparing a shmem.c patch set
to send Andrew in the next day or two, so I'll factor that in too.

I would be much happier about adding it, if you could tell me that
I can then remove the flush_page_to_ram(page) from shmem_nopage?

But suspect you won't grant me that: notice that 2.4.18 and 2.5.3
added flush_dcache_page in addition to flush_page_to_ram in
memclear_highpage_flush, which I'll take as definitive.

To x86ers, flush_page_to_ram, flush_dcache_page, flush_icache_page
etc. all seem like forlorn prayers to different gods, "Please, let
my data be seen by the user".  Documentation/cachetlb.txt has for
a long time told us that flush_page_to_ram (sacrifice ram to page
god) is now deprecated, the new religion is flush_dcache_page,
and flush_icache_page can soon be forgotten.  But they're all
still there to confuse us; and it seems that years can go by
without the high priests noticing where these prayers are needed.

In view of which, I don't expect to be rushing a 2.4.20 fix to
Marcelo: let it ride until 2.4.21, okay?

Hugh

