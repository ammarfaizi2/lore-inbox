Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264026AbRF1DWf>; Wed, 27 Jun 2001 23:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265500AbRF1DW0>; Wed, 27 Jun 2001 23:22:26 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:3498 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S264026AbRF1DWJ>; Wed, 27 Jun 2001 23:22:09 -0400
Message-ID: <3B3AA2B8.93F9A28C@uow.edu.au>
Date: Thu, 28 Jun 2001 13:21:28 +1000
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
In-Reply-To: <Pine.LNX.4.33L.0106271641570.23373-100000@duckman.distro.conectiva> <933130000.993673450@tiny>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> 
> ...
> The work around I've been using is the dirty_inode method.  Whenever
> mark_inode_dirty is called, reiserfs logs the dirty inode.  This means
> inode changes are _always_ reflected in the buffer cache right away, and
> the inode itself is never actually dirty.

reiserfs_mark_inode_dirty() has taken a copy of the in-core inode, so
it can do this:

            spin_lock(&inode_lock);
            if ((inode->i_state & I_LOCK) == 0)
                    inode->i_state &= ~(I_DIRTY_SYNC|I_DIRTY_DATASYNC);
            spin_unlock(&inode_lock);

Unfortunately there is no API function to do this, so inode_lock
needs to be exported :(

The effect of this is that the filesystem almost never has dirty inodes
as far as the VFS is concerned: shrink_icache_memory() can just drop the
inodes without calling into the fs at all.  Which is nice.

So you end up with:

reiserfs_write_inode(struct inode * inode, int do_sync)
{
}


The write_inode() method is still called by shrink_icache_memory()
with extreme infrequency.  I haven't looked into the reasons why.  It may
be an SMP window.

This is not just a memory-tweak-optimisation hack, BTW.
shrink_icache->write_inode is a horrible embarrassment because it
can be called at any time.   The caller may have a transaction open
against a different fs.  It would cause nested transactions which
will exceed the current reservation, which will require a commit,
which simply cannot be performed, etc.

sync(), fsync() and msync() can be handled in ->fsync().


-
