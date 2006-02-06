Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWBFUaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWBFUaA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbWBFU3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:29:41 -0500
Received: from mail.kroah.org ([69.55.234.183]:26813 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964786AbWBFU3f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:29:35 -0500
Cc: gregkh@suse.de
Subject: [PATCH] IB: fix up major/minor sysfs interface for IB core
In-Reply-To: <11392577571422@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 6 Feb 2006 12:29:17 -0800
Message-Id: <11392577573268@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] IB: fix up major/minor sysfs interface for IB core

Current IB code doesn't work with userspace programs that listen only to
the kernel event netlink socket as it is trying to create its own dev
interface.  This small patch fixes this problem, and removes some
unneeded code as the driver core handles this logic for you
automatically.

Acked-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 68f5f996347dc2724a0dd511683643a2b6912380
tree 1a1131ef78c81129791c2c3b3cf365c7e35283aa
parent 0650fd5824e07570f0c43980b81bb23ae917f1d7
author Greg Kroah-Hartman <gregkh@suse.de> Fri, 20 Jan 2006 14:08:59 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 06 Feb 2006 12:17:17 -0800

 drivers/infiniband/core/ucm.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/core/ucm.c b/drivers/infiniband/core/ucm.c
index e95c429..f6a0596 100644
--- a/drivers/infiniband/core/ucm.c
+++ b/drivers/infiniband/core/ucm.c
@@ -1319,15 +1319,6 @@ static struct class ucm_class = {
 	.release = ib_ucm_release_class_dev
 };
 
-static ssize_t show_dev(struct class_device *class_dev, char *buf)
-{
-	struct ib_ucm_device *dev;
-	
-	dev = container_of(class_dev, struct ib_ucm_device, class_dev);
-	return print_dev_t(buf, dev->dev.dev);
-}
-static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
-
 static ssize_t show_ibdev(struct class_device *class_dev, char *buf)
 {
 	struct ib_ucm_device *dev;
@@ -1364,15 +1355,13 @@ static void ib_ucm_add_one(struct ib_dev
 
 	ucm_dev->class_dev.class = &ucm_class;
 	ucm_dev->class_dev.dev = device->dma_device;
+	ucm_dev->class_dev.devt = ucm_dev->dev.dev;
 	snprintf(ucm_dev->class_dev.class_id, BUS_ID_SIZE, "ucm%d",
 		 ucm_dev->devnum);
 	if (class_device_register(&ucm_dev->class_dev))
 		goto err_cdev;
 
 	if (class_device_create_file(&ucm_dev->class_dev,
-				     &class_device_attr_dev))
-		goto err_class;
-	if (class_device_create_file(&ucm_dev->class_dev,
 				     &class_device_attr_ibdev))
 		goto err_class;
 

