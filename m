Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316886AbSHPWfa>; Fri, 16 Aug 2002 18:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317616AbSHPWfa>; Fri, 16 Aug 2002 18:35:30 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:16393 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316886AbSHPWf1>;
	Fri, 16 Aug 2002 18:35:27 -0400
Date: Fri, 16 Aug 2002 15:34:51 -0700
From: Greg KH <greg@kroah.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       "'colpatch@us.ibm.com'" <colpatch@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel@vger.kernel.org, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       jgarzik@mandrakesoft.com,
       "Diefenbaugh, Paul S" <paul.s.diefenbaugh@intel.com>, hannal@us.ibm.com
Subject: Re: [patch] PCI Cleanup
Message-ID: <20020816223451.GA6323@kroah.com>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DD92@orsmsx119.jf.intel.com> <Pine.LNX.4.44.0208151014210.849-100000@chaos.physics.uiowa.edu> <20020815163645.GC35918@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020815163645.GC35918@us.ibm.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Fri, 19 Jul 2002 21:12:17 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2002 at 09:36:45AM -0700, Greg KH wrote:
> 
> If there are no complaints, I think I'll go implement this, and move the
> functions into the main pci code so that other parts of the kernel (like
> ACPI) can use them.

Ok, here's the patch that goes on top of Matt's previous patch, moving
the pci_ops functions to be pci_bus based instead of pci_dev, like they
are today.  This enables us to get rid of all of the pci_*_nodev
functions in the pci hotplug core (that's 245 lines removed :)  It's
currently running on the machine I'm typing this from.

I used the devfn as a paramater instead of the function and slot, as
some archs just take the devfn and move it around before using it.  If
there were two paramaters, we would be splitting the values apart, and
then putting them back together for every function.

This is only for i386, if there's no complaints I'll knock out the other
archs before submitting it.

thanks,

greg k-h


diff -Nru a/arch/i386/pci/direct.c b/arch/i386/pci/direct.c
--- a/arch/i386/pci/direct.c	Fri Aug 16 15:31:06 2002
+++ b/arch/i386/pci/direct.c	Fri Aug 16 15:31:06 2002
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
--- a/arch/i386/pci/pcbios.c	Fri Aug 16 15:31:06 2002
+++ b/arch/i386/pci/pcbios.c	Fri Aug 16 15:31:06 2002
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
--- a/drivers/pci/access.c	Fri Aug 16 15:31:06 2002
+++ b/drivers/pci/access.c	Fri Aug 16 15:31:06 2002
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
--- a/include/linux/pci.h	Fri Aug 16 15:31:06 2002
+++ b/include/linux/pci.h	Fri Aug 16 15:31:06 2002
@@ -457,8 +457,8 @@
 /* Low-level architecture-dependent routines */
 
 struct pci_ops {
-	int (*read)(struct pci_dev *, int where, int size, u32 *val);
-	int (*write)(struct pci_dev *, int where, int size, u32 val);
+	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
+	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
 };
 
 struct pbus_set_ranges_data
@@ -557,12 +557,37 @@
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
 
