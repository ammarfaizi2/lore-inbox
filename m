Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292628AbSBZBXX>; Mon, 25 Feb 2002 20:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292593AbSBZBXO>; Mon, 25 Feb 2002 20:23:14 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:54768 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S292605AbSBZBWz>; Mon, 25 Feb 2002 20:22:55 -0500
Date: Mon, 25 Feb 2002 20:22:55 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Patch for sd cleanup
Message-ID: <20020225202255.A3526@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo's 2.4.18 does not have this:

--- linux-2.4.18/drivers/scsi/sd.c	Mon Feb 25 11:38:04 2002
+++ linux-2.4.18-p3/drivers/scsi/sd.c	Mon Feb 25 17:09:59 2002
@@ -279,7 +279,7 @@
  	target = DEVICE_NR(dev);
 
 	dpnt = &rscsi_disks[target];
-	if (!dpnt)
+	if (!dpnt->device)
 		return NULL;	/* No such device */
 	return &dpnt->device->request_queue;
 }
@@ -302,7 +302,7 @@
 
 	dpnt = &rscsi_disks[dev];
 	if (devm >= (sd_template.dev_max << 4) ||
-	    !dpnt ||
+	    !dpnt->device ||
 	    !dpnt->device->online ||
  	    block + SCpnt->request.nr_sectors > sd[devm].nr_sects) {
 		SCSI_LOG_HLQUEUE(2, printk("Finishing %ld sectors\n", SCpnt->request.nr_sectors));

The subject was beaten to death on lists. The patch must go in.
BTW, 2.5 has the same defect.

Since we are on the topic of sd.c cleanup, here's one more for you.
I posted it before. Someone please try it out and let me know
if anything interesting happens (say, slab area corruption :)

--- linux-2.4.18/drivers/scsi/sd.c	Mon Feb 25 11:38:04 2002
+++ linux-2.4.18-p3/drivers/scsi/sd.c	Mon Feb 25 17:09:59 2002
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

-- Pete
