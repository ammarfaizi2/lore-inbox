Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbVI3NVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbVI3NVk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 09:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbVI3NVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 09:21:40 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58861 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030291AbVI3NVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 09:21:40 -0400
Date: Fri, 30 Sep 2005 14:17:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: dwmw2@infradead.org, kernel list <linux-kernel@vger.kernel.org>,
       linux-mtd@lists.infradead.org
Subject: [patch] switch mtd to new driver model & cleanups
Message-ID: <20050930121741.GA5506@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Switch mtd to new power management.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit c608c935000f919426316a2f76084e31cab0171b
tree e5bbc83aac75f5916cf79f7e531530c9655e38c6
parent 81a2889a21eb2bfdf8b242f2cc2cc1d6ad424ea2
author <pavel@amd.(none)> Fri, 30 Sep 2005 00:19:32 +0200
committer <pavel@amd.(none)> Fri, 30 Sep 2005 00:19:32 +0200

 drivers/mtd/mtdcore.c |   68 ++++++++++++++++++++++++++++++++-----------------
 1 files changed, 44 insertions(+), 24 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -19,6 +19,7 @@
 #include <linux/ioctl.h>
 #include <linux/init.h>
 #include <linux/mtd/compatmac.h>
+#include <linux/sysdev.h>
 #ifdef CONFIG_PROC_FS
 #include <linux/proc_fs.h>
 #endif
@@ -80,6 +81,7 @@ int add_mtd_device(struct mtd_info *mtd)
 	return 1;
 }
 
+
 /**
  *	del_mtd_device - unregister an MTD device
  *	@mtd: pointer to MTD device info structure
@@ -303,30 +305,59 @@ EXPORT_SYMBOL(default_mtd_readv);
 
 #include <linux/pm.h>
 
-static struct pm_dev *mtd_pm_dev = NULL;
+static int mtd_resume(struct sys_device *dev)
+{
+	int ret = 0, i;
 
-static int mtd_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data)
+	if (down_trylock(&mtd_table_mutex))
+		return -EAGAIN;
+
+	for (i = MAX_MTD_DEVICES-1; i >= 0; i--) {
+		if (mtd_table[i] && mtd_table[i]->resume)
+			mtd_table[i]->resume(mtd_table[i]);
+	}
+
+	up(&mtd_table_mutex);
+	return ret;
+}
+
+static int mtd_suspend(struct sys_device *dev, pm_message_t state)
 {
 	int ret = 0, i;
 
 	if (down_trylock(&mtd_table_mutex))
 		return -EAGAIN;
-	if (rqst == PM_SUSPEND) {
-		for (i = 0; ret == 0 && i < MAX_MTD_DEVICES; i++) {
-			if (mtd_table[i] && mtd_table[i]->suspend)
-				ret = mtd_table[i]->suspend(mtd_table[i]);
-		}
-	} else i = MAX_MTD_DEVICES-1;
 
-	if (rqst == PM_RESUME || ret) {
-		for ( ; i >= 0; i--) {
-			if (mtd_table[i] && mtd_table[i]->resume)
-				mtd_table[i]->resume(mtd_table[i]);
-		}
+	for (i = 0; ret == 0 && i < MAX_MTD_DEVICES; i++) {
+		if (mtd_table[i] && mtd_table[i]->suspend)
+			ret = mtd_table[i]->suspend(mtd_table[i]);
 	}
+
 	up(&mtd_table_mutex);
 	return ret;
 }
+
+static struct sysdev_class mtd_sysdev_class = {
+	set_kset_name("mtd"),
+	.suspend = mtd_suspend,
+	.resume = mtd_resume,
+};
+
+static struct sys_device device_mtd = {
+	.id	= 0,
+	.cls	= &mtd_sysdev_class,
+};
+
+static int __init mtd_init_sysfs(void)
+{
+	int error = sysdev_class_register(&mtd_sysdev_class);
+	if (!error)
+		error = sysdev_register(&device_mtd);
+	return error;
+}
+
+device_initcall(mtd_init_sysfs);
+
 #endif
 
 /*====================================================================*/
@@ -388,22 +419,11 @@ static int __init init_mtd(void)
 	if ((proc_mtd = create_proc_entry( "mtd", 0, NULL )))
 		proc_mtd->read_proc = mtd_read_proc;
 #endif
-
-#ifdef CONFIG_PM
-	mtd_pm_dev = pm_register(PM_UNKNOWN_DEV, 0, mtd_pm_callback);
-#endif
 	return 0;
 }
 
 static void __exit cleanup_mtd(void)
 {
-#ifdef CONFIG_PM
-	if (mtd_pm_dev) {
-		pm_unregister(mtd_pm_dev);
-		mtd_pm_dev = NULL;
-	}
-#endif
-
 #ifdef CONFIG_PROC_FS
         if (proc_mtd)
 		remove_proc_entry( "mtd", NULL);



!-------------------------------------------------------------flip-


Kill useless ifdefs from mtd.

---
commit b6ee6a389e7679a4f81e61a4c1ce84232df1a6f5
tree b71d9dbd8d035ef167134b88e67ed1d662b43146
parent c608c935000f919426316a2f76084e31cab0171b
author <pavel@amd.(none)> Fri, 30 Sep 2005 00:20:52 +0200
committer <pavel@amd.(none)> Fri, 30 Sep 2005 00:20:52 +0200

 drivers/mtd/mtdcore.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -20,9 +20,7 @@
 #include <linux/init.h>
 #include <linux/mtd/compatmac.h>
 #include <linux/sysdev.h>
-#ifdef CONFIG_PROC_FS
 #include <linux/proc_fs.h>
-#endif
 
 #include <linux/mtd/mtd.h>
 
@@ -415,19 +413,15 @@ done:
 
 static int __init init_mtd(void)
 {
-#ifdef CONFIG_PROC_FS
 	if ((proc_mtd = create_proc_entry( "mtd", 0, NULL )))
 		proc_mtd->read_proc = mtd_read_proc;
-#endif
 	return 0;
 }
 
 static void __exit cleanup_mtd(void)
 {
-#ifdef CONFIG_PROC_FS
         if (proc_mtd)
 		remove_proc_entry( "mtd", NULL);
-#endif
 }
 
 module_init(init_mtd);



!-------------------------------------------------------------flip-



-- 
if you have sharp zaurus hardware you don't need... you know my address
