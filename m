Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277812AbRJIQ2W>; Tue, 9 Oct 2001 12:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277813AbRJIQ2M>; Tue, 9 Oct 2001 12:28:12 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:60624 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S277812AbRJIQ17>;
	Tue, 9 Oct 2001 12:27:59 -0400
Date: Tue, 9 Oct 2001 12:28:24 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: Re: [PATCH] devfs v194 available
In-Reply-To: <200110091603.f99G32o28831@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0110091206100.15875-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Oct 2001, Richard Gooch wrote:

> Alexander Viro writes:
> > ... doesn't fix _under_run in try_modload() (see what happens if
> > namelen is 255 and parent is devfs root)
> 
> What underrun?
> How can this be a problem? Before I use pos, I have the following
> check:
>     if (namelen >= STRING_LENGTH) return -ENAMETOOLONG;
> 
> so the maximum value that namelen can be is STRING_LENGTH-1. Thus we
> have:
>     pos = STRING_LENGTH - (STRING_LENGTH - 1) - 1;
> ->  pos = 0;

Certainly.  And
     buf[STRING_LENGTH - namelen - 2] = '/';
assigns '/' to
	buf [ STRING_LENGTH - (STRING_LENGTH-1) - 2 ]
i.e.
	buf[-1]

> Ah, shit. I just checked the rwsem implementation. It seems that once
> we do a down_write() (even if that blocks because someone else has a
> down_read() already), subsequent down_read() calls will block until
> the writer is granted access and then does up_write(). Damn. It would
> have been good for this to be documented somewhere. Those are the
> kinds of traps that should be mentioned in the header file.
>
> OK: is there a variant of rwsem which is "unfair" (i.e. readers can
> starve writers indefinately)?

	IMO it's a wrong approach.  Notice that all these problems
have common reason - you are reusing entries.  There's absolutely
no need to do that.  Separate the logics for "search" and "create",
so that devfs_register() would fail if entry already exists.
Detach it from the tree upon unregister().  And add a simple reference
counter to the damn thing.  Set it to 1 when entry is created. Bump it
when you use it up/drop when you stop.  And drop it when you detach
from the tree.  End of story.  Symlink contents is freed along with
the entry when refcount hits zero.  No semaphores, no new locking
primitives, no wheels to reinvent.

	Now, given the unholy mess in your search_...() functions I
don't envy you - cleaning them up _will_ hurt.  Ditto for auditing
the code for places that would retain a reference to unregistered
entries.  But as far as I can see that's the only realistic way
to handle these problems.

