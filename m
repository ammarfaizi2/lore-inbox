Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276034AbRI1NPs>; Fri, 28 Sep 2001 09:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276045AbRI1NPi>; Fri, 28 Sep 2001 09:15:38 -0400
Received: from [192.25.22.11] ([192.25.22.11]:1643 "EHLO
	bmdipc2c.germany.agilent.com") by vger.kernel.org with ESMTP
	id <S276034AbRI1NP0>; Fri, 28 Sep 2001 09:15:26 -0400
Message-Id: <200109281315.f8SDFpA01669@bmdipc2c.germany.agilent.com>
Content-Type: text/plain; charset=US-ASCII
From: Joachim Weller <joachim_weller@hsgmed.com>
To: linux-kernel@vger.kernel.org
Subject: BUG: cat /proc/partitions endless loop
Date: Fri, 28 Sep 2001 15:15:51 +0200
X-Mailer: KMail [version 1.3.1]
Organization: Philips Medical Systems Boeblingen GmbH 
Cc: JoachimWeller@web.de
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After upgrading from 2.4.9 to 2.4.10, I discovered that
a "cat /proc/partitions" resulted in an infinite  repetition
of the partition list.
This resulted in a complete hang of SuSE's sys admin tool yast.
A more detailed report was sent to Jens Axboe (axboe@suse.de)

The affected machine is a dual pentium pro:
 Linux version 2.4.10 (root@bmdipc2c) (gcc version 2.95.3 20010315 (SuSE)) #1 
SMP Fri Sep 28 13:10:18 CEST 2001

 I traced the problem down to drivers/block/genhd.c, 
where the function get_partition_list() outer loop does not 
terminate due to the last element in the structured list starting 
with gendisk_head is not initialized to NULL, by whatever reason.
My fix does not cure the pointered endless loop, but prevents
from looping when stepping thru the pointered list.
--------------------------------------------------------------------------------------
diff -u --recursive --new-file 2.4.10/linux/drivers/block/genhd.c 
linux/drivers/block/genhd.c
--- 2.4.10/linux/drivers/block/genhd.c  Sun Sep  9 21:00:55 2001
+++ linux/drivers/block/genhd.c Fri Sep 28 14:45:13 2001
@@ -14,6 +14,15 @@
  * TODO:  rip out the remaining init crap from this file  --hch
  */

+/*
+ * Change: Blocked potential endless loop within get_partition_list()
+ *         which occured for "cat /proc/partitions"
+ *         because gendisk_head->next is not initialized correctly to NULL
+ *         before add_gendisk() is called the first time.
+ *         Joachim Weller 28sep2001 (JoachimWeller@web.de)
+ *
+ */
+
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/fs.h>
@@ -115,7 +124,7 @@

        len = sprintf(page, "major minor  #blocks  name\n\n");
        read_lock(&gendisk_lock);
-       for (gp = gendisk_head; gp; gp = gp->next) {
+       for (gp = gendisk_head; gp; gp = (gp->next!=gendisk_head ?  gp->next 
: NULL)) {
                for (n = 0; n < (gp->nr_real << gp->minor_shift); n++) {
                        if (gp->part[n].nr_sects == 0)
                                continue;

--------------------------------------------------------------------------------------

-- 
Joachim Weller

Philips Medizinsysteme Boeblingen GmbH		Mail:  joachim_weller@hsgmed.com
Cardiac and Monitoring Systems (CMS)		Phone: {+49|0}-7031-463-1891
New Product Engineering				Fax:   {+49|0}-7031-463-2112

Hewlett-Packard Str. 2,	D 71034 Boeblingen	-GERMANY-

