Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267620AbRGPS2v>; Mon, 16 Jul 2001 14:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267621AbRGPS2e>; Mon, 16 Jul 2001 14:28:34 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:53080 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S267620AbRGPS2N>; Mon, 16 Jul 2001 14:28:13 -0400
Date: Mon, 16 Jul 2001 20:28:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Gianluca Anzolin <g.anzolin@inwind.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.7-pre6 can't complete e2fsck
Message-ID: <20010716202825.J11978@athlon.random>
In-Reply-To: <20010716132933.A216@fourier.home.intranet> <20010716190653.E11978@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010716190653.E11978@athlon.random>; from andrea@suse.de on Mon, Jul 16, 2001 at 07:06:53PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2001 at 07:06:53PM +0200, Andrea Arcangeli wrote:
> I can reproduce so it will be fixed in the next release. thanks for the

Ok, it was because I developed the blkdev-pagecache and
00_drop_async-io-get_bh-1 patches in two separated trees.

When both patches passed all the regression testing I merged both
into 2.4.7pre6aa1 but unfortunately no reject reminded me I had to drop
the get_bh from the async handler used by the blkdev pagecache (sorry!).

So in short this incremental patch on top of 2.4.7pre6aa1 will fix your
problem (at least it did for mine):

--- 2.4.7pre6aa1/fs/block_dev.c.~1~	Mon Jul 16 19:16:44 2001
+++ 2.4.7pre6aa1/fs/block_dev.c	Mon Jul 16 20:15:51 2001
@@ -105,7 +105,6 @@
 	do {
 		lock_buffer(bh);
 		set_buffer_async_io(bh);
-		atomic_inc(&bh->b_count);
 		set_bit(BH_Uptodate, &bh->b_state);
 		clear_bit(BH_Dirty, &bh->b_state);
 		bh = bh->b_this_page;
@@ -189,7 +188,6 @@
 		struct buffer_head * bh = arr[i];
 		lock_buffer(bh);
 		set_buffer_async_io(bh);
-		atomic_inc(&bh->b_count);
 	}
 
 	/* Stage 3: start the IO */


I guess I will keep the above patch separated from the blkdev patch to
ensure I won't forget about it (and also because if for whatever reason
somebody can see any reason for which dropping the
00_drop_async-io-get_bh-1 patch could be a good thing in the long run, I
won't need to rediff the blkdev patch)

Andrea
