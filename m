Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271518AbRIJSD3>; Mon, 10 Sep 2001 14:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271520AbRIJSDU>; Mon, 10 Sep 2001 14:03:20 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:44300 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271518AbRIJSDM>; Mon, 10 Sep 2001 14:03:12 -0400
Date: Mon, 10 Sep 2001 20:03:44 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@caldera.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.10pre7aa1
Message-ID: <20010910200344.C714@athlon.random>
In-Reply-To: <20010910175416.A714@athlon.random> <200109101741.f8AHfwx17136@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200109101741.f8AHfwx17136@ns.caldera.de>; from hch@caldera.de on Mon, Sep 10, 2001 at 07:41:58PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2001 at 07:41:58PM +0200, Christoph Hellwig wrote:
> In article <20010910175416.A714@athlon.random> you wrote:
> > Only in 2.4.10pre4aa1: 00_paride-max_sectors-1
> > Only in 2.4.10pre7aa1: 00_paride-max_sectors-2
> >
> > 	Rediffed (also noticed the gendisk list changes deleted too much stuff
> > 	here so resurrected it).
> 
> Do you plan to submit the max_sectors changes to Linus & Alan?
> Otherwise I will do as they seem to be needed for reliable operation.

agreed, Linus, here it is ready for merging into mainline:

diff -urN 2.4.10pre6/drivers/block/paride/pd.c paride/drivers/block/paride/pd.c
--- 2.4.10pre6/drivers/block/paride/pd.c	Sun Sep  9 06:04:54 2001
+++ paride/drivers/block/paride/pd.c	Mon Sep 10 03:58:48 2001
@@ -287,6 +287,7 @@
 static struct hd_struct pd_hd[PD_DEVS];
 static int pd_sizes[PD_DEVS];
 static int pd_blocksizes[PD_DEVS];
+static int pd_maxsectors[PD_DEVS];
 
 #define PD_NAMELEN	8
 
@@ -385,56 +386,6 @@
 	}
 }
 
-static inline int pd_new_segment(request_queue_t *q, struct request *req, int max_segments)
-{
-	if (max_segments > cluster)
-		max_segments = cluster;
-
-	if (req->nr_segments < max_segments) {
-		req->nr_segments++;
-		return 1;
-	}
-	return 0;
-}
-
-static int pd_back_merge_fn(request_queue_t *q, struct request *req, 
-			    struct buffer_head *bh, int max_segments)
-{
-	if (req->bhtail->b_data + req->bhtail->b_size == bh->b_data)
-		return 1;
-	return pd_new_segment(q, req, max_segments);
-}
-
-static int pd_front_merge_fn(request_queue_t *q, struct request *req, 
-			     struct buffer_head *bh, int max_segments)
-{
-	if (bh->b_data + bh->b_size == req->bh->b_data)
-		return 1;
-	return pd_new_segment(q, req, max_segments);
-}
-
-static int pd_merge_requests_fn(request_queue_t *q, struct request *req,
-				struct request *next, int max_segments)
-{
-	int total_segments = req->nr_segments + next->nr_segments;
-	int same_segment;
-
-	if (max_segments > cluster)
-		max_segments = cluster;
-
-	same_segment = 0;
-	if (req->bhtail->b_data + req->bhtail->b_size == next->bh->b_data) {
-		total_segments--;
-		same_segment = 1;
-	}
-    
-	if (total_segments > max_segments)
-		return 0;
-
-	req->nr_segments = total_segments;
-	return 1;
-}
-
 int pd_init (void)
 
 {       int i;
@@ -448,9 +399,6 @@
         }
 	q = BLK_DEFAULT_QUEUE(MAJOR_NR);
 	blk_init_queue(q, DEVICE_REQUEST);
-	q->back_merge_fn = pd_back_merge_fn;
-	q->front_merge_fn = pd_front_merge_fn;
-	q->merge_requests_fn = pd_merge_requests_fn;
         read_ahead[MAJOR_NR] = 8;       /* 8 sector (4kB) read ahead */
         
 	pd_gendisk.major = major;
@@ -460,6 +408,9 @@
 	for(i=0;i<PD_DEVS;i++) pd_blocksizes[i] = 1024;
 	blksize_size[MAJOR_NR] = pd_blocksizes;
 
+	for(i=0;i<PD_DEVS;i++) pd_maxsectors[i] = cluster;
+	max_sectors[MAJOR_NR] = pd_maxsectors;
+
 	printk("%s: %s version %s, major %d, cluster %d, nice %d\n",
 		name,name,PD_VERSION,major,cluster,nice);
 	pd_init_units();
@@ -642,6 +593,11 @@
 
         devfs_unregister_blkdev(MAJOR_NR,name);
 	del_gendisk(&pd_gendisk);
+
+	for (unit=0;unit<PD_UNITS;unit++) 
+	   if (PD.present) pi_release(PI);
+
+	max_sectors[MAJOR_NR] = NULL;
 }
 
 #endif

> > Only in 2.4.10pre7aa1: 00_rcu-1
> >
> > 	wait_for_rcu and call_rcu implementation (from IBM). I did some
> > 	modifications with respect to the original version from IBM.
> > 	In particular I dropped the vmalloc_rcu/kmalloc_rcu, the
> > 	rcu_head must always be allocated in the data structures, it has
> > 	to be a field of a class, rather than hiding it in the allocation
> > 	and playing dirty and risky with casts on a bigger allocation.
> 
> Do we really need yet-another per-CPU thread for this?  I'd prefer to have
> the context thread per-CPU instead (like in Ben's asynchio patch) and do
> this as well.

The first desing solution I proposed to Paul and Dipankar was just to
use ksoftirqd for that (in short set need_resched and wait it to be
cleared), it worked out nicely and it was a sensible improvement with
respect to their previous patches. (also it was reliable, we cannot
afford allocations in the wait_for_rcu path to avoid having to introduce
fail paths) it was also a noop to the ksoftirqd paths.

However they remarked ksoftirqd wasn't a RT thread so under very high
load it could introduce an higher latency to the wait_for_rcu calls.
keventd as well isn't a RT task and furthmore currently the
schedule_task as the property that only one task in the keventd queue
will be run at once (but I guess for the latter issue we can probably
ignore it since it's better not to rely on it).

So the obvious next step was to waste another 8k per cpu and to get the
best runtime behaviour and also very clean and self contained code. I
think that's rasonable.

So in short if you really are in pain for 8k per cpu to get the best
runtime behaviour and cleaner code I'd at least suggest to use the
ksoftirqd way that should be the next best step.

> BTW, do you plan to merge patches that actually _use_ this into your tree?

Long term of course, but with my further changes before the inclusion
the plain current patches shouldn't apply any longer, I'd like if the
developers of the current rcu fd patches could check my changes and
adapt them (if they agree with my changes of course ;).

> > Only in 2.4.10pre4aa1: 10_prefetch-4
> > Only in 2.4.10pre7aa1: 10_prefetch-5
> >
> > 	Part of prefetch in mainline, rediffed the architectural parts.
> 
> In my tree I also have an ia64 prefetch patch (I think it's from redhat,
> not sure though), it's appended if you want to take it.

thanks, applied.

Andrea
