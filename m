Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319693AbSH3WXn>; Fri, 30 Aug 2002 18:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319695AbSH3WXn>; Fri, 30 Aug 2002 18:23:43 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:3332 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319693AbSH3WXU>;
	Fri, 30 Aug 2002 18:23:20 -0400
Date: Fri, 30 Aug 2002 15:26:43 -0700
From: Greg KH <greg@kroah.com>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] PCI ops cleanups for 2.5.32-bk
Message-ID: <20020830222642.GB10877@kroah.com>
References: <20020830220720.GA10783@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020830220720.GA10783@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2002 at 03:07:21PM -0700, Greg KH wrote:
> Hi,
> 
> Here are the pci_ops cleanups that were discussed on lkml last week.  It
> removes a lot of code from the arch specific implementation of
> pci_*_config* functions, and removes lots of code from the pci_hotplug
> core (yes, the pci_hotplug code is still broken, I'm working on that
> next...) 
> 
> These patches includes fixups for almost all of the different
> architecture specific code.  I have a number of patches that I will send
> to some of the arch maintainers directly, that are not included in this
> bk tree.

Here's the patch for sparc64.  David, please apply to your tree.

thanks,

greg k-h


diff -Nru a/arch/sparc64/kernel/pci_sabre.c b/arch/sparc64/kernel/pci_sabre.c
--- a/arch/sparc64/kernel/pci_sabre.c	Fri Aug 30 13:59:47 2002
+++ b/arch/sparc64/kernel/pci_sabre.c	Fri Aug 30 13:59:47 2002
@@ -258,56 +258,25 @@
 		 PCI_SLOT(devfn) > 8));
 }
 
-static int __sabre_read_byte(struct pci_dev *dev, int where, u8 *value)
+static int __sabre_read(struct pci_bus *bus_dev, unsigned int devfn,
+			int where, int size, u32 *value)
 {
-	struct pci_pbm_info *pbm = pci_bus2pbm[dev->bus->number];
-	unsigned char bus = dev->bus->number;
-	unsigned int devfn = dev->devfn;
-	u8 *addr;
-
-	*value = 0xff;
-	addr = sabre_pci_config_mkaddr(pbm, bus, devfn, where);
-	if (!addr)
-		return PCIBIOS_SUCCESSFUL;
-
-	if (__sabre_out_of_range(pbm, bus, devfn))
-		return PCIBIOS_SUCCESSFUL;
-	pci_config_read8(addr, value);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int __sabre_read_word(struct pci_dev *dev, int where, u16 *value)
-{
-	struct pci_pbm_info *pbm = pci_bus2pbm[dev->bus->number];
-	unsigned char bus = dev->bus->number;
-	unsigned int devfn = dev->devfn;
-	u16 *addr;
-
-	*value = 0xffff;
-	addr = sabre_pci_config_mkaddr(pbm, bus, devfn, where);
-	if (!addr)
-		return PCIBIOS_SUCCESSFUL;
-
-	if (__sabre_out_of_range(pbm, bus, devfn))
-		return PCIBIOS_SUCCESSFUL;
+	struct pci_pbm_info *pbm = pci_bus2pbm[bus_dev->number];
+	unsigned char bus = bus_dev->number;
+	u32 *addr;
 
-	if (where & 0x01) {
-		printk("pcibios_read_config_word: misaligned reg [%x]\n",
-		       where);
-		return PCIBIOS_SUCCESSFUL;
+	switch (size) {
+	case 1:
+		*value = 0xff;
+		break;
+	case 2:
+		*value = 0xffff;
+		break;
+	case 4:
+		*value = 0xffffffff;
+		break;
 	}
-	pci_config_read16(addr, value);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int __sabre_read_dword(struct pci_dev *dev, int where, u32 *value)
-{
-	struct pci_pbm_info *pbm = pci_bus2pbm[dev->bus->number];
-	unsigned char bus = dev->bus->number;
-	unsigned int devfn = dev->devfn;
-	u32 *addr;
 
-	*value = 0xffffffff;
 	addr = sabre_pci_config_mkaddr(pbm, bus, devfn, where);
 	if (!addr)
 		return PCIBIOS_SUCCESSFUL;
@@ -315,86 +284,97 @@
 	if (__sabre_out_of_range(pbm, bus, devfn))
 		return PCIBIOS_SUCCESSFUL;
 
-	if (where & 0x03) {
-		printk("pcibios_read_config_dword: misaligned reg [%x]\n",
-		       where);
-		return PCIBIOS_SUCCESSFUL;
-	}
-	pci_config_read32(addr, value);
-	return PCIBIOS_SUCCESSFUL;
-}
+	switch (size) {
+	case 1:
+		pci_config_read8(addr, value);
+		break;
 
-static int sabre_read_byte(struct pci_dev *dev, int where, u8 *value)
-{
-	if (dev->bus->number)
-		return __sabre_read_byte(dev, where, value);
+	case 2:
+		if (where & 0x01) {
+			printk("pci_read_config_word: misaligned reg [%x]\n",
+			       where);
+			return PCIBIOS_SUCCESSFUL;
+		}
+		pci_config_read16(addr, value);
+		break;
 
-	if (sabre_out_of_range(dev->devfn)) {
-		*value = 0xff;
-		return PCIBIOS_SUCCESSFUL;
+	case 4:
+		if (where & 0x03) {
+			printk("pci_read_config_dword: misaligned reg [%x]\n",
+			       where);
+			return PCIBIOS_SUCCESSFUL;
+		}
+		pci_config_read32(addr, value);
+		break;
 	}
 
-	if (where < 8) {
-		u16 tmp;
-
-		__sabre_read_word(dev, where & ~1, &tmp);
-		if (where & 1)
-			*value = tmp >> 8;
-		else
-			*value = tmp & 0xff;
-		return PCIBIOS_SUCCESSFUL;
-	} else
-		return __sabre_read_byte(dev, where, value);
+	return PCIBIOS_SUCCESSFUL;
 }
 
-static int sabre_read_word(struct pci_dev *dev, int where, u16 *value)
+static int sabre_read(struct pci_bus *bus, unsigned int devfn,
+		      int where, int size, u32 *value)
 {
-	if (dev->bus->number)
-		return __sabre_read_word(dev, where, value);
+	if (bus->number)
+		return __sabre_read(bus, devfn, where, size, value);
 
-	if (sabre_out_of_range(dev->devfn)) {
-		*value = 0xffff;
+	if (sabre_out_of_range(devfn)) {
+		switch (size) {
+		case 1:
+			*value = 0xff;
+			break;
+		case 2:
+			*value = 0xffff;
+			break;
+		case 4:
+			*value = 0xffffffff;
+			break;
+		}
 		return PCIBIOS_SUCCESSFUL;
 	}
 
-	if (where < 8)
-		return __sabre_read_word(dev, where, value);
-	else {
-		u8 tmp;
+	switch (size) {
+	case 1:
+		if (where < 8) {
+			u16 tmp;
+
+			__sabre_read(bus, devfn, where & ~1, 2, &tmp);
+			if (where & 1)
+				*value = tmp >> 8;
+			else
+				*value = tmp & 0xff;
+		} else
+			return __sabre_read(bus, devfn, where, 1, value);
+		break;
+
+	case 2:
+		if (where < 8)
+			return __sabre_read(bus, devfn, where, 2, value);
+		else {
+			u8 tmp;
+
+			__sabre_read(bus, devfn, where, 1, &tmp);
+			*value = tmp;
+			__sabre_read(bus, devfn, where + 1, 1, &tmp);
+			*value |= tmp << 8;
+		}
+		break;
 
-		__sabre_read_byte(dev, where, &tmp);
+	case 4:
+		sabre_read(bus, devfn, where, 2, &tmp);
 		*value = tmp;
-		__sabre_read_byte(dev, where + 1, &tmp);
-		*value |= tmp << 8;
-		return PCIBIOS_SUCCESSFUL;
+		sabre_read(bus, devfn, where + 2, 2, &tmp);
+		*value |= tmp << 16;
+		break;
 	}
-}
-
-static int sabre_read_dword(struct pci_dev *dev, int where, u32 *value)
-{
-	u16 tmp;
-
-	if (dev->bus->number)
-		return __sabre_read_dword(dev, where, value);
-
-	if (sabre_out_of_range(dev->devfn)) {
-		*value = 0xffffffff;
-		return PCIBIOS_SUCCESSFUL;
-	}
-
-	sabre_read_word(dev, where, &tmp);
-	*value = tmp;
-	sabre_read_word(dev, where + 2, &tmp);
-	*value |= tmp << 16;
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int __sabre_write_byte(struct pci_dev *dev, int where, u8 value)
+static int __sabre_write(struct pci_bus *bus_dev, unsigned int devfn,
+			 int where, int size, u32 value)
 {
-	struct pci_pbm_info *pbm = pci_bus2pbm[dev->bus->number];
-	unsigned char bus = dev->bus->number;
-	unsigned int devfn = dev->devfn;
-	u8 *addr;
+	struct pci_pbm_info *pbm = pci_bus2pbm[bus_dev->number];
+	unsigned char bus = bus_dev->number;
+	u32 *addr;
 
 	addr = sabre_pci_config_mkaddr(pbm, bus, devfn, where);
 	if (!addr)
@@ -402,117 +382,79 @@
 
 	if (__sabre_out_of_range(pbm, bus, devfn))
 		return PCIBIOS_SUCCESSFUL;
-	pci_config_write8(addr, value);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int __sabre_write_word(struct pci_dev *dev, int where, u16 value)
-{
-	struct pci_pbm_info *pbm = pci_bus2pbm[dev->bus->number];
-	unsigned char bus = dev->bus->number;
-	unsigned int devfn = dev->devfn;
-	u16 *addr;
-
-	addr = sabre_pci_config_mkaddr(pbm, bus, devfn, where);
-	if (!addr)
-		return PCIBIOS_SUCCESSFUL;
 
-	if (__sabre_out_of_range(pbm, bus, devfn))
-		return PCIBIOS_SUCCESSFUL;
+	switch (size) {
+	case 1:
+		pci_config_write8(addr, (u8 *)value);
+		break;
+
+	case 2:
+		if (where & 0x01) {
+			printk("pci_write_config_word: misaligned reg [%x]\n",
+			       where);
+			return PCIBIOS_SUCCESSFUL;
+		}
+		pci_config_write16(addr, (u16 *)value);
+		break;
 
-	if (where & 0x01) {
-		printk("pcibios_write_config_word: misaligned reg [%x]\n",
-		       where);
-		return PCIBIOS_SUCCESSFUL;
+	case 4:
+		if (where & 0x03) {
+			printk("pci_write_config_dword: misaligned reg [%x]\n",
+			       where);
+			return PCIBIOS_SUCCESSFUL;
+		}
+		pci_config_write32(addr, value);
+		break;
 	}
-	pci_config_write16(addr, value);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int __sabre_write_dword(struct pci_dev *dev, int where, u32 value)
-{
-	struct pci_pbm_info *pbm = pci_bus2pbm[dev->bus->number];
-	unsigned char bus = dev->bus->number;
-	unsigned int devfn = dev->devfn;
-	u32 *addr;
 
-	addr = sabre_pci_config_mkaddr(pbm, bus, devfn, where);
-	if (!addr)
-		return PCIBIOS_SUCCESSFUL;
-
-	if (__sabre_out_of_range(pbm, bus, devfn))
-		return PCIBIOS_SUCCESSFUL;
-
-	if (where & 0x03) {
-		printk("pcibios_write_config_dword: misaligned reg [%x]\n",
-		       where);
-		return PCIBIOS_SUCCESSFUL;
-	}
-	pci_config_write32(addr, value);
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int sabre_write_byte(struct pci_dev *dev, int where, u8 value)
+static int sabre_write(struct pci_bus *bus, unsigned int devfn,
+		       int where, int size, u32 value)
 {
-	if (dev->bus->number)
-		return __sabre_write_byte(dev, where, value);
+	if (bus->number)
+		return __sabre_write(bus, devfn, where, size, value);
 
-	if (sabre_out_of_range(dev->devfn))
+	if (sabre_out_of_range(devfn))
 		return PCIBIOS_SUCCESSFUL;
 
-	if (where < 8) {
-		u16 tmp;
+	switch (size) {
+	case 1:
+		if (where < 8) {
+			u16 tmp;
 
-		__sabre_read_word(dev, where & ~1, &tmp);
-		if (where & 1) {
-			value &= 0x00ff;
-			value |= tmp << 8;
-		} else {
-			value &= 0xff00;
-			value |= tmp;
-		}
-		return __sabre_write_word(dev, where & ~1, tmp);
-	} else
-		return __sabre_write_byte(dev, where, value);
-}
-
-static int sabre_write_word(struct pci_dev *dev, int where, u16 value)
-{
-	if (dev->bus->number)
-		return __sabre_write_word(dev, where, value);
-
-	if (sabre_out_of_range(dev->devfn))
-		return PCIBIOS_SUCCESSFUL;
-
-	if (where < 8)
-		return __sabre_write_word(dev, where, value);
-	else {
-		__sabre_write_byte(dev, where, value & 0xff);
-		__sabre_write_byte(dev, where + 1, value >> 8);
-		return PCIBIOS_SUCCESSFUL;
+			__sabre_read(bus, devfn, where & ~1, 2, &tmp);
+			if (where & 1) {
+				value &= 0x00ff;
+				value |= tmp << 8;
+			} else {
+				value &= 0xff00;
+				value |= tmp;
+			}
+			return __sabre_write(bus, devfn, where & ~1, 2, tmp);
+		} else
+			return __sabre_write(bus, devfn, where, 1, value);
+		break;
+	case 2:
+		if (where < 8)
+			return __sabre_write(bus, devfn, where, 2, value);
+		else {
+			__sabre_write(dev, devfn, where, 1, value & 0xff);
+			__sabre_write(bus, devfn, where + 1, 1, value >> 8);
+		}
+		break;
+	case 4:
+		sabre_write(bus, devfn, where, 2, value & 0xffff);
+		sabre_write(dev, devfn, where + 2, 2, value >> 16);
+		break;
 	}
-}
-
-static int sabre_write_dword(struct pci_dev *dev, int where, u32 value)
-{
-	if (dev->bus->number)
-		return __sabre_write_dword(dev, where, value);
-
-	if (sabre_out_of_range(dev->devfn))
-		return PCIBIOS_SUCCESSFUL;
-
-	sabre_write_word(dev, where, value & 0xffff);
-	sabre_write_word(dev, where + 2, value >> 16);
 	return PCIBIOS_SUCCESSFUL;
 }
 
 static struct pci_ops sabre_ops = {
-	sabre_read_byte,
-	sabre_read_word,
-	sabre_read_dword,
-	sabre_write_byte,
-	sabre_write_word,
-	sabre_write_dword
+	.read =		sabre_read,
+	.write =	sabre_write,
 };
 
 static unsigned long sabre_pcislot_imap_offset(unsigned long ino)
diff -Nru a/arch/sparc64/kernel/pci_psycho.c b/arch/sparc64/kernel/pci_psycho.c
--- a/arch/sparc64/kernel/pci_psycho.c	Fri Aug 30 13:59:44 2002
+++ b/arch/sparc64/kernel/pci_psycho.c	Fri Aug 30 13:59:44 2002
@@ -107,119 +107,62 @@
 
 /* PSYCHO PCI configuration space accessors. */
 
-static int psycho_read_byte(struct pci_dev *dev, int where, u8 *value)
+static int psycho_read(struct pci_bus *bus_dev, unsigned int devfn,
+		       int where, int size, u32 value)
 {
-	struct pci_pbm_info *pbm = pci_bus2pbm[dev->bus->number];
-	unsigned char bus = dev->bus->number;
-	unsigned int devfn = dev->devfn;
-	u8 *addr;
-
-	*value = 0xff;
-	addr = psycho_pci_config_mkaddr(pbm, bus, devfn, where);
-	if (!addr)
-		return PCIBIOS_SUCCESSFUL;
-
-	if (psycho_out_of_range(pbm, bus, devfn))
-		return PCIBIOS_SUCCESSFUL;
-	pci_config_read8(addr, value);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int psycho_read_word(struct pci_dev *dev, int where, u16 *value)
-{
-	struct pci_pbm_info *pbm = pci_bus2pbm[dev->bus->number];
-	unsigned char bus = dev->bus->number;
-	unsigned int devfn = dev->devfn;
-	u16 *addr;
-
-	*value = 0xffff;
-	addr = psycho_pci_config_mkaddr(pbm, bus, devfn, where);
-	if (!addr)
-		return PCIBIOS_SUCCESSFUL;
-
-	if (psycho_out_of_range(pbm, bus, devfn))
-		return PCIBIOS_SUCCESSFUL;
-
-	if (where & 0x01) {
-		printk("pcibios_read_config_word: misaligned reg [%x]\n",
-		       where);
-		return PCIBIOS_SUCCESSFUL;
-	}
-	pci_config_read16(addr, value);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int psycho_read_dword(struct pci_dev *dev, int where, u32 *value)
-{
-	struct pci_pbm_info *pbm = pci_bus2pbm[dev->bus->number];
-	unsigned char bus = dev->bus->number;
-	unsigned int devfn = dev->devfn;
+	struct pci_pbm_info *pbm = pci_bus2pbm[bus_dev->number];
+	unsigned char bus = bus_dev->number;
 	u32 *addr;
 
-	*value = 0xffffffff;
-	addr = psycho_pci_config_mkaddr(pbm, bus, devfn, where);
-	if (!addr)
-		return PCIBIOS_SUCCESSFUL;
-
-	if (psycho_out_of_range(pbm, bus, devfn))
-		return PCIBIOS_SUCCESSFUL;
-
-	if (where & 0x03) {
-		printk("pcibios_read_config_dword: misaligned reg [%x]\n",
-		       where);
-		return PCIBIOS_SUCCESSFUL;
+	switch (size) {
+	case 1:
+		*value = 0xff;
+		break;
+	case 2:
+		*value = 0xffff;
+		break;
+	case 4:
+		*value = 0xffffffff;
+		break;
 	}
 
-	pci_config_read32(addr, value);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int psycho_write_byte(struct pci_dev *dev, int where, u8 value)
-{
-	struct pci_pbm_info *pbm = pci_bus2pbm[dev->bus->number];
-	unsigned char bus = dev->bus->number;
-	unsigned int devfn = dev->devfn;
-	u8 *addr;
-
-	addr = psycho_pci_config_mkaddr(pbm, bus, devfn, where);
-	if (!addr)
-		return PCIBIOS_SUCCESSFUL;
-
-	if (psycho_out_of_range(pbm, bus, devfn))
-		return PCIBIOS_SUCCESSFUL;
-
-	pci_config_write8(addr, value);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int psycho_write_word(struct pci_dev *dev, int where, u16 value)
-{
-	struct pci_pbm_info *pbm = pci_bus2pbm[dev->bus->number];
-	unsigned char bus = dev->bus->number;
-	unsigned int devfn = dev->devfn;
-	u16 *addr;
-
 	addr = psycho_pci_config_mkaddr(pbm, bus, devfn, where);
 	if (!addr)
 		return PCIBIOS_SUCCESSFUL;
 
 	if (psycho_out_of_range(pbm, bus, devfn))
 		return PCIBIOS_SUCCESSFUL;
-
-	if (where & 0x01) {
-		printk("pcibios_write_config_word: misaligned reg [%x]\n",
-		       where);
-		return PCIBIOS_SUCCESSFUL;
+	switch (size) {
+	case 1:
+		pci_config_read8((u8 *)addr, value);
+		break;
+
+	case 2:
+		if (where & 0x01) {
+			printk("pci_read_config_word: misaligned reg [%x]\n",
+			       where);
+			return PCIBIOS_SUCCESSFUL;
+		}
+		pci_config_read16((u16 *)addr, value);
+		break;
+
+	case 4:
+		if (where & 0x03) {
+			printk("pci_read_config_dword: misaligned reg [%x]\n",
+			       where);
+			return PCIBIOS_SUCCESSFUL;
+		}
+		pci_config_read32(addr, value);
+		break;
 	}
-	pci_config_write16(addr, value);
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int psycho_write_dword(struct pci_dev *dev, int where, u32 value)
+static int psycho_write(struct pci_bus *bus_dev, unsigned int devfn,
+			int where, int size, u32 value)
 {
-	struct pci_pbm_info *pbm = pci_bus2pbm[dev->bus->number];
-	unsigned char bus = dev->bus->number;
-	unsigned int devfn = dev->devfn;
+	struct pci_pbm_info *pbm = pci_bus2pbm[bus_dev->number];
+	unsigned char bus = bus_dev->number;
 	u32 *addr;
 
 	addr = psycho_pci_config_mkaddr(pbm, bus, devfn, where);
@@ -229,22 +172,34 @@
 	if (psycho_out_of_range(pbm, bus, devfn))
 		return PCIBIOS_SUCCESSFUL;
 
-	if (where & 0x03) {
-		printk("pcibios_write_config_dword: misaligned reg [%x]\n",
-		       where);
-		return PCIBIOS_SUCCESSFUL;
+	switch (size) {
+	case 1:
+		pci_config_write8((u8 *)addr, value);
+		break;
+
+	case 2:
+		if (where & 0x01) {
+			printk("pci_write_config_word: misaligned reg [%x]\n",
+			       where);
+			return PCIBIOS_SUCCESSFUL;
+		}
+		pci_config_write16((u16 *)addr, value);
+		break;
+
+	case 4:
+		if (where & 0x03) {
+			printk("pci_write_config_dword: misaligned reg [%x]\n",
+			       where);
+			return PCIBIOS_SUCCESSFUL;
+		}
+		pci_config_write32(addr, value);
 	}
-	pci_config_write32(addr, value);
 	return PCIBIOS_SUCCESSFUL;
 }
 
 static struct pci_ops psycho_ops = {
-	psycho_read_byte,
-	psycho_read_word,
-	psycho_read_dword,
-	psycho_write_byte,
-	psycho_write_word,
-	psycho_write_dword
+	.read =		psycho_read,
+	.write =	psycho_write,
 };
 
 /* PSYCHO interrupt mapping support. */
diff -Nru a/arch/sparc64/kernel/pci_schizo.c b/arch/sparc64/kernel/pci_schizo.c
--- a/arch/sparc64/kernel/pci_schizo.c	Fri Aug 30 13:59:44 2002
+++ b/arch/sparc64/kernel/pci_schizo.c	Fri Aug 30 13:59:44 2002
@@ -124,119 +124,62 @@
 
 /* SCHIZO PCI configuration space accessors. */
 
-static int schizo_read_byte(struct pci_dev *dev, int where, u8 *value)
+static int schizo_read(struct pci_bus *bus_dev, unsigned int devfn,
+		       int where, int size, u32 value)
 {
-	struct pci_pbm_info *pbm = pci_bus2pbm[dev->bus->number];
-	unsigned char bus = dev->bus->number;
-	unsigned int devfn = dev->devfn;
-	u8 *addr;
-
-	*value = 0xff;
-	addr = schizo_pci_config_mkaddr(pbm, bus, devfn, where);
-	if (!addr)
-		return PCIBIOS_SUCCESSFUL;
-
-	if (schizo_out_of_range(pbm, bus, devfn))
-		return PCIBIOS_SUCCESSFUL;
-	pci_config_read8(addr, value);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int schizo_read_word(struct pci_dev *dev, int where, u16 *value)
-{
-	struct pci_pbm_info *pbm = pci_bus2pbm[dev->bus->number];
-	unsigned char bus = dev->bus->number;
-	unsigned int devfn = dev->devfn;
-	u16 *addr;
-
-	*value = 0xffff;
-	addr = schizo_pci_config_mkaddr(pbm, bus, devfn, where);
-	if (!addr)
-		return PCIBIOS_SUCCESSFUL;
-
-	if (schizo_out_of_range(pbm, bus, devfn))
-		return PCIBIOS_SUCCESSFUL;
-
-	if (where & 0x01) {
-		printk("pcibios_read_config_word: misaligned reg [%x]\n",
-		       where);
-		return PCIBIOS_SUCCESSFUL;
-	}
-	pci_config_read16(addr, value);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int schizo_read_dword(struct pci_dev *dev, int where, u32 *value)
-{
-	struct pci_pbm_info *pbm = pci_bus2pbm[dev->bus->number];
-	unsigned char bus = dev->bus->number;
-	unsigned int devfn = dev->devfn;
+	struct pci_pbm_info *pbm = pci_bus2pbm[bus_dev->number];
+	unsigned char bus = bus_dev->number;
 	u32 *addr;
 
-	*value = 0xffffffff;
-	addr = schizo_pci_config_mkaddr(pbm, bus, devfn, where);
-	if (!addr)
-		return PCIBIOS_SUCCESSFUL;
-
-	if (schizo_out_of_range(pbm, bus, devfn))
-		return PCIBIOS_SUCCESSFUL;
-
-	if (where & 0x03) {
-		printk("pcibios_read_config_dword: misaligned reg [%x]\n",
-		       where);
-		return PCIBIOS_SUCCESSFUL;
+	switch (size) {
+	case 1:
+		*value = 0xff;
+		break;
+	case 2:
+		*value = 0xffff;
+		break;
+	case 4:
+		*value = 0xffffffff;
+		break;
 	}
 
-	pci_config_read32(addr, value);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int schizo_write_byte(struct pci_dev *dev, int where, u8 value)
-{
-	struct pci_pbm_info *pbm = pci_bus2pbm[dev->bus->number];
-	unsigned char bus = dev->bus->number;
-	unsigned int devfn = dev->devfn;
-	u8 *addr;
-
-	addr = schizo_pci_config_mkaddr(pbm, bus, devfn, where);
-	if (!addr)
-		return PCIBIOS_SUCCESSFUL;
-
-	if (schizo_out_of_range(pbm, bus, devfn))
-		return PCIBIOS_SUCCESSFUL;
-
-	pci_config_write8(addr, value);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int schizo_write_word(struct pci_dev *dev, int where, u16 value)
-{
-	struct pci_pbm_info *pbm = pci_bus2pbm[dev->bus->number];
-	unsigned char bus = dev->bus->number;
-	unsigned int devfn = dev->devfn;
-	u16 *addr;
-
 	addr = schizo_pci_config_mkaddr(pbm, bus, devfn, where);
 	if (!addr)
 		return PCIBIOS_SUCCESSFUL;
 
 	if (schizo_out_of_range(pbm, bus, devfn))
 		return PCIBIOS_SUCCESSFUL;
-
-	if (where & 0x01) {
-		printk("pcibios_write_config_word: misaligned reg [%x]\n",
-		       where);
-		return PCIBIOS_SUCCESSFUL;
+	switch (size) {
+	case 1:
+		pci_config_read8((u8 *)addr, value);
+		break;
+
+	case 2:
+		if (where & 0x01) {
+			printk("pci_read_config_word: misaligned reg [%x]\n",
+			       where);
+			return PCIBIOS_SUCCESSFUL;
+		}
+		pci_config_read16((u16 *)addr, value);
+		break;
+
+	case 4:
+		if (where & 0x03) {
+			printk("pci_read_config_dword: misaligned reg [%x]\n",
+			       where);
+			return PCIBIOS_SUCCESSFUL;
+		}
+		pci_config_read32(addr, value);
+		break;
 	}
-	pci_config_write16(addr, value);
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int schizo_write_dword(struct pci_dev *dev, int where, u32 value)
+static int schizo_write(struct pci_bus *bus_dev, unsigned int devfn,
+			int where, int size, u32 value)
 {
-	struct pci_pbm_info *pbm = pci_bus2pbm[dev->bus->number];
-	unsigned char bus = dev->bus->number;
-	unsigned int devfn = dev->devfn;
+	struct pci_pbm_info *pbm = pci_bus2pbm[bus_dev->number];
+	unsigned char bus = bus_dev->number;
 	u32 *addr;
 
 	addr = schizo_pci_config_mkaddr(pbm, bus, devfn, where);
@@ -246,22 +189,34 @@
 	if (schizo_out_of_range(pbm, bus, devfn))
 		return PCIBIOS_SUCCESSFUL;
 
-	if (where & 0x03) {
-		printk("pcibios_write_config_dword: misaligned reg [%x]\n",
-		       where);
-		return PCIBIOS_SUCCESSFUL;
+	switch (size) {
+	case 1:
+		pci_config_write8((u8 *)addr, value);
+		break;
+
+	case 2:
+		if (where & 0x01) {
+			printk("pci_write_config_word: misaligned reg [%x]\n",
+			       where);
+			return PCIBIOS_SUCCESSFUL;
+		}
+		pci_config_write16((u16 *)addr, value);
+		break;
+
+	case 4:
+		if (where & 0x03) {
+			printk("pci_write_config_dword: misaligned reg [%x]\n",
+			       where);
+			return PCIBIOS_SUCCESSFUL;
+		}
+		pci_config_write32(addr, value);
 	}
-	pci_config_write32(addr, value);
 	return PCIBIOS_SUCCESSFUL;
 }
 
 static struct pci_ops schizo_ops = {
-	schizo_read_byte,
-	schizo_read_word,
-	schizo_read_dword,
-	schizo_write_byte,
-	schizo_write_word,
-	schizo_write_dword
+	.read =		schizo_read,
+	.write =	schizo_write,
 };
 
 /* SCHIZO interrupt mapping support.  Unlike Psycho, for this controller the
