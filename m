Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbWC1WY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWC1WY0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWC1WY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:24:26 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:39565 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932455AbWC1WYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:24:24 -0500
Date: Wed, 29 Mar 2006 08:23:45 +1000
From: Nathan Scott <nathans@sgi.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       lkml <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com
Subject: Re: kernel BUG at fs/direct-io.c:916!
Message-ID: <20060329082345.G871924@wobbly.melbourne.sgi.com>
References: <20060326230206.06C1EE083AAB@knarzkiste.dyndns.org> <20060326180440.GA4776@charite.de> <20060326184644.GC4776@charite.de> <20060327080811.D753448@wobbly.melbourne.sgi.com> <20060326230358.GG4776@charite.de> <20060327060436.GC2481@frodo> <20060327110342.GX21946@charite.de> <20060328050135.GA2177@frodo> <1143567049.26106.2.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1143567049.26106.2.camel@dyn9047017100.beaverton.ibm.com>; from pbadari@us.ibm.com on Tue, Mar 28, 2006 at 09:30:44AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 09:30:44AM -0800, Badari Pulavarty wrote:
> Thanks for working this out. You may want to add a description
> to the patch. Like:
> 
> "inode->i_blkbits should be used instead of dio->blkbits, as
> it may not indicate the filesystem block size all the time".

Will do, thanks.  Oh, another thing - what is the situation
where a NULL bdev would be passed into __blockdev_direct_IO?
All the filesystems seem to pass i_sb->s_bdev, so I guess it
must be blkdev_direct_IO - can I_BDEV(inode) ever be NULL on
a block device inode (doesn't sound right)?  If it cannot, I
suppose we should remove those NULL bdev checks too...

cheers.

-- 
Nathan


Index: xfs-linux-2.6/fs/direct-io.c
===================================================================
--- xfs-linux-2.6.orig/fs/direct-io.c
+++ xfs-linux-2.6/fs/direct-io.c
@@ -1186,8 +1186,8 @@ __blockdev_direct_IO(int rw, struct kioc
 	size_t size;
 	unsigned long addr;
 	unsigned blkbits = inode->i_blkbits;
-	unsigned bdev_blkbits = 0;
 	unsigned blocksize_mask = (1 << blkbits) - 1;
+	unsigned bdev_blkbits = blksize_bits(bdev_hardsect_size(bdev));
 	ssize_t retval = -EINVAL;
 	loff_t end = offset;
 	struct dio *dio;
@@ -1197,12 +1197,8 @@ __blockdev_direct_IO(int rw, struct kioc
 	if (rw & WRITE)
 		current->flags |= PF_SYNCWRITE;
 
-	if (bdev)
-		bdev_blkbits = blksize_bits(bdev_hardsect_size(bdev));
-
 	if (offset & blocksize_mask) {
-		if (bdev)
-			 blkbits = bdev_blkbits;
+		blkbits = bdev_blkbits;
 		blocksize_mask = (1 << blkbits) - 1;
 		if (offset & blocksize_mask)
 			goto out;
@@ -1214,8 +1210,7 @@ __blockdev_direct_IO(int rw, struct kioc
 		size = iov[seg].iov_len;
 		end += size;
 		if ((addr & blocksize_mask) || (size & blocksize_mask))  {
-			if (bdev)
-				 blkbits = bdev_blkbits;
+			blkbits = bdev_blkbits;
 			blocksize_mask = (1 << blkbits) - 1;
 			if ((addr & blocksize_mask) || (size & blocksize_mask))  
 				goto out;
