Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262260AbVCHXyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbVCHXyH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 18:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbVCHXwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 18:52:51 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:34804 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262242AbVCHXrv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 18:47:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=BLSkj6fnbeq+5s6yBlVuCvxhYTRTo/anRyJy323e16RLMoZNLKfd1ZnBKCQpLdW6pZcAAWl7274oqCGY/qzwuA/vgo6fcfKVRduIBC6WD86Ok8CoL4yJ93mKbM913YU+l5U0L3AzFJ3nafyclLFoaRq4xwFEAEOmfU2dJOaB4oQ=
Message-ID: <9e47339105030815477d0c7688@mail.gmail.com>
Date: Tue, 8 Mar 2005 18:47:51 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] VGA arbitration: draft of kernel side
Cc: xorg@freedesktop.org, Egbert Eich <eich@freedesktop.org>,
       Jon Smirl <jonsmirl@yahoo.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1110319304.13594.272.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_187_29082101.1110325671135"
References: <1110265919.13607.261.camel@gaston>
	 <1110319304.13594.272.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_187_29082101.1110325671135
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This very similar to the reset support patch I have been working on.

In the reset patch there is a 'vga' attribute on each VGA device. Set
it to 0/1 to make the device active. This lets you move the console
around betweem VGA devices.

You can also set it to 3, which disables all VGA devices but remembers
the active one. Setting it to 4 disables all VGA devices then restores
the active one. To use, set it to 3, post, set it to 4.

GregKH wants this code out of the pci directory but it needs hooks
into pci_destroy_dev() to delete the arbiter. You also need a hook on
add for when a hotplug device appears.

I'll try merging my sysfs support into your code.

-- 
Jon Smirl
jonsmirl@gmail.com

------=_Part_187_29082101.1110325671135
Content-Type: text/x-diff; name="vga.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="vga.patch"

diff -Nru a/arch/i386/pci/fixup.c b/arch/i386/pci/fixup.c
--- a/arch/i386/pci/fixup.c=092005-02-18 15:41:21 -05:00
+++ b/arch/i386/pci/fixup.c=092005-02-18 15:41:21 -05:00
@@ -375,6 +375,6 @@
 =09=09}
 =09=09bus =3D bus->parent;
 =09}
-=09pdev->resource[PCI_ROM_RESOURCE].flags |=3D IORESOURCE_ROM_SHADOW;
+=09pdev->resource[PCI_ROM_RESOURCE].flags |=3D IORESOURCE_ROM_SHADOW | IOR=
ESOURCE_VGA_ACTIVE;
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pci_fixup_video);
diff -Nru a/drivers/pci/Kconfig b/drivers/pci/Kconfig
--- a/drivers/pci/Kconfig=092005-02-18 15:41:21 -05:00
+++ b/drivers/pci/Kconfig=092005-02-18 15:41:21 -05:00
@@ -47,3 +47,13 @@
=20
 =09  When in doubt, say Y.
=20
+config VGA_CONTROL
+=09bool "VGA Control"
+=09depends on PCI
+=09---help---
+=09  Provides sysfs attributes for ensuring that only a single VGA
+=09  device can be enabled per PCI domain. If a VGA device is removed
+=09  via hotplug, display is routed to another VGA device if available.
+
+=09  If you have more than one VGA device, say Y.
+
diff -Nru a/drivers/pci/Makefile b/drivers/pci/Makefile
--- a/drivers/pci/Makefile=092005-02-18 15:41:21 -05:00
+++ b/drivers/pci/Makefile=092005-02-18 15:41:21 -05:00
@@ -28,6 +28,7 @@
 obj-$(CONFIG_MIPS) +=3D setup-bus.o setup-irq.o
 obj-$(CONFIG_X86_VISWS) +=3D setup-irq.o
 obj-$(CONFIG_PCI_MSI) +=3D msi.o
+obj-$(CONFIG_VGA_CONTROL) +=3D vga.o
=20
 #
 # ACPI Related PCI FW Functions
diff -Nru a/drivers/pci/bus.c b/drivers/pci/bus.c
--- a/drivers/pci/bus.c=092005-02-18 15:41:21 -05:00
+++ b/drivers/pci/bus.c=092005-02-18 15:41:21 -05:00
@@ -85,6 +85,9 @@
=20
 =09pci_proc_attach_device(dev);
 =09pci_create_sysfs_dev_files(dev);
+#if CONFIG_VGA_CONTROL
+=09pci_vga_add_device(dev);
+#endif
 }
=20
 /**
diff -Nru a/drivers/pci/pci.h b/drivers/pci/pci.h
--- a/drivers/pci/pci.h=092005-02-18 15:41:21 -05:00
+++ b/drivers/pci/pci.h=092005-02-18 15:41:21 -05:00
@@ -11,6 +11,8 @@
 =09=09=09=09  void (*alignf)(void *, struct resource *,
 =09=09=09=09=09  =09 unsigned long, unsigned long),
 =09=09=09=09  void *alignf_data);
+extern int pci_vga_add_device(struct pci_dev *pdev);
+extern int pci_vga_remove_device(struct pci_dev *pdev);
 /* PCI /proc functions */
 #ifdef CONFIG_PROC_FS
 extern int pci_proc_attach_device(struct pci_dev *dev);
diff -Nru a/drivers/pci/remove.c b/drivers/pci/remove.c
--- a/drivers/pci/remove.c=092005-02-18 15:41:21 -05:00
+++ b/drivers/pci/remove.c=092005-02-18 15:41:21 -05:00
@@ -26,6 +26,9 @@
=20
 static void pci_destroy_dev(struct pci_dev *dev)
 {
+#if CONFIG_VGA_CONTROL
+=09pci_vga_remove_device(dev);
+#endif
 =09pci_proc_detach_device(dev);
 =09pci_remove_sysfs_dev_files(dev);
 =09device_unregister(&dev->dev);
diff -Nru a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
--- a/drivers/pci/setup-bus.c=092005-02-18 15:41:21 -05:00
+++ b/drivers/pci/setup-bus.c=092005-02-18 15:41:21 -05:00
@@ -64,7 +64,9 @@
=20
 =09=09if (class =3D=3D PCI_CLASS_DISPLAY_VGA ||
 =09=09    class =3D=3D PCI_CLASS_NOT_DEFINED_VGA)
-=09=09=09bus->bridge_ctl |=3D PCI_BRIDGE_CTL_VGA;
+=09=09=09/* only route to the active VGA, ignore inactive ones */
+=09=09=09if  (dev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_VGA_ACTIV=
E)
+=09=09=09=09bus->bridge_ctl |=3D PCI_BRIDGE_CTL_VGA;
=20
 =09=09pdev_sort_resources(dev, &head);
 =09}
diff -Nru a/drivers/pci/vga.c b/drivers/pci/vga.c
--- /dev/null=09Wed Dec 31 16:00:00 196900
+++ b/drivers/pci/vga.c=092005-02-18 15:41:21 -05:00
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
+static int vga_initialized =3D 0;
+static struct pci_dev *vga_active =3D NULL;
+
+static void bridge_yes(struct pci_dev *pdev)
+{
+=09struct pci_dev *bridge;
+=09struct pci_bus *bus;
+=09
+=09/* Make sure the bridges route to us */
+=09bus =3D pdev->bus;
+=09while (bus) {
+=09=09bridge =3D bus->self;
+=09=09if (bridge) {
+=09=09=09bus->bridge_ctl |=3D PCI_BRIDGE_CTL_VGA;
+=09=09=09pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, bus->bridge_ctl=
);
+=09=09}
+=09=09bus =3D bus->parent;
+=09}
+}
+
+static void bridge_no(struct pci_dev *pdev)
+{
+=09struct pci_dev *bridge;
+=09struct pci_bus *bus;
+=09
+=09/* Make sure the bridges don't route to us */
+=09bus =3D pdev->bus;
+=09while (bus) {
+=09=09bridge =3D bus->self;
+=09=09if (bridge) {
+=09=09=09bus->bridge_ctl &=3D ~PCI_BRIDGE_CTL_VGA;
+=09=09=09pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, bus->bridge_ctl=
);
+=09=09}
+=09=09bus =3D bus->parent;
+=09}
+}
+
+static void vga_enable(struct pci_dev *pdev, unsigned int enable)
+{
+=09u16 command;
+=09
+=09bridge_yes(pdev);
+
+=09if (enable) {
+=09=09pci_enable_device(pdev);
+=09=09/* this assumes all other potential VGA devices are disabled */
+=09=09outb(0x01 | inb(0x3C3),  0x3C3);  /* 0 - enable */
+=09=09outb(0x08 | inb(0x46e8), 0x46e8);
+=09=09outb(0x01 | inb(0x102),  0x102);
+=09=09pdev->resource[PCI_ROM_RESOURCE].flags |=3D IORESOURCE_VGA_ACTIVE;
+=09=09vga_active =3D pdev;
+
+=09=09/* return and leave the card enabled */
+=09=09return;
+=09}
+=09
+=09pci_read_config_word(pdev, PCI_COMMAND, &command);
+=09pci_write_config_word(pdev, PCI_COMMAND, command | PCI_COMMAND_IO | PCI=
_COMMAND_MEMORY);
+=09
+=09outb(~0x01 & inb(0x3C3),  0x3C3);
+=09outb(~0x08 & inb(0x46e8), 0x46e8);
+=09outb(~0x01 & inb(0x102),  0x102);
+=09pdev->resource[PCI_ROM_RESOURCE].flags &=3D ~IORESOURCE_VGA_ACTIVE;
+=09if (pdev =3D=3D vga_active)
+=09=09vga_active =3D NULL;
+=09bridge_no(pdev);
+
+=09pci_write_config_word(pdev, PCI_COMMAND, command);
+}
+
+/* echo these values to the sysfs vga attribute on a VGA device */
+enum eEnable {
+=09VGA_DISABLE_THIS =3D 0,=09/* If this VGA is enabled, disable it. */
+=09VGA_ENABLE_THIS =3D 1,=09/* Disable all VGAs then enable this VGA, mark=
 as active VGA */
+=09/* Used while resetting a board, board being reset may not be the activ=
e VGA */
+=09VGA_DISABLE_ALL =3D 2,=09/* Remember active VGA then disable all VGAa a=
nd devices */
+=09VGA_ENABLE_ACTIVE =3D 3,=09/* Make sure all VGAs are disabled, then ree=
nable active VGA */
+};
+
+static void set_state(struct pci_dev *pdev, enum eEnable enable)
+{
+=09struct pci_dev *pcidev =3D NULL;
+=09unsigned int class;
+
+=09if (enable =3D=3D VGA_DISABLE_THIS)
+=09=09if (vga_active !=3D pdev)
+=09=09=09return;
+=09=09
+=09vga_enable(vga_active, 0);
+
+=09/* loop over all devices and make sure no multiple routings */
+=09while ((pcidev =3D pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, P=
CI_ANY_ID, pcidev)) !=3D NULL) {
+=09=09class =3D pcidev->class >> 8;
+
+=09=09if (class =3D=3D PCI_CLASS_DISPLAY_VGA)
+=09=09=09bridge_no(pcidev);
+=09}
+
+=09/* loop over all devices and make sure everyone is disabled */
+=09while ((pcidev =3D pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, P=
CI_ANY_ID, pcidev)) !=3D NULL) {
+=09=09class =3D pcidev->class >> 8;
+
+=09=09if (class =3D=3D PCI_CLASS_DISPLAY_VGA)
+=09=09=09vga_enable(pcidev, 0);
+=09}
+
+=09switch (enable) {
+=09=09case VGA_DISABLE_THIS:
+=09=09case VGA_DISABLE_ALL:
+=09=09=09break;
+
+=09=09/* Mark us active if requested */
+=09=09case VGA_ENABLE_THIS:
+=09=09=09vga_enable(pdev, 1);
+=09=09=09break;
+=09
+=09=09/* Restore active device if requested */
+=09=09case VGA_ENABLE_ACTIVE:
+=09=09=09vga_enable(vga_active, 1);
+=09=09=09break;
+=09}
+}
+
+/* sysfs store for VGA device */
+static ssize_t vga_device_store(struct device *dev, const char *buf, size_=
t count)
+{
+=09char *last;
+=09struct pci_dev *pdev =3D to_pci_dev(dev);
+=09enum eEnable enable;
+
+=09/* sysfs strings are terminated by \n */
+=09enable =3D simple_strtoul(buf, &last, 0);
+=09if (last =3D=3D buf)
+=09=09return -EINVAL;
+
+=09if ((enable < VGA_DISABLE_THIS) || (enable > VGA_ENABLE_ACTIVE))
+=09=09return -EINVAL;
+
+=09set_state(pdev, enable);
+
+=09return count;
+}
+
+/* sysfs show for VGA device */
+static ssize_t vga_device_show(struct device *dev, char *buf)
+{
+=09struct pci_dev *pdev =3D to_pci_dev(dev);
+=09return sprintf(buf, "%d\n", (pdev->resource[PCI_ROM_RESOURCE].flags & I=
ORESOURCE_VGA_ACTIVE) !=3D 0);
+}
+
+static struct device_attribute vga_device_attr =3D __ATTR(vga, S_IRUGO|S_I=
WUSR, vga_device_show, vga_device_store);
+
+/* sysfs show for VGA routing bridge */
+static ssize_t vga_bridge_show(struct device *dev, char *buf)
+{
+=09struct pci_dev *pdev =3D to_pci_dev(dev);
+=09u16 l;
+
+=09/* don't trust the shadow PCI_BRIDGE_CTL_VGA in pdev */
+=09/* user space may change hardware without telling the kernel */
+=09pci_read_config_word(pdev, PCI_BRIDGE_CONTROL, &l);
+=09return sprintf(buf, "%d\n", (l & PCI_BRIDGE_CTL_VGA) !=3D 0);
+}
+
+static struct device_attribute vga_bridge_attr =3D __ATTR(vga, S_IRUGO, vg=
a_bridge_show, NULL);
+
+/* If the device is a VGA or a bridge, add a VGA sysfs attribute */
+int pci_vga_add_device(struct pci_dev *pdev)
+{
+=09int class =3D pdev->class >> 8;
+
+=09if (!vga_initialized)
+=09=09return -EACCES;
+
+=09if (class =3D=3D PCI_CLASS_DISPLAY_VGA) {
+=09=09device_create_file(&pdev->dev, &vga_device_attr);
+
+=09=09/* record the active boot device when located */
+=09=09if (pdev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_VGA_ACTIVE)
+=09=09=09vga_active =3D pdev;
+=09=09return 0;
+=09}
+
+=09if ((class =3D=3D PCI_CLASS_BRIDGE_PCI) || (class =3D=3D PCI_CLASS_BRID=
GE_CARDBUS)) {
+=09=09device_create_file(&pdev->dev, &vga_bridge_attr);
+=09}
+=09return 0;
+}
+
+/* If the device is a VGA or a bridge, remove the VGA sysfs attribute */
+int pci_vga_remove_device(struct pci_dev *pdev)
+{
+=09struct pci_dev *pcidev =3D NULL;
+=09int class =3D pdev->class >> 8;
+
+=09if (!vga_initialized)
+=09=09return -EACCES;
+
+=09if (class =3D=3D PCI_CLASS_DISPLAY_VGA) {
+=09=09device_remove_file(&pdev->dev, &vga_device_attr);
+
+=09=09/* record the active boot device when located */
+=09=09if (vga_active =3D=3D pdev) {
+=09=09=09while ((pcidev =3D pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY=
_ID, PCI_ANY_ID, pcidev)) !=3D NULL) {
+=09=09=09=09class =3D pcidev->class >> 8;
+=09=09=09=09if (class !=3D PCI_CLASS_DISPLAY_VGA)
+=09=09=09=09=09continue;
+=09=09=09=09if (pcidev =3D=3D pdev)
+=09=09=09=09=09continue;
+=09=09=09=09set_state(pcidev, VGA_ENABLE_THIS);
+=09=09=09=09break;
+=09=09=09}
+=09=09=09if (pcidev =3D=3D NULL)
+=09=09=09=09set_state(NULL, VGA_DISABLE_ALL);
+=09=09=09
+=09=09}
+=09=09return 0;
+=09}
+
+=09if ((class =3D=3D PCI_CLASS_BRIDGE_PCI) || (class =3D=3D PCI_CLASS_BRID=
GE_CARDBUS))
+=09=09device_remove_file(&pdev->dev, &vga_bridge_attr);
+
+=09return 0;
+}
+
+/* Initialize by scanning all devices */
+static int __init vga_init(void)
+{
+=09struct pci_dev *pdev =3D NULL;
+
+=09vga_initialized =3D 1;
+
+=09while ((pdev =3D pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI=
_ANY_ID, pdev)) !=3D NULL)
+=09=09pci_vga_add_device(pdev);
+=09=09
+=09return 0;
+}
+
+__initcall(vga_init);
+
diff -Nru a/include/linux/ioport.h b/include/linux/ioport.h
--- a/include/linux/ioport.h=092005-02-18 15:41:21 -05:00
+++ b/include/linux/ioport.h=092005-02-18 15:41:21 -05:00
@@ -41,7 +41,6 @@
 #define IORESOURCE_CACHEABLE=090x00004000
 #define IORESOURCE_RANGELENGTH=090x00008000
 #define IORESOURCE_SHADOWABLE=090x00010000
-#define IORESOURCE_BUS_HAS_VGA=090x00080000
=20
 #define IORESOURCE_DISABLED=090x10000000
 #define IORESOURCE_UNSET=090x20000000
@@ -86,6 +85,7 @@
 #define IORESOURCE_ROM_ENABLE=09=09(1<<0)=09/* ROM is enabled, same as PCI=
_ROM_ADDRESS_ENABLE */
 #define IORESOURCE_ROM_SHADOW=09=09(1<<1)=09/* ROM is copy at C000:0 */
 #define IORESOURCE_ROM_COPY=09=09(1<<2)=09/* ROM is alloc'd copy, resource=
 field overlaid */
+#define IORESOURCE_VGA_ACTIVE=09=09(1<<3)=09/* VGA device is active */
=20
 /* PC/ISA/whatever - the normal PC address spaces: IO and memory */
 extern struct resource ioport_resource;

------=_Part_187_29082101.1110325671135--
