Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132533AbQKDHuj>; Sat, 4 Nov 2000 02:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132535AbQKDHu3>; Sat, 4 Nov 2000 02:50:29 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:46347 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S132533AbQKDHuO>;
	Sat, 4 Nov 2000 02:50:14 -0500
Message-ID: <3A03BF93.1C89CCC8@mandrakesoft.com>
Date: Sat, 04 Nov 2000 02:49:39 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, David Hinds <dhinds@valinux.com>,
        randy.dunlap@intel.com, mj@ucw.cz,
        David Brownell <david-b@pacbell.net>
Subject: PATCH 2.4.0.10 v2: Update hotplug
In-Reply-To: <3A012059.D328F190@mandrakesoft.com>
Content-Type: multipart/mixed;
 boundary="------------B40E9504194C1461EEB74D1B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B40E9504194C1461EEB74D1B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Attached is a revised "hotplug update" patch, against 2.4.0-test10. 
It's looking close to submit-able now.

General change description is the same as the first patch, which can be
found at
http://boudicca.tux.org/hypermail/linux-kernel/this-week/0785.html

Changes since the first patch:
* CONFIG_HOTPLUG and CONFIG_KMOD are now totally independent.  It was an
incestuous relationship anyway.
* exec_usermodehelper and call_usermodehelper are now unconditionally
present
* new file Documentation/networking/netdevices.txt describes
/sbin/network usage, and netdevice locking
* usb supports ACTION=$verb again, for compatibility with existing
implementation
* don't use magic numbers for 'insert' value in code, use TRUE/FALSE
* ditch the sbus slot number
* use '/' separate in PCI environment variables, for consistency with
USB
* eliminate EXPORT_SYMBOL(hotplug_path), modules don't need it
* constify netdev_event_name[] array

Now, time to track down that elusive thing called sleep... :)

-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
--------------B40E9504194C1461EEB74D1B
Content-Type: text/plain; charset=us-ascii;
 name="hotplug-2.4.0.10-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hotplug-2.4.0.10-2.patch"

Index: linux_2_4/Documentation/00-INDEX
diff -u linux_2_4/Documentation/00-INDEX:1.1.1.1 linux_2_4/Documentation/00-INDEX:1.1.1.1.34.1
--- linux_2_4/Documentation/00-INDEX:1.1.1.1	Sun Oct 22 12:47:49 2000
+++ linux_2_4/Documentation/00-INDEX	Wed Nov  1 22:50:19 2000
@@ -53,6 +53,8 @@
 	- notes about the floppy tape device driver
 hayes-esp.txt
 	- info on using the Hayes ESP serial driver.
+hotplug.txt
+	- kernel hotplug support
 i386/
 	- directory with info about Linux on the intel ix86 architecture.
 ide.txt
Index: linux_2_4/Documentation/hotplug.txt
diff -u /dev/null linux_2_4/Documentation/hotplug.txt:1.1.2.2
--- /dev/null	Fri Nov  3 23:12:53 2000
+++ linux_2_4/Documentation/hotplug.txt	Fri Nov  3 23:12:03 2000
@@ -0,0 +1,92 @@
+
+Hot-Plug Devices, the Kernel, and You!
+
+
+Introduction
+============
+Kernel version 2.4.0 and later includes native support for hotpluggable
+devices.  This text documents that support.
+
+FIXME: turn this random collection of notes into a real document
+
+Supported hot-plug buses:  CardBus (in the PCI subsystem), USB.
+
+Hot-plug code is conditionally included when CONFIG_HOTPLUG is enabled
+in 'make config'.  CONFIG_HOTPLUG now requires CONFIG_KMOD, so it is
+automatically defined when CONFIG_HOTPLUG is enabled.
+
+
+/sbin/hotplug
+=============
+When hotpluggable hardware devices are added or removed, /sbin/hotplug
+is executed by the kernel.  The usage of /sbin/hotplug is as follows:
+
+	/sbin/hotplug [bus] [event]
+
+[bus] - The bus on which the hotpluggable event occurred.  Supported
+bus types are:
+
+	usb	- USB
+	pci	- PCI-compatible hot-plug:  CardBus
+
+[event] - Type of hot-plug event
+
+	add	- Device insertion
+	del	- Device removal
+
+In addition to the standard arguments passed to /sbin/hotplug as
+described above, each bus has its own set of environment variables
+which are passed to the program.
+
+hotplug pci env vars
+--------------------
+HOME=/
+	Hardcoded value.
+PATH=/sbin:/bin:/usr/sbin:/usr/bin
+	Hardcoded value.
+PCI_CLASS=$CLASS
+	$CLASS - PCI device class, in hexidecimal
+PCI_ID=$VENDOR/$DEVICE
+	$VENDOR	- 16-bit PCI device vendor id, in hexidecimal
+	$DEVICE	- 16-bit PCI device id, in hexidecimal
+PCI_SUBSYS_ID=$VENDOR/$DEVICE
+	$VENDOR	- 16-bit PCI device subsystem vendor id, in hexidecimal
+	$DEVICE	- 16-bit PCI device subsystem device id, in hexidecimal
+PCI_BUS_ID=$BUS/$SLOT/$FUNC
+	$BUS	- PCI bus number, in decimal
+	$SLOT	- PCI device slot, decoded from devfn, in decimal
+	$FUNC	- PCI device function, decoded from devfn, in decimal
+
+
+hotplug usb env vars
+--------------------
+HOME=/
+	Hardcoded value.
+PATH=/sbin:/bin:/usr/sbin:/usr/bin
+	Hardcoded value.
+DEBUG=kernel
+	Hardcoded value.  Only present if USB is in debug mode
+DEVFS=/proc/bus/usb
+	Hardcoded value.  Only present if CONFIG_USB_DEVICEFS is set.
+DEVICE=/proc/bus/usb/$BUS/$DEVICE
+	Indicates the assigned USB device node for the USB device.
+	Only present if CONFIG_USB_DEVICEFS is set.
+	$BUS	- USB bus number
+	$DEVICE	- USB device number
+PRODUCT=$VENDOR/$PRODUCT/$DEVICE
+	USB device identification info.
+	$VENDOR	- USB vendor id, in hexadecimal
+	$PRODUCT- USB product ID, in hexadecimal
+	$DEVICE	- Binary-coded decimal device number
+TYPE=$CLASS/$SUB/$PROTO
+	Only present if device class is non-zero.
+	$CLASS	- USB device class.
+	$SUB	- USB device sub-class.
+	$PROTO	- USB device protocol number.
+INTERFACE=$CLASS/$SUB/$PROTO
+	Only present if device class is zero.
+	Only the first interface (interface 0) is presented.
+	$CLASS	- USB interface 0 class.
+	$SUB	- USB interface 0 sub-class.
+	$PROTO	- USB interface 0 protocol number.
+
Index: linux_2_4/Documentation/networking/00-INDEX
diff -u linux_2_4/Documentation/networking/00-INDEX:1.1.1.1 linux_2_4/Documentation/networking/00-INDEX:1.1.1.1.34.2
--- linux_2_4/Documentation/networking/00-INDEX:1.1.1.1	Sun Oct 22 12:48:03 2000
+++ linux_2_4/Documentation/networking/00-INDEX	Fri Nov  3 23:12:03 2000
@@ -54,10 +54,14 @@
 	- Behaviour of cards under Multicast
 ncsa-telnet
 	- notes on how NCSA telnet (DOS) breaks with MTU discovery enabled.
+netdevices.txt
+	- notes on developing and using network devices
 net-modules.txt
 	- info and "insmod" parameters for all network driver modules.
 policy-routing.txt
 	- IP policy-based routing
+proc-net-if.txt
+	- Description of /proc/net/if/* contents
 pt.txt
 	- the Gracilis Packetwin AX.25 device driver
 routing.txt
Index: linux_2_4/Documentation/networking/netdevices.txt
diff -u /dev/null linux_2_4/Documentation/networking/netdevices.txt:1.1.2.1
--- /dev/null	Fri Nov  3 23:12:55 2000
+++ linux_2_4/Documentation/networking/netdevices.txt	Fri Nov  3 23:12:03 2000
@@ -0,0 +1,69 @@
+
+Network Devices, the Kernel, and You!
+
+
+Introduction
+============
+The following is a random collection of documentation regarding
+network devices.
+
+
+/sbin/network
+=============
+When network devices (interfaces) are added or removed, /sbin/network
+is executed by the kernel.  The usage of /sbin/network is as follows:
+
+	/sbin/network [netdev-event] [interface]
+
+[netdev-event] - any one of the follow one-word ASCII strings:
+
+	register	- New device [interface] was just added
+	unregister	- Device [interface] was just removed
+
+/sbin/network is executed by the kernel when all such events occur --
+after bootup.  Register and un-register events which occur during
+bootup, including initcalls, do not cause /sbin/network to be executed.
+
+The return value of /sbin/network is ignored by the kernel, and the
+file does not have to exist.  No errors or warnings will be issued
+by the kernel is /sbin/network execution fails in any way.
+
+Developers can change the events which cause /sbin/network to be
+executed in net/core/dev.c, netdev_event_names[] array.
+
+
+struct net_device synchronization rules
+=======================================
+dev->open:
+	Locking: Inside rtnl_lock() semaphore.
+	Sleeping: OK
+
+dev->stop:
+	Locking: Inside rtnl_lock() semaphore.
+	Sleeping: OK
+
+dev->do_ioctl:
+	Locking: Inside rtnl_lock() semaphore.
+	Sleeping: OK
+
+dev->get_stats:
+	Locking: Inside dev_base_lock spinlock.
+	Sleeping: NO
+
+dev->hard_start_xmit:
+	Locking: Inside dev->xmit_lock spinlock.
+	Sleeping: NO[1]
+
+dev->tx_timeout:
+	Locking: Inside dev->xmit_lock spinlock.
+	Sleeping: NO[1]
+
+dev->set_multicast_list:
+	Locking: Inside dev->xmit_lock spinlock.
+	Sleeping: NO[1]
+
+
+NOTE [1]: On principle, you should not sleep when a spinlock is held.
+However, since this spinlock is per-net-device, we only block ourselves
+if we sleep, so the effect is mitigated.
+
Index: linux_2_4/Documentation/networking/proc-net-if.txt
diff -u /dev/null linux_2_4/Documentation/networking/proc-net-if.txt:1.1.2.1
--- /dev/null	Fri Nov  3 23:12:55 2000
+++ linux_2_4/Documentation/networking/proc-net-if.txt	Wed Nov  1 23:04:19 2000
@@ -0,0 +1,20 @@
+Contents of /proc/net/if/*:
+
+/proc/net/if is a container for per-interface procfs information.
+Each interface has its own directory, which contains the following
+pseudo-files:
+
+businfo
+	- Outputs a bus-specific string describing the hardware device
+	which owns this network interface.  Zero bytes are output if
+	no hardware info is associated with the network device.
+
+Examples:
+
+	$ cat /proc/net/if/eth0/businfo
+	PCI bus 0 devfn 0
+	$
+
+	$ cat /proc/net/if/lo/businfo
+	$
+
Index: linux_2_4/drivers/net/epic100.c
diff -u linux_2_4/drivers/net/epic100.c:1.1.1.6 linux_2_4/drivers/net/epic100.c:1.1.1.6.18.2
--- linux_2_4/drivers/net/epic100.c:1.1.1.6	Sun Oct 22 14:55:54 2000
+++ linux_2_4/drivers/net/epic100.c	Wed Nov  1 22:50:19 2000
@@ -491,6 +491,10 @@
 	dev->watchdog_timeo = TX_TIMEOUT;
 	dev->tx_timeout = &epic_tx_timeout;
 
+	dev->bus_info.u.pci.pdev = pdev;
+	wmb();
+	dev->bus_info.bus_type = BUSINFO_PCI;
+
 	return 0;
 
 #ifndef USE_IO_OPS
Index: linux_2_4/drivers/pci/pci.c
diff -u linux_2_4/drivers/pci/pci.c:1.1.1.6 linux_2_4/drivers/pci/pci.c:1.1.1.6.6.3
--- linux_2_4/drivers/pci/pci.c:1.1.1.6	Fri Oct 27 00:45:05 2000
+++ linux_2_4/drivers/pci/pci.c	Fri Nov  3 23:12:03 2000
@@ -20,6 +20,8 @@
 #include <linux/ioport.h>
 #include <linux/spinlock.h>
 #include <linux/pm.h>
+#include <linux/businfo.h>
+#include <linux/kmod.h>		/* for hotplug_path */
 
 #include <asm/page.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
@@ -343,6 +345,47 @@
 
 #ifdef CONFIG_HOTPLUG
 
+#ifndef FALSE
+#define FALSE 0
+#define TRUE (!FALSE)
+#endif
+
+static void
+run_sbin_hotplug(struct pci_dev *pdev, int insert)
+{
+	char *argv[4], *envp[6];
+	char id[32], sub_id[32], bus_id[32], class_id[32];
+	int i;
+
+	if (!hotplug_path[0])
+		return;
+
+	sprintf(class_id, "PCI_CLASS=%X", pdev->class >> 8);
+	sprintf(id, "PCI_ID=%X/%X", pdev->vendor, pdev->device);
+	sprintf(sub_id, "PCI_SUBSYS_ID=%X/%X", pdev->subsystem_vendor, pdev->subsystem_device);
+	sprintf(bus_id, "PCI_BUS_ID=%d/%d/%d", pdev->bus->number,
+		PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
+
+	i = 0;
+	argv[i++] = hotplug_path;
+	argv[i++] = "pci";
+	argv[i++] = insert ? "add" : "del";
+	argv[i] = 0;
+
+	i = 0;
+	/* minimal command environment */
+	envp[i++] = "HOME=/";
+	envp[i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
+	
+	/* other stuff we want to pass to /sbin/hotplug */
+	envp[i++] = id;
+	envp[i++] = sub_id;
+	envp[i++] = bus_id;
+	envp[i] = 0;
+
+	call_usermodehelper (argv [0], argv, envp);
+}
+
 void
 pci_insert_device(struct pci_dev *dev, struct pci_bus *bus)
 {
@@ -358,9 +401,13 @@
 		if (drv->remove && pci_announce_device(drv, dev))
 			break;
 	}
+
+	/* notify userspace of new hotplug device */
+	run_sbin_hotplug(dev, TRUE);
 }
 
-static void pci_free_resources(struct pci_dev *dev)
+static void
+pci_free_resources(struct pci_dev *dev)
 {
 	int i;
 
@@ -385,6 +432,9 @@
 #ifdef CONFIG_PROC_FS
 	pci_proc_detach_device(dev);
 #endif
+
+	/* notify userspace of hotplug device removal */
+	run_sbin_hotplug(dev, FALSE);
 }
 
 #endif
@@ -1096,6 +1146,24 @@
 	return 0;
 }
 #endif
+
+/*
+ * format for ASCII PCI device identifiers:
+ *	PCI bus A slot B func C
+ * A - PCI device's bus number
+ * B - PCI device's slot number
+ * C - PCI device function's function number
+ */
+void sprintf_pci_businfo (char *buf, struct bus_info *bi)
+{
+	if (!bi->u.pci.pdev)
+		buf[0] = 0;
+	else
+		sprintf (buf, "PCI bus %d slot %d func %d",
+			 bi->u.pci.pdev->bus->number,
+			 PCI_SLOT(bi->u.pci.pdev->devfn),
+			 PCI_FUNC(bi->u.pci.pdev->devfn));
+}
 
 void __init pci_init(void)
 {
Index: linux_2_4/drivers/sbus/sbus.c
diff -u linux_2_4/drivers/sbus/sbus.c:1.1.1.1 linux_2_4/drivers/sbus/sbus.c:1.1.1.1.34.2
--- linux_2_4/drivers/sbus/sbus.c:1.1.1.1	Sun Oct 22 12:44:03 2000
+++ linux_2_4/drivers/sbus/sbus.c	Fri Nov  3 23:12:03 2000
@@ -9,6 +9,7 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/businfo.h>
 
 #include <asm/system.h>
 #include <asm/sbus.h>
@@ -546,4 +547,21 @@
 		clock_probe();
 	}
 #endif
+}
+
+
+/*
+ * format for ASCII SBUS device identifiers:
+ *	SBUS bus A dev B
+ * A - OBP node of SBUS
+ * B - OBP node of this device
+ */
+void sprintf_sbus_businfo (char *buf, struct bus_info *bi)
+{
+	if (!bi->u.sbus.bus || !bi->u.sbus.dev)
+		buf[0] = 0;
+	else
+		sprintf (buf, "SBUS bus %d dev %d",
+			 bi->u.sbus.bus->prom_node,
+			 bi->u.sbus.dev->prom_node);
 }
Index: linux_2_4/drivers/usb/usb.c
diff -u linux_2_4/drivers/usb/usb.c:1.1.1.12 linux_2_4/drivers/usb/usb.c:1.1.1.12.2.3
--- linux_2_4/drivers/usb/usb.c:1.1.1.12	Tue Oct 31 13:28:21 2000
+++ linux_2_4/drivers/usb/usb.c	Fri Nov  3 23:12:04 2000
@@ -574,7 +574,7 @@
 }
 
 
-#if	defined(CONFIG_KMOD) && defined(CONFIG_HOTPLUG)
+#ifdef CONFIG_HOTPLUG
 
 /*
  * USB hotplugging invokes what /proc/sys/kernel/hotplug says
@@ -623,6 +623,13 @@
 	return retval;
 }
 
+
+/* defined for users of call_policy() */
+#ifndef FALSE
+#define FALSE 0
+#define TRUE (!FALSE)
+#endif
+
 /*
  * This invokes a user mode policy agent, typically helping to load driver
  * or other modules, configure the device, or both.
@@ -639,9 +646,9 @@
  * cases, we know no other thread can recycle our address, since we must
  * already have been serialized enough to prevent that.
  */
-static void call_policy (char *verb, struct usb_device *dev)
+static void call_policy (struct usb_device *dev, int insert)
 {
-	char *argv [3], **envp, *buf, *scratch;
+	char *argv [4], *envp[8], *buf, *scratch;
 	int i = 0, value;
 
 	if (!hotplug_path [0])
@@ -652,27 +659,24 @@
 	}
 	if (!current->fs->root) {
 		/* statically linked USB is initted rather early */
-		dbg ("call_policy %s, num %d -- no FS yet", verb, dev->devnum);
+		dbg ("call_policy %s, num %d -- no FS yet",
+		     insert ? "add" : "del", dev->devnum);
 		return;
 	}
 	if (dev->devnum < 0) {
 		dbg ("device already deleted ??");
 		return;
 	}
-	if (!(envp = (char **) kmalloc (20 * sizeof (char *), GFP_KERNEL))) {
-		dbg ("enomem");
-		return;
-	}
 	if (!(buf = kmalloc (256, GFP_KERNEL))) {
-		kfree (envp);
 		dbg ("enomem2");
 		return;
 	}
 
-	/* only one standardized param to hotplug command: type */
+	/* args: /sbin/hotplug [bus type] [add/del] */
 	argv [0] = hotplug_path;
 	argv [1] = "usb";
-	argv [2] = 0;
+	argv [2] = insert ? "add" : "del";
+	argv [3] = 0;
 
 	/* minimal command environment */
 	envp [i++] = "HOME=/";
@@ -689,7 +693,7 @@
 
 	/* action:  add, remove */
 	envp [i++] = scratch;
-	scratch += sprintf (scratch, "ACTION=%s", verb) + 1;
+	scratch += sprintf (scratch, "ACTION=%s", insert ? "add" : "remove") + 1;
 
 #ifdef	CONFIG_USB_DEVICEFS
 	/* If this is available, userspace programs can directly read
@@ -742,7 +746,6 @@
 	dbg ("kusbd: %s %s %d", argv [0], verb, dev->devnum);
 	value = call_usermodehelper (argv [0], argv, envp);
 	kfree (buf);
-	kfree (envp);
 	if (value != 0)
 		dbg ("kusbd policy returned 0x%x", value);
 }
@@ -750,10 +753,10 @@
 #else
 
 static inline void
-call_policy (char *verb, struct usb_device *dev)
+call_policy (struct usb_device *dev, int insert)
 { } 
 
-#endif	/* KMOD && HOTPLUG */
+#endif /* CONFIG_HOTPLUG */
 
 
 /*
@@ -1520,7 +1523,7 @@
 	}
 
 	/* Let policy agent unload modules etc */
-	call_policy ("remove", dev);
+	call_policy (dev, FALSE);
 
 	/* Free the device number and remove the /proc/bus/usb entry */
 	if (dev->devnum > 0) {
@@ -2037,7 +2040,7 @@
 	usb_find_drivers(dev);
 
 	/* userspace may load modules and/or configure further */
-	call_policy ("add", dev);
+	call_policy (dev, TRUE);
 
 	return 0;
 }
Index: linux_2_4/fs/proc/Makefile
diff -u linux_2_4/fs/proc/Makefile:1.1.1.1 linux_2_4/fs/proc/Makefile:1.1.1.1.34.1
--- linux_2_4/fs/proc/Makefile:1.1.1.1	Sun Oct 22 12:35:07 2000
+++ linux_2_4/fs/proc/Makefile	Tue Oct 31 14:43:34 2000
@@ -9,7 +9,8 @@
 
 O_TARGET := proc.o
 O_OBJS   := inode.o root.o base.o generic.o array.o \
-		kmsg.o proc_tty.o proc_misc.o kcore.o
+		kmsg.o proc_tty.o proc_misc.o kcore.o \
+		businfo.o
 OX_OBJS  := procfs_syms.o
 M_OBJS   := 
 
Index: linux_2_4/fs/proc/businfo.c
diff -u /dev/null linux_2_4/fs/proc/businfo.c:1.1.6.2
--- /dev/null	Fri Nov  3 23:13:25 2000
+++ linux_2_4/fs/proc/businfo.c	Wed Nov  1 22:50:19 2000
@@ -0,0 +1,116 @@
+/*
+ * kernel/businfo.c
+ * Copyright 2000 Jeff Garzik <jgarzik@mandrakesoft.com>
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ */
+
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/pci.h>
+#include <linux/businfo.h>
+
+
+extern void sprintf_pci_businfo (char *buf, struct bus_info *bi);
+extern void sprintf_sbus_businfo (char *buf, struct bus_info *bi);
+
+
+#ifdef CONFIG_PROC_FS
+
+
+/* normally we put sprintf_$bus_businfo in a bus-specific module.  However there
+ * is no drivers/isa, so as a special case we put the following function here.
+ */
+#ifdef CONFIG_ISA
+/*
+ * format for ASCII ISA device identifiers:
+ *	ISA mem A irq B dma C port D
+ * A - An occupied 24-bit ISA memory area, in hexidecimal, or zero.
+ * B - An assigned irq number, in decimal, or zero.
+ * C - An assigned dma channel number, in decimal, or zero.
+ * D - The base of an I/O port range (as used with inb/outb),
+ *     in hexidecimal, or zero.
+ */
+static void sprintf_isa_businfo (char *buf, struct bus_info *bi)
+{
+	if (!bi->u.isa.mem && !bi->u.isa.irq &&
+	    !bi->u.isa.dma && !bi->u.isa.port)
+		buf[0] = 0;
+	else
+		sprintf (buf, "ISA mem %X irq %d dma %d port %X",
+			 bi->u.isa.mem,
+			 bi->u.isa.irq,
+			 bi->u.isa.dma,
+			 bi->u.isa.port);
+}
+#endif /* CONFIG_ISA */
+
+
+/* rule for userspace users: zero output is a valid return,
+ * which implies the bus info is unknown or unavailable
+ */
+int businfo_read_proc (char *buf, char **start, off_t fpos,
+		       int length, int *eof, struct bus_info *bi)
+{
+	size_t len;
+
+	switch (bi->bus_type) {
+#ifdef CONFIG_ISA
+	case BUSINFO_ISA:
+		sprintf_isa_businfo (buf, bi);
+		break;
+#endif
+
+#ifdef CONFIG_PCI
+	case BUSINFO_PCI:
+		sprintf_pci_businfo (buf, bi);
+		break;
+#endif
+
+#ifdef CONFIG_SBUS
+	case BUSINFO_SBUS:
+		sprintf_sbus_businfo (buf, bi);
+		break;
+#endif
+
+	default:
+		buf[0] = 0;
+		break;
+	}
+
+	len = strlen (buf);
+
+	if (fpos >= len) {
+		*start = buf;
+		*eof = 1;
+		return 0;
+	}
+
+	*start = buf + fpos;
+        if ((len -= fpos) > length)
+                return length;
+        *eof = 1;
+        return len;
+}
+
+
+#else /* CONFIG_PROC_FS */
+
+
+int businfo_read_proc (char *buf, char **start, off_t fpos,
+		       int length, int *eof, struct bus_info *bi)
+{
+	*eof = 1;
+	return 0;
+}
+
+
+#endif /* CONFIG_PROC_FS */
+
+EXPORT_SYMBOL(businfo_read_proc);
Index: linux_2_4/include/linux/businfo.h
diff -u /dev/null linux_2_4/include/linux/businfo.h:1.1.6.2
--- /dev/null	Fri Nov  3 23:13:26 2000
+++ linux_2_4/include/linux/businfo.h	Wed Nov  1 22:50:19 2000
@@ -0,0 +1,64 @@
+/*
+ * include/linux/businfo.h
+ * Copyright 2000 Jeff Garzik <jgarzik@mandrakesoft.com>
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ */
+
+#ifndef __LINUX_BUSINFO_H__
+#define __LINUX_BUSINFO_H__
+
+
+/* this is the only include allowed */
+#include <linux/types.h>
+
+
+enum {
+	BUSINFO_NULL = 0,	/* unknown or error */
+	BUSINFO_ISA,
+	BUSINFO_PCI,
+	BUSINFO_SBUS,
+};
+
+
+struct isa_bus_info {
+	u32 mem;		/* 24-bit, most significant 8 bits ignored */
+	u8 irq;
+	u8 dma;
+	u16 port;
+};
+
+
+struct pci_dev;
+struct pci_bus_info {
+	struct pci_dev *pdev;
+};
+
+
+struct sbus_bus;
+struct sbus_dev;
+struct sbus_bus_info {
+	struct sbus_bus *bus;
+	struct sbus_dev *dev;
+};
+
+
+struct bus_info {
+	unsigned int bus_type;
+	union {
+		struct isa_bus_info isa;
+		struct pci_bus_info pci;
+		struct sbus_bus_info sbus;
+	} u;
+};
+
+
+
+extern int businfo_read_proc (char *buf, char **start, off_t fpos,
+			      int length, int *eof, struct bus_info *bi);
+
+#endif /* __LINUX_BUSINFO_H__ */
Index: linux_2_4/include/linux/netdevice.h
diff -u linux_2_4/include/linux/netdevice.h:1.1.1.8 linux_2_4/include/linux/netdevice.h:1.1.1.8.2.2
--- linux_2_4/include/linux/netdevice.h:1.1.1.8	Tue Oct 31 13:19:43 2000
+++ linux_2_4/include/linux/netdevice.h	Wed Nov  1 22:50:19 2000
@@ -28,6 +28,7 @@
 #include <linux/if.h>
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
+#include <linux/businfo.h>
 
 #include <asm/atomic.h>
 #include <asm/cache.h>
@@ -261,6 +262,9 @@
 	int			(*init)(struct net_device *dev);
 
 	/* ------- Fields preinitialized in Space.c finish here ------- */
+
+	/* Hardware bus identity, exported to userspace */
+	struct bus_info		bus_info;
 
 	struct net_device	*next_sched;
 
Index: linux_2_4/init/main.c
diff -u linux_2_4/init/main.c:1.1.1.10 linux_2_4/init/main.c:1.1.1.10.6.1
--- linux_2_4/init/main.c:1.1.1.10	Fri Oct 27 00:37:39 2000
+++ linux_2_4/init/main.c	Wed Nov  1 22:50:19 2000
@@ -95,6 +95,7 @@
 extern void signals_init(void);
 extern void bdev_init(void);
 extern int init_pcmcia_ds(void);
+extern void net_notifier_init(void);
 
 extern void free_initmem(void);
 extern void filesystem_setup(void);
@@ -710,6 +711,13 @@
 #ifdef CONFIG_PCMCIA
 	init_pcmcia_ds();		/* Do this last */
 #endif
+
+	/* do this after other 'do this last' stuff, because we want
+	 * to minimize spurious executions of /sbin/network
+	 * during boot-up
+	 */
+	net_notifier_init();
+
 	/* Mount the root filesystem.. */
 	mount_root();
 
Index: linux_2_4/kernel/Makefile
diff -u linux_2_4/kernel/Makefile:1.1.1.3 linux_2_4/kernel/Makefile:1.1.1.3.24.2
--- linux_2_4/kernel/Makefile:1.1.1.3	Sun Oct 22 14:00:25 2000
+++ linux_2_4/kernel/Makefile	Fri Nov  3 23:12:04 2000
@@ -12,14 +12,10 @@
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
 	    sysctl.o acct.o capability.o ptrace.o timer.o user.o
 
-OX_OBJS  += signal.o sys.o
+OX_OBJS  += signal.o sys.o kmod.o
 
 ifeq ($(CONFIG_UID16),y)
 O_OBJS += uid16.o
-endif
-
-ifeq ($(CONFIG_KMOD),y)
-O_OBJS += kmod.o
 endif
 
 ifeq ($(CONFIG_MODULES),y)
Index: linux_2_4/kernel/kmod.c
diff -u linux_2_4/kernel/kmod.c:1.1.1.6 linux_2_4/kernel/kmod.c:1.1.1.6.18.1
--- linux_2_4/kernel/kmod.c:1.1.1.6	Sun Oct 22 14:52:47 2000
+++ linux_2_4/kernel/kmod.c	Fri Nov  3 23:12:04 2000
@@ -16,17 +16,13 @@
 #define __KERNEL_SYSCALLS__
 
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/unistd.h>
 #include <linux/smp_lock.h>
 
 #include <asm/uaccess.h>
 
-/*
-	modprobe_path is set via /proc/sys.
-*/
-char modprobe_path[256] = "/sbin/modprobe";
-
 extern int max_threads;
 
 static inline void
@@ -130,6 +126,13 @@
 	return 0;
 }
 
+#ifdef CONFIG_KMOD
+
+/*
+	modprobe_path is set via /proc/sys.
+*/
+char modprobe_path[256] = "/sbin/modprobe";
+
 static int exec_modprobe(void * module_name)
 {
 	static char * envp[] = { "HOME=/", "TERM=linux", "PATH=/sbin:/usr/sbin:/bin:/usr/bin", NULL };
@@ -226,6 +229,7 @@
 	}
 	return 0;
 }
+#endif /* CONFIG_KMOD */
 
 
 #ifdef CONFIG_HOTPLUG
@@ -247,6 +251,8 @@
 */
 char hotplug_path[256] = "/sbin/hotplug";
 
+#endif /* CONFIG_HOTPLUG */
+
 
 static int exec_helper (void *arg)
 {
@@ -286,5 +292,10 @@
 	return retval;
 }
 
+EXPORT_SYMBOL(exec_usermodehelper);
+EXPORT_SYMBOL(call_usermodehelper);
+
+#ifdef CONFIG_KMOD
+EXPORT_SYMBOL(request_module);
 #endif
 
Index: linux_2_4/kernel/ksyms.c
diff -u linux_2_4/kernel/ksyms.c:1.1.1.10 linux_2_4/kernel/ksyms.c:1.1.1.10.4.1
--- linux_2_4/kernel/ksyms.c:1.1.1.10	Mon Oct 30 11:37:29 2000
+++ linux_2_4/kernel/ksyms.c	Fri Nov  3 23:12:04 2000
@@ -71,15 +71,6 @@
 #endif
 
 
-#ifdef CONFIG_KMOD
-EXPORT_SYMBOL(request_module);
-EXPORT_SYMBOL(exec_usermodehelper);
-#ifdef CONFIG_HOTPLUG
-EXPORT_SYMBOL(hotplug_path);
-EXPORT_SYMBOL(call_usermodehelper);
-#endif
-#endif
-
 #ifdef CONFIG_MODULES
 EXPORT_SYMBOL(get_module_symbol);
 EXPORT_SYMBOL(put_module_symbol);
Index: linux_2_4/kernel/sysctl.c
diff -u linux_2_4/kernel/sysctl.c:1.1.1.7 linux_2_4/kernel/sysctl.c:1.1.1.7.2.1
--- linux_2_4/kernel/sysctl.c:1.1.1.7	Tue Oct 31 13:19:30 2000
+++ linux_2_4/kernel/sysctl.c	Fri Nov  3 23:12:04 2000
@@ -54,10 +54,10 @@
 
 #ifdef CONFIG_KMOD
 extern char modprobe_path[];
+#endif
 #ifdef CONFIG_HOTPLUG
 extern char hotplug_path[];
 #endif
-#endif
 #ifdef CONFIG_CHR_DEV_SG
 extern int sg_big_buff;
 #endif
@@ -188,10 +188,10 @@
 #ifdef CONFIG_KMOD
 	{KERN_MODPROBE, "modprobe", &modprobe_path, 256,
 	 0644, NULL, &proc_dostring, &sysctl_string },
+#endif
 #ifdef CONFIG_HOTPLUG
 	{KERN_HOTPLUG, "hotplug", &hotplug_path, 256,
 	 0644, NULL, &proc_dostring, &sysctl_string },
-#endif
 #endif
 #ifdef CONFIG_CHR_DEV_SG
 	{KERN_SG_BIG_BUFF, "sg-big-buff", &sg_big_buff, sizeof (int),
Index: linux_2_4/net/core/dev.c
diff -u linux_2_4/net/core/dev.c:1.1.1.8 linux_2_4/net/core/dev.c:1.1.1.8.4.3
--- linux_2_4/net/core/dev.c:1.1.1.8	Mon Oct 30 11:39:10 2000
+++ linux_2_4/net/core/dev.c	Fri Nov  3 23:12:04 2000
@@ -2253,6 +2253,23 @@
 	}
 }
 
+/**
+ *	netdev_proc_businfo	- output bus identity for a network device
+ *
+ *	This function is static inline because using its address in
+ *	create_proc_read_entry() call below forces it un-inlined...
+ *	Except for the !CONFIG_PROC_FS case, when it goes away completely.
+ *	XXX unverified...
+ */
+static inline int netdev_proc_businfo (char *buf, char **start, off_t fpos,
+				       int length, int *eof, void *data)
+{
+	struct net_device *dev = data;
+	
+	return businfo_read_proc(buf, start, fpos, length, eof, &dev->bus_info);
+}
+
+
 static int dev_boot_phase = 1;
 
 /**
@@ -2276,9 +2293,8 @@
 int register_netdevice(struct net_device *dev)
 {
 	struct net_device *d, **dp;
-#ifdef CONFIG_NET_DIVERT
 	int ret;
-#endif
+	char businfo_fn[32];
 
 	spin_lock_init(&dev->queue_lock);
 	spin_lock_init(&dev->xmit_lock);
@@ -2331,9 +2347,16 @@
 
 	dev->iflink = -1;
 
+	/* register /proc/net/if/???/businfo */
+	/* we purposefully ignore create_proc_read_entry failure */
+	sprintf(businfo_fn, "net/if/%s/businfo", dev->name);
+	create_proc_read_entry(businfo_fn, 0, NULL, netdev_proc_businfo, dev);
+
 	/* Init, if this function is available */
-	if (dev->init && dev->init(dev) != 0)
-		return -EIO;
+	if (dev->init && dev->init(dev) != 0) {
+		ret = -EIO;
+		goto err_out;
+	}
 
 	dev->ifindex = dev_new_index();
 	if (dev->iflink == -1)
@@ -2342,7 +2365,8 @@
 	/* Check for existence, and append to tail of chain */
 	for (dp=&dev_base; (d=*dp) != NULL; dp=&d->next) {
 		if (d == dev || strcmp(d->name, dev->name) == 0) {
-			return -EEXIST;
+			ret = -EEXIST;
+			goto err_out;
 		}
 	}
 	/*
@@ -2371,13 +2395,17 @@
 #ifdef CONFIG_NET_DIVERT
 	ret = alloc_divert_blk(dev);
 	if (ret)
-		return ret;
+		goto err_out;
 #endif /* CONFIG_NET_DIVERT */
 	
 	/* Notify protocols, that a new device appeared. */
 	notifier_call_chain(&netdev_chain, NETDEV_REGISTER, dev);
 
 	return 0;
+
+err_out:
+	remove_proc_entry(businfo_fn, NULL);
+	return ret;
 }
 
 /**
@@ -2423,6 +2451,7 @@
 
 int unregister_netdevice(struct net_device *dev)
 {
+	char businfo_fn[32];
 	unsigned long now, warning_time;
 	struct net_device *d, **dp;
 
@@ -2469,6 +2498,10 @@
 	if (dev->uninit)
 		dev->uninit(dev);
 
+	/* eliminate our /proc/net/if/???/businfo inode */
+	sprintf(businfo_fn, "net/if/%s/businfo", dev->name);
+	remove_proc_entry(businfo_fn, NULL);
+
 	/* Notifier chain MUST detach us from master device. */
 	BUG_TRAP(dev->master==NULL);
 
@@ -2687,4 +2720,64 @@
 	net_device_init();
 
 	return 0;
+}
+
+
+/* Notify userspace when a netdevice event occurs,
+ * by running /sbin/network [event] [interface]
+ * 'event' - an ASCII string indicating the type of event
+ * 'interface' - an ASCII string naming the interface on which
+ *	the event occurred.
+ * Currently reported events are listed in netdev_event_names[].
+ */
+
+/* /sbin/network ONLY executes for events named here */
+static const char *netdev_event_names[] = {
+	[NETDEV_REGISTER]	= "register",
+	[NETDEV_UNREGISTER]	= "unregister",
+};
+
+/* FIXME: make this changeable like hotplug_path */
+char sbin_network_path[256] = "/sbin/network";
+
+static int run_sbin_network(struct notifier_block *this,
+			    unsigned long event, void *ptr)
+{
+	struct net_device *dev = (struct net_device *) ptr;
+	char *argv[4], *envp[3];
+	int i = 0;
+
+	if ((event >= ARRAY_SIZE(netdev_event_names)) ||
+	    !netdev_event_names[event])
+		return NOTIFY_DONE;
+
+	argv[0] = sbin_network_path;
+	argv[1] = netdev_event_names[event];
+	argv[2] = dev->name;
+	argv[3] = 0;
+	
+	/* minimal command environment */
+	envp [i++] = "HOME=/";
+	envp [i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
+	envp [i] = 0;
+	
+	call_usermodehelper (argv [0], argv, envp);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block sbin_network = {
+	notifier_call: run_sbin_network,
+};
+
+/*
+ * called from init/main.c, -after- all the initcalls are complete.
+ * Registers a hook that calls /sbin/network on every netdev
+ * addition and removal.
+ */
+void __init net_notifier_init (void)
+{
+	if (register_netdevice_notifier(&sbin_network))
+		printk (KERN_WARNING "unable to register netdev notifier\n"
+			KERN_WARNING "/sbin/network will not be run.\n");
 }

--------------B40E9504194C1461EEB74D1B--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
