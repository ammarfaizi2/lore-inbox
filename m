Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317597AbSH3WF4>; Fri, 30 Aug 2002 18:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317602AbSH3WFz>; Fri, 30 Aug 2002 18:05:55 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:30227 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317597AbSH3WFs>;
	Fri, 30 Aug 2002 18:05:48 -0400
Date: Fri, 30 Aug 2002 15:09:12 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] PCI ops cleanups for 2.5.32-bk
Message-ID: <20020830220912.GC10783@kroah.com>
References: <20020830220720.GA10783@kroah.com> <20020830220846.GB10783@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020830220846.GB10783@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.543   -> 1.544  
#	arch/i386/pci/pcbios.c	1.10    -> 1.11   
#	arch/i386/pci/direct.c	1.10    -> 1.11   
#	 include/linux/pci.h	1.36    -> 1.37   
#	drivers/pci/access.c	1.4     -> 1.5    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/30	greg@kroah.com	1.544
# [PATCH] PCI:  add pci_bus_* functions to replace the pci_read_* and pci_write_* functions.
# 
# add pci_bus_* functions to replace the pci_read_* and pci_write_* functions.
# --------------------------------------------
#
diff -Nru a/arch/i386/pci/direct.c b/arch/i386/pci/direct.c
--- a/arch/i386/pci/direct.c	Fri Aug 30 15:00:36 2002
+++ b/arch/i386/pci/direct.c	Fri Aug 30 15:00:36 2002
@@ -71,16 +71,16 @@
 
 #undef PCI_CONF1_ADDRESS
 
-static int pci_conf1_read(struct pci_dev *dev, int where, int size, u32 *value)
+static int pci_conf1_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
 {
-	return __pci_conf1_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, size, value);
+	return __pci_conf1_read(0, bus->number, PCI_SLOT(devfn), 
+		PCI_FUNC(devfn), where, size, value);
 }
 
-static int pci_conf1_write(struct pci_dev *dev, int where, int size, u32 value)
+static int pci_conf1_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
 {
-	return __pci_conf1_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, size, value);
+	return __pci_conf1_write(0, bus->number, PCI_SLOT(devfn), 
+		PCI_FUNC(devfn), where, size, value);
 }
 
 static struct pci_ops pci_direct_conf1 = {
@@ -165,16 +165,16 @@
 
 #undef PCI_CONF2_ADDRESS
 
-static int pci_conf2_read(struct pci_dev *dev, int where, int size, u32 *value)
+static int pci_conf2_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
 {
-	return __pci_conf2_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, size, value);
+	return __pci_conf2_read(0, bus->number, PCI_SLOT(devfn), 
+		PCI_FUNC(devfn), where, size, value);
 }
 
-static int pci_conf2_write(struct pci_dev *dev, int where, int size, u32 value)
+static int pci_conf2_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
 {
-	return __pci_conf2_write(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, size, value);
+	return __pci_conf2_write(0, bus->number, PCI_SLOT(devfn), 
+		PCI_FUNC(devfn), where, size, value);
 }
 
 static struct pci_ops pci_direct_conf2 = {
@@ -204,9 +204,9 @@
 	bus.number = 0;
 	dev.bus = &bus;
 	for(dev.devfn=0; dev.devfn < 0x100; dev.devfn++)
-		if ((!o->read(&dev, PCI_CLASS_DEVICE, 2, &x) &&
+		if ((!o->read(&bus, dev.devfn, PCI_CLASS_DEVICE, 2, &x) &&
 		     (x == PCI_CLASS_BRIDGE_HOST || x == PCI_CLASS_DISPLAY_VGA)) ||
-		    (!o->read(&dev, PCI_VENDOR_ID, 2, &x) &&
+		    (!o->read(&bus, dev.devfn, PCI_VENDOR_ID, 2, &x) &&
 		     (x == PCI_VENDOR_ID_INTEL || x == PCI_VENDOR_ID_COMPAQ)))
 			return 1;
 	DBG("PCI: Sanity check failed\n");
diff -Nru a/arch/i386/pci/pcbios.c b/arch/i386/pci/pcbios.c
--- a/arch/i386/pci/pcbios.c	Fri Aug 30 15:00:36 2002
+++ b/arch/i386/pci/pcbios.c	Fri Aug 30 15:00:36 2002
@@ -295,16 +295,16 @@
 	return (int)((result & 0xff00) >> 8);
 }
 
-static int pci_bios_read(struct pci_dev *dev, int where, int size, u32 *value)
+static int pci_bios_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
 {
-	return __pci_bios_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, size, value);
+	return __pci_bios_read(0, bus->number, PCI_SLOT(devfn), 
+		PCI_FUNC(devfn), where, size, value);
 }
 
-static int pci_bios_write(struct pci_dev *dev, int where, int size, u32 value)
+static int pci_bios_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
 {
-	return __pci_bios_write(0, dev->bus->number, PCI_SLOT(dev->devfn),
-		PCI_FUNC(dev->devfn), where, size, value);
+	return __pci_bios_write(0, bus->number, PCI_SLOT(devfn),
+		PCI_FUNC(devfn), where, size, value);
 }
 
 
diff -Nru a/drivers/pci/access.c b/drivers/pci/access.c
--- a/drivers/pci/access.c	Fri Aug 30 15:00:36 2002
+++ b/drivers/pci/access.c	Fri Aug 30 15:00:36 2002
@@ -20,27 +20,29 @@
 #define PCI_dword_BAD (pos & 3)
 
 #define PCI_OP_READ(size,type,len) \
-int pci_read_config_##size (struct pci_dev *dev, int pos, type *value) \
+int pci_bus_read_config_##size \
+	(struct pci_bus *bus, unsigned int devfn, int pos, type *value)	\
 {									\
 	int res;							\
 	unsigned long flags;						\
 	u32 data = 0;							\
 	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
 	spin_lock_irqsave(&pci_lock, flags);				\
-	res = dev->bus->ops->read(dev, pos, len, &data);		\
+	res = bus->ops->read(bus, devfn, pos, len, &data);		\
 	*value = (type)data;						\
 	spin_unlock_irqrestore(&pci_lock, flags);			\
 	return res;							\
 }
 
 #define PCI_OP_WRITE(size,type,len) \
-int pci_write_config_##size (struct pci_dev *dev, int pos, type value) \
+int pci_bus_write_config_##size \
+	(struct pci_bus *bus, unsigned int devfn, int pos, type value)	\
 {									\
 	int res;							\
 	unsigned long flags;						\
 	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
 	spin_lock_irqsave(&pci_lock, flags);				\
-	res = dev->bus->ops->write(dev, pos, len, value);		\
+	res = bus->ops->write(bus, devfn, pos, len, value);		\
 	spin_unlock_irqrestore(&pci_lock, flags);			\
 	return res;							\
 }
@@ -52,10 +54,10 @@
 PCI_OP_WRITE(word, u16, 2)
 PCI_OP_WRITE(dword, u32, 4)
 
-EXPORT_SYMBOL(pci_read_config_byte);
-EXPORT_SYMBOL(pci_read_config_word);
-EXPORT_SYMBOL(pci_read_config_dword);
-EXPORT_SYMBOL(pci_write_config_byte);
-EXPORT_SYMBOL(pci_write_config_word);
-EXPORT_SYMBOL(pci_write_config_dword);
+EXPORT_SYMBOL(pci_bus_read_config_byte);
+EXPORT_SYMBOL(pci_bus_read_config_word);
+EXPORT_SYMBOL(pci_bus_read_config_dword);
+EXPORT_SYMBOL(pci_bus_write_config_byte);
+EXPORT_SYMBOL(pci_bus_write_config_word);
+EXPORT_SYMBOL(pci_bus_write_config_dword);
 EXPORT_SYMBOL(pci_lock);
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Fri Aug 30 15:00:36 2002
+++ b/include/linux/pci.h	Fri Aug 30 15:00:36 2002
@@ -456,8 +456,8 @@
 /* Low-level architecture-dependent routines */
 
 struct pci_ops {
-	int (*read)(struct pci_dev *, int where, int size, u32 *val);
-	int (*write)(struct pci_dev *, int where, int size, u32 val);
+	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
+	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
 };
 
 struct pbus_set_ranges_data
@@ -556,12 +556,37 @@
 struct pci_dev *pci_find_slot (unsigned int bus, unsigned int devfn);
 int pci_find_capability (struct pci_dev *dev, int cap);
 
-int pci_read_config_byte(struct pci_dev *dev, int where, u8 *val);
-int pci_read_config_word(struct pci_dev *dev, int where, u16 *val);
-int pci_read_config_dword(struct pci_dev *dev, int where, u32 *val);
-int pci_write_config_byte(struct pci_dev *dev, int where, u8 val);
-int pci_write_config_word(struct pci_dev *dev, int where, u16 val);
-int pci_write_config_dword(struct pci_dev *dev, int where, u32 val);
+int pci_bus_read_config_byte (struct pci_bus *bus, unsigned int devfn, int where, u8 *val);
+int pci_bus_read_config_word (struct pci_bus *bus, unsigned int devfn, int where, u16 *val);
+int pci_bus_read_config_dword (struct pci_bus *bus, unsigned int devfn, int where, u32 *val);
+int pci_bus_write_config_byte (struct pci_bus *bus, unsigned int devfn, int where, u8 val);
+int pci_bus_write_config_word (struct pci_bus *bus, unsigned int devfn, int where, u16 val);
+int pci_bus_write_config_dword (struct pci_bus *bus, unsigned int devfn, int where, u32 val);
+
+static inline int pci_read_config_byte(struct pci_dev *dev, int where, u8 *val)
+{
+	return pci_bus_read_config_byte (dev->bus, dev->devfn, where, val);
+}
+static int inline pci_read_config_word(struct pci_dev *dev, int where, u16 *val)
+{
+	return pci_bus_read_config_word (dev->bus, dev->devfn, where, val);
+}
+static int inline pci_read_config_dword(struct pci_dev *dev, int where, u32 *val)
+{
+	return pci_bus_read_config_dword (dev->bus, dev->devfn, where, val);
+}
+static int inline pci_write_config_byte(struct pci_dev *dev, int where, u8 val)
+{
+	return pci_bus_write_config_byte (dev->bus, dev->devfn, where, val);
+}
+static int inline pci_write_config_word(struct pci_dev *dev, int where, u16 val)
+{
+	return pci_bus_write_config_word (dev->bus, dev->devfn, where, val);
+}
+static int inline pci_write_config_dword(struct pci_dev *dev, int where, u32 val)
+{
+	return pci_bus_write_config_dword (dev->bus, dev->devfn, where, val);
+}
 
 extern spinlock_t pci_lock;
 
