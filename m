Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161132AbWJDJcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161132AbWJDJcz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 05:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161187AbWJDJcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 05:32:55 -0400
Received: from havoc.gtf.org ([69.61.125.42]:57734 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1161132AbWJDJcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 05:32:54 -0400
Date: Wed, 4 Oct 2006 05:32:54 -0400
From: Jeff Garzik <jeff@garzik.org>
To: linux-scsi@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] SCSI sd: fix module init/exit error handling
Message-ID: <20061004093254.GA15585@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- Properly handle and unwind errors in init_sd().  Fixes leaks on error,
  if class_register() or scsi_register_driver() failed.

- Ensure that exit_sd() execution order is the perfect inverse of
  initialization order.

FIXME:  If some-but-not-all register_blkdev() calls fail, we wind up
calling unregister_blkdev() for block devices we did not register.
This was a pre-existing bug.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/scsi/sd.c |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 10bc99c..d9a118e 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1794,7 +1794,7 @@ static void sd_shutdown(struct device *d
  **/
 static int __init init_sd(void)
 {
-	int majors = 0, i;
+	int majors = 0, i, err;
 
 	SCSI_LOG_HLQUEUE(3, printk("init_sd: sd driver entry point\n"));
 
@@ -1805,9 +1805,22 @@ static int __init init_sd(void)
 	if (!majors)
 		return -ENODEV;
 
-	class_register(&sd_disk_class);
+	err = class_register(&sd_disk_class);
+	if (err) 
+		goto err_out;
 
-	return scsi_register_driver(&sd_template.gendrv);
+	err = scsi_register_driver(&sd_template.gendrv);
+	if (err)
+		goto err_out_class;
+	
+	return 0;
+
+err_out_class:
+	class_unregister(&sd_disk_class);
+err_out:
+	for (i = 0; i < SD_MAJORS; i++)
+		unregister_blkdev(sd_major(i), "sd");
+	return err;
 }
 
 /**
@@ -1822,10 +1835,10 @@ static void __exit exit_sd(void)
 	SCSI_LOG_HLQUEUE(3, printk("exit_sd: exiting sd driver\n"));
 
 	scsi_unregister_driver(&sd_template.gendrv);
+	class_unregister(&sd_disk_class);
+
 	for (i = 0; i < SD_MAJORS; i++)
 		unregister_blkdev(sd_major(i), "sd");
-
-	class_unregister(&sd_disk_class);
 }
 
 module_init(init_sd);
