Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261381AbSJMALk>; Sat, 12 Oct 2002 20:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261382AbSJMALk>; Sat, 12 Oct 2002 20:11:40 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:12188 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S261381AbSJMALi>; Sat, 12 Oct 2002 20:11:38 -0400
Date: Sat, 12 Oct 2002 18:17:15 -0600
Message-Id: <200210130017.g9D0HFM26892@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] killing DEVFS_FL_AUTO_OWNER
In-Reply-To: <Pine.GSO.4.21.0210061550100.25699-100000@weyl.math.psu.edu>
References: <200210061932.g96JW3527255@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0210061550100.25699-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> On Sun, 6 Oct 2002, Richard Gooch wrote:
> > Well, I can't comment on the video1394 driver. I don't really know why
> > they are using DEVFS_FL_AUTO_OWNER. If their device node is safe to
> > have rw-rw-rw- (like with PTY slaves), then it's not a problem.
> > However, if the driver allows you to do Bad Things[tm] if you can read
> > or write to the device node, then the driver is buggy, and is abusing
> > DEVFS_FL_AUTO_OWNER.
> > 
> > So we should get input from the driver maintainer as to what the
> > intent is.

Before you get upset about my reply, bear in mind that the following
discussion is mostly irrelevant, since DEVFS_FL_AUTO_OWNER is no
longer being used for BSD PTY slaves.

> 1) current implementation does _not_ reset uid/gid after the first
> open().  It either stays as it was (until the d_delete) or gets
> reset to root.root.666 (after d_delete) and stays that way.

The uid/gid isn't supposed to reset after the first open(). It's
supposed to reset after the last close() (or soon after). The intended
semantics of DEVFS_FL_AUTO_OWNER as quite simple: hand ownership of
the node to the opening process, which will then do a chmod(2) to
obtain the desired permissions (which are usually rw-------). The
process will receive EPERM if someone else opens the same device at
the same time and wins the race.

Once the "owning" process closes the device, it will soon be restored
to root.root rw-rw-rw-, allowing another process to open the device.

> Notice that your code that sets it is in the very end of
> devfs_open() - in the part that is run once.  df->open is never
> reset, so...

Actually, it *is* reset, in devfs_d_delete().

> Oh, BTW - you have
> 
> 	if (df->open) return 0;
> 	df->open = TRUE;
> 
> with no locking whatsoever - you'd reduced BKL-covered area so that
> it doesn't cover that place.  With obvious consequences...

It doesn't really matter, because the worst that will happen is that a
process open(2)s the node, but some other process manages to get
ownership. For the intended use (allowing the user to set BSD PTY
slave permissions to rw------- rather than the normal rw-rw-rw-) this
is fine. The situation is no worse than a non-devfs system where a
non-privileged process cannot ever lock down the permissions on its
BSD PTY slave. With DEVFS_FL_AUTO_OWNER, said process can.

> 2) either applications do care to do chmod/chown (and in that case
> DEVFS_FL_AUTO_OWNER is simply irrelevant), or they are
> 	* broken on non-devfs systems
> 	* broken on devfs systems due to (1)

I do: "chmod go= `tty`" in my login scripts, just to prevent funny
buggers from sending crap to my login session. I don't always have
permission to do this (depending on the system), but where I do, it's
a plus. So the intended application doesn't depend on this, but takes
advantage of it.

I do agree that depending on it is non-portable, though.

> Having world-readable video camera is an obvious security problem,
> so applications _must_ deal with that, for non-devfs systems if
> nothing else.

Agreed, and I can't see why the driver author did this.

> 3) this crap is the only thing that still uses DEVFS_FL_AUTO_OWNER.
> 
> IOW, we should remove it and send heads-up to driver authors.  End
> of story.

That's fine by me too. I might have coded up a patch for it by now,
but my box has been busy the last few hours doing a rsync (scanning
the ChangeSet information seems to be the main offender, even though I
have a gig of RAM:-(). I'll start on this once my repository is
unlocked again.

> Another thing: when you do devfs_register(), the thing creates
> intermediate directories.  However, devfs_unregister() on the same
> node doesn't undo the effect of devfs_register() - directories stay
> around, even if nothing else holds them.
> 
> Proposal: add a counter to devfs entries of directories so that
> 	* result of devfs_mk_dir would have it set to 1
> 	* creation of child in a directory would increment it by 1
> 	* removal of child would decrement it by 1
> 	* when counter drops to 0 (which means that directory had
> been created implictly by devfs_register() and all children are gone)
> we unregister directory.  That, in turn, can cause unregistering its
> parent, etc.

Hm. I'll have to think about this some more, but offhand I'm not happy
about the potential interactions with devfs_get()/devfs_put(). If a
driver grabs hold of an intermediate directory and removes the child,
the directory it has a hold of is no longer part of the tree. This
could cause problems for some people (I've always rejected a
devfs_move(), but I know there are people who have implemented it
themselves). A sequence like:
	devfs_get_handle ();
	devfs_unregister ();
	devfs_register ();

would now fail. People would have to recode to:
	devfs_get_handle ();
	devfs_register ();
	devfs_unregister ();

> That would cut down the amount of work done in drivers (esp. block
> device drivers) and allow to simplify the ad-hackery in
> partitions/check.c.

What kind of reductions to driver code do you have in mind? Is it
really a big deal?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
