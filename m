Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315607AbSFCWMa>; Mon, 3 Jun 2002 18:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315611AbSFCWM3>; Mon, 3 Jun 2002 18:12:29 -0400
Received: from 216-42-72-145.ppp.netsville.net ([216.42.72.145]:4225 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S315607AbSFCWM2>; Mon, 3 Jun 2002 18:12:28 -0400
Subject: Re: [patch 12/16] fix race between writeback and unlink
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3CF91E48.C76B34FA@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 03 Jun 2002 18:10:33 -0400
Message-Id: <1023142233.31475.23.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-06-01 at 15:19, Andrew Morton wrote:
> Linus Torvalds wrote:
> > 
> > On Sat, 1 Jun 2002, Andrew Morton wrote:
> > >
> > > So run __iget prior to dropping inode_lock.
> > 
> > This part looks horrible:
> > 
> > +               spin_unlock(&inode_lock);
> > +               iput(inode);
> > +               spin_lock(&inode_lock);
> 
> Yup.  The inode refcounting APIs are really awkward.  Note how I recently
> added dopey code in ext2_put_inode() to only drop the prealloc window on
> the "final" iput().

Hmmm, a quick glance makes the test in ext2_put_inode look unsafe.

iput calls put_inode before decrementing i_count.  So, nothing stops 5
iput callers from all deciding i_count > 2 and leaving the preallocation
blocks hanging.

Also, a knfsd triggered iget/iput pair should hit the same race with an
put_inode call.

Or am I missing something?

-chris


