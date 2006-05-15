Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWEOFuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWEOFuw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 01:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWEOFuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 01:50:52 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:7335 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932182AbWEOFuv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 01:50:51 -0400
Date: Mon, 15 May 2006 15:46:27 +1000
From: Nathan Scott <nathans@sgi.com>
To: David Howells <dhowells@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: [PATCH 02/14] NFS: Permit filesystem to perform statfs with a known root dentry [try #9]
Message-ID: <20060515054627.GB1490@frodo>
References: <20060510160123.9058.428.stgit@warthog.cambridge.redhat.com> <20060510160111.9058.55026.stgit@warthog.cambridge.redhat.com> <25979.1147431096@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25979.1147431096@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Fri, May 12, 2006 at 11:51:36AM +0100, David Howells wrote:
> 
> The attached patch gives the statfs superblock operation a vfsmount pointer
> rather than a superblock pointer.
> 
> This complements the get_sb() patch.  That reduced the significance of
> sb->s_root, allowing NFS to place a fake root there.  However, NFS does require
> a dentry to use as a target for the statfs operation.  This permits the root in
> the vfsmount to be used instead.
> ...
>  	int (*sync_fs)(struct super_block *sb, int wait);
>  	void (*write_super_lockfs) (struct super_block *);
>  	void (*unlockfs) (struct super_block *);
> -	int (*statfs) (struct super_block *, struct kstatfs *);
> +	int (*statfs) (struct vfsmount *, struct kstatfs *);
>  	int (*remount_fs) (struct super_block *, int *, char *);
>  	void (*clear_inode) (struct inode *);
>  	void (*umount_begin) (struct super_block *);

I know this has come up before, and I'm sure it'll come up again
at some point unless we fix it now - could we pass the dentry down
here instead, pretty please?

Miklos asked for it here (and last I spoke to him, he was still
keen on having this available, and his questions on how to do
this cleanly some other way seem to have gone unanswered):
http://www.ussg.iu.edu/hypermail/linux/kernel/0510.3/0234.html

We could now use it in XFS too, hence my interest.  We have some
functionality for managing space of a "project" (XFS concept, bit
of a holdover from IRIX thats found new legs recently) within a
filesystem, that provides for dynamically resizable chunks of
space to be carved off of the total filesystem space for these
individual "projects", such that individual projects can be set
space limits (i.e. they are limited to how much space they can
use from the entire filesystem), and we can also report on used
space at a "project" level.

This is done by maintaining project identifiers for every inode in
the tree, with the project identifier being inherited for new nodes
(hardlinks and renames in a project tree are handled as if it were
a separate filesystem, i.e. they're not allowed, EXDEV) and then
using quota by project ID (as opposed to uid/gid) to account and
enforce.

[ Example:  we have media customers who want to be able to manage
a single large filesystem on top of a honking big RAID (one fs is
alot easier to backup and administer in general than hundreds...),
but who have multiple groups of artists working on a number of
different films at once.
What they want is to be able to set aside a fixed amount of space
based on an individual films needs, then export that path via NFS,
and later reclaim that space for the next one once the project is
done, but also have the flexibility to easily increase space for a
project when urgently needed <*knock,knock*  Ah, Mr Spielberg, how
are you?  Yes, sir, right away>.  All of this becomes excruciating
when we're forced to work at the volume manager level, of course,
which is where this would otherwise have to be done. ]

This is implemented in XFS and has been merged for awhile now, but
currently the interface for querying free/used space is clunky -
internally XFS is using the quota subsystem to implement this, so
quotactl(2) it is, then there's custom tools, etc.  And it is not
exactly a seamless integration with NFS and CIFS, unfortunately,
which we'd really like to provide.

If the VFS passed on the dentry that we have at the statfs syscall
(or from the NFS call, or wherever) we could more cleanly report, in
a way the user expects, on the space used within that project (yes,
I'm aware of the df walking-back-up-to-what-it-thinks-the-root-is
issue, but I also agree with Miklos that its easy to fix).

Anyway, that's why we need it.  Miklos gave his sshfs case (see above
link), so it looks like its definately useful in multiple contexts.
And now it sounds like you could use it too (unless there's other
reasons for needing a vfsmount instead of dentry?  If I understand the
initial patch description of yours above, it sounds like the dentry
would suffice for you, is that right?).  Also, it's not like passing
around a vfsmount is particularly easy, as we can see in this snippet
(and elsewhere) from your patch...

>  ...
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>  ...
>  int
>  nfsd_statfs(struct svc_rqst *rqstp, struct svc_fh *fhp, struct kstatfs *stat)
>  {
> +	struct vfsmount mnt;
> +
>  	int err = fh_verify(rqstp, fhp, 0, MAY_NOP);
> -	if (!err && vfs_statfs(fhp->fh_dentry->d_inode->i_sb,stat))
> -		err = nfserr_io;
> +	if (!err) {
> +		memset(&mnt, 0, sizeof(mnt));
> +
> +		mnt.mnt_sb = fhp->fh_dentry->d_inode->i_sb;
> +		mnt.mnt_root = mnt.mnt_sb->s_root;
> +		mnt.mnt_mountpoint = mnt.mnt_root;
> +
> +		if (vfs_statfs(&mnt, stat))
> +			err = nfserr_io;
> +	}
>  	return err;

Yuhuuuuck!

So, passing the dentry would actually seem to provide you a cleaner
implementation too.  You'd also not need to propogate that mount.h
#include into all those other files which otherwise don't need it.

cheers.

-- 
Nathan
