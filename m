Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbULEXKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbULEXKr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 18:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbULEXKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 18:10:46 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:40946 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261264AbULEXJR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 18:09:17 -0500
Date: Sat, 4 Dec 2004 16:31:04 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: andmike@us.ibm.com, dipankar@us.ibm.com, neilb@cse.unsw.edu.au,
       mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [RFC, PATCH] RCU questions on md driver
Message-ID: <20041205003104.GA1914@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

A few questions and comments on md driver locking, my best guess at
answers may be found in the patch below (which I have not even attempted
to compile, let alone test).

o	Need some rcu_dereference() primitives in a number of places.

o	The reference counts must be decremented after rcu_read_lock().
	Otherwise, unless I am missing something, a preemption (in a
	CONFIG_PREEMPT kernel) occuring just before the rcu_read_lock()
	looks like it could destroy the element subsequently used.

o	How does the locking work in read_balance() in drivers/md/raid1.c?
	It looks to me that the conf->mirrors[] array could potentially
	be changing during the read_balance() operation, which I cannot
	see how is handled correctly.

	For that matter, I don't see what prevents multiple instances
	of read_balance() from executing concurrently on the same
	set of disks...

o	Ditto for read_balance in drivers/md/raid10.c.  And raid5.c.

Thoughts?

						Thanx, Paul


diff -urpN -X ../dontdiff linux-2.5/drivers/md/multipath.c linux-2.5-mpio/drivers/md/multipath.c
--- linux-2.5/drivers/md/multipath.c	Mon Nov 29 10:48:55 2004
+++ linux-2.5-mpio/drivers/md/multipath.c	Sat Dec  4 15:32:19 2004
@@ -63,7 +63,7 @@ static int multipath_map (multipath_conf
 
 	rcu_read_lock();
 	for (i = 0; i < disks; i++) {
-		mdk_rdev_t *rdev = conf->multipaths[i].rdev;
+		mdk_rdev_t *rdev = rcu_dereference(conf->multipaths[i].rdev);
 		if (rdev && rdev->in_sync) {
 			atomic_inc(&rdev->nr_pending);
 			rcu_read_unlock();
@@ -138,7 +138,7 @@ static void unplug_slaves(mddev_t *mddev
 
 	rcu_read_lock();
 	for (i=0; i<mddev->raid_disks; i++) {
-		mdk_rdev_t *rdev = conf->multipaths[i].rdev;
+		mdk_rdev_t *rdev = rcu_dereference(conf->multipaths[i].rdev);
 		if (rdev && !rdev->faulty && atomic_read(&rdev->nr_pending)) {
 			request_queue_t *r_queue = bdev_get_queue(rdev->bdev);
 
@@ -148,8 +148,8 @@ static void unplug_slaves(mddev_t *mddev
 			if (r_queue->unplug_fn)
 				r_queue->unplug_fn(r_queue);
 
-			rdev_dec_pending(rdev, mddev);
 			rcu_read_lock();
+			rdev_dec_pending(rdev, mddev);
 		}
 	}
 	rcu_read_unlock();
@@ -222,7 +222,7 @@ static int multipath_issue_flush(request
 
 	rcu_read_lock();
 	for (i=0; i<mddev->raid_disks && ret == 0; i++) {
-		mdk_rdev_t *rdev = conf->multipaths[i].rdev;
+		mdk_rdev_t *rdev = rcu_dereference(conf->multipaths[i].rdev);
 		if (rdev && !rdev->faulty) {
 			struct block_device *bdev = rdev->bdev;
 			request_queue_t *r_queue = bdev_get_queue(bdev);
@@ -234,8 +234,8 @@ static int multipath_issue_flush(request
 				rcu_read_unlock();
 				ret = r_queue->issue_flush_fn(r_queue, bdev->bd_disk,
 							      error_sector);
-				rdev_dec_pending(rdev, mddev);
 				rcu_read_lock();
+				rdev_dec_pending(rdev, mddev);
 			}
 		}
 	}
diff -urpN -X ../dontdiff linux-2.5/drivers/md/raid1.c linux-2.5-mpio/drivers/md/raid1.c
--- linux-2.5/drivers/md/raid1.c	Mon Nov 29 10:48:55 2004
+++ linux-2.5-mpio/drivers/md/raid1.c	Sat Dec  4 16:16:48 2004
@@ -338,6 +338,7 @@ static int read_balance(conf_t *conf, r1
 	int new_disk = conf->last_used, disk = new_disk;
 	const int sectors = r1_bio->sectors;
 	sector_t new_distance, current_distance;
+	mdk_rdev_t *rdev;
 
 	rcu_read_lock();
 	/*
@@ -350,8 +351,9 @@ static int read_balance(conf_t *conf, r1
 		/* Choose the first operation device, for consistancy */
 		new_disk = 0;
 
-		while (!conf->mirrors[new_disk].rdev ||
-		       !conf->mirrors[new_disk].rdev->in_sync) {
+		while (!(rdev =
+			 rcu_dereference(conf->mirrors[new_disk].rdev)) ||
+		       !rdev->in_sync) {
 			new_disk++;
 			if (new_disk == conf->raid_disks) {
 				new_disk = -1;
@@ -363,8 +365,8 @@ static int read_balance(conf_t *conf, r1
 
 
 	/* make sure the disk is operational */
-	while (!conf->mirrors[new_disk].rdev ||
-	       !conf->mirrors[new_disk].rdev->in_sync) {
+	while (!(rdev = rcu_dereference(conf->mirrors[new_disk].rdev)) ||
+	       !rdev->in_sync) {
 		if (new_disk <= 0)
 			new_disk = conf->raid_disks;
 		new_disk--;
@@ -393,11 +395,11 @@ static int read_balance(conf_t *conf, r1
 			disk = conf->raid_disks;
 		disk--;
 
-		if (!conf->mirrors[disk].rdev ||
-		    !conf->mirrors[disk].rdev->in_sync)
+		if (!(rdev = rcu_dereference(conf->mirrors[disk].rdev)) ||
+		    !rdev->in_sync)
 			continue;
 
-		if (!atomic_read(&conf->mirrors[disk].rdev->nr_pending)) {
+		if (!atomic_read(&rdev->nr_pending)) {
 			new_disk = disk;
 			break;
 		}
@@ -414,7 +416,7 @@ rb_out:
 	if (new_disk >= 0) {
 		conf->next_seq_sect = this_sector + sectors;
 		conf->last_used = new_disk;
-		atomic_inc(&conf->mirrors[new_disk].rdev->nr_pending);
+		atomic_inc(&rdev->nr_pending);
 	}
 	rcu_read_unlock();
 
@@ -428,7 +430,7 @@ static void unplug_slaves(mddev_t *mddev
 
 	rcu_read_lock();
 	for (i=0; i<mddev->raid_disks; i++) {
-		mdk_rdev_t *rdev = conf->mirrors[i].rdev;
+		mdk_rdev_t *rdev = rcu_dereference(conf->mirrors[i].rdev);
 		if (rdev && !rdev->faulty && atomic_read(&rdev->nr_pending)) {
 			request_queue_t *r_queue = bdev_get_queue(rdev->bdev);
 
@@ -438,8 +440,8 @@ static void unplug_slaves(mddev_t *mddev
 			if (r_queue->unplug_fn)
 				r_queue->unplug_fn(r_queue);
 
-			rdev_dec_pending(rdev, mddev);
 			rcu_read_lock();
+			rdev_dec_pending(rdev, mddev);
 		}
 	}
 	rcu_read_unlock();
@@ -459,7 +461,7 @@ static int raid1_issue_flush(request_que
 
 	rcu_read_lock();
 	for (i=0; i<mddev->raid_disks && ret == 0; i++) {
-		mdk_rdev_t *rdev = conf->mirrors[i].rdev;
+		mdk_rdev_t *rdev = rcu_dereference(conf->mirrors[i].rdev);
 		if (rdev && !rdev->faulty) {
 			struct block_device *bdev = rdev->bdev;
 			request_queue_t *r_queue = bdev_get_queue(bdev);
@@ -471,8 +473,8 @@ static int raid1_issue_flush(request_que
 				rcu_read_unlock();
 				ret = r_queue->issue_flush_fn(r_queue, bdev->bd_disk,
 							      error_sector);
-				rdev_dec_pending(rdev, mddev);
 				rcu_read_lock();
+				rdev_dec_pending(rdev, mddev);
 			}
 		}
 	}
@@ -585,9 +587,9 @@ static int make_request(request_queue_t 
 	disks = conf->raid_disks;
 	rcu_read_lock();
 	for (i = 0;  i < disks; i++) {
-		if (conf->mirrors[i].rdev &&
-		    !conf->mirrors[i].rdev->faulty) {
-			atomic_inc(&conf->mirrors[i].rdev->nr_pending);
+		mdk_rdev_t *rdev = rcu_dereference(conf->mirrors[i].rdev);
+		if (rdev && !rdev->faulty) {
+			atomic_inc(&rdev->nr_pending);
 			r1_bio->bios[i] = bio;
 		} else
 			r1_bio->bios[i] = NULL;
diff -urpN -X ../dontdiff linux-2.5/drivers/md/raid10.c linux-2.5-mpio/drivers/md/raid10.c
--- linux-2.5/drivers/md/raid10.c	Mon Nov 29 10:48:55 2004
+++ linux-2.5-mpio/drivers/md/raid10.c	Sat Dec  4 16:23:49 2004
@@ -496,6 +496,7 @@ static int read_balance(conf_t *conf, r1
 	int disk, slot, nslot;
 	const int sectors = r10_bio->sectors;
 	sector_t new_distance, current_distance;
+	mdk_rdev_t *rdev;
 
 	raid10_find_phys(conf, r10_bio);
 	rcu_read_lock();
@@ -510,8 +511,8 @@ static int read_balance(conf_t *conf, r1
 		slot = 0;
 		disk = r10_bio->devs[slot].devnum;
 
-		while (!conf->mirrors[disk].rdev ||
-		       !conf->mirrors[disk].rdev->in_sync) {
+		while (!(rdev = rcu_dereference(conf->mirrors[disk].rdev)) ||
+		       !rdev->in_sync) {
 			slot++;
 			if (slot == conf->copies) {
 				slot = 0;
@@ -527,8 +528,8 @@ static int read_balance(conf_t *conf, r1
 	/* make sure the disk is operational */
 	slot = 0;
 	disk = r10_bio->devs[slot].devnum;
-	while (!conf->mirrors[disk].rdev ||
-	       !conf->mirrors[disk].rdev->in_sync) {
+	while (!(rdev = rcu_dereference(conf->mirrors[disk].rdev)) ||
+	       !rdev->in_sync) {
 		slot ++;
 		if (slot == conf->copies) {
 			disk = -1;
@@ -546,11 +547,11 @@ static int read_balance(conf_t *conf, r1
 		int ndisk = r10_bio->devs[nslot].devnum;
 
 
-		if (!conf->mirrors[ndisk].rdev ||
-		    !conf->mirrors[ndisk].rdev->in_sync)
+		if (!(rdev = rcu_dereference(conf->mirrors[ndisk].rdev)) ||
+		    !rdev->in_sync)
 			continue;
 
-		if (!atomic_read(&conf->mirrors[ndisk].rdev->nr_pending)) {
+		if (!atomic_read(&rdev->nr_pending)) {
 			disk = ndisk;
 			slot = nslot;
 			break;
@@ -568,8 +569,8 @@ rb_out:
 	r10_bio->read_slot = slot;
 /*	conf->next_seq_sect = this_sector + sectors;*/
 
-	if (disk >= 0 && conf->mirrors[disk].rdev)
-		atomic_inc(&conf->mirrors[disk].rdev->nr_pending);
+	if (disk >= 0 && rdev)
+		atomic_inc(&rdev->nr_pending);
 	rcu_read_unlock();
 
 	return disk;
@@ -582,7 +583,7 @@ static void unplug_slaves(mddev_t *mddev
 
 	rcu_read_lock();
 	for (i=0; i<mddev->raid_disks; i++) {
-		mdk_rdev_t *rdev = conf->mirrors[i].rdev;
+		mdk_rdev_t *rdev = rcu_dereference(conf->mirrors[i].rdev);
 		if (rdev && !rdev->faulty && atomic_read(&rdev->nr_pending)) {
 			request_queue_t *r_queue = bdev_get_queue(rdev->bdev);
 
@@ -592,8 +593,8 @@ static void unplug_slaves(mddev_t *mddev
 			if (r_queue->unplug_fn)
 				r_queue->unplug_fn(r_queue);
 
-			rdev_dec_pending(rdev, mddev);
 			rcu_read_lock();
+			rdev_dec_pending(rdev, mddev);
 		}
 	}
 	rcu_read_unlock();
@@ -613,7 +614,7 @@ static int raid10_issue_flush(request_qu
 
 	rcu_read_lock();
 	for (i=0; i<mddev->raid_disks && ret == 0; i++) {
-		mdk_rdev_t *rdev = conf->mirrors[i].rdev;
+		mdk_rdev_t *rdev = rcu_dereference(conf->mirrors[i].rdev);
 		if (rdev && !rdev->faulty) {
 			struct block_device *bdev = rdev->bdev;
 			request_queue_t *r_queue = bdev_get_queue(bdev);
@@ -625,8 +626,8 @@ static int raid10_issue_flush(request_qu
 				rcu_read_unlock();
 				ret = r_queue->issue_flush_fn(r_queue, bdev->bd_disk,
 							      error_sector);
-				rdev_dec_pending(rdev, mddev);
 				rcu_read_lock();
+				rdev_dec_pending(rdev, mddev);
 			}
 		}
 	}
@@ -763,10 +764,11 @@ static int make_request(request_queue_t 
 	raid10_find_phys(conf, r10_bio);
 	rcu_read_lock();
 	for (i = 0;  i < conf->copies; i++) {
+		mdk_rdev_t *rdev;
 		int d = r10_bio->devs[i].devnum;
-		if (conf->mirrors[d].rdev &&
-		    !conf->mirrors[d].rdev->faulty) {
-			atomic_inc(&conf->mirrors[d].rdev->nr_pending);
+		rdev = rcu_dereference(conf->mirrors[d].rdev);
+		if (rdev && !rdev->faulty) {
+			atomic_inc(&rdev->nr_pending);
 			r10_bio->devs[i].bio = bio;
 		} else
 			r10_bio->devs[i].bio = NULL;
diff -urpN -X ../dontdiff linux-2.5/drivers/md/raid5.c linux-2.5-mpio/drivers/md/raid5.c
--- linux-2.5/drivers/md/raid5.c	Mon Nov 29 10:48:55 2004
+++ linux-2.5-mpio/drivers/md/raid5.c	Sat Dec  4 16:26:01 2004
@@ -1248,7 +1248,7 @@ static void handle_stripe(struct stripe_
 			bi->bi_end_io = raid5_end_read_request;
  
 		rcu_read_lock();
-		rdev = conf->disks[i].rdev;
+		rdev = rcu_dereference(conf->disks[i].rdev);
 		if (rdev && rdev->faulty)
 			rdev = NULL;
 		if (rdev)
@@ -1305,7 +1305,7 @@ static void unplug_slaves(mddev_t *mddev
 
 	rcu_read_lock();
 	for (i=0; i<mddev->raid_disks; i++) {
-		mdk_rdev_t *rdev = conf->disks[i].rdev;
+		mdk_rdev_t *rdev = rcu_dereference(conf->disks[i].rdev);
 		if (rdev && !rdev->faulty && atomic_read(&rdev->nr_pending)) {
 			request_queue_t *r_queue = bdev_get_queue(rdev->bdev);
 
@@ -1315,8 +1315,8 @@ static void unplug_slaves(mddev_t *mddev
 			if (r_queue->unplug_fn)
 				r_queue->unplug_fn(r_queue);
 
-			rdev_dec_pending(rdev, mddev);
 			rcu_read_lock();
+			rdev_dec_pending(rdev, mddev);
 		}
 	}
 	rcu_read_unlock();
@@ -1348,7 +1348,7 @@ static int raid5_issue_flush(request_que
 
 	rcu_read_lock();
 	for (i=0; i<mddev->raid_disks && ret == 0; i++) {
-		mdk_rdev_t *rdev = conf->disks[i].rdev;
+		mdk_rdev_t *rdev = rcu_dereference(conf->disks[i].rdev);
 		if (rdev && !rdev->faulty) {
 			struct block_device *bdev = rdev->bdev;
 			request_queue_t *r_queue = bdev_get_queue(bdev);
@@ -1360,8 +1360,8 @@ static int raid5_issue_flush(request_que
 				rcu_read_unlock();
 				ret = r_queue->issue_flush_fn(r_queue, bdev->bd_disk,
 							      error_sector);
-				rdev_dec_pending(rdev, mddev);
 				rcu_read_lock();
+				rdev_dec_pending(rdev, mddev);
 			}
 		}
 	}
diff -urpN -X ../dontdiff linux-2.5/drivers/md/raid6main.c linux-2.5-mpio/drivers/md/raid6main.c
--- linux-2.5/drivers/md/raid6main.c	Mon Nov 29 10:48:55 2004
+++ linux-2.5-mpio/drivers/md/raid6main.c	Sat Dec  4 16:27:56 2004
@@ -1411,7 +1411,7 @@ static void handle_stripe(struct stripe_
 			bi->bi_end_io = raid6_end_read_request;
 
 		rcu_read_lock();
-		rdev = conf->disks[i].rdev;
+		rdev = rcu_dereference(conf->disks[i].rdev);
 		if (rdev && rdev->faulty)
 			rdev = NULL;
 		if (rdev)
@@ -1468,7 +1468,7 @@ static void unplug_slaves(mddev_t *mddev
 
 	rcu_read_lock();
 	for (i=0; i<mddev->raid_disks; i++) {
-		mdk_rdev_t *rdev = conf->disks[i].rdev;
+		mdk_rdev_t *rdev = rcu_dereference(conf->disks[i].rdev);
 		if (rdev && !rdev->faulty && atomic_read(&rdev->nr_pending)) {
 			request_queue_t *r_queue = bdev_get_queue(rdev->bdev);
 
@@ -1478,8 +1478,8 @@ static void unplug_slaves(mddev_t *mddev
 			if (r_queue->unplug_fn)
 				r_queue->unplug_fn(r_queue);
 
-			rdev_dec_pending(rdev, mddev);
 			rcu_read_lock();
+			rdev_dec_pending(rdev, mddev);
 		}
 	}
 	rcu_read_unlock();
@@ -1511,7 +1511,7 @@ static int raid6_issue_flush(request_que
 
 	rcu_read_lock();
 	for (i=0; i<mddev->raid_disks && ret == 0; i++) {
-		mdk_rdev_t *rdev = conf->disks[i].rdev;
+		mdk_rdev_t *rdev = rcu_dereference(conf->disks[i].rdev);
 		if (rdev && !rdev->faulty) {
 			struct block_device *bdev = rdev->bdev;
 			request_queue_t *r_queue = bdev_get_queue(bdev);
@@ -1523,8 +1523,8 @@ static int raid6_issue_flush(request_que
 				rcu_read_unlock();
 				ret = r_queue->issue_flush_fn(r_queue, bdev->bd_disk,
 							      error_sector);
-				rdev_dec_pending(rdev, mddev);
 				rcu_read_lock();
+				rdev_dec_pending(rdev, mddev);
 			}
 		}
 	}
