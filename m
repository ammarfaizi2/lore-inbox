Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272459AbTHJH3Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 03:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272469AbTHJH3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 03:29:25 -0400
Received: from [203.145.184.221] ([203.145.184.221]:32781 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S272459AbTHJH3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 03:29:23 -0400
Subject: Re: PROBLEM: drivers/block/paride/pd.c fails to compile at line 896
	on	i686
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: pmjcovello@shaw.ca
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1060450071.11078.6.camel@localhost.localdomain>
References: <1060450071.11078.6.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 10 Aug 2003 13:19:20 +0530
Message-Id: <1060501761.1354.2.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 2003-08-09 at 22:57, Thomas Covello wrote:
> drivers/block/paride/pd.c fails to compile at line 896 on an i686.

Can you try this patch and let us know if it works for you.


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


