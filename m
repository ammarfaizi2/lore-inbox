Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbUCLSdm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 13:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbUCLSdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 13:33:41 -0500
Received: from vena.lwn.net ([206.168.112.25]:51160 "HELO lwn.net")
	by vger.kernel.org with SMTP id S262388AbUCLSc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 13:32:58 -0500
Message-ID: <20040312183256.1331.qmail@lwn.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] cdev 1/2: Eliminate /sys/cdev
cc: viro@parcelfarce.linux.theplanet.co.uk, greg@kroah.com
From: Jonathan Corbet <corbet@lwn.net>
Date: Fri, 12 Mar 2004 11:32:56 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first of two patches designed to make life easier for authors
of device driver books - and, with luck, driver authors too.

/sys/cdev is, according to Al, a mistake which was never really meant to
exist.  I believe nothing uses it currently - there isn't a whole lot there
to use.  Its existence takes up system resources, and also requires drivers
to deal with the cdev's embedded kobject in their failure paths.  The
following patch (against 2.6.4) makes it all go away.

OK, almost all.  We have to keep (but not register) cdev_subsys because
it's rwsem is needed to control access to cdev_map.

jon

diff -urNp -X dontdiff 2.6.4-vanilla/drivers/char/tty_io.c 2.6.4/drivers/char/tty_io.c
--- 2.6.4-vanilla/drivers/char/tty_io.c	2004-03-13 00:16:53.000000000 -0700
+++ 2.6.4/drivers/char/tty_io.c	2004-03-13 01:28:38.000000000 -0700
@@ -2195,8 +2195,6 @@ void tty_unregister_device(struct tty_dr
 EXPORT_SYMBOL(tty_register_device);
 EXPORT_SYMBOL(tty_unregister_device);
 
-static struct kobject tty_kobj = {.name = "tty"};
-
 struct tty_driver *alloc_tty_driver(int lines)
 {
 	struct tty_driver *driver;
@@ -2296,7 +2294,6 @@ int tty_register_driver(struct tty_drive
 		driver->termios_locked = NULL;
 	}
 
-	driver->cdev.kobj.parent = &tty_kobj;
 	strcpy(driver->cdev.kobj.name, driver->name);
 	for (s = strchr(driver->cdev.kobj.name, '/'); s; s = strchr(s, '/'))
 		*s = '!';
@@ -2420,7 +2417,9 @@ static int __init tty_class_init(void)
 }
 
 postcore_initcall(tty_class_init);
- 
+
+/* 3/2004 jmc: why do these devices exist? */
+
 static struct cdev tty_cdev, console_cdev;
 #ifdef CONFIG_UNIX98_PTYS
 static struct cdev ptmx_cdev;
@@ -2451,9 +2450,6 @@ static int __init tty_init(void)
 	devfs_mk_cdev(MKDEV(TTYAUX_MAJOR, 1), S_IFCHR|S_IRUSR|S_IWUSR, "console");
 	class_simple_device_add(tty_class, MKDEV(TTYAUX_MAJOR, 1), NULL, "console");
 
-	tty_kobj.kset = tty_cdev.kobj.kset;
-	kobject_register(&tty_kobj);
-
 #ifdef CONFIG_UNIX98_PTYS
 	strcpy(ptmx_cdev.kobj.name, "dev.ptmx");
 	cdev_init(&ptmx_cdev, &tty_fops);
diff -urNp -X dontdiff 2.6.4-vanilla/fs/char_dev.c 2.6.4/fs/char_dev.c
--- 2.6.4-vanilla/fs/char_dev.c	2004-03-05 04:58:42.000000000 -0700
+++ 2.6.4/fs/char_dev.c	2004-03-13 01:04:26.000000000 -0700
@@ -340,15 +340,9 @@ static int exact_lock(dev_t dev, void *d
 
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
@@ -359,7 +353,6 @@ static void cdev_unmap(dev_t dev, unsign
 void cdev_del(struct cdev *p)
 {
 	cdev_unmap(p->dev, p->count);
-	kobject_del(&p->kobj);
 	kobject_put(&p->kobj);
 }
 
@@ -407,18 +400,12 @@ static struct kobj_type ktype_cdev_dynam
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
@@ -428,7 +415,6 @@ struct cdev *cdev_alloc(void)
 void cdev_init(struct cdev *cdev, struct file_operations *fops)
 {
 	INIT_LIST_HEAD(&cdev->list);
-	kobj_set_kset_s(cdev, cdev_subsys);
 	cdev->kobj.ktype = &ktype_cdev_default;
 	kobject_init(&cdev->kobj);
 	cdev->ops = fops;
@@ -444,8 +430,12 @@ static struct kobject *base_probe(dev_t 
 
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
 
