Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319559AbSIHCjK>; Sat, 7 Sep 2002 22:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319560AbSIHCjK>; Sat, 7 Sep 2002 22:39:10 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:11392 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S319559AbSIHCjJ>;
	Sat, 7 Sep 2002 22:39:09 -0400
Date: Sat, 7 Sep 2002 22:43:46 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Daniel Phillips <phillips@arcor.de>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Question about pseudo filesystems
In-Reply-To: <20020908032121.A23455@kushida.apsleyroad.org>
Message-ID: <Pine.GSO.4.21.0209072232500.23664-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 8 Sep 2002, Jamie Lokier wrote:

> Alexander Viro wrote:
> > It is neither safe nor needed.  Please, look at the previous posting again -
> > neither variant calls mntput() in ->release().
> > 
> > Now, __fput() _does_ call mntput() - always.  And yes, if that happens to
> > be the final reference - it's OK.
> 
> Thanks, that's really nice.
> 
> I'd assumed `kern_mount' was similar to mounting a normal filesystem,
> but in a non-existent namespace.  Traditionally in unix you can't
> unmount a filesystem when its in use, and mounts don't disappear when
> the last file being used on them disappears.
> 
> But you've rather cutely arranged that these kinds of mount _do_
> disappear when the last file being used on them disappears.  Clever, if
> a bit disturbing.

Normal mount _is_ do_kern_mount() + pinning down the resulting vfsmount +
attaching it to mountpoint.

The second part is what keeps them alive until fs is unmounted.  Moreover,
umount itself is just
	check refcount, return -EBUSY if the thing is busy and MNT_DETACH is
not given.
	detach from mountpoint
	drop the reference

Notice that umount _with_ MNT_DETACH will happily skip that check - and
that will simply detach filesystem from mountpoint with fs shutdown
postponed until it stops being busy.

IOW, filesystem shutdown is _always_ a garbage collection - there's nothing
special about vfsmounts that are not mounted somewhere.  Check for fs
being busy in umount(2) is just a compatibility code - kernel is perfectly
happy with dissolving mountpoints, busy or not.  If stuff mounted is not
busy it will be shut down immediately, if not - when it stops being busy.

It's actually very similar to relation between open(), unlink() and close() -
you can unlink opened files and their contents will be there until the
final close(); then it will be killed.

