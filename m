Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWERS77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWERS77 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 14:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWERS77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 14:59:59 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:27593 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751377AbWERS76
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 14:59:58 -0400
Date: Thu, 18 May 2006 12:59:56 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] sector_t overflow in block layer
Message-ID: <20060518185955.GK5964@schatzie.adilger.int>
Mail-Followup-To: "Stephen C. Tweedie" <sct@redhat.com>,
	"ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
References: <1147849273.16827.27.camel@localhost.localdomain> <m3odxxukcp.fsf@bzzz.home.net> <1147884610.16827.44.camel@localhost.localdomain> <m34pzo36d4.fsf@bzzz.home.net> <1147888715.12067.38.camel@dyn9047017100.beaverton.ibm.com> <m364k4zfor.fsf@bzzz.home.net> <20060517235804.GA5731@schatzie.adilger.int> <1147947803.5464.19.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147947803.5464.19.camel@sisko.sctweedie.blueyonder.co.uk>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 18, 2006  11:23 +0100, Stephen C. Tweedie wrote:
> On Wed, 2006-05-17 at 17:58 -0600, Andreas Dilger wrote:
> > > the next question then is should we fail mounting of any >2TB fs
> > > w/o CONFIG_LBD or it would be better to mount IFF the fs has
> > > no allocated blocks beyond 2TB?
> > 
> > This could actually be the primary source of the > 2TB filesystem
> > corruption problem that I've seen reported occasionally.  The question
> > is if CONFIG_LBD isn't enabled will the kernel silently truncate
> > block-layer offsets?  
>
> It appears so, yes.  bread() goes through submit_bh(), which converts
> blocknr to sector with:
> 
> 	bio->bi_sector = bh->b_blocknr * (bh->b_size >> 9);
> 
> without checking for overflow.
> 
> > This would seem to be a critical kernel bug that should be addressed in
> > the block subsystem to prevent use of block devices > 2TB if sector_t
> > is only 32 bits.
> 
> I think the arguments are a little less strong about restricting block
> device access in such cases, but certainly filesystem access needs to be
> properly checked.  We need to check the *filesystem* size, not the
> device size (they are usually the same but they don't strictly have to
> be), both on mount and on attempted resize.

At least the submit_bh() code should return an error in this case
regardless of who the caller is.  If ext[23] and other filesystems
check this themselves at mount time that is of course also prudent.

Patch has not been more than compile tested but it is a pretty serious
problem dating back a long time so I'm posting it for review anyways.

There are several ways to check for the 64-bit overflow, the efficiency
of which depends on the architecture.  We could alternately shift b_blocknr
by >> 41 or change the mask, for example.  The primary concern is really
the 32-bit overflow and resulting silent and massive data corruption
when CONFIG_LBD isn't enabled.

It is coincidental that mke2fs will clobber the primary group's metadata
(bitmaps, inode table) when formatting such a filesystem, but since this
data is identical at format time (group 0 offsets and group 16384 offsets
modulo 2TB are the same) it is very hard to detect before corruption hits.

==================== buffer_overflow.diff ===============================
--- ./fs/buffer.c.orig	2006-05-18 12:15:45.000000000 -0600
+++ ./fs/buffer.c	2006-05-18 12:09:20.000000000 -0600
@@ -2758,12 +2784,32 @@ static int end_bio_bh_io_sync(struct bio
 int submit_bh(int rw, struct buffer_head * bh)
 {
 	struct bio *bio;
+	unsigned long long sector;
 	int ret = 0;
 
 	BUG_ON(!buffer_locked(bh));
 	BUG_ON(!buffer_mapped(bh));
 	BUG_ON(!bh->b_end_io);
 
+	/* Check if we overflow sector_t when computing the sector offset.  */
+	sector = (unsigned long long)bh->b_blocknr * (bh->b_size >> 9);
+#if !defined(CONFIG_LBD) && BITS_PER_LONG == 32
+	if (unlikely(sector != (sector_t)sector))
+#else
+	if (unlikely(((bh->b_blocknr >> 32) * (bh->b_size >> 9)) >=
+		     0xffffffff00000000ULL))
+#endif
+	{
+		printk(KERN_ERR "IO past maximum addressable sector"
+#if !defined(CONFIG_LBD) && BITS_PER_LONG == 32
+		       "- CONFIG_LBD not enabled"
+#endif
+		       "\n");
+		buffer_io_error(bh);
+
+		return -EOVERFLOW;
+	}
+
 	if (buffer_ordered(bh) && (rw == WRITE))
 		rw = WRITE_BARRIER;
 
@@ -2780,7 +2828,7 @@ int submit_bh(int rw, struct buffer_head
 	 */
 	bio = bio_alloc(GFP_NOIO, 1);
 
-	bio->bi_sector = bh->b_blocknr * (bh->b_size >> 9);
+	bio->bi_sector = sector;
 	bio->bi_bdev = bh->b_bdev;
 	bio->bi_io_vec[0].bv_page = bh->b_page;
 	bio->bi_io_vec[0].bv_len = bh->b_size;


Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

