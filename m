Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280357AbRKNIVv>; Wed, 14 Nov 2001 03:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280351AbRKNIVo>; Wed, 14 Nov 2001 03:21:44 -0500
Received: from gate.mesa.nl ([194.151.5.70]:22796 "EHLO joshua.mesa.nl")
	by vger.kernel.org with ESMTP id <S280357AbRKNIV1>;
	Wed, 14 Nov 2001 03:21:27 -0500
Date: Wed, 14 Nov 2001 09:20:22 +0100
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: Mingming cao <cmm@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net
Subject: Re: [PATCH]Disk IO statistics for all disks (request queue)
Message-ID: <20011114092022.A23345@joshua.mesa.nl>
Reply-To: marcel@mesa.nl
In-Reply-To: <Pine.LNX.4.33.0111121401070.7555-100000@penguin.transmeta.com> <3BF1D45E.9ECE1A12@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BF1D45E.9ECE1A12@us.ibm.com>; from cmm@us.ibm.com on Tue, Nov 13, 2001 at 06:18:06PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

What is wrong with tha sar patches from Stephan Tweedie.
They also include data to caclculate disk responsetime, busy%
and queue lengths.
Would be nice to have this in the mainstream kernel.

-Marcel

On Tue, Nov 13, 2001 at 06:18:06PM -0800, Mingming cao wrote:
> Hi Linus, Alan, All,
> 
> Here is a try in the direction of moving disk statistics into the
> request queue.  The main idea is: For each request queue,there is a
> pointer to a statistics structure. The statistics structure is
> dynamically allocated in blk_init_queue() and freed in
> blk_cleanup_queue(). Disk statistics gathering is easier and faster now,
> since less lookup is needed. In this way we extend the disk io gathering
> ability, dynamically allocate statistics memory for registered device
> only, and faster disk statistics gathering in the kernel side.
> 
> However, by moving statistics into the request queue, it makes
> kstat_read_proc() hard (maybe slower?) to show those statistics.  It is
> not straightforward to find out all request queues since drivers could
> have their own request queues.  The method used in this patch is,for
> each major, calculates the max number of disks(by the
> gendisk.minor_shift), and loop around to call blk_get_queue() to lookup
> the request queue associated with every disk. Any suggestions on how to
> find out all request queues in kstat_read_proc()?   
> 
> The fact is, the value of max number of disks calculated through
> gendisk.minor_shift, may be greater than the actual max number disks
> defined in the driver. For example,  MAX_DRIVES defined in ide.h is 2,
> but ide could have up to 4 disks in theory.  ide_get_queue() returns 
> one of the first two request queues when the disk index is greater than
> MAX_DRIVES.  Thus, kstat_read_proc() will print the the statistics for
> ide disk2 and disk3, since to kstat_read_proc(), there are request
> queues associated with those disks(even if those disks are not exist). 
> I don't know whether changing the ide_get_queue() (ide_get_queue()
> returns NULL if disk index is out of range) is a right way to fix this. 
> Could break anything?  Also,  any other drivers have similar issues?
> 
> One more thing I am not sure is, for the device which has multiple disks
> but only use one default request queue, there is no way to differentiate
> the statistics between disks;  Also, gathering statistics at the
> partition level seems impossible, although I am not sure how important
> it is.
> 
> 
> Attached patch is against 2.4.14.  Thanks in advance for your inputs and
> comments.
> 
> 
> -- 
> Mingming Cao
> IBM Linux Technology Center
> 503-578-5024  IBM T/L: 775-5024
> cmm@us.ibm.com
> http://www.ibm.com/linux/ltc
> diff -urN -X dontdiff linux-2.4.14/drivers/block/ll_rw_blk.c linux-test/drivers/block/ll_rw_blk.c
> --- linux-2.4.14/drivers/block/ll_rw_blk.c	Mon Oct 29 12:11:17 2001
> +++ linux-test/drivers/block/ll_rw_blk.c	Tue Nov 13 12:18:20 2001
> @@ -183,7 +183,12 @@
>  
>  	if (count)
>  		printk("blk_cleanup_queue: leaked requests (%d)\n", count);
> -
> +	/*
> +	 * free statistics structure
> +	 */
> +	if (q->dk_stat)
> +		kfree(q->dk_stat);
> +	
>  	memset(q, 0, sizeof(*q));
>  }
>  
> @@ -393,6 +398,8 @@
>   **/
>  void blk_init_queue(request_queue_t * q, request_fn_proc * rfn)
>  {
> +	disk_stat * new;	
> +
>  	INIT_LIST_HEAD(&q->queue_head);
>  	elevator_init(&q->elevator, ELEVATOR_LINUS);
>  	blk_init_free_list(q);
> @@ -413,6 +420,15 @@
>  	 */
>  	q->plug_device_fn 	= generic_plug_device;
>  	q->head_active    	= 1;
> +	/* 
> +	 * At last, allocate and initialize the statistics 
> +	 */
> +	new = (disk_stat * )kmalloc(sizeof(disk_stat), GFP_KERNEL);
> +	if (new == NULL) {
> +		printk(KERN_ERR "blk_init_queue:error allocating statisitcs\n");
> +	}
> +	memset(new, 0, sizeof(disk_stat));
> +	q->dk_stat = new;
>  }
>  
>  #define blkdev_free_rq(list) list_entry((list)->next, struct request, queue);
> @@ -497,23 +513,18 @@
>  	else ro_bits[major][minor >> 5] &= ~(1 << (minor & 31));
>  }
>  
> -inline void drive_stat_acct (kdev_t dev, int rw,
> +inline void drive_stat_acct (disk_stat * ds, int rw,
>  				unsigned long nr_sectors, int new_io)
>  {
> -	unsigned int major = MAJOR(dev);
> -	unsigned int index;
> -
> -	index = disk_index(dev);
> -	if ((index >= DK_MAX_DISK) || (major >= DK_MAX_MAJOR))
> +	if (ds == NULL)
>  		return;
>  
> -	kstat.dk_drive[major][index] += new_io;
>  	if (rw == READ) {
> -		kstat.dk_drive_rio[major][index] += new_io;
> -		kstat.dk_drive_rblk[major][index] += nr_sectors;
> +		ds->dk_drive_rio += new_io;
> +		ds->dk_drive_rblk += nr_sectors;
>  	} else if (rw == WRITE) {
> -		kstat.dk_drive_wio[major][index] += new_io;
> -		kstat.dk_drive_wblk[major][index] += nr_sectors;
> +		ds->dk_drive_wio += new_io;
> +		ds->dk_drive_wblk += nr_sectors;
>  	} else
>  		printk(KERN_ERR "drive_stat_acct: cmd not R/W?\n");
>  }
> @@ -529,7 +540,7 @@
>  static inline void add_request(request_queue_t * q, struct request * req,
>  			       struct list_head *insert_here)
>  {
> -	drive_stat_acct(req->rq_dev, req->cmd, req->nr_sectors, 1);
> +	drive_stat_acct(q->dk_stat, req->cmd, req->nr_sectors, 1);
>  
>  	if (!q->plugged && q->head_active && insert_here == &q->queue_head) {
>  		spin_unlock_irq(&io_request_lock);
> @@ -701,7 +712,7 @@
>  			req->bhtail = bh;
>  			req->nr_sectors = req->hard_nr_sectors += count;
>  			blk_started_io(count);
> -			drive_stat_acct(req->rq_dev, req->cmd, count, 0);
> +			drive_stat_acct(q->dk_stat, req->cmd, count, 0);
>  			attempt_back_merge(q, req, max_sectors, max_segments);
>  			goto out;
>  
> @@ -716,7 +727,7 @@
>  			req->sector = req->hard_sector = sector;
>  			req->nr_sectors = req->hard_nr_sectors += count;
>  			blk_started_io(count);
> -			drive_stat_acct(req->rq_dev, req->cmd, count, 0);
> +			drive_stat_acct(q->dk_stat, req->cmd, count, 0);
>  			attempt_front_merge(q, head, req, max_sectors, max_segments);
>  			goto out;
>  
> diff -urN -X dontdiff linux-2.4.14/drivers/ide/ide.c linux-test/drivers/ide/ide.c
> --- linux-2.4.14/drivers/ide/ide.c	Thu Oct 25 13:58:35 2001
> +++ linux-test/drivers/ide/ide.c	Tue Nov 13 17:47:42 2001
> @@ -1451,8 +1451,10 @@
>  request_queue_t *ide_get_queue (kdev_t dev)
>  {
>  	ide_hwif_t *hwif = (ide_hwif_t *)blk_dev[MAJOR(dev)].data;
> -
> -	return &hwif->drives[DEVICE_NR(dev) & 1].queue;
> +	if (DEVICE_NR(dev) >= MAX_DRIVES)
> +		 return NULL;
> +	else 
> +		return &hwif->drives[DEVICE_NR(dev)].queue;
>  }
>  
>  /*
> diff -urN -X dontdiff linux-2.4.14/drivers/md/md.c linux-test/drivers/md/md.c
> --- linux-2.4.14/drivers/md/md.c	Thu Oct 25 13:58:34 2001
> +++ linux-test/drivers/md/md.c	Tue Nov 13 17:49:31 2001
> @@ -3302,12 +3302,15 @@
>  	ITERATE_RDEV(mddev,rdev,tmp) {
>  		int major = MAJOR(rdev->dev);
>  		int idx = disk_index(rdev->dev);
> -
> +		request_queue_t * rq = blk_get_queue(rdev->dev);
> +		
>  		if ((idx >= DK_MAX_DISK) || (major >= DK_MAX_MAJOR))
>  			continue;
> -
> -		curr_events = kstat.dk_drive_rblk[major][idx] +
> -						kstat.dk_drive_wblk[major][idx] ;
> +		
> +		if (rq == NULL || (rq->dk_stat == NULL))
> +			continue;
> +		curr_events = rq->dk_stat->dk_drive_rblk + 
> +			rq->dk_stat->dk_drive_wblk ;
>  		curr_events -= sync_io[major][idx];
>  		if ((curr_events - rdev->last_events) > 32) {
>  			rdev->last_events = curr_events;
> diff -urN -X dontdiff linux-2.4.14/fs/proc/proc_misc.c linux-test/fs/proc/proc_misc.c
> --- linux-2.4.14/fs/proc/proc_misc.c	Thu Oct 11 10:46:57 2001
> +++ linux-test/fs/proc/proc_misc.c	Tue Nov 13 16:11:33 2001
> @@ -35,12 +35,12 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/smp_lock.h>
> +#include <linux/blkdev.h>
>  
>  #include <asm/uaccess.h>
>  #include <asm/pgtable.h>
>  #include <asm/io.h>
>  
> -
>  #define LOAD_INT(x) ((x) >> FSHIFT)
>  #define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
>  /*
> @@ -259,7 +259,23 @@
>  	return len;
>  }
>  #endif
> -
> +static inline int show_disk_stat(char * page, int len, disk_stat * ds,
> +					int major, int disk)
> +{
> +	int active = ds->dk_drive_rio + ds->dk_drive_wio +
> +		 ds->dk_drive_rblk + ds->dk_drive_wblk;
> +	if (active)
> +		len += sprintf(page + len,
> +			"(%u,%u):(%u,%u,%u,%u,%u) ",
> +			major, disk,
> +			ds->dk_drive_rio + ds->dk_drive_wio,
> +			ds->dk_drive_rio,
> +			ds->dk_drive_rblk,
> +			ds->dk_drive_wio,
> +			ds->dk_drive_wblk
> +		);
> +	return len;
> +}
>  static int kstat_read_proc(char *page, char **start, off_t off,
>  				 int count, int *eof, void *data)
>  {
> @@ -309,21 +325,27 @@
>  
>  	len += sprintf(page + len, "\ndisk_io: ");
>  
> -	for (major = 0; major < DK_MAX_MAJOR; major++) {
> -		for (disk = 0; disk < DK_MAX_DISK; disk++) {
> -			int active = kstat.dk_drive[major][disk] +
> -				kstat.dk_drive_rblk[major][disk] +
> -				kstat.dk_drive_wblk[major][disk];
> -			if (active)
> -				len += sprintf(page + len,
> -					"(%u,%u):(%u,%u,%u,%u,%u) ",
> -					major, disk,
> -					kstat.dk_drive[major][disk],
> -					kstat.dk_drive_rio[major][disk],
> -					kstat.dk_drive_rblk[major][disk],
> -					kstat.dk_drive_wio[major][disk],
> -					kstat.dk_drive_wblk[major][disk]
> -			);
> +	for (major = 0; major < MAX_BLKDEV; major++) {
> +		disk_stat * ds;
> +
> +		if (!(blk_dev[major].queue)){
> +			ds = (BLK_DEFAULT_QUEUE(major))->dk_stat;
> +			if (ds)
> +				len = show_disk_stat(page, len, ds, major, 0);
> +		}else {
> +			request_queue_t * q;
> +			struct gendisk * hd = get_gendisk(MKDEV(major,0));
> +			int max_disk = MINORMASK>>hd->minor_shift;
> +
> +			for (disk = 0; disk <= max_disk; disk++) {
> +				q = blk_get_queue(MKDEV(major,disk<<hd->minor_shift));
> +				if (!q)
> +					continue;
> +				ds = q->dk_stat;
> +				if (!ds)
> +					continue;
> +				len = show_disk_stat(page, len, ds, major,disk);
> +			}
>  		}
>  	}
>  
> diff -urN -X dontdiff linux-2.4.14/include/linux/blkdev.h linux-test/include/linux/blkdev.h
> --- linux-2.4.14/include/linux/blkdev.h	Mon Nov  5 12:42:57 2001
> +++ linux-test/include/linux/blkdev.h	Tue Nov 13 11:42:47 2001
> @@ -71,6 +71,13 @@
>  	struct list_head free;
>  };
>  
> +typedef struct disk_stat{
> +	unsigned int dk_drive_rio;
> +	unsigned int dk_drive_wio;
> +	unsigned int dk_drive_rblk;
> +	unsigned int dk_drive_wblk;
> +} disk_stat;
> +
>  struct request_queue
>  {
>  	/*
> @@ -122,6 +129,10 @@
>  	 * Tasks wait here for free request
>  	 */
>  	wait_queue_head_t	wait_for_request;
> +	/*
> +	 * statistics
> +	 */
> +	disk_stat * dk_stat;
>  };
>  
>  struct blk_dev_struct {
> @@ -190,7 +201,7 @@
>  #define blkdev_next_request(req) blkdev_entry_to_request((req)->queue.next)
>  #define blkdev_prev_request(req) blkdev_entry_to_request((req)->queue.prev)
>  
> -extern void drive_stat_acct (kdev_t dev, int rw,
> +extern void drive_stat_acct (disk_stat *, int rw,
>  					unsigned long nr_sectors, int new_io);
>  
>  static inline int get_hardsect_size(kdev_t dev)
> diff -urN -X dontdiff linux-2.4.14/include/linux/kernel_stat.h linux-test/include/linux/kernel_stat.h
> --- linux-2.4.14/include/linux/kernel_stat.h	Mon Nov  5 12:42:14 2001
> +++ linux-test/include/linux/kernel_stat.h	Tue Nov 13 18:09:44 2001
> @@ -19,11 +19,6 @@
>  	unsigned int per_cpu_user[NR_CPUS],
>  	             per_cpu_nice[NR_CPUS],
>  	             per_cpu_system[NR_CPUS];
> -	unsigned int dk_drive[DK_MAX_MAJOR][DK_MAX_DISK];
> -	unsigned int dk_drive_rio[DK_MAX_MAJOR][DK_MAX_DISK];
> -	unsigned int dk_drive_wio[DK_MAX_MAJOR][DK_MAX_DISK];
> -	unsigned int dk_drive_rblk[DK_MAX_MAJOR][DK_MAX_DISK];
> -	unsigned int dk_drive_wblk[DK_MAX_MAJOR][DK_MAX_DISK];
>  	unsigned int pgpgin, pgpgout;
>  	unsigned int pswpin, pswpout;
>  #if !defined(CONFIG_ARCH_S390)
> 


-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,           Linux user 1148  --  counter.li.org
    so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com
