Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262823AbRFCKyK>; Sun, 3 Jun 2001 06:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262842AbRFCKyA>; Sun, 3 Jun 2001 06:54:00 -0400
Received: from hera.cwi.nl ([192.16.191.8]:58277 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262823AbRFCKxp>;
	Sun, 3 Jun 2001 06:53:45 -0400
Date: Sun, 3 Jun 2001 12:53:11 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106031053.MAA185287.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@math.psu.edu
Subject: Re: symlink_prefix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From viro@math.psu.edu Sun Jun  3 02:49:08 2001

    On Sun, 3 Jun 2001 Andries.Brouwer@cwi.nl wrote:

    > This evening I needed to work on a filesystem of a non-Linux OS,
    > full of absolute symlinks. After mounting the fs on /mnt, each
    > symlink pointing to /foo/bar in that filesystem should be
    > regarded as pointing to /mnt/foo/bar.
    > 
    > Since doing ls -ld on every component of every pathname was
    > far too slow, I made a small kernel wart, where a mount option
    > -o symlink_prefix=/pathname would cause /pathname to be prepended
    > in front of every absolute symlink in the given filesystem
    > (when the symlink is followed). That works satisfactorily.

    Absolute symlinks... Dunno. _If_ we want that at all, we probably
    want it on per-mountpoint basis. However, that opens a door to
    _really_ ugly feature requests. E.g. "if symlink starts with
    /foo - replace it with /mnt/bar, but if it starts with /foo/baz -
    replace with /mnt/splat instead".

Suppose I have devices /dev/a, /dev/b, /dev/c that contain the
/, /usr and /usr/spool filesystems for FOO OS. Now
	mount /dev/a /mnt -o symlink_prefix=/mnt
	mount /dev/b /mnt/usr -o symlink_prefix=/mnt
	mount /dev/c /mnt/usr/spool -o symlink_prefix=/mnt
suffice.
I do not immediately see a realistic use for changing symlink
contents halfway.

    I can see how to implement per-mountpoint variant. However, I'm
    less than enthusiastic about the API side of that and about the
    ugliness it will lead to. It smells like a wrong approach. And
    no, I don't see a good one right now.

    As for the API... How would you pass that option? Yet another
    mount(2) argument?

What I did was: add a field  `char *mnt_symlink_prefix;'  to the
struct vfsmount, fill it in super.c:add_vfsmnt(), use it in
namei.c:vfs_follow_link(). Pick the value up by recognizing
in super.c:do_mount() the option "symlink_prefix=" before
giving the options to the separate filesystems.

[One could start a subdiscussion about that part. The mount(2)
system call needs to transport vfs information and per-fs information.
So far, the vfs information used flag bits only, but sooner or later
we'll want to have strings, and need a vfs_parse_mount_options().
Indeed, many filesystems today have uid= and gid= and umask= options
that might be removed from the individual filesystems and put into vfs.
After all, such options are also useful for (foreign) ext2 filesystems.]


Andries
