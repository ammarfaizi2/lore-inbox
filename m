Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266308AbSKUCwI>; Wed, 20 Nov 2002 21:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266310AbSKUCwI>; Wed, 20 Nov 2002 21:52:08 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:46219 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S266308AbSKUCwH>;
	Wed, 20 Nov 2002 21:52:07 -0500
Date: Wed, 20 Nov 2002 21:58:51 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: kill i_dev
In-Reply-To: <UTC200211210133.gAL1Xjw05852.aeb@smtp.cwi.nl>
Message-ID: <Pine.GSO.4.21.0211202053250.6440-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Nov 2002 Andries.Brouwer@cwi.nl wrote:

> Yes, I looked at that but concluded that someone (you?)
> had added the assignment just to preserve the guarantee
> previously given by get_empty_inode() at the moment it
> was replaced by new_inode(). But it is superfluous, I think.

Existing userland doesn't, though.
 
> Something else is kdev_t. I liked it when it was a pointer.
> Now it is just garbage and the kernel is full of conversions
> to and from. Is there any reason not to throw out all of kdev_t?
> That is, is there a reason to have a kdev_t different from dev_t?

Yes - dev_t has legitimate reasons to exist.  kdev_t is a garbage
and its presence means that we need to fugure out what real objects
should be used in that particular context.

Note that in many cases these objects are, indeed, different.  So
blanket replacement of kdev_t with pointer to some type is *wrong*.
E.g. on the block side, we used to use kdev_t when we actually needed
	* filesystem
	* device node in some fs
	* device number from userland POV
	* struct block_device *, with associated cache, etc.
	* "disk" from driver POV (what had become struct gendisk *)
	* pointer to driver-specific data structure.

All of the above have different lifetime rules.  That alone means that
there is no hope in hell for a natural object unifying these uses.

And this information ("what kind of object are we talking about") was
simply not there - most of the stuff I'd been doing in 2.5 was *adding*
*that* *information* *into* *source*.  Several megabytes in 400-odd
patches...

Similar work needs to be done for character devices.  Then (and only then)
kdev_t can go.  Note that dev_t has only one legitimate use - it's when
we are talking about userland-supplied number without refering to internal
objects.

And yes, these conversions serve useful purpose - they mark the places
that need work.  Simple "oh, we'll just s/kdev_t/dev_t/" is not a good
step - more often than not it would just propagate dev_t to the places
where it doesn't belong.

