Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317637AbSH3WMX>; Fri, 30 Aug 2002 18:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317641AbSH3WMM>; Fri, 30 Aug 2002 18:12:12 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:33299 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317637AbSH3WId>;
	Fri, 30 Aug 2002 18:08:33 -0400
Date: Fri, 30 Aug 2002 15:11:57 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] PCI ops cleanups for 2.5.32-bk
Message-ID: <20020830221157.GI10783@kroah.com>
References: <20020830220720.GA10783@kroah.com> <20020830220846.GB10783@kroah.com> <20020830220912.GC10783@kroah.com> <20020830220931.GD10783@kroah.com> <20020830221017.GE10783@kroah.com> <20020830221044.GF10783@kroah.com> <20020830221107.GG10783@kroah.com> <20020830221127.GH10783@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020830221127.GH10783@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.549   -> 1.550  
#	arch/sh/kernel/pci-dc.c	1.2     -> 1.3    
#	arch/sh/kernel/pci-sh7751.c	1.3     -> 1.4    
#	arch/sh/kernel/pci_st40.c	1.4     -> 1.5    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/30	hannal@us.ibm.com	1.550
# [PATCH] PCI: sh pci_ops changes
# 
# sh pci ops changes
# --------------------------------------------
#
diff -Nru a/arch/sh/kernel/pci-dc.c b/arch/sh/kernel/pci-dc.c
--- a/arch/sh/kernel/pci-dc.c	Fri Aug 30 15:00:18 2002
+++ b/arch/sh/kernel/pci-dc.c	Fri Aug 30 15:00:18 2002
@@ -31,76 +31,57 @@
 	{0, 0, 0, NULL}
 };
 
-#define BBA_SELECTED(dev) (dev->bus->number==0 && dev->devfn==0)
+#define BBA_SELECTED(bus,devfn) (bus->number==0 && devfn==0)
 
-static int gapspci_read_config_byte(struct pci_dev *dev, int where,
-                                    u8 * val)
+static int gapspci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 * val)
 {
-	if (BBA_SELECTED(dev))
-		*val = inb(GAPSPCI_BBA_CONFIG+where);
-	else
-                *val = 0xff;
-
+	switch (size) {
+	case 1:
+		if (BBA_SELECTED(bus, devfn))
+			*val = (u8)inb(GAPSPCI_BBA_CONFIG+where);
+		else
+			*val = (u8)0xff;
+		break;
+	case 2:
+		if (BBA_SELECTED(bus, devfn))
+			*val = (u16)inw(GAPSPCI_BBA_CONFIG+where);
+		else
+			*val = (u16)0xffff;
+		break;
+	case 4:
+		if (BBA_SELECTED(bus, devfn))
+			*val = inl(GAPSPCI_BBA_CONFIG+where);
+		else
+			*val = 0xffffffff;
+		break;
+	}	
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int gapspci_read_config_word(struct pci_dev *dev, int where,
-                                    u16 * val)
-{
-        if (BBA_SELECTED(dev))
-		*val = inw(GAPSPCI_BBA_CONFIG+where);
-	else
-                *val = 0xffff;
-
-        return PCIBIOS_SUCCESSFUL;
-}
-
-static int gapspci_read_config_dword(struct pci_dev *dev, int where,
-                                     u32 * val)
-{
-        if (BBA_SELECTED(dev))
-		*val = inl(GAPSPCI_BBA_CONFIG+where);
-	else
-                *val = 0xffffffff;
-
-        return PCIBIOS_SUCCESSFUL;
-}
-
-static int gapspci_write_config_byte(struct pci_dev *dev, int where,
-                                     u8 val)
-{
-        if (BBA_SELECTED(dev))
-		outb(val, GAPSPCI_BBA_CONFIG+where);
-
-        return PCIBIOS_SUCCESSFUL;
-}
-
-
-static int gapspci_write_config_word(struct pci_dev *dev, int where,
-                                     u16 val)
-{
-        if (BBA_SELECTED(dev))
-		outw(val, GAPSPCI_BBA_CONFIG+where);
-
-        return PCIBIOS_SUCCESSFUL;
-}
-
-static int gapspci_write_config_dword(struct pci_dev *dev, int where,
-                                      u32 val)
+static int gapspci_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val)
 {
-        if (BBA_SELECTED(dev))
-		outl(val, GAPSPCI_BBA_CONFIG+where);
-
-        return PCIBIOS_SUCCESSFUL;
+	if (BBA_SELECTED(bus, devfn)) {
+		switch (size) {
+		case 1:
+			if (BBA_SELECTED(bus, devfn))
+				outb((u8)val, GAPSPCI_BBA_CONFIG+where);
+			break;
+		case 2:
+			if (BBA_SELECTED(bus, devfn))
+				outw((u16)val, GAPSPCI_BBA_CONFIG+where);
+			break;
+		case 4:
+			if (BBA_SELECTED(bus, devfn))
+				outl(val, GAPSPCI_BBA_CONFIG+where);
+			break;
+		}
+	}
+	return PCIBIOS_SUCCESSFUL;
 }
 
 static struct pci_ops pci_config_ops = {
-        gapspci_read_config_byte,
-        gapspci_read_config_word,
-        gapspci_read_config_dword,
-        gapspci_write_config_byte,
-        gapspci_write_config_word,
-        gapspci_write_config_dword
+	.read = 	gapspci_read,
+	.write = 	gapspci_write,
 };
 
 
@@ -143,7 +124,7 @@
 
 	for (ln=bus->devices.next; ln != &bus->devices; ln=ln->next) {
 		dev = pci_dev_b(ln);
-		if (!BBA_SELECTED(dev)) continue;
+		if (!BBA_SELECTED(bus, dev->devfn)) continue;
 
 		printk("PCI: MMIO fixup to %s\n", dev->name);
 		dev->resource[1].start=0x01001700;
diff -Nru a/arch/sh/kernel/pci-sh7751.c b/arch/sh/kernel/pci-sh7751.c
--- a/arch/sh/kernel/pci-sh7751.c	Fri Aug 30 15:00:18 2002
+++ b/arch/sh/kernel/pci-sh7751.c	Fri Aug 30 15:00:18 2002
@@ -41,14 +41,14 @@
 #ifdef CONFIG_PCI_DIRECT
 
 
-#define CONFIG_CMD(dev, where) (0x80000000 | (dev->bus->number << 16) | (dev->devfn << 8) | (where & ~3))
+#define CONFIG_CMD(bus, devfn, where) (0x80000000 | (bus->number << 16) | (devfn << 8) | (where & ~3))
 
 #define PCI_REG(reg) (SH7751_PCIREG_BASE+reg)
 
 /*
  * Functions for accessing PCI configuration space with type 1 accesses
  */
-static int pci_conf1_read_config_byte(struct pci_dev *dev, int where, u8 *value)
+static int pci_conf1_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *value)
 {
 	u32 word;
 	unsigned long flags;
@@ -57,144 +57,88 @@
      * so we must do byte alignment by hand 
      */
 	save_and_cli(flags);
-	outl(CONFIG_CMD(dev,where), PCI_REG(SH7751_PCIPAR));
+	outl(CONFIG_CMD(bus,devfn,where), PCI_REG(SH7751_PCIPAR));
 	word = inl(PCI_REG(SH7751_PCIPDR));
 	restore_flags(flags);
-	switch (where & 0x3) {
-	    case 3:
-		    *value = (u8)(word >> 24);
-			break;
-		case 2:
-		    *value = (u8)(word >> 16);
-			break;
-		case 1:
-		    *value = (u8)(word >> 8);
-			break;
-		default:
-		    *value = (u8)word;
-			break;
-    }
-	PCIDBG(4,"pci_conf1_read_config_byte@0x%08x=0x%x\n",
-	     CONFIG_CMD(dev,where),*value);
-	return PCIBIOS_SUCCESSFUL;
-}
 
-static int pci_conf1_read_config_word(struct pci_dev *dev, int where, u16 *value)
-{
-	u32 word;
-	unsigned long flags;
-
-    /* PCIPDR may only be accessed as 32 bit words, 
-     * so we must do word alignment by hand 
-     */
-	save_and_cli(flags);
-	outl(CONFIG_CMD(dev,where), PCI_REG(SH7751_PCIPAR));
-	word = inl(PCI_REG(SH7751_PCIPDR));
-	restore_flags(flags);
-	switch (where & 0x3) {
-	    case 3:
-		    // This should never happen...
-			printk(KERN_ERR "PCI BIOS: read_config_word: Illegal u16 alignment");
-	        return PCIBIOS_BAD_REGISTER_NUMBER;
-		case 2:
-		    *value = (u16)(word >> 16);
-			break;
+	switch (size) {
 		case 1:
-		    *value = (u16)(word >> 8);
-			break;
-		default:
-		    *value = (u16)word;
+			switch (where & 0x3) {
+				case 3:
+					*value = (u8)(word >> 24);
+					break;
+				case 2:
+					*value = (u8)(word >> 16);
+					break;
+				case 1:
+					*value = (u8)(word >> 8);
+					break;
+				default:
+					*value = (u8)word;
+					break;
+			}
+		case 2:
+			switch (where & 0x3) {
+				case 3: /*This should never happen.*/
+					printk(KERN_ERR "PCI BIOS: read_config: Illegal u16 alignment");
+					return PCIBIOS_BAD_REGISTER_NUMBER;
+				case 2:
+					*value = (u16)(word >> 16);
+					break;
+				case 1:
+					*value = (u16)(word >> 8);
+					break;
+				default:
+					*value = (u16)word;
+					break;
+			}
+		case 4:
+			*value = word;
 			break;
-    }
-	PCIDBG(4,"pci_conf1_read_config_word@0x%08x=0x%x\n",
-	     CONFIG_CMD(dev,where),*value);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int pci_conf1_read_config_dword(struct pci_dev *dev, int where, u32 *value)
-{
-	unsigned long flags;
-	
-	save_and_cli(flags);
-	outl(CONFIG_CMD(dev,where), PCI_REG(SH7751_PCIPAR));
-	*value = inl(PCI_REG(SH7751_PCIPDR));
-	restore_flags(flags);
-	PCIDBG(4,"pci_conf1_read_config_dword@0x%08x=0x%x\n",
-	     CONFIG_CMD(dev,where),*value);
+	}
+	PCIDBG(4,"pci_conf1_read@0x%08x=0x%x\n", CONFIG_CMD(bus,devfn,where),*value); 
 	return PCIBIOS_SUCCESSFUL;    
 }
 
-static int pci_conf1_write_config_byte(struct pci_dev *dev, int where, u8 value)
+/* 
+ * Since SH7751 only does 32bit access we'll have to do a read,mask,write operation.  
+ * We'll allow an odd byte offset, though it should be illegal.
+ */ 
+static int pci_conf1_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 value)
 {
-	u32 word;
-	u32 shift = (where & 3) * 8;
-	u32 mask = ((1 << 8) - 1) << shift;  // create the byte mask
+	u32 word,mask;
 	unsigned long flags;
-
-    /* Since SH7751 only does 32bit access we'll have to do a
-     * read,mask,write operation
-     */ 
-	save_and_cli(flags);
-	outl(CONFIG_CMD(dev,where), PCI_REG(SH7751_PCIPAR));
-	word = inl(PCI_REG(SH7751_PCIPDR)) ;
-	word &= ~mask;
-	word |= value << shift;
- 
-	outl(word, PCI_REG(SH7751_PCIPDR));
-	restore_flags(flags);
-	PCIDBG(4,"pci_conf1_write_config_byte@0x%08x=0x%x\n",
-	     CONFIG_CMD(dev,where),word);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int pci_conf1_write_config_word(struct pci_dev *dev, int where, u16 value)
-{
-	u32 word;
 	u32 shift = (where & 3) * 8;
-	u32 mask = ((1 << 16) - 1) << shift;  // create the word mask
-	unsigned long flags;
 
-    /* Since SH7751 only does 32bit access we'll have to do a
-     * read,mask,write operation.  We'll allow an odd byte offset,
-	 * though it should be illegal.
-     */ 
-	if (shift == 24)
-	    return PCIBIOS_BAD_REGISTER_NUMBER;
-	save_and_cli(flags);
-	outl(CONFIG_CMD(dev,where), PCI_REG(SH7751_PCIPAR));
+	if(size == 1) {
+		mask = ((1 << 8) - 1) << shift;  // create the byte mask
+	} else if(size == 2){
+		if(shift == 24)
+			return PCIBIOS_BAD_REGISTER_NUMBER;           
+		mask = ((1 << 16) - 1) << shift;  // create the word mask
+	}
+	save_and_cli(flags);
+	outl(CONFIG_CMD(bus,devfn,where), PCI_REG(SH7751_PCIPAR));
+	if(size == 4){
+		outl(value, PCI_REG(SH7751_PCIPDR));
+		restore_flags(flags);
+		PCIDBG(4,"pci_conf1_write@0x%08x=0x%x\n", CONFIG_CMD(bus,devfn,where),value);
+		return PCIBIOS_SUCCESSFUL;
+	}
 	word = inl(PCI_REG(SH7751_PCIPDR)) ;
 	word &= ~mask;
 	word |= value << shift;
- 
-	outl(value, PCI_REG(SH7751_PCIPDR));
-	restore_flags(flags);
-	PCIDBG(4,"pci_conf1_write_config_word@0x%08x=0x%x\n",
-	     CONFIG_CMD(dev,where),word);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int pci_conf1_write_config_dword(struct pci_dev *dev, int where, u32 value)
-{
-	unsigned long flags;
-
-	save_and_cli(flags);
-	outl(CONFIG_CMD(dev,where), PCI_REG(SH7751_PCIPAR));
-	outl(value, PCI_REG(SH7751_PCIPDR));
+	outl(word, PCI_REG(SH7751_PCIPDR));
 	restore_flags(flags);
-	PCIDBG(4,"pci_conf1_write_config_dword@0x%08x=0x%x\n",
-	     CONFIG_CMD(dev,where),value);
+	PCIDBG(4,"pci_conf1_write@0x%08x=0x%x\n", CONFIG_CMD(bus,devfn,where),word);
 	return PCIBIOS_SUCCESSFUL;
 }
 
 #undef CONFIG_CMD
 
 static struct pci_ops pci_direct_conf1 = {
-	pci_conf1_read_config_byte,
-	pci_conf1_read_config_word,
-	pci_conf1_read_config_dword,
-	pci_conf1_write_config_byte,
-	pci_conf1_write_config_word,
-	pci_conf1_write_config_dword
+	.read =		pci_conf1_read,
+	.write = 	pci_conf1_write,
 };
 
 struct pci_ops * __init pci_check_direct(void)
diff -Nru a/arch/sh/kernel/pci_st40.c b/arch/sh/kernel/pci_st40.c
--- a/arch/sh/kernel/pci_st40.c	Fri Aug 30 15:00:18 2002
+++ b/arch/sh/kernel/pci_st40.c	Fri Aug 30 15:00:18 2002
@@ -268,7 +268,7 @@
 #define SET_CONFIG_BITS(bus,devfn,where)\
   (((bus) << 16) | ((devfn) << 8) | ((where) & ~3) | (bus!=0))
 
-#define CONFIG_CMD(dev, where) SET_CONFIG_BITS((dev)->bus->number,(dev)->devfn,where)
+#define CONFIG_CMD(bus, devfn, where) SET_CONFIG_BITS(bus->number,devfn,where)
 
 
 static int CheckForMasterAbort(void)
@@ -284,79 +284,53 @@
 }
 
 /* Write to config register */
-static int st40pci_read_config_byte(struct pci_dev *dev, int where,
-				    u8 * val)
+static int st40pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 * val)
 {
-	ST40PCI_WRITE(PAR, CONFIG_CMD(dev, where));
-
-	*val = ST40PCI_READ_BYTE(PDR + (where & 3));
-
-	if (CheckForMasterAbort())
-		*val = 0xff;
-
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int st40pci_read_config_word(struct pci_dev *dev, int where,
-				    u16 * val)
-{
-	ST40PCI_WRITE(PAR, CONFIG_CMD(dev, where));
-
-	*val = ST40PCI_READ_SHORT(PDR + (where & 2));
-
-	if (CheckForMasterAbort())
-		*val = 0xffff;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-
-static int st40pci_read_config_dword(struct pci_dev *dev, int where,
-				     u32 * val)
-{
-
-	ST40PCI_WRITE(PAR, CONFIG_CMD(dev, where));
-
-	*val = ST40PCI_READ(PDR);
-
-	if (CheckForMasterAbort())
-		*val = 0xffffffff;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int st40pci_write_config_byte(struct pci_dev *dev, int where,
-				     u8 val)
-{
-	ST40PCI_WRITE(PAR, CONFIG_CMD(dev, where));
-
-	ST40PCI_WRITE_BYTE(PDR + (where & 3), val);
-
-	CheckForMasterAbort();
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-
-static int st40pci_write_config_word(struct pci_dev *dev, int where,
-				     u16 val)
-{
-	ST40PCI_WRITE(PAR, CONFIG_CMD(dev, where));
-
-	ST40PCI_WRITE_SHORT(PDR + (where & 2), val);
+	ST40PCI_WRITE(PAR, CONFIG_CMD(bus, devfn, where));
+	switch (size) {
+		case 1:
+			*val = (u8)ST40PCI_READ_BYTE(PDR + (where & 3));
+			break;
+		case 2:
+			*val = (u16)ST40PCI_READ_SHORT(PDR + (where & 2));
+			break;
+		case 4:
+		 	*val = ST40PCI_READ(PDR); 
+			break;
+	}
 
-	CheckForMasterAbort();
+	if (CheckForMasterAbort()){
+		switch (size) {
+			case 1:
+				*val = (u8)0xff;
+				break;
+			case 2:
+				*val = (u16)0xffff;
+				break;
+			case 4:
+				*val = 0xffffffff;
+				break;
+		}
+	}
 
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int st40pci_write_config_dword(struct pci_dev *dev, int where,
-				      u32 val)
+static int st40pci_write(struct pci_bus *bus, unsigned int devfn; int where, int size, u32 val)
 {
 	ST40PCI_WRITE(PAR, CONFIG_CMD(dev, where));
 
-	ST40PCI_WRITE(PDR, val);
+	switch (size) {
+		case 1:
+			ST40PCI_WRITE_BYTE(PDR + (where & 3), (u8)val);
+			break;
+		case 2:
+			ST40PCI_WRITE_SHORT(PDR + (where & 2), (u16)val);
+			break;
+		case 4:
+			ST40PCI_WRITE(PDR, val);
+			break;
+	}
 
 	CheckForMasterAbort();
 
@@ -364,12 +338,8 @@
 }
 
 static struct pci_ops pci_config_ops = {
-	st40pci_read_config_byte,
-	st40pci_read_config_word,
-	st40pci_read_config_dword,
-	st40pci_write_config_byte,
-	st40pci_write_config_word,
-	st40pci_write_config_dword
+	.read = 	st40pci_read,
+	.write = 	st40pci_write,
 };
 
 
