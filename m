Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318065AbSHVXpn>; Thu, 22 Aug 2002 19:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318107AbSHVXpn>; Thu, 22 Aug 2002 19:45:43 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:36777 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318065AbSHVXpj>; Thu, 22 Aug 2002 19:45:39 -0400
Date: Thu, 22 Aug 2002 16:54:00 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: gregkh@us.ibm.com
cc: linux-kernel@vger.kernel.org, Hanna Linder <hannal@us.ibm.com>
Subject: Re: PCI Cleanup
Message-ID: <47950000.1030060440@w-hlinder>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One more file in sh arch ported to the new pci_ops changes. 
This will apply agains bk://linuxusb.bkbits.net/pci_hp-2.5
(roughly 2.5.31).

Hanna

-----
diff -Nru a/arch/sh/kernel/pci-sh7751.c b/arch/sh/kernel/pci-sh7751.c
--- a/arch/sh/kernel/pci-sh7751.c	Thu Aug 22 16:49:52 2002
+++ b/arch/sh/kernel/pci-sh7751.c	Thu Aug 22 16:49:52 2002
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

