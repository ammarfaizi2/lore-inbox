Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289356AbSAOBpp>; Mon, 14 Jan 2002 20:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289353AbSAOBph>; Mon, 14 Jan 2002 20:45:37 -0500
Received: from air-1.osdl.org ([65.201.151.5]:32648 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S289362AbSAOBpY>;
	Mon, 14 Jan 2002 20:45:24 -0500
Date: Mon, 14 Jan 2002 17:47:15 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: <linux-kernel@vger.kernel.org>
Subject: Defining new section for bus driver init 
Message-ID: <Pine.LNX.4.33.0201141746000.827-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently, in init/main.c, static calls are made to some device
subsystems, like this:

#ifdef CONFIG_PCI
        pci_init();
#endif

By careful examination and a bit of mediatating, I have inferred a few
things about those calls.

They initialize the "root" buses in the system - the buses that hang right
off of the equivalent of the host controller (i.e. north bridge) on $arch.

They are statically called in do_basic_setup() because if they used
__initcall(), it would hard, if not impossible, to guarantee that they are
called before anything else.

The collection of them in init/main.c is ugly, and the model doesn't scale
well.

Attached is a patch that creates a new section for device subsystem init
calls. With it, the root bus init calls are handled just like init calls
- the section consists of a table of function pointers.
device_driver_init() iterates over that table and calls each one.
(device_driver_init() currently happens just before that pci_init() call
above).

What do people think about the concept? I am more than willing to port the
other calls to it, as well add the vmlinux.lds entries (though both are
trivial). I don't have any other hardware to test on, though, besides an
x86 PCI-based system.

I will warn that the name is kinda clumsy, but it's the best that I could
come up with (I wasted my creativity for the day on thinking about
Penelope). I used "subsystem" because I have alterior motives.

In order for a driver to be loaded, there needs to be drivers for the bus
on which it resides loaded, and drivers for the device class to which it
belongs (disk, network, etc) loaded.

Buses that are not currently "root" buses have initcall init calls. All
device classes do, too. And the device-specific drivers are in there, too.
Bus and class drivers need to be loaded before device drivers, and they
do not depend on each other, so it seems that they can be grouped
together in a section and called (like below). Right?

	-pat

diff -Nur linux-2.5.1.orig/arch/i386/vmlinux.lds linux-2.5.1/arch/i386/vmlinux.lds
--- linux-2.5.1.orig/arch/i386/vmlinux.lds	Mon Jul  2 14:40:14 2001
+++ linux-2.5.1/arch/i386/vmlinux.lds	Mon Jan 14 16:50:12 2002
@@ -50,6 +50,11 @@
   __initcall_start = .;
   .initcall.init : { *(.initcall.init) }
   __initcall_end = .;
+
+  __devsubsys_start = .;
+  .devsubsys.init : { *(.devsubsys.init) }
+  __devsubsys_end = .;
+
   . = ALIGN(4096);
   __init_end = .;

diff -Nur linux-2.5.1.orig/drivers/pci/pci.c linux-2.5.1/drivers/pci/pci.c
--- linux-2.5.1.orig/drivers/pci/pci.c	Tue Nov 20 21:53:29 2001
+++ linux-2.5.1/drivers/pci/pci.c	Mon Jan 14 16:57:44 2002
@@ -1929,7 +1929,7 @@
 }


-void __devinit  pci_init(void)
+int __devinit  pci_init(void)
 {
 	struct pci_dev *dev;

@@ -1942,6 +1942,7 @@
 #ifdef CONFIG_PM
 	pm_register(PM_PCI_DEV, 0, pci_pm_callback);
 #endif
+	return 0;
 }

 static int __devinit  pci_setup(char *str)
@@ -1958,6 +1959,8 @@
 	}
 	return 1;
 }
+
+__devsubsys_init(pci_init);

 __setup("pci=", pci_setup);

diff -Nur linux-2.5.1.orig/include/linux/init.h linux-2.5.1/include/linux/init.h
--- linux-2.5.1.orig/include/linux/init.h	Fri Dec 21 16:05:57 2001
+++ linux-2.5.1/include/linux/init.h	Mon Jan 14 16:54:08 2002
@@ -55,6 +55,12 @@
 #define __exitcall(fn)								\
 	static exitcall_t __exitcall_##fn __exit_call = fn

+/* device subsystem initialization */
+extern initcall_t __devsubsys_start, __devsubsys_end;
+
+#define __devsubsys_init(fn) \
+static initcall_t __devsubsys_##fn __devsubsys_call = fn;
+
 /*
  * Used for kernel command line parameter setup
  */
@@ -82,6 +88,7 @@
 #define __initsetup	__attribute__ ((unused,__section__ (".setup.init")))
 #define __init_call	__attribute__ ((unused,__section__ (".initcall.init")))
 #define __exit_call	__attribute__ ((unused,__section__ (".exitcall.exit")))
+#define __devsubsys_call __attribute__ ((unused,__section__ (".devsubsys.init")))

 /* For assembly routines */
 #define __INIT		.section	".text.init","ax"
diff -Nur linux-2.5.1.orig/include/linux/pci.h linux-2.5.1/include/linux/pci.h
--- linux-2.5.1.orig/include/linux/pci.h	Fri Dec 21 16:06:13 2001
+++ linux-2.5.1/include/linux/pci.h	Mon Jan 14 17:32:42 2002
@@ -525,7 +525,7 @@

 /* Generic PCI functions used internally */

-void pci_init(void);
+int pci_init(void);
 int pci_bus_exists(const struct list_head *list, int nr);
 struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata);
 struct pci_bus *pci_alloc_primary_bus(int bus);
diff -Nur linux-2.5.1.orig/init/main.c linux-2.5.1/init/main.c
--- linux-2.5.1.orig/init/main.c	Wed Jan  9 11:03:06 2002
+++ linux-2.5.1/init/main.c	Mon Jan 14 17:35:25 2002
@@ -38,10 +38,6 @@
 #include <asm/ccwcache.h>
 #endif

-#ifdef CONFIG_PCI
-#include <linux/pci.h>
-#endif
-
 #ifdef CONFIG_DIO
 #include <linux/dio.h>
 #endif
@@ -481,9 +477,6 @@
 	/* bring up the device tree */
 	device_driver_init();

-#ifdef CONFIG_PCI
-	pci_init();
-#endif
 #ifdef CONFIG_SBUS
 	sbus_init();
 #endif
diff -Nur linux-2.5.1.orig/kernel/device.c linux-2.5.1/kernel/device.c
--- linux-2.5.1.orig/kernel/device.c	Wed Jan  9 11:03:00 2002
+++ linux-2.5.1/kernel/device.c	Mon Jan 14 17:03:46 2002
@@ -890,6 +890,17 @@
 	return (device_root.dir ? 0 : -EFAULT);
 }

+initcall_t __devsubsys_start, __devsubsys_end;
+
+static void device_subsys_init(void)
+{
+	initcall_t * fn = &__devsubsys_start;
+
+	do {
+		(*fn)();
+	} while (++fn < &__devsubsys_end);
+}
+
 int __init device_driver_init(void)
 {
 	int error = 0;
@@ -910,6 +921,8 @@
 		printk(KERN_ERR "%s: device root init failed!\n", __FUNCTION__);
 		return error;
 	}
+
+	device_subsys_init();

 	DBG("DEV: Done Initialising\n");
 	return error;


