Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265309AbSKFBlR>; Tue, 5 Nov 2002 20:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265474AbSKFBlR>; Tue, 5 Nov 2002 20:41:17 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:18448 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265309AbSKFBkb>;
	Tue, 5 Nov 2002 20:40:31 -0500
Date: Tue, 5 Nov 2002 17:43:04 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] PCI hotplug changes for 2.5.46
Message-ID: <20021106014304.GV18627@kroah.com>
References: <20021106013615.GQ18627@kroah.com> <20021106013708.GR18627@kroah.com> <20021106013741.GS18627@kroah.com> <20021106013835.GT18627@kroah.com> <20021106013915.GU18627@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106013915.GU18627@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.875.1.5, 2002/11/02 23:07:09-08:00, scottm@somanetworks.com

[PATCH] 2.5.45 CompactPCI driver patch 3/4

This is patch 3 of 4 of my CompactPCI hotplug core and
drivers, consisting of the Ziatech ZT5550 hotplug driver.

The hardware banging code in this driver started its life in the PICMG
2.12 driver code that MontaVista released at the end of 2001.


diff -Nru a/CREDITS b/CREDITS
--- a/CREDITS	Tue Nov  5 17:26:11 2002
+++ b/CREDITS	Tue Nov  5 17:26:11 2002
@@ -2223,6 +2223,7 @@
 E: scott@spiteful.org
 D: OPL3-SA2, OPL3-SA3 sound driver
 D: CompactPCI hotplug core
+D: Ziatech ZT5550 CompactPCI hotplug drivers
 S: Toronto, Ontario
 S: Canada
 
diff -Nru a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	Tue Nov  5 17:26:11 2002
+++ b/MAINTAINERS	Tue Nov  5 17:26:11 2002
@@ -324,6 +324,13 @@
 L:	pcihpd-discuss@lists.sourceforge.net
 S:	Supported
 
+COMPACTPCI HOTPLUG ZIATECH ZT5550 DRIVER
+P:	Scott Murray
+M:	scottm@somanetworks.com
+M:	scott@spiteful.org
+L:	pcihpd-discuss@lists.sourceforge.net
+S:	Supported
+
 COMPAQ FIBRE CHANNEL 64-bit/66MHz PCI non-intelligent HBA
 P:	Amy Vanzant-Hodge 
 M:	Amy Vanzant-Hodge (fibrechannel@compaq.com)
diff -Nru a/drivers/hotplug/Kconfig b/drivers/hotplug/Kconfig
--- a/drivers/hotplug/Kconfig	Tue Nov  5 17:26:11 2002
+++ b/drivers/hotplug/Kconfig	Tue Nov  5 17:26:11 2002
@@ -87,5 +87,19 @@
 
 	  When in doubt, say N.
 
+config HOTPLUG_PCI_CPCI_ZT5550
+	tristate "Ziatech ZT5550 CompactPCI Hotplug driver"
+	depends on HOTPLUG_PCI_CPCI && X86
+	help
+	  Say Y here if you have an Performance Technologies (formerly Intel,
+          formerly just Ziatech) Ziatech ZT5550 CompactPCI system card.
+
+	  This code is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module will be called cpcihp_zt5550.o. If you want to compile it
+	  as a module, say M here and read <file:Documentation/modules.txt>.
+
+	  When in doubt, say N.
+
 endmenu
 
diff -Nru a/drivers/hotplug/Makefile b/drivers/hotplug/Makefile
--- a/drivers/hotplug/Makefile	Tue Nov  5 17:26:11 2002
+++ b/drivers/hotplug/Makefile	Tue Nov  5 17:26:11 2002
@@ -9,6 +9,7 @@
 obj-$(CONFIG_HOTPLUG_PCI_IBM)		+= ibmphp.o
 obj-$(CONFIG_HOTPLUG_PCI_ACPI)		+= acpiphp.o
 obj-$(CONFIG_HOTPLUG_PCI_CPCI)		+= cpci_hotplug.o
+obj-$(CONFIG_HOTPLUG_PCI_CPCI_ZT5550)	+= cpcihp_zt5550.o
 
 pci_hotplug-objs	:=	pci_hotplug_core.o	\
 				pci_hotplug_util.o
diff -Nru a/drivers/hotplug/cpcihp_zt5550.c b/drivers/hotplug/cpcihp_zt5550.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/hotplug/cpcihp_zt5550.c	Tue Nov  5 17:26:11 2002
@@ -0,0 +1,306 @@
+/*
+ * cpcihp_zt5550.c
+ *
+ * Intel/Ziatech ZT5550 CompactPCI Host Controller driver
+ *
+ * Copyright 2002 SOMA Networks, Inc.
+ * Copyright 2001 Intel San Luis Obispo
+ * Copyright 2000,2001 MontaVista Software Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY 
+ * AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL 
+ * THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
+ * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
+ * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
+ * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
+ * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to <scottm@somanetworks.com>
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/pci.h>
+#include "cpci_hotplug.h"
+#include "cpcihp_zt5550.h"
+
+#define DRIVER_VERSION	"0.2"
+#define DRIVER_AUTHOR	"Scott Murray <scottm@somanetworks.com>"
+#define DRIVER_DESC	"ZT5550 CompactPCI Hot Plug Driver"
+
+#if !defined(CONFIG_HOTPLUG_PCI_CPCI_ZT5550_MODULE)
+#define MY_NAME	"cpcihp_zt5550"
+#else
+#define MY_NAME	THIS_MODULE->name
+#endif
+
+#define dbg(format, arg...)					\
+	do {							\
+		if(debug)					\
+			printk (KERN_DEBUG "%s: " format "\n",	\
+				MY_NAME , ## arg); 		\
+	} while(0)
+#define err(format, arg...) printk(KERN_ERR "%s: " format "\n", MY_NAME , ## arg)
+#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", MY_NAME , ## arg)
+#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", MY_NAME , ## arg)
+
+/* local variables */
+static int debug;
+static int poll;
+static struct cpci_hp_controller_ops zt5550_hpc_ops;
+static struct cpci_hp_controller zt5550_hpc;
+
+/* Primary cPCI bus bridge device */
+static struct pci_dev *bus0_dev;
+static struct pci_bus *bus0;
+
+/* Host controller device */
+static struct pci_dev *hc_dev;
+
+/* Host controller register addresses */
+static void *hc_registers;
+static void *csr_hc_index;
+static void *csr_hc_data;
+static void *csr_int_status;
+static void *csr_int_mask;
+
+
+static int zt5550_hc_config(struct pci_dev *pdev)
+{
+	/* Since we know that no boards exist with two HC chips, treat it as an error */
+	if(hc_dev) {
+		err("too many host controller devices?");
+		return -EBUSY;
+	}
+	hc_dev = pdev;
+	dbg("hc_dev = %p", hc_dev);
+	dbg("pci resource start %lx", pci_resource_start(hc_dev, 1));
+	dbg("pci resource len %lx", pci_resource_len(hc_dev, 1));
+
+	if(!request_mem_region(pci_resource_start(hc_dev, 1),
+				pci_resource_len(hc_dev, 1), MY_NAME)) {
+		err("cannot reserve MMIO region");
+		return -ENOMEM;
+	}
+
+	hc_registers =
+	    ioremap(pci_resource_start(hc_dev, 1), pci_resource_len(hc_dev, 1));
+	if(!hc_registers) {
+		err("cannot remap MMIO region %lx @ %lx",
+		    pci_resource_len(hc_dev, 1), pci_resource_start(hc_dev, 1));
+		release_mem_region(pci_resource_start(hc_dev, 1),
+				   pci_resource_len(hc_dev, 1));
+		return -ENODEV;
+	}
+
+	csr_hc_index = hc_registers + CSR_HCINDEX;
+	csr_hc_data = hc_registers + CSR_HCDATA;
+	csr_int_status = hc_registers + CSR_INTSTAT;
+	csr_int_mask = hc_registers + CSR_INTMASK;
+
+	/*
+	 * Disable host control, fault and serial interrupts
+	 */
+	dbg("disabling host control, fault and serial interrupts");
+	writeb((u8) HC_INT_MASK_REG, csr_hc_index);
+	writeb((u8) ALL_INDEXED_INTS_MASK, csr_hc_data);
+	dbg("disabled host control, fault and serial interrupts");
+
+	/*
+	 * Disable timer0, timer1 and ENUM interrupts
+	 */
+	dbg("disabling timer0, timer1 and ENUM interrupts");
+	writeb((u8) ALL_DIRECT_INTS_MASK, csr_int_mask);
+	dbg("disabled timer0, timer1 and ENUM interrupts");
+	return 0;
+}
+
+static int zt5550_hc_cleanup(void)
+{
+	if(!hc_dev)
+		return -ENODEV;
+	release_mem_region(pci_resource_start(hc_dev, 1),
+			   pci_resource_len(hc_dev, 1));
+	return 0;
+}
+
+static int zt5550_hc_query_enum(void)
+{
+	u8 value;
+
+	value = inb_p(ENUM_PORT);
+	return ((value & ENUM_MASK) == ENUM_MASK);
+}
+
+static int zt5550_hc_check_irq(void *dev_id)
+{
+	int ret;
+	u8 reg;
+
+	ret = 0;
+	if(dev_id == zt5550_hpc.dev_id) {
+		reg = readb(csr_int_status);
+		if(reg)
+			ret = 1;
+	}
+	return ret;
+}
+
+static int zt5550_hc_enable_irq(void)
+{
+	u8 reg;
+
+	if(hc_dev == NULL) {
+		return -ENODEV;
+	}
+	reg = readb(csr_int_mask);
+	reg = reg & ~ENUM_INT_MASK;
+	writeb(reg, csr_int_mask);
+	return 0;
+}
+
+int zt5550_hc_disable_irq(void)
+{
+	u8 reg;
+
+	if(hc_dev == NULL) {
+		return -ENODEV;
+	}
+
+	reg = readb(csr_int_mask);
+	reg = reg | ENUM_INT_MASK;
+	writeb(reg, csr_int_mask);
+	return 0;
+}
+
+static int __devinit zt5550_hc_init_one (struct pci_dev *pdev,
+					 const struct pci_device_id *ent)
+{
+	int status;
+
+	status = zt5550_hc_config(pdev);
+	if(status != 0) {
+		return status;
+	}
+	dbg("returned from zt5550_hc_config");
+
+	memset(&zt5550_hpc, 0, sizeof (struct cpci_hp_controller));
+	zt5550_hpc_ops.query_enum = zt5550_hc_query_enum;
+	zt5550_hpc.ops = &zt5550_hpc_ops;
+	if(!poll) {
+		zt5550_hpc.irq = hc_dev->irq;
+		zt5550_hpc.irq_flags = SA_SHIRQ;
+		zt5550_hpc.dev_id = hc_dev;
+
+		zt5550_hpc_ops.enable_irq = zt5550_hc_enable_irq;
+		zt5550_hpc_ops.disable_irq = zt5550_hc_disable_irq;
+		zt5550_hpc_ops.check_irq = zt5550_hc_check_irq;
+	} else {
+		info("using ENUM# polling mode");
+	}
+
+	status = cpci_hp_register_controller(&zt5550_hpc);
+	if(status != 0) {
+		err("could not register cPCI hotplug controller");
+		goto init_hc_error;
+	}
+	dbg("registered controller");
+
+	/* Look for first device matching cPCI bus's bridge vendor and device IDs */
+	if(!(bus0_dev = pci_find_device(PCI_VENDOR_ID_DEC,
+					 PCI_DEVICE_ID_DEC_21154, NULL))) {
+		status = -ENODEV;
+		goto init_register_error;
+	}
+	bus0 = bus0_dev->subordinate;
+
+	status = cpci_hp_register_bus(bus0, 0x0a, 0x0f);
+	if(status != 0) {
+		err("could not register cPCI hotplug bus");
+		goto init_register_error;
+	}
+	dbg("registered bus");
+
+	status = cpci_hp_start();
+	if(status != 0) {
+		err("could not started cPCI hotplug system");
+		cpci_hp_unregister_bus(bus0);
+		goto init_register_error;
+	}
+	dbg("started cpci hp system");
+
+	return 0;
+init_register_error:
+	cpci_hp_unregister_controller(&zt5550_hpc);
+init_hc_error:
+	err("status = %d", status);
+	zt5550_hc_cleanup();
+	return status;
+
+}
+
+static void __devexit zt5550_hc_remove_one(struct pci_dev *pdev)
+{
+	cpci_hp_stop();
+	cpci_hp_unregister_bus(bus0);
+	cpci_hp_unregister_controller(&zt5550_hpc);
+	zt5550_hc_cleanup();
+}
+
+
+static struct pci_device_id zt5550_hc_pci_tbl[] __devinitdata = {
+	{ PCI_VENDOR_ID_ZIATECH, PCI_DEVICE_ID_ZIATECH_5550_HC, PCI_ANY_ID, PCI_ANY_ID, },
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, zt5550_hc_pci_tbl);
+	
+static struct pci_driver zt5550_hc_driver = {
+	.name		= "zt5550_hc",
+	.id_table	= zt5550_hc_pci_tbl,
+	.probe		= zt5550_hc_init_one,
+	.remove		= __devexit_p(zt5550_hc_remove_one),
+};
+
+static int __init zt5550_init(void)
+{
+	struct resource* r;
+
+	info(DRIVER_DESC " version: " DRIVER_VERSION);
+	r = request_region(ENUM_PORT, 1, "#ENUM hotswap signal register");
+	if(!r)
+		return -EBUSY;
+
+	return pci_module_init(&zt5550_hc_driver);
+}
+
+static void __exit
+zt5550_exit(void)
+{
+	pci_unregister_driver(&zt5550_hc_driver);
+	release_region(ENUM_PORT, 1);
+}
+
+module_init(zt5550_init);
+module_exit(zt5550_exit);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
+MODULE_PARM(debug, "i");
+MODULE_PARM_DESC(debug, "Debugging mode enabled or not");
+MODULE_PARM(poll, "i");
+MODULE_PARM_DESC(poll, "#ENUM polling mode enabled or not");
diff -Nru a/drivers/hotplug/cpcihp_zt5550.h b/drivers/hotplug/cpcihp_zt5550.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/hotplug/cpcihp_zt5550.h	Tue Nov  5 17:26:11 2002
@@ -0,0 +1,79 @@
+/*
+ * cpcihp_zt5550.h
+ *
+ * Intel/Ziatech ZT5550 CompactPCI Host Controller driver definitions
+ *
+ * Copyright 2002 SOMA Networks, Inc.
+ * Copyright 2001 Intel San Luis Obispo
+ * Copyright 2000,2001 MontaVista Software Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY 
+ * AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL 
+ * THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
+ * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
+ * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
+ * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
+ * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to <scottm@somanetworks.com>
+ */
+
+#ifndef _CPCIHP_ZT5550_H
+#define _CPCIHP_ZT5550_H
+
+/* Direct registers */
+#define CSR_HCINDEX		0x00
+#define CSR_HCDATA		0x04
+#define CSR_INTSTAT		0x08
+#define CSR_INTMASK		0x09
+#define CSR_CNT0CMD		0x0C
+#define CSR_CNT1CMD		0x0E
+#define CSR_CNT0		0x10
+#define CSR_CNT1		0x14
+
+/* Masks for interrupt bits in CSR_INTMASK direct register */
+#define CNT0_INT_MASK		0x01
+#define CNT1_INT_MASK		0x02
+#define ENUM_INT_MASK		0x04
+#define ALL_DIRECT_INTS_MASK	0x07
+
+/* Indexed registers (through CSR_INDEX, CSR_DATA) */
+#define HC_INT_MASK_REG		0x04
+#define HC_STATUS_REG		0x08
+#define HC_CMD_REG		0x0C
+#define ARB_CONFIG_GNT_REG	0x10
+#define ARB_CONFIG_CFG_REG	0x12
+#define ARB_CONFIG_REG	 	0x10
+#define ISOL_CONFIG_REG		0x18
+#define FAULT_STATUS_REG	0x20
+#define FAULT_CONFIG_REG	0x24
+#define WD_CONFIG_REG		0x2C
+#define HC_DIAG_REG		0x30
+#define SERIAL_COMM_REG		0x34
+#define SERIAL_OUT_REG		0x38
+#define SERIAL_IN_REG		0x3C
+
+/* Masks for interrupt bits in HC_INT_MASK_REG indexed register */
+#define SERIAL_INT_MASK		0x01
+#define FAULT_INT_MASK		0x02
+#define HCF_INT_MASK		0x04
+#define ALL_INDEXED_INTS_MASK	0x07
+
+/* Digital I/O port storing ENUM# */
+#define ENUM_PORT	0xE1
+/* Mask to get to the ENUM# bit on the bus */
+#define ENUM_MASK	0x40
+
+#endif				/* _CPCIHP_ZT5550_H */
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Tue Nov  5 17:26:11 2002
+++ b/include/linux/pci_ids.h	Tue Nov  5 17:26:11 2002
@@ -1100,6 +1100,9 @@
 #define PCI_DEVICE_ID_EICON_MAESTRAQ	0xe012
 #define PCI_DEVICE_ID_EICON_MAESTRAQ_U	0xe013
 #define PCI_DEVICE_ID_EICON_MAESTRAP	0xe014
+
+#define PCI_VENDOR_ID_ZIATECH		0x1138
+#define PCI_DEVICE_ID_ZIATECH_5550_HC	0x5550
  
 #define PCI_VENDOR_ID_CYCLONE		0x113c
 #define PCI_DEVICE_ID_CYCLONE_SDK	0x0001
