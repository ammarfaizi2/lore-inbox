Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265681AbRF1MzD>; Thu, 28 Jun 2001 08:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265683AbRF1Myx>; Thu, 28 Jun 2001 08:54:53 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:15876
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S265681AbRF1Mym>; Thu, 28 Jun 2001 08:54:42 -0400
Date: Thu, 28 Jun 2001 08:53:42 -0400
From: Chris Mason <mason@suse.com>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Xuan Baldauf <xuan--lkml@baldauf.org>, linux-kernel@vger.kernel.org,
        andrea@suse.de,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: VM deadlock
Message-ID: <1022480000.993732822@tiny>
In-Reply-To: <3B3AA2B8.93F9A28C@uow.edu.au>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, June 28, 2001 01:21:28 PM +1000 Andrew Morton
<andrewm@uow.edu.au> wrote:

> Chris Mason wrote:
>> 
>> ...
>> The work around I've been using is the dirty_inode method.  Whenever
>> mark_inode_dirty is called, reiserfs logs the dirty inode.  This means
>> inode changes are _always_ reflected in the buffer cache right away, and
>> the inode itself is never actually dirty.
> 
> reiserfs_mark_inode_dirty() has taken a copy of the in-core inode, so
> it can do this:
> 
>             spin_lock(&inode_lock);
>             if ((inode->i_state & I_LOCK) == 0)
>                     inode->i_state &= ~(I_DIRTY_SYNC|I_DIRTY_DATASYNC);
>             spin_unlock(&inode_lock);
> 
> Unfortunately there is no API function to do this, so inode_lock
> needs to be exported :(

Well, this is kind of my own fault.  I didn't want the dirty_inode call
back to be able to screw with the internals of how inode.c dealt with
things, I wanted it purely to allow actions in addition to what inode.c
wanted to do.

So, mark_inode_dirty calls dirty_inode, and then it sets whatever dirty
bits it wants to.  Clearing them in your own dirty_inode call won't matter,
they should just get set again later.

If we really want to leave the inode clean,  fsync isn't as much of a
concern as O_SYNC writes, since you want generic_osync_inode to properly
flush the updated inode.  But, that can be dealt with by having your
commit_write func test for O_SYNC.

What we can't get around is our friend knfsd, who uses write_inode_now.
The I_DIRTY bit needs to be accurate there (although it doesn't seem
perfect right now anyway).

The real problem I see is that we've overload the sync flag to write_inode.
It means flush now to get the data safe, and flush now to free ram.
Normally this kind of overloading is ok, but once logging comes into play I
believe a distinction is needed.

So, my current plan to fix reiserfs_write_inode is to do nothing when
current->flags & PF_MEMALLOC == 1.  I'm not wild about it, but don't see
many other fixes that don't involve api changes.  

I'd rather not do a private inode list until there is a clean way to apply
memory pressure to it, since reiserfs pins enough memory as it is.

-chris

