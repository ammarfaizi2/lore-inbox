Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422684AbWGJTv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422684AbWGJTv2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 15:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422686AbWGJTv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 15:51:28 -0400
Received: from mta11.adelphia.net ([68.168.78.205]:61947 "EHLO
	mta11.adelphia.net") by vger.kernel.org with ESMTP id S1422684AbWGJTv1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 15:51:27 -0400
Message-ID: <44B2B009.7040708@walsh.ws>
Date: Mon, 10 Jul 2006 15:52:41 -0400
From: Brian Walsh <brian@walsh.ws>
User-Agent: Mail/News 1.5 (X11/20060213)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.18-rc1 1/1] drivers/base: Platform notify needs to occur
 before drivers attach to the device
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_notify call for Arm and PPC architectures needs to be
called before the driver attaches to the device.  The problem only
presents itself when hotplugging certain devices while the driver is
already loaded.


Signed-off-by: Brian Walsh <brian@walsh.ws>
---

diff -ur a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c       2006-07-10 13:26:00.000000000 -0400
+++ b/drivers/base/core.c       2006-07-10 13:32:58.000000000 -0400
@@ -307,6 +307,10 @@
        if ((error = kobject_add(&dev->kobj)))
                goto Error;

+       /* notify platform of device entry */
+       if (platform_notify)
+               platform_notify(dev);
+
        dev->uevent_attr.attr.name = "uevent";
        dev->uevent_attr.attr.mode = S_IWUSR;
        if (dev->driver)
@@ -361,10 +365,6 @@
                list_add_tail(&dev->node, &dev->class->devices);
                up(&dev->class->sem);
        }
-
-       /* notify platform of device entry */
-       if (platform_notify)
-               platform_notify(dev);
  Done:
        kfree(class_name);
        put_device(dev);

