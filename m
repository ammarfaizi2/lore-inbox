Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132911AbRDEOu7>; Thu, 5 Apr 2001 10:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132917AbRDEOut>; Thu, 5 Apr 2001 10:50:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:9996 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S132911AbRDEOub>;
	Thu, 5 Apr 2001 10:50:31 -0400
Date: Thu, 5 Apr 2001 16:49:42 +0200
From: Jens Axboe <axboe@suse.de>
To: Herbert Valerio Riedel <hvr@hvrlab.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        linux-lvm-patch@ez-darmstadt.telekom.de
Subject: Re: /dev/loop0 over lvm... leading to d-state :-(
Message-ID: <20010405164942.N418@suse.de>
In-Reply-To: <Pine.LNX.4.30.0104042152490.1183-100000@janus.txd.hvrlab.org> <20010405071313.A418@suse.de> <20010405163818.M418@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dkEUBIird37B8yKS"
Content-Disposition: inline
In-Reply-To: <20010405163818.M418@suse.de>; from axboe@suse.de on Thu, Apr 05, 2001 at 04:38:18PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 05 2001, Jens Axboe wrote:
> To the LVM folks: you can't use b_dev or b_blocknr inside your
> make_request_fn, it destroys stacking drivers such as loop. And
> is just plain wrong in the general case too.

Irks, another one. lvm_make_request_fn also needs to call b_end_io
if a map fails. Updated patch attached, I'll collate further
patches if I find more :-)

-- 
Jens Axboe


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lvm-stack-2

--- /opt/kernel/linux-2.4.3/drivers/md/lvm.c	Mon Jan 29 01:11:20 2001
+++ drivers/md/lvm.c	Thu Apr  5 16:48:52 2001
@@ -148,6 +148,9 @@
  *                 procfs is always supported now. (JT)
  *    12/01/2001 - avoided flushing logical volume in case of shrinking
  *                 because of unecessary overhead in case of heavy updates
+ *    05/04/2001 - lvm_map bugs: don't use b_blocknr/b_dev in lvm_map, it
+ *		   destroys stacking devices. call b_end_io on failed maps.
+ *		   (Jens Axboe)
  *
  */
 
@@ -1480,14 +1483,14 @@
  */
 static int lvm_map(struct buffer_head *bh, int rw)
 {
-	int minor = MINOR(bh->b_dev);
+	int minor = MINOR(bh->b_rdev);
 	int ret = 0;
 	ulong index;
 	ulong pe_start;
 	ulong size = bh->b_size >> 9;
-	ulong rsector_tmp = bh->b_blocknr * size;
+	ulong rsector_tmp = bh->b_rsector;
 	ulong rsector_sav;
-	kdev_t rdev_tmp = bh->b_dev;
+	kdev_t rdev_tmp = bh->b_rdev;
 	kdev_t rdev_sav;
 	vg_t *vg_this = vg[VG_BLK(minor)];
 	lv_t *lv = vg_this->lv[LV_BLK(minor)];
@@ -1676,8 +1679,12 @@
  */
 static int lvm_make_request_fn(request_queue_t *q,
 			       int rw,
-			       struct buffer_head *bh) {
-	return (lvm_map(bh, rw) < 0) ? 0 : 1;
+			       struct buffer_head *bh)
+{
+	int ret = lvm_map(bh, rw);
+	if (ret)
+		bh->b_end_io(bh, test_bit(BH_Uptodate, &bh->b_state));
+	return ret;
 }
 
 

--dkEUBIird37B8yKS--
