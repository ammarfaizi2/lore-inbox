Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261293AbSIWTU2>; Mon, 23 Sep 2002 15:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261344AbSIWTTo>; Mon, 23 Sep 2002 15:19:44 -0400
Received: from dsl-213-023-022-250.arcor-ip.net ([213.23.22.250]:45749 "EHLO
	starship") by vger.kernel.org with ESMTP id <S261293AbSIWTSt>;
	Mon, 23 Sep 2002 15:18:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: trond.myklebust@fys.uio.no, Andrew Morton <akpm@digeo.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: invalidate_inode_pages in 2.5.32/3
Date: Mon, 23 Sep 2002 21:13:26 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Rik van Riel <riel@conectiva.com.br>,
       Urban Widmark <urban@teststation.com>, Chuck Lever <cel@citi.umich.edu>,
       trond.myklebust@fys.uio.no,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3D811363.70ABB50C@digeo.com> <3D811A6C.C73FEC37@digeo.com> <15759.17258.990642.379366@charged.uio.no>
In-Reply-To: <15759.17258.990642.379366@charged.uio.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17tYe7-0003b4-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 September 2002 18:38, Trond Myklebust wrote:
> >>>>> " " == Andrew Morton <akpm@digeo.com> writes:
> 
>      > Look, idunnoigiveup.  Like scsi and USB, NFS is a black hole
>      > where akpms fear to tread.  I think I'll sulk until someone
>      > explains why this work has to be performed in the context of a
>      > process which cannot do it.
> 
> I'd be happy to move that work out of the RPC callbacks if you could
> point out which other processes actually can do it.
> 
> The main problem is that the VFS/MM has no way of relabelling pages as
> being invalid or no longer up to date: I once proposed simply clearing
> PG_uptodate on those pages which cannot be cleared by
> invalidate_inode_pages(), but this was not to Linus' taste.

I'll take a run at analyzing this.

First, it's clear why can't just set the page !uptodate: if we fail to
lock the page we can't change the state of the uptodate bit because we
would violate the locking rules, iow, we would race with the vfs (see
block_read/write_full_page).

Note that even if succeed in the TryLock and set !uptodate, we still
have to walk the rmap list and unmap the page or it won't get refaulted
and the uptodate bit will be ignored.

For any page we can't lock without blocking, the cases are:

 1) Dirty: we don't need to invalidate it because it's going to get
    written back to the server anyway

 2) Locked, clean: the page could be locked for any number of reasons.
    Probably, it's locked for reading though.  We *obviously* need to
    kill this page at some point or we have a nasty heisenbug.  E.g., 
    somebody, somewhere, will get a file handed back to them from some 
    other client that rewrote the whole thing, complete and correct
    except for a stale page or two.

For pages that we can lock, we have:

 3) Elevated count, clean: we could arguably ignore the use count
    and just yank the page out of the inode list, as Andrew's patch
    does.  Getting it out of the mapping is harder, perhaps much
    harder.

 4) Clean, has buffers, can't get rid of the buffers: we can't know
    why.  HTree puts pages in this state for directory access, Ext3
    probably does it for a variety of reasons.  Same situation as
    above.

Given the obviously broken case (2) above and the two probably broken
case (3) and (4), I don't see any way to ignore this problem and still
implement the NFS semantics Chuck described earlier.

I see Rik's suggestion of marking the problem pages invalid, and walking
the ptes to protect them as the cleanest fix.  Unlike invalidate_inode_pages,
the fault path can block perfectly happily while the problem conditions
sort themselves out.

-- 
Daniel
