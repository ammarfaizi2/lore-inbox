Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262458AbVAUSSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbVAUSSn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 13:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbVAUSS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 13:18:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3753 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262441AbVAUSPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 13:15:07 -0500
Date: Fri, 21 Jan 2005 18:15:03 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: device-mapper: optionally bypass a bdget
Message-ID: <20050121181503.GJ10195@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Improve performance by optionally bypassing some code that uses bdget.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
--- diff/drivers/md/dm-ioctl.c	2005-01-12 20:50:16.000000000 +0000
+++ source/drivers/md/dm-ioctl.c	2005-01-12 20:50:07.000000000 +0000
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 2001, 2002 Sistina Software (UK) Limited.
- * Copyright (C) 2004 Red Hat, Inc. All rights reserved.
+ * Copyright (C) 2004 - 2005 Red Hat, Inc. All rights reserved.
  *
  * This file is released under the GPL.
  */
@@ -520,19 +520,22 @@
 	if (dm_suspended(md))
 		param->flags |= DM_SUSPEND_FLAG;
 
-	bdev = bdget_disk(disk, 0);
-	if (!bdev)
-		return -ENXIO;
-
 	param->dev = huge_encode_dev(MKDEV(disk->major, disk->first_minor));
 
-	/*
-	 * Yes, this will be out of date by the time it gets back
-	 * to userland, but it is still very useful ofr
-	 * debugging.
-	 */
-	param->open_count = bdev->bd_openers;
-	bdput(bdev);
+	if (!(param->flags & DM_SKIP_BDGET_FLAG)) {
+		bdev = bdget_disk(disk, 0);
+		if (!bdev)
+			return -ENXIO;
+
+		/*
+		 * Yes, this will be out of date by the time it gets back
+		 * to userland, but it is still very useful for
+		 * debugging.
+		 */
+		param->open_count = bdev->bd_openers;
+		bdput(bdev);
+	} else
+		param->open_count = -1;
 
 	if (disk->policy)
 		param->flags |= DM_READONLY_FLAG;
--- diff/include/linux/dm-ioctl.h	2005-01-12 20:50:16.000000000 +0000
+++ source/include/linux/dm-ioctl.h	2005-01-12 20:49:42.000000000 +0000
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 2001 - 2003 Sistina Software (UK) Limited.
- * Copyright (C) 2004 Red Hat, Inc. All rights reserved.
+ * Copyright (C) 2004 - 2005 Red Hat, Inc. All rights reserved.
  *
  * This file is released under the LGPL.
  */
@@ -272,9 +272,9 @@
 #define DM_TARGET_MSG	 _IOWR(DM_IOCTL, DM_TARGET_MSG_CMD, struct dm_ioctl)
 
 #define DM_VERSION_MAJOR	4
-#define DM_VERSION_MINOR	3
+#define DM_VERSION_MINOR	4
 #define DM_VERSION_PATCHLEVEL	0
-#define DM_VERSION_EXTRA	"-ioctl (2004-09-30)"
+#define DM_VERSION_EXTRA	"-ioctl (2005-01-12)"
 
 /* Status bits */
 #define DM_READONLY_FLAG	(1 << 0) /* In/Out */
@@ -300,4 +300,9 @@
  */
 #define DM_BUFFER_FULL_FLAG	(1 << 8) /* Out */
 
+/*
+ * Set this to improve performance when you aren't going to use open_count
+ */
+#define DM_SKIP_BDGET_FLAG	(1 << 9) /* In */
+
 #endif				/* _LINUX_DM_IOCTL_H */
