Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130882AbRCJCnE>; Fri, 9 Mar 2001 21:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130895AbRCJCmz>; Fri, 9 Mar 2001 21:42:55 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:54442 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130882AbRCJCmn>;
	Fri, 9 Mar 2001 21:42:43 -0500
Date: Fri, 9 Mar 2001 21:42:01 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: LA Walsh <law@sgi.com>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: (struct dentry *)->vfsmnt;
In-Reply-To: <3AA989B2.9CE8273E@sgi.com>
Message-ID: <Pine.GSO.4.21.0103092114420.17677-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Mar 2001, LA Walsh wrote:

[getting path by dentry]
> 	I'm getting it from various places, 1) if I want to know the
> path relative to the root of the dentry at the end of 'path_walk'
> or __user_path_walk (as used in truncate)  and

In that case you have nd->mnt and nd->dentry

> 2) If I've gotten a dentry as in sys_fchdir/fchown/fstat/newfstat 
> from a file descriptor and I want the absolute path or if multple

In that case you have file->f_vfsmnt and file->f_dentry

If you have the pair (mnt, dentry) - p = d_path(mnt, dentry, buf, buflen);
will put the path into buf and set p pointing to its beginning.

dentry alone is not enough - it simply doesn't describe a unique point
in the namespace. It does describe the unique point in the filesystem
tree, but that tree can occur in several places of the unified tree.
Thus the need of pair (vfsmount, dentry).

If you ever need to do someting like "let's find any vfsmount that
could go in pair with our dentry" - you are doing something wrong
(or I had missed something last Spring). Table below gives the
list of such pairs.
		vfsmount	dentry
file		->f_vfsmnt	->f_dentry
nameidata	->mnt		->dentry
swap component	->swap_vfsmnt	->swap_file
knfsd export	->exp_mnt	->exp_dentry
cwd		->pwdmnt	->pwd
root		->rootmnt	->root
emul.root	->altrootmnt	->altroot
mountpoint	->mnt_parent	->mnt_mountpoint

Does that cover your case?
						Cheers,
							Al

