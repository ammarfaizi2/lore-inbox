Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278046AbRKSUjb>; Mon, 19 Nov 2001 15:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278522AbRKSUjV>; Mon, 19 Nov 2001 15:39:21 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:27783 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278046AbRKSUjJ>;
	Mon, 19 Nov 2001 15:39:09 -0500
Date: Mon, 19 Nov 2001 15:39:01 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] problem with grow_dev_page()/readpage()
In-Reply-To: <Pine.LNX.4.33.0111191217390.8460-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0111191533320.19969-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Nov 2001, Linus Torvalds wrote:

> 
> On Mon, 19 Nov 2001, Alexander Viro wrote:
> >
> > That breaks if you do bread() on something less than hardware sector size,
> > though.  Then all following attempts to read that page (until ->buffers
> > is evicted) will keep trying to submit IO on too small buffers.
> 
> I don't think that can happen - you can only bread with i_blksize, and the
> set_blocksize() stuff refuses to set to smaller than the hardware sector
> size.

Then we'd better check that in bread() (getblk(), actually).  Works for
me - that's even better than grow_dev_page().

Notice that 2.4.15-pre6 _does_ have at least two bugs of that kind - aic7xxx
(both old and new drivers).  They have an ioctl() that tries to guess the
BIOS geometry.  It blindly does bread() on 1Kb buffer, which leaves MO
disks very unhappy.  So check looks like a good idea...

