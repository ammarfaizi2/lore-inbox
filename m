Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262265AbVBSX3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbVBSX3X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 18:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbVBSX3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 18:29:22 -0500
Received: from farside.demon.co.uk ([62.49.25.247]:21492 "EHLO
	mail.farside.org.uk") by vger.kernel.org with ESMTP id S262265AbVBSX3O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 18:29:14 -0500
From: Malcolm Rowe <malcolm-linux@farside.org.uk>
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Symlink /sys/class/block to /sys/block
Date: Sat, 19 Feb 2005 23:29:13 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID: <courier.4217CBC9.000027C1@mail.farside.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg, 

Following the discussion in [1], the attached patch creates /sys/class/block
as a symlink to /sys/block. The patch applies to 2.6.11-rc4-bk7. 

Please cc: me on any replies - I'm not subscribed to the mailing list. 

[1] http://marc.theaimsgroup.com/?m=110506536315986 

Regards,
Malcolm 

Signed-off-by: Malcolm Rowe <malcolm-linux@farside.org.uk> 

diff -ur linux-2.6.11-rc4-bk7/drivers/base/class.c 
linux-2.6.11-rc4-bk7-diff/drivers/base/class.c
 --- linux-2.6.11-rc4-bk7/drivers/base/class.c	2005-02-19 21:34:31.000000000 
+0000
+++ linux-2.6.11-rc4-bk7-diff/drivers/base/class.c	2005-02-19 
21:38:31.000000000 +0000
@@ -69,7 +69,7 @@
}; 

/* Hotplug events for classes go to the class_obj subsys */
 -static decl_subsys(class, &ktype_class, NULL);
+decl_subsys(class, &ktype_class, NULL); 


int class_create_file(struct class * cls, const struct class_attribute * 
attr)
diff -ur linux-2.6.11-rc4-bk7/drivers/block/genhd.c 
linux-2.6.11-rc4-bk7-diff/drivers/block/genhd.c
 --- linux-2.6.11-rc4-bk7/drivers/block/genhd.c	2005-02-19 21:34:31.000000000 
+0000
+++ linux-2.6.11-rc4-bk7-diff/drivers/block/genhd.c	2005-02-19 
22:01:56.000000000 +0000
@@ -14,6 +14,7 @@
#include <linux/slab.h>
#include <linux/kmod.h>
#include <linux/kobj_map.h>
+#include <linux/sysfs.h> 

#define MAX_PROBE_HASH 255	/* random */ 

@@ -300,11 +301,24 @@
	return NULL;
} 

+extern struct subsystem class_subsys;
+
static int __init genhd_device_init(void)
{
	bdev_map = kobj_map_init(base_probe, &block_subsys);
	blk_dev_init();
 -	subsystem_register(&block_subsys);
+	if (!subsystem_register(&block_subsys)) {
+		/*
+		 * /sys/block should really live under /sys/class, but for
+		 * the moment, we can only have class devices, not
+		 * sub-classes-devices. Until we can move /sys/block into
+		 * the right place, create a symlink from /sys/class/block to
+		 * /sys/block, so that userspace doesn't need to know about
+		 * the difference.
+		 */
+		sysfs_create_link(&class_subsys.kset.kobj,
+				  &block_subsys.kset.kobj, "block");
+	}
	return 0;
} 

@@ -406,6 +420,7 @@
static void disk_release(struct kobject * kobj)
{
	struct gendisk *disk = to_disk(kobj);
+	sysfs_remove_link(&class_subsys.kset.kobj, "block");
	kfree(disk->random);
	kfree(disk->part);
	free_disk_stats(disk); 


