Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289174AbSAVFtW>; Tue, 22 Jan 2002 00:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289171AbSAVFtM>; Tue, 22 Jan 2002 00:49:12 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:53246 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S289173AbSAVFs5>; Tue, 22 Jan 2002 00:48:57 -0500
Date: Tue, 22 Jan 2002 00:48:57 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, zaitcev@redhat.com
Subject: Two small things around sd_init() in 2.4.18-pre4
Message-ID: <20020122004857.B21332@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys & gals:

Recenly, Marcelo took my bugfix for ->init() failure recovery.
When I worked on it, I noticed two small unrelated thinkos which
I'd like someone to verify.

1. It seems that sd_gendisks[i].de_arr and sd_gendisks[i].flags
are never freed, thus rmmod leaks.

2. The sd.c sets blksize_size and clears blk_size, which looks
dubious.

Are these two bugs or not?

Cheers,
-- Pete

--- linux-2.4.18-pre4/drivers/scsi/sd.c.0	Mon Jan 21 21:22:25 2002
+++ linux-2.4.18-pre4/drivers/scsi/sd.c	Mon Jan 21 21:22:43 2002
@@ -1412,10 +1412,14 @@
 		kfree(sd_blocksizes);
 		kfree(sd_hardsizes);
 		kfree((char *) sd);
+		for (i = 0; i < N_USED_SD_MAJORS; i++) {
+			kfree(sd_gendisks[i].de_arr);
+			kfree(sd_gendisks[i].flags);
+		}
 	}
 	for (i = 0; i < N_USED_SD_MAJORS; i++) {
 		del_gendisk(&sd_gendisks[i]);
-		blk_size[SD_MAJOR(i)] = NULL;
+		blksize_size[SD_MAJOR(i)] = NULL;
 		hardsect_size[SD_MAJOR(i)] = NULL;
 		read_ahead[SD_MAJOR(i)] = 0;
 	}
