Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272673AbTG1GpX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 02:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272674AbTG1GpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 02:45:23 -0400
Received: from dm4-157.slc.aros.net ([66.219.220.157]:2946 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S272673AbTG1GpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 02:45:18 -0400
Message-ID: <3F24CA0D.4050901@aros.net>
Date: Mon, 28 Jul 2003 01:00:29 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Cc: Jens Axboe <axboe@suse.de>, Andrea Arcangeli <andrea@suse.de>,
       NeilBrown <neilb@cse.unsw.edu.au>
Subject: [PATCH 2.6.0-test2] fix broken blk_start_queue behavior
References: <3F2418D9.1020703@aros.net>
In-Reply-To: <3F2418D9.1020703@aros.net>
Content-Type: multipart/mixed;
 boundary="------------070608070809090109020109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070608070809090109020109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch changes the behavior of blk_start_queue() so that request 
queues really do start up again after blk_start_queue() is called (on 
queues that were previously stopped via blk_stop_queue). The patch 
applies against 2.6.0-test2. I have tested this patch with the use of 
blk_stop_queue and blk_start_queue in my branch of the nbd block device 
driver (not yet released). blk_start_queue is also used in 
./drivers/{block/cciss.c,ide/ide-io.c} which should see things function 
as intended now w.r.t. stopping and starting the request queue (but I do 
not know if anybody noticed that they weren't working correctly before). 
ide-io.c uses queue stop and start for power management handling. Please 
let me know if you've seen a problem before with that, especially if 
this patch fixes it - that will be happy news ;-)

--------------070608070809090109020109
Content-Type: text/plain;
 name="patch-2.6.0-test2-unplug"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.6.0-test2-unplug"

diff -urN linux-2.6.0-test2/drivers/block/ll_rw_blk.c linux-2.6.0-test2-unplug/drivers/block/ll_rw_blk.c
--- linux-2.6.0-test2/drivers/block/ll_rw_blk.c	2003-07-27 19:02:48.000000000 -0600
+++ linux-2.6.0-test2-unplug/drivers/block/ll_rw_blk.c	2003-07-28 00:36:35.366537142 -0600
@@ -1027,10 +1027,10 @@
  */
 static inline void __generic_unplug_device(request_queue_t *q)
 {
-	if (!blk_remove_plug(q))
+	if (test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags))
 		return;
 
-	if (test_bit(QUEUE_FLAG_STOPPED, &q->queue_flags))
+	if (!blk_remove_plug(q))
 		return;
 
 	del_timer(&q->unplug_timer);

--------------070608070809090109020109--

