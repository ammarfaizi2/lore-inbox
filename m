Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318240AbSIOUHS>; Sun, 15 Sep 2002 16:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318242AbSIOUHS>; Sun, 15 Sep 2002 16:07:18 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:56721 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S318240AbSIOUHR>; Sun, 15 Sep 2002 16:07:17 -0400
Message-Id: <200209152012.g8FKC0Ic208648@pimout2-ext.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Alexander Viro <viro@math.psu.edu>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>
Subject: Moving a mount point (was Re: Question about pseudo filesystems)
Date: Sat, 14 Sep 2002 21:41:45 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Daniel Phillips <phillips@arcor.de>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
References: <Pine.GSO.4.21.0209072232500.23664-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0209072232500.23664-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 September 2002 10:43 pm, Alexander Viro wrote:

> IOW, filesystem shutdown is _always_ a garbage collection - there's nothing
> special about vfsmounts that are not mounted somewhere.  Check for fs
> being busy in umount(2) is just a compatibility code - kernel is perfectly
> happy with dissolving mountpoints, busy or not.  If stuff mounted is not
> busy it will be shut down immediately, if not - when it stops being busy.

This wanders into something I've been trying to figure out for a while now.

I want to move an existing mount point.  I can't unmount it, because it's got 
a file open in it, but I want to move it to another binding in the tree and 
make the original binding go away so the filesystem IT'S under can go away.  
I can create a duplicate binding, but can't get the first binding to go away 
while the filesystem's in use.

In case you're curious, the reason is I created a system where the whole root 
partition is a zisofs image, with /boot, /etc, /root, and /tmp symlinks to 
directories under /var.  When the system is fully up, /var will be a mount 
point for /dev/hda1 (ext3), and /home on /dev/hda3.  / is loopback mounted 
from a file ("firmware") under /var.

To make this work, I make an initrd, which mounts /dev/hda1 on /var, does an 
losetup on /dev/loop0, exits and lets the boot continue (with root on 
/dev/loop0), and then runs /sbin/init-first which does a mount --bind 
/initrd/var to /var (duplicating the mount point), and then "exec 
/sbin/init", and life goes on.  (Obviously, init-first has to run before init 
or else /etc is a symlink pointing to nothing.  Haven't cleaned up /etc 
enough that it can be read-only, not sure I ever will...)

The downside of duplicating the binding in init-first rather than moving it 
is I can't unmount /initrd and free its memory.  It's not a major burning 
issue keeping me awake at night (caffiene manages to do that quite well on 
its own, thank you), it's just two extra mount entries in /proc/mounts and 
about four megabytes of wasted ram on a system with a quarter gig of the 
stuff, but it seems there should be a way to do this...

Since each filesystem only has one superblock (regardless of the number of 
mount points), there's no way it can care too deeply about where it's 
mounted.  The losetup really shouldn't care too much either (fundamentally, 
it's bound to an inode).  So there's no theoretical reason "mount --move /old 
/new" couldn't be made to work.  There may need to be a loop to flush 
dentries, and some locking, but that would be about it.  (Mount points under 
the mount point being moved could either be moved as well, or the action 
could be denied if any exist.  The first is cleaner, it's sort of the 
opposite of chroot or pivot_root.  P.S.  yes, I tried a few variants of 
pivot_root, that fails if either of the filesystems has any files open in 
it...)

It could just be that since the concept of mount point and filesystem 
instance were only separated in 2.4, that this is just a historical relic.  
If so, I'd like to correct it.  A filesystem instance can't go away with an 
open file, but a mount point can...

Did I miss the ability to do this already, or are the userspace tools simply 
not taking advantage of something the kernel can currently do, or I need to 
come up with a patch to make this work under the 2.4 kernel?  (I've poked 
around a bit, and vfs.txt does a pretty good job of describing how things 
were in 2.1.99, back when mount points and filesystem instances were the same 
thing...)

Rob

