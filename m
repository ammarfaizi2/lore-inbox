Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265083AbUELAMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265083AbUELAMV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 20:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265082AbUELAMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 20:12:21 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:57559 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S265083AbUELADM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 20:03:12 -0400
Date: Tue, 11 May 2004 17:01:50 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: [PATCH 1/2] PPC32: New OCP core support
Message-ID: <20040511170150.A4743@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New OCP infrastructure ported from 2.4 along with several
enhancements. Please apply.

-Matt

diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	Tue May 11 14:56:45 2004
+++ b/arch/ppc/Kconfig	Tue May 11 14:56:45 2004
@@ -1238,7 +1238,7 @@
 	bool "Support for early boot texts over serial port"
 	depends on 4xx || GT64260 || LOPEC || PPLUS || PRPMC800 || PPC_GEN550
 
-config OCP
+config PPC_OCP
 	bool
 	depends on IBM_OCP
 	default y
diff -Nru a/arch/ppc/Makefile b/arch/ppc/Makefile
--- a/arch/ppc/Makefile	Tue May 11 14:56:45 2004
+++ b/arch/ppc/Makefile	Tue May 11 14:56:45 2004
@@ -43,7 +43,6 @@
 drivers-$(CONFIG_8xx)		+= arch/ppc/8xx_io/
 drivers-$(CONFIG_4xx)		+= arch/ppc/4xx_io/
 drivers-$(CONFIG_8260)		+= arch/ppc/8260_io/
-drivers-$(CONFIG_OCP)		+= arch/ppc/ocp/
 
 BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd vmlinux.sm
 
diff -Nru a/arch/ppc/kernel/setup.c b/arch/ppc/kernel/setup.c
--- a/arch/ppc/kernel/setup.c	Tue May 11 14:56:45 2004
+++ b/arch/ppc/kernel/setup.c	Tue May 11 14:56:45 2004
@@ -37,6 +37,7 @@
 #include <asm/sections.h>
 #include <asm/nvram.h>
 #include <asm/xmon.h>
+#include <asm/ocp.h>
 
 #if defined CONFIG_KGDB
 #include <asm/kgdb.h>
@@ -682,6 +683,12 @@
 	/* set up the bootmem stuff with available memory */
 	do_init_bootmem();
 	if ( ppc_md.progress ) ppc_md.progress("setup_arch: bootmem", 0x3eab);
+
+#ifdef CONFIG_PPC_OCP
+	/* Initialize OCP device list */
+	ocp_early_init();
+	if ( ppc_md.progress ) ppc_md.progress("ocp: exit", 0x3eab);
+#endif
 
 	ppc_md.setup_arch();
 	if ( ppc_md.progress ) ppc_md.progress("arch: exit", 0x3eab);
diff -Nru a/arch/ppc/ocp/Makefile b/arch/ppc/ocp/Makefile
--- a/arch/ppc/ocp/Makefile	Tue May 11 14:56:45 2004
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,6 +0,0 @@
-#
-# Makefile for the linux kernel.
-#
-
-obj-y   	:= ocp.o ocp-driver.o ocp-probe.o
-
diff -Nru a/arch/ppc/ocp/ocp-driver.c b/arch/ppc/ocp/ocp-driver.c
--- a/arch/ppc/ocp/ocp-driver.c	Tue May 11 14:56:45 2004
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,195 +0,0 @@
-/*
- * FILE NAME: ocp-driver.c
- *
- * BRIEF MODULE DESCRIPTION:
- * driver callback, id matching and registration
- * Based on drivers/pci/pci-driver, Copyright (c) 1997--1999 Martin Mares
- *
- * Maintained by: Armin <akuster@mvista.com>
- *
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <asm/ocp.h>
-#include <linux/module.h>
-#include <linux/init.h>
-
-/*
- *  Registration of OCP drivers and handling of hot-pluggable devices.
- */
-
-static int
-ocp_device_probe(struct device *dev)
-{
-	int error = 0;
-	struct ocp_driver *drv;
-	struct ocp_device *ocp_dev;
-
-	drv = to_ocp_driver(dev->driver);
-	ocp_dev = to_ocp_dev(dev);
-
-	if (drv->probe) {
-		error = drv->probe(ocp_dev);
-		DBG("probe return code %d\n", error);
-		if (error >= 0) {
-			ocp_dev->driver = drv;
-			error = 0;
-		}
-	}
-	return error;
-}
-
-static int
-ocp_device_remove(struct device *dev)
-{
-	struct ocp_device *ocp_dev = to_ocp_dev(dev);
-
-	if (ocp_dev->driver) {
-		if (ocp_dev->driver->remove)
-			ocp_dev->driver->remove(ocp_dev);
-		ocp_dev->driver = NULL;
-	}
-	return 0;
-}
-
-static int
-ocp_device_suspend(struct device *dev, u32 state, u32 level)
-{
-	struct ocp_device *ocp_dev = to_ocp_dev(dev);
-
-	int error = 0;
-
-	if (ocp_dev->driver) {
-		if (level == SUSPEND_SAVE_STATE && ocp_dev->driver->save_state)
-			error = ocp_dev->driver->save_state(ocp_dev, state);
-		else if (level == SUSPEND_POWER_DOWN
-			 && ocp_dev->driver->suspend)
-			error = ocp_dev->driver->suspend(ocp_dev, state);
-	}
-	return error;
-}
-
-static int
-ocp_device_resume(struct device *dev, u32 level)
-{
-	struct ocp_device *ocp_dev = to_ocp_dev(dev);
-
-	if (ocp_dev->driver) {
-		if (level == RESUME_POWER_ON && ocp_dev->driver->resume)
-			ocp_dev->driver->resume(ocp_dev);
-	}
-	return 0;
-}
-
-/**
- * ocp_bus_match - Works out whether an OCP device matches any
- * of the IDs listed for a given OCP driver.
- * @dev: the generic device struct for the OCP device
- * @drv: the generic driver struct for the OCP driver
- *
- * Used by a driver to check whether a OCP device present in the
- * system is in its list of supported devices.  Returns 1 for a
- * match, or 0 if there is no match.
- */
-static int
-ocp_bus_match(struct device *dev, struct device_driver *drv)
-{
-	struct ocp_device *ocp_dev = to_ocp_dev(dev);
-	struct ocp_driver *ocp_drv = to_ocp_driver(drv);
-	const struct ocp_device_id *ids = ocp_drv->id_table;
-
-	if (!ids)
-		return 0;
-
-	while (ids->vendor || ids->device) {
-		if ((ids->vendor == OCP_ANY_ID
-		     || ids->vendor == ocp_dev->vendor)
-		    && (ids->device == OCP_ANY_ID
-			|| ids->device == ocp_dev->device)) {
-			DBG("Bus match -vendor:%x device:%x\n", ids->vendor,
-			    ids->device);
-			return 1;
-		}
-		ids++;
-	}
-	return 0;
-}
-
-struct bus_type ocp_bus_type = {
-	.name = "ocp",
-	.match = ocp_bus_match,
-};
-
-static int __init
-ocp_driver_init(void)
-{
-	return bus_register(&ocp_bus_type);
-}
-
-postcore_initcall(ocp_driver_init);
-
-/**
- * ocp_register_driver - register a new ocp driver
- * @drv: the driver structure to register
- *
- * Adds the driver structure to the list of registered drivers
- * Returns the number of ocp devices which were claimed by the driver
- * during registration.  The driver remains registered even if the
- * return value is zero.
- */
-int
-ocp_register_driver(struct ocp_driver *drv)
-{
-	int count = 0;
-
-	/* initialize common driver fields */
-	drv->driver.name = drv->name;
-	drv->driver.bus = &ocp_bus_type;
-	drv->driver.probe = ocp_device_probe;
-	drv->driver.resume = ocp_device_resume;
-	drv->driver.suspend = ocp_device_suspend;
-	drv->driver.remove = ocp_device_remove;
-
-	/* register with core */
-	count = driver_register(&drv->driver);
-	return count ? count : 1;
-}
-
-/**
- * ocp_unregister_driver - unregister a ocp driver
- * @drv: the driver structure to unregister
- *
- * Deletes the driver structure from the list of registered OCP drivers,
- * gives it a chance to clean up by calling its remove() function for
- * each device it was responsible for, and marks those devices as
- * driverless.
- */
-
-void
-ocp_unregister_driver(struct ocp_driver *drv)
-{
-	driver_unregister(&drv->driver);
-}
-
-EXPORT_SYMBOL(ocp_register_driver);
-EXPORT_SYMBOL(ocp_unregister_driver);
-EXPORT_SYMBOL(ocp_bus_type);
diff -Nru a/arch/ppc/ocp/ocp-probe.c b/arch/ppc/ocp/ocp-probe.c
--- a/arch/ppc/ocp/ocp-probe.c	Tue May 11 14:56:45 2004
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,113 +0,0 @@
-/*
- * FILE NAME: ocp-probe.c
- *
- * BRIEF MODULE DESCRIPTION:
- * Device scanning & bus set routines
- * Based on drivers/pci/probe, Copyright (c) 1997--1999 Martin Mares
- *
- * Maintained by: Armin <akuster@mvista.com>
- *
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <asm/ocp.h>
-
-LIST_HEAD(ocp_devices);
-struct device *ocp_bus;
-
-static struct ocp_device * __devinit
-ocp_setup_dev(struct ocp_def *odef, unsigned int index)
-{
-	struct ocp_device *dev;
-
-	dev = kmalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev)
-		return NULL;
-	memset(dev, 0, sizeof(*dev));
-
-	dev->vendor = odef->vendor;
-	dev->device = odef->device;
-	dev->num = ocp_get_num(dev->device);
-	dev->paddr = odef->paddr;
-	dev->irq = odef->irq;
-	dev->pm = odef->pm;
-	dev->current_state = 4;
-
-	sprintf(dev->name, "OCP device %04x:%04x", dev->vendor, dev->device);
-
-	DBG("%s %s 0x%lx irq:%d pm:0x%lx \n", dev->slot_name, dev->name,
-	    (unsigned long) dev->paddr, dev->irq, dev->pm);
-
-	/* now put in global tree */
-	sprintf(dev->dev.bus_id, "%d", index);
-	dev->dev.parent = ocp_bus;
-	dev->dev.bus = &ocp_bus_type;
-	device_register(&dev->dev);
-
-	return dev;
-}
-
-static struct device * __devinit ocp_alloc_primary_bus(void)
-{
-	struct device *b;
-
-	b = kmalloc(sizeof(struct device), GFP_KERNEL);
-	if (b == NULL)
-		return NULL;
-	memset(b, 0, sizeof(struct device));
-	strcpy(b->bus_id, "ocp");
-
-	device_register(b);
-
-	return b;
-}
-
-void __devinit ocp_setup_devices(struct ocp_def *odef)
-{
-	int index;
-	struct ocp_device *dev;
-
-	if (ocp_bus == NULL)
-		ocp_bus = ocp_alloc_primary_bus();
-	for (index = 0; odef->vendor != OCP_VENDOR_INVALID; ++index, ++odef) {
-		dev = ocp_setup_dev(odef, index);
-		if (dev != NULL)
-			list_add_tail(&dev->global_list, &ocp_devices);
-	}
-}
-
-extern struct ocp_def core_ocp[];
-
-static int __init
-ocparch_init(void)
-{
-	ocp_setup_devices(core_ocp);
-	return 0;
-}
-
-subsys_initcall(ocparch_init);
-
-EXPORT_SYMBOL(ocp_devices);
diff -Nru a/arch/ppc/ocp/ocp.c b/arch/ppc/ocp/ocp.c
--- a/arch/ppc/ocp/ocp.c	Tue May 11 14:56:45 2004
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,109 +0,0 @@
-/*
- * ocp.c
- *
- *	The is drived from pci.c
- *
- * 	Current Maintainer
- *      Armin Kuster akuster@dslextreme.com
- *      Jan, 2002
- *
- *
- *
- * This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR   IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT,  INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/list.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/config.h>
-#include <linux/stddef.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-#include <asm/io.h>
-#include <asm/ocp.h>
-#include <asm/errno.h>
-
-/**
- * ocp_get_num - This determines how many OCP devices of a given
- * device are registered
- * @device: OCP device such as HOST, PCI, GPT, UART, OPB, IIC, GPIO, EMAC, ZMII,
- *
- * The routine returns the number that devices which is registered
- */
-unsigned int ocp_get_num(unsigned int device)
-{
-	unsigned int count = 0;
-	struct ocp_device *ocp;
-	struct list_head *ocp_l;
-
-	list_for_each(ocp_l, &ocp_devices) {
-		ocp = list_entry(ocp_l, struct ocp_device, global_list);
-		if (device == ocp->device)
-			count++;
-	}
-	return count;
-}
-
-/**
- * ocp_get_dev - get ocp driver pointer for ocp device and instance of it
- * @device: OCP device such as PCI, GPT, UART, OPB, IIC, GPIO, EMAC, ZMII
- * @dev_num: ocp device number whos paddr you want
- *
- * The routine returns ocp device pointer
- * in list based on device and instance of that device
- *
- */
-struct ocp_device *
-ocp_get_dev(unsigned int device, int dev_num)
-{
-	struct ocp_device *ocp;
-	struct list_head *ocp_l;
-	int count = 0;
-
-	list_for_each(ocp_l, &ocp_devices) {
-		ocp = list_entry(ocp_l, struct ocp_device, global_list);
-		if (device == ocp->device) {
-			if (dev_num == count)
-				return ocp;
-			count++;
-		}
-	}
-	return NULL;
-}
-
-EXPORT_SYMBOL(ocp_get_dev);
-EXPORT_SYMBOL(ocp_get_num);
-
-#ifdef CONFIG_PM
-int ocp_generic_suspend(struct ocp_device *pdev, u32 state)
-{
-	ocp_force_power_off(pdev);
-	return 0;
-}
-
-int ocp_generic_resume(struct ocp_device *pdev)
-{
-	ocp_force_power_on(pdev);
-}
-
-EXPORT_SYMBOL(ocp_generic_suspend);
-EXPORT_SYMBOL(ocp_generic_resume);
-#endif /* CONFIG_PM */
diff -Nru a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile	Tue May 11 14:56:45 2004
+++ b/arch/ppc/syslib/Makefile	Tue May 11 14:56:45 2004
@@ -13,6 +13,7 @@
 CFLAGS_btext.o          += -mrelocatable-lib
 
 obj-$(CONFIG_PPCBUG_NVRAM)	+= prep_nvram.o
+obj-$(CONFIG_PPC_OCP)		+= ocp.o
 obj-$(CONFIG_44x)		+= ibm44x_common.o
 obj-$(CONFIG_440GP)		+= ibm440gp_common.o
 ifeq ($(CONFIG_4xx),y)
diff -Nru a/arch/ppc/syslib/ocp.c b/arch/ppc/syslib/ocp.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ppc/syslib/ocp.c	Tue May 11 14:56:45 2004
@@ -0,0 +1,584 @@
+/*
+ * ocp.c
+ *
+ *      (c) Benjamin Herrenschmidt (benh@kernel.crashing.org)
+ *          Mipsys - France
+ *
+ *          Derived from work (c) Armin Kuster akuster@pacbell.net
+ *
+ *          Additional support and port to 2.6 LDM/sysfs by
+ *          Matt Porter <mporter@kernel.crashing.org>
+ *          Copyright 2004 MontaVista Software, Inc.
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/list.h>
+#include <linux/miscdevice.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/pm.h>
+#include <linux/bootmem.h>
+#include <linux/device.h>
+
+#include <asm/io.h>
+#include <asm/ocp.h>
+#include <asm/errno.h>
+#include <asm/rwsem.h>
+#include <asm/semaphore.h>
+
+//#define DBG(x)	printk x
+#define DBG(x)
+
+extern int mem_init_done;
+
+extern struct ocp_def core_ocp[];	/* Static list of devices, provided by
+					   CPU core */
+
+LIST_HEAD(ocp_devices);			/* List of all OCP devices */
+DECLARE_RWSEM(ocp_devices_sem);		/* Global semaphores for those lists */
+
+static int ocp_inited;
+
+/* Sysfs support */
+#define OCP_DEF_ATTR(field, format_string)				\
+static ssize_t								\
+show_##field(struct device *dev, char *buf)				\
+{									\
+	struct ocp_device *odev = to_ocp_dev(dev);			\
+									\
+	return sprintf(buf, format_string, odev->def->field);		\
+}									\
+static DEVICE_ATTR(field, S_IRUGO, show_##field, NULL);
+
+OCP_DEF_ATTR(vendor, "0x%04x\n");
+OCP_DEF_ATTR(function, "0x%04x\n");
+OCP_DEF_ATTR(index, "0x%04x\n");
+#ifdef CONFIG_PTE_64BIT
+OCP_DEF_ATTR(paddr, "0x%16Lx\n");
+#else
+OCP_DEF_ATTR(paddr, "0x%08lx\n");
+#endif
+OCP_DEF_ATTR(irq, "%d\n");
+OCP_DEF_ATTR(pm, "%lu\n");
+
+void ocp_create_sysfs_dev_files(struct ocp_device *odev)
+{
+	struct device *dev = &odev->dev;
+
+	/* Current OCP device def attributes */
+	device_create_file(dev, &dev_attr_vendor);
+	device_create_file(dev, &dev_attr_function);
+	device_create_file(dev, &dev_attr_index);
+	device_create_file(dev, &dev_attr_paddr);
+	device_create_file(dev, &dev_attr_irq);
+	device_create_file(dev, &dev_attr_pm);
+	/* Current OCP device additions attributes */
+	if (odev->def->additions && odev->def->show)
+		odev->def->show(dev);
+}
+
+/**
+ *	ocp_device_match	-	Match one driver to one device
+ *	@drv: driver to match
+ *	@dev: device to match
+ *
+ *	This function returns 0 if the driver and device don't match
+ */
+static int
+ocp_device_match(struct device *dev, struct device_driver *drv)
+{
+	struct ocp_device *ocp_dev = to_ocp_dev(dev);
+	struct ocp_driver *ocp_drv = to_ocp_drv(drv);
+	const struct ocp_device_id *ids = ocp_drv->id_table;
+
+	if (!ids)
+		return 0;
+
+	while (ids->vendor || ids->function) {
+		if ((ids->vendor == OCP_ANY_ID
+		     || ids->vendor == ocp_dev->def->vendor)
+		    && (ids->function == OCP_ANY_ID
+			|| ids->function == ocp_dev->def->function))
+		        return 1;
+		ids++;
+	}
+	return 0;
+}
+
+static int
+ocp_device_probe(struct device *dev)
+{
+	int error = 0;
+	struct ocp_driver *drv;
+	struct ocp_device *ocp_dev;
+
+	drv = to_ocp_drv(dev->driver);
+	ocp_dev = to_ocp_dev(dev);
+
+	if (drv->probe) {
+		error = drv->probe(ocp_dev);
+		if (error >= 0) {
+			ocp_dev->driver = drv;
+			error = 0;
+		}
+	}
+	return error;
+}
+
+static int
+ocp_device_remove(struct device *dev)
+{
+	struct ocp_device *ocp_dev = to_ocp_dev(dev);
+
+	if (ocp_dev->driver) {
+		if (ocp_dev->driver->remove)
+			ocp_dev->driver->remove(ocp_dev);
+		ocp_dev->driver = NULL;
+	}
+	return 0;
+}
+
+static int
+ocp_device_suspend(struct device *dev, u32 state)
+{
+	struct ocp_device *ocp_dev = to_ocp_dev(dev);
+	struct ocp_driver *ocp_drv = to_ocp_drv(dev->driver);
+
+	if (dev->driver && ocp_drv->suspend)
+		return ocp_drv->suspend(ocp_dev, state);
+	return 0;
+}
+
+static int
+ocp_device_resume(struct device *dev)
+{
+	struct ocp_device *ocp_dev = to_ocp_dev(dev);
+	struct ocp_driver *ocp_drv = to_ocp_drv(dev->driver);
+
+	if (dev->driver && ocp_drv->resume)
+		return ocp_drv->resume(ocp_dev);
+	return 0;
+}
+
+struct bus_type ocp_bus_type = {
+	.name = "ocp",
+	.match = ocp_device_match,
+	.suspend = ocp_device_suspend,
+	.resume = ocp_device_resume,
+};
+
+/**
+ *	ocp_register_driver	-	Register an OCP driver
+ *	@drv: pointer to statically defined ocp_driver structure
+ *
+ *	The driver's probe() callback is called either recursively
+ *	by this function or upon later call of ocp_driver_init
+ *
+ *	NOTE: Detection of devices is a 2 pass step on this implementation,
+ *	hotswap isn't supported. First, all OCP devices are put in the device
+ *	list, _then_ all drivers are probed on each match.
+ *
+ *	This function returns a count of how many devices actually matched
+ *	(whether the probe routine returned 0 or -ENODEV, a different error
+ *	code isn't considered as a match).
+ */
+int
+ocp_register_driver(struct ocp_driver *drv)
+{
+	int count = 0;
+
+	/* initialize common driver fields */
+	drv->driver.name = drv->name;
+	drv->driver.bus = &ocp_bus_type;
+	drv->driver.probe = ocp_device_probe;
+	drv->driver.remove = ocp_device_remove;
+
+	/* register with core */
+	count = driver_register(&drv->driver);
+
+	return count ? count : 1;
+}
+
+/**
+ *	ocp_unregister_driver	-	Unregister an OCP driver
+ *	@drv: pointer to statically defined ocp_driver structure
+ *
+ *	The driver's remove() callback is called recursively
+ *	by this function for any device already registered
+ */
+void
+ocp_unregister_driver(struct ocp_driver *drv)
+{
+	DBG(("ocp: ocp_unregister_driver(%s)...\n", drv->name));
+
+	driver_unregister(&drv->driver);
+
+	DBG(("ocp: ocp_unregister_driver(%s)... done.\n", drv->name));
+}
+
+/* Core of ocp_find_device(). Caller must hold ocp_devices_sem */
+static struct ocp_device *
+__ocp_find_device(unsigned int vendor, unsigned int function, int index)
+{
+	struct list_head	*entry;
+	struct ocp_device	*dev, *found = NULL;
+
+	DBG(("ocp: __ocp_find_device(vendor: %x, function: %x, index: %d)...\n", vendor, function, index));
+
+	list_for_each(entry, &ocp_devices) {
+		dev = list_entry(entry, struct ocp_device, link);
+		if (vendor != OCP_ANY_ID && vendor != dev->def->vendor)
+			continue;
+		if (function != OCP_ANY_ID && function != dev->def->function)
+			continue;
+		if (index != OCP_ANY_INDEX && index != dev->def->index)
+			continue;
+		found = dev;
+		break;
+	}
+
+	DBG(("ocp: __ocp_find_device(vendor: %x, function: %x, index: %d)... done\n", vendor, function, index));
+
+	return found;
+}
+
+/**
+ *	ocp_find_device	-	Find a device by function & index
+ *      @vendor: vendor ID of the device (or OCP_ANY_ID)
+ *	@function: function code of the device (or OCP_ANY_ID)
+ *	@idx: index of the device (or OCP_ANY_INDEX)
+ *
+ *	This function allows a lookup of a given function by it's
+ *	index, it's typically used to find the MAL or ZMII associated
+ *	with an EMAC or similar horrors.
+ *      You can pass vendor, though you usually want OCP_ANY_ID there...
+ */
+struct ocp_device *
+ocp_find_device(unsigned int vendor, unsigned int function, int index)
+{
+	struct ocp_device	*dev;
+
+	down_read(&ocp_devices_sem);
+	dev = __ocp_find_device(vendor, function, index);
+	up_read(&ocp_devices_sem);
+
+	return dev;
+}
+
+/**
+ *	ocp_get_one_device -	Find a def by function & index
+ *      @vendor: vendor ID of the device (or OCP_ANY_ID)
+ *	@function: function code of the device (or OCP_ANY_ID)
+ *	@idx: index of the device (or OCP_ANY_INDEX)
+ *
+ *	This function allows a lookup of a given ocp_def by it's
+ *	vendor, function, and index.  The main purpose for is to
+ *	allow modification of the def before binding to the driver
+ */
+struct ocp_def *
+ocp_get_one_device(unsigned int vendor, unsigned int function, int index)
+{
+	struct ocp_device	*dev;
+	struct ocp_def		*found = NULL;
+
+	DBG(("ocp: ocp_get_one_device(vendor: %x, function: %x, index: %d)...\n",
+		vendor, function, index));
+
+	dev = ocp_find_device(vendor, function, index);
+
+	if (dev) 
+		found = dev->def;
+
+	DBG(("ocp: ocp_get_one_device(vendor: %x, function: %x, index: %d)... done.\n",
+		vendor, function, index));
+
+	return found;
+}
+
+/**
+ *	ocp_add_one_device	-	Add a device
+ *	@def: static device definition structure
+ *
+ *	This function adds a device definition to the
+ *	device list. It may only be called before
+ *	ocp_driver_init() and will return an error
+ *	otherwise.
+ */
+int
+ocp_add_one_device(struct ocp_def *def)
+{
+	struct	ocp_device	*dev;
+
+	DBG(("ocp: ocp_add_one_device()...\n"));
+
+	/* Can't be called after ocp driver init */
+	if (ocp_inited)
+		return 1;
+
+	if (mem_init_done)
+		dev = kmalloc(sizeof(*dev), GFP_KERNEL);
+	else
+		dev = alloc_bootmem(sizeof(*dev));
+
+	if (dev == NULL)
+		return 1;
+	memset(dev, 0, sizeof(*dev));
+	dev->def = def;
+	dev->current_state = 4;
+	sprintf(dev->name, "OCP device %04x:%04x:%04x",
+		dev->def->vendor, dev->def->function, dev->def->index);
+	down_write(&ocp_devices_sem);
+	list_add_tail(&dev->link, &ocp_devices);
+	up_write(&ocp_devices_sem);
+
+	DBG(("ocp: ocp_add_one_device()...done\n"));
+
+	return 0;
+}
+
+/**
+ *	ocp_remove_one_device -	Remove a device by function & index
+ *      @vendor: vendor ID of the device (or OCP_ANY_ID)
+ *	@function: function code of the device (or OCP_ANY_ID)
+ *	@idx: index of the device (or OCP_ANY_INDEX)
+ *
+ *	This function allows removal of a given function by its
+ *	index. It may only be called before ocp_driver_init()
+ *	and will return an error otherwise.
+ */
+int
+ocp_remove_one_device(unsigned int vendor, unsigned int function, int index)
+{
+	struct ocp_device *dev;
+
+	DBG(("ocp: ocp_remove_one_device(vendor: %x, function: %x, index: %d)...\n", vendor, function, index));
+
+	/* Can't be called after ocp driver init */
+	if (ocp_inited)
+		return 1;
+
+	down_write(&ocp_devices_sem);
+	dev = __ocp_find_device(vendor, function, index);
+	list_del((struct list_head *)dev);
+	up_write(&ocp_devices_sem);
+
+	DBG(("ocp: ocp_remove_one_device(vendor: %x, function: %x, index: %d)... done.\n", vendor, function, index));
+
+	return 0;
+}
+
+/**
+ *	ocp_for_each_device	-	Iterate over OCP devices
+ *	@callback: routine to execute for each ocp device.
+ *	@arg: user data to be passed to callback routine.
+ *
+ *	This routine holds the ocp_device semaphore, so the
+ *	callback routine cannot modify the ocp_device list.
+ */
+void
+ocp_for_each_device(void(*callback)(struct ocp_device *, void *arg), void *arg)
+{
+	struct list_head *entry;
+
+	if (callback) {
+		down_read(&ocp_devices_sem);
+		list_for_each(entry, &ocp_devices)
+			callback(list_entry(entry, struct ocp_device, link),
+				arg);
+		up_read(&ocp_devices_sem);
+	}
+}
+
+#ifdef CONFIG_PM
+/**
+ * OCP Power management..
+ *
+ * This needs to be done centralized, so that we power manage PCI
+ * devices in the right order: we should not shut down PCI bridges
+ * before we've shut down the devices behind them, and we should
+ * not wake up devices before we've woken up the bridge to the
+ * device.. Eh?
+ *
+ * We do not touch devices that don't have a driver that exports
+ * a suspend/resume function. That is just too dangerous. If the default
+ * PCI suspend/resume functions work for a device, the driver can
+ * easily implement them (ie just have a suspend function that calls
+ * the pci_set_power_state() function).
+ *
+ * BenH: Implementation here couldn't work properly. This version
+ *       slightly modified and _might_ be more useable, but real
+ *       PM support will probably have to wait for 2.5
+ */
+
+static int ocp_pm_save_state_device(struct ocp_device *dev, u32 state)
+{
+	int error = 0;
+	if (dev) {
+		struct ocp_driver *driver = dev->driver;
+		if (driver && driver->save_state)
+			error = driver->save_state(dev,state);
+	}
+	return error;
+}
+
+static int ocp_pm_suspend_device(struct ocp_device *dev, u32 state)
+{
+	int error = 0;
+	if (dev) {
+		struct ocp_driver *driver = dev->driver;
+		if (driver && driver->suspend)
+			error = driver->suspend(dev,state);
+	}
+	return error;
+}
+
+static int ocp_pm_resume_device(struct ocp_device *dev)
+{
+	int error = 0;
+	if (dev) {
+		struct ocp_driver *driver = dev->driver;
+		if (driver && driver->resume)
+			error = driver->resume(dev);
+	}
+	return error;
+}
+
+static int
+ocp_pm_callback(struct pm_dev *pm_device, pm_request_t rqst, void *data)
+{
+	int error = 0;
+	struct list_head	*entry;
+	struct ocp_device	*dev;
+
+	down_read(&ocp_devices_sem);
+
+	list_for_each(entry, &ocp_devices) {
+		dev = list_entry(entry, struct ocp_device, link);
+		switch (rqst) {
+		case PM_SAVE_STATE:
+			error = ocp_pm_save_state_device(dev, 3);
+			break;
+		case PM_SUSPEND:
+			error = ocp_pm_suspend_device(dev, 3);
+			break;
+		case PM_RESUME:
+			error = ocp_pm_resume_device(dev);
+			break;
+		default: break;
+		}
+		if (error)
+			break;
+	}
+
+	up_read(&ocp_devices_sem);
+
+	return error;
+}
+
+/*
+ * Is this ever used ?
+ */
+void
+ppc4xx_cpm_fr(u32 bits, int val)
+{
+	unsigned long flags;
+
+	save_flags(flags);
+	cli();
+
+	if (val)
+		mtdcr(DCRN_CPMFR, mfdcr(DCRN_CPMFR) | bits);
+	else
+		mtdcr(DCRN_CPMFR, mfdcr(DCRN_CPMFR) & ~bits);
+
+	restore_flags(flags);
+}
+#endif /* CONFIG_PM */
+
+/**
+ *	ocp_early_init	-	Init OCP device management
+ *
+ *	This function builds the list of devices before setup_arch. 
+ *	This allows platform code to modify the device lists before
+ *	they are bound to drivers (changes to paddr, removing devices
+ *	etc)
+ */
+int __init
+ocp_early_init(void)
+{
+	struct ocp_def	*def;
+
+	DBG(("ocp: ocp_early_init()...\n"));
+
+	/* Fill the devices list */
+	for (def = core_ocp; def->vendor != OCP_VENDOR_INVALID; def++)
+		ocp_add_one_device(def);
+
+	DBG(("ocp: ocp_early_init()... done.\n"));
+
+	return 0;
+}
+
+/**
+ *	ocp_driver_init	-	Init OCP device management
+ *
+ *	This function is meant to be called via OCP bus registration.
+ */
+static int __init
+ocp_driver_init(void)
+{
+	int ret = 0, index = 0;
+	struct device *ocp_bus;
+	struct list_head *entry;
+	struct ocp_device *dev;
+
+	if (ocp_inited)
+		return ret;
+	ocp_inited = 1;
+
+	DBG(("ocp: ocp_driver_init()...\n"));
+
+#ifdef CONFIG_PM
+	pm_register(PM_SYS_DEV, 0, ocp_pm_callback);
+#endif
+
+	/* Allocate/register primary OCP bus */
+	ocp_bus = kmalloc(sizeof(struct device), GFP_KERNEL);
+	if (ocp_bus == NULL)
+		return 1;
+	memset(ocp_bus, 0, sizeof(struct device));
+	strcpy(ocp_bus->bus_id, "ocp");
+
+	bus_register(&ocp_bus_type);
+
+	device_register(ocp_bus);
+
+	/* Put each OCP device into global device list */
+	list_for_each(entry, &ocp_devices) {
+		dev = list_entry(entry, struct ocp_device, link);
+		sprintf(dev->dev.bus_id, "%2.2x", index);
+		dev->dev.parent = ocp_bus;
+		dev->dev.bus = &ocp_bus_type;
+		device_register(&dev->dev);
+		ocp_create_sysfs_dev_files(dev);
+		index++;
+	}
+
+	DBG(("ocp: ocp_driver_init()... done.\n"));
+
+	return 0;
+}
+
+postcore_initcall(ocp_driver_init);
+
+EXPORT_SYMBOL(ocp_bus_type);
+EXPORT_SYMBOL(ocp_find_device);
+EXPORT_SYMBOL(ocp_register_driver);
+EXPORT_SYMBOL(ocp_unregister_driver);
diff -Nru a/include/asm-ppc/ocp.h b/include/asm-ppc/ocp.h
--- a/include/asm-ppc/ocp.h	Tue May 11 14:56:45 2004
+++ b/include/asm-ppc/ocp.h	Tue May 11 14:56:45 2004
@@ -1,103 +1,114 @@
 /*
  * ocp.h
  *
+ *      (c) Benjamin Herrenschmidt (benh@kernel.crashing.org)
+ *          Mipsys - France
  *
- * 	Current Maintainer
- *      Armin Kuster akuster@pacbell.net
- *      Jan, 2002
- *
+ *          Derived from work (c) Armin Kuster akuster@pacbell.net
  *
+ *          Additional support and port to 2.6 LDM/sysfs by
+ *          Matt Porter <mporter@kernel.crashing.org>
+ *          Copyright 2003-2004 MontaVista Software, Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR   IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT,  INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ *  TODO: - Add get/put interface & fixup locking to provide same API for
+ *          2.4 and 2.5
+ *	  - Rework PM callbacks
  */
 
 #ifdef __KERNEL__
 #ifndef __OCP_H__
 #define __OCP_H__
 
+#include <linux/init.h>
 #include <linux/list.h>
 #include <linux/config.h>
+#include <linux/devfs_fs_kernel.h>
 #include <linux/device.h>
-#include <linux/errno.h>
 
+#include <asm/mmu.h>
 #include <asm/ocp_ids.h>
-#include <asm/mmu.h>		/* For phys_addr_t */
-#undef DEBUG
-/* #define DEBUG*/
-
-#ifdef DEBUG
-#define DBG(x...) printk(x)
-#else
-#define DBG(x...)
-#endif
+#include <asm/rwsem.h>
+#include <asm/semaphore.h>
 
+#define OCP_MAX_IRQS	7
+#define MAX_EMACS	4
 #define OCP_IRQ_NA	-1	/* used when ocp device does not have an irq */
-#define OCP_IRQ_MUL	-2	/* used for ocp devices with multiple irqs */
-#define OCP_NULL_TYPE	0	/* used to mark end of list */
-#define OCP_DEV_NA	-1
+#define OCP_IRQ_MUL	-2	/* used for ocp devices with multiply irqs */
+#define OCP_NULL_TYPE	-1	/* used to mark end of list */
 #define OCP_CPM_NA	0	/* No Clock or Power Management avaliable */
+#define OCP_PADDR_NA	0	/* No MMIO registers */
 
 #define OCP_ANY_ID	(~0)
+#define OCP_ANY_INDEX	-1
 
-
-extern struct list_head ocp_root_buses;
-extern struct list_head ocp_devices;
+extern struct list_head 	ocp_devices;
+extern struct rw_semaphore	ocp_devices_sem;
 
 struct ocp_device_id {
-	unsigned int vendor, device;		/* Vendor and device ID or PCI_ANY_ID */
-	char name[16];
-	char desc[50];
-	unsigned long driver_data;		/* Data private to the driver */
+	unsigned int	vendor, function;	/* Vendor and function ID or OCP_ANY_ID */
+	unsigned long	driver_data;		/* Data private to the driver */
 };
 
-struct func_info {
-	char name[16];
-	char desc[50];
-};
 
+/*
+ * Static definition of an OCP device.
+ *
+ * @vendor:    Vendor code. It is _STRONGLY_ discouraged to use
+ *             the vendor code as a way to match a unique device,
+ *             though I kept that possibility open, you should
+ *             really define different function codes for different
+ *             device types
+ * @function:  This is the function code for this device.
+ * @index:     This index is used for mapping the Nth function of a
+ *             given core. This is typically used for cross-driver
+ *             matching, like looking for a given MAL or ZMII from
+ *             an EMAC or for getting to the proper set of DCRs.
+ *             Indices are no longer magically calculated based on
+ *             structure ordering, they have to be actually coded
+ *             into the ocp_def to avoid any possible confusion
+ *             I _STRONGLY_ (again ? wow !) encourage anybody relying
+ *             on index mapping to encode the "target" index in an
+ *             associated structure pointed to by "additions", see
+ *             how it's done for the EMAC driver.
+ * @paddr:     Device physical address (may not mean anything...)
+ * @irq:       Interrupt line for this device (TODO: think about making
+ *             an array with this)
+ * @pm:        Currently, contains the bitmask in CPMFR DCR for the device
+ * @additions: Optionally points to a function specific structure
+ *             providing additional informations for a given device
+ *             instance. It's currently used by the EMAC driver for MAL
+ *             channel & ZMII port mapping among others.
+ * @show:      Optionally points to a function specific structure
+ *             providing a sysfs show routine for additions fields.
+ */
 struct ocp_def {
-	unsigned int vendor;
-	unsigned int device;
-	phys_addr_t paddr;
-	int irq;
-	unsigned long pm;
+	unsigned int	vendor;
+	unsigned int	function;
+	int		index;
+	phys_addr_t	paddr;
+	int	  	irq;
+	unsigned long	pm;
+	void		*additions;
+	void		(*show)(struct device *);
 };
 
 
-/* Struct for single ocp device managment */
+/* Struct for a given device instance */
 struct ocp_device {
-	struct list_head global_list;
-	unsigned int	num;		/* instance of device */
-	char		name[80];	/* device name */
-	unsigned int vendor;
-	unsigned int device;
-	phys_addr_t paddr;
-	int irq;
-	unsigned long pm;
-	void *ocpdev;		/* driver data for this device */
-	struct ocp_driver *driver;
-	u32 current_state;	/* Current operating state. In ACPI-speak,
-				   this is D0-D3, D0 being fully functional,
-				   and D3 being off. */
-	struct device dev;
+	struct list_head	link;
+	char			name[80];	/* device name */
+	struct ocp_def		*def;		/* device definition */
+	void			*drvdata;	/* driver data for this device */
+	struct ocp_driver	*driver;
+	u32			current_state;	/* Current operating state. In ACPI-speak,
+						   this is D0-D3, D0 being fully functional,
+						   and D3 being off. */
+	struct			device dev;
 };
 
 struct ocp_driver {
@@ -106,23 +117,13 @@
 	const struct ocp_device_id *id_table;	/* NULL if wants all devices */
 	int  (*probe)  (struct ocp_device *dev);	/* New device inserted */
 	void (*remove) (struct ocp_device *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
-	int  (*save_state) (struct ocp_device *dev, u32 state);    /* Save Device Context */
 	int  (*suspend) (struct ocp_device *dev, u32 state);	/* Device suspended */
 	int  (*resume) (struct ocp_device *dev);	                /* Device woken up */
-	int  (*enable_wake) (struct ocp_device *dev, u32 state, int enable);   /* Enable wake event */
 	struct device_driver driver;
 };
 
-#define	to_ocp_dev(n) container_of(n, struct ocp_device, dev)
-#define	to_ocp_driver(n) container_of(n, struct ocp_driver, driver)
-
-extern int ocp_register_driver(struct ocp_driver *drv);
-extern void ocp_unregister_driver(struct ocp_driver *drv);
-
-#define ocp_dev_g(n) list_entry(n, struct ocp_device, global_list)
-
-#define ocp_for_each_dev(dev) \
-	for(dev = ocp_dev_g(ocp_devices.next); dev != ocp_dev_g(&ocp_devices); dev = ocp_dev_g(dev->global_list.next))
+#define to_ocp_dev(n) container_of(n, struct ocp_device, dev)
+#define to_ocp_drv(n) container_of(n, struct ocp_driver, driver)
 
 /* Similar to the helpers above, these manipulate per-ocp_dev
  * driver-specific data.  Currently stored as ocp_dev::ocpdev,
@@ -131,45 +132,13 @@
 static inline void *
 ocp_get_drvdata(struct ocp_device *pdev)
 {
-	return pdev->ocpdev;
+	return pdev->drvdata;
 }
 
 static inline void
 ocp_set_drvdata(struct ocp_device *pdev, void *data)
 {
-	pdev->ocpdev = data;
-}
-
-/*
- * a helper function which helps ensure correct pci_driver
- * setup and cleanup for commonly-encountered hotplug/modular cases
- *
- * This MUST stay in a header, as it checks for -DMODULE
- */
-static inline int ocp_module_init(struct ocp_driver *drv)
-{
-	int rc = ocp_register_driver(drv);
-
-	if (rc > 0)
-		return 0;
-
-	/* iff CONFIG_HOTPLUG and built into kernel, we should
-	 * leave the driver around for future hotplug events.
-	 * For the module case, a hotplug daemon of some sort
-	 * should load a module in response to an insert event. */
-#if defined(CONFIG_HOTPLUG) && !defined(MODULE)
-	if (rc == 0)
-		return 0;
-#else
-	if (rc == 0)
-		rc = -ENODEV;		
-#endif
-
-	/* if we get here, we need to clean up pci driver instance
-	 * and return some sort of error */
-	ocp_unregister_driver (drv);
-	
-	return rc;
+	pdev->drvdata = data;
 }
 
 #if defined (CONFIG_PM)
@@ -180,26 +149,56 @@
 static inline void
 ocp_force_power_off(struct ocp_device *odev)
 {
-	mtdcr(DCRN_CPMFR, mfdcr(DCRN_CPMFR) | odev->pm);
+	mtdcr(DCRN_CPMFR, mfdcr(DCRN_CPMFR) | odev->def->pm);
 }
 
 static inline void
 ocp_force_power_on(struct ocp_device *odev)
 {
-	mtdcr(DCRN_CPMFR, mfdcr(DCRN_CPMFR) & ~odev->pm);
+	mtdcr(DCRN_CPMFR, mfdcr(DCRN_CPMFR) & ~odev->def->pm);
 }
 #else
 #define ocp_force_power_off(x)	(void)(x)
 #define ocp_force_power_on(x)	(void)(x)
 #endif
 
-extern void ocp_init(void);
-extern struct bus_type ocp_bus_type;
-extern struct ocp_device *ocp_get_dev(unsigned int device, int index);
-extern unsigned int ocp_get_num(unsigned int device);
+/* Register/Unregister an OCP driver */
+extern int ocp_register_driver(struct ocp_driver *drv);
+extern void ocp_unregister_driver(struct ocp_driver *drv);
+
+/* Build list of devices */
+extern int ocp_early_init(void) __init;
 
-extern int ocp_generic_suspend(struct ocp_device *pdev, u32 state);
-extern int ocp_generic_resume(struct ocp_device *pdev);
+/* Find a device by index */
+extern struct ocp_device *ocp_find_device(unsigned int vendor, unsigned int function, int index);
+
+/* Get a def by index */
+extern struct ocp_def *ocp_get_one_device(unsigned int vendor, unsigned int function, int index);
+
+/* Add a device by index */
+extern int ocp_add_one_device(struct ocp_def *def);
+
+/* Remove a device by index */
+extern int ocp_remove_one_device(unsigned int vendor, unsigned int function, int index);
+
+/* Iterate over devices and execute a routine */
+extern void ocp_for_each_device(void(*callback)(struct ocp_device *, void *arg), void *arg);
+
+/* Sysfs support */
+#define OCP_SYSFS_ADDTL(type, format, name, field)			\
+static ssize_t								\
+show_##name##_##field(struct device *dev, char *buf)			\
+{									\
+	struct ocp_device *odev = to_ocp_dev(dev);			\
+	type *add = odev->def->additions;				\
+									\
+	return sprintf(buf, format, add->field);			\
+}									\
+static DEVICE_ATTR(name##_##field, S_IRUGO, show_##name##_##field, NULL);
+
+#ifdef CONFIG_IBM_OCP
+#include <asm/ibm_ocp.h>
+#endif
 
 #endif				/* __OCP_H__ */
 #endif				/* __KERNEL__ */
diff -Nru a/include/asm-ppc/ocp_ids.h b/include/asm-ppc/ocp_ids.h
--- a/include/asm-ppc/ocp_ids.h	Tue May 11 14:56:45 2004
+++ b/include/asm-ppc/ocp_ids.h	Tue May 11 14:56:45 2004
@@ -1,34 +1,15 @@
 /*
- * FILE NAME: ocp_ids.h
+ * ocp_ids.h
  *
- * BRIEF MODULE DESCRIPTION:
  * OCP device ids based on the ideas from PCI
  *
- * Maintained by: Armin <akuster@mvista.com>
+ * The numbers below are almost completely arbitrary, and in fact
+ * strings might work better.  -- paulus
  *
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- *  Version 1.0 08/22/02 -Armin
- *  	initial release
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
  */
 
 /*
@@ -42,8 +23,9 @@
 
 #define	OCP_VENDOR_INVALID	0x0000
 #define	OCP_VENDOR_ARM		0x0004
+#define OCP_VENDOR_FREESCALE	0x1057
 #define OCP_VENDOR_IBM		0x1014
-#define OCP_VENDOR_MOTOROLA	0x1057
+#define OCP_VENDOR_MOTOROLA	OCP_VENDOR_FREESCALE
 #define	OCP_VENDOR_XILINX	0x10ee
 #define	OCP_VENDOR_UNKNOWN	0xFFFF
 
@@ -53,33 +35,20 @@
 #define OCP_FUNC_INVALID	0x0000
 
 /* system 0x0001 - 0x001F */
-#define	OCP_FUNC_UIC		0x0001
 
 /* Timers 0x0020 - 0x002F */
-#define OCP_FUNC_GPT		0x0020 	/* General purpose timers */
-#define OCP_FUNC_RTC		0x0021
 
 /* Serial 0x0030 - 0x006F*/
 #define OCP_FUNC_16550		0x0031
-#define OCP_FUNC_SSP		0x0032 /* sync serial port */
-#define OCP_FUNC_SCP		0x0033 	/* serial controller port */
-#define OCP_FUNC_SCC		0x0034 	/* serial contoller */
-#define OCP_FUNC_SCI		0x0035 	/* Smart card */
-#define OCP_FUNC_IIC		0x0040
-#define OCP_FUNC_USB		0x0050
-#define OCP_FUNC_IR		0x0060	
+#define OCP_FUNC_IIC		0x0032
+#define OCP_FUNC_USB		0x0033
 
 /* Memory devices 0x0090 - 0x009F */
-#define	OCP_FUNC_SDRAM		0x0091
-#define OCP_FUNC_DMA		0x0092
+#define OCP_FUNC_MAL		0x0090
 
 /* Display 0x00A0 - 0x00AF */
-#define OCP_FUNC_VIDEO		0x00A0
-#define OCP_FUNC_LED		0x00A1
-#define	OCP_FUNC_LCD		0x00A2
 
 /* Sound 0x00B0 - 0x00BF */
-#define OCP_FUNC_AUDIO		0x00B0
 
 /* Mass Storage 0x00C0 - 0xxCF */
 #define OCP_FUNC_IDE		0x00C0
@@ -87,17 +56,15 @@
 /* Misc 0x00D0 - 0x00DF*/
 #define OCP_FUNC_GPIO		0x00D0
 #define OCP_FUNC_ZMII		0x00D1
+#define OCP_FUNC_PERFMON	0x00D2	/* Performance Monitor */
+#define OCP_FUNC_RGMII		0x00D3
+#define OCP_FUNC_TAH		0x00D4
 
 /* Network 0x0200 - 0x02FF */
 #define OCP_FUNC_EMAC		0x0200
+#define OCP_FUNC_ENET		0x0201	/* TSEC & FEC */
 
 /* Bridge devices 0xE00 - 0xEFF */
-#define OCP_FUNC_HOST		0x0E00
-#define OCP_FUNC_DCR		0x0E01
-#define OCP_FUNC_OPB		0x0E02
-#define OCP_FUNC_PHY		0x0E03
-#define OCP_FUNC_EXT		0x0E04
-#define	OCP_FUNC_PCI		0x0E05
-#define	OCP_FUNC_PLB		0x0E06
+#define OCP_FUNC_OPB		0x0E00
 
 #define OCP_FUNC_UNKNOWN	0xFFFF
