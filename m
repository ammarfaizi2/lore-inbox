Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWBXAD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWBXAD5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 19:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWBXAD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 19:03:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17032 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932155AbWBXAD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 19:03:56 -0500
Message-ID: <43FE4DB5.5050904@ce.jp.nec.com>
Date: Thu, 23 Feb 2006 19:05:09 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: device-mapper development <dm-devel@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] dm missing bdput/thaw_bdev at removal
Content-Type: multipart/mixed;
 boundary="------------010607050004060606030302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010607050004060606030302
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hello,

The following script stalls at the 2nd suspend.
It's because bdput() isn't called for the suspended_bdev.

So the inode with bd_mount_sem held is just reused
in the next mapped_device device.
Then dm_suspend will try to freeze_bdev and wait forever.

Attached patch fixes this problem.

------------------------------------------------------------
#!/bin/sh -x

map=a
while true; do
  dmsetup create $map --notable
  dmsetup suspend $map
  dmsetup remove $map
done
------------------------------------------------------------

-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.

--------------010607050004060606030302
Content-Type: text/x-patch;
 name="dm-missing-bdput.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dm-missing-bdput.patch"

Need to unfreeze and release bdev
otherwise the bdev inode with inconsistent state is reused later
and cause problem.

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

--- linux-2.6.15.orig/drivers/md/dm.c	2006-02-23 18:28:23.000000000 -0500
+++ linux-2.6.15/drivers/md/dm.c	2006-02-23 18:29:04.000000000 -0500
@@ -812,6 +812,10 @@ static struct mapped_device *alloc_dev(u
 
 static void free_dev(struct mapped_device *md)
 {
+	if (md->suspended_bdev) {
+		thaw_bdev(md->suspended_bdev, NULL);
+		bdput(md->suspended_bdev);
+	}
 	free_minor(md->disk->first_minor);
 	mempool_destroy(md->tio_pool);
 	mempool_destroy(md->io_pool);

--------------010607050004060606030302--
