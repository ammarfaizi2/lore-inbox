Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289750AbSBESmp>; Tue, 5 Feb 2002 13:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289752AbSBESmg>; Tue, 5 Feb 2002 13:42:36 -0500
Received: from air-2.osdl.org ([65.201.151.6]:18093 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S289750AbSBESm3>;
	Tue, 5 Feb 2002 13:42:29 -0500
Date: Tue, 5 Feb 2002 10:43:14 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Pavel Machek <pavel@suse.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: driverfs support for motherboard devices
In-Reply-To: <20020205173912.GA165@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0202050959020.25114-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Pavel,

On Tue, 5 Feb 2002, Pavel Machek wrote:

> Hi!
> 
> This patch adds support for motherboard devices, so that you can see
> them in driverfs.
> 
> Should ide be presented to driverfs as bus with two devices on it?

I think that ide should get its own bus, as a child of the ide controller. 
I haven't looked at ide yet at all. But, on most modern systems, the ide 
controller is a function of the southbridge, so ide devices should go 
under that. Like what the usb stuff does now...

> 
> What about "legacy" bus? It is not in this release, and I'm not 100%
> sure who should generate it. Many architectures will need such bus so
> maybe it belongs in drivers/base in order to avoid duplicate code?

I've had this actually in my queue for some time, though I've been 
waititng for some of the other changes to go in (most of which went in to 
2.5.3).

Adding simple legacy and system device support is trivial - patches are 
attached. Basically, you would do something like:

static struct device old_legacy_device = {
	bus_id:		"artifact",
	name:		"Some old device that someone is still using",
};

old_dev_init() 
{
	...
	register_legacy_device(&old_legacy_device);
}


And it shows up as $MNTPT/root/legacy/artifact/

Similarly for system devices with register_sys_device().

Unfortunately, the diff is relative to what I've already sent Linus. He 
says he applied them, so you'll have to wait until 2.4.1-pre1 comes. 

For clarification: 

Legacy devices are typical legacy PC devices, like floppy drives, parallel 
ports, serial ports, etc. They are devices that you can typically access 
through the standard, hardcoded I/O addresses; and without having to 
enable the upstream parents to do so. 

'legacy' is what I've always heard them referred to as, as a whole. The 
name may imply old and/or deprecated, and in a lot of cases they are. But, 
it's a easy, common way to group them.

System devices are devices are attached to the motherboard, but aren't 
typical devices that you would read or write to. Yet, you still want to 
export an interface to them. This includes CPUs, PICs, RTC, etc. 

	-pat

Also included are samples for the keyboard and RTC drivers (keyboard is a 
legacy device, RTC is a system device)

diff -Nur linux-2.5.3.orig/drivers/base/legacy.c linux-2.5.3/drivers/base/legacy.c
--- linux-2.5.3.orig/drivers/base/legacy.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.3/drivers/base/legacy.c	Tue Feb  5 07:30:48 2002
@@ -0,0 +1,44 @@
+/*
+ * legacy.c - Create bus for legacy devices to attach to
+ * 
+ * Copyright (c) 2002 Patrick Mochel
+ *		 2002 Open Source Development Lab
+ * 
+ * 
+ */
+
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/init.h>
+
+static struct device legacy_bus = { 
+	name:		"Legacy Bus",
+	bus_id:		"legacy",
+};
+
+int register_legacy_device(struct device * dev)
+{
+	int error = -EINVAL;
+	if (dev) {
+		if (!dev->parent)
+			dev->parent = &legacy_bus;
+		error = device_register(dev);
+	}
+	return error;
+}
+
+void unregister_legacy_device(struct device * dev)
+{
+	if (dev)
+		put_device(dev);
+}
+
+static int legacy_bus_init(void)
+{
+	return device_register(&legacy_bus);
+}
+
+subsys_initcall(legacy_bus_init);
+EXPORT_SYMBOL(register_legacy_device);
+EXPORT_SYMBOL(unregister_legacy_device);
diff -Nur linux-2.5.3.orig/drivers/base/Makefile linux-2.5.3/drivers/base/Makefile
--- linux-2.5.3.orig/drivers/base/Makefile	Mon Jan 28 14:50:41 2002
+++ linux-2.5.3/drivers/base/Makefile	Tue Feb  5 10:03:55 2002
@@ -1,7 +1,9 @@
 O_TARGET	:= base.o
 
-obj-y		:= core.o interface.o fs.o
+obj-y		:= core.o interface.o fs.o \
+			sys.o legacy.o
 
-export-objs	:= core.o interface.o fs.o 
+export-objs	:= core.o interface.o fs.o \
+			sys.o legacy.o
 
 include $(TOPDIR)/Rules.make
diff -Nur linux-2.5.3.orig/drivers/base/sys.c linux-2.5.3/drivers/base/sys.c
--- linux-2.5.3.orig/drivers/base/sys.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.3/drivers/base/sys.c	Tue Feb  5 07:31:01 2002
@@ -0,0 +1,48 @@
+/*
+ * sys.c - pseudo-bus for system 'devices' (cpus, PICs, timers, etc)
+ *
+ * Copyright (c) 2002 Patrick Mochel
+ *		 2002 Open Source Development Lab
+ * 
+ * This exports a 'system' bus type. 
+ * By default, a 'sys' bus gets added to the root of the system. There will
+ * always be core system devices. Devices can use register_sys_device() to
+ * add themselves as children of the system bus.
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+
+static struct device system_bus = {
+	name:		"System Bus",
+	bus_id:		"sys",
+};
+
+int register_sys_device(struct device * dev)
+{
+	int error = -EINVAL;
+
+	if (dev) {
+		if (!dev->parent)
+			dev->parent = &system_bus;
+		error = device_register(dev);
+	}
+	return error;
+}
+
+void unregister_sys_device(struct device * dev)
+{
+	if (dev)
+		put_device(dev);
+}
+
+static int sys_bus_init(void)
+{
+	return device_register(&system_bus);
+}
+
+subsys_initcall(sys_bus_init);
+EXPORT_SYMBOL(register_sys_device);
+EXPORT_SYMBOL(unregister_sys_device);
diff -Nur linux-2.5.3.orig/drivers/char/keyboard.c linux-2.5.3/drivers/char/keyboard.c
--- linux-2.5.3.orig/drivers/char/keyboard.c	Thu Jan 24 13:02:23 2002
+++ linux-2.5.3/drivers/char/keyboard.c	Tue Feb  5 07:41:41 2002
@@ -42,6 +42,7 @@
 #include <linux/kbd_ll.h>
 #include <linux/sysrq.h>
 #include <linux/pm.h>
+#include <linux/device.h>
 
 #define SIZE(x) (sizeof(x)/sizeof((x)[0]))
 
@@ -906,6 +907,11 @@
 
 pm_callback pm_kbd_request_override = NULL;
 
+static struct device kbd_device = {
+	bus_id:	"keyboard",
+	name:	"Keyboard",
+};
+
 int __init kbd_init(void)
 {
 	int i;
@@ -930,6 +936,8 @@
 	tasklet_schedule(&keyboard_tasklet);
 	
 	pm_kbd = pm_register(PM_SYS_DEV, PM_SYS_KBC, pm_kbd_request_override);
+
+	register_legacy_device(&kbd_device);
 
 	return 0;
 }
diff -Nur linux-2.5.3.orig/drivers/char/rtc.c linux-2.5.3/drivers/char/rtc.c
--- linux-2.5.3.orig/drivers/char/rtc.c	Thu Jan 24 13:02:23 2002
+++ linux-2.5.3/drivers/char/rtc.c	Tue Feb  5 07:50:35 2002
@@ -67,6 +67,7 @@
 #include <linux/poll.h>
 #include <linux/proc_fs.h>
 #include <linux/spinlock.h>
+#include <linux/device.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -659,6 +660,11 @@
 	&rtc_fops
 };
 
+static struct device rtc_device = {
+	bus_id:	"rtc",
+	name:	"Real Time Clock",
+};
+
 static int __init rtc_init(void)
 {
 #if defined(__alpha__) || defined(__mips__)
@@ -797,7 +803,7 @@
 	rtc_freq = 1024;
 no_irq2:
 #endif
-
+	register_sys_device(&rtc_device);
 	printk(KERN_INFO "Real Time Clock Driver v" RTC_VERSION "\n");
 
 	return 0;

