Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVA1LIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVA1LIn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 06:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVA1LIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 06:08:43 -0500
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132]:35741 "EHLO
	ppsw-2.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261276AbVA1LIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 06:08:31 -0500
Date: Fri, 28 Jan 2005 11:08:18 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Nathan Scott <nathans@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: Advice sought on how to lock multiple pages in ->prepare_write
 and ->writepage
In-Reply-To: <20050128050614.GC1799@frodo>
Message-ID: <Pine.LNX.4.60.0501281044390.7887@hermes-1.csi.cam.ac.uk>
References: <1106822924.30098.27.camel@imp.csi.cam.ac.uk>
 <20050127165822.291dbd2d.akpm@osdl.org> <20050128050614.GC1799@frodo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On Fri, 28 Jan 2005, Nathan Scott wrote:
> On Thu, Jan 27, 2005 at 04:58:22PM -0800, Andrew Morton wrote:
> > Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> > >
> > > What would you propose can I do to perform the required zeroing in a
> > > deadlock safe manner whilst also ensuring that it cannot happen that a
> > > concurrent ->readpage() will cause me to miss a page and thus end up
> > > with non-initialized/random data on disk for that page?
> > 
> > The only thing I can think of is to lock all the pages.  There's no other
> > place in the kernel above you which locks multiple pagecache pages, but we
> > can certainly adopt the convention that multiple-page-locking must proceed
> > in ascending file offset order.
> > 
> > ...
> > 
> > Not very pretty though.
> 
> Just putting up my hand to say "yeah, us too" - we could also make
> use of that functionality, so we can grok existing XFS filesystems
> that have blocksizes larger than the page size.
> 
> Were you looking at using an i_blkbits value larger than pageshift,
> Anton?  There's many places where generic code does 1 << i_blkbits
> that'll need careful auditing, I think.

No, definitely not.  The inode and superblock block size are always set to 
512 bytes for NTFS (in present code).  The NTFS driver does the 
translation from "page->index + offset" to "byte offset" to "logical block 
+ offset in the block" everywhere.  This allows both reading and writing 
to occur in 512 byte granularity (the smallest logical block size allowed 
on NTFS).  So if the user is reading only 1 byte, I only need to read in 
that page and if the user is writing only 1 byte into a 
non-sparse/preallocated file, I can only write out 512 bytes 
(prepare/commit write) or a page (writepage).

But the real reason for why I have to stick with 512 bytes is that NTFS 
stores all its metadata (including the on-disk inodes, the directory 
indices, the boot record, the volume label and flags, etc) inside regular 
files.  And the contents of the metadata are organised like flat database 
files containing fixed length records - but depending on the metadata the 
size is different - (which in turn contain variable length records) and 
each fixed length record is protected at a 512 byte granularity with 
fixups which ensure that partial writes due to power failure or disk 
failure are detected.  These fixups need to be applied every time metadata 
records are written.  And when the fixups are applied, the metadata 
appears corrupt.  So we do: apply fixups, write, take away fixups.  This 
means that we have to lock each metadata record for exclusive access 
while this is happening otherwise someone could look at the record and see 
it in a corrupt state...  And since two adjacent records are not usually 
related to each other at all we cannot just lock multiple records at once 
(given the page is already locked) otherwise we would deadlock immediately 
and hence we cannot write out more than one record at once.  Which in turn 
means we need to maintain a 512 byte granularity at the write level.  
Anyway, this is slightly off topic.  I hope the above makes some sense...

> A lock-in-page-index-order approach seems the simplest way to prevent 
> page deadlocks as Andrew suggested, and always starting to lock pages at 
> the lowest block- aligned file offset (rather than taking a page lock, 
> dropping it, locking earlier pages, reaquiring the later one, etc) - 
> that can't really be done inside the filesystems though.

Indeed.  But I don't think we would want to write out whole logical blocks 
at once unless it was actuall all dirty data.  Why write out loads when 
you can get away with as little as 512 bytes or PAGE_CACHE_SIZE in 
majority of cases?  In NTFS the logical block size can go into the mega 
bytes (in theory) and if we were forced to do such large writes every time 
performance would degrade really badly for most usage scenarios.

> So it's probably something that should be handled in generic page
> cache code such that the locking is done in common places for all
> filesystems using large i_blkbits values, and such that locking is
> done before the filesystem-specific read/writepage(s) routines are
> called, so that they don't have to be changed to do page locking
> any differently.

Yes, this would have advantages.  In fact this may be the point where we 
would actually make PAGE_CACHE_SIZE dynamic (but presumably only in 
multiples of PAGE_SIZE) but that is a rather big project in its own right.

For NTFS, I would prefer to not use a large i_blkbits as explained above.

However, I do not see why the VFS cannot provide one or more 
library/helper functions to do "lock multiple pages with start_index, 
end_index, already_locked_page, writeback_control/NULL, etc".  NTFS would 
then just call this from prepare_write and writepage/writepages.  And the 
compression engine (once we implement write to compressed files) may well 
need to use this, too.  And if XFS would find it useful then having a VFS 
based helper function would be sensible.

I am going to go ahead and cook something up for NTFS and bounce it off 
you to see if it fits in with your requirements.  If it does than we can 
put it in the VFS rather than in NTFS otherwise we can perhaps come up 
with a compromise that works for both of us (and anyone else who would 
like to use this)...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
