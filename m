Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbVFUCl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVFUCl5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVFUCka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:40:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:24292 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261687AbVFTW7n convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:43 -0400
Cc: gregkh@suse.de
Subject: [PATCH] class: convert drivers/block/* to use the new class api instead of class_simple
In-Reply-To: <11193083623136@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:22 -0700
Message-Id: <11193083621030@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] class: convert drivers/block/* to use the new class api instead of class_simple

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit deb3697037a7d362d13468a73643e09cbc1615a8
tree 1123942229b7edc193045300d1badb2018dc2bf0
parent 619e666b7e9d2b0545ab60a9c824ae5f77c20c3b
author gregkh@suse.de <gregkh@suse.de> Wed, 23 Mar 2005 09:52:10 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:07 -0700

 drivers/block/aoe/aoechr.c |   10 +++++-----
 drivers/block/paride/pg.c  |   14 +++++++-------
 drivers/block/paride/pt.c  |   20 ++++++++++----------
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/block/aoe/aoechr.c b/drivers/block/aoe/aoechr.c
--- a/drivers/block/aoe/aoechr.c
+++ b/drivers/block/aoe/aoechr.c
@@ -36,7 +36,7 @@ static int emsgs_head_idx, emsgs_tail_id
 static struct semaphore emsgs_sema;
 static spinlock_t emsgs_lock;
 static int nblocked_emsgs_readers;
-static struct class_simple *aoe_class;
+static struct class *aoe_class;
 static struct aoe_chardev chardevs[] = {
 	{ MINOR_ERR, "err" },
 	{ MINOR_DISCOVER, "discover" },
@@ -218,13 +218,13 @@ aoechr_init(void)
 	}
 	sema_init(&emsgs_sema, 0);
 	spin_lock_init(&emsgs_lock);
-	aoe_class = class_simple_create(THIS_MODULE, "aoe");
+	aoe_class = class_create(THIS_MODULE, "aoe");
 	if (IS_ERR(aoe_class)) {
 		unregister_chrdev(AOE_MAJOR, "aoechr");
 		return PTR_ERR(aoe_class);
 	}
 	for (i = 0; i < ARRAY_SIZE(chardevs); ++i)
-		class_simple_device_add(aoe_class,
+		class_device_create(aoe_class,
 					MKDEV(AOE_MAJOR, chardevs[i].minor),
 					NULL, chardevs[i].name);
 
@@ -237,8 +237,8 @@ aoechr_exit(void)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(chardevs); ++i)
-		class_simple_device_remove(MKDEV(AOE_MAJOR, chardevs[i].minor));
-	class_simple_destroy(aoe_class);
+		class_device_destroy(aoe_class, MKDEV(AOE_MAJOR, chardevs[i].minor));
+	class_destroy(aoe_class);
 	unregister_chrdev(AOE_MAJOR, "aoechr");
 }
 
diff --git a/drivers/block/paride/pg.c b/drivers/block/paride/pg.c
--- a/drivers/block/paride/pg.c
+++ b/drivers/block/paride/pg.c
@@ -222,7 +222,7 @@ static int pg_identify(struct pg *dev, i
 
 static char pg_scratch[512];	/* scratch block buffer */
 
-static struct class_simple *pg_class;
+static struct class *pg_class;
 
 /* kernel glue structures */
 
@@ -666,7 +666,7 @@ static int __init pg_init(void)
 		err = -1;
 		goto out;
 	}
-	pg_class = class_simple_create(THIS_MODULE, "pg");
+	pg_class = class_create(THIS_MODULE, "pg");
 	if (IS_ERR(pg_class)) {
 		err = PTR_ERR(pg_class);
 		goto out_chrdev;
@@ -675,7 +675,7 @@ static int __init pg_init(void)
 	for (unit = 0; unit < PG_UNITS; unit++) {
 		struct pg *dev = &devices[unit];
 		if (dev->present) {
-			class_simple_device_add(pg_class, MKDEV(major, unit), 
+			class_device_create(pg_class, MKDEV(major, unit),
 					NULL, "pg%u", unit);
 			err = devfs_mk_cdev(MKDEV(major, unit),
 				      S_IFCHR | S_IRUSR | S_IWUSR, "pg/%u",
@@ -688,8 +688,8 @@ static int __init pg_init(void)
 	goto out;
 
 out_class:
-	class_simple_device_remove(MKDEV(major, unit));
-	class_simple_destroy(pg_class);
+	class_device_destroy(pg_class, MKDEV(major, unit));
+	class_destroy(pg_class);
 out_chrdev:
 	unregister_chrdev(major, "pg");
 out:
@@ -703,11 +703,11 @@ static void __exit pg_exit(void)
 	for (unit = 0; unit < PG_UNITS; unit++) {
 		struct pg *dev = &devices[unit];
 		if (dev->present) {
-			class_simple_device_remove(MKDEV(major, unit));
+			class_device_destroy(pg_class, MKDEV(major, unit));
 			devfs_remove("pg/%u", unit);
 		}
 	}
-	class_simple_destroy(pg_class);
+	class_destroy(pg_class);
 	devfs_remove("pg");
 	unregister_chrdev(major, name);
 
diff --git a/drivers/block/paride/pt.c b/drivers/block/paride/pt.c
--- a/drivers/block/paride/pt.c
+++ b/drivers/block/paride/pt.c
@@ -242,7 +242,7 @@ static struct file_operations pt_fops = 
 };
 
 /* sysfs class support */
-static struct class_simple *pt_class;
+static struct class *pt_class;
 
 static inline int status_reg(struct pi_adapter *pi)
 {
@@ -963,7 +963,7 @@ static int __init pt_init(void)
 		err = -1;
 		goto out;
 	}
-	pt_class = class_simple_create(THIS_MODULE, "pt");
+	pt_class = class_create(THIS_MODULE, "pt");
 	if (IS_ERR(pt_class)) {
 		err = PTR_ERR(pt_class);
 		goto out_chrdev;
@@ -972,29 +972,29 @@ static int __init pt_init(void)
 	devfs_mk_dir("pt");
 	for (unit = 0; unit < PT_UNITS; unit++)
 		if (pt[unit].present) {
-			class_simple_device_add(pt_class, MKDEV(major, unit), 
+			class_device_create(pt_class, MKDEV(major, unit),
 					NULL, "pt%d", unit);
 			err = devfs_mk_cdev(MKDEV(major, unit),
 				      S_IFCHR | S_IRUSR | S_IWUSR,
 				      "pt/%d", unit);
 			if (err) {
-				class_simple_device_remove(MKDEV(major, unit));
+				class_device_destroy(pt_class, MKDEV(major, unit));
 				goto out_class;
 			}
-			class_simple_device_add(pt_class, MKDEV(major, unit + 128),
+			class_device_create(pt_class, MKDEV(major, unit + 128),
 					NULL, "pt%dn", unit);
 			err = devfs_mk_cdev(MKDEV(major, unit + 128),
 				      S_IFCHR | S_IRUSR | S_IWUSR,
 				      "pt/%dn", unit);
 			if (err) {
-				class_simple_device_remove(MKDEV(major, unit + 128));
+				class_device_destroy(pt_class, MKDEV(major, unit + 128));
 				goto out_class;
 			}
 		}
 	goto out;
 
 out_class:
-	class_simple_destroy(pt_class);
+	class_destroy(pt_class);
 out_chrdev:
 	unregister_chrdev(major, "pt");
 out:
@@ -1006,12 +1006,12 @@ static void __exit pt_exit(void)
 	int unit;
 	for (unit = 0; unit < PT_UNITS; unit++)
 		if (pt[unit].present) {
-			class_simple_device_remove(MKDEV(major, unit));
+			class_device_destroy(pt_class, MKDEV(major, unit));
 			devfs_remove("pt/%d", unit);
-			class_simple_device_remove(MKDEV(major, unit + 128));
+			class_device_destroy(pt_class, MKDEV(major, unit + 128));
 			devfs_remove("pt/%dn", unit);
 		}
-	class_simple_destroy(pt_class);
+	class_destroy(pt_class);
 	devfs_remove("pt");
 	unregister_chrdev(major, name);
 	for (unit = 0; unit < PT_UNITS; unit++)

