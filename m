Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129845AbRBYWjo>; Sun, 25 Feb 2001 17:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129850AbRBYWjf>; Sun, 25 Feb 2001 17:39:35 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:13787 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129845AbRBYWjS>;
	Sun, 25 Feb 2001 17:39:18 -0500
Date: Sun, 25 Feb 2001 17:39:16 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Werner Almesberger <Werner.Almesberger@epfl.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][CFT] per-process namespaces for Linux
In-Reply-To: <20010225225750.B19635@almesberger.net>
Message-ID: <Pine.GSO.4.21.0102251702350.26808-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 25 Feb 2001, Werner Almesberger wrote:

> Alexander Viro wrote:
> > No kludges actually needed. "Simplified boot sequence" _is_ simplified -
> > we overmount the "final" root over ramfs. Initially empty. So you have
> > the normal environment when you load ramdisk, etc.
> 
> So is this the Holy Grail, err, union mount we've discussed about one year
> ago ? I.e.

No. Just an overmount. Final root ends up mounted atop of absolute root -
see comments in fs/super.c:mount_root() and in init/do_mounts.c

> stat foo	# output A
> mount /dev/whatever /
> stat foo	# output B
> 
> with A != B ?

We end with forced chroot to covering one. Due to details of path_walk()
it's unbreakable even for root (well, barring the direct access to
kernel data structures via /dev/kmem ;-)

So yes, you'll see the covering fs. Chech do_chroot() in init/do_mounts.c
 
> If yes, is there also a way to destroy/empty ramfs after this ?

At the end of boot process we are left with (at most) 8 dentries, 8 inodes and
no data pages on ramfs. Is it worth emptying? I can do that (reduce to
1 dentry/1 inode), just add sys_rmdir() and sys_unlink() calls in
the end of init/do_mounts.c:prepare_namespace(), but I don't really
see the point of it.

Fs _is_ covered - you don't get its objects after mouting the final root.

BTW, Werner - could you take a look at the prepare_namespace()/handle_initrd()?
That's our late boot process taken into one place. I'm really not happy
about the following:
	a) initrd with /linuxrc exec'ing init leaves init with PID > 1.
Is it a good idea? I've reproduced the behaviour we have in the main tree,
but I have a bad feeling about it. For one thing, init is killable that
way. Not good...
	b) can we _please_ kill the real_root_dev sysctl?
	c) you had plans for mandating non-exiting /linuxrc. What's the status
of these plans? I'd be glad if we could pull that one off... More than
half of handle_initrd() implements the behaviour for the case when /linuxrc
does exit and I would be only happy to remove that cruft. AFAICS both
RH and Debian have /linuxrc that _does_ exit, though...

Again, current patch reproduces the behaviour of the main tree. Every
boot setup that used to work should stay working - that was the design
goal. I want to, erm, concentrate the existing logics in one place
and make it readable before even thinking of changing behaviour.

I've tested it with all combinations that end up with root on local
fs (initrd or not, ramdisks from floppies, devfs mounted or not and
their combinations, with different variants of /linuxrc in cases that
did initrd).  I didn't do exhaustive testing for NFS-root. If someone
can find a setup that works with official tree and doesn't work with 
the patched one - yell. I consider that as a bug.

BTW, people with rootfs=... patches may find that in this variant
their patches would become _much_ simpler - they can actually call sys_mount()
to mount the final root.

Don't get me wrong - I would be glad to see both rootfs=... and tar patches
done atop of that namespace/s_lock (and archive them, keep up-to-date, put
on FTP, etc).  Just don't expect me to _merge_ them until their counterparts
get merged into the Linus' tree (or this patch ends up these, but that won't
happen until 2.5).

IOW, I consider the boot-process part of the patch as cleanup of
existing code. If it makes some experiments easier - great, but
in _that_ respect namespace patch is in permanent feature freeze.
Unless behaviour is accepted by Linus - it won't get merged.

							Cheers,
								Al

