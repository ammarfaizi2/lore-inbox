Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315454AbSFCTvN>; Mon, 3 Jun 2002 15:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315455AbSFCTvM>; Mon, 3 Jun 2002 15:51:12 -0400
Received: from 216-42-72-145.ppp.netsville.net ([216.42.72.145]:64237 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S315454AbSFCTvK>; Mon, 3 Jun 2002 15:51:10 -0400
Subject: Re: [RFC] iput() cleanup (was Re: [patch 12/16] fix race between
	writeback and unlink)
From: Chris Mason <mason@suse.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, Alexander Viro <aviro@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0206031232500.1947-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 03 Jun 2002 15:49:24 -0400
Message-Id: <1023133764.22608.1867.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-06-03 at 15:34, Linus Torvalds wrote:
> 
> On 3 Jun 2002, Chris Mason wrote:
> > 
> > Now that is kinda neat, calling it with the inode lock held lets me move
> > some things out of reiserfs_file_release which need i_sem, and move them
> > into a less expensive drop_inode call without grabbing the semaphore.
> 
> CAREFUL!
> 
> If you make real per-FS use of this, and aren't just using the standard 
> ones, you need to be very very careful. In particular, you get called with 
> the inode lock held, but you would have to drop the lock yourself after 
> having removed the inode from the hash chains etc. I'd like people to 
> avoid playing too many games in this area, the locking and the exact 
> semantics of "drop_inode" are rather nasty.

Right, I don't want too much in there.  There are a few things I need to
do when I know nobody else is messing with the inode, and I'm using
i_sem to provide that now.  put_inode doesn't do what I need because
knfsd might iget his way into the mess.

I'm talking a very limited set of operations followed by calling the
generic functions.  I might not do it at all if I can't get them safe
when called under the spin lock.

-chris


