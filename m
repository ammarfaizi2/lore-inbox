Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277851AbRJRRow>; Thu, 18 Oct 2001 13:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277859AbRJRRon>; Thu, 18 Oct 2001 13:44:43 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:26972 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277851AbRJRRoZ>; Thu, 18 Oct 2001 13:44:25 -0400
Date: Thu, 18 Oct 2001 19:44:15 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Andreas Dilger <adilger@turbolabs.com>, Kamil Iskra <kamil@science.uva.nl>,
        Steve Kieu <haiquy@yahoo.com>, kernel <linux-kernel@vger.kernel.org>
Subject: Re: Poor floppy performance in kernel 2.4.10
Message-ID: <20011018194415.S12055@athlon.random>
In-Reply-To: <20011018092837.C1144@turbolinux.com> <Pine.GSO.4.21.0110181217120.21021-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.GSO.4.21.0110181217120.21021-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Oct 18, 2001 at 12:18:12PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2001 at 12:18:12PM -0400, Alexander Viro wrote:
> 
> 
> On Thu, 18 Oct 2001, Andreas Dilger wrote:
> 
> > I think this is a result of the "blockdev in pagecache" change added in
> > 2.4.10.  One of the byproducts of this change is that if a block device
> > is closed (no other openers) then all of the pages from this device are
> > dropped from the cache.  In the case of a floppy drive, this is very
> > important, as you don't want to be cacheing data from one floppy after
> > you have inserted a new floppy.
> 
> 
> RTFS.  That _exactly_ matches the behaviour of buffer-cache variant.

Indeed, only 2.2 trusted the check media change information and left the
cache valid on top of the floppy across close/open of the blkdev.

Maybe it's because a read now fills in the whole page rather than 1k.
So if you write 1k aligned, and you read it back, the read will it the
disk and it will have to read another 3k before it can return such 1k
info that was just in memory. It's exactly the same on the files on a 1k
ext2 filesystem.

Alexander just proposed some month ago to support the partial reads in
the pagecache like we do for partial writes: by not marking the page
uptodate for partial reads and by going down to the buffer layer every
time to check if the partial memory we're interested about is just
uptodate or not (and marking the page uptodate eventually if we end
reading the whole page). So it's nothing unfixable, we just need to
understand if that is the problem and/or if mtools is doing something
stupid that sorted out to work ok when partial reads were supported.

Andrea
