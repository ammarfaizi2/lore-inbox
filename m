Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWBXR0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWBXR0R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 12:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWBXR0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 12:26:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40641 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932398AbWBXR0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 12:26:17 -0500
Message-ID: <43FF4206.2030209@ce.jp.nec.com>
Date: Fri, 24 Feb 2006 12:27:34 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: device-mapper development <dm-devel@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] dm free minor after unlink gendisk
Content-Type: multipart/mixed;
 boundary="------------020402090500010402070201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020402090500010402070201
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hello,

free_dev() releases minor number before unregistering gendisk.
It creates a window where two registered gendisk with same number
exist, which will cause problem.

Typically, if you run the following script,
you will hit WARN_ON() in kref_get().

#!/bin/sh
(while dmsetup create a --notable; do dmsetup remove a; done) &
(while dmsetup create b --notable; do dmsetup remove b; done) &

Attached patch fixes this problem.

-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.

--------------020402090500010402070201
Content-Type: text/x-patch;
 name="dm-free-minor-after-del_gendisk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dm-free-minor-after-del_gendisk.patch"

minor number should be freed after del_gendisk().
Otherwise, there could be a window where 2 registered gendisk
has same minor number.

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

--- linux-2.6.15.orig/drivers/md/dm.c	2006-02-24 11:05:05.000000000 -0500
+++ linux-2.6.15/drivers/md/dm.c	2006-02-24 11:17:54.000000000 -0500
@@ -812,14 +812,16 @@ static struct mapped_device *alloc_dev(u
 
 static void free_dev(struct mapped_device *md)
 {
+	unsigned int minor = md->disk->first_minor;
+
 	if (md->suspended_bdev) {
 		thaw_bdev(md->suspended_bdev, NULL);
 		bdput(md->suspended_bdev);
 	}
-	free_minor(md->disk->first_minor);
 	mempool_destroy(md->tio_pool);
 	mempool_destroy(md->io_pool);
 	del_gendisk(md->disk);
+	free_minor(minor);
 	put_disk(md->disk);
 	blk_put_queue(md->queue);
 	kfree(md);

--------------020402090500010402070201--
