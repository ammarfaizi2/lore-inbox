Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSIDR7G>; Wed, 4 Sep 2002 13:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313113AbSIDR7F>; Wed, 4 Sep 2002 13:59:05 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:10893 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S313305AbSIDR7F>; Wed, 4 Sep 2002 13:59:05 -0400
Date: Wed, 4 Sep 2002 19:02:25 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Alex Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Question about pseudo filesystems
Message-ID: <20020904190225.A13448@kushida.apsleyroad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a small problem with a module I'm writing.  It uses a
pseudo-filesystem, rather like futexes and pipes, so that it can hand
out special file descriptors on request.

Following the examples of pipe.c and futex.c, but specifically for a 2.4
kernel, I'm doing this:

	static DECLARE_FSTYPE (mymod_fs_type, "mymod_fs",
			       mymod_read_super, FS_NOMOUNT);


	static int __init mymod_init (void)
	{
		int err = register_filesystem (&mymod_fs_type);
		if (err)
			return err;
		mymod_mnt = kern_mount (&mymod_fs_type);
		if (IS_ERR (mymod_mnt)) {
			unregister_filesystem (&mymod_fs_type);
			return PTR_ERR (mymod_mnt);
		}
	}

	static void __exit mymod_exit (void)
	{
		mntput (mymod_mnt);
		unregister_filesystem (&mymod_fs_type);
	}

Unfortunately, when I come to _unload_ the module, it can't be unloaded
because the kern_mount increments the module reference count.

(pipe.c in 2.4 appears to have the same problem, but of course nobody
can ever unload it anyway so it doesn't matter).

I'm handing out file descriptors rather like futexes from 2.5: they all
share the same dentry, which is the root of the filesystem.  In my
code's case, that dentry is created in `mymod_read_super' (just the same
way as 2.4 pipe.c).

Somehow, it looks like I need to mount the filesystem when it first
generates an fd, and unmount it when the last fd is destroyed -- but is
it safe to unmount the filesystem _within_ a release function of an
inode on the filesystem?

Either that, or I need something else.

Thanks,
-- Jamie

