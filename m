Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262877AbRFCL0A>; Sun, 3 Jun 2001 07:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262885AbRFCLZk>; Sun, 3 Jun 2001 07:25:40 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:49302 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262877AbRFCLZ3>;
	Sun, 3 Jun 2001 07:25:29 -0400
Date: Sun, 3 Jun 2001 07:25:25 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: symlink_prefix
In-Reply-To: <UTC200106031053.MAA185287.aeb@vlet.cwi.nl>
Message-ID: <Pine.GSO.4.21.0106030703590.27673-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 3 Jun 2001 Andries.Brouwer@cwi.nl wrote:

> What I did was: add a field  `char *mnt_symlink_prefix;'  to the
> struct vfsmount, fill it in super.c:add_vfsmnt(), use it in
> namei.c:vfs_follow_link(). Pick the value up by recognizing
> in super.c:do_mount() the option "symlink_prefix=" before
> giving the options to the separate filesystems.
> 
> [One could start a subdiscussion about that part. The mount(2)
> system call needs to transport vfs information and per-fs information.
> So far, the vfs information used flag bits only, but sooner or later
> we'll want to have strings, and need a vfs_parse_mount_options().
> Indeed, many filesystems today have uid= and gid= and umask= options
> that might be removed from the individual filesystems and put into vfs.
> After all, such options are also useful for (foreign) ext2 filesystems.]

_Please_, if we do anything of that kind - let's use a new syscall.
Ideally, I'd say
	fs_fd = open("/fs/ext2", O_RDWR);
	/* error -> no such filesystem */
	write(fs_fd. "/dev/sda1", strlen("/dev/sda1"));
	/* error handling */
	write(fs_fd, "reserve=5", strlen(....));
	...
	dir = open("/usr/local", O_DIRECTORY);
	/* error handling */
	new_mount(dir, MNT_SET, fs_fd);	/* closes dir and fs_fd */
	/* error handling */

First open gives you a new channel. Preferably - wit datagram semantics (i.e.
write() boundaries are preserved). Then you convince fs driver to give you
fs. Then you mount it.

Notice that all cruft with "mount ncpfs and then use ioctls to authenticate"
goes away - authentication happens before you mount. Parsers are also easier
that way. Moreover, seeing what filesystem types are available is also trivial,
etc. We need only one special case - mounting that fstypefs. Fine, let's
make new_mount(dir, MNT_TYPES) do that.

BTW, bind and friends are also easy - it's
	what = open(old, 0);
	where = open(mountpoint, 0);
	new_mount(where, MNT_BIND, what);

Comments?

