Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261810AbSJNEmC>; Mon, 14 Oct 2002 00:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261818AbSJNEmC>; Mon, 14 Oct 2002 00:42:02 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:43507 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S261810AbSJNEmB>; Mon, 14 Oct 2002 00:42:01 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Sun, 13 Oct 2002 22:43:55 -0600
To: Michael Clark <michael@metaparadigm.com>
Cc: Alexander Viro <viro@math.psu.edu>, Christoph Hellwig <hch@infradead.org>,
       Mark Peloquin <markpeloquin@hotmail.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: Linux v2.5.42
Message-ID: <20021014044355.GQ3045@clusterfs.com>
Mail-Followup-To: Michael Clark <michael@metaparadigm.com>,
	Alexander Viro <viro@math.psu.edu>,
	Christoph Hellwig <hch@infradead.org>,
	Mark Peloquin <markpeloquin@hotmail.com>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com,
	evms-devel@lists.sourceforge.net
References: <Pine.GSO.4.21.0210131243480.9247-100000@steklov.math.psu.edu> <3DA9B05F.8000600@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA9B05F.8000600@metaparadigm.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 14, 2002  01:41 +0800, Michael Clark wrote:
> Can we have some concensus on whether intermediate remapping layers also 
> need to be exposed as block devices as this requiement would have a large
> impact on the code.
> 
> From the discussion so far:
> 
> Pros
> * Simplify ioctl routing to plugins
> 
> Cons
> * Chew up a minor
> * Get a block device we don't need or want (ie. we can still easily
>   directly access the underlying physical block devices)
> * lose purely logical remapping abstraction in plugins
> * Complicate mapping of request queues to devices (ie. shouldn't only
>   the top level volume device and the underlying physical devices need
>   request queues)

I never did get a clear understanding why Christoph wants access to
"intermediate" block devices from EVMS, except for the ioctl issue.
Granted, it _may_ be more "pure" to keep within the current block device
paradigm for each internal stacking layer, or whatever.  If AV wants
it implemented differently, then do it, I say.  But, that said, the
fact that each intermediate layer _could_ be considered a block device
does not mean that it makes sense to allow user-space access to these
intermediate layers.

Why on earth would I want to start reading from or writing to a block
device which is part of a RAID 5 volume which is chunked into 16MB
logical extents for a volume which is part of a snapshot of some
totally different volume?  Yes, in some strange recovery scenario, I
might want to 'dd' the underlying disks somewhere else for backup, but
otherwise the only other thing I can possibly do is corrupt my data
by mistake.

Don't get me wrong, I'm all for giving people enough rope to shoot
themselves in the foot, but I'd rather have /proc/partitions show me
"you have 10 volumes" than "you have these 500 partial volumes that
aren't really useful by themselves - good luck finding which one
currently isn't in use for the filesystem you need to make".

It's like "ls -l" showing you each and every block that makes up a file,
or "ps aux" listing the address of each chunk of RAM that a process has
allocated.  Even better (Al will hate this one), it's like processes
being able to read(2) and write(2) directory "files", ugh.  Sure, in
some strange context it might be useful to have this information (and
there are definitely tools which will let you know it and work directly
on the raw bits), but in 99.9999% of cases it is just an accident
waiting to happen, a waste of time to see this much detail, and confusion
for users.

Ted will recall an incident at VA where an intern mke2fs'd part of an
MD RAID device that made up Sourceforge, because he couldn't see it
mounted anywhere, and thought it wasn't in use.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

