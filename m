Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbTLIAw5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 19:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbTLIAw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 19:52:57 -0500
Received: from mail.kroah.org ([65.200.24.183]:19382 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262161AbTLIAwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 19:52:53 -0500
Date: Mon, 8 Dec 2003 16:51:36 -0800
From: Greg KH <greg@kroah.com>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sysfs support for vcs devices (was Re: State of devfs in 2.6?)
Message-ID: <20031209005136.GA31863@kroah.com>
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com> <pan.2003.12.08.23.04.07.111640@dungeon.inka.de> <20031208233428.GA31370@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031208233428.GA31370@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 08, 2003 at 03:34:28PM -0800, Greg KH wrote:
> On Tue, Dec 09, 2003 at 12:04:08AM +0100, Andreas Jellinghaus wrote:
> >  - 18 vcc/ devices
> 
> Hm, good catch.  I wonder why these aren't getting picked up in
> /sys/class/tty as they are tty devices.  I thought they used to be
> there...

Ah, they really aren't tty devices, they are char devices.  That's why
they never have showed up.

Anyway, here's a patch against 2.6.0-test11 that adds sysfs support for
all of the vcs devices.  Now udev has support for them :)

thanks for pointing these out,

greg k-h

# add /sys/class/vc support for the vcs devices.

diff -Nru a/drivers/char/vc_screen.c b/drivers/char/vc_screen.c
--- a/drivers/char/vc_screen.c	Mon Dec  8 16:49:54 2003
+++ b/drivers/char/vc_screen.c	Mon Dec  8 16:49:54 2003
@@ -36,6 +36,7 @@
 #include <linux/kbd_kern.h>
 #include <linux/console.h>
 #include <linux/smp_lock.h>
+#include <linux/device.h>
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
@@ -469,6 +470,85 @@
 	.open		= vcs_open,
 };
 
+/* vc class implementation */
+
+struct vc_dev {
+	struct list_head node;
+	dev_t dev;
+	struct class_device class_dev;
+};
+#define to_vc_dev(d) container_of(d, struct vc_dev, class_dev)
+
+static LIST_HEAD(vc_dev_list);
+static spinlock_t vc_dev_list_lock = SPIN_LOCK_UNLOCKED;
+
+static void release_vc_dev(struct class_device *class_dev)
+{
+	struct vc_dev *vc_dev = to_vc_dev(class_dev);
+	kfree(vc_dev);
+}
+
+static struct class vc_class = {
+	.name		= "vc",
+	.release	= &release_vc_dev,
+};
+
+static ssize_t show_dev(struct class_device *class_dev, char *buf)
+{
+	struct vc_dev *vc_dev = to_vc_dev(class_dev);
+	return print_dev_t(buf, vc_dev->dev);
+}
+static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
+
+static int vc_add_class_device(dev_t dev, char *name, int minor)
+{
+	struct vc_dev *vc_dev = NULL;
+	int retval;
+
+	vc_dev = kmalloc(sizeof(*vc_dev), GFP_KERNEL);
+	if (!vc_dev)
+		return -ENOMEM;
+	memset(vc_dev, 0x00, sizeof(*vc_dev));
+
+	vc_dev->dev = dev;
+	vc_dev->class_dev.class = &vc_class;
+	snprintf(vc_dev->class_dev.class_id, BUS_ID_SIZE, name, minor);
+	retval = class_device_register(&vc_dev->class_dev);
+	if (retval)
+		goto error;
+	class_device_create_file(&vc_dev->class_dev, &class_device_attr_dev);
+	spin_lock(&vc_dev_list_lock);
+	list_add(&vc_dev->node, &vc_dev_list);
+	spin_unlock(&vc_dev_list_lock);
+	return 0;
+error:
+	kfree(vc_dev);
+	return retval;
+}
+
+static void vc_remove_class_device(int minor)
+{
+	struct vc_dev *vc_dev = NULL;
+	struct list_head *tmp;
+	int found = 0;
+
+	spin_lock(&vc_dev_list_lock);
+	list_for_each(tmp, &vc_dev_list) {
+		vc_dev = list_entry(tmp, struct vc_dev, node);
+		if (MINOR(vc_dev->dev) == minor) {
+			found = 1;
+			break;
+		}
+	}
+	if (found) {
+		list_del(&vc_dev->node);
+		spin_unlock(&vc_dev_list_lock);
+		class_device_unregister(&vc_dev->class_dev);
+	} else {
+		spin_unlock(&vc_dev_list_lock);
+	}
+}
+
 void vcs_make_devfs(struct tty_struct *tty)
 {
 	devfs_mk_cdev(MKDEV(VCS_MAJOR, tty->index + 1),
@@ -477,19 +557,26 @@
 	devfs_mk_cdev(MKDEV(VCS_MAJOR, tty->index + 129),
 			S_IFCHR|S_IRUSR|S_IWUSR,
 			"vcc/a%u", tty->index + 1);
+	vc_add_class_device(MKDEV(VCS_MAJOR, tty->index + 1), "vcs%u", tty->index + 1);
+	vc_add_class_device(MKDEV(VCS_MAJOR, tty->index + 129), "vcsa%u", tty->index + 1);
 }
 void vcs_remove_devfs(struct tty_struct *tty)
 {
 	devfs_remove("vcc/%u", tty->index + 1);
 	devfs_remove("vcc/a%u", tty->index + 1);
+	vc_remove_class_device(tty->index + 1);
+	vc_remove_class_device(tty->index + 129);
 }
 
 int __init vcs_init(void)
 {
 	if (register_chrdev(VCS_MAJOR, "vcs", &vcs_fops))
 		panic("unable to get major %d for vcs device", VCS_MAJOR);
+	class_register(&vc_class);
 
 	devfs_mk_cdev(MKDEV(VCS_MAJOR, 0), S_IFCHR|S_IRUSR|S_IWUSR, "vcc/0");
 	devfs_mk_cdev(MKDEV(VCS_MAJOR, 128), S_IFCHR|S_IRUSR|S_IWUSR, "vcc/a0");
+	vc_add_class_device(MKDEV(VCS_MAJOR, 0), "vcs", 0);
+	vc_add_class_device(MKDEV(VCS_MAJOR, 128), "vcsa", 128);
 	return 0;
 }
