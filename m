Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261370AbSKRC7D>; Sun, 17 Nov 2002 21:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261339AbSKRC7D>; Sun, 17 Nov 2002 21:59:03 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:22758 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261290AbSKRC7A>; Sun, 17 Nov 2002 21:59:00 -0500
Date: Sun, 17 Nov 2002 22:06:39 -0500
From: Doug Ledford <dledford@redhat.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Scsi Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: Failure to reread partition tables on non-busy devices
Message-ID: <20021118030639.GD4608@redhat.com>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Scsi Mailing List <linux-scsi@vger.kernel.org>
References: <20021118000505.GM3280@redhat.com> <Pine.GSO.4.21.0211171939580.23400-100000@steklov.math.psu.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0211171939580.23400-100000@steklov.math.psu.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 17, 2002 at 07:43:27PM -0500, Alexander Viro wrote:
> Not really.  Correct fix is:
> 	a) in fs/block_dev.c::full_check_disk_change() replace
> 
> 	if (check_disk_change(bdev)) {
> with
> 	if (check_disk_change(bdev) && bdev->bd_invalidated) {
> 
> 	b) lost the check in rescan_partitions().
> 
> Other callers either do that check themselves or don't want that check to
> happen at all (BLKRRPART).

Well, since you didn't attach the patch, here it is.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="part.patch"

===== fs/block_dev.c 1.112 vs edited =====
--- 1.112/fs/block_dev.c	Sun Nov 17 08:09:16 2002
+++ edited/fs/block_dev.c	Sun Nov 17 22:00:23 2002
@@ -520,7 +520,7 @@
 	if (bdev->bd_contains != bdev)
 		BUG();
 	down(&bdev->bd_sem);
-	if (check_disk_change(bdev)) {
+	if (check_disk_change(bdev) && bdev->bd_invalidated) {
 		rescan_partitions(bdev->bd_disk, bdev);
 		res = 1;
 	}
===== fs/partitions/check.c 1.85 vs edited =====
--- 1.85/fs/partitions/check.c	Mon Nov 11 22:16:11 2002
+++ edited/fs/partitions/check.c	Sun Nov 17 21:59:28 2002
@@ -453,8 +453,6 @@
 	struct parsed_partitions *state;
 	int p, res;
 
-	if (!bdev->bd_invalidated)
-		return 0;
 	if (bdev->bd_part_count)
 		return -EBUSY;
 	res = invalidate_device(dev, 1);

--CE+1k2dSO48ffgeK--
