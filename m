Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbVJEQ5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbVJEQ5v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbVJEQ5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:57:50 -0400
Received: from lead.cat.pdx.edu ([131.252.208.91]:63368 "EHLO lead.cat.pdx.edu")
	by vger.kernel.org with ESMTP id S1030251AbVJEQ5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:57:49 -0400
Date: Wed, 5 Oct 2005 09:57:34 -0700 (PDT)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200510051657.j95GvYUl021714@rastaban.cs.pdx.edu>
To: linux-kernel@vger.kernel.org
Cc: paulmck@us.ibm.com, suzannew@cs.pdx.edu, walpole@cs.pdx.edu
Subject: [RFC][PATCH] identify raid rcu-protected pointer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please consider the following patch submittal
to insert rcu_dereference() to make explicit
the object of the rcu read-side critical sections.  
Thank you.

drivers/md/multipath.c	|	6 +++---
drivers/md/raid10.c	|	6 +++--- 
drivers/md/raid1.c	|	8 ++++----
drivers/md/raid5.c	|	6 +++---
drivers/md/raid6main.c	|	6 +++--- 
5 files changed, 16 insertions(+), 16 deletions(-)

---------------------------------------------------

diff -urpNa -X dontdiff a/linux-2.6.14-rc3/drivers/md/multipath.c b/linux-2.6.14-rc3/drivers/md/multipath.c
--- a/linux-2.6.14-rc3/drivers/md/multipath.c	2005-09-30 14:17:34.000000000 -0700
+++ b/linux-2.6.14-rc3/drivers/md/multipath.c	2005-10-04 21:12:36.000000000 -0700
@@ -63,7 +63,7 @@ static int multipath_map (multipath_conf
 
 	rcu_read_lock();
 	for (i = 0; i < disks; i++) {
-		mdk_rdev_t *rdev = conf->multipaths[i].rdev;
+		mdk_rdev_t *rdev = rcu_deference(conf->multipaths[i].rdev);
 		if (rdev && rdev->in_sync) {
 			atomic_inc(&rdev->nr_pending);
 			rcu_read_unlock();
@@ -139,7 +139,7 @@ static void unplug_slaves(mddev_t *mddev
 
 	rcu_read_lock();
 	for (i=0; i<mddev->raid_disks; i++) {
-		mdk_rdev_t *rdev = conf->multipaths[i].rdev;
+		mdk_rdev_t *rdev = rcu_deference(conf->multipaths[i].rdev);
 		if (rdev && !rdev->faulty && atomic_read(&rdev->nr_pending)) {
 			request_queue_t *r_queue = bdev_get_queue(rdev->bdev);
 
@@ -228,7 +228,7 @@ static int multipath_issue_flush(request
 
 	rcu_read_lock();
 	for (i=0; i<mddev->raid_disks && ret == 0; i++) {
-		mdk_rdev_t *rdev = conf->multipaths[i].rdev;
+		mdk_rdev_t *rdev = rcu_dereference(conf->multipaths[i].rdev);
 		if (rdev && !rdev->faulty) {
 			struct block_device *bdev = rdev->bdev;
 			request_queue_t *r_queue = bdev_get_queue(bdev);
diff -urpNa -X dontdiff a/linux-2.6.14-rc3/drivers/md/raid10.c b/linux-2.6.14-rc3/drivers/md/raid10.c
--- a/linux-2.6.14-rc3/drivers/md/raid10.c	2005-09-30 14:17:34.000000000 -0700
+++ b/linux-2.6.14-rc3/drivers/md/raid10.c	2005-10-04 21:24:33.000000000 -0700
@@ -583,7 +583,7 @@ static void unplug_slaves(mddev_t *mddev
 
 	rcu_read_lock();
 	for (i=0; i<mddev->raid_disks; i++) {
-		mdk_rdev_t *rdev = conf->mirrors[i].rdev;
+		mdk_rdev_t *rdev = rcu_dereference(conf->mirrors[i].rdev);
 		if (rdev && !rdev->faulty && atomic_read(&rdev->nr_pending)) {
 			request_queue_t *r_queue = bdev_get_queue(rdev->bdev);
 
@@ -614,7 +614,7 @@ static int raid10_issue_flush(request_qu
 
 	rcu_read_lock();
 	for (i=0; i<mddev->raid_disks && ret == 0; i++) {
-		mdk_rdev_t *rdev = conf->mirrors[i].rdev;
+		mdk_rdev_t *rdev = rcu_dereference(conf->mirrors[i].rdev);
 		if (rdev && !rdev->faulty) {
 			struct block_device *bdev = rdev->bdev;
 			request_queue_t *r_queue = bdev_get_queue(bdev);
@@ -772,7 +772,7 @@ static int make_request(request_queue_t 
 	rcu_read_lock();
 	for (i = 0;  i < conf->copies; i++) {
 		int d = r10_bio->devs[i].devnum;
-		if (conf->mirrors[d].rdev &&
+		if (rcu_dereference(conf->mirrors[d].rdev) &&
 		    !conf->mirrors[d].rdev->faulty) {
 			atomic_inc(&conf->mirrors[d].rdev->nr_pending);
 			r10_bio->devs[i].bio = bio;
diff -urpNa -X dontdiff a/linux-2.6.14-rc3/drivers/md/raid1.c b/linux-2.6.14-rc3/drivers/md/raid1.c
--- a/linux-2.6.14-rc3/drivers/md/raid1.c	2005-09-30 14:17:34.000000000 -0700
+++ b/linux-2.6.14-rc3/drivers/md/raid1.c	2005-10-04 21:16:00.000000000 -0700
@@ -416,7 +416,7 @@ static int read_balance(conf_t *conf, r1
 		/* Choose the first operation device, for consistancy */
 		new_disk = 0;
 
-		for (rdev = conf->mirrors[new_disk].rdev;
+		for (rdev = rcu_dereference(conf->mirrors[new_disk].rdev);
 		     !rdev || !rdev->in_sync
 			     || test_bit(WriteMostly, &rdev->flags);
 		     rdev = conf->mirrors[++new_disk].rdev) {
@@ -522,7 +522,7 @@ static void unplug_slaves(mddev_t *mddev
 
 	rcu_read_lock();
 	for (i=0; i<mddev->raid_disks; i++) {
-		mdk_rdev_t *rdev = conf->mirrors[i].rdev;
+		mdk_rdev_t *rdev = rcu_dereference(conf->mirrors[i].rdevi);
 		if (rdev && !rdev->faulty && atomic_read(&rdev->nr_pending)) {
 			request_queue_t *r_queue = bdev_get_queue(rdev->bdev);
 
@@ -556,7 +556,7 @@ static int raid1_issue_flush(request_que
 
 	rcu_read_lock();
 	for (i=0; i<mddev->raid_disks && ret == 0; i++) {
-		mdk_rdev_t *rdev = conf->mirrors[i].rdev;
+		mdk_rdev_t *rdev = rcu_dereference(conf->mirrors[i].rdev);
 		if (rdev && !rdev->faulty) {
 			struct block_device *bdev = rdev->bdev;
 			request_queue_t *r_queue = bdev_get_queue(bdev);
@@ -732,7 +732,7 @@ static int make_request(request_queue_t 
 #endif
 	rcu_read_lock();
 	for (i = 0;  i < disks; i++) {
-		if ((rdev=conf->mirrors[i].rdev) != NULL &&
+		if ((rdev=rcu_dereference(conf->mirrors[i].rdev)) != NULL &&
 		    !rdev->faulty) {
 			atomic_inc(&rdev->nr_pending);
 			if (rdev->faulty) {
diff -urpNa -X dontdiff a/linux-2.6.14-rc3/drivers/md/raid5.c b/linux-2.6.14-rc3/drivers/md/raid5.c
--- a/linux-2.6.14-rc3/drivers/md/raid5.c	2005-09-30 14:17:34.000000000 -0700
+++ b/linux-2.6.14-rc3/drivers/md/raid5.c	2005-10-04 21:26:07.000000000 -0700
@@ -1305,7 +1305,7 @@ static void handle_stripe(struct stripe_
 			bi->bi_end_io = raid5_end_read_request;
  
 		rcu_read_lock();
-		rdev = conf->disks[i].rdev;
+		rdev = rcu_dereference(conf->disks[i].rdev);
 		if (rdev && rdev->faulty)
 			rdev = NULL;
 		if (rdev)
@@ -1379,7 +1379,7 @@ static void unplug_slaves(mddev_t *mddev
 
 	rcu_read_lock();
 	for (i=0; i<mddev->raid_disks; i++) {
-		mdk_rdev_t *rdev = conf->disks[i].rdev;
+		mdk_rdev_t *rdev = rcu_dereference(conf->disks[i].rdev);
 		if (rdev && !rdev->faulty && atomic_read(&rdev->nr_pending)) {
 			request_queue_t *r_queue = bdev_get_queue(rdev->bdev);
 
@@ -1424,7 +1424,7 @@ static int raid5_issue_flush(request_que
 
 	rcu_read_lock();
 	for (i=0; i<mddev->raid_disks && ret == 0; i++) {
-		mdk_rdev_t *rdev = conf->disks[i].rdev;
+		mdk_rdev_t *rdev = rcu_dereference(conf->disks[i].rdev);
 		if (rdev && !rdev->faulty) {
 			struct block_device *bdev = rdev->bdev;
 			request_queue_t *r_queue = bdev_get_queue(bdev);
diff -urpNa -X dontdiff a/linux-2.6.14-rc3/drivers/md/raid6main.c b/linux-2.6.14-rc3/drivers/md/raid6main.c
--- a/linux-2.6.14-rc3/drivers/md/raid6main.c	2005-09-30 14:17:34.000000000 -0700
+++ b/linux-2.6.14-rc3/drivers/md/raid6main.c	2005-10-04 21:29:19.000000000 -0700
@@ -1464,7 +1464,7 @@ static void handle_stripe(struct stripe_
 			bi->bi_end_io = raid6_end_read_request;
 
 		rcu_read_lock();
-		rdev = conf->disks[i].rdev;
+		rdev = rcu_dereference(conf->disks[i].rdev);
 		if (rdev && rdev->faulty)
 			rdev = NULL;
 		if (rdev)
@@ -1538,7 +1538,7 @@ static void unplug_slaves(mddev_t *mddev
 
 	rcu_read_lock();
 	for (i=0; i<mddev->raid_disks; i++) {
-		mdk_rdev_t *rdev = conf->disks[i].rdev;
+		mdk_rdev_t *rdev = rcu_dereference(conf->disks[i].rdev);
 		if (rdev && !rdev->faulty && atomic_read(&rdev->nr_pending)) {
 			request_queue_t *r_queue = bdev_get_queue(rdev->bdev);
 
@@ -1583,7 +1583,7 @@ static int raid6_issue_flush(request_que
 
 	rcu_read_lock();
 	for (i=0; i<mddev->raid_disks && ret == 0; i++) {
-		mdk_rdev_t *rdev = conf->disks[i].rdev;
+		mdk_rdev_t *rdev = rcu_dereference(conf->disks[i].rdev);
 		if (rdev && !rdev->faulty) {
 			struct block_device *bdev = rdev->bdev;
 			request_queue_t *r_queue = bdev_get_queue(bdev);

