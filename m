Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281403AbRKEW2S>; Mon, 5 Nov 2001 17:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281404AbRKEW2J>; Mon, 5 Nov 2001 17:28:09 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:19724 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281403AbRKEW2C>; Mon, 5 Nov 2001 17:28:02 -0500
Message-ID: <3BE71131.59BA0CFC@zip.com.au>
Date: Mon, 05 Nov 2001 14:22:41 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Mike Fedyk <mfedyk@matchmail.com>, lkml <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] disk throughput
In-Reply-To: <3BE647F4.AD576FF2@zip.com.au> <Pine.GSO.4.21.0111050904000.23204-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Mon, 5 Nov 2001, Andrew Morton wrote:
> 
> > OK, that's one possible reason.  Not sure I buy it though.  If
> > the files are created a few days after their parent directory
> > then the chance of their data or metadata being within device
> > readhead scope of any of the parent dir's blocks seems small?
> 
> Algorithm for inode allocation had been written by Kirk back in
> '84.  You can find some analisys in the original paper (A Fast
> Filesystem for UNIX).

'84.

> BTW, what you want is not "readahead scope of parent dir block".
> You want inodes of files in given directory close to each other.
> That matters a lot when you do stat() on directory contents,
> etc.  Moreover, since we attempt to keep data blocks close to
> inodes, we want to keep use of cylinder groups more or less
> even.

For some workloads we want the subdirectories close to the
parent as well.  Failing to do so is horridly wrong.

What has changed since Kirk's design?

- The relative cost of seeks has increased.  Device caching
  and readahead and increased bandwidth make it more expensive
  to seek away.

- The seek distance-versus-cost equation has changed.  Take a look
  at a graph of seek distance versus time.  Once you've decided to
  seek ten percent of the distance across the disk, a 90% seek only
  takes twice as long.

- The size of devices has grown more quickly than ext2 blocksizes,
  so instead of having four or eight block groups as we did in the
  old days, we now have hundreds.  256 block groups on a 32 gig fs.
  Sprinkling a directory tree across 256 block groups hurts a lot.


I don't think I buy the fragmentation argument, really.  I suspect
that doing first-fit within the bounds of a block group will have
a long-term effect similar to performing first-fit on the entire fs.

But I don't know.  This is just all bullshit handwaving speculation.
We need tests.  Numbers.  Does anyone have source to a filesystem
aging simulation?  The Smith/Seltzer code seems to be off the air.

I just fed patch-2.4.14-ac8 into my sucky cvs import scripts and it
ran in about a fifth of the time.  This is a serious matter, worth
spending time on.

-
