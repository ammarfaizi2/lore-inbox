Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310300AbSCHSMp>; Fri, 8 Mar 2002 13:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310997AbSCHSMg>; Fri, 8 Mar 2002 13:12:36 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:49168 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S310300AbSCHSMT>;
	Fri, 8 Mar 2002 13:12:19 -0500
Date: Fri, 8 Mar 2002 19:04:58 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Driver support for system devices
Message-ID: <20020308180457.GA7045@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This adds devicefs support for motherboard devices. time is going to
need it (to restore time after resume), floppy might be critical too
(it uses DMA, so we *need* it stopped). Please apply,

								Pavel

--- clean.pre/arch/i386/kernel/i8259.c	Fri Mar  8 18:40:34 2002
+++ linux-dm.pre/arch/i386/kernel/i8259.c	Fri Mar  8 00:16:49 2002
@@ -11,6 +11,7 @@
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/kernel_stat.h>
+#include <linux/device.h>
 
 #include <asm/atomic.h>
 #include <asm/system.h>
@@ -332,6 +333,19 @@
 		goto handle_real_irq;
 	}
 }
+
+static struct device device_i8259A = {
+	name:	       	"i8259A",
+	bus_id:		"0020",
+	parent:		&device_sys,
+};
+
+static void __init init_8259A_devicefs(void)
+{
+	device_register(&device_i8259A);
+}
+
+__initcall(init_8259A_devicefs);
 
 void __init init_8259A(int auto_eoi)
 {
--- clean.pre/arch/i386/kernel/time.c	Fri Mar  8 18:40:34 2002
+++ linux-dm.pre/arch/i386/kernel/time.c	Fri Mar  8 00:16:49 2002
@@ -41,6 +41,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/smp.h>
+#include <linux/device.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -634,6 +635,18 @@
 bad_ctc:
 	return 0;
 }
+
+static struct device device_i8253;
+
+static void time_init_driverfs(void)
+{
+	strcpy(device_i8253.name, "i8253");
+	strcpy(device_i8253.bus_id, "0040");
+	device_i8253.parent = &device_sys;
+	device_register(&device_i8253);
+}
+
+__initcall(time_init_driverfs);
 
 void __init time_init(void)
 {
--- clean.pre/drivers/base/core.c	Mon Feb 11 20:50:55 2002
+++ linux-dm.pre/drivers/base/core.c	Fri Mar  8 00:11:00 2002
@@ -24,6 +24,18 @@
 	name:		"System Root",
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
 
@@ -121,7 +133,13 @@
 
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
 }
 
 static int __init device_init(void)
--- clean.pre/drivers/block/floppy.c	Tue Mar  5 21:52:34 2002
+++ linux-dm.pre/drivers/block/floppy.c	Fri Mar  8 00:11:00 2002
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
 
--- clean.pre/include/linux/device.h	Tue Mar  5 21:52:49 2002
+++ linux-dm.pre/include/linux/device.h	Fri Mar  8 00:11:27 2002
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
@@ -142,5 +143,8 @@
 }
 
 extern void put_device(struct device * dev);
+extern struct device device_root;
+extern struct device device_legacy;
+extern struct device device_sys;
 
 #endif /* _DEVICE_H_ */

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
