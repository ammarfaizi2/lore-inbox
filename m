Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133084AbRDRL0y>; Wed, 18 Apr 2001 07:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133086AbRDRL0o>; Wed, 18 Apr 2001 07:26:44 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:7947 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S133084AbRDRL0c>; Wed, 18 Apr 2001 07:26:32 -0400
Date: Wed, 18 Apr 2001 06:45:40 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: generic_osync_inode/ext2_fsync_inode still not safe
In-Reply-To: <20010417140928.C2505@redhat.com>
Message-ID: <Pine.LNX.4.21.0104180632490.4382-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Apr 2001, Stephen C. Tweedie wrote:

> Hi,
> 
> On Sat, Apr 14, 2001 at 07:24:42AM -0300, Marcelo Tosatti wrote:
> > 
> > As described earlier, code which wants to write an inode cannot rely on
> > the I_DIRTY bits (on inode->i_state) being clean to guarantee that the
> > inode and its dirty pages, if any, are safely synced on disk.
> 
> Indeed --- for all such structures, including pages, buffer_heads and
> inodes, you can only assume that the object is safely on disk if you
> have checked both the dirty bit AND the locked bit. 

No.

> If you find it locked but clean, then a writeout may be in progress,
> so you need to do a wait_on_* to be really sure that the write has
> completed.

As far as I can see, you cannot guarantee that an inode which is unlocked
_and_ clean (accordingly to the inode->i_state) is safely on disk.

The reason for that are calls to sync_one() which write the inode
asynchronously: 

sync_one(struct inode *inode, int sync) {
...
        dirty = inode->i_state & I_DIRTY;
        inode->i_state |= I_LOCK;
        inode->i_state &= ~I_DIRTY;
        spin_unlock(&inode_lock);

        filemap_fdatasync(inode->i_mapping);

        /* Don't write the inode if only I_DIRTY_PAGES was set */
        if (dirty & (I_DIRTY_SYNC | I_DIRTY_DATASYNC))
                write_inode(inode, sync);               <-------------

        filemap_fdatawait(inode->i_mapping);

        spin_lock(&inode_lock);
        inode->i_state &= ~I_LOCK;
        wake_up(&inode->i_wait);
}

The fs-specific write_inode() function will simply "generate" the dirty
buffer_head and add it to the dirty list.  After that, it unlocks the
inode.  

Where is the guarantee that this dirty buffer head has hitted the disk?

Do you see what I mean now ?

I don't see a clean "for 2.4" fix except writting the inode
unconditionally at _each_ call which needs to write the inode
synchronously.

