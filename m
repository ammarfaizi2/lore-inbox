Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277802AbRJIQEA>; Tue, 9 Oct 2001 12:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277804AbRJIQDu>; Tue, 9 Oct 2001 12:03:50 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:64145 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S277802AbRJIQDe>; Tue, 9 Oct 2001 12:03:34 -0400
Date: Tue, 9 Oct 2001 10:03:02 -0600
Message-Id: <200110091603.f99G32o28831@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: Re: [PATCH] devfs v194 available
In-Reply-To: <Pine.GSO.4.21.0110090445340.13381-100000@weyl.math.psu.edu>
In-Reply-To: <200110090604.f99644D23291@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0110090445340.13381-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> ... doesn't fix _under_run in try_modload() (see what happens if
> namelen is 255 and parent is devfs root)

What underrun?
How can this be a problem? Before I use pos, I have the following
check:
    if (namelen >= STRING_LENGTH) return -ENAMETOOLONG;

so the maximum value that namelen can be is STRING_LENGTH-1. Thus we
have:
    pos = STRING_LENGTH - (STRING_LENGTH - 1) - 1;
->  pos = 0;

> ... doesn't fix the deadlock introduced into -pre6 in place of symlink
> races. That
> 
>     /*  Need to follow the link: this is a stack chomper  */
>     down_read (&symlink_rwsem);
>     retval = curr->registered ?
>         search_for_entry (parent, curr->u.symlink.linkname,
>                           curr->u.symlink.length, FALSE, FALSE, NULL,
>                           TRUE) : NULL;
>     up_read (&symlink_rwsem);
> 
> is a fairly bad idea.  Think what happens if somebody else tries to
> acquire symlink_rwsem for write between two calls of down_read() in
> that recursion.

Where is the problem? After the first call to down_read(), anyone
calling down_write() will block, which is fine. Then the second call
to down_read() should still work, right? Once the recursion unwinds,
the semaphore will be released and whoever is waiting on down_write()
will unblock.

There should be no code paths where there is recursion between
down_read() and down_write() (otherwise we *would* have a deadlock).

Ah, shit. I just checked the rwsem implementation. It seems that once
we do a down_write() (even if that blocks because someone else has a
down_read() already), subsequent down_read() calls will block until
the writer is granted access and then does up_write(). Damn. It would
have been good for this to be documented somewhere. Those are the
kinds of traps that should be mentioned in the header file.

OK: is there a variant of rwsem which is "unfair" (i.e. readers can
starve writers indefinately)?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
