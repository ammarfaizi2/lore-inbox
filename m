Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263204AbUENXKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbUENXKz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbUENXKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:10:12 -0400
Received: from mail.kroah.org ([65.200.24.183]:52700 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263204AbUENXIH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:08:07 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.6
In-Reply-To: <10845760414160@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 14 May 2004 16:07:21 -0700
Message-Id: <10845760412992@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.5.12, 2004/04/28 11:51:03-07:00, greg@kroah.com

My cleanups to the smbios driver.


 drivers/firmware/smbios.c |   44 +++++++++++++-------------------------------
 1 files changed, 13 insertions(+), 31 deletions(-)


diff -Nru a/drivers/firmware/smbios.c b/drivers/firmware/smbios.c
--- a/drivers/firmware/smbios.c	Fri May 14 15:59:57 2004
+++ b/drivers/firmware/smbios.c	Fri May 14 15:59:57 2004
@@ -10,9 +10,9 @@
  *
  * This code takes information provided by SMBIOS tables
  * and presents it in sysfs as:
- *    /sys/firmware/smbios/smbios
- *				|--> /table_entry_point
- *				|--> /table
+ *    /sys/firmware/smbios
+ *			|--> /table_entry_point
+ *			|--> /table
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License v2.0 as published by
@@ -42,7 +42,6 @@
 struct smbios_device {
 	struct smbios_table_entry_point table_eps;
 	unsigned int smbios_table_real_length;
-	struct kobject kobj;
 };
 
 /* there shall be only one */
@@ -143,7 +142,7 @@
 smbios_read_table_entry_point(struct kobject *kobj, char *buffer,
 				loff_t pos, size_t size)
 {
-	struct smbios_device *sdev = to_smbios_device(kobj);
+	struct smbios_device *sdev = &the_smbios_device;
 	const char *p = (const char *)&(sdev->table_eps);
 	unsigned int count =
 		size > sizeof(sdev->table_eps) ?
@@ -156,7 +155,7 @@
 smbios_read_table(struct kobject *kobj, char *buffer,
 				loff_t pos, size_t size)
 {
-	struct smbios_device *sdev = to_smbios_device(kobj);
+	struct smbios_device *sdev = &the_smbios_device;
 	u8 *buf;
 	unsigned int count = sdev->smbios_table_real_length - pos;
 	int i = 0;
@@ -204,30 +203,16 @@
 
 static decl_subsys(smbios,&ktype_smbios,NULL);
 
-static inline void
-smbios_device_unregister(struct smbios_device *sdev)
+static void smbios_device_unregister(void)
 {
-	sysfs_remove_bin_file(&sdev->kobj, &tep_attr );
-	sysfs_remove_bin_file(&sdev->kobj, &table_attr );
-	kobject_unregister(&sdev->kobj);
+	sysfs_remove_bin_file(&smbios_subsys.kset.kobj, &tep_attr );
+	sysfs_remove_bin_file(&smbios_subsys.kset.kobj, &table_attr );
 }
 
-static int
-smbios_device_register(struct smbios_device *sdev)
+static void __init smbios_device_register(void)
 {
-	int error;
-
-	if (!sdev)
-		return 1;
-
-	kobject_set_name(&sdev->kobj, "smbios");
-	kobj_set_kset_s(sdev,smbios_subsys);
-	error = kobject_register(&sdev->kobj);
-	if (!error){
-		sysfs_create_bin_file(&sdev->kobj, &tep_attr );
-		sysfs_create_bin_file(&sdev->kobj, &table_attr );
-	}
-	return error;
+	sysfs_create_bin_file(&smbios_subsys.kset.kobj, &tep_attr );
+	sysfs_create_bin_file(&smbios_subsys.kset.kobj, &table_attr );
 }
 
 static int __init
@@ -247,10 +232,7 @@
 	if (rc)
 		return rc;
 
-	rc = smbios_device_register(&the_smbios_device);
-
-	if (rc)
-		firmware_unregister(&smbios_subsys);
+	smbios_device_register();
 
 	return rc;
 }
@@ -258,7 +240,7 @@
 static void __exit
 smbios_exit(void)
 {
-	smbios_device_unregister(&the_smbios_device);
+	smbios_device_unregister();
 	firmware_unregister(&smbios_subsys);
 }
 

