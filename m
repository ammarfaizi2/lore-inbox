Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbTIEG5b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 02:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbTIEG5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 02:57:31 -0400
Received: from dyn-ctb-210-9-244-140.webone.com.au ([210.9.244.140]:42757 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262257AbTIEG5T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 02:57:19 -0400
Message-ID: <3F5833BA.5090909@cyberone.com.au>
Date: Fri, 05 Sep 2003 16:56:58 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@kernel.dk>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix IO hangs
Content-Type: multipart/mixed;
 boundary="------------080800070706040505050407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080800070706040505050407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi, sorry for the hangs, everyone. I think I have it worked out, but
testers and an ack from Jens would be good.

The insert_here code now does as advertised. The big difference being
that regular blk_fs_requests will be subject to it (required for SCSI
requeue). Unfortunately ll_rw_blk.c misuses it and will sometimes try
to insert at requests which are not on the dispatch list, causing the
badness.

It looks like the code was maybe used to provide an insertion hint
for the elevator. The RB tree has now eliminated that requirement even
if the code did work. Which it doesn't.

I can't reproduce the hangs with this patch. Please test.


Aside, insert_here really seems to be quite dangerous to me. I think
combination of barriers and an "insert at start/end" flag would be
enough.


--------------080800070706040505050407
Content-Type: text/plain;
 name="elv-insert_here-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="elv-insert_here-fix"

--- archs/linux-2.6/drivers/block/ll_rw_blk.c	2003-09-05 16:46:02.000000000 +1000
+++ linux-2.6/drivers/block/ll_rw_blk.c	2003-09-05 16:35:39.000000000 +1000
@@ -2060,7 +2060,7 @@ get_rq:
 	req->rq_disk = bio->bi_bdev->bd_disk;
 	req->start_time = jiffies;
 
-	add_request(q, req, insert_here);
+	add_request(q, req, NULL);
 out:
 	if (freereq)
 		__blk_put_request(q, freereq);

--------------080800070706040505050407--

