Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751609AbWCCVwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbWCCVwg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 16:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbWCCVwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 16:52:36 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:20381 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751609AbWCCVwf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 16:52:35 -0500
Subject: Re: [PATCH 0/4] map multiple blocks in get_block() and
	mpage_readpages()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, mcao@us.ibm.com
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060303123222.2fff68cf.akpm@osdl.org>
References: <1141075239.10542.19.camel@dyn9047017100.beaverton.ibm.com>
	 <20060301175230.4b96e9ad.akpm@osdl.org>
	 <1141405539.10542.68.camel@dyn9047017100.beaverton.ibm.com>
	 <20060303123222.2fff68cf.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-rY/tcN/cA7H7QQuWjbFi"
Date: Fri, 03 Mar 2006 13:54:02 -0800
Message-Id: <1141422842.10542.90.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rY/tcN/cA7H7QQuWjbFi
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2006-03-03 at 12:32 -0800, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > On Wed, 2006-03-01 at 17:52 -0800, Andrew Morton wrote:
> > > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > > >
> > > > I noticed decent improvements (reduced sys time) on JFS, XFS and ext3.
> > > > (on simple "dd" read tests).
> > > > 
> > > >          (rc3.mm1)      (rc3.mm1 + patches)
> > > > real    0m18.814s       0m18.482s
> > > > user    0m0.000s        0m0.004s
> > > > sys     0m3.240s        0m2.912s
> > > 
> > > With which filesystem?  XFS and JFS implement a larger-than-b_size
> > > ->get_block, but ext3 doesn't.  I'd expect ext3 system time to increase a
> > > bit, if anything?
> > 
> > These numbers are on JFS. With the current ext3 (mainline) - I did
> > find not-really-noticible increase in sys time (due to code overhead).
> > 
> > I tested on ext3 with Mingming's ext3 getblocks() support in -mm also,
> > which showed reduction in sys time.
> > 
> 
> OK, no surprises there.  Things will improve when someone gets around to
> doing multi-block get_block for ext3.

Well, I already did this when I tested Mingming's multiblock work for
ext3. (-mm only patch)

Thanks,
Badari



--=-rY/tcN/cA7H7QQuWjbFi
Content-Disposition: attachment; filename=ext3-getblocks.patch
Content-Type: text/x-patch; name=ext3-getblocks.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Mingming Cao recently added multi-block allocation support
for ext3, currently used only by DIO. I added support to map 
multiple blocks for mpage_readpages(). This patch add support 
for ext3_get_block() to deal with multi-block mapping.
Basically it renames ext3_direct_io_get_blocks() as ext3_get_block().

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>

Index: linux-2.6.16-rc5-mm2/fs/ext3/inode.c
===================================================================
--- linux-2.6.16-rc5-mm2.orig/fs/ext3/inode.c	2006-03-03 13:46:22.000000000 -0800
+++ linux-2.6.16-rc5-mm2/fs/ext3/inode.c	2006-03-03 13:52:15.000000000 -0800
@@ -936,9 +936,8 @@ out:
 
 #define DIO_CREDITS (EXT3_RESERVE_TRANS_BLOCKS + 32)
 
-static int
-ext3_direct_io_get_blocks(struct inode *inode, sector_t iblock,
-		struct buffer_head *bh_result, int create)
+static int ext3_get_block(struct inode *inode, sector_t iblock,
+			struct buffer_head *bh_result, int create)
 {
 	handle_t *handle = journal_current_handle();
 	int ret = 0;
@@ -987,12 +986,6 @@ get_block:
 	return ret;
 }
 
-static int ext3_get_block(struct inode *inode, sector_t iblock,
-			struct buffer_head *bh_result, int create)
-{
-	return ext3_direct_io_get_blocks(inode, iblock, bh_result, create);
-}
-
 /*
  * `handle' can be NULL if create is zero
  */
@@ -1645,10 +1638,10 @@ static ssize_t ext3_direct_IO(int rw, st
 
 	ret = blockdev_direct_IO(rw, iocb, inode, inode->i_sb->s_bdev, iov, 
 				 offset, nr_segs,
-				 ext3_direct_io_get_blocks, NULL);
+				 ext3_get_block, NULL);
 
 	/*
-	 * Reacquire the handle: ext3_direct_io_get_block() can restart the
+	 * Reacquire the handle: ext3_get_block() can restart the
 	 * transaction
 	 */
 	handle = journal_current_handle();

--=-rY/tcN/cA7H7QQuWjbFi--

