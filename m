Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWEBHuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWEBHuj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 03:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWEBHuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 03:50:39 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:58510 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932257AbWEBHuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 03:50:39 -0400
Message-ID: <346556235.24875@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Tue, 2 May 2006 15:50:49 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: [RFC] kernel facilities for cache prefetching
Message-ID: <20060502075049.GA5000@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Badari Pulavarty <pbadari@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pre-caching reloaded ;)

I have been exploring cache prefetching on desktop systems for quite
some time, and recently found ways that have _proven_ effects.

The basic ideas are described in the following google soc proposal,
with the proof-of-concept patch to support I/O priority attached.

I'd like to know whether the two proposed kernel components would be
acceptable for the mainline kernel, and any recommends to improve them.

Thanks,
Wu

------------------------------------------------------------------------
SOC PROPOSAL

	Rapid linux desktop startup through pre-caching


MOTIVATION

	KDE, Gnome, OpenOffice, and Firefox all take too long to start up.
	Boot time pre-caching seems to be the single most straightforward and
	effective way to improve it and make linux desktop experience more
	comfortable. It is a great pleasure for me to take up the work.


QUALIFICATION

	I have been working on linux kernel readahead for over a year, and
	developed an adaptive readahead patch(http://lwn.net/Articles/155510/)
	to bring a bunch of new capabilities to linux.  During the time I
	gained knowledge about the VM/IO subsystems of linux kernel, and get
	acquainted with the slow startup problem, the existing solutions, why
	they do no work as one would expect and how to get the job better done.


PREVIOUS WORKS

	There has been some similar efforts, i.e.
		- Linux: Boot Time Speedups Through Precaching
		  http://kerneltrap.org/node/2157
		- Andrew Morton's kernel module solution
		  http://www.zip.com.au/~akpm/linux/fboot.tar.gz
		- preload - adaptive readahead daemon
		  http://sourceforge.net/projects/preload
	The formers are mainly kernel staffs, while the latter is a pure
	user-land solution. But none seems to do the trick for system startup
	time.  Andrew saw ~10% speedup, while preload actually saw slow down.

	IMHO, Andrew's kernel module to dump the contents of pagecache and to
	restore it at boot time is one step towards the final solution.
	However, it takes one more step to actually win the time: to optimize
	the I/O on restoring time.


I/O ANALYSE

	How come the prefetcher gains little or even negative time?

	After some huntings in the source tree and some experiments,
	I came to the conclusions that

	1. the prefetcher has to readahead one file _after_ another, thus loses
	   the opportunity to reorder the blocks and reduce seeking time.
	   == reasoning ==
	   It tends to be blocked on calling open(), where the kernel has to do
	   some dir/inode/bmap lookups and do tiny I/Os _synchronously_ and with
	   _locks_ held.

	2. the readahead I/O stands in the way of normal I/O, thus the prefetcher
	   blocks normal apps and loses the opportunity to overlap CPU/IO time.
	   == reasoning ==
	   Support of I/O priority is still incomplete for linux. Of the three
	   I/O elevators, anticipatory & deadline simply overlooks priority;
	   CFQ is built for fair I/O priorities, though is still not enough for
	   the case of readahead.  Imagine that the prefetcher first issues an
	   I/O request for page A with low priority, then comes the real app
	   that needs page A, and simply waits on the page to be available,
	   which will take rather long time because the elevator still thinks
	   the page as a low priority one.

	So we get the amazing fact that prefetching actually slows things down!


SCHEME/GOAL

	1) kernel facility to provide necessary I/O priority support
		- add basic I/O priority support to AS/deadline elevators:
		  never have readahead I/O stand in the way of normal I/O
		- enable AS/CFQ/deadline to react on I/O priority changes:
		  reschedule a previous readahead I/O that is now actually
		  demanded by a legacy program

	2) kernel module to query the file cache
		- on loading: create /proc/filecache
		- setting up: echo "param value" > /proc/filecache
		- info query: cat /proc/filecache
		- sample sessions:

		# modprobe filecache
		$ cat /proc/filecache
		# file ALL
		# mask 0
		#
		# ino	size	cached	status	refcnt	name
		0	2929846	3181	D	1	/dev/hda1
		81455	9	9	_	1	/sbin/init
		......
	
		$ echo "file /dev/hda1" > /proc/filecache
		$ cat /proc/filecache
		# file /dev/hda1
		# mask 0
		#
		# idx	len
		0	24
		48	2
		53	5
		......

	3) user-land tools to dump the current content of file cache,
	   and to restore it on boot time
		- store as plain text files to be script/user friendly
		- be able to run on the very beginning of boot process
		- be able to trim down the cache records (for small systems)
		- optional poor man's defrag ;)
		- record and replay I/O for any task by taking two cache
		  snapshots and do a set-substract

	A proof of concept implementation has been developed and ran on my
	desktop. According to the experimental results, the expected effect
	of the final work would be:
		- the power-on to login time remains roughly the same
		- most gui files are ready on login time
		- login to usable desktop time comes close to a warm startup

BIO

	I am currently pursuing PhD. degree in University of Science and
	Technology of China. I enjoy computing and GNU/Linux.

	- programming since 1993
	- using linux since 1998
	- playing PXE since 2000
	- developing OSS since 2004
	- developing adaptive readahead for linux since 2005

------------------------------------------------------------------------
 block/deadline-iosched.c |   35 +++++++++++++++++++++++++++++++++++
 block/ll_rw_blk.c        |    8 ++++++++
 fs/buffer.c              |    5 +++--
 include/linux/elevator.h |    2 ++
 4 files changed, 48 insertions(+), 2 deletions(-)

--- linux.orig/block/deadline-iosched.c
+++ linux/block/deadline-iosched.c
@@ -310,6 +310,40 @@ deadline_add_request(struct request_queu
 }
 
 /*
+ * kick a page for io
+ */
+static int
+deadline_kick_page(struct request_queue *q, struct page *page)
+{
+	struct deadline_data *dd = q->elevator->elevator_data;
+	struct deadline_rq *drq;
+	struct request *rq;
+	struct list_head *pos;
+	struct bio_vec *bvec;
+	struct bio *bio;
+	int i;
+
+	list_for_each(pos, &dd->fifo_list[READ]) {
+		drq = list_entry_fifo(pos);
+		rq = drq->request;
+		rq_for_each_bio(bio, rq) {
+			bio_for_each_segment(bvec, bio, i) {
+				if (page == bvec->bv_page)
+					goto found;
+			}
+		}
+	}
+
+	return -1;
+
+found:
+	rq->ioprio = 1;
+	list_del(&drq->fifo);
+	deadline_add_drq_fifo(dd, rq);
+	return 0;
+}
+
+/*
  * remove rq from rbtree, fifo, and hash
  */
 static void deadline_remove_request(request_queue_t *q, struct request *rq)
@@ -784,6 +818,7 @@ static struct elevator_type iosched_dead
 		.elevator_merge_req_fn =	deadline_merged_requests,
 		.elevator_dispatch_fn =		deadline_dispatch_requests,
 		.elevator_add_req_fn =		deadline_add_request,
+		.elevator_kick_page_fn =	deadline_kick_page,
 		.elevator_queue_empty_fn =	deadline_queue_empty,
 		.elevator_former_req_fn =	deadline_former_request,
 		.elevator_latter_req_fn =	deadline_latter_request,
--- linux.orig/block/ll_rw_blk.c
+++ linux/block/ll_rw_blk.c
@@ -1620,6 +1620,14 @@ static void blk_backing_dev_unplug(struc
 {
 	request_queue_t *q = bdi->unplug_io_data;
 
+	if (page &&
+		IOPRIO_PRIO_CLASS(current->ioprio) != IOPRIO_CLASS_IDLE &&
+		q->elevator && q->elevator->ops->elevator_kick_page_fn) {
+		spin_lock_irq(q->queue_lock);
+		q->elevator->ops->elevator_kick_page_fn(q, page);
+		spin_unlock_irq(q->queue_lock);
+	}
+
 	/*
 	 * devices don't necessarily have an ->unplug_fn defined
 	 */
--- linux.orig/fs/buffer.c
+++ linux/fs/buffer.c
@@ -63,8 +63,9 @@ static int sync_buffer(void *word)
 
 	smp_mb();
 	bd = bh->b_bdev;
-	if (bd)
-		blk_run_address_space(bd->bd_inode->i_mapping);
+	if (bd && bd->bd_inode && bd->bd_inode->i_mapping)
+		blk_run_backing_dev(bd->bd_inode->i_mapping->backing_dev_info,
+					bh->b_page);
 	io_schedule();
 	return 0;
 }
--- linux.orig/include/linux/elevator.h
+++ linux/include/linux/elevator.h
@@ -20,6 +20,7 @@ typedef int (elevator_set_req_fn) (reque
 typedef void (elevator_put_req_fn) (request_queue_t *, struct request *);
 typedef void (elevator_activate_req_fn) (request_queue_t *, struct request *);
 typedef void (elevator_deactivate_req_fn) (request_queue_t *, struct request *);
+typedef int (elevator_kick_page_fn) (request_queue_t *, struct page *);
 
 typedef int (elevator_init_fn) (request_queue_t *, elevator_t *);
 typedef void (elevator_exit_fn) (elevator_t *);
@@ -34,6 +35,7 @@ struct elevator_ops
 	elevator_add_req_fn *elevator_add_req_fn;
 	elevator_activate_req_fn *elevator_activate_req_fn;
 	elevator_deactivate_req_fn *elevator_deactivate_req_fn;
+	elevator_kick_page_fn *elevator_kick_page_fn;
 
 	elevator_queue_empty_fn *elevator_queue_empty_fn;
 	elevator_completed_req_fn *elevator_completed_req_fn;
