Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262182AbVCJDYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbVCJDYn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 22:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbVCJBJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:09:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:50079 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262619AbVCJAm2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:28 -0500
Cc: kay.sievers@vrfy.org
Subject: [PATCH] block core: export MAJOR/MINOR to the hotplug env
In-Reply-To: <1110414880513@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:34:41 -0800
Message-Id: <11104148811634@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2040, 2005/03/09 09:32:58-08:00, kay.sievers@vrfy.org

[PATCH] block core: export MAJOR/MINOR to the hotplug env

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/block/genhd.c |   53 ++++++++++++++++++++++++++++++++------------------
 1 files changed, 34 insertions(+), 19 deletions(-)


diff -Nru a/drivers/block/genhd.c b/drivers/block/genhd.c
--- a/drivers/block/genhd.c	2005-03-09 16:29:48 -08:00
+++ b/drivers/block/genhd.c	2005-03-09 16:29:48 -08:00
@@ -430,42 +430,57 @@
 static int block_hotplug(struct kset *kset, struct kobject *kobj, char **envp,
 			 int num_envp, char *buffer, int buffer_size)
 {
-	struct device *dev = NULL;
 	struct kobj_type *ktype = get_ktype(kobj);
+	struct device *physdev;
+	struct gendisk *disk;
+	struct hd_struct *part;
 	int length = 0;
 	int i = 0;
 
-	/* get physical device backing disk or partition */
 	if (ktype == &ktype_block) {
-		struct gendisk *disk = container_of(kobj, struct gendisk, kobj);
-		dev = disk->driverfs_dev;
+		disk = container_of(kobj, struct gendisk, kobj);
+		add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size,
+				    &length, "MINOR=%u", disk->first_minor);
 	} else if (ktype == &ktype_part) {
-		struct gendisk *disk = container_of(kobj->parent, struct gendisk, kobj);
-		dev = disk->driverfs_dev;
-	}
-
-	if (dev) {
-		/* add physical device, backing this device  */
-		char *path = kobject_get_path(&dev->kobj, GFP_KERNEL);
+		disk = container_of(kobj->parent, struct gendisk, kobj);
+		part = container_of(kobj, struct hd_struct, kobj);
+		add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size,
+				    &length, "MINOR=%u",
+				    disk->first_minor + part->partno);
+	} else
+		return 0;
+
+	add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size, &length,
+			    "MAJOR=%u", disk->major);
+
+	/* add physical device, backing this device  */
+	physdev = disk->driverfs_dev;
+	if (physdev) {
+		char *path = kobject_get_path(&physdev->kobj, GFP_KERNEL);
 
 		add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size,
 				    &length, "PHYSDEVPATH=%s", path);
 		kfree(path);
 
-		/* add bus name of physical device */
-		if (dev->bus)
+		if (physdev->bus)
 			add_hotplug_env_var(envp, num_envp, &i,
 					    buffer, buffer_size, &length,
-					    "PHYSDEVBUS=%s", dev->bus->name);
+					    "PHYSDEVBUS=%s",
+					    physdev->bus->name);
 
-		/* add driver name of physical device */
-		if (dev->driver)
+		if (physdev->driver)
 			add_hotplug_env_var(envp, num_envp, &i,
 					    buffer, buffer_size, &length,
-					    "PHYSDEVDRIVER=%s", dev->driver->name);
-
-		envp[i] = NULL;
+					    "PHYSDEVDRIVER=%s",
+					    physdev->driver->name);
 	}
+
+	/* terminate, set to next free slot, shrink available space */
+	envp[i] = NULL;
+	envp = &envp[i];
+	num_envp -= i;
+	buffer = &buffer[length];
+	buffer_size -= length;
 
 	return 0;
 }

