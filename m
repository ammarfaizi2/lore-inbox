Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272315AbTHIKPh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 06:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272316AbTHIKPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 06:15:37 -0400
Received: from [203.145.184.221] ([203.145.184.221]:21253 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S272315AbTHIKPb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 06:15:31 -0400
Subject: Re: [PATCH 2.6.0-test3] compile fix for driver/block/paride/pd.c
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: Nick Piggin <piggin@cyberone.com.au>, Jens Axboe <axboe@suse.de>
Cc: trivial@rustcorp.com.au, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3F34BEC4.8090701@cyberone.com.au>
References: <1060421994.1276.6.camel@lima.royalchallenge.com> 
	<3F34BEC4.8090701@cyberone.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 09 Aug 2003 16:03:43 +0530
Message-Id: <1060425223.1276.22.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Sat, 2003-08-09 at 14:58, Nick Piggin wrote:
> blk_init_queue now returns a request queue, so this
> patch will not work properly. See the changes in
> test2 -> test3 for how to do it correctly.

Thanks for pointing out. Here is the one with proper fixes. Compiles
fine though not tested.


This patch modifies the code to use the new blk_init_queue.

pd.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff -urN linux-2.6.0-test3/drivers/block/paride/pd.c linux-2.6.0-test3-nvk/drivers/block/paride/pd.c
--- linux-2.6.0-test3/drivers/block/paride/pd.c	2003-07-28 10:43:52.000000000 +0530
+++ linux-2.6.0-test3-nvk/drivers/block/paride/pd.c	2003-08-09 15:58:56.000000000 +0530
@@ -654,7 +654,7 @@
 	return pd_identify(disk);
 }
 
-static struct request_queue pd_queue;
+static struct request_queue* pd_queue;
 
 static int pd_detect(void)
 {
@@ -704,7 +704,7 @@
 			set_capacity(p, disk->capacity);
 			disk->gd = p;
 			p->private_data = disk;
-			p->queue = &pd_queue;
+			p->queue = pd_queue;
 			add_disk(p);
 		}
 	}
@@ -782,7 +782,7 @@
 	spin_lock_irqsave(&pd_lock, saved_flags);
 	end_request(pd_req, success);
 	pd_busy = 0;
-	do_pd_request(&pd_queue);
+	do_pd_request(pd_queue);
 	spin_unlock_irqrestore(&pd_lock, saved_flags);
 }
 
@@ -893,13 +893,18 @@
 	if (register_blkdev(major, name))
 		return -1;
 
-	blk_init_queue(&pd_queue, do_pd_request, &pd_lock);
-	blk_queue_max_sectors(&pd_queue, cluster);
+	pd_queue = blk_init_queue(do_pd_request, &pd_lock);
+	if (!pd_queue)
+		goto error;
+
+	blk_queue_max_sectors(pd_queue, cluster);
 
 	printk("%s: %s version %s, major %d, cluster %d, nice %d\n",
 	       name, name, PD_VERSION, major, cluster, nice);
 	pd_init_units();
 	if (!pd_detect()) {
+		blk_put_queue(pd_queue);
+error:
 		unregister_blkdev(major, name);
 		return -1;
 	}
@@ -920,7 +925,7 @@
 			pi_release(disk->pi);
 		}
 	}
-	blk_cleanup_queue(&pd_queue);
+	blk_put_queue(pd_queue);
 }
 
 MODULE_LICENSE("GPL");

