Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWBVQMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWBVQMU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 11:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWBVQMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 11:12:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31191 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932357AbWBVQL6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 11:11:58 -0500
Message-ID: <43FC8D97.9080102@ce.jp.nec.com>
Date: Wed, 22 Feb 2006 11:13:11 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>, Alasdair Kergon <agk@redhat.com>,
       Lars Marowsky-Bree <lmb@suse.de>, Greg KH <gregkh@suse.de>
CC: linux-kernel@vger.kernel.org,
       device-mapper development <dm-devel@redhat.com>
Subject: [PATCH 3/3] sysfs representation of stacked devices (md) (rev.2)
References: <43FC8C00.5020600@ce.jp.nec.com>
In-Reply-To: <43FC8C00.5020600@ce.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------080802050506060906040303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080802050506060906040303
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

This patch modifies md driver to call bd_claim_by_kobject
and bd_release_from_kobject.

-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.

--------------080802050506060906040303
Content-Type: text/x-patch;
 name="md.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="md.patch"

Exporting stacked device relationship to sysfs (md)

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

--- linux-2.6.15/drivers/md/md.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/drivers/md/md.c	2006-02-21 19:11:16.000000000 -0500
@@ -1226,6 +1226,7 @@ static int bind_rdev_to_array(mdk_rdev_t
 	else
 		ko = &rdev->bdev->bd_disk->kobj;
 	sysfs_create_link(&rdev->kobj, ko, "block");
+	bd_claim_by_kobject(rdev->bdev, rdev, &mddev->gendisk->slave_dir);
 	return 0;
 }
 
@@ -1236,6 +1237,7 @@ static void unbind_rdev_from_array(mdk_r
 		MD_BUG();
 		return;
 	}
+	bd_release_from_kobject(rdev->bdev, &rdev->mddev->gendisk->slave_dir);
 	list_del_init(&rdev->same_set);
 	printk(KERN_INFO "md: unbind<%s>\n", bdevname(rdev->bdev,b));
 	rdev->mddev = NULL;

--------------080802050506060906040303--
