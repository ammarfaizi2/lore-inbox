Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315423AbSFCTLl>; Mon, 3 Jun 2002 15:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315437AbSFCTLk>; Mon, 3 Jun 2002 15:11:40 -0400
Received: from 216-42-72-145.ppp.netsville.net ([216.42.72.145]:46829 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S315423AbSFCTLj>; Mon, 3 Jun 2002 15:11:39 -0400
Subject: Re: [RFC] iput() cleanup (was Re: [patch 12/16] fix race between
	writeback and unlink)
From: Chris Mason <mason@suse.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, Alexander Viro <aviro@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0206022119300.1030-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 03 Jun 2002 15:09:36 -0400
Message-Id: <1023131376.22609.1856.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-06-03 at 00:27, Linus Torvalds wrote:
> 
> 
> On Sat, 1 Jun 2002, Andrew Morton wrote:
> >
> > > Why not just split up the code inside iput(), and then just do
> > >
> > >         if (atomic_dec(&inode->i_count))
> > >                 final_iput(inode);
> >
> > Yes, I suspect all the inode refcounting, locking, I_FREEING, I_LOCK, etc
> > could do with a spring clean. Make it a bit more conventional.  I'll
> > discuss with Al when he resurfaces.
> 
> This is a first cut at cleaning up "iput()" and getting rid of some of the
> magic VFS-level behaviour of the i_nlink field which many filesystems do
> not actually want - as shown by the number of "force_delete" users out
> there.
> 
> It does not change any real behaviour, but it splits up the "iput()"
> behaviour into several functions ("common_delete_inode()",
> "common_forget_inode()" and "common_drop_inode()"), and adds a place for a
> low-level filesystem to hook into the behaviour at inode drop time,
> through the "drop_inode" superblock operation.

Now that is kinda neat, calling it with the inode lock held lets me move
some things out of reiserfs_file_release which need i_sem, and move them
into a less expensive drop_inode call without grabbing the semaphore.

-chris


