Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271006AbTHBGjM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 02:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272060AbTHBGjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 02:39:12 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:10933 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S271006AbTHBGiG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 02:38:06 -0400
Date: Sat, 2 Aug 2003 08:37:49 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-pre10-ac1
Message-ID: <20030802063749.GA23189@ranty.pantax.net>
Reply-To: ranty@debian.org
References: <200308012216.h71MGLe31285@devserv.devel.redhat.com> <20030802040917.GA22776@ip68-4-255-84.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <20030802040917.GA22776@ip68-4-255-84.oc.oc.cox.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 01, 2003 at 09:09:17PM -0700, Barry K. Nathan wrote:
> ccache gcc -D__KERNEL__ -I/home/barryn/lsx/kernels/2.4/build/linux-2.4.22-pre10-ac1/include -Wall -Wstrict-prototypes -Wno-trigraphs -Os -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon -DMODULE -DMODVERSIONS -include /home/barryn/lsx/kernels/2.4/build/linux-2.4.22-pre10-ac1/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=firmware_class  -DEXPORT_SYMTAB -c firmware_class.c
> firmware_class.c: In function `call_helper':
> firmware_class.c:78: error: `hotplug_path' undeclared (first use in this function)
> firmware_class.c:78: error: (Each undeclared identifier is reported only once
> firmware_class.c:78: error: for each function it appears in.)
> make[1]: *** [firmware_class.o] Error 1
> make[1]: Leaving directory `/home/barryn/lsx/kernels/2.4/build/linux-2.4.22-pre10-ac1/lib'
> make: *** [_mod_lib] Error 2
[snip]
> # CONFIG_HOTPLUG is not set

 CONFIG_HOTPLUG needs to be enabled, attached patch to make it explicit:

 Just choose one of the following:

 firmware-class_2.4-lib-Config.in-incremental.diff
 	- Incremental patch.
	
 firmware-class_2.4-lib-Config.in.diff
 	- Updated Config.in pieces.

 firmware-class-2.4-3.2-full.diff
 	- Updated full patch.


 Have a nice day

 	Manuel
-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="firmware-class-2.4-3.2-full.diff"

diff --exclude=CVS -urN linux-2.4.orig/Documentation/Configure.help linux-2.4.mine/Documentation/Configure.help
--- linux-2.4.orig/Documentation/Configure.help	2003-08-02 08:22:02.000000000 +0200
+++ linux-2.4.mine/Documentation/Configure.help	2003-07-26 13:33:40.000000000 +0200
@@ -26945,6 +26945,12 @@
 
   If unsure, say N.
 
+Hotplug firmware loading support (EXPERIMENTAL)
+CONFIG_FW_LOADER
+  This option is provided for the case where no in-kernel-tree modules require
+  hotplug firmware loading support, but a module built outside the kernel tree
+  does.
+
 NatSemi SCx200 support
 CONFIG_SCx200
   This provides basic support for the National Semiconductor SCx200
diff --exclude=CVS -urN linux-2.4.orig/Documentation/firmware_class/README linux-2.4.mine/Documentation/firmware_class/README
--- linux-2.4.orig/Documentation/firmware_class/README	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.mine/Documentation/firmware_class/README	2003-06-15 16:29:12.000000000 +0200
@@ -0,0 +1,58 @@
+
+ request_firmware() hotplug interface:
+ ------------------------------------
+	Copyright (C) 2003 Manuel Estrada Sainz <ranty@debian.org>
+
+ Why:
+ ---
+
+ Today, the most extended way to use firmware in the Linux kernel is linking
+ it statically in a header file. Which has political and technical issues:
+
+  1) Some firmware is not legal to redistribute.
+  2) The firmware occupies memory permanently, even though it often is just
+     used once.
+  3) Some people, like the Debian crowd, don't consider some firmware free
+     enough and remove entire drivers (e.g.: keyspan).
+
+ about in-kernel persistence:
+ ---------------------------
+ Under some circumstances, as explained below, it would be interesting to keep
+ firmware images in non-swappable kernel memory or even in the kernel image
+ (probably within initramfs).
+
+ Note that this functionality has not been implemented.
+
+ - Why OPTIONAL in-kernel persistence may be a good idea sometimes:
+ 
+	- If the device that needs the firmware is needed to access the
+	  filesystem. When upon some error the device has to be reset and the
+	  firmware reloaded, it won't be possible to get it from userspace.
+	  e.g.:
+		- A diskless client with a network card that needs firmware.
+		- The filesystem is stored in a disk behind an scsi device
+		  that needs firmware.
+	- Replacing buggy DSDT/SSDT ACPI tables on boot.
+	  Note: this would require the persistent objects to be included
+	  within the kernel image, probably within initramfs.
+	  
+   And the same device can be needed to access the filesystem or not depending
+   on the setup, so I think that the choice on what firmware to make
+   persistent should be left to userspace.
+
+ - Why register_firmware()+__init can be useful:
+ 	- For boot devices needing firmware.
+	- To make the transition easier:
+		The firmware can be declared __init and register_firmware()
+		called on module_init. Then the firmware is warranted to be
+		there even if "firmware hotplug userspace" is not there yet or
+		it doesn't yet provide the needed firmware.
+		Once the firmware is widely available in userspace, it can be
+		removed from the kernel. Or made optional (CONFIG_.*_FIRMWARE).
+
+	In either case, if firmware hotplug support is there, it can move the
+	firmware out of kernel memory into the real filesystem for later
+	usage.
+
+	Note: If persistence is implemented on top of initramfs,
+	register_firmware() may not be appropriate.
diff --exclude=CVS -urN linux-2.4.orig/Documentation/firmware_class/firmware_sample_driver.c linux-2.4.mine/Documentation/firmware_class/firmware_sample_driver.c
--- linux-2.4.orig/Documentation/firmware_class/firmware_sample_driver.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.mine/Documentation/firmware_class/firmware_sample_driver.c	2003-06-15 14:03:47.000000000 +0200
@@ -0,0 +1,121 @@
+/*
+ * firmware_sample_driver.c -
+ *
+ * Copyright (c) 2003 Manuel Estrada Sainz <ranty@debian.org>
+ *
+ * Sample code on how to use request_firmware() from drivers.
+ *
+ * Note that register_firmware() is currently useless.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/string.h>
+
+#include "linux/firmware.h"
+
+#define WE_CAN_NEED_FIRMWARE_BEFORE_USERSPACE_IS_AVAILABLE
+#ifdef WE_CAN_NEED_FIRMWARE_BEFORE_USERSPACE_IS_AVAILABLE
+char __init inkernel_firmware[] = "let's say that this is firmware\n";
+#endif
+
+static char ghost_device[] = "ghost0";
+
+static void sample_firmware_load(char *firmware, int size)
+{
+	u8 buf[size+1];
+	memcpy(buf, firmware, size);
+	buf[size] = '\0';
+	printk("firmware_sample_driver: firmware: %s\n", buf);
+}
+
+static void sample_probe_default(void)
+{
+	/* uses the default method to get the firmware */
+        const struct firmware *fw_entry;
+	printk("firmware_sample_driver: a ghost device got inserted :)\n");
+
+        if(request_firmware(&fw_entry, "sample_driver_fw", ghost_device)!=0)
+	{
+		printk(KERN_ERR
+		       "firmware_sample_driver: Firmware not available\n");
+		return;
+	}
+	
+	sample_firmware_load(fw_entry->data, fw_entry->size);
+
+	release_firmware(fw_entry);
+
+	/* finish setting up the device */
+}
+static void sample_probe_specific(void)
+{
+	/* Uses some specific hotplug support to get the firmware from
+	 * userspace  directly into the hardware, or via some sysfs file */
+
+	/* NOTE: This currently doesn't work */
+
+	printk("firmware_sample_driver: a ghost device got inserted :)\n");
+
+        if(request_firmware(NULL, "sample_driver_fw", ghost_device)!=0)
+	{
+		printk(KERN_ERR
+		       "firmware_sample_driver: Firmware load failed\n");
+		return;
+	}
+	
+	/* request_firmware blocks until userspace finished, so at
+	 * this point the firmware should be already in the device */
+
+	/* finish setting up the device */
+}
+static void sample_probe_async_cont(const struct firmware *fw, void *context)
+{
+	if(!fw){
+		printk(KERN_ERR
+		       "firmware_sample_driver: firmware load failed\n");
+		return;
+	}
+
+	printk("firmware_sample_driver: device pointer \"%s\"\n",
+	       (char *)context);
+	sample_firmware_load(fw->data, fw->size);
+}
+static void sample_probe_async(void)
+{
+	/* Let's say that I can't sleep */
+	int error;
+	error = request_firmware_nowait (THIS_MODULE,
+					 "sample_driver_fw", ghost_device,
+					 "my device pointer",
+					 sample_probe_async_cont);
+	if(error){
+		printk(KERN_ERR 
+		       "firmware_sample_driver:"
+		       " request_firmware_nowait failed\n");
+	}
+}
+
+static int sample_init(void)
+{
+#ifdef WE_CAN_NEED_FIRMWARE_BEFORE_USERSPACE_IS_AVAILABLE
+	register_firmware("sample_driver_fw", inkernel_firmware,
+			  sizeof(inkernel_firmware));
+#endif
+	/* since there is no real hardware insertion I just call the
+	 * sample probe functions here */
+	sample_probe_specific();
+	sample_probe_default();
+	sample_probe_async();
+	return 0;
+}
+static void __exit sample_exit(void)
+{
+}
+
+module_init (sample_init);
+module_exit (sample_exit);
+
+MODULE_LICENSE("GPL");
diff --exclude=CVS -urN linux-2.4.orig/Documentation/firmware_class/hotplug-script linux-2.4.mine/Documentation/firmware_class/hotplug-script
--- linux-2.4.orig/Documentation/firmware_class/hotplug-script	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.mine/Documentation/firmware_class/hotplug-script	2003-06-15 13:45:00.000000000 +0200
@@ -0,0 +1,16 @@
+#!/bin/sh
+
+# Simple hotplug script sample:
+# 
+# Both $DEVPATH and $FIRMWARE are already provided in the environment.
+
+HOTPLUG_FW_DIR=/usr/lib/hotplug/firmware/
+
+echo 1 > /sysfs/$DEVPATH/loading
+cat $HOTPLUG_FW_DIR/$FIRMWARE > /sysfs/$DEVPATH/data
+echo 0 > /sysfs/$DEVPATH/loading
+
+# To cancel the load in case of error:
+#
+#	echo -1 > /sysfs/$DEVPATH/loading
+#
diff --exclude=CVS -urN linux-2.4.orig/include/linux/firmware.h linux-2.4.mine/include/linux/firmware.h
--- linux-2.4.orig/include/linux/firmware.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.mine/include/linux/firmware.h	2003-05-24 17:56:40.000000000 +0200
@@ -0,0 +1,20 @@
+#ifndef _LINUX_FIRMWARE_H
+#define _LINUX_FIRMWARE_H
+#include <linux/module.h>
+#include <linux/types.h>
+#define FIRMWARE_NAME_MAX 30 
+struct firmware {
+	size_t size;
+	u8 *data;
+};
+int request_firmware (const struct firmware **fw, const char *name,
+		      const char *device);
+int request_firmware_nowait (
+	struct module *module,
+	const char *name, const char *device, void *context,
+	void (*cont)(const struct firmware *fw, void *context));
+/* On 2.5 'device' is 'struct device *' */
+
+void release_firmware (const struct firmware *fw);
+void register_firmware (const char *name, const u8 *data, size_t size);
+#endif
diff --exclude=CVS -urN linux-2.4.orig/lib/Config.in linux-2.4.mine/lib/Config.in
--- linux-2.4.orig/lib/Config.in	2003-08-02 08:22:02.000000000 +0200
+++ linux-2.4.mine/lib/Config.in	2003-08-02 08:19:14.000000000 +0200
@@ -41,4 +41,9 @@
   fi
 fi
 
+if [ "$CONFIG_EXPERIMENTAL" = "y" -a \
+     "$CONFIG_HOTPLUG" = "y" ]; then
+   tristate 'Hotplug firmware loading support (EXPERIMENTAL)' CONFIG_FW_LOADER
+fi
+
 endmenu
diff --exclude=CVS -urN linux-2.4.orig/lib/Makefile linux-2.4.mine/lib/Makefile
--- linux-2.4.orig/lib/Makefile	2003-08-02 08:22:02.000000000 +0200
+++ linux-2.4.mine/lib/Makefile	2003-06-21 19:58:58.000000000 +0200
@@ -9,11 +9,12 @@
 L_TARGET := lib.a
 
 export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o \
-	       rbtree.o crc32.o
+	       rbtree.o crc32.o firmware_class.o
 
 obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o \
 	 bust_spinlocks.o rbtree.o dump_stack.o
 
+obj-$(CONFIG_FW_LOADER) += firmware_class.o
 obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
 
diff --exclude=CVS -urN linux-2.4.orig/lib/firmware_class.c linux-2.4.mine/lib/firmware_class.c
--- linux-2.4.orig/lib/firmware_class.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.mine/lib/firmware_class.c	2003-06-24 23:39:07.000000000 +0200
@@ -0,0 +1,557 @@
+/*
+ * firmware_class.c - Multi purpose firmware loading support
+ *
+ * Copyright (c) 2003 Manuel Estrada Sainz <ranty@debian.org>
+ *
+ * Please see Documentation/firmware_class/ for more information.
+ *
+ */
+/*
+ * Based on kernel/kmod.c and drivers/usb/usb.c
+ */
+/*
+        kernel/kmod.c
+        Kirk Petersen
+
+        Reorganized not to be a daemon by Adam Richter, with guidance
+        from Greg Zornetzer.
+
+        Modified to avoid chroot and file sharing problems.
+        Mikael Pettersson
+
+        Limit the concurrent number of kmod modprobes to catch loops from
+        "modprobe needs a service that is in a module".
+        Keith Owens <kaos@ocs.com.au> December 1999
+
+        Unblock all signals when we exec a usermode process.
+        Shuu Yamaguchi <shuu@wondernetworkresources.com> December 2000
+*/
+/*
+ * drivers/usb/usb.c
+ *
+ * (C) Copyright Linus Torvalds 1999
+ * (C) Copyright Johannes Erdfelt 1999-2001
+ * (C) Copyright Andreas Gal 1999
+ * (C) Copyright Gregory P. Smith 1999
+ * (C) Copyright Deti Fliegl 1999 (new USB architecture)
+ * (C) Copyright Randy Dunlap 2000
+ * (C) Copyright David Brownell 2000 (kernel hotplug, usb_device_id)
+ * (C) Copyright Yggdrasil Computing, Inc. 2000
+ *     (usb_device_id matching changes by Adam J. Richter)
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/kmod.h>
+#include <linux/proc_fs.h>
+#include <linux/vmalloc.h>
+#include <asm/hardirq.h>
+
+#include "linux/firmware.h"
+
+MODULE_AUTHOR("Manuel Estrada Sainz <ranty@debian.org>");
+MODULE_DESCRIPTION("Multi purpose firmware loading support");
+MODULE_LICENSE("GPL");
+
+#define err(format, arg...) \
+     printk(KERN_ERR  "%s:%s: " format "\n",__FILE__, __FUNCTION__ , ## arg)
+#define warn(format, arg...) \
+     printk(KERN_WARNING "%s:%s: " format "\n",__FILE__, __FUNCTION__ , ## arg)
+#define dbg(format, arg...) \
+     printk(KERN_DEBUG "%s:%s: " format "\n",__FILE__, __FUNCTION__ , ## arg)
+
+static int loading_timeout = 10;	/* In seconds */
+static struct proc_dir_entry *proc_dir_timeout;
+static struct proc_dir_entry *proc_dir;
+
+static int
+call_helper(char *verb, const char *name, const char *device)
+{
+	char *argv[3], **envp, *buf, *scratch;
+	int i = 0;
+
+	int retval = 0;
+
+	if (!hotplug_path[0])
+		return -ENOENT;
+	if (in_interrupt()) {
+		err("in_interrupt");
+		return -EFAULT;
+	}
+	if (!current->fs->root) {
+		warn("call_policy %s -- no FS yet", verb);
+		return -EPERM;
+	}
+
+	if (!(envp = (char **) kmalloc(20 * sizeof (char *), GFP_KERNEL))) {
+		err("unable to allocate envp");
+		return -ENOMEM;
+	}
+	if (!(buf = kmalloc(256, GFP_KERNEL))) {
+		kfree(envp);
+		err("unable to allocate buf");
+		return -ENOMEM;
+	}
+
+	/* only one standardized param to hotplug command: type */
+	argv[0] = hotplug_path;
+	argv[1] = "firmware";
+	argv[2] = 0;
+
+	/* minimal command environment */
+	envp[i++] = "HOME=/";
+	envp[i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
+
+#ifdef  DEBUG
+	/* hint that policy agent should enter no-stdout debug mode */
+	envp[i++] = "DEBUG=kernel";
+#endif
+	scratch = buf;
+
+	if (device) {
+		envp[i++] = scratch;
+		scratch += snprintf(scratch, FIRMWARE_NAME_MAX+25,
+				    "DEVPATH=/driver/firmware/%s", device) + 1;
+	}
+
+	envp[i++] = scratch;
+	scratch += sprintf(scratch, "ACTION=%s", verb) + 1;
+
+	envp[i++] = scratch;
+	scratch += snprintf(scratch, FIRMWARE_NAME_MAX,
+			    "FIRMWARE=%s", name) + 1;
+
+	envp[i++] = 0;
+
+	dbg("firmware: %s %s %s", argv[0], argv[1], verb);
+
+	retval = call_usermodehelper(argv[0], argv, envp);
+	if (retval) {
+		printk("call_usermodehelper return %d\n", retval);
+	}
+
+	kfree(buf);
+	kfree(envp);
+	return retval;
+}
+
+struct firmware_priv {
+	struct completion completion;
+	struct proc_dir_entry *proc_dir;
+	struct proc_dir_entry *attr_data;
+	struct proc_dir_entry *attr_loading;
+	struct firmware *fw;
+	int loading;
+	int abort;
+	int alloc_size;
+	struct timer_list timeout;
+};
+
+static int
+firmware_timeout_show(char *buf, char **start, off_t off,
+		      int count, int *eof, void *data)
+{
+	return sprintf(buf, "%d\n", loading_timeout);
+}
+
+/**
+ * firmware_timeout_store:
+ * Description:
+ *	Sets the number of seconds to wait for the firmware.  Once
+ *	this expires an error will be return to the driver and no
+ *	firmware will be provided.
+ *
+ *	Note: zero means 'wait for ever'
+ *  
+ **/
+static int
+firmware_timeout_store(struct file *file, const char *buf,
+		       unsigned long count, void *data)
+{
+	loading_timeout = simple_strtol(buf, NULL, 10);
+	return count;
+}
+
+static ssize_t
+firmware_loading_show(char *buf, char **start, off_t off,
+		      int count, int *eof, void *data)
+{
+	struct firmware_priv *fw_priv = data;
+	return sprintf(buf, "%d\n", fw_priv->loading);
+}
+
+/**
+ * firmware_loading_store: - loading control file
+ * Description:
+ *	The relevant values are: 
+ *
+ *	 1: Start a load, discarding any previous partial load.
+ *	 0: Conclude the load and handle the data to the driver code.
+ *	-1: Conclude the load with an error and discard any written data.
+ **/
+static ssize_t
+firmware_loading_store(struct file *file, const char *buf,
+		       unsigned long count, void *data)
+{
+	struct firmware_priv *fw_priv = data;
+	int prev_loading = fw_priv->loading;
+
+	fw_priv->loading = simple_strtol(buf, NULL, 10);
+
+	switch (fw_priv->loading) {
+	case -1:
+		fw_priv->abort = 1;
+		wmb();
+		complete(&fw_priv->completion);
+		break;
+	case 1:
+		kfree(fw_priv->fw->data);
+		fw_priv->fw->data = NULL;
+		fw_priv->fw->size = 0;
+		fw_priv->alloc_size = 0;
+		break;
+	case 0:
+		if (prev_loading == 1)
+			complete(&fw_priv->completion);
+		break;
+	}
+
+	return count;
+}
+
+static ssize_t
+firmware_data_read(char *buffer, char **start, off_t offset,
+		   int count, int *eof, void *data)
+{
+	struct firmware_priv *fw_priv = data;
+	struct firmware *fw = fw_priv->fw;
+
+	if (offset > fw->size)
+		return 0;
+	if (offset + count > fw->size)
+		count = fw->size - offset;
+
+	memcpy(buffer, fw->data + offset, count);
+	*start = (void*)count;
+	return count;
+}
+static int
+fw_realloc_buffer(struct firmware_priv *fw_priv, int min_size)
+{
+	u8 *new_data;
+	int new_size;
+
+	if (min_size <= fw_priv->alloc_size)
+		return 0;
+	if((min_size % PAGE_SIZE) == 0)
+		new_size = min_size;
+	else
+		new_size = (min_size + PAGE_SIZE) & PAGE_MASK;
+	new_data = vmalloc(new_size);
+	if (!new_data) {
+		printk(KERN_ERR "%s: unable to alloc buffer\n", __FUNCTION__);
+		/* Make sure that we don't keep incomplete data */
+		fw_priv->abort = 1;
+		return -ENOMEM;
+	}
+	fw_priv->alloc_size = new_size;
+	if (fw_priv->fw->data) {
+		memcpy(new_data, fw_priv->fw->data, fw_priv->fw->size);
+		vfree(fw_priv->fw->data);
+	}
+	fw_priv->fw->data = new_data;
+	BUG_ON(min_size > fw_priv->alloc_size);
+	return 0;
+}
+
+/**
+ * firmware_data_write:
+ *
+ * Description:
+ *
+ *	Data written to the 'data' attribute will be later handled to
+ *	the driver as a firmware image.
+ **/
+static ssize_t
+firmware_data_write(struct file *file, const char *buffer,
+		    unsigned long count, void *data)
+{
+	struct firmware_priv *fw_priv = data;
+	struct firmware *fw = fw_priv->fw;
+	int offset = file->f_pos;
+	int retval;
+
+	retval = fw_realloc_buffer(fw_priv, offset + count);
+	if (retval) {
+		printk("%s: retval:%d\n", __FUNCTION__, retval);
+		return retval;
+	}
+
+	memcpy(fw->data + offset, buffer, count);
+
+	fw->size = max_t(size_t, offset + count, fw->size);
+	file->f_pos += count;
+	return count;
+}
+
+static void
+firmware_class_timeout(u_long data)
+{
+	struct firmware_priv *fw_priv = (struct firmware_priv *) data;
+	fw_priv->abort = 1;
+	wmb();
+	complete(&fw_priv->completion);
+}
+static int
+fw_setup_class_device(struct firmware_priv **fw_priv_p,
+		      const char *fw_name, const char *device)
+{
+	int retval;
+	struct firmware_priv *fw_priv = kmalloc(sizeof (struct firmware_priv),
+						GFP_KERNEL);
+	*fw_priv_p = fw_priv;
+	if (!fw_priv) {
+		retval = -ENOMEM;
+		goto out;
+	}
+	memset(fw_priv, 0, sizeof (*fw_priv));
+
+	init_completion(&fw_priv->completion);
+
+	fw_priv->timeout.function = firmware_class_timeout;
+	fw_priv->timeout.data = (u_long) fw_priv;
+	init_timer(&fw_priv->timeout);
+
+	retval = -EAGAIN;
+	fw_priv->proc_dir = create_proc_entry(device, 0644 | S_IFDIR, proc_dir);
+	if (!fw_priv->proc_dir)
+		goto err_free_fw_priv;
+
+	fw_priv->attr_data = create_proc_entry("data", 0644 | S_IFREG,
+					       fw_priv->proc_dir);
+	if (!fw_priv->attr_data)
+		goto err_remove_dir;
+
+	fw_priv->attr_data->read_proc = firmware_data_read;
+	fw_priv->attr_data->write_proc = firmware_data_write;
+	fw_priv->attr_data->data = fw_priv;
+
+	fw_priv->attr_loading = create_proc_entry("loading", 0644 | S_IFREG,
+						  fw_priv->proc_dir);
+	if (!fw_priv->attr_loading)
+		goto err_remove_data;
+
+	fw_priv->attr_loading->read_proc = firmware_loading_show;
+	fw_priv->attr_loading->write_proc = firmware_loading_store;
+	fw_priv->attr_loading->data = fw_priv;
+
+	retval = 0;
+	fw_priv->fw = kmalloc(sizeof (struct firmware), GFP_KERNEL);
+	if (!fw_priv->fw) {
+		printk(KERN_ERR "%s: kmalloc(struct firmware) failed\n",
+		       __FUNCTION__);
+		retval = -ENOMEM;
+		goto err_remove_loading;
+	}
+	memset(fw_priv->fw, 0, sizeof (*fw_priv->fw));
+
+	goto out;
+
+err_remove_loading:
+	remove_proc_entry("loading", fw_priv->proc_dir);
+err_remove_data:
+	remove_proc_entry("data", fw_priv->proc_dir);
+err_remove_dir:
+	remove_proc_entry(device, proc_dir);
+err_free_fw_priv:
+	kfree(fw_priv);
+out:
+	return retval;
+}
+static void
+fw_remove_class_device(struct firmware_priv *fw_priv)
+{
+	remove_proc_entry("loading", fw_priv->proc_dir);
+	remove_proc_entry("data", fw_priv->proc_dir);
+	remove_proc_entry(fw_priv->proc_dir->name, proc_dir);
+}
+
+/** 
+ * request_firmware: - request firmware to hotplug and wait for it
+ * Description:
+ *	@firmware will be used to return a firmware image by the name
+ *	of @name for device @device.
+ *
+ *	Should be called from user context where sleeping is allowed.
+ *
+ *	@name will be use as $FIRMWARE in the hotplug environment and
+ *	should be distinctive enough not to be confused with any other
+ *	firmware image for this or any other device.
+ **/
+int
+request_firmware(const struct firmware **firmware, const char *name,
+		 const char *device)
+{
+	struct firmware_priv *fw_priv;
+	int retval;
+
+	if (!firmware) {
+		retval = -EINVAL;
+		goto out;
+	}
+	*firmware = NULL;
+
+	retval = fw_setup_class_device(&fw_priv, name, device);
+	if (retval)
+		goto out;
+
+	retval = call_helper("add", name, device);
+	if (retval)
+		goto out;
+	if (loading_timeout) {
+		fw_priv->timeout.expires = jiffies + loading_timeout * HZ;
+		add_timer(&fw_priv->timeout);
+	}
+
+	wait_for_completion(&fw_priv->completion);
+
+	del_timer(&fw_priv->timeout);
+	fw_remove_class_device(fw_priv);
+
+	if (fw_priv->fw->size && !fw_priv->abort) {
+		*firmware = fw_priv->fw;
+	} else {
+		retval = -ENOENT;
+		vfree(fw_priv->fw->data);
+		kfree(fw_priv->fw);
+	}
+out:
+	kfree(fw_priv);
+	return retval;
+}
+
+void
+release_firmware(const struct firmware *fw)
+{
+	if (fw) {
+		vfree(fw->data);
+		kfree(fw);
+	}
+}
+
+/**
+ * register_firmware: - provide a firmware image for later usage
+ * 
+ * Description:
+ *	Make sure that @data will be available by requesting firmware @name.
+ *
+ *	Note: This will not be possible until some kind of persistence
+ *	is available.
+ **/
+void
+register_firmware(const char *name, const u8 *data, size_t size)
+{
+	/* This is meaningless without firmware caching, so until we
+	 * decide if firmware caching is reasonable just leave it as a
+	 * noop */
+}
+
+/* Async support */
+struct firmware_work {
+	struct tq_struct work;
+	struct module *module;
+	const char *name;
+	const char *device;
+	void *context;
+	void (*cont)(const struct firmware *fw, void *context);
+};
+
+static void
+request_firmware_work_func(void *arg)
+{
+	struct firmware_work *fw_work = arg;
+	const struct firmware *fw;
+	if (!arg)
+		return;
+	request_firmware(&fw, fw_work->name, fw_work->device);
+	fw_work->cont(fw, fw_work->context);
+	release_firmware(fw);
+	__MOD_DEC_USE_COUNT(fw_work->module);
+	kfree(fw_work);
+}
+
+/**
+ * request_firmware_nowait:
+ *
+ * Description:
+ *	Asynchronous variant of request_firmware() for contexts where
+ *	it is not possible to sleep.
+ *
+ *	@cont will be called asynchronously when the firmware request is over.
+ *
+ *	@context will be passed over to @cont.
+ *
+ *	@fw may be %NULL if firmware request fails.
+ *
+ **/
+int
+request_firmware_nowait(
+	struct module *module,
+	const char *name, const char *device, void *context,
+	void (*cont)(const struct firmware *fw, void *context))
+{
+	struct firmware_work *fw_work = kmalloc(sizeof (struct firmware_work),
+						GFP_ATOMIC);
+	if (!fw_work)
+		return -ENOMEM;
+	if (!try_inc_mod_count(module)) {
+		kfree(fw_work);
+		return -EFAULT;
+	}
+
+	*fw_work = (struct firmware_work) {
+		.module = module,
+		.name = name,
+		.device = device,
+		.context = context,
+		.cont = cont,
+	};
+	INIT_TQUEUE(&fw_work->work, request_firmware_work_func, fw_work);
+
+	schedule_task(&fw_work->work);
+	return 0;
+}
+
+static int __init
+firmware_class_init(void)
+{
+	proc_dir = create_proc_entry("driver/firmware", 0755 | S_IFDIR, NULL);
+	if (!proc_dir)
+		return -EAGAIN;
+	proc_dir_timeout = create_proc_entry("timeout",
+					     0644 | S_IFREG, proc_dir);
+	if (!proc_dir_timeout) {
+		remove_proc_entry("driver/firmware", NULL);
+		return -EAGAIN;
+	}
+	proc_dir_timeout->read_proc = firmware_timeout_show;
+	proc_dir_timeout->write_proc = firmware_timeout_store;
+	return 0;
+}
+static void __exit
+firmware_class_exit(void)
+{
+	remove_proc_entry("timeout", proc_dir);
+	remove_proc_entry("driver/firmware", NULL);
+}
+
+module_init(firmware_class_init);
+module_exit(firmware_class_exit);
+
+EXPORT_SYMBOL(release_firmware);
+EXPORT_SYMBOL(request_firmware);
+EXPORT_SYMBOL(request_firmware_nowait);
+EXPORT_SYMBOL(register_firmware);

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="firmware-class_2.4-lib-Config.in-incremental.diff"

diff -u linux-2.4.mine/lib/Config.in linux-2.4.mine/lib/Config.in
--- linux-2.4.mine/lib/Config.in	2003-06-14 22:41:08.000000000 +0200
+++ linux-2.4.mine/lib/Config.in	2003-08-02 08:19:14.000000000 +0200
@@ -41,7 +41,8 @@
   fi
 fi
 
-if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+if [ "$CONFIG_EXPERIMENTAL" = "y" -a \
+     "$CONFIG_HOTPLUG" = "y" ]; then
    tristate 'Hotplug firmware loading support (EXPERIMENTAL)' CONFIG_FW_LOADER
 fi
 

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="firmware-class_2.4-lib-Config.in.diff"

diff --exclude=CVS -urN linux-2.4.orig/lib/Config.in linux-2.4.mine/lib/Config.in
--- linux-2.4.orig/lib/Config.in	2003-08-02 08:22:02.000000000 +0200
+++ linux-2.4.mine/lib/Config.in	2003-08-02 08:19:14.000000000 +0200
@@ -41,4 +41,9 @@
   fi
 fi
 
+if [ "$CONFIG_EXPERIMENTAL" = "y" -a \
+     "$CONFIG_HOTPLUG" = "y" ]; then
+   tristate 'Hotplug firmware loading support (EXPERIMENTAL)' CONFIG_FW_LOADER
+fi
+
 endmenu

--gKMricLos+KVdGMg--
