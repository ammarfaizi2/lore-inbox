Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316609AbSGQUBd>; Wed, 17 Jul 2002 16:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316610AbSGQUBd>; Wed, 17 Jul 2002 16:01:33 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:36367 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S316609AbSGQUBd>; Wed, 17 Jul 2002 16:01:33 -0400
Date: Wed, 17 Jul 2002 17:04:13 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Daniel Phillips <phillips@arcor.de>
cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/13] minimal rmap
In-Reply-To: <E17Uuti-0004PT-00@starship>
Message-ID: <Pine.LNX.4.44L.0207171657200.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2002, Daniel Phillips wrote:
> On Wednesday 17 July 2002 21:41, Rik van Riel wrote:
> > On Wed, 17 Jul 2002, Daniel Phillips wrote:

> > Nope. If it hits every directory entry once, it'll hit every
> > page with directory or inode information multiple times, causing
> > that page to enter the active list and push out process pages.
>
> Yes, it could get challenging, but it's very desirable to do the
> optimization somehow.  It's even more desirable to stay focussed on
> the immediate issues, imho.

One simple way of getting this right is adding a new list
to the VM, after which we'd have the following lists:

1) new_pages list, restricted to a certain size (5% of RAM,
   50% of the size of the inactive list, ...)
   FIFO, new pages get added to the front of the list,
   old pages get their accessed bit cleared and moved to
   the inactive list

2) inactive list, second chance fifo, target size 1/2 of active list ?
   pages sit on the inactive list until the pageout code runs into
   them, if the page was not accessed it will be evicted, if it was
   accessed it will be moved to the active list

3) active list, second chance fifo
   pages on this list get rotated slowly, if they were referenced
   they go back on the other side of the list, if they were not
   referenced they go to the inactive list

With this setup, we should be able to catch things like updatedb
and common streaming IO; their accesses to the pages should mostly
happen while the pages are on the new_pages list (1) and they
shouldn't get referenced again while on the inactive list.

Of course, this isn't the case for things like the directory
/usr, but we _want_ to cache directories close to the top of
the tree anyway. Besides, we won't have many of those directories.

An added advantage of this scheme is that we'll no longer need to
touch the lru list in mark_page_accessed() (reducing contention)
and use-once might actually work for mmap()d pages.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

