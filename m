Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293454AbSBZBxN>; Mon, 25 Feb 2002 20:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293447AbSBZBxA>; Mon, 25 Feb 2002 20:53:00 -0500
Received: from acolyte.thorsen.se ([193.14.93.247]:39686 "HELO
	acolyte.hack.org") by vger.kernel.org with SMTP id <S293439AbSBZBwY>;
	Mon, 25 Feb 2002 20:52:24 -0500
From: Christer Weinigel <wingel@acolyte.hack.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] NatSemi SCx200 Support
Message-Id: <20020226015215.20118F5B@acolyte.hack.org>
Date: Tue, 26 Feb 2002 02:52:15 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is a patch to add support for the National Semiconductor SC1200,
SC2200 and SC3200 families of processors to the Linux kernel.  I hope
this is suitable for the mainstream kernel.  

The drivers adds a generic file, arch/i386/kernel/scx200.c that probes
for a SCx200 CPU and allocates resources.  This file also provides
support for the GPIO pins on the CPU.  Then there are drivers for
individual features of the CPU such as the on chip watchdog timer,
using two GPIO pins as an I2C bus and using a flash chip connected
directly to the CPU.

Finally, there is one file arch/i386/kernel/scx200_nano.c which is
very specific for our hardware.  This file configures the chipset,
doing some hardware specific pin remappings and fixups for the BIOS.
You might want to skip this file, but in my opinion the file isn't
large and only touches the rest of the code to add a call to the init
functions so I belive it belongs in the mainstream kernel too.  Please
tell me if you want a patch without the nano-specific part.

  /Christer

diff -u linux/MAINTAINERS.orig linux/MAINTAINERS
--- linux/MAINTAINERS.orig	Tue Feb 26 01:42:46 2002
+++ linux/MAINTAINERS	Tue Feb 26 01:42:46 2002
@@ -1355,6 +1355,12 @@
 L:	linux-scsi@vger.kernel.org
 S:	Maintained
 
+SCx200 CPU SUPPORT
+P:	Christer Weinigel
+M:	wingel@nano-system.com
+W:	http://www.nano-system.com
+S:	Supported
+
 SGI VISUAL WORKSTATION 320 AND 540
 P:	Bent Hagemark
 M:	bh@sgi.com
diff -urN linux.orig/Documentation/Configure.help linux/Documentation/Configure.help
--- linux.orig/Documentation/Configure.help	Tue Feb 26 01:16:57 2002
+++ linux/Documentation/Configure.help	Tue Feb 26 01:16:58 2002
@@ -24404,6 +24404,66 @@
   information:  http://www.candelatech.com/~greear/vlan.html  If unsure,
   you can safely say 'N'.
 
+National Geode SCx200 support
+CONFIG_ARCH_SCx200
+  This provides basic support for the features of a National
+  Semiconductor SCx200 processor.
+
+  If you don't know what to do here, say N.
+
+  This support is also available as a module.  You probably don't want
+  to do this unless you are a developer modifying this driver.  If
+  compiled as a module, it will be called scx200.o.
+
+Nano Computer support
+CONFIG_ARCH_SCx200_NANO
+  The Nano Computer is a SC2200 based computer from Nano Computer
+  Systems AB, URL: <http://www.nano-system.com>.  Say Y here to create
+  a kernel that will have support for the Nano Computer.
+
+  WARNING!  Do NOT run a kernel compiled for the Nano Computer on any
+  other SC2200 platform; doing so could potentially do bad things to
+  your computer, such as fry your TFT screen.
+
+  This support is also available as a module.  You probably don't want
+  to do this unless you are a developer modifying this driver.  If
+  compiled as a module, it will be called scx200_nano.o.
+
+NatSemi SCx200 Watchdog
+CONFIG_SCx200_WATCHDOG
+  Enable the built-in watchdog timer support on SCx200 processors.
+
+  If compiled as a module, it will be called scx200_watchdog.o.
+
+NatSemi SCx200 I2C using GPIO pins
+CONFIG_I2C_SCx200
+  Enable the use of two GPIO pins of a SCx200 processor as an I2C bus.
+
+  If you don't know what to do here, say N.
+
+  If compiled as a module, it will be called scx200_i2c.o.
+
+GPIOp pin used for SCL
+CONFIG_I2C_SCx200_SCL
+  Enter the GPIO pin number used for the SCL signal.  This value can
+  also be specified with a module parameter, if you want to do that,
+  leave the value as -1.
+
+GPIO pin used for SDA
+CONFIG_I2C_SCx200_SDA
+  Enter the GPIO pin number used for the SSA signal.  This value can
+  also be specified with a module parameter, if you want to do that,
+  leave the value as -1.
+
+Flash device mapped with DOCCS on NatSemi SCx200
+CONFIG_MTD_SCx200_DOCFLASH
+  Enable support for an CFI flash mapped using the DOCCS signal on a
+  SCx200 processor.  
+
+  If you don't know what to do here, say N.
+
+  If compiled as a module, it will be called scx200_docflash.o.
+
 #
 # A couple of things I keep forgetting:
 #   capitalize: AppleTalk, Ethernet, DOS, DMA, FAT, FTP, Internet,
diff -urN linux.orig/arch/i386/config.in linux/arch/i386/config.in
--- linux.orig/arch/i386/config.in	Tue Feb 26 01:16:58 2002
+++ linux/arch/i386/config.in	Tue Feb 26 01:16:58 2002
@@ -235,6 +235,9 @@
    fi
 fi
 
+tristate 'National Geode SCx200 support' CONFIG_ARCH_SCx200
+dep_tristate '    Nano Computer support' CONFIG_ARCH_SCx200_NANO $CONFIG_ARCH_SCx200
+
 source drivers/pci/Config.in
 
 bool 'EISA support' CONFIG_EISA
diff -urN linux.orig/arch/i386/kernel/Makefile linux/arch/i386/kernel/Makefile
--- linux.orig/arch/i386/kernel/Makefile	Tue Feb 26 01:16:58 2002
+++ linux/arch/i386/kernel/Makefile	Tue Feb 26 01:16:58 2002
@@ -41,4 +41,8 @@
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o acpitable.o
 obj-$(CONFIG_X86_VISWS_APIC)	+= visws_apic.o
 
+export-objs += scx200.o
+obj-$(CONFIG_ARCH_SCx200)	+= scx200.o
+obj-$(CONFIG_ARCH_SCx200_NANO)	+= scx200_nano.o
+
 include $(TOPDIR)/Rules.make
diff -urN linux.orig/arch/i386/kernel/scx200.c linux/arch/i386/kernel/scx200.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ linux/arch/i386/kernel/scx200.c	Tue Feb 26 01:16:58 2002
@@ -0,0 +1,240 @@
+/* linux/arch/i386/kernel/scx200.c 
+
+   Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>
+
+   National Semiconductor SCx200 support
+
+   Probe for a SCx200 CPU and locate the Configuration Block.
+   Provide a more user friendly interface to the GPIO pins.
+*/
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+
+#include <linux/scx200.h>
+
+MODULE_AUTHOR("Christer Weinigel <wingel@nano-system.com>");
+MODULE_DESCRIPTION("National Semiconductor Geode SCx200 support");
+MODULE_LICENSE("GPL");
+
+extern int scx200_nano_init(void);
+
+#define CONFIG_BLOCK_SIZE 0x40
+#define GX_BASE_SIZE (64*1024)
+
+static char name[] = "scx200";
+
+struct pci_dev *scx200_f0_pdev;
+struct pci_dev *scx200_f5_pdev;
+unsigned scx200_config_block;
+void *gx1_control;
+
+EXPORT_SYMBOL(scx200_f0_pdev);
+EXPORT_SYMBOL(scx200_f5_pdev);
+EXPORT_SYMBOL(scx200_config_block);
+EXPORT_SYMBOL(gx1_control);
+
+static int __init scx200_probe_config_block(unsigned cb_base)
+{
+	unsigned cb_data;
+
+	/* Check for the presence of the Configuration block.  */
+	cb_data = inw(cb_base + 0x3e);
+	return (cb_data == cb_base);
+}
+
+int __init scx200_init(void)
+{
+	int r;
+	int bank;
+	long flags;
+	u8 gcr;
+	unsigned gx_base;
+	unsigned cb_base;
+	const char *cb_text;
+
+	printk(KERN_DEBUG "%s\n", __PRETTY_FUNCTION__);
+
+	if ((scx200_f0_pdev = pci_find_device(PCI_VENDOR_ID_NS, 
+					      PCI_DEVICE_ID_NS_SCx200_BRIDGE,
+					      NULL)) == NULL)
+		return -ENODEV;
+
+	if ((scx200_f5_pdev = pci_find_device(PCI_VENDOR_ID_NS, 
+					      PCI_DEVICE_ID_NS_SCx200_XBUS,
+					      NULL)) == NULL)
+		return -ENODEV;
+
+	r = pci_request_regions(scx200_f0_pdev, name);
+	if (r) {
+		printk(KERN_WARNING "%s: unable to allocate the F0 I/O region\n", name);
+		return r;
+	}
+
+	/* First check if the configuration BIOS has stored the
+	   Configuration Block address in the scratch pad register */
+	pci_read_config_dword(scx200_f5_pdev, 0x64, &cb_base);
+	if (cb_base && scx200_probe_config_block(cb_base)) {
+		cb_text = "BIOS";
+		goto have_cb;
+	} 
+
+	/* The BIOS hasn't set up the scratch pad register, so first
+	   try the default address specified in the SCx200 errata */
+	cb_base = 0x9000;
+	if (scx200_probe_config_block(cb_base)) {
+		cb_text = "default";
+		goto have_cb;
+	}
+
+	/* Didn't work either, do it the hard way by scanning the I/O
+	   space for it */
+	printk(KERN_DEBUG "%s: Scanning for Configuration Block\n", name);
+	for (cb_base = 0x400; cb_base < 0x10000; cb_base += 64)	{
+		if (scx200_probe_config_block(cb_base)) {
+			cb_text = "scanned";
+			goto have_cb;
+		}
+	}
+	
+	printk(KERN_WARNING "%s: Unable to find Configuration Block\n", name);
+	cb_base = 0;
+	pci_release_regions(scx200_f0_pdev);
+	return -ENODEV;
+
+ have_cb:
+	printk(KERN_INFO "%s: Configuration Block at 0x%04x (%s)\n", 
+	       name, cb_base, cb_text);
+	scx200_config_block = cb_base;
+
+	if (!request_region(scx200_config_block, CONFIG_BLOCK_SIZE, name)) {
+		printk(KERN_WARNING "%s: unable to allocate the Configuration Block I/O region\n", name);
+		pci_release_regions(scx200_f0_pdev);
+		return -EBUSY;
+	}
+
+	save_flags(flags);
+	cli();
+	outb(0xb8, 0x22);	/* Read GCR */
+	gcr = inb(0x23);
+	restore_flags(flags);
+	gx_base = (gcr & 3) << 30;
+	if (gx_base) {
+		printk(KERN_INFO "%s: GX_BASE is 0x%08x\n", name, gx_base);
+		gx1_control = ioremap(gx_base, GX_BASE_SIZE);
+		if (!gx1_control)
+			printk(KERN_WARNING "%s: unable to allocate the GX_BASE I/O region\n", name);
+	}
+	else
+		printk(KERN_INFO "%s: GX_BASE is disabled\n",name);
+
+	if (gx_base) {
+		printk(KERN_DEBUG "MC_MEM_CNTRL1: 0x%08x\n", readl(gx1_control + 0x8404));
+		printk(KERN_DEBUG "MC_MEM_CNTRL2: 0x%08x\n", readl(gx1_control + 0x8404));
+		printk(KERN_DEBUG "MC_SYNC_TIM1:  0x%08x\n", readl(gx1_control + 0x840c));
+	}
+
+	scx200_gpio_base = pci_resource_start(scx200_f0_pdev, 0);
+	printk(KERN_INFO "%s: GPIOs at 0x%x\n", name, scx200_gpio_base);
+
+	/* read the current values driven on the GPIO signals */
+	for (bank = 0; bank < 2; ++bank)
+		scx200_gpio_shadow[bank] = inl(scx200_gpio_base + 0x10 * bank);
+
+#ifdef CONFIG_ARCH_SCx200_NANO
+	scx200_nano_init();
+#endif
+
+	return 0;
+}
+
+#ifdef MODULE
+void __exit scx200_cleanup(void)
+{
+	printk(KERN_DEBUG "%s\n", __PRETTY_FUNCTION__);
+
+	if (gx1_control)
+		iounmap(gx1_control);
+	release_region(scx200_config_block, CONFIG_BLOCK_SIZE);
+	pci_release_regions(scx200_f0_pdev);
+}
+
+module_init(scx200_init);
+module_exit(scx200_cleanup);
+#endif MODULE
+
+/* GPIO stuff */
+
+unsigned scx200_gpio_base;
+u32 scx200_gpio_shadow[2];
+
+spinlock_t scx200_gpio_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t scx200_gpio_config_lock = SPIN_LOCK_UNLOCKED;
+
+/* this should be spinlock protected I suppose */
+u32 scx200_gpio_configure(int index, u32 mask, u32 bits)
+{
+	u32 config, new_config;
+	unsigned long flags;
+
+	spin_lock_irqsave(&scx200_gpio_config_lock, flags);
+
+	outl(index, scx200_gpio_base + 0x20);
+	config = inl(scx200_gpio_base + 0x24);
+
+	new_config = (config & mask) | bits;
+	outl(new_config, scx200_gpio_base + 0x24);
+
+	spin_unlock_irqrestore(&scx200_gpio_config_lock, flags);
+
+	return config;
+}
+
+void scx200_gpio_dump(unsigned index)
+{
+	u32 config = scx200_gpio_configure(index, ~0, 0);
+	printk(KERN_DEBUG "GPIO%02u: 0x%08lx", index, (unsigned long)config);
+	
+	if (config & 1) 
+		printk(" OE"); /* output enabled */
+	else
+		printk(" TS"); /* tristate */
+	if (config & 2) 
+		printk(" PP"); /* push pull */
+	else
+		printk(" OD"); /* open drain */
+	if (config & 4) 
+		printk(" PUE"); /* pull up enabled */
+	else
+		printk(" PUD"); /* pull up disabled */
+	if (config & 8) 
+		printk(" LOCKED"); /* locked */
+	if (config & 16) 
+		printk(" LEVEL"); /* level input */
+	else
+		printk(" EDGE"); /* edge input */
+	if (config & 32) 
+		printk(" HI"); /* trigger on rising edge */
+	else
+		printk(" LO"); /* trigger on falling edge */
+	if (config & 64) 
+		printk(" DEBOUNCE"); /* debounce */
+	printk("\n");
+}
+
+EXPORT_SYMBOL(scx200_gpio_base);
+EXPORT_SYMBOL(scx200_gpio_shadow);
+EXPORT_SYMBOL(scx200_gpio_lock);
+EXPORT_SYMBOL(scx200_gpio_configure);
+EXPORT_SYMBOL(scx200_gpio_dump);
+
+/*
+    Local variables:
+        compile-command: "make -k -C ../../.. SUBDIRS=arch/i386/kernel"
+        c-basic-offset: 8
+    End:
+*/
diff -urN linux.orig/arch/i386/kernel/scx200_nano.c linux/arch/i386/kernel/scx200_nano.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ linux/arch/i386/kernel/scx200_nano.c	Tue Feb 26 01:16:58 2002
@@ -0,0 +1,192 @@
+/* linux/arch/i386/kernel/scx200_nano.c 
+
+   Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>
+
+   Do any hardware specific setup for the SC2200 based Nano Computer.
+
+   WARNING!  Do NOT run a kernel compiled for the Nano Computer on any
+   other SC2200 platform; doing so could potentially do bad things to
+   your computer, such as fry your TFT screen. */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/scx200.h>
+
+MODULE_AUTHOR("Christer Weinigel <wingel@nano-system.com>");
+MODULE_DESCRIPTION("Nano Computer support");
+MODULE_LICENSE("GPL");
+
+static char name[] = "scx200_nano";
+
+/* Where should the flash be mapped? */
+#define DOC_WINDOW_ADDR (0xc0000000)
+#define DOC_WINDOW_SIZE (16 * 1024 * 1024)
+#define DOC_BUSWIDTH 1
+
+static void __init nano_fixup_irq(void)
+{
+	struct pci_dev *dev;
+	int i;
+	u16 int_map;
+	int intb, intc;
+
+	if (scx200_f0_pdev == NULL) {
+		printk(KERN_ERR "scx200_i2c: Not a SCx200 CPU\n");
+		return;
+	}
+
+	pci_read_config_word(scx200_f0_pdev, 0x5c, &int_map);
+	intb = (int_map >> 4) & 15;
+	intc = (int_map >> 8) & 15;
+
+	for (i = 0; i < 4; i++) {
+		u8 pin;
+		int irq;
+
+		dev = pci_find_slot(0, PCI_DEVFN(0x11, i));
+		if (!dev)
+			break;
+
+		pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+		if (!pin) {
+			continue;
+		}
+		switch (pin) {
+		case 1:
+		case 3:
+			irq = intc;
+			break;
+		case 2:
+		case 4:
+			irq = intb;
+			break;
+		default:
+			irq = dev->irq;
+		}
+
+		if (irq != dev->irq) {
+			printk(KERN_INFO "%s: IRQ fixup for %02x:%02x.%d, was %d, new %d\n", name, 0, 0x11, i, dev->irq, irq);
+			dev->irq = irq;
+			pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
+		}
+	}
+}
+
+int __init scx200_nano_init(void)
+{
+	u32 pmr, mcr;
+	u32 doccs_base, doccs_ctrl;
+
+	printk(KERN_DEBUG "%s\n", __PRETTY_FUNCTION__);
+
+	if (scx200_f0_pdev == NULL) {
+		printk(KERN_ERR "%s: Not a SCx200 CPU\n", name);
+		return -ENODEV;
+	}
+
+	pmr = inl(scx200_config_block + SCx200_PMR);
+	mcr = inl(scx200_config_block + SCx200_MCR);
+
+	printk(KERN_DEBUG "%s: PMR = 0x%08x\n", name, pmr);
+	printk(KERN_DEBUG "%s: MCR = 0x%08x\n", name, mcr);
+
+	pci_read_config_dword(scx200_f0_pdev, 0x78, &doccs_base);
+	pci_read_config_dword(scx200_f0_pdev, 0x7c, &doccs_ctrl);
+
+	printk(KERN_DEBUG "%s: PCI DOCCS Base = 0x%08x\n", name, doccs_base);
+	printk(KERN_DEBUG "%s: PCI DOCCS Ctrl = 0x%08x\n", name, doccs_ctrl);
+	
+	printk(KERN_INFO "%s: GPIO01/#IOCS1,GPIO20/#DOCCS on H2,H3\n", name);
+	pmr &= ~(1<<23);
+
+	printk(KERN_INFO "%s: Configuring GPIOs\n", name);
+	pmr &= ~(1<<13);	/* GPIO01 not #IOCS1 */
+	pmr &= ~((1<<14) | (1<<22)); /* GPIO32-GPIO39 not LPC */
+	pmr &= ~(1<<19);	/* GPIO12-GPIO13 not ACCESS.bus 2 */
+
+	/* Pin header GPIOs */
+	scx200_gpio_configure(36, 0, 0); /* GPIO36 = HGPIO1 */
+	scx200_gpio_configure(35, 0, 0); /* GPIO35 = HGPIO2 */
+	scx200_gpio_configure(1, 0, 0); /* GPIO1 = HGPIO3 */
+	scx200_gpio_configure(17, 0, 0); /* GPIO17 = HGPIO4 */
+
+	/* Unused GPIOs */
+	scx200_gpio_configure(37, 0, 0); /* GPIO37 = HGPIO8 not connected */
+	scx200_gpio_configure(39, 0, 0); /* GPIO39/SERIRQ not connected */
+
+	/* LED GPIOs */
+	scx200_gpio_configure(32, 7, 7);
+	scx200_gpio_configure(33, 7, 7);
+	scx200_gpio_configure(34, 7, 7);
+
+	/* EEPROM U6WP GPIO */
+	scx200_gpio_configure(38, 7, 7);
+
+	printk(KERN_INFO "%s: #DOCCS not GPIO20, ZWS\n", name);
+	pmr |= (1<<7);	/* #DOCCS not GPIO20 */
+	mcr |= (1<<10);	/* Zero Wait States */
+
+	printk(KERN_DEBUG "%s: DOC 0x%x-0x%x, width %d\n",
+	       name, DOC_WINDOW_ADDR, DOC_WINDOW_ADDR+DOC_WINDOW_SIZE, 
+	       DOC_BUSWIDTH);
+	scx200_gpio_configure(20, 7, 7); /* DOCCS GPIOs (not needed?) */
+	doccs_base = DOC_WINDOW_ADDR;
+	doccs_ctrl = ((DOC_WINDOW_SIZE-1) >> 13);
+	doccs_ctrl |= 0x07000000;
+	if (DOC_BUSWIDTH == 1)
+		pmr &= ~(1<<6);
+	else if (DOC_BUSWIDTH == 2)
+		pmr |= (1<<6);
+	else
+		printk(KERN_WARNING "%s: invalid DOC bus with %d\n", 
+		       name, DOC_BUSWIDTH);
+
+	/* INTC */
+	pmr |= 1<<4;		/* #INTC not GPIO19 */
+	pmr &= ~(1<<9);	/* #INTC not IOCHRDY */
+	
+	printk(KERN_DEBUG "%s: PCI DOCCS Base = 0x%08x\n", name, doccs_base);
+	printk(KERN_DEBUG "%s: PCI DOCCS Ctrl = 0x%08x\n", name, doccs_ctrl);
+	
+	pci_write_config_dword(scx200_f0_pdev, 0x78, doccs_base);
+	pci_write_config_dword(scx200_f0_pdev, 0x7c, doccs_ctrl);
+
+	printk(KERN_DEBUG "%s: PMR = 0x%08x\n", name, pmr);
+	printk(KERN_DEBUG "%s: MCR = 0x%08x\n", name, mcr);
+
+	outl(pmr, scx200_config_block + SCx200_PMR);
+	outl(mcr, scx200_config_block + SCx200_MCR);
+
+	printk(KERN_DEBUG "%s: Removing EEPROM write protect\n", name);
+	scx200_gpio_set_low(38);
+
+	/* turn off two top leds */
+	scx200_gpio_set_low(32);
+	scx200_gpio_set_low(33);
+	scx200_gpio_set_high(34);
+
+	nano_fixup_irq();
+
+	return 0;
+}
+
+#ifdef MODULE
+void __exit scx200_nano_cleanup(void)
+{
+	printk(KERN_INFO "%s\n", __PRETTY_FUNCTION__);
+}
+
+module_init(scx200_nano_init);
+module_exit(scx200_nano_cleanup);
+#endif
+
+/*
+    Local variables:
+        compile-command: "make -k -C ../../.. SUBDIRS=arch/i386/kernel"
+        c-basic-offset: 8
+    End:
+*/
diff -urN linux.orig/drivers/char/Config.in linux/drivers/char/Config.in
--- linux.orig/drivers/char/Config.in	Tue Feb 26 01:16:58 2002
+++ linux/drivers/char/Config.in	Tue Feb 26 01:16:58 2002
@@ -168,6 +168,7 @@
    tristate '  IB700 SBC Watchdog Timer' CONFIG_IB700_WDT
    tristate '  Intel i810 TCO timer / Watchdog' CONFIG_I810_TCO
    tristate '  Mixcom Watchdog' CONFIG_MIXCOMWD 
+   dep_tristate '  NatSemi SCx200 Watchdog' CONFIG_SCx200_WATCHDOG $CONFIG_ARCH_SCx200
    tristate '  SBC-60XX Watchdog Timer' CONFIG_60XX_WDT
    tristate '  W83877F (EMACS) Watchdog Timer' CONFIG_W83877F_WDT
    tristate '  ZF MachZ Watchdog' CONFIG_MACHZ_WDT
diff -urN linux.orig/drivers/char/Makefile linux/drivers/char/Makefile
--- linux.orig/drivers/char/Makefile	Tue Feb 26 01:16:58 2002
+++ linux/drivers/char/Makefile	Tue Feb 26 01:16:58 2002
@@ -235,6 +235,7 @@
 obj-$(CONFIG_SH_WDT) += shwdt.o
 obj-$(CONFIG_EUROTECH_WDT) += eurotechwdt.o
 obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
+obj-$(CONFIG_SCx200_WATCHDOG) += scx200_watchdog.o
 
 subdir-$(CONFIG_MWAVE) += mwave
 ifeq ($(CONFIG_MWAVE),y)
diff -urN linux.orig/drivers/char/scx200_watchdog.c linux/drivers/char/scx200_watchdog.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ linux/drivers/char/scx200_watchdog.c	Tue Feb 26 01:16:58 2002
@@ -0,0 +1,263 @@
+/* linux/drivers/char/scx200_watchdog.c 
+
+   National Semiconductor SCx200 Watchdog support
+
+   Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>
+
+   Som code taken from:
+   National Semiconductor PC87307/PC97307 (ala SC1200) WDT driver
+   (c) Copyright 2002 Zwane Mwaikambo <zwane@commfireservices.com>
+
+   This program is free software; you can redistribute it and/or
+   modify it under the terms of the GNU General Public License as
+   published by the Free Software Foundation; either version 2 of the
+   License, or (at your option) any later version.
+
+   The author(s) of this software shall not be held liable for damages
+   of any nature resulting due to the use of this software. This
+   software is provided AS-IS with no warranties. */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <asm/uaccess.h>
+
+#include <linux/scx200.h>
+
+MODULE_AUTHOR("Christer Weinigel <wingel@nano-system.com>");
+MODULE_DESCRIPTION("NatSemi SCx200 Watchdog");
+MODULE_LICENSE("GPL");
+
+#ifndef CONFIG_WATCHDOG_NOWAYOUT
+#define CONFIG_WATCHDOG_NOWAYOUT 0
+#endif
+
+static const char name[] = "scx200_watchdog";
+
+static int margin = 60;		/* in seconds */
+MODULE_PARM(margin, "i");
+MODULE_PARM_DESC(margin, "Watchdog margin in seconds");
+
+static int nowayout = CONFIG_WATCHDOG_NOWAYOUT;
+MODULE_PARM(nowayout, "i");
+MODULE_PARM_DESC(nowayout, "Disable watchdog shutdown on close");
+
+static u16 wdto_restart;
+static struct semaphore open_semaphore;
+static unsigned expect_close;
+
+#define WDTO 0x00		/* Time-Out Register */
+#define WDCNFG 0x02		/* Configuration Register */
+#define    W_ENABLE 0x00fa	/* Enable watchdog */
+#define    W_DISABLE 0x0000	/* Disable watchdog */
+#define WDSTS 0x04		/* Status Register */
+#define    WDOVF (1<<0)		/* Overflow */
+
+#define W_SCALE (32768/1024)	/* This depends on the value of W_ENABLE */
+
+static void scx200_watchdog_ping(void)
+{
+	outw(wdto_restart, scx200_config_block + WDTO);
+}
+
+static void scx200_watchdog_update_margin(void)
+{
+	printk(KERN_INFO "%s: timer margin %d seconds\n", name, margin);
+	wdto_restart = margin * W_SCALE;
+}
+
+static void scx200_watchdog_enable(void)
+{
+	printk(KERN_DEBUG "%s: enabling watchdog timer, wdto_restart = %d\n", 
+	       name, wdto_restart);
+
+	outw(0, scx200_config_block + WDTO);
+	outb(WDOVF, scx200_config_block + WDSTS);
+	outw(W_ENABLE, scx200_config_block + WDCNFG);
+
+	scx200_watchdog_ping();
+}
+
+static void scx200_watchdog_disable(void)
+{
+	printk(KERN_DEBUG "%s: disabling watchdog timer\n", name);
+		
+	outw(0, scx200_config_block + WDTO);
+	outb(WDOVF, scx200_config_block + WDSTS);
+	outw(W_DISABLE, scx200_config_block + WDCNFG);
+}
+
+static int scx200_watchdog_open(struct inode *inode, struct file *file)
+{
+        /* only allow one at a time */
+        if (down_trylock(&open_semaphore))
+                return -EBUSY;
+	scx200_watchdog_enable();
+	expect_close = 0;
+
+	return 0;
+}
+
+static int scx200_watchdog_release(struct inode *inode, struct file *file)
+{
+	if (!expect_close) {
+		printk(KERN_WARNING "%s: watchdog device closed unexpectedly, "
+		       "will not disable the watchdog timer\n", name);
+	} else if (!nowayout) {
+		scx200_watchdog_disable();
+	}
+        up(&open_semaphore);
+
+	return 0;
+}
+
+static int scx200_watchdog_notify_sys(struct notifier_block *this, 
+				      unsigned long code, void *unused)
+{
+        if (code == SYS_HALT || code == SYS_POWER_OFF)
+		if (!nowayout)
+			scx200_watchdog_disable();
+
+        return NOTIFY_DONE;
+}
+
+static struct notifier_block scx200_watchdog_notifier =
+{
+        notifier_call: scx200_watchdog_notify_sys
+};
+
+static ssize_t scx200_watchdog_write(struct file *file, const char *data, 
+				     size_t len, loff_t *ppos)
+{
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+
+	/* check for a magic close character */
+	if (len) 
+	{
+		size_t i;
+
+		scx200_watchdog_ping();
+
+		expect_close = 0;
+		for (i = 0; i < len; ++i) {
+			char c;
+			if (get_user(c, data+i))
+				return -EFAULT;
+			if (c == 'V')
+				expect_close = 1;
+		}
+
+		return len;
+	}
+
+	return 0;
+}
+
+static int scx200_watchdog_ioctl(struct inode *inode, struct file *file,
+	unsigned int cmd, unsigned long arg)
+{
+	static struct watchdog_info ident = {
+		identity : "SCx200 Watchdog",
+		firmware_version : 1, 
+		options : (
+#ifdef WDIOF_SETTIMEOUT
+			WDIOF_SETTIMEOUT | 
+#endif
+			WDIOF_KEEPALIVEPING),
+	};
+	int new_margin;
+	
+	switch (cmd) {
+	default:
+		return -ENOTTY;
+	case WDIOC_GETSUPPORT:
+		if(copy_to_user((struct watchdog_info *)arg, &ident, 
+				sizeof(ident)))
+			return -EFAULT;
+		return 0;
+	case WDIOC_GETSTATUS:
+	case WDIOC_GETBOOTSTATUS:
+		return put_user(0, (int *)arg);
+	case WDIOC_KEEPALIVE:
+		scx200_watchdog_ping();
+		return 0;
+	case WDIOC_SETTIMEOUT:
+		if (get_user(new_margin, (int *)arg))
+			return -EFAULT;
+		if (new_margin < 1)
+			return -EINVAL;
+		margin = new_margin;
+		scx200_watchdog_update_margin();
+		scx200_watchdog_ping();
+#ifdef WDIOC_GETTIMEOUT
+	case WDIOC_GETTIMEOUT:
+#endif
+		return put_user(margin, (int *)arg);
+	}
+}
+
+static struct file_operations scx200_watchdog_fops = {
+	owner: THIS_MODULE,
+	write: scx200_watchdog_write,
+	ioctl: scx200_watchdog_ioctl,
+	open: scx200_watchdog_open,
+	release: scx200_watchdog_release,
+};
+
+static struct miscdevice scx200_watchdog_miscdev = {
+	minor: WATCHDOG_MINOR,
+	name: name,
+	fops: &scx200_watchdog_fops,
+};
+
+static int __init scx200_watchdog_init(void)
+{
+	int r;
+
+	if (scx200_f0_pdev == NULL) {
+		printk(KERN_ERR "%s: Not a SCx200 CPU\n", name);
+		return -ENODEV;
+	}
+
+	scx200_watchdog_update_margin();
+	scx200_watchdog_disable();
+
+	sema_init(&open_semaphore, 1);
+
+	r = misc_register(&scx200_watchdog_miscdev);
+	if (r)
+		return r;
+
+	r = register_reboot_notifier(&scx200_watchdog_notifier);
+        if (r) {
+                printk(KERN_ERR "%s: unable to register reboot notifier", 
+		       name);
+		misc_deregister(&scx200_watchdog_miscdev);
+                return r;
+        }
+
+	return 0;
+}
+
+static void __exit scx200_watchdog_cleanup(void)
+{
+        unregister_reboot_notifier(&scx200_watchdog_notifier);
+	misc_deregister(&scx200_watchdog_miscdev);
+}
+
+module_init(scx200_watchdog_init);
+module_exit(scx200_watchdog_cleanup);
+
+/*
+    Local variables:
+        compile-command: "make -k -C ../.. SUBDIRS=drivers/char modules"
+        c-basic-offset: 8
+    End:
+*/
diff -urN linux.orig/drivers/i2c/Config.in linux/drivers/i2c/Config.in
--- linux.orig/drivers/i2c/Config.in	Tue Feb 26 01:16:57 2002
+++ linux/drivers/i2c/Config.in	Tue Feb 26 01:16:57 2002
@@ -13,6 +13,11 @@
       dep_tristate '  Philips style parallel port adapter' CONFIG_I2C_PHILIPSPAR $CONFIG_I2C_ALGOBIT $CONFIG_PARPORT
       dep_tristate '  ELV adapter' CONFIG_I2C_ELV $CONFIG_I2C_ALGOBIT
       dep_tristate '  Velleman K9000 adapter' CONFIG_I2C_VELLEMAN $CONFIG_I2C_ALGOBIT
+      dep_tristate '  NatSemi SCx200 I2C using GPIO pins' CONFIG_I2C_SCx200 $CONFIG_ARCH_SCx200 $CONFIG_I2C_ALGOBIT
+      if [ "$CONFIG_I2C_SCx200" != "n" ]; then
+         int  '    GPIO pin used for SCL' CONFIG_I2C_SCx200_SCL -1
+         int  '    GPIO pin used for SDA' CONFIG_I2C_SCx200_SDA -1
+      fi
    fi
 
    dep_tristate 'I2C PCF 8584 interfaces' CONFIG_I2C_ALGOPCF $CONFIG_I2C
diff -urN linux.orig/drivers/i2c/Makefile linux/drivers/i2c/Makefile
--- linux.orig/drivers/i2c/Makefile	Tue Feb 26 01:16:57 2002
+++ linux/drivers/i2c/Makefile	Tue Feb 26 01:16:57 2002
@@ -18,6 +18,7 @@
 obj-$(CONFIG_ITE_I2C_ALGO)	+= i2c-algo-ite.o
 obj-$(CONFIG_ITE_I2C_ADAP)	+= i2c-adap-ite.o
 obj-$(CONFIG_I2C_PROC)		+= i2c-proc.o
+obj-$(CONFIG_I2C_SCx200)	+= scx200_i2c.o
 obj-$(CONFIG_I2C_KEYWEST)	+= i2c-keywest.o
 
 # This is needed for automatic patch generation: sensors code starts here
diff -urN linux.orig/drivers/i2c/scx200_i2c.c linux/drivers/i2c/scx200_i2c.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ linux/drivers/i2c/scx200_i2c.c	Tue Feb 26 01:16:58 2002
@@ -0,0 +1,151 @@
+/* linux/drivers/i2c/scx200_i2c.c 
+
+   Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>
+
+   National Semiconductor SCx200 I2C bus on GPIO pins
+
+   Based on i2c-velleman.c Copyright (C) 1995-96, 2000 Simon G. Vogl
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 2 of the License, or
+   (at your option) any later version.
+   
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+   
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software
+   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     
+*/
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+
+#include <linux/scx200.h>
+
+MODULE_AUTHOR("Christer Weinigel <wingel@nano-system.com>");
+MODULE_DESCRIPTION("NatSemi SCx200 I2C");
+MODULE_LICENSE("GPL");
+
+MODULE_PARM(scl, "i");
+MODULE_PARM_DESC(scl, "GPIO line for SCL");
+MODULE_PARM(sda, "i");
+MODULE_PARM_DESC(sda, "GPIO line for SDA");
+
+static int scl = CONFIG_I2C_SCx200_SCL;
+static int sda = CONFIG_I2C_SCx200_SDA;
+
+static const char name[] = "scx200_i2c";
+
+static void scx200_i2c_setscl(void *data, int state)
+{
+	scx200_gpio_set(scl, state);
+}
+
+static void scx200_i2c_setsda(void *data, int state)
+{
+	scx200_gpio_set(sda, state);
+} 
+
+static int scx200_i2c_getscl(void *data)
+{
+	return scx200_gpio_get(scl);
+}
+
+static int scx200_i2c_getsda(void *data)
+{
+	return scx200_gpio_get(sda);
+}
+
+static int scx200_i2c_reg(struct i2c_client *client)
+{
+	return 0;
+}
+
+static int scx200_i2c_unreg(struct i2c_client *client)
+{
+	return 0;
+}
+
+static void scx200_i2c_inc_use(struct i2c_adapter *adap)
+{
+	MOD_INC_USE_COUNT;
+}
+
+static void scx200_i2c_dec_use(struct i2c_adapter *adap)
+{
+	MOD_DEC_USE_COUNT;
+}
+
+/* ------------------------------------------------------------------------
+ * Encapsulate the above functions in the correct operations structure.
+ * This is only done when more than one hardware adapter is supported.
+ */
+
+static struct i2c_algo_bit_data scx200_i2c_data = {
+	NULL,
+	scx200_i2c_setsda,
+	scx200_i2c_setscl,
+	scx200_i2c_getsda,
+	scx200_i2c_getscl,
+	10, 10, 100,		/* waits, timeout */
+};
+
+static struct i2c_adapter scx200_i2c_ops = {
+	"SCx200",
+	I2C_HW_B_VELLE,
+	NULL,
+	&scx200_i2c_data,
+	scx200_i2c_inc_use,
+	scx200_i2c_dec_use,
+	scx200_i2c_reg,
+	scx200_i2c_unreg,
+};
+
+int scx200_i2c_init(void)
+{
+	if (scx200_f0_pdev == NULL) {
+		printk(KERN_ERR "%s: Not a SCx200 CPU\n", name);
+		return -ENODEV;
+	}
+
+	printk(KERN_INFO "%s: SCL=GPIO%02u, SDA=GPIO%02u\n", 
+	       name, scl, sda);
+
+	if (scl == -1 || sda == -1 || scl == sda) {
+		printk(KERN_ERR "%s: scl and sda must be specified\n", name);
+		return -EINVAL;
+	}
+
+	/* Configure GPIOs as open collector outputs */
+	scx200_gpio_configure(scl, ~2, 5);
+	scx200_gpio_configure(sda, ~2, 5);
+
+	if (i2c_bit_add_bus(&scx200_i2c_ops) < 0)
+		return -ENODEV;
+
+	return 0;
+}
+
+void scx200_i2c_cleanup(void)
+{
+	i2c_bit_del_bus(&scx200_i2c_ops);
+}
+
+module_init(scx200_i2c_init);
+module_exit(scx200_i2c_cleanup);
+
+/*
+    Local variables:
+        compile-command: "make -k -C ../.. SUBDIRS=drivers/i2c modules"
+        c-basic-offset: 8
+    End:
+*/
--- linux.orig/drivers/mtd/maps/Config.in	Tue Feb 26 01:16:57 2002
+++ linux/drivers/mtd/maps/Config.in	Tue Feb 26 01:16:57 2002
@@ -27,6 +27,7 @@
    dep_tristate '  JEDEC Flash device mapped on Octagon 5066 SBC' CONFIG_MTD_OCTAGON $CONFIG_MTD_JEDEC
    dep_tristate '  JEDEC Flash device mapped on Tempustech VMAX SBC301' CONFIG_MTD_VMAX $CONFIG_MTD_JEDEC
    dep_tristate '  BIOS flash chip on Intel L440GX boards' CONFIG_MTD_L440GX $CONFIG_I386 $CONFIG_MTD_JEDEC
+   dep_tristate '  Flash device mapped with DOCCS on NatSemi SCx200' CONFIG_MTD_SCx200_DOCFLASH $CONFIG_ARCH_SCx200 $CONFIG_MTD_CFI $CONFIG_MTD_PARTITIONS
 fi
 
 if [ "$CONFIG_PPC" = "y" ]; then
diff -urN linux.orig/drivers/mtd/maps/Makefile linux/drivers/mtd/maps/Makefile
--- linux.orig/drivers/mtd/maps/Makefile	Tue Feb 26 01:16:57 2002
+++ linux/drivers/mtd/maps/Makefile	Tue Feb 26 01:16:57 2002
@@ -29,5 +29,6 @@
 obj-$(CONFIG_MTD_DBOX2)		+= dbox2-flash.o
 obj-$(CONFIG_MTD_OCELOT)	+= ocelot.o
 obj-$(CONFIG_MTD_SOLUTIONENGINE)+= solutionengine.o
+obj-$(CONFIG_MTD_SCx200_DOCFLASH)+= scx200_docflash.o
 
 include $(TOPDIR)/Rules.make
diff -urN linux.orig/drivers/mtd/maps/scx200_docflash.c linux/drivers/mtd/maps/scx200_docflash.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ linux/drivers/mtd/maps/scx200_docflash.c	Tue Feb 26 01:16:58 2002
@@ -0,0 +1,177 @@
+/* linux/drivers/mtd/maps/scx200_docflash.c 
+
+   Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>
+
+   National Semiconductor SCx200 flash mapped with DOCCS
+*/
+
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <asm/io.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/map.h>
+#include <linux/mtd/partitions.h>
+
+#include <linux/pci.h>
+#include <linux/scx200.h>
+
+MODULE_AUTHOR("Christer Weinigel <wingel@hack.org>");
+MODULE_DESCRIPTION("NatSemi SCx200 DOCCS Flash");
+MODULE_LICENSE("GPL");
+
+static int partition = 1;
+
+static const char name[] = "scx200_docflash";
+
+static struct mtd_info *mymtd;
+
+/* partition_info gives details on the logical partitions that the split the 
+ * single flash device into. If the size if zero we use up to the end of the
+ * device. */
+static struct mtd_partition partition_info[] = {
+	{ 
+		name: "scx200 Boot kernel", 
+		offset: 0, 
+		size: 	0xc0000
+	},
+	{ 
+		name: "scx200 Low BIOS", 
+		offset: 0xc0000, 
+		size: 	0x40000
+	},
+	{ 
+		name: "scx200 File system", 
+		offset: 0x100000, 
+		size: 	~0	/* calculate from flash size */
+	},
+	{ 
+		name: "scx200 High BIOS", 
+		offset: ~0, 	/* calculate from flash size */
+		size: 0x80000
+	},
+};
+#define NUM_PARTITIONS (sizeof(partition_info)/sizeof(partition_info[0]))
+
+static __u8 scx200_docflash_read8(struct map_info *map, unsigned long ofs)
+{
+	return __raw_readb(map->map_priv_1 + ofs);
+}
+
+static __u16 scx200_docflash_read16(struct map_info *map, unsigned long ofs)
+{
+	return __raw_readw(map->map_priv_1 + ofs);
+}
+
+static void scx200_docflash_copy_from(struct map_info *map, void *to, unsigned long from, ssize_t len)
+{
+	memcpy_fromio(to, map->map_priv_1 + from, len);
+}
+
+static void scx200_docflash_write8(struct map_info *map, __u8 d, unsigned long adr)
+{
+	__raw_writeb(d, map->map_priv_1 + adr);
+	mb();
+}
+
+static void scx200_docflash_write16(struct map_info *map, __u16 d, unsigned long adr)
+{
+	__raw_writew(d, map->map_priv_1 + adr);
+	mb();
+}
+
+static void scx200_docflash_copy_to(struct map_info *map, unsigned long to, const void *from, ssize_t len)
+{
+	memcpy_toio(map->map_priv_1 + to, from, len);
+}
+
+static struct map_info scx200_docflash_map = {
+	name: "scx200 DOCCS flash",
+	read8: scx200_docflash_read8,
+	read16: scx200_docflash_read16,
+	copy_from: scx200_docflash_copy_from,
+	write8: scx200_docflash_write8,
+	write16: scx200_docflash_write16,
+	copy_to: scx200_docflash_copy_to
+};
+
+int __init init_scx200_docflash(void)
+{
+	unsigned doccs_base;
+	unsigned doccs_ctrl;
+	unsigned pmr;
+
+	if (scx200_f0_pdev == NULL) {
+		printk(KERN_ERR "%s: Not a SCx200 CPU\n", name);
+		return -ENODEV;
+	}
+
+	/* read the current configuration for the DOCCS from the
+           SCx200 and use this to set up our flash mapping.  It might
+           be a better idea to ask the Linux kernel for a memory
+           region where the flash can be mapped instead of relying on
+           the BIOS to do it correctly */
+	pci_read_config_dword(scx200_f0_pdev, 0x78, &doccs_base);
+	pci_read_config_dword(scx200_f0_pdev, 0x7c, &doccs_ctrl);
+	pmr = inl(scx200_config_block + SCx200_PMR);
+
+	scx200_docflash_map.size = ((doccs_ctrl & 0x1fff) << 13) + (1<<13);
+
+	if (pmr & (1<<6))	/* is the flash 16 or 8 bits wide */
+		scx200_docflash_map.buswidth = 2;
+	else
+		scx200_docflash_map.buswidth = 1;
+
+       	printk(KERN_INFO "%s: DOCCS mapped at 0x%x, size 0x%lx, width %d\n", 
+	       name, doccs_base, 
+	       scx200_docflash_map.size, scx200_docflash_map.buswidth);
+
+	scx200_docflash_map.map_priv_1 = (unsigned long)ioremap(doccs_base, scx200_docflash_map.size);
+	if (!scx200_docflash_map.map_priv_1) {
+		printk(KERN_ERR "%s: failed to ioremap the flash\n", name);
+		return -EIO;
+	}
+
+	mymtd = do_map_probe("cfi_probe", &scx200_docflash_map);
+	if (!mymtd) {
+		printk(KERN_ERR "%s: unable to detect flash\n", name);
+		iounmap((void *)scx200_docflash_map.map_priv_1);
+		return -ENXIO;
+	}
+
+	mymtd->module = THIS_MODULE;
+
+	if (partition) {
+		partition_info[3].offset = mymtd->size-partition_info[3].size;
+		partition_info[2].size = partition_info[3].offset-partition_info[2].offset;
+		add_mtd_partitions(mymtd, partition_info, NUM_PARTITIONS);
+	} else {
+		add_mtd_device(mymtd);
+	}
+	return 0;
+}
+
+static void __exit cleanup_scx200_docflash(void)
+{
+	if (mymtd) {
+		if (partition)
+			del_mtd_partitions(mymtd);
+		del_mtd_device(mymtd);
+		map_destroy(mymtd);
+	}
+	if (scx200_docflash_map.map_priv_1) {
+		iounmap((void *)scx200_docflash_map.map_priv_1);
+		scx200_docflash_map.map_priv_1 = 0;
+	}
+}
+
+module_init(init_scx200_docflash);
+module_exit(cleanup_scx200_docflash);
+
+/*
+    Local variables:
+        compile-command: "make -k -C ../../.. SUBDIRS=drivers/mtd/maps modules"
+        c-basic-offset: 8
+    End:
+*/
diff -urN linux.orig/include/linux/pci_ids.h linux/include/linux/pci_ids.h
--- linux.orig/include/linux/pci_ids.h	Tue Feb 26 01:16:58 2002
+++ linux/include/linux/pci_ids.h	Tue Feb 26 01:16:58 2002
@@ -287,6 +287,12 @@
 #define PCI_DEVICE_ID_NS_87560_USB	0x0012
 #define PCI_DEVICE_ID_NS_83815		0x0020
 #define PCI_DEVICE_ID_NS_83820		0x0022
+#define PCI_DEVICE_ID_NS_SCx200_BRIDGE	0x0500
+#define PCI_DEVICE_ID_NS_SCx200_SMI	0x0501
+#define PCI_DEVICE_ID_NS_SCx200_IDE	0x0502
+#define PCI_DEVICE_ID_NS_SCx200_AUDIO	0x0503
+#define PCI_DEVICE_ID_NS_SCx200_VIDEO	0x0504
+#define PCI_DEVICE_ID_NS_SCx200_XBUS	0x0505
 #define PCI_DEVICE_ID_NS_87410		0xd001
 
 #define PCI_VENDOR_ID_TSENG		0x100c
diff -urN linux.orig/include/linux/scx200.h linux/include/linux/scx200.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ linux/include/linux/scx200.h	Tue Feb 26 01:16:58 2002
@@ -0,0 +1,110 @@
+#include <linux/pci.h>
+#include <linux/spinlock.h>
+
+/* Configuation block */
+#define SCx200_PMR	0x30
+#define SCx200_MCR	0x34	/* Miscellaneous Configuration Register */
+
+/* scx200_main.c */
+
+extern struct pci_dev *scx200_f0_pdev;
+extern struct pci_dev *scx200_f5_pdev;
+extern unsigned scx200_config_block;
+
+/* GPIO */
+
+u32 scx200_gpio_configure(int index, u32 set, u32 clear);
+void scx200_gpio_dump(unsigned index);
+
+extern unsigned scx200_gpio_base;
+extern spinlock_t scx200_gpio_lock;
+extern u32 scx200_gpio_shadow[2];
+extern u32 *dummy;
+
+/* Definitions to make sure I do the same thing in all functions */
+#define __SCx200_GPIO_BANK unsigned bank = index>>5
+#define __SCx200_GPIO_IOADDR unsigned short ioaddr = scx200_gpio_base+0x10*bank
+#define __SCx200_GPIO_SHADOW u32 *shadow = scx200_gpio_shadow+bank
+#define __SCx200_GPIO_INDEX index &= 31
+
+#define __SCx200_GPIO_OUT __asm__ __volatile__("outsl":"=mS" (shadow):"d" (ioaddr), "0" (shadow))
+
+/* returns the value of the GPIO pin */
+
+static inline int scx200_gpio_get(int index) {
+	__SCx200_GPIO_BANK;
+	__SCx200_GPIO_IOADDR + 0x04;
+	__SCx200_GPIO_INDEX;
+		
+	return (inl(ioaddr) & (1<<index)) ? 1 : 0;
+}
+
+/* return the value driven on the GPIO signal (the value that will be
+   driven if the GPIO is configured as an output, it might not be the
+   state of the GPIO right now if the GPIO is configured as an input) */
+
+static inline int scx200_gpio_current(int index) {
+        __SCx200_GPIO_BANK;
+	__SCx200_GPIO_INDEX;
+		
+	return (scx200_gpio_shadow[bank] & (1<<index)) ? 1 : 0;
+}
+
+/* drive the GPIO signal high */
+
+static inline void scx200_gpio_set_high(int index) {
+	__SCx200_GPIO_BANK;
+	__SCx200_GPIO_IOADDR;
+	__SCx200_GPIO_SHADOW;
+	__SCx200_GPIO_INDEX;
+	set_bit(index, shadow);
+	__SCx200_GPIO_OUT;
+}
+
+/* drive the GPIO signal low */
+
+static inline void scx200_gpio_set_low(int index) {
+	__SCx200_GPIO_BANK;
+	__SCx200_GPIO_IOADDR;
+	__SCx200_GPIO_SHADOW;
+	__SCx200_GPIO_INDEX;
+	clear_bit(index, shadow);
+	__SCx200_GPIO_OUT;
+}
+
+/* drive the GPIO signal to state */
+
+static inline void scx200_gpio_set(int index, int state) {
+	__SCx200_GPIO_BANK;
+	__SCx200_GPIO_IOADDR;
+	__SCx200_GPIO_SHADOW;
+	__SCx200_GPIO_INDEX;
+	if (state)
+		set_bit(index, shadow);
+	else
+		clear_bit(index, shadow);
+	__SCx200_GPIO_OUT;
+}
+
+/* toggle the GPIO signal */
+static inline void scx200_gpio_change(int index) {
+	__SCx200_GPIO_BANK;
+	__SCx200_GPIO_IOADDR;
+	__SCx200_GPIO_SHADOW;
+	__SCx200_GPIO_INDEX;
+	change_bit(index, shadow);
+	__SCx200_GPIO_OUT;
+}
+
+#undef __SCx200_GPIO_BANK
+#undef __SCx200_GPIO_IOADDR
+#undef __SCx200_GPIO_SHADOW
+#undef __SCx200_GPIO_INDEX
+#undef __SCx200_GPIO_OUT
+
+/*
+    Local variables:
+        compile-command: "cd ../../.. && ./build.sh fast "
+        c-basic-offset: 8
+    End:
+*/
diff -urN linux.orig/init/main.c linux/init/main.c
--- linux.orig/init/main.c	Tue Feb 26 01:16:57 2002
+++ linux/init/main.c	Tue Feb 26 01:16:57 2002
@@ -94,6 +94,7 @@
 extern void sysctl_init(void);
 extern void signals_init(void);
 extern int init_pcmcia_ds(void);
+extern int scx200_init(void);
 
 extern void free_initmem(void);
 
@@ -729,6 +730,9 @@
 #endif
 #ifdef CONFIG_TC
 	tc_init();
+#endif
+#ifdef CONFIG_ARCH_SCx200
+	scx200_init();
 #endif
 
 	/* Networking initialization needs a process context */ 



-- 
"Just how much can I get away with and still go to heaven?"
