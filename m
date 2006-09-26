Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWIZFiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWIZFiL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWIZFiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:38:11 -0400
Received: from mail.suse.de ([195.135.220.2]:42465 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751286AbWIZFiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:38:08 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Kay Sievers <kay.sievers@suse.de>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 2/47] deprecate PHYSDEV* keys
Date: Mon, 25 Sep 2006 22:37:22 -0700
Message-Id: <11592490903867-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <1159249087369-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kay Sievers <kay.sievers@suse.de>

deprecate PHYSDEV* values in the uevent environment

These values are no longer needed and inconsistent with the
stacking of class devices. The event environment should not
carry properties of a parent device. The key PHYSDEVDRIVER is
available as DRIVER, PHYDEVBUS is indentical SUBSYSTEM. Class
devices should not carry any of these values.

Signed-off-by: Kay Sievers <kay.sievers@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 Documentation/feature-removal-schedule.txt |   12 ++++++++++++
 drivers/base/class.c                       |    2 +-
 drivers/base/core.c                        |   10 +++++++---
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 552507f..a89a1b7 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -294,3 +294,15 @@ Why:	The frame diverter is included in m
 	It is not clear if anyone is still using it.
 Who:	Stephen Hemminger <shemminger@osdl.org>
 
+---------------------------
+
+
+What:	PHYSDEVPATH, PHYSDEVBUS, PHYSDEVDRIVER in the uevent environment
+When:	Oktober 2008
+Why:	The stacking of class devices makes these values misleading and
+	inconsistent.
+	Class devices should not carry any of these properties, and bus
+	devices have SUBSYTEM and DRIVER as a replacement.
+Who:	Kay Sievers <kay.sievers@suse.de>
+
+---------------------------
diff --git a/drivers/base/class.c b/drivers/base/class.c
index de89083..46336f1 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -361,7 +361,7 @@ static int class_uevent(struct kset *kse
 	pr_debug("%s - name = %s\n", __FUNCTION__, class_dev->class_id);
 
 	if (class_dev->dev) {
-		/* add physical device, backing this device  */
+		/* add device, backing this class device (deprecated) */
 		struct device *dev = class_dev->dev;
 		char *path = kobject_get_path(&dev->kobj, GFP_KERNEL);
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index be6b5bc..04d089f 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -149,17 +149,21 @@ static int dev_uevent(struct kset *kset,
 			       "MINOR=%u", MINOR(dev->devt));
 	}
 
-	/* add bus name of physical device */
+	/* add bus name (same as SUBSYSTEM, deprecated) */
 	if (dev->bus)
 		add_uevent_var(envp, num_envp, &i,
 			       buffer, buffer_size, &length,
 			       "PHYSDEVBUS=%s", dev->bus->name);
 
-	/* add driver name of physical device */
-	if (dev->driver)
+	/* add driver name (PHYSDEV* values are deprecated)*/
+	if (dev->driver) {
+		add_uevent_var(envp, num_envp, &i,
+			       buffer, buffer_size, &length,
+			       "DRIVER=%s", dev->driver->name);
 		add_uevent_var(envp, num_envp, &i,
 			       buffer, buffer_size, &length,
 			       "PHYSDEVDRIVER=%s", dev->driver->name);
+	}
 
 	/* terminate, set to next free slot, shrink available space */
 	envp[i] = NULL;
-- 
1.4.2.1

