Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264379AbTFIObj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 10:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbTFIOX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 10:23:57 -0400
Received: from smithers.nildram.co.uk ([195.112.4.34]:19716 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S264377AbTFIOWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 10:22:33 -0400
Date: Mon, 9 Jun 2003 15:36:11 +0100
From: Joe Thornber <thornber@sistina.com>
To: Joe Thornber <thornber@sistina.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/7] dm: new suspend/resume target methods
Message-ID: <20030609143611.GD11331@fib011235813.fsnet.co.uk>
References: <20030609142946.GA11331@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030609142946.GA11331@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some targets may perform io of their own volition, eg. a mirror
performing recovery, a cache target pulling in different chunks.  We
cannot let them perform this io while the device is suspended.  This
patch adds 2 new methods to the target type, which instruct the target
to suspend/resume itself.  All targets start in the suspended state,
so should expect an initial resume call.  Simple targets do not need
to implement these functions.
--- diff/drivers/md/dm-table.c	2003-06-09 15:05:02.000000000 +0100
+++ source/drivers/md/dm-table.c	2003-06-09 15:05:08.000000000 +0100
@@ -776,6 +776,31 @@
 	add_wait_queue(&t->eventq, wq);
 }
 
+void dm_table_suspend_targets(struct dm_table *t)
+{
+	int i;
+
+	for (i = 0; i < t->num_targets; i++) {
+		struct dm_target *ti = t->targets + i;
+
+		if (ti->type->suspend)
+			ti->type->suspend(ti);
+	}
+}
+
+void dm_table_resume_targets(struct dm_table *t)
+{
+	int i;
+
+	for (i = 0; i < t->num_targets; i++) {
+		struct dm_target *ti = t->targets + i;
+
+		if (ti->type->resume)
+			ti->type->resume(ti);
+	}
+}
+
+
 EXPORT_SYMBOL(dm_get_device);
 EXPORT_SYMBOL(dm_put_device);
 EXPORT_SYMBOL(dm_table_event);
--- diff/drivers/md/dm.c	2003-06-09 15:05:02.000000000 +0100
+++ source/drivers/md/dm.c	2003-06-09 15:05:08.000000000 +0100
@@ -678,6 +678,7 @@
 		free_dev(md);
 		return r;
 	}
+	dm_table_resume_targets(md->map);
 
 	*result = md;
 	return 0;
@@ -692,6 +693,8 @@
 {
 	if (atomic_dec_and_test(&md->holders)) {
 		DMWARN("destroying md");
+		if (!test_bit(DMF_SUSPENDED, &md->flags))
+			dm_table_suspend_targets(md->map);
 		__unbind(md);
 		free_dev(md);
 	}
@@ -781,6 +784,7 @@
 	down_write(&md->lock);
 	remove_wait_queue(&md->wait, &wait);
 	set_bit(DMF_SUSPENDED, &md->flags);
+	dm_table_suspend_targets(md->map);
 	up_write(&md->lock);
 
 	return 0;
@@ -797,6 +801,7 @@
 		return -EINVAL;
 	}
 
+	dm_table_resume_targets(md->map);
 	clear_bit(DMF_SUSPENDED, &md->flags);
 	clear_bit(DMF_BLOCK_IO, &md->flags);
 	def = md->deferred;
--- diff/drivers/md/dm.h	2003-06-09 15:05:02.000000000 +0100
+++ source/drivers/md/dm.h	2003-06-09 15:05:08.000000000 +0100
@@ -104,6 +104,8 @@
 struct list_head *dm_table_get_devices(struct dm_table *t);
 int dm_table_get_mode(struct dm_table *t);
 void dm_table_add_wait_queue(struct dm_table *t, wait_queue_t *wq);
+void dm_table_suspend_targets(struct dm_table *t);
+void dm_table_resume_targets(struct dm_table *t);
 
 /*-----------------------------------------------------------------
  * A registry of target types.
--- diff/include/linux/device-mapper.h	2003-06-09 15:05:02.000000000 +0100
+++ source/include/linux/device-mapper.h	2003-06-09 15:05:08.000000000 +0100
@@ -33,6 +33,10 @@
  * > 0: simple remap complete
  */
 typedef int (*dm_map_fn) (struct dm_target *ti, struct bio *bio);
+
+typedef void (*dm_suspend_fn) (struct dm_target *ti);
+typedef void (*dm_resume_fn) (struct dm_target *ti);
+
 typedef int (*dm_status_fn) (struct dm_target *ti, status_type_t status_type,
 			     char *result, unsigned int maxlen);
 
@@ -56,6 +60,8 @@
 	dm_ctr_fn ctr;
 	dm_dtr_fn dtr;
 	dm_map_fn map;
+	dm_suspend_fn suspend;
+	dm_resume_fn resume;
 	dm_status_fn status;
 };
 
