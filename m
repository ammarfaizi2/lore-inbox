Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279860AbRKRQBc>; Sun, 18 Nov 2001 11:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279891AbRKRQBX>; Sun, 18 Nov 2001 11:01:23 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:21258 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S279860AbRKRQBS>; Sun, 18 Nov 2001 11:01:18 -0500
Message-ID: <3BF7DB34.ED578280@linux-m68k.org>
Date: Sun, 18 Nov 2001 17:00:52 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devfs v196 available
In-Reply-To: <200111031747.fA3Hl0u19223@vindaloo.ras.ucalgary.ca>
		<Pine.LNX.4.33.0111162035180.29140-100000@serv> <200111172116.fAHLGxS12195@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Richard Gooch wrote:

> That's something that I've already said I'm planning, but that's a 2.5
> thing, and I'm waiting for the dcache to be split from the icache.
> Even if the current, horribly bloated, struct inode is trimmed down by
> removing that union, it will still be too big for my liking. Hence I
> want the dcache/icache split.

Why not do it the other way around? Such a change would require changes
to all filesystems. If devfs would already make better use of existing
infrastructure, it would be far easier to take the needs of devfs into
account, instead of trying to fit it in later. A nice side effect would
be people could help with the conversion.

> > - you should do something about the recursive calls, it's an
> >   invitation to abuse them.
> 
> That's why I've tagged them as such. I've tried to keep their stack
> usage low. Switching to a non-recursive algorithm has it's own
> problems: it's a lot harder to understand, and it's much harder to get
> right in the first place. Non-recursive algorithms are more fragile.

_devfs_walk_path: There is already nicely working code in fs/namei.c.
unregister: you can easily go back with the parent pointer.
find_by_dev: this is just wrong (see below)

> > - symlink/slave handling of tapes/disk/cdroms is maybe better done
> >   in userspace.
> 
> No, because you want to be able to mount your root FS using
> "root=/dev/cdroms/cdrom0", for example.

That's about the only use of it at boot time and can be achieved easier.

> Again, you're talking about 2.5 stuff. If and when we get a decent
> block device structure, I'll look at using that.

The correct interface in 2.4 is get_blkfops. devfs has to use it like
everyone else.

> It's questionable
> whether we'll ever get a generic char device structure, since they're
> all so different. So for char devices, the ops pointer should be kept
> inside the devfs entry.

No, find_by_dev is just wrong, scanning a whole tree for a specific
information is broken. Timing is absolutely unpredictable and prone to
abuse. The current implementation can even return wrong information.
The correct place to store char device info is fs/char_dev.c.

> As for devfs_get_ops(), that has to stay until you can change over all
> the SGI IA64 drivers, which (ab)use it heavily. API change-> 2.5.

If it depends on devfs, it's simply broken and must be fixed, that has
nothing to do with the API.

> Yeah, on more than one occasion I've stated that I'd love to rip out
> all the tree management code in devfs. I'm waiting for VFS changes to
> make that palatable.

Do the changes now and you can push the responsibility to VFS, but the
last you should do is to maintain bloat.

bye, Roman
