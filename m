Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVCHHTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVCHHTJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 02:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVCHHTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 02:19:08 -0500
Received: from gate.crashing.org ([63.228.1.57]:26793 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261833AbVCHHQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 02:16:24 -0500
Subject: [PATCH] VGA arbitration: draft of kernel side
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: xorg@freedesktop.org, Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Egbert Eich <eich@freedesktop.org>,
       Jon Smirl <jonsmirl@yahoo.com>
Content-Type: text/plain
Date: Tue, 08 Mar 2005 18:11:59 +1100
Message-Id: <1110265919.13607.261.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Ok, so here is a first, totally untested draft for the kernel side
of the VGA arbiter.

BIG NOTE: It's really only the basic arbiter itself, which provides the
API I drafted a bit earlier, with arch hooks similar to what Alan proposed,
it does _NOT_ yet provides a userland interface (to a library providing the
same API hopefully).

It's totally untested (just tested that it builds on ppc32). Some
refinements from my original ideas is the notion of "default" VGA device
which is for vgacon (which would then be able to pass "NULL" to
vga_get/tryget/put, which is handy since current vgacon has no idea of
what a PCI device is). Possible room for a non-PCI device there, but I
haven't completely decided how to deal with that case (see comments in
the code).

Note about vgacon (or vesafb for what matters): I haven't yet looked at
what is involved in getting those adapted to the arbiter. As far as vgacon
is concerned, I strongly suspect that we'll need a way for a console write
to return -EAGAIN, telling to the printk core to come back later (either on
the next printk or from schedul'able time). That shouldn't be too difficult
tho. vesafb may need additional massaging too.

I don't know how much time I'll have on my hands to more forward with
adapting vgacon and doing a userland interface, I expect to be fairly busy
the rest of the week, so if any of you feel like picking up from there,
just let me know.

Ben.

Index: linux-work/include/linux/pci.h
===================================================================
--- linux-work.orig/include/linux/pci.h	2005-01-24 17:09:57.000000000 +1100
+++ linux-work/include/linux/pci.h	2005-03-08 15:26:25.000000000 +1100
@@ -1064,5 +1064,6 @@
 #define PCIPCI_VSFX		16
 #define PCIPCI_ALIMAGIK		32
 
+
 #endif /* __KERNEL__ */
 #endif /* LINUX_PCI_H */
Index: linux-work/drivers/pci/Makefile
===================================================================
--- linux-work.orig/drivers/pci/Makefile	2005-01-24 17:09:38.000000000 +1100
+++ linux-work/drivers/pci/Makefile	2005-03-08 15:20:23.000000000 +1100
@@ -4,7 +4,7 @@
 
 obj-y		+= access.o bus.o probe.o remove.o pci.o quirks.o \
 			names.o pci-driver.o search.o pci-sysfs.o \
-			rom.o
+			rom.o vga.o
 obj-$(CONFIG_PROC_FS) += proc.o
 
 ifndef CONFIG_SPARC64
Index: linux-work/drivers/pci/remove.c
===================================================================
--- linux-work.orig/drivers/pci/remove.c	2005-01-24 17:09:38.000000000 +1100
+++ linux-work/drivers/pci/remove.c	2005-03-08 15:25:52.000000000 +1100
@@ -26,6 +26,7 @@
 
 static void pci_destroy_dev(struct pci_dev *dev)
 {
+	vga_arbiter_del_pci_device(pdev);
 	pci_proc_detach_device(dev);
 	pci_remove_sysfs_dev_files(dev);
 	device_unregister(&dev->dev);
Index: linux-work/drivers/pci/pci.h
===================================================================
--- linux-work.orig/drivers/pci/pci.h	2005-01-24 17:09:38.000000000 +1100
+++ linux-work/drivers/pci/pci.h	2005-03-08 15:26:51.000000000 +1100
@@ -88,3 +88,7 @@
 	return NULL;
 }
 
+
+/* VGA arbiter functions */
+extern void vga_arbiter_add_pci_device(struct pci_dev *pdev);
+extern void vga_arbiter_del_pci_device(struct pci_dev *pdev);
Index: linux-work/drivers/pci/vga.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/drivers/pci/vga.c	2005-03-08 18:04:57.000000000 +1100
@@ -0,0 +1,403 @@
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/sched.h>
+#include <linux/wait.h>
+#include <linux/spinlock.h>
+#include <linux/vga.h>
+
+#include "pci.h"
+
+/*
+ * We keep a list of all vga devices in the system to speed
+ * up the various operations of the arbiter
+ */
+struct vga_device
+{
+	struct list_head	list;
+	struct pci_dev		*pdev;
+	unsigned int		decodes;	/* what does it decodes */
+	unsigned int		owns;		/* what does it owns */
+	unsigned int		locks;		/* what does it locks */
+};
+
+static LIST_HEAD(		vga_list);
+static spinlock_t	       	vga_lock;
+static DECLARE_WAIT_QUEUE_HEAD(	vga_wait_queue);
+
+#ifndef __ARCH_HAS_VGA_DEFAULT_DEVICE
+static struct pci_dev		*vga_default;
+#endif
+
+
+/* Find somebody in our list */
+static struct vga_device *vgadev_find(struct pci_dev *pdev)
+{
+	struct vga_device *vgadev;
+
+	list_for_each_entry(vgadev, &vga_list, list)
+		if (pdev == vgadev->pdev)
+			return vgadev;
+	return NULL;
+}
+
+/* Returns the default VGA device (vgacon's babe) */
+#ifndef __ARCH_HAS_VGA_DEFAULT_DEVICE
+struct pci_dev *vga_default_device(void)
+{
+	return vga_default;
+}
+#endif
+
+/* Architecture can override enabling/disabling of a given
+ * device resources here
+ */
+#ifndef __ARCH_HAS_VGA_DISABLE_RESOURCES
+static inline void vga_disable_resources(struct pci_dev *pdev,
+					 unsigned int rsrc,
+					 unsigned int change_bridge)
+{
+	struct pci_bus *bus;
+	struct pci_dev *bridge;
+	u16 cmd;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	if (rsrc & VGA_RSRC_IO)
+		cmd &= ~PCI_COMMAND_IO;
+	if (rsrc & VGA_RSRC_MEM)
+		cmd &= ~PCI_COMMAND_MEMORY;
+	pci_write_config_word(pdev, PCI_COMMAND, cmd);
+
+	if (!change_bridge)
+		return;
+
+	bus = pdev->bus;
+	while (bus) {
+		bridge = bus->self;
+		if (bridge) {
+			pci_read_config_word(bridge, PCI_BRIDGE_CONTROL, &cmd);
+			if (!(cmd & PCI_BRIDGE_CTL_VGA))
+				continue;
+			cmd &= ~PCI_BRIDGE_CTL_VGA;
+			pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, cmd);
+		}
+		bus = bus->parent;
+	}
+}
+#endif
+
+#ifndef __ARCH_HAS_VGA_ENABLE_RESOURCES
+static inline void vga_enable_resources(struct pci_dev *pdev,
+					 unsigned int rsrc)
+{
+	struct pci_bus *bus;
+	struct pci_dev *bridge;
+	u16 cmd;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	if (rsrc & VGA_RSRC_IO)
+		cmd |= PCI_COMMAND_IO;
+	if (rsrc & VGA_RSRC_MEM)
+		cmd |= PCI_COMMAND_MEMORY;
+	pci_write_config_word(pdev, PCI_COMMAND, cmd);
+
+	bus = pdev->bus;
+	while (bus) {
+		bridge = bus->self;
+		if (bridge) {
+			pci_read_config_word(bridge, PCI_BRIDGE_CONTROL, &cmd);
+			if (cmd & PCI_BRIDGE_CTL_VGA)
+				continue;
+			cmd |= PCI_BRIDGE_CTL_VGA;
+			pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, cmd);
+		}
+		bus = bus->parent;
+	}
+}
+#endif
+
+static struct vga_device * __vga_tryget(struct vga_device *vgadev,
+					unsigned int rsrc)
+{
+	unsigned int wants, match;
+	struct vga_device *conflict;
+
+	/* Check what resources we need to acquire */
+	wants = rsrc & !vgadev->owns;
+
+	/* We already own everything, just mark locked & bye bye */
+	if (wants == 0)
+		goto lock_them;
+
+	/* Ok, we don't, let's find out how we need to kick off */
+	list_for_each_entry(conflict, &vga_list, list) {
+		unsigned int lwants = wants;
+		unsigned int change_bridge = 0;
+
+		/* Check if the architecture allows a conflict between those
+		 * 2 devices or if they are on separate domains
+		 */
+		if (!vga_conflicts(vgadev->pdev, conflict->pdev))
+			continue;
+
+		/* We have a possible conflict. before we go further, we must
+		 * check if we sit on the same bus as the conflicting device.
+		 * if we don't, then we must tie both IO and MEM resources
+		 * together since there is only a single bit controlling
+		 * VGA forwarding on P2P bridges
+		 */
+		if (vgadev->pdev->bus != conflict->pdev->bus) {
+			change_bridge = 1;
+			lwants = VGA_RSRC_IO | VGA_RSRC_MEM;
+		}
+
+		/* Check if the guy has a lock on the resource. If he does,
+		 * return the conflicting entry
+		 */
+		if (conflict->locks & lwants)
+			return conflict;
+
+		/* Ok, now check if he owns the resource we want. We don't need
+		 * to check "decodes" since it should be impossible to have
+		 * own resources you don't decode unless I have a bug in this
+		 * code...
+		 */
+		WARN_ON(conflict->owns & !conflict->decodes);
+		match = lwants & conflict->owns;
+		if (!match)
+			continue;
+
+		/* looks like he doesn't have a lock, we can steal
+		 * them from him
+		 */
+		vga_disable_resources(conflict->pdev, lwants, change_bridge);
+		conflict->owns &= ~lwants;
+	}
+
+	/* ok dude, we got it, everybody has been disabled, let's
+	 * enable us. Make sure we don't mark a bit in "owns" that
+	 * we don't also have in "decodes". We can lock resources
+	 * we don't decode but not own them.
+	 */
+	vga_enable_resources(vgadev->pdev, wants);
+	vgadev->owns |= (wants & vgadev->decodes);
+ lock_them:
+	vgadev->locks |= rsrc;
+
+	return NULL;
+}
+
+static void __vga_put(struct vga_device *vgadev, unsigned int rsrc)
+{
+	/* Just clear lock bits, we do lazy operations so we don't really
+	 * have to bother about anything else at this point
+	 */
+	vgadev->locks &= ~rsrc;
+
+	/* Kick the wait queue in case somebody was waiting */
+	wake_up_all(&vga_wait_queue);
+}
+
+int vga_get(struct pci_dev *pdev, unsigned int rsrc)
+{
+	struct vga_device *vgadev, *conflict;
+	unsigned long flags;
+        wait_queue_t wait;
+	int rc = 0;
+
+	if (pdev == NULL)
+		pdev = vga_default_device();
+	if (pdev == NULL)
+		return 0;
+	spin_lock_irqsave(&vga_lock, flags);
+	vgadev = vgadev_find(pdev);
+	if (vgadev == NULL) {
+		rc = -ENODEV;
+		goto bail;
+	}
+	for (;;) {
+		conflict = __vga_tryget(vgadev, rsrc);
+		if (conflict == NULL)
+			break;
+
+		/* We have a conflict, we wait until somebody kicks the
+		 * work queue. Currently we have one work queue that we
+		 * kick each time some resources are released, but it would
+		 * be fairly easy to have a per device one so that we only
+		 * need to attach to the conflicting device
+		 */
+		init_waitqueue_entry(&wait, current);
+		add_wait_queue(&vga_wait_queue, &wait);
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (signal_pending(current)) {
+			rc = -EINTR;
+			break;
+		}
+		schedule();
+		remove_wait_queue(&vga_wait_queue, &wait);
+		set_current_state(TASK_RUNNING);
+	}
+ bail:
+	spin_unlock_irqrestore(&vga_lock, flags);
+	return rc;
+}
+
+int vga_tryget(struct pci_dev *pdev, unsigned int rsrc)
+{
+	struct vga_device *vgadev;
+	unsigned long flags;
+	int rc = 0;
+
+	if (pdev == NULL)
+		pdev = vga_default_device();
+	if (pdev == NULL)
+		return 0;
+	spin_lock_irqsave(&vga_lock, flags);
+	vgadev = vgadev_find(pdev);
+	if (vgadev == NULL) {
+		rc = -ENODEV;
+		goto bail;
+	}
+	if (__vga_tryget(vgadev, rsrc))
+		rc = -EBUSY;
+ bail:
+	spin_unlock_irqrestore(&vga_lock, flags);
+	return rc;
+}
+
+void vga_put(struct pci_dev *pdev, unsigned int rsrc)
+{
+	struct vga_device *vgadev;
+	unsigned long flags;
+
+	if (pdev == NULL)
+		pdev = vga_default_device();
+	if (pdev == NULL)
+		return;
+	spin_lock_irqsave(&vga_lock, flags);
+	vgadev = vgadev_find(pdev);
+	if (vgadev == NULL)
+		goto bail;
+	__vga_put(vgadev, rsrc);
+ bail:
+	spin_unlock_irqrestore(&vga_lock, flags);
+}
+
+
+/*
+ * Currently, we assume that the "initial" setup of the system is
+ * sane, that is we don't come up with conflicting devices, which
+ * would be annoying. We could double check and be better at
+ * deciding who is the default here, but we don't. 
+ */
+void vga_arbiter_add_pci_device(struct pci_dev *pdev)
+{
+	struct vga_device *vgadev;
+	unsigned long flags;
+	struct pci_bus *bus;
+	struct pci_dev *bridge;
+	u16 cmd;
+
+	/* Only deal with VGA class devices */
+	if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
+		return;
+
+	/* Allocate structure */
+	vgadev = kmalloc(sizeof(struct vga_device), GFP_KERNEL);
+	memset(vgadev, 0, sizeof(*vgadev));
+
+	/* Take lock & check for duplicates */
+	spin_lock_irqsave(&vga_lock, flags);
+	if (vgadev_find(pdev) != NULL) {
+		WARN_ON(1);
+		goto fail;
+	}
+	vgadev->pdev = pdev;
+
+	/* By default, assume we decode everything */
+	vgadev->decodes = VGA_RSRC_IO | VGA_RSRC_MEM;
+
+	/* Mark that we "own" resources based on our enables, we will
+	 * clear that below if the bridge isn't forwarding
+	 */
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	if (cmd & PCI_COMMAND_IO)
+		vgadev->owns |= VGA_RSRC_IO;
+	if (cmd & PCI_COMMAND_MEMORY)
+		vgadev->owns |= VGA_RSRC_MEM;
+
+	/* Check if VGA cycles can get down to us */
+	bus = pdev->bus;
+	while (bus) {
+		bridge = bus->self;
+		if (bridge) {
+			u16 l;
+			pci_read_config_word(bridge, PCI_BRIDGE_CONTROL, &l);
+			if (!(l & PCI_BRIDGE_CTL_VGA)) {
+				vgadev->owns = 0;
+				break;
+			}
+		}
+		bus = bus->parent;
+	}
+
+	/* Deal with VGA default device. Use first enabled one
+	 * by default if arch doesn't have it's own hook
+	 */
+#ifndef __ARCH_HAS_VGA_DEFAULT_DEVICE
+	if (vga_default == NULL && (vgadev->owns & VGA_RSRC_MEM) &&
+	    (vgadev->owns & VGA_RSRC_IO))
+		vga_default = pdev;
+
+#endif
+
+	/* Add to the list */
+	list_add(&vgadev->list, &vga_list);
+	spin_unlock_irqrestore(&vga_lock, flags);
+ fail:
+	spin_unlock_irqrestore(&vga_lock, flags);
+	kfree(vgadev);
+}
+
+void vga_arbiter_del_pci_device(struct pci_dev *pdev)
+{
+	struct vga_device *vgadev;
+	unsigned long flags;
+
+	spin_lock_irqsave(&vga_lock, flags);
+	vgadev = vgadev_find(pdev);
+	if (vgadev == NULL)
+		goto bail;
+	if (vgadev->locks)
+		__vga_put(vgadev, vgadev->locks);
+	list_del(&vgadev->list);
+ bail:
+	spin_unlock_irqrestore(&vga_lock, flags);
+	if (vgadev)
+		kfree(vgadev);
+}
+
+void vga_set_legacy_decoding(struct pci_dev *pdev, unsigned int decodes)
+{
+	struct vga_device *vgadev;
+	unsigned long flags;
+
+	spin_lock_irqsave(&vga_lock, flags);
+	vgadev = vgadev_find(pdev);
+	if (vgadev == NULL)
+		goto bail;
+
+	vgadev->decodes = decodes;
+	vgadev->owns &= decodes;
+
+	/* XXX if somebody is going from "doesn't decode" to "decodes" state
+	 * here, additional care must be taken. Basically, we probably want
+	 * to disable it preventively in that case, but I have to make sure
+	 * of that...
+	 */
+ bail:
+	spin_unlock_irqrestore(&vga_lock, flags);
+}
Index: linux-work/include/linux/vga.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/include/linux/vga.h	2005-03-08 18:03:40.000000000 +1100
@@ -0,0 +1,62 @@
+/*
+ *	vga.h
+ *
+ *	VGA Arbiter functions
+ *
+ *	Copyright 2005 Benjamin Herrenschmidt
+ *	               <benh@kernel.crashing.org>
+ *
+ */
+
+#ifndef LINUX_VGA_H
+
+#include <asm/vga.h>
+
+#define VGA_RSRC_IO	0x01
+#define VGA_RSRC_MEM	0x02
+
+/* Passing that instead of a pci_dev to use the system "default"
+ * device, that is the one used by vgacon. Archs will probably
+ * have to provide their own vga_default_device();
+ */
+#define VGA_DEFAULT_DEVICE	(NULL)
+
+/* For use by clients */
+
+extern void vga_set_legacy_decoding(struct pci_dev *pdev,
+				    unsigned int decodes);
+extern int vga_get(struct pci_dev *pdev, unsigned int rsrc);
+extern int vga_tryget(struct pci_dev *pdev, unsigned int rsrc);
+extern void vga_put(struct pci_dev *pdev, unsigned int rsrc);
+
+
+/* This can be defined by the platform. The default implementation
+ * is rather dumb and will probably only work properly on single
+ * vga card setups and/or x86 platforms.
+ *
+ * If your VGA default device is not PCI, you'll have to return
+ * NULL here. In this case, I assume it will not conflict with
+ * any PCI card. If this is not true, I'll have to define two archs
+ * hooks for enabling/disabling the VGA default device if that is
+ * possible. This may be a problem with real _ISA_ VGA cards, in
+ * addition to a PCI one. I don't know at this point how to deal
+ * with that card. Can theirs IOs be disabled at all ? If not, then
+ * I suppose it's a matter of having the proper arch hook telling
+ * us about it, so we basically never allow anybody to succeed a
+ * vga_get()...
+ */
+#ifndef __ARCH_HAS_VGA_DEFAULT_DEVICE
+extern struct pci_dev *vga_default_device(void);
+#endif
+
+/* Architectures should define this if they have several
+ * independant PCI domains that can afford concurrent VGA decoding
+ */
+#ifndef __ARCH_HAS_VGA_CONFLICT
+static inline int vga_conflicts(struct pci_dev *p1, struct pci_dev *p2)
+{
+	return 1;
+}
+#endif
+
+#endif /* LINUX_VGA_H */


