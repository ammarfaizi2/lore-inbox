Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130317AbRDTUdF>; Fri, 20 Apr 2001 16:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130446AbRDTUcz>; Fri, 20 Apr 2001 16:32:55 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:38410 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S130317AbRDTUcw>; Fri, 20 Apr 2001 16:32:52 -0400
Date: Fri, 20 Apr 2001 21:27:27 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: generic_osync_inode/ext2_fsync_inode still not safe
Message-ID: <20010420212727.B1042@redhat.com>
In-Reply-To: <20010417140928.C2505@redhat.com> <Pine.LNX.4.21.0104180632490.4382-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0104180632490.4382-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Wed, Apr 18, 2001 at 06:45:40AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 18, 2001 at 06:45:40AM -0300, Marcelo Tosatti wrote:

> As far as I can see, you cannot guarantee that an inode which is unlocked
> _and_ clean (accordingly to the inode->i_state) is safely on disk.
> 
> The reason for that are calls to sync_one() which write the inode
> asynchronously: 
> 
> sync_one(struct inode *inode, int sync) {
> ...
>         /* Don't write the inode if only I_DIRTY_PAGES was set */
>         if (dirty & (I_DIRTY_SYNC | I_DIRTY_DATASYNC))
>                 write_inode(inode, sync);               <-------------
...
>         inode->i_state &= ~I_LOCK;

Right --- nasty.  But not _too_ nasty, there's a moderately easy way
of dealing with this.

Basically we can't trust the i_state flag for this purpose if we are
allowing async IO to happen on inodes without having proper IO
completion callbacks marking the inodes as unlocked once they are firm
on disk.  However, in this case the filesystem itself will know which
underlying buffer_head contains the inode data, and can check to see
if that buffer is locked and perform a wait if necessary.

This is somewhat unpleasant in that it may sometimes cause unnecessary
false sharing, given that we have multiple inodes in an inode block.
However, I can't see any simple way around that.

Linus, do you have any preference for how to deal with this?  We can
either do it by adding a s_op->wait_inode() function to complement
write_inode(), and have a wait_inode() implementation in block-device
filesystems which does the buffer lookup and wait; or we can push that
whole logic into the filesystems, so that the I_DIRTY check is removed
from the VFS mid-layer altogether and the filesystem is responsible
for testing both the inode and buffer locked state when we try to wait
for outstanding inode IO to complete.

The second method is a bit cleaner conceptually but it results in more
code duplication.

Cheers,
 Stephen
