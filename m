Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317602AbSH3WG6>; Fri, 30 Aug 2002 18:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317610AbSH3WG5>; Fri, 30 Aug 2002 18:06:57 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:30739 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317602AbSH3WGI>;
	Fri, 30 Aug 2002 18:06:08 -0400
Date: Fri, 30 Aug 2002 15:09:32 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] PCI ops cleanups for 2.5.32-bk
Message-ID: <20020830220931.GD10783@kroah.com>
References: <20020830220720.GA10783@kroah.com> <20020830220846.GB10783@kroah.com> <20020830220912.GC10783@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020830220912.GC10783@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.544   -> 1.545  
#	drivers/hotplug/pci_hotplug_util.c	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/30	greg@kroah.com	1.545
# [PATCH] PCI Hotplug: removed the pci_*_nodev functions
# 
# removed the pci_*_nodev functions, as the pci_bus_* functions should be used instead.
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/pci_hotplug_util.c b/drivers/hotplug/pci_hotplug_util.c
--- a/drivers/hotplug/pci_hotplug_util.c	Fri Aug 30 15:00:33 2002
+++ b/drivers/hotplug/pci_hotplug_util.c	Fri Aug 30 15:00:33 2002
@@ -51,245 +51,6 @@
 static int debug;
 
 
-static int build_dev (struct pci_ops *ops, u8 bus, u8 slot, u8 function, struct pci_dev **pci_dev)
-{
-	struct pci_dev *my_dev;
-	struct pci_bus *my_bus;
-
-	/* Some validity checks. */
-	if ((function > 7) ||
-	    (slot > 31) ||
-	    (pci_dev == NULL) ||
-	    (ops == NULL))
-		return -ENODEV;
-
-	my_dev = kmalloc (sizeof (struct pci_dev), GFP_KERNEL);
-	if (!my_dev)
-		return -ENOMEM;
-	my_bus = kmalloc (sizeof (struct pci_bus), GFP_KERNEL);
-	if (!my_bus) {
-		kfree (my_dev);
-		return -ENOMEM;
-	}
-	memset(my_dev, 0, sizeof(struct pci_dev));
-	memset(my_bus, 0, sizeof(struct pci_bus));
-
-	my_bus->number = bus;
-	my_bus->ops = ops;
-	my_dev->devfn = PCI_DEVFN(slot, function);
-	my_dev->bus = my_bus;
-	*pci_dev = my_dev;
-	return 0;
-}
-
-/**
- * pci_read_config_byte_nodev - read a byte from a pci device
- * @ops: pointer to a &struct pci_ops that will be used to read from the pci device
- * @bus: the bus of the pci device to read from
- * @slot: the pci slot number of the pci device to read from
- * @function: the function of the pci device to read from
- * @where: the location on the pci address space to read from
- * @value: pointer to where to place the data read
- *
- * Like pci_read_config_byte() but works for pci devices that do not have a
- * pci_dev structure set up yet.
- * Returns 0 on success.
- */
-int pci_read_config_byte_nodev (struct pci_ops *ops, u8 bus, u8 slot, u8 function, int where, u8 *value)
-{
-	struct pci_dev *dev = NULL;
-	int result;
-
-	dbg("%p, %d, %d, %d, %d, %p\n", ops, bus, slot, function, where, value);
-	dev = pci_find_slot(bus, PCI_DEVFN(slot, function));
-	if (dev) {
-		dbg("using native pci_dev\n");
-		return pci_read_config_byte (dev, where, value);
-	}
-	
-	result = build_dev (ops, bus, slot, function, &dev);
-	if (result)
-		return result;
-	result = pci_read_config_byte(dev, where, value);
-	kfree (dev->bus);
-	kfree (dev);
-	return result;
-}
-
-/**
- * pci_read_config_word_nodev - read a word from a pci device
- * @ops: pointer to a &struct pci_ops that will be used to read from the pci device
- * @bus: the bus of the pci device to read from
- * @slot: the pci slot number of the pci device to read from
- * @function: the function of the pci device to read from
- * @where: the location on the pci address space to read from
- * @value: pointer to where to place the data read
- *
- * Like pci_read_config_word() but works for pci devices that do not have a
- * pci_dev structure set up yet. 
- * Returns 0 on success.
- */
-int pci_read_config_word_nodev (struct pci_ops *ops, u8 bus, u8 slot, u8 function, int where, u16 *value)
-{
-	struct pci_dev *dev = NULL;
-	int result;
-
-	dbg("%p, %d, %d, %d, %d, %p\n", ops, bus, slot, function, where, value);
-	dev = pci_find_slot(bus, PCI_DEVFN(slot, function));
-	if (dev) {
-		dbg("using native pci_dev\n");
-		return pci_read_config_word (dev, where, value);
-	}
-	
-	result = build_dev (ops, bus, slot, function, &dev);
-	if (result)
-		return result;
-	result = pci_read_config_word(dev, where, value);
-	kfree (dev->bus);
-	kfree (dev);
-	return result;
-}
-
-/**
- * pci_read_config_dword_nodev - read a dword from a pci device
- * @ops: pointer to a &struct pci_ops that will be used to read from the pci
- * device
- * @bus: the bus of the pci device to read from
- * @slot: the pci slot number of the pci device to read from
- * @function: the function of the pci device to read from
- * @where: the location on the pci address space to read from
- * @value: pointer to where to place the data read
- *
- * Like pci_read_config_dword() but works for pci devices that do not have a
- * pci_dev structure set up yet. 
- * Returns 0 on success.
- */
-int pci_read_config_dword_nodev (struct pci_ops *ops, u8 bus, u8 slot, u8 function, int where, u32 *value)
-{
-	struct pci_dev *dev = NULL;
-	int result;
-
-	dbg("%p, %d, %d, %d, %d, %p\n", ops, bus, slot, function, where, value);
-	dev = pci_find_slot(bus, PCI_DEVFN(slot, function));
-	if (dev) {
-		dbg("using native pci_dev\n");
-		return pci_read_config_dword (dev, where, value);
-	}
-	
-	result = build_dev (ops, bus, slot, function, &dev);
-	if (result)
-		return result;
-	result = pci_read_config_dword(dev, where, value);
-	kfree (dev->bus);
-	kfree (dev);
-	return result;
-}
-
-/**
- * pci_write_config_byte_nodev - write a byte to a pci device
- * @ops: pointer to a &struct pci_ops that will be used to write to the pci
- * device
- * @bus: the bus of the pci device to write to
- * @slot: the pci slot number of the pci device to write to
- * @function: the function of the pci device to write to
- * @where: the location on the pci address space to write to
- * @value: the value to write to the pci device
- *
- * Like pci_write_config_byte() but works for pci devices that do not have a
- * pci_dev structure set up yet. 
- * Returns 0 on success.
- */
-int pci_write_config_byte_nodev (struct pci_ops *ops, u8 bus, u8 slot, u8 function, int where, u8 value)
-{
-	struct pci_dev *dev = NULL;
-	int result;
-
-	dbg("%p, %d, %d, %d, %d, %d\n", ops, bus, slot, function, where, value);
-	dev = pci_find_slot(bus, PCI_DEVFN(slot, function));
-	if (dev) {
-		dbg("using native pci_dev\n");
-		return pci_write_config_byte (dev, where, value);
-	}
-	
-	result = build_dev (ops, bus, slot, function, &dev);
-	if (result)
-		return result;
-	result = pci_write_config_byte(dev, where, value);
-	kfree (dev->bus);
-	kfree (dev);
-	return result;
-}
-
-/**
- * pci_write_config_word_nodev - write a word to a pci device
- * @ops: pointer to a &struct pci_ops that will be used to write to the pci
- * device
- * @bus: the bus of the pci device to write to
- * @slot: the pci slot number of the pci device to write to
- * @function: the function of the pci device to write to
- * @where: the location on the pci address space to write to
- * @value: the value to write to the pci device
- *
- * Like pci_write_config_word() but works for pci devices that do not have a
- * pci_dev structure set up yet. 
- * Returns 0 on success.
- */
-int pci_write_config_word_nodev (struct pci_ops *ops, u8 bus, u8 slot, u8 function, int where, u16 value)
-{
-	struct pci_dev *dev = NULL;
-	int result;
-
-	dbg("%p, %d, %d, %d, %d, %d\n", ops, bus, slot, function, where, value);
-	dev = pci_find_slot(bus, PCI_DEVFN(slot, function));
-	if (dev) {
-		dbg("using native pci_dev\n");
-		return pci_write_config_word (dev, where, value);
-	}
-	
-	result = build_dev (ops, bus, slot, function, &dev);
-	if (result)
-		return result;
-	result = pci_write_config_word(dev, where, value);
-	kfree (dev->bus);
-	kfree (dev);
-	return result;
-}
-
-/**
- * pci_write_config_dword_nodev - write a dword to a pci device
- * @ops: pointer to a &struct pci_ops that will be used to write to the pci
- * device
- * @bus: the bus of the pci device to write to
- * @slot: the pci slot number of the pci device to write to
- * @function: the function of the pci device to write to
- * @where: the location on the pci address space to write to
- * @value: the value to write to the pci device
- *
- * Like pci_write_config_dword() but works for pci devices that do not have a
- * pci_dev structure set up yet. 
- * Returns 0 on success.
- */
-int pci_write_config_dword_nodev (struct pci_ops *ops, u8 bus, u8 slot, u8 function, int where, u32 value)
-{
-	struct pci_dev *dev = NULL;
-	int result;
-
-	dbg("%p, %d, %d, %d, %d, %d\n", ops, bus, slot, function, where, value);
-	dev = pci_find_slot(bus, PCI_DEVFN(slot, function));
-	if (dev) {
-		dbg("using native pci_dev\n");
-		return pci_write_config_dword (dev, where, value);
-	}
-	
-	result = build_dev (ops, bus, slot, function, &dev);
-	if (result)
-		return result;
-	result = pci_write_config_dword(dev, where, value);
-	kfree (dev->bus);
-	kfree (dev);
-	return result;
-}
-
 /*
  * This is code that scans the pci buses.
  * Every bus and every function is presented to a custom
@@ -394,10 +155,4 @@
 
 
 EXPORT_SYMBOL(pci_visit_dev);
-EXPORT_SYMBOL(pci_read_config_byte_nodev);
-EXPORT_SYMBOL(pci_read_config_word_nodev);
-EXPORT_SYMBOL(pci_read_config_dword_nodev);
-EXPORT_SYMBOL(pci_write_config_byte_nodev);
-EXPORT_SYMBOL(pci_write_config_word_nodev);
-EXPORT_SYMBOL(pci_write_config_dword_nodev);
 
