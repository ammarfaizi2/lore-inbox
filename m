Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287860AbSAFNA0>; Sun, 6 Jan 2002 08:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287862AbSAFNAR>; Sun, 6 Jan 2002 08:00:17 -0500
Received: from mail1.home.nl ([213.51.129.225]:62899 "EHLO mail1.home.nl")
	by vger.kernel.org with ESMTP id <S287860AbSAFNAF>;
	Sun, 6 Jan 2002 08:00:05 -0500
Message-ID: <3C384A97.8090909@home.nl>
Date: Sun, 06 Jan 2002 14:01:11 +0100
From: Gertjan van Wingerde <gwingerde@home.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020101
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: drivers/md compile fixes.
Content-Type: multipart/mixed;
 boundary="------------000500070304080704080108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000500070304080704080108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

The attached patch to 2.5.2-pre9 is necessary to get it to compile and
to clean up some NODEV vs. mk_kdev(0, 0) usages.

-- 
	Best regards/MvG,

		Gertjan

----------

Gertjan van Wingerde
Geessinkweg 177
7544 TX Enschede
The Netherlands
E-mail: gwingerde@home.nl

--------------000500070304080704080108
Content-Type: text/plain;
 name="linux-md.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-md.diff"

diff -u --recursive linux-2.5.2-pre8/drivers/md/md.c linux-2.5.x/drivers/md/md.c
--- linux-2.5.2-pre8/drivers/md/md.c	Sun Jan  6 11:28:53 2002
+++ linux-2.5.x/drivers/md/md.c	Sun Jan  6 11:30:03 2002
@@ -641,7 +641,7 @@
 	int err = 0;
 	struct block_device *bdev;
 
-	bdev = bdget(rdev->dev);
+	bdev = bdget(kdev_t_to_nr(rdev->dev));
 	if (!bdev)
 		return -ENOMEM;
 	err = blkdev_get(bdev, FMODE_READ|FMODE_WRITE, 0, BDEV_RAW);
@@ -1132,7 +1132,7 @@
 						rdev->sb->this_disk.minor);
 			rdev->desc_nr = rdev->sb->this_disk.number;
 		} else {
-			rdev->old_dev = NODEV;
+			rdev->old_dev = mk_kdev(0, 0);
 			rdev->desc_nr = -1;
 		}
 	}
diff -u --recursive linux-2.5.2-pre8/drivers/md/raid1.c linux-2.5.x/drivers/md/raid1.c
--- linux-2.5.2-pre8/drivers/md/raid1.c	Sun Jan  6 11:28:53 2002
+++ linux-2.5.x/drivers/md/raid1.c	Fri Jan  4 21:53:52 2002
@@ -853,7 +853,7 @@
 
 		*d = failed_desc;
 
-		if (kdev_none(sdisk->dev))
+		if (kdev_same(sdisk->dev, mk_kdev(0,0)))
 			sdisk->used_slot = 0;
 		/*
 		 * this really activates the spare.
@@ -879,7 +879,7 @@
 			err = 1;
 			goto abort;
 		}
-		rdisk->dev = NODEV;
+		rdisk->dev = mk_kdev(0,0);
 		rdisk->used_slot = 0;
 		conf->nr_disks--;
 		break;
@@ -1428,7 +1428,7 @@
 
 			disk->number = descriptor->number;
 			disk->raid_disk = disk_idx;
-			disk->dev = NODEV;
+			disk->dev = mk_kdev(0,0);
 
 			disk->operational = 0;
 			disk->write_only = 0;

--------------000500070304080704080108--

