Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277821AbRJIQsZ>; Tue, 9 Oct 2001 12:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277822AbRJIQsP>; Tue, 9 Oct 2001 12:48:15 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:6546 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S277821AbRJIQsI>; Tue, 9 Oct 2001 12:48:08 -0400
Date: Tue, 9 Oct 2001 10:48:31 -0600
Message-Id: <200110091648.f99GmVS29516@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devfs v194 available
In-Reply-To: <Pine.GSO.4.21.0110091206100.15875-100000@weyl.math.psu.edu>
In-Reply-To: <200110091603.f99G32o28831@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0110091206100.15875-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> On Tue, 9 Oct 2001, Richard Gooch wrote:
> 
> > Alexander Viro writes:
> > > ... doesn't fix _under_run in try_modload() (see what happens if
> > > namelen is 255 and parent is devfs root)
> > 
> > What underrun?
> > How can this be a problem? Before I use pos, I have the following
> > check:
> >     if (namelen >= STRING_LENGTH) return -ENAMETOOLONG;
> > 
> > so the maximum value that namelen can be is STRING_LENGTH-1. Thus we
> > have:
> >     pos = STRING_LENGTH - (STRING_LENGTH - 1) - 1;
> > ->  pos = 0;
> 
> Certainly.  And
>      buf[STRING_LENGTH - namelen - 2] = '/';
> assigns '/' to
> 	buf [ STRING_LENGTH - (STRING_LENGTH-1) - 2 ]
> i.e.
> 	buf[-1]

Bugger. Didn't look further down. Ah, well. Incomplete bug report :-)

> > Ah, shit. I just checked the rwsem implementation. It seems that once
> > we do a down_write() (even if that blocks because someone else has a
> > down_read() already), subsequent down_read() calls will block until
> > the writer is granted access and then does up_write(). Damn. It would
> > have been good for this to be documented somewhere. Those are the
> > kinds of traps that should be mentioned in the header file.
> >
> > OK: is there a variant of rwsem which is "unfair" (i.e. readers can
> > starve writers indefinately)?
> 
> 	IMO it's a wrong approach.  Notice that all these problems
> have common reason - you are reusing entries.  There's absolutely no
> need to do that.  Separate the logics for "search" and "create", so
> that devfs_register() would fail if entry already exists.  Detach it
> from the tree upon unregister().  And add a simple reference counter
> to the damn thing.  Set it to 1 when entry is created. Bump it when
> you use it up/drop when you stop.  And drop it when you detach from
> the tree.  End of story.  Symlink contents is freed along with the
> entry when refcount hits zero.  No semaphores, no new locking
> primitives, no wheels to reinvent.

This is exactly what I've done in my big re-write.

> 	Now, given the unholy mess in your search_...() functions I
> don't envy you - cleaning them up _will_ hurt.

Yes, it *is* hurting :-( Those mutually recursive functions are the
last bits left to convert/burn-at-the-stake in my re-write. They're
the last bits precisely because they're the most ugly.

> Ditto for auditing the code for places that would retain a reference
> to unregistered entries.  But as far as I can see that's the only
> realistic way to handle these problems.

Yep. My new code is looking *much* cleaner.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
