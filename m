Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314433AbSE0W4c>; Mon, 27 May 2002 18:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314468AbSE0W4c>; Mon, 27 May 2002 18:56:32 -0400
Received: from host194.steeleye.com ([216.33.1.194]:17157 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S314433AbSE0W4b>; Mon, 27 May 2002 18:56:31 -0400
Message-Id: <200205272256.g4RMuRH03974@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: [PATCH] initrd fails again in 2.5.18
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_18786864270"
Date: Mon, 27 May 2002 18:56:27 -0400
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_18786864270
Content-Type: text/plain; charset=us-ascii

The initial ramdisk fails to work with a slew of errors like:

generic_make_request: Trying to access nonexistent block-device 01:00 (2)

The problem was caused by change

kdev_t -> bdev cleanups [2/2]

which took out the ability of bdev_get_queue() to create a queue if one didn't 
already exist for the device.  The functionality was moved to 
block_dev.c:do_open() where it exists within the if(!bdev->bd_openers) which 
the ramdisk never gets to.

The (tested) fix, I think, is to set bd_queue as part of ramdisk 
initialisation, which is what the attached patch does.

James Bottomley


--==_Exmh_18786864270
Content-Type: text/plain ; name="rd-2.5.18.diff"; charset=us-ascii
Content-Description: rd-2.5.18.diff
Content-Disposition: attachment; filename="rd-2.5.18.diff"

===== drivers/block/rd.c 1.38 vs edited =====
--- 1.38/drivers/block/rd.c	Thu May 23 08:18:38 2002
+++ edited/drivers/block/rd.c	Mon May 27 17:11:40 2002
@@ -379,6 +379,7 @@
 		rd_bdev[unit]->bd_openers++;
 		rd_bdev[unit]->bd_block_size = rd_blocksize;
 		rd_bdev[unit]->bd_inode->i_mapping->a_ops = &ramdisk_aops;
+		rd_bdev[unit]->bd_queue = BLK_DEFAULT_QUEUE(MAJOR_NR);
 	}
 
 	return 0;

--==_Exmh_18786864270--


