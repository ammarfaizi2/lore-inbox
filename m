Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315517AbSEME2s>; Mon, 13 May 2002 00:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315594AbSEME2r>; Mon, 13 May 2002 00:28:47 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:8400 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S315517AbSEME2q>; Mon, 13 May 2002 00:28:46 -0400
Date: Sun, 12 May 2002 22:28:44 -0600
Message-Id: <200205130428.g4D4Si314816@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devfs v212 available
In-Reply-To: <Pine.GSO.4.21.0205130006570.27629-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Sun, 12 May 2002, Richard Gooch wrote:
> 
> > OK, I've had a look. There is indeed a race there. While it is safe
> > against module unloading, it isn't safe against removal of entries
> > from the directory. I'm considering some different options to fix this
> > (one is simple and obvious, the other will be a little more
> > efficient).
> > 
> > Question: can invalidate_device() and the bdops methods
> > check_media_change() and revalidate() be called with a lock held?
> 
> Erm...  Depends on the nature of lock.  Spinlocks are out of
> question, obviously (at the very least we reread partition table if
> disk had been changed and you can't make that nonblocking ;-).
> Semaphore might work, but I would be very careful with deadlocks -
> the same rereading partition table could add or remove devfs
> entries.

Yeah, I think I'll go for the simpler and safer solution.

> Could you describe what are you trying to achieve in the callers of
> check_disc_changed()?  I'd been unable to deduce that from code and
> some comments would be very welcome.

There are two cases where we want to do a partition re-read:
- in lookup(), if the entry was not found
- in readdir().

The point of this is to make sure that the partition list is updated
(if media has changed) whenever user-space might care. Without the
above code, if the media changes, and thus the partitioning changes,
the list of partitions that devfs has is stale. Two things (at least)
could go wrong in this case:
- ls on directory reports partitions that are no longer valid
- a new partition cannot be accessed because the entry hasn't been
  registered yet.

The code prevents these problems.

Clear?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
