Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265426AbRGBU3Z>; Mon, 2 Jul 2001 16:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265428AbRGBU3Q>; Mon, 2 Jul 2001 16:29:16 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:2058 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S265426AbRGBU3D>; Mon, 2 Jul 2001 16:29:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: linux-kernel@vger.kernel.org
Date: Mon, 2 Jul 2001 22:32:31 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Subject: [RFC] Early Flush with Bandwidth Estimation
Cc: Stephen Tweedie <sct@redhat.com>, Mike Galbraith <mikeg@wen-online.de>,
        arjan@fenrus.demon.nl (Arjan van de Ven)
Message-Id: <01070222323102.00338@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an experimental attempt to optimize my previous early flush
patch by adding continuous disk bandwidth estimation.  In spirit, the
new modifications are similar to Stephen Tweedie's "sard" disk
monitoring patch, though it was only after implementing my own ideas
that I became aware of the overlap.  On the other hand, what I have done
here is quite lightweight, on the order of 20 lines or so, and seems to
produce good results.

It is far from clear that this continuous bandwidth feedback from the IO
queue is the "right" approach.  Alternatively, it would be quite easy to
provide an interface from userland to allow the administrator to provide
a one-time bandwidth estimate, perhaps derived from hddisk -t.  On the
other hand, it would be just as easy to provide both an automatic
estimation and a manual override.  One big advantage of making the
automatic method the default is that no tuning needs to be done in order
to get decent performance from a new install.  Another potential
advantage is that bandwidth can change under different loads, so any
one-time estimate may prove to be sub-optimal. 

The Patch
---------

This is a patch set with three parts:

   1) A lightly edited version of the early flush patch
   2) Add-on bandwidth estimation
   3) Add-on proc interface for bandwidth estimate and transfer rate

Each part depends on the ones before it and each results in a usable
system.  I.e, to get the original early flush behaviour, just omit the
second and third patches.

The second patch adds bandwidth estimation and this is where things get
interesting from the benchmarking point of view.  At this point I
haven't done any rigorous benchmarking and I can only guess at the
performance effects.  On the other hand, by monitoring the bandwidth
estimate, I've learned some interesting things about how well we are 
doing in terms of optimizing disk seeks (not spectacularly well) and I
have also noticed what appears to be a low-level problem in the disk
queue, causing short periods of unreasonably low block transfer rates on
my laptop.

To apply:

  cd /usr/src/yourtree
  patch -p0 <thispatch

To reverse, you must separate the patch into it's three parts and
reverse in reverse order.  Sorry.  I will try to avoid placing multiple
patches in one file in the future. ;-)

For example:

  <edit this file into three parts: look for early.flush.1/2/3>
  patch -p0 <early.flush.3 --reverse
  patch -p0 <early.flush.2 --reverse
  patch -p0 <early.flush.1 --reverse

Method
------

As expected, estimating disk bandwidth is a little tricky.  There
are several problems.

  - There could be serveral disks on the downstream end
  - Some of them might not even be disks: ramdisk, flash, nbd.
  - Need to know when transfers are running back to back
  - Seeking can make the transfer rate highly variable

The way I decided to go at it is by considering two types of sample
periods: a) sample periods with continous activitiy and b) sample
periods with some idle time.  Sample periods that include idle time
only cause the bandwidth estimate to increase; those with continous
activity can cause the bandwidth estimate to increase or decrease.

The bandwidth samples thus obtained tend to fluctuate rapidly.  To make
them more useful, I filter them.  The line:

    bandwidth_sectors = (bandwidth_sectors*3 + bandwidth_sample)/4;

implements a simple low-pass filter using only shifts and adds.

In some respects, what has been implemented is a feedback loop.  When
early flushing is the only active disk IO process, the estimate of disk
bandwidth will tend to be continously improved.  This happens because
the flush will try to write keep the queue full to a level somewhat
greater (150%) of the bandwidth estimation, allowing the estimate to
increase by 50% on each poll interval.  When the queue has been properly
saturated with transfers the estimate can decrease as well.  Hence the
flushing behaviour causes migration towards a position of improved
knowledge about the underlying hardware.

Observations
------------

It turns out that measured bandwidth tends to fluctuate a great deal -
by a factor of 20 to 40.  This reflects the difference between
sequential transfers and those require large amounts of seeking.  For
example, an IDE disk may be capable of transfering a 4K block in 250
microseconds, but if the blocks are all on separate tracks the actual
transfer time may be 5 milliseconds or so, somewhere in the range of the
disk's average access time.  This gives a factor of 20 bandwidth
difference depending on access patterns.  I observed this in practice.

Interestingly, the use of smaller blocks gives an even wider variance.
This is because of the larger number of seeks possible for a given
amount of data.  I see 2-3 times as much variance with 1K blocks as with
4K blocks.  This is an important reason why larger block sizes are good
for throughput.  (However, note that the improvement could be illusory if
the data items being transfered are significantly smaller than the block
size.)

Peak transfer rates don't vary much with block size and remain near the
raw transfer rate of the disk as measured by hdparm -t.  This is
encouraging as far correctness of the measuring method goes.

A Level Disk Transfer Anomaly
-----------------------------

I have consistently observed a troubling anomaly in low level disk
transfer throughput.  On rare occasions, the low level transfer rate
seems to drop to about 10 blocks/second on my laptop.  During these
periods of slow transfers, the IO queue is typically backed up by a few
tens of sectors.  It is hard to imagine any hardware cause for this.  I
do not think that this measurement is due to a flaw in my method of
collecting statistics, nonetheless, it is possible.  If I have made no
mistake, then there is indeed something odd going on down at the lowest
levels of disk access. 

Application to Early Flushing
-----------------------------

The early flush algorithm essentially tries to use disk bandwidth that
would otherwise be unused.  When it detects a period of disk inactivity
it tries to write out as many old buffers as it can, without loading up
the disk queue so much that some higher priority user of the disk
bandwidth, such as the swapper, would be delayed too much.  In other
words, it wants to submit enough sectors for io to keep the disk busy
continuously, and not a lot more than that.  To do this accurately it
needs to know the disk bandwidth.

As discussed above, disk bandwidth is not a simple number, it depends on
what the disk is actually doing.  It's possible that keeping a
continuous estimate of disk throughput as I do in this patch is better
than assuming some fixed number.  There are dangers too.  Suppose for
example that a period of coherent IO results in a bandwidth estimate
close to the raw transfer rate of the drive, then activity ceases and
the early flush uses that estimate to begin a flush episode. 
Unfortunately, the blocks being flushed turn out to be highly
fragmented, and so 20 times more blocks are scheduled for IO than would
be ideal.  If there is no new demand for disk bandwidth during the
period of the flush episode, no harm is done, because the estimate will
be improved over the next few sample periods.  But if there is sudden
demand, the higher priority user will be delayed by the low priority
blocks in the queue.  Hopefully, such a unfortunate combination of
factors is a rare event, nonetheless I am giving consideration to how
the possible bad effects could be ameliorated.

I tested this patch just once on a live system, for a reality check.  In
that test I saw a 5% improvement in kernel compile speed:

  Command

    time make clean bzImage modules

  Vanila kernel

    real    11m58.176s
    user    10m37.840s
    sys     0m28.740s

  With early flush + bandwidth sensing

    real    11m21.227s
    user    8m38.160s
    sys     0m48.460s

More testing needs to be done to see if this is reproducible.

Other applications
------------------

There are other areas in the kernel that could benefit from using disk
bandwidth and queue size input.  Once example is page laundering.

Currently, page laundering relies on a memory pressure and clean page
statistics to decide how many pages to submit for writing. 
Unfortunately, under some loads, memory pressure is continuous, and that
statistic carries little useful information.  Similarly, some loads use
dirty pages as fast as they are cleaned, so the clean page statistic is
not reliable either.

Alternatively, page_launder could sense the length of the io queue and
use the disk bandwidth statistic to guide its decisions on how many
pages to write out.  It is counterproductive to load up the io queue
with too many dirty page writeouts, if only because a sudden relaxation
of the load can leave the system busily writing out pages when it should
be reading, e.g., swapping a gui program back in that was swapped out
under load.  So instead, page_launder can write out enough pages to let
the elevator work efficiently and stop there.

Other applications will no likely be found.  Even the possibilities for
opportunistic IO have hardly been mined out.

Possible Improvements
---------------------

The current patch is most probably sub-optimal.  For one thing, it lumps
reads and writes together in one bandwidth statistic.  For another, the
full/partial sample distinction is overly crude.  Something along the
lines of what Stephen Tweedie does in his sard patch with idle time
measurement would likely be superior.

>From the enterprise-computing point of view, the major improvement that
needs to be made is in separate analysis of multiple block devices.  This
per-device information needs to be propagated back into kernel
mechanisms such as bdflush, page_launder and the swapper.  Needless to
say, this is 2.5 material.

Proc Interface
--------------

In the third patch of this set I create a simple proc interface to
expose the bandwidth estimation, and another simple statistic, current
transfer rate, to user space.  This is used as follows:

  daniel@starship# cat /proc/bandwith
  1720 0

The first number is the current bandwidth estimate and the second is the
current transfer rate.  Note that the bandwidth estimate is updated only
when there is disk activity, and it can vary a great deal as described
above.  Do not be surprised to see a strangely low bandwith estimate
when the system is sitting idle - it can easily result from a final
burst of disk access that is extremely fragmented.

I do not pretend that the this proc interface is correct in any way,
however is should be fun to play with.

early.flush.1
-------------

--- ../uml.2.4.5.clean/drivers/block/ll_rw_blk.c	Thu Apr 12 21:15:52 2001
+++ ./drivers/block/ll_rw_blk.c	Sun Jul  1 02:48:35 2001
@@ -122,6 +122,7 @@
  * of memory with locked buffers
  */
 atomic_t queued_sectors;
+atomic_t submitted_sectors;
 
 /*
  * high and low watermark for above
--- ../uml.2.4.5.clean/include/linux/blkdev.h	Sat May 26 03:01:40 2001
+++ ./include/linux/blkdev.h	Sun Jul  1 02:51:09 2001
@@ -177,6 +177,7 @@
 extern int * max_segments[MAX_BLKDEV];
 
 extern atomic_t queued_sectors;
+extern atomic_t submitted_sectors;
 
 #define MAX_SEGMENTS 128
 #define MAX_SECTORS 255
@@ -213,6 +214,7 @@
 	}
 
 #define blk_started_io(nsects)				\
+	atomic_add(nsects, &submitted_sectors);		\
 	atomic_add(nsects, &queued_sectors);
 
 #endif
--- ../uml.2.4.5.clean/include/linux/fs.h	Sat May 26 03:01:28 2001
+++ ./include/linux/fs.h	Fri Jun 29 20:37:18 2001
@@ -236,7 +236,7 @@
 	atomic_t b_count;		/* users using this block */
 	kdev_t b_rdev;			/* Real device */
 	unsigned long b_state;		/* buffer state bitmap (see above) */
-	unsigned long b_flushtime;	/* Time when (dirty) buffer should be written */
+	unsigned long b_dirtytime;	/* Time buffer became dirty */
 
 	struct buffer_head *b_next_free;/* lru/free list linkage */
 	struct buffer_head *b_prev_free;/* doubly linked list of buffers */
--- ../uml.2.4.5.clean/mm/filemap.c	Thu May 31 15:29:06 2001
+++ ./mm/filemap.c	Fri Jun 29 20:37:19 2001
@@ -349,7 +349,7 @@
 		if (buffer_locked(bh) || !buffer_dirty(bh) || !buffer_uptodate(bh))
 			continue;
 
-		bh->b_flushtime = jiffies;
+		bh->b_dirtytime = jiffies /*- bdf_prm.b_un.age_buffer*/; // needed??
 		ll_rw_block(WRITE, 1, &bh);	
 	} while ((bh = bh->b_this_page) != head);
 	return 0;
--- ../uml.2.4.5.clean/mm/highmem.c	Sat May 26 02:57:46 2001
+++ ./mm/highmem.c	Fri Jun 29 20:37:19 2001
@@ -400,7 +400,7 @@
 	bh->b_rdev = bh_orig->b_rdev;
 	bh->b_state = bh_orig->b_state;
 #ifdef HIGHMEM_DEBUG
-	bh->b_flushtime = jiffies;
+	bh->b_dirtytime = jiffies /*- bdf_prm.b_un.age_buffer*/; // needed??
 	bh->b_next_free = NULL;
 	bh->b_prev_free = NULL;
 	/* bh->b_this_page */
--- ../uml.2.4.5.clean/fs/buffer.c	Sat May 26 02:57:46 2001
+++ ./fs/buffer.c	Sun Jul  1 02:46:51 2001
@@ -1076,7 +1076,7 @@
 
 static __inline__ void __mark_dirty(struct buffer_head *bh)
 {
-	bh->b_flushtime = jiffies + bdf_prm.b_un.age_buffer;
+	bh->b_dirtytime = jiffies;
 	refile_buffer(bh);
 }
 
@@ -2524,12 +2524,18 @@
    as all dirty buffers lives _only_ in the DIRTY lru list.
    As we never browse the LOCKED and CLEAN lru lists they are infact
    completly useless. */
-static int flush_dirty_buffers(int check_flushtime)
+
+static int bandwidth_sectors = 1000; /* 5 Meg/sec initial estimate */
+
+static int flush_dirty_buffers (int update)
 {
 	struct buffer_head * bh, *next;
-	int flushed = 0, i;
-
- restart:
+	unsigned sectors_to_flush = bdf_prm.b_un.ndirty << 3;
+	unsigned youngest_to_flush = jiffies - bdf_prm.b_un.age_buffer;
+	unsigned queued_goal = (bandwidth_sectors * 3) / 2;
+	int submitted = 0, i;
+	
+restart:
 	spin_lock(&lru_list_lock);
 	bh = lru_list[BUF_DIRTY];
 	if (!bh)
@@ -2544,22 +2550,18 @@
 		if (buffer_locked(bh))
 			continue;
 
-		if (check_flushtime) {
-			/* The dirty lru list is chronologically ordered so
-			   if the current bh is not yet timed out,
-			   then also all the following bhs
-			   will be too young. */
-			if (time_before(jiffies, bh->b_flushtime))
-				goto out_unlock;
-		} else {
-			if (++flushed > bdf_prm.b_un.ndirty)
+		if (update) {
+			if (time_before (youngest_to_flush, bh->b_dirtytime))
+				if (atomic_read (&queued_sectors) >= queued_goal)
+					goto out_unlock;
+		} else
+			if (sectors_to_flush >= sectors_to_flush)
 				goto out_unlock;
-		}
 
-		/* OK, now we are committed to write it out. */
 		atomic_inc(&bh->b_count);
 		spin_unlock(&lru_list_lock);
 		ll_rw_block(WRITE, 1, &bh);
+		submitted += bh->b_size >> 9;
 		atomic_dec(&bh->b_count);
 
 		if (current->need_resched)
@@ -2569,7 +2571,12 @@
  out_unlock:
 	spin_unlock(&lru_list_lock);
 
-	return flushed;
+#ifdef DEBUG
+	if (update)
+		printk("updated %i at %lu, %u queued\n",
+			submitted, jiffies, atomic_read (&queued_sectors));
+#endif
+	return submitted;
 }
 
 DECLARE_WAIT_QUEUE_HEAD(bdflush_wait);
@@ -2717,7 +2724,8 @@
 int kupdate(void *sem)
 {
 	struct task_struct * tsk = current;
-	int interval;
+	int submitted0 = atomic_read (&submitted_sectors);
+	int countdown = 0;
 
 	tsk->session = 1;
 	tsk->pgrp = 1;
@@ -2733,11 +2741,12 @@
 	up((struct semaphore *)sem);
 
 	for (;;) {
-		/* update interval */
-		interval = bdf_prm.b_un.interval;
-		if (interval) {
+		unsigned sync_interval = bdf_prm.b_un.interval;
+		unsigned poll_interval = HZ/10;
+		
+		if (sync_interval) {
 			tsk->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(interval);
+			schedule_timeout(poll_interval);
 		} else {
 		stop_kupdate:
 			tsk->state = TASK_STOPPED;
@@ -2756,10 +2765,17 @@
 			if (stopped)
 				goto stop_kupdate;
 		}
-#ifdef DEBUG
-		printk("kupdate() activated...\n");
-#endif
-		sync_old_buffers();
+		{
+			int submitted1 = atomic_read (&submitted_sectors);
+			if ((countdown -= poll_interval) < 0 || 
+				(submitted1 == submitted0 &&
+					atomic_read(&queued_sectors) < bandwidth_sectors))
+			{
+				submitted1 += sync_old_buffers();
+				countdown = sync_interval;
+			}
+			submitted0 = submitted1;
+		}
 	}
 }
 

early.flush.2
-------------

--- ../uml.2.4.5.clean/drivers/block/ll_rw_blk.c	Mon Jul  2 02:34:12 2001
+++ ./drivers/block/ll_rw_blk.c	Mon Jul  2 00:53:32 2001
@@ -123,6 +123,8 @@
  */
 atomic_t queued_sectors;
 atomic_t submitted_sectors;
+atomic_t completed_sectors;
+int queue_emptied;
 
 /*
  * high and low watermark for above
--- ../uml.2.4.5.clean/fs/buffer.c	Mon Jul  2 02:34:12 2001
+++ ./fs/buffer.c	Mon Jul  2 02:35:03 2001
@@ -2724,7 +2724,9 @@
 int kupdate(void *sem)
 {
 	struct task_struct * tsk = current;
+	unsigned bandwidth_sample = 0;
 	int submitted0 = atomic_read (&submitted_sectors);
+	int completed0 = atomic_read (&completed_sectors);
 	int countdown = 0;
 
 	tsk->session = 1;
@@ -2767,6 +2769,17 @@
 		}
 		{
 			int submitted1 = atomic_read (&submitted_sectors);
+			int completed1 = atomic_read (&completed_sectors);
+			int completed = completed1 - completed0;
+			int emptied = xchg(&queue_emptied, 0);
+
+			/* Update full or partial bandwidth sample */
+			if (emptied == 2 || completed > bandwidth_sample)
+				bandwidth_sample = completed;
+			
+			/* Low pass filter */
+			bandwidth_sectors = (bandwidth_sectors*3 + bandwidth_sample)/4;
+				
 			if ((countdown -= poll_interval) < 0 || 
 				(submitted1 == submitted0 &&
 					atomic_read(&queued_sectors) < bandwidth_sectors))
@@ -2775,6 +2788,15 @@
 				countdown = sync_interval;
 			}
 			submitted0 = submitted1;
+			completed0 = completed1;
+#if 0
+			printk("rate = %i, sample = %i, completed = %i, queued = %i, emptied = %i\n",
+				bandwidth_sectors,
+				bandwidth_sample,
+				completed, 
+				atomic_read (&queued_sectors),
+				emptied);
+#endif
 		}
 	}
 }
--- ../uml.2.4.5.clean/include/linux/blkdev.h	Mon Jul  2 02:34:12 2001
+++ ./include/linux/blkdev.h	Mon Jul  2 02:35:03 2001
@@ -178,6 +178,8 @@
 
 extern atomic_t queued_sectors;
 extern atomic_t submitted_sectors;
+extern atomic_t completed_sectors;
+extern int queue_emptied;
 
 #define MAX_SEGMENTS 128
 #define MAX_SECTORS 255
@@ -207,10 +209,16 @@
 }
 
 #define blk_finished_io(nsects)				\
+	atomic_add(nsects, &completed_sectors);		\
 	atomic_sub(nsects, &queued_sectors);		\
-	if (atomic_read(&queued_sectors) < 0) {		\
-		printk("block: queued_sectors < 0\n");	\
-		atomic_set(&queued_sectors, 0);		\
+	queue_emptied |= 2;				\
+	if (atomic_read(&queued_sectors) <= 0) {	\
+		if (atomic_read(&queued_sectors) == 0)	\
+			queue_emptied |= 1;		\
+		else {					\
+			printk("block: queued_sectors < 0\n");	\
+			atomic_set(&queued_sectors, 0);	\
+		}					\
 	}
 
 #define blk_started_io(nsects)				\

early.flush.3
-------------

--- ../uml.2.4.5.clean/fs/buffer.c	Mon Jul  2 02:22:45 2001
+++ ./fs/buffer.c	Mon Jul  2 01:32:29 2001
@@ -2525,7 +2525,8 @@
    As we never browse the LOCKED and CLEAN lru lists they are infact
    completly useless. */
 
-static int bandwidth_sectors = 1000; /* 5 Meg/sec initial estimate */
+int bandwidth_sectors = 1000; /* 5 Meg/sec initial estimate */
+int transfers_sectors = 0; /* Filtered actual transfer rate */
 
 static int flush_dirty_buffers (int update)
 {
@@ -2779,6 +2780,7 @@
 			
 			/* Low pass filter */
 			bandwidth_sectors = (bandwidth_sectors*3 + bandwidth_sample)/4;
+			transfers_sectors = (transfers_sectors + completed)/2;
 				
 			if ((countdown -= poll_interval) < 0 || 
 				(submitted1 == submitted0 &&
--- ../uml.2.4.5.clean/fs/proc/proc_misc.c	Sat Apr 14 05:26:07 2001
+++ ./fs/proc/proc_misc.c	Mon Jul  2 01:32:29 2001
@@ -100,6 +100,17 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
+static int bandwidth_read_proc(char *page, char **start, off_t off,
+				 int count, int *eof, void *data)
+{
+	extern int bandwidth_sectors;
+	extern int transfers_sectors;
+	return proc_calc_metrics(page, start, off, count, eof,
+		sprintf(page,"%i %i\n",
+			bandwidth_sectors * 10 / 2,
+			transfers_sectors * 10 / 2));
+}
+
 static int uptime_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -514,6 +525,7 @@
 		int (*read_proc)(char*,char**,off_t,int,int*,void*);
 	} *p, simple_ones[] = {
 		{"loadavg",     loadavg_read_proc},
+		{"bandwidth",   bandwidth_read_proc},
 		{"uptime",	uptime_read_proc},
 		{"meminfo",	meminfo_read_proc},
 		{"version",	version_read_proc},
--- ../uml.2.4.5.clean/include/linux/blkdev.h	Mon Jul  2 02:00:13 2001
+++ ./include/linux/blkdev.h	Mon Jul  2 01:32:29 2001
@@ -180,6 +180,8 @@
 extern atomic_t submitted_sectors;
 extern atomic_t completed_sectors;
 extern int queue_emptied;
+extern int bandwidth_sectors;
+extern int bandwidth_sectors;
 
 #define MAX_SEGMENTS 128
 #define MAX_SECTORS 255

