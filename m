Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbUCWHTk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 02:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUCWHTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 02:19:40 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:20744 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S262286AbUCWHTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 02:19:37 -0500
Message-ID: <405FE501.6030704@cs.wisc.edu>
Date: Mon, 22 Mar 2004 23:19:29 -0800
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: [PATCH] catch error when completing bio pairs
Content-Type: multipart/mixed;
 boundary="------------080000060001030305050203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080000060001030305050203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

A couple of drivers can sometimes fail the first
segments in a bio then requeue the rest of the request. In this
situation, if the last part of the bio completes successfully
bio_pair_end_* will miss that the beginging of the bio had
failed becuase they just return one when bi_size is not yet
zero. The attached patch moves the error value test before
the bi_size to catch the above case.

Mike Christie

--------------080000060001030305050203
Content-Type: text/plain;
 name="biopair-err.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="biopair-err.patch"

--- linux-2.6.5-rc2/fs/bio.c	2004-03-22 22:44:28.000000000 -0800
+++ linux-2.6.5-rc2-ec/fs/bio.c	2004-03-22 23:00:18.000000000 -0800
@@ -701,11 +701,12 @@ static int bio_pair_end_1(struct bio * b
 {
 	struct bio_pair *bp = container_of(bi, struct bio_pair, bio1);
 
-	if (bi->bi_size)
-		return 1;
 	if (err)
 		bp->error = err;
 
+	if (bi->bi_size)
+		return 1;
+
 	bio_pair_release(bp);
 	return 0;
 }
@@ -714,11 +715,12 @@ static int bio_pair_end_2(struct bio * b
 {
 	struct bio_pair *bp = container_of(bi, struct bio_pair, bio2);
 
-	if (bi->bi_size)
-		return 1;
 	if (err)
 		bp->error = err;
 
+	if (bi->bi_size)
+		return 1;
+
 	bio_pair_release(bp);
 	return 0;
 }

--------------080000060001030305050203--

