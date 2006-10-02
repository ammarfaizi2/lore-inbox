Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965108AbWJBU5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108AbWJBU5Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 16:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965109AbWJBU5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 16:57:25 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:21479 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S965108AbWJBU5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 16:57:23 -0400
To: balagi@justmail.de
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       akpm@osdl.org
Subject: Re: [PATCH 1/4] 2.6.18-mm2 pktcdvd: replace pktcdvd strings with macro DRIVER_NAME
References: <op.tgraqehniudtyh@master>
From: Peter Osterlund <petero2@telia.com>
Date: 02 Oct 2006 22:56:52 +0200
In-Reply-To: <op.tgraqehniudtyh@master>
Message-ID: <m3d59ah1wr.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Thomas Maier" <balagi@justmail.de> writes:

> this patch 1/4 for pktcdvd against Linux 2.6.18 (stable)
> or 2.6.18-mm2 replaces all "pktcdvd" strings against
> the DRIVER_NAME macro.

Thanks, looks good. Andrew, please apply this patch to the -mm tree:


From: Thomas Maier <balagi@justmail.de>

pktcdvd: Replace pktcdvd strings with macro DRIVER_NAME.

Signed-off-by: Thomas Maier <balagi@justmail.de>
Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 drivers/block/pktcdvd.c |  124 ++++++++++++++++++++++++-----------------------
 1 files changed, 63 insertions(+), 61 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index a6b2aa6..8a73a05 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -62,6 +62,8 @@ #include <scsi/scsi.h>
 
 #include <asm/uaccess.h>
 
+#define DRIVER_NAME	"pktcdvd"
+
 #if PACKET_DEBUG
 #define DPRINTK(fmt, args...) printk(KERN_NOTICE fmt, ##args)
 #else
@@ -89,7 +91,7 @@ static void pkt_bio_finished(struct pktc
 {
 	BUG_ON(atomic_read(&pd->cdrw.pending_bios) <= 0);
 	if (atomic_dec_and_test(&pd->cdrw.pending_bios)) {
-		VPRINTK("pktcdvd: queue empty\n");
+		VPRINTK(DRIVER_NAME": queue empty\n");
 		atomic_set(&pd->iosched.attention, 1);
 		wake_up(&pd->wqueue);
 	}
@@ -400,7 +402,7 @@ static void pkt_dump_sense(struct packet
 	int i;
 	struct request_sense *sense = cgc->sense;
 
-	printk("pktcdvd:");
+	printk(DRIVER_NAME":");
 	for (i = 0; i < CDROM_PACKET_SIZE; i++)
 		printk(" %02x", cgc->cmd[i]);
 	printk(" - ");
@@ -528,7 +530,7 @@ static void pkt_iosched_process_queue(st
 				need_write_seek = 0;
 			if (need_write_seek && reads_queued) {
 				if (atomic_read(&pd->cdrw.pending_bios) > 0) {
-					VPRINTK("pktcdvd: write, waiting\n");
+					VPRINTK(DRIVER_NAME": write, waiting\n");
 					break;
 				}
 				pkt_flush_cache(pd);
@@ -537,7 +539,7 @@ static void pkt_iosched_process_queue(st
 		} else {
 			if (!reads_queued && writes_queued) {
 				if (atomic_read(&pd->cdrw.pending_bios) > 0) {
-					VPRINTK("pktcdvd: read, waiting\n");
+					VPRINTK(DRIVER_NAME": read, waiting\n");
 					break;
 				}
 				pd->iosched.writing = 1;
@@ -600,7 +602,7 @@ static int pkt_set_segment_merging(struc
 		set_bit(PACKET_MERGE_SEGS, &pd->flags);
 		return 0;
 	} else {
-		printk("pktcdvd: cdrom max_phys_segments too small\n");
+		printk(DRIVER_NAME": cdrom max_phys_segments too small\n");
 		return -EIO;
 	}
 }
@@ -1049,7 +1051,7 @@ static void pkt_start_write(struct pktcd
 	for (f = 0; f < pkt->frames; f++)
 		if (!bio_add_page(pkt->w_bio, bvec[f].bv_page, CD_FRAMESIZE, bvec[f].bv_offset))
 			BUG();
-	VPRINTK("pktcdvd: vcnt=%d\n", pkt->w_bio->bi_vcnt);
+	VPRINTK(DRIVER_NAME": vcnt=%d\n", pkt->w_bio->bi_vcnt);
 
 	atomic_set(&pkt->io_wait, 1);
 	pkt->w_bio->bi_rw = WRITE;
@@ -1286,7 +1288,7 @@ work_to_do:
 
 static void pkt_print_settings(struct pktcdvd_device *pd)
 {
-	printk("pktcdvd: %s packets, ", pd->settings.fp ? "Fixed" : "Variable");
+	printk(DRIVER_NAME": %s packets, ", pd->settings.fp ? "Fixed" : "Variable");
 	printk("%u blocks, ", pd->settings.size >> 2);
 	printk("Mode-%c disc\n", pd->settings.block_mode == 8 ? '1' : '2');
 }
@@ -1471,7 +1473,7 @@ #endif
 		/*
 		 * paranoia
 		 */
-		printk("pktcdvd: write mode wrong %d\n", wp->data_block_type);
+		printk(DRIVER_NAME": write mode wrong %d\n", wp->data_block_type);
 		return 1;
 	}
 	wp->packet_size = cpu_to_be32(pd->settings.size >> 2);
@@ -1515,7 +1517,7 @@ static int pkt_writable_track(struct pkt
 	if (ti->rt == 1 && ti->blank == 0)
 		return 1;
 
-	printk("pktcdvd: bad state %d-%d-%d\n", ti->rt, ti->blank, ti->packet);
+	printk(DRIVER_NAME": bad state %d-%d-%d\n", ti->rt, ti->blank, ti->packet);
 	return 0;
 }
 
@@ -1533,7 +1535,7 @@ static int pkt_writable_disc(struct pktc
 		case 0x12: /* DVD-RAM */
 			return 1;
 		default:
-			VPRINTK("pktcdvd: Wrong disc profile (%x)\n", pd->mmc3_profile);
+			VPRINTK(DRIVER_NAME": Wrong disc profile (%x)\n", pd->mmc3_profile);
 			return 0;
 	}
 
@@ -1542,22 +1544,22 @@ static int pkt_writable_disc(struct pktc
 	 * but i'm not sure, should we leave this to user apps? probably.
 	 */
 	if (di->disc_type == 0xff) {
-		printk("pktcdvd: Unknown disc. No track?\n");
+		printk(DRIVER_NAME": Unknown disc. No track?\n");
 		return 0;
 	}
 
 	if (di->disc_type != 0x20 && di->disc_type != 0) {
-		printk("pktcdvd: Wrong disc type (%x)\n", di->disc_type);
+		printk(DRIVER_NAME": Wrong disc type (%x)\n", di->disc_type);
 		return 0;
 	}
 
 	if (di->erasable == 0) {
-		printk("pktcdvd: Disc not erasable\n");
+		printk(DRIVER_NAME": Disc not erasable\n");
 		return 0;
 	}
 
 	if (di->border_status == PACKET_SESSION_RESERVED) {
-		printk("pktcdvd: Can't write to last track (reserved)\n");
+		printk(DRIVER_NAME": Can't write to last track (reserved)\n");
 		return 0;
 	}
 
@@ -1593,12 +1595,12 @@ static int pkt_probe_settings(struct pkt
 
 	track = 1; /* (di.last_track_msb << 8) | di.last_track_lsb; */
 	if ((ret = pkt_get_track_info(pd, track, 1, &ti))) {
-		printk("pktcdvd: failed get_track\n");
+		printk(DRIVER_NAME": failed get_track\n");
 		return ret;
 	}
 
 	if (!pkt_writable_track(pd, &ti)) {
-		printk("pktcdvd: can't write to this track\n");
+		printk(DRIVER_NAME": can't write to this track\n");
 		return -EROFS;
 	}
 
@@ -1608,11 +1610,11 @@ static int pkt_probe_settings(struct pkt
 	 */
 	pd->settings.size = be32_to_cpu(ti.fixed_packet_size) << 2;
 	if (pd->settings.size == 0) {
-		printk("pktcdvd: detected zero packet size!\n");
+		printk(DRIVER_NAME": detected zero packet size!\n");
 		return -ENXIO;
 	}
 	if (pd->settings.size > PACKET_MAX_SECTORS) {
-		printk("pktcdvd: packet size is too big\n");
+		printk(DRIVER_NAME": packet size is too big\n");
 		return -EROFS;
 	}
 	pd->settings.fp = ti.fp;
@@ -1654,7 +1656,7 @@ static int pkt_probe_settings(struct pkt
 			pd->settings.block_mode = PACKET_BLOCK_MODE2;
 			break;
 		default:
-			printk("pktcdvd: unknown data mode\n");
+			printk(DRIVER_NAME": unknown data mode\n");
 			return -EROFS;
 	}
 	return 0;
@@ -1688,10 +1690,10 @@ static int pkt_write_caching(struct pktc
 	cgc.buflen = cgc.cmd[8] = 2 + ((buf[0] << 8) | (buf[1] & 0xff));
 	ret = pkt_mode_select(pd, &cgc);
 	if (ret) {
-		printk("pktcdvd: write caching control failed\n");
+		printk(DRIVER_NAME": write caching control failed\n");
 		pkt_dump_sense(&cgc);
 	} else if (!ret && set)
-		printk("pktcdvd: enabled write caching on %s\n", pd->name);
+		printk(DRIVER_NAME": enabled write caching on %s\n", pd->name);
 	return ret;
 }
 
@@ -1805,11 +1807,11 @@ static int pkt_media_speed(struct pktcdv
 	}
 
 	if (!buf[6] & 0x40) {
-		printk("pktcdvd: Disc type is not CD-RW\n");
+		printk(DRIVER_NAME": Disc type is not CD-RW\n");
 		return 1;
 	}
 	if (!buf[6] & 0x4) {
-		printk("pktcdvd: A1 values on media are not valid, maybe not CDRW?\n");
+		printk(DRIVER_NAME": A1 values on media are not valid, maybe not CDRW?\n");
 		return 1;
 	}
 
@@ -1829,14 +1831,14 @@ static int pkt_media_speed(struct pktcdv
 			*speed = us_clv_to_speed[sp];
 			break;
 		default:
-			printk("pktcdvd: Unknown disc sub-type %d\n",st);
+			printk(DRIVER_NAME": Unknown disc sub-type %d\n",st);
 			return 1;
 	}
 	if (*speed) {
-		printk("pktcdvd: Max. media speed: %d\n",*speed);
+		printk(DRIVER_NAME": Max. media speed: %d\n",*speed);
 		return 0;
 	} else {
-		printk("pktcdvd: Unknown speed %d for sub-type %d\n",sp,st);
+		printk(DRIVER_NAME": Unknown speed %d for sub-type %d\n",sp,st);
 		return 1;
 	}
 }
@@ -1847,7 +1849,7 @@ static int pkt_perform_opc(struct pktcdv
 	struct request_sense sense;
 	int ret;
 
-	VPRINTK("pktcdvd: Performing OPC\n");
+	VPRINTK(DRIVER_NAME": Performing OPC\n");
 
 	init_cdrom_command(&cgc, NULL, 0, CGC_DATA_NONE);
 	cgc.sense = &sense;
@@ -1865,12 +1867,12 @@ static int pkt_open_write(struct pktcdvd
 	unsigned int write_speed, media_write_speed, read_speed;
 
 	if ((ret = pkt_probe_settings(pd))) {
-		VPRINTK("pktcdvd: %s failed probe\n", pd->name);
+		VPRINTK(DRIVER_NAME": %s failed probe\n", pd->name);
 		return ret;
 	}
 
 	if ((ret = pkt_set_write_settings(pd))) {
-		DPRINTK("pktcdvd: %s failed saving write settings\n", pd->name);
+		DPRINTK(DRIVER_NAME": %s failed saving write settings\n", pd->name);
 		return -EIO;
 	}
 
@@ -1882,26 +1884,26 @@ static int pkt_open_write(struct pktcdvd
 		case 0x13: /* DVD-RW */
 		case 0x1a: /* DVD+RW */
 		case 0x12: /* DVD-RAM */
-			DPRINTK("pktcdvd: write speed %ukB/s\n", write_speed);
+			DPRINTK(DRIVER_NAME": write speed %ukB/s\n", write_speed);
 			break;
 		default:
 			if ((ret = pkt_media_speed(pd, &media_write_speed)))
 				media_write_speed = 16;
 			write_speed = min(write_speed, media_write_speed * 177);
-			DPRINTK("pktcdvd: write speed %ux\n", write_speed / 176);
+			DPRINTK(DRIVER_NAME": write speed %ux\n", write_speed / 176);
 			break;
 	}
 	read_speed = write_speed;
 
 	if ((ret = pkt_set_speed(pd, write_speed, read_speed))) {
-		DPRINTK("pktcdvd: %s couldn't set write speed\n", pd->name);
+		DPRINTK(DRIVER_NAME": %s couldn't set write speed\n", pd->name);
 		return -EIO;
 	}
 	pd->write_speed = write_speed;
 	pd->read_speed = read_speed;
 
 	if ((ret = pkt_perform_opc(pd))) {
-		DPRINTK("pktcdvd: %s Optimum Power Calibration failed\n", pd->name);
+		DPRINTK(DRIVER_NAME": %s Optimum Power Calibration failed\n", pd->name);
 	}
 
 	return 0;
@@ -1929,7 +1931,7 @@ static int pkt_open_dev(struct pktcdvd_d
 		goto out_putdev;
 
 	if ((ret = pkt_get_last_written(pd, &lba))) {
-		printk("pktcdvd: pkt_get_last_written failed\n");
+		printk(DRIVER_NAME": pkt_get_last_written failed\n");
 		goto out_unclaim;
 	}
 
@@ -1959,11 +1961,11 @@ static int pkt_open_dev(struct pktcdvd_d
 
 	if (write) {
 		if (!pkt_grow_pktlist(pd, CONFIG_CDROM_PKTCDVD_BUFFERS)) {
-			printk("pktcdvd: not enough memory for buffers\n");
+			printk(DRIVER_NAME": not enough memory for buffers\n");
 			ret = -ENOMEM;
 			goto out_unclaim;
 		}
-		printk("pktcdvd: %lukB available on disc\n", lba << 1);
+		printk(DRIVER_NAME": %lukB available on disc\n", lba << 1);
 	}
 
 	return 0;
@@ -1983,7 +1985,7 @@ out:
 static void pkt_release_dev(struct pktcdvd_device *pd, int flush)
 {
 	if (flush && pkt_flush_cache(pd))
-		DPRINTK("pktcdvd: %s not flushing cache\n", pd->name);
+		DPRINTK(DRIVER_NAME": %s not flushing cache\n", pd->name);
 
 	pkt_lock_door(pd, 0);
 
@@ -2006,7 +2008,7 @@ static int pkt_open(struct inode *inode,
 	struct pktcdvd_device *pd = NULL;
 	int ret;
 
-	VPRINTK("pktcdvd: entering open\n");
+	VPRINTK(DRIVER_NAME": entering open\n");
 
 	mutex_lock(&ctl_mutex);
 	pd = pkt_find_dev_from_minor(iminor(inode));
@@ -2040,7 +2042,7 @@ static int pkt_open(struct inode *inode,
 out_dec:
 	pd->refcnt--;
 out:
-	VPRINTK("pktcdvd: failed open (%d)\n", ret);
+	VPRINTK(DRIVER_NAME": failed open (%d)\n", ret);
 	mutex_unlock(&ctl_mutex);
 	return ret;
 }
@@ -2088,7 +2090,7 @@ static int pkt_make_request(request_queu
 
 	pd = q->queuedata;
 	if (!pd) {
-		printk("pktcdvd: %s incorrect request queue\n", bdevname(bio->bi_bdev, b));
+		printk(DRIVER_NAME": %s incorrect request queue\n", bdevname(bio->bi_bdev, b));
 		goto end_io;
 	}
 
@@ -2110,13 +2112,13 @@ static int pkt_make_request(request_queu
 	}
 
 	if (!test_bit(PACKET_WRITABLE, &pd->flags)) {
-		printk("pktcdvd: WRITE for ro device %s (%llu)\n",
+		printk(DRIVER_NAME": WRITE for ro device %s (%llu)\n",
 			pd->name, (unsigned long long)bio->bi_sector);
 		goto end_io;
 	}
 
 	if (!bio->bi_size || (bio->bi_size % CD_FRAMESIZE)) {
-		printk("pktcdvd: wrong bio size\n");
+		printk(DRIVER_NAME": wrong bio size\n");
 		goto end_io;
 	}
 
@@ -2319,7 +2321,7 @@ static int pkt_new_dev(struct pktcdvd_de
 	struct block_device *bdev;
 
 	if (pd->pkt_dev == dev) {
-		printk("pktcdvd: Recursive setup not allowed\n");
+		printk(DRIVER_NAME": Recursive setup not allowed\n");
 		return -EBUSY;
 	}
 	for (i = 0; i < MAX_WRITERS; i++) {
@@ -2327,11 +2329,11 @@ static int pkt_new_dev(struct pktcdvd_de
 		if (!pd2)
 			continue;
 		if (pd2->bdev->bd_dev == dev) {
-			printk("pktcdvd: %s already setup\n", bdevname(pd2->bdev, b));
+			printk(DRIVER_NAME": %s already setup\n", bdevname(pd2->bdev, b));
 			return -EBUSY;
 		}
 		if (pd2->pkt_dev == dev) {
-			printk("pktcdvd: Can't chain pktcdvd devices\n");
+			printk(DRIVER_NAME": Can't chain pktcdvd devices\n");
 			return -EBUSY;
 		}
 	}
@@ -2354,7 +2356,7 @@ static int pkt_new_dev(struct pktcdvd_de
 	atomic_set(&pd->cdrw.pending_bios, 0);
 	pd->cdrw.thread = kthread_run(kcdrwd, pd, "%s", pd->name);
 	if (IS_ERR(pd->cdrw.thread)) {
-		printk("pktcdvd: can't start kernel thread\n");
+		printk(DRIVER_NAME": can't start kernel thread\n");
 		ret = -ENOMEM;
 		goto out_mem;
 	}
@@ -2364,7 +2366,7 @@ static int pkt_new_dev(struct pktcdvd_de
 		proc->data = pd;
 		proc->proc_fops = &pkt_proc_fops;
 	}
-	DPRINTK("pktcdvd: writer %s mapped to %s\n", pd->name, bdevname(bdev, b));
+	DPRINTK(DRIVER_NAME": writer %s mapped to %s\n", pd->name, bdevname(bdev, b));
 	return 0;
 
 out_mem:
@@ -2401,7 +2403,7 @@ static int pkt_ioctl(struct inode *inode
 		return blkdev_ioctl(pd->bdev->bd_inode, file, cmd, arg);
 
 	default:
-		VPRINTK("pktcdvd: Unknown ioctl for %s (%x)\n", pd->name, cmd);
+		VPRINTK(DRIVER_NAME": Unknown ioctl for %s (%x)\n", pd->name, cmd);
 		return -ENOTTY;
 	}
 
@@ -2446,7 +2448,7 @@ static int pkt_setup_dev(struct pkt_ctrl
 		if (!pkt_devs[idx])
 			break;
 	if (idx == MAX_WRITERS) {
-		printk("pktcdvd: max %d writers supported\n", MAX_WRITERS);
+		printk(DRIVER_NAME": max %d writers supported\n", MAX_WRITERS);
 		return -EBUSY;
 	}
 
@@ -2470,7 +2472,7 @@ static int pkt_setup_dev(struct pkt_ctrl
 
 	spin_lock_init(&pd->lock);
 	spin_lock_init(&pd->iosched.lock);
-	sprintf(pd->name, "pktcdvd%d", idx);
+	sprintf(pd->name, DRIVER_NAME"%d", idx);
 	init_waitqueue_head(&pd->wqueue);
 	pd->bio_queue = RB_ROOT;
 
@@ -2478,7 +2480,7 @@ static int pkt_setup_dev(struct pkt_ctrl
 	disk->first_minor = idx;
 	disk->fops = &pktcdvd_ops;
 	disk->flags = GENHD_FL_REMOVABLE;
-	sprintf(disk->disk_name, "pktcdvd%d", idx);
+	sprintf(disk->disk_name, DRIVER_NAME"%d", idx);
 	disk->private_data = pd;
 	disk->queue = blk_alloc_queue(GFP_KERNEL);
 	if (!disk->queue)
@@ -2520,7 +2522,7 @@ static int pkt_remove_dev(struct pkt_ctr
 			break;
 	}
 	if (idx == MAX_WRITERS) {
-		DPRINTK("pktcdvd: dev not setup\n");
+		DPRINTK(DRIVER_NAME": dev not setup\n");
 		return -ENXIO;
 	}
 
@@ -2533,7 +2535,7 @@ static int pkt_remove_dev(struct pkt_ctr
 	blkdev_put(pd->bdev);
 
 	remove_proc_entry(pd->name, pkt_proc);
-	DPRINTK("pktcdvd: writer %s unmapped\n", pd->name);
+	DPRINTK(DRIVER_NAME": writer %s unmapped\n", pd->name);
 
 	del_gendisk(pd->disk);
 	blk_cleanup_queue(pd->disk->queue);
@@ -2610,7 +2612,7 @@ static struct file_operations pkt_ctl_fo
 
 static struct miscdevice pkt_misc = {
 	.minor 		= MISC_DYNAMIC_MINOR,
-	.name  		= "pktcdvd",
+	.name  		= DRIVER_NAME,
 	.fops  		= &pkt_ctl_fops
 };
 
@@ -2623,9 +2625,9 @@ static int __init pkt_init(void)
 	if (!psd_pool)
 		return -ENOMEM;
 
-	ret = register_blkdev(pkt_major, "pktcdvd");
+	ret = register_blkdev(pkt_major, DRIVER_NAME);
 	if (ret < 0) {
-		printk("pktcdvd: Unable to register block device\n");
+		printk(DRIVER_NAME": Unable to register block device\n");
 		goto out2;
 	}
 	if (!pkt_major)
@@ -2633,18 +2635,18 @@ static int __init pkt_init(void)
 
 	ret = misc_register(&pkt_misc);
 	if (ret) {
-		printk("pktcdvd: Unable to register misc device\n");
+		printk(DRIVER_NAME": Unable to register misc device\n");
 		goto out;
 	}
 
 	mutex_init(&ctl_mutex);
 
-	pkt_proc = proc_mkdir("pktcdvd", proc_root_driver);
+	pkt_proc = proc_mkdir(DRIVER_NAME, proc_root_driver);
 
 	return 0;
 
 out:
-	unregister_blkdev(pkt_major, "pktcdvd");
+	unregister_blkdev(pkt_major, DRIVER_NAME);
 out2:
 	mempool_destroy(psd_pool);
 	return ret;
@@ -2652,9 +2654,9 @@ out2:
 
 static void __exit pkt_exit(void)
 {
-	remove_proc_entry("pktcdvd", proc_root_driver);
+	remove_proc_entry(DRIVER_NAME, proc_root_driver);
 	misc_deregister(&pkt_misc);
-	unregister_blkdev(pkt_major, "pktcdvd");
+	unregister_blkdev(pkt_major, DRIVER_NAME);
 	mempool_destroy(psd_pool);
 }
 

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
