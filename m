Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbULFSfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbULFSfk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 13:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbULFSfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 13:35:40 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:24737 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261606AbULFSbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 13:31:19 -0500
Date: Mon, 6 Dec 2004 10:30:48 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: andmike@us.ibm.com, dipankar@in.ibm.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC, PATCH] RCU questions on md driver
Message-ID: <20041206183048.GA1435@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20041205003104.GA1914@us.ibm.com> <16819.41088.159731.651102@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16819.41088.159731.651102@cse.unsw.edu.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2004 at 10:57:52AM +1100, Neil Brown wrote:
> On Saturday December 4, paulmck@us.ibm.com wrote:
> > Hello!
> > 
> > A few questions and comments on md driver locking, my best guess at
> > answers may be found in the patch below (which I have not even attempted
> > to compile, let alone test).
> 
> Thanks for the input.

No problem!  Thank you for looking into it.

> > o	Need some rcu_dereference() primitives in a number of places.
> 
> I don't understand the need for these.
> In the first place, it would seem from a quick reading of rcupdate.h
> that rcu_dereference would normally be paired with rcu_assign_pointer,
> however you haven't inserted any calls to rcu_assign_pointer.

Yep.  If forced to guess, I would insert them as shown in the
patch below (only guessed for raid1.c).

> Secondly, the usage of "rcu_read_[un]lock" in md is not about
> protecting data in the these data structures.  It is purely about
> synchronising with synchronize_kernel in raid1_remove_disk (and
> similar).

So the fields of the structure that ->rdev points to is constant?
(Or at least those fields referenced under rcu_read_lock().)

> *_remove_disk sets ->rdev to NULL, calls synchronize_kernel, and then
> checks ->nr_pending on the thing that used to be in ->rdev.  It will
> have "lost the race" (and so must put the value of ->rdev back) only
> if some other code called atomic_inc(&rdev->nr_pending) under an
> rcu_read_lock.   Presumably atomic_inc and atomic_read have enough
> barriers to make this work.

atomic_inc() is not required to have -any- memory barriers.  And in
fact has none in ppc64, has partial "acq" barrier in ia64, has none
in alpha, has partial memory barrier in sparc64, &c.

Is the caller of read_balance() required to hold a reference count
in rdev->nr_pending?  But what about the following sequence of events:

o	raid1_remove_disk() sees rdev as being insync and
	nr_pending of zero.

o	Someone increments nr_pending and invokes read_balance().

o	read_balance() checks conf->mirrors[new_disk].rdev and
	finds it non-NULL (while loop near line 353).

o	raid1_remove_disk() sets p_rdev to NULL.

o	read_balance() tries to access conf->mirrors[new_disk].rdev->in_sync
	and blows up on the now-NULL pointer.

o	raid1_remove_disk() then sees the nr_pending, but it is too late
	read_balance() has already tossed its cookies...

Or is there something that prevents this sequence from happening?

> > o	The reference counts must be decremented after rcu_read_lock().
> > 	Otherwise, unless I am missing something, a preemption (in a
> > 	CONFIG_PREEMPT kernel) occuring just before the rcu_read_lock()
> > 	looks like it could destroy the element subsequently used.
> 
> I don't think so.  The "element" isn't "subsequently used" after
> rdev_dec_pending is called (or have I missed something?)

Good point, I stand corrected.

> > o	How does the locking work in read_balance() in drivers/md/raid1.c?
> > 	It looks to me that the conf->mirrors[] array could potentially
> > 	be changing during the read_balance() operation, which I cannot
> > 	see how is handled correctly.
> 
> There is no locking on "head_position" and it could well change
> underneath read_balance.  However read_balance is at-best a fuzzy
> heuristic.  If it mostly makes a reasonably good decision about which
> device to use, that is the best we can hope for anyway.  Random
> changes in head_position won't affect correctness of the code, only
> performance. 

OK, as long as it avoids NULL-pointer dereferences.

> However there is some code in there that isn't quite right:
> 
> 		while (!conf->mirrors[new_disk].rdev ||
> 		       !conf->mirrors[new_disk].rdev->in_sync) {
> should really read
> 		while ((rdev=conf->mirrors[new_disk].rdev)== NULL ||
> 		       !rdev->in_sync) {
> 
> (much as your patch does) to avoid the second de-reference getting a
> NULL which the first didn't see (Though I suspect the compile will
> optimise  out the extra de-ref anyway.

Usually, though I have been nailed by cases where this optimization
does not occur...  :-/

> > 	For that matter, I don't see what prevents multiple instances
> > 	of read_balance() from executing concurrently on the same
> > 	set of disks...
> 
> Nothing.

I have not thought through all the possibilities here, but am concerned
about tangled assignments in the code following the rb_out: label.
I could easily imagine races with updates resulting in different
instances of read_balance() choosing different disks, and different
read_balance() instances winning on the different assignments in
the rb_out: codepath.

> > o	Ditto for read_balance in drivers/md/raid10.c.  And raid5.c.
> 
> ditto for raid10.  raid5 doesn't read-balance.
> 
> 
> Have I adequately answered your concerns?

My remaining concerns are:

o	NULL-pointer dereferences in read_balance() (which your suggested
	change should address, if carried through the rest of read_balance()).

o	Are the rdev fields referenced in read_balance() really constant?
	If not, and if "fuzzy" values are not OK, then the rcu_assign_pointer()
	and rcu_dereference() calls are needed.

o	Races with different instances of read_balance() "winning"
	on the different assignments in the rb_out: code path.

						Thanx, Paul

PS: patch untested, not even compiled.

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
+++ linux-2.5-mpio/drivers/md/raid1.c	Mon Dec  6 10:18:58 2004
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
 
@@ -459,7 +461,7 @@ static int raid1_issue_flush(request_que
 
 	rcu_read_lock();
 	for (i=0; i<mddev->raid_disks && ret == 0; i++) {
-		mdk_rdev_t *rdev = conf->mirrors[i].rdev;
+		mdk_rdev_t *rdev = rcu_dereference(conf->mirrors[i].rdev);
 		if (rdev && !rdev->faulty) {
 			struct block_device *bdev = rdev->bdev;
 			request_queue_t *r_queue = bdev_get_queue(bdev);
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
@@ -757,7 +759,7 @@ static int raid1_add_disk(mddev_t *mddev
 			p->head_position = 0;
 			rdev->raid_disk = mirror;
 			found = 1;
-			p->rdev = rdev;
+			rcu_assign_pointer(p->rdev, rdev);
 			break;
 		}
 
@@ -785,7 +787,7 @@ static int raid1_remove_disk(mddev_t *md
 		if (atomic_read(&rdev->nr_pending)) {
 			/* lost the race, try later */
 			err = -EBUSY;
-			p->rdev = rdev;
+			p->rdev = rdev;  /* OK, no updates. */
 		}
 	}
 abort:
@@ -1192,7 +1194,7 @@ static int run(mddev_t *mddev)
 			continue;
 		disk = conf->mirrors + disk_idx;
 
-		disk->rdev = rdev;
+		rcu_assign_pointer(disk->rdev, rdev);  /* needed? */
 
 		blk_queue_stack_limits(mddev->queue,
 				       rdev->bdev->bd_disk->queue);
diff -urpN -X ../dontdiff linux-2.5/drivers/md/raid10.c linux-2.5-mpio/drivers/md/raid10.c
--- linux-2.5/drivers/md/raid10.c	Mon Nov 29 10:48:55 2004
+++ linux-2.5-mpio/drivers/md/raid10.c	Mon Dec  6 10:19:37 2004
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
 
@@ -613,7 +614,7 @@ static int raid10_issue_flush(request_qu
 
 	rcu_read_lock();
 	for (i=0; i<mddev->raid_disks && ret == 0; i++) {
-		mdk_rdev_t *rdev = conf->mirrors[i].rdev;
+		mdk_rdev_t *rdev = rcu_dereference(conf->mirrors[i].rdev);
 		if (rdev && !rdev->faulty) {
 			struct block_device *bdev = rdev->bdev;
 			request_queue_t *r_queue = bdev_get_queue(bdev);
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
+++ linux-2.5-mpio/drivers/md/raid5.c	Mon Dec  6 10:19:20 2004
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
 
@@ -1348,7 +1348,7 @@ static int raid5_issue_flush(request_que
 
 	rcu_read_lock();
 	for (i=0; i<mddev->raid_disks && ret == 0; i++) {
-		mdk_rdev_t *rdev = conf->disks[i].rdev;
+		mdk_rdev_t *rdev = rcu_dereference(conf->disks[i].rdev);
 		if (rdev && !rdev->faulty) {
 			struct block_device *bdev = rdev->bdev;
 			request_queue_t *r_queue = bdev_get_queue(bdev);
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
