Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264176AbRFRPRG>; Mon, 18 Jun 2001 11:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264203AbRFRPRD>; Mon, 18 Jun 2001 11:17:03 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:54435 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S264176AbRFRPQ2>; Mon, 18 Jun 2001 11:16:28 -0400
Date: Mon, 18 Jun 2001 09:15:38 -0600
Message-Id: <200106181515.f5IFFcA00598@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: Re: [PATCH] devfs v181 available
In-Reply-To: <Pine.GSO.4.21.0106180246360.17131-100000@weyl.math.psu.edu>
In-Reply-To: <200106180640.f5I6eLS30459@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0106180246360.17131-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> On Mon, 18 Jun 2001, Richard Gooch wrote:
> > Alexander Viro writes:
> > > On Mon, 18 Jun 2001, Richard Gooch wrote:
> > > > - Widened locking in <devfs_readlink> and <devfs_follow_link>
> > > 
> > > No, you hadn't. Both vfs_readlink() and vfs_follow_link() are blocking
> > > functions, so BKL is worthless there.
> > 
> > Huh? The BKL will protect against other operations which might cause
> > the devfs entry to be unregistered, where those other operations also
> > grab the BKL. So, it's an improvement.
> 
> BKL is released as soon as you block. You _do_ regain it when you get
> the next timeslice, but in the meanwhile anything could happen.
> 
> > Sure, some operations may cause unregistration without grabbing the
> 
> Irrelevant. BKL provides an exclusion only on non-blocking areas.

Yeah, I know all that.

> > BKL, but that's orthogonal (and requires more extensive changes). If
> > this "widening" is of no use, then what use are the existing grabs of
> > the BKL in those functions? You're the one who added them in the first
> > place.
> 
> _Moved_ them there from the callers of these functions. And AFAICS
> you do need BKL for get_devfs_entry_...(); otherwise relocation of
> the table will be able to screw you inside of that function. Now, it
> will merrily screw you anyway in a lot of places, but that's another
> story.

OK, so it was another global change.

> BTW, free advice: when you are checking some condition treat the
> result as something that can expire. And don't rely on it past the
> moment when it might expired. E.g. in case of de->registered result
> expires as soon as you do unlock_kernel() _or_ do anything that
> might block.

Yeah, I know. Fear not: I'll be adding proper locks (spinlocks and
semaphores) to the code, continuing the work I started this weekend. I
don't like the BKL anyway (too coarse grained), and hope to see it
removed entirely one day.

Question: assuming data fed to vfs_follow_link() is "safe", does it
need the BKL? I can see that vfs_readlink() obviously doesn't need
it. From reading Documentation/filesystems/Locking I suspect it
doesn't need the BKL, but the way I read it says "follow_link() method
does not *have* the BKL already". But that doesn't explicitely say
whether vfs_follow_link() needs it.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
