Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132912AbRDEOlj>; Thu, 5 Apr 2001 10:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132913AbRDEOlT>; Thu, 5 Apr 2001 10:41:19 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:1548 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S132908AbRDEOjI>;
	Thu, 5 Apr 2001 10:39:08 -0400
Date: Thu, 5 Apr 2001 16:38:18 +0200
From: Jens Axboe <axboe@suse.de>
To: Herbert Valerio Riedel <hvr@hvrlab.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        linux-lvm-patch@ez-darmstadt.telekom.de
Subject: Re: /dev/loop0 over lvm... leading to d-state :-(
Message-ID: <20010405163818.M418@suse.de>
In-Reply-To: <Pine.LNX.4.30.0104042152490.1183-100000@janus.txd.hvrlab.org> <20010405071313.A418@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline
In-Reply-To: <20010405071313.A418@suse.de>; from axboe@suse.de on Thu, Apr 05, 2001 at 07:13:13AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 05 2001, Jens Axboe wrote:
> On Wed, Apr 04 2001, Herbert Valerio Riedel wrote:
> > 
> > fyi, loop devices over lvm LV's dont work for me...
> > 
> > I've tested with 2.4.3final (and some other 2.4.3 derivates) and two
> > lvm'ized partitions with a size of about 1gig each; mke2fs
> > just goes into D-state and stays there when applying it to /dev/loop0,
> > running it directly on the LV-device works...
> 
> this would appear to be an lvm bug, could you try this patch? it's
> untested, let me know if it doesn't work and I'll try and reproduce
> here.

What do you know, there was one more in there. Even visible in
the original hunk :-). And this time it wasn't a loop bug (the
crowd goes bezerk).

To the LVM folks: you can't use b_dev or b_blocknr inside your
make_request_fn, it destroys stacking drivers such as loop. And
is just plain wrong in the general case too.

-- 
Jens Axboe


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lvm-stack-1

--- /opt/kernel/linux-2.4.3/drivers/md/lvm.c	Mon Jan 29 01:11:20 2001
+++ drivers/md/lvm.c	Thu Apr  5 16:20:12 2001
@@ -148,6 +148,8 @@
  *                 procfs is always supported now. (JT)
  *    12/01/2001 - avoided flushing logical volume in case of shrinking
  *                 because of unecessary overhead in case of heavy updates
+ *    05/04/2001 - don't use b_blocknr/b_dev in lvm_map, it destroys
+ *		   stacking devices (Jens Axboe)
  *
  */
 
@@ -1480,14 +1482,14 @@
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

--FkmkrVfFsRoUs1wW--
