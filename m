Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319481AbSIGNb5>; Sat, 7 Sep 2002 09:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319485AbSIGNb5>; Sat, 7 Sep 2002 09:31:57 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:34697 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S319481AbSIGNbz>;
	Sat, 7 Sep 2002 09:31:55 -0400
Date: Sat, 7 Sep 2002 09:36:26 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Daniel Phillips <phillips@arcor.de>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Question about pseudo filesystems
In-Reply-To: <E17neGi-0006Sv-00@starship>
Message-ID: <Pine.GSO.4.21.0209070858380.21690-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 7 Sep 2002, Daniel Phillips wrote:

> On Wednesday 04 September 2002 20:02, Jamie Lokier wrote:
> > I have a small problem with a module I'm writing.  It uses a
> > pseudo-filesystem, rather like futexes and pipes, so that it can hand
> > out special file descriptors on request.
> > 
> > Following the examples of pipe.c and futex.c, but specifically for a 2.4
> > kernel, I'm doing this:
> > 
> > 	static DECLARE_FSTYPE (mymod_fs_type, "mymod_fs",
> > 			       mymod_read_super, FS_NOMOUNT);
> > 
> > 
> > 	static int __init mymod_init (void)
> > 	{
> > 		int err = register_filesystem (&mymod_fs_type);
> > 		if (err)
> > 			return err;
> > 		mymod_mnt = kern_mount (&mymod_fs_type);
> > 		if (IS_ERR (mymod_mnt)) {
> > 			unregister_filesystem (&mymod_fs_type);
> > 			return PTR_ERR (mymod_mnt);
> > 		}
> > 	}
> > 
> > 	static void __exit mymod_exit (void)
> > 	{
> > 		mntput (mymod_mnt);
> > 		unregister_filesystem (&mymod_fs_type);
> > 	}
> > 
> > Unfortunately, when I come to _unload_ the module, it can't be unloaded
> > because the kern_mount increments the module reference count.
> > 
> > (pipe.c in 2.4 appears to have the same problem, but of course nobody
> > can ever unload it anyway so it doesn't matter).
> > 
> > I'm handing out file descriptors rather like futexes from 2.5: they all
> > share the same dentry, which is the root of the filesystem.  In my
> > code's case, that dentry is created in `mymod_read_super' (just the same
> > way as 2.4 pipe.c).
> > 
> > Somehow, it looks like I need to mount the filesystem when it first
> > generates an fd, and unmount it when the last fd is destroyed -- but is
> > it safe to unmount the filesystem _within_ a release function of an
> > inode on the filesystem?
> > 
> > Either that, or I need something else.

You need something else - namely, you need the code to follow the semantics
you want for the lifetime of that beast.

If your rules are "it's pinned as long as there are opened files created
by foo()" - very well, there are two variants.  The basic idea is the same
- have sum of ->mnt_count for all vfsmounts of our type bumped whenever we
call foo() and drop whenever final fput() is done on a file created by foo().

1) Trivial variant:
in foo() have
	file->f_vfsmnt = do_kern_mount(...);
	file->f_dentry = dget(file->f_vfsmnt->mnt_root);
and lose kern_mount() in init

2) Slightly optimized one:

spinlock_t lock;
int count;
struct vfsmount *mnt;

in foo()
	p = NULL;
	spin_lock(&lock);
	if (!count++) {
		/* slow path */
		count--;
		spin_unlock(&lock);
		p = do_kern_mount(...);
		spin_lock(&lock);
		if (!count++)
			mnt = p;
	}
	mntget(mnt);
	spin_unlock(&lock);
	mntput(p);
	file->f_vfsmnt = mnt;
	file->f_dentry = dget(mnt->mnt_root);

and in ->release() for these files
	spin_lock(&lock);
	if (!--count)
		mnt = NULL;
	spin_unlock(&lock);
(and lose kern_mount() in init, again)

In both variants destruction of superblock is triggered by final fput() -
upon mntput(file->f_vfsmnt); the difference being that (b) takes some
care to avoid allocation of new vfsmounts if we already have one pinned
down by opened file - whether that optimization is worth the trouble depends
on intended use.

> It's a good example of why the module interface is stupidly wrong, and
> __exit needs to be called by the module unloader, returning 0 if it's
> ok to unload.  Then your __exit can whatever condition it's interested
> in and, if all is well, do the kern_umount.

BS.  Instead of playing silly buggers with "oh, we will start exiting
and maybe we'll bail out, let's just hope we won't find that we want
to do that after we'd destroyed something" you need to decide what kind
of rules you really want for the module lifetime.  The rest is trivial.
Again, variant (a) (which is absolutely straightforward - add one line
in foo(), modify one line in foo(), delete one line in init) is enough
to give the desired rules.  Optimizing it if needed is not too hard -
see (b) for one possible variant...

