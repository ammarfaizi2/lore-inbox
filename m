Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316659AbSGQUKv>; Wed, 17 Jul 2002 16:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316664AbSGQUKv>; Wed, 17 Jul 2002 16:10:51 -0400
Received: from dsl-213-023-038-064.arcor-ip.net ([213.23.38.64]:42686 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316659AbSGQUKG>;
	Wed, 17 Jul 2002 16:10:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: [patch 1/13] minimal rmap
Date: Wed, 17 Jul 2002 22:13:51 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0207171657200.12241-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.44L.0207171657200.12241-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17UvBH-0004Pb-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 July 2002 22:04, Rik van Riel wrote:
> On Wed, 17 Jul 2002, Daniel Phillips wrote:
> > On Wednesday 17 July 2002 21:41, Rik van Riel wrote:
> > > On Wed, 17 Jul 2002, Daniel Phillips wrote:
> 
> > > Nope. If it hits every directory entry once, it'll hit every
> > > page with directory or inode information multiple times, causing
> > > that page to enter the active list and push out process pages.
> >
> > Yes, it could get challenging, but it's very desirable to do the
> > optimization somehow.  It's even more desirable to stay focussed on
> > the immediate issues, imho.
> 
> One simple way of getting this right is adding a new list
> to the VM, after which we'd have the following lists:
> 
> 1) new_pages list, restricted to a certain size (5% of RAM,
>    50% of the size of the inactive list, ...)
>    FIFO, new pages get added to the front of the list,
>    old pages get their accessed bit cleared and moved to
>    the inactive list
> 
> 2) inactive list, second chance fifo, target size 1/2 of active list ?
>    pages sit on the inactive list until the pageout code runs into
>    them, if the page was not accessed it will be evicted, if it was
>    accessed it will be moved to the active list
> 
> 3) active list, second chance fifo
>    pages on this list get rotated slowly, if they were referenced
>    they go back on the other side of the list, if they were not
>    referenced they go to the inactive list
> 
> With this setup, we should be able to catch things like updatedb
> and common streaming IO; their accesses to the pages should mostly
> happen while the pages are on the new_pages list (1) and they
> shouldn't get referenced again while on the inactive list.
> 
> Of course, this isn't the case for things like the directory
> /usr, but we _want_ to cache directories close to the top of
> the tree anyway. Besides, we won't have many of those directories.
> 
> An added advantage of this scheme is that we'll no longer need to
> touch the lru list in mark_page_accessed() (reducing contention)
> and use-once might actually work for mmap()d pages.

Yes, I've always felt that at least one new list is needed to do the job 
properly, and there are other considerations as well.  What we really want to 
do is treat a short burst of accesses to a page as a single access.  Right 
now we're only doing a very crude approximation of that, which happens to 
work for some common situations, of which updatedb is not one.

Obviously we don't want to be adding new lists and other experimental cruft 
just now.

-- 
Daniel
