Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312889AbSDKW3T>; Thu, 11 Apr 2002 18:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312986AbSDKW3T>; Thu, 11 Apr 2002 18:29:19 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:55568 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S312889AbSDKW3S>; Thu, 11 Apr 2002 18:29:18 -0400
Message-ID: <3CB5FFB5.693E7755@zip.com.au>
Date: Thu, 11 Apr 2002 14:27:17 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [prepatch] address_space-based writeback
In-Reply-To: <a94r5k$m23$1@penguin.transmeta.com> <Pine.GSO.4.21.0204111629370.21089-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> ...
> FWIW, correct solution might be to put dirty address_spaces on a list -
> per-superblock or global.

Another approach may be to implement address_space.private,
which appears to be what NTFS wants.  My initial reaction
to that is fear, because it just makes the graph even more
tangly.

I agree that listing the dirty address_spaces against the
superblock makes sense - really it's what I'm trying to do,
and the intermediate inode is the only means of getting there.

Also, this splitup would clearly separate the concepts
of a dirty-inode and dirty-inode-pages.  These seem to be
coupled in a non-obvious way at present.

AFAIK, the current superblock->inode->mapping approach won't
break any existing filesystems, so I'm inclined to follow 
that for the while, get all the known problems collected
together and then take another pass at it. Maybe do something
to make inode_lock a bit more conventional as well.


This whole trend toward a flowering of tiny address_spaces
worries me a little from the performance POV, because
writeback likes big gobs of linear data to chew on.  With the
global buffer LRU, even though large-scale sorting 
opportunities were never implemented, we at least threw
a decent amount of data at the request queue.

With my current approach, all dirty conventional metadata
(the output from mark_buffer_dirty) is written back via
the blockdev's mapping.  It becomes a bit of a dumping
ground for the output of legacy filesystems, but it does
offer the opportunity to implement a high-level sort before
sending it to disk.  If that's needed.

I guess that as long as the periodic- and memory-pressure
based writeback continues to send a lot of pages down the
pipe we'll still get adequate merging, but it is something
to be borne in mind.  At the end of the day we have to deal
with these funny spinning things.


One thing I'm not clear on with the private metadata address_space
concept: how will it handle blocksize less than PAGE_CACHE_SIZE? 
The only means we have at present of representing sub-page
segments is the buffer_head.  Do we want to generalise the buffer
layer so that it can be applied against private address_spaces?
That wouldn't be a big leap.

Or would the metadata address_spaces send their I/O through the
backing blockdev mapping in some manner?

-
