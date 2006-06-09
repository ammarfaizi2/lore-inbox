Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030387AbWFIXuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbWFIXuN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 19:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbWFIXuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 19:50:13 -0400
Received: from thunk.org ([69.25.196.29]:43922 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1030387AbWFIXuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 19:50:11 -0400
To: linux-kernel@vger.kernel.org
Subject: [RFC]  Slimming down struct inode
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E1Foqjw-00010e-Ln@candygram.thunk.org>
Date: Fri, 09 Jun 2006 19:50:08 -0400
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since Linus has been complaining about how awful ext3's in-core inodes
are, and given that 70% of the space used by ext3's in-core inode is
coming from the include/linux/fs.h's struct inode structure, I decided
it would be good to see how we might be able to slim it down.  Slimming
down struct inode has the added benefit that it will help all
filesystems, so this is generic goodness.  Furthermore, depending on
which features you have compiled into the kernel, even slimming struct
inode by 12 bytes could result being able to pack more objects per page
in the slab cache.

So without further ado, here are some ideas of ways that we can slim
down struct inode:

1) Move i_blksize (optimal size for I/O, reported by the stat system
   call).  Is there any reason why this needs to be per-inode, instead
   of per-filesystem?

2) Move i_blkbits (blocksize for doing direct I/O in bits) to struct
   super.  Again, why is this per-inode?

3) Move i_pipe, i_bdev, and i_cdev into a union.  An inode cannot
    simultaneously be a pipe, block device, and character device at the
    same time.

4) i_state and i_flags are both 4-byte longs, but they only need to be
   2-byte shorts, and could be placed next to each other.

5) Nuke i_cindex.  This is only used by ieee1394's
   ieee_file_to_instance.  There must be another place where we can
   store this --- say, in a ieee1394-specific field in struct file?  Or
   maybe it can be derived some other way, but to chew up 4 bytes in
   i_cindex for all inodes just for ieee1394's benefit seems like the
   Wrong Thing(tm).

6) Separate out those elements which are only used if the inode is open
   into a separate data structure (call it "struct inode_state" for
   the sake of argument):

	i_flock, i_mapping, i_data, i_dnotify_mask, i_dnotify,
	inotify_watches, inotify_sem, i_state, dirtied_when,
	i_size_seqcount, i_mutex, i_alloc_sem

   This is the motherload.  Moving these fields out to a separate
   structure which is only allocated for inodes which are open will save
   a huge amount of memory.  But, of course, sweeping through all of the
   code which uses these variables to move them would be a major code
   change.  (We can do it initially with #define magic, but we will need
   to audit the code paths to see if it's always to safe to assume that
   inode is open before dereferencing the i_state pointer, or whether we
   need to check to see if it is valid first.)

The first four I think are fairly non-contentious, but it's worth
checking to see if anybody knows if there are filesystems for which the
block size changes on a per-inode basis (I hope not!).  There's a very
trivial way of fixing #5 by simply moving i_cindex into struct file, but
it may be possible to fix the ieee1394 layer so it doesn't need it at
all.

#6 is going to be the hard one, since it will involving touching the
largest amount of code.  But of course, the payoff will be quite big as
well.  Of course, memory is pretty cheap these days, which is probably
why we've ignored it until Linus started kvetching about the size of
ext3's in-core inodes....   and when I looked into it, most of it wasn't
even ext3's fault.  :-)

What do people think?  Is it worth putting together patches to do some
or all of the above?

						- Ted
