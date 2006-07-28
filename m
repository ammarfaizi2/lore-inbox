Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161100AbWG1I6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161100AbWG1I6Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 04:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161103AbWG1I6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 04:58:16 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:25109 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161100AbWG1I6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 04:58:14 -0400
Date: Fri, 28 Jul 2006 10:58:25 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cornelia.huck@de.ibm.com
Subject: [patch] s390: duplicate ccw devices in ccwgroup.
Message-ID: <20060728085825.GB19478@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[S390] duplicate ccw devices in ccwgroup.

Fail to create a ccwgroup device if a ccw device is passed in twice.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/ccwgroup.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/ccwgroup.c linux-2.6-patched/drivers/s390/cio/ccwgroup.c
--- linux-2.6/drivers/s390/cio/ccwgroup.c	2006-07-27 13:52:22.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/ccwgroup.c	2006-07-27 13:52:40.000000000 +0200
@@ -152,7 +152,6 @@ ccwgroup_create(struct device *root,
 	struct ccwgroup_device *gdev;
 	int i;
 	int rc;
-	int del_drvdata;
 
 	if (argc > 256) /* disallow dumb users */
 		return -EINVAL;
@@ -163,7 +162,6 @@ ccwgroup_create(struct device *root,
 
 	atomic_set(&gdev->onoff, 0);
 
-	del_drvdata = 0;
 	for (i = 0; i < argc; i++) {
 		gdev->cdev[i] = get_ccwdev_by_busid(cdrv, argv[i]);
 
@@ -180,10 +178,8 @@ ccwgroup_create(struct device *root,
 			rc = -EINVAL;
 			goto free_dev;
 		}
-	}
-	for (i = 0; i < argc; i++)
 		gdev->cdev[i]->dev.driver_data = gdev;
-	del_drvdata = 1;
+	}
 
 	gdev->creator_id = creator_id;
 	gdev->count = argc;
@@ -226,9 +222,9 @@ error:
 free_dev:
 	for (i = 0; i < argc; i++)
 		if (gdev->cdev[i]) {
-			put_device(&gdev->cdev[i]->dev);
-			if (del_drvdata)
+			if (gdev->cdev[i]->dev.driver_data == gdev)
 				gdev->cdev[i]->dev.driver_data = NULL;
+			put_device(&gdev->cdev[i]->dev);
 		}
 	kfree(gdev);
 	return rc;
