Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131983AbRDEFOK>; Thu, 5 Apr 2001 01:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131985AbRDEFOA>; Thu, 5 Apr 2001 01:14:00 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:65031 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131983AbRDEFN4>;
	Thu, 5 Apr 2001 01:13:56 -0400
Date: Thu, 5 Apr 2001 07:13:13 +0200
From: Jens Axboe <axboe@suse.de>
To: Herbert Valerio Riedel <hvr@hvrlab.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/loop0 over lvm... leading to d-state :-(
Message-ID: <20010405071313.A418@suse.de>
In-Reply-To: <Pine.LNX.4.30.0104042152490.1183-100000@janus.txd.hvrlab.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0104042152490.1183-100000@janus.txd.hvrlab.org>; from hvr@hvrlab.org on Wed, Apr 04, 2001 at 10:00:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 04 2001, Herbert Valerio Riedel wrote:
> 
> fyi, loop devices over lvm LV's dont work for me...
> 
> I've tested with 2.4.3final (and some other 2.4.3 derivates) and two
> lvm'ized partitions with a size of about 1gig each; mke2fs
> just goes into D-state and stays there when applying it to /dev/loop0,
> running it directly on the LV-device works...

this would appear to be an lvm bug, could you try this patch? it's
untested, let me know if it doesn't work and I'll try and reproduce
here.

-- 
Jens Axboe


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lvm-rdev-1

--- /opt/kernel/linux-2.4.3/drivers/md/lvm.c	Mon Jan 29 01:11:20 2001
+++ drivers/md/lvm.c	Thu Apr  5 07:12:14 2001
@@ -1480,14 +1480,14 @@
  */
 static int lvm_map(struct buffer_head *bh, int rw)
 {
-	int minor = MINOR(bh->b_dev);
+	int minor = MINOR(bh->b_rdev);
 	int ret = 0;
 	ulong index;
 	ulong pe_start;
 	ulong size = bh->b_size >> 9;
 	ulong rsector_tmp = bh->b_blocknr * size;
 	ulong rsector_sav;
-	kdev_t rdev_tmp = bh->b_dev;
+	kdev_t rdev_tmp = bh->b_rdev;
 	kdev_t rdev_sav;
 	vg_t *vg_this = vg[VG_BLK(minor)];
 	lv_t *lv = vg_this->lv[LV_BLK(minor)];

--qMm9M+Fa2AknHoGS--
