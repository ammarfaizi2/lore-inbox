Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162284AbWLAXYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162284AbWLAXYJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162277AbWLAXX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:23:56 -0500
Received: from ns2.suse.de ([195.135.220.15]:26861 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1162241AbWLAXW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:22:58 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 13/36] Driver core: convert tty core to use struct device
Date: Fri,  1 Dec 2006 15:21:43 -0800
Message-Id: <1165015366759-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11650153631070-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com> <11650153362310-git-send-email-greg@kroah.com> <11650153392022-git-send-email-greg@kroah.com> <11650153432284-git-send-email-greg@kroah.com> <11650153463092-git-send-email-greg@kroah.com> <1165015349830-git-send-email-greg@kroah.com> <11650153522862-git-send-email-greg@kroah.com> <116501535622-git-send-email-greg@kroah.com> <11650153591876-git-send-email-greg@kroah.com> <11650153631070-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Converts from using struct "class_device" to "struct device" making
everything show up properly in /sys/devices/ with symlinks from the
/sys/class directory.

Also fixes up the isdn drivers that were putting something in the class
device's directory.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/char/tty_io.c            |   19 ++++++++++---------
 drivers/isdn/gigaset/common.c    |    2 +-
 drivers/isdn/gigaset/gigaset.h   |    2 +-
 drivers/isdn/gigaset/interface.c |   10 +++++-----
 drivers/isdn/gigaset/proc.c      |   19 ++++++++++---------
 include/linux/tty.h              |    5 ++---
 6 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index e90ea39..50dc492 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -3612,7 +3612,8 @@ static struct class *tty_class;
  *		This field is optional, if there is no known struct device
  *		for this tty device it can be set to NULL safely.
  *
- *	Returns a pointer to the class device (or ERR_PTR(-EFOO) on error).
+ *	Returns a pointer to the struct device for this tty device
+ *	(or ERR_PTR(-EFOO) on error).
  *
  *	This call is required to be made to register an individual tty device
  *	if the tty driver's flags have the TTY_DRIVER_DYNAMIC_DEV bit set.  If
@@ -3622,8 +3623,8 @@ static struct class *tty_class;
  *	Locking: ??
  */
 
-struct class_device *tty_register_device(struct tty_driver *driver,
-					 unsigned index, struct device *device)
+struct device *tty_register_device(struct tty_driver *driver, unsigned index,
+				   struct device *device)
 {
 	char name[64];
 	dev_t dev = MKDEV(driver->major, driver->minor_start) + index;
@@ -3639,7 +3640,7 @@ struct class_device *tty_register_device
 	else
 		tty_line_name(driver, index, name);
 
-	return class_device_create(tty_class, NULL, dev, device, "%s", name);
+	return device_create(tty_class, device, dev, name);
 }
 
 /**
@@ -3655,7 +3656,7 @@ struct class_device *tty_register_device
 
 void tty_unregister_device(struct tty_driver *driver, unsigned index)
 {
-	class_device_destroy(tty_class, MKDEV(driver->major, driver->minor_start) + index);
+	device_destroy(tty_class, MKDEV(driver->major, driver->minor_start) + index);
 }
 
 EXPORT_SYMBOL(tty_register_device);
@@ -3895,20 +3896,20 @@ static int __init tty_init(void)
 	if (cdev_add(&tty_cdev, MKDEV(TTYAUX_MAJOR, 0), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 0), 1, "/dev/tty") < 0)
 		panic("Couldn't register /dev/tty driver\n");
-	class_device_create(tty_class, NULL, MKDEV(TTYAUX_MAJOR, 0), NULL, "tty");
+	device_create(tty_class, NULL, MKDEV(TTYAUX_MAJOR, 0), "tty");
 
 	cdev_init(&console_cdev, &console_fops);
 	if (cdev_add(&console_cdev, MKDEV(TTYAUX_MAJOR, 1), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 1), 1, "/dev/console") < 0)
 		panic("Couldn't register /dev/console driver\n");
-	class_device_create(tty_class, NULL, MKDEV(TTYAUX_MAJOR, 1), NULL, "console");
+	device_create(tty_class, NULL, MKDEV(TTYAUX_MAJOR, 1), "console");
 
 #ifdef CONFIG_UNIX98_PTYS
 	cdev_init(&ptmx_cdev, &ptmx_fops);
 	if (cdev_add(&ptmx_cdev, MKDEV(TTYAUX_MAJOR, 2), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 2), 1, "/dev/ptmx") < 0)
 		panic("Couldn't register /dev/ptmx driver\n");
-	class_device_create(tty_class, NULL, MKDEV(TTYAUX_MAJOR, 2), NULL, "ptmx");
+	device_create(tty_class, NULL, MKDEV(TTYAUX_MAJOR, 2), "ptmx");
 #endif
 
 #ifdef CONFIG_VT
@@ -3916,7 +3917,7 @@ static int __init tty_init(void)
 	if (cdev_add(&vc0_cdev, MKDEV(TTY_MAJOR, 0), 1) ||
 	    register_chrdev_region(MKDEV(TTY_MAJOR, 0), 1, "/dev/vc/0") < 0)
 		panic("Couldn't register /dev/tty0 driver\n");
-	class_device_create(tty_class, NULL, MKDEV(TTY_MAJOR, 0), NULL, "tty0");
+	device_create(tty_class, NULL, MKDEV(TTY_MAJOR, 0), "tty0");
 
 	vty_init();
 #endif
diff --git a/drivers/isdn/gigaset/common.c b/drivers/isdn/gigaset/common.c
index 5800bee..defd574 100644
--- a/drivers/isdn/gigaset/common.c
+++ b/drivers/isdn/gigaset/common.c
@@ -702,7 +702,7 @@ struct cardstate *gigaset_initcs(struct
 	cs->open_count = 0;
 	cs->dev = NULL;
 	cs->tty = NULL;
-	cs->class = NULL;
+	cs->tty_dev = NULL;
 	cs->cidmode = cidmode != 0;
 
 	//if(onechannel) { //FIXME
diff --git a/drivers/isdn/gigaset/gigaset.h b/drivers/isdn/gigaset/gigaset.h
index 884bd72..06298cc 100644
--- a/drivers/isdn/gigaset/gigaset.h
+++ b/drivers/isdn/gigaset/gigaset.h
@@ -444,7 +444,7 @@ struct cardstate {
 	struct gigaset_driver *driver;
 	unsigned minor_index;
 	struct device *dev;
-	struct class_device *class;
+	struct device *tty_dev;
 
 	const struct gigaset_ops *ops;
 
diff --git a/drivers/isdn/gigaset/interface.c b/drivers/isdn/gigaset/interface.c
index 596f3ae..7edea01 100644
--- a/drivers/isdn/gigaset/interface.c
+++ b/drivers/isdn/gigaset/interface.c
@@ -625,13 +625,13 @@ void gigaset_if_init(struct cardstate *c
 		return;
 
 	tasklet_init(&cs->if_wake_tasklet, &if_wake, (unsigned long) cs);
-	cs->class = tty_register_device(drv->tty, cs->minor_index, NULL);
+	cs->tty_dev = tty_register_device(drv->tty, cs->minor_index, NULL);
 
-	if (!IS_ERR(cs->class))
-		class_set_devdata(cs->class, cs);
+	if (!IS_ERR(cs->tty_dev))
+		dev_set_drvdata(cs->tty_dev, cs);
 	else {
 		warn("could not register device to the tty subsystem");
-		cs->class = NULL;
+		cs->tty_dev = NULL;
 	}
 }
 
@@ -645,7 +645,7 @@ void gigaset_if_free(struct cardstate *c
 
 	tasklet_disable(&cs->if_wake_tasklet);
 	tasklet_kill(&cs->if_wake_tasklet);
-	cs->class = NULL;
+	cs->tty_dev = NULL;
 	tty_unregister_device(drv->tty, cs->minor_index);
 }
 
diff --git a/drivers/isdn/gigaset/proc.c b/drivers/isdn/gigaset/proc.c
index 9ad840e..e767afa 100644
--- a/drivers/isdn/gigaset/proc.c
+++ b/drivers/isdn/gigaset/proc.c
@@ -16,11 +16,12 @@
 #include "gigaset.h"
 #include <linux/ctype.h>
 
-static ssize_t show_cidmode(struct class_device *class, char *buf)
+static ssize_t show_cidmode(struct device *dev,
+			    struct device_attribute *attr, char *buf)
 {
 	int ret;
 	unsigned long flags;
-	struct cardstate *cs = class_get_devdata(class);
+	struct cardstate *cs = dev_get_drvdata(dev);
 
 	spin_lock_irqsave(&cs->lock, flags);
 	ret = sprintf(buf, "%u\n", cs->cidmode);
@@ -29,10 +30,10 @@ static ssize_t show_cidmode(struct class
 	return ret;
 }
 
-static ssize_t set_cidmode(struct class_device *class,
+static ssize_t set_cidmode(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
-	struct cardstate *cs = class_get_devdata(class);
+	struct cardstate *cs = dev_get_drvdata(dev);
 	long int value;
 	char *end;
 
@@ -64,25 +65,25 @@ static ssize_t set_cidmode(struct class_
 	return count;
 }
 
-static CLASS_DEVICE_ATTR(cidmode, S_IRUGO|S_IWUSR, show_cidmode, set_cidmode);
+static DEVICE_ATTR(cidmode, S_IRUGO|S_IWUSR, show_cidmode, set_cidmode);
 
 /* free sysfs for device */
 void gigaset_free_dev_sysfs(struct cardstate *cs)
 {
-	if (!cs->class)
+	if (!cs->tty_dev)
 		return;
 
 	gig_dbg(DEBUG_INIT, "removing sysfs entries");
-	class_device_remove_file(cs->class, &class_device_attr_cidmode);
+	device_remove_file(cs->tty_dev, &dev_attr_cidmode);
 }
 
 /* initialize sysfs for device */
 void gigaset_init_dev_sysfs(struct cardstate *cs)
 {
-	if (!cs->class)
+	if (!cs->tty_dev)
 		return;
 
 	gig_dbg(DEBUG_INIT, "setting up sysfs");
-	if (class_device_create_file(cs->class, &class_device_attr_cidmode))
+	if (device_create_file(cs->tty_dev, &dev_attr_cidmode))
 		dev_err(cs->dev, "could not create sysfs attribute\n");
 }
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 44091c0..65321f9 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -276,9 +276,8 @@ extern int tty_register_ldisc(int disc,
 extern int tty_unregister_ldisc(int disc);
 extern int tty_register_driver(struct tty_driver *driver);
 extern int tty_unregister_driver(struct tty_driver *driver);
-extern struct class_device *tty_register_device(struct tty_driver *driver,
-						unsigned index,
-						struct device *dev);
+extern struct device *tty_register_device(struct tty_driver *driver,
+					  unsigned index, struct device *dev);
 extern void tty_unregister_device(struct tty_driver *driver, unsigned index);
 extern int tty_read_raw_data(struct tty_struct *tty, unsigned char *bufp,
 			     int buflen);
-- 
1.4.4.1

