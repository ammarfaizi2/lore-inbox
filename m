Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbUBXQv6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 11:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbUBXQv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 11:51:58 -0500
Received: from eth13.com-link.com ([208.242.241.164]:30136 "EHLO
	real.realitydiluted.com") by vger.kernel.org with ESMTP
	id S262295AbUBXQvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 11:51:45 -0500
Message-ID: <403B8108.6080606@realitydiluted.com>
Date: Tue, 24 Feb 2004 11:51:20 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jeremy Higdon <jeremy@sgi.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.6.2, Partition support for SCSI CDROM...
References: <40396134.6030906@realitydiluted.com> <20040222190047.01f6f024.akpm@osdl.org> <40396E8F.4050307@realitydiluted.com> <20040224061130.GC503530@sgi.com>
In-Reply-To: <20040224061130.GC503530@sgi.com>
Content-Type: multipart/mixed;
 boundary="------------060109060609020107080702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060109060609020107080702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here is the second try at the patch.

-Steve

--------------060109060609020107080702
Content-Type: text/x-patch;
 name="scsi-sr-partitions-2.6.2-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="scsi-sr-partitions-2.6.2-2.patch"

diff -urN linux-2.6.2/drivers/scsi/sr.c linux-2.6.2-patched/drivers/scsi/sr.c
--- linux-2.6.2/drivers/scsi/sr.c	2004-02-22 20:15:08.000000000 -0500
+++ linux-2.6.2-patched/drivers/scsi/sr.c	2004-02-24 11:48:16.000000000 -0500
@@ -55,6 +55,23 @@
 #include "scsi_logging.h"
 #include "sr.h"
 
+/*
+ * Device node mappings are as follows:
+ *
+ *    sr0 - first CDROM, whole disk
+ *    sr1 - first CDROM, first partition
+ *
+ *    [...]
+ *
+ *    sr16 - first CDROM, sixteenth partition
+ *    sr17 - second CDROM, whole disk
+ *    sr18 - second CDROM, first partition
+ *
+ *    [...]
+ */
+static int partitions = 16;
+MODULE_PARM(partitions, "i");
+MODULE_PARM_DESC(partitions, "number of SCSI CDROM partitions to support");
 
 MODULE_PARM(xa_test, "i");	/* see sr_ioctl.c */
 
@@ -518,7 +535,7 @@
 		goto fail;
 	memset(cd, 0, sizeof(*cd));
 
-	disk = alloc_disk(1);
+	disk = alloc_disk(partitions + 1);
 	if (!disk)
 		goto fail_free;
 
@@ -533,7 +550,7 @@
 	spin_unlock(&sr_index_lock);
 
 	disk->major = SCSI_CDROM_MAJOR;
-	disk->first_minor = minor;
+	disk->first_minor = minor * (partitions + 1);
 	sprintf(disk->disk_name, "sr%d", minor);
 	disk->fops = &sr_bdops;
 	disk->flags = GENHD_FL_CD;
@@ -868,6 +885,10 @@
 {
 	int rc;
 
+	/* Check number of partitions specified. */
+	if (partitions < 0)
+		partitions = 0;
+
 	rc = register_blkdev(SCSI_CDROM_MAJOR, "sr");
 	if (rc)
 		return rc;

--------------060109060609020107080702--
