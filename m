Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281740AbRKQVR2>; Sat, 17 Nov 2001 16:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281728AbRKQVRS>; Sat, 17 Nov 2001 16:17:18 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:54424 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S281719AbRKQVRE>; Sat, 17 Nov 2001 16:17:04 -0500
Date: Sat, 17 Nov 2001 14:16:59 -0700
Message-Id: <200111172116.fAHLGxS12195@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devfs v196 available
In-Reply-To: <Pine.LNX.4.33.0111162035180.29140-100000@serv>
In-Reply-To: <200111031747.fA3Hl0u19223@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.33.0111162035180.29140-100000@serv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel writes:
> On Sat, 3 Nov 2001, Richard Gooch wrote:
> 
> >   Hi, all. Version 196 of my devfs patch is now available from:
> 
> Some small comments:
> - You should consider to integrate devfs into the dcache (check e.g.
>   ramfs), currently you duplicate lots of infrastructure, which you get
>   for free (and faster) from the dcache. It would save you also lots of
>   locking.

That's something that I've already said I'm planning, but that's a 2.5
thing, and I'm waiting for the dcache to be split from the icache.
Even if the current, horribly bloated, struct inode is trimmed down by
removing that union, it will still be too big for my liking. Hence I
want the dcache/icache split.

> - you should delay the path generation in try_modload to the read
>   function, then you're not limited here in the pathname length and don't
>   have to abuse the stack.

Yep. Now that I've got the refcounting, I can do the thing I'm doing
with other events (a for loop to increment the refcounts before
returning) for the lookup event as well. In fact, it will allow me to
clean up the devfsd_read() code as well (I never liked that test for
the event type).

> - you should use "%.*s" if you want to print a dentry name (no need to
>   copy it).

Yep, good idea.

> - you should do something about the recursive calls, it's an
>   invitation to abuse them.

That's why I've tagged them as such. I've tried to keep their stack
usage low. Switching to a non-recursive algorithm has it's own
problems: it's a lot harder to understand, and it's much harder to get
right in the first place. Non-recursive algorithms are more fragile.

> - symlink/slave handling of tapes/disk/cdroms is maybe better done
>   in userspace.

No, because you want to be able to mount your root FS using
"root=/dev/cdroms/cdrom0", for example.

> - uid/gid in devfsd_buf_entry is 16 bit

Actually, it's uid_t and gid_t. Just like struct inode uses. When
these are increased to 32 bits, devfs will automatically be 32 bits
for these as well.

> - devfs is not a database! E.g. devfs has no business to store the
>   char/block device ops table. So devfs_get_ops is wrong here, the
>   same for devfs_[gs]et_info. devfs has to stay optional and
>   storing/retrieving certain device data should not be done in
>   different ways, this is only asking for trouble because of subtle
>   differences. The problem so far is that we have no [bc]dev_t,
>   where this info should be stored, but this hopefully changes early
>   2.5. So the path to get e.g. to the ops table should be "kdev_t ->
>   [bc]dev_t -> ops" and not "kdev_t -> search whole devfs tree -> no
>   ops" (because you missed manual dev nodes).

Again, you're talking about 2.5 stuff. If and when we get a decent
block device structure, I'll look at using that. It's questionable
whether we'll ever get a generic char device structure, since they're
all so different. So for char devices, the ops pointer should be kept
inside the devfs entry.

As for devfs_get_ops(), that has to stay until you can change over all
the SGI IA64 drivers, which (ab)use it heavily. API change-> 2.5.

> - the simple event mechanism looks prone to DOS attacks (even if all
>   races are gone). Events are too easily delayed or even
>   dropped. This makes the events unreliable and unsuitable for any
>   serious use.

I know about the dropped events: people with some ISDN cards get them,
as did I when I was testing my sd-many patch. That's been on my list
of things to fix, once the locking and refcounting was working. It was
planned to be a v1.1 fix:-)

> - in _devfs_make_parent_for_leaf you shouldn't simply return if
>   _devfs_append_entry fails, because someone else might have created
>   the directory since _devfs_descend.

Yes, I know. That too was planned to be a v1.1 improvement.

> Especially the first point is very important, this was even
> suggested by Linus already more than 3 years ago. devfs could be a
> very thin layer, but right now it's far bigger than it had to be.

Yeah, on more than one occasion I've stated that I'd love to rip out
all the tree management code in devfs. I'm waiting for VFS changes to
make that palatable. Don't think for a minute that v1.x (where x is
small) is my final vision of devfs. v1.x was supposed to be the
race-free version which did it's own tree management (v0.x being the
racy, development version prior to v1.0). And v2.0 is supposed to be
the lightweight-let-the-dcache-do-the-work version. I hope that 2.5
will see further VFS improvements.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
