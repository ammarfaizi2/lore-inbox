Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268172AbUIMPMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268172AbUIMPMR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 11:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267701AbUIMPMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 11:12:12 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:21580 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268298AbUIMPGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 11:06:53 -0400
Message-ID: <9e47339104091308063c394704@mail.gmail.com>
Date: Mon, 13 Sep 2004 11:06:43 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: radeon-pre-2
Cc: Dave Airlie <airlied@linux.ie>,
       =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1095074778.14374.41.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_350_21531592.1095088003838"
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <9e47339104091010221f03ec06@mail.gmail.com>
	 <1094835846.17932.11.camel@localhost.localdomain>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <1094853588.18235.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409110137590.26651@skynet>
	 <1094912726.21157.52.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409122319550.20080@skynet>
	 <1095074778.14374.41.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_350_21531592.1095088003838
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 13 Sep 2004 12:26:33 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Well this is what I came up with so far. It creates a vga class so you
> can bind the drivers to functions of the card (and we can add/remove
> functions later as appropriate), tells functions about each other and
> now implements Linux lock proposal as I understood it.

It needs something to sort out both drivers attaching to the IRQ.

It also needs something to sort out both drivers using pci_drvdata()
to get to their private data. For example in the hotplug routines you
only get passed a pdev and you want to use that to locate your private
data.

It also needs to track pci_enable_device() so that if one driver
unloads it won't turn the device off for the other driver.

VGA routing needs to be supported. I attached the code I was writing
for that. I was in the middle of writing it so it doesn't compile.
This code should be integrated into the VGA driver.

It needs to integrate into VGAcon. VGAcon should require the vga
device before loading. The resource reservation code in VGAcon needs
to be moved to the VGA driver. If you use a command to switch the
active VGA device, VGAcon needs to reset itself for the new device.

VGA driver needs to generate hotplug events for the VGA device that
indicate if they are primary or secondary. If they are secondary there
needs to be a user space reset program that uses the new ROM hooks to
reset the card.

It should support more than two drivers, I forgot to check, does it already?

fbdev takes a snapshot of the video registers when it loads. When you
unload it it writes those registers back. That doesn't work if you
load from an xterm and rmmod it from the command line. It snapshots
the card in graphics mode and then restores it in an environment
expecting text mode.

Something needs to be done for DMA processing. What if I get an
interrupt that the DMA queue has been completed but we've switched to
a driver that doesn't understand DMA? I guess the only safe thing to
do is make sure all DMA queue are finished before releasing control.

-- 
Jon Smirl
jonsmirl@gmail.com

------=_Part_350_21531592.1095088003838
Content-Type: text/x-patch; name="v.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="v.diff"

=3D=3D=3D=3D=3D arch/i386/pci/fixup.c 1.21 vs edited =3D=3D=3D=3D=3D
--- 1.21/arch/i386/pci/fixup.c=09Sun Aug 29 00:21:23 2004
+++ edited/arch/i386/pci/fixup.c=09Fri Sep 10 01:03:06 2004
@@ -225,7 +225,7 @@
  * issue another HALT within 80 ns of the initial HALT, the failure condit=
ion
  * is avoided.
  */
-static void __init pci_fixup_nforce2(struct pci_dev *dev)
+static void __devinit pci_fixup_nforce2(struct pci_dev *dev)
 {
 =09u32 val, fixed_val;
 =09u8 rev;
@@ -290,6 +290,6 @@
 =09=09}
 =09=09bus =3D bus->parent;
 =09}
-=09pdev->resource[PCI_ROM_RESOURCE].flags |=3D IORESOURCE_ROM_SHADOW;
+=09pdev->resource[PCI_ROM_RESOURCE].flags |=3D IORESOURCE_ROM_SHADOW | IOR=
ESOURCE_VGA_ENABLE;
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pci_fixup_video);
=3D=3D=3D=3D=3D drivers/pci/Kconfig 1.6 vs edited =3D=3D=3D=3D=3D
--- 1.6/drivers/pci/Kconfig=09Mon Aug  2 04:00:43 2004
+++ edited/drivers/pci/Kconfig=09Fri Sep 10 01:03:06 2004
@@ -47,3 +47,13 @@
=20
 =09  When in doubt, say Y.
=20
+config VGA_CONTROL
+=09bool "VGA Control Device"
+=09depends on PCI
+=09---help---
+=09  Provides a VGA Control Device for ensuring that only a single VGA
+=09  device can be enabled per PCI domain. If a VGA device is removed
+=09  via hotplug, display is routed to another VGA device if available.
+
+=09  If you have more than one VGA device, say Y.
+
=3D=3D=3D=3D=3D drivers/pci/Makefile 1.41 vs edited =3D=3D=3D=3D=3D
--- 1.41/drivers/pci/Makefile=09Sun Aug 29 00:21:23 2004
+++ edited/drivers/pci/Makefile=09Sat Sep 11 22:44:22 2004
@@ -28,6 +28,7 @@
 obj-$(CONFIG_MIPS) +=3D setup-bus.o setup-irq.o
 obj-$(CONFIG_X86_VISWS) +=3D setup-irq.o
 obj-$(CONFIG_PCI_MSI) +=3D msi.o
+obj-$(CONFIG_VGA_CONTROL) +=3D vga.o
=20
 # Cardbus & CompactPCI use setup-bus
 obj-$(CONFIG_HOTPLUG) +=3D setup-bus.o
=3D=3D=3D=3D=3D drivers/pci/bus.c 1.9 vs edited =3D=3D=3D=3D=3D
--- 1.9/drivers/pci/bus.c=09Sat Apr 10 18:27:59 2004
+++ edited/drivers/pci/bus.c=09Sat Sep 11 22:48:04 2004
@@ -100,7 +100,9 @@
=20
 =09=09pci_proc_attach_device(dev);
 =09=09pci_create_sysfs_dev_files(dev);
-
+#if CONFIG_VGA_DEVICE
+=09=09pci_vga_add_device(dev);
+#endif
 =09}
=20
 =09list_for_each_entry(dev, &bus->devices, bus_list) {
=3D=3D=3D=3D=3D drivers/pci/pci.h 1.13 vs edited =3D=3D=3D=3D=3D
--- 1.13/drivers/pci/pci.h=09Sun Aug 29 00:21:23 2004
+++ edited/drivers/pci/pci.h=09Fri Sep 10 01:03:08 2004
@@ -11,6 +11,7 @@
 =09=09=09=09  void (*alignf)(void *, struct resource *,
 =09=09=09=09=09  =09 unsigned long, unsigned long),
 =09=09=09=09  void *alignf_data);
+int pci_vga_add_device(struct pci_dev *pdev);
 /* PCI /proc functions */
 #ifdef CONFIG_PROC_FS
 extern int pci_proc_attach_device(struct pci_dev *dev);
=3D=3D=3D=3D=3D drivers/pci/setup-bus.c 1.25 vs edited =3D=3D=3D=3D=3D
--- 1.25/drivers/pci/setup-bus.c=09Sun Jul 11 08:41:20 2004
+++ edited/drivers/pci/setup-bus.c=09Fri Sep 10 01:03:09 2004
@@ -51,16 +51,8 @@
 =09struct resource_list head, *list, *tmp;
 =09int idx;
=20
-=09bus->bridge_ctl &=3D ~PCI_BRIDGE_CTL_VGA;
-
 =09head.next =3D NULL;
 =09list_for_each_entry(dev, &bus->devices, bus_list) {
-=09=09u16 class =3D dev->class >> 8;
-
-=09=09if (class =3D=3D PCI_CLASS_DISPLAY_VGA
-=09=09=09=09|| class =3D=3D PCI_CLASS_NOT_DEFINED_VGA)
-=09=09=09bus->bridge_ctl |=3D PCI_BRIDGE_CTL_VGA;
-
 =09=09pdev_sort_resources(dev, &head);
 =09}
=20
@@ -499,12 +491,6 @@
=20
 =09pbus_assign_resources_sorted(bus);
=20
-=09if (bus->bridge_ctl & PCI_BRIDGE_CTL_VGA) {
-=09=09/* Propagate presence of the VGA to upstream bridges */
-=09=09for (b =3D bus; b->parent; b =3D b->parent) {
-=09=09=09b->bridge_ctl |=3D PCI_BRIDGE_CTL_VGA;
-=09=09}
-=09}
 =09list_for_each_entry(dev, &bus->devices, bus_list) {
 =09=09b =3D dev->subordinate;
 =09=09if (!b)
=3D=3D=3D=3D=3D drivers/pci/vga.c 1.1 vs edited =3D=3D=3D=3D=3D
--- 1.1/drivers/pci/vga.c=09Fri Sep 10 01:01:47 2004
+++ edited/drivers/pci/vga.c=09Sat Sep 11 01:05:37 2004
@@ -1 +1,381 @@
+/*
+ * linux/drivers/char/vga.c
+ *
+ * (C) Copyright 2004 Jon Smirl <jonsmirl@gmail.com>
+ *
+ * VGA control device for ensuring only a single enabled VGA device
+ *
+ * Reuses the DRM major 226, starts minors at VGA_MINOR_BASE, 0x200
+ */
+
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <linux/pci.h>
+#include <linux/major.h>
+#include <linux/vga.h>
+
+struct vga_dev {
+=09struct class_device class_dev;
+=09struct list_head node;
+=09dev_t dev;
+=09int enabled;
+};
+#define to_vga_dev(d) container_of(d, struct vga_dev, class_dev)
+
+static struct class *vga_class;
+static struct vga_dev *vga_device;
+static DECLARE_MUTEX(vga_mutex);
+static int vga_initialized;=09/* =3D 0 */
+
+/*
+ * Open/close code for vga IO.
+ */
+static int vga_open(struct inode *inode, struct file *filp)
+{
+//=09const int minor =3D iminor(inode);
+
+=09down(&vga_mutex);
+=09up(&vga_mutex);
+
+=09return 0;
+}
+
+/*
+ */
+static int vga_release(struct inode *inode, struct file *filp)
+{
+=09down(&vga_mutex);
+=09up(&vga_mutex);
+
+=09return 0;
+}
+
+/*
+ */
+static int
+vga_ioctl(struct inode *inode, struct file *filp,
+=09=09  unsigned int command, unsigned long arg)
+{
+=09return 0;
+}
+
+static struct file_operations vga_fops =3D {
+=09.open=09=3D=09vga_open,
+=09.release=3D=09vga_release,
+=09.ioctl=09=3D=09vga_ioctl,
+=09.owner=09=3D=09THIS_MODULE,
+};
+
+static struct cdev vga_cdev =3D {
+=09.kobj=09=3D=09{.name =3D "vga", },
+=09.owner=09=3D=09THIS_MODULE,
+};
+
+static void bridge_yes(drm_device_t *dev)
+{
+=09struct pci_dev *bridge;
+=09struct pci_bus *bus;
+=09
+=09/* Make sure the bridges route to us */
+=09bus =3D dev->pdev->bus;
+=09while (bus) {
+=09=09bridge =3D bus->self;
+=09=09if (bridge) {
+=09=09=09pci_read_config_word(bridge, PCI_BRIDGE_CONTROL, &pbus->bridge_ct=
l);
+=09=09=09pbus->bridge_ctl |=3D PCI_BRIDGE_CTL_VGA;
+=09=09=09pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, pbus->bridge_ct=
l);
+=09=09}
+=09=09bus =3D bus->parent;
+=09}
+}
+
+static void bridge_no(drm_device_t *dev)
+{
+=09struct pci_dev *bridge;
+=09struct pci_bus *bus;
+=09
+=09/* Make sure the bridges don't route to us */
+=09bus =3D dev->pdev->bus;
+=09while (bus) {
+=09=09bridge =3D bus->self;
+=09=09if (bridge) {
+=09=09=09pci_read_config_word(bridge, PCI_BRIDGE_CONTROL, &pbus->bridge_ct=
l);
+=09=09=09pbus->bridge_ctl &=3D ~PCI_BRIDGE_CTL_VGA;
+=09=09=09pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, pbus->bridge_ct=
l);
+=09=09}
+=09=09bus =3D bus->parent;
+=09}
+}
+
+
+/* sysfs for VGA device */
+static ssize_t vga_device_show(struct device *dev, char *buf)
+{
+=09struct pci_dev *pdev =3D to_pci_dev(dev);
+=09return sprintf(bus, "%d\n", (pdev->resource[PCI_ROM_RESOURCE].flags & I=
ORESOURCE_VGA_ENABLE) !=3D 0);
+}
+static ssize_t vga_device_store(struct device *dev, const char *buf, size_=
t count)
+{
+=09return count;
+}
+static struct device_attribute vga_device_attr =3D __ATTR(vga, S_IRUGO|S_I=
WUSR, vga_device_show, vga_device_store);
+
+/* sysfs for VGA routing bridge */
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
+static struct device_attribute vga_bridge_attr =3D __ATTR(vga, S_IRUGO, vg=
a_bridge_show, NULL);
+
+/* sysfs for VGA root legacy space */
+static ssize_t vga_root_show(struct class_device *class_dev, char *buf)
+{
+=09struct vga_dev *vga =3D to_vga_dev(class_dev);
+=09return sprintf(buf, "%d\n", vga->enabled);
+}
+static ssize_t vga_root_store(struct class_device *class_dev, const char *=
buf, size_t count)
+{
+=09char *endp;
+=09struct vga_dev *vga =3D to_vga_dev(class_dev);
+=09
+=09vga->enabled =3D  (simple_strtoul(buf, &endp, 0) !=3D 0);
+=09return count;
+}
+static struct class_device_attribute vga_root_attr =3D __ATTR(vga, S_IRUGO=
|S_IWUSR, vga_root_show, vga_root_store);
+
+/* sysfs for /class/vga/vga0/dev */
+static ssize_t show_dev(struct class_device *class_dev, char *buf)
+{
+=09struct vga_dev *vga =3D to_vga_dev(class_dev);
+=09return print_dev_t(buf, vga->dev);
+}
+CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
+
+int pci_vga_add_device(struct pci_dev *pdev)
+{
+=09char name[20];
+=09int class =3D pdev->class >> 8;
+
+=09if (!vga_initialized)
+=09=09return -EACCES;
+
+=09if (class =3D=3D PCI_CLASS_DISPLAY_VGA) {
+=09=09device_create_file(&pdev->dev, &vga_device_attr);
+=09=09snprintf(name, sizeof(name), "%04x:%02x:%02x.%d", pci_domain_nr(pdev=
->bus),=20
+=09=09=09pdev->bus->number, PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
+=09=09sysfs_create_link(&vga_device->class_dev.kobj, &pdev->dev.kobj, name=
);
+=09=09return 0;
+=09}
+
+=09if ((class =3D=3D PCI_CLASS_BRIDGE_PCI) || (class =3D=3D PCI_CLASS_BRID=
GE_CARDBUS)) {
+=09=09device_create_file(&pdev->dev, &vga_bridge_attr);
+=09}
+
+=09return 0;
+}
+
+static int __init vga_init(void)
+{
+=09int ret;
+=09dev_t dev;
+=09int minor =3D 0;
+=09struct pci_dev *pdev =3D NULL;
+
+=09vga_initialized =3D 1;
+=09dev =3D MKDEV(DRM_MAJOR, VGA_MINOR_BASE);
+
+=09if (register_chrdev_region(dev, VGA_MINOR_MAX, "vga"))
+=09=09goto err_i1;
+
+=09cdev_init(&vga_cdev, &vga_fops);
+=09if (cdev_add(&vga_cdev, dev, VGA_MINOR_MAX)) {
+=09=09kobject_put(&vga_cdev.kobj);
+=09=09goto err_i2;
+=09}
+
+=09vga_class =3D kmalloc(sizeof(*vga_class), GFP_KERNEL);
+=09if (!vga_class)
+=09=09goto err_i3;
+=09memset(vga_class, 0x00, sizeof(*vga_class));
+
+=09vga_class->name =3D "vga";
+=09if ((ret =3D class_register(vga_class)))
+=09=09goto err_i4;
+
+=09vga_device =3D kmalloc(sizeof(*vga_device), GFP_KERNEL);
+=09if (!vga_device)
+=09=09goto err_i5;
+=09memset(vga_device, 0x00, sizeof(*vga_device));
+
+=09vga_device->dev =3D MKDEV(DRM_MAJOR, VGA_MINOR_BASE + minor);
+=09vga_device->class_dev.dev =3D NULL;
+=09vga_device->class_dev.class =3D vga_class;
+=09snprintf(vga_device->class_dev.class_id, BUS_ID_SIZE, "vga%d", minor);
+=09
+=09if ((ret =3D class_device_register(&vga_device->class_dev)))
+=09=09goto err_i6;
+
+=09class_device_create_file(&vga_device->class_dev, &class_device_attr_dev=
);
+=09class_device_create_file(&vga_device->class_dev, &vga_root_attr);
+
+=09while ((pdev =3D pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) !=3D NU=
LL)
+=09=09pci_vga_add_device(pdev);
+=09=09
+=09printk(KERN_INFO "VGA control device 1.0 initialized\n");
+
+=09return 0;
+
+err_i6:
+=09kfree(vga_device);
+err_i5:
+=09class_unregister(vga_class);
+err_i4:
+=09kfree(vga_class);
+err_i3:
+=09cdev_del(&vga_cdev);
+err_i2:
+=09unregister_chrdev_region(dev, VGA_MINOR_MAX);
+err_i1:
+=09printk(KERN_ERR "error initializing VGA control device\n");
+=09return 1;
+}
+
+static void __exit vga_exit(void)
+{
+=09class_device_unregister(&vga_device->class_dev);
+=09kfree(vga_device);
+=09class_unregister(vga_class);
+=09kfree(vga_class);
+=09cdev_del(&vga_cdev);
+=09unregister_chrdev_region(MKDEV(DRM_MAJOR, VGA_MINOR_BASE), VGA_MINOR_MA=
X);
+}
+
+__initcall(vga_init);
+__exitcall(vga_exit);
+
+
+
+/*
+ * 0 - Disable all VGA and cards
+ * 1 - Enable only active card and VGA (assumes other devices are disabled=
)
+ * 2 - Enable all pci devices
+ *
+ * This is a driver specific function accessed via DRM(stub)
+ * doing it this way allows for driver specific overrides if needed
+ */
+#define VE_DISABLE 0
+#define VE_ACTIVE 1
+#define VE_ENABLE 2
+int DRM(vgaenable)(int enable, int clear_active) {
+=09int i;
+=09drm_device_t *dev;
+=09
+=09switch (enable) {=09
+=09case VE_DISABLE:
+=09=09/* disable all VGA and all devices */
+=09=09/* loop over all the driver's cards */
+=09=09for (i =3D 0; i < DRM(numdevs); i++) {
+=09=09=09dev =3D &DRM(device)[i];
+=09=09=09if (clear_active)
+=09=09=09=09dev->vga_active =3D FALSE;
+=09=09
+=09=09=09bridge_yes(dev);
+=09=09=09/* 0x3CC and 0x3C2 are correct, it's not a typo */
+=09=09=09outb(~0x03 & inb(0x3CC),  0x3C2);
+=09=09=09outb(~0x01 & inb(0x3C3),  0x3C3);
+=09=09=09outb(~0x08 & inb(0x46e8), 0x46e8);
+=09=09=09outb(~0x01 & inb(0x102),  0x102);
+=09=09=09pci_disable_device(dev->pdev);
+=09=09=09bridge_no(dev);
+=09=09}
+=09=09return 0;
+=09case VE_ACTIVE:
+=09=09/* enable device and VGA on active device */=09
+=09=09/* loop over all the driver's cards */
+=09=09for (i =3D 0; i < DRM(numdevs); i++) {
+=09=09=09dev =3D &DRM(device)[i];
+=09=09=09if (!dev->vga_active)
+=09=09=09=09continue;
+=09=09=09/* this assumes all other potential VGA devices are disabled */
+=09=09=09bridge_yes(dev);
+=09=09=09pci_enable_device(dev->pdev);
+=09=09=09/* 0x3CC and 0x3C2 are correct, it's not a typo */
+=09=09=09outb(0x03 | inb(0x3CC),  0x3C2);
+=09=09=09outb(0x01 | inb(0x3C3),  0x3C3);
+=09=09=09outb(0x08 | inb(0x46e8), 0x46e8);
+=09=09=09outb(0x01 | inb(0x102),  0x102);
+=09=09=09return 0;
+=09=09}
+=09=09return 0;
+=09case VE_ENABLE:
+=09=09/* loop over all the driver's cards */
+=09=09for (i =3D 0; i < DRM(numdevs); i++) {
+=09=09=09dev =3D &DRM(device)[i];
+=09=09=09pci_enable_device(dev->pdev);
+=09=09}
+=09=09return 0;
+=09default:
+=09=09return -1;
+=09}
+}
+
+/*
+ * VGA_ENABLE_ACTIVE=3D0 - Make sure all DRM VGAs are disabled, if this on=
e not active reenable active VGA
+ * VGA_ENABLE_THIS=3D1 - Make sure all DRM VGAs are disabled and enable th=
is DRM VGA, mark as active VGA
+ * Used while resetting a board
+ * VGA_DISABLE_ALL=3D2 - Disable all DRM VGA and devices, remember active =
VGA
+ */
+int DRM(vga_enable)( DRM_IOCTL_ARGS ) {
+=09DRM_DEVICE;
+=09drm_file_t *filp_priv;
+=09drm_vga_enable_t ve;
+=09struct drm_stub_info *pStub;
+=09
+=09DRM_GET_PRIV_WITH_RETURN( filp_priv, filp );
+
+=09DRM_COPY_FROM_USER_IOCTL( ve, ( drm_vga_enable_t* )data, sizeof( ve ) )=
;
+
+=09if ((ve.enable < VGA_ENABLE_ACTIVE) || (ve.enable > VGA_DISABLE_ALL))
+=09=09return -1;
+
+=09/* First disable all VGA and all devices */
+=09/* loop over all drivers */
+=09pStub =3D &DRM(stub_info);
+=09do {
+=09=09/* clear the active device if enable 1 */
+=09=09pStub->vgaenable(VE_DISABLE, (ve.enable =3D=3D VGA_ENABLE_THIS));
+=09=09pStub =3D pStub->next;
+=09} while (pStub !=3D &DRM(stub_info));
+=09
+=09if (ve.enable =3D=3D VGA_DISABLE_ALL)
+=09=09return 0;
+
+=09/* Mark us active if requested */=09
+=09if (ve.enable =3D=3D VGA_ENABLE_THIS)
+=09=09dev->vga_active =3D TRUE;
+=09=09
+=09/* Now enable VGA on the target device */
+=09/* loop over all drivers; don't know where the device is */
+=09pStub =3D &DRM(stub_info);
+=09do {
+=09=09pStub->vgaenable(VE_ACTIVE, 0);
+=09=09pStub =3D pStub->next;
+=09} while (pStub !=3D &DRM(stub_info));
+=09
+=09/* Reenable all PCI devices but don't touch VGA state */
+=09pStub =3D &DRM(stub_info);
+=09do {
+=09=09pStub->vgaenable(VE_ENABLE, 0);
+=09=09pStub =3D pStub->next;
+=09} while (pStub !=3D &DRM(stub_info));
+=09
+=09return 0;
+}
=20
=3D=3D=3D=3D=3D include/linux/ioport.h 1.15 vs edited =3D=3D=3D=3D=3D
--- 1.15/include/linux/ioport.h=09Sun Aug 29 00:21:23 2004
+++ edited/include/linux/ioport.h=09Fri Sep 10 01:03:10 2004
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
+#define IORESOURCE_VGA_ENABLE=09=09(1<<3)=09/* VGA device is active */
=20
 /* PC/ISA/whatever - the normal PC address spaces: IO and memory */
 extern struct resource ioport_resource;
=3D=3D=3D=3D=3D include/linux/major.h 1.12 vs edited =3D=3D=3D=3D=3D
--- 1.12/include/linux/major.h=09Fri Mar 19 00:59:29 2004
+++ edited/include/linux/major.h=09Fri Sep 10 21:29:53 2004
@@ -160,6 +160,7 @@
=20
 #define OSST_MAJOR=09=09206=09/* OnStream-SCx0 SCSI tape */
=20
+#define DRM_MAJOR=09=09226=09/* Direct Rendering Manager */
 #define IBM_TTY3270_MAJOR=09227
 #define IBM_FS3270_MAJOR=09228
=20
=3D=3D=3D=3D=3D include/linux/vga.h 1.1 vs edited =3D=3D=3D=3D=3D
--- 1.1/include/linux/vga.h=09Fri Sep 10 01:01:47 2004
+++ edited/include/linux/vga.h=09Fri Sep 10 21:41:00 2004
@@ -1 +1,14 @@
+/*
+ * include/linux/vga.h
+ *
+ * (C) Copyright 2004 Jon Smirl <jonsmirl@yahoo.com>
+ *
+ * VGA control device for ensuring only a single enabled VGA device
+ */
 =20
+/* VGA device shares it's major device number with the DRM devices */
+/* DRM_MAJOR defines the major number in major.h */
+
+#define VGA_MINOR_BASE=090x200=09/* First VGA minor starts here */
+#define VGA_MINOR_MAX=0916=20
+

------=_Part_350_21531592.1095088003838--
