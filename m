Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317767AbSGPG5b>; Tue, 16 Jul 2002 02:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317771AbSGPG5a>; Tue, 16 Jul 2002 02:57:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55559 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317767AbSGPG53>;
	Tue, 16 Jul 2002 02:57:29 -0400
Message-ID: <3D33C64A.7491B591@zip.com.au>
Date: Tue, 16 Jul 2002 00:07:54 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG] loop.c oopses
References: <20020716062453.GK1022@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> loop.c oopses when bio_copy() returns NULL. This was encountered while
> running dbench 16 on a loopback-mounted reiserfs filesystem.

ugh.  GFP_NOIO is evil.  I guess it's better to add __GFP_HIGH
there, but it's not a happy solution.

> ...
> 
> If what I've done is proper, it may be necessary to allow
> try_to_free_buffers() to fail if (!was_uptodate && PageUptodate(page))

Is OK - that's just overeager whining.  You received an IO error
during a write.  This marks the buffer not uptodate.  (Heaven
knows why, because it clearly *is* uptodate).  And try_to_free_buffers
doesn't like seeing a non-uptodate buffer against an uptodate
page: it violates the alleged page/buffer state coherency.

Some sucker needs to go through and test-n-fix all the IO handling
paths.  He'll probably leave that until after "feature freeze".

 loop.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

--- 2.5.25/drivers/block/loop.c~wli-loop-fix	Mon Jul 15 23:58:10 2002
+++ 2.5.25-akpm/drivers/block/loop.c	Mon Jul 15 23:59:32 2002
@@ -457,8 +457,9 @@ static struct bio *loop_get_buffer(struc
 		goto out_bh;
 	}
 
-	bio = bio_copy(rbh, GFP_NOIO, rbh->bi_rw & WRITE);
-
+	bio = bio_copy(rbh, GFP_NOIO|__GFP_HIGH, rbh->bi_rw & WRITE);
+	if (bio == NULL)
+		goto out;
 	bio->bi_end_io = loop_end_io_transfer;
 	bio->bi_private = rbh;
 
@@ -466,7 +467,7 @@ out_bh:
 	bio->bi_sector = rbh->bi_sector + (lo->lo_offset >> 9);
 	bio->bi_rw = rbh->bi_rw;
 	bio->bi_bdev = lo->lo_device;
-
+out:
 	return bio;
 }
 
@@ -537,6 +538,8 @@ static int loop_make_request(request_que
 	 * piggy old buffer on original, and submit for I/O
 	 */
 	new_bio = loop_get_buffer(lo, old_bio);
+	if (new_bio == NULL)
+		goto out;
 	IV = loop_get_iv(lo, old_bio->bi_sector);
 	if (rw == WRITE) {
 		if (bio_transfer(lo, new_bio, old_bio))

.
