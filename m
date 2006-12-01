Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162277AbWLAXYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162277AbWLAXYK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162237AbWLAXXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:23:54 -0500
Received: from cantor2.suse.de ([195.135.220.15]:27885 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1162239AbWLAXXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:23:01 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 14/36] Driver core: convert raw device code to use struct device
Date: Fri,  1 Dec 2006 15:21:44 -0800
Message-Id: <11650153704007-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <1165015366759-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com> <11650153362310-git-send-email-greg@kroah.com> <11650153392022-git-send-email-greg@kroah.com> <11650153432284-git-send-email-greg@kroah.com> <11650153463092-git-send-email-greg@kroah.com> <1165015349830-git-send-email-greg@kroah.com> <11650153522862-git-send-email-greg@kroah.com> <116501535622-git-send-email-greg@kroah.com> <11650153591876-git-send-email-greg@kroah.com> <11650153631070-git-send-email-greg@kroah.com> <1165015366759-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Converts from using struct "class_device" to "struct device" making
everything show up properly in /sys/devices/ with symlinks from the
/sys/class directory.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/char/raw.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/char/raw.c b/drivers/char/raw.c
index 89b718e..3b32313 100644
--- a/drivers/char/raw.c
+++ b/drivers/char/raw.c
@@ -127,9 +127,9 @@ raw_ioctl(struct inode *inode, struct fi
 
 static void bind_device(struct raw_config_request *rq)
 {
-	class_device_destroy(raw_class, MKDEV(RAW_MAJOR, rq->raw_minor));
-	class_device_create(raw_class, NULL, MKDEV(RAW_MAJOR, rq->raw_minor),
-				      NULL, "raw%d", rq->raw_minor);
+	device_destroy(raw_class, MKDEV(RAW_MAJOR, rq->raw_minor));
+	device_create(raw_class, NULL, MKDEV(RAW_MAJOR, rq->raw_minor),
+		      "raw%d", rq->raw_minor);
 }
 
 /*
@@ -200,7 +200,7 @@ static int raw_ctl_ioctl(struct inode *i
 			if (rq.block_major == 0 && rq.block_minor == 0) {
 				/* unbind */
 				rawdev->binding = NULL;
-				class_device_destroy(raw_class,
+				device_destroy(raw_class,
 						MKDEV(RAW_MAJOR, rq.raw_minor));
 			} else {
 				rawdev->binding = bdget(dev);
@@ -283,7 +283,7 @@ static int __init raw_init(void)
 		ret = PTR_ERR(raw_class);
 		goto error_region;
 	}
-	class_device_create(raw_class, NULL, MKDEV(RAW_MAJOR, 0), NULL, "rawctl");
+	device_create(raw_class, NULL, MKDEV(RAW_MAJOR, 0), "rawctl");
 
 	return 0;
 
@@ -295,7 +295,7 @@ error:
 
 static void __exit raw_exit(void)
 {
-	class_device_destroy(raw_class, MKDEV(RAW_MAJOR, 0));
+	device_destroy(raw_class, MKDEV(RAW_MAJOR, 0));
 	class_destroy(raw_class);
 	cdev_del(&raw_cdev);
 	unregister_chrdev_region(MKDEV(RAW_MAJOR, 0), MAX_RAW_MINORS);
-- 
1.4.4.1

