Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWARQ5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWARQ5z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 11:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWARQ5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 11:57:55 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:61835 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751332AbWARQ5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 11:57:54 -0500
Date: Wed, 18 Jan 2006 17:57:45 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Horst Hummel <horst.hummel@de.ibm.com>
Subject: [PATCH 6/7] s390: dasd open counter.
Message-ID: <20060118165745.GF29266@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horst Hummel <horst.hummel@de.ibm.com>

The open_count is increased for every opener, that includes the
blkdev_get in dasd_scan_partitions. This tampers the open_count
in BIODASDINFO. Hide the internal open from user-space.

Signed-off-by: Horst Hummel <horst.hummel@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/block/dasd_ioctl.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/block/dasd_ioctl.c linux-2.6-patched/drivers/s390/block/dasd_ioctl.c
--- linux-2.6/drivers/s390/block/dasd_ioctl.c	2006-01-18 17:25:49.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_ioctl.c	2006-01-18 17:25:53.000000000 +0100
@@ -421,8 +421,15 @@ dasd_ioctl_information(struct block_devi
 	dasd_info->cu_model = cdev->id.cu_model;
 	dasd_info->dev_type = cdev->id.dev_type;
 	dasd_info->dev_model = cdev->id.dev_model;
-	dasd_info->open_count = atomic_read(&device->open_count);
 	dasd_info->status = device->state;
+	/*
+	 * The open_count is increased for every opener, that includes
+	 * the blkdev_get in dasd_scan_partitions.
+	 * This must be hidden from user-space.
+	 */
+	dasd_info->open_count = atomic_read(&device->open_count);
+	if (!device->bdev)
+		dasd_info->open_count++;
 	
 	/*
 	 * check if device is really formatted
