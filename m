Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbUFWWJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUFWWJS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 18:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUFWWIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 18:08:51 -0400
Received: from siaag2ac.compuserve.com ([149.174.40.133]:58077 "EHLO
	siaag2ac.compuserve.com") by vger.kernel.org with ESMTP
	id S261951AbUFWWGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 18:06:32 -0400
Date: Wed, 23 Jun 2004 18:00:45 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [PATCH] Fragmented SCSI disk messages in 2.6.7
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200406231803_MC3-1-854F-EC5D@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Without this patch I get the following on bootup with media
inserted in a USB powered Zip 250:


sda: Spinning up disk....<6>EXT3 FS on hde3, internal journal
Adding 524152k swap on /dev/hdg2.  Priority:-1 extents:1
Adding 524152k swap on /dev/hde2.  Priority:-2 extents:1
.<6>kjournald starting.  Commit interval 5 seconds
((  --- Snip 17 lines of EXT3 mount messages --- ))
..<3>microcode: error! Bad data in microcode data file
microcode: Error in the microcode data
.....ready


Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 267.0/drivers/scsi/sd.c     2004-06-21 16:09:58.099832360 -0400
+++ 267.1/drivers/scsi/sd.c     2004-06-21 16:25:12.464827752 -0400
@@ -889,7 +889,7 @@ sd_spinup_disk(struct scsi_disk *sdkp, c
                } else if (SRpnt->sr_sense_buffer[2] == NOT_READY) {
                        unsigned long time1;
                        if (!spintime) {
-                               printk(KERN_NOTICE "%s: Spinning up disk...",
+                               printk(KERN_NOTICE "%s: Spinning up disk...\n",
                                       diskname);
                                cmd[0] = START_STOP;
                                cmd[1] = 1;     /* Return immediately */
@@ -912,7 +912,6 @@ sd_spinup_disk(struct scsi_disk *sdkp, c
                                current->state = TASK_UNINTERRUPTIBLE;
                                time1 = schedule_timeout(time1);
                        } while(time1);
-                       printk(".");
                } else {
                        /* we don't understand the sense code, so it's
                         * probably pointless to loop */
@@ -928,9 +927,9 @@ sd_spinup_disk(struct scsi_disk *sdkp, c
 
        if (spintime) {
                if (scsi_status_is_good(the_result))
-                       printk("ready\n");
+                       printk(KERN_NOTICE "%s: Disk ready\n", diskname);
                else
-                       printk("not responding...\n");
+                       printk(KERN_NOTICE "%s: Disk not responding...\n", diskname);
        }
 }
 

