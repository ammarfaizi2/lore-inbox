Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbWCMWOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbWCMWOx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWCMWOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:14:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44743 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932504AbWCMWOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:14:50 -0500
Message-ID: <4415EF35.2010402@ce.jp.nec.com>
Date: Mon, 13 Mar 2006 17:16:21 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Alasdair Kergon <agk@redhat.com>,
       Greg KH <gregkh@suse.de>, Neil Brown <neilb@suse.de>
CC: Lars Marowsky-Bree <lmb@suse.de>,
       device-mapper development <dm-devel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] dm/md dependency tree in sysfs: bd_claim_by_disk
References: <4415EC4B.4010003@ce.jp.nec.com>
In-Reply-To: <4415EC4B.4010003@ce.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------010908030706060300080101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010908030706060300080101
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

This patch is part of dm/md dependency tree in sysfs.

This adds variants of bd_claim_by_kobject which takes gendisk instead
of kobject and do kobject_{get,put}(&gendisk->slave_dir).

Thanks,
-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.

--------------010908030706060300080101
Content-Type: text/x-patch;
 name="04-bd_claim_by_disk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="04-bd_claim_by_disk.patch"

Variants of bd_claim_by_kobject which takes gendisk instead
of kobject and do kobject_{get,put}(&gendisk->slave_dir).

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

 include/linux/genhd.h |   13 +++++++++++++
 1 files changed, 13 insertions(+)

--- linux-2.6.16-rc6.orig/include/linux/genhd.h	2006-03-11 17:12:55.000000000 -0500
+++ linux-2.6.16-rc6/include/linux/genhd.h	2006-03-13 11:24:13.000000000 -0500
@@ -421,6 +424,19 @@ static inline struct block_device *bdget
 	return bdget(MKDEV(disk->major, disk->first_minor) + index);
 }
 
+static inline int bd_claim_by_disk(struct block_device *bdev,
+					void *holder, struct gendisk *disk)
+{
+	return bd_claim_by_kobject(bdev, holder, kobject_get(disk->slave_dir));
+}
+
+static inline void bd_release_from_disk(struct block_device *bdev,
+					struct gendisk *disk)
+{
+	bd_release_from_kobject(bdev, disk->slave_dir);
+	kobject_put(disk->slave_dir);
+}
+
 #endif
 
 #endif

--------------010908030706060300080101--
