Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbUBWXzH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 18:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbUBWXzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 18:55:07 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:1301 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262099AbUBWXzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 18:55:00 -0500
Date: Tue, 24 Feb 2004 10:53:39 +1100
From: Nathan Scott <nathans@sgi.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blkdev_open/bd_claim vs BLKBSZSET
Message-ID: <20040223235339.GC773@frodo>
References: <20040223231705.GB773@frodo> <20040223232803.GD31035@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040223232803.GD31035@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 11:28:04PM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Tue, Feb 24, 2004 at 10:17:05AM +1100, Nathan Scott wrote:
> > Hi there,
> > 
> > I was modifying mkfs.xfs to use O_EXCL for 2.6, and hit a snag.
> > It seems that once I've opened a block dev with O_EXCL I can no
> > longer issue the BLKBSZSET ioctl to it.  (Is that the expected
> > behavior?  If so, ignore...)
>  
> > And mkfs gets EBUSY back from the ioctl.  Using the patch
> > below, the ioctl succeeds cos the original filp bdev owner
> > from open now matches with the owner in the ioctl call.  I
> > suspect that would be the correct behavior, but perhaps I'm
> > overlooking some good reason for it being this way?
> 
> <shrug> it can be done that way, but I really wonder why the hell does
> mkfs.xfs bother with BLKBSZSET in the first place?

Thats taking me back a few years - IIRC this was originally added
because mkfs.xfs zeroes out the last N KB of the device before it
goes on to creating the XFS filesystem.  Waaay back (~3 years now?)
there was a problem when someone had, say, a 4K block size ext2 fs
on the device - mount/unmount of that left the device block size at
4K in the kernel, when mkfs.xfs then came along it would not be able
to zero the last small-amount-less-than-4K of the device (on devices
where the size was not 4K aligned only - heh, that was a fun wrinkle)
and mkfs would see write-past-end-of-device errors.

No idea if that can still happen in 2.6, I imagine it can in 2.4
where we originally saw the problem.

> FWIW, that ioctl is practically never the right thing to do these days.
> I'm not saying that we shouldn't apply the patch - it looks sane - but
> it looks like mkfs.xfs is doing something bogus.

At least for some older kernel versions this was needed - possibly
still is, I'm not sure.

cheers.

-- 
Nathan
