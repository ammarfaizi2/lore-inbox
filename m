Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbVIUCgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbVIUCgE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 22:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbVIUCgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 22:36:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53919 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750844AbVIUCgD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 22:36:03 -0400
Date: Wed, 21 Sep 2005 03:36:01 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Ray Lee <ray@madrabbit.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event under load
Message-ID: <20050921023601.GT7992@ftp.linux.org.uk>
References: <20050920051729.GF7992@ftp.linux.org.uk> <76677C3D-D5E0-4B5A-800F-9503DA09F1C3@tentacle.dhs.org> <20050920163848.GO7992@ftp.linux.org.uk> <1127238257.9940.14.camel@localhost> <Pine.LNX.4.58.0509201108120.2553@g5.osdl.org> <20050920182249.GP7992@ftp.linux.org.uk> <Pine.LNX.4.58.0509201234560.2553@g5.osdl.org> <1127256814.749.5.camel@vertex> <20050921010154.GR7992@ftp.linux.org.uk> <1127266907.3950.5.camel@vertex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127266907.3950.5.camel@vertex>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 09:41:47PM -0400, John McCutchan wrote:
> I grepped all the filesystems

... in the tree

> , and they all seem to use
> generic_drop_inode, except for hugetlbfs, which seems to have the same
> logic of (!inode->i_nlink).

I have no problems with killing ->drop_inode(), but that should be
	a) done for in-tree filesystems
	b) announced on fsdevel, so that out-of-tree folks could deal
with that
	c) given at least one release to avoid screwing them.

Christoph, could you send the patch you've mentioned?  I'd rather avoid
duplicating what you've done...

> > BTW, what happens if one uses inotify on procfs?  Or sysfs, for that matter?
> > Fundamental problem with that sucker is that you are playing games with
> > lifetime rules of inodes in a way that might be OK for some filesystems,
> > but violates a lot of assumptions made by other...
> > 
> 
> Honestly, I don't know. And I don't think I know enough to say with any
> certainty how either of them would work. Would a black list of
> filesystems that don't want inotify on them be acceptable?

Maybe...  Alternatively, it might be interesting to see if differences
between filesystem requirements can be handled by secondary method
table that would be set at ->get_sb() time (or merged into super_operations
if we end up with few of them).

I'd certainly love to deal with sys_unlink() kludge that way, BTW - two
new methods, with vfs_unlink() ending with

        up(&dentry->d_inode->i_sem);

	/* NOTE: fast path should be dealt with in real version, this
	   is just a demo */

	if (error)
		return ERR_PTR(error);
	else if (!dir->i_op->post_unlink)
		return generic_post_unlink(dentry);
	else
		return dir->i_op->post_unlink(dentry);
}

with callers doing

	p = vfs_unlink(dir, dentry);
	...
	up(&dir->i_sem);
	err = vfs_finish_unlink(dir, p);


vfs_finish_unlink(dir, p) (again, that would need to be optimized for fast path)

	if (IS_ERR(p))
		return PTR_ERR(p);
	if (!dir->i_op->finish_unlink)
		return generic_finish_unlink(dir, p);
	else
		return dir->i_op->finish_unlink(dir, p);

generic_post_unlink(dentry): grab a reference to dentry->d_inode, call
d_delete(), return inode

generic_finish_unlink(dir, p): iput(p); return 0;

NFS: don't mess with inode refcount at all *and* make sure we don't
d_delete() sillyrenamed ones.

sys_unlink(): no more messing with inodes behind fs back.

Price: change of public API (vfs_unlink() changes the type of return value
*and* calling conventions - we need to pass its return value to
vfs_finish_unlink() after unlocking the parent).

> > BTW^2, what guarantees that inotify_unmount_inodes() will not happen while we
> > are in inotify_release()?  That would happily keep watch refcount bumped,
> > so it would outlive inotify_unmount_inodes().  Sure, it would be dropped.
> > And call iput() on a pinned inode that had outlived the umount().  Oops...
> 
> Good catch,

[snip]

Why don't you simply put watches on a list anchored at superblock and
go through that list instead of messing with inode lists?

Speaking of disappearing ->d_inode problem...  How about collecting
watches on a temporary list while holding dcache_lock and then hitting
them all with "it's going away" if ->i_nlink has hit zero?  You don't
need inode to be around for the last part - you only use it to find watches
in question.  And that can be done without any allocations...
