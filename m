Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264475AbRFTBsW>; Tue, 19 Jun 2001 21:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264476AbRFTBsM>; Tue, 19 Jun 2001 21:48:12 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:28944 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S264475AbRFTBrz>; Tue, 19 Jun 2001 21:47:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Mike Galbraith <mikeg@wen-online.de>
Subject: [RFC] Early flush (was: spindown)
Date: Wed, 20 Jun 2001 03:50:33 +0200
X-Mailer: KMail [version 1.2]
Cc: Rik van Riel <riel@conectiva.com.br>, Pavel Machek <pavel@suse.cz>,
        John Stoffel <stoffel@casc.com>,
        Roger Larsson <roger.larsson@norran.net>, <thunder7@xs4all.nl>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0106171156410.318-100000@mikeg.weiden.de> <01061816220503.11745@starship>
In-Reply-To: <01061816220503.11745@starship>
MIME-Version: 1.0
Message-Id: <01062003503300.00439@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I never realized how much I didn't like the good old 5 second delay between 
saving an edit and actually getting it written to disk until it went away.  
Now the question is, did I lose any performance in doing that.  What I wrote 
in the previous email turned out to be pretty accurate, so I'll just quote it 
to keep it together with the patch:

> I'm now in the midst of hatching a patch. [1] The first thing I had to do
> is go explore the block driver code, yum yum.  I found that it already
> computes the statistic I'm interested in, namely queued_sectors, which is
> used to pace the IO on block devices.  It's a little crude - we really want
> this to be per-queue and have one queue per "spindle" - but even in its
> current form it's workable.
>
> The idea is that when queued_sectors drops below some threshold we have
> 'unused disk bandwidth' so it would be nice to do something useful with it:
>
>   1) Do an early 'sync_old_buffers'
>   2) Do some preemptive pageout
>
> The benefit of (1) is that it lets disks go idle a few seconds earlier, and
> (2) should improve the system's latency in response to load surges.  There
> are drawbacks too, which have been pointed out to me privately, but they
> tend to be pretty minor, for example: on a flash disk you'd do a few extra
> writes and wear it out ever-so-slightly sooner.  All the same, such special
> devices can be dealt easily once we progress a little further in improving
> the kernel's 'per spindle' intelligence.
>
> Now how to implement this.  I considered putting a (newly minted)
> wakeup_kflush in blk_finished_io, conditional on a loaded-to-unloaded
> transition, and that's fine except it doesn't do the whole job: we also
> need to have the early flush for any write to a disk file while the disks
> are lightly loaded, i.e., there is no convenient loaded-to-unloaded
> transition to trigger it.  The missing trigger could be inserted into
> __mark_dirty, but that would penalize the loaded state (a little, but
> that's still too much). Furthermore, it's probably desirable to maintain a
> small delay between the dirty and the flush.  So what I'll try first is
> just running kflush's timer faster, and make its reschedule period vary
> with disk load, i.e., when there are fewer queued_sectors, kflush looks at
> the dirty buffer list more often.
>
> The rest of what has to happen in kflush is pretty straightforward.  It
> just uses queued_sectors to determine how far to walk the dirty buffer
> list, which is maintained in time-since-dirtied order.  If queued_sectors
> is below some threshold the entire list is flushed.  Note that we want to
> change the sense of b_flushtime to b_timedirtied.  It's more efficient to
> do it this way anyway.
>
> I haven't done anything about preemptive pageout yet, but similar ideas
> apply.
>
> [1] This is an experiment, do not worry, it will not show up in your tree
> any time soon.  IOW, constructive criticism appreciated, flames copied to
> /dev/null.

I originally intended to implement a sliding flush delay based on disk load.  
This turned out to be a lot of work for a hard-to-discern benefit.  So the 
current approach has just two delays: .1 second and whatever the bdflush 
delay is set to.  If there is any non-flush disk traffic the longer delay is 
used.  This is crude but effective... I think.  I hope that somebody will run 
this through some benchmarks to see if I lost any performance.  According to 
my calculations, I did not.  I tested this mainly in UML, and also ran it 
briefly on my laptop.  The interactive feel of the change is immediately 
obvious, and for me at least, a big improvement.

The patch is against 2.4.5.  To apply:

  cd /your/source/tree
  patch <this/patch -p0

--- ../uml.2.4.5.clean/fs/buffer.c	Sat May 26 02:57:46 2001
+++ ./fs/buffer.c	Wed Jun 20 01:55:21 2001
@@ -1076,7 +1076,7 @@
 
 static __inline__ void __mark_dirty(struct buffer_head *bh)
 {
-	bh->b_flushtime = jiffies + bdf_prm.b_un.age_buffer;
+	bh->b_dirtytime = jiffies;
 	refile_buffer(bh);
 }
 
@@ -2524,12 +2524,20 @@
    as all dirty buffers lives _only_ in the DIRTY lru list.
    As we never browse the LOCKED and CLEAN lru lists they are infact
    completly useless. */
-static int flush_dirty_buffers(int check_flushtime)
+static int flush_dirty_buffers (int update)
 {
 	struct buffer_head * bh, *next;
 	int flushed = 0, i;
+	unsigned queued = atomic_read (&queued_sectors);
+	unsigned long youngest_to_update;
 
- restart:
+#ifdef DEBUG
+	if (update)
+		printk("kupdate %lu %i\n", jiffies, queued);
+#endif
+
+restart:
+	youngest_to_update = jiffies - (queued? bdf_prm.b_un.age_buffer: 0);
 	spin_lock(&lru_list_lock);
 	bh = lru_list[BUF_DIRTY];
 	if (!bh)
@@ -2544,19 +2552,14 @@
 		if (buffer_locked(bh))
 			continue;
 
-		if (check_flushtime) {
-			/* The dirty lru list is chronologically ordered so
-			   if the current bh is not yet timed out,
-			   then also all the following bhs
-			   will be too young. */
-			if (time_before(jiffies, bh->b_flushtime))
+		if (update) {
+			if (time_before (youngest_to_update, bh->b_dirtytime))
 				goto out_unlock;
 		} else {
 			if (++flushed > bdf_prm.b_un.ndirty)
 				goto out_unlock;
 		}
 
-		/* OK, now we are committed to write it out. */
 		atomic_inc(&bh->b_count);
 		spin_unlock(&lru_list_lock);
 		ll_rw_block(WRITE, 1, &bh);
@@ -2717,7 +2720,7 @@
 int kupdate(void *sem)
 {
 	struct task_struct * tsk = current;
-	int interval;
+	int update_when = 0;
 
 	tsk->session = 1;
 	tsk->pgrp = 1;
@@ -2733,11 +2736,11 @@
 	up((struct semaphore *)sem);
 
 	for (;;) {
-		/* update interval */
-		interval = bdf_prm.b_un.interval;
-		if (interval) {
+		unsigned check_interval = HZ/10, update_interval = bdf_prm.b_un.interval;
+		
+		if (update_interval) {
 			tsk->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(interval);
+			schedule_timeout(check_interval);
 		} else {
 		stop_kupdate:
 			tsk->state = TASK_STOPPED;
@@ -2756,10 +2759,15 @@
 			if (stopped)
 				goto stop_kupdate;
 		}
+		update_when -= check_interval;
+		if (update_when > 0 && atomic_read(&queued_sectors))
+			continue;
+
 #ifdef DEBUG
 		printk("kupdate() activated...\n");
 #endif
 		sync_old_buffers();
+		update_when = update_interval;
 	}
 }
 
--- ../uml.2.4.5.clean/include/linux/fs.h	Sat May 26 03:01:28 2001
+++ ./include/linux/fs.h	Tue Jun 19 15:12:18 2001
@@ -236,7 +236,7 @@
 	atomic_t b_count;		/* users using this block */
 	kdev_t b_rdev;			/* Real device */
 	unsigned long b_state;		/* buffer state bitmap (see above) */
-	unsigned long b_flushtime;	/* Time when (dirty) buffer should be written */
+	unsigned long b_dirtytime;	/* Time buffer became dirty */
 
 	struct buffer_head *b_next_free;/* lru/free list linkage */
 	struct buffer_head *b_prev_free;/* doubly linked list of buffers */
--- ../uml.2.4.5.clean/mm/filemap.c	Thu May 31 15:29:06 2001
+++ ./mm/filemap.c	Tue Jun 19 15:32:47 2001
@@ -349,7 +349,7 @@
 		if (buffer_locked(bh) || !buffer_dirty(bh) || !buffer_uptodate(bh))
 			continue;
 
-		bh->b_flushtime = jiffies;
+		bh->b_dirtytime = jiffies /*- bdf_prm.b_un.age_buffer*/; // needed??
 		ll_rw_block(WRITE, 1, &bh);	
 	} while ((bh = bh->b_this_page) != head);
 	return 0;
--- ../uml.2.4.5.clean/mm/highmem.c	Sat May 26 02:57:46 2001
+++ ./mm/highmem.c	Tue Jun 19 15:33:22 2001
@@ -400,7 +400,7 @@
 	bh->b_rdev = bh_orig->b_rdev;
 	bh->b_state = bh_orig->b_state;
 #ifdef HIGHMEM_DEBUG
-	bh->b_flushtime = jiffies;
+	bh->b_dirtytime = jiffies /*- bdf_prm.b_un.age_buffer*/; // needed??
 	bh->b_next_free = NULL;
 	bh->b_prev_free = NULL;
 	/* bh->b_this_page */
 
