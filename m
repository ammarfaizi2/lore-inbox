Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292122AbSCDILi>; Mon, 4 Mar 2002 03:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292150AbSCDIL3>; Mon, 4 Mar 2002 03:11:29 -0500
Received: from dsl-213-023-043-059.arcor-ip.net ([213.23.43.59]:21395 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S292122AbSCDILT>;
	Mon, 4 Mar 2002 03:11:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [patch] delayed disk block allocation
Date: Mon, 4 Mar 2002 09:06:39 +0100
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C7F3B4A.41DB7754@zip.com.au> <20020303223103.J4188@lynx.adilger.int> <3C83280A.A8CF7CC8@zip.com.au>
In-Reply-To: <3C83280A.A8CF7CC8@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16hnUV-0000aa-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 4, 2002 08:53 am, Andrew Morton wrote:
> Andreas Dilger wrote:
> > 
> > Actually, there are a whole bunch of performance issues with 1kB block
> > ext2 filesystems.
> 
> I don't see any new problems with file tails here.  They're catered for
> OK.  What I have not catered for is file holes.    With the delalloc
> patches, whole pages are always written out (except for at eof).  So
> if your file has lots of very small non-holes in it, these will become
> larger non-holes.
> 
> If we're serious about 64k PAGE_CACHE_SIZE then this becomes more of
> a problem.  In the worst case, a file which used to consist of
> 
> 4k block | (1 meg - 4k) hole | 4k block | (1 meg - 4k) hole | ...
> 
> will become:
> 
> 64k block | (1 meg - 64k) hole | 64k block | (1 meg - 64k hole) | ...
> 
> Which is a *lot* more disk space.  It'll happen right now, if the
> file is written via mmap.  But with no-buffer-head delayed allocate,
> it'll happen with write(2) as well.
> 
> Is such space wastage on sparse files a showstopper?    Maybe,
> but probably not if there is always at least one filesystem
> which handles this scenario well, because it _is_ a specialised
> scenario.

I guess 4K PAGE_CACHE_SIZE will serve us well for another couple of years, 
and in that time I hope to produce a patch that generalizes the notion of 
page size so we can use the size that works best for each address_space, 
i.e., the same as the filesystem blocksize.

By the way, have you ever seen a sparse 1K blocksize file?  I haven't, I
wouldn't get too worked up about treating the holes a little less than
optimally.

-- 
Daniel
