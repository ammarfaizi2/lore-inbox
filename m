Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315202AbSF3N5t>; Sun, 30 Jun 2002 09:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315204AbSF3N5s>; Sun, 30 Jun 2002 09:57:48 -0400
Received: from [193.14.93.89] ([193.14.93.89]:32516 "HELO acolyte.hack.org")
	by vger.kernel.org with SMTP id <S315202AbSF3N5X>;
	Sun, 30 Jun 2002 09:57:23 -0400
From: Christer Weinigel <wingel@nano-system.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: SCx200 patches part 3/3 -- I2C drivers
Message-Id: <20020630135937.2C9B7F5B@acolyte.hack.org>
Date: Sun, 30 Jun 2002 15:59:37 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the thirdSCx200 patch.  It adds support for an I2C bus on the
SCx200 processors.  Actually the patch is threee parts:

1. A driver for the ACCESS.bus of the SCx200 CPU, this is basically an
   I2C bus with some hardware state machines. 

2. A driver for using two GPIO pins of the processor as an I2C bus.  

3. A driver for the GPIO pins so that the I2C bus driver has something
   to talk to.  I have added the I2C driver to the arch/i386/kernel
   directory since it is very processor specific, and I've also added
   some static initializers to init/main.c so that the GPIO
   initialization is run before any drivers.  Does this look ok?

I also have some more patches for my specific SCx200 board, and also
some IDE patches that probably should end up in the main kernel, but I
will sit on those for a while since they are not as well tested yet.
If anyone is inerested, please mail me.

  /Christer

diff -urw ./linux/arch/i386/config.in.orig ./linux/arch/i386/config.in
--- ./linux/arch/i386/config.in.orig	Sun Jun 30 15:15:24 2002
+++ ./linux/arch/i386/config.in	Sun Jun 30 15:16:23 2002
@@ -238,6 +238,11 @@
    fi
 fi
 
+tristate 'NatSemi SCx200 GPIO support' CONFIG_SCx200_GPIO
+if [ "$CONFIG_SCx200_GPIO" = "y" ]; then
+	define_bool CONFIG_SCx200 y
+fi
+
 source drivers/pci/Config.in
 
 bool 'EISA support' CONFIG_EISA
diff -urw ./linux/arch/i386/kernel/Makefile.orig ./linux/arch/i386/kernel/Makefile
--- ./linux/arch/i386/kernel/Makefile.orig	Sun Jun 30 15:15:24 2002
+++ ./linux/arch/i386/kernel/Makefile	Sun Jun 30 15:16:33 2002
@@ -41,4 +41,8 @@
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o acpitable.o
 obj-$(CONFIG_X86_VISWS_APIC)	+= visws_apic.o
 
+obj-$(CONFIG_SCx200)		+= scx200.o
+export-objs += scx200_gpio.o
+obj-$(CONFIG_SCx200_GPIO)	+= scx200_gpio.o
+
 include $(TOPDIR)/Rules.make
diff -urw ./linux/arch/i386/kernel/scx200.c.orig ./linux/arch/i386/kernel/scx200.c
--- ./linux/arch/i386/kernel/scx200.c.orig	Sun Jun 30 15:15:29 2002
+++ ./linux/arch/i386/kernel/scx200.c	Sun Jun 30 15:17:24 2002
@@ -0,0 +1,31 @@
+/* linux/arch/i386/kernel/scx200.c 
+
+   Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>
+
+   Make sure that the SCx200 specific initializations are run before
+   any drivers are initialized.  This is also a good place to add any
+   board specific initializers. */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+
+extern int scx200_gpio_init(void);
+extern int scx200_nano_init(void);
+
+int __init scx200_init(void)
+{
+#ifdef CONFIG_SCx200_GPIO
+	scx200_gpio_init();
+#endif
+}
+
+/*
+    Local variables:
+        compile-command: "make -k -C ../../.. SUBDIRS=arch/i386/kernel bzImage"
+        c-basic-offset: 8
+    End:
+*/
diff -urw ./linux/arch/i386/kernel/scx200_gpio.c.orig ./linux/arch/i386/kernel/scx200_gpio.c
--- ./linux/arch/i386/kernel/scx200_gpio.c.orig	Sun Jun 30 15:15:29 2002
+++ ./linux/arch/i386/kernel/scx200_gpio.c	Sun Jun 30 15:18:30 2002
@@ -0,0 +1,130 @@
+/* linux/arch/i386/kernel/scx200_gpio.c 
+
+   Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>
+
+   National Semiconductor SCx200 GPIO support. */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+
+#include <linux/scx200.h>
+#include <linux/scx200_gpio.h>
+
+#define NAME "scx200_gpio"
+
+MODULE_AUTHOR("Christer Weinigel <wingel@nano-system.com>");
+MODULE_DESCRIPTION("NatSemi SCx200 GPIO Driver");
+MODULE_LICENSE("GPL");
+
+unsigned scx200_gpio_base = 0;
+u32 scx200_gpio_shadow[2];
+
+spinlock_t scx200_gpio_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t scx200_gpio_config_lock = SPIN_LOCK_UNLOCKED;
+
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
+int __init scx200_gpio_init(void)
+{
+	struct pci_dev *bridge;
+	int bank;
+	unsigned base;
+
+	printk(KERN_DEBUG NAME ": NatSemi SCx200 GPIO Driver\n");
+
+	if ((bridge = pci_find_device(PCI_VENDOR_ID_NS, 
+				      PCI_DEVICE_ID_NS_SCx200_BRIDGE,
+				      NULL)) == NULL)
+		return -ENODEV;
+
+	base = pci_resource_start(bridge, 0);
+	printk(KERN_INFO NAME ": GPIO base 0x%x\n", base);
+
+	if (request_region(base, SCx200_GPIO_SIZE, "NatSemi SCx200 GPIO") == 0) {
+		printk(KERN_ERR NAME ": can't allocate I/O for GPIOs\n");
+		return -EBUSY;
+	}
+
+	scx200_gpio_base = base;
+
+	/* read the current values driven on the GPIO signals */
+	for (bank = 0; bank < 2; ++bank)
+		scx200_gpio_shadow[bank] = inl(scx200_gpio_base + 0x10 * bank);
+
+	return 0;
+}
+
+#ifdef MODULE
+void __exit scx200_gpio_cleanup(void)
+{
+	release_region(scx200_gpio_base, SCx200_GPIO_SIZE);
+}
+
+module_init(scx200_gpio_init);
+module_exit(scx200_gpio_cleanup);
+#endif MODULE
+
+EXPORT_SYMBOL(scx200_gpio_base);
+EXPORT_SYMBOL(scx200_gpio_shadow);
+EXPORT_SYMBOL(scx200_gpio_lock);
+EXPORT_SYMBOL(scx200_gpio_configure);
+EXPORT_SYMBOL(scx200_gpio_dump);
+
+/*
+    Local variables:
+        compile-command: "make -k -C ../../.. SUBDIRS=arch/i386/kernel modules"
+        c-basic-offset: 8
+    End:
+*/
diff -urw ./linux/drivers/i2c/Config.in.orig ./linux/drivers/i2c/Config.in
--- ./linux/drivers/i2c/Config.in.orig	Mon Feb 25 20:37:57 2002
+++ ./linux/drivers/i2c/Config.in	Sun Jun 30 15:19:07 2002
@@ -13,6 +13,12 @@
       dep_tristate '  Philips style parallel port adapter' CONFIG_I2C_PHILIPSPAR $CONFIG_I2C_ALGOBIT $CONFIG_PARPORT
       dep_tristate '  ELV adapter' CONFIG_I2C_ELV $CONFIG_I2C_ALGOBIT
       dep_tristate '  Velleman K9000 adapter' CONFIG_I2C_VELLEMAN $CONFIG_I2C_ALGOBIT
+      dep_tristate '  NatSemi SCx200 I2C using GPIO pins' CONFIG_SCx200_I2C $CONFIG_SCx200_GPIO $CONFIG_I2C_ALGOBIT
+      if [ "$CONFIG_SCx200_I2C" != "n" ]; then
+         int  '    GPIO pin used for SCL' CONFIG_SCx200_I2C_SCL 12
+         int  '    GPIO pin used for SDA' CONFIG_SCx200_I2C_SDA 13
+      fi
+      dep_tristate '  NatSemi SCx200 ACCESS.bus' CONFIG_SCx200_ACB $CONFIG_I2C
    fi
 
    dep_tristate 'I2C PCF 8584 interfaces' CONFIG_I2C_ALGOPCF $CONFIG_I2C
diff -urw ./linux/drivers/i2c/Makefile.orig ./linux/drivers/i2c/Makefile
--- ./linux/drivers/i2c/Makefile.orig	Mon Feb 25 20:37:57 2002
+++ ./linux/drivers/i2c/Makefile	Sun Jun 30 15:19:07 2002
@@ -18,6 +18,8 @@
 obj-$(CONFIG_ITE_I2C_ALGO)	+= i2c-algo-ite.o
 obj-$(CONFIG_ITE_I2C_ADAP)	+= i2c-adap-ite.o
 obj-$(CONFIG_I2C_PROC)		+= i2c-proc.o
+obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
+obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
 obj-$(CONFIG_I2C_KEYWEST)	+= i2c-keywest.o
 
 # This is needed for automatic patch generation: sensors code starts here
diff -urw ./linux/drivers/i2c/scx200_acb.c.orig ./linux/drivers/i2c/scx200_acb.c
--- ./linux/drivers/i2c/scx200_acb.c.orig	Sun Jun 30 15:19:07 2002
+++ ./linux/drivers/i2c/scx200_acb.c	Sun Jun 30 15:19:07 2002
@@ -0,0 +1,581 @@
+/*  linux/drivers/i2c/scx200_acb.c 
+
+    Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>
+
+    National Semiconductor SCx200 ACCESS.bus support
+    
+    Based on i2c-keywest.c which is:
+        Copyright (c) 2001 Benjamin Herrenschmidt <benh@kernel.crashing.org>
+        Copyright (c) 2000 Philip Edelbrock <phil@stimpy.netroedge.com>
+    
+    This program is free software; you can redistribute it and/or
+    modify it under the terms of the GNU General Public License as
+    published by the Free Software Foundation; either version 2 of the
+    License, or (at your option) any later version.
+   
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+    General Public License for more details.
+   
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+
+*/
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/smp_lock.h>
+#include <linux/pci.h>
+#include <asm/io.h>
+
+#include <linux/scx200.h>
+
+#define NAME "scx200_acb"
+
+MODULE_AUTHOR("Christer Weinigel <wingel@nano-system.com>");
+MODULE_DESCRIPTION("NatSemi SCx200 ACCESS.bus Driver");
+MODULE_LICENSE("GPL");
+
+#define MAX_DEVICES 4
+static int base[MAX_DEVICES] = { 0x840 };
+MODULE_PARM(base, "1-4i");
+MODULE_PARM_DESC(base, "Base addresses for the ACCESS.bus controllers");
+
+#define DEBUG 0
+
+#if DEBUG
+#define DBG(x...) printk(KERN_DEBUG NAME ": " x)
+#else
+#define DBG(x...)
+#endif
+
+/* The hardware supports interrupt driven mode too, but I haven't
+   implemented that. */
+#define POLLED_MODE 1
+#define POLL_TIMEOUT (HZ)
+
+enum scx200_acb_state {
+	state_idle,
+	state_address,
+	state_command,
+	state_repeat_start,
+	state_quick,
+	state_read,
+	state_write,
+};
+
+static const char *scx200_acb_state_name[] = {
+	"idle",
+	"address",
+	"command",
+	"repeat_start",
+	"quick",
+	"read",
+	"write",
+};
+
+/* Physical interface */
+struct scx200_acb_iface
+{
+	struct scx200_acb_iface *next;
+	struct i2c_adapter adapter;
+	unsigned base;
+	struct semaphore sem;
+
+	/* State machine data */
+	enum scx200_acb_state state;
+	int result;
+	u8 address_byte;
+	u8 command;
+	u8 *ptr;
+	char needs_reset;
+	unsigned len;
+};
+
+/* Register Definitions */
+#define ACBSDA		(iface->base + 0)
+#define ACBST		(iface->base + 1)
+#define    ACBST_SDAST		0x40 /* SDA Status */
+#define    ACBST_BER		0x20 
+#define    ACBST_NEGACK		0x10 /* Negative Acknowledge */
+#define    ACBST_STASTR		0x08 /* Stall After Start */
+#define    ACBST_MASTER		0x02
+#define ACBCST		(iface->base + 2)
+#define    ACBCST_BB		0x02
+#define ACBCTL1		(iface->base + 3)
+#define    ACBCTL1_STASTRE	0x80
+#define    ACBCTL1_NMINTE	0x40
+#define	   ACBCTL1_ACK		0x10
+#define	   ACBCTL1_STOP		0x02
+#define	   ACBCTL1_START	0x01
+#define ACBADDR		(iface->base + 4)
+#define ACBCTL2		(iface->base + 5)
+#define    ACBCTL2_ENABLE	0x01
+
+/************************************************************************/
+
+static void scx200_acb_machine(struct scx200_acb_iface *iface, u8 status)
+{
+	const char *errmsg;
+
+	DBG("state %s, status = 0x%02x\n", 
+	    scx200_acb_state_name[iface->state], status);
+
+	if (status & ACBST_BER) {
+		errmsg = "bus error";
+		goto error;
+	}
+	if (!(status & ACBST_MASTER)) {
+		errmsg = "not master";
+		goto error;
+	}
+	if (status & ACBST_NEGACK)
+		goto negack;
+
+	switch (iface->state) {
+	case state_idle:
+		printk(KERN_WARNING NAME ": %s, interrupt in idle state\n", 
+		       iface->adapter.name);
+		break;
+
+	case state_address:
+		/* Do a pointer write first */
+		outb(iface->address_byte & ~1, ACBSDA);
+
+		iface->state = state_command;
+		break;
+
+	case state_command:
+		outb(iface->command, ACBSDA);
+
+		if (iface->address_byte & 1)
+			iface->state = state_repeat_start;
+		else
+			iface->state = state_write;
+		break;
+
+	case state_repeat_start:
+		outb(inb(ACBCTL1) | ACBCTL1_START, ACBCTL1);
+		/* fallthrough */
+		
+	case state_quick:
+		if (iface->address_byte & 1) {
+			if (iface->len == 1) 
+				outb(inb(ACBCTL1) | ACBCTL1_ACK, ACBCTL1);
+			else
+				outb(inb(ACBCTL1) & ~ACBCTL1_ACK, ACBCTL1);
+			outb(iface->address_byte, ACBSDA);
+
+			iface->state = state_read;
+		} else {
+			outb(iface->address_byte, ACBSDA);
+
+			iface->state = state_write;
+		}
+		break;
+
+	case state_read:
+		/* Set ACK if receiving the last byte */
+		if (iface->len == 1)
+			outb(inb(ACBCTL1) | ACBCTL1_ACK, ACBCTL1);
+		else
+			outb(inb(ACBCTL1) & ~ACBCTL1_ACK, ACBCTL1);
+
+		*iface->ptr++ = inb(ACBSDA);
+		--iface->len;
+
+		if (iface->len == 0) {
+			iface->result = 0;
+			iface->state = state_idle;
+			outb(inb(ACBCTL1) | ACBCTL1_STOP, ACBCTL1);
+		}
+
+		break;
+
+	case state_write:
+		if (iface->len == 0) {
+			iface->result = 0;
+			iface->state = state_idle;
+			outb(inb(ACBCTL1) | ACBCTL1_STOP, ACBCTL1);
+			break;
+		}
+		
+		outb(*iface->ptr++, ACBSDA);
+		--iface->len;
+		
+		break;
+	}
+
+	return;
+
+ negack:
+	DBG("%s: negative acknowledge in state %s\n", 
+	    name, scx200_acb_state_name[iface->state]);
+
+	iface->state = state_idle;
+	iface->result = -ENXIO;
+
+	outb(inb(ACBCTL1) | ACBCTL1_STOP, ACBCTL1);
+	outb(ACBST_STASTR | ACBST_NEGACK, ACBST);
+	return;
+
+ error:
+	printk(KERN_ERR NAME ": %s, %s in state %s\n", iface->adapter.name, 
+	       errmsg, scx200_acb_state_name[iface->state]);
+
+	iface->state = state_idle;
+	iface->result = -EIO;
+	iface->needs_reset = 1;
+}
+
+static void scx200_acb_timeout(struct scx200_acb_iface *iface) 
+{
+	printk(KERN_ERR NAME ": %s, timeout in state %s\n", 
+	       iface->adapter.name, scx200_acb_state_name[iface->state]);
+
+	iface->state = state_idle;
+	iface->result = -EIO;
+	iface->needs_reset = 1;
+}
+
+#ifdef POLLED_MODE
+static void scx200_acb_poll(struct scx200_acb_iface *iface)
+{
+	u8 status = 0;
+	unsigned long timeout;
+
+	timeout = jiffies + POLL_TIMEOUT;
+	while (time_before(jiffies, timeout)) {
+		status = inb(ACBST);
+		if ((status & (ACBST_SDAST|ACBST_BER|ACBST_NEGACK)) != 0) {
+			scx200_acb_machine(iface, status);
+			return;
+		}
+		current->policy |= SCHED_YIELD;
+		schedule();
+	}
+
+	scx200_acb_timeout(iface);
+}
+#endif /* POLLED_MODE */
+
+static void scx200_acb_reset(struct scx200_acb_iface *iface)
+{
+	/* Disable the ACCESS.bus device and Configure the SCL
+           frequency: 16 clock cycles */
+	outb(0x70, ACBCTL2);
+	/* Polling mode */
+	outb(0, ACBCTL1);
+	/* Disable slave address */
+	outb(0, ACBADDR);
+	/* Enable the ACCESS.bus device */
+	outb(inb(ACBCTL2) | ACBCTL2_ENABLE, ACBCTL2);
+	/* Free STALL after START */
+	outb(inb(ACBCTL1) & ~(ACBCTL1_STASTRE | ACBCTL1_NMINTE), ACBCTL1);
+	/* Send a STOP */
+	outb(inb(ACBCTL1) | ACBCTL1_STOP, ACBCTL1);
+	/* Clear BER, NEGACK and STASTR bits */
+	outb(ACBST_BER | ACBST_NEGACK | ACBST_STASTR, ACBST);
+	/* Clear BB bit */
+	outb(inb(ACBCST) | ACBCST_BB, ACBCST);
+}
+
+static s32 scx200_acb_smbus_xfer(struct i2c_adapter *adapter,
+				u16 address, unsigned short flags,	
+				char rw, u8 command, int size, 
+				union i2c_smbus_data *data)
+{
+	struct scx200_acb_iface *iface = adapter->data;
+	int len;
+	u8 *buffer;
+	u16 cur_word;
+	int rc;
+
+	switch (size) {
+	case I2C_SMBUS_QUICK:
+	    	len = 0;
+	    	buffer = NULL;
+	    	break;
+	case I2C_SMBUS_BYTE:
+		if (rw == I2C_SMBUS_READ) {
+			len = 1;
+			buffer = &data->byte;
+		} else {
+			len = 1;
+			buffer = &command;
+		}
+	    	break;
+	case I2C_SMBUS_BYTE_DATA:
+	    	len = 1;
+	    	buffer = &data->byte;
+	    	break;
+	case I2C_SMBUS_WORD_DATA:
+		len = 2;
+	    	cur_word = cpu_to_le16(data->word);
+	    	buffer = (u8 *)&cur_word;
+		break;
+	case I2C_SMBUS_BLOCK_DATA:
+	    	len = data->block[0];
+	    	buffer = &data->block[1];
+		break;
+	default:
+	    	return -EINVAL;
+	}
+
+	DBG("%s: size=%d, address=0x%x, command=0x%x, len=%d, read=%d\n",
+	    name, size, address, command, len, rw == I2C_SMBUS_READ);
+
+	if (!len && rw == I2C_SMBUS_READ) {
+		printk(KERN_WARNING NAME ": %s, zero length read\n", 
+		       adapter->name);
+		return -EINVAL;
+	}
+
+	if (len && !buffer) {
+		printk(KERN_WARNING NAME ": %s, nonzero length but no buffer\n", adapter->name);
+		return -EFAULT;
+	}
+
+	down(&iface->sem);
+
+	iface->address_byte = address<<1;
+	if (rw == I2C_SMBUS_READ)
+		iface->address_byte |= 1;
+	iface->command = command;
+	iface->ptr = buffer;
+	iface->len = len;
+	iface->result = -EINVAL;
+	iface->needs_reset = 0;
+
+	outb(inb(ACBCTL1) | ACBCTL1_START, ACBCTL1);
+
+	if (size == I2C_SMBUS_QUICK || size == I2C_SMBUS_BYTE)
+		iface->state = state_quick;
+	else
+		iface->state = state_address;
+
+#ifdef POLLED_MODE
+	while (iface->state != state_idle)
+		scx200_acb_poll(iface);
+#else /* POLLED_MODE */
+#error Interrupt driven mode not implemented
+#endif /* POLLED_MODE */	
+
+	if (iface->needs_reset)
+		scx200_acb_reset(iface);
+
+	rc = iface->result;
+
+	up(&iface->sem);
+
+	if (rc == 0 && size == I2C_SMBUS_WORD_DATA && rw == I2C_SMBUS_READ)
+	    	data->word = le16_to_cpu(cur_word);
+
+#if DEBUG
+	printk(KERN_DEBUG "%s: transfer done, result: %d", name, rc);
+	if (buffer) {
+		int i;
+		printk(" data:");
+		for (i = 0; i < len; ++i)
+			printk(" %02x", buffer[i]);
+		printk("\n");
+	}
+#endif
+	DBG("\n");
+
+	return rc;
+}
+
+static u32 scx200_acb_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
+	       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
+	       I2C_FUNC_SMBUS_BLOCK_DATA;
+}
+
+static int scx200_acb_reg(struct i2c_client *client)
+{
+	return 0;
+}
+
+static int scx200_acb_unreg(struct i2c_client *client)
+{
+	return 0;
+}
+
+static void scx200_acb_inc_use(struct i2c_adapter *adapter)
+{
+	MOD_INC_USE_COUNT;
+}
+
+static void scx200_acb_dec_use(struct i2c_adapter *adapter)
+{
+	MOD_DEC_USE_COUNT;
+}
+
+/* For now, we only handle combined mode (smbus) */
+static struct i2c_algorithm scx200_acb_algorithm = {
+	name:		"NatSemi SCx200 ACCESS.bus",
+	id:		I2C_ALGO_SMBUS,
+	smbus_xfer:	scx200_acb_smbus_xfer,
+	functionality:	scx200_acb_func,
+};
+
+struct scx200_acb_iface *scx200_acb_list;
+
+int scx200_acb_probe(struct scx200_acb_iface *iface)
+{
+	u8 val;
+
+	/* Disable the ACCESS.bus device and Configure the SCL
+           frequency: 16 clock cycles */
+	outb(0x70, ACBCTL2);
+
+	if (inb(ACBCTL2) != 0x70) {
+		DBG("%s: ACBCTL2 readback failed\n", name);
+		return -ENXIO;
+	}
+
+	outb(inb(ACBCTL1) | ACBCTL1_NMINTE, ACBCTL1);
+
+	val = inb(ACBCTL1);
+	if (val) {
+		DBG("%s: disabled, but ACBCTL1=0x%02x\n", name, val);
+		return -ENXIO;
+	}
+
+	outb(inb(ACBCTL2) | ACBCTL2_ENABLE, ACBCTL2);
+
+	outb(inb(ACBCTL1) | ACBCTL1_NMINTE, ACBCTL1);
+
+	val = inb(ACBCTL1);
+	if ((val & ACBCTL1_NMINTE) != ACBCTL1_NMINTE) {
+		DBG("%s: enabled, but NMINTE won't be set, ACBCTL1=0x%02x\n", 
+		    name, val);
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static int  __init scx200_acb_create(int base, int index)
+{
+	struct scx200_acb_iface *iface;
+	struct i2c_adapter *adapter;
+	int rc = 0;
+	char description[64];
+
+	iface = kmalloc(sizeof(*iface), GFP_KERNEL);
+	if (!iface) {
+		printk(KERN_ERR NAME ": can't allocate memory\n");
+		rc = -ENOMEM;
+		goto errout;
+	}
+
+	memset(iface, 0, sizeof(*iface));
+	adapter = &iface->adapter;
+	adapter->data = iface;
+	sprintf(adapter->name, "SCx200 ACB%d", index);
+	adapter->id = I2C_ALGO_SMBUS;
+	adapter->algo = &scx200_acb_algorithm;
+	adapter->inc_use = scx200_acb_inc_use;
+	adapter->dec_use = scx200_acb_dec_use;
+	adapter->client_register = scx200_acb_reg;
+	adapter->client_unregister = scx200_acb_unreg;
+
+	init_MUTEX(&iface->sem);
+
+	sprintf(description, "NatSemi SCx200 ACCESS.bus [%s]", adapter->name);
+	if (request_region(base, 8, description) == 0) {
+		printk(KERN_ERR NAME ": %s, can't allocate io 0x%x-0x%x\n", 
+		       adapter->name, base, base + 8-1);
+		rc = -EBUSY;
+		goto errout;
+	}
+	iface->base = base;
+
+	rc = scx200_acb_probe(iface);
+	if (rc) {
+		printk(KERN_WARNING NAME ": %s, probe failed\n", adapter->name);
+		goto errout;
+	}
+
+	scx200_acb_reset(iface);
+
+	if (i2c_add_adapter(adapter) < 0) {
+		printk(KERN_ERR NAME ": %s, failed to register\n", adapter->name);
+		rc = -ENODEV;
+		goto errout;
+	}
+
+	lock_kernel();
+	iface->next = scx200_acb_list;
+	scx200_acb_list = iface;
+	unlock_kernel();
+
+	return 0;
+
+ errout:
+	if (iface) {
+		if (iface->base)
+			release_region(iface->base, 8);
+		kfree(iface);
+	}
+	return rc;
+}
+
+static int __init scx200_acb_init(void)
+{
+	int i;
+	int rc;
+
+	printk(KERN_DEBUG NAME ": NatSemi SCx200 ACCESS.bus Driver\n");
+
+	/* Verify that this really is a SCx200 processor */
+	if (pci_find_device(PCI_VENDOR_ID_NS,
+			    PCI_DEVICE_ID_NS_SCx200_BRIDGE,
+			    NULL) == NULL)
+		return -ENODEV;
+
+	rc = -ENXIO;
+	for (i = 0; i < MAX_DEVICES; ++i) {
+		if (base[i] > 0)
+			rc = scx200_acb_create(base[i], i);
+	}
+	if (scx200_acb_list)
+		return 0;
+	return rc;
+}
+
+static void __exit scx200_acb_cleanup(void)
+{
+	struct scx200_acb_iface *iface;
+	lock_kernel();
+	while ((iface = scx200_acb_list) != NULL) {
+		scx200_acb_list = iface->next;
+		unlock_kernel();
+
+		i2c_del_adapter(&iface->adapter);
+		release_region(iface->base, 8);
+		kfree(iface);
+		lock_kernel();
+	}
+	unlock_kernel();
+}
+
+module_init(scx200_acb_init);
+module_exit(scx200_acb_cleanup);
+
+/*
+    Local variables:
+        compile-command: "make -k -C ../.. SUBDIRS=drivers/i2c modules"
+        c-basic-offset: 8
+    End:
+*/
+
diff -urw ./linux/drivers/i2c/scx200_i2c.c.orig ./linux/drivers/i2c/scx200_i2c.c
--- ./linux/drivers/i2c/scx200_i2c.c.orig	Sun Jun 30 15:19:07 2002
+++ ./linux/drivers/i2c/scx200_i2c.c	Sun Jun 30 15:19:07 2002
@@ -0,0 +1,156 @@
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
+#include <asm/io.h>
+
+#include <linux/scx200_gpio.h>
+
+#define NAME "scx200_i2c"
+
+MODULE_AUTHOR("Christer Weinigel <wingel@nano-system.com>");
+MODULE_DESCRIPTION("NatSemi SCx200 I2C Driver");
+MODULE_LICENSE("GPL");
+
+MODULE_PARM(scl, "i");
+MODULE_PARM_DESC(scl, "GPIO line for SCL");
+MODULE_PARM(sda, "i");
+MODULE_PARM_DESC(sda, "GPIO line for SDA");
+
+static int scl = CONFIG_SCx200_I2C_SCL;
+static int sda = CONFIG_SCx200_I2C_SDA;
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
+	name:		"NatSemi SCx200 I2C",
+	id:		I2C_HW_B_VELLE,
+	algo_data:	&scx200_i2c_data,
+	inc_use:	scx200_i2c_inc_use,
+	dec_use:	scx200_i2c_dec_use,
+	client_register: scx200_i2c_reg,
+	client_unregister: scx200_i2c_unreg,
+};
+
+int scx200_i2c_init(void)
+{
+	printk(KERN_DEBUG NAME ": NatSemi SCx200 I2C Driver\n");
+
+	if (!scx200_gpio_present()) {
+		printk(KERN_ERR NAME ": no SCx200 gpio pins available\n");
+		return -ENODEV;
+	}
+
+	printk(KERN_DEBUG NAME ": SCL=GPIO%02u, SDA=GPIO%02u\n", 
+	       scl, sda);
+
+	if (scl == -1 || sda == -1 || scl == sda) {
+		printk(KERN_ERR NAME ": scl and sda must be specified\n");
+		return -EINVAL;
+	}
+
+	/* Configure GPIOs as open collector outputs */
+	scx200_gpio_configure(scl, ~2, 5);
+	scx200_gpio_configure(sda, ~2, 5);
+
+	if (i2c_bit_add_bus(&scx200_i2c_ops) < 0) {
+		printk(KERN_ERR NAME ": adapter %s registration failed\n", 
+		       scx200_i2c_ops.name);
+		return -ENODEV;
+	}
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
diff -urw ./linux/include/linux/scx200_gpio.h.orig ./linux/include/linux/scx200_gpio.h
--- ./linux/include/linux/scx200_gpio.h.orig	Sun Jun 30 15:15:29 2002
+++ ./linux/include/linux/scx200_gpio.h	Sun Jun 30 15:15:29 2002
@@ -0,0 +1,99 @@
+#include <linux/spinlock.h>
+
+u32 scx200_gpio_configure(int index, u32 set, u32 clear);
+void scx200_gpio_dump(unsigned index);
+
+extern unsigned scx200_gpio_base;
+extern spinlock_t scx200_gpio_lock;
+extern u32 scx200_gpio_shadow[2];
+extern u32 *dummy;
+
+#define scx200_gpio_present() (scx200_gpio_base!=0)
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
+        compile-command: "make -C ../.. bzImage modules"
+        c-basic-offset: 8
+    End:
+*/
diff -urw ./linux/init/main.c.orig ./linux/init/main.c
--- ./linux/init/main.c.orig	Sun Jun 30 15:15:24 2002
+++ ./linux/init/main.c	Sun Jun 30 15:15:29 2002
@@ -94,6 +94,7 @@
 extern void sysctl_init(void);
 extern void signals_init(void);
 extern int init_pcmcia_ds(void);
+extern int scx200_init(void);
 
 extern void free_initmem(void);
 
@@ -521,6 +522,9 @@
 #endif
 #ifdef CONFIG_TC
 	tc_init();
+#endif
+#ifdef CONFIG_SCx200
+	scx200_init();
 #endif
 
 	/* Networking initialization needs a process context */ 


-- 
"Just how much can I get away with and still go to heaven?"
