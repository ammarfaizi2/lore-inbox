Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280959AbRKLUA0>; Mon, 12 Nov 2001 15:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280954AbRKLUAR>; Mon, 12 Nov 2001 15:00:17 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:1416 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S280959AbRKLUAH>; Mon, 12 Nov 2001 15:00:07 -0500
Date: Mon, 12 Nov 2001 12:59:54 -0700
Message-Id: <200111121959.fACJxsj08462@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andrew Morton <akpm@zip.com.au>
Cc: Ben Israel <ben@genesis-one.com>, linux-kernel@vger.kernel.org
Subject: Re: File System Performance
In-Reply-To: <3BF02702.34C21E75@zip.com.au>
In-Reply-To: <00b201c16b81$9d7aaba0$5101a8c0@pbc.adelphia.net>
	<3BEFF9D1.3CC01AB3@zip.com.au>
	<00da01c16ba2$96aeda00$5101a8c0@pbc.adelphia.net>
	<3BF02702.34C21E75@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
> Ben Israel wrote:
> > 
> > Andrew
> > 
> >  Thank you very much for your response. I would like to know what ever I can
> > about File Systems that achieve near Raw Disk Transfer Speeds on large file
> > system modifications.
> 
> This is very filesystem-dependent.   Probably the XFS mailing list
> linux-xfs@oss.sgi.com is the place to ask for XFS.
> 
> > What does the "Orlov allocator" do differently?
> 
> The problem which ext2 experiences with your particular workload
> is that it attempts to balance the creation of new directories
> across the filesystem's various "block groups".  There are tens
> or hundreds of these.  ext2 also tries to place files in the same
> block group as their parent directory.
> 
> Consequently, when you untar (or just copy) a directory tree,
> it gets placed all over the partition.  So both reading it and
> writing it requires a lot of seeking.
> 
> That's a fast-growth workload.  A slow-growth workload is
> the normal sort of day-to-day activity where you reqularly
> create and delete files.  The occupancy of the fs grows slowly.
> 
> We are seeing some degradation in performance in the slow-growth
> case with the Orlov algorithm.  But fast-growth is increased a lot.
> 
> The Orlov algorithm (or at least Al's version of it) tries to
> spread top-level directories evenly across the partition, under
> the assumption that these contain unrelated information.  But for
> directories at a lower level, it is more aggressive about placing
> directories in the same block group as their parent.   It _will_
> move into a different block group, but only when it sees that the
> current one is filling up.

Here's an idea: add a "--compact" option to tar, so that it creates
*all* inodes (files and directories alike) in the base directory, and
then renames newly created entries to shuffle them into their correct
positions. That should limit the number of block groups that are used,
right?

It would probably also be a good idea to do that for cp as well, so
that when I do a "cp -al" of a virgin kernel tree, I can keep all the
directory inodes together. It will make a cold diff even faster.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
