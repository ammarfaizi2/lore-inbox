Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266025AbUBJRGZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266024AbUBJREV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:04:21 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:60173 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S266023AbUBJRBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:01:08 -0500
Date: Tue, 10 Feb 2004 17:00:39 +0000
From: Joe Thornber <thornber@redhat.com>
To: Joe Thornber <thornber@redhat.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [Patch 5/10] dm: Tidy up the error path for alloc_dev()
Message-ID: <20040210170039.GK27507@reti>
References: <20040210163548.GC27507@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210163548.GC27507@reti>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tidy up the error path for alloc_dev()
--- diff/drivers/md/dm.c	2004-02-10 16:11:37.000000000 +0000
+++ source/drivers/md/dm.c	2004-02-10 16:11:43.000000000 +0000
@@ -560,41 +560,28 @@
 
 	/* get a minor number for the dev */
 	r = persistent ? specific_minor(minor) : next_free_minor(&minor);
-	if (r < 0) {
-		kfree(md);
-		return NULL;
-	}
+	if (r < 0)
+		goto bad1;
 
 	memset(md, 0, sizeof(*md));
 	init_rwsem(&md->lock);
 	atomic_set(&md->holders, 1);
 
 	md->queue = blk_alloc_queue(GFP_KERNEL);
-	if (!md->queue) {
-		kfree(md);
-		return NULL;
-	}
+	if (!md->queue)
+		goto bad1;
 
 	md->queue->queuedata = md;
 	blk_queue_make_request(md->queue, dm_request);
 
 	md->io_pool = mempool_create(MIN_IOS, mempool_alloc_slab,
 				     mempool_free_slab, _io_cache);
-	if (!md->io_pool) {
-		free_minor(minor);
-		blk_put_queue(md->queue);
-		kfree(md);
-		return NULL;
-	}
+ 	if (!md->io_pool)
+ 		goto bad2;
 
 	md->disk = alloc_disk(1);
-	if (!md->disk) {
-		mempool_destroy(md->io_pool);
-		free_minor(minor);
-		blk_put_queue(md->queue);
-		kfree(md);
-		return NULL;
-	}
+	if (!md->disk)
+		goto bad3;
 
 	md->disk->major = _major;
 	md->disk->first_minor = minor;
@@ -609,6 +596,16 @@
 	init_waitqueue_head(&md->eventq);
 
 	return md;
+
+
+ bad3:
+	mempool_destroy(md->io_pool);
+ bad2:
+	blk_put_queue(md->queue);
+	free_minor(minor);
+ bad1:
+	kfree(md);
+	return NULL;
 }
 
 static void free_dev(struct mapped_device *md)
