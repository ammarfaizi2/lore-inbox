Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751769AbWDCRXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbWDCRXq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 13:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbWDCRXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 13:23:45 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:58908 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751771AbWDCRXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 13:23:35 -0400
Date: Mon, 3 Apr 2006 19:23:34 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, horst.hummel@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 8/9] s390: dasd proc entries.
Message-ID: <20060403172334.GH11049@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horst Hummel <horst.hummel@de.ibm.com>

[patch 8/9] s390: dasd proc entries.

The proc_mkdir calls in the dasd driver are not check for NULL
pointers. Add code to check the pointers and bail out if one of
the proc entries could not be created.

Signed-off-by: Horst Hummel <horst.hummel@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_proc.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+)

diff -urpN linux-2.6/drivers/s390/block/dasd_proc.c linux-2.6-patched/drivers/s390/block/dasd_proc.c
--- linux-2.6/drivers/s390/block/dasd_proc.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_proc.c	2006-04-03 18:46:41.000000000 +0200
@@ -294,23 +294,40 @@ out_error:
 #endif				/* CONFIG_DASD_PROFILE */
 }
 
+/*
+ * Create dasd proc-fs entries.
+ * In case creation failed, cleanup and return -ENOENT.
+ */
 int
 dasd_proc_init(void)
 {
 	dasd_proc_root_entry = proc_mkdir("dasd", &proc_root);
+	if (!dasd_proc_root_entry)
+		goto out_nodasd;
 	dasd_proc_root_entry->owner = THIS_MODULE;
 	dasd_devices_entry = create_proc_entry("devices",
 					       S_IFREG | S_IRUGO | S_IWUSR,
 					       dasd_proc_root_entry);
+	if (!dasd_devices_entry)
+		goto out_nodevices;
 	dasd_devices_entry->proc_fops = &dasd_devices_file_ops;
 	dasd_devices_entry->owner = THIS_MODULE;
 	dasd_statistics_entry = create_proc_entry("statistics",
 						  S_IFREG | S_IRUGO | S_IWUSR,
 						  dasd_proc_root_entry);
+	if (!dasd_statistics_entry)
+		goto out_nostatistics;
 	dasd_statistics_entry->read_proc = dasd_statistics_read;
 	dasd_statistics_entry->write_proc = dasd_statistics_write;
 	dasd_statistics_entry->owner = THIS_MODULE;
 	return 0;
+
+ out_nostatistics:
+	remove_proc_entry("devices", dasd_proc_root_entry);
+ out_nodevices:
+	remove_proc_entry("dasd", &proc_root);
+ out_nodasd:
+	return -ENOENT;
 }
 
 void
