Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274979AbTHLCGa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 22:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274980AbTHLCGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 22:06:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27271 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S274979AbTHLCG1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 22:06:27 -0400
Date: Tue, 12 Aug 2003 03:06:25 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: [FWD: Bug in drivers/block/paride/pd.c]
Message-ID: <20030812020625.GA454@parcelfarce.linux.theplanet.co.uk>
References: <098FA428.01C2B229.005FFA64@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <098FA428.01C2B229.005FFA64@netscape.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 08:34:49PM -0400, A1tmblwd@netscape.net wrote:
> Hi, I sent this message to the original author; however, I am not certain that he is maintaining the code or is reachable at the address provided. Please forward to the appropriate party.

diff -urN B3-imajor/drivers/block/paride/pd.c B3-pd/drivers/block/paride/pd.c
--- B3-imajor/drivers/block/paride/pd.c	Mon Jul 28 11:13:03 2003
+++ B3-pd/drivers/block/paride/pd.c	Mon Aug 11 17:11:49 2003
@@ -654,7 +654,7 @@
 	return pd_identify(disk);
 }
 
-static struct request_queue pd_queue;
+static struct request_queue *pd_queue;
 
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
 
@@ -890,20 +890,30 @@
 {
 	if (disable)
 		return -1;
-	if (register_blkdev(major, name))
-		return -1;
 
-	blk_init_queue(&pd_queue, do_pd_request, &pd_lock);
-	blk_queue_max_sectors(&pd_queue, cluster);
+	pd_queue = blk_init_queue(do_pd_request, &pd_lock);
+	if (!pd_queue)
+		goto out1;
+
+	blk_queue_max_sectors(pd_queue, cluster);
+
+	if (register_blkdev(major, name))
+		goto out2;
 
 	printk("%s: %s version %s, major %d, cluster %d, nice %d\n",
 	       name, name, PD_VERSION, major, cluster, nice);
 	pd_init_units();
-	if (!pd_detect()) {
-		unregister_blkdev(major, name);
-		return -1;
-	}
+	if (!pd_detect())
+		goto out3;
+
 	return 0;
+
+out3:
+	unregister_blkdev(major, name);
+out2:
+	blk_cleanup_queue(pd_queue);
+out1:
+	return -1;
 }
 
 static void __exit pd_exit(void)
@@ -920,7 +930,7 @@
 			pi_release(disk->pi);
 		}
 	}
-	blk_cleanup_queue(&pd_queue);
+	blk_cleanup_queue(pd_queue);
 }
 
 MODULE_LICENSE("GPL");
