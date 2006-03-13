Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932505AbWCMWPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbWCMWPK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWCMWPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:15:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:968 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932505AbWCMWPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:15:07 -0500
Message-ID: <4415EF48.5060907@ce.jp.nec.com>
Date: Mon, 13 Mar 2006 17:16:40 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Alasdair Kergon <agk@redhat.com>,
       Greg KH <gregkh@suse.de>, Neil Brown <neilb@suse.de>
CC: Lars Marowsky-Bree <lmb@suse.de>,
       device-mapper development <dm-devel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] dm/md dependency tree in sysfs: md to use bd_claim_by_disk
References: <4415EC4B.4010003@ce.jp.nec.com>
In-Reply-To: <4415EC4B.4010003@ce.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------000105040106010208040102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000105040106010208040102
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

This patch is part of dm/md dependency tree in sysfs.

Following symlinks are created if md0 is built from sda and sdb
  /sys/block/md0/slaves/sda --> /sys/block/sda
  /sys/block/md0/slaves/sdb --> /sys/block/sdb
  /sys/block/sda/holders/md0 --> /sys/block/md0
  /sys/block/sdb/holders/md0 --> /sys/block/md0

Thanks,
-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.

--------------000105040106010208040102
Content-Type: text/x-patch;
 name="05-md_deptree.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="05-md_deptree.patch"

Use bd_claim_by_disk.

Following symlinks are created if md0 is built from sda and sdb
  /sys/block/md0/slaves/sda --> /sys/block/sda
  /sys/block/md0/slaves/sdb --> /sys/block/sdb
  /sys/block/sda/holders/md0 --> /sys/block/md0
  /sys/block/sdb/holders/md0 --> /sys/block/md0

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

 drivers/md/md.c |    2 ++
 1 files changed, 2 insertions(+)

--- linux-2.6.16-rc6.orig/drivers/md/md.c	2006-03-11 17:12:55.000000000 -0500
+++ linux-2.6.16-rc6/drivers/md/md.c	2006-03-13 11:24:00.000000000 -0500
@@ -1298,6 +1298,7 @@ static int bind_rdev_to_array(mdk_rdev_t
 	else
 		ko = &rdev->bdev->bd_disk->kobj;
 	sysfs_create_link(&rdev->kobj, ko, "block");
+	bd_claim_by_disk(rdev->bdev, rdev, mddev->gendisk);
 	return 0;
 }
 
@@ -1308,6 +1309,7 @@ static void unbind_rdev_from_array(mdk_r
 		MD_BUG();
 		return;
 	}
+	bd_release_from_disk(rdev->bdev, rdev->mddev->gendisk);
 	list_del_init(&rdev->same_set);
 	printk(KERN_INFO "md: unbind<%s>\n", bdevname(rdev->bdev,b));
 	rdev->mddev = NULL;

--------------000105040106010208040102--
