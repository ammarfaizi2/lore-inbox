Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbTD3R1N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 13:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbTD3R1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 13:27:13 -0400
Received: from verein.lst.de ([212.34.181.86]:11022 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S262235AbTD3R1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 13:27:02 -0400
Date: Wed, 30 Apr 2003 19:39:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] replacing devfs_register()
Message-ID: <20030430193920.A5582@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The worst offender still left in the devfs API is devfs_register, it's
prototype is:

	 devfs_handle_t devfs_register(devfs_handle_t dir,
		const char *name, unsigned int flags,
		unsigned int major, unsigned int minor,
		umode_t mode, void *ops, void *info)

Of these:

 - dir and flags are always zero
 - the return value is never used
 - info is only used in one driver which doesn't even need it for
   operation
 - umode_t always describes a character device
 - name very often comes from a stack buffer we sprintf'ed into

so obviously we really want a much simpler API instead.  My first draft
for this was:

	int devfs_mk_cdev(dev_t dev, umode_t mode,
		struct file_operations *fops, void *info,
		const char *fmt, ...)

this removes the unused argumens, switches to a proper dev_t for the
device number and allows to directly use a printf-like expression as
name, getting rid of the temporary buffers.

Now Al has reappeared and put the first steps of his CIDR for charater
device on public ftp and we'll soon have a similar lookup object +
fops mechanism in generic code as we already habe for blockdevices, i.e.
the devfs code to assign fops from an entry will become superflous as
generic code already does it.  That means the fops and info arguments
are obsolete before they were introduced, so I've come up with the
following API instead:

	int devfs_mk_cdev(dev_t dev, umode_t mode, const char *fmt, ...)

which is much nicer anyway. 

First patch introduces the API and converts drivers/input over to it.



--- 1.23/drivers/input/evdev.c	Sun Apr 20 19:21:18 2003
+++ edited/drivers/input/evdev.c	Tue Apr 29 13:03:51 2003
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/input.h>
+#include <linux/major.h>
 #include <linux/smp_lock.h>
 #include <linux/device.h>
 #include <linux/devfs_fs_kernel.h>
@@ -400,7 +401,9 @@
 	sprintf(evdev->name, "event%d", minor);
 
 	evdev_table[minor] = evdev;
-	input_register_minor("input/event%d", minor, EVDEV_MINOR_BASE);
+
+	devfs_mk_cdev(MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
+			S_IFCHR|S_IRUGO|S_IWUSR, "input/event%d", minor);
 
 	return &evdev->handle;
 }
--- 1.29/drivers/input/input.c	Sun Apr 20 19:21:18 2003
+++ edited/drivers/input/input.c	Tue Apr 29 13:02:14 2003
@@ -16,6 +16,7 @@
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/random.h>
+#include <linux/major.h>
 #include <linux/pm.h>
 #include <linux/proc_fs.h>
 #include <linux/kmod.h>
@@ -32,7 +33,6 @@
 EXPORT_SYMBOL(input_unregister_device);
 EXPORT_SYMBOL(input_register_handler);
 EXPORT_SYMBOL(input_unregister_handler);
-EXPORT_SYMBOL(input_register_minor);
 EXPORT_SYMBOL(input_open_device);
 EXPORT_SYMBOL(input_close_device);
 EXPORT_SYMBOL(input_accept_process);
@@ -40,7 +40,6 @@
 EXPORT_SYMBOL(input_event);
 EXPORT_SYMBOL(input_devclass);
 
-#define INPUT_MAJOR	13
 #define INPUT_DEVICES	256
 
 static LIST_HEAD(input_dev_list);
@@ -540,15 +539,6 @@
 	.owner = THIS_MODULE,
 	.open = input_open_file,
 };
-
-void input_register_minor(char *name, int minor, int minor_base)
-{
-	char devfs_name[16];
-
-	sprintf(devfs_name, name, minor);
-	devfs_register(NULL, devfs_name, 0, INPUT_MAJOR, minor_base + minor,
-			S_IFCHR|S_IRUGO|S_IWUSR, &input_fops, NULL);
-}
 
 #ifdef CONFIG_PROC_FS
 
--- 1.16/drivers/input/joydev.c	Sun Apr 20 19:21:18 2003
+++ edited/drivers/input/joydev.c	Tue Apr 29 13:03:16 2003
@@ -445,7 +445,9 @@
 	}
 
 	joydev_table[minor] = joydev;
-	input_register_minor("js%d", minor, JOYDEV_MINOR_BASE);
+	
+	devfs_mk_cdev(MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
+			S_IFCHR|S_IRUGO|S_IWUSR, "js%d", minor);
 
 	return &joydev->handle;
 }
--- 1.23/drivers/input/mousedev.c	Sun Apr 20 19:21:18 2003
+++ edited/drivers/input/mousedev.c	Tue Apr 29 13:03:47 2003
@@ -432,7 +432,9 @@
 		input_open_device(&mousedev->handle);
 
 	mousedev_table[minor] = mousedev;
-	input_register_minor("input/mouse%d", minor, MOUSEDEV_MINOR_BASE);
+
+	devfs_mk_cdev(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
+			S_IFCHR|S_IRUGO|S_IWUSR, "input/mouse%d", minor);
 
 	return &mousedev->handle;
 }
@@ -512,7 +514,10 @@
 	mousedev_table[MOUSEDEV_MIX] = &mousedev_mix;
 	mousedev_mix.exist = 1;
 	mousedev_mix.minor = MOUSEDEV_MIX;
-	input_register_minor("input/mice", MOUSEDEV_MIX, MOUSEDEV_MINOR_BASE);
+
+	devfs_mk_cdev(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX),
+			S_IFCHR|S_IRUGO|S_IWUSR, "input/mice");
+
 
 #ifdef CONFIG_INPUT_MOUSEDEV_PSAUX
 	if (!(mousedev_mix.misc = !misc_register(&psaux_mouse)))
--- 1.9/drivers/input/tsdev.c	Sun Apr 20 19:21:18 2003
+++ edited/drivers/input/tsdev.c	Tue Apr 29 13:03:12 2003
@@ -36,6 +36,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/input.h>
+#include <linux/major.h>
 #include <linux/config.h>
 #include <linux/smp_lock.h>
 #include <linux/random.h>
@@ -329,8 +330,9 @@
 	tsdev->handle.private = tsdev;
 
 	tsdev_table[minor] = tsdev;
-	input_register_minor("input/ts%d", minor, TSDEV_MINOR_BASE);
-
+	
+	devfs_mk_cdev(MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor),
+			S_IFCHR|S_IRUGO|S_IWUSR, "input/ts%d", minor);
 
 	return &tsdev->handle;
 }
--- 1.87/fs/devfs/base.c	Sun Apr 20 19:54:18 2003
+++ edited/fs/devfs/base.c	Tue Apr 29 13:01:41 2003
@@ -1562,6 +1562,52 @@
 EXPORT_SYMBOL(devfs_mk_bdev);
 
 
+int devfs_mk_cdev(dev_t dev, umode_t mode, const char *fmt, ...)
+{
+	struct devfs_entry *dir = NULL, *de;
+	char buf[64];
+	va_list args;
+	int error, n;
+
+	if (!S_ISCHR(mode)) {
+		printk(KERN_WARNING "%s: invalide mode (%u) for %s\n",
+				__FUNCTION__, mode, buf);
+		return -EINVAL;
+	}
+
+	va_start(args, fmt);
+	n = vsnprintf(buf, 64, fmt, args);
+	if (n >= 64 || !buf[0]) {
+		printk(KERN_WARNING "%s: invalid format string\n",
+				__FUNCTION__);
+		return -EINVAL;
+	}
+
+	de = _devfs_prepare_leaf(&dir, buf, mode);
+	if (!de) {
+		printk(KERN_WARNING "%s: could not prepare leaf for %s\n",
+				__FUNCTION__, buf);
+		return -ENOMEM;		/* could be more accurate... */
+	}
+
+	de->u.cdev.dev = dev;
+
+	error = _devfs_append_entry(dir, de, NULL);
+	if (error) {
+		printk(KERN_WARNING "%s: could not append to parent for %s\n",
+				__FUNCTION__, buf);
+		goto out;
+	}
+
+	devfsd_notify(de, DEVFSD_NOTIFY_REGISTERED);
+ out:
+	devfs_put(dir);
+	return error;
+}
+
+EXPORT_SYMBOL(devfs_mk_cdev);
+
+
 /**
  *	_devfs_unhook - Unhook a device entry from its parents list
  *	@de: The entry to unhook.
--- 1.43/include/linux/devfs_fs_kernel.h	Sun Apr 20 19:53:06 2003
+++ edited/include/linux/devfs_fs_kernel.h	Tue Apr 29 14:12:48 2003
@@ -27,6 +27,8 @@
 				      umode_t mode, void *ops, void *info);
 extern int devfs_mk_bdev(dev_t dev, umode_t mode, const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
+extern int devfs_mk_cdev(dev_t dev, umode_t mode, const char *fmt, ...)
+	__attribute__((format (printf, 3, 4)));
 extern int devfs_mk_symlink(const char *name, const char *link);
 extern int devfs_mk_dir(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
@@ -51,6 +53,10 @@
 {
 	return 0;
 }
+static inline int devfs_mk_cdev(dev_t dev, umode_t mode, const char *fmt, ...)
+{
+	return 0;
+}
 static inline int devfs_mk_symlink (const char *name, const char *link)
 {
     return 0;
--- 1.28/include/linux/input.h	Sun Apr 20 19:21:19 2003
+++ edited/include/linux/input.h	Tue Apr 29 13:02:14 2003
@@ -894,9 +894,6 @@
 int input_accept_process(struct input_handle *handle, struct file *file);
 int input_flush_device(struct input_handle* handle, struct file* file);
 
-/* will go away once devfs_register gets sanitized */
-void input_register_minor(char *name, int minor, int minor_base);
-
 void input_event(struct input_dev *dev, unsigned int type, unsigned int code, int value);
 
 #define input_report_key(a,b,c) input_event(a, EV_KEY, b, !!(c))
--- 1.8/include/linux/major.h	Tue Mar 18 10:58:33 2003
+++ edited/include/linux/major.h	Tue Apr 29 13:02:14 2003
@@ -27,6 +27,7 @@
 #define MUX_MAJOR		11	/* PA-RISC only */
 #define QIC02_TAPE_MAJOR	12
 #define XT_DISK_MAJOR		13
+#define INPUT_MAJOR		13
 #define SOUND_MAJOR		14
 #define CDU31A_CDROM_MAJOR	15
 #define JOYSTICK_MAJOR		15
