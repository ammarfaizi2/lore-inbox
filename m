Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280856AbRKGQaa>; Wed, 7 Nov 2001 11:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280844AbRKGQaX>; Wed, 7 Nov 2001 11:30:23 -0500
Received: from galba.tp1.ruhr-uni-bochum.de ([134.147.240.75]:58642 "EHLO
	galba.tp1.ruhr-uni-bochum.de") by vger.kernel.org with ESMTP
	id <S280851AbRKGQ35>; Wed, 7 Nov 2001 11:29:57 -0500
Date: Wed, 7 Nov 2001 17:29:55 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PCI like interface for ISAPnP
Message-ID: <Pine.LNX.4.33.0111071727130.13350-100000@chaos.tp1.ruhr-uni-bochum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2001, Alan Cox wrote:

> > So the question is: Should I provide a generic isapnp_{,un}register_driver 
> > framework (it's pretty simple anyway), or keep things private to my 
> > driver?
> 
> Please do - I added one for pnpbios and for 2.5 we need a generic layer
> for all cases.

Okay, here it is - generic part and also a new ISDN driver for the 
Fritz!PCI v2 / Fritz!PnP which uses the new interface.

(Applies to current vanilla and -ac)

--Kai


diff -urN linux-2.4.14.1/drivers/pnp/isapnp.c linux-2.4.14.2/drivers/pnp/isapnp.c
--- linux-2.4.14.1/drivers/pnp/isapnp.c	Wed Oct 24 22:51:43 2001
+++ linux-2.4.14.2/drivers/pnp/isapnp.c	Wed Nov  7 16:48:09 2001
@@ -25,6 +25,9 @@
  *  2001-06-03  Added release_region calls to correspond with
  *		request_region calls when a failure occurs.  Also
  *		added KERN_* constants to printk() calls.
+ *  2001-11-07  Added isapnp_{,un}register_driver calls along the lines
+ *              of the pci driver interface
+ *              Kai Germaschewski <kai.germaschewski@gmx.de>
  */
 
 #include <linux/config.h>
@@ -2162,6 +2165,89 @@
 #endif
 }
 
+static int isapnp_announce_device(struct isapnp_driver *drv, 
+				  struct pci_dev *dev)
+{
+	const struct isapnp_device_id *id;
+	int ret = 0;
+
+	if (drv->id_table) {
+		id = isapnp_match_dev(drv->id_table, dev);
+		if (!id) {
+			ret = 0;
+			goto out;
+		}
+	} else
+		id = NULL;
+
+	if (drv->probe(dev, id) >= 0) {
+		dev->driver = (struct pci_driver *) drv;
+		ret = 1;
+	}
+out:
+	return ret;
+}
+
+/**
+ * isapnp_dev_driver - get the isapnp_driver of a device
+ * @dev: the device to query
+ *
+ * Returns the appropriate isapnp_driver structure or %NULL if there is no 
+ * registered driver for the device.
+ */
+static struct isapnp_driver *isapnp_dev_driver(const struct pci_dev *dev)
+{
+	return (struct isapnp_driver *) dev->driver;
+}
+
+static LIST_HEAD(isapnp_drivers);
+
+/**
+ * isapnp_register_driver - register a new ISAPnP driver
+ * @drv: the driver structure to register
+ * 
+ * Adds the driver structure to the list of registered ISAPnP drivers
+ * Returns the number of isapnp devices which were claimed by the driver
+ * during registration.  The driver remains registered even if the
+ * return value is zero.
+ */
+int isapnp_register_driver(struct isapnp_driver *drv)
+{
+	struct pci_dev *dev;
+	int count = 0;
+
+	list_add_tail(&drv->node, &isapnp_drivers);
+
+	isapnp_for_each_dev(dev) {
+		if (!isapnp_dev_driver(dev))
+			count += isapnp_announce_device(drv, dev);
+	}
+	return count;
+}
+
+/**
+ * isapnp_unregister_driver - unregister an isapnp driver
+ * @drv: the driver structure to unregister
+ * 
+ * Deletes the driver structure from the list of registered ISAPnP drivers,
+ * gives it a chance to clean up by calling its remove() function for
+ * each device it was responsible for, and marks those devices as
+ * driverless.
+ */
+void isapnp_unregister_driver(struct isapnp_driver *drv)
+{
+	struct pci_dev *dev;
+
+	list_del(&drv->node);
+	isapnp_for_each_dev(dev) {
+		if (dev->driver == (struct pci_driver *) drv) {
+			if (drv->remove)
+				drv->remove(dev);
+			dev->driver = NULL;
+		}
+	}
+}
+
 EXPORT_SYMBOL(isapnp_cards);
 EXPORT_SYMBOL(isapnp_devices);
 EXPORT_SYMBOL(isapnp_present);
@@ -2183,6 +2269,8 @@
 EXPORT_SYMBOL(isapnp_probe_devs);
 EXPORT_SYMBOL(isapnp_activate_dev);
 EXPORT_SYMBOL(isapnp_resource_change);
+EXPORT_SYMBOL(isapnp_register_driver);
+EXPORT_SYMBOL(isapnp_unregister_driver);
 
 int __init isapnp_init(void)
 {
diff -urN linux-2.4.14.1/include/linux/isapnp.h linux-2.4.14.2/include/linux/isapnp.h
--- linux-2.4.14.1/include/linux/isapnp.h	Wed Nov  7 15:55:48 2001
+++ linux-2.4.14.2/include/linux/isapnp.h	Wed Nov  7 16:48:09 2001
@@ -162,6 +162,14 @@
 	unsigned long driver_data;	/* data private to the driver */
 };
 
+struct isapnp_driver {
+	struct list_head node;
+	char *name;
+	const struct isapnp_device_id *id_table;	/* NULL if wants all devices */
+	int  (*probe)  (struct pci_dev *dev, const struct isapnp_device_id *id);	/* New device inserted */
+	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
+};
+
 #if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MODULE))
 
 #define __ISAPNP__
@@ -214,6 +222,9 @@
 #define isapnp_for_each_dev(dev) \
 	for(dev = pci_dev_g(isapnp_devices.next); dev != pci_dev_g(&isapnp_devices); dev = pci_dev_g(dev->global_list.next))
 
+int isapnp_register_driver(struct isapnp_driver *drv);
+void isapnp_unregister_driver(struct isapnp_driver *drv);
+
 #else /* !CONFIG_ISAPNP */
 
 /* lowlevel configuration */
@@ -248,6 +259,10 @@
 					  unsigned long start,
 					  unsigned long size) { ; }
 static inline int isapnp_activate_dev(struct pci_dev *dev, const char *name) { return -ENODEV; }
+
+static inline int isapnp_register_driver(struct isapnp_driver *drv) { return 0; }
+
+static inline void isapnp_unregister_driver(struct isapnp_driver *drv) { }
 
 #endif /* CONFIG_ISAPNP */
 
diff -urN linux-2.4.14.1/drivers/isdn/Config.in linux-2.4.14.2/drivers/isdn/Config.in
--- linux-2.4.14.1/drivers/isdn/Config.in	Tue Sep 25 13:44:21 2001
+++ linux-2.4.14.2/drivers/isdn/Config.in	Wed Nov  7 16:48:09 2001
@@ -81,6 +81,7 @@
    dep_tristate 'Sedlbauer PCMCIA cards' CONFIG_HISAX_SEDLBAUER_CS $CONFIG_PCMCIA
    dep_tristate 'ELSA PCMCIA MicroLink cards' CONFIG_HISAX_ELSA_CS $CONFIG_PCMCIA
    dep_tristate 'ST5481 USB ISDN modem (EXPERIMENTAL)' CONFIG_HISAX_ST5481 $CONFIG_HISAX $CONFIG_USB $CONFIG_EXPERIMENTAL
+   dep_tristate 'Fritz!PCIv2 support (EXPERIMENTAL)' CONFIG_HISAX_FRITZ_PCIPNP $CONFIG_HISAX $CONFIG_EXPERIMENTAL
 fi
 endmenu
 
diff -urN linux-2.4.14.1/drivers/isdn/hisax/Makefile linux-2.4.14.2/drivers/isdn/hisax/Makefile
--- linux-2.4.14.1/drivers/isdn/hisax/Makefile	Tue Sep 25 13:44:21 2001
+++ linux-2.4.14.2/drivers/isdn/hisax/Makefile	Wed Nov  7 16:48:09 2001
@@ -6,7 +6,7 @@
 
 # Objects that export symbols.
 
-export-objs	  := config.o fsm.o
+export-objs	  := config.o fsm.o hisax_isac.o
 
 # Multipart objects.
 
@@ -58,6 +58,7 @@
 obj-$(CONFIG_HISAX_SEDLBAUER_CS)	+= sedlbauer_cs.o
 obj-$(CONFIG_HISAX_ELSA_CS)		+= elsa_cs.o
 obj-$(CONFIG_HISAX_ST5481)		+= hisax_st5481.o
+obj-$(CONFIG_HISAX_FRITZ_PCIPNP)        += hisax_fcpcipnp.o hisax_isac.o
 
 CERT := $(shell md5sum -c md5sums.asc >> /dev/null;echo $$?)
 CFLAGS_cert.o := -DCERTIFICATION=$(CERT)
diff -urN linux-2.4.14.1/drivers/isdn/hisax/hisax_fcpcipnp.c linux-2.4.14.2/drivers/isdn/hisax/hisax_fcpcipnp.c
--- linux-2.4.14.1/drivers/isdn/hisax/hisax_fcpcipnp.c	Thu Jan  1 01:00:00 1970
+++ linux-2.4.14.2/drivers/isdn/hisax/hisax_fcpcipnp.c	Wed Nov  7 16:48:43 2001
@@ -0,0 +1,1008 @@
+/*
+ * Driver for AVM Fritz!PCI, Fritz!PCI v2, Fritz!PnP ISDN cards
+ *
+ * Author       Kai Germaschewski
+ * Copyright    2001 by Kai Germaschewski  <kai.germaschewski@gmx.de>
+ *              2001 by Karsten Keil       <keil@isdn4linux.de>
+ * 
+ * based upon Karsten Keil's original avm_pci.c driver
+ *
+ * This software may be used and distributed according to the terms
+ * of the GNU General Public License, incorporated herein by reference.
+ *
+ * Thanks to Wizard Computersysteme GmbH, Bremervoerde and
+ *           SoHaNet Technology GmbH, Berlin
+ * for supporting the development of this driver
+ */
+
+
+/* TODO:
+ *
+ * o POWER PC
+ * o clean up debugging
+ */
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/isapnp.h>
+#include <linux/kmod.h>
+#include <linux/slab.h>
+#include <linux/skbuff.h>
+#include <linux/netdevice.h>
+#include "hisax_fcpcipnp.h"
+#include "hisax_isac.h"
+
+// debugging cruft
+#define __debug_variable debug
+#include "hisax_debug.h"
+
+#ifdef CONFIG_HISAX_DEBUG
+static int debug = 0;
+MODULE_PARM(debug, "i");
+#endif
+
+MODULE_AUTHOR("Kai Germaschewski <kai.germaschewski@gmx.de>");
+MODULE_DESCRIPTION("AVM Fritz!PCI/PnP ISDN driver");
+
+#ifndef PCI_DEVICE_ID_AVM_A1_V2
+#define PCI_DEVICE_ID_AVM_A1_V2 0x0e00
+#endif
+
+static struct pci_device_id fcpci_ids[] __initdata = {
+	{ PCI_VENDOR_ID_AVM, PCI_DEVICE_ID_AVM_A1   , PCI_ANY_ID, PCI_ANY_ID,
+	  0, 0, (unsigned long) "Fritz!Card PCI" },
+	{ PCI_VENDOR_ID_AVM, PCI_DEVICE_ID_AVM_A1_V2, PCI_ANY_ID, PCI_ANY_ID,
+	  0, 0, (unsigned long) "Fritz!Card PCI v2" },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, fcpci_ids);
+
+static struct isapnp_device_id fcpnp_ids[] __initdata = {
+	{ ISAPNP_VENDOR('A', 'V', 'M'), ISAPNP_FUNCTION(0x0900),
+	  ISAPNP_VENDOR('A', 'V', 'M'), ISAPNP_FUNCTION(0x0900), 
+	  (unsigned long) "Fritz!Card PnP" },
+	{ }
+};
+MODULE_DEVICE_TABLE(isapnp, fcpnp_ids);
+
+static int protocol = 2;       /* EURO-ISDN Default */
+MODULE_PARM(protocol, "i");
+
+static LIST_HEAD(adapter_list);
+
+// ----------------------------------------------------------------------
+
+#define  AVM_INDEX              0x04
+#define  AVM_DATA               0x10
+
+#define	 AVM_IDX_HDLC_1		0x00
+#define	 AVM_IDX_HDLC_2		0x01
+#define	 AVM_IDX_ISAC_FIFO	0x02
+#define	 AVM_IDX_ISAC_REG_LOW	0x04
+#define	 AVM_IDX_ISAC_REG_HIGH	0x06
+
+#define  AVM_STATUS0            0x02
+
+#define  AVM_STATUS0_IRQ_ISAC	0x01
+#define  AVM_STATUS0_IRQ_HDLC	0x02
+#define  AVM_STATUS0_IRQ_TIMER	0x04
+#define  AVM_STATUS0_IRQ_MASK	0x07
+
+#define  AVM_STATUS0_RESET	0x01
+#define  AVM_STATUS0_DIS_TIMER	0x02
+#define  AVM_STATUS0_RES_TIMER	0x04
+#define  AVM_STATUS0_ENA_IRQ	0x08
+#define  AVM_STATUS0_TESTBIT	0x10
+
+#define  AVM_STATUS1            0x03
+#define  AVM_STATUS1_ENA_IOM	0x80
+
+#define  HDLC_FIFO		0x0
+#define  HDLC_STATUS		0x4
+#define  HDLC_CTRL		0x4
+
+#define  HDLC_MODE_ITF_FLG	0x01
+#define  HDLC_MODE_TRANS	0x02
+#define  HDLC_MODE_CCR_7	0x04
+#define  HDLC_MODE_CCR_16	0x08
+#define  HDLC_MODE_TESTLOOP	0x80
+
+#define  HDLC_INT_XPR		0x80
+#define  HDLC_INT_XDU		0x40
+#define  HDLC_INT_RPR		0x20
+#define  HDLC_INT_MASK		0xE0
+
+#define  HDLC_STAT_RME		0x01
+#define  HDLC_STAT_RDO		0x10
+#define  HDLC_STAT_CRCVFRRAB	0x0E
+#define  HDLC_STAT_CRCVFR	0x06
+#define  HDLC_STAT_RML_MASK	0x3f00
+
+#define  HDLC_CMD_XRS		0x80
+#define  HDLC_CMD_XME		0x01
+#define  HDLC_CMD_RRS		0x20
+#define  HDLC_CMD_XML_MASK	0x3f00
+
+#define  AVM_HDLC_FIFO_1        0x10
+#define  AVM_HDLC_FIFO_2        0x18
+
+#define  AVM_HDLC_STATUS_1      0x14
+#define  AVM_HDLC_STATUS_2      0x1c
+
+#define  AVM_ISACSX_INDEX       0x04
+#define  AVM_ISACSX_DATA        0x08
+
+// ----------------------------------------------------------------------
+// Fritz!PCI
+
+static unsigned char fcpci_read_isac(struct isac *isac, unsigned char offset)
+{
+	struct fritz_adapter *adapter = isac->priv;
+	unsigned char idx = (offset > 0x2f) ? 
+		AVM_IDX_ISAC_REG_HIGH : AVM_IDX_ISAC_REG_LOW;
+	unsigned char val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&adapter->hw_lock, flags);
+	outb(idx, adapter->io + AVM_INDEX);
+	val = inb(adapter->io + AVM_DATA + (offset & 0xf));
+ 	spin_unlock_irqrestore(&adapter->hw_lock, flags);
+	DBG(0x1000, __FUNCTION__ " port %#x, value %#x",
+	    offset, val);
+	return val;
+}
+
+static void fcpci_write_isac(struct isac *isac, unsigned char offset,
+			     unsigned char value)
+{
+	struct fritz_adapter *adapter = isac->priv;
+	unsigned char idx = (offset > 0x2f) ? 
+		AVM_IDX_ISAC_REG_HIGH : AVM_IDX_ISAC_REG_LOW;
+	unsigned long flags;
+
+	DBG(0x1000, __FUNCTION__ " port %#x, value %#x",
+	    offset, value);
+	spin_lock_irqsave(&adapter->hw_lock, flags);
+	outb(idx, adapter->io + AVM_INDEX);
+	outb(value, adapter->io + AVM_DATA + (offset & 0xf));
+ 	spin_unlock_irqrestore(&adapter->hw_lock, flags);
+}
+
+static void fcpci_read_isac_fifo(struct isac *isac, unsigned char * data, 
+				 int size)
+{
+	struct fritz_adapter *adapter = isac->priv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&adapter->hw_lock, flags);
+	outb(AVM_IDX_ISAC_FIFO, adapter->io + AVM_INDEX);
+	insb(adapter->io + AVM_DATA, data, size);
+ 	spin_unlock_irqrestore(&adapter->hw_lock, flags);
+}
+
+static void fcpci_write_isac_fifo(struct isac *isac, unsigned char * data, 
+				  int size)
+{
+	struct fritz_adapter *adapter = isac->priv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&adapter->hw_lock, flags);
+	outb(AVM_IDX_ISAC_FIFO, adapter->io + AVM_INDEX);
+	outsb(adapter->io + AVM_DATA, data, size);
+ 	spin_unlock_irqrestore(&adapter->hw_lock, flags);
+}
+
+static u32 fcpci_read_hdlc_status(struct fritz_adapter *adapter, int nr)
+{
+	u32 val;
+	int idx = nr ? AVM_IDX_HDLC_2 : AVM_IDX_HDLC_1;
+	unsigned long flags;
+
+	spin_lock_irqsave(&adapter->hw_lock, flags);
+	outl(idx, adapter->io + AVM_INDEX);
+	val = inl(adapter->io + AVM_DATA + HDLC_STATUS);
+	spin_unlock_irqrestore(&adapter->hw_lock, flags);
+	return val;
+}
+
+static void __fcpci_write_ctrl(struct fritz_bcs *bcs, int which)
+{
+	struct fritz_adapter *adapter = bcs->adapter;
+	int idx = bcs->channel ? AVM_IDX_HDLC_2 : AVM_IDX_HDLC_1;
+
+	DBG(0x40, "hdlc %c wr%x ctrl %x",
+	    'A' + bcs->channel, which, bcs->ctrl.ctrl);
+
+	outl(idx, adapter->io + AVM_INDEX);
+	outl(bcs->ctrl.ctrl, adapter->io + AVM_DATA + HDLC_CTRL);
+}
+
+static void fcpci_write_ctrl(struct fritz_bcs *bcs, int which)
+{
+	struct fritz_adapter *adapter = bcs->adapter;
+	unsigned long flags;
+
+	spin_lock_irqsave(&adapter->hw_lock, flags);
+	__fcpci_write_ctrl(bcs, which);
+	spin_unlock_irqrestore(&adapter->hw_lock, flags);
+}
+
+// ----------------------------------------------------------------------
+// Fritz!PCI v2
+
+static unsigned char fcpci2_read_isac(struct isac *isac, unsigned char offset)
+{
+	struct fritz_adapter *adapter = isac->priv;
+	unsigned char val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&adapter->hw_lock, flags);
+	outl(offset, adapter->io + AVM_ISACSX_INDEX);
+	val = inl(adapter->io + AVM_ISACSX_DATA);
+ 	spin_unlock_irqrestore(&adapter->hw_lock, flags);
+	DBG(0x1000, __FUNCTION__ " port %#x, value %#x",
+	    offset, val);
+
+	return val;
+}
+
+static void fcpci2_write_isac(struct isac *isac, unsigned char offset, 
+			      unsigned char value)
+{
+	struct fritz_adapter *adapter = isac->priv;
+	unsigned long flags;
+
+	DBG(0x1000, __FUNCTION__ " port %#x, value %#x",
+	    offset, value);
+	spin_lock_irqsave(&adapter->hw_lock, flags);
+	outl(offset, adapter->io + AVM_ISACSX_INDEX);
+	outl(value, adapter->io + AVM_ISACSX_DATA);
+ 	spin_unlock_irqrestore(&adapter->hw_lock, flags);
+}
+
+static void fcpci2_read_isac_fifo(struct isac *isac, unsigned char * data, 
+				  int size)
+{
+	struct fritz_adapter *adapter = isac->priv;
+	int i;
+	unsigned long flags;
+
+	spin_lock_irqsave(&adapter->hw_lock, flags);
+	outl(0, adapter->io + AVM_ISACSX_INDEX);
+	for (i = 0; i < size; i++)
+		data[i] = inl(adapter->io + AVM_ISACSX_DATA);
+ 	spin_unlock_irqrestore(&adapter->hw_lock, flags);
+}
+
+static void fcpci2_write_isac_fifo(struct isac *isac, unsigned char * data, 
+				   int size)
+{
+	struct fritz_adapter *adapter = isac->priv;
+	int i;
+	unsigned long flags;
+
+	spin_lock_irqsave(&adapter->hw_lock, flags);
+	outl(0, adapter->io + AVM_ISACSX_INDEX);
+	for (i = 0; i < size; i++)
+		outl(data[i], adapter->io + AVM_ISACSX_DATA);
+ 	spin_unlock_irqrestore(&adapter->hw_lock, flags);
+}
+
+static u32 fcpci2_read_hdlc_status(struct fritz_adapter *adapter, int nr)
+{
+	int offset = nr ? AVM_HDLC_STATUS_2 : AVM_HDLC_STATUS_1;
+
+	return inl(adapter->io + offset);
+}
+
+static void fcpci2_write_ctrl(struct fritz_bcs *bcs, int which)
+{
+	struct fritz_adapter *adapter = bcs->adapter;
+	int offset = bcs->channel ? AVM_HDLC_STATUS_2 : AVM_HDLC_STATUS_1;
+
+	DBG(0x40, "hdlc %c wr%x ctrl %x",
+	    'A' + bcs->channel, which, bcs->ctrl.ctrl);
+
+	outl(bcs->ctrl.ctrl, adapter->io + offset);
+}
+
+// ----------------------------------------------------------------------
+// Fritz!PnP (ISAC access as for Fritz!PCI)
+
+static u32 fcpnp_read_hdlc_status(struct fritz_adapter *adapter, int nr)
+{
+	unsigned char idx = nr ? AVM_IDX_HDLC_2 : AVM_IDX_HDLC_1;
+	u32 val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&adapter->hw_lock, flags);
+	outb(idx, adapter->io + AVM_INDEX);
+	val = inb(adapter->io + AVM_DATA + HDLC_STATUS);
+	if (val & HDLC_INT_RPR)
+		val |= inb(adapter->io + AVM_DATA + HDLC_STATUS + 1) << 8;
+	spin_unlock_irqrestore(&adapter->hw_lock, flags);
+	return val;
+}
+
+static void __fcpnp_write_ctrl(struct fritz_bcs *bcs, int which)
+{
+	struct fritz_adapter *adapter = bcs->adapter;
+	unsigned char idx = bcs->channel ? AVM_IDX_HDLC_2 : AVM_IDX_HDLC_1;
+
+	DBG(0x40, "hdlc %c wr%x ctrl %x",
+	    'A' + bcs->channel, which, bcs->ctrl.ctrl);
+
+	outb(idx, adapter->io + AVM_INDEX);
+	if (which & 4)
+		outb(bcs->ctrl.sr.mode, 
+		     adapter->io + AVM_DATA + HDLC_STATUS + 2);
+	if (which & 2)
+		outb(bcs->ctrl.sr.xml, 
+		     adapter->io + AVM_DATA + HDLC_STATUS + 1);
+	if (which & 1)
+		outb(bcs->ctrl.sr.cmd,
+		     adapter->io + AVM_DATA + HDLC_STATUS + 0);
+}
+
+static void fcpnp_write_ctrl(struct fritz_bcs *bcs, int which)
+{
+	struct fritz_adapter *adapter = bcs->adapter;
+	unsigned long flags;
+
+	spin_lock_irqsave(&adapter->hw_lock, flags);
+	__fcpnp_write_ctrl(bcs, which);
+	spin_unlock_irqrestore(&adapter->hw_lock, flags);
+}
+
+// ----------------------------------------------------------------------
+
+static inline void B_L1L2(struct fritz_bcs *bcs, int pr, void *arg)
+{
+	struct hisax_if *ifc = (struct hisax_if *) &bcs->b_if;
+
+	DBG(2, "pr %#x", pr);
+	ifc->l1l2(ifc, pr, arg);
+}
+
+static void hdlc_fill_fifo(struct fritz_bcs *bcs)
+{
+	struct fritz_adapter *adapter = bcs->adapter;
+	struct sk_buff *skb = bcs->tx_skb;
+	int count;
+	int fifo_size = 32;
+	unsigned long flags;
+	unsigned char *p;
+
+	DBG(0x40, "hdlc_fill_fifo");
+
+	if (!skb)
+		BUG();
+
+	if (skb->len == 0)
+		BUG();
+
+	bcs->ctrl.sr.cmd &= ~HDLC_CMD_XME;
+	if (bcs->tx_skb->len > fifo_size) {
+		count = fifo_size;
+	} else {
+		count = bcs->tx_skb->len;
+		if (bcs->mode != L1_MODE_TRANS)
+			bcs->ctrl.sr.cmd |= HDLC_CMD_XME;
+	}
+	DBG(0x40, "hdlc_fill_fifo %d/%d", count, bcs->tx_skb->len);
+	p = bcs->tx_skb->data;
+	skb_pull(bcs->tx_skb, count);
+	bcs->tx_cnt += count;
+	bcs->ctrl.sr.xml = ((count == fifo_size) ? 0 : count);
+
+	switch (adapter->type) {
+	case AVM_FRITZ_PCI:
+		spin_lock_irqsave(&adapter->hw_lock, flags);
+		// sets the correct AVM_INDEX, too
+		__fcpci_write_ctrl(bcs, 3);
+		outsl(adapter->io + AVM_DATA + HDLC_FIFO,
+		      p, (count + 3) / 4);
+		spin_unlock_irqrestore(&adapter->hw_lock, flags);
+		break;
+	case AVM_FRITZ_PCIV2:
+		fcpci2_write_ctrl(bcs, 3);
+		outsl(adapter->io + 
+		      (bcs->channel ? AVM_HDLC_FIFO_2 : AVM_HDLC_FIFO_1),
+		      p, (count + 3) / 4);
+		break;
+	case AVM_FRITZ_PNP:
+		spin_lock_irqsave(&adapter->hw_lock, flags);
+		// sets the correct AVM_INDEX, too
+		__fcpnp_write_ctrl(bcs, 3);
+		outsb(adapter->io + AVM_DATA, p, count);
+		spin_unlock_irqrestore(&adapter->hw_lock, flags);
+		break;
+	}
+}
+
+static inline void hdlc_empty_fifo(struct fritz_bcs *bcs, int count)
+{
+	struct fritz_adapter *adapter = bcs->adapter;
+	unsigned char *p;
+	unsigned char idx = bcs->channel ? AVM_IDX_HDLC_2 : AVM_IDX_HDLC_1;
+
+	DBG(0x10, "hdlc_empty_fifo %d", count);
+	if (bcs->rcvidx + count > HSCX_BUFMAX) {
+		DBG(0x10, "hdlc_empty_fifo: incoming packet too large");
+		return;
+	}
+	p = bcs->rcvbuf + bcs->rcvidx;
+	bcs->rcvidx += count;
+	switch (adapter->type) {
+	case AVM_FRITZ_PCI:
+		spin_lock(&adapter->hw_lock);
+		outl(idx, adapter->io + AVM_INDEX);
+		insl(adapter->io + AVM_DATA + HDLC_FIFO, 
+		     p, (count + 3) / 4);
+		spin_unlock(&adapter->hw_lock);
+		break;
+	case AVM_FRITZ_PCIV2:
+		insl(adapter->io + 
+		     (bcs->channel ? AVM_HDLC_FIFO_2 : AVM_HDLC_FIFO_1),
+		     p, (count + 3) / 4);
+		break;
+	case AVM_FRITZ_PNP:
+		spin_lock(&adapter->hw_lock);
+		outb(idx, adapter->io + AVM_INDEX);
+		insb(adapter->io + AVM_DATA, p, count);
+		spin_unlock(&adapter->hw_lock);
+		break;
+	}
+}
+
+static inline void hdlc_rpr_irq(struct fritz_bcs *bcs, u32 stat)
+{
+	struct fritz_adapter *adapter = bcs->adapter;
+	struct sk_buff *skb;
+	int len;
+
+	if (stat & HDLC_STAT_RDO) {
+		DBG(0x10, "RDO");
+		bcs->ctrl.sr.xml = 0;
+		bcs->ctrl.sr.cmd |= HDLC_CMD_RRS;
+		adapter->write_ctrl(bcs, 1);
+		bcs->ctrl.sr.cmd &= ~HDLC_CMD_RRS;
+		adapter->write_ctrl(bcs, 1);
+		bcs->rcvidx = 0;
+		return;
+	}
+
+	len = (stat & HDLC_STAT_RML_MASK) >> 8;
+	if (len == 0)
+		len = 32;
+
+	hdlc_empty_fifo(bcs, len);
+
+	if ((stat & HDLC_STAT_RME) || (bcs->mode == L1_MODE_TRANS)) {
+		if (((stat & HDLC_STAT_CRCVFRRAB)== HDLC_STAT_CRCVFR) ||
+		    (bcs->mode == L1_MODE_TRANS)) {
+			skb = dev_alloc_skb(bcs->rcvidx);
+			if (!skb) {
+				printk(KERN_WARNING "HDLC: receive out of memory\n");
+			} else {
+				memcpy(skb_put(skb, bcs->rcvidx), bcs->rcvbuf,
+				       bcs->rcvidx);
+				DBG_SKB(1, skb);
+				B_L1L2(bcs, PH_DATA | INDICATION, skb);
+			}
+			bcs->rcvidx = 0;
+		} else {
+			DBG(0x10, "ch%d invalid frame %#x",
+			    bcs->channel, stat);
+			bcs->rcvidx = 0;
+		}
+	}
+}
+
+static inline void hdlc_xdu_irq(struct fritz_bcs *bcs)
+{
+	struct fritz_adapter *adapter = bcs->adapter;
+
+	/* Here we lost an TX interrupt, so
+	 * restart transmitting the whole frame.
+	 */
+	bcs->ctrl.sr.xml = 0;
+	bcs->ctrl.sr.cmd |= HDLC_CMD_XRS;
+	adapter->write_ctrl(bcs, 1);
+	bcs->ctrl.sr.cmd &= ~HDLC_CMD_XRS;
+	adapter->write_ctrl(bcs, 1);
+
+	if (!bcs->tx_skb) {
+		DBG(0x10, "XDU without skb");
+		return;
+	}
+	skb_push(bcs->tx_skb, bcs->tx_cnt);
+	bcs->tx_cnt = 0;
+}
+
+static inline void hdlc_xpr_irq(struct fritz_bcs *bcs)
+{
+	struct sk_buff *skb;
+
+	skb = bcs->tx_skb;
+	if (!skb)
+		return;
+
+	if (skb->len) {
+		hdlc_fill_fifo(bcs);
+		return;
+	}
+	bcs->tx_cnt = 0;
+	bcs->tx_skb = NULL;
+	B_L1L2(bcs, PH_DATA | CONFIRM, (void *) skb->truesize);
+	dev_kfree_skb_irq(skb);
+}
+
+static void hdlc_irq(struct fritz_bcs *bcs, u32 stat)
+{
+	DBG(0x10, "ch%d stat %#x", bcs->channel, stat);
+	if (stat & HDLC_INT_RPR) {
+		DBG(0x10, "RPR");
+		hdlc_rpr_irq(bcs, stat);
+	}
+	if (stat & HDLC_INT_XDU) {
+		DBG(0x10, "XDU");
+		hdlc_xdu_irq(bcs);
+	}
+	if (stat & HDLC_INT_XPR) {
+		DBG(0x10, "XPR");
+		hdlc_xpr_irq(bcs);
+	}
+}
+
+static inline void hdlc_interrupt(struct fritz_adapter *adapter)
+{
+	int nr;
+	u32 stat;
+
+	for (nr = 0; nr < 2; nr++) {
+		stat = adapter->read_hdlc_status(adapter, nr);
+		DBG(0x10, "HDLC %c stat %#x", 'A' + nr, stat);
+		if (stat & HDLC_INT_MASK)
+			hdlc_irq(&adapter->bcs[nr], stat);
+	}
+}
+
+static void modehdlc(struct fritz_bcs *bcs, int mode)
+{
+	struct fritz_adapter *adapter = bcs->adapter;
+	
+	DBG(0x40, "hdlc %c mode %d --> %d",
+	    'A' + bcs->channel, bcs->mode, mode);
+
+	if (bcs->mode == mode)
+		return;
+
+	bcs->ctrl.ctrl = 0;
+	bcs->ctrl.sr.cmd  = HDLC_CMD_XRS | HDLC_CMD_RRS;
+	switch (mode) {
+	case L1_MODE_NULL:
+		bcs->ctrl.sr.mode = HDLC_MODE_TRANS;
+		adapter->write_ctrl(bcs, 5);
+		break;
+	case L1_MODE_TRANS:
+		bcs->ctrl.sr.mode = HDLC_MODE_TRANS;
+		adapter->write_ctrl(bcs, 5);
+		bcs->ctrl.sr.cmd = HDLC_CMD_XRS;
+		adapter->write_ctrl(bcs, 1);
+		bcs->ctrl.sr.cmd = 0;
+		break;
+	case L1_MODE_HDLC:
+		bcs->ctrl.sr.mode = HDLC_MODE_ITF_FLG;
+		adapter->write_ctrl(bcs, 5);
+		bcs->ctrl.sr.cmd = HDLC_CMD_XRS;
+		adapter->write_ctrl(bcs, 1);
+		bcs->ctrl.sr.cmd = 0;
+		break;
+	}
+	bcs->mode = mode;
+}
+
+static void fritz_b_l2l1(struct hisax_if *ifc, int pr, void *arg)
+{
+	struct fritz_bcs *bcs = ifc->priv;
+	struct sk_buff *skb = arg;
+	int mode;
+
+	DBG(0x10, "pr %#x", pr);
+
+	switch (pr) {
+	case PH_DATA | REQUEST:
+		if (bcs->tx_skb)
+			BUG();
+		
+		bcs->tx_skb = skb;
+		DBG_SKB(1, skb);
+		hdlc_fill_fifo(bcs);
+		break;
+	case PH_ACTIVATE | REQUEST:
+		mode = (int) arg;
+		DBG(4,"B%d,PH_ACTIVATE_REQUEST %d", bcs->channel + 1, mode);
+		modehdlc(bcs, mode);
+		B_L1L2(bcs, PH_ACTIVATE | INDICATION, NULL);
+		break;
+	case PH_DEACTIVATE | REQUEST:
+		DBG(4,"B%d,PH_DEACTIVATE_REQUEST", bcs->channel + 1);
+		modehdlc(bcs, L1_MODE_NULL);
+		B_L1L2(bcs, PH_DEACTIVATE | INDICATION, NULL);
+		break;
+	}
+}
+
+// ----------------------------------------------------------------------
+
+static void fcpci2_irq(int intno, void *dev, struct pt_regs *regs)
+{
+	struct fritz_adapter *adapter = dev;
+	unsigned char val;
+
+	val = inb(adapter->io + AVM_STATUS0);
+	if (!(val & AVM_STATUS0_IRQ_MASK))
+		/* hopefully a shared  IRQ reqest */
+		return;
+	DBG(2, "STATUS0 %#x", val);
+	if (val & AVM_STATUS0_IRQ_ISAC)
+		isacsx_interrupt(&adapter->isac);
+
+	if (val & AVM_STATUS0_IRQ_HDLC)
+		hdlc_interrupt(adapter);
+}
+
+static void fcpci_irq(int intno, void *dev, struct pt_regs *regs)
+{
+	struct fritz_adapter *adapter = dev;
+	unsigned char sval;
+
+	sval = inb(adapter->io + 2);
+	if ((sval & AVM_STATUS0_IRQ_MASK) == AVM_STATUS0_IRQ_MASK)
+		/* possibly a shared  IRQ reqest */
+		return;
+	DBG(2, "sval %#x", sval);
+	if (!(sval & AVM_STATUS0_IRQ_ISAC))
+		isac_interrupt(&adapter->isac);
+
+	if (!(sval & AVM_STATUS0_IRQ_HDLC))
+		hdlc_interrupt(adapter);
+}
+
+// ----------------------------------------------------------------------
+
+static inline void fcpci2_init(struct fritz_adapter *adapter)
+{
+	outb(AVM_STATUS0_RES_TIMER, adapter->io + AVM_STATUS0);
+	outb(AVM_STATUS0_ENA_IRQ, adapter->io + AVM_STATUS0);
+
+}
+
+static inline void fcpci_init(struct fritz_adapter *adapter)
+{
+	outb(AVM_STATUS0_DIS_TIMER | AVM_STATUS0_RES_TIMER | 
+	     AVM_STATUS0_ENA_IRQ, adapter->io + AVM_STATUS0);
+}
+
+// ----------------------------------------------------------------------
+
+static int __devinit fcpcipnp_setup(struct fritz_adapter *adapter)
+{
+	u32 val = 0;
+	struct pci_dev *pdev = adapter->pci_dev;
+	int retval;
+
+	DBG(1,"");
+
+	isac_init(&adapter->isac); // FIXME is this okay now
+
+	retval = -EBUSY;
+	if (!request_region(adapter->io, 32, "hisax_fcpcipnp"))
+		goto err;
+
+	switch (adapter->type) {
+	case AVM_FRITZ_PCIV2:
+		retval = request_irq(pdev->irq, fcpci2_irq, SA_SHIRQ, 
+				     "hisax_fcpcipnp", adapter);
+		break;
+	case AVM_FRITZ_PCI:
+		retval = request_irq(pdev->irq, fcpci_irq, SA_SHIRQ,
+				     "hisax_fcpcipnp", adapter);
+		break;
+	case AVM_FRITZ_PNP:
+		retval = request_irq(pdev->irq, fcpci_irq, 0,
+				     "hisax_fcpcipnp", adapter);
+		break;
+	}
+	if (retval)
+		goto err_region;
+
+	switch (adapter->type) {
+	case AVM_FRITZ_PCIV2:
+	case AVM_FRITZ_PCI:
+		val = inl(adapter->io);
+		break;
+	case AVM_FRITZ_PNP:
+		val = inb(adapter->io);
+		val |= inb(adapter->io + 1) << 8;
+		break;
+	}
+
+	DBG(1, "stat %#x Class %X Rev %d",
+	    val, val & 0xff, (val>>8) & 0xff);
+
+	spin_lock_init(&adapter->hw_lock);
+	adapter->isac.priv = adapter;
+	switch (adapter->type) {
+	case AVM_FRITZ_PCIV2:
+		adapter->isac.read_isac       = &fcpci2_read_isac;;
+		adapter->isac.write_isac      = &fcpci2_write_isac;
+		adapter->isac.read_isac_fifo  = &fcpci2_read_isac_fifo;
+		adapter->isac.write_isac_fifo = &fcpci2_write_isac_fifo;
+
+		adapter->read_hdlc_status     = &fcpci2_read_hdlc_status;
+		adapter->write_ctrl           = &fcpci2_write_ctrl;
+		break;
+	case AVM_FRITZ_PCI:
+		adapter->isac.read_isac       = &fcpci_read_isac;;
+		adapter->isac.write_isac      = &fcpci_write_isac;
+		adapter->isac.read_isac_fifo  = &fcpci_read_isac_fifo;
+		adapter->isac.write_isac_fifo = &fcpci_write_isac_fifo;
+
+		adapter->read_hdlc_status     = &fcpci_read_hdlc_status;
+		adapter->write_ctrl           = &fcpci_write_ctrl;
+		break;
+	case AVM_FRITZ_PNP:
+		adapter->isac.read_isac       = &fcpci_read_isac;;
+		adapter->isac.write_isac      = &fcpci_write_isac;
+		adapter->isac.read_isac_fifo  = &fcpci_read_isac_fifo;
+		adapter->isac.write_isac_fifo = &fcpci_write_isac_fifo;
+
+		adapter->read_hdlc_status     = &fcpnp_read_hdlc_status;
+		adapter->write_ctrl           = &fcpnp_write_ctrl;
+		break;
+	}
+
+	// Reset
+	outb(0, adapter->io + AVM_STATUS0);
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(50 * HZ / 1000); // 50 msec
+	outb(AVM_STATUS0_RESET, adapter->io + AVM_STATUS0);
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(50 * HZ / 1000); // 50 msec
+	outb(0, adapter->io + AVM_STATUS0);
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(10 * HZ / 1000); // 10 msec
+
+	switch (adapter->type) {
+	case AVM_FRITZ_PCIV2:
+		fcpci2_init(adapter);
+		isacsx_setup(&adapter->isac);
+		break;
+	case AVM_FRITZ_PCI:
+	case AVM_FRITZ_PNP:
+		fcpci_init(adapter);
+		isac_setup(&adapter->isac);
+		break;
+	}
+	val = adapter->read_hdlc_status(adapter, 0);
+	DBG(0x20, "HDLC A STA %x", val);
+	val = adapter->read_hdlc_status(adapter, 1);
+	DBG(0x20, "HDLC B STA %x", val);
+
+	adapter->bcs[0].mode = -1;
+	adapter->bcs[1].mode = -1;
+	modehdlc(&adapter->bcs[0], L1_MODE_NULL);
+	modehdlc(&adapter->bcs[1], L1_MODE_NULL);
+
+	return 0;
+
+ err_region:
+	release_region(adapter->io, 32);
+ err:
+	return retval;
+}
+
+static void __devexit fcpcipnp_release(struct fritz_adapter *adapter)
+{
+	struct pci_dev *pdev = adapter->pci_dev;
+
+	DBG(1,"");
+
+	outb(0, adapter->io + AVM_STATUS0);
+	free_irq(pdev->irq, adapter);
+	release_region(adapter->io, 32);
+
+	switch (adapter->type) {
+	case AVM_FRITZ_PCI:
+	case AVM_FRITZ_PCIV2:
+		pci_disable_device(pdev);
+		break;
+	case AVM_FRITZ_PNP:
+		pdev->deactivate(pdev);
+		break;
+	}
+}
+
+// ----------------------------------------------------------------------
+
+static struct fritz_adapter * __devinit 
+new_adapter(struct pci_dev *pdev)
+{
+	struct fritz_adapter *adapter;
+	struct hisax_b_if *b_if[2];
+	int i;
+
+	adapter = kmalloc(sizeof(struct fritz_adapter), GFP_KERNEL);
+	if (!adapter)
+		return NULL;
+
+	memset(adapter, 0, sizeof(struct fritz_adapter));
+
+	adapter->pci_dev = pdev;
+
+	SET_MODULE_OWNER(&adapter->isac.hisax_d_if);
+	adapter->isac.hisax_d_if.ifc.priv = &adapter->isac;
+	adapter->isac.hisax_d_if.ifc.l2l1 = isac_d_l2l1;
+	
+	for (i = 0; i < 2; i++) {
+		adapter->bcs[i].adapter = adapter;
+		adapter->bcs[i].channel = i;
+		adapter->bcs[i].b_if.ifc.priv = &adapter->bcs[i];
+		adapter->bcs[i].b_if.ifc.l2l1 = fritz_b_l2l1;
+	}
+	list_add(&adapter->list, &adapter_list);
+
+	pci_set_drvdata(pdev, adapter);
+
+	for (i = 0; i < 2; i++)
+		b_if[i] = &adapter->bcs[i].b_if;
+
+	hisax_register(&adapter->isac.hisax_d_if, b_if, "fcpcipnp", protocol);
+
+	return adapter;
+}
+
+static void delete_adapter(struct fritz_adapter *adapter)
+{
+	hisax_unregister(&adapter->isac.hisax_d_if);
+	list_del(&adapter->list);
+	kfree(adapter);
+}
+
+static int __devinit fcpci_probe(struct pci_dev *pdev,
+				 const struct pci_device_id *ent)
+{
+	struct fritz_adapter *adapter;
+	int retval;
+
+	printk(KERN_INFO "hisax_fcpcipnp: found adapter %s at %s\n",
+	       (char *) ent->driver_data, pdev->slot_name);
+
+	retval = -ENOMEM;
+	adapter = new_adapter(pdev);
+	if (!adapter)
+		goto err;
+
+	if (pdev->device == 0x0e00) 
+		adapter->type = AVM_FRITZ_PCIV2;
+	else
+		adapter->type = AVM_FRITZ_PCI;
+
+	retval = pci_enable_device(pdev);
+	if (retval)
+		goto err_free;
+	adapter->io = pci_resource_start(pdev, 1);
+
+	retval = fcpcipnp_setup(adapter);
+	if (retval)
+		goto err_free;
+
+	return 0;
+	
+ err_free:
+	delete_adapter(adapter);
+ err:
+	return retval;
+}
+
+static int __devinit fcpnp_probe(struct pci_dev *pdev,
+				 const struct isapnp_device_id *ent)
+{
+	struct fritz_adapter *adapter;
+	int retval;
+
+	printk(KERN_INFO "hisax_fcpcipnp: found adapter %s\n",
+	       (char *) ent->driver_data);
+
+	retval = -ENOMEM;
+	adapter = new_adapter(pdev);
+	if (!adapter)
+		goto err;
+
+	adapter->type = AVM_FRITZ_PNP;
+
+	pdev->prepare(pdev);
+	pdev->deactivate(pdev); // why?
+	pdev->activate(pdev);
+	adapter->io = pdev->resource[0].start;
+	pdev->irq = pdev->irq_resource[0].start;
+	
+	retval = fcpcipnp_setup(adapter);
+	if (retval)
+		goto err_free;
+
+	return 0;
+	
+ err_free:
+	delete_adapter(adapter);
+ err:
+	return retval;
+}
+
+static void __devexit fcpcipnp_remove(struct pci_dev *pdev)
+{
+	struct fritz_adapter *adapter = pci_get_drvdata(pdev);
+
+	fcpcipnp_release(adapter);
+	delete_adapter(adapter);
+}
+
+static struct pci_driver fcpci_driver = {
+	name: "fcpci",
+	probe: fcpci_probe,
+	remove: fcpcipnp_remove,
+	id_table: fcpci_ids,
+};
+
+static struct isapnp_driver fcpnp_driver = {
+	name: "fcpnp",
+	probe: fcpnp_probe,
+	remove: fcpcipnp_remove,
+	id_table: fcpnp_ids,
+};
+
+static int __init hisax_fcpci_init(void)
+{
+	int retval, pci_nr_found;
+
+	printk(KERN_INFO "hisax_fcpcipnp: Fritz!PCI/PnP ISDN driver v0.0.1\n");
+
+	retval = pci_register_driver(&fcpci_driver);
+	if (retval < 0)
+		goto out;
+	pci_nr_found = retval;
+
+	retval = isapnp_register_driver(&fcpnp_driver);
+	if (retval < 0)
+		goto out_unregister_pci;
+
+#if !defined(CONFIG_HOTPLUG) || defined(MODULE)
+	if (pci_nr_found + retval == 0) {
+		retval = -ENODEV;
+		goto out_unregister_isapnp;
+	}
+#endif
+	return 0;
+
+#if !defined(CONFIG_HOTPLUG) || defined(MODULE)
+ out_unregister_isapnp:
+	isapnp_unregister_driver(&fcpnp_driver);
+#endif
+ out_unregister_pci:
+	pci_unregister_driver(&fcpci_driver);
+ out:
+	return retval;
+}
+
+static void __exit hisax_fcpci_exit(void)
+{
+	isapnp_unregister_driver(&fcpnp_driver);
+	pci_unregister_driver(&fcpci_driver);
+}
+
+module_init(hisax_fcpci_init);
+module_exit(hisax_fcpci_exit);
diff -urN linux-2.4.14.1/drivers/isdn/hisax/hisax_fcpcipnp.h linux-2.4.14.2/drivers/isdn/hisax/hisax_fcpcipnp.h
--- linux-2.4.14.1/drivers/isdn/hisax/hisax_fcpcipnp.h	Thu Jan  1 01:00:00 1970
+++ linux-2.4.14.2/drivers/isdn/hisax/hisax_fcpcipnp.h	Wed Nov  7 16:48:43 2001
@@ -0,0 +1,59 @@
+#include "hisax_if.h"
+#include "hisax_isac.h"
+#include <linux/pci.h>
+
+#define HSCX_BUFMAX	4096
+
+enum {
+	AVM_FRITZ_PCI,
+	AVM_FRITZ_PNP,
+	AVM_FRITZ_PCIV2,
+};
+
+struct hdlc_stat_reg {
+#ifdef __BIG_ENDIAN
+	u_char fill __attribute__((packed));
+	u_char mode __attribute__((packed));
+	u_char xml  __attribute__((packed));
+	u_char cmd  __attribute__((packed));
+#else
+	u_char cmd  __attribute__((packed));
+	u_char xml  __attribute__((packed));
+	u_char mode __attribute__((packed));
+	u_char fill __attribute__((packed));
+#endif
+};
+
+struct fritz_bcs {
+	struct hisax_b_if b_if;
+	struct fritz_adapter *adapter;
+	int mode;
+	int channel;
+
+	union {
+		u_int ctrl;
+		struct hdlc_stat_reg sr;
+	} ctrl;
+	u_int stat;
+	int rcvidx;
+	u_char rcvbuf[HSCX_BUFMAX]; /* B-Channel receive Buffer */
+
+	int tx_cnt;		    /* B-Channel transmit counter */
+	struct sk_buff *tx_skb;     /* B-Channel transmit Buffer */
+};
+
+struct fritz_adapter {
+	struct list_head list;
+	struct pci_dev *pci_dev;
+
+	int type;
+	spinlock_t hw_lock;
+	unsigned int io;
+	struct isac isac;
+
+	struct fritz_bcs bcs[2];
+
+	u32  (*read_hdlc_status) (struct fritz_adapter *adapter, int nr);
+	void (*write_ctrl) (struct fritz_bcs *bcs, int which);
+};
+
diff -urN linux-2.4.14.1/drivers/isdn/hisax/hisax_isac.c linux-2.4.14.2/drivers/isdn/hisax/hisax_isac.c
--- linux-2.4.14.1/drivers/isdn/hisax/hisax_isac.c	Thu Jan  1 01:00:00 1970
+++ linux-2.4.14.2/drivers/isdn/hisax/hisax_isac.c	Wed Nov  7 16:48:48 2001
@@ -0,0 +1,891 @@
+/*
+ * Driver for ISAC-S and ISAC-SX 
+ * ISDN Subscriber Access Controller for Terminals
+ *
+ * Author       Kai Germaschewski
+ * Copyright    2001 by Kai Germaschewski  <kai.germaschewski@gmx.de>
+ *              2001 by Karsten Keil       <keil@isdn4linux.de>
+ * 
+ * based upon Karsten Keil's original isac.c driver
+ *
+ * This software may be used and distributed according to the terms
+ * of the GNU General Public License, incorporated herein by reference.
+ *
+ * Thanks to Wizard Computersysteme GmbH, Bremervoerde and
+ *           SoHaNet Technology GmbH, Berlin
+ * for supporting the development of this driver
+ */
+
+/* TODO:
+ * specifically handle level vs edge triggered?
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/netdevice.h>
+#include "hisax_isac.h"
+
+// debugging cruft
+
+#define __debug_variable debug
+#include "hisax_debug.h"
+
+#ifdef CONFIG_HISAX_DEBUG
+static int debug = 1;
+MODULE_PARM(debug, "i");
+
+static char *ISACVer[] __devinitdata = {
+  "2086/2186 V1.1", 
+  "2085 B1", 
+  "2085 B2",
+  "2085 V2.3"
+};
+#endif
+
+#define DBG_WARN      0x0001
+#define DBG_IRQ       0x0002
+#define DBG_L1M       0x0004
+#define DBG_PR        0x0008
+#define DBG_RFIFO     0x0100
+#define DBG_RPACKET   0x0200
+#define DBG_XFIFO     0x1000
+#define DBG_XPACKET   0x2000
+
+// we need to distinguish ISAC-S and ISAC-SX
+#define TYPE_ISAC        0x00
+#define TYPE_ISACSX      0x01
+
+// registers etc.
+#define ISAC_MASK        0x20
+#define ISAC_ISTA        0x20
+#define ISAC_ISTA_EXI    0x01
+#define ISAC_ISTA_SIN    0x02
+#define ISAC_ISTA_CISQ   0x04
+#define ISAC_ISTA_XPR    0x10
+#define ISAC_ISTA_RSC    0x20
+#define ISAC_ISTA_RPF    0x40
+#define ISAC_ISTA_RME    0x80
+
+#define ISAC_STAR        0x21
+#define ISAC_CMDR        0x21
+#define ISAC_CMDR_XRES   0x01
+#define ISAC_CMDR_XME    0x02
+#define ISAC_CMDR_XTF    0x08
+#define ISAC_CMDR_RRES   0x40
+#define ISAC_CMDR_RMC    0x80
+
+#define ISAC_EXIR        0x24
+#define ISAC_EXIR_MOS    0x04
+#define ISAC_EXIR_XDU    0x40
+#define ISAC_EXIR_XMR    0x80
+
+#define ISAC_ADF2        0x39
+#define ISAC_SPCR        0x30
+#define ISAC_ADF1        0x38
+
+#define ISAC_CIR0        0x31
+#define ISAC_CIX0        0x31
+#define ISAC_CIR0_CIC0   0x02
+#define ISAC_CIR0_CIC1   0x01
+
+#define ISAC_CIR1        0x33
+#define ISAC_CIX1        0x33
+#define ISAC_STCR        0x37
+#define ISAC_MODE        0x22
+
+#define ISAC_RSTA        0x27
+#define ISAC_RSTA_RDO    0x40
+#define ISAC_RSTA_CRC    0x20
+#define ISAC_RSTA_RAB    0x10
+
+#define ISAC_RBCL 0x25
+#define ISAC_RBCH 0x2A
+#define ISAC_TIMR 0x23
+#define ISAC_SQXR 0x3b
+#define ISAC_MOSR 0x3a
+#define ISAC_MOCR 0x3a
+#define ISAC_MOR0 0x32
+#define ISAC_MOX0 0x32
+#define ISAC_MOR1 0x34
+#define ISAC_MOX1 0x34
+
+#define ISAC_RBCH_XAC 0x80
+
+#define ISAC_CMD_TIM    0x0
+#define ISAC_CMD_RES    0x1
+#define ISAC_CMD_SSP    0x2
+#define ISAC_CMD_SCP    0x3
+#define ISAC_CMD_AR8    0x8
+#define ISAC_CMD_AR10   0x9
+#define ISAC_CMD_ARL    0xa
+#define ISAC_CMD_DI     0xf
+
+#define ISACSX_MASK       0x60
+#define ISACSX_ISTA       0x60
+#define ISACSX_ISTA_ICD   0x01
+#define ISACSX_ISTA_CIC   0x10
+
+#define ISACSX_MASKD      0x20
+#define ISACSX_ISTAD      0x20
+#define ISACSX_ISTAD_XDU  0x04
+#define ISACSX_ISTAD_XMR  0x08
+#define ISACSX_ISTAD_XPR  0x10
+#define ISACSX_ISTAD_RFO  0x20
+#define ISACSX_ISTAD_RPF  0x40
+#define ISACSX_ISTAD_RME  0x80
+
+#define ISACSX_CMDRD      0x21
+#define ISACSX_CMDRD_XRES 0x01
+#define ISACSX_CMDRD_XME  0x02
+#define ISACSX_CMDRD_XTF  0x08
+#define ISACSX_CMDRD_RRES 0x40
+#define ISACSX_CMDRD_RMC  0x80
+
+#define ISACSX_MODED      0x22
+
+#define ISACSX_RBCLD      0x26
+
+#define ISACSX_RSTAD      0x28
+#define ISACSX_RSTAD_RAB  0x10
+#define ISACSX_RSTAD_CRC  0x20
+#define ISACSX_RSTAD_RDO  0x40
+#define ISACSX_RSTAD_VFR  0x80
+
+#define ISACSX_CIR0       0x2e
+#define ISACSX_CIR0_CIC0  0x08
+#define ISACSX_CIX0       0x2e
+
+#define ISACSX_TR_CONF0   0x30
+
+#define ISACSX_TR_CONF2   0x32
+
+static struct Fsm l1fsm;
+
+enum {
+	ST_L1_RESET,
+	ST_L1_F3_PDOWN,
+	ST_L1_F3_PUP,
+	ST_L1_F3_PEND_DEACT,
+	ST_L1_F4,
+	ST_L1_F5,
+	ST_L1_F6,
+	ST_L1_F7,
+	ST_L1_F8,
+};
+
+#define L1_STATE_COUNT (ST_L1_F8+1)
+
+static char *strL1State[] =
+{
+	"ST_L1_RESET",
+	"ST_L1_F3_PDOWN",
+	"ST_L1_F3_PUP",
+	"ST_L1_F3_PEND_DEACT",
+	"ST_L1_F4",
+	"ST_L1_F5",
+	"ST_L1_F6",
+	"ST_L1_F7",
+	"ST_L1_F8",
+};
+
+enum {
+	EV_PH_DR,           // 0000
+	EV_PH_RES,          // 0001
+	EV_PH_TMA,          // 0010
+	EV_PH_SLD,          // 0011
+	EV_PH_RSY,          // 0100
+	EV_PH_DR6,          // 0101
+	EV_PH_EI,           // 0110
+	EV_PH_PU,           // 0111
+	EV_PH_AR,           // 1000
+	EV_PH_9,            // 1001
+	EV_PH_ARL,          // 1010
+	EV_PH_CVR,          // 1011
+	EV_PH_AI8,          // 1100
+	EV_PH_AI10,         // 1101
+	EV_PH_AIL,          // 1110
+	EV_PH_DC,           // 1111
+	EV_PH_ACTIVATE_REQ,
+	EV_PH_DEACTIVATE_REQ,
+	EV_TIMER3,
+};
+
+#define L1_EVENT_COUNT (EV_TIMER3 + 1)
+
+static char *strL1Event[] =
+{
+	"EV_PH_DR",           // 0000
+	"EV_PH_RES",          // 0001
+	"EV_PH_TMA",          // 0010
+	"EV_PH_SLD",          // 0011
+	"EV_PH_RSY",          // 0100
+	"EV_PH_DR6",          // 0101
+	"EV_PH_EI",           // 0110
+	"EV_PH_PU",           // 0111
+	"EV_PH_AR",           // 1000
+	"EV_PH_9",            // 1001
+	"EV_PH_ARL",          // 1010
+	"EV_PH_CVR",          // 1011
+	"EV_PH_AI8",          // 1100
+	"EV_PH_AI10",         // 1101
+	"EV_PH_AIL",          // 1110
+	"EV_PH_DC",           // 1111
+	"EV_PH_ACTIVATE_REQ",
+	"EV_PH_DEACTIVATE_REQ",
+	"EV_TIMER3",
+};
+
+static inline void D_L1L2(struct isac *isac, int pr, void *arg)
+{
+	struct hisax_if *ifc = (struct hisax_if *) &isac->hisax_d_if;
+
+	DBG(DBG_PR, "pr %#x", pr);
+	ifc->l1l2(ifc, pr, arg);
+}
+
+static void ph_command(struct isac *isac, unsigned int command)
+{
+	DBG(DBG_L1M, "ph_command %#x", command);
+	switch (isac->type) {
+	case TYPE_ISAC:
+		isac->write_isac(isac, ISAC_CIX0, (command << 2) | 3);
+		break;
+	case TYPE_ISACSX:
+		isac->write_isac(isac, ISACSX_CIX0, (command << 4) | (7 << 1));
+		break;
+	}
+}
+
+// ----------------------------------------------------------------------
+
+static void l1_di(struct FsmInst *fi, int event, void *arg)
+{
+	struct isac *isac = fi->userdata;
+
+	FsmChangeState(fi, ST_L1_RESET);
+	ph_command(isac, ISAC_CMD_DI);
+}
+
+static void l1_di_deact_ind(struct FsmInst *fi, int event, void *arg)
+{
+	struct isac *isac = fi->userdata;
+
+	FsmChangeState(fi, ST_L1_RESET);
+	D_L1L2(isac, PH_DEACTIVATE | INDICATION, NULL);
+	ph_command(isac, ISAC_CMD_DI);
+}
+
+static void l1_go_f3pdown(struct FsmInst *fi, int event, void *arg)
+{
+	FsmChangeState(fi, ST_L1_F3_PDOWN);
+}
+
+static void l1_go_f3pend_deact_ind(struct FsmInst *fi, int event, void *arg)
+{
+	struct isac *isac = fi->userdata;
+
+	FsmChangeState(fi, ST_L1_F3_PEND_DEACT);
+	D_L1L2(isac, PH_DEACTIVATE | INDICATION, NULL);
+	ph_command(isac, ISAC_CMD_DI);
+}
+
+static void l1_go_f3pend(struct FsmInst *fi, int event, void *arg)
+{
+	struct isac *isac = fi->userdata;
+
+	FsmChangeState(fi, ST_L1_F3_PEND_DEACT);
+	ph_command(isac, ISAC_CMD_DI);
+}
+
+static void l1_go_f4(struct FsmInst *fi, int event, void *arg)
+{
+	FsmChangeState(fi, ST_L1_F4);
+}
+
+static void l1_go_f5(struct FsmInst *fi, int event, void *arg)
+{
+	FsmChangeState(fi, ST_L1_F5);
+}
+
+static void l1_go_f6(struct FsmInst *fi, int event, void *arg)
+{
+	FsmChangeState(fi, ST_L1_F6);
+}
+
+static void l1_go_f6_deact_ind(struct FsmInst *fi, int event, void *arg)
+{
+	struct isac *isac = fi->userdata;
+
+	FsmChangeState(fi, ST_L1_F6);
+	D_L1L2(isac, PH_DEACTIVATE | INDICATION, NULL);
+}
+
+static void l1_go_f7_act_ind(struct FsmInst *fi, int event, void *arg)
+{
+	struct isac *isac = fi->userdata;
+
+	FsmDelTimer(&isac->timer, 0);
+	FsmChangeState(fi, ST_L1_F7);
+	ph_command(isac, ISAC_CMD_AR8);
+	D_L1L2(isac, PH_ACTIVATE | INDICATION, NULL);
+}
+
+static void l1_go_f8(struct FsmInst *fi, int event, void *arg)
+{
+	FsmChangeState(fi, ST_L1_F8);
+}
+
+static void l1_go_f8_deact_ind(struct FsmInst *fi, int event, void *arg)
+{
+	struct isac *isac = fi->userdata;
+
+	FsmChangeState(fi, ST_L1_F8);
+	D_L1L2(isac, PH_DEACTIVATE | INDICATION, NULL);
+}
+
+static void l1_ar8(struct FsmInst *fi, int event, void *arg)
+{
+	struct isac *isac = fi->userdata;
+
+	FsmRestartTimer(&isac->timer, TIMER3_VALUE, EV_TIMER3, NULL, 2);
+	ph_command(isac, ISAC_CMD_AR8);
+}
+
+static void l1_timer3(struct FsmInst *fi, int event, void *arg)
+{
+	struct isac *isac = fi->userdata;
+
+	ph_command(isac, ISAC_CMD_DI);
+	D_L1L2(isac, PH_DEACTIVATE | INDICATION, NULL);
+}
+
+// state machines according to data sheet PSB 2186 / 3186
+
+static struct FsmNode L1FnList[] __initdata =
+{
+	{ST_L1_RESET,         EV_PH_RES,            l1_di},
+	{ST_L1_RESET,         EV_PH_EI,             l1_di},
+	{ST_L1_RESET,         EV_PH_DC,             l1_go_f3pdown},
+	{ST_L1_RESET,         EV_PH_AR,             l1_go_f6},
+	{ST_L1_RESET,         EV_PH_AI8,            l1_go_f7_act_ind},
+
+	{ST_L1_F3_PDOWN,      EV_PH_RES,            l1_di},
+	{ST_L1_F3_PDOWN,      EV_PH_EI,             l1_di},
+	{ST_L1_F3_PDOWN,      EV_PH_AR,             l1_go_f6},
+	{ST_L1_F3_PDOWN,      EV_PH_RSY,            l1_go_f5},
+	{ST_L1_F3_PDOWN,      EV_PH_PU,             l1_go_f4},
+	{ST_L1_F3_PDOWN,      EV_PH_AI8,            l1_go_f7_act_ind},
+	{ST_L1_F3_PDOWN,      EV_PH_ACTIVATE_REQ,   l1_ar8},
+	{ST_L1_F3_PDOWN,      EV_TIMER3,            l1_timer3},
+	
+	{ST_L1_F3_PEND_DEACT, EV_PH_RES,            l1_di},
+	{ST_L1_F3_PEND_DEACT, EV_PH_EI,             l1_di},
+	{ST_L1_F3_PEND_DEACT, EV_PH_DC,             l1_go_f3pdown},
+	{ST_L1_F3_PEND_DEACT, EV_PH_RSY,            l1_go_f5},
+	{ST_L1_F3_PEND_DEACT, EV_PH_AR,             l1_go_f6},
+	{ST_L1_F3_PEND_DEACT, EV_PH_AI8,            l1_go_f7_act_ind},
+
+	{ST_L1_F4,            EV_PH_RES,            l1_di},
+	{ST_L1_F4,            EV_PH_EI,             l1_di},
+	{ST_L1_F4,            EV_PH_RSY,            l1_go_f5},
+	{ST_L1_F4,            EV_PH_AI8,            l1_go_f7_act_ind},
+	{ST_L1_F4,            EV_TIMER3,            l1_timer3},
+	{ST_L1_F4,            EV_PH_DC,             l1_go_f3pdown},
+
+	{ST_L1_F5,            EV_PH_RES,            l1_di},
+	{ST_L1_F5,            EV_PH_EI,             l1_di},
+	{ST_L1_F5,            EV_PH_AR,             l1_go_f6},
+	{ST_L1_F5,            EV_PH_AI8,            l1_go_f7_act_ind},
+	{ST_L1_F5,            EV_TIMER3,            l1_timer3},
+	{ST_L1_F5,            EV_PH_DR,             l1_go_f3pend},
+	{ST_L1_F5,            EV_PH_DC,             l1_go_f3pdown},
+
+	{ST_L1_F6,            EV_PH_RES,            l1_di},
+	{ST_L1_F6,            EV_PH_EI,             l1_di},
+	{ST_L1_F6,            EV_PH_RSY,            l1_go_f8},
+	{ST_L1_F6,            EV_PH_AI8,            l1_go_f7_act_ind},
+	{ST_L1_F6,            EV_PH_DR6,            l1_go_f3pend},
+	{ST_L1_F6,            EV_TIMER3,            l1_timer3},
+	{ST_L1_F6,            EV_PH_DC,             l1_go_f3pdown},
+
+	{ST_L1_F7,            EV_PH_RES,            l1_di_deact_ind},
+	{ST_L1_F7,            EV_PH_EI,             l1_di_deact_ind},
+	{ST_L1_F7,            EV_PH_AR,             l1_go_f6_deact_ind},
+	{ST_L1_F7,            EV_PH_RSY,            l1_go_f8_deact_ind},
+	{ST_L1_F7,            EV_PH_DR,             l1_go_f3pend_deact_ind},
+
+	{ST_L1_F8,            EV_PH_RES,            l1_di},
+	{ST_L1_F8,            EV_PH_EI,             l1_di},
+	{ST_L1_F8,            EV_PH_AR,             l1_go_f6},
+	{ST_L1_F8,            EV_PH_DR,             l1_go_f3pend},
+	{ST_L1_F8,            EV_PH_AI8,            l1_go_f7_act_ind},
+	{ST_L1_F8,            EV_TIMER3,            l1_timer3},
+	{ST_L1_F8,            EV_PH_DC,             l1_go_f3pdown},
+};
+
+static void l1m_debug(struct FsmInst *fi, char *fmt, ...)
+{
+	va_list args;
+	char buf[256];
+	
+	va_start(args, fmt);
+	vsprintf(buf, fmt, args);
+	DBG(DBG_L1M, "%s", buf);
+	va_end(args);
+}
+
+static void __devinit isac_version(struct isac *cs)
+{
+	int val;
+
+	val = cs->read_isac(cs, ISAC_RBCH);
+	DBG(1, "ISAC version (%x): %s", val, ISACVer[(val >> 5) & 3]);
+}
+
+static void isac_empty_fifo(struct isac *isac, int count)
+{
+	// this also works for isacsx, since
+	// CMDR(D) register works the same
+	u_char *ptr;
+
+	DBG(DBG_IRQ, "count %d", count);
+
+	if ((isac->rcvidx + count) >= MAX_DFRAME_LEN_L1) {
+		DBG(DBG_WARN, "overrun %d", isac->rcvidx + count);
+		isac->write_isac(isac, ISAC_CMDR, ISAC_CMDR_RMC);
+		isac->rcvidx = 0;
+		return;
+	}
+	ptr = isac->rcvbuf + isac->rcvidx;
+	isac->rcvidx += count;
+	isac->read_isac_fifo(isac, ptr, count);
+	isac->write_isac(isac, ISAC_CMDR, ISAC_CMDR_RMC);
+	DBG_PACKET(DBG_RFIFO, ptr, count);
+}
+
+static void isac_fill_fifo(struct isac *isac)
+{
+	// this also works for isacsx, since
+	// CMDR(D) register works the same
+
+	int count;
+	unsigned char cmd;
+	u_char *ptr;
+
+	if (!isac->tx_skb)
+		BUG();
+
+	count = isac->tx_skb->len;
+	if (count <= 0)
+		BUG();
+
+	DBG(DBG_IRQ, "count %d", count);
+
+	if (count > 0x20) {
+		count = 0x20;
+		cmd = ISAC_CMDR_XTF;
+	} else {
+		cmd = ISAC_CMDR_XTF | ISAC_CMDR_XME;
+	}
+
+	ptr = isac->tx_skb->data;
+	skb_pull(isac->tx_skb, count);
+	isac->tx_cnt += count;
+	DBG_PACKET(DBG_XFIFO, ptr, count);
+	isac->write_isac_fifo(isac, ptr, count);
+	isac->write_isac(isac, ISAC_CMDR, cmd);
+}
+
+static void isac_retransmit(struct isac *isac)
+{
+	if (!isac->tx_skb) {
+		DBG(DBG_WARN, "no skb");
+		return;
+	}
+	skb_push(isac->tx_skb, isac->tx_cnt);
+	isac->tx_cnt = 0;
+}
+
+
+static inline void isac_cisq_interrupt(struct isac *isac)
+{
+	unsigned char val;
+
+	val = isac->read_isac(isac, ISAC_CIR0);
+	DBG(DBG_IRQ, "CIR0 %#x", val);
+	if (val & ISAC_CIR0_CIC0) {
+		DBG(DBG_IRQ, "CODR0 %#x", (val >> 2) & 0xf);
+		FsmEvent(&isac->l1m, (val >> 2) & 0xf, NULL);
+	}
+	if (val & ISAC_CIR0_CIC1) {
+		val = isac->read_isac(isac, ISAC_CIR1);
+		DBG(DBG_WARN, "ISAC CIR1 %#x", val );
+	}
+}
+
+static inline void isac_rme_interrupt(struct isac *isac)
+{
+	unsigned char val;
+	int count;
+	struct sk_buff *skb;
+	
+	val = isac->read_isac(isac, ISAC_RSTA);
+	if ((val & (ISAC_RSTA_RDO | ISAC_RSTA_CRC | ISAC_RSTA_RAB) )
+	     != ISAC_RSTA_CRC) {
+		DBG(DBG_WARN, "RSTA %#x, dropped", val);
+		isac->write_isac(isac, ISAC_CMDR, ISAC_CMDR_RMC);
+		goto out;
+	}
+
+	count = isac->read_isac(isac, ISAC_RBCL) & 0x1f;
+	DBG(DBG_IRQ, "RBCL %#x", count);
+	if (count == 0)
+		count = 0x20;
+
+	isac_empty_fifo(isac, count);
+	count = isac->rcvidx;
+	if (count < 1) {
+		DBG(DBG_WARN, "count %d < 1", count);
+		goto out;
+	}
+
+	skb = alloc_skb(count, GFP_ATOMIC);
+	if (!skb) {
+		DBG(DBG_WARN, "no memory, dropping\n");
+		goto out;
+	}
+	memcpy(skb_put(skb, count), isac->rcvbuf, count);
+	DBG_SKB(DBG_RPACKET, skb);
+	D_L1L2(isac, PH_DATA | INDICATION, skb);
+ out:
+	isac->rcvidx = 0;
+}
+
+static inline void isac_xpr_interrupt(struct isac *isac)
+{
+	if (!isac->tx_skb)
+		return;
+
+	if (isac->tx_skb->len > 0) {
+		isac_fill_fifo(isac);
+		return;
+	}
+	dev_kfree_skb_irq(isac->tx_skb);
+	isac->tx_cnt = 0;
+	isac->tx_skb = NULL;
+	D_L1L2(isac, PH_DATA | CONFIRM, NULL);
+}
+
+static inline void isac_exi_interrupt(struct isac *isac)
+{
+	unsigned char val;
+
+	val = isac->read_isac(isac, ISAC_EXIR);
+	DBG(2, "EXIR %#x", val);
+
+	if (val & ISAC_EXIR_XMR) {
+		DBG(DBG_WARN, "ISAC XMR");
+		isac_retransmit(isac);
+	}
+	if (val & ISAC_EXIR_XDU) {
+		DBG(DBG_WARN, "ISAC XDU");
+		isac_retransmit(isac);
+	}
+	if (val & ISAC_EXIR_MOS) {  /* MOS */
+		DBG(DBG_WARN, "MOS");
+		val = isac->read_isac(isac, ISAC_MOSR);
+		DBG(2, "ISAC MOSR %#x", val);
+	}
+}
+
+void isac_interrupt(struct isac *isac)
+{
+	unsigned char val;
+
+	val = isac->read_isac(isac, ISAC_ISTA);
+	DBG(DBG_IRQ, "ISTA %#x", val);
+
+	if (val & ISAC_ISTA_EXI) {
+		DBG(DBG_IRQ, "EXI");
+		isac_exi_interrupt(isac);
+	}
+	if (val & ISAC_ISTA_XPR) {
+		DBG(DBG_IRQ, "XPR");
+		isac_xpr_interrupt(isac);
+	}
+	if (val & ISAC_ISTA_RME) {
+		DBG(DBG_IRQ, "RME");
+		isac_rme_interrupt(isac);
+	}
+	if (val & ISAC_ISTA_RPF) {
+		DBG(DBG_IRQ, "RPF");
+		isac_empty_fifo(isac, 0x20);
+	}
+	if (val & ISAC_ISTA_CISQ) {
+		DBG(DBG_IRQ, "CISQ");
+		isac_cisq_interrupt(isac);
+	}
+	if (val & ISAC_ISTA_RSC) {
+		DBG(DBG_WARN, "RSC");
+	}
+	if (val & ISAC_ISTA_SIN) {
+		DBG(DBG_WARN, "SIN");
+	}
+}
+
+// ======================================================================
+
+static inline void isacsx_cic_interrupt(struct isac *isac)
+{
+	unsigned char val;
+
+	val = isac->read_isac(isac, ISACSX_CIR0);
+	DBG(DBG_IRQ, "CIR0 %#x", val);
+	if (val & ISACSX_CIR0_CIC0) {
+		DBG(DBG_IRQ, "CODR0 %#x", val >> 4);
+		FsmEvent(&isac->l1m, val >> 4, NULL);
+	}
+}
+
+static inline void isacsx_rme_interrupt(struct isac *isac)
+{
+	int count;
+	struct sk_buff *skb;
+	unsigned char val;
+
+	val = isac->read_isac(isac, ISACSX_RSTAD);
+	if ((val & (ISACSX_RSTAD_VFR | 
+		    ISACSX_RSTAD_RDO | 
+		    ISACSX_RSTAD_CRC | 
+		    ISACSX_RSTAD_RAB)) 
+	    != (ISACSX_RSTAD_VFR | ISACSX_RSTAD_CRC)) {
+		DBG(DBG_WARN, "RSTAD %#x, dropped", val);
+		isac->write_isac(isac, ISACSX_CMDRD, ISACSX_CMDRD_RMC);
+		goto out;
+	}
+
+	count = isac->read_isac(isac, ISACSX_RBCLD) & 0x1f;
+	DBG(DBG_IRQ, "RBCLD %#x", count);
+	if (count == 0)
+		count = 0x20;
+
+	isac_empty_fifo(isac, count);
+	// strip trailing status byte
+	count = isac->rcvidx - 1;
+	if (count < 1) {
+		DBG(DBG_WARN, "count %d < 1", count);
+		goto out;
+	}
+
+	skb = dev_alloc_skb(count);
+	if (!skb) {
+		DBG(DBG_WARN, "no memory, dropping");
+		goto out;
+	}
+	memcpy(skb_put(skb, count), isac->rcvbuf, count);
+	DBG_SKB(DBG_RPACKET, skb);
+	D_L1L2(isac, PH_DATA | INDICATION, skb);
+ out:
+	isac->rcvidx = 0;
+}
+
+static inline void isacsx_xpr_interrupt(struct isac *isac)
+{
+	if (!isac->tx_skb)
+		return;
+
+	if (isac->tx_skb->len > 0) {
+		isac_fill_fifo(isac);
+		return;
+	}
+	dev_kfree_skb_irq(isac->tx_skb);
+	isac->tx_skb = NULL;
+	isac->tx_cnt = 0;
+	D_L1L2(isac, PH_DATA | CONFIRM, NULL);
+}
+
+static inline void isacsx_icd_interrupt(struct isac *isac)
+{
+	unsigned char val;
+
+	val = isac->read_isac(isac, ISACSX_ISTAD);
+	DBG(DBG_IRQ, "ISTAD %#x", val);
+	if (val & ISACSX_ISTAD_XDU) {
+		DBG(DBG_WARN, "ISTAD XDU");
+		isac_retransmit(isac);
+	}
+	if (val & ISACSX_ISTAD_XMR) {
+		DBG(DBG_WARN, "ISTAD XMR");
+		isac_retransmit(isac);
+	}
+	if (val & ISACSX_ISTAD_XPR) {
+		DBG(DBG_IRQ, "ISTAD XPR");
+		isacsx_xpr_interrupt(isac);
+	}
+	if (val & ISACSX_ISTAD_RFO) {
+		DBG(DBG_WARN, "ISTAD RFO");
+		isac->write_isac(isac, ISACSX_CMDRD, ISACSX_CMDRD_RMC);
+	}
+	if (val & ISACSX_ISTAD_RME) {
+		DBG(DBG_IRQ, "ISTAD RME");
+		isacsx_rme_interrupt(isac);
+	}
+	if (val & ISACSX_ISTAD_RPF) {
+		DBG(DBG_IRQ, "ISTAD RPF");
+		isac_empty_fifo(isac, 0x20);
+	}
+}
+
+void isacsx_interrupt(struct isac *isac)
+{
+	unsigned char val;
+
+	val = isac->read_isac(isac, ISACSX_ISTA);
+	DBG(DBG_IRQ, "ISTA %#x", val);
+
+	if (val & ISACSX_ISTA_ICD)
+		isacsx_icd_interrupt(isac);
+	if (val & ISACSX_ISTA_CIC)
+		isacsx_cic_interrupt(isac);
+}
+
+void __devinit isac_init(struct isac *isac)
+{
+	isac->tx_skb = NULL;
+	isac->l1m.fsm = &l1fsm;
+	isac->l1m.state = ST_L1_RESET;
+#ifdef CONFIG_HISAX_DEBUG
+	isac->l1m.debug = 1;
+#else
+	isac->l1m.debug = 0;
+#endif
+	isac->l1m.userdata = isac;
+	isac->l1m.printdebug = l1m_debug;
+	FsmInitTimer(&isac->l1m, &isac->timer);
+}
+
+void __devinit isac_setup(struct isac *isac)
+{
+	int val, eval;
+
+	isac->type = TYPE_ISAC;
+	isac_version(isac);
+
+	ph_command(isac, ISAC_CMD_RES);
+
+  	isac->write_isac(isac, ISAC_MASK, 0xff);
+  	isac->mocr = 0xaa;
+	if (test_bit(HW_IOM1, &isac->flags)) {
+		/* IOM 1 Mode */
+		isac->write_isac(isac, ISAC_ADF2, 0x0);
+		isac->write_isac(isac, ISAC_SPCR, 0xa);
+		isac->write_isac(isac, ISAC_ADF1, 0x2);
+		isac->write_isac(isac, ISAC_STCR, 0x70);
+		isac->write_isac(isac, ISAC_MODE, 0xc9);
+	} else {
+		/* IOM 2 Mode */
+		if (!isac->adf2)
+			isac->adf2 = 0x80;
+		isac->write_isac(isac, ISAC_ADF2, isac->adf2);
+		isac->write_isac(isac, ISAC_SQXR, 0x2f);
+		isac->write_isac(isac, ISAC_SPCR, 0x00);
+		isac->write_isac(isac, ISAC_STCR, 0x70);
+		isac->write_isac(isac, ISAC_MODE, 0xc9);
+		isac->write_isac(isac, ISAC_TIMR, 0x00);
+		isac->write_isac(isac, ISAC_ADF1, 0x00);
+	}
+	val = isac->read_isac(isac, ISAC_STAR);
+	DBG(2, "ISAC STAR %x", val);
+	val = isac->read_isac(isac, ISAC_MODE);
+	DBG(2, "ISAC MODE %x", val);
+	val = isac->read_isac(isac, ISAC_ADF2);
+	DBG(2, "ISAC ADF2 %x", val);
+	val = isac->read_isac(isac, ISAC_ISTA);
+	DBG(2, "ISAC ISTA %x", val);
+	if (val & 0x01) {
+		eval = isac->read_isac(isac, ISAC_EXIR);
+		DBG(2, "ISAC EXIR %x", eval);
+	}
+	val = isac->read_isac(isac, ISAC_CIR0);
+	DBG(2, "ISAC CIR0 %x", val);
+	FsmEvent(&isac->l1m, (val >> 2) & 0xf, NULL);
+
+	isac->write_isac(isac, ISAC_MASK, 0x0);
+	/* RESET Receiver and Transmitter */
+	isac->write_isac(isac, ISAC_CMDR, ISAC_CMDR_XRES | ISAC_CMDR_RRES);
+}
+
+void isacsx_setup(struct isac *isac)
+{
+	isac->type = TYPE_ISACSX;
+	// clear LDD
+	isac->write_isac(isac, ISACSX_TR_CONF0, 0x00);
+	// enable transmitter
+	isac->write_isac(isac, ISACSX_TR_CONF2, 0x00);
+	// transparent mode 0, RAC, stop/go
+	isac->write_isac(isac, ISACSX_MODED,    0xc9);
+	// all HDLC IRQ unmasked
+	isac->write_isac(isac, ISACSX_MASKD,    0x03);
+	// unmask ICD, CID IRQs
+	isac->write_isac(isac, ISACSX_MASK,            
+			 ~(ISACSX_ISTA_ICD | ISACSX_ISTA_CIC));
+}
+
+void isac_d_l2l1(struct hisax_if *hisax_d_if, int pr, void *arg)
+{
+	struct isac *isac = hisax_d_if->priv;
+	struct sk_buff *skb = arg;
+
+	DBG(DBG_PR, "pr %#x", pr);
+
+	switch (pr) {
+	case PH_ACTIVATE | REQUEST:
+		FsmEvent(&isac->l1m, EV_PH_ACTIVATE_REQ, NULL);
+		break;
+	case PH_DEACTIVATE | REQUEST:
+		FsmEvent(&isac->l1m, EV_PH_DEACTIVATE_REQ, NULL);
+		break;
+	case PH_DATA | REQUEST:
+		DBG(DBG_PR, "PH_DATA REQUEST len %d", skb->len);
+		DBG_SKB(DBG_XPACKET, skb);
+		if (isac->l1m.state != ST_L1_F7) {
+			DBG(1, "L1 wrong state %d\n", isac->l1m.state);
+			dev_kfree_skb(skb);
+			break;
+		}
+		if (isac->tx_skb)
+			BUG();
+
+		isac->tx_skb = skb;
+		isac_fill_fifo(isac);
+		break;
+	}
+}
+
+static int __init hisax_isac_init(void)
+{
+	printk(KERN_INFO "hisax_isac: ISAC-S/ISAC-SX ISDN driver v0.1.0\n");
+
+	l1fsm.state_count = L1_STATE_COUNT;
+	l1fsm.event_count = L1_EVENT_COUNT;
+	l1fsm.strState = strL1State;
+	l1fsm.strEvent = strL1Event;
+	return FsmNew(&l1fsm, L1FnList, ARRAY_SIZE(L1FnList));
+}
+
+static void __exit hisax_isac_exit(void)
+{
+	FsmFree(&l1fsm);
+}
+
+EXPORT_SYMBOL(isac_init);
+EXPORT_SYMBOL(isac_d_l2l1);
+
+EXPORT_SYMBOL(isacsx_setup);
+EXPORT_SYMBOL(isacsx_interrupt);
+
+EXPORT_SYMBOL(isac_setup);
+EXPORT_SYMBOL(isac_interrupt);
+
+module_init(hisax_isac_init);
+module_exit(hisax_isac_exit);
diff -urN linux-2.4.14.1/drivers/isdn/hisax/hisax_isac.h linux-2.4.14.2/drivers/isdn/hisax/hisax_isac.h
--- linux-2.4.14.1/drivers/isdn/hisax/hisax_isac.h	Thu Jan  1 01:00:00 1970
+++ linux-2.4.14.2/drivers/isdn/hisax/hisax_isac.h	Wed Nov  7 16:48:48 2001
@@ -0,0 +1,45 @@
+#ifndef __HISAX_ISAC_H__
+#define __HISAX_ISAC_H__
+
+#include <linux/kernel.h>
+#include "fsm.h"
+#include "hisax_if.h"
+
+#define TIMER3_VALUE 7000
+#define MAX_DFRAME_LEN_L1 300
+
+#define HW_IOM1	0
+
+struct isac {
+	void *priv;
+
+	u_long flags;
+	struct hisax_d_if hisax_d_if;
+	struct FsmInst l1m;
+	struct FsmTimer timer;
+	u_char mocr;
+	u_char adf2;
+	int    type;
+
+	u_char rcvbuf[MAX_DFRAME_LEN_L1];
+	int rcvidx;
+
+	struct sk_buff *tx_skb;
+	int tx_cnt;
+
+	u_char (*read_isac)      (struct isac *, u_char);
+	void   (*write_isac)     (struct isac *, u_char, u_char);
+	void   (*read_isac_fifo) (struct isac *, u_char *, int);
+	void   (*write_isac_fifo)(struct isac *, u_char *, int);
+};
+
+void isac_init(struct isac *isac);
+void isac_d_l2l1(struct hisax_if *hisax_d_if, int pr, void *arg);
+
+void isac_setup(struct isac *isac);
+void isac_interrupt(struct isac *isac);
+
+void isacsx_setup(struct isac *isac);
+void isacsx_interrupt(struct isac *isac);
+
+#endif

