Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbUAAXsu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 18:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbUAAXsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 18:48:50 -0500
Received: from smtp5.hy.skanova.net ([195.67.199.134]:20432 "EHLO
	smtp5.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261881AbUAAXss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 18:48:48 -0500
Date: Fri, 2 Jan 2004 00:47:11 +0100 (CET)
From: Peter Osterlund <petero2@telia.com>
X-X-Sender: petero@best.localdomain
To: Jens Axboe <axboe@suse.de>
cc: packet-writing <packet-writing@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: ext2 on a CD-RW
Message-ID: <Pine.LNX.4.44.0401020022060.2407-100000@telia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 May 2002, Jens Axboe wrote:

> On Tue, May 07 2002, Peter Osterlund wrote:
> > On Mon, 6 May 2002, Johnathan Hicks wrote:
> > 
> > > I thought some people here might find this amusing. After I
> > > quick-formatted a CD-RW with cdrwtool today I then did the
> > > following:
> > > 
> > > mke2fs -b 2048 /dev/pktcdvd0
> > > 
> > > It appears to work OK and I'm compiling a kernel on it as I type
> > > this. pktcdvd can't handle this properly unless the '-b 2048' is
> > > given for a pretty obvious reason. df tells me that the capacity of
> > > a disc formatted like this is 530MB so there is a few MB lost
> > > compared to UDF. I'm pretty sure this is a follish thing to do so
> > > would anyone care to give me some technical reasons why? :)
> > 
> > Yes, I have tested this too. It works in 2.4 but not in 2.5. In 2.5
> > sr.c complains about unaligned transfers when I try to mount the
> > filesystem. 2.4 has code (sr_scatter_pad) to handle unaligned
> > transfers, but that code was removed in 2.5, and I havn't yet
> > investigated how it is supposed to work without that code.
> 
> There's supposed to be a reblocking player in the middle, ala loop. This
> doesn't really work well for pktcdvd of course, so I'd suggest writing a
> helper for reading and writing sub-block size units.

I finally decided to investigate why this didn't work in the 2.5/2.6 code.
(My tests were made with the 2.6.1-rc1 code and the latest packet patch.)
There are two problems. The first is that the packet writing code forgot
to set the hardsect size. This is fixed by the following patch.

--- linux/drivers/block/pktcdvd.c.old	2004-01-02 00:23:57.000000000 +0100
+++ linux/drivers/block/pktcdvd.c	2004-01-02 00:24:01.000000000 +0100
@@ -2164,6 +2164,7 @@
 	request_queue_t *q = disks[pkt_get_minor(pd)]->queue;
 
 	blk_queue_make_request(q, pkt_make_request);
+	blk_queue_hardsect_size(q, CD_FRAMESIZE);
 	blk_queue_max_sectors(q, PACKET_MAX_SECTORS);
 	blk_queue_merge_bvec(q, pkt_merge_bvec);
 	q->queuedata = pd;

That's not enough to make it work though. If I create an ext2 filesystem
with 2kb blocksize, I hit a bug when I try to write some large files to
the filesystem. The problem is that the code in mpage_writepage() fails if
a page is mapped to disk across a packet boundary. In that case, the
bio_add_page() call at line 543 in mpage.c can fail even if the bio was
previously empty. The code then passes an empty bio to submit_bio(), which
triggers a bug at line 2303 in ll_rw_blk.c. This patch seems to fix the
problem.

--- linux/fs/mpage.c.old	2004-01-02 00:26:19.000000000 +0100
+++ linux/fs/mpage.c	2004-01-02 00:26:50.000000000 +0100
@@ -541,6 +541,11 @@
 
 	length = first_unmapped << blkbits;
 	if (bio_add_page(bio, page, length, 0) < length) {
+		if (!bio->bi_size) {
+			bio_put(bio);
+			bio = NULL;
+			goto confused;
+		}
 		bio = mpage_bio_submit(WRITE, bio);
 		goto alloc_new;
 	}

I noted that performance is quite bad with 2kb blocksize. It is a lot
faster with 4kb blocksize. (2kb blocksize with the udf filesystem is not
slow, only ext2 seems to have this problem.) Maybe the "confused" case
(which calls a_ops->writepage()) in mpage_writepage() isn't really meant
to be fast. Is there a better way to fix this problem?

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340

