Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281138AbRK3WsS>; Fri, 30 Nov 2001 17:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281142AbRK3WsI>; Fri, 30 Nov 2001 17:48:08 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:19437 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S281090AbRK3WsC>; Fri, 30 Nov 2001 17:48:02 -0500
Date: Fri, 30 Nov 2001 17:48:00 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: marcelo@conectiva.co.br
Cc: linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>
Subject: Patch to sd.c in 2.4.16
Message-ID: <20011130174800.B22181@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marcelo (and the list):

Here's a patch that fixes kfree of static data in sd.c
(and bizzare ooses), also a modest cleanup. Please consider.
It's a fallout of one guy attaching 150 disks.

-- Pete

--- linux-2.4.16/drivers/scsi/sd.c	Fri Nov  9 14:05:06 2001
+++ linux-2.4.16-niph/drivers/scsi/sd.c	Thu Nov 29 19:25:22 2001
@@ -1157,8 +1157,6 @@
                         SCSI_DISKS_PER_MAJOR * sizeof *sd_gendisks[i].flags);
 		sd_gendisks[i].major = SD_MAJOR(i);
 		sd_gendisks[i].major_name = "sd";
-		sd_gendisks[i].minor_shift = 4;
-		sd_gendisks[i].max_p = 1 << 4;
 		sd_gendisks[i].part = sd + (i * SCSI_DISKS_PER_MAJOR << 4);
 		sd_gendisks[i].sizes = sd_sizes + (i * SCSI_DISKS_PER_MAJOR << 4);
 		sd_gendisks[i].nr_real = 0;
@@ -1175,7 +1173,8 @@
 		kfree(sd_gendisks[i].de_arr);
 		kfree(sd_gendisks[i].flags);
 	}
-	kfree(sd_gendisks);
+	if (sd_gendisks != &sd_gendisk)
+		kfree(sd_gendisks);
 cleanup_sd_gendisks:
 	kfree(sd);
 cleanup_sd:
@@ -1305,8 +1304,8 @@
 	}
 	DEVICE_BUSY = 1;
 
-	max_p = sd_gendisks->max_p;
-	start = target << sd_gendisks->minor_shift;
+	max_p = sd_gendisk.max_p;
+	start = target << sd_gendisk.minor_shift;
 
 	for (i = max_p - 1; i >= 0; i--) {
 		int index = start + i;
@@ -1365,7 +1364,6 @@
 			}
                         devfs_register_partitions (&SD_GENDISK (i),
                                                    SD_MINOR_NUMBER (start), 1);
-			/* unregister_disk() */
 			dpnt->has_part_table = 0;
 			dpnt->device = NULL;
 			dpnt->capacity = 0;
