Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129242AbRCBP3J>; Fri, 2 Mar 2001 10:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129245AbRCBP2t>; Fri, 2 Mar 2001 10:28:49 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:46861 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129242AbRCBP2l>;
	Fri, 2 Mar 2001 10:28:41 -0500
Date: Fri, 2 Mar 2001 16:28:24 +0100
From: Jens Axboe <axboe@suse.de>
To: Mario Hermann <ario@eikon.tum.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: report bug: System reboots when accessing a loop-device over a second loop-device with 2.4.2-ac7
Message-ID: <20010302162824.H408@suse.de>
In-Reply-To: <3A9E66BB.70FB0C75@eikon.tum.de> <20010301172145.T21518@suse.de> <3A9FADAB.F37E5449@eikon.tum.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <3A9FADAB.F37E5449@eikon.tum.de>; from ario@eikon.tum.de on Fri, Mar 02, 2001 at 03:26:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 02 2001, Mario Hermann wrote:
> There is another small bug with the loop over loop problem. Now it works
> fine for
> files but not for Devices:
> 
> losetup /dev/loop0 /dev/sr1
> losetup /dev/loop1 /dev/loop0
> dd if=/dev/loop1 of=test.dat bs=2048 count=1024

Pending miscount, this should fix it.

-- 
Jens Axboe


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=loop-ac8-1

--- /opt/kernel/linux-2.4.2-ac8/drivers/block/loop.c	Fri Mar  2 14:48:24 2001
+++ drivers/block/loop.c	Fri Mar  2 16:27:31 2001
@@ -307,6 +307,7 @@
 		lo->lo_bh = lo->lo_bhtail = bh;
 	spin_unlock_irqrestore(&lo->lo_lock, flags);
 
+	atomic_inc(&lo->lo_pending);
 	up(&lo->lo_bh_mutex);
 }
 
@@ -404,7 +405,6 @@
 	spin_lock_irq(&lo->lo_lock);
 	if (lo->lo_state != Lo_bound)
 		goto inactive;
-	atomic_inc(&lo->lo_pending);
 	spin_unlock_irq(&lo->lo_lock);
 
 	if (rw == WRITE) {
@@ -452,8 +452,6 @@
 	return 0;
 
 err:
-	if (atomic_dec_and_test(&lo->lo_pending))
-		up(&lo->lo_bh_mutex);
 	loop_put_buffer(bh);
 out:
 	buffer_IO_error(rbh);

--YiEDa0DAkWCtVeE4--
