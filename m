Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVAWEYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVAWEYI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 23:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVAWEYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 23:24:07 -0500
Received: from soundwarez.org ([217.160.171.123]:4747 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261207AbVAWEXU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 23:23:20 -0500
Date: Sun, 23 Jan 2005 05:23:17 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 2/7] block core: export MAJOR/MINOR to the hotplug env
Message-ID: <20050123042317.GC9209@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>

===== drivers/block/genhd.c 1.109 vs edited =====
--- 1.109/drivers/block/genhd.c	2005-01-14 20:21:23 +01:00
+++ edited/drivers/block/genhd.c	2005-01-23 02:59:27 +01:00
@@ -430,42 +430,57 @@ static int block_hotplug_filter(struct k
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

