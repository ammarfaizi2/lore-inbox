Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264536AbTGBVoZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 17:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264539AbTGBVoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 17:44:25 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:65451 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264536AbTGBVoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 17:44:22 -0400
Date: Wed, 2 Jul 2003 14:58:47 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] add module reference counts to sysfs attribute files
Message-ID: <20030702215847.GA9973@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's a patch against 2.5.74 that adds module reference counting to
sysfs attribute files.  We already protect kobject from going away when
attribute files are open, but we also need to protect the code that the
kobject is referencing from going away too.  This patch fixes that hole,
and as a nice side benefit allows drivers to put attributes in kobjects
that they don't necessarily own (but you still have to be careful about
how you do this, grab the reference first, add the files.  then on exit,
delete the files and then decrement the count.)

This patch works for me on testing of files in pci devices and
/sys/class/usb_host/ as well as other places in sysfs.  Nice part of
this patch is that nothing is needed to be changed for drivers that
already use the *_ATTR() macros to create files.  If you do not use
them, then you have to set the .owner field on your own.

If no one has any objections to it I'll send it on to Linus in a bit.

thanks,

greg k-h

p.s. You will also need a jiffies cleanup patch which I've included at
the end of this patch if you want to build this.  I've told the author
of that file what needs to be fixed so that shouldn't be necessary for
long.



# SYSFS: add module referencing to sysfs attribute files.

diff -Nru a/fs/sysfs/file.c b/fs/sysfs/file.c
--- a/fs/sysfs/file.c	Wed Jul  2 14:35:26 2003
+++ b/fs/sysfs/file.c	Wed Jul  2 14:35:26 2003
@@ -247,6 +247,12 @@
 	if (!kobj || !attr)
 		goto Einval;
 
+	/* Grab the module reference for this attribute if we have one */
+	if (!try_module_get(attr->owner)) {
+		error = -ENODEV;
+		goto Done;
+	}
+
 	/* if the kobject has no ktype, then we assume that it is a subsystem
 	 * itself, and use ops for it.
 	 */
@@ -300,6 +306,7 @@
 	goto Done;
  Eaccess:
 	error = -EACCES;
+	module_put(attr->owner);
  Done:
 	if (error && kobj)
 		kobject_put(kobj);
@@ -314,10 +321,12 @@
 static int sysfs_release(struct inode * inode, struct file * filp)
 {
 	struct kobject * kobj = filp->f_dentry->d_parent->d_fsdata;
+	struct attribute * attr = filp->f_dentry->d_fsdata;
 	struct sysfs_buffer * buffer = filp->private_data;
 
 	if (kobj) 
 		kobject_put(kobj);
+	module_put(attr->owner);
 
 	if (buffer) {
 		if (buffer->page)
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Wed Jul  2 14:35:26 2003
+++ b/include/linux/device.h	Wed Jul  2 14:35:26 2003
@@ -18,6 +18,7 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/ioport.h>
+#include <linux/module.h>
 #include <asm/semaphore.h>
 #include <asm/atomic.h>
 
@@ -95,7 +96,7 @@
 
 #define BUS_ATTR(_name,_mode,_show,_store)	\
 struct bus_attribute bus_attr_##_name = { 		\
-	.attr = {.name = __stringify(_name), .mode = _mode },	\
+	.attr = {.name = __stringify(_name), .mode = _mode, .owner = THIS_MODULE },	\
 	.show	= _show,				\
 	.store	= _store,				\
 };
@@ -136,7 +137,7 @@
 
 #define DRIVER_ATTR(_name,_mode,_show,_store)	\
 struct driver_attribute driver_attr_##_name = { 		\
-	.attr = {.name = __stringify(_name), .mode = _mode },	\
+	.attr = {.name = __stringify(_name), .mode = _mode, .owner = THIS_MODULE },	\
 	.show	= _show,				\
 	.store	= _store,				\
 };
@@ -176,7 +177,7 @@
 
 #define CLASS_ATTR(_name,_mode,_show,_store)			\
 struct class_attribute class_attr_##_name = { 			\
-	.attr = {.name = __stringify(_name), .mode = _mode },	\
+	.attr = {.name = __stringify(_name), .mode = _mode, .owner = THIS_MODULE },	\
 	.show	= _show,					\
 	.store	= _store,					\
 };
@@ -226,7 +227,7 @@
 
 #define CLASS_DEVICE_ATTR(_name,_mode,_show,_store)		\
 struct class_device_attribute class_device_attr_##_name = { 	\
-	.attr = {.name = __stringify(_name), .mode = _mode },	\
+	.attr = {.name = __stringify(_name), .mode = _mode, .owner = THIS_MODULE },	\
 	.show	= _show,					\
 	.store	= _store,					\
 };
@@ -324,7 +325,7 @@
 
 #define DEVICE_ATTR(_name,_mode,_show,_store) \
 struct device_attribute dev_attr_##_name = { 		\
-	.attr = {.name = __stringify(_name), .mode = _mode },	\
+	.attr = {.name = __stringify(_name), .mode = _mode, .owner = THIS_MODULE },	\
 	.show	= _show,				\
 	.store	= _store,				\
 };
diff -Nru a/include/linux/sysfs.h b/include/linux/sysfs.h
--- a/include/linux/sysfs.h	Wed Jul  2 14:35:26 2003
+++ b/include/linux/sysfs.h	Wed Jul  2 14:35:26 2003
@@ -10,9 +10,11 @@
 #define _SYSFS_H_
 
 struct kobject;
+struct module;
 
 struct attribute {
 	char			* name;
+	struct module 		* owner;
 	mode_t			mode;
 };
 


# fix jiffies compiler warning.

diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Wed Jul  2 14:52:20 2003
+++ b/arch/i386/kernel/timers/timer_tsc.c	Wed Jul  2 14:52:20 2003
@@ -21,7 +21,6 @@
 int tsc_disable __initdata = 0;
 
 extern spinlock_t i8253_lock;
-extern unsigned long jiffies;
 
 static int use_tsc;
 /* Number of usecs that the last interrupt was delayed */
