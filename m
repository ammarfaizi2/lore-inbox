Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266763AbSLPKLd>; Mon, 16 Dec 2002 05:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266665AbSLPKKV>; Mon, 16 Dec 2002 05:10:21 -0500
Received: from cmailg3.svr.pol.co.uk ([195.92.195.173]:35856 "EHLO
	cmailg3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266686AbSLPKJm>; Mon, 16 Dec 2002 05:09:42 -0500
Date: Mon, 16 Dec 2002 10:17:48 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 17/19
Message-ID: <20021216101748.GR7407@reti>
References: <20021211121749.GA20782@reti> <Pine.LNX.4.44.0212151649180.2445-100000@home.transmeta.com> <20021216100457.GA7407@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216100457.GA7407@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

o  If there's an error you still need to call bio_endio with bio->bi_size
   as the 'done' param.

o  Simplify clone_endio.

[Kevin Corry]
--- diff/drivers/md/dm.c	2002-12-16 09:41:34.000000000 +0000
+++ source/drivers/md/dm.c	2002-12-16 09:41:39.000000000 +0000
@@ -249,7 +249,7 @@
 			/* nudge anyone waiting on suspend queue */
 			wake_up(&io->md->wait);
 
-		bio_endio(io->bio, io->error ? 0 : io->bio->bi_size, io->error);
+		bio_endio(io->bio, io->bio->bi_size, io->error);
 		free_io(io->md, io);
 	}
 }
@@ -258,16 +258,11 @@
 {
 	struct dm_io *io = bio->bi_private;
 
-	/*
-	 * Only call dec_pending if the clone has completely
-	 * finished.  If a partial io errors I'm assuming it won't
-	 * be requeued.  FIXME: check this.
-	 */
-	if (error || !bio->bi_size) {
-		dec_pending(io, error);
-		bio_put(bio);
-	}
+	if (bio->bi_size)
+		return 1;
 
+	dec_pending(io, error);
+	bio_put(bio);
 	return 0;
 }
 
@@ -454,13 +449,13 @@
 		up_read(&md->lock);
 
 		if (bio_rw(bio) == READA) {
-			bio_io_error(bio, 0);
+			bio_io_error(bio, bio->bi_size);
 			return 0;
 		}
 
 		r = queue_io(md, bio);
 		if (r < 0) {
-			bio_io_error(bio, 0);
+			bio_io_error(bio, bio->bi_size);
 			return 0;
 
 		} else if (r == 0)
