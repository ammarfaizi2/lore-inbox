Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbWCDA5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbWCDA5J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 19:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbWCDA5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 19:57:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8100 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750946AbWCDA46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 19:56:58 -0500
Message-ID: <4408E62D.9030701@ce.jp.nec.com>
Date: Fri, 03 Mar 2006 19:58:21 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alasdair Kergon <agk@redhat.com>, Neil Brown <neilb@suse.de>,
       Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
CC: Lars Marowsky-Bree <lmb@suse.de>, akpm@osdl.org,
       device-mapper development <dm-devel@redhat.com>
Subject: [PATCH 5/6] md to use bd_claim_by_disk
References: <4408E33E.1080703@ce.jp.nec.com>
In-Reply-To: <4408E33E.1080703@ce.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------040005090200080303080904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040005090200080303080904
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

This patch is part of dm/md sysfs dependency tree.

Following symlinks are created if md0 is built from sda and sdb
  /sys/block/md0/slaves/sda --> /sys/block/sda
  /sys/block/md0/slaves/sdb --> /sys/block/sdb
  /sys/block/sda/holders/md0 --> /sys/block/md0
  /sys/block/sdb/holders/md0 --> /sys/block/md0

Thanks,
-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.

--------------040005090200080303080904
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

--- linux-2.6.16-rc5.orig/drivers/md/md.c	2006-02-27 00:09:35.000000000 -0500
+++ linux-2.6.16-rc5/drivers/md/md.c	2006-03-02 14:57:05.000000000 -0500
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

--------------040005090200080303080904--
