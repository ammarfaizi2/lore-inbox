Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319689AbSH3WWV>; Fri, 30 Aug 2002 18:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319690AbSH3WWU>; Fri, 30 Aug 2002 18:22:20 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:2052 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319689AbSH3WWH>;
	Fri, 30 Aug 2002 18:22:07 -0400
Date: Fri, 30 Aug 2002 15:25:29 -0700
From: Greg KH <greg@kroah.com>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] PCI ops cleanups for 2.5.32-bk
Message-ID: <20020830222529.GA10877@kroah.com>
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

Here's the arm fixup.  I didn't try to change the iop310-pci.c file, as
it looked trickier than I wanted to attempt (it is using dev->sysdata,
which isn't available anymore.)

thanks,

greg k-h


diff -Nru a/arch/arm/kernel/plx90x0.c b/arch/arm/kernel/plx90x0.c
--- a/arch/arm/kernel/plx90x0.c	Fri Aug 30 13:59:41 2002
+++ b/arch/arm/kernel/plx90x0.c	Fri Aug 30 13:59:41 2002
@@ -34,9 +34,9 @@
 #define PLX_SET_CONFIG							\
 	{ unsigned long flags;						\
 	local_irq_save(flags);						\
-	__raw_writel((1<<31 | (dev->bus->number << 16)			\
-		| (dev->devfn << 8) | (where & ~3)			\
-		| ((dev->bus->number == 0)?0:1)), PLX_BASE + 0xac);	\
+	__raw_writel((1<<31 | (bus->number << 16)			\
+		| (devfn << 8) | (where & ~3)				\
+		| ((bus->number == 0)?0:1)), PLX_BASE + 0xac);		\
 
 #define PLX_CONFIG_WRITE(size)						\
 	PLX_SET_CONFIG							\
@@ -58,47 +58,47 @@
 
 /* Configuration space access routines */
 
-static int
-plx90x0_read_config_byte (struct pci_dev *dev,
-			  int where, u8 *value)
-{
-	PLX_CONFIG_READ(b)
-}
-
-static int
-plx90x0_read_config_word (struct pci_dev *dev,
-			  int where, u16 *value)
-{
-	PLX_CONFIG_READ(w)
-}
-
-static int 
-plx90x0_read_config_dword (struct pci_dev *dev,
-			   int where, u32 *value)
-{
-	PLX_CONFIG_READ(l)
-}
-
 static int 
-plx90x0_write_config_byte (struct pci_dev *dev,
-			   int where, u8 value)
+plx90x0_read_config (struct pci_bus *bus, unsigned int devfn, int where,
+		     int where, int size, u32 *value)
 {
-	PLX_CONFIG_WRITE(b)
+	switch (size) {
+	case 1:
+		PLX_CONFIG_READ(b)
+		break;
+	case 2:
+		PLX_CONFIG_READ(w)
+		break;
+	case 4:
+		PLX_CONFIG_READ(l)
+		break;
+	}
+	return PCIBIOS_SUCCESSFUL;
 }
 
 static int 
-plx90x0_write_config_word (struct pci_dev *dev,
-			   int where, u16 value)
+plx90x0_write_config (struct pci_bus *bus, unsigned int devfn, int where,
+		      int where, int size, u32 value)
 {
-	PLX_CONFIG_WRITE(w)
+	switch (size) {
+	case 1:
+		PLX_CONFIG_WRITE(b)
+		break;
+	case 2:
+		PLX_CONFIG_WRITE(w)
+		break;
+	case 4:
+		PLX_CONFIG_WRITE(l)
+		break;
+	}
+	return PCIBIOS_SUCCESSFUL;
 }
 
-static int 
-plx90x0_write_config_dword (struct pci_dev *dev,
-			    int where, u32 value)
+static struct pci_ops plx90x0_ops = 
 {
-	PLX_CONFIG_WRITE(l)
-}
+	.read =		plx90x0_read_config,
+	.write =	plx90x0_write_config,
+};
 
 static void 
 plx_syserr_handler(int irq, void *handle, struct pt_regs *regs)
@@ -107,17 +107,6 @@
 	       readw(PLX_BASE + 6), regs->ARM_pc);
 	__raw_writew(0xf000, PLX_BASE + 6);
 }
-
-static struct pci_ops 
-plx90x0_ops = 
-{
-	plx90x0_read_config_byte,
-	plx90x0_read_config_word,
-	plx90x0_read_config_dword,
-	plx90x0_write_config_byte,
-	plx90x0_write_config_word,
-	plx90x0_write_config_dword,
-};
 
 /*
  * Initialise the PCI system.
diff -Nru a/arch/arm/kernel/via82c505.c b/arch/arm/kernel/via82c505.c
--- a/arch/arm/kernel/via82c505.c	Fri Aug 30 13:59:41 2002
+++ b/arch/arm/kernel/via82c505.c	Fri Aug 30 13:59:41 2002
@@ -15,63 +15,49 @@
 
 #define MAX_SLOTS		7
 
-#define CONFIG_CMD(dev, where)   (0x80000000 | (dev->bus->number << 16) | (dev->devfn << 8) | (where & ~3))
+#define CONFIG_CMD(bus, devfn, where)   (0x80000000 | (bus->number << 16) | (devfn << 8) | (where & ~3))
 
 static int
-via82c505_read_config_byte(struct pci_dev *dev, int where, u8 *value)
+via82c505_read_config(struct pci_bus *bus, unsigned int devfn, int where,
+		      int size, u32 *value)
 {
 	outl(CONFIG_CMD(dev,where),0xCF8);
-	*value=inb(0xCFC + (where&3));
+	switch (size) {
+	case 1:
+		*value=inb(0xCFC + (where&3));
+		break;
+	case 2:
+		*value=inw(0xCFC + (where&2));
+		break;
+	case 4:
+		*value=inl(0xCFC);
+		break;
+	}
 	return PCIBIOS_SUCCESSFUL;
 }
 
 static int
-via82c505_read_config_word(struct pci_dev *dev, int where, u16 *value)
-{
-	outl(CONFIG_CMD(dev,where),0xCF8);
-	*value=inw(0xCFC + (where&2));
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-via82c505_read_config_dword(struct pci_dev *dev, int where, u32 *value)
-{
-	outl(CONFIG_CMD(dev,where),0xCF8);
-	*value=inl(0xCFC);
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-via82c505_write_config_byte(struct pci_dev *dev, int where, u8 value)
-{
-	outl(CONFIG_CMD(dev,where),0xCF8);
-	outb(value, 0xCFC + (where&3));
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-via82c505_write_config_word(struct pci_dev *dev, int where, u16 value)
-{
-	outl(CONFIG_CMD(dev,where),0xCF8);
-	outw(value, 0xCFC + (where&2));
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-via82c505_write_config_dword(struct pci_dev *dev, int where, u32 value)
-{
-	outl(CONFIG_CMD(dev,where),0xCF8);
-	outl(value, 0xCFC);
+via82c505_write_config(struct pci_bus *bus, unsigned int devfn, int where
+		       int size, u32 value)
+{
+	outl(CONFIG_CMD(bus,devfn,where),0xCF8);
+	switch (size) {
+	case 1:
+		outb(value, 0xCFC + (where&3));
+		break;
+	case 2:
+		outw(value, 0xCFC + (where&2));
+		break;
+	case 4:
+		outl(value, 0xCFC);
+		break;
+	}
 	return PCIBIOS_SUCCESSFUL;
 }
 
 static struct pci_ops via82c505_ops = {
-	via82c505_read_config_byte,
-	via82c505_read_config_word,
-	via82c505_read_config_dword,
-	via82c505_write_config_byte,
-	via82c505_write_config_word,
-	via82c505_write_config_dword,
+	.read =		via82c505_read_config,
+	.write =	via82c505_write_config,
 };
 
 void __init via82c505_preinit(void *sysdata)
diff -Nru a/arch/arm/mach-footbridge/dc21285.c b/arch/arm/mach-footbridge/dc21285.c
--- a/arch/arm/mach-footbridge/dc21285.c	Fri Aug 30 13:59:41 2002
+++ b/arch/arm/mach-footbridge/dc21285.c	Fri Aug 30 13:59:41 2002
@@ -36,12 +36,11 @@
 extern void register_isa_ports(unsigned int, unsigned int, unsigned int);
 
 static unsigned long
-dc21285_base_address(struct pci_dev *dev)
+dc21285_base_address(struct pci_bus *bus, unsigned int devfn)
 {
 	unsigned long addr = 0;
-	unsigned int devfn = dev->devfn;
 
-	if (dev->bus->number == 0) {
+	if (bus->number == 0) {
 		if (PCI_SLOT(devfn) == 0)
 			/*
 			 * For devfn 0, point at the 21285
@@ -54,54 +53,33 @@
 				addr = PCICFG0_BASE | 0xc00000 | (devfn << 8);
 		}
 	} else
-		addr = PCICFG1_BASE | (dev->bus->number << 16) | (devfn << 8);
+		addr = PCICFG1_BASE | (bus->number << 16) | (devfn << 8);
 
 	return addr;
 }
 
 static int
-dc21285_read_config_byte(struct pci_dev *dev, int where, u8 *value)
+dc21285_read_config(struct pci_bus *bus, unsigned int devfn, int where,
+		    int size, u32 *value)
 {
-	unsigned long addr = dc21285_base_address(dev);
-	u8 v;
-
-	if (addr)
-		asm("ldr%?b	%0, [%1, %2]"
-			: "=r" (v) : "r" (addr), "r" (where));
-	else
-		v = 0xff;
-
-	*value = v;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-dc21285_read_config_word(struct pci_dev *dev, int where, u16 *value)
-{
-	unsigned long addr = dc21285_base_address(dev);
-	u16 v;
-
-	if (addr)
-		asm("ldr%?h	%0, [%1, %2]"
-			: "=r" (v) : "r" (addr), "r" (where));
-	else
-		v = 0xffff;
-
-	*value = v;
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-dc21285_read_config_dword(struct pci_dev *dev, int where, u32 *value)
-{
-	unsigned long addr = dc21285_base_address(dev);
+	unsigned long addr = dc21285_base_address(bus, devfn);
 	u32 v;
 
 	if (addr)
-		asm("ldr%?	%0, [%1, %2]"
-			: "=r" (v) : "r" (addr), "r" (where));
+		switch (size) {
+		case 1:
+			asm("ldr%?b	%0, [%1, %2]"
+				: "=r" (v) : "r" (addr), "r" (where));
+			break;
+		case 2:
+			asm("ldr%?h	%0, [%1, %2]"
+				: "=r" (v) : "r" (addr), "r" (where));
+			break;
+		case 4:
+			asm("ldr%?	%0, [%1, %2]"
+				: "=r" (v) : "r" (addr), "r" (where));
+			break;
+		}
 	else
 		v = 0xffffffff;
 
@@ -111,48 +89,33 @@
 }
 
 static int
-dc21285_write_config_byte(struct pci_dev *dev, int where, u8 value)
-{
-	unsigned long addr = dc21285_base_address(dev);
-
-	if (addr)
-		asm("str%?b	%0, [%1, %2]"
-			: : "r" (value), "r" (addr), "r" (where));
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-dc21285_write_config_word(struct pci_dev *dev, int where, u16 value)
-{
-	unsigned long addr = dc21285_base_address(dev);
-
-	if (addr)
-		asm("str%?h	%0, [%1, %2]"
-			: : "r" (value), "r" (addr), "r" (where));
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int
-dc21285_write_config_dword(struct pci_dev *dev, int where, u32 value)
+dc21285_write_config(struct pci_bus *bus, unsigned int devfn, int where,
+		     int size, u32 value)
 {
-	unsigned long addr = dc21285_base_address(dev);
+	unsigned long addr = dc21285_base_address(bus, devfn);
 
 	if (addr)
-		asm("str%?	%0, [%1, %2]"
-			: : "r" (value), "r" (addr), "r" (where));
+		switch (size) {
+		case 1:
+			asm("str%?b	%0, [%1, %2]"
+				: : "r" (value), "r" (addr), "r" (where));
+			break;
+		case 2:
+			asm("str%?h	%0, [%1, %2]"
+				: : "r" (value), "r" (addr), "r" (where));
+			break;
+		case 4:
+			asm("str%?	%0, [%1, %2]"
+				: : "r" (value), "r" (addr), "r" (where));
+			break;
+		}
 
 	return PCIBIOS_SUCCESSFUL;
 }
 
 static struct pci_ops dc21285_ops = {
-	dc21285_read_config_byte,
-	dc21285_read_config_word,
-	dc21285_read_config_dword,
-	dc21285_write_config_byte,
-	dc21285_write_config_word,
-	dc21285_write_config_dword,
+	.read =		dc21285_read_config,
+	.write =	dc21285_write_config,
 };
 
 static struct timer_list serr_timer;
diff -Nru a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-integrator/pci_v3.c
--- a/arch/arm/mach-integrator/pci_v3.c	Fri Aug 30 13:59:41 2002
+++ b/arch/arm/mach-integrator/pci_v3.c	Fri Aug 30 13:59:41 2002
@@ -181,11 +181,12 @@
 #undef V3_LB_BASE_PREFETCH
 #define V3_LB_BASE_PREFETCH 0
 
-static unsigned long v3_open_config_window(struct pci_dev *dev, int offset)
+static unsigned long v3_open_config_window(struct pci_bus *bus,
+					   unsigned int devfn, int offset)
 {
 	unsigned int address, mapaddress, busnr;
 
-	busnr = dev->bus->number;
+	busnr = bus->number;
 
 	/*
 	 * Trap out illegal values
@@ -194,11 +195,11 @@
 		BUG();
 	if (busnr > 255)
 		BUG();
-	if (dev->devfn > 255)
+	if (devfn > 255)
 		BUG();
 
 	if (busnr == 0) {
-		int slot = PCI_SLOT(dev->devfn);
+		int slot = PCI_SLOT(devfn);
 
 		/*
 		 * local bus segment so need a type 0 config cycle
@@ -210,7 +211,7 @@
 		 *  3:1 = config cycle (101)
 		 *  0   = PCI A1 & A0 are 0 (0)
 		 */
-		address = PCI_FUNC(dev->devfn) << 8;
+		address = PCI_FUNC(devfn) << 8;
 		mapaddress = V3_LB_MAP_TYPE_CONFIG;
 
 		if (slot > 12)
@@ -237,7 +238,7 @@
 		 *  0   = PCI A1 & A0 from host bus (1)
 		 */
 		mapaddress = V3_LB_MAP_TYPE_CONFIG | V3_LB_MAP_AD_LOW_EN;
-		address = (busnr << 16) | (dev->devfn << 8);
+		address = (busnr << 16) | (devfn << 8);
 	}
 
 	/*
@@ -276,52 +277,29 @@
 			V3_LB_BASE_ADR_SIZE_256MB | V3_LB_BASE_ENABLE);
 }
 
-static int v3_read_config_byte(struct pci_dev *dev, int where, u8 *val)
-{
-	unsigned long addr;
-	unsigned long flags;
-	u8 v;
-
-	spin_lock_irqsave(&v3_lock, flags);
-	addr = v3_open_config_window(dev, where);
-
-	v = __raw_readb(addr);
-
-	v3_close_config_window();
-	spin_unlock_irqrestore(&v3_lock, flags);
-
-	*val = v;
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int v3_read_config_word(struct pci_dev *dev, int where, u16 *val)
-{
-	unsigned long addr;
-	unsigned long flags;
-	u16 v;
-
-	spin_lock_irqsave(&v3_lock, flags);
-	addr = v3_open_config_window(dev, where);
-
-	v = __raw_readw(addr);
-
-	v3_close_config_window();
-	spin_unlock_irqrestore(&v3_lock, flags);
-
-	*val = v;
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int v3_read_config_dword(struct pci_dev *dev, int where, u32 *val)
+static int v3_read_config(struct pci_bus *bus, unsigned int devfn, int where,
+			  int size, u32 *val)
 {
 	unsigned long addr;
 	unsigned long flags;
 	u32 v;
 
 	spin_lock_irqsave(&v3_lock, flags);
-	addr = v3_open_config_window(dev, where);
+	addr = v3_open_config_window(bus, devfn, where);
 
-	v = __raw_readl(addr);
+	switch (size) {
+	case 1:
+		v = __raw_readb(addr);
+		break;
+
+	case 2:
+		v = __raw_readw(addr);
+		break;
+
+	case 4:
+		v = __raw_readl(addr);
+		break;
+	}
 
 	v3_close_config_window();
 	spin_unlock_irqrestore(&v3_lock, flags);
@@ -330,50 +308,31 @@
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int v3_write_config_byte(struct pci_dev *dev, int where, u8 val)
-{
-	unsigned long addr;
-	unsigned long flags;
-
-	spin_lock_irqsave(&v3_lock, flags);
-	addr = v3_open_config_window(dev, where);
-
-	__raw_writeb(val, addr);
-	__raw_readb(addr);
-	
-	v3_close_config_window();
-	spin_unlock_irqrestore(&v3_lock, flags);
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int v3_write_config_word(struct pci_dev *dev, int where, u16 val)
+static int v3_write_config(struct pci_bus *bus, unsigned int devfn, int where,
+			   int size, u32 val)
 {
 	unsigned long addr;
 	unsigned long flags;
 
 	spin_lock_irqsave(&v3_lock, flags);
-	addr = v3_open_config_window(dev, where);
+	addr = v3_open_config_window(bus, devfn, where);
 
-	__raw_writew(val, addr);
-	__raw_readw(addr);
+	switch (size) {
+	case 1:
+		__raw_writeb((u8)val, addr);
+		__raw_readb(addr);
+		break;
 
-	v3_close_config_window();
-	spin_unlock_irqrestore(&v3_lock, flags);
+	case 2:
+		__raw_writew((u16)val, addr);
+		__raw_readw(addr);
+		break;
 
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int v3_write_config_dword(struct pci_dev *dev, int where, u32 val)
-{
-	unsigned long addr;
-	unsigned long flags;
-
-	spin_lock_irqsave(&v3_lock, flags);
-	addr = v3_open_config_window(dev, where);
-
-	__raw_writel(val, addr);
-	__raw_readl(addr);
+	case 4:
+		__raw_writel(val, addr);
+		__raw_readl(addr);
+		break;
+	}
 
 	v3_close_config_window();
 	spin_unlock_irqrestore(&v3_lock, flags);
@@ -382,12 +341,8 @@
 }
 
 static struct pci_ops pci_v3_ops = {
-	.read_byte	= v3_read_config_byte,
-	.read_word	= v3_read_config_word,
-	.read_dword	= v3_read_config_dword,
-	.write_byte	= v3_write_config_byte,
-	.write_word	= v3_write_config_word,
-	.write_dword	= v3_write_config_dword,
+	.read =		v3_read_config,
+	.write =	v3_write_config,
 };
 
 static struct resource non_mem = {
