Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312603AbSCZRqn>; Tue, 26 Mar 2002 12:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312604AbSCZRqg>; Tue, 26 Mar 2002 12:46:36 -0500
Received: from [195.39.17.254] ([195.39.17.254]:35205 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S312603AbSCZRqb>;
	Tue, 26 Mar 2002 12:46:31 -0500
Date: Tue, 26 Mar 2002 18:45:02 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
        Patrick Mochel <mochel@osdl.org>, torvalds@transmeta.com
Subject: device model: introducing sys bus
Message-ID: <20020326174501.GA2434@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'd like to propose this patch... If we want to move from reboot
notifier to the driver model, in-kernel device_suspend is neccessary.

Consider applying,
								Pavel


--- clean/Documentation/driver-model.txt	Sun Mar 10 20:06:28 2002
+++ linux-acpi/Documentation/driver-model.txt	Thu Mar 21 13:19:24 2002
@@ -52,7 +52,8 @@
 Each bus layer should implement the callbacks for these drivers. It then
 forwards the calls on to the device-specific callbacks. This means that
 device-specific drivers must still implement callbacks for each operation.
-But, they are not called from the top level driver layer.
+But, they are not called from the top level driver layer. [So for example
+PCI devices will not call device_register but pci_device_register.]
 
 This does add another layer of indirection for calling one of these functions,
 but there are benefits that are believed to outweigh this slowdown.
@@ -60,7 +61,7 @@
 First, it prevents device-specific drivers from having to know about the
 global device layer. This speeds up integration time incredibly. It also
 allows drivers to be more portable across kernel versions. Note that the
-former was intentional, the latter is an added bonus.
+former was intentional, the latter is an added bonus. 
 
 Second, this added indirection allows the bus to perform any additional logic
 necessary for its child devices. A bus layer may add additional information to
@@ -225,7 +226,6 @@
 	It also allows the platform driver (e.g. ACPI) to a driver without the driver
 	having to have explicit knowledge of (atrocities like) ACPI.
 
-
 current_state:
 	Current power state of the device. For PCI and other modern devices, this is
 	0-3, though it's not necessarily limited to those values.
@@ -251,18 +251,24 @@
 }
 
 probe:
-	Check for device existence and associate driver with it.
+	Check for device existence and associate driver with it. In case of device 
+	insertion, *all* drivers are called. Struct device has parent and bus_id 
+	valid at this point. probe() may only be called from process context. Returns
+	0 if it handles that device, -ESRCH if this driver does not know how to handle
+	this device, valid error otherwise.
 
 remove:
 	Dissociate driver with device. Releases device so that it could be used by
 	another driver. Also, if it is a hotplug device (hotplug PCI, Cardbus), an
-	ejection event could take place here.
+	ejection event could take place here. remove() can be called from interrupt 
+	context. [Fixme: Is that good?] Returns 0 on success. [Can we recover from
+	failed remove or should I define that remove() never fails?]
 
 suspend:
-	Perform one step of the device suspend process.
+	Perform one step of the device suspend process. Returns 0 on success.
 
 resume:
-	Perform one step of the device resume process.
+	Perform one step of the device resume process. Returns 0 on success.
 
 The probe() and remove() callbacks are intended to be much simpler than the
 current PCI correspondents.
@@ -275,7 +281,7 @@
 
 Some device initialisation was done in probe(). This should not be the case
 anymore. All initialisation should take place in the open() call for the
-device.
+device. [FIXME: How do you "open" uhci?]
 
 Breaking initialisation code out must also be done for the resume() callback,
 as most devices will have to be completely reinitialised when coming back from
@@ -324,6 +330,7 @@
 
 enum{
 	SUSPEND_NOTIFY,
+	SUSPEND_DISABLE,
 	SUSPEND_SAVE_STATE,
 	SUSPEND_POWER_DOWN,
 };
@@ -331,6 +338,7 @@
 enum {
 	RESUME_POWER_ON,
 	RESUME_RESTORE_STATE,
+	RESUME_ENABLE,
 };
 
 
@@ -352,9 +360,9 @@
 Instead, the walking of the device tree has been moved to userspace. When a
 user requests the system to suspend, it will walk the device tree, as exported
 via driverfs, and tell each device to go to sleep. It will do this multiple
-times based on what the system policy is.
-
-[ FIXME: URL pointer to the corresponding utility is missing here! ]
+times based on what the system policy is. [Not possible. Take ACPI enabled 
+system, with battery critically low. In such state, you want to suspend-to-disk,
+*fast*. User maybe is not even running powerd (think system startup)!]
 
 Device resume should happen in the same manner when the system awakens.
 
@@ -366,22 +374,25 @@
 cannot resume the hardware from the requested level, or it feels that it is
 too important to be put to sleep, it should return an error from this function.
 
-It does not have to stop I/O requests or actually save state at this point.
+It does not have to stop I/O requests or actually save state at this point. Called
+from process context.
 
 SUSPEND_DISABLE:
 
 The driver should stop taking I/O requests at this stage. Because the save
 state stage happens afterwards, the driver may not want to physically disable
-the device; only mark itself unavailable if possible.
+the device; only mark itself unavailable if possible. Called from process 
+context.
 
 SUSPEND_SAVE_STATE:
 
 The driver should allocate memory and save any device state that is relevant
-for the state it is going to enter.
+for the state it is going to enter. Called from process context.
 
 SUSPEND_POWER_DOWN:
 
-The driver should place the device in the power state requested.
+The driver should place the device in the power state requested. May be called
+from interrupt context.
 
 
 For resume, the stages are defined as follows:
@@ -389,25 +400,27 @@
 RESUME_POWER_ON:
 
 Devices should be powered on and reinitialised to some known working state.
+Called from process context.
 
 RESUME_RESTORE_STATE:
 
 The driver should restore device state to its pre-suspend state and free any
-memory allocated for its saved state.
+memory allocated for its saved state. Called from process context.
 
 RESUME_ENABLE:
 
-The device should start taking I/O requests again.
+The device should start taking I/O requests again. Called from process context.
 
 
 Each driver does not have to implement each stage. But, it if it does
-implemente a stage, it should do what is described above. It should not assume
+implement a stage, it should do what is described above. It should not assume
 that it performed any stage previously, or that it will perform any stage
-later.
+later. [Really? It makes sense to support SAVE_STATE only after DISABLE].
 
 It is quite possible that a driver can fail during the suspend process, for
 whatever reason. In this event, the calling process must gracefully recover
-and restore everything to their states before the suspend transition began.
+and restore everything to their states before the suspend transition began. 
+[Suspend may not fail, think battery low.]
 
 If a driver knows that it cannot suspend or resume properly, it should fail
 during the notify stage. Properly implemented power management schemes should
--- clean/arch/i386/kernel/i8259.c	Sun Mar 10 20:06:31 2002
+++ linux-acpi/arch/i386/kernel/i8259.c	Fri Mar 22 12:40:56 2002
@@ -11,6 +11,7 @@
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/kernel_stat.h>
+#include <linux/device.h>
 
 #include <asm/atomic.h>
 #include <asm/system.h>
@@ -332,6 +333,39 @@
 		goto handle_real_irq;
 	}
 }
+
+static int i8249A_resume(struct device *dev, u32 level)
+{
+	printk("i8249A -- do nothing for now\n");
+	return 0;
+}
+
+/* This is just a hook for the overall driver tree.
+ *
+ * FIXME: This is soon goig to replace the custom linked list games played up
+ * to great extend between the different components of the IDE drivers.
+ */
+
+static struct device_driver i8249A_devdrv = {
+	resume: i8249A_resume,
+};
+
+
+static struct device device_i8259A = {
+	name:	       	"i8259A",
+	bus_id:		"0020",
+	parent:		&device_sys,
+	driver:		&i8249A_devdrv,
+};
+
+#define __init /* Do not want make this init-only */
+
+static void __init init_8259A_devicefs(void)
+{
+	device_register(&device_i8259A);
+}
+
+__initcall(init_8259A_devicefs);
 
 void __init init_8259A(int auto_eoi)
 {
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean/arch/i386/kernel/time.c linux-acpi/arch/i386/kernel/time.c
--- clean/arch/i386/kernel/time.c	Sun Mar 10 20:06:31 2002
+++ linux-acpi/arch/i386/kernel/time.c	Mon Mar 25 22:49:40 2002
@@ -42,6 +42,7 @@
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/module.h>
+#include <linux/device.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -635,6 +636,19 @@
 bad_ctc:
 	return 0;
 }
+
+static struct device device_i8253 = {
+	name:		"i8253",
+	bus_id:		"0040",
+	parent:		&device_sys
+};
+
+static void time_init_driverfs(void)
+{
+	device_register(&device_i8253);
+}
+
+device_initcall(time_init_driverfs);
 
 void __init time_init(void)
 {
--- clean/drivers/base/core.c	Thu Mar 21 11:35:57 2002
+++ linux-acpi/drivers/base/core.c	Tue Mar 26 18:02:16 2002
@@ -19,11 +19,23 @@
 # define DBG(x...)
 #endif
 
-static struct device device_root = {
+struct device device_root = {
 	bus_id:		"root",
 	name:		"System root",
 };
 
+struct device device_sys = {
+	bus_id:		"sys",
+	name:		"Bus for motherboard devices",
+	parent:		&device_root,
+};
+
+struct device device_legacy = {
+	bus_id:		"legacy",
+	name:		"Bus for devices on southbridge/X-BUS/ISA",
+	parent:		&device_root,
+};
+
 int (*platform_notify)(struct device * dev) = NULL;
 int (*platform_notify_remove)(struct device * dev) = NULL;
 
@@ -119,9 +131,89 @@
 	put_device(dev->parent);
 }
 
+static int __device_suspend(struct device * root, u32 state, u32 level, int depth)
+{
+	list_t	* node, * next;
+	struct device * child;
+	int error = 0;
+
+	if (depth>7)
+		panic("Device tree too deep");
+ 
+	spin_lock(&device_lock);
+	list_for_each_safe(node,next,&root->children) {
+		child = list_entry(node,struct device, node);
+ 
+		get_device(child);
+		spin_unlock(&device_lock);
+		__device_suspend(child, state, level, depth+1);
+
+		if(child->driver && child->driver->suspend)
+			error = child->driver->suspend(child, state, level);
+
+		put_device(child);
+		spin_lock(&device_lock);
+ 
+		if (error)
+			break;
+	}
+	spin_unlock(&device_lock);
+	return error;
+}
+
+
+static int __device_resume(struct device * root, u32 level, int depth)
+{
+	list_t	* node, * next;
+	struct device * child;
+	int error = 0;
+
+	if (depth>7)
+		panic("Device tree too deep");
+ 
+	spin_lock(&device_lock);
+	list_for_each_safe(node,next,&root->children) {
+		child = list_entry(node,struct device, node);
+ 
+		get_device(child);
+		spin_unlock(&device_lock);
+
+		if(child->driver && child->driver->resume)
+			error = child->driver->resume(child, level);
+
+		__device_resume(child, level, depth+1);
+
+		put_device(child);
+		spin_lock(&device_lock);
+ 
+		if (error)
+			break;
+	}
+	spin_unlock(&device_lock);
+	return error;
+}
+
+int device_suspend(struct device * root, u32 state, u32 level)
+{
+	__device_suspend(root, state, level, 0);
+}
+
+
+int device_resume(struct device * root, u32 level)
+{
+	__device_resume(root, level, 0);
+}
+
 static int __init device_init_root(void)
 {
-	return device_register(&device_root);
+	int res;
+	res = device_register(&device_root);
+	if (res) return res;
+	res = device_register(&device_sys);
+	if (res) return res;
+	res = device_register(&device_legacy);
+	if (res) return res;
+	return 0;
 }
 
 static int __init device_init(void)
--- clean/drivers/block/floppy.c	Sun Mar 10 20:06:33 2002
+++ linux-acpi/drivers/block/floppy.c	Thu Mar 21 13:19:24 2002
@@ -167,6 +167,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/device.h>
 
 /*
  * PS/2 floppies have much slower step rates than regular floppies.
@@ -4146,11 +4147,16 @@
 
 static int have_no_fdc= -ENODEV;
 
+static struct device device_floppy;
 
 int __init floppy_init(void)
 {
 	int i,unit,drive;
 
+	strcpy(device_floppy.name, "floppy");
+	strcpy(device_floppy.bus_id, "03?0");
+	device_floppy.parent = &device_sys;
+	device_register(&device_floppy);
 
 	raw_cmd = NULL;
 
--- clean/drivers/char/pc_keyb.c	Wed Dec 19 22:38:12 2001
+++ linux-acpi/drivers/char/pc_keyb.c	Mon Mar 25 22:28:54 2002
@@ -35,6 +35,7 @@
 #include <linux/smp_lock.h>
 #include <linux/kd.h>
 #include <linux/pm.h>
+#include <linux/device.h>
 
 #include <asm/keyboard.h>
 #include <asm/bitops.h>
@@ -804,7 +805,7 @@
 }
 #endif /* CONFIG_PSMOUSE */
 
-static char * __init initialize_kbd(void)
+static char * initialize_kbd(void)
 {
 	int status;
 
@@ -1231,3 +1232,34 @@
 }
 
 #endif /* CONFIG_PSMOUSE */
+
+#ifdef CONFIG_PM
+
+static int pckeyb_resume(struct device *dev, u32 level)
+{
+	if (level != RESUME_RESTORE_STATE)
+		return 0;
+
+	initialize_kbd();
+	return 0;
+}
+
+static struct device_driver pckeyb_devdrv = {
+	resume: 	pckeyb_resume,
+};
+
+static struct device device_pckeyb = {
+	name:	       	"pc_keyb",
+	bus_id:		"0060",
+	parent:		&device_sys,
+	driver:		&pckeyb_devdrv,
+};
+
+static void __init init_pckeyb_devicefs(void)
+{
+	device_register(&device_pckeyb);
+}
+
+__initcall(init_pckeyb_devicefs);
+
+#endif
--- clean/include/linux/device.h	Tue Mar  5 21:52:49 2002
+++ linux-acpi/include/linux/device.h	Fri Mar 22 11:45:43 2002
@@ -61,6 +61,7 @@
 
 	int	(*suspend)	(struct device * dev, u32 state, u32 level);
 	int	(*resume)	(struct device * dev, u32 level);
+	int	(*enable_wake) 	(struct device * dev, u32 state, int enable);   /* Enable wake event */
 };
 
 struct device {
@@ -83,7 +84,7 @@
 					   device */
 	void		*driver_data;	/* data private to the driver */
 	void		*platform_data;	/* Platform specific data (e.g. ACPI,
-					   BIOS data relevant to device */
+					   BIOS data relevant to device) */
 
 	u32		current_state;  /* Current operating state. In
 					   ACPI-speak, this is D0-D3, D0
@@ -142,5 +143,11 @@
 }
 
 extern void put_device(struct device * dev);
+extern struct device device_root;
+extern struct device device_legacy;
+extern struct device device_sys;
+
+extern int device_suspend(struct device *dev, u32 state, u32 level);
+extern int device_resume(struct device *dev, u32 level);
 
 #endif /* _DEVICE_H_ */


-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
