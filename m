Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWAUAIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWAUAIU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 19:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWAUAIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 19:08:20 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:6883 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S932072AbWAUAIT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 19:08:19 -0500
Date: Fri, 20 Jan 2006 16:08:19 -0800
From: Greg KH <greg@kroah.com>
To: rolandd@cisco.com, mshefty@ichips.intel.com,
       Kay Sievers <kay.sievers@vrfy.org>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: [PATCH] fix IB with latest versions of udev
Message-ID: <20060121000819.GA26967@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch that will remove a few lines of code from the IB core,
and let it work properly with userspace programs that are only watching
the netlink socket for events, instead of mucking around in sysfs (like
the latest versions of udev do.)

I've only compile tested it as I have no IB hardware here.

If you want, I can forward this on to Linus in my driver tree, or you
can send it yourselves.

thanks,

greg k-h

---------------------

From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: IB: fix up major/minor sysfs interface for IB core

Current IB code doesn't work with userspace programs that listen only to
the kernel event netlink socket as it is trying to create its own dev
interface.  This small patch fixes this problem, and removes some
unneeded code as the driver core handles this logic for you
automatically.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/infiniband/core/ucm.c |   13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

--- gregkh-2.6.orig/drivers/infiniband/core/ucm.c
+++ gregkh-2.6/drivers/infiniband/core/ucm.c
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
 
