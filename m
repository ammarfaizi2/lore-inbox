Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262115AbSIZGKx>; Thu, 26 Sep 2002 02:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262199AbSIZGKx>; Thu, 26 Sep 2002 02:10:53 -0400
Received: from packet.digeo.com ([12.110.80.53]:5082 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262115AbSIZGKt>;
	Thu, 26 Sep 2002 02:10:49 -0400
Message-ID: <3D92A61E.40BFF2D0@digeo.com>
Date: Wed, 25 Sep 2002 23:15:58 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] deadline io scheduler
References: <20020925172024.GH15479@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Sep 2002 06:15:58.0961 (UTC) FILETIME=[2E49C610:01C26524]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is looking good.   With a little more tuning and tweaking
this problem is solved.

The horror test was:

	cd /usr/src/linux
	dd if=/dev/zero of=foo bs=1M count=4000
	sleep 5
	time cat kernel/*.c > /dev/null

Testing on IDE (this matters - SCSI is very different)

- On 2.5.38 + souped-up VM it was taking 25 seconds.

- My read-latency patch took 1 second-odd.

- Linus' rework yesterday was taking 0.3 seconds.

- With Linus' current tree (with the deadline scheduler) it now takes
  5 seconds.

Let's see what happens as we vary read_expire:

	read_expire (ms)	time cat kernel/*.c (secs)
		500			5.2
		400			3.8
		300			4.5
		200			3.9
		100			5.1
		 50			5.0

well that was a bit of a placebo ;)

Let's leave read_expire at 500ms and diddle writes_starved:

	writes_starved (units)	time cat kernel/*.c (secs)
		 1			4.8
		 2			4.4
		 4			4.0
		 8			4.9
		16			4.9


Now alter fifo_batch, everything else default:

	fifo_batch (units)	time cat kernel/*.c (secs)
		64			5.0
		32			2.0
		16			0.2
		 8			0.17

OK, that's a winner.


Here's something really nice with the deadline scheduler.  I was
madly catting five separate kernel trees (five reading processes)
and then started a big `dd', tunables at default:

   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 0  9  0   6008   2460   8304 324716    0    0  2048     0 1102   254 13 88  0
 0  7  0   6008   2600   8288 324480    0    0  1800     0 1114   266  0 100  0
 0  6  0   6008   2452   8292 324520    0    0  2432     0 1126   287 29 71  0
 0  6  0   6008   3160   8292 323952    0    0  3568     0 1132   312  0 100  0
 0  6  0   6008   2860   8296 324148  128    0  2984     0 1119   281 17 83  0
 1  6  0   5984   2856   8264 323816  352    0  5240     0 1162   479  0 100  0
 0  7  1   5984   4152   7876 324068    0    0  1648 28192 1215  1572  1 99  0
 0  9  2   6016   3136   7300 328568    0  180  1232 37248 1324  1201  3 97  0
 0  9  2   6020   5260   5628 329212    0    4  1112 29488 1296   560  0 100  0
 0  9  3   6020   3548   5596 330944    0    0  1064 35240 1302   629  6 94  0
 0  9  3   6020   3412   5572 331352    0    0   744 31744 1298   452  6 94  0
 0  9  2   6020   1516   5576 333352    0    0   888 31488 1283   467  0 100  0
 0  9  2   6020   3528   5580 331396    0    0  1312 20768 1251   385  0 100  0

Note how the read rate maybe halved, and we sustained a high
volume of writeback.  This is excellent.


Let's try it again with fifo_batch at 16:

 0  5  0     80 303936   3960  49288    0    0  2520     0 1092   174  0 100  0
 0  5  0     80 302400   3996  50776    0    0  3040     0 1094   172 20 80  0
 0  5  0     80 301164   4032  51988    0    0  2504     0 1082   150  0 100  0
 0  5  0     80 299708   4060  53412    0    0  2904     0 1084   149  0 100  0
 1  5  1     80 164640   4060 186784    0    0  1344 26720 1104   891  1 99  0
 0  6  2     80 138900   4060 212088    0    0   280  7928 1039   226  0 100  0
 0  6  2     80 134992   4064 215928    0    0  1512  7704 1100   226  0 100  0
 0  6  2     80 130880   4068 219976    0    0  1928  9688 1124   245 17 83  0
 0  6  2     80 123316   4084 227432    0    0  2664  8200 1125   283 11 89  0

That looks acceptable.  Writes took quite a bit of punishment, but
the VM should cope with that OK.

It'd be interesting to know why read_expire and writes_starved have
no effect, while fifo_batch has a huge effect.

I'd like to gain a solid understanding of what these three knobs do.
Could you explain that a little more?

During development I'd suggest the below patch, to add
/proc/sys/vm/read_expire, fifo_batch and writes_starved - it beats
recompiling each time.

I'll test scsi now.



 drivers/block/deadline-iosched.c |   18 +++++++++---------
 kernel/sysctl.c                  |   12 ++++++++++++
 2 files changed, 21 insertions(+), 9 deletions(-)

--- 2.5.38/drivers/block/deadline-iosched.c~akpm-deadline	Wed Sep 25 22:16:36 2002
+++ 2.5.38-akpm/drivers/block/deadline-iosched.c	Wed Sep 25 23:05:45 2002
@@ -24,14 +24,14 @@
  * fifo_batch is how many steps along the sorted list we will take when the
  * front fifo request expires.
  */
-static int read_expire = HZ / 2;	/* 500ms start timeout */
-static int fifo_batch = 64;		/* 4 seeks, or 64 contig */
-static int seek_cost = 16;		/* seek is 16 times more expensive */
+int read_expire = HZ / 2;	/* 500ms start timeout */
+int fifo_batch = 64;		/* 4 seeks, or 64 contig */
+int seek_cost = 16;		/* seek is 16 times more expensive */
 
 /*
  * how many times reads are allowed to starve writes
  */
-static int writes_starved = 2;
+int writes_starved = 2;
 
 static const int deadline_hash_shift = 8;
 #define DL_HASH_BLOCK(sec)	((sec) >> 3)
@@ -253,7 +253,7 @@ static void deadline_move_requests(struc
 {
 	struct list_head *sort_head = &dd->sort_list[rq_data_dir(rq)];
 	sector_t last_sec = dd->last_sector;
-	int batch_count = dd->fifo_batch;
+	int batch_count = fifo_batch;
 
 	do {
 		struct list_head *nxt = rq->queuelist.next;
@@ -267,7 +267,7 @@ static void deadline_move_requests(struc
 		if (rq->sector == last_sec)
 			batch_count--;
 		else
-			batch_count -= dd->seek_cost;
+			batch_count -= seek_cost;
 
 		if (nxt == sort_head)
 			break;
@@ -319,7 +319,7 @@ dispatch:
 	 * if we have expired entries on the fifo list, move some to dispatch
 	 */
 	if (deadline_check_fifo(dd)) {
-		if (writes && (dd->starved++ >= dd->writes_starved))
+		if (writes && (dd->starved++ >= writes_starved))
 			goto dispatch_writes;
 
 		nxt = dd->read_fifo.next;
@@ -329,7 +329,7 @@ dispatch:
 	}
 
 	if (!list_empty(&dd->sort_list[READ])) {
-		if (writes && (dd->starved++ >= dd->writes_starved))
+		if (writes && (dd->starved++ >= writes_starved))
 			goto dispatch_writes;
 
 		nxt = dd->sort_list[READ].next;
@@ -392,7 +392,7 @@ deadline_add_request(request_queue_t *q,
 		/*
 		 * set expire time and add to fifo list
 		 */
-		drq->expires = jiffies + dd->read_expire;
+		drq->expires = jiffies + read_expire;
 		list_add_tail(&drq->fifo, &dd->read_fifo);
 	}
 }
--- 2.5.38/kernel/sysctl.c~akpm-deadline	Wed Sep 25 22:59:48 2002
+++ 2.5.38-akpm/kernel/sysctl.c	Wed Sep 25 23:05:42 2002
@@ -272,6 +272,9 @@ static int zero = 0;
 static int one = 1;
 static int one_hundred = 100;
 
+extern int fifo_batch;
+extern int read_expire;
+extern int writes_starved;
 
 static ctl_table vm_table[] = {
 	{VM_OVERCOMMIT_MEMORY, "overcommit_memory", &sysctl_overcommit_memory,
@@ -314,6 +317,15 @@ static ctl_table vm_table[] = {
 	 {VM_HUGETLB_PAGES, "nr_hugepages", &htlbpage_max, sizeof(int), 0644, NULL, 
 	  &proc_dointvec},
 #endif
+	{90, "read_expire",
+	 &read_expire, sizeof(read_expire), 0644,
+	 NULL, &proc_dointvec},
+	{91, "fifo_batch",
+	 &fifo_batch, sizeof(fifo_batch), 0644,
+	 NULL, &proc_dointvec},
+	{92, "writes_starved",
+	 &writes_starved, sizeof(writes_starved), 0644,
+	 NULL, &proc_dointvec},
 	{0}
 };
 

.
