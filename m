Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271487AbRIAXyl>; Sat, 1 Sep 2001 19:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271503AbRIAXya>; Sat, 1 Sep 2001 19:54:30 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:11161 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S271502AbRIAXyY>;
	Sat, 1 Sep 2001 19:54:24 -0400
Date: Sat, 1 Sep 2001 19:54:40 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [RFC] lazy allocation of struct block_device
In-Reply-To: <200109012042.UAA17644@vlet.cwi.nl>
Message-ID: <Pine.GSO.4.21.0109011945360.19304-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 1 Sep 2001 Andries.Brouwer@cwi.nl wrote:

>     How do you tell when inode is not opened anymore?
> ...
>     When do you reset it [i_bcdev]?
> 
> Now I see what you are asking - at first I thought you wondered
> about the bookkeeping for the device struct, and there is no problem there,
> but you ask about the bookkeeping for i_bcdev.
> 
> Since the refcount is for the device struct, we cannot do anything
> until that count hits zero. Then the release method of the device struct
> is called (which frees it, or decrements a refcount for the module).

Wait a minute. You had suggested (upthread) that these objects are allocated
by partition code and contain per-partition data. Freeing them once the device
is closed looks very odd.

> After this i_bcdev cannot be used anymore.
> Since we don't know whether this happened already, i_bcdev must be
> recomputed on each open or mount.

... and that means that we can't make devfs-like filesystems just set
->i_bdev (or ->i_cdev) at read_super() (or lookup()) and avoid all mess
with major/minor allocation.  IMO that's unfortunate, especially since
majors allocation is on the permanent freeze.

> (One might invent additional data structure to avoid this recomputation,
> but data structures take memory and add the complication that they
> must be kept consistent and up-to-date. Since mounting, or opening
> a block device, are very infrequent operations, it does not matter
> that we do a possibly superfluous bdopen().)

Once you look at character devices (they have same set of problems)
frequency goes up big way.

