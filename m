Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbVAXUSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVAXUSg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 15:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVAXUSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 15:18:36 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:41686 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261613AbVAXUOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:14:39 -0500
Date: Mon, 24 Jan 2005 23:37:20 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: [1/1] superio: change scx200 module name to scx.
Message-ID: <20050124233720.484c7ad0@zanzibar.2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change scx200 module name to scx.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

--- linux-2.6/drivers/superio/scx.c	1970-01-01 03:00:00.000000000 +0300
+++ linux-2.6/drivers/superio/scx.c	2005-01-24 22:06:15.000000000 +0300
@@ -0,0 +1,413 @@
+/*
+ * 	scx.c
+ * 
+ * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <asm/atomic.h>
+#include <asm/types.h>
+#include <asm/io.h>
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/timer.h>
+#include <linux/slab.h>
+#include <linux/timer.h>
+#include <linux/mod_devicetable.h>
+#include <linux/pci.h>
+#include <linux/suspend.h>
+
+#include "sc.h"
+#include "scx.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
+MODULE_DESCRIPTION("Driver for SCx200/SC1100 SuperIO chips.");
+
+static int scx200_probe(void *, unsigned long base);
+static int scx200_activate_one_logical(struct logical_dev *ldev);
+static int scx200_deactivate_one_logical(struct logical_dev *ldev);
+
+static struct sc_chip_id scx200_logical_devs[] = {
+	{"RTC", 0x00},
+	{"SWC", 0x01},
+	{"IRCP", 0x02},
+	{"ACB", 0x05},
+	{"ACB", 0x06},
+	{"SPORT", 0x08},
+	{"GPIO", LDEV_PRIVATE},
+	{}
+};
+
+static struct sc_dev scx200_dev = {
+	.name =			"SCx200",
+	.probe =		scx200_probe,
+	.ldevs = 		scx200_logical_devs,
+	.activate_one = 	scx200_activate_one_logical,
+	.deactivate_one =	scx200_deactivate_one_logical,
+};
+
+static struct sc_chip_id scx200_sio_ids[] = {
+	{"SCx200/SC1100", 0xF5},
+};
+
+static unsigned long private_base;
+
+static struct pci_device_id scx200_tbl[] = {
+	{PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SCx200_BRIDGE)},
+	{PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SC1100_BRIDGE)},
+	{},
+};
+
+MODULE_DEVICE_TABLE(pci, scx200_tbl);
+
+static int scx200_pci_probe(struct pci_dev *, const struct pci_device_id *);
+
+static struct pci_driver scx200_pci_driver = {
+	.name = "scx200",
+	.id_table = scx200_tbl,
+	.probe = scx200_pci_probe,
+};
+
+void scx200_write_reg(struct sc_dev *dev, u8 reg, u8 val)
+{
+	outb(reg, dev->base_index);
+	outb(val, dev->base_data);
+}
+
+u8 scx200_read_reg(struct sc_dev *dev, u8 reg)
+{
+	u8 val;
+
+	outb(reg, dev->base_index);
+	val = inb(dev->base_data);
+
+	return val;
+}
+
+static u8 scx200_gpio_read(void *data, int pin_number)
+{
+	u32 val;
+	int bank;
+	unsigned long base;
+	struct logical_dev *ldev = (struct logical_dev *)data;
+
+	if (pin_number > 63 || pin_number < 0)
+		return 0;
+
+	bank = 0;
+	base = ldev->base_addr;
+
+	if (pin_number > 31) {
+		bank = 1;
+		base = ldev->base_addr + 0x10;
+		pin_number -= 32;
+	}
+
+	val = inl(base + 0x04);
+
+	return ((val >> pin_number) & 0x01);
+}
+
+static void scx200_gpio_write(void *data, int pin_number, u8 byte)
+{
+	u32 val;
+	int bank;
+	unsigned long base;
+	struct logical_dev *ldev = (struct logical_dev *)data;
+
+	if (pin_number > 63 || pin_number < 0)
+		return;
+
+	bank = 0;
+	base = ldev->base_addr;
+
+	if (pin_number > 31) {
+		bank = 1;
+		base = ldev->base_addr + 0x10;
+		pin_number -= 32;
+	}
+
+	val = inl(base);
+
+	if (byte)
+		val |= (1 << pin_number);
+	else
+		val &= ~(1 << pin_number);
+
+	outl(val, base);
+}
+
+void scx200_gpio_control(void *data, int pin_number, u8 mask, u8 ctl)
+{
+	u32 val;
+	int bank;
+	unsigned long base;
+	struct logical_dev *ldev = (struct logical_dev *)data;
+
+	if (pin_number > 63 || pin_number < 0)
+		return;
+
+	bank = 0;
+	base = ldev->base_addr;
+
+	if (pin_number > 31) {
+		bank = 1;
+		base = ldev->base_addr + 0x10;
+		pin_number -= 32;
+	}
+
+	/*
+	 * Pin selection.
+	 */
+
+	val = 0;
+	val = ((bank & 0x01) << 5) | pin_number;
+	outl(val, ldev->base_addr + 0x20);
+
+	val = inl(ldev->base_addr + 0x24);
+
+	val &= 0x7f;
+	val &= mask;
+	val |= ctl;
+
+	outl(val, ldev->base_addr + 0x24);
+}
+
+int scx200_gpio_activate(void *data)
+{
+	return 0;
+}
+
+static int scx200_ldev_index_by_name(char *name)
+{
+	int i;
+
+	for (i = 0;
+	     i < sizeof(scx200_logical_devs) / sizeof(scx200_logical_devs[0]); ++i)
+		if (!strncmp(scx200_logical_devs[i].name, name, SC_NAME_LEN))
+			return i;
+
+	return -ENODEV;
+}
+
+static int scx200_chip_index(u8 id)
+{
+	int i;
+
+	for (i = 0; i < sizeof(scx200_sio_ids) / sizeof(scx200_sio_ids[0]); ++i)
+		if (scx200_sio_ids[i].id == id)
+			return i;
+
+	return -ENODEV;
+}
+
+static int scx200_probe(void *data, unsigned long base)
+{
+	unsigned long size = 2;
+	u8 id;
+	int chip_num;
+	struct sc_dev *dev = (struct sc_dev *)data;
+
+	/*
+	 * Special address to handle.
+	 */
+	if (base == 0) {
+		return scx200_probe(data, 0x015C);
+	}
+
+	dev->base_index = base;
+	dev->base_data = base + 1;
+
+	id = scx200_read_reg(dev, SIO_REG_SID);
+	chip_num = scx200_chip_index(id);
+
+	if (chip_num >= 0) {
+		printk(KERN_INFO "Found %s [0x%x] at 0x%04lx-0x%04lx.\n",
+		       scx200_sio_ids[chip_num].name,
+		       scx200_sio_ids[chip_num].id, base, base + size - 1);
+		return 0;
+	}
+
+	printk(KERN_INFO "Found nothing at 0x%04lx-0x%04lx.\n", 
+			base, base + size - 1);
+
+	return -ENODEV;
+}
+
+static int scx200_pci_probe(struct pci_dev *pdev,
+			    const struct pci_device_id *ent)
+{
+	private_base = pci_resource_start(pdev, 0);
+	printk(KERN_INFO "%s: GPIO base 0x%lx.\n", pci_name(pdev), private_base);
+
+	if (!request_region
+	    (private_base, SCx200_GPIO_SIZE, "NatSemi SCx200 GPIO")) {
+		printk(KERN_ERR "%s: failed to request %d bytes I/O region for GPIOs.\n",
+		       pci_name(pdev), SCx200_GPIO_SIZE);
+		return -EBUSY;
+	}
+
+	pci_set_drvdata(pdev, &private_base);
+	pci_enable_device(pdev);
+
+	return 0;
+}
+
+static int scx200_deactivate_one_logical(struct logical_dev *ldev)
+{
+	if (ldev->index != LDEV_PRIVATE)
+		return -ENODEV;
+
+	private_base -= 0x10;
+
+	return 0;
+}
+
+static int scx200_find_private_device(struct logical_dev *ldev)
+{
+	struct sc_dev *dev = (struct sc_dev *)ldev->pdev;
+
+	/*
+	 * SCx200/SC1100 has only GPIO in it's private space.
+	 */
+
+	if (strncmp(ldev->name, "GPIO", SC_NAME_LEN)) {
+		printk(KERN_ERR "Logical device %s at private space is not supported in chip %s.\n",
+		       ldev->name, dev->name);
+		return -ENODEV;
+	}
+
+	ldev->base_addr = private_base;
+	private_base += 0x10;
+
+	ldev->read = scx200_gpio_read;
+	ldev->write = scx200_gpio_write;
+	ldev->control = scx200_gpio_control;
+	ldev->activate = scx200_gpio_activate;
+
+	return 0;
+}
+
+static int scx200_activate_one_logical(struct logical_dev *ldev)
+{
+	int err, idx;
+	struct sc_dev *dev = ldev->pdev;
+	u8 active;
+
+	idx = scx200_ldev_index_by_name(ldev->name);
+	if (idx < 0) {
+		printk(KERN_INFO "Chip %s does not have logical device %s at %x.\n",
+		       dev->name, ldev->name, ldev->index);
+		return -ENODEV;
+	}
+
+	if (scx200_logical_devs[idx].id == LDEV_PRIVATE) {
+		err = scx200_find_private_device(ldev);
+		if (err)
+			return err;
+
+		printk(KERN_INFO "\t%16s - found at 0x%lx.\n", 
+				ldev->name, ldev->base_addr);
+	} else {
+		scx200_write_reg(dev, SIO_REG_LDN, ldev->index);
+		active = scx200_read_reg(dev, SIO_REG_ACTIVE);
+		if ((active & SIO_ACTIVE_EN) == 0) {
+			printk(KERN_INFO "\t%16s - not activated at %x: activating... ",
+			       ldev->name, ldev->index);
+
+			scx200_write_reg(dev, SIO_REG_ACTIVE,
+					 active | SIO_ACTIVE_EN);
+			active = scx200_read_reg(dev, SIO_REG_ACTIVE);
+			if ((active & SIO_ACTIVE_EN) == 0) {
+				printk("failed.\n");
+				return -ENODEV;
+			}
+			printk("done.\n");
+		}
+
+		ldev->base_addr = scx200_read_reg(dev, SIO_REG_IO_LSB);
+		ldev->base_addr |= (scx200_read_reg(dev, SIO_REG_IO_MSB) << 8);
+	}
+
+	err = ldev->activate(ldev);
+	if (err < 0) {
+		printk(KERN_INFO "\t%16s - not activated: ->activate() failed with error code %d.\n",
+				ldev->name, err);
+		return -ENODEV;
+	}
+
+	printk(KERN_INFO "\t%16s - activated at %x: 0x%04lx-0x%04lx\n",
+	       ldev->name, ldev->index, ldev->base_addr,
+	       ldev->base_addr + ldev->range);
+
+	return 0;
+}
+
+static int scx200_init(void)
+{
+	int err;
+
+	err = pci_module_init(&scx200_pci_driver);
+	if (err) {
+		printk(KERN_ERR "Failed to register PCI driver for device %s : err=%d.\n",
+		       scx200_pci_driver.name, err);
+		return err;
+	}
+
+	err = sc_add_sc_dev(&scx200_dev);
+	if (err)
+		return err;
+
+	printk(KERN_INFO "Driver for %s SuperIO chip.\n", scx200_dev.name);
+	return 0;
+}
+
+static void scx200_fini(void)
+{
+	sc_del_sc_dev(&scx200_dev);
+
+	while (atomic_read(&scx200_dev.refcnt))
+	{
+		printk(KERN_INFO "Waiting for %s to became free: refcnt=%d.\n",
+				scx200_dev.name, atomic_read(&scx200_dev.refcnt));
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(HZ);
+			
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_FREEZE);
+
+		if (signal_pending(current))
+			flush_signals(current);
+	}
+
+	pci_unregister_driver(&scx200_pci_driver);
+	if (private_base)
+		release_region(private_base, SCx200_GPIO_SIZE);
+}
+
+module_init(scx200_init);
+module_exit(scx200_fini);
+
+EXPORT_SYMBOL(scx200_write_reg);
+EXPORT_SYMBOL(scx200_read_reg);
--- linux-2.6/drivers/superio/scx200.c	2005-01-24 22:06:15.000000000 +0300
+++ /dev/null	2004-09-17 14:58:06.000000000 +0400
@@ -1,413 +0,0 @@
-/*
- * 	scx200.c
- * 
- * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * All rights reserved.
- * 
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
- */
-
-#include <asm/atomic.h>
-#include <asm/types.h>
-#include <asm/io.h>
-
-#include <linux/delay.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/list.h>
-#include <linux/interrupt.h>
-#include <linux/spinlock.h>
-#include <linux/timer.h>
-#include <linux/slab.h>
-#include <linux/timer.h>
-#include <linux/mod_devicetable.h>
-#include <linux/pci.h>
-#include <linux/suspend.h>
-
-#include "sc.h"
-#include "scx200.h"
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Evgeniy Polyakov <johnpol@2ka.mipt.ru>");
-MODULE_DESCRIPTION("Driver for SCx200/SC1100 SuperIO chips.");
-
-static int scx200_probe(void *, unsigned long base);
-static int scx200_activate_one_logical(struct logical_dev *ldev);
-static int scx200_deactivate_one_logical(struct logical_dev *ldev);
-
-static struct sc_chip_id scx200_logical_devs[] = {
-	{"RTC", 0x00},
-	{"SWC", 0x01},
-	{"IRCP", 0x02},
-	{"ACB", 0x05},
-	{"ACB", 0x06},
-	{"SPORT", 0x08},
-	{"GPIO", LDEV_PRIVATE},
-	{}
-};
-
-static struct sc_dev scx200_dev = {
-	.name =			"SCx200",
-	.probe =		scx200_probe,
-	.ldevs = 		scx200_logical_devs,
-	.activate_one = 	scx200_activate_one_logical,
-	.deactivate_one =	scx200_deactivate_one_logical,
-};
-
-static struct sc_chip_id scx200_sio_ids[] = {
-	{"SCx200/SC1100", 0xF5},
-};
-
-static unsigned long private_base;
-
-static struct pci_device_id scx200_tbl[] = {
-	{PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SCx200_BRIDGE)},
-	{PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_SC1100_BRIDGE)},
-	{},
-};
-
-MODULE_DEVICE_TABLE(pci, scx200_tbl);
-
-static int scx200_pci_probe(struct pci_dev *, const struct pci_device_id *);
-
-static struct pci_driver scx200_pci_driver = {
-	.name = "scx200",
-	.id_table = scx200_tbl,
-	.probe = scx200_pci_probe,
-};
-
-void scx200_write_reg(struct sc_dev *dev, u8 reg, u8 val)
-{
-	outb(reg, dev->base_index);
-	outb(val, dev->base_data);
-}
-
-u8 scx200_read_reg(struct sc_dev *dev, u8 reg)
-{
-	u8 val;
-
-	outb(reg, dev->base_index);
-	val = inb(dev->base_data);
-
-	return val;
-}
-
-static u8 scx200_gpio_read(void *data, int pin_number)
-{
-	u32 val;
-	int bank;
-	unsigned long base;
-	struct logical_dev *ldev = (struct logical_dev *)data;
-
-	if (pin_number > 63 || pin_number < 0)
-		return 0;
-
-	bank = 0;
-	base = ldev->base_addr;
-
-	if (pin_number > 31) {
-		bank = 1;
-		base = ldev->base_addr + 0x10;
-		pin_number -= 32;
-	}
-
-	val = inl(base + 0x04);
-
-	return ((val >> pin_number) & 0x01);
-}
-
-static void scx200_gpio_write(void *data, int pin_number, u8 byte)
-{
-	u32 val;
-	int bank;
-	unsigned long base;
-	struct logical_dev *ldev = (struct logical_dev *)data;
-
-	if (pin_number > 63 || pin_number < 0)
-		return;
-
-	bank = 0;
-	base = ldev->base_addr;
-
-	if (pin_number > 31) {
-		bank = 1;
-		base = ldev->base_addr + 0x10;
-		pin_number -= 32;
-	}
-
-	val = inl(base);
-
-	if (byte)
-		val |= (1 << pin_number);
-	else
-		val &= ~(1 << pin_number);
-
-	outl(val, base);
-}
-
-void scx200_gpio_control(void *data, int pin_number, u8 mask, u8 ctl)
-{
-	u32 val;
-	int bank;
-	unsigned long base;
-	struct logical_dev *ldev = (struct logical_dev *)data;
-
-	if (pin_number > 63 || pin_number < 0)
-		return;
-
-	bank = 0;
-	base = ldev->base_addr;
-
-	if (pin_number > 31) {
-		bank = 1;
-		base = ldev->base_addr + 0x10;
-		pin_number -= 32;
-	}
-
-	/*
-	 * Pin selection.
-	 */
-
-	val = 0;
-	val = ((bank & 0x01) << 5) | pin_number;
-	outl(val, ldev->base_addr + 0x20);
-
-	val = inl(ldev->base_addr + 0x24);
-
-	val &= 0x7f;
-	val &= mask;
-	val |= ctl;
-
-	outl(val, ldev->base_addr + 0x24);
-}
-
-int scx200_gpio_activate(void *data)
-{
-	return 0;
-}
-
-static int scx200_ldev_index_by_name(char *name)
-{
-	int i;
-
-	for (i = 0;
-	     i < sizeof(scx200_logical_devs) / sizeof(scx200_logical_devs[0]); ++i)
-		if (!strncmp(scx200_logical_devs[i].name, name, SC_NAME_LEN))
-			return i;
-
-	return -ENODEV;
-}
-
-static int scx200_chip_index(u8 id)
-{
-	int i;
-
-	for (i = 0; i < sizeof(scx200_sio_ids) / sizeof(scx200_sio_ids[0]); ++i)
-		if (scx200_sio_ids[i].id == id)
-			return i;
-
-	return -ENODEV;
-}
-
-static int scx200_probe(void *data, unsigned long base)
-{
-	unsigned long size = 2;
-	u8 id;
-	int chip_num;
-	struct sc_dev *dev = (struct sc_dev *)data;
-
-	/*
-	 * Special address to handle.
-	 */
-	if (base == 0) {
-		return scx200_probe(data, 0x015C);
-	}
-
-	dev->base_index = base;
-	dev->base_data = base + 1;
-
-	id = scx200_read_reg(dev, SIO_REG_SID);
-	chip_num = scx200_chip_index(id);
-
-	if (chip_num >= 0) {
-		printk(KERN_INFO "Found %s [0x%x] at 0x%04lx-0x%04lx.\n",
-		       scx200_sio_ids[chip_num].name,
-		       scx200_sio_ids[chip_num].id, base, base + size - 1);
-		return 0;
-	}
-
-	printk(KERN_INFO "Found nothing at 0x%04lx-0x%04lx.\n", 
-			base, base + size - 1);
-
-	return -ENODEV;
-}
-
-static int scx200_pci_probe(struct pci_dev *pdev,
-			    const struct pci_device_id *ent)
-{
-	private_base = pci_resource_start(pdev, 0);
-	printk(KERN_INFO "%s: GPIO base 0x%lx.\n", pci_name(pdev), private_base);
-
-	if (!request_region
-	    (private_base, SCx200_GPIO_SIZE, "NatSemi SCx200 GPIO")) {
-		printk(KERN_ERR "%s: failed to request %d bytes I/O region for GPIOs.\n",
-		       pci_name(pdev), SCx200_GPIO_SIZE);
-		return -EBUSY;
-	}
-
-	pci_set_drvdata(pdev, &private_base);
-	pci_enable_device(pdev);
-
-	return 0;
-}
-
-static int scx200_deactivate_one_logical(struct logical_dev *ldev)
-{
-	if (ldev->index != LDEV_PRIVATE)
-		return -ENODEV;
-
-	private_base -= 0x10;
-
-	return 0;
-}
-
-static int scx200_find_private_device(struct logical_dev *ldev)
-{
-	struct sc_dev *dev = (struct sc_dev *)ldev->pdev;
-
-	/*
-	 * SCx200/SC1100 has only GPIO in it's private space.
-	 */
-
-	if (strncmp(ldev->name, "GPIO", SC_NAME_LEN)) {
-		printk(KERN_ERR "Logical device %s at private space is not supported in chip %s.\n",
-		       ldev->name, dev->name);
-		return -ENODEV;
-	}
-
-	ldev->base_addr = private_base;
-	private_base += 0x10;
-
-	ldev->read = scx200_gpio_read;
-	ldev->write = scx200_gpio_write;
-	ldev->control = scx200_gpio_control;
-	ldev->activate = scx200_gpio_activate;
-
-	return 0;
-}
-
-static int scx200_activate_one_logical(struct logical_dev *ldev)
-{
-	int err, idx;
-	struct sc_dev *dev = ldev->pdev;
-	u8 active;
-
-	idx = scx200_ldev_index_by_name(ldev->name);
-	if (idx < 0) {
-		printk(KERN_INFO "Chip %s does not have logical device %s at %x.\n",
-		       dev->name, ldev->name, ldev->index);
-		return -ENODEV;
-	}
-
-	if (scx200_logical_devs[idx].id == LDEV_PRIVATE) {
-		err = scx200_find_private_device(ldev);
-		if (err)
-			return err;
-
-		printk(KERN_INFO "\t%16s - found at 0x%lx.\n", 
-				ldev->name, ldev->base_addr);
-	} else {
-		scx200_write_reg(dev, SIO_REG_LDN, ldev->index);
-		active = scx200_read_reg(dev, SIO_REG_ACTIVE);
-		if ((active & SIO_ACTIVE_EN) == 0) {
-			printk(KERN_INFO "\t%16s - not activated at %x: activating... ",
-			       ldev->name, ldev->index);
-
-			scx200_write_reg(dev, SIO_REG_ACTIVE,
-					 active | SIO_ACTIVE_EN);
-			active = scx200_read_reg(dev, SIO_REG_ACTIVE);
-			if ((active & SIO_ACTIVE_EN) == 0) {
-				printk("failed.\n");
-				return -ENODEV;
-			}
-			printk("done.\n");
-		}
-
-		ldev->base_addr = scx200_read_reg(dev, SIO_REG_IO_LSB);
-		ldev->base_addr |= (scx200_read_reg(dev, SIO_REG_IO_MSB) << 8);
-	}
-
-	err = ldev->activate(ldev);
-	if (err < 0) {
-		printk(KERN_INFO "\t%16s - not activated: ->activate() failed with error code %d.\n",
-				ldev->name, err);
-		return -ENODEV;
-	}
-
-	printk(KERN_INFO "\t%16s - activated at %x: 0x%04lx-0x%04lx\n",
-	       ldev->name, ldev->index, ldev->base_addr,
-	       ldev->base_addr + ldev->range);
-
-	return 0;
-}
-
-static int scx200_init(void)
-{
-	int err;
-
-	err = pci_module_init(&scx200_pci_driver);
-	if (err) {
-		printk(KERN_ERR "Failed to register PCI driver for device %s : err=%d.\n",
-		       scx200_pci_driver.name, err);
-		return err;
-	}
-
-	err = sc_add_sc_dev(&scx200_dev);
-	if (err)
-		return err;
-
-	printk(KERN_INFO "Driver for %s SuperIO chip.\n", scx200_dev.name);
-	return 0;
-}
-
-static void scx200_fini(void)
-{
-	sc_del_sc_dev(&scx200_dev);
-
-	while (atomic_read(&scx200_dev.refcnt))
-	{
-		printk(KERN_INFO "Waiting for %s to became free: refcnt=%d.\n",
-				scx200_dev.name, atomic_read(&scx200_dev.refcnt));
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(HZ);
-			
-		if (current->flags & PF_FREEZE)
-			refrigerator(PF_FREEZE);
-
-		if (signal_pending(current))
-			flush_signals(current);
-	}
-
-	pci_unregister_driver(&scx200_pci_driver);
-	if (private_base)
-		release_region(private_base, SCx200_GPIO_SIZE);
-}
-
-module_init(scx200_init);
-module_exit(scx200_fini);
-
-EXPORT_SYMBOL(scx200_write_reg);
-EXPORT_SYMBOL(scx200_read_reg);
--- linux-2.6/drivers/superio/Makefile~	2005-01-24 22:06:15.000000000 +0300
+++ linux-2.6/drivers/superio/Makefile	2005-01-24 22:58:30.000000000 +0300
@@ -6,6 +6,6 @@
 obj-$(CONFIG_SC_GPIO)		+= sc_gpio.o
 obj-$(CONFIG_SC_ACB)		+= sc_acb.o
 obj-$(CONFIG_SC_PC8736X)	+= pc8736x.o
-obj-$(CONFIG_SC_SCX200)		+= scx200.o
+obj-$(CONFIG_SC_SCX200)		+= scx.o
 
 superio-objs		:= sc.o chain.o sc_conn.o
--- linux-2.6/drivers/superio/scx200.h	2005-01-24 22:06:15.000000000 +0300
+++ /dev/null	2004-09-17 14:58:06.000000000 +0400
@@ -1,28 +0,0 @@
-/*
- * 	scx200.h
- * 
- * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
- * All rights reserved.
- * 
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
- */
-
-#ifndef __SCX200_H
-#define __SCX200_H
-
-#define SCx200_GPIO_SIZE 	0x2c
-
-#endif /* __SCX200_H */
--- /dev/null	2004-09-17 14:58:06.000000000 +0400
+++ linux-2.6/drivers/superio/scx.h	2005-01-24 22:06:15.000000000 +0300
@@ -0,0 +1,28 @@
+/*
+ * 	scx.h
+ * 
+ * 2004 Copyright (c) Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+ * All rights reserved.
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#ifndef __SCX200_H
+#define __SCX200_H
+
+#define SCx200_GPIO_SIZE 	0x2c
+
+#endif /* __SCX200_H */


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
