Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262058AbVBAQYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbVBAQYu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 11:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbVBAQYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 11:24:50 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:64877 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262058AbVBAQYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 11:24:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=eJ0VDQt2gByvCqdke4JMMN2asmaIA6/PCMjkHVq43LOguVuQ0sXDb94BcCzEGR6Jza/lBGIFmLIuvXYKhxojHnOILgY9RbBJNbgsbchDttztg3OXZv0sSmYKAtZq3dPoKxOqgOBnKBvhCNOwuRBc2wUAUfeTFOdhIIuaYaMeavs=
Message-ID: <9e473391050201082468526b50@mail.gmail.com>
Date: Tue, 1 Feb 2005 11:24:09 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: Fwd: Patch to control VGA bus routing and active VGA device.
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Jeff Garzik <jgarzik@pobox.com>,
       Matthew Wilcox <matthew@wil.cx>, Jesse Barnes <jbarnes@sgi.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050201063817.GE15179@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339105011719436a9e5038@mail.gmail.com>
	 <9e473391050122083822a7f81c@mail.gmail.com>
	 <200501240847.51208.jbarnes@sgi.com>
	 <20050124175131.GM31455@parcelfarce.linux.theplanet.co.uk>
	 <9e473391050124111767a9c6b7@mail.gmail.com>
	 <41F54FC1.6080207@pobox.com>
	 <20050124195523.B5541@flint.arm.linux.org.uk>
	 <20050125042459.GA32697@kroah.com>
	 <9e473391050127015970e1fedc@mail.gmail.com>
	 <20050201063817.GE15179@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2005 22:38:17 -0800, Greg KH <greg@kroah.com> wrote:
> Ick, patch wasn't inline for me to comment on it :(

Here's the patch inline. Big things that need to be addressed...

1) Generating the user space reset event. I tried using the pci
hotplug event but ran into the fb blacklist. The reset events need to
be serialized across multiple cards. Make a temp kobj or just use
call_userspacehelp?

2) Things need to be set up so that it will generate the reset event
when compiled in. So the event has to come after early user space is
set up.

3) Where does this code go? It's not a specific device driver since it
doesn't attach to a single piece of hardware. I also run into
interference from existing fb driver as a normal device driver. It
needs to tie into drivers for bus chips when those happen.

4) It needs to monitor hotplug add/remove. If you pull the bus with
the console on it, it will try to move the console to another VGA
device.

diff -Nru a/arch/i386/pci/fixup.c b/arch/i386/pci/fixup.c
--- a/arch/i386/pci/fixup.c	2005-01-27 04:01:08 -05:00
+++ b/arch/i386/pci/fixup.c	2005-01-27 04:01:08 -05:00
@@ -375,6 +375,6 @@
 		}
 		bus = bus->parent;
 	}
-	pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_SHADOW;
+	pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_SHADOW |
IORESOURCE_VGA_ACTIVE;
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pci_fixup_video);
diff -Nru a/drivers/pci/Kconfig b/drivers/pci/Kconfig
--- a/drivers/pci/Kconfig	2005-01-27 04:01:08 -05:00
+++ b/drivers/pci/Kconfig	2005-01-27 04:01:08 -05:00
@@ -47,3 +47,13 @@
 
 	  When in doubt, say Y.
 
+config VGA_CONTROL
+	bool "VGA Control"
+	depends on PCI
+	---help---
+	  Provides sysfs attributes for ensuring that only a single VGA
+	  device can be enabled per PCI domain. If a VGA device is removed
+	  via hotplug, display is routed to another VGA device if available.
+
+	  If you have more than one VGA device, say Y.
+
diff -Nru a/drivers/pci/Makefile b/drivers/pci/Makefile
--- a/drivers/pci/Makefile	2005-01-27 04:01:08 -05:00
+++ b/drivers/pci/Makefile	2005-01-27 04:01:08 -05:00
@@ -28,6 +28,7 @@
 obj-$(CONFIG_MIPS) += setup-bus.o setup-irq.o
 obj-$(CONFIG_X86_VISWS) += setup-irq.o
 obj-$(CONFIG_PCI_MSI) += msi.o
+obj-$(CONFIG_VGA_CONTROL) += vga.o
 
 #
 # ACPI Related PCI FW Functions
diff -Nru a/drivers/pci/bus.c b/drivers/pci/bus.c
--- a/drivers/pci/bus.c	2005-01-27 04:01:08 -05:00
+++ b/drivers/pci/bus.c	2005-01-27 04:01:08 -05:00
@@ -85,6 +85,9 @@
 
 	pci_proc_attach_device(dev);
 	pci_create_sysfs_dev_files(dev);
+#if CONFIG_VGA_CONTROL
+	pci_vga_add_device(dev);
+#endif
 }
 
 /**
diff -Nru a/drivers/pci/pci.h b/drivers/pci/pci.h
--- a/drivers/pci/pci.h	2005-01-27 04:01:08 -05:00
+++ b/drivers/pci/pci.h	2005-01-27 04:01:08 -05:00
@@ -11,6 +11,8 @@
 				  void (*alignf)(void *, struct resource *,
 					  	 unsigned long, unsigned long),
 				  void *alignf_data);
+extern int pci_vga_add_device(struct pci_dev *pdev);
+extern int pci_vga_remove_device(struct pci_dev *pdev);
 /* PCI /proc functions */
 #ifdef CONFIG_PROC_FS
 extern int pci_proc_attach_device(struct pci_dev *dev);
diff -Nru a/drivers/pci/remove.c b/drivers/pci/remove.c
--- a/drivers/pci/remove.c	2005-01-27 04:01:08 -05:00
+++ b/drivers/pci/remove.c	2005-01-27 04:01:08 -05:00
@@ -26,6 +26,9 @@
 
 static void pci_destroy_dev(struct pci_dev *dev)
 {
+#if CONFIG_VGA_CONTROL
+	pci_vga_remove_device(dev);
+#endif
 	pci_proc_detach_device(dev);
 	pci_remove_sysfs_dev_files(dev);
 	device_unregister(&dev->dev);
diff -Nru a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
--- a/drivers/pci/setup-bus.c	2005-01-27 04:01:08 -05:00
+++ b/drivers/pci/setup-bus.c	2005-01-27 04:01:08 -05:00
@@ -64,7 +64,9 @@
 
 		if (class == PCI_CLASS_DISPLAY_VGA ||
 		    class == PCI_CLASS_NOT_DEFINED_VGA)
-			bus->bridge_ctl |= PCI_BRIDGE_CTL_VGA;
+			/* only route to the active VGA, ignore inactive ones */
+			if  (dev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_VGA_ACTIVE)
+				bus->bridge_ctl |= PCI_BRIDGE_CTL_VGA;
 
 		pdev_sort_resources(dev, &head);
 	}
diff -Nru a/drivers/pci/vga.c b/drivers/pci/vga.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/pci/vga.c	2005-01-27 04:01:08 -05:00
@@ -0,0 +1,254 @@
+/*
+ * linux/drivers/pci/vga.c
+ *
+ * (C) Copyright 2004 Jon Smirl <jonsmirl@gmail.com>
+ *
+ * VGA control logic for ensuring only a single enabled VGA device
+ */
+
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <linux/pci.h>
+#include <linux/major.h>
+
+static int vga_initialized = 0;
+static struct pci_dev *vga_active = NULL;
+
+static void bridge_yes(struct pci_dev *pdev)
+{
+	struct pci_dev *bridge;
+	struct pci_bus *bus;
+	
+	/* Make sure the bridges route to us */
+	bus = pdev->bus;
+	while (bus) {
+		bridge = bus->self;
+		if (bridge) {
+			bus->bridge_ctl |= PCI_BRIDGE_CTL_VGA;
+			pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, bus->bridge_ctl);
+		}
+		bus = bus->parent;
+	}
+}
+
+static void bridge_no(struct pci_dev *pdev)
+{
+	struct pci_dev *bridge;
+	struct pci_bus *bus;
+	
+	/* Make sure the bridges don't route to us */
+	bus = pdev->bus;
+	while (bus) {
+		bridge = bus->self;
+		if (bridge) {
+			bus->bridge_ctl &= ~PCI_BRIDGE_CTL_VGA;
+			pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, bus->bridge_ctl);
+		}
+		bus = bus->parent;
+	}
+}
+
+static void vga_enable(struct pci_dev *pdev, unsigned int enable)
+{
+	u16 command;
+	
+	bridge_yes(pdev);
+
+	if (enable) {
+		pci_enable_device(pdev);
+		/* this assumes all other potential VGA devices are disabled */
+		outb(0x01 | inb(0x3C3),  0x3C3);  /* 0 - enable */
+		outb(0x08 | inb(0x46e8), 0x46e8);
+		outb(0x01 | inb(0x102),  0x102);
+		pdev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_VGA_ACTIVE;
+		vga_active = pdev;
+
+		/* return and leave the card enabled */
+		return;
+	}
+	
+	pci_read_config_word(pdev, PCI_COMMAND, &command);
+	pci_write_config_word(pdev, PCI_COMMAND, command | PCI_COMMAND_IO |
PCI_COMMAND_MEMORY);
+	
+	outb(~0x01 & inb(0x3C3),  0x3C3);
+	outb(~0x08 & inb(0x46e8), 0x46e8);
+	outb(~0x01 & inb(0x102),  0x102);
+	pdev->resource[PCI_ROM_RESOURCE].flags &= ~IORESOURCE_VGA_ACTIVE;
+	if (pdev == vga_active)
+		vga_active = NULL;
+	bridge_no(pdev);
+
+	pci_write_config_word(pdev, PCI_COMMAND, command);
+}
+
+/* echo these values to the sysfs vga attribute on a VGA device */
+enum eEnable {
+	VGA_DISABLE_THIS = 0,	/* If this VGA is enabled, disable it. */
+	VGA_ENABLE_THIS = 1,	/* Disable all VGAs then enable this VGA, mark
as active VGA */
+	/* Used while resetting a board, board being reset may not be the
active VGA */
+	VGA_DISABLE_ALL = 2,	/* Remember active VGA then disable all VGAa
and devices */
+	VGA_ENABLE_ACTIVE = 3,	/* Make sure all VGAs are disabled, then
reenable active VGA */
+};
+
+static void set_state(struct pci_dev *pdev, enum eEnable enable)
+{
+	struct pci_dev *pcidev = NULL;
+	unsigned int class;
+
+	if (enable == VGA_DISABLE_THIS)
+		if (vga_active != pdev)
+			return;
+		
+	vga_enable(vga_active, 0);
+
+	/* loop over all devices and make sure no multiple routings */
+	while ((pcidev = pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
PCI_ANY_ID, pcidev)) != NULL) {
+		class = pcidev->class >> 8;
+
+		if (class == PCI_CLASS_DISPLAY_VGA)
+			bridge_no(pcidev);
+	}
+
+	/* loop over all devices and make sure everyone is disabled */
+	while ((pcidev = pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
PCI_ANY_ID, pcidev)) != NULL) {
+		class = pcidev->class >> 8;
+
+		if (class == PCI_CLASS_DISPLAY_VGA)
+			vga_enable(pcidev, 0);
+	}
+
+	switch (enable) {
+		case VGA_DISABLE_THIS:
+		case VGA_DISABLE_ALL:
+			break;
+
+		/* Mark us active if requested */
+		case VGA_ENABLE_THIS:
+			vga_enable(pdev, 1);
+			break;
+	
+		/* Restore active device if requested */
+		case VGA_ENABLE_ACTIVE:
+			vga_enable(vga_active, 1);
+			break;
+	}
+}
+
+/* sysfs store for VGA device */
+static ssize_t vga_device_store(struct device *dev, const char *buf,
size_t count)
+{
+	char *last;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	enum eEnable enable;
+
+	/* sysfs strings are terminated by \n */
+	enable = simple_strtoul(buf, &last, 0);
+	if (last == buf)
+		return -EINVAL;
+
+	if ((enable < VGA_DISABLE_THIS) || (enable > VGA_ENABLE_ACTIVE))
+		return -EINVAL;
+
+	set_state(pdev, enable);
+
+	return count;
+}
+
+/* sysfs show for VGA device */
+static ssize_t vga_device_show(struct device *dev, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	return sprintf(buf, "%d\n", (pdev->resource[PCI_ROM_RESOURCE].flags
& IORESOURCE_VGA_ACTIVE) != 0);
+}
+
+static struct device_attribute vga_device_attr = __ATTR(vga,
S_IRUGO|S_IWUSR, vga_device_show, vga_device_store);
+
+/* sysfs show for VGA routing bridge */
+static ssize_t vga_bridge_show(struct device *dev, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u16 l;
+
+	/* don't trust the shadow PCI_BRIDGE_CTL_VGA in pdev */
+	/* user space may change hardware without telling the kernel */
+	pci_read_config_word(pdev, PCI_BRIDGE_CONTROL, &l);
+	return sprintf(buf, "%d\n", (l & PCI_BRIDGE_CTL_VGA) != 0);
+}
+
+static struct device_attribute vga_bridge_attr = __ATTR(vga, S_IRUGO,
vga_bridge_show, NULL);
+
+/* If the device is a VGA or a bridge, add a VGA sysfs attribute */
+int pci_vga_add_device(struct pci_dev *pdev)
+{
+	int class = pdev->class >> 8;
+
+	if (!vga_initialized)
+		return -EACCES;
+
+	if (class == PCI_CLASS_DISPLAY_VGA) {
+		device_create_file(&pdev->dev, &vga_device_attr);
+
+		/* record the active boot device when located */
+		if (pdev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_VGA_ACTIVE)
+			vga_active = pdev;
+		return 0;
+	}
+
+	if ((class == PCI_CLASS_BRIDGE_PCI) || (class == PCI_CLASS_BRIDGE_CARDBUS)) {
+		device_create_file(&pdev->dev, &vga_bridge_attr);
+	}
+	return 0;
+}
+
+/* If the device is a VGA or a bridge, remove the VGA sysfs attribute */
+int pci_vga_remove_device(struct pci_dev *pdev)
+{
+	struct pci_dev *pcidev = NULL;
+	int class = pdev->class >> 8;
+
+	if (!vga_initialized)
+		return -EACCES;
+
+	if (class == PCI_CLASS_DISPLAY_VGA) {
+		device_remove_file(&pdev->dev, &vga_device_attr);
+
+		/* record the active boot device when located */
+		if (vga_active == pdev) {
+			while ((pcidev = pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID,
PCI_ANY_ID, PCI_ANY_ID, pcidev)) != NULL) {
+				class = pcidev->class >> 8;
+				if (class != PCI_CLASS_DISPLAY_VGA)
+					continue;
+				if (pcidev == pdev)
+					continue;
+				set_state(pcidev, VGA_ENABLE_THIS);
+				break;
+			}
+			if (pcidev == NULL)
+				set_state(NULL, VGA_DISABLE_ALL);
+			
+		}
+		return 0;
+	}
+
+	if ((class == PCI_CLASS_BRIDGE_PCI) || (class == PCI_CLASS_BRIDGE_CARDBUS))
+		device_remove_file(&pdev->dev, &vga_bridge_attr);
+
+	return 0;
+}
+
+/* Initialize by scanning all devices */
+static int __init vga_init(void)
+{
+	struct pci_dev *pdev = NULL;
+
+	vga_initialized = 1;
+
+	while ((pdev = pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
PCI_ANY_ID, pdev)) != NULL)
+		pci_vga_add_device(pdev);
+		
+	return 0;
+}
+
+__initcall(vga_init);
+
diff -Nru a/include/linux/ioport.h b/include/linux/ioport.h
--- a/include/linux/ioport.h	2005-01-27 04:01:08 -05:00
+++ b/include/linux/ioport.h	2005-01-27 04:01:08 -05:00
@@ -41,7 +41,6 @@
 #define IORESOURCE_CACHEABLE	0x00004000
 #define IORESOURCE_RANGELENGTH	0x00008000
 #define IORESOURCE_SHADOWABLE	0x00010000
-#define IORESOURCE_BUS_HAS_VGA	0x00080000
 
 #define IORESOURCE_DISABLED	0x10000000
 #define IORESOURCE_UNSET	0x20000000
@@ -86,6 +85,7 @@
 #define IORESOURCE_ROM_ENABLE		(1<<0)	/* ROM is enabled, same as
PCI_ROM_ADDRESS_ENABLE */
 #define IORESOURCE_ROM_SHADOW		(1<<1)	/* ROM is copy at C000:0 */
 #define IORESOURCE_ROM_COPY		(1<<2)	/* ROM is alloc'd copy, resource
field overlaid */
+#define IORESOURCE_VGA_ACTIVE		(1<<3)	/* VGA device is active */
 
 /* PC/ISA/whatever - the normal PC address spaces: IO and memory */
 extern struct resource ioport_resource;

-- 
Jon Smirl
jonsmirl@gmail.com
