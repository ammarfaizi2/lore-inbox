Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131596AbRATSvE>; Sat, 20 Jan 2001 13:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131539AbRATSup>; Sat, 20 Jan 2001 13:50:45 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:51463 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131461AbRATSul>;
	Sat, 20 Jan 2001 13:50:41 -0500
Date: Sat, 20 Jan 2001 19:50:27 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: andersg@0x63.nu, linux-kernel@vger.kernel.org
Subject: Re: lvm-oops in 2.4.1pre8
Message-ID: <20010120195027.Q30779@suse.de>
In-Reply-To: <20010120184106.A355@h55p111.delphi.afb.lu.se> <20010120192553.K8717@athlon.random>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mSxgbZZZvrAyzONB"
Content-Disposition: inline
In-Reply-To: <20010120192553.K8717@athlon.random>; from andrea@suse.de on Sat, Jan 20, 2001 at 07:25:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 20 2001, Andrea Arcangeli wrote:
> On Sat, Jan 20, 2001 at 06:41:06PM +0100, andersg@0x63.nu wrote:
> > hi,
> > 
> > got this oops when doing a 
> > vgextend -v vgroot /dev/ide/host2/bus0/target0/lun0/part2 \
> > /dev/ide/host2/bus1/target0/lun0/part2
> 
> You should upgrade to 0.9.1_beta2 that should merge all the known fixes out
> there. It's planned for inclusion into 2.4.1.

If you are doing updates, could you include this patch too? All it does
is waste memory.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs

--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lvm-request_fn-1

--- /kt/linux-2.4.1-pre9/drivers/md/lvm.c	Fri Dec 29 23:07:22 2000
+++ drivers/md/lvm.c	Sat Jan 20 19:50:59 2001
@@ -208,9 +208,6 @@
 extern int lvm_init(void);
 #endif
 
-static void lvm_dummy_device_request(request_queue_t *);
-#define	DEVICE_REQUEST	lvm_dummy_device_request
-
 static int lvm_make_request_fn(request_queue_t*, int, struct buffer_head*);
 
 static int lvm_blk_ioctl(struct inode *, struct file *, uint, ulong);
@@ -464,7 +461,6 @@
 	lvm_hd_name_ptr = lvm_hd_name;
 #endif
 
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
 	blk_queue_make_request(BLK_DEFAULT_QUEUE(MAJOR_NR), lvm_make_request_fn);
 
 	/* optional read root VGDA */
@@ -504,7 +500,6 @@
 	if (unregister_blkdev(MAJOR_NR, lvm_name) < 0) {
 		printk(KERN_ERR "%s -- unregister_blkdev failed\n", lvm_name);
 	}
-	blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
 
 	gendisk_ptr = gendisk_ptr_prev = gendisk_head;
 	while (gendisk_ptr != NULL) {
@@ -1730,21 +1725,6 @@
 	return;
 }
 #endif
-
-
-/*
- * this one never should be called...
- */
-static void lvm_dummy_device_request(request_queue_t * t)
-{
-	printk(KERN_EMERG
-	     "%s -- oops, got lvm request for %02d:%02d [sector: %lu]\n",
-	       lvm_name,
-	       MAJOR(CURRENT->rq_dev),
-	       MINOR(CURRENT->rq_dev),
-	       CURRENT->sector);
-	return;
-}
 
 
 /*

--mSxgbZZZvrAyzONB--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
