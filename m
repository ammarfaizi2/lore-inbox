Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261401AbSLPXo2>; Mon, 16 Dec 2002 18:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261529AbSLPXo2>; Mon, 16 Dec 2002 18:44:28 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:21004 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261401AbSLPXoR>;
	Mon, 16 Dec 2002 18:44:17 -0500
Date: Mon, 16 Dec 2002 15:49:53 -0800
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [PATCH] PCI Hotplug changes for 2.4.21-pre1
Message-ID: <20021216234953.GE17214@kroah.com>
References: <20021216234817.GD17214@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216234817.GD17214@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.885, 2002/12/16 11:46:55-08:00, willy@debian.org

[PATCH] Add pci_bus_*() API for 2.4 [1/2]

Introduce the pci_bus_(read|write)_config(byte|word|dword) functions from
Linux 2.5.  Reimplement the pci_(read|write)_config(byte|word|dword)_nodev
functions as compatibility wrappers.


diff -Nru a/drivers/hotplug/pci_hotplug.h b/drivers/hotplug/pci_hotplug.h
--- a/drivers/hotplug/pci_hotplug.h	Mon Dec 16 15:42:52 2002
+++ b/drivers/hotplug/pci_hotplug.h	Mon Dec 16 15:42:52 2002
@@ -167,6 +167,18 @@
 				 struct pci_dev_wrapped *wrapped_dev,
 				 struct pci_bus_wrapped *wrapped_parent);
 
+int pci_bus_read_config_byte (struct pci_bus *bus, unsigned int devfn, int where, u8 *val);
+int pci_bus_read_config_word (struct pci_bus *bus, unsigned int devfn, int where, u16 *val);
+int pci_bus_read_config_dword (struct pci_bus *bus, unsigned int devfn, int where, u32 *val);
+int pci_bus_write_config_byte(struct pci_bus *bus, unsigned int devfn, int where, u8 val);
+int pci_bus_write_config_word(struct pci_bus *bus, unsigned int devfn, int where, u16 val);
+int pci_bus_write_config_dword(struct pci_bus *bus, unsigned int devfn, int where, u32 val);
+
+/*
+ * Compatibility functions.  Don't use these, use the
+ * pci_bus_*() functions above.
+ */
+
 extern int pci_read_config_byte_nodev	(struct pci_ops *ops, u8 bus, u8 device,
 					 u8 function, int where, u8 *val);
 extern int pci_read_config_word_nodev	(struct pci_ops *ops, u8 bus, u8 device,
diff -Nru a/drivers/hotplug/pci_hotplug_util.c b/drivers/hotplug/pci_hotplug_util.c
--- a/drivers/hotplug/pci_hotplug_util.c	Mon Dec 16 15:42:52 2002
+++ b/drivers/hotplug/pci_hotplug_util.c	Mon Dec 16 15:42:52 2002
@@ -50,78 +50,58 @@
 /* local variables */
 static int debug;
 
-
-static int build_dev (struct pci_ops *ops, u8 bus, u8 slot, u8 function, struct pci_dev **pci_dev)
+static int build_dev (struct pci_bus *bus, unsigned int devfn, struct pci_dev **pci_dev)
 {
 	struct pci_dev *my_dev;
-	struct pci_bus *my_bus;
-
-	/* Some validity checks. */
-	if ((function > 7) ||
-	    (slot > 31) ||
-	    (pci_dev == NULL) ||
-	    (ops == NULL))
-		return -ENODEV;
 
 	my_dev = kmalloc (sizeof (struct pci_dev), GFP_KERNEL);
 	if (!my_dev)
 		return -ENOMEM;
-	my_bus = kmalloc (sizeof (struct pci_bus), GFP_KERNEL);
-	if (!my_bus) {
-		kfree (my_dev);
-		return -ENOMEM;
-	}
+
 	memset(my_dev, 0, sizeof(struct pci_dev));
-	memset(my_bus, 0, sizeof(struct pci_bus));
 
-	my_bus->number = bus;
-	my_bus->ops = ops;
-	my_dev->devfn = PCI_DEVFN(slot, function);
-	my_dev->bus = my_bus;
+	my_dev->devfn = devfn;
+	my_dev->bus = bus;
+	my_dev->sysdata = bus->sysdata;
 	*pci_dev = my_dev;
 	return 0;
 }
 
 /**
- * pci_read_config_byte_nodev - read a byte from a pci device
- * @ops: pointer to a &struct pci_ops that will be used to read from the pci device
- * @bus: the bus of the pci device to read from
- * @slot: the pci slot number of the pci device to read from
- * @function: the function of the pci device to read from
- * @where: the location on the pci address space to read from
+ * pci_bus_read_config_byte - read a byte from a pci device
+ * @bus: pointer to the parent bus of the pci device to read from
+ * @devfn: the device / function of the pci device to read from
+ * @where: the location in the pci address space to read from
  * @value: pointer to where to place the data read
  *
  * Like pci_read_config_byte() but works for pci devices that do not have a
  * pci_dev structure set up yet.
  * Returns 0 on success.
  */
-int pci_read_config_byte_nodev (struct pci_ops *ops, u8 bus, u8 slot, u8 function, int where, u8 *value)
+int pci_bus_read_config_byte (struct pci_bus *bus, unsigned int devfn, int where, u8 *value)
 {
 	struct pci_dev *dev = NULL;
 	int result;
 
-	dbg("%p, %d, %d, %d, %d, %p\n", ops, bus, slot, function, where, value);
-	dev = pci_find_slot(bus, PCI_DEVFN(slot, function));
+	dbg("%p, %d, %d, %p\n", bus, devfn, where, value);
+	dev = pci_find_slot(bus->number, devfn);
 	if (dev) {
 		dbg("using native pci_dev\n");
 		return pci_read_config_byte (dev, where, value);
 	}
 	
-	result = build_dev (ops, bus, slot, function, &dev);
+	result = build_dev(bus, devfn, &dev);
 	if (result)
 		return result;
 	result = pci_read_config_byte(dev, where, value);
-	kfree (dev->bus);
 	kfree (dev);
 	return result;
 }
 
 /**
- * pci_read_config_word_nodev - read a word from a pci device
- * @ops: pointer to a &struct pci_ops that will be used to read from the pci device
- * @bus: the bus of the pci device to read from
- * @slot: the pci slot number of the pci device to read from
- * @function: the function of the pci device to read from
+ * pci_bus_read_config_word - read a word from a pci device
+ * @bus: pointer to the parent bus of the pci device to read from
+ * @devfn: the device / function of the pci device to read from
  * @where: the location on the pci address space to read from
  * @value: pointer to where to place the data read
  *
@@ -129,34 +109,30 @@
  * pci_dev structure set up yet. 
  * Returns 0 on success.
  */
-int pci_read_config_word_nodev (struct pci_ops *ops, u8 bus, u8 slot, u8 function, int where, u16 *value)
+int pci_bus_read_config_word (struct pci_bus *bus, unsigned int devfn, int where, u16 *value)
 {
 	struct pci_dev *dev = NULL;
 	int result;
 
-	dbg("%p, %d, %d, %d, %d, %p\n", ops, bus, slot, function, where, value);
-	dev = pci_find_slot(bus, PCI_DEVFN(slot, function));
+	dbg("%p, %d, %d, %p\n", bus, devfn, where, value);
+	dev = pci_find_slot(bus->number, devfn);
 	if (dev) {
 		dbg("using native pci_dev\n");
 		return pci_read_config_word (dev, where, value);
 	}
 	
-	result = build_dev (ops, bus, slot, function, &dev);
+	result = build_dev(bus, devfn, &dev);
 	if (result)
 		return result;
 	result = pci_read_config_word(dev, where, value);
-	kfree (dev->bus);
 	kfree (dev);
 	return result;
 }
 
 /**
- * pci_read_config_dword_nodev - read a dword from a pci device
- * @ops: pointer to a &struct pci_ops that will be used to read from the pci
- * device
- * @bus: the bus of the pci device to read from
- * @slot: the pci slot number of the pci device to read from
- * @function: the function of the pci device to read from
+ * pci_bus_read_config_dword - read a dword from a pci device
+ * @bus: pointer to the parent bus of the pci device to read from
+ * @devfn: the device / function of the pci device to read from
  * @where: the location on the pci address space to read from
  * @value: pointer to where to place the data read
  *
@@ -164,34 +140,30 @@
  * pci_dev structure set up yet. 
  * Returns 0 on success.
  */
-int pci_read_config_dword_nodev (struct pci_ops *ops, u8 bus, u8 slot, u8 function, int where, u32 *value)
+int pci_bus_read_config_dword (struct pci_bus *bus, unsigned int devfn, int where, u32 *value)
 {
 	struct pci_dev *dev = NULL;
 	int result;
 
-	dbg("%p, %d, %d, %d, %d, %p\n", ops, bus, slot, function, where, value);
-	dev = pci_find_slot(bus, PCI_DEVFN(slot, function));
+	dbg("%p, %d, %d, %p\n", bus, devfn, where, value);
+	dev = pci_find_slot(bus->number, devfn);
 	if (dev) {
 		dbg("using native pci_dev\n");
 		return pci_read_config_dword (dev, where, value);
 	}
 	
-	result = build_dev (ops, bus, slot, function, &dev);
+	result = build_dev(bus, devfn, &dev);
 	if (result)
 		return result;
 	result = pci_read_config_dword(dev, where, value);
-	kfree (dev->bus);
 	kfree (dev);
 	return result;
 }
 
 /**
- * pci_write_config_byte_nodev - write a byte to a pci device
- * @ops: pointer to a &struct pci_ops that will be used to write to the pci
- * device
- * @bus: the bus of the pci device to write to
- * @slot: the pci slot number of the pci device to write to
- * @function: the function of the pci device to write to
+ * pci_bus_write_config_byte - write a byte to a pci device
+ * @bus: pointer to the parent bus of the pci device to read from
+ * @devfn: the device / function of the pci device to read from
  * @where: the location on the pci address space to write to
  * @value: the value to write to the pci device
  *
@@ -199,34 +171,30 @@
  * pci_dev structure set up yet. 
  * Returns 0 on success.
  */
-int pci_write_config_byte_nodev (struct pci_ops *ops, u8 bus, u8 slot, u8 function, int where, u8 value)
+int pci_bus_write_config_byte (struct pci_bus *bus, unsigned int devfn, int where, u8 value)
 {
 	struct pci_dev *dev = NULL;
 	int result;
 
-	dbg("%p, %d, %d, %d, %d, %d\n", ops, bus, slot, function, where, value);
-	dev = pci_find_slot(bus, PCI_DEVFN(slot, function));
+	dbg("%p, %d, %d, %d\n", bus, devfn, where, value);
+	dev = pci_find_slot(bus->number, devfn);
 	if (dev) {
 		dbg("using native pci_dev\n");
 		return pci_write_config_byte (dev, where, value);
 	}
 	
-	result = build_dev (ops, bus, slot, function, &dev);
+	result = build_dev(bus, devfn, &dev);
 	if (result)
 		return result;
 	result = pci_write_config_byte(dev, where, value);
-	kfree (dev->bus);
 	kfree (dev);
 	return result;
 }
 
 /**
- * pci_write_config_word_nodev - write a word to a pci device
- * @ops: pointer to a &struct pci_ops that will be used to write to the pci
- * device
- * @bus: the bus of the pci device to write to
- * @slot: the pci slot number of the pci device to write to
- * @function: the function of the pci device to write to
+ * pci_bus_write_config_word - write a word to a pci device
+ * @bus: pointer to the parent bus of the pci device to read from
+ * @devfn: the device / function of the pci device to read from
  * @where: the location on the pci address space to write to
  * @value: the value to write to the pci device
  *
@@ -234,34 +202,30 @@
  * pci_dev structure set up yet. 
  * Returns 0 on success.
  */
-int pci_write_config_word_nodev (struct pci_ops *ops, u8 bus, u8 slot, u8 function, int where, u16 value)
+int pci_bus_write_config_word (struct pci_bus *bus, unsigned int devfn, int where, u16 value)
 {
 	struct pci_dev *dev = NULL;
 	int result;
 
-	dbg("%p, %d, %d, %d, %d, %d\n", ops, bus, slot, function, where, value);
-	dev = pci_find_slot(bus, PCI_DEVFN(slot, function));
+	dbg("%p, %d, %d, %d\n", bus, devfn, where, value);
+	dev = pci_find_slot(bus->number, devfn);
 	if (dev) {
 		dbg("using native pci_dev\n");
 		return pci_write_config_word (dev, where, value);
 	}
 	
-	result = build_dev (ops, bus, slot, function, &dev);
+	result = build_dev(bus, devfn, &dev);
 	if (result)
 		return result;
 	result = pci_write_config_word(dev, where, value);
-	kfree (dev->bus);
 	kfree (dev);
 	return result;
 }
 
 /**
- * pci_write_config_dword_nodev - write a dword to a pci device
- * @ops: pointer to a &struct pci_ops that will be used to write to the pci
- * device
- * @bus: the bus of the pci device to write to
- * @slot: the pci slot number of the pci device to write to
- * @function: the function of the pci device to write to
+ * pci_bus_write_config_dword - write a dword to a pci device
+ * @bus: pointer to the parent bus of the pci device to read from
+ * @devfn: the device / function of the pci device to read from
  * @where: the location on the pci address space to write to
  * @value: the value to write to the pci device
  *
@@ -269,23 +233,22 @@
  * pci_dev structure set up yet. 
  * Returns 0 on success.
  */
-int pci_write_config_dword_nodev (struct pci_ops *ops, u8 bus, u8 slot, u8 function, int where, u32 value)
+int pci_bus_write_config_dword (struct pci_bus *bus, unsigned int devfn, int where, u32 value)
 {
 	struct pci_dev *dev = NULL;
 	int result;
 
-	dbg("%p, %d, %d, %d, %d, %d\n", ops, bus, slot, function, where, value);
-	dev = pci_find_slot(bus, PCI_DEVFN(slot, function));
+	dbg("%p, %d, %d, %d\n", bus, devfn, where, value);
+	dev = pci_find_slot(bus->number, devfn);
 	if (dev) {
 		dbg("using native pci_dev\n");
 		return pci_write_config_dword (dev, where, value);
 	}
 	
-	result = build_dev (ops, bus, slot, function, &dev);
+	result = build_dev(bus, devfn, &dev);
 	if (result)
 		return result;
 	result = pci_write_config_dword(dev, where, value);
-	kfree (dev->bus);
 	kfree (dev);
 	return result;
 }
@@ -392,8 +355,98 @@
 	return result;
 }
 
+/* Compatibility wrapper functions */
+
+static struct pci_bus *alloc_bus(struct pci_ops *ops, u8 bus_nr)
+{
+	struct pci_bus *bus = kmalloc(sizeof(struct pci_bus), GFP_KERNEL);
+	if (!bus)
+		return NULL;
+	memset(bus, 0, sizeof(struct pci_bus));
+	bus->number = bus_nr;
+	bus->ops = ops;
+	return bus;
+}
+
+int pci_read_config_byte_nodev(struct pci_ops *ops, u8 bus_nr, u8 slot, u8 function, int where, u8 *value)
+{
+	int result;
+	struct pci_bus *bus = alloc_bus(ops, bus_nr);
+	if (!bus)
+		return -ENOMEM;
+	result = pci_bus_read_config_byte(bus, PCI_DEVFN(slot, function),
+						where, value);
+	kfree(bus);
+	return result;
+}
+
+int pci_read_config_word_nodev(struct pci_ops *ops, u8 bus_nr, u8 slot, u8 function, int where, u16 *value)
+{
+	int result;
+	struct pci_bus *bus = alloc_bus(ops, bus_nr);
+	if (!bus)
+		return -ENOMEM;
+	result = pci_bus_read_config_word(bus, PCI_DEVFN(slot, function),
+						where, value);
+	kfree(bus);
+	return result;
+}
+
+int pci_read_config_dword_nodev(struct pci_ops *ops, u8 bus_nr, u8 slot, u8 function, int where, u32 *value)
+{
+	int result;
+	struct pci_bus *bus = alloc_bus(ops, bus_nr);
+	if (!bus)
+		return -ENOMEM;
+	result = pci_bus_read_config_dword(bus, PCI_DEVFN(slot, function),
+						where, value);
+	kfree(bus);
+	return result;
+}
+
+int pci_write_config_byte_nodev(struct pci_ops *ops, u8 bus_nr, u8 slot, u8 function, int where, u8 value)
+{
+	int result;
+	struct pci_bus *bus = alloc_bus(ops, bus_nr);
+	if (!bus)
+		return -ENOMEM;
+	result = pci_bus_write_config_byte(bus, PCI_DEVFN(slot, function),
+						where, value);
+	kfree(bus);
+	return result;
+}
+
+int pci_write_config_word_nodev(struct pci_ops *ops, u8 bus_nr, u8 slot, u8 function, int where, u16 value)
+{
+	int result;
+	struct pci_bus *bus = alloc_bus(ops, bus_nr);
+	if (!bus)
+		return -ENOMEM;
+	result = pci_bus_write_config_word(bus, PCI_DEVFN(slot, function),
+						where, value);
+	kfree(bus);
+	return result;
+}
+
+int pci_write_config_dword_nodev(struct pci_ops *ops, u8 bus_nr, u8 slot, u8 function, int where, u32 value)
+{
+	int result;
+	struct pci_bus *bus = alloc_bus(ops, bus_nr);
+	if (!bus)
+		return -ENOMEM;
+	result = pci_bus_write_config_dword(bus, PCI_DEVFN(slot, function),
+						where, value);
+	kfree(bus);
+	return result;
+}
 
 EXPORT_SYMBOL(pci_visit_dev);
+EXPORT_SYMBOL(pci_bus_read_config_byte);
+EXPORT_SYMBOL(pci_bus_read_config_word);
+EXPORT_SYMBOL(pci_bus_read_config_dword);
+EXPORT_SYMBOL(pci_bus_write_config_byte);
+EXPORT_SYMBOL(pci_bus_write_config_word);
+EXPORT_SYMBOL(pci_bus_write_config_dword);
 EXPORT_SYMBOL(pci_read_config_byte_nodev);
 EXPORT_SYMBOL(pci_read_config_word_nodev);
 EXPORT_SYMBOL(pci_read_config_dword_nodev);
