Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWGLDxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWGLDxi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 23:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbWGLDxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 23:53:38 -0400
Received: from xenotime.net ([66.160.160.81]:15590 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932392AbWGLDwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 23:52:03 -0400
Date: Tue, 11 Jul 2006 20:53:22 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>, scsi <linux-scsi@vger.kernel.org>
Cc: jejb <james.bottomley@steeleye.com>, akpm <akpm@osdl.org>,
       dgilbert@interlog.com
Subject: [PATCH -mm] scsi_debug: must_check fixes
Message-Id: <20060711205322.4f258729.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Check all __must_check warnings in scsi_debug.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/scsi/scsi_debug.c |   72 ++++++++++++++++++++++++++++++++++------------
 1 files changed, 54 insertions(+), 18 deletions(-)

--- linux-2618-rc1mm1.orig/drivers/scsi/scsi_debug.c
+++ linux-2618-rc1mm1/drivers/scsi/scsi_debug.c
@@ -286,7 +286,7 @@ static int inquiry_evpd_83(unsigned char
 			   int dev_id_num, const char * dev_id_str,
 			   int dev_id_str_len);
 static int inquiry_evpd_88(unsigned char * arr, int target_dev_id);
-static void do_create_driverfs_files(void);
+static int do_create_driverfs_files(void);
 static void do_remove_driverfs_files(void);
 
 static int sdebug_add_adapter(void);
@@ -2487,19 +2487,22 @@ static ssize_t sdebug_add_host_store(str
 DRIVER_ATTR(add_host, S_IRUGO | S_IWUSR, sdebug_add_host_show, 
 	    sdebug_add_host_store);
 
-static void do_create_driverfs_files(void)
+static int do_create_driverfs_files(void)
 {
-	driver_create_file(&sdebug_driverfs_driver, &driver_attr_add_host);
-	driver_create_file(&sdebug_driverfs_driver, &driver_attr_delay);
-	driver_create_file(&sdebug_driverfs_driver, &driver_attr_dev_size_mb);
-	driver_create_file(&sdebug_driverfs_driver, &driver_attr_dsense);
-	driver_create_file(&sdebug_driverfs_driver, &driver_attr_every_nth);
-	driver_create_file(&sdebug_driverfs_driver, &driver_attr_max_luns);
-	driver_create_file(&sdebug_driverfs_driver, &driver_attr_num_tgts);
-	driver_create_file(&sdebug_driverfs_driver, &driver_attr_num_parts);
-	driver_create_file(&sdebug_driverfs_driver, &driver_attr_ptype);
-	driver_create_file(&sdebug_driverfs_driver, &driver_attr_opts);
-	driver_create_file(&sdebug_driverfs_driver, &driver_attr_scsi_level);
+	int ret;
+
+	ret = driver_create_file(&sdebug_driverfs_driver, &driver_attr_add_host);
+	ret |= driver_create_file(&sdebug_driverfs_driver, &driver_attr_delay);
+	ret |= driver_create_file(&sdebug_driverfs_driver, &driver_attr_dev_size_mb);
+	ret |= driver_create_file(&sdebug_driverfs_driver, &driver_attr_dsense);
+	ret |= driver_create_file(&sdebug_driverfs_driver, &driver_attr_every_nth);
+	ret |= driver_create_file(&sdebug_driverfs_driver, &driver_attr_max_luns);
+	ret |= driver_create_file(&sdebug_driverfs_driver, &driver_attr_num_tgts);
+	ret |= driver_create_file(&sdebug_driverfs_driver, &driver_attr_num_parts);
+	ret |= driver_create_file(&sdebug_driverfs_driver, &driver_attr_ptype);
+	ret |= driver_create_file(&sdebug_driverfs_driver, &driver_attr_opts);
+	ret |= driver_create_file(&sdebug_driverfs_driver, &driver_attr_scsi_level);
+	return ret;
 }
 
 static void do_remove_driverfs_files(void)
@@ -2522,6 +2525,7 @@ static int __init scsi_debug_init(void)
 	unsigned int sz;
 	int host_to_add;
 	int k;
+	int ret;
 
 	if (scsi_debug_dev_size_mb < 1)
 		scsi_debug_dev_size_mb = 1;  /* force minimum 1 MB ramdisk */
@@ -2560,12 +2564,32 @@ static int __init scsi_debug_init(void)
 	if (scsi_debug_num_parts > 0)
 		sdebug_build_parts(fake_storep);
 
-	init_all_queued();
+	ret = device_register(&pseudo_primary);
+	if (ret < 0) {
+		printk(KERN_WARNING "scsi_debug: device_register error: %d\n",
+			ret);
+		goto free_vm;
+	}
+	ret = bus_register(&pseudo_lld_bus);
+	if (ret < 0) {
+		printk(KERN_WARNING "scsi_debug: bus_register error: %d\n",
+			ret);
+		goto dev_unreg;
+	}
+	ret = driver_register(&sdebug_driverfs_driver);
+	if (ret < 0) {
+		printk(KERN_WARNING "scsi_debug: driver_register error: %d\n",
+			ret);
+		goto bus_unreg;
+	}
+	ret = do_create_driverfs_files();
+	if (ret < 0) {
+		printk(KERN_WARNING "scsi_debug: driver_create_file error: %d\n",
+			ret);
+		goto del_files;
+	}
 
-	device_register(&pseudo_primary);
-	bus_register(&pseudo_lld_bus);
-	driver_register(&sdebug_driverfs_driver);
-	do_create_driverfs_files();
+	init_all_queued();
 
 	sdebug_driver_template.proc_name = (char *)sdebug_proc_name;
 
@@ -2585,6 +2609,18 @@ static int __init scsi_debug_init(void)
 		       scsi_debug_add_host);
 	}
 	return 0;
+
+del_files:
+	do_remove_driverfs_files();
+	driver_unregister(&sdebug_driverfs_driver);
+bus_unreg:
+	bus_unregister(&pseudo_lld_bus);
+dev_unreg:
+	device_unregister(&pseudo_primary);
+free_vm:
+	vfree(fake_storep);
+
+	return ret;
 }
 
 static void __exit scsi_debug_exit(void)


---
