Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313319AbSDLCW1>; Thu, 11 Apr 2002 22:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313322AbSDLCW0>; Thu, 11 Apr 2002 22:22:26 -0400
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:46272 "EHLO
	swan.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S313319AbSDLCWX>; Thu, 11 Apr 2002 22:22:23 -0400
Subject: Re: sard/iostat disk I/O statistics/accounting for 2.5.8-pre3
From: Don Dupuis <ddupuissprint@earthlink.net>
To: zlatko.calusic@iskon.hr
Cc: linux-kernel@vger.kernel.org, "Stephen C. Tweedie" <sct@redhat.com>,
        Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <dnu1qia3zg.fsf@magla.zg.iskon.hr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 11 Apr 2002 21:23:20 -0500
Message-Id: <1018578201.4395.22.camel@linux-ath.linux.dev.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a program called cspm at http://sourceforge.net/projects/cspm
that uses Stephen's sard patches.  This program allows showing stats on
all disks, controllers, and on a systemwide basis.  It will show ios,
uses, merges, and blocks per second.  This program was written in QT.
Please have a look at it and provide some feedback.

Thanks.

Don Dupuis

On Thu, 2002-04-11 at 06:06, Zlatko Calusic wrote:
> Hi!
> 
> I have ported Stephen's excellent sard I/O accounting patch to
> 2.5.8-pre3. Additionaly, I have adapted/cleaned up iostat utility
> (originally written by Greg Franks) and created a man page for it.
> 
> All this gives Linux a much needed functionality - extensive
> measurements and reporting of disk device performance/bottlenecks.
> No server should be without it. See below for a real life story.
> 
> The patch, iostat utility and man page can be found at
> 
>  <URL:http://linux.inet.hr/>
> 
> Also, find the patch appended to this mail, for quicker browsing.
> 
> 
> Some observations:
> -----------------
> 
> The patch is quite well tested and stable (that is, it shouldn't eat
> your machine :)). Both on UP & SMP configurations, but I have tested
> it only on IDE hardware. Please test it on your configuration
> (especially SCSI) and report results.
> 
> I had to make some changes, as kernel internals have changed since the
> time patch was originally written. Alan has also included this patch
> in his 2.4.x-ac kernel series, but it is not working well.
> 
> First problem is that somehow, misteriously, ios_in_flight variable
> drops to value of -1 when disks are idle. Of course, this skews lots
> of other numbers and iostat reports garbage. I tried to find the cause
> of this behaviour, but failed (looks like we have a request fired on
> each disk, whose start is never accounted but completion is?!). So I
> resolved it this way
> 
> if (hd->ios_in_flight)
>                --hd->ios_in_flight;
> 
> which works well, but I would still love to know how number of I/Os
> can drop below zero. :)
> 
> Second problem/nuisance is that blk_partition_remap() destroys
> partition information from the bio->bi_dev before the request is
> queued. That's why -ac kernel doesn't report per-partition
> information. To resolve that, I had to put additional code in
> locate_hd_struct() to extract partition information back again which
> is kind of ugly (first we destroy it, then we recreate it again). The
> other way we could solve this is to put something like bio->bi_acctdev
> in bio structure and keep original device there, but that is not only
> a duplication of info (which is also ugly), but would also waste
> precious memory. I don't know if block re-mapping which is happening
> in the abovementioned function is strictly necessary. Jens, could you
> help with that one and/or give a suggestion which way to go with that
> one?
> 
> 
> TODO:
> ----
> 
> Please check the patch on various hardware you're equipped with and
> report success/failure. Somebody should really go through the man page
> and correct grammar mistakes :), maybe make it more readable in
> places. By the time this patch is ready for inclusion in the Linus
> kernel, old disk statistics counters should be removed (as they are
> buggy, incomplete and obsolete).
> 
> This patch w/ iostat utility is probably a necessary ingredient to
> make quality measurement of the new IDE-TCQ code. Too bad I have a
> Maxtor drive on a Promise controller here (any hope of me running TCQ
> on that combination in the future?).
> 
> 
> Real life story:
> ---------------
> 
> So, I had this applications heavily inserting data in the Oracle
> database. And its performance mattered to me. As the disk rattled all
> the time inserts were going on, I decided I needed to spend some time
> reordering datafiles to achieve the peak performance (disk I/O was a
> performance bottleneck, obviously). But after an hour or two I got
> only few percents improvement. How could that happen?!
> 
> Well, it happened that the database and application were already tuned
> quite well, and the load on database was (correctly) CPU based. As I
> have an SMP machine, I forgot that 40% free CPU could be on that
> second processor, obviously unusable in the app in question. And disk
> rattling was normal, lots of fsyncs, some seeks...
> 
> So, when I finally managed to port this patch to 2.5.x (we are
> speaking of a home development database, 2.5.x kernels are OK for
> those, right?! :)) iostat showed only ~20% disk utilization!  That is,
> there was _NO_ heavy I/O contention and disks were _NOT_ a culprit.
> Live and learn.
> 
> If only I had known that before I wasted my time needlessly moving big
> datafiles around and fixing configuration... :(
> 
> 
> Regards,
> 
> Zlatko
> 
> 
> Index: 7.12/include/linux/blkdev.h
> --- 7.12/include/linux/blkdev.h Wed, 10 Apr 2002 09:50:17 +0200 zcalusic (linux25/n/b/1_blkdev.h 1.1.1.1.1.1.1.2.2.1 644)
> +++ 7.14/include/linux/blkdev.h Wed, 10 Apr 2002 10:02:44 +0200 zcalusic (linux25/n/b/1_blkdev.h 1.1.1.1.1.1.1.2.2.2 644)
> @@ -34,6 +34,7 @@
>  	int rq_status;	/* should split this into a few status bits */
>  	kdev_t rq_dev;
>  	int errors;
> +	unsigned long start_time;
>  	sector_t sector;
>  	unsigned long nr_sectors;
>  	unsigned long hard_sector;	/* the hard_* are block layer
> Index: 7.12/include/linux/genhd.h
> --- 7.12/include/linux/genhd.h Tue, 15 Jan 2002 22:59:02 +0100 zcalusic (linux25/o/b/18_genhd.h 1.1.1.1.1.1 644)
> +++ 7.14/include/linux/genhd.h Wed, 10 Apr 2002 10:02:44 +0200 zcalusic (linux25/o/b/18_genhd.h 1.1.1.1.1.1.2.1 644)
> @@ -61,6 +61,22 @@
>  	unsigned long start_sect;
>  	unsigned long nr_sects;
>  	devfs_handle_t de;              /* primary (master) devfs entry  */
> +
> +	/* Performance stats: */
> +	unsigned int ios_in_flight;
> +	unsigned int io_ticks;
> +	unsigned int last_idle_time;
> +	unsigned int last_queue_change;
> +	unsigned int aveq;
> +
> +	unsigned int rd_ios;
> +	unsigned int rd_merges;
> +	unsigned int rd_ticks;
> +	unsigned int rd_sectors;
> +	unsigned int wr_ios;
> +	unsigned int wr_merges;
> +	unsigned int wr_ticks;
> +	unsigned int wr_sectors;
>  	int number;                     /* stupid old code wastes space  */
>  };
>  
> @@ -238,6 +254,19 @@
>  #ifdef __KERNEL__
>  
>  char *disk_name (struct gendisk *hd, int minor, char *buf);
> +
> +/*
> + * disk_round_stats is used to round off the IO statistics for a disk
> + * for a complete clock tick.
> + */
> +void disk_round_stats(struct hd_struct *hd);
> +
> +/* 
> + * Account for the completion of an IO request (used by drivers which 
> + * bypass the normal end_request processing) 
> + */
> +struct request;
> +void req_finished_io(struct request *);
>  
>  extern void devfs_register_partitions (struct gendisk *dev, int minor,
>  				       int unregister);
> Index: 7.12/drivers/scsi/scsi_lib.c
> --- 7.12/drivers/scsi/scsi_lib.c Tue, 12 Feb 2002 09:26:34 +0100 zcalusic (linux25/j/c/26_scsi_lib.c 1.1.1.1.1.2 644)
> +++ 7.14/drivers/scsi/scsi_lib.c Wed, 10 Apr 2002 10:02:44 +0200 zcalusic (linux25/j/c/26_scsi_lib.c 1.1.1.1.1.2.1.1 644)
> @@ -382,6 +382,7 @@
>  	 */
>  	if (req->waiting)
>  		complete(req->waiting);
> +	req_finished_io(req);
>  
>  	add_blkdev_randomness(major(req->rq_dev));
>  
> Index: 7.12/drivers/block/genhd.c
> --- 7.12/drivers/block/genhd.c Wed, 10 Apr 2002 09:50:17 +0200 zcalusic (linux25/x/c/3_genhd.c 1.1.1.1.1.1.3.1 644)
> +++ 7.14/drivers/block/genhd.c Wed, 10 Apr 2002 10:02:44 +0200 zcalusic (linux25/x/c/3_genhd.c 1.1.1.1.1.1.3.2 644)
> @@ -168,6 +168,10 @@
>  	read_unlock(&gendisk_lock);
>  }
>  
> +
> +/* Normalise the disk performance stats to a notional timer tick of 1ms. */
> +#define MSEC(x) ((x) * 1000 / HZ)
> +
>  static int show_partition(struct seq_file *part, void *v)
>  {
>  	struct gendisk *sgp = v;
> @@ -175,19 +179,34 @@
>  	char buf[64];
>  
>  	if (sgp == gendisk_head)
> -		seq_puts(part, "major minor  #blocks  name\n\n");
> +		seq_puts(part, "major minor  #blocks  name "
> +			 "rio rmerge rsect ruse "
> +			 "wio wmerge wsect wuse "
> +			 "running use aveq\n\n");
>  
>  	/* show all non-0 size partitions of this disk */
>  	for (n = 0; n < (sgp->nr_real << sgp->minor_shift); n++) {
> -		if (sgp->part[n].nr_sects == 0)
> +		struct hd_struct *hd = &sgp->part[n];
> +
> +		if (!hd->nr_sects)
>  			continue;
> -		seq_printf(part, "%4d  %4d %10d %s\n",
> -			sgp->major, n, sgp->sizes[n],
> -			disk_name(sgp, n, buf));
> +		disk_round_stats(hd);
> +		seq_printf(part, "%4d  %4d %10d %s "
> +			   "%d %d %d %d %d %d %d %d %d %d %d\n",
> +			   sgp->major, n, sgp->sizes[n],
> +			   disk_name(sgp, n, buf),
> +			   hd->rd_ios, hd->rd_merges,
> +			   hd->rd_sectors, MSEC(hd->rd_ticks),
> +			   hd->wr_ios, hd->wr_merges,
> +			   hd->wr_sectors, MSEC(hd->wr_ticks),
> +			   hd->ios_in_flight, MSEC(hd->io_ticks),
> +			   MSEC(hd->aveq));
>  	}
>  
>  	return 0;
>  }
> +
> +#undef MSEC
>  
>  struct seq_operations partitions_op = {
>  	start:	part_start,
> Index: 7.12/drivers/block/ll_rw_blk.c
> --- 7.12/drivers/block/ll_rw_blk.c Wed, 10 Apr 2002 09:50:17 +0200 zcalusic (linux25/x/c/9_ll_rw_blk. 1.1.1.1.1.1.1.1.1.1.3.1.1.1 644)
> +++ 7.14/drivers/block/ll_rw_blk.c Wed, 10 Apr 2002 18:37:24 +0200 zcalusic (linux25/x/c/9_ll_rw_blk. 1.1.1.1.1.1.1.1.1.1.3.1.1.3 644)
> @@ -944,6 +944,136 @@
>  		printk(KERN_ERR "drive_stat_acct: cmd not R/W?\n");
>  }
>  
> +/* Return up to two hd_structs on which to do IO accounting for a given
> + * request.  On a partitioned device, we want to account both against
> + * the partition and against the whole disk.
> + */
> +static void locate_hd_struct(struct request *req, 
> +			     struct hd_struct **hd1,
> +			     struct hd_struct **hd2)
> +{
> +	int p, n_part;
> +	struct gendisk *gd;
> +	struct hd_struct *hd;
> +
> +	*hd1 = NULL;
> +	*hd2 = NULL;
> +
> +	gd = get_gendisk(req->rq_dev);
> +	if (gd && gd->part) {
> +		*hd1 = &gd->part[0];
> +
> +		/* Try to reconstruct the partition */
> +		n_part = 1 << gd->minor_shift;
> +		for (p = 1; p < n_part; p++) {
> +			hd = &gd->part[p];
> +			/* skip empty and extended partitions */
> +			if (hd->nr_sects < 3)
> +				continue;
> +			if (req->sector >= hd->start_sect
> +			    && req->sector < hd->start_sect + hd->nr_sects)
> +				break;
> +		}
> +		if (p < n_part)
> +			*hd2 = hd;
> +	}
> +}
> +
> +/* Round off the performance stats on an hd_struct.  The average IO
> + * queue length and utilisation statistics are maintained by observing
> + * the current state of the queue length and the amount of time it has
> + * been in this state for.  Normally, that accounting is done on IO
> + * completion, but that can result in more than a second's worth of IO
> + * being accounted for within any one second, leading to >100%
> + * utilisation.  To deal with that, we do a round-off before returning
> + * the results when reading /proc/partitions, accounting immediately for
> + * all queue usage up to the current jiffies and restarting the counters
> + * again.
> + */
> +void disk_round_stats(struct hd_struct *hd)
> +{
> +	unsigned long now = jiffies;
> +
> +	hd->aveq += hd->ios_in_flight * (now - hd->last_queue_change);
> +	hd->last_queue_change = now;
> +
> +	if (hd->ios_in_flight)
> +		hd->io_ticks += (now - hd->last_idle_time);
> +	hd->last_idle_time = now;
> +}
> +
> +static inline void down_ios(struct hd_struct *hd)
> +{
> +	disk_round_stats(hd);
> +	if (hd->ios_in_flight)
> +		--hd->ios_in_flight;
> +}
> +
> +static inline void up_ios(struct hd_struct *hd)
> +{
> +	disk_round_stats(hd);
> +	++hd->ios_in_flight;
> +}
> +
> +static void account_io_start(struct hd_struct *hd, struct request *req,
> +			     int merge, int sectors)
> +{
> +	switch (rq_data_dir(req)) {
> +	case READ:
> +		if (merge)
> +			hd->rd_merges++;
> +		hd->rd_sectors += sectors;
> +		break;
> +	case WRITE:
> +		if (merge)
> +			hd->wr_merges++;
> +		hd->wr_sectors += sectors;
> +		break;
> +	default:
> +	}
> +	if (!merge)
> +		up_ios(hd);
> +}
> +
> +static void account_io_end(struct hd_struct *hd, struct request *req)
> +{
> +	unsigned long duration = jiffies - req->start_time;
> +	switch (rq_data_dir(req)) {
> +	case READ:
> +		hd->rd_ticks += duration;
> +		hd->rd_ios++;
> +		break;
> +	case WRITE:
> +		hd->wr_ticks += duration;
> +		hd->wr_ios++;
> +		break;
> +	default:
> +	}
> +	down_ios(hd);
> +}
> +
> +void req_new_io(struct request *req, int merge, int sectors)
> +{
> +	struct hd_struct *hd1, *hd2;
> +
> +	locate_hd_struct(req, &hd1, &hd2);
> +	if (hd1)
> +		account_io_start(hd1, req, merge, sectors);
> +	if (hd2)
> +		account_io_start(hd2, req, merge, sectors);
> +}
> +
> +void req_finished_io(struct request *req)
> +{
> +	struct hd_struct *hd1, *hd2;
> +
> +	locate_hd_struct(req, &hd1, &hd2);
> +	if (hd1)
> +		account_io_end(hd1, req);
> +	if (hd2)
> +		account_io_end(hd2, req);
> +}
> +
>  /*
>   * add-request adds a request to the linked list.
>   * queue lock is held and interrupts disabled, as we muck with the
> @@ -1018,6 +1148,8 @@
>  	 * counts here.
>  	 */
>  	if (q->merge_requests_fn(q, req, next)) {
> +		struct hd_struct *hd1, *hd2;
> +
>  		elv_merge_requests(q, req, next);
>  
>  		blkdev_dequeue_request(next);
> @@ -1027,6 +1159,15 @@
>  
>  		req->nr_sectors = req->hard_nr_sectors += next->hard_nr_sectors;
>  
> +		/* One last thing: we have removed a request, so we now have
> +		 * one less expected IO to complete for accounting purposes.
> +		 */
> +		locate_hd_struct(req, &hd1, &hd2);
> +		if (hd1)
> +			down_ios(hd1);
> +		if (hd2)	
> +			down_ios(hd2);
> +
>  		blkdev_release_request(next);
>  	}
>  }
> @@ -1117,6 +1258,7 @@
>  			req->biotail = bio;
>  			req->nr_sectors = req->hard_nr_sectors += nr_sectors;
>  			drive_stat_acct(req, nr_sectors, 0);
> +			req_new_io(req, 1, nr_sectors);
>  			attempt_back_merge(q, req);
>  			goto out;
>  
> @@ -1142,6 +1284,7 @@
>  			req->sector = req->hard_sector = sector;
>  			req->nr_sectors = req->hard_nr_sectors += nr_sectors;
>  			drive_stat_acct(req, nr_sectors, 0);
> +			req_new_io(req, 1, nr_sectors);
>  			attempt_front_merge(q, req);
>  			goto out;
>  
> @@ -1210,6 +1353,8 @@
>  	req->waiting = NULL;
>  	req->bio = req->biotail = bio;
>  	req->rq_dev = bio->bi_dev;
> +	req->start_time = jiffies;
> +	req_new_io(req, 0, nr_sectors);
>  	add_request(q, req, insert_here);
>  out:
>  	if (freereq)
> @@ -1649,6 +1794,7 @@
>  {
>  	if (req->waiting)
>  		complete(req->waiting);
> +	req_finished_io(req);
>  
>  	blkdev_release_request(req);
>  }
> 
> -- 
> Zlatko
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


