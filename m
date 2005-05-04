Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbVEDRQC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbVEDRQC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 13:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVEDRPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 13:15:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12958 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261254AbVEDRLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 13:11:24 -0400
Date: Wed, 4 May 2005 18:11:09 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mikenc@us.ibm.com,
       Lars Marowsky-Bree <lmb@suse.de>, Jens Axboe <axboe@suse.de>
Subject: [PATCH] device-mapper multipath: Use private workqueue
Message-ID: <20050504171109.GS10195@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	mikenc@us.ibm.com, Lars Marowsky-Bree <lmb@suse.de>,
	Jens Axboe <axboe@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dm-mpath.c needs to use a private workqueue (like other dm targets
already do) to avoid interfering with users of the default workqueue.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
Acked-by: Jens Axboe <axboe@suse.de>
Signed-off-by: Lars Marowsky-Bree <lmb@suse.de>
Signed-off-by: mikenc@us.ibm.com

--- diff/drivers/md/dm-mpath.c	2005-04-04 17:38:05.000000000 +0100
+++ source/drivers/md/dm-mpath.c	2005-04-21 17:32:53.000000000 +0100
@@ -101,6 +101,7 @@
 
 static kmem_cache_t *_mpio_cache;
 
+struct workqueue_struct *kmultipathd;
 static void process_queued_ios(void *data);
 static void trigger_event(void *data);
 
@@ -308,7 +309,7 @@
 		bio_list_add(&m->queued_ios, bio);
 		m->queue_size++;
 		if (m->pg_init_required || !m->queue_io)
-			schedule_work(&m->process_queued_ios);
+			queue_work(kmultipathd, &m->process_queued_ios);
 		pgpath = NULL;
 		r = 0;
 	} else if (!pgpath)
@@ -334,7 +335,7 @@
 
 	m->queue_if_no_path = queue_if_no_path;
 	if (!m->queue_if_no_path)
-		schedule_work(&m->process_queued_ios);
+		queue_work(kmultipathd, &m->process_queued_ios);
 
 	spin_unlock_irqrestore(&m->lock, flags);
 
@@ -800,7 +801,7 @@
 	if (pgpath == m->current_pgpath)
 		m->current_pgpath = NULL;
 
-	schedule_work(&m->trigger_event);
+	queue_work(kmultipathd, &m->trigger_event);
 
 out:
 	spin_unlock_irqrestore(&m->lock, flags);
@@ -837,9 +838,9 @@
 
 	m->current_pgpath = NULL;
 	if (!m->nr_valid_paths++)
-		schedule_work(&m->process_queued_ios);
+		queue_work(kmultipathd, &m->process_queued_ios);
 
-	schedule_work(&m->trigger_event);
+	queue_work(kmultipathd, &m->trigger_event);
 
 out:
 	spin_unlock_irqrestore(&m->lock, flags);
@@ -883,7 +884,7 @@
 
 	spin_unlock_irqrestore(&m->lock, flags);
 
-	schedule_work(&m->trigger_event);
+	queue_work(kmultipathd, &m->trigger_event);
 }
 
 /*
@@ -913,7 +914,7 @@
 	}
 	spin_unlock_irqrestore(&m->lock, flags);
 
-	schedule_work(&m->trigger_event);
+	queue_work(kmultipathd, &m->trigger_event);
 	return 0;
 }
 
@@ -968,7 +969,7 @@
 		m->current_pgpath = NULL;
 		m->current_pg = NULL;
 	}
-	schedule_work(&m->process_queued_ios);
+	queue_work(kmultipathd, &m->process_queued_ios);
 	spin_unlock_irqrestore(&m->lock, flags);
 }
 
@@ -1018,7 +1019,7 @@
 	bio_list_add(&m->queued_ios, bio);
 	m->queue_size++;
 	if (!m->queue_io)
-		schedule_work(&m->process_queued_ios);
+		queue_work(kmultipathd, &m->process_queued_ios);
 	spin_unlock(&m->lock);
 
 	return 1;	/* io not complete */
@@ -1057,7 +1058,7 @@
 	spin_lock_irqsave(&m->lock, flags);
 	m->suspended = 1;
 	if (m->queue_if_no_path)
-		schedule_work(&m->process_queued_ios);
+		queue_work(kmultipathd, &m->process_queued_ios);
 	spin_unlock_irqrestore(&m->lock, flags);
 }
 
@@ -1274,6 +1275,15 @@
 		return -EINVAL;
 	}
 
+	kmultipathd = create_workqueue("kmpathd");
+	if (!kmultipathd) {
+		DMERR("%s: failed to create workqueue kmpathd", 
+				multipath_target.name);
+		dm_unregister_target(&multipath_target);
+		kmem_cache_destroy(_mpio_cache);
+		return -ENOMEM;
+	}
+
 	DMINFO("dm-multipath version %u.%u.%u loaded",
 	       multipath_target.version[0], multipath_target.version[1],
 	       multipath_target.version[2]);
@@ -1285,6 +1295,8 @@
 {
 	int r;
 
+	destroy_workqueue(kmultipathd);
+
 	r = dm_unregister_target(&multipath_target);
 	if (r < 0)
 		DMERR("%s: target unregister failed %d",
