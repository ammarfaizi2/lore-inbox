Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbVIUBCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbVIUBCA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 21:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbVIUBCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 21:02:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:30694 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750866AbVIUBB7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 21:01:59 -0400
Date: Wed, 21 Sep 2005 02:01:55 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Ray Lee <ray@madrabbit.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event under load
Message-ID: <20050921010154.GR7992@ftp.linux.org.uk>
References: <20050920045835.GE7992@ftp.linux.org.uk> <1127192784.19093.7.camel@vertex> <20050920051729.GF7992@ftp.linux.org.uk> <76677C3D-D5E0-4B5A-800F-9503DA09F1C3@tentacle.dhs.org> <20050920163848.GO7992@ftp.linux.org.uk> <1127238257.9940.14.camel@localhost> <Pine.LNX.4.58.0509201108120.2553@g5.osdl.org> <20050920182249.GP7992@ftp.linux.org.uk> <Pine.LNX.4.58.0509201234560.2553@g5.osdl.org> <1127256814.749.5.camel@vertex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127256814.749.5.camel@vertex>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 06:53:34PM -0400, John McCutchan wrote:
> Is there some reason we can't just do this from vfs_unlink
> 
> inode = dentry->inode;
> iget (inode);
> d_delete (dentry);
> fsnotify_inoderemove (inode);
> iput (inode);
> 
> This would allow us to have immediate event notification, and avoid a
> race with the inode going away, right?

Playing with references to struct inode means playing dirty tricks
behind the filesystem's back.  Doing that in a way that really changes
inode lifetime means asking for trouble.  Combined with a dirty trick
*already* pulled by sys_unlink() to postpone the final iput until after
we unlock the parent, it means breakage (and aforementioned dirty trick
took some rather interesting logics to compensate for in the first place).

Moreover, your suggestion would do that to _everyone_, whether they use
inotify or not.  NAK.

>  static inline void fsnotify_inoderemove(struct inode *inode)
>  {
> -	inotify_inode_queue_event(inode, IN_DELETE_SELF, 0, NULL);
> -	inotify_inode_is_dead(inode);
> +	inotify_inode_queue_event(inode, IN_DELETE_SELF, inode->i_nlink, NULL);
> +	if (inode->i_nlink == 0)
> +		inotify_inode_is_dead(inode);
>  }

Assumes that filesystem treats ->i_nlink on final iput() in usual way.
It doesn't have to.

BTW, what happens if one uses inotify on procfs?  Or sysfs, for that matter?
Fundamental problem with that sucker is that you are playing games with
lifetime rules of inodes in a way that might be OK for some filesystems,
but violates a lot of assumptions made by other...

BTW^2, what guarantees that inotify_unmount_inodes() will not happen while we
are in inotify_release()?  That would happily keep watch refcount bumped,
so it would outlive inotify_unmount_inodes().  Sure, it would be dropped.
And call iput() on a pinned inode that had outlived the umount().  Oops...
