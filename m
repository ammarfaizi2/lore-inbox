Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265938AbRF1OJZ>; Thu, 28 Jun 2001 10:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265937AbRF1OJP>; Thu, 28 Jun 2001 10:09:15 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:41714 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S265935AbRF1OI4>; Thu, 28 Jun 2001 10:08:56 -0400
Message-ID: <3B3B3A65.844C3880@uow.edu.au>
Date: Fri, 29 Jun 2001 00:08:37 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Xuan Baldauf <xuan--lkml@baldauf.org>, linux-kernel@vger.kernel.org,
        andrea@suse.de,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: VM deadlock
In-Reply-To: <3B3AA2B8.93F9A28C@uow.edu.au> <1022480000.993732822@tiny>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> 
> On Thursday, June 28, 2001 01:21:28 PM +1000 Andrew Morton
> <andrewm@uow.edu.au> wrote:
> ...
> > reiserfs_mark_inode_dirty() has taken a copy of the in-core inode, so
> > it can do this:
> >
> >             spin_lock(&inode_lock);
> >             if ((inode->i_state & I_LOCK) == 0)
> >                     inode->i_state &= ~(I_DIRTY_SYNC|I_DIRTY_DATASYNC);
> >             spin_unlock(&inode_lock);
> >
> > Unfortunately there is no API function to do this, so inode_lock
> > needs to be exported :(
> 
> Well, this is kind of my own fault.  I didn't want the dirty_inode call
> back to be able to screw with the internals of how inode.c dealt with
> things, I wanted it purely to allow actions in addition to what inode.c
> wanted to do.
> 
> So, mark_inode_dirty calls dirty_inode, and then it sets whatever dirty
> bits it wants to.  Clearing them in your own dirty_inode call won't matter,
> they should just get set again later.

yes, the above code is a bit of a waste of space :)

The reason ->write_inode() can be a no-op is that __sync_one()
marks the inode clean, then calls ->write_inode().  We *know*
that we took a copy of the inode in mark_inode_dirty(), so
we don't need to do anything.

Of course this absolutely requires all inode dirtiers to
call mark_inode_dirty() after doing the dirty, which is a risk.
But we face that risk with the PF_MEMALLOC case anyway.  No
problems have appeared in testing.

mark_inode_dirty() is the only way in which those bits can get
set. So the risk we face is that someone calls mark_inode_dirty(),
then alters the inode, then there is a call to write_inode().
That would be a bug, IMO.

As for knfsd, well, someone must have called mark_inode_dirty()
at sometime, else they'd never get written.

It's all rather dodgy.

-
