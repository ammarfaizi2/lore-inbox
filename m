Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265981AbUGOASh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265981AbUGOASh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 20:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266025AbUGOASh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 20:18:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:52971 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265981AbUGOAJC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 20:09:02 -0400
Subject: Re: [PATCH] I2C update for 2.6.8-rc1
In-Reply-To: <10898500322333@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 14 Jul 2004 17:07:13 -0700
Message-Id: <10898500321009@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1784.13.12, 2004/07/09 16:39:56-07:00, greg@kroah.com

1 Wire: add Dallas 1-wire protocol driver subsystem

This was written and developed by Evgeniy Polyakov <johnpol@2ka.mipt.ru>
with only very minor cleanups by me.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 MAINTAINERS             |    6 
 drivers/Kconfig         |    2 
 drivers/Makefile        |    1 
 drivers/w1/Kconfig      |   31 ++
 drivers/w1/Makefile     |    9 
 drivers/w1/matrox_w1.c  |  246 ++++++++++++++++++
 drivers/w1/w1.c         |  623 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/w1/w1.h         |  112 ++++++++
 drivers/w1/w1_family.c  |  133 ++++++++++
 drivers/w1/w1_family.h  |   65 +++++
 drivers/w1/w1_int.c     |  207 +++++++++++++++
 drivers/w1/w1_int.h     |   36 ++
 drivers/w1/w1_io.c      |  138 ++++++++++
 drivers/w1/w1_io.h      |   35 ++
 drivers/w1/w1_log.h     |   38 ++
 drivers/w1/w1_netlink.c |   55 ++++
 drivers/w1/w1_netlink.h |   44 +++
 drivers/w1/w1_therm.c   |  177 +++++++++++++
 18 files changed, 1958 insertions(+)


diff -Nru a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	2004-07-14 16:59:14 -07:00
+++ b/MAINTAINERS	2004-07-14 16:59:14 -07:00
@@ -2379,6 +2379,12 @@
 M:	kraxel@bytesex.org
 S:	Maintained
 
+W1 DALLAS'S 1-WIRE BUS
+P:	Evgeniy Polyakov
+M:	johnpol@2ka.mipt.ru
+L:	sensors@stimpy.netroedge.com
+S:	Maintained
+
 WAN ROUTER & SANGOMA WANPIPE DRIVERS & API (X.25, FRAME RELAY, PPP, CISCO HDLC)
 P:	Nenad Corbic
 M:	ncorbic@sangoma.com
diff -Nru a/drivers/Kconfig b/drivers/Kconfig
--- a/drivers/Kconfig	2004-07-14 16:59:14 -07:00
+++ b/drivers/Kconfig	2004-07-14 16:59:14 -07:00
@@ -42,6 +42,8 @@
 
 source "drivers/i2c/Kconfig"
 
+source "drivers/w1/Kconfig"
+
 source "drivers/misc/Kconfig"
 
 source "drivers/media/Kconfig"
diff -Nru a/drivers/Makefile b/drivers/Makefile
--- a/drivers/Makefile	2004-07-14 16:59:14 -07:00
+++ b/drivers/Makefile	2004-07-14 16:59:14 -07:00
@@ -42,6 +42,7 @@
 obj-$(CONFIG_SERIO)		+= input/serio/
 obj-$(CONFIG_I2O)		+= message/
 obj-$(CONFIG_I2C)		+= i2c/
+obj-$(CONFIG_W1)		+= w1/
 obj-$(CONFIG_PHONE)		+= telephony/
 obj-$(CONFIG_MD)		+= md/
 obj-$(CONFIG_BT)		+= bluetooth/
diff -Nru a/drivers/w1/Kconfig b/drivers/w1/Kconfig
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/w1/Kconfig	2004-07-14 16:59:14 -07:00
@@ -0,0 +1,31 @@
+menu "Dallas's 1-wire bus"
+
+config W1
+	tristate "Dallas's 1-wire support"
+	---help---
+	  Dallas's 1-wire bus is usefull to connect slow 1-pin devices 
+	  such as iButtons and thermal sensors.
+	  
+	  If you want W1 support, you should say Y here.
+
+	  This W1 support can also be built as a module.  If so, the module
+	  will be called wire.ko.
+
+config W1_MATROX
+	tristate "Matrox G400 transport layer for 1-wire"
+	depends on W1
+	help
+	  Say Y here if you want to communicate with your 1-wire devices
+	  using Matrox's G400 GPIO pins.
+	  
+	  This support is also available as a module.  If so, the module 
+	  will be called matrox_w1.ko.
+
+config W1_THERM
+	tristate "Thermal family implementation"
+	depends on W1
+	help
+	  Say Y here if you want to connect 1-wire thermal sensors to you
+	  wire.
+
+endmenu
diff -Nru a/drivers/w1/Makefile b/drivers/w1/Makefile
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/w1/Makefile	2004-07-14 16:59:14 -07:00
@@ -0,0 +1,9 @@
+#
+# Makefile for the Dallas's 1-wire bus.
+#
+
+obj-$(CONFIG_W1)	+= wire.o
+wire-objs		:= w1.o w1_int.o w1_family.o w1_netlink.o w1_io.o
+
+obj-$(CONFIG_W1_MATROX)		+= matrox_w1.o
+obj-$(CONFIG_W1_THERM)		+= w1_therm.o
diff -Nru a/drivers/w1/matrox_w1.c b/drivers/w1/matrox_w1.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/w1/matrox_w1.c	2004-07-14 16:59:14 -07:00
@@ -0,0 +1,246 @@
+/*
+ * 	matrox_w1.c
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <asm/atomic.h>
+#include <asm/types.h>
+#include <asm/io.h>
+#include <asm/delay.h>
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/timer.h>
+#include <linux/slab.h>
+#include <linux/pci_ids.h>
+#include <linux/pci.h>
+#include <linux/timer.h>
+
+#include "w1.h"
+#include "w1_int.h"
+#include "w1_log.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
+MODULE_DESCRIPTION("Driver for transport(Dallas 1-wire prtocol) over VGA DDC(matrox gpio).");
+
+static struct pci_device_id matrox_w1_tbl[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_MATROX, PCI_DEVICE_ID_MATROX_G400) },
+	{ },
+};
+MODULE_DEVICE_TABLE(pci, matrox_w1_tbl);
+
+static int __devinit matrox_w1_probe(struct pci_dev *, const struct pci_device_id *);
+static void __devexit matrox_w1_remove(struct pci_dev *);
+
+static struct pci_driver matrox_w1_pci_driver = {
+	.name = "matrox_w1",
+	.id_table = matrox_w1_tbl,
+	.probe = matrox_w1_probe,
+	.remove = __devexit_p(matrox_w1_remove),
+};
+
+/* 
+ * Matrox G400 DDC registers.
+ */
+
+#define MATROX_G400_DDC_CLK		(1<<4)
+#define MATROX_G400_DDC_DATA		(1<<1)
+
+#define MATROX_BASE			0x3C00
+#define MATROX_STATUS			0x1e14
+
+#define MATROX_PORT_INDEX_OFFSET	0x00
+#define MATROX_PORT_DATA_OFFSET		0x0A
+
+#define MATROX_GET_CONTROL		0x2A
+#define MATROX_GET_DATA			0x2B
+#define MATROX_CURSOR_CTL		0x06
+
+struct matrox_device
+{
+	unsigned long base_addr;
+	unsigned long port_index, port_data;
+	u8 data_mask;
+
+	unsigned long phys_addr, virt_addr;
+	unsigned long found;
+
+	struct w1_bus_master *bus_master;
+};
+
+static u8 matrox_w1_read_ddc_bit(unsigned long);
+static void matrox_w1_write_ddc_bit(unsigned long, u8);
+
+/*
+ * These functions read and write DDC Data bit.
+ *
+ * Using tristate pins, since i can't  fin any open-drain pin in whole motherboard.
+ * Unfortunately we can't connect to Intel's 82801xx IO controller
+ * since we don't know motherboard schema, wich has pretty unused(may be not) GPIO.
+ *
+ * I've heard that PIIX also has open drain pin.
+ *
+ * Port mapping.
+ */
+static __inline__ u8 matrox_w1_read_reg(struct matrox_device *dev, u8 reg)
+{
+	u8 ret;
+
+	writeb(reg, dev->port_index);
+	ret = readb(dev->port_data);
+	barrier();
+
+	return ret;
+}
+
+static __inline__ void matrox_w1_write_reg(struct matrox_device *dev, u8 reg, u8 val)
+{
+	writeb(reg, dev->port_index);
+	writeb(val, dev->port_data);
+	wmb();
+}
+
+static void matrox_w1_write_ddc_bit(unsigned long data, u8 bit)
+{
+	u8 ret;
+	struct matrox_device *dev = (struct matrox_device *) data;
+
+	if (bit)
+		bit = 0;
+	else
+		bit = dev->data_mask;
+
+	ret = matrox_w1_read_reg(dev, MATROX_GET_CONTROL);
+	matrox_w1_write_reg(dev, MATROX_GET_CONTROL, ((ret & ~dev->data_mask) | bit));
+	matrox_w1_write_reg(dev, MATROX_GET_DATA, 0x00);
+}
+
+static u8 matrox_w1_read_ddc_bit(unsigned long data)
+{
+	u8 ret;
+	struct matrox_device *dev = (struct matrox_device *) data;
+
+	ret = matrox_w1_read_reg(dev, MATROX_GET_DATA);
+
+	return ret;
+}
+
+static void matrox_w1_hw_init(struct matrox_device *dev)
+{
+	matrox_w1_write_reg(dev, MATROX_GET_DATA, 0xFF);
+	matrox_w1_write_reg(dev, MATROX_GET_CONTROL, 0x00);
+}
+
+static int __devinit matrox_w1_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	struct matrox_device *dev;
+	int err;
+
+	assert(pdev != NULL);
+	assert(ent != NULL);
+
+	if (pdev->vendor != PCI_VENDOR_ID_MATROX || pdev->device != PCI_DEVICE_ID_MATROX_G400)
+		return -ENODEV;
+
+	dev = kmalloc(sizeof(struct matrox_device) +
+		       sizeof(struct w1_bus_master), GFP_KERNEL);
+	if (!dev) {
+		dev_err(&pdev->dev,
+			"%s: Failed to create new matrox_device object.\n",
+			__func__);
+		return -ENOMEM;
+	}
+
+	memset(dev, 0, sizeof(struct matrox_device) + sizeof(struct w1_bus_master));
+
+	dev->bus_master = (struct w1_bus_master *)(dev + 1);
+
+	/* 
+	 * True for G400, for some other we need resource 0, see drivers/video/matrox/matroxfb_base.c 
+	 */
+
+	dev->phys_addr = pci_resource_start(pdev, 1);
+
+	dev->virt_addr =
+		(unsigned long) ioremap_nocache(dev->phys_addr, 16384);
+	if (!dev->virt_addr) {
+		dev_err(&pdev->dev, "%s: failed to ioremap(0x%lx, %d).\n",
+			__func__, dev->phys_addr, 16384);
+		err = -EIO;
+		goto err_out_free_device;
+	}
+
+	dev->base_addr = dev->virt_addr + MATROX_BASE;
+	dev->port_index = dev->base_addr + MATROX_PORT_INDEX_OFFSET;
+	dev->port_data = dev->base_addr + MATROX_PORT_DATA_OFFSET;
+	dev->data_mask = (MATROX_G400_DDC_DATA);
+
+	matrox_w1_hw_init(dev);
+
+	dev->bus_master->data = (unsigned long) dev;
+	dev->bus_master->read_bit = &matrox_w1_read_ddc_bit;
+	dev->bus_master->write_bit = &matrox_w1_write_ddc_bit;
+
+	err = w1_add_master_device(dev->bus_master);
+	if (err)
+		goto err_out_free_device;
+
+	pci_set_drvdata(pdev, dev);
+
+	dev->found = 1;
+
+	dev_info(&pdev->dev, "Matrox G400 GPIO transport layer for 1-wire.\n");
+
+	return 0;
+
+err_out_free_device:
+	kfree(dev);
+
+	return err;
+}
+
+static void __devexit matrox_w1_remove(struct pci_dev *pdev)
+{
+	struct matrox_device *dev = pci_get_drvdata(pdev);
+
+	assert(dev != NULL);
+
+	if (dev->found) {
+		w1_remove_master_device(dev->bus_master);
+		iounmap((void *) dev->virt_addr);
+	}
+	kfree(dev);
+}
+
+static int __init matrox_w1_init(void)
+{
+	return pci_module_init(&matrox_w1_pci_driver);
+}
+
+static void __exit matrox_w1_fini(void)
+{
+	pci_unregister_driver(&matrox_w1_pci_driver);
+}
+
+module_init(matrox_w1_init);
+module_exit(matrox_w1_fini);
diff -Nru a/drivers/w1/w1.c b/drivers/w1/w1.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/w1/w1.c	2004-07-14 16:59:14 -07:00
@@ -0,0 +1,623 @@
+/*
+ * 	w1.c
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <asm/atomic.h>
+#include <asm/delay.h>
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/list.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/timer.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/suspend.h>
+
+#include "w1.h"
+#include "w1_io.h"
+#include "w1_log.h"
+#include "w1_int.h"
+#include "w1_family.h"
+#include "w1_netlink.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
+MODULE_DESCRIPTION("Driver for 1-wire Dallas network protocol.");
+
+static int w1_timeout = 5 * HZ;
+int w1_max_slave_count = 10;
+
+module_param_named(timeout, w1_timeout, int, 0);
+module_param_named(max_slave_count, w1_max_slave_count, int, 0);
+
+spinlock_t w1_mlock = SPIN_LOCK_UNLOCKED;
+LIST_HEAD(w1_masters);
+
+static pid_t control_thread;
+static int control_needs_exit;
+static DECLARE_COMPLETION(w1_control_complete);
+static DECLARE_WAIT_QUEUE_HEAD(w1_control_wait);
+
+static int w1_master_match(struct device *dev, struct device_driver *drv)
+{
+	return 1;
+}
+
+static int w1_master_probe(struct device *dev)
+{
+	return -ENODEV;
+}
+
+static int w1_master_remove(struct device *dev)
+{
+	return 0;
+}
+
+static void w1_master_release(struct device *dev)
+{
+	struct w1_master *md = container_of(dev, struct w1_master, dev);
+
+	complete(&md->dev_released);
+}
+
+static void w1_slave_release(struct device *dev)
+{
+	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
+
+	complete(&sl->dev_released);
+}
+
+static ssize_t w1_default_read_name(struct device *dev, char *buf)
+{
+	return sprintf(buf, "No family registered.\n");
+}
+
+static ssize_t w1_default_read_bin(struct kobject *kobj, char *buf, loff_t off,
+		     size_t count)
+{
+	return sprintf(buf, "No family registered.\n");
+}
+
+struct bus_type w1_bus_type = {
+	.name = "w1",
+	.match = w1_master_match,
+};
+
+struct device_driver w1_driver = {
+	.name = "w1_driver",
+	.bus = &w1_bus_type,
+	.probe = w1_master_probe,
+	.remove = w1_master_remove,
+};
+
+struct device w1_device = {
+	.parent = NULL,
+	.bus = &w1_bus_type,
+	.bus_id = "w1 bus master",
+	.driver = &w1_driver,
+	.release = &w1_master_release
+};
+
+static struct device_attribute w1_slave_attribute = {
+	.attr = {
+			.name = "name",
+			.mode = S_IRUGO,
+			.owner = THIS_MODULE
+	},
+	.show = &w1_default_read_name,
+};
+
+static struct device_attribute w1_slave_attribute_val = {
+	.attr = {
+			.name = "value",
+			.mode = S_IRUGO,
+			.owner = THIS_MODULE
+	},
+	.show = &w1_default_read_name,
+};
+
+static ssize_t w1_master_attribute_show(struct device *dev, char *buf)
+{
+	return sprintf(buf, "please fix me\n");
+#if 0
+	struct w1_master *md = container_of(dev, struct w1_master, dev);
+	int c = PAGE_SIZE;
+
+	if (down_interruptible(&md->mutex))
+		return -EBUSY;
+
+	c -= snprintf(buf + PAGE_SIZE - c, c, "%s\n", md->name);
+	c -= snprintf(buf + PAGE_SIZE - c, c,
+		       "bus_master=0x%p, timeout=%d, max_slave_count=%d, attempts=%lu\n",
+		       md->bus_master, w1_timeout, md->max_slave_count,
+		       md->attempts);
+	c -= snprintf(buf + PAGE_SIZE - c, c, "%d slaves: ",
+		       md->slave_count);
+	if (md->slave_count == 0)
+		c -= snprintf(buf + PAGE_SIZE - c, c, "no.\n");
+	else {
+		struct list_head *ent, *n;
+		struct w1_slave *sl;
+
+		list_for_each_safe(ent, n, &md->slist) {
+			sl = list_entry(ent, struct w1_slave, w1_slave_entry);
+
+			c -= snprintf(buf + PAGE_SIZE - c, c, "%s[%p] ",
+				       sl->name, sl);
+		}
+		c -= snprintf(buf + PAGE_SIZE - c, c, "\n");
+	}
+
+	up(&md->mutex);
+
+	return PAGE_SIZE - c;
+#endif
+}
+
+struct device_attribute w1_master_attribute = {
+	.attr = {
+			.name = "w1_master_stats",
+			.mode = S_IRUGO,
+			.owner = THIS_MODULE,
+	},
+	.show = &w1_master_attribute_show,
+};
+
+static struct bin_attribute w1_slave_bin_attribute = {
+	.attr = {
+		 	.name = "w1_slave",
+		 	.mode = S_IRUGO,
+			.owner = THIS_MODULE,
+	},
+	.size = W1_SLAVE_DATA_SIZE,
+	.read = &w1_default_read_bin,
+};
+
+static int __w1_attach_slave_device(struct w1_slave *sl)
+{
+	int err;
+
+	sl->dev.parent = &sl->master->dev;
+	sl->dev.driver = sl->master->driver;
+	sl->dev.bus = &w1_bus_type;
+	sl->dev.release = &w1_slave_release;
+
+	snprintf(&sl->dev.bus_id[0], sizeof(sl->dev.bus_id),
+		  "%x-%llx",
+		  (unsigned int) sl->reg_num.family,
+		  (unsigned long long) sl->reg_num.id);
+	snprintf (&sl->name[0], sizeof(sl->name),
+		  "%x-%llx",
+		  (unsigned int) sl->reg_num.family,
+		  (unsigned long long) sl->reg_num.id);
+
+	dev_dbg(&sl->dev, "%s: registering %s.\n", __func__,
+		&sl->dev.bus_id[0]);
+
+	err = device_register(&sl->dev);
+	if (err < 0) {
+		dev_err(&sl->dev,
+			 "Device registration [%s] failed. err=%d\n",
+			 sl->dev.bus_id, err);
+		return err;
+	}
+
+	w1_slave_bin_attribute.read = sl->family->fops->rbin;
+	w1_slave_attribute.show = sl->family->fops->rname;
+	w1_slave_attribute_val.show = sl->family->fops->rval;
+	w1_slave_attribute_val.attr.name = sl->family->fops->rvalname;
+
+	err = device_create_file(&sl->dev, &w1_slave_attribute);
+	if (err < 0) {
+		dev_err(&sl->dev,
+			 "sysfs file creation for [%s] failed. err=%d\n",
+			 sl->dev.bus_id, err);
+		device_unregister(&sl->dev);
+		return err;
+	}
+
+	err = device_create_file(&sl->dev, &w1_slave_attribute_val);
+	if (err < 0) {
+		dev_err(&sl->dev,
+			 "sysfs file creation for [%s] failed. err=%d\n",
+			 sl->dev.bus_id, err);
+		device_remove_file(&sl->dev, &w1_slave_attribute);
+		device_unregister(&sl->dev);
+		return err;
+	}
+
+	err = sysfs_create_bin_file(&sl->dev.kobj, &w1_slave_bin_attribute);
+	if (err < 0) {
+		dev_err(&sl->dev,
+			 "sysfs file creation for [%s] failed. err=%d\n",
+			 sl->dev.bus_id, err);
+		device_remove_file(&sl->dev, &w1_slave_attribute);
+		device_remove_file(&sl->dev, &w1_slave_attribute_val);
+		device_unregister(&sl->dev);
+		return err;
+	}
+
+	list_add_tail(&sl->w1_slave_entry, &sl->master->slist);
+
+	return 0;
+}
+
+static int w1_attach_slave_device(struct w1_master *dev, struct w1_reg_num *rn)
+{
+	struct w1_slave *sl;
+	struct w1_family *f;
+	int err;
+
+	sl = kmalloc(sizeof(struct w1_slave), GFP_KERNEL);
+	if (!sl) {
+		dev_err(&dev->dev,
+			 "%s: failed to allocate new slave device.\n",
+			 __func__);
+		return -ENOMEM;
+	}
+
+	memset(sl, 0, sizeof(*sl));
+
+	sl->owner = THIS_MODULE;
+	sl->master = dev;
+
+	memcpy(&sl->reg_num, rn, sizeof(sl->reg_num));
+	atomic_set(&sl->refcnt, 0);
+	init_completion(&sl->dev_released);
+
+	spin_lock(&w1_flock);
+	f = w1_family_registered(rn->family);
+	if (!f) {
+		spin_unlock(&w1_flock);
+		dev_info(&dev->dev, "Family %x is not registered.\n",
+			  rn->family);
+		kfree(sl);
+		return -ENODEV;
+	}
+	__w1_family_get(f);
+	spin_unlock(&w1_flock);
+
+	sl->family = f;
+
+
+	err = __w1_attach_slave_device(sl);
+	if (err < 0) {
+		dev_err(&dev->dev, "%s: Attaching %s failed.\n", __func__,
+			 sl->name);
+		w1_family_put(sl->family);
+		kfree(sl);
+		return err;
+	}
+
+	dev->slave_count++;
+
+	return 0;
+}
+
+static void w1_slave_detach(struct w1_slave *sl)
+{
+	dev_info(&sl->dev, "%s: detaching %s.\n", __func__, sl->name);
+
+	while (atomic_read(&sl->refcnt))
+		schedule_timeout(10);
+
+	sysfs_remove_bin_file(&sl->dev.kobj, &w1_slave_bin_attribute);
+	device_remove_file(&sl->dev, &w1_slave_attribute);
+	device_unregister(&sl->dev);
+	w1_family_put(sl->family);
+}
+
+static void w1_search(struct w1_master *dev)
+{
+	u64 last, rn, tmp;
+	int i, count = 0, slave_count;
+	int last_family_desc, last_zero, last_device;
+	int search_bit, id_bit, comp_bit, desc_bit;
+	struct list_head *ent;
+	struct w1_slave *sl;
+	int family_found = 0;
+	struct w1_netlink_msg msg;
+
+	dev->attempts++;
+
+	memset(&msg, 0, sizeof(msg));
+
+	search_bit = id_bit = comp_bit = 0;
+	rn = tmp = last = 0;
+	last_device = last_zero = last_family_desc = 0;
+
+	desc_bit = 64;
+
+	while (!(id_bit && comp_bit) && !last_device
+		&& count++ < dev->max_slave_count) {
+		last = rn;
+		rn = 0;
+
+		last_family_desc = 0;
+
+		/*
+		 * Reset bus and all 1-wire device state machines
+		 * so they can respond to our requests.
+		 *
+		 * Return 0 - device(s) present, 1 - no devices present.
+		 */
+		if (w1_reset_bus(dev)) {
+			dev_info(&dev->dev, "No devices present on the wire.\n");
+			break;
+		}
+
+#if 1
+		memset(&msg, 0, sizeof(msg));
+
+		w1_write_8(dev, W1_SEARCH);
+		for (i = 0; i < 64; ++i) {
+			/*
+			 * Read 2 bits from bus.
+			 * All who don't sleep must send ID bit and COMPLEMENT ID bit.
+			 * They actually are ANDed between all senders.
+			 */
+			id_bit = w1_read_bit(dev);
+			comp_bit = w1_read_bit(dev);
+
+			if (id_bit && comp_bit)
+				break;
+
+			if (id_bit == 0 && comp_bit == 0) {
+				if (i == desc_bit)
+					search_bit = 1;
+				else if (i > desc_bit)
+					search_bit = 0;
+				else
+					search_bit = ((last >> i) & 0x1);
+
+				if (search_bit == 0) {
+					last_zero = i;
+					if (last_zero < 9)
+						last_family_desc = last_zero;
+				}
+
+			}
+			else
+				search_bit = id_bit;
+
+			tmp = search_bit;
+			rn |= (tmp << i);
+
+			/*
+			 * Write 1 bit to bus
+			 * and make all who don't have "search_bit" in "i"'th position
+			 * in it's registration number sleep.
+			 */
+			w1_write_bit(dev, search_bit);
+
+		}
+#endif
+		msg.id.w1_id = rn;
+		msg.val = w1_calc_crc8((u8 *) & rn, 7);
+		w1_netlink_send(dev, &msg);
+
+		if (desc_bit == last_zero)
+			last_device = 1;
+
+		desc_bit = last_zero;
+
+		slave_count = 0;
+		list_for_each(ent, &dev->slist) {
+			struct w1_reg_num *tmp;
+
+			tmp = (struct w1_reg_num *) &rn;
+
+			sl = list_entry(ent, struct w1_slave, w1_slave_entry);
+
+			if (sl->reg_num.family == tmp->family &&
+			    sl->reg_num.id == tmp->id &&
+			    sl->reg_num.crc == tmp->crc)
+				break;
+			else if (sl->reg_num.family == tmp->family) {
+				family_found = 1;
+				break;
+			}
+
+			slave_count++;
+		}
+
+		if (slave_count == dev->slave_count &&
+		    msg.val && (*((__u8 *) & msg.val) == msg.id.id.crc)) {
+			w1_attach_slave_device(dev, (struct w1_reg_num *) &rn);
+		}
+	}
+}
+
+int w1_control(void *data)
+{
+	struct w1_slave *sl;
+	struct w1_master *dev;
+	struct list_head *ent, *ment, *n, *mn;
+	int err, have_to_wait = 0, timeout;
+
+	daemonize("w1_control");
+	allow_signal(SIGTERM);
+
+	while (!control_needs_exit || have_to_wait) {
+		have_to_wait = 0;
+
+		timeout = w1_timeout;
+		do {
+			timeout = interruptible_sleep_on_timeout(&w1_control_wait, timeout);
+			if (current->flags & PF_FREEZE)
+				refrigerator(PF_FREEZE);
+		} while (!signal_pending(current) && (timeout > 0));
+
+		if (signal_pending(current))
+			flush_signals(current);
+
+		list_for_each_safe(ment, mn, &w1_masters) {
+			dev = list_entry(ment, struct w1_master, w1_master_entry);
+
+			if (!control_needs_exit && !dev->need_exit)
+				continue;
+			/*
+			 * Little race: we can create thread but not set the flag.
+			 * Get a chance for external process to set flag up.
+			 */
+			if (!dev->initialized) {
+				have_to_wait = 1;
+				continue;
+			}
+
+			spin_lock(&w1_mlock);
+			list_del(&dev->w1_master_entry);
+			spin_unlock(&w1_mlock);
+
+			if (control_needs_exit) {
+				dev->need_exit = 1;
+
+				err = kill_proc(dev->kpid, SIGTERM, 1);
+				if (err)
+					dev_err(&dev->dev,
+						 "Failed to send signal to w1 kernel thread %d.\n",
+						 dev->kpid);
+			}
+
+			wait_for_completion(&dev->dev_exited);
+
+			list_for_each_safe(ent, n, &dev->slist) {
+				sl = list_entry(ent, struct w1_slave, w1_slave_entry);
+
+				if (!sl)
+					dev_warn(&dev->dev,
+						  "%s: slave entry is NULL.\n",
+						  __func__);
+				else {
+					list_del(&sl->w1_slave_entry);
+
+					w1_slave_detach(sl);
+					kfree(sl);
+				}
+			}
+			device_remove_file(&dev->dev, &w1_master_attribute);
+			atomic_dec(&dev->refcnt);
+		}
+	}
+
+	complete_and_exit(&w1_control_complete, 0);
+}
+
+int w1_process(void *data)
+{
+	struct w1_master *dev = (struct w1_master *) data;
+	unsigned long timeout;
+
+	daemonize("%s", dev->name);
+	allow_signal(SIGTERM);
+
+	while (!dev->need_exit) {
+		timeout = w1_timeout;
+		do {
+			timeout = interruptible_sleep_on_timeout(&dev->kwait, timeout);
+			if (current->flags & PF_FREEZE)
+				refrigerator(PF_FREEZE);
+		} while (!signal_pending(current) && (timeout > 0));
+
+		if (signal_pending(current))
+			flush_signals(current);
+
+		if (dev->need_exit)
+			break;
+
+		if (!dev->initialized)
+			continue;
+
+		if (down_interruptible(&dev->mutex))
+			continue;
+		w1_search(dev);
+		up(&dev->mutex);
+	}
+
+	atomic_dec(&dev->refcnt);
+	complete_and_exit(&dev->dev_exited, 0);
+
+	return 0;
+}
+
+int w1_init(void)
+{
+	int retval;
+
+	printk(KERN_INFO "Driver for 1-wire Dallas network protocol.\n");
+
+	retval = bus_register(&w1_bus_type);
+	if (retval) {
+		printk(KERN_ERR "Failed to register bus. err=%d.\n", retval);
+		goto err_out_exit_init;
+	}
+
+	retval = driver_register(&w1_driver);
+	if (retval) {
+		printk(KERN_ERR
+			"Failed to register master driver. err=%d.\n",
+			retval);
+		goto err_out_bus_unregister;
+	}
+
+	control_thread = kernel_thread(&w1_control, NULL, 0);
+	if (control_thread < 0) {
+		printk(KERN_ERR "Failed to create control thread. err=%d\n",
+			control_thread);
+		retval = control_thread;
+		goto err_out_driver_unregister;
+	}
+
+	return 0;
+
+err_out_driver_unregister:
+	driver_unregister(&w1_driver);
+
+err_out_bus_unregister:
+	bus_unregister(&w1_bus_type);
+
+err_out_exit_init:
+	return retval;
+}
+
+void w1_fini(void)
+{
+	struct w1_master *dev;
+	struct list_head *ent, *n;
+
+	list_for_each_safe(ent, n, &w1_masters) {
+		dev = list_entry(ent, struct w1_master, w1_master_entry);
+		__w1_remove_master_device(dev);
+	}
+
+	control_needs_exit = 1;
+
+	wait_for_completion(&w1_control_complete);
+
+	driver_unregister(&w1_driver);
+	bus_unregister(&w1_bus_type);
+}
+
+module_init(w1_init);
+module_exit(w1_fini);
diff -Nru a/drivers/w1/w1.h b/drivers/w1/w1.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/w1/w1.h	2004-07-14 16:59:14 -07:00
@@ -0,0 +1,112 @@
+/*
+ * 	w1.h
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef __W1_H
+#define __W1_H
+
+struct w1_reg_num
+{
+	__u64	family:8,
+		id:48,
+		crc:8;
+};
+
+#ifdef __KERNEL__
+
+#include <linux/completion.h>
+#include <linux/device.h>
+
+#include <net/sock.h>
+
+#include <asm/semaphore.h>
+
+#include "w1_family.h"
+
+#define W1_MAXNAMELEN		32
+#define W1_SLAVE_DATA_SIZE	128
+
+#define W1_SEARCH		0xF0
+#define W1_CONDITIONAL_SEARCH	0xEC
+#define W1_CONVERT_TEMP		0x44
+#define W1_SKIP_ROM		0xCC
+#define W1_READ_SCRATCHPAD	0xBE
+#define W1_READ_ROM		0x33
+#define W1_READ_PSUPPLY		0xB4
+#define W1_MATCH_ROM		0x55
+
+struct w1_slave
+{
+	struct module		*owner;
+	unsigned char		name[W1_MAXNAMELEN];
+	struct list_head	w1_slave_entry;
+	struct w1_reg_num	reg_num;
+	atomic_t		refcnt;
+	u8			rom[9];
+
+	struct w1_master	*master;
+	struct w1_family 	*family;
+	struct device 		dev;
+	struct completion 	dev_released;
+};
+
+struct w1_bus_master
+{
+	unsigned long		data;
+
+	u8			(*read_bit)(unsigned long);
+	void			(*write_bit)(unsigned long, u8);
+};
+
+struct w1_master
+{
+	struct list_head	w1_master_entry;
+	struct module		*owner;
+	unsigned char		name[W1_MAXNAMELEN];
+	struct list_head	slist;
+	int			max_slave_count, slave_count;
+	unsigned long		attempts;
+	int			initialized;
+	u32			id;
+
+	atomic_t		refcnt;
+
+	void			*priv;
+	int			priv_size;
+
+	int			need_exit;
+	pid_t			kpid;
+	wait_queue_head_t 	kwait;
+	struct semaphore 	mutex;
+
+	struct device_driver	*driver;
+	struct device 		dev;
+	struct completion 	dev_released;
+	struct completion 	dev_exited;
+
+	struct w1_bus_master	*bus_master;
+
+	u32			seq, groups;
+	struct sock 		*nls;
+};
+
+#endif /* __KERNEL__ */
+
+#endif /* __W1_H */
diff -Nru a/drivers/w1/w1_family.c b/drivers/w1/w1_family.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/w1/w1_family.c	2004-07-14 16:59:14 -07:00
@@ -0,0 +1,133 @@
+/*
+ * 	w1_family.c
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/spinlock.h>
+#include <linux/list.h>
+
+#include "w1_family.h"
+
+spinlock_t w1_flock = SPIN_LOCK_UNLOCKED;
+static LIST_HEAD(w1_families);
+
+int w1_register_family(struct w1_family *newf)
+{
+	struct list_head *ent, *n;
+	struct w1_family *f;
+	int ret = 0;
+
+	spin_lock(&w1_flock);
+	list_for_each_safe(ent, n, &w1_families) {
+		f = list_entry(ent, struct w1_family, family_entry);
+
+		if (f->fid == newf->fid) {
+			ret = -EEXIST;
+			break;
+		}
+	}
+
+	if (!ret) {
+		atomic_set(&newf->refcnt, 0);
+		newf->need_exit = 0;
+		list_add_tail(&newf->family_entry, &w1_families);
+	}
+
+	spin_unlock(&w1_flock);
+
+	return ret;
+}
+
+void w1_unregister_family(struct w1_family *fent)
+{
+	struct list_head *ent, *n;
+	struct w1_family *f;
+
+	spin_lock(&w1_flock);
+	list_for_each_safe(ent, n, &w1_families) {
+		f = list_entry(ent, struct w1_family, family_entry);
+
+		if (f->fid == fent->fid) {
+			list_del(&fent->family_entry);
+			break;
+		}
+	}
+
+	fent->need_exit = 1;
+
+	spin_unlock(&w1_flock);
+
+	while (atomic_read(&fent->refcnt))
+		schedule_timeout(10);
+}
+
+/*
+ * Should be called under w1_flock held.
+ */
+struct w1_family * w1_family_registered(u8 fid)
+{
+	struct list_head *ent, *n;
+	struct w1_family *f = NULL;
+	int ret = 0;
+
+	list_for_each_safe(ent, n, &w1_families) {
+		f = list_entry(ent, struct w1_family, family_entry);
+
+		if (f->fid == fid) {
+			ret = 1;
+			break;
+		}
+	}
+
+	return (ret) ? f : NULL;
+}
+
+void w1_family_put(struct w1_family *f)
+{
+	spin_lock(&w1_flock);
+	__w1_family_put(f);
+	spin_unlock(&w1_flock);
+}
+
+void __w1_family_put(struct w1_family *f)
+{
+	if (atomic_dec_and_test(&f->refcnt))
+		f->need_exit = 1;
+}
+
+void w1_family_get(struct w1_family *f)
+{
+	spin_lock(&w1_flock);
+	__w1_family_get(f);
+	spin_unlock(&w1_flock);
+
+}
+
+void __w1_family_get(struct w1_family *f)
+{
+	atomic_inc(&f->refcnt);
+}
+
+EXPORT_SYMBOL(w1_family_get);
+EXPORT_SYMBOL(w1_family_put);
+EXPORT_SYMBOL(__w1_family_get);
+EXPORT_SYMBOL(__w1_family_put);
+EXPORT_SYMBOL(w1_family_registered);
+EXPORT_SYMBOL(w1_unregister_family);
+EXPORT_SYMBOL(w1_register_family);
diff -Nru a/drivers/w1/w1_family.h b/drivers/w1/w1_family.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/w1/w1_family.h	2004-07-14 16:59:14 -07:00
@@ -0,0 +1,65 @@
+/*
+ * 	w1_family.h
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef __W1_FAMILY_H
+#define __W1_FAMILY_H
+
+#include <linux/types.h>
+#include <linux/device.h>
+#include <asm/atomic.h>
+
+#define W1_FAMILY_DEFAULT	0
+#define W1_FAMILY_THERM		0x10
+#define W1_FAMILY_IBUT		0xff /* ? */
+
+#define MAXNAMELEN		32
+
+struct w1_family_ops
+{
+	ssize_t (* rname)(struct device *, char *);
+	ssize_t (* rbin)(struct kobject *, char *, loff_t, size_t);
+	
+	ssize_t (* rval)(struct device *, char *);
+	unsigned char rvalname[MAXNAMELEN];
+};
+
+struct w1_family
+{
+	struct list_head	family_entry;
+	u8			fid;
+	
+	struct w1_family_ops	*fops;
+	
+	atomic_t		refcnt;
+	u8			need_exit;
+};
+
+extern spinlock_t w1_flock;
+
+void w1_family_get(struct w1_family *);
+void w1_family_put(struct w1_family *);
+void __w1_family_get(struct w1_family *);
+void __w1_family_put(struct w1_family *);
+struct w1_family * w1_family_registered(u8);
+void w1_unregister_family(struct w1_family *);
+int w1_register_family(struct w1_family *);
+
+#endif /* __W1_FAMILY_H */
diff -Nru a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/w1/w1_int.c	2004-07-14 16:59:14 -07:00
@@ -0,0 +1,207 @@
+/*
+ * 	w1_int.c
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/list.h>
+
+#include "w1.h"
+#include "w1_log.h"
+
+static u32 w1_ids = 1;
+
+extern struct device_driver w1_driver;
+extern struct bus_type w1_bus_type;
+extern struct device w1_device;
+extern struct device_attribute w1_master_attribute;
+extern int w1_max_slave_count;
+extern struct list_head w1_masters;
+extern spinlock_t w1_mlock;
+
+extern int w1_process(void *);
+
+struct w1_master * w1_alloc_dev(u32 id, int slave_count,
+	      struct device_driver *driver, struct device *device)
+{
+	struct w1_master *dev;
+	int err;
+
+	/*
+	 * We are in process context(kernel thread), so can sleep.
+	 */
+	dev = kmalloc(sizeof(struct w1_master) + sizeof(struct w1_bus_master), GFP_KERNEL);
+	if (!dev) {
+		printk(KERN_ERR
+			"Failed to allocate %d bytes for new w1 device.\n",
+			sizeof(struct w1_master));
+		return NULL;
+	}
+
+	memset(dev, 0, sizeof(struct w1_master) + sizeof(struct w1_bus_master));
+
+	dev->bus_master = (struct w1_bus_master *)(dev + 1);
+
+	dev->owner 		= THIS_MODULE;
+	dev->max_slave_count 	= slave_count;
+	dev->slave_count 	= 0;
+	dev->attempts 		= 0;
+	dev->kpid 		= -1;
+	dev->initialized 	= 0;
+	dev->id 		= id;
+
+	atomic_set(&dev->refcnt, 2);
+
+	INIT_LIST_HEAD(&dev->slist);
+	init_MUTEX(&dev->mutex);
+
+	init_waitqueue_head(&dev->kwait);
+	init_completion(&dev->dev_released);
+	init_completion(&dev->dev_exited);
+
+	memcpy(&dev->dev, device, sizeof(struct device));
+	snprintf(dev->dev.bus_id, sizeof(dev->dev.bus_id),
+		  "w1_bus_master%u", dev->id);
+	snprintf(dev->name, sizeof(dev->name), "w1_bus_master%u", dev->id);
+
+	dev->driver = driver;
+
+	dev->groups = 23;
+	dev->seq = 1;
+	dev->nls = netlink_kernel_create(NETLINK_NFLOG, NULL);
+	if (!dev->nls) {
+		printk(KERN_ERR "Failed to create new netlink socket(%u).\n",
+			NETLINK_NFLOG);
+		memset(dev, 0, sizeof(struct w1_master));
+		kfree(dev);
+		dev = NULL;
+	}
+
+	err = device_register(&dev->dev);
+	if (err) {
+		printk(KERN_ERR "Failed to register master device. err=%d\n", err);
+		if (dev->nls->sk_socket)
+			sock_release(dev->nls->sk_socket);
+		memset(dev, 0, sizeof(struct w1_master));
+		kfree(dev);
+		dev = NULL;
+	}
+
+	return dev;
+}
+
+void w1_free_dev(struct w1_master *dev)
+{
+	device_unregister(&dev->dev);
+	if (dev->nls->sk_socket)
+		sock_release(dev->nls->sk_socket);
+	memset(dev, 0, sizeof(struct w1_master) + sizeof(struct w1_bus_master));
+	kfree(dev);
+}
+
+int w1_add_master_device(struct w1_bus_master *master)
+{
+	struct w1_master *dev;
+	int retval = 0;
+
+	dev = w1_alloc_dev(w1_ids++, w1_max_slave_count, &w1_driver, &w1_device);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->kpid = kernel_thread(&w1_process, dev, 0);
+	if (dev->kpid < 0) {
+		dev_err(&dev->dev,
+			 "Failed to create new kernel thread. err=%d\n",
+			 dev->kpid);
+		retval = dev->kpid;
+		goto err_out_free_dev;
+	}
+
+	retval = device_create_file(&dev->dev, &w1_master_attribute);
+	if (retval)
+		goto err_out_kill_thread;
+
+	memcpy(dev->bus_master, master, sizeof(struct w1_bus_master));
+
+	dev->initialized = 1;
+
+	spin_lock(&w1_mlock);
+	list_add(&dev->w1_master_entry, &w1_masters);
+	spin_unlock(&w1_mlock);
+
+	return 0;
+
+err_out_kill_thread:
+	dev->need_exit = 1;
+	if (kill_proc(dev->kpid, SIGTERM, 1))
+		dev_err(&dev->dev,
+			 "Failed to send signal to w1 kernel thread %d.\n",
+			 dev->kpid);
+	wait_for_completion(&dev->dev_exited);
+
+err_out_free_dev:
+	w1_free_dev(dev);
+
+	return retval;
+}
+
+void __w1_remove_master_device(struct w1_master *dev)
+{
+	int err;
+
+	dev->need_exit = 1;
+	err = kill_proc(dev->kpid, SIGTERM, 1);
+	if (err)
+		dev_err(&dev->dev,
+			 "%s: Failed to send signal to w1 kernel thread %d.\n",
+			 __func__, dev->kpid);
+
+	while (atomic_read(&dev->refcnt))
+		schedule_timeout(10);
+
+	w1_free_dev(dev);
+}
+
+void w1_remove_master_device(struct w1_bus_master *bm)
+{
+	struct w1_master *dev = NULL;
+	struct list_head *ent, *n;
+
+	list_for_each_safe(ent, n, &w1_masters) {
+		dev = list_entry(ent, struct w1_master, w1_master_entry);
+		if (!dev->initialized)
+			continue;
+
+		if (dev->bus_master->data == bm->data)
+			break;
+	}
+
+	if (!dev) {
+		printk(KERN_ERR "Device doesn't exist.\n");
+		return;
+	}
+
+	__w1_remove_master_device(dev);
+}
+
+EXPORT_SYMBOL(w1_alloc_dev);
+EXPORT_SYMBOL(w1_free_dev);
+EXPORT_SYMBOL(w1_add_master_device);
+EXPORT_SYMBOL(w1_remove_master_device);
+EXPORT_SYMBOL(__w1_remove_master_device);
diff -Nru a/drivers/w1/w1_int.h b/drivers/w1/w1_int.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/w1/w1_int.h	2004-07-14 16:59:14 -07:00
@@ -0,0 +1,36 @@
+/*
+ * 	w1_int.h
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef __W1_INT_H
+#define __W1_INT_H
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+
+#include "w1.h"
+
+struct w1_master * w1_alloc_dev(int, struct device_driver *, struct device *);
+void w1_free_dev(struct w1_master *dev);
+int w1_add_master_device(struct w1_bus_master *);
+void w1_remove_master_device(struct w1_bus_master *);
+void __w1_remove_master_device(struct w1_master *);
+
+#endif /* __W1_INT_H */
diff -Nru a/drivers/w1/w1_io.c b/drivers/w1/w1_io.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/w1/w1_io.c	2004-07-14 16:59:14 -07:00
@@ -0,0 +1,138 @@
+/*
+ * 	w1_io.c
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <asm/io.h>
+#include <asm/delay.h>
+
+#include <linux/moduleparam.h>
+
+#include "w1.h"
+#include "w1_log.h"
+#include "w1_io.h"
+
+int w1_delay_parm = 1;
+module_param_named(delay_coef, w1_delay_parm, int, 0);
+
+static u8 w1_crc8_table[] = {
+	0, 94, 188, 226, 97, 63, 221, 131, 194, 156, 126, 32, 163, 253, 31, 65,
+	157, 195, 33, 127, 252, 162, 64, 30, 95, 1, 227, 189, 62, 96, 130, 220,
+	35, 125, 159, 193, 66, 28, 254, 160, 225, 191, 93, 3, 128, 222, 60, 98,
+	190, 224, 2, 92, 223, 129, 99, 61, 124, 34, 192, 158, 29, 67, 161, 255,
+	70, 24, 250, 164, 39, 121, 155, 197, 132, 218, 56, 102, 229, 187, 89, 7,
+	219, 133, 103, 57, 186, 228, 6, 88, 25, 71, 165, 251, 120, 38, 196, 154,
+	101, 59, 217, 135, 4, 90, 184, 230, 167, 249, 27, 69, 198, 152, 122, 36,
+	248, 166, 68, 26, 153, 199, 37, 123, 58, 100, 134, 216, 91, 5, 231, 185,
+	140, 210, 48, 110, 237, 179, 81, 15, 78, 16, 242, 172, 47, 113, 147, 205,
+	17, 79, 173, 243, 112, 46, 204, 146, 211, 141, 111, 49, 178, 236, 14, 80,
+	175, 241, 19, 77, 206, 144, 114, 44, 109, 51, 209, 143, 12, 82, 176, 238,
+	50, 108, 142, 208, 83, 13, 239, 177, 240, 174, 76, 18, 145, 207, 45, 115,
+	202, 148, 118, 40, 171, 245, 23, 73, 8, 86, 180, 234, 105, 55, 213, 139,
+	87, 9, 235, 181, 54, 104, 138, 212, 149, 203, 41, 119, 244, 170, 72, 22,
+	233, 183, 85, 11, 136, 214, 52, 106, 43, 117, 151, 201, 74, 20, 246, 168,
+	116, 42, 200, 150, 21, 75, 169, 247, 182, 232, 10, 84, 215, 137, 107, 53
+};
+
+void w1_delay(unsigned long tm)
+{
+	udelay(tm * w1_delay_parm);
+}
+
+void w1_write_bit(struct w1_master *dev, int bit)
+{
+	if (bit) {
+		dev->bus_master->write_bit(dev->bus_master->data, 0);
+		w1_delay(6);
+		dev->bus_master->write_bit(dev->bus_master->data, 1);
+		w1_delay(64);
+	} else {
+		dev->bus_master->write_bit(dev->bus_master->data, 0);
+		w1_delay(60);
+		dev->bus_master->write_bit(dev->bus_master->data, 1);
+		w1_delay(10);
+	}
+}
+
+void w1_write_8(struct w1_master *dev, u8 byte)
+{
+	int i;
+
+	for (i = 0; i < 8; ++i)
+		w1_write_bit(dev, (byte >> i) & 0x1);
+}
+
+u8 w1_read_bit(struct w1_master *dev)
+{
+	int result;
+
+	dev->bus_master->write_bit(dev->bus_master->data, 0);
+	w1_delay(6);
+	dev->bus_master->write_bit(dev->bus_master->data, 1);
+	w1_delay(9);
+
+	result = dev->bus_master->read_bit(dev->bus_master->data);
+	w1_delay(55);
+
+	return result & 0x1;
+}
+
+u8 w1_read_8(struct w1_master * dev)
+{
+	int i;
+	u8 res = 0;
+
+	for (i = 0; i < 8; ++i)
+		res |= (w1_read_bit(dev) << i);
+
+	return res;
+}
+
+int w1_reset_bus(struct w1_master *dev)
+{
+	int result;
+
+	dev->bus_master->write_bit(dev->bus_master->data, 0);
+	w1_delay(480);
+	dev->bus_master->write_bit(dev->bus_master->data, 1);
+	w1_delay(70);
+
+	result = dev->bus_master->read_bit(dev->bus_master->data) & 0x1;
+	w1_delay(410);
+
+	return result;
+}
+
+u8 w1_calc_crc8(u8 * data, int len)
+{
+	u8 crc = 0;
+
+	while (len--)
+		crc = w1_crc8_table[crc ^ *data++];
+
+	return crc;
+}
+
+EXPORT_SYMBOL(w1_write_bit);
+EXPORT_SYMBOL(w1_write_8);
+EXPORT_SYMBOL(w1_read_bit);
+EXPORT_SYMBOL(w1_read_8);
+EXPORT_SYMBOL(w1_reset_bus);
+EXPORT_SYMBOL(w1_calc_crc8);
+EXPORT_SYMBOL(w1_delay);
diff -Nru a/drivers/w1/w1_io.h b/drivers/w1/w1_io.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/w1/w1_io.h	2004-07-14 16:59:14 -07:00
@@ -0,0 +1,35 @@
+/*
+ * 	w1_io.h
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef __W1_IO_H
+#define __W1_IO_H
+
+#include "w1.h"
+
+void w1_delay(unsigned long);
+void w1_write_bit(struct w1_master *, int);
+void w1_write_8(struct w1_master *, u8);
+u8 w1_read_bit(struct w1_master *);
+u8 w1_read_8(struct w1_master *);
+int w1_reset_bus(struct w1_master *);
+u8 w1_calc_crc8(u8 *, int);
+
+#endif /* __W1_IO_H */
diff -Nru a/drivers/w1/w1_log.h b/drivers/w1/w1_log.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/w1/w1_log.h	2004-07-14 16:59:14 -07:00
@@ -0,0 +1,38 @@
+/*
+ * 	w1_log.h
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef __W1_LOG_H
+#define __W1_LOG_H
+
+#define DEBUG
+
+#ifdef W1_DEBUG
+#  define assert(expr) do {} while (0)
+#else
+#  define assert(expr) \
+        if(unlikely(!(expr))) {				        \
+        printk(KERN_ERR "Assertion failed! %s,%s,%s,line=%d\n",	\
+        #expr,__FILE__,__FUNCTION__,__LINE__);		        \
+        }
+#endif
+
+#endif /* __W1_LOG_H */
+
diff -Nru a/drivers/w1/w1_netlink.c b/drivers/w1/w1_netlink.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/w1/w1_netlink.c	2004-07-14 16:59:14 -07:00
@@ -0,0 +1,55 @@
+/*
+ * w1_netlink.c
+ *
+ * Copyright (c) 2003 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/skbuff.h>
+#include <linux/netlink.h>
+
+#include "w1.h"
+#include "w1_log.h"
+#include "w1_netlink.h"
+
+void w1_netlink_send(struct w1_master *dev, struct w1_netlink_msg *msg)
+{
+	unsigned int size;
+	struct sk_buff *skb;
+	struct w1_netlink_msg *data;
+	struct nlmsghdr *nlh;
+
+	size = NLMSG_SPACE(sizeof(struct w1_netlink_msg));
+
+	skb = alloc_skb(size, GFP_ATOMIC);
+	if (!skb) {
+		dev_err(&dev->dev, "skb_alloc() failed.\n");
+		return;
+	}
+
+	nlh = NLMSG_PUT(skb, 0, dev->seq++, NLMSG_DONE, size - sizeof(*nlh));
+
+	data = (struct w1_netlink_msg *)NLMSG_DATA(nlh);
+
+	memcpy(data, msg, sizeof(struct w1_netlink_msg));
+
+	NETLINK_CB(skb).dst_groups = dev->groups;
+	netlink_broadcast(dev->nls, skb, 0, dev->groups, GFP_ATOMIC);
+
+nlmsg_failure:
+	return;
+}
diff -Nru a/drivers/w1/w1_netlink.h b/drivers/w1/w1_netlink.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/w1/w1_netlink.h	2004-07-14 16:59:14 -07:00
@@ -0,0 +1,44 @@
+/*
+ * w1_netlink.h
+ *
+ * Copyright (c) 2003 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef __W1_NETLINK_H
+#define __W1_NETLINK_H
+
+#include <asm/types.h>
+
+#include "w1.h"
+
+struct w1_netlink_msg 
+{
+	union
+	{
+		struct w1_reg_num 	id;
+		__u64			w1_id;
+	} id;
+	__u64				val;
+};
+
+#ifdef __KERNEL__
+
+void w1_netlink_send(struct w1_master *, struct w1_netlink_msg *);
+
+#endif /* __KERNEL__ */
+#endif /* __W1_NETLINK_H */
diff -Nru a/drivers/w1/w1_therm.c b/drivers/w1/w1_therm.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/w1/w1_therm.c	2004-07-14 16:59:14 -07:00
@@ -0,0 +1,177 @@
+/*
+ * 	w1_therm.c
+ *
+ * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the therms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <asm/types.h>
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <linux/types.h>
+
+#include "w1.h"
+#include "w1_io.h"
+#include "w1_int.h"
+#include "w1_family.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
+MODULE_DESCRIPTION("Driver for 1-wire Dallas network protocol, temperature family.");
+
+static ssize_t w1_therm_read_name(struct device *, char *);
+static ssize_t w1_therm_read_temp(struct device *, char *);
+static ssize_t w1_therm_read_bin(struct kobject *, char *, loff_t, size_t);
+
+static struct w1_family_ops w1_therm_fops = {
+	.rname = &w1_therm_read_name,
+	.rbin = &w1_therm_read_bin,
+	.rval = &w1_therm_read_temp,
+	.rvalname = "temp1_input",
+};
+
+static ssize_t w1_therm_read_name(struct device *dev, char *buf)
+{
+	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
+
+	return sprintf(buf, "%s\n", sl->name);
+}
+
+static ssize_t w1_therm_read_temp(struct device *dev, char *buf)
+{
+	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
+	s16 temp;
+
+	/* 
+	 * Must be more precise.
+	 */
+	temp = 0;
+	temp <<= sl->rom[1] / 2;
+	temp |= sl->rom[0] / 2;
+
+	return sprintf(buf, "%d\n", temp * 1000);
+}
+
+static ssize_t w1_therm_read_bin(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	struct w1_slave *sl = container_of(container_of(kobj, struct device, kobj),
+			      			struct w1_slave, dev);
+	struct w1_master *dev = sl->master;
+	u8 rom[9], crc, verdict;
+	size_t icount;
+	int i;
+	u16 temp;
+
+	atomic_inc(&sl->refcnt);
+	if (down_interruptible(&sl->master->mutex)) {
+		count = 0;
+		goto out_dec;
+	}
+
+	if (off > W1_SLAVE_DATA_SIZE) {
+		count = 0;
+		goto out;
+	}
+	if (off + count > W1_SLAVE_DATA_SIZE)
+		count = W1_SLAVE_DATA_SIZE - off;
+
+	icount = count;
+
+	memset(buf, 0, count);
+	memset(rom, 0, sizeof(rom));
+
+	count = 0;
+	verdict = 0;
+	crc = 0;
+	if (!w1_reset_bus(dev)) {
+		u64 id = *(u64 *) & sl->reg_num;
+		int count = 0;
+
+		w1_write_8(dev, W1_MATCH_ROM);
+		for (i = 0; i < 8; ++i)
+			w1_write_8(dev, (id >> i * 8) & 0xff);
+
+		w1_write_8(dev, W1_CONVERT_TEMP);
+
+		while (dev->bus_master->read_bit(dev->bus_master->data) == 0
+		       && count < 10) {
+			w1_delay(1);
+			count++;
+		}
+
+		if (count < 10) {
+			if (!w1_reset_bus(dev)) {
+				w1_write_8(dev, W1_MATCH_ROM);
+				for (i = 0; i < 8; ++i)
+					w1_write_8(dev,
+						   (id >> i * 8) & 0xff);
+
+				w1_write_8(dev, W1_READ_SCRATCHPAD);
+				for (i = 0; i < 9; ++i)
+					rom[i] = w1_read_8(dev);
+
+				crc = w1_calc_crc8(rom, 8);
+
+				if (rom[8] == crc && rom[0])
+					verdict = 1;
+			}
+		}
+		else
+			dev_warn(&dev->dev,
+				  "18S20 doesn't respond to CONVERT_TEMP.\n");
+	}
+
+	for (i = 0; i < 9; ++i)
+		count += snprintf(buf + count, icount - count, "%02x ", rom[i]);
+	count += snprintf(buf + count, icount - count, ": crc=%02x %s\n",
+			   crc, (verdict) ? "YES" : "NO");
+	if (verdict)
+		memcpy(sl->rom, rom, sizeof(sl->rom));
+	for (i = 0; i < 9; ++i)
+		count += snprintf(buf + count, icount - count, "%02x ", sl->rom[i]);
+	temp = 0;
+	temp <<= sl->rom[1] / 2;
+	temp |= sl->rom[0] / 2;
+	count += snprintf(buf + count, icount - count, "t=%u\n", temp);
+out:
+	up(&dev->mutex);
+out_dec:
+	atomic_dec(&sl->refcnt);
+
+	return count;
+}
+
+static struct w1_family w1_therm_family = {
+	.fid = W1_FAMILY_THERM,
+	.fops = &w1_therm_fops,
+};
+
+static int __init w1_therm_init(void)
+{
+	return w1_register_family(&w1_therm_family);
+}
+
+static void __exit w1_therm_fini(void)
+{
+	w1_unregister_family(&w1_therm_family);
+}
+
+module_init(w1_therm_init);
+module_exit(w1_therm_fini);

