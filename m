Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262474AbUKWCdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbUKWCdp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 21:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbUKWCb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 21:31:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:21218 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262528AbUKWCaX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 21:30:23 -0500
Date: Mon, 22 Nov 2004 18:30:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] problem of cont_prepare_write()
Message-Id: <20041122183006.5ef3b41c.akpm@osdl.org>
In-Reply-To: <87k6sdwbhy.fsf@devron.myhome.or.jp>
References: <877joexjk5.fsf@devron.myhome.or.jp>
	<20041122024654.37eb5f3d.akpm@osdl.org>
	<87ekimw1uj.fsf@devron.myhome.or.jp>
	<20041122134344.3b2cb489.akpm@osdl.org>
	<87k6sdwbhy.fsf@devron.myhome.or.jp>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
> >> Umm... however, if ->i_size is updated before ->commit_write(),
> >> doesn't it allow access to those pages, before all write() work is
> >> successful?
> >
> > That's OK.  A thread which is read()ing that page will either
> >
> > a) decide that the page is outside i_size, and won't read it anyway or
> >
> > b) decide that the page is inside i_size and will read the page's contents.
> >
> > Still, I'd be inclined to update i_size after running ->commit_write.  It
> > looks like we can simply replace the call to __block_commit_write() with a
> > call to generic_commit_write().
> 
> If ->prepare_write() failed, I thought we should restore the ->i_size
> by vmtruncate() before running ->prepare_write().

                  ^^^^^^ I assume you meant "after"

> 
> But, it's not required... yes?

yes, it's needed in theory - see generic_file_buffered_write().  I'm trying
to remember why...

I think the only problem which that is solving is that the filesystem may
have left some blocks in the file outside i_size.  That's a minor
consistency issue which a fsck will fix up.  But I guess a subsequent lseek
may permit unwritten disk blocks to be read.

This problem is present whenever ->prepare_write() is called and we really
shouldn't be open-coding it everywhere.

> Anyway, fixed patch is the following.

Thanks. Does it pass all your testing?

> -- 
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> 
> 
> 
>  fs/buffer.c |    3 +--
>  1 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff -puN fs/buffer.c~cont_prepare_write-fix fs/buffer.c
> --- linux-2.6.10-rc2/fs/buffer.c~cont_prepare_write-fix	2004-11-23 11:10:10.000000000 +0900
> +++ linux-2.6.10-rc2-hirofumi/fs/buffer.c	2004-11-23 11:10:10.000000000 +0900
> @@ -2224,8 +2224,7 @@ int cont_prepare_write(struct page *page
>  		memset(kaddr+zerofrom, 0, PAGE_CACHE_SIZE-zerofrom);
>  		flush_dcache_page(new_page);
>  		kunmap_atomic(kaddr, KM_USER0);
> -		__block_commit_write(inode, new_page,
> -				zerofrom, PAGE_CACHE_SIZE);
> +		generic_commit_write(NULL, new_page, zerofrom, PAGE_CACHE_SIZE);
>  		unlock_page(new_page);
>  		page_cache_release(new_page);
>  	}
> _
