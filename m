Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUCKJN0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 04:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbUCKJN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 04:13:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53135 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261610AbUCKJNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 04:13:24 -0500
Date: Thu, 11 Mar 2004 09:14:30 +0000
From: Joe Thornber <thornber@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, kenneth.w.chen@intel.com,
       Andrew Morton <akpm@osdl.org>, thornber@redhat.com
Subject: Re: [PATCH] backing dev unplugging
Message-ID: <20040311091430.GB2138@reti>
References: <20040310124507.GU4949@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310124507.GU4949@suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens,

Small locking changes to the dm bits.  I've just seen that you've
posted an updated version of your patch to lkml, so I'll post another
version of this patch to that thread too.

- Joe


Fix md->map protection in the global unplug removal patch.
--- diff/drivers/md/dm.c	2004-03-11 08:41:27.000000000 +0000
+++ source/drivers/md/dm.c	2004-03-11 08:57:14.000000000 +0000
@@ -578,8 +578,12 @@ static int dm_request(request_queue_t *q
 static void dm_unplug_all(request_queue_t *q)
 {
 	struct mapped_device *md = q->queuedata;
+	struct dm_table *map = dm_get_table(md);
 
-	dm_table_unplug_all(md->map);
+	if (map) {
+		dm_table_unplug_all(map);
+		dm_table_put(map);
+	}
 }
 
 static int dm_any_congested(void *congested_data, int bdi_bits)
@@ -904,11 +908,17 @@ int dm_suspend(struct mapped_device *md)
 	add_wait_queue(&md->wait, &wait);
 	up_write(&md->lock);
 
+	/* unplug */
+	map = dm_get_table(md);
+	if (map) {
+		dm_table_unplug_all(map);
+		dm_table_put(map);
+	}
+
 	/*
 	 * Then we wait for the already mapped ios to
 	 * complete.
 	 */
-	dm_table_unplug_all(md->map);
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
 
@@ -953,10 +963,9 @@ int dm_resume(struct mapped_device *md)
 	def = bio_list_get(&md->deferred);
 	__flush_deferred_io(md, def);
 	up_write(&md->lock);
+	dm_table_unplug_all(map);
 	dm_table_put(map);
 
-	dm_table_unplug_all(md->map);
-
 	return 0;
 }
 
