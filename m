Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313014AbSDKXWU>; Thu, 11 Apr 2002 19:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313022AbSDKXWT>; Thu, 11 Apr 2002 19:22:19 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:64435 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S313014AbSDKXWR>; Thu, 11 Apr 2002 19:22:17 -0400
Date: Fri, 12 Apr 2002 00:22:11 +0100 (BST)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: Andrew Morton <akpm@zip.com.au>
cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [prepatch] address_space-based writeback
In-Reply-To: <3CB5FFB5.693E7755@zip.com.au>
Message-ID: <Pine.SOL.3.96.1020411235415.24708A-100000@virgo.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2002, Andrew Morton wrote:
> Alexander Viro wrote:
> > ...
> > FWIW, correct solution might be to put dirty address_spaces on a list -
> > per-superblock or global.
> 
> Another approach may be to implement address_space.private,
> which appears to be what NTFS wants.  My initial reaction
> to that is fear, because it just makes the graph even more
> tangly.
> 
> I agree that listing the dirty address_spaces against the
> superblock makes sense - really it's what I'm trying to do,
> and the intermediate inode is the only means of getting there.

If you take Al's approach then the intermediate inode becomes irrelevant.
I like the idea of per super block dirty mappings list a lot. In fact I
was planning to do that for ntfs and attach the list to the ntfs_volume
and then have a kntfsd thread walk those every 5 seconds and flush to
disk... (I was also thinking of throwing in barriers and
flush_to_this_barrier_now functionality for journalling purposes but I
was going to leave that for later...)

It would be great if the VFS implemented that in general instead. (-:

> Also, this splitup would clearly separate the concepts
> of a dirty-inode and dirty-inode-pages.  These seem to be
> coupled in a non-obvious way at present.

Indeed. That would be very nice.

> AFAIK, the current superblock->inode->mapping approach won't
> break any existing filesystems, so I'm inclined to follow 
> that for the while, get all the known problems collected
> together and then take another pass at it. Maybe do something
> to make inode_lock a bit more conventional as well.
> 
> This whole trend toward a flowering of tiny address_spaces
> worries me a little from the performance POV,

Why tiny address_spaces? I have seen 4.5GiB large $MFT/$DATA (inode table)
on a 40GiB ntfs partition and that was year ago now... That's not what I
call tiny. (-;

The cluster allocation bitmap on a 40GiB partition is 10MiB in size, that
is not huge but not what I would call tiny either...

> because writeback likes big gobs of linear data to chew on.  With the
> global buffer LRU, even though large-scale sorting opportunities were
> never implemented, we at least threw a decent amount of data at the
> request queue. 
> 
> With my current approach, all dirty conventional metadata
> (the output from mark_buffer_dirty) is written back via
> the blockdev's mapping.  It becomes a bit of a dumping
> ground for the output of legacy filesystems, but it does
> offer the opportunity to implement a high-level sort before
> sending it to disk.  If that's needed.

Considering modern harddrives have their own intelligent write back and
sorting of write requests and ever growing hd buffers the need for doing
this at the OS level is going to become less and less would be my guess, I
may be wrong of course...

> I guess that as long as the periodic- and memory-pressure
> based writeback continues to send a lot of pages down the
> pipe we'll still get adequate merging, but it is something
> to be borne in mind.  At the end of the day we have to deal
> with these funny spinning things.
> 
> One thing I'm not clear on with the private metadata address_space
> concept: how will it handle blocksize less than PAGE_CACHE_SIZE? 

The new ntfs uses 512 byte blocksize ONLY (the hd sector size) and remaps
internally between the actual partition cluster size (block size) and the
512 byte block size set in s_blocksize.

This is the only way to support cluster sizes above PAGE_CACHE_SIZE. -
NTFS 3.1 can go up to 512kiB clusters (and bigger!, but Windows doesn't
allow you to format partitions with bigger cluster sizes AFAIK). 

At the moment I am using a buffer head for each 512 byte disk sector which
is very counter productive to performance. 

It would be great to be able to submit variable size "io entities" even
greater than PAGE_CACHE_SIZE (by giving a list of pages, starting offset
in first page and total request size for example) and saying write that to
the device starting at offset xyz. That would suit ntfs perfectly. (-:

> The only means we have at present of representing sub-page
> segments is the buffer_head.  Do we want to generalise the buffer
> layer so that it can be applied against private address_spaces?
> That wouldn't be a big leap.

It is already generalised. I use it that way at least at the moment...

> Or would the metadata address_spaces send their I/O through the
> backing blockdev mapping in some manner?

Not sure what you mean...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
IRC: #ntfs on irc.openprojects.net / ICQ: 8561279
WWW: http://www-stu.christs.cam.ac.uk/~aia21/

