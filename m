Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317641AbSH3WMX>; Fri, 30 Aug 2002 18:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317876AbSH3WLo>; Fri, 30 Aug 2002 18:11:44 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:32787 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317641AbSH3WIF>;
	Fri, 30 Aug 2002 18:08:05 -0400
Date: Fri, 30 Aug 2002 15:11:28 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] PCI ops cleanups for 2.5.32-bk
Message-ID: <20020830221127.GH10783@kroah.com>
References: <20020830220720.GA10783@kroah.com> <20020830220846.GB10783@kroah.com> <20020830220912.GC10783@kroah.com> <20020830220931.GD10783@kroah.com> <20020830221017.GE10783@kroah.com> <20020830221044.GF10783@kroah.com> <20020830221107.GG10783@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020830221107.GG10783@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.548   -> 1.549  
#	arch/mips/ddb5xxx/ddb5477/pci_ops.c	1.1     -> 1.2    
#	arch/mips/ddb5476/pci.c	1.3     -> 1.4    
#	arch/mips/mips-boards/generic/pci.c	1.3     -> 1.4    
#	arch/mips/ddb5074/pci.c	1.4     -> 1.5    
#	arch/mips/gt64120/common/pci.c	1.3     -> 1.4    
#	 arch/mips/sni/pci.c	1.4     -> 1.5    
#	arch/mips/ite-boards/generic/it8172_pci.c	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/30	hannal@us.ibm.com	1.549
# [PATCH] PCI: mips pci_ops changes
# 
# mips pci ops changes
# --------------------------------------------
#
diff -Nru a/arch/mips/ddb5074/pci.c b/arch/mips/ddb5074/pci.c
--- a/arch/mips/ddb5074/pci.c	Fri Aug 30 15:00:21 2002
+++ b/arch/mips/ddb5074/pci.c	Fri Aug 30 15:00:21 2002
@@ -43,137 +43,118 @@
 }
 
 
-static int nile4_pci_read_config_dword(struct pci_dev *dev,
-				       int where, u32 * val)
+static int nile4_pci_read(struct pci_bus *bus, unsigned int devfn, int where, 
+			  int size, u32 * val)
 {
-	int slot_num, func_num;
-	u32 base;
+	int status, slot_num, func_num;
+	u32 result, base;
 
-	/*
-	 *  For starters let's do configuration cycle 0 only (one bus only)
-	 */
-	if (dev->bus->number)
-		return PCIBIOS_FUNC_NOT_SUPPORTED;
-
-	slot_num = PCI_SLOT(dev->devfn);
-	func_num = PCI_FUNC(dev->devfn);
-	if (slot_num == 5) {
-		/*
-		 * This is Nile 4 and it will crash if we access it like other
-		 * devices
-		 */
-		*val = nile4_in32(NILE4_PCI_BASE + where);
-		return PCIBIOS_SUCCESSFUL;
+	switch (size) {
+		case 4:
+			/*
+	 		 *  For starters let's do configuration cycle 0 only 
+			 *  (one bus only)
+	 		*/
+			if (bus->number)
+				return PCIBIOS_FUNC_NOT_SUPPORTED;
+
+			slot_num = PCI_SLOT(devfn);
+			func_num = PCI_FUNC(devfn);
+			if (slot_num == 5) {
+				/*
+		 	 	* This is Nile 4 and it will crash if we access it 
+			 	* like other devices
+		 	 	*/
+				*val = nile4_in32(NILE4_PCI_BASE + where);
+				return PCIBIOS_SUCCESSFUL;
+			}
+			base = nile4_pre_pci_access0(slot_num);
+			*val = *((volatile u32 *) (base + (func_num << 8) + 
+					   (where & 0xfc)));
+			nile4_post_pci_access0();
+			return PCIBIOS_SUCCESSFUL;
+
+		case 2:
+			status = nile4_pci_read(bus, devfn, where, 4, &result);
+			if (status != PCIBIOS_SUCCESSFUL)
+				return status;
+			if (where & 2)
+				result >>= 16;
+			*val = (u16)(result & 0xffff);
+			break;
+		case 1:
+			status = nile4_pci_read(bus, devfn, where, 4, &result);
+			if (status != PCIBIOS_SUCCESSFUL)
+				return status;
+			if (where & 1)
+				result >>= 8;
+			if (where & 2)
+				result >>= 16;
+			*val = (u8)(result & 0xff);
+			break;
 	}
-	base = nile4_pre_pci_access0(slot_num);
-	*val =
-	    *((volatile u32 *) (base + (func_num << 8) + (where & 0xfc)));
-	nile4_post_pci_access0();
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int nile4_pci_write_config_dword(struct pci_dev *dev, int where,
-					u32 val)
-{
-	int slot_num, func_num;
-	u32 base;
-
-	/*
-	 * For starters let's do configuration cycle 0 only (one bus only)
-	 */
-	if (dev->bus->number)
-		return PCIBIOS_FUNC_NOT_SUPPORTED;
-
-	slot_num = PCI_SLOT(dev->devfn);
-	func_num = PCI_FUNC(dev->devfn);
-	if (slot_num == 5) {
-		/*
-		 * This is Nile 4 and it will crash if we access it like other
-		 * devices
-		 */
-		nile4_out32(NILE4_PCI_BASE + where, val);
-		return PCIBIOS_SUCCESSFUL;
-	}
-	base = nile4_pre_pci_access0(slot_num);
-	*((volatile u32 *) (base + (func_num << 8) + (where & 0xfc))) =
-	    val;
-	nile4_post_pci_access0();
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int nile4_pci_read_config_word(struct pci_dev *dev, int where,
-				      u16 * val)
-{
-	int status;
-	u32 result;
-
-	status = nile4_pci_read_config_dword(dev, where, &result);
-	if (status != PCIBIOS_SUCCESSFUL)
-		return status;
-	if (where & 2)
-		result >>= 16;
-	*val = result & 0xffff;
-	return PCIBIOS_SUCCESSFUL;
-}
 
-static int nile4_pci_read_config_byte(struct pci_dev *dev, int where,
-				      u8 * val)
+static int nile4_pci_write(struct pci_bus *bus, unsigned int devfn, int where, 
+			   int size, u32 val)
 {
-	int status;
-	u32 result;
+	int status, slot_num, func_num, shift = 0;
+	u32 result, base;
 
-	status = nile4_pci_read_config_dword(dev, where, &result);
-	if (status != PCIBIOS_SUCCESSFUL)
-		return status;
-	if (where & 1)
-		result >>= 8;
-	if (where & 2)
-		result >>= 16;
-	*val = result & 0xff;
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int nile4_pci_write_config_word(struct pci_dev *dev, int where,
-				       u16 val)
-{
-	int status, shift = 0;
-	u32 result;
-
-	status = nile4_pci_read_config_dword(dev, where, &result);
-	if (status != PCIBIOS_SUCCESSFUL)
-		return status;
-	if (where & 2)
-		shift += 16;
-	result &= ~(0xffff << shift);
-	result |= val << shift;
-	return nile4_pci_write_config_dword(dev, where, result);
-}
-
-static int nile4_pci_write_config_byte(struct pci_dev *dev, int where,
-				       u8 val)
-{
-	int status, shift = 0;
-	u32 result;
-
-	status = nile4_pci_read_config_dword(dev, where, &result);
-	if (status != PCIBIOS_SUCCESSFUL)
-		return status;
-	if (where & 2)
-		shift += 16;
-	if (where & 1)
-		shift += 8;
-	result &= ~(0xff << shift);
-	result |= val << shift;
-	return nile4_pci_write_config_dword(dev, where, result);
+	switch (size) {
+		case 4:
+			/*
+	 		 * For starters let's do configuration cycle 0 only 
+			 * (one bus only)
+	 		 */
+			if (bus->number)
+				return PCIBIOS_FUNC_NOT_SUPPORTED;
+
+			slot_num = PCI_SLOT(devfn);
+			func_num = PCI_FUNC(devfn);
+			if (slot_num == 5) {
+				/*
+		 	 	 * This is Nile 4 and it will crash if we access 
+				 * it like other devices
+		 	 	*/
+				nile4_out32(NILE4_PCI_BASE + where, val);
+				return PCIBIOS_SUCCESSFUL;
+			}
+			base = nile4_pre_pci_access0(slot_num);
+			*((volatile u32 *) (base + (func_num << 8) + 
+					    (where & 0xfc))) = val;
+			nile4_post_pci_access0();
+			return PCIBIOS_SUCCESSFUL;
+
+		case 2:
+			status = nile4_pci_read(bus, devfn, where, 4, &result);
+			if (status != PCIBIOS_SUCCESSFUL)
+				return status;
+			if (where & 2)
+				shift += 16;
+			result &= ~(0xffff << shift);
+			result |= (u16)(val << shift);
+			break;
+		case 1:
+			status = nile4_pci_read(bus, devfn, where, 4, &result);
+			if (status != PCIBIOS_SUCCESSFUL)
+				return status;
+			if (where & 2)
+				shift += 16;
+			if (where & 1)
+				shift += 8;
+			result &= ~(0xff << shift);
+			result |= (u8)(val << shift);
+			break;
+	}
+	return nile4_pci_write(bus, devfn, where, 4, result);
 }
 
 struct pci_ops nile4_pci_ops = {
-	nile4_pci_read_config_byte,
-	nile4_pci_read_config_word,
-	nile4_pci_read_config_dword,
-	nile4_pci_write_config_byte,
-	nile4_pci_write_config_word,
-	nile4_pci_write_config_dword
+	.read = 	nile4_pci_read,
+	.write = 	nile4_pci_write,
 };
 
 struct {
diff -Nru a/arch/mips/ddb5476/pci.c b/arch/mips/ddb5476/pci.c
--- a/arch/mips/ddb5476/pci.c	Fri Aug 30 15:00:21 2002
+++ b/arch/mips/ddb5476/pci.c	Fri Aug 30 15:00:21 2002
@@ -51,145 +51,106 @@
 	nile4_set_pmr(NILE4_PCIINIT1, NILE4_PCICMD_MEM, 0x08000000);
 }
 
-
-static int nile4_pci_read_config_dword(struct pci_dev *dev,
-				       int where, u32 * val)
+static int nile4_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
+			 int size, u32 * val)
 {
-	int slot_num, func_num;
-	u32 base;
-	u32 addr;
-
-	/*
-	 *  Do we need to generate type 1 configure transaction?
-	 */
-	if (dev->bus->number) {
-		/* FIXME - not working yet */
-		return PCIBIOS_FUNC_NOT_SUPPORTED;
-
-		/*
-		 * the largest type 1 configuration addr is 16M, < 256M
-		 * config space
-		 */
-		slot_num = 0;
-		addr =
-		    (dev->bus->number << 16) | (dev->devfn <
-						8) | where | 1;
-	} else {
-		slot_num = PCI_SLOT(dev->devfn);
-		func_num = PCI_FUNC(dev->devfn);
-		addr = (func_num << 8) + where;
-	}
+	int status, slot_num, func_num;
+	u32 result, base, addr;
 
-	base = nile4_pre_pci_access0(slot_num);
-	*val = *(volatile u32 *) (base + addr);
-	nile4_post_pci_access0();
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int nile4_pci_write_config_dword(struct pci_dev *dev, int where,
-					u32 val)
-{
-	int slot_num, func_num;
-	u32 base;
-	u32 addr;
-
-	/*
-	 *  Do we need to generate type 1 configure transaction?
-	 */
-	if (dev->bus->number) {
-		/* FIXME - not working yet */
-		return PCIBIOS_FUNC_NOT_SUPPORTED;
-
-		/* the largest type 1 configuration addr is 16M, < 256M config space */
-		slot_num = 0;
-		addr =
-		    (dev->bus->number << 16) | (dev->devfn <
-						8) | where | 1;
-	} else {
-		slot_num = PCI_SLOT(dev->devfn);
-		func_num = PCI_FUNC(dev->devfn);
-		addr = (func_num << 8) + where;
+	if(size == 4) {
+		/* Do we need to generate type 1 configure transaction? */
+		if (bus->number) {
+			/* FIXME - not working yet */
+			return PCIBIOS_FUNC_NOT_SUPPORTED;
+			/*
+			 * the largest type 1 configuration addr is 16M, 
+			 * < 256M config space 
+			 */
+			slot_num = 0;
+			addr = (bus->number << 16) | (devfn < 8) | where | 1;
+		} else {
+			slot_num = PCI_SLOT(devfn);
+			func_num = PCI_FUNC(devfn);
+			addr = (func_num << 8) + where;
+		}
+		base = nile4_pre_pci_access0(slot_num);
+		*val = *(volatile u32 *) (base + addr);
+		nile4_post_pci_access0();
+		return PCIBIOS_SUCCESSFUL;
 	}
 
-	base = nile4_pre_pci_access0(slot_num);
-	*(volatile u32 *) (base + addr) = val;
-	nile4_post_pci_access0();
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int nile4_pci_read_config_word(struct pci_dev *dev, int where,
-				      u16 * val)
-{
-	int status;
-	u32 result;
-
-	status = nile4_pci_read_config_dword(dev, where & ~3, &result);
-	if (status != PCIBIOS_SUCCESSFUL)
-		return status;
-	if (where & 2)
-		result >>= 16;
-	*val = result & 0xffff;
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int nile4_pci_read_config_byte(struct pci_dev *dev, int where,
-				      u8 * val)
-{
-	int status;
-	u32 result;
-
-	status = nile4_pci_read_config_dword(dev, where & ~3, &result);
+	status = nile4_pci_read(bus, devfn, where & ~3, 4, &result);
 	if (status != PCIBIOS_SUCCESSFUL)
 		return status;
-	if (where & 1)
-		result >>= 8;
-	if (where & 2)
-		result >>= 16;
-	*val = result & 0xff;
+	switch (size) {
+		case 1:
+			if (where & 1)
+				result >>= 8;
+			if (where & 2)
+				result >>= 16;
+			*val = (u8)(result & 0xff);
+			break;
+		case 2:
+			if (where & 2)
+				result >>= 16;
+			*val = (u16)(result & 0xffff);
+			break;
+	}
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int nile4_pci_write_config_word(struct pci_dev *dev, int where,
-				       u16 val)
+static int nile4_pci_write(struct pci_bus *bus, unsigned int devfn, int where,
+			  int size, u32 val)
 {
-	int status, shift = 0;
-	u32 result;
+	int status, slot_num, func_num, shift = 0;
+	u32 result, base, addr;
 
-	status = nile4_pci_read_config_dword(dev, where & ~3, &result);
+	status = nile4_pci_read(bus, devfn, where & ~3, 4, &result);
 	if (status != PCIBIOS_SUCCESSFUL)
 		return status;
-	if (where & 2)
-		shift += 16;
-	result &= ~(0xffff << shift);
-	result |= val << shift;
-	return nile4_pci_write_config_dword(dev, where & ~3, result);
-}
-
-static int nile4_pci_write_config_byte(struct pci_dev *dev, int where,
-				       u8 val)
-{
-	int status, shift = 0;
-	u32 result;
-
-	status = nile4_pci_read_config_dword(dev, where & ~3, &result);
-	if (status != PCIBIOS_SUCCESSFUL)
-		return status;
-	if (where & 2)
-		shift += 16;
-	if (where & 1)
-		shift += 8;
-	result &= ~(0xff << shift);
-	result |= val << shift;
-	return nile4_pci_write_config_dword(dev, where & ~3, result);
+	switch (size) {
+		case 1:
+			if (where & 2)
+				shift += 16;
+			if (where & 1)
+				shift += 8;
+			result &= ~(0xff << shift);
+			result |= val << shift;
+			break;
+		case 2:
+			if (where & 2)
+				shift += 16;
+			result &= ~(0xffff << shift);
+			result |= val << shift;
+			break;
+		case 4:
+			/* Do we need to generate type 1 configure transaction? */
+			if (bus->number) {
+				/* FIXME - not working yet */
+				return PCIBIOS_FUNC_NOT_SUPPORTED;
+
+				/* the largest type 1 configuration addr is 16M, 
+				 * < 256M config space */
+				slot_num = 0;
+				addr = (bus->number << 16) | (devfn < 8) | 
+					where | 1;
+			} else {
+				slot_num = PCI_SLOT(devfn);
+				func_num = PCI_FUNC(devfn);
+				addr = (func_num << 8) + where;
+			}
+
+			base = nile4_pre_pci_access0(slot_num);
+			*(volatile u32 *) (base + addr) = val;
+			nile4_post_pci_access0();
+			return PCIBIOS_SUCCESSFUL;
+	}
+	return nile4_pci_write(bus, devfn, where & ~3, 4, result);
 }
 
 struct pci_ops nile4_pci_ops = {
-	nile4_pci_read_config_byte,
-	nile4_pci_read_config_word,
-	nile4_pci_read_config_dword,
-	nile4_pci_write_config_byte,
-	nile4_pci_write_config_word,
-	nile4_pci_write_config_dword
+	.read = 	nile4_pci_read,
+	.write = 	nile4_pci_write,
 };
 
 struct {
@@ -274,13 +235,13 @@
 
 			pci_pmu = dev;	/* for LEDs D2 and D3 */
 			/* Program the lines for LEDs D2 and D3 to output */
-			nile4_pci_read_config_byte(dev, 0x7d, &t8);
+			nile4_pci_read(dev->bus, dev->devfn, 0x7d, 1, &t8);
 			t8 |= 0xc0;
-			nile4_pci_write_config_byte(dev, 0x7d, t8);
+			nile4_pci_write(dev->bus, dev->devfn, 0x7d, 1, t8);
 			/* Turn LEDs D2 and D3 off */
-			nile4_pci_read_config_byte(dev, 0x7e, &t8);
+			nile4_pci_read(dev->bus, dev->devfn, 0x7e, 1, &t8);
 			t8 |= 0xc0;
-			nile4_pci_write_config_byte(dev, 0x7e, t8);
+			nile4_pci_write(dev->bus, dev->devfn, 0x7e, 1, t8);
 		} else if (dev->vendor == PCI_VENDOR_ID_AL &&
 			   dev->device == 0x5229) {
 			int i;
diff -Nru a/arch/mips/ddb5xxx/ddb5477/pci_ops.c b/arch/mips/ddb5xxx/ddb5477/pci_ops.c
--- a/arch/mips/ddb5xxx/ddb5477/pci_ops.c	Fri Aug 30 15:00:21 2002
+++ b/arch/mips/ddb5xxx/ddb5477/pci_ops.c	Fri Aug 30 15:00:21 2002
@@ -134,173 +134,138 @@
 	ddb_out32(swap->pmr, swap->pmr_backup);
 }
 
-static int read_config_dword(struct pci_config_swap *swap,
-			     struct pci_dev *dev,
+static int read_config(struct pci_config_swap *swap,
+			     struct pci_bus *bus,
+			     unsigned int devfn,
 			     u32 where,
+			     int size,
 			     u32 *val)
 {
-	u32 bus, slot_num, func_num;
-	u32 base;
+	u32 busnum, slot_num, func_num, base, result;
+	int status	
 
-	MIPS_ASSERT((where & 3) == 0);
-	MIPS_ASSERT(where < (1 << 8));
-
-	/* check if the bus is top-level */
-	if (dev->bus->parent != NULL) {
-		bus = dev->bus->number;
-		MIPS_ASSERT(bus != 0);
-	} else {
-		bus = 0;
+	switch (size) {
+		case 4:
+			MIPS_ASSERT((where & 3) == 0);
+			MIPS_ASSERT(where < (1 << 8));
+
+			/* check if the bus is top-level */
+			if (bus->parent != NULL) {
+				busnum = bus->number;
+				MIPS_ASSERT(busnum != 0);
+			} else {
+				busnum = 0;
+			}
+
+			slot_num = PCI_SLOT(devfn);
+			func_num = PCI_FUNC(devfn);
+			base = ddb_access_config_base(swap, busnum, slot_num);
+			*val = *(volatile u32*) (base + (func_num << 8) + where);
+			ddb_close_config_base(swap);
+			return PCIBIOS_SUCCESSFUL;
+
+		case 2:
+			MIPS_ASSERT((where & 1) == 0);
+
+        		status = read_config(swap, bus, devfn, where & ~3, 4,
+					     &result);
+        		if (where & 2) result >>= 16;
+        		*val = (u16)(result & 0xffff);
+        		return status;
+
+		case 1:
+        		status = read_config(swap, bus, devfn, where & ~3, 4,
+					     &result);
+        		if (where & 1) result >>= 8;
+        		if (where & 2) result >>= 16;
+        		*val = (u8)(result & 0xff);
+        		return status;
 	}
-
-	slot_num = PCI_SLOT(dev->devfn);
-	func_num = PCI_FUNC(dev->devfn);
-	base = ddb_access_config_base(swap, bus, slot_num);
-	*val = *(volatile u32*) (base + (func_num << 8) + where);
-	ddb_close_config_base(swap);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int read_config_word(struct pci_config_swap *swap,
-			    struct pci_dev *dev,
-			    u32 where,
-			    u16 *val)
-{
-        int status;
-        u32 result;
-
-	MIPS_ASSERT((where & 1) == 0);
-
-        status = read_config_dword(swap, dev, where & ~3, &result);
-        if (where & 2) result >>= 16;
-        *val = result & 0xffff;
-        return status;
 }
 
-static int read_config_byte(struct pci_config_swap *swap,
-			    struct pci_dev *dev,
-			    u32 where,
-			    u8 *val)
-{
-        int status;
-        u32 result;
-
-        status = read_config_dword(swap, dev, where & ~3, &result);
-        if (where & 1) result >>= 8;
-        if (where & 2) result >>= 16;
-        *val = result & 0xff;
-        return status;
-}
-
-static int write_config_dword(struct pci_config_swap *swap,
-			      struct pci_dev *dev,
+static int write_config(struct pci_config_swap *swap,
+			      struct pci_bus *bus,
+			      unsigned int devfn,
 			      u32 where,
+			      int size,
 			      u32 val)
 {
-	u32 bus, slot_num, func_num;
-	u32 base;
+	u32 busnum, slot_num, func_num, base, results;
+	int status, shift = 0;	
 
-	MIPS_ASSERT((where & 3) == 0);
-	MIPS_ASSERT(where < (1 << 8));
-
-	/* check if the bus is top-level */
-	if (dev->bus->parent != NULL) {
-		bus = dev->bus->number;
-		MIPS_ASSERT(bus != 0);
-	} else {
-		bus = 0;
+	switch (size) {
+		case 4:
+			MIPS_ASSERT((where & 3) == 0);
+			MIPS_ASSERT(where < (1 << 8));
+
+			/* check if the bus is top-level */
+			if (bus->parent != NULL) {
+				busnum = bus->number;
+				MIPS_ASSERT(busnum != 0);
+			} else {
+				busnum = 0;
+			}
+
+			slot_num = PCI_SLOT(devfn);
+			func_num = PCI_FUNC(devfn);
+			base = ddb_access_config_base(swap, busnum, slot_num);
+			*(volatile u32*) (base + (func_num << 8) + where) = val; 
+			ddb_close_config_base(swap);
+			return PCIBIOS_SUCCESSFUL;
+
+		case 2:
+			MIPS_ASSERT((where & 1) == 0);
+
+			status = read_config(swap, bus, devfn, where & ~3, 4, 
+					     &result);
+			if (status != PCIBIOS_SUCCESSFUL) return status;
+
+        		if (where & 2)
+                		shift += 16;
+        		result &= ~(0xffff << shift);
+        		result |= (u16)(val << shift);
+        		return write_config(swap, bus, devfn, where & ~3, size, 
+					    result);
+
+		case 1:
+			status = read_config(swap, bus, devfn, where & ~3, 4,
+					    &result);
+			if (status != PCIBIOS_SUCCESSFUL) return status;
+
+        		if (where & 2)
+                		shift += 16;
+        		if (where & 1)
+                		shift += 8;
+        		result &= ~(0xff << shift);
+        		result |= (u8)(val << shift);
+        		return write_config(swap, bus, devfn, where & ~3, size, 
+					    result);
 	}
-
-	slot_num = PCI_SLOT(dev->devfn);
-	func_num = PCI_FUNC(dev->devfn);
-	base = ddb_access_config_base(swap, bus, slot_num);
-	*(volatile u32*) (base + (func_num << 8) + where) = val; 
-	ddb_close_config_base(swap);
-	return PCIBIOS_SUCCESSFUL;
 }
 
-static int write_config_word(struct pci_config_swap *swap,
-			     struct pci_dev *dev,
-			     u32 where,
-			     u16 val)
-{
-	int status, shift=0;
-	u32 result;
-
-	MIPS_ASSERT((where & 1) == 0);
-
-	status = read_config_dword(swap, dev, where & ~3, &result);
-	if (status != PCIBIOS_SUCCESSFUL) return status;
-
-        if (where & 2)
-                shift += 16;
-        result &= ~(0xffff << shift);
-        result |= val << shift;
-        return write_config_dword(swap, dev, where & ~3, result);
-}
-
-static int write_config_byte(struct pci_config_swap *swap,
-			     struct pci_dev *dev,
-			     u32 where,
-			     u8 val)
-{
-	int status, shift=0;
-	u32 result;
-
-	status = read_config_dword(swap, dev, where & ~3, &result);
-	if (status != PCIBIOS_SUCCESSFUL) return status;
-
-        if (where & 2)
-                shift += 16;
-        if (where & 1)
-                shift += 8;
-        result &= ~(0xff << shift);
-        result |= val << shift;
-        return write_config_dword(swap, dev, where & ~3, result);
-}
-
-#define	MAKE_PCI_OPS(prefix, rw, unitname, unittype, pciswap) \
-static int prefix##_##rw##_config_##unitname(struct pci_dev *dev, int where, unittype val) \
+#define	MAKE_PCI_OPS(prefix, rw, pciswap) \
+static int prefix##_##rw##_config(struct pci_bus *bus, unsigned int devfn, \
+				  int where, int size, u32 val) \
 { \
-     return rw##_config_##unitname(pciswap, \
-                                   dev, \
-                                   where, \
-                                   val); \
+     return rw##_config(pciswap, bus, devfn, \
+                                   where, size, val); \
 }
 
-MAKE_PCI_OPS(extpci, read, byte, u8 *, &ext_pci_swap)
-MAKE_PCI_OPS(extpci, read, word, u16 *, &ext_pci_swap)
-MAKE_PCI_OPS(extpci, read, dword, u32 *, &ext_pci_swap)
-
-MAKE_PCI_OPS(iopci, read, byte, u8 *, &io_pci_swap)
-MAKE_PCI_OPS(iopci, read, word, u16 *, &io_pci_swap)
-MAKE_PCI_OPS(iopci, read, dword, u32 *, &io_pci_swap)
-
-MAKE_PCI_OPS(extpci, write, byte, u8, &ext_pci_swap)
-MAKE_PCI_OPS(extpci, write, word, u16, &ext_pci_swap)
-MAKE_PCI_OPS(extpci, write, dword, u32, &ext_pci_swap)
-
-MAKE_PCI_OPS(iopci, write, byte, u8, &io_pci_swap)
-MAKE_PCI_OPS(iopci, write, word, u16, &io_pci_swap)
-MAKE_PCI_OPS(iopci, write, dword, u32, &io_pci_swap)
+MAKE_PCI_OPS(extpci, read, &ext_pci_swap)
+MAKE_PCI_OPS(extpci, write, &ext_pci_swap)
+
+MAKE_PCI_OPS(iopci, read, &io_pci_swap)
+MAKE_PCI_OPS(iopci, write, &io_pci_swap)
 
 struct pci_ops ddb5477_ext_pci_ops ={
-	extpci_read_config_byte,
-	extpci_read_config_word,
-	extpci_read_config_dword,
-	extpci_write_config_byte,
-	extpci_write_config_word,
-	extpci_write_config_dword
+	.read = 	extpci_read_config,
+	.write = 	extpci_write_config,
 };
 
 
 struct pci_ops ddb5477_io_pci_ops ={
-	iopci_read_config_byte,
-	iopci_read_config_word,
-	iopci_read_config_dword,
-	iopci_write_config_byte,
-	iopci_write_config_word,
-	iopci_write_config_dword
+	.read = 	iopci_read_config,
+	.write = 	iopci_write_config,
 };
 
 #if defined(CONFIG_LL_DEBUG)
diff -Nru a/arch/mips/gt64120/common/pci.c b/arch/mips/gt64120/common/pci.c
--- a/arch/mips/gt64120/common/pci.c	Fri Aug 30 15:00:21 2002
+++ b/arch/mips/gt64120/common/pci.c	Fri Aug 30 15:00:21 2002
@@ -108,18 +108,10 @@
 
 
 /*  Functions to implement "pci ops"  */
-static int galileo_pcibios_read_config_word(struct pci_dev *dev,
-					    int offset, u16 * val);
-static int galileo_pcibios_read_config_byte(struct pci_dev *dev,
-					    int offset, u8 * val);
-static int galileo_pcibios_read_config_dword(struct pci_dev *dev,
-					     int offset, u32 * val);
-static int galileo_pcibios_write_config_byte(struct pci_dev *dev,
-					     int offset, u8 val);
-static int galileo_pcibios_write_config_word(struct pci_dev *dev,
-					     int offset, u16 val);
-static int galileo_pcibios_write_config_dword(struct pci_dev *dev,
-					      int offset, u32 val);
+static int galileo_pcibios_read(struct pci_bus *bus, unsigned int devfn,
+			       	int offset, int size, u32 * val);
+static int galileo_pcibios_write(struct pci_bus *bus, unsigned int devfn,
+				int offset, int size, u32 val);
 static void galileo_pcibios_set_master(struct pci_dev *dev);
 
 /*
@@ -609,15 +601,16 @@
 
 
 /*
- * galileo_pcibios_(read/write)_config_(dword/word/byte) -
+ * galileo_pcibios_(read/write) -
  *
  * reads/write a dword/word/byte register from the configuration space
  * of a device.
  *
  * Inputs :
  * bus - bus number
- * dev - device number
+ * devfn - device function index
  * offset - register offset in the configuration space
+ * size - size of value (1=byte,2=word,4-dword)
  * val - value to be written / read
  *
  * Outputs :
@@ -626,165 +619,106 @@
  * PCIBIOS_BAD_REGISTER_NUMBER when accessing non aligned
  */
 
-static int galileo_pcibios_read_config_dword(struct pci_dev *device,
-					     int offset, u32 * val)
+static int galileo_pcibios_read (struct pci_bus *bus, unsigned int devfn, int offset, int size, u32 * val)
 {
-	int dev, bus;
-	bus = device->bus->number;
-	dev = PCI_SLOT(device->devfn);
+	int dev, busnum;
 
-	if (pci_range_ck(bus, dev)) {
-		*val = 0xffffffff;
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
-	if (offset & 0x3)
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-	if (bus == 0)
-		*val = pci0ReadConfigReg(offset, device);
+	busnum = bus->number;
+	dev = PCI_SLOT(devfn);
 
-	/*  This is so that the upper PCI layer will get the correct return value if
-	   we're not attached to anything.  */
-	if ((offset == 0) && (*val == 0xffffffff)) {
+	if (pci_range_ck(busnum, dev)) {
+		if(size == 1)
+			*val = (u8)0xff;
+		else if (size == 2)
+			*val = (u16)0xffff;
+		else if (size == 4)
+			*val = 0xffffffff;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int galileo_pcibios_read_config_word(struct pci_dev *device,
-					    int offset, u16 * val)
-{
-	int dev, bus;
-
-	bus = device->bus->number;
-	dev = PCI_SLOT(device->devfn);
-
-	if (pci_range_ck(bus, dev)) {
-		*val = 0xffff;
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
-	if (offset & 0x1)
+	if ((size == 2) && (offset & 0x1))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	else if ((size == 4) && (offset & 0x3))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 
-	if (bus == 0)
-		*val =
-		    (unsigned short) (pci0ReadConfigReg(offset, device) >>
+	if (busnum == 0) {
+		if(size == 1) {
+			*val = (u8)(pci0ReadConfigReg(offset, bus->dev) >>
+				     ((offset & ~0x3) * 8));
+		}else if (size == 2) {
+			*val = (u16)(pci0ReadConfigReg(offset, bus->dev) >>
 				      ((offset & ~0x3) * 8));
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int galileo_pcibios_read_config_byte(struct pci_dev *device,
-					    int offset, u8 * val)
-{
-	int dev, bus;
-
-	bus = device->bus->number;
-	dev = PCI_SLOT(device->devfn);
-
-	if (pci_range_ck(bus, dev)) {
-		*val = 0xff;
-		return PCIBIOS_DEVICE_NOT_FOUND;
+		}else if (size == 4) {
+			*val = pci0ReadConfigReg(offset, bus->dev);
+		}
 	}
 
-	if (bus == 0)
-		*val =
-		    (unsigned char) (pci0ReadConfigReg(offset, device) >>
-				     ((offset & ~0x3) * 8));
-
 	/*
 	 *  This is so that the upper PCI layer will get the correct return
 	 * value if we're not attached to anything.
 	 */
-	if ((offset == 0xe) && (*val == 0xff)) {
-		u32 MasterAbort;
-		GT_READ(GT_INTRCAUSE_OFS, &MasterAbort);
-		if (MasterAbort & 0x40000) {
-			GT_WRITE(GT_INTRCAUSE_OFS,
-				 (MasterAbort & 0xfffbffff));
-			return PCIBIOS_DEVICE_NOT_FOUND;
-		}
+	switch (size) {
+		case 1:
+			if ((offset == 0xe) && (*val == (u8)0xff)) {
+				u32 MasterAbort;
+				GT_READ(GT_INTRCAUSE_OFS, &MasterAbort);
+				if (MasterAbort & 0x40000) {
+					GT_WRITE(GT_INTRCAUSE_OFS, 
+						 (MasterAbort & 0xfffbffff));
+					return PCIBIOS_DEVICE_NOT_FOUND;
+				}
+			}
+			break;
+		case 4:
+			if ((offset == 0) && (*val == 0xffffffff)) {
+				return PCIBIOS_DEVICE_NOT_FOUND;
+			}
+			break
 	}
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int galileo_pcibios_write_config_dword(struct pci_dev *device,
-					      int offset, u32 val)
-{
-	int dev, bus;
-
-	bus = device->bus->number;
-	dev = PCI_SLOT(device->devfn);
-
-	if (pci_range_ck(bus, dev))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	if (offset & 0x3)
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-	if (bus == 0)
-		pci0WriteConfigReg(offset, device, val);
-//  if (bus == 1) pci1WriteConfigReg (offset,device,val);
-
 	return PCIBIOS_SUCCESSFUL;
 }
 
-
-static int galileo_pcibios_write_config_word(struct pci_dev *device,
-					     int offset, u16 val)
+static int galileo_pcibios_write(struct pci_bus *bus, unsigned int devfn, int offset, int size, u32 val)
 {
-	int dev, bus;
+	int dev, busnum;
 	unsigned long tmp;
 
-	bus = device->bus->number;
-	dev = PCI_SLOT(device->devfn);
+	busnum = bus->number;
+	dev = PCI_SLOT(devfn);
 
-	if (pci_range_ck(bus, dev))
+	if (pci_range_ck(busnum, dev))
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	if (offset & 0x1)
+	if (size == 4) {
+		if (offset & 0x3)
+			return PCIBIOS_BAD_REGISTER_NUMBER;
+		if(busnum == 0)
+			pci0WriteConfigReg(offset, bus->dev, val);
+		//if (busnum == 1) pci1WriteConfigReg (offset,bus->dev,val);
+		return PCIBIOS_SUCCESSFUL;
+	}
+	if ((size == 2) && (offset & 0x1))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
-	if (bus == 0)
-		tmp = pci0ReadConfigReg(offset, device);
-//  if (bus == 1) tmp = pci1ReadConfigReg (offset,device);
-
-	if ((offset % 4) == 0)
-		tmp = (tmp & 0xffff0000) | (val & 0xffff);
-	if ((offset % 4) == 2)
-		tmp = (tmp & 0x0000ffff) | ((val & 0xffff) << 16);
-
-	if (bus == 0)
-		pci0WriteConfigReg(offset, device, tmp);
-//  if (bus == 1) pci1WriteConfigReg (offset,device,tmp);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int galileo_pcibios_write_config_byte(struct pci_dev *device,
-					     int offset, u8 val)
-{
-	int dev, bus;
-	unsigned long tmp;
-
-	bus = device->bus->number;
-	dev = PCI_SLOT(device->devfn);
-
-	if (pci_range_ck(bus, dev))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	if (bus == 0)
-		tmp = pci0ReadConfigReg(offset, device);
-//  if (bus == 1) tmp = pci1ReadConfigReg (offset,device);
-
-	if ((offset % 4) == 0)
-		tmp = (tmp & 0xffffff00) | (val & 0xff);
-	if ((offset % 4) == 1)
-		tmp = (tmp & 0xffff00ff) | ((val & 0xff) << 8);
-	if ((offset % 4) == 2)
-		tmp = (tmp & 0xff00ffff) | ((val & 0xff) << 16);
-	if ((offset % 4) == 3)
-		tmp = (tmp & 0x00ffffff) | ((val & 0xff) << 24);
-
-	if (bus == 0)
-		pci0WriteConfigReg(offset, device, tmp);
-//  if (bus == 1) pci1WriteConfigReg (offset,device,tmp);
-
+	if (busnum == 0){
+		tmp = pci0ReadConfigReg(offset, bus->dev);
+		//if (busnum == 1) tmp = pci1ReadConfigReg (offset,bus->dev);
+		if (size == 1) {
+			if ((offset % 4) == 0)
+				tmp = (tmp & 0xffffff00) | (val & (u8)0xff);
+			if ((offset % 4) == 1)
+				tmp = (tmp & 0xffff00ff) | ((val & (u8)0xff) << 8);
+			if ((offset % 4) == 2)
+				tmp = (tmp & 0xff00ffff) | ((val & (u8)0xff) << 16);
+			if ((offset % 4) == 3)
+				tmp = (tmp & 0x00ffffff) | ((val & (u8)0xff) << 24);
+		} else if (size == 2) {
+			if ((offset % 4) == 0)
+				tmp = (tmp & 0xffff0000) | (val & (u16)0xffff);
+			if ((offset % 4) == 2)
+				tmp = (tmp & 0x0000ffff) | ((val & (u16)0xffff) << 16);
+		}
+		if (busnum == 0)
+			pci0WriteConfigReg(offset, bus->dev, tmp);
+		//if (busnum == 1) pci1WriteConfigReg (offset,bus->dev,tmp);
+	}
 	return PCIBIOS_SUCCESSFUL;
 }
 
@@ -792,9 +726,9 @@
 {
 	u16 cmd;
 
-	galileo_pcibios_read_config_word(dev, PCI_COMMAND, &cmd);
+	galileo_pcibios_read(dev->bus, dev->devfn, PCI_COMMAND, 2, &cmd);
 	cmd |= PCI_COMMAND_MASTER;
-	galileo_pcibios_write_config_word(dev, PCI_COMMAND, cmd);
+	galileo_pcibios_write(dev->bus, dev->devfn, PCI_COMMAND, 2, cmd);
 }
 
 /*  Externally-expected functions.  Do not change function names  */
@@ -806,7 +740,7 @@
 	int idx;
 	struct resource *r;
 
-	galileo_pcibios_read_config_word(dev, PCI_COMMAND, &cmd);
+	galileo_pcibios_read(dev->bus, dev->devfn, PCI_COMMAND, 2, &cmd);
 	old_cmd = cmd;
 	for (idx = 0; idx < 6; idx++) {
 		r = &dev->resource[idx];
@@ -822,7 +756,7 @@
 			cmd |= PCI_COMMAND_MEMORY;
 	}
 	if (cmd != old_cmd) {
-		galileo_pcibios_write_config_word(dev, PCI_COMMAND, cmd);
+		galileo_pcibios_write(dev->bus, dev->devfn, PCI_COMMAND, 2, cmd);
 	}
 
 	/*
@@ -830,19 +764,17 @@
 	 * line size = 32 bytes / sizeof dword (4) = 8.
 	 * Latency timer must be > 8.  32 is random but appears to work.
 	 */
-	galileo_pcibios_read_config_byte(dev, PCI_CACHE_LINE_SIZE, &tmp1);
+	galileo_pcibios_read(dev->bus, dev->devfn, PCI_CACHE_LINE_SIZE, 1, &tmp1);
 	if (tmp1 != 8) {
 		printk(KERN_WARNING "PCI setting cache line size to 8 from "
 		       "%d\n", tmp1);
-		galileo_pcibios_write_config_byte(dev, PCI_CACHE_LINE_SIZE,
-						  8);
+		galileo_pcibios_write(dev->bus, dev->devfn, PCI_CACHE_LINE_SIZE, 1, 8);
 	}
-	galileo_pcibios_read_config_byte(dev, PCI_LATENCY_TIMER, &tmp1);
+	galileo_pcibios_read(dev->bus, dev->devfn, PCI_LATENCY_TIMER, 1, &tmp1);
 	if (tmp1 < 32) {
 		printk(KERN_WARNING "PCI setting latency timer to 32 from %d\n",
 		       tmp1);
-		galileo_pcibios_write_config_byte(dev, PCI_LATENCY_TIMER,
-						  32);
+		galileo_pcibios_write(dev->bus, dev->devfn, PCI_LATENCY_TIMER, 1, 32);
 	}
 
 	return 0;
@@ -909,12 +841,8 @@
 }
 
 struct pci_ops galileo_pci_ops = {
-	galileo_pcibios_read_config_byte,
-	galileo_pcibios_read_config_word,
-	galileo_pcibios_read_config_dword,
-	galileo_pcibios_write_config_byte,
-	galileo_pcibios_write_config_word,
-	galileo_pcibios_write_config_dword
+	.read = 	galileo_pcibios_read,
+	.write = 	galileo_pcibios_write,
 };
 
 struct pci_fixup pcibios_fixups[] = {
diff -Nru a/arch/mips/ite-boards/generic/it8172_pci.c b/arch/mips/ite-boards/generic/it8172_pci.c
--- a/arch/mips/ite-boards/generic/it8172_pci.c	Fri Aug 30 15:00:21 2002
+++ b/arch/mips/ite-boards/generic/it8172_pci.c	Fri Aug 30 15:00:21 2002
@@ -45,18 +45,17 @@
 #undef DEBUG_CONFIG_CYCLES
 
 static int
-it8172_pcibios_config_access(unsigned char access_type, struct pci_dev *dev,
-                           unsigned char where, u32 *data)
+it8172_pcibios_config_access(unsigned char access_type, struct pci_bus *bus, unsigned int devfn, unsigned char where, u32 *data)
 {
 	/* 
 	 * config cycles are on 4 byte boundary only
 	 */
-	unsigned char bus = dev->bus->number;
-	unsigned char dev_fn = dev->devfn;
+	unsigned char bus = bus->number;
+	unsigned char dev_fn = (char)devfn;
 
 #ifdef DEBUG_CONFIG_CYCLES
-	printk("it config: type %d dev %x bus %d dev_fn %x data %x\n",
-			access_type, dev, bus, dev_fn, *data);
+	printk("it config: type %d bus %d dev_fn %x data %x\n",
+			access_type, bus, dev_fn, *data);
 
 #endif
 
@@ -86,121 +85,63 @@
  * read/write a 32bit word and mask/modify the data we actually want.
  */
 static int
-it8172_pcibios_read_config_byte (struct pci_dev *dev, int where, u8 *val)
+it8172_pcibios_read (struct pci_bus *bus, unsigned int devfn,  int where, int size, u32 *val)
 {
 	u32 data = 0;
 
-	if (it8172_pcibios_config_access(PCI_ACCESS_READ, dev, where, &data))
-		return -1;
-
-	*val = (data >> ((where & 3) << 3)) & 0xff;
-#ifdef DEBUG
-        printk("cfg read byte: bus %d dev_fn %x where %x: val %x\n", 
-                dev->bus->number, dev->devfn, where, *val);
-#endif
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-
-static int
-it8172_pcibios_read_config_word (struct pci_dev *dev, int where, u16 *val)
-{
-	u32 data = 0;
-
-	if (where & 1)
+	if ((size == 2) && (where & 1))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	if (it8172_pcibios_config_access(PCI_ACCESS_READ, dev, where, &data))
-	       return -1;
-
-	*val = (data >> ((where & 3) << 3)) & 0xffff;
-#ifdef DEBUG
-        printk("cfg read word: bus %d dev_fn %x where %x: val %x\n", 
-                dev->bus->number, dev->devfn, where, *val);
-#endif
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-it8172_pcibios_read_config_dword (struct pci_dev *dev, int where, u32 *val)
-{
-	u32 data = 0;
-
-	if (where & 3)
+	else if ((size == 4) && (where & 3))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
-	
-	if (it8172_pcibios_config_access(PCI_ACCESS_READ, dev, where, &data))
+	if (it8172_pcibios_config_access(PCI_ACCESS_READ, bus, devfn, where, &data))
 		return -1;
+	if (size == 1)
+		*val = (u8)(data >> ((where & 3) << 3)) & 0xff;
+	else if (size == 2)
+		*val = (u16)(data >> ((where & 3) << 3)) & 0xffff;
+	else if (size == 4) 
+		*val = data;
 
-	*val = data;
 #ifdef DEBUG
-        printk("cfg read dword: bus %d dev_fn %x where %x: val %x\n", 
-                dev->bus->number, dev->devfn, where, *val);
+        	printk("cfg read: bus %d devfn %x where %x size %x: val %x\n", 
+                bus->number, devfn, where, size, *val);
 #endif
 
 	return PCIBIOS_SUCCESSFUL;
 }
 
-
 static int
-it8172_pcibios_write_config_byte (struct pci_dev *dev, int where, u8 val)
+it8172_pcibios_write (struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val)
 {
 	u32 data = 0;
-       
-	if (it8172_pcibios_config_access(PCI_ACCESS_READ, dev, where, &data))
-		return -1;
-
-	data = (data & ~(0xff << ((where & 3) << 3))) |
-	       (val << ((where & 3) << 3));
 
-	if (it8172_pcibios_config_access(PCI_ACCESS_WRITE, dev, where, &data))
-		return -1;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-it8172_pcibios_write_config_word (struct pci_dev *dev, int where, u16 val)
-{
-        u32 data = 0;
-
-	if (where & 1)
+	if ((size == 2) && (where & 1))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
+	else if (size == 4) {
+		if (where & 3)
+			return PCIBIOS_BAD_REGISTER_NUMBER;
+		if (it8172_pcibios_config_access(PCI_ACCESS_WRITE, bus, devfn, where, &val))
+			return -1;
+		return PCIBIOS_SUCCESSFUL;
+	}
        
-        if (it8172_pcibios_config_access(PCI_ACCESS_READ, dev, where, &data))
-	       return -1;
-
-	data = (data & ~(0xffff << ((where & 3) << 3))) | 
-	       (val << ((where & 3) << 3));
-
-	if (it8172_pcibios_config_access(PCI_ACCESS_WRITE, dev, where, &data))
-	       return -1;
-
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-it8172_pcibios_write_config_dword(struct pci_dev *dev, int where, u32 val)
-{
-	if (where & 3)
-		return PCIBIOS_BAD_REGISTER_NUMBER;
+	if (it8172_pcibios_config_access(PCI_ACCESS_READ, bus, devfn, where, &data))
+		return -1;
 
-	if (it8172_pcibios_config_access(PCI_ACCESS_WRITE, dev, where, &val))
-	       return -1;
+	if(size == 1) {
+		data = (u8)(data & ~(0xff << ((where & 3) << 3))) | 
+			(val << ((where & 3) << 3));
+	} else if (size == 2) {
+		data = (u16)(data & ~(0xffff << ((where & 3) << 3))) | 
+			(val << ((where & 3) << 3));
+	}
 
 	return PCIBIOS_SUCCESSFUL;
 }
 
 struct pci_ops it8172_pci_ops = {
-	it8172_pcibios_read_config_byte,
-        it8172_pcibios_read_config_word,
-	it8172_pcibios_read_config_dword,
-	it8172_pcibios_write_config_byte,
-	it8172_pcibios_write_config_word,
-	it8172_pcibios_write_config_dword
+	.read = 	it8172_pcibios_read,
+	.write = 	it8172_pcibios_write,
 };
 
 void __init pcibios_init(void)
diff -Nru a/arch/mips/mips-boards/generic/pci.c b/arch/mips/mips-boards/generic/pci.c
--- a/arch/mips/mips-boards/generic/pci.c	Fri Aug 30 15:00:21 2002
+++ b/arch/mips/mips-boards/generic/pci.c	Fri Aug 30 15:00:21 2002
@@ -37,11 +37,9 @@
 #define PCI_ACCESS_WRITE 1
 
 static int
-mips_pcibios_config_access(unsigned char access_type, struct pci_dev *dev,
-                           unsigned char where, u32 *data)
+mips_pcibios_config_access(unsigned char access_type, struct pci_bus *bus_dev, unsigned int dev_fn, unsigned char where, u32 *data)
 {
-	unsigned char bus = dev->bus->number;
-	unsigned char dev_fn = dev->devfn;
+	unsigned char bus = bus_dev->number;
         u32 intr;
 
 	if ((bus == 0) && (dev_fn >= PCI_DEVFN(31,0)))
@@ -101,109 +99,56 @@
  * read/write a 32bit word and mask/modify the data we actually want.
  */
 static int
-mips_pcibios_read_config_byte (struct pci_dev *dev, int where, u8 *val)
+mips_pcibios_read (struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val)
 {
 	u32 data = 0;
 
-	if (mips_pcibios_config_access(PCI_ACCESS_READ, dev, where, &data))
-		return -1;
-
-	*val = (data >> ((where & 3) << 3)) & 0xff;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-
-static int
-mips_pcibios_read_config_word (struct pci_dev *dev, int where, u16 *val)
-{
-	u32 data = 0;
-
-	if (where & 1)
+	if((size == 2) && (where & 1))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	if (mips_pcibios_config_access(PCI_ACCESS_READ, dev, where, &data))
-	       return -1;
-
-	*val = (data >> ((where & 3) << 3)) & 0xffff;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-mips_pcibios_read_config_dword (struct pci_dev *dev, int where, u32 *val)
-{
-	u32 data = 0;
-
-	if (where & 3)
+	else if ((size == 4)  && (where & 3))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
-	
-	if (mips_pcibios_config_access(PCI_ACCESS_READ, dev, where, &data))
+	if (mips_pcibios_config_access(PCI_ACCESS_READ, bus, devfn, where, &data))
 		return -1;
-
-	*val = data;
+	if(size == 1) 
+		*val = (u8)(data >> ((where & 3) << 3)) & 0xff;
+	else if (size == 2)
+		*val = (u16)(data >> ((where & 3) << 3)) & 0xffff;
+	else if (size == 4)
+		*val = data;
 
 	return PCIBIOS_SUCCESSFUL;
 }
 
 
 static int
-mips_pcibios_write_config_byte (struct pci_dev *dev, int where, u8 val)
+mips_pcibios_write (struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val)
 {
 	u32 data = 0;
        
-	if (mips_pcibios_config_access(PCI_ACCESS_READ, dev, where, &data))
-		return -1;
-
-	data = (data & ~(0xff << ((where & 3) << 3))) |
-	       (val << ((where & 3) << 3));
-
-	if (mips_pcibios_config_access(PCI_ACCESS_WRITE, dev, where, &data))
-		return -1;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-mips_pcibios_write_config_word (struct pci_dev *dev, int where, u16 val)
-{
-        u32 data = 0;
-
-	if (where & 1)
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-       
-        if (mips_pcibios_config_access(PCI_ACCESS_READ, dev, where, &data))
-	       return -1;
-
-	data = (data & ~(0xffff << ((where & 3) << 3))) | 
-	       (val << ((where & 3) << 3));
-
-	if (mips_pcibios_config_access(PCI_ACCESS_WRITE, dev, where, &data))
-	       return -1;
-
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-mips_pcibios_write_config_dword(struct pci_dev *dev, int where, u32 val)
-{
-	if (where & 3)
+	if((size == 2) && (where & 1))
 		return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	if (mips_pcibios_config_access(PCI_ACCESS_WRITE, dev, where, &val))
-	       return -1;
-
+	else if (size == 4) {
+		if(where & 3)
+			return PCIBIOS_BAD_REGISTER_NUMBER;
+		if(mips_pcibios_config_access(PCI_ACCESS_READ, bus, devfn, where, &val))
+			return -1;
+		return PCIBIOS_SUCCESSFUL;
+	}
+	if (mips_pcibios_config_access(PCI_ACCESS_READ, bus, devfn,  where, &data))
+		return -1;
+	if(size == 1) {
+		data = (data & ~(0xff << ((where & 3) << 3))) |
+		       	(val << ((where & 3) << 3));
+	} else if (size == 2) {
+		data = (data & ~(0xffff << ((where & 3) << 3))) | 
+			(val << ((where & 3) << 3));
+	}
 	return PCIBIOS_SUCCESSFUL;
 }
 
 struct pci_ops mips_pci_ops = {
-	mips_pcibios_read_config_byte,
-        mips_pcibios_read_config_word,
-	mips_pcibios_read_config_dword,
-	mips_pcibios_write_config_byte,
-	mips_pcibios_write_config_word,
-	mips_pcibios_write_config_dword
+	.read = 	mips_pcibios_read,
+	.write = 	mips_pcibios_write,
 };
 
 void __init pcibios_init(void)
diff -Nru a/arch/mips/sni/pci.c b/arch/mips/sni/pci.c
--- a/arch/mips/sni/pci.c	Fri Aug 30 15:00:21 2002
+++ b/arch/mips/sni/pci.c	Fri Aug 30 15:00:21 2002
@@ -17,13 +17,13 @@
 
 #ifdef CONFIG_PCI
 
-#define mkaddr(dev, where)                                                   \
+#define mkaddr(bus, devfn, where)                                                   \
 do {                                                                         \
-	if ((dev)->bus->number == 0)                                         \
+	if (bus->number == 0)                                         \
 		return -1;                                                   \
 	*(volatile u32 *)PCIMT_CONFIG_ADDRESS =                              \
-		 ((dev->bus->number    & 0xff) << 0x10) |                    \
-	         ((dev->devfn & 0xff) << 0x08) |                             \
+		 ((bus->number    & 0xff) << 0x10) |                    \
+	         ((devfn & 0xff) << 0x08) |                             \
 	         (where  & 0xfc);                                            \
 } while(0)
 
@@ -69,87 +69,67 @@
  * We can't address 8 and 16 bit words directly.  Instead we have to
  * read/write a 32bit word and mask/modify the data we actually want.
  */
-static int pcimt_read_config_byte (struct pci_dev *dev,
-                                   int where, unsigned char *val)
+static int pcimt_read (struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val)
 {
 	u32 res;
 
-	mkaddr(dev, where);
-	res = *(volatile u32 *)PCIMT_CONFIG_DATA;
-	res = (le32_to_cpu(res) >> ((where & 3) << 3)) & 0xff;
-	*val = res;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int pcimt_read_config_word (struct pci_dev *dev,
-                                   int where, unsigned short *val)
-{
-	u32 res;
-
-	if (where & 1)
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-	mkaddr(dev, where);
-	res = *(volatile u32 *)PCIMT_CONFIG_DATA;
-	res = (le32_to_cpu(res) >> ((where & 3) << 3)) & 0xffff;
-	*val = res;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int pcimt_read_config_dword (struct pci_dev *dev,
-                                    int where, unsigned int *val)
-{
-	u32 res;
-
-		if (where & 3)
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-	mkaddr(dev, where);
-	res = *(volatile u32 *)PCIMT_CONFIG_DATA;
-	res = le32_to_cpu(res);
-	*val = res;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int pcimt_write_config_byte (struct pci_dev *dev,
-                                    int where, unsigned char val)
-{
-	mkaddr(dev, where);
-	*(volatile u8 *)(PCIMT_CONFIG_DATA + (where & 3)) = val;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int pcimt_write_config_word (struct pci_dev *dev,
-                                    int where, unsigned short val)
-{
-	if (where & 1)
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-	mkaddr(dev, where);
-	*(volatile u16 *)(PCIMT_CONFIG_DATA + (where & 3)) = le16_to_cpu(val);
+	switch (size) {
+		case 1:
+			mkaddr(bus, devfn, where);
+			res = *(volatile u32 *)PCIMT_CONFIG_DATA;
+			res = (le32_to_cpu(res) >> ((where & 3) << 3)) & 0xff;
+			*val = (u8)res;
+			break;
+		case 2:
+			if (where & 1)
+				return PCIBIOS_BAD_REGISTER_NUMBER;
+			mkaddr(bus, devfn, where);
+			res = *(volatile u32 *)PCIMT_CONFIG_DATA;
+			res = (le32_to_cpu(res) >> ((where & 3) << 3)) & 0xffff;
+			*val = (u16)res;
+			break;
+		case 4:
+			if (where & 3)
+				return PCIBIOS_BAD_REGISTER_NUMBER;
+			mkaddr(bus, devfn, where);
+			res = *(volatile u32 *)PCIMT_CONFIG_DATA;
+			res = le32_to_cpu(res);
+			*val = res;
+			break;
+	}
 
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int pcimt_write_config_dword (struct pci_dev *dev,
-                                     int where, unsigned int val)
+static int pcimt_write (struct pci_bus *bus, unsigned int devfn,  int where, int size,  u32 val)
 {
-	if (where & 3)
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-	mkaddr(dev, where);
-	*(volatile u32 *)PCIMT_CONFIG_DATA = le32_to_cpu(val);
+	switch (size) {
+		case 1:
+			mkaddr(bus, devfn, where);
+			*(volatile u8 *)(PCIMT_CONFIG_DATA + (where & 3)) = 
+				(u8)le32_to_cpu(val);
+			break;
+		case 2:
+			if (where & 1)
+				return PCIBIOS_BAD_REGISTER_NUMBER;
+			mkaddr(bus, devfn, where);
+			*(volatile u16 *)(PCIMT_CONFIG_DATA + (where & 3)) = 
+				(u16)le32_to_cpu(val);
+			break;
+		case 4:
+			if (where & 3)
+				return PCIBIOS_BAD_REGISTER_NUMBER;
+			mkaddr(bus, devfn, where);
+			*(volatile u32 *)PCIMT_CONFIG_DATA = le32_to_cpu(val);
+			break;
+	}
 
 	return PCIBIOS_SUCCESSFUL;
 }
 
 struct pci_ops sni_pci_ops = {
-	pcimt_read_config_byte,
-	pcimt_read_config_word,
-	pcimt_read_config_dword,
-	pcimt_write_config_byte,
-	pcimt_write_config_word,
-	pcimt_write_config_dword
+	.read = 	pcimt_read,
+	.write = 	pcimt_write,
 };
 
 void __init
