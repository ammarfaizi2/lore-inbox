Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316523AbSE0CQE>; Sun, 26 May 2002 22:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316524AbSE0CQD>; Sun, 26 May 2002 22:16:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20484 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316523AbSE0CQC>;
	Sun, 26 May 2002 22:16:02 -0400
Message-ID: <3CF197A8.A5DB850B@zip.com.au>
Date: Sun, 26 May 2002 19:19:20 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 5/18] mark swapout pages PageWriteback()
In-Reply-To: <3CF14834.7FF3E72E@zip.com.au> <Pine.LNX.4.44.0205261756410.1400-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 26 May 2002, Andrew Morton wrote:
> >
> > One fix would be to teach shrink_cache() to wait on PG_locked for swap
> > pages.  The other approach is to set both PG_locked and PG_writeback
> > for swap pages so they can be handled in the same manner as file-backed
> > pages in shrink_cache().
> 
> How about making them do exactly what normal writeout does, namely drop
> the locked bit too. Is there any advantage to holding it any more? The
> difference between swap writeout and normal writeout seems to be fairly
> arbitrary at this point.
> 

That leads to block_flushpage() being called under spinlock against a
page which has locked buffers, so it schedules on the buffer lock and
the box deadlocks.

So... can do, but I'll have to sort out the block_flushpage-under-spinlock
problem in the process.

But I recall you saying that there was advantage in keeping swapout pages
locked so that aggressive memory users would throttle against their
own swapout.  What's the story there?

Generally, there are a number of irritating swap special-cases popping up
and yes, it would be nice to give swap a proper inode, superblock (maybe)
and a get_block so it can become more regular.  One obstacle there is
the PAGE_SIZE versus PAGE_CACHE_SIZE thing.  Would have to add a new
address_space.page_size for that, which would penalise other address_spaces
slightly (in terms of memory usage and code size).

I've been trying to not look at the swap code ;) But there will be some
benefit it teaching swap to go direct to BIO to avoid the extra buffer
allocations when things are squeezy.  So I do need to stick my nose in 
there.

-
