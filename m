Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129624AbQKBIGg>; Thu, 2 Nov 2000 03:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129686AbQKBIG0>; Thu, 2 Nov 2000 03:06:26 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:62482 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129624AbQKBIGT>;
	Thu, 2 Nov 2000 03:06:19 -0500
Message-ID: <3A012059.D328F190@mandrakesoft.com>
Date: Thu, 02 Nov 2000 03:05:45 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, David Hinds <dhinds@valinux.com>,
        randy.dunlap@intel.com, mj@ucw.cz
Subject: PATCH 2.4.0.10: Update hotplug
Content-Type: multipart/mixed;
 boundary="------------D5FE456A5EBA42DF2A952029"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D5FE456A5EBA42DF2A952029
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Note - this is just an RFC patch, do not apply.  It compiles, but is not
tested.

Attached is a patch against 2.4.0-test10 which updates the kernel's
hotplug capabilities per recent discussions (both public and private).

Major changes:
* pci: Execute /sbin/hotplug for each hotplug device insertion or
removal
* net: Export network device hardware info to userspace as
/proc/net/if/$IF/businfo
* net: Execute /sbin/network for each net device register/unregister

Minor changes:
* kbuild: CONFIG_HOTPLUG now requires CONFIG_KMOD
* epic100: demonstration of how a net device exports its bus info
* procfs: add standard method of exporting bus info to userspace. 
Currently ISA, PCI, and SBUS are supported.
* pci: support businfo
* sparc: support businfo
* usb: update /sbin/hotplug execution to pass event type (verb) as
standardized cmd line arg

DaveM - netdevice.h seems like the best place to include businfo.h. 
Since it doesn't include anything but linux/types.h, that should
eliminate any worry about a nightmare of nested includes...

Note - the patch to include/linux/pci.h will go away, that is a remnant
of an earlier change.  But it is included as you may need it to compile.

-- 
Jeff Garzik             | "Mind if I drive?"  -Sam
Building 1024           | "Not if you don't mind me clawing at the
MandrakeSoft            |  dash and shrieking like a cheerleader."
                        |                     -Max
--------------D5FE456A5EBA42DF2A952029
Content-Type: text/plain; charset=us-ascii;
 name="hotplug-2.4.0.10.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hotplug-2.4.0.10.patch"

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
diff -u /dev/null linux_2_4/Documentation/hotplug.txt:1.1.2.1
--- /dev/null	Wed Nov  1 23:27:35 2000
+++ linux_2_4/Documentation/hotplug.txt	Wed Nov  1 22:50:19 2000
@@ -0,0 +1,111 @@
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
+PCI_ID=$VENDOR:$DEVICE
+	$VENDOR	- 16-bit PCI device vendor id, in hexidecimal
+	$DEVICE	- 16-bit PCI device id, in hexidecimal
+PCI_SUBSYS_ID=$VENDOR:$DEVICE
+	$VENDOR	- 16-bit PCI device subsystem vendor id, in hexidecimal
+	$DEVICE	- 16-bit PCI device subsystem device id, in hexidecimal
+PCI_BUS_ID=$BUS:$SLOT:$FUNC
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
diff -u linux_2_4/Documentation/networking/00-INDEX:1.1.1.1 linux_2_4/Documentation/networking/00-INDEX:1.1.1.1.34.1
--- linux_2_4/Documentation/networking/00-INDEX:1.1.1.1	Sun Oct 22 12:48:03 2000
+++ linux_2_4/Documentation/networking/00-INDEX	Wed Nov  1 23:04:19 2000
@@ -58,6 +58,8 @@
 	- info and "insmod" parameters for all network driver modules.
 policy-routing.txt
 	- IP policy-based routing
+proc-net-if.txt
+	- Description of /proc/net/if/* contents
 pt.txt
 	- the Gracilis Packetwin AX.25 device driver
 routing.txt
Index: linux_2_4/Documentation/networking/proc-net-if.txt
diff -u /dev/null linux_2_4/Documentation/networking/proc-net-if.txt:1.1.2.1
--- /dev/null	Wed Nov  1 23:27:36 2000
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
Index: linux_2_4/arch/alpha/config.in
diff -u linux_2_4/arch/alpha/config.in:1.1.1.7 linux_2_4/arch/alpha/config.in:1.1.1.7.10.1
--- linux_2_4/arch/alpha/config.in:1.1.1.7	Sun Oct 22 16:26:26 2000
+++ linux_2_4/arch/alpha/config.in	Wed Nov  1 22:50:19 2000
@@ -222,6 +222,9 @@
  
 if [ "$CONFIG_HOTPLUG" = "y" ] ; then
    source drivers/pcmcia/Config.in
+   if [ "$CONFIG_KMOD" != "y" ] ; then
+      define_bool CONFIG_KMOD y
+   fi
 else
    define_bool CONFIG_PCMCIA n
 fi
Index: linux_2_4/arch/arm/config.in
diff -u linux_2_4/arch/arm/config.in:1.1.1.8 linux_2_4/arch/arm/config.in:1.1.1.8.16.1
--- linux_2_4/arch/arm/config.in:1.1.1.8	Sun Oct 22 15:34:31 2000
+++ linux_2_4/arch/arm/config.in	Wed Nov  1 22:50:19 2000
@@ -242,6 +242,9 @@
 bool 'Support hot-pluggable devices' CONFIG_HOTPLUG
 if [ "$CONFIG_HOTPLUG" = "y" ]; then
    source drivers/pcmcia/Config.in
+   if [ "$CONFIG_KMOD" != "y" ] ; then
+      define_bool CONFIG_KMOD y
+   fi
 else
    define_bool CONFIG_PCMCIA n
 fi
Index: linux_2_4/arch/i386/config.in
diff -u linux_2_4/arch/i386/config.in:1.1.1.7 linux_2_4/arch/i386/config.in:1.1.1.7.10.2
--- linux_2_4/arch/i386/config.in:1.1.1.7	Sun Oct 22 16:26:14 2000
+++ linux_2_4/arch/i386/config.in	Wed Nov  1 22:50:19 2000
@@ -202,6 +202,9 @@
 
 if [ "$CONFIG_HOTPLUG" = "y" ] ; then
    source drivers/pcmcia/Config.in
+   if [ "$CONFIG_KMOD" != "y" ] ; then
+      define_bool CONFIG_KMOD y
+   fi
 else
    define_bool CONFIG_PCMCIA n
 fi
Index: linux_2_4/arch/ia64/config.in
diff -u linux_2_4/arch/ia64/config.in:1.1.1.8 linux_2_4/arch/ia64/config.in:1.1.1.8.14.1
--- linux_2_4/arch/ia64/config.in:1.1.1.8	Sun Oct 22 15:53:47 2000
+++ linux_2_4/arch/ia64/config.in	Wed Nov  1 22:50:19 2000
@@ -98,6 +98,9 @@
 bool 'Support for hot-pluggable devices' CONFIG_HOTPLUG
 if [ "$CONFIG_HOTPLUG" = "y" ]; then
    source drivers/pcmcia/Config.in
+   if [ "$CONFIG_KMOD" != "y" ] ; then
+      define_bool CONFIG_KMOD y
+   fi
 else
    define_bool CONFIG_PCMCIA n
 fi
Index: linux_2_4/arch/mips/config.in
diff -u linux_2_4/arch/mips/config.in:1.1.1.7 linux_2_4/arch/mips/config.in:1.1.1.7.18.1
--- linux_2_4/arch/mips/config.in:1.1.1.7	Sun Oct 22 15:03:27 2000
+++ linux_2_4/arch/mips/config.in	Wed Nov  1 22:50:19 2000
@@ -181,6 +181,9 @@
 
 if [ "$CONFIG_HOTPLUG" = "y" ] ; then
    source drivers/pcmcia/Config.in
+   if [ "$CONFIG_KMOD" != "y" ] ; then
+      define_bool CONFIG_KMOD y
+   fi
 else
    define_bool CONFIG_PCMCIA n
 fi
Index: linux_2_4/arch/mips64/config.in
diff -u linux_2_4/arch/mips64/config.in:1.1.1.7 linux_2_4/arch/mips64/config.in:1.1.1.7.18.1
--- linux_2_4/arch/mips64/config.in:1.1.1.7	Sun Oct 22 15:04:47 2000
+++ linux_2_4/arch/mips64/config.in	Wed Nov  1 22:50:19 2000
@@ -93,6 +93,9 @@
 
 if [ "$CONFIG_HOTPLUG" = "y" ] ; then
    source drivers/pcmcia/Config.in
+   if [ "$CONFIG_KMOD" != "y" ] ; then
+      define_bool CONFIG_KMOD y
+   fi
 else
    define_bool CONFIG_PCMCIA n
 fi
Index: linux_2_4/arch/ppc/config.in
diff -u linux_2_4/arch/ppc/config.in:1.1.1.8 linux_2_4/arch/ppc/config.in:1.1.1.8.10.1
--- linux_2_4/arch/ppc/config.in:1.1.1.8	Sun Oct 22 16:26:54 2000
+++ linux_2_4/arch/ppc/config.in	Wed Nov  1 22:50:19 2000
@@ -132,6 +132,9 @@
 
 if [ "$CONFIG_HOTPLUG" = "y" ]; then
    source drivers/pcmcia/Config.in
+   if [ "$CONFIG_KMOD" != "y" ] ; then
+      define_bool CONFIG_KMOD y
+   fi
 else
    define_bool CONFIG_PCMCIA n
 fi
Index: linux_2_4/arch/sh/config.in
diff -u linux_2_4/arch/sh/config.in:1.1.1.7 linux_2_4/arch/sh/config.in:1.1.1.7.18.1
--- linux_2_4/arch/sh/config.in:1.1.1.7	Sun Oct 22 15:04:35 2000
+++ linux_2_4/arch/sh/config.in	Wed Nov  1 22:50:19 2000
@@ -100,6 +100,9 @@
 
 if [ "$CONFIG_HOTPLUG" = "y" ] ; then
    source drivers/pcmcia/Config.in
+   if [ "$CONFIG_KMOD" != "y" ] ; then
+      define_bool CONFIG_KMOD y
+   fi
 else
    define_bool CONFIG_PCMCIA n
 fi
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
diff -u linux_2_4/drivers/pci/pci.c:1.1.1.6 linux_2_4/drivers/pci/pci.c:1.1.1.6.6.2
--- linux_2_4/drivers/pci/pci.c:1.1.1.6	Fri Oct 27 00:45:05 2000
+++ linux_2_4/drivers/pci/pci.c	Wed Nov  1 22:50:19 2000
@@ -20,6 +20,8 @@
 #include <linux/ioport.h>
 #include <linux/spinlock.h>
 #include <linux/pm.h>
+#include <linux/businfo.h>
+#include <linux/kmod.h>		/* for hotplug_path */
 
 #include <asm/page.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
@@ -343,6 +345,41 @@
 
 #ifdef CONFIG_HOTPLUG
 
+static void
+run_sbin_hotplug(struct pci_dev *pdev, int insert)
+{
+	char *argv[4], *envp[6];
+	char id[32], sub_id[32], bus_id[32];
+	int i;
+
+	if (!hotplug_path[0])
+		return;
+
+	sprintf(id, "PCI_ID=%04X:%04X", pdev->vendor, pdev->device);
+	sprintf(sub_id, "PCI_SUBSYS_ID=%04X:%04X", pdev->subsystem_vendor, pdev->subsystem_device);
+	sprintf(bus_id, "PCI_BUS_ID=%d:%d:%d", pdev->bus->number,
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
@@ -358,9 +395,13 @@
 		if (drv->remove && pci_announce_device(drv, dev))
 			break;
 	}
+
+	/* notify userspace of new hotplug device */
+	run_sbin_hotplug(dev, 1);
 }
 
-static void pci_free_resources(struct pci_dev *dev)
+static void
+pci_free_resources(struct pci_dev *dev)
 {
 	int i;
 
@@ -385,6 +426,9 @@
 #ifdef CONFIG_PROC_FS
 	pci_proc_detach_device(dev);
 #endif
+
+	/* notify userspace of hotplug device removal */
+	run_sbin_hotplug(dev, 0);
 }
 
 #endif
@@ -1097,6 +1141,23 @@
 }
 #endif
 
+/*
+ * format for ASCII PCI device identifiers:
+ *	PCI bus A devfn B
+ * where "A" is the PCI bus number, and "B" is the
+ * encoded slot/device-function number as found in the
+ * PCI device's devfn configuration register.
+ */
+void sprintf_pci_businfo (char *buf, struct bus_info *bi)
+{
+	if (!bi->u.pci.pdev)
+		buf[0] = 0;
+	else
+		sprintf (buf, "PCI bus %d devfn %d",
+			 bi->u.pci.pdev->bus->number,
+			 bi->u.pci.pdev->devfn);
+}
+
 void __init pci_init(void)
 {
 	struct pci_dev *dev;
@@ -1175,4 +1236,3 @@
 
 EXPORT_SYMBOL(isa_dma_bridge_buggy);
 EXPORT_SYMBOL(pci_pci_problems);
-
Index: linux_2_4/drivers/sbus/sbus.c
diff -u linux_2_4/drivers/sbus/sbus.c:1.1.1.1 linux_2_4/drivers/sbus/sbus.c:1.1.1.1.34.1
--- linux_2_4/drivers/sbus/sbus.c:1.1.1.1	Sun Oct 22 12:44:03 2000
+++ linux_2_4/drivers/sbus/sbus.c	Wed Nov  1 22:50:19 2000
@@ -9,6 +9,7 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/businfo.h>
 
 #include <asm/system.h>
 #include <asm/sbus.h>
@@ -546,4 +547,23 @@
 		clock_probe();
 	}
 #endif
+}
+
+
+/*
+ * format for ASCII SBUS device identifiers:
+ *	SBUS bus A dev B slot C
+ * A - OBP node of SBUS
+ * B - OBP node of this device
+ * C - SBUS slot number
+ */
+void sprintf_sbus_businfo (char *buf, struct bus_info *bi)
+{
+	if (!bi->u.sbus.bus || !bi->u.sbus.dev)
+		buf[0] = 0;
+	else
+		sprintf (buf, "SBUS bus %d dev %d slot %d",
+			 bi->u.sbus.bus->prom_node,
+			 bi->u.sbus.dev->prom_node,
+			 bi->u.sbus.dev->slot);
 }


Index: linux_2_4/drivers/usb/usb.c
diff -u linux_2_4/drivers/usb/usb.c:1.1.1.12 linux_2_4/drivers/usb/usb.c:1.1.1.12.2.2
--- linux_2_4/drivers/usb/usb.c:1.1.1.12	Tue Oct 31 13:28:21 2000
+++ linux_2_4/drivers/usb/usb.c	Wed Nov  1 22:54:06 2000
@@ -574,7 +574,7 @@
 }
 
 
-#if	defined(CONFIG_KMOD) && defined(CONFIG_HOTPLUG)
+#ifdef CONFIG_HOTPLUG
 
 /*
  * USB hotplugging invokes what /proc/sys/kernel/hotplug says
@@ -639,9 +639,9 @@
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
@@ -652,27 +652,24 @@
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
@@ -687,10 +684,6 @@
 	 */
 	scratch = buf;
 
-	/* action:  add, remove */
-	envp [i++] = scratch;
-	scratch += sprintf (scratch, "ACTION=%s", verb) + 1;
-
 #ifdef	CONFIG_USB_DEVICEFS
 	/* If this is available, userspace programs can directly read
 	 * all the device descriptors we don't tell them about.  Or
@@ -742,7 +735,6 @@
 	dbg ("kusbd: %s %s %d", argv [0], verb, dev->devnum);
 	value = call_usermodehelper (argv [0], argv, envp);
 	kfree (buf);
-	kfree (envp);
 	if (value != 0)
 		dbg ("kusbd policy returned 0x%x", value);
 }
@@ -750,10 +742,10 @@
 #else
 
 static inline void
-call_policy (char *verb, struct usb_device *dev)
+call_policy (struct usb_device *dev, int insert)
 { } 
 
-#endif	/* KMOD && HOTPLUG */
+#endif /* CONFIG_HOTPLUG */
 
 
 /*
@@ -1520,7 +1512,7 @@
 	}
 
 	/* Let policy agent unload modules etc */
-	call_policy ("remove", dev);
+	call_policy (dev, 0);
 
 	/* Free the device number and remove the /proc/bus/usb entry */
 	if (dev->devnum > 0) {
@@ -2037,7 +2029,7 @@
 	usb_find_drivers(dev);
 
 	/* userspace may load modules and/or configure further */
-	call_policy ("add", dev);
+	call_policy (dev, 1);
 
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
--- /dev/null	Wed Nov  1 23:28:22 2000
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
--- /dev/null	Wed Nov  1 23:28:35 2000
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
 
Index: linux_2_4/include/linux/pci.h
diff -u linux_2_4/include/linux/pci.h:1.1.1.2 linux_2_4/include/linux/pci.h:1.1.1.2.18.2
--- linux_2_4/include/linux/pci.h:1.1.1.2	Sun Oct 22 14:52:55 2000
+++ linux_2_4/include/linux/pci.h	Wed Nov  1 22:50:19 2000
@@ -286,6 +286,7 @@
 #include <linux/ioport.h>
 #include <linux/list.h>
 #include <linux/errno.h>
+#include <linux/businfo.h>
 
 /* This defines the direction arg to the DMA mapping routines. */
 #define PCI_DMA_BIDIRECTIONAL	0
 		    int (*)(struct pci_dev *, u8, u8));
+
 
 /* New-style probing supporting hot-pluggable devices */
 int pci_register_driver(struct pci_driver *);
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
 
Index: linux_2_4/net/core/dev.c
diff -u linux_2_4/net/core/dev.c:1.1.1.8 linux_2_4/net/core/dev.c:1.1.1.8.4.2
--- linux_2_4/net/core/dev.c:1.1.1.8	Mon Oct 30 11:39:10 2000
+++ linux_2_4/net/core/dev.c	Wed Nov  1 22:50:19 2000
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
+static char *netdev_event_names[] = {
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

--------------D5FE456A5EBA42DF2A952029--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
