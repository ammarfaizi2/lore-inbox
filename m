Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263686AbRFRHKE>; Mon, 18 Jun 2001 03:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263676AbRFRHJz>; Mon, 18 Jun 2001 03:09:55 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:61938 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263674AbRFRHJn>;
	Mon, 18 Jun 2001 03:09:43 -0400
Date: Mon, 18 Jun 2001 03:09:40 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: Re: [PATCH] devfs v181 available
In-Reply-To: <200106180640.f5I6eLS30459@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0106180246360.17131-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Jun 2001, Richard Gooch wrote:

> Alexander Viro writes:
> > 
> > 
> > On Mon, 18 Jun 2001, Richard Gooch wrote:
> > 
> > > - Widened locking in <devfs_readlink> and <devfs_follow_link>
> > 
> > No, you hadn't. Both vfs_readlink() and vfs_follow_link() are blocking
> > functions, so BKL is worthless there.
> 
> Huh? The BKL will protect against other operations which might cause
> the devfs entry to be unregistered, where those other operations also
> grab the BKL. So, it's an improvement.

BKL is released as soon as you block. You _do_ regain it when you get
the next timeslice, but in the meanwhile anything could happen.

> Sure, some operations may cause unregistration without grabbing the

Irrelevant. BKL provides an exclusion only on non-blocking areas.

> BKL, but that's orthogonal (and requires more extensive changes). If
> this "widening" is of no use, then what use are the existing grabs of
> the BKL in those functions? You're the one who added them in the first
> place.

_Moved_ them there from the callers of these functions. And AFAICS you
do need BKL for get_devfs_entry_...(); otherwise relocation of the
table will be able to screw you inside of that function. Now, it will
merrily screw you anyway in a lot of places, but that's another story.

BTW, free advice: when you are checking some condition treat the result
as something that can expire. And don't rely on it past the moment when
it might expired. E.g. in case of de->registered result expires as soon
as you do unlock_kernel() _or_ do anything that might block.

