Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319470AbSIGLxi>; Sat, 7 Sep 2002 07:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319473AbSIGLxi>; Sat, 7 Sep 2002 07:53:38 -0400
Received: from dsl-213-023-038-028.arcor-ip.net ([213.23.38.28]:41912 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319470AbSIGLxh>;
	Sat, 7 Sep 2002 07:53:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Question about pseudo filesystems
Date: Sat, 7 Sep 2002 14:00:51 +0200
X-Mailer: KMail [version 1.3.2]
References: <20020904190225.A13448@kushida.apsleyroad.org>
In-Reply-To: <20020904190225.A13448@kushida.apsleyroad.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17neGi-0006Sv-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 September 2002 20:02, Jamie Lokier wrote:
> I have a small problem with a module I'm writing.  It uses a
> pseudo-filesystem, rather like futexes and pipes, so that it can hand
> out special file descriptors on request.
> 
> Following the examples of pipe.c and futex.c, but specifically for a 2.4
> kernel, I'm doing this:
> 
> 	static DECLARE_FSTYPE (mymod_fs_type, "mymod_fs",
> 			       mymod_read_super, FS_NOMOUNT);
> 
> 
> 	static int __init mymod_init (void)
> 	{
> 		int err = register_filesystem (&mymod_fs_type);
> 		if (err)
> 			return err;
> 		mymod_mnt = kern_mount (&mymod_fs_type);
> 		if (IS_ERR (mymod_mnt)) {
> 			unregister_filesystem (&mymod_fs_type);
> 			return PTR_ERR (mymod_mnt);
> 		}
> 	}
> 
> 	static void __exit mymod_exit (void)
> 	{
> 		mntput (mymod_mnt);
> 		unregister_filesystem (&mymod_fs_type);
> 	}
> 
> Unfortunately, when I come to _unload_ the module, it can't be unloaded
> because the kern_mount increments the module reference count.
> 
> (pipe.c in 2.4 appears to have the same problem, but of course nobody
> can ever unload it anyway so it doesn't matter).
> 
> I'm handing out file descriptors rather like futexes from 2.5: they all
> share the same dentry, which is the root of the filesystem.  In my
> code's case, that dentry is created in `mymod_read_super' (just the same
> way as 2.4 pipe.c).
> 
> Somehow, it looks like I need to mount the filesystem when it first
> generates an fd, and unmount it when the last fd is destroyed -- but is
> it safe to unmount the filesystem _within_ a release function of an
> inode on the filesystem?
> 
> Either that, or I need something else.

It's a good example of why the module interface is stupidly wrong, and
__exit needs to be called by the module unloader, returning 0 if it's
ok to unload.  Then your __exit can whatever condition it's interested
in and, if all is well, do the kern_umount.

-- 
Daniel
