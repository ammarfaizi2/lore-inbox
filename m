Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286161AbSBRVDm>; Mon, 18 Feb 2002 16:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286263AbSBRVD0>; Mon, 18 Feb 2002 16:03:26 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:30637 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S286161AbSBRVDI>; Mon, 18 Feb 2002 16:03:08 -0500
Subject: [PATCH] Encountered a Null Pointer Problem on the SCSI Layer
To: Jens Axboe <axboe@suse.de>, marcelo@conectiva.com.br
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFC7A42817.7DD2C3FB-ON85256B64.00725D00@raleigh.ibm.com>
From: "Peter Wong" <wpeter@us.ibm.com>
Date: Mon, 18 Feb 2002 15:03:05 -0600
X-MIMETrack: Serialize by Router on D04NM203/04/M/IBM(Release 5.0.9 |November 16, 2001) at
 02/18/2002 04:03:06 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A while ago, I reported that I encountered a null pointer problem
on the SCSI layer when I was testing Mingming Cao's diskio patch
"diskio-stat-rq-2414" on 2.4.14.

Mingming's patch is at http://sourceforge.net/projects/lse/.

The code in sd_find_queue() that protects against accessing a
non-existent device is not correct. After my patch was sent out,
Pete Zaitcev of Red Hat identified a similar problem in
sd_init_command of the same file.

     Let's consider sd_find_queue().

     If the array pointed by rscsi_disk has been allocated,
dpnt cannot be null.

     If rscsi_disk has NOT been allocated, dpnt = &rscsi_disks[target]
may NOT be null, and it depends on the value of target. Thus,
"if (!dpnt)" is not sufficient anyway.

     You can also look at sd_attach(), in which "if (!dpnt->device)" is
tested, not "if (!dpnt)".

     Please check.

The following patch is based on the 2.4.18-pre7 code:
---------------------------------------------------------------------------
--- linux/drivers/scsi/sd.c   Mon Feb 18 13:36:42 2002
+++ linux-2.4.17-diskio/drivers/scsi/sd.c Mon Feb 18 13:29:34 2002
@@ -279,7 +279,7 @@
      target = DEVICE_NR(dev);

      dpnt = &rscsi_disks[target];
-     if (!dpnt)
+     if (!dpnt->device)
            return NULL;      /* No such device */
      return &dpnt->device->request_queue;
 }
@@ -302,7 +302,7 @@

      dpnt = &rscsi_disks[dev];
      if (devm >= (sd_template.dev_max << 4) ||
-         !dpnt ||
+         !dpnt->device ||
          !dpnt->device->online ||
          block + SCpnt->request.nr_sectors > sd[devm].nr_sects) {
            SCSI_LOG_HLQUEUE(2, printk("Finishing %ld sectors\n", SCpnt->request.nr_sectors));
---------------------------------------------------------------------------

Regards,
Peter

Wai Yee Peter Wong
IBM Linux Technology Center, Performance Analysis
email: wpeter@us.ibm.com

