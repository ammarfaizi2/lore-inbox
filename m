Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130733AbRCWMHb>; Fri, 23 Mar 2001 07:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130768AbRCWMHW>; Fri, 23 Mar 2001 07:07:22 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:51701 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130721AbRCWMHR>;
	Fri, 23 Mar 2001 07:07:17 -0500
Date: Fri, 23 Mar 2001 07:06:35 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Dave Kleikamp <shaggy@austin.ibm.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] sane access to per-fs metadata (was Re: [PATCH]
 Documentation/ioctl-number.txt)
In-Reply-To: <200103230600.f2N60CU07723@webber.adilger.int>
Message-ID: <Pine.GSO.4.21.0103230644541.8373-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Mar 2001, Andreas Dilger wrote:

> I look forward to seeing the ext2 code.  I was just in the process of
> adding ioctls to ext3 to do online resizing within transactions.  Maybe
> I'll rather use this interface if it looks good.  Will it work on 2.2,
> or does it depend too much on new VFS?

Should be OK, except that with 2.2 you'll need to get hold on dentry
from original fs instead of vfsmount (unfortunately, that can't be
done same way for both - 2.2 doesn't have vfsmount tree and in 2.4
holding dentry without holding vfsmount is a one-way ticket to hell -
umount() will be unhappy). However, version-dependent part should be
very small. Something like

struct superblock *grab_super(name, p)
char *name;
void **p;
{
	struct nameidata nd;
	int err = 0;
	*p = NULL;
	if (path_init(name, 0, &nd))
		err = path_walk(name, &nd);
	if (err)
		return ERR_PTR(err);
	*p = mntget(nd.mnt);
	path_release(&nd);
	return (*(struct vfsmount**)p)->mnt_sb;
}

for 2.4 and

struct superblock *grab_super(name, p)
char *name;
void **p;
{
	int err = 0;
	struct dentry *dentry;
	*p = NULL;
	dentry = lookup_dentry(name, NULL, 0);
	if (IS_ERR(dentry))
		return (struct super_block*)dentry;
	*p = dentry;
	return dentry->d_sb;
}

for 2.2 should do the trick -
	master_sb = grab_super(ext2root, &sb->u.ext2meta_sb.holder);
	if (IS_ERR(matser_sb))
		/* fail */
	sb->u.ext2meta_sb.master = master_sb;
	...
should be OK (to release the master sb you'll need to do dput() or mntput()
of sb->....holder in 2.2 and 2.4 resp., indeed). I wouldn't try to port
that to 2.0, though...
							Cheers,
								Al

