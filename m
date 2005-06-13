Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVFMJqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVFMJqz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 05:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVFMJqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 05:46:55 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:27818 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261282AbVFMJqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 05:46:42 -0400
Message-ID: <42AD55FA.50109@yahoo.com.au>
Date: Mon, 13 Jun 2005 19:46:34 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] blkstat
Content-Type: multipart/mixed;
 boundary="------------090501030004090207050200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090501030004090207050200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I have made a simple tool to measure idle and busy time for
block devices.

I have been wanting something like this for a while, because
the absolute throughput/seek numbers don't always help you
determine whether or not a workload is becoming IO bound.

It requires a small kernel patch, and I've also attached my
lame userspace program for it. It is kind of like vmstat.

Oh, and before I go further, does anyone know of any program
or statistic that allows the same functionality? Any comments?

** sample output **
npiggin@didi:~/blk$ ./blkstat hda
bdev      bi %    bo %    io %    id %
hda        0.0     0.0     0.0   100.0
hda        0.0     0.0     0.0   100.0
hda        1.2     0.0     1.2    98.8
hda       48.1     0.0    48.1    51.9
hda       53.6     0.0    53.6    46.4
hda       47.1     0.0    47.1    52.9


Nick

-- 
SUSE Labs, Novell Inc.


--------------090501030004090207050200
Content-Type: text/plain;
 name="blk-start-time.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blk-start-time.patch"

Index: linux-2.6/include/linux/blkdev.h
===================================================================
--- linux-2.6.orig/include/linux/blkdev.h	2005-06-10 21:11:21.000000000 +1000
+++ linux-2.6/include/linux/blkdev.h	2005-06-10 21:20:53.000000000 +1000
@@ -137,7 +137,6 @@ struct request {
 	int rq_status;	/* should split this into a few status bits */
 	struct gendisk *rq_disk;
 	int errors;
-	unsigned long start_time;
 
 	/* Number of scatter-gather DMA addr+len pairs after
 	 * physical address coalescing is performed.
@@ -368,6 +367,11 @@ struct request_queue
 	struct kobject kobj;
 
 	/*
+	 * Jiffies. Time the current request was started
+	 */
+	unsigned long		start_time;
+	
+	/*
 	 * queue settings
 	 */
 	unsigned long		nr_requests;	/* Max # of requests */
Index: linux-2.6/drivers/block/ll_rw_blk.c
===================================================================
--- linux-2.6.orig/drivers/block/ll_rw_blk.c	2005-06-10 21:10:26.000000000 +1000
+++ linux-2.6/drivers/block/ll_rw_blk.c	2005-06-11 16:23:38.000000000 +1000
@@ -1914,10 +1914,13 @@ static struct request *get_request(reque
 	}
 
 get_rq:
+	if (rl->count[READ] + rl->count[WRITE] == 0)
+		q->start_time = jiffies;
 	rl->count[rw]++;
 	rl->starved[rw] = 0;
 	if (rl->count[rw] >= queue_congestion_on_threshold(q))
 		set_queue_congested(q, rw);
+
 	spin_unlock_irq(q->queue_lock);
 
 	rq = blk_alloc_request(q, rw, gfp_mask);
@@ -2487,15 +2490,6 @@ static int attempt_merge(request_queue_t
 	if (!q->merge_requests_fn(q, req, next))
 		return 0;
 
-	/*
-	 * At this point we have either done a back merge
-	 * or front merge. We need the smaller start_time of
-	 * the merged requests to be the current request
-	 * for accounting purposes.
-	 */
-	if (time_after(req->start_time, next->start_time))
-		req->start_time = next->start_time;
-
 	req->biotail->bi_next = next->bio;
 	req->biotail = next->biotail;
 
@@ -2703,7 +2697,6 @@ get_rq:
 	req->waiting = NULL;
 	req->bio = req->biotail = bio;
 	req->rq_disk = bio->bi_bdev->bd_disk;
-	req->start_time = jiffies;
 
 	add_request(q, req);
 out:
@@ -3195,13 +3188,16 @@ EXPORT_SYMBOL(end_that_request_chunk);
  */
 void end_that_request_last(struct request *req)
 {
+	request_queue_t *q = req->q;
+	unsigned long now = jiffies;
 	struct gendisk *disk = req->rq_disk;
 
 	if (unlikely(laptop_mode) && blk_fs_request(req))
 		laptop_io_completion();
 
 	if (disk && blk_fs_request(req)) {
-		unsigned long duration = jiffies - req->start_time;
+		unsigned long duration = now - q->start_time;
+
 		switch (rq_data_dir(req)) {
 		    case WRITE:
 			__disk_stat_inc(disk, writes);
@@ -3215,6 +3211,8 @@ void end_that_request_last(struct reques
 		disk_round_stats(disk);
 		disk->in_flight--;
 	}
+	q->start_time = now;
+
 	if (req->end_io)
 		req->end_io(req);
 	else

--------------090501030004090207050200
Content-Type: text/x-csrc;
 name="blkstat.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blkstat.c"

#include <sys/types.h>
#include <sys/time.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <time.h>

#define PATH_MAX	4096

int main(int argc, char *argv[])
{
	unsigned int iter;
	unsigned long o_read_ms, o_write_ms, o_time_ms;
	char path[PATH_MAX];
	int fd;

	if (argc != 2) {
		printf("Usage: %s <bdev>\n", argv[0]);
		exit(0);
	}

	if (!snprintf(path, PATH_MAX, "/sys/block/%s/stat", argv[1]))
		fprintf(stderr, "Could not build path\n"), exit(1);

	iter = 0;
	for (;;) {
		unsigned long d_read_ms, d_write_ms, d_time_ms;
		unsigned long read_ms, write_ms, time_ms;
		
		struct timeval tv;
		int ret;
		char *token;
		char mem[1024];

		fd = open(path, O_RDONLY);
		if (fd == -1)
			perror("open"), exit(1);

		if (gettimeofday(&tv, NULL) == -1)
			perror("gettimeofday"), exit(1);
		
		time_ms = tv.tv_sec * 1000 + tv.tv_usec / 1000;
		d_time_ms = time_ms - o_time_ms;
		
		do {
			ret = read(fd, mem, 1024);
		} while (ret == -1 && errno == EINTR);
		if (ret == -1)
			perror("read"), exit(1);
		if (close(fd) == -1)
			perror("close"), exit(1);

		strtok(mem, " ");
		strtok(NULL, " ");
		strtok(NULL, " ");
		token = strtok(NULL, " ");
		if (!token)
			fprintf(stderr, "strtok failed\n"), exit(1);
		errno = 0;
		read_ms = strtoul(token, NULL, 10);
		if (errno == ERANGE)
			fprintf(stderr, "strtoul failed\n"), exit(1);

		strtok(NULL, " ");
		strtok(NULL, " ");
		strtok(NULL, " ");
		token = strtok(NULL, " ");
		if (!token)
			fprintf(stderr, "strtok failed\n"), exit(1);
		errno = 0;
		write_ms = strtoul(token, NULL, 10);
		if (errno == ERANGE)
			fprintf(stderr, "strtoul failed\n"), exit(1);
	
		d_read_ms = read_ms - o_read_ms;
		d_write_ms = write_ms - o_write_ms;
		if (d_read_ms + d_write_ms > d_time_ms)
			d_time_ms = d_read_ms + d_write_ms;

		if (iter % 20 == 0)
			printf("bdev\t  bi %%\t  bo %%\t  io %%\t  id %%\n");

		if (iter && d_time_ms) {
			printf("%s\t%6.1f\t%6.1f\t%6.1f\t%6.1f\n",
			argv[1],
			100.0f * d_read_ms / d_time_ms,
			100.0f * d_write_ms / d_time_ms,
			100.0f * (d_read_ms + d_write_ms) / d_time_ms,
			100.0f - 100.0f * (d_read_ms | d_write_ms) / d_time_ms);
		}

		o_read_ms = read_ms;
		o_write_ms = write_ms;
		o_time_ms = time_ms;

		sleep(1);
		iter++;
	}
	
	return 0;
}

--------------090501030004090207050200--
Send instant messages to your online friends http://au.messenger.yahoo.com 
