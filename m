Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311147AbSCHV24>; Fri, 8 Mar 2002 16:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311146AbSCHV2r>; Fri, 8 Mar 2002 16:28:47 -0500
Received: from gateway2.ensim.com ([65.164.64.250]:31493 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S311136AbSCHV2d>; Fri, 8 Mar 2002 16:28:33 -0500
X-mailer: xrn 8.03-beta-26
From: Paul Menage <pmenage@ensim.com>
Subject: Re: [PATCH] 2.5.6-pre3 Fast Walk Dcache
To: Hanna Linder <hannal@us.ibm.com>
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org, pmenage@ensim.com
X-Newsgroups: 
In-Reply-To: <0C01A29FBAE24448A792F5C68F5EA47D2260CB@nasdaq.ms.ensim.com>
Message-Id: <E16jRuZ-00076W-00@pmenage-dt.ensim.com>
Date: Fri, 08 Mar 2002 13:28:23 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In article <0C01A29FBAE24448A792F5C68F5EA47D2260CB@nasdaq.ms.ensim.com>,
you write:
>
>Changed path_lookup to hold the dcache_lock instead of incrementing the 
>d_count reference counter while walking the path as long as the desired 
>dentry's are found in the dcache. Dave Olien wrote permission_exec_lite. 
>These ideas came from Al Viro to decrease cacheline bouncing.

Some points:

1) You're missing parentheses in cached_lookup_nd() and path_lookup():

	if(!nd->flags & LOOKUP_LOCKED)
		return cached_lookup(nd->dentry, name, flags);

...

	if (!nd->flags & LOOKUP_LOCKED)
		dput(nd->dentry);


! binds closer than binary &, so the tests will never be true (and gcc
probably optimises the entire tests/calls away).

2) Since cached_lookup_nd() calls __d_lookup() and hence
__dget_locked(), it's not clear how you actually avoid incrementing the
d_count values of the dentries, other than the root/cwd dentries. Can
you explain the logic in a little more detail?

e.g. if you do path_lookup("/usr/bin", 0, nd), this translates into
(substituting names for dentries for readability ...)

path_walk("/usr/bin", nd)
  cached_lookup("/", "usr", LOOKUP_CONTINUE)
    __d_lookup("/", "usr")
      __dget_locked("/usr")
        atomic_inc(&"/usr"->d_count)

3) If you replace walk_init_root() and path_lookup() with something
like the following, you can pull the ugliness of walk_init_root() out
of path_lookup(). Basically, make walk_init_root() recognise
LOOKUP_LOCKED and take the dcache_lock rather than grabbing refcounts. 
walk_init_root() drops the LOOKUP_LOCKED flag if necessary while
calling __emul_lookup_dentry() to avoid additional complexity. If
walk_init_root() returns 0, then the dcache lock wasn't taken,
regardless of whether the nd.flags had LOOKUP_LOCKED set.

static inline int
walk_init_root(const char *name, struct nameidata *nd)
{
	unsigned int flags = nd->flags;
	read_lock(&current->fs->lock);
	if (current->fs->altroot && !(nd->flags & LOOKUP_NOALT)) {

		if(flags & LOOKUP_LOCKED)
			nd->flags &= ~LOOKUP_LOCKED;

		nd->mnt = mntget(current->fs->altrootmnt);
		nd->dentry = dget(current->fs->altroot);
		read_unlock(&current->fs->lock);
		if (__emul_lookup_dentry(name,nd))
			return 0;

		if(flags & LOOKUP_LOCKED) 
			nd->flags = flags;

		read_lock(&current->fs->lock);
	}
	nd->mnt = current->fs->rootmnt;
	nd->dentry = current->fs->root;
	if(flags & LOOKUP_LOCKED) {
		read_lock(&dcache_lock);
	} else {
		mntget(nd->mnt);
		dget(nd->dentry);
	}
	read_unlock(&current->fs->lock);
	return 1;
}

...

int path_lookup(const char *name, unsigned int flags, struct nameidata
*nd)
{
	nd->last_type = LAST_ROOT; /* if there are only slashes... */
	nd->flags = flags | LOOKUP_LOCKED;
	if (*name=='/'){
		if(!walk_init_root(name, nd)) 
			return 0;
	} else{
		read_lock(&current->fs->lock);
		spin_lock(&dcache_lock);
		nd->mnt = current->fs->pwdmnt;
		nd->dentry = current->fs->pwd;
		read_unlock(&current->fs->lock);
	}
	return (path_walk(name, nd));
}

Paul
