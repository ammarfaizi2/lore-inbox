Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262646AbSJDUpy>; Fri, 4 Oct 2002 16:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262665AbSJDUpy>; Fri, 4 Oct 2002 16:45:54 -0400
Received: from packet.digeo.com ([12.110.80.53]:32736 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262646AbSJDUpw>;
	Fri, 4 Oct 2002 16:45:52 -0400
Message-ID: <3D9DFF47.6B0C3CED@digeo.com>
Date: Fri, 04 Oct 2002 13:51:19 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steve Lord <lord@sgi.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 O)DIRECT problem
References: <3D9DFA34.581D9D98@digeo.com> <1033763896.6896.101.camel@jen.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Oct 2002 20:51:19.0603 (UTC) FILETIME=[CA55C030:01C26BE7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lord wrote:
> 
> On Fri, 2002-10-04 at 15:29, Andrew Morton wrote:
> > Steve Lord wrote:
> > > Either the flush needs to happen before the bounds checks, or the
> > > invalidate should only be done on a successful write. It looks
> > > pretty hard to detect the latter case with the current structure,
> > > we can get EINVAL from the bounds check and possibly from an
> > > aligned, but invalid memory address being passed in.
> >
> > Yes I agree; let's just do the sync before any checks.
> >
> > I think it should be moved into generic_file_direct_IO(),
> > because that's the place where the invalidation happens, yes?
> 
> OK, sounds good to me, I will let my tests churn away on that
> version and see what happens. I think something else is doing
> the same thing to me elsewhere, but it might well be an xfs
> specific case.

I queued the below patch.

BTW, I'm sitting on a patch from Badari which allows the direct-io
code to perform 512-byte-aligned and multiple-of-512-byte-sized
IO against a 4k blocksize filesystem.  We make (reasonable)
assumptions about the return value from get_block(): scale it
from softblocksize up to sectors and then add an offset. 

And we do weird things with the ZERO_PAGE to cater for the case
where the filesystem block is buffer_new() - use bits of the
ZERO_PAGE to fill out the gaps in the BIOs to zero out bits of
disk blocks.

We're also currently requiring that the filesystem pass its backing
block_device * into generic_direct_IO so we can run bdev_hardsectsize()
at the right time, which I'm not 100% happy with.

But relaxing the 4k alignment requirement has great value, so
we'll persist with that.  I'll include that in the next -mm;
you may want to take a look at it.



patch:

If the alignment checks in generic_direct_IO() fail, we end up not
forcing writeback of dirty pagecache pages, but we still run
invalidate_inode_pages2().  The net result is that dirty pagecache gets
incorrectly removed.  I guess this will expose unwritten disk blocks.

So move the sync up into generic_file_direct_IO(), where we perform the
invalidation.  So we know that pagecache and disk are in sync before we
do anything else.



 fs/direct-io.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

--- 2.5.40/fs/direct-io.c~direct-io-invalidation-fix	Fri Oct  4 13:41:37 2002
+++ 2.5.40-akpm/fs/direct-io.c	Fri Oct  4 13:41:37 2002
@@ -620,13 +620,11 @@ generic_direct_IO(int rw, struct inode *
 	int seg;
 	size_t size;
 	unsigned long addr;
-	struct address_space *mapping = inode->i_mapping;
 	unsigned blocksize_mask = (1 << inode->i_blkbits) - 1;
 	ssize_t retval = -EINVAL;
 
-	if (offset & blocksize_mask) {
+	if (offset & blocksize_mask)
 		goto out;
-	}
 
 	/* Check the memory alignment.  Blocks cannot straddle pages */
 	for (seg = 0; seg < nr_segs; seg++) {
@@ -636,14 +634,6 @@ generic_direct_IO(int rw, struct inode *
 			goto out;	
 	}
 
-	if (mapping->nrpages) {
-		retval = filemap_fdatawrite(mapping);
-		if (retval == 0)
-			retval = filemap_fdatawait(mapping);
-		if (retval)
-			goto out;
-	}
-
 	retval = direct_io_worker(rw, inode, iov, offset, nr_segs, get_blocks);
 out:
 	return retval;
@@ -656,8 +646,17 @@ generic_file_direct_IO(int rw, struct in
 	struct address_space *mapping = inode->i_mapping;
 	ssize_t retval;
 
+	if (mapping->nrpages) {
+		retval = filemap_fdatawrite(mapping);
+		if (retval == 0)
+			retval = filemap_fdatawait(mapping);
+		if (retval)
+			goto out;
+	}
+
 	retval = mapping->a_ops->direct_IO(rw, inode, iov, offset, nr_segs);
 	if (inode->i_mapping->nrpages)
 		invalidate_inode_pages2(inode->i_mapping);
+out:
 	return retval;
 }

.
