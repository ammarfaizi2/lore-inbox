Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264037AbTEWM1y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 08:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264039AbTEWM1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 08:27:54 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:32414 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264037AbTEWM1v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 08:27:51 -0400
Date: Fri, 23 May 2003 18:13:24 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, ivg2@cornell.edu,
       linux-kernel@vger.kernel.org, greg@kroah.com, tytso@us.ibm.com
Subject: Re: kernel BUG at include/linux/dcache.h:271!
Message-ID: <20030523124324.GA1661@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <200305211911.51467.ivg2@cornell.edu> <20030522115702.GA1150@in.ibm.com> <20030522151954.1230ef53.akpm@digeo.com> <20030523062508.GN812@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030523062508.GN812@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 23, 2003 at 08:25:08AM +0200, Jens Axboe wrote:
> On Thu, May 22 2003, Andrew Morton wrote:
> > Maneesh Soni <maneesh@in.ibm.com> wrote:
> > >
> > > ramdisk 
> > >  - should have separate queues on for each ramdisk
> > > 
> > > elevator 
> > >  - should not re-register already registered queue in elv_register_queue
> > > 
> > > sysfs 
> > >  - should handle kobject with multiple parent kobjects 
> > 
> > I can't think of anywhere else where we are likely to want to support
> > multiple devices from a single queue in this manner, so perhaps the best
> > solution is to remove the exceptional case: allocate a separate queue for
> > each ramdisk instance.
> > 
> > Jens, do you agree?
> 
> Completely and utterly agree :)
> 
> -- 
> Jens Axboe

Hi,

The following patch provides a separate queue for each ramdisk instance
and the BUG is not seen now.

Please check whether it is ok or not.

Thanks,
Maneesh

 drivers/block/rd.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff -puN drivers/block/rd.c~multiqueue_ramdisk drivers/block/rd.c
--- linux-2.5.69/drivers/block/rd.c~multiqueue_ramdisk	2003-05-23 16:04:38.000000000 +0530
+++ linux-2.5.69-maneesh/drivers/block/rd.c	2003-05-23 17:45:24.000000000 +0530
@@ -67,6 +67,7 @@
 
 static struct gendisk *rd_disks[NUM_RAMDISKS];
 static struct block_device *rd_bdev[NUM_RAMDISKS];/* Protected device data */
+static struct request_queue *rd_queue;
 
 /*
  * Parameters for the boot-loading of the RAM disk.  These are set by
@@ -308,12 +309,11 @@ static void __exit rd_cleanup (void)
 		del_gendisk(rd_disks[i]);
 		put_disk(rd_disks[i]);
 	}
-
+	kfree(rd_queue);
 	devfs_remove("rd");
 	unregister_blkdev(RAMDISK_MAJOR, "ramdisk" );
 }
 
-static struct request_queue rd_queue;
 /* This is the registration and initialization section of the RAM disk driver */
 static int __init rd_init (void)
 {
@@ -333,23 +333,28 @@ static int __init rd_init (void)
 			goto out;
 	}
 
+	rd_queue = kmalloc(NUM_RAMDISKS * sizeof(struct request_queue),
+			     GFP_KERNEL);
+	if (!rd_queue)
+		goto out;
+
 	if (register_blkdev(RAMDISK_MAJOR, "ramdisk")) {
 		err = -EIO;
-		goto out;
+		goto out_queue;
 	}
 
-	blk_queue_make_request(&rd_queue, &rd_make_request);
-
 	devfs_mk_dir("rd");
 
 	for (i = 0; i < NUM_RAMDISKS; i++) {
 		struct gendisk *disk = rd_disks[i];
 
+		blk_queue_make_request(&rd_queue[i], &rd_make_request);
+
 		/* rd_size is given in kB */
 		disk->major = RAMDISK_MAJOR;
 		disk->first_minor = i;
 		disk->fops = &rd_bd_op;
-		disk->queue = &rd_queue;
+		disk->queue = &rd_queue[i];
 		sprintf(disk->disk_name, "ram%d", i);
 		sprintf(disk->devfs_name, "rd/%d", i);
 		set_capacity(disk, rd_size * 2);
@@ -362,6 +367,8 @@ static int __init rd_init (void)
 	       NUM_RAMDISKS, rd_size, rd_blocksize);
 
 	return 0;
+out_queue:
+	kfree(rd_queue);
 out:
 	while (i--)
 		put_disk(rd_disks[i]);

_

 

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
