Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266645AbSLPKEG>; Mon, 16 Dec 2002 05:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266560AbSLPKCc>; Mon, 16 Dec 2002 05:02:32 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:20752 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266548AbSLPKBl>; Mon, 16 Dec 2002 05:01:41 -0500
Date: Mon, 16 Dec 2002 10:09:47 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 6/19
Message-ID: <20021216100947.GG7407@reti>
References: <20021211121749.GA20782@reti> <Pine.LNX.4.44.0212151649180.2445-100000@home.transmeta.com> <20021216100457.GA7407@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216100457.GA7407@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

minor change for dm-stripe.c. Tests for correct chunksize before it allocates
the stripe context. [Heinz Mauelshagen]

--- diff/drivers/md/dm-stripe.c	2002-11-18 10:11:54.000000000 +0000
+++ source/drivers/md/dm-stripe.c	2002-12-16 09:40:48.000000000 +0000
@@ -117,6 +117,14 @@
 		return -EINVAL;
 	}
 
+	/*
+	 * chunk_size is a power of two
+	 */
+	if (!chunk_size || (chunk_size & (chunk_size - 1))) {
+		ti->error = "dm-stripe: Invalid chunk size";
+		return -EINVAL;
+	}
+
 	if (!multiple(ti->len, stripes, &width)) {
 		ti->error = "dm-stripe: Target length not divisable by "
 		    "number of stripes";
@@ -134,15 +142,6 @@
 	sc->stripe_width = width;
 	ti->split_io = chunk_size;
 
-	/*
-	 * chunk_size is a power of two
-	 */
-	if (!chunk_size || (chunk_size & (chunk_size - 1))) {
-		ti->error = "dm-stripe: Invalid chunk size";
-		kfree(sc);
-		return -EINVAL;
-	}
-
 	sc->chunk_mask = ((sector_t) chunk_size) - 1;
 	for (sc->chunk_shift = 0; chunk_size; sc->chunk_shift++)
 		chunk_size >>= 1;
