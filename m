Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbUCPBOm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262935AbUCPADI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:03:08 -0500
Received: from mail.kroah.org ([65.200.24.183]:687 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262870AbUCPABv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:01:51 -0500
Subject: Re: [PATCH] Driver Core update for 2.6.4
In-Reply-To: <1079395148429@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 15:59:09 -0800
Message-Id: <10793951492163@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.84.12, 2004/03/12 15:20:28-08:00, corbet@lwn.net

[PATCH] cdev 1/2: Eliminate /sys/cdev

This is the first of two patches designed to make life easier for authors
of device driver books - and, with luck, driver authors too.

/sys/cdev is, according to Al, a mistake which was never really meant to
exist.  I believe nothing uses it currently - there isn't a whole lot there
to use.  Its existence takes up system resources, and also requires drivers
to deal with the cdev's embedded kobject in their failure paths.  The
following patch (against 2.6.4) makes it all go away.

OK, almost all.  We have to keep (but not register) cdev_subsys because
it's rwsem is needed to control access to cdev_map.


 drivers/char/tty_io.c |   10 +++-------
 fs/char_dev.c         |   26 ++++++++------------------
 2 files changed, 11 insertions(+), 25 deletions(-)


diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Mon Mar 15 15:28:42 2004
+++ b/drivers/char/tty_io.c	Mon Mar 15 15:28:42 2004
@@ -2175,8 +2175,6 @@
 EXPORT_SYMBOL(tty_register_device);
 EXPORT_SYMBOL(tty_unregister_device);
 
-static struct kobject tty_kobj = {.name = "tty"};
-
 struct tty_driver *alloc_tty_driver(int lines)
 {
 	struct tty_driver *driver;
@@ -2276,7 +2274,6 @@
 		driver->termios_locked = NULL;
 	}
 
-	driver->cdev.kobj.parent = &tty_kobj;
 	strcpy(driver->cdev.kobj.name, driver->name);
 	for (s = strchr(driver->cdev.kobj.name, '/'); s; s = strchr(s, '/'))
 		*s = '!';
@@ -2400,7 +2397,9 @@
 }
 
 postcore_initcall(tty_class_init);
- 
+
+/* 3/2004 jmc: why do these devices exist? */
+
 static struct cdev tty_cdev, console_cdev;
 #ifdef CONFIG_UNIX98_PTYS
 static struct cdev ptmx_cdev;
@@ -2430,9 +2429,6 @@
 		panic("Couldn't register /dev/console driver\n");
 	devfs_mk_cdev(MKDEV(TTYAUX_MAJOR, 1), S_IFCHR|S_IRUSR|S_IWUSR, "console");
 	class_simple_device_add(tty_class, MKDEV(TTYAUX_MAJOR, 1), NULL, "console");
-
-	tty_kobj.kset = tty_cdev.kobj.kset;
-	kobject_register(&tty_kobj);
 
 #ifdef CONFIG_UNIX98_PTYS
 	strcpy(ptmx_cdev.kobj.name, "dev.ptmx");
diff -Nru a/fs/char_dev.c b/fs/char_dev.c
--- a/fs/char_dev.c	Mon Mar 15 15:28:42 2004
+++ b/fs/char_dev.c	Mon Mar 15 15:28:42 2004
@@ -340,15 +340,9 @@
 
 int cdev_add(struct cdev *p, dev_t dev, unsigned count)
 {
-	int err = kobject_add(&p->kobj);
-	if (err)
-		return err;
-	err = kobj_map(cdev_map, dev, count, NULL, exact_match, exact_lock, p);
-	if (err)
-		kobject_del(&p->kobj);
 	p->dev = dev;
 	p->count = count;
-	return err;
+	return kobj_map(cdev_map, dev, count, NULL, exact_match, exact_lock, p);
 }
 
 static void cdev_unmap(dev_t dev, unsigned count)
@@ -359,7 +353,6 @@
 void cdev_del(struct cdev *p)
 {
 	cdev_unmap(p->dev, p->count);
-	kobject_del(&p->kobj);
 	kobject_put(&p->kobj);
 }
 
@@ -407,18 +400,12 @@
 	.release	= cdev_dynamic_release,
 };
 
-static struct kset kset_dynamic = {
-	.subsys = &cdev_subsys,
-	.kobj = {.name = "major",},
-	.ktype = &ktype_cdev_dynamic,
-};
-
 struct cdev *cdev_alloc(void)
 {
 	struct cdev *p = kmalloc(sizeof(struct cdev), GFP_KERNEL);
 	if (p) {
 		memset(p, 0, sizeof(struct cdev));
-		p->kobj.kset = &kset_dynamic;
+		p->kobj.ktype = &ktype_cdev_dynamic;
 		INIT_LIST_HEAD(&p->list);
 		kobject_init(&p->kobj);
 	}
@@ -428,7 +415,6 @@
 void cdev_init(struct cdev *cdev, struct file_operations *fops)
 {
 	INIT_LIST_HEAD(&cdev->list);
-	kobj_set_kset_s(cdev, cdev_subsys);
 	cdev->kobj.ktype = &ktype_cdev_default;
 	kobject_init(&cdev->kobj);
 	cdev->ops = fops;
@@ -444,8 +430,12 @@
 
 void __init chrdev_init(void)
 {
-	subsystem_register(&cdev_subsys);
-	kset_register(&kset_dynamic);
+/*
+ * Keep cdev_subsys around because (and only because) the kobj_map code
+ * depends on the rwsem it contains.  We don't make it public in sysfs,
+ * however.
+ */
+	subsystem_init(&cdev_subsys);
 	cdev_map = kobj_map_init(base_probe, &cdev_subsys);
 }
 

