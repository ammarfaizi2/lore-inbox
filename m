Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264536AbTFWXq2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 19:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264923AbTFWXq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 19:46:28 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:63415 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264536AbTFWXpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 19:45:49 -0400
Date: Mon, 23 Jun 2003 16:59:32 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI fixes for 2.5.73
Message-ID: <20030623235932.GE12207@kroah.com>
References: <20030623235852.GA12207@kroah.com> <20030623235910.GB12207@kroah.com> <20030623235919.GC12207@kroah.com> <20030623235925.GD12207@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030623235925.GD12207@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1348.14.4, 2003/06/23 15:03:31-07:00, willy@debian.org

[PATCH] PCI: pci_raw_ops devfn

Combine the dev and func arguments to pci_raw_ops into devfn which is
more natural all around.


 arch/i386/pci/common.c |    6 ++----
 arch/i386/pci/direct.c |   48 +++++++++++++++++++++++++++---------------------
 arch/i386/pci/numa.c   |   16 ++++++++--------
 arch/i386/pci/pcbios.c |   12 ++++++------
 arch/ia64/pci/pci.c    |   20 ++++++++++----------
 drivers/acpi/osl.c     |    6 ++++--
 include/linux/pci.h    |    4 ++--
 7 files changed, 59 insertions(+), 53 deletions(-)


diff -Nru a/arch/i386/pci/common.c b/arch/i386/pci/common.c
--- a/arch/i386/pci/common.c	Mon Jun 23 16:53:53 2003
+++ b/arch/i386/pci/common.c	Mon Jun 23 16:53:53 2003
@@ -27,14 +27,12 @@
 
 static int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
 {
-	return raw_pci_ops->read(0, bus->number, PCI_SLOT(devfn), 
-		PCI_FUNC(devfn), where, size, value);
+	return raw_pci_ops->read(0, bus->number, devfn, where, size, value);
 }
 
 static int pci_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
 {
-	return raw_pci_ops->write(0, bus->number, PCI_SLOT(devfn), 
-		PCI_FUNC(devfn), where, size, value);
+	return raw_pci_ops->write(0, bus->number, devfn, where, size, value);
 }
 
 struct pci_ops pci_root_ops = {
diff -Nru a/arch/i386/pci/direct.c b/arch/i386/pci/direct.c
--- a/arch/i386/pci/direct.c	Mon Jun 23 16:53:53 2003
+++ b/arch/i386/pci/direct.c	Mon Jun 23 16:53:53 2003
@@ -10,19 +10,19 @@
  * Functions for accessing PCI configuration space with type 1 accesses
  */
 
-#define PCI_CONF1_ADDRESS(bus, dev, fn, reg) \
-	(0x80000000 | (bus << 16) | (dev << 11) | (fn << 8) | (reg & ~3))
+#define PCI_CONF1_ADDRESS(bus, devfn, reg) \
+	(0x80000000 | (bus << 16) | (devfn << 8) | (reg & ~3))
 
-static int pci_conf1_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
+static int pci_conf1_read (int seg, int bus, int devfn, int reg, int len, u32 *value)
 {
 	unsigned long flags;
 
-	if (!value || (bus > 255) || (dev > 31) || (fn > 7) || (reg > 255))
+	if (!value || (bus > 255) || (devfn > 255) || (reg > 255))
 		return -EINVAL;
 
 	spin_lock_irqsave(&pci_config_lock, flags);
 
-	outl(PCI_CONF1_ADDRESS(bus, dev, fn, reg), 0xCF8);
+	outl(PCI_CONF1_ADDRESS(bus, devfn, reg), 0xCF8);
 
 	switch (len) {
 	case 1:
@@ -41,16 +41,16 @@
 	return 0;
 }
 
-static int pci_conf1_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
+static int pci_conf1_write (int seg, int bus, int devfn, int reg, int len, u32 value)
 {
 	unsigned long flags;
 
-	if ((bus > 255) || (dev > 31) || (fn > 7) || (reg > 255)) 
+	if ((bus > 255) || (devfn > 255) || (reg > 255)) 
 		return -EINVAL;
 
 	spin_lock_irqsave(&pci_config_lock, flags);
 
-	outl(PCI_CONF1_ADDRESS(bus, dev, fn, reg), 0xCF8);
+	outl(PCI_CONF1_ADDRESS(bus, devfn, reg), 0xCF8);
 
 	switch (len) {
 	case 1:
@@ -83,13 +83,17 @@
 
 #define PCI_CONF2_ADDRESS(dev, reg)	(u16)(0xC000 | (dev << 8) | reg)
 
-static int pci_conf2_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
+static int pci_conf2_read(int seg, int bus, int devfn, int reg, int len, u32 *value)
 {
 	unsigned long flags;
+	int dev, fn;
 
-	if (!value || (bus > 255) || (dev > 31) || (fn > 7) || (reg > 255))
+	if (!value || (bus > 255) || (devfn > 255) || (reg > 255))
 		return -EINVAL;
 
+	dev = PCI_SLOT(devfn);
+	fn = PCI_FUNC(devfn);
+
 	if (dev & 0x10) 
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
@@ -110,20 +114,24 @@
 		break;
 	}
 
-	outb (0, 0xCF8);
+	outb(0, 0xCF8);
 
 	spin_unlock_irqrestore(&pci_config_lock, flags);
 
 	return 0;
 }
 
-static int pci_conf2_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
+static int pci_conf2_write (int seg, int bus, int devfn, int reg, int len, u32 value)
 {
 	unsigned long flags;
+	int dev, fn;
 
-	if ((bus > 255) || (dev > 31) || (fn > 7) || (reg > 255)) 
+	if ((bus > 255) || (devfn > 255) || (reg > 255)) 
 		return -EINVAL;
 
+	dev = PCI_SLOT(devfn);
+	fn = PCI_FUNC(devfn);
+
 	if (dev & 0x10) 
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
@@ -134,17 +142,17 @@
 
 	switch (len) {
 	case 1:
-		outb ((u8)value, PCI_CONF2_ADDRESS(dev, reg));
+		outb((u8)value, PCI_CONF2_ADDRESS(dev, reg));
 		break;
 	case 2:
-		outw ((u16)value, PCI_CONF2_ADDRESS(dev, reg));
+		outw((u16)value, PCI_CONF2_ADDRESS(dev, reg));
 		break;
 	case 4:
-		outl ((u32)value, PCI_CONF2_ADDRESS(dev, reg));
+		outl((u32)value, PCI_CONF2_ADDRESS(dev, reg));
 		break;
 	}
 
-	outb (0, 0xCF8);    
+	outb(0, 0xCF8);    
 
 	spin_unlock_irqrestore(&pci_config_lock, flags);
 
@@ -178,14 +186,12 @@
 		return 1;
 
 	for (devfn = 0; devfn < 0x100; devfn++) {
-		if (o->read(0, 0, PCI_SLOT(devfn), PCI_FUNC(devfn),
-						PCI_CLASS_DEVICE, 2, &x))
+		if (o->read(0, 0, devfn, PCI_CLASS_DEVICE, 2, &x))
 			continue;
 		if (x == PCI_CLASS_BRIDGE_HOST || x == PCI_CLASS_DISPLAY_VGA)
 			return 1;
 
-		if (o->read(0, 0, PCI_SLOT(devfn), PCI_FUNC(devfn),
-						PCI_VENDOR_ID, 2, &x))
+		if (o->read(0, 0, devfn, PCI_VENDOR_ID, 2, &x))
 			continue;
 		if (x == PCI_VENDOR_ID_INTEL || x == PCI_VENDOR_ID_COMPAQ)
 			return 1;
diff -Nru a/arch/i386/pci/numa.c b/arch/i386/pci/numa.c
--- a/arch/i386/pci/numa.c	Mon Jun 23 16:53:53 2003
+++ b/arch/i386/pci/numa.c	Mon Jun 23 16:53:53 2003
@@ -10,19 +10,19 @@
 #define BUS2LOCAL(global) (mp_bus_id_to_local[global])
 #define QUADLOCAL2BUS(quad,local) (quad_local_to_mp_bus_id[quad][local])
 
-#define PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg) \
-	(0x80000000 | (BUS2LOCAL(bus) << 16) | (dev << 11) | (fn << 8) | (reg & ~3))
+#define PCI_CONF1_MQ_ADDRESS(bus, devfn, reg) \
+	(0x80000000 | (BUS2LOCAL(bus) << 16) | (devfn << 8) | (reg & ~3))
 
-static int pci_conf1_mq_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
+static int pci_conf1_mq_read (int seg, int bus, int devfn, int reg, int len, u32 *value)
 {
 	unsigned long flags;
 
-	if (!value || (bus > MAX_MP_BUSSES) || (dev > 31) || (fn > 7) || (reg > 255))
+	if (!value || (bus > MAX_MP_BUSSES) || (devfn > 255) || (reg > 255))
 		return -EINVAL;
 
 	spin_lock_irqsave(&pci_config_lock, flags);
 
-	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8, BUS2QUAD(bus));
+	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, devfn, reg), 0xCF8, BUS2QUAD(bus));
 
 	switch (len) {
 	case 1:
@@ -41,16 +41,16 @@
 	return 0;
 }
 
-static int pci_conf1_mq_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
+static int pci_conf1_mq_write (int seg, int bus, int devfn, int reg, int len, u32 value)
 {
 	unsigned long flags;
 
-	if ((bus > MAX_MP_BUSSES) || (dev > 31) || (fn > 7) || (reg > 255)) 
+	if ((bus > MAX_MP_BUSSES) || (devfn > 255) || (reg > 255)) 
 		return -EINVAL;
 
 	spin_lock_irqsave(&pci_config_lock, flags);
 
-	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, dev, fn, reg), 0xCF8, BUS2QUAD(bus));
+	outl_quad(PCI_CONF1_MQ_ADDRESS(bus, devfn, reg), 0xCF8, BUS2QUAD(bus));
 
 	switch (len) {
 	case 1:
diff -Nru a/arch/i386/pci/pcbios.c b/arch/i386/pci/pcbios.c
--- a/arch/i386/pci/pcbios.c	Mon Jun 23 16:53:53 2003
+++ b/arch/i386/pci/pcbios.c	Mon Jun 23 16:53:53 2003
@@ -172,13 +172,13 @@
 	return (int) (ret & 0xff00) >> 8;
 }
 
-static int pci_bios_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
+static int pci_bios_read (int seg, int bus, int devfn, int reg, int len, u32 *value)
 {
 	unsigned long result = 0;
 	unsigned long flags;
-	unsigned long bx = ((bus << 8) | (dev << 3) | fn);
+	unsigned long bx = (bus << 8) | devfn;
 
-	if (!value || (bus > 255) || (dev > 31) || (fn > 7) || (reg > 255))
+	if (!value || (bus > 255) || (devfn > 255) || (reg > 255))
 		return -EINVAL;
 
 	spin_lock_irqsave(&pci_config_lock, flags);
@@ -227,13 +227,13 @@
 	return (int)((result & 0xff00) >> 8);
 }
 
-static int pci_bios_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
+static int pci_bios_write (int seg, int bus, int devfn, int reg, int len, u32 value)
 {
 	unsigned long result = 0;
 	unsigned long flags;
-	unsigned long bx = ((bus << 8) | (dev << 3) | fn);
+	unsigned long bx = (bus << 8) | devfn;
 
-	if ((bus > 255) || (dev > 31) || (fn > 7) || (reg > 255)) 
+	if ((bus > 255) || (devfn > 255) || (reg > 255)) 
 		return -EINVAL;
 
 	spin_lock_irqsave(&pci_config_lock, flags);
diff -Nru a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
--- a/arch/ia64/pci/pci.c	Mon Jun 23 16:53:53 2003
+++ b/arch/ia64/pci/pci.c	Mon Jun 23 16:53:53 2003
@@ -53,21 +53,21 @@
  * synchronization mechanism here.
  */
 
-#define PCI_SAL_ADDRESS(seg, bus, dev, fn, reg) \
+#define PCI_SAL_ADDRESS(seg, bus, devfn, reg) \
 	((u64)(seg << 24) | (u64)(bus << 16) | \
-	 (u64)(dev << 11) | (u64)(fn << 8) | (u64)(reg))
+	 (u64)(devfn << 8) | (u64)(reg))
 
 
 static int
-pci_sal_read (int seg, int bus, int dev, int fn, int reg, int len, u32 *value)
+pci_sal_read (int seg, int bus, int devfn, int reg, int len, u32 *value)
 {
 	int result = 0;
 	u64 data = 0;
 
-	if (!value || (seg > 255) || (bus > 255) || (dev > 31) || (fn > 7) || (reg > 255))
+	if (!value || (seg > 255) || (bus > 255) || (devfn > 255) || (reg > 255))
 		return -EINVAL;
 
-	result = ia64_sal_pci_config_read(PCI_SAL_ADDRESS(seg, bus, dev, fn, reg), len, &data);
+	result = ia64_sal_pci_config_read(PCI_SAL_ADDRESS(seg, bus, devfn, reg), len, &data);
 
 	*value = (u32) data;
 
@@ -75,12 +75,12 @@
 }
 
 static int
-pci_sal_write (int seg, int bus, int dev, int fn, int reg, int len, u32 value)
+pci_sal_write (int seg, int bus, int devfn, int reg, int len, u32 value)
 {
-	if ((seg > 255) || (bus > 255) || (dev > 31) || (fn > 7) || (reg > 255))
+	if ((seg > 255) || (bus > 255) || (devfn > 255) || (reg > 255))
 		return -EINVAL;
 
-	return ia64_sal_pci_config_write(PCI_SAL_ADDRESS(seg, bus, dev, fn, reg), len, value);
+	return ia64_sal_pci_config_write(PCI_SAL_ADDRESS(seg, bus, devfn, reg), len, value);
 }
 
 struct pci_raw_ops pci_sal_ops = {
@@ -95,14 +95,14 @@
 pci_read (struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
 {
 	return raw_pci_ops->read(pci_domain_nr(bus), bus->number,
-			PCI_SLOT(devfn), PCI_FUNC(devfn), where, size, value);
+			devfn, where, size, value);
 }
 
 static int
 pci_write (struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
 {
 	return raw_pci_ops->write(pci_domain_nr(bus), bus->number,
-			PCI_SLOT(devfn), PCI_FUNC(devfn), where, size, value);
+			devfn, where, size, value);
 }
 
 static struct pci_ops pci_root_ops = {
diff -Nru a/drivers/acpi/osl.c b/drivers/acpi/osl.c
--- a/drivers/acpi/osl.c	Mon Jun 23 16:53:53 2003
+++ b/drivers/acpi/osl.c	Mon Jun 23 16:53:53 2003
@@ -466,7 +466,8 @@
 	}
 
 	result = raw_pci_ops->read(pci_id->segment, pci_id->bus,
-			pci_id->device, pci_id->function, reg, size, value);
+				PCI_DEVFN(pci_id->device, pci_id->function),
+				reg, size, value);
 
 	return (result ? AE_ERROR : AE_OK);
 }
@@ -491,7 +492,8 @@
 	}
 
 	result = raw_pci_ops->write(pci_id->segment, pci_id->bus,
-			pci_id->device, pci_id->function, reg, size, value);
+				PCI_DEVFN(pci_id->device, pci_id->function),
+				reg, size, value);
 
 	return (result ? AE_ERROR : AE_OK);
 }
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Mon Jun 23 16:53:53 2003
+++ b/include/linux/pci.h	Mon Jun 23 16:53:53 2003
@@ -487,8 +487,8 @@
 };
 
 struct pci_raw_ops {
-	int (*read)(int dom, int bus, int dev, int func, int reg, int len, u32 *val);
-	int (*write)(int dom, int bus, int dev, int func, int reg, int len, u32 val);
+	int (*read)(int dom, int bus, int devfn, int reg, int len, u32 *val);
+	int (*write)(int dom, int bus, int devfn, int reg, int len, u32 val);
 };
 
 extern struct pci_raw_ops *raw_pci_ops;
