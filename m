Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbTIVXhS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 19:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263036AbTIVXhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 19:37:18 -0400
Received: from mail.kroah.org ([65.200.24.183]:673 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262330AbTIVXac convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 19:30:32 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10642734272108@kroah.com>
Subject: Re: [PATCH] i2c driver fixes for 2.6.0-test5
In-Reply-To: <10642734271040@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 22 Sep 2003 16:30:27 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1315.1.23, 2003/09/22 14:21:09-07:00, greg@kroah.com

[PATCH] I2C: move the scx200* drivers to drivers/i2c/busses


 drivers/i2c/scx200_acb.c        |  553 ----------------------------------------
 drivers/i2c/scx200_i2c.c        |  133 ---------
 drivers/i2c/Kconfig             |   38 --
 drivers/i2c/Makefile            |    2 
 drivers/i2c/busses/Kconfig      |   38 ++
 drivers/i2c/busses/Makefile     |    2 
 drivers/i2c/busses/scx200_acb.c |  553 ++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/scx200_i2c.c |  132 +++++++++
 8 files changed, 725 insertions(+), 726 deletions(-)


diff -Nru a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
--- a/drivers/i2c/Kconfig	Mon Sep 22 16:12:15 2003
+++ b/drivers/i2c/Kconfig	Mon Sep 22 16:12:15 2003
@@ -48,44 +48,6 @@
 	  This support is also available as a module.  If so, the module 
 	  will be called i2c-algo-bit.
 
-config SCx200_I2C
-	tristate "NatSemi SCx200 I2C using GPIO pins"
-	depends on SCx200 && I2C_ALGOBIT
-	help
-	  Enable the use of two GPIO pins of a SCx200 processor as an I2C bus.
-
-	  If you don't know what to do here, say N.
-
-	  This support is also available as a module.  If so, the module 
-	  will be called scx200_i2c.
-
-config SCx200_I2C_SCL
-	int "GPIO pin used for SCL"
-	depends on SCx200_I2C
-	default "12"
-	help
-	  Enter the GPIO pin number used for the SCL signal.  This value can
-	  also be specified with a module parameter.
-
-config SCx200_I2C_SDA
-	int "GPIO pin used for SDA"
-	depends on SCx200_I2C
-	default "13"
-	help
-	  Enter the GPIO pin number used for the SSA signal.  This value can
-	  also be specified with a module parameter.
-
-config SCx200_ACB
-	tristate "NatSemi SCx200 ACCESS.bus"
-	depends on I2C_ALGOBIT!=n && I2C
-	help
-	  Enable the use of the ACCESS.bus controllers of a SCx200 processor.
-
-	  If you don't know what to do here, say N.
-
-	  This support is also available as a module.  If so, the module 
-	  will be called scx200_acb.
-
 config I2C_ALGOPCF
 	tristate "I2C PCF 8584 interfaces"
 	depends on I2C
diff -Nru a/drivers/i2c/Makefile b/drivers/i2c/Makefile
--- a/drivers/i2c/Makefile	Mon Sep 22 16:12:15 2003
+++ b/drivers/i2c/Makefile	Mon Sep 22 16:12:15 2003
@@ -9,8 +9,6 @@
 obj-$(CONFIG_I2C_KEYWEST)	+= i2c-keywest.o
 obj-$(CONFIG_ITE_I2C_ALGO)	+= i2c-algo-ite.o
 obj-$(CONFIG_ITE_I2C_ADAP)	+= i2c-adap-ite.o
-obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
-obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
 obj-$(CONFIG_I2C_IBM_IIC)	+= i2c-ibm_iic.o
 obj-$(CONFIG_I2C_SENSOR)	+= i2c-sensor.o
 obj-$(CONFIG_I2C_IOP3XX)	+= i2c-iop3xx.o
diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Sep 22 16:12:15 2003
+++ b/drivers/i2c/busses/Kconfig	Mon Sep 22 16:12:15 2003
@@ -166,6 +166,44 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-savage4.
 
+config SCx200_I2C
+	tristate "NatSemi SCx200 I2C using GPIO pins"
+	depends on SCx200 && I2C_ALGOBIT
+	help
+	  Enable the use of two GPIO pins of a SCx200 processor as an I2C bus.
+
+	  If you don't know what to do here, say N.
+
+	  This support is also available as a module.  If so, the module 
+	  will be called scx200_i2c.
+
+config SCx200_I2C_SCL
+	int "GPIO pin used for SCL"
+	depends on SCx200_I2C
+	default "12"
+	help
+	  Enter the GPIO pin number used for the SCL signal.  This value can
+	  also be specified with a module parameter.
+
+config SCx200_I2C_SDA
+	int "GPIO pin used for SDA"
+	depends on SCx200_I2C
+	default "13"
+	help
+	  Enter the GPIO pin number used for the SSA signal.  This value can
+	  also be specified with a module parameter.
+
+config SCx200_ACB
+	tristate "NatSemi SCx200 ACCESS.bus"
+	depends on I2C_ALGOBIT!=n && I2C
+	help
+	  Enable the use of the ACCESS.bus controllers of a SCx200 processor.
+
+	  If you don't know what to do here, say N.
+
+	  This support is also available as a module.  If so, the module 
+	  will be called scx200_acb.
+
 config I2C_SIS5595
 	tristate "SiS 5595"
 	depends on I2C && PCI && EXPERIMENTAL
diff -Nru a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
--- a/drivers/i2c/busses/Makefile	Mon Sep 22 16:12:15 2003
+++ b/drivers/i2c/busses/Makefile	Mon Sep 22 16:12:15 2003
@@ -23,3 +23,5 @@
 obj-$(CONFIG_I2C_VIA)		+= i2c-via.o
 obj-$(CONFIG_I2C_VIAPRO)	+= i2c-viapro.o
 obj-$(CONFIG_I2C_VOODOO3)	+= i2c-voodoo3.o
+obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
+obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
diff -Nru a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/busses/scx200_acb.c	Mon Sep 22 16:12:15 2003
@@ -0,0 +1,553 @@
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
+		dev_warn(&iface->adapter.dev, "interrupt in idle state\n");
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
+	DBG("negative acknowledge in state %s\n", 
+	    scx200_acb_state_name[iface->state]);
+
+	iface->state = state_idle;
+	iface->result = -ENXIO;
+
+	outb(inb(ACBCTL1) | ACBCTL1_STOP, ACBCTL1);
+	outb(ACBST_STASTR | ACBST_NEGACK, ACBST);
+	return;
+
+ error:
+	dev_err(&iface->adapter.dev, "%s in state %s\n", errmsg,
+		scx200_acb_state_name[iface->state]);
+
+	iface->state = state_idle;
+	iface->result = -EIO;
+	iface->needs_reset = 1;
+}
+
+static void scx200_acb_timeout(struct scx200_acb_iface *iface) 
+{
+	dev_err(&iface->adapter.dev, "timeout in state %s\n",
+		scx200_acb_state_name[iface->state]);
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
+		schedule_timeout(HZ/100+1);
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
+	struct scx200_acb_iface *iface = i2c_get_adapdata(adapter);
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
+	DBG("size=%d, address=0x%x, command=0x%x, len=%d, read=%d\n",
+	    size, address, command, len, rw == I2C_SMBUS_READ);
+
+	if (!len && rw == I2C_SMBUS_READ) {
+		dev_warn(&adapter->dev, "zero length read\n");
+		return -EINVAL;
+	}
+
+	if (len && !buffer) {
+		dev_warn(&adapter->dev, "nonzero length but no buffer\n");
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
+	printk(KERN_DEBUG NAME ": transfer done, result: %d", rc);
+	if (buffer) {
+		int i;
+		printk(" data:");
+		for (i = 0; i < len; ++i)
+			printk(" %02x", buffer[i]);
+	}
+	printk("\n");
+#endif
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
+/* For now, we only handle combined mode (smbus) */
+static struct i2c_algorithm scx200_acb_algorithm = {
+	.name		= "NatSemi SCx200 ACCESS.bus",
+	.id		= I2C_ALGO_SMBUS,
+	.smbus_xfer	= scx200_acb_smbus_xfer,
+	.functionality	= scx200_acb_func,
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
+		DBG("ACBCTL2 readback failed\n");
+		return -ENXIO;
+	}
+
+	outb(inb(ACBCTL1) | ACBCTL1_NMINTE, ACBCTL1);
+
+	val = inb(ACBCTL1);
+	if (val) {
+		DBG("disabled, but ACBCTL1=0x%02x\n", val);
+		return -ENXIO;
+	}
+
+	outb(inb(ACBCTL2) | ACBCTL2_ENABLE, ACBCTL2);
+
+	outb(inb(ACBCTL1) | ACBCTL1_NMINTE, ACBCTL1);
+
+	val = inb(ACBCTL1);
+	if ((val & ACBCTL1_NMINTE) != ACBCTL1_NMINTE) {
+		DBG("enabled, but NMINTE won't be set, ACBCTL1=0x%02x\n", val);
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
+	i2c_set_adapdata(adapter, iface);
+	snprintf(adapter->name, I2C_NAME_SIZE, "SCx200 ACB%d", index);
+	adapter->owner = THIS_MODULE;
+	adapter->id = I2C_ALGO_SMBUS;
+	adapter->algo = &scx200_acb_algorithm;
+
+	init_MUTEX(&iface->sem);
+
+	snprintf(description, sizeof(description), "NatSemi SCx200 ACCESS.bus [%s]", adapter->name);
+	if (request_region(base, 8, description) == 0) {
+		dev_err(&adapter->dev, "can't allocate io 0x%x-0x%x\n",
+			base, base + 8-1);
+		rc = -EBUSY;
+		goto errout;
+	}
+	iface->base = base;
+
+	rc = scx200_acb_probe(iface);
+	if (rc) {
+		dev_warn(&adapter->dev, "probe failed\n");
+		goto errout;
+	}
+
+	scx200_acb_reset(iface);
+
+	if (i2c_add_adapter(adapter) < 0) {
+		dev_err(&adapter->dev, "failed to register\n");
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
diff -Nru a/drivers/i2c/busses/scx200_i2c.c b/drivers/i2c/busses/scx200_i2c.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/busses/scx200_i2c.c	Mon Sep 22 16:12:15 2003
@@ -0,0 +1,132 @@
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
+	.owner		   = THIS_MODULE,
+	.algo_data	   = &scx200_i2c_data,
+	.name	= "NatSemi SCx200 I2C",
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
diff -Nru a/drivers/i2c/scx200_acb.c b/drivers/i2c/scx200_acb.c
--- a/drivers/i2c/scx200_acb.c	Mon Sep 22 16:12:15 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,553 +0,0 @@
-/*  linux/drivers/i2c/scx200_acb.c 
-
-    Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>
-
-    National Semiconductor SCx200 ACCESS.bus support
-    
-    Based on i2c-keywest.c which is:
-        Copyright (c) 2001 Benjamin Herrenschmidt <benh@kernel.crashing.org>
-        Copyright (c) 2000 Philip Edelbrock <phil@stimpy.netroedge.com>
-    
-    This program is free software; you can redistribute it and/or
-    modify it under the terms of the GNU General Public License as
-    published by the Free Software Foundation; either version 2 of the
-    License, or (at your option) any later version.
-   
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-    General Public License for more details.
-   
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
-*/
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/i2c.h>
-#include <linux/smp_lock.h>
-#include <linux/pci.h>
-#include <asm/io.h>
-
-#include <linux/scx200.h>
-
-#define NAME "scx200_acb"
-
-MODULE_AUTHOR("Christer Weinigel <wingel@nano-system.com>");
-MODULE_DESCRIPTION("NatSemi SCx200 ACCESS.bus Driver");
-MODULE_LICENSE("GPL");
-
-#define MAX_DEVICES 4
-static int base[MAX_DEVICES] = { 0x840 };
-MODULE_PARM(base, "1-4i");
-MODULE_PARM_DESC(base, "Base addresses for the ACCESS.bus controllers");
-
-#define DEBUG 0
-
-#if DEBUG
-#define DBG(x...) printk(KERN_DEBUG NAME ": " x)
-#else
-#define DBG(x...)
-#endif
-
-/* The hardware supports interrupt driven mode too, but I haven't
-   implemented that. */
-#define POLLED_MODE 1
-#define POLL_TIMEOUT (HZ)
-
-enum scx200_acb_state {
-	state_idle,
-	state_address,
-	state_command,
-	state_repeat_start,
-	state_quick,
-	state_read,
-	state_write,
-};
-
-static const char *scx200_acb_state_name[] = {
-	"idle",
-	"address",
-	"command",
-	"repeat_start",
-	"quick",
-	"read",
-	"write",
-};
-
-/* Physical interface */
-struct scx200_acb_iface
-{
-	struct scx200_acb_iface *next;
-	struct i2c_adapter adapter;
-	unsigned base;
-	struct semaphore sem;
-
-	/* State machine data */
-	enum scx200_acb_state state;
-	int result;
-	u8 address_byte;
-	u8 command;
-	u8 *ptr;
-	char needs_reset;
-	unsigned len;
-};
-
-/* Register Definitions */
-#define ACBSDA		(iface->base + 0)
-#define ACBST		(iface->base + 1)
-#define    ACBST_SDAST		0x40 /* SDA Status */
-#define    ACBST_BER		0x20 
-#define    ACBST_NEGACK		0x10 /* Negative Acknowledge */
-#define    ACBST_STASTR		0x08 /* Stall After Start */
-#define    ACBST_MASTER		0x02
-#define ACBCST		(iface->base + 2)
-#define    ACBCST_BB		0x02
-#define ACBCTL1		(iface->base + 3)
-#define    ACBCTL1_STASTRE	0x80
-#define    ACBCTL1_NMINTE	0x40
-#define	   ACBCTL1_ACK		0x10
-#define	   ACBCTL1_STOP		0x02
-#define	   ACBCTL1_START	0x01
-#define ACBADDR		(iface->base + 4)
-#define ACBCTL2		(iface->base + 5)
-#define    ACBCTL2_ENABLE	0x01
-
-/************************************************************************/
-
-static void scx200_acb_machine(struct scx200_acb_iface *iface, u8 status)
-{
-	const char *errmsg;
-
-	DBG("state %s, status = 0x%02x\n", 
-	    scx200_acb_state_name[iface->state], status);
-
-	if (status & ACBST_BER) {
-		errmsg = "bus error";
-		goto error;
-	}
-	if (!(status & ACBST_MASTER)) {
-		errmsg = "not master";
-		goto error;
-	}
-	if (status & ACBST_NEGACK)
-		goto negack;
-
-	switch (iface->state) {
-	case state_idle:
-		dev_warn(&iface->adapter.dev, "interrupt in idle state\n");
-		break;
-
-	case state_address:
-		/* Do a pointer write first */
-		outb(iface->address_byte & ~1, ACBSDA);
-
-		iface->state = state_command;
-		break;
-
-	case state_command:
-		outb(iface->command, ACBSDA);
-
-		if (iface->address_byte & 1)
-			iface->state = state_repeat_start;
-		else
-			iface->state = state_write;
-		break;
-
-	case state_repeat_start:
-		outb(inb(ACBCTL1) | ACBCTL1_START, ACBCTL1);
-		/* fallthrough */
-		
-	case state_quick:
-		if (iface->address_byte & 1) {
-			if (iface->len == 1) 
-				outb(inb(ACBCTL1) | ACBCTL1_ACK, ACBCTL1);
-			else
-				outb(inb(ACBCTL1) & ~ACBCTL1_ACK, ACBCTL1);
-			outb(iface->address_byte, ACBSDA);
-
-			iface->state = state_read;
-		} else {
-			outb(iface->address_byte, ACBSDA);
-
-			iface->state = state_write;
-		}
-		break;
-
-	case state_read:
-		/* Set ACK if receiving the last byte */
-		if (iface->len == 1)
-			outb(inb(ACBCTL1) | ACBCTL1_ACK, ACBCTL1);
-		else
-			outb(inb(ACBCTL1) & ~ACBCTL1_ACK, ACBCTL1);
-
-		*iface->ptr++ = inb(ACBSDA);
-		--iface->len;
-
-		if (iface->len == 0) {
-			iface->result = 0;
-			iface->state = state_idle;
-			outb(inb(ACBCTL1) | ACBCTL1_STOP, ACBCTL1);
-		}
-
-		break;
-
-	case state_write:
-		if (iface->len == 0) {
-			iface->result = 0;
-			iface->state = state_idle;
-			outb(inb(ACBCTL1) | ACBCTL1_STOP, ACBCTL1);
-			break;
-		}
-		
-		outb(*iface->ptr++, ACBSDA);
-		--iface->len;
-		
-		break;
-	}
-
-	return;
-
- negack:
-	DBG("negative acknowledge in state %s\n", 
-	    scx200_acb_state_name[iface->state]);
-
-	iface->state = state_idle;
-	iface->result = -ENXIO;
-
-	outb(inb(ACBCTL1) | ACBCTL1_STOP, ACBCTL1);
-	outb(ACBST_STASTR | ACBST_NEGACK, ACBST);
-	return;
-
- error:
-	dev_err(&iface->adapter.dev, "%s in state %s\n", errmsg,
-		scx200_acb_state_name[iface->state]);
-
-	iface->state = state_idle;
-	iface->result = -EIO;
-	iface->needs_reset = 1;
-}
-
-static void scx200_acb_timeout(struct scx200_acb_iface *iface) 
-{
-	dev_err(&iface->adapter.dev, "timeout in state %s\n",
-		scx200_acb_state_name[iface->state]);
-
-	iface->state = state_idle;
-	iface->result = -EIO;
-	iface->needs_reset = 1;
-}
-
-#ifdef POLLED_MODE
-static void scx200_acb_poll(struct scx200_acb_iface *iface)
-{
-	u8 status = 0;
-	unsigned long timeout;
-
-	timeout = jiffies + POLL_TIMEOUT;
-	while (time_before(jiffies, timeout)) {
-		status = inb(ACBST);
-		if ((status & (ACBST_SDAST|ACBST_BER|ACBST_NEGACK)) != 0) {
-			scx200_acb_machine(iface, status);
-			return;
-		}
-		schedule_timeout(HZ/100+1);
-	}
-
-	scx200_acb_timeout(iface);
-}
-#endif /* POLLED_MODE */
-
-static void scx200_acb_reset(struct scx200_acb_iface *iface)
-{
-	/* Disable the ACCESS.bus device and Configure the SCL
-           frequency: 16 clock cycles */
-	outb(0x70, ACBCTL2);
-	/* Polling mode */
-	outb(0, ACBCTL1);
-	/* Disable slave address */
-	outb(0, ACBADDR);
-	/* Enable the ACCESS.bus device */
-	outb(inb(ACBCTL2) | ACBCTL2_ENABLE, ACBCTL2);
-	/* Free STALL after START */
-	outb(inb(ACBCTL1) & ~(ACBCTL1_STASTRE | ACBCTL1_NMINTE), ACBCTL1);
-	/* Send a STOP */
-	outb(inb(ACBCTL1) | ACBCTL1_STOP, ACBCTL1);
-	/* Clear BER, NEGACK and STASTR bits */
-	outb(ACBST_BER | ACBST_NEGACK | ACBST_STASTR, ACBST);
-	/* Clear BB bit */
-	outb(inb(ACBCST) | ACBCST_BB, ACBCST);
-}
-
-static s32 scx200_acb_smbus_xfer(struct i2c_adapter *adapter,
-				u16 address, unsigned short flags,	
-				char rw, u8 command, int size, 
-				union i2c_smbus_data *data)
-{
-	struct scx200_acb_iface *iface = i2c_get_adapdata(adapter);
-	int len;
-	u8 *buffer;
-	u16 cur_word;
-	int rc;
-
-	switch (size) {
-	case I2C_SMBUS_QUICK:
-	    	len = 0;
-	    	buffer = NULL;
-	    	break;
-	case I2C_SMBUS_BYTE:
-		if (rw == I2C_SMBUS_READ) {
-			len = 1;
-			buffer = &data->byte;
-		} else {
-			len = 1;
-			buffer = &command;
-		}
-	    	break;
-	case I2C_SMBUS_BYTE_DATA:
-	    	len = 1;
-	    	buffer = &data->byte;
-	    	break;
-	case I2C_SMBUS_WORD_DATA:
-		len = 2;
-	    	cur_word = cpu_to_le16(data->word);
-	    	buffer = (u8 *)&cur_word;
-		break;
-	case I2C_SMBUS_BLOCK_DATA:
-	    	len = data->block[0];
-	    	buffer = &data->block[1];
-		break;
-	default:
-	    	return -EINVAL;
-	}
-
-	DBG("size=%d, address=0x%x, command=0x%x, len=%d, read=%d\n",
-	    size, address, command, len, rw == I2C_SMBUS_READ);
-
-	if (!len && rw == I2C_SMBUS_READ) {
-		dev_warn(&adapter->dev, "zero length read\n");
-		return -EINVAL;
-	}
-
-	if (len && !buffer) {
-		dev_warn(&adapter->dev, "nonzero length but no buffer\n");
-		return -EFAULT;
-	}
-
-	down(&iface->sem);
-
-	iface->address_byte = address<<1;
-	if (rw == I2C_SMBUS_READ)
-		iface->address_byte |= 1;
-	iface->command = command;
-	iface->ptr = buffer;
-	iface->len = len;
-	iface->result = -EINVAL;
-	iface->needs_reset = 0;
-
-	outb(inb(ACBCTL1) | ACBCTL1_START, ACBCTL1);
-
-	if (size == I2C_SMBUS_QUICK || size == I2C_SMBUS_BYTE)
-		iface->state = state_quick;
-	else
-		iface->state = state_address;
-
-#ifdef POLLED_MODE
-	while (iface->state != state_idle)
-		scx200_acb_poll(iface);
-#else /* POLLED_MODE */
-#error Interrupt driven mode not implemented
-#endif /* POLLED_MODE */	
-
-	if (iface->needs_reset)
-		scx200_acb_reset(iface);
-
-	rc = iface->result;
-
-	up(&iface->sem);
-
-	if (rc == 0 && size == I2C_SMBUS_WORD_DATA && rw == I2C_SMBUS_READ)
-	    	data->word = le16_to_cpu(cur_word);
-
-#if DEBUG
-	printk(KERN_DEBUG NAME ": transfer done, result: %d", rc);
-	if (buffer) {
-		int i;
-		printk(" data:");
-		for (i = 0; i < len; ++i)
-			printk(" %02x", buffer[i]);
-	}
-	printk("\n");
-#endif
-
-	return rc;
-}
-
-static u32 scx200_acb_func(struct i2c_adapter *adapter)
-{
-	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
-	       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
-	       I2C_FUNC_SMBUS_BLOCK_DATA;
-}
-
-/* For now, we only handle combined mode (smbus) */
-static struct i2c_algorithm scx200_acb_algorithm = {
-	.name		= "NatSemi SCx200 ACCESS.bus",
-	.id		= I2C_ALGO_SMBUS,
-	.smbus_xfer	= scx200_acb_smbus_xfer,
-	.functionality	= scx200_acb_func,
-};
-
-struct scx200_acb_iface *scx200_acb_list;
-
-int scx200_acb_probe(struct scx200_acb_iface *iface)
-{
-	u8 val;
-
-	/* Disable the ACCESS.bus device and Configure the SCL
-           frequency: 16 clock cycles */
-	outb(0x70, ACBCTL2);
-
-	if (inb(ACBCTL2) != 0x70) {
-		DBG("ACBCTL2 readback failed\n");
-		return -ENXIO;
-	}
-
-	outb(inb(ACBCTL1) | ACBCTL1_NMINTE, ACBCTL1);
-
-	val = inb(ACBCTL1);
-	if (val) {
-		DBG("disabled, but ACBCTL1=0x%02x\n", val);
-		return -ENXIO;
-	}
-
-	outb(inb(ACBCTL2) | ACBCTL2_ENABLE, ACBCTL2);
-
-	outb(inb(ACBCTL1) | ACBCTL1_NMINTE, ACBCTL1);
-
-	val = inb(ACBCTL1);
-	if ((val & ACBCTL1_NMINTE) != ACBCTL1_NMINTE) {
-		DBG("enabled, but NMINTE won't be set, ACBCTL1=0x%02x\n", val);
-		return -ENXIO;
-	}
-
-	return 0;
-}
-
-static int  __init scx200_acb_create(int base, int index)
-{
-	struct scx200_acb_iface *iface;
-	struct i2c_adapter *adapter;
-	int rc = 0;
-	char description[64];
-
-	iface = kmalloc(sizeof(*iface), GFP_KERNEL);
-	if (!iface) {
-		printk(KERN_ERR NAME ": can't allocate memory\n");
-		rc = -ENOMEM;
-		goto errout;
-	}
-
-	memset(iface, 0, sizeof(*iface));
-	adapter = &iface->adapter;
-	i2c_set_adapdata(adapter, iface);
-	snprintf(adapter->name, I2C_NAME_SIZE, "SCx200 ACB%d", index);
-	adapter->owner = THIS_MODULE;
-	adapter->id = I2C_ALGO_SMBUS;
-	adapter->algo = &scx200_acb_algorithm;
-
-	init_MUTEX(&iface->sem);
-
-	snprintf(description, sizeof(description), "NatSemi SCx200 ACCESS.bus [%s]", adapter->name);
-	if (request_region(base, 8, description) == 0) {
-		dev_err(&adapter->dev, "can't allocate io 0x%x-0x%x\n",
-			base, base + 8-1);
-		rc = -EBUSY;
-		goto errout;
-	}
-	iface->base = base;
-
-	rc = scx200_acb_probe(iface);
-	if (rc) {
-		dev_warn(&adapter->dev, "probe failed\n");
-		goto errout;
-	}
-
-	scx200_acb_reset(iface);
-
-	if (i2c_add_adapter(adapter) < 0) {
-		dev_err(&adapter->dev, "failed to register\n");
-		rc = -ENODEV;
-		goto errout;
-	}
-
-	lock_kernel();
-	iface->next = scx200_acb_list;
-	scx200_acb_list = iface;
-	unlock_kernel();
-
-	return 0;
-
- errout:
-	if (iface) {
-		if (iface->base)
-			release_region(iface->base, 8);
-		kfree(iface);
-	}
-	return rc;
-}
-
-static int __init scx200_acb_init(void)
-{
-	int i;
-	int rc;
-
-	printk(KERN_DEBUG NAME ": NatSemi SCx200 ACCESS.bus Driver\n");
-
-	/* Verify that this really is a SCx200 processor */
-	if (pci_find_device(PCI_VENDOR_ID_NS,
-			    PCI_DEVICE_ID_NS_SCx200_BRIDGE,
-			    NULL) == NULL)
-		return -ENODEV;
-
-	rc = -ENXIO;
-	for (i = 0; i < MAX_DEVICES; ++i) {
-		if (base[i] > 0)
-			rc = scx200_acb_create(base[i], i);
-	}
-	if (scx200_acb_list)
-		return 0;
-	return rc;
-}
-
-static void __exit scx200_acb_cleanup(void)
-{
-	struct scx200_acb_iface *iface;
-	lock_kernel();
-	while ((iface = scx200_acb_list) != NULL) {
-		scx200_acb_list = iface->next;
-		unlock_kernel();
-
-		i2c_del_adapter(&iface->adapter);
-		release_region(iface->base, 8);
-		kfree(iface);
-		lock_kernel();
-	}
-	unlock_kernel();
-}
-
-module_init(scx200_acb_init);
-module_exit(scx200_acb_cleanup);
-
-/*
-    Local variables:
-        compile-command: "make -k -C ../.. SUBDIRS=drivers/i2c modules"
-        c-basic-offset: 8
-    End:
-*/
-
diff -Nru a/drivers/i2c/scx200_i2c.c b/drivers/i2c/scx200_i2c.c
--- a/drivers/i2c/scx200_i2c.c	Mon Sep 22 16:12:15 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,133 +0,0 @@
-/* linux/drivers/i2c/scx200_i2c.c 
-
-   Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>
-
-   National Semiconductor SCx200 I2C bus on GPIO pins
-
-   Based on i2c-velleman.c Copyright (C) 1995-96, 2000 Simon G. Vogl
-
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License as published by
-   the Free Software Foundation; either version 2 of the License, or
-   (at your option) any later version.
-   
-   This program is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-   GNU General Public License for more details.
-   
-   You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software
-   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     
-*/
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/i2c.h>
-#include <linux/i2c-algo-bit.h>
-#include <asm/io.h>
-
-#include <linux/scx200_gpio.h>
-
-#define NAME "scx200_i2c"
-
-MODULE_AUTHOR("Christer Weinigel <wingel@nano-system.com>");
-MODULE_DESCRIPTION("NatSemi SCx200 I2C Driver");
-MODULE_LICENSE("GPL");
-
-MODULE_PARM(scl, "i");
-MODULE_PARM_DESC(scl, "GPIO line for SCL");
-MODULE_PARM(sda, "i");
-MODULE_PARM_DESC(sda, "GPIO line for SDA");
-
-static int scl = CONFIG_SCx200_I2C_SCL;
-static int sda = CONFIG_SCx200_I2C_SDA;
-
-static void scx200_i2c_setscl(void *data, int state)
-{
-	scx200_gpio_set(scl, state);
-}
-
-static void scx200_i2c_setsda(void *data, int state)
-{
-	scx200_gpio_set(sda, state);
-} 
-
-static int scx200_i2c_getscl(void *data)
-{
-	return scx200_gpio_get(scl);
-}
-
-static int scx200_i2c_getsda(void *data)
-{
-	return scx200_gpio_get(sda);
-}
-
-/* ------------------------------------------------------------------------
- * Encapsulate the above functions in the correct operations structure.
- * This is only done when more than one hardware adapter is supported.
- */
-
-static struct i2c_algo_bit_data scx200_i2c_data = {
-	NULL,
-	scx200_i2c_setsda,
-	scx200_i2c_setscl,
-	scx200_i2c_getsda,
-	scx200_i2c_getscl,
-	10, 10, 100,		/* waits, timeout */
-};
-
-static struct i2c_adapter scx200_i2c_ops = {
-	.owner		   = THIS_MODULE,
-	.id		   = I2C_HW_B_VELLE,
-	.algo_data	   = &scx200_i2c_data,
-	.name	= "NatSemi SCx200 I2C",
-};
-
-int scx200_i2c_init(void)
-{
-	printk(KERN_DEBUG NAME ": NatSemi SCx200 I2C Driver\n");
-
-	if (!scx200_gpio_present()) {
-		printk(KERN_ERR NAME ": no SCx200 gpio pins available\n");
-		return -ENODEV;
-	}
-
-	printk(KERN_DEBUG NAME ": SCL=GPIO%02u, SDA=GPIO%02u\n", 
-	       scl, sda);
-
-	if (scl == -1 || sda == -1 || scl == sda) {
-		printk(KERN_ERR NAME ": scl and sda must be specified\n");
-		return -EINVAL;
-	}
-
-	/* Configure GPIOs as open collector outputs */
-	scx200_gpio_configure(scl, ~2, 5);
-	scx200_gpio_configure(sda, ~2, 5);
-
-	if (i2c_bit_add_bus(&scx200_i2c_ops) < 0) {
-		printk(KERN_ERR NAME ": adapter %s registration failed\n", 
-		       scx200_i2c_ops.name);
-		return -ENODEV;
-	}
-	
-	return 0;
-}
-
-void scx200_i2c_cleanup(void)
-{
-	i2c_bit_del_bus(&scx200_i2c_ops);
-}
-
-module_init(scx200_i2c_init);
-module_exit(scx200_i2c_cleanup);
-
-/*
-    Local variables:
-        compile-command: "make -k -C ../.. SUBDIRS=drivers/i2c modules"
-        c-basic-offset: 8
-    End:
-*/

