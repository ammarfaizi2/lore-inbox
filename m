Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbVLGRea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbVLGRea (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 12:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbVLGRea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 12:34:30 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:47630 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751263AbVLGRe3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 12:34:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=O2PsDViY4QE4+awYqjpKDbEKKCidEVVGFXaTPoeK2cH2mFBmyJ0e8ukgPfvwlGI5tZA3i+CFgd0q6dbnFM2J5A+KAQPOv965lTgD1vhx61ob7A968NDDGgWHhKYEU9Nt4xvIINi7SNYCRJXRCrKK92B9tw6jAK3S+JGEjeNzCGo=
Message-ID: <808c8e9d0512070934m25fb4a10pd0df8702b9228f2a@mail.gmail.com>
Date: Wed, 7 Dec 2005 11:34:22 -0600
From: Ben Gardner <gardner.ben@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/3] i386: CS5535 chip support - SMBus
Cc: lm-sensors <lm-sensors@lm-sensors.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1984_2206685.1133976862429"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1984_2206685.1133976862429
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Provides a SMBus/I2C driver for the AMD CS5535, modeled after the
scx200_acb driver.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>

------=_Part_1984_2206685.1133976862429
Content-Type: text/plain; name=cs5535-smb.patch.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cs5535-smb.patch.txt"

 drivers/i2c/busses/Kconfig      |   11 
 drivers/i2c/busses/Makefile     |    1 
 drivers/i2c/busses/i2c-cs5535.c |  553 ++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c-id.h          |    1 
 4 files changed, 566 insertions(+)

Index: linux-2.6.14/drivers/i2c/busses/Makefile
===================================================================
--- linux-2.6.14.orig/drivers/i2c/busses/Makefile
+++ linux-2.6.14/drivers/i2c/busses/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_I2C_AMD756)	+= i2c-amd756.o
 obj-$(CONFIG_I2C_AMD756_S4882)	+= i2c-amd756-s4882.o
 obj-$(CONFIG_I2C_AMD8111)	+= i2c-amd8111.o
 obj-$(CONFIG_I2C_AU1550)	+= i2c-au1550.o
+obj-$(CONFIG_I2C_CS5535)	+= i2c-cs5535.o
 obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
 obj-$(CONFIG_I2C_HYDRA)		+= i2c-hydra.o
 obj-$(CONFIG_I2C_I801)		+= i2c-i801.o
Index: linux-2.6.14/drivers/i2c/busses/Kconfig
===================================================================
--- linux-2.6.14.orig/drivers/i2c/busses/Kconfig
+++ linux-2.6.14/drivers/i2c/busses/Kconfig
@@ -84,6 +84,17 @@ config I2C_AU1550
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-au1550.
 
+config I2C_CS5535
+	tristate "AMD CS5535 SMBus (Geode GX)"
+	depends on I2C && CS5535 && EXPERIMENTAL
+	help
+	  Enable the use of the SMB controller on the CS5535 companion device.
+
+	  If you don't know what to do here, say N.
+
+	  This support is also available as a module.  If so, the module
+	  will be called i2c-cs5535.
+
 config I2C_ELEKTOR
 	tristate "Elektor ISA card"
 	depends on I2C && ISA && BROKEN_ON_SMP
Index: linux-2.6.14/drivers/i2c/busses/i2c-cs5535.c
===================================================================
--- /dev/null
+++ linux-2.6.14/drivers/i2c/busses/i2c-cs5535.c
@@ -0,0 +1,553 @@
+/*  linux/drivers/i2c/i2c-cs5535.c
+ *
+ *  Copyright (c) 2005 Ben Gardner <bgardner@wabtec.com>
+ *
+ *  AMD CS5535 SMB support - mostly identical to
+ *  National Semiconductor SCx200 ACCESS.bus support
+ *  except for the detection routine.
+ *
+ *  Based on scx200_acb.c which is:
+ *      Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  TODO: the Access.Bus logic should be put in a separate file, as it could
+ *        be shared with the scx200.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/smp_lock.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <asm/msr.h>
+#include <asm/io.h>
+
+#define NAME			"cs5535_smb"
+
+MODULE_AUTHOR("Ben Gardner <bgardner@wabtec.com>");
+MODULE_DESCRIPTION("AMD CS5535 SMB Driver");
+MODULE_LICENSE("GPL");
+
+/* Needed to see if the cs5535 is present */
+extern u32 cs5535_gpio_base;
+
+#define MSR_LBAR_SMB		0x5140000B
+#define SMB_IO_SIZE		8
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(x...) printk(KERN_DEBUG NAME ": " x)
+#else
+#define DBG(x...)
+#endif
+
+/* The hardware supports interrupt driven mode too, but I haven't
+   implemented that. */
+#define POLL_TIMEOUT (HZ)
+
+enum cs5535_smb_state {
+	state_idle,
+	state_address,
+	state_command,
+	state_repeat_start,
+	state_quick,
+	state_read,
+	state_write,
+};
+
+static const char *cs5535_smb_state_name[] = {
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
+struct cs5535_smb_iface {
+	struct i2c_adapter	adapter;
+	u32			base;
+	struct semaphore	sem;
+
+	/* State machine data */
+	enum cs5535_smb_state	state;
+	int			result;
+	u8			address_byte;
+	u8			command;
+	u8			*ptr;
+	char			needs_reset;
+	u32			len;
+};
+
+
+/* Register Definitions */
+#define SMBSDA		(iface->base + 0)
+#define SMBST		(iface->base + 1)
+#define    SMBST_SDAST		0x40	/* SDA Status */
+#define    SMBST_BER		0x20
+#define    SMBST_NEGACK		0x10	/* Negative Acknowledge */
+#define    SMBST_STASTR		0x08	/* Stall After Start */
+#define    SMBST_MASTER		0x02
+#define SMBCST		(iface->base + 2)
+#define    SMBCST_BB		0x02
+#define SMBCTL1		(iface->base + 3)
+#define    SMBCTL1_STASTRE	0x80
+#define    SMBCTL1_NMINTE	0x40
+#define    SMBCTL1_ACK		0x10
+#define    SMBCTL1_INTEN	0x04
+#define    SMBCTL1_STOP		0x02
+#define    SMBCTL1_START	0x01
+#define SMBADDR		(iface->base + 4)
+#define SMBCTL2		(iface->base + 5)
+#define    SMBCTL2_ENABLE	0x01
+
+/************************************************************************/
+
+static u8 smb_inb(u32 p)
+{
+	u8 ch = inb(p);
+	udelay(5);
+	return ch;
+}
+
+static void smb_outb(u8 ch, u32 p)
+{
+	outb(ch, p);
+	udelay(5);
+}
+
+static void cs5535_smb_machine(struct cs5535_smb_iface *iface, u8 status)
+{
+	const char *errmsg;
+
+	DBG("state %s, status = 0x%02x\n",
+	    cs5535_smb_state_name[iface->state], status);
+
+	if (status & SMBST_BER) {
+		errmsg = "bus error";
+		goto error;
+	}
+	if (!(status & SMBST_MASTER)) {
+		errmsg = "not master";
+		goto error;
+	}
+	if (status & SMBST_NEGACK) {
+		DBG("negative acknowledge in state %s\n",
+		    cs5535_smb_state_name[iface->state]);
+
+		iface->state = state_idle;
+		iface->result = -ENXIO;
+
+		smb_outb(smb_inb(SMBCTL1) | SMBCTL1_STOP, SMBCTL1);
+		smb_outb(SMBST_STASTR | SMBST_NEGACK, SMBST);
+		smb_outb(0, SMBST); /* Status Reg bug workaround */
+		return;
+	}
+
+	switch (iface->state) {
+	case state_idle:
+		dev_warn(&iface->adapter.dev, "interrupt in idle state\n");
+		break;
+
+	case state_address:
+		/* Do a pointer write first */
+		smb_outb(iface->address_byte & ~1, SMBSDA);
+
+		iface->state = state_command;
+		break;
+
+	case state_command:
+		smb_outb(iface->command, SMBSDA);
+
+		if (iface->address_byte & 1)
+			iface->state = state_repeat_start;
+		else
+			iface->state = state_write;
+		break;
+
+	case state_repeat_start:
+		smb_outb(smb_inb(SMBCTL1) | SMBCTL1_START, SMBCTL1);
+		/* fallthrough */
+
+	case state_quick:
+		if (iface->address_byte & 1) {
+			if (iface->len == 1)
+				smb_outb(smb_inb(SMBCTL1) | SMBCTL1_ACK,
+					 SMBCTL1);
+			else
+				smb_outb(smb_inb(SMBCTL1) & ~SMBCTL1_ACK,
+					 SMBCTL1);
+			smb_outb(iface->address_byte, SMBSDA);
+
+			iface->state = state_read;
+		} else {
+			smb_outb(iface->address_byte, SMBSDA);
+
+			iface->state = state_write;
+		}
+		break;
+
+	case state_read:
+		/* Set ACK if receiving the last byte */
+		if (iface->len == 1)
+			smb_outb(smb_inb(SMBCTL1) | SMBCTL1_ACK, SMBCTL1);
+		else
+			smb_outb(smb_inb(SMBCTL1) & ~SMBCTL1_ACK, SMBCTL1);
+
+		*iface->ptr++ = smb_inb(SMBSDA);
+		--iface->len;
+
+		if (iface->len == 0) {
+			iface->result = 0;
+			iface->state = state_idle;
+			smb_outb(smb_inb(SMBCTL1) | SMBCTL1_STOP, SMBCTL1);
+		}
+
+		break;
+
+	case state_write:
+		if (iface->len == 0) {
+			iface->result = 0;
+			iface->state = state_idle;
+			smb_outb(smb_inb(SMBCTL1) | SMBCTL1_STOP, SMBCTL1);
+			break;
+		}
+
+		smb_outb(*iface->ptr++, SMBSDA);
+		--iface->len;
+
+		break;
+	}
+
+	return;
+
+error:
+	dev_err(&iface->adapter.dev, "%s in state %s\n", errmsg,
+		cs5535_smb_state_name[iface->state]);
+
+	iface->state = state_idle;
+	iface->result = -EIO;
+	iface->needs_reset = 1;
+}
+
+static void cs5535_smb_timeout(struct cs5535_smb_iface *iface)
+{
+	dev_err(&iface->adapter.dev, "timeout in state %s\n",
+		cs5535_smb_state_name[iface->state]);
+
+	iface->state = state_idle;
+	iface->result = -EIO;
+	iface->needs_reset = 1;
+}
+
+static void cs5535_smb_poll(struct cs5535_smb_iface *iface)
+{
+	u8 status = 0;
+	unsigned long timeout;
+
+	timeout = jiffies + POLL_TIMEOUT;
+	while (time_before(jiffies, timeout)) {
+
+		/* The i2c bus takes 9us per bit, 10 bits per transaction.
+		 * This amounts to ~100us per char. Since that time is quite
+		 * small and we can wait longer, we'll just yield.
+		 */
+		yield();
+
+		status = smb_inb(SMBST);
+		if ((status & (SMBST_SDAST | SMBST_BER | SMBST_NEGACK)) != 0) {
+			cs5535_smb_machine(iface, status);
+			return;
+		}
+	}
+
+	cs5535_smb_timeout(iface);
+}
+
+static void cs5535_smb_reset(struct cs5535_smb_iface *iface)
+{
+	/* Disable the ACCESS.bus device and Configure the SCL
+	 * frequency: 16 clock cycles */
+
+	smb_outb(0x70, SMBCTL2); /* clock time is 4.7 us */
+	/* interrupt mode */
+	smb_outb(SMBCTL1_INTEN, SMBCTL1);
+	/* Disable slave address */
+	smb_outb(0, SMBADDR);
+	/* Enable the ACCESS.bus device */
+	smb_outb(smb_inb(SMBCTL2) | SMBCTL2_ENABLE, SMBCTL2);
+	/* Free STALL after START */
+	smb_outb(smb_inb(SMBCTL1) & ~(SMBCTL1_STASTRE | SMBCTL1_NMINTE), SMBCTL1);
+	/* Send a STOP */
+	smb_outb(smb_inb(SMBCTL1) | SMBCTL1_STOP, SMBCTL1);
+	/* Clear BER, NEGACK and STASTR bits */
+	smb_outb(SMBST_BER | SMBST_NEGACK | SMBST_STASTR, SMBST);
+	smb_outb(0, SMBST); /* Status Reg bug workaround */
+
+	/* Clear BB bit */
+	smb_outb(smb_inb(SMBCST) | SMBCST_BB, SMBCST);
+}
+
+static s32 cs5535_smb_smbus_xfer(struct i2c_adapter *adapter,
+				 u16 address, unsigned short flags,
+				 char rw, u8 command, int size,
+				 union i2c_smbus_data *data)
+{
+	struct cs5535_smb_iface *iface = i2c_get_adapdata(adapter);
+	int len;
+	u8 *buffer;
+	u16 cur_word;
+	int rc;
+
+	switch (size) {
+	case I2C_SMBUS_QUICK:
+		len = 0;
+		buffer = NULL;
+		break;
+
+	case I2C_SMBUS_BYTE:
+		if (rw == I2C_SMBUS_READ) {
+			len = 1;
+			buffer = &data->byte;
+		} else {
+			len = 1;
+			buffer = &command;
+		}
+		break;
+
+	case I2C_SMBUS_BYTE_DATA:
+		len = 1;
+		buffer = &data->byte;
+		break;
+
+	case I2C_SMBUS_WORD_DATA:
+		len = 2;
+		cur_word = cpu_to_le16(data->word);
+		buffer = (u8 *)&cur_word;
+		break;
+
+	case I2C_SMBUS_BLOCK_DATA:
+		len = data->block[0];
+		buffer = &data->block[1];
+		break;
+
+	default:
+		return -EINVAL;
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
+	iface->address_byte = address << 1;
+	if (rw == I2C_SMBUS_READ)
+		iface->address_byte |= 1;
+	iface->command = command;
+	iface->ptr = buffer;
+	iface->len = len;
+	iface->result = -EINVAL;
+	iface->needs_reset = 0;
+
+	smb_outb(smb_inb(SMBCTL1) | SMBCTL1_START, SMBCTL1);
+
+	if (size == I2C_SMBUS_QUICK || size == I2C_SMBUS_BYTE)
+		iface->state = state_quick;
+	else
+		iface->state = state_address;
+
+	while (iface->state != state_idle)
+		cs5535_smb_poll(iface);
+
+	if (iface->needs_reset)
+		cs5535_smb_reset(iface);
+
+	rc = iface->result;
+
+	up(&iface->sem);
+
+	if (rc == 0 && size == I2C_SMBUS_WORD_DATA && rw == I2C_SMBUS_READ)
+		data->word = le16_to_cpu(cur_word);
+
+#ifdef DEBUG
+	DBG(": transfer done, result: %d", rc);
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
+static u32 cs5535_smb_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
+	       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
+	       I2C_FUNC_SMBUS_BLOCK_DATA;
+}
+
+static struct i2c_algorithm cs5535_smb_algorithm = {
+	.smbus_xfer	= cs5535_smb_smbus_xfer,
+	.functionality	= cs5535_smb_func,
+};
+static struct cs5535_smb_iface *cs5535_iface;
+
+static int cs5535_smb_probe(struct cs5535_smb_iface *iface)
+{
+	u8 val;
+
+	cs5535_smb_reset(iface);
+
+	/* Disable the ACCESS.bus device and Configure the SCL
+	 * frequency: 16 clock cycles */
+	smb_outb(0x70, SMBCTL2);
+	if (smb_inb(SMBCTL2) != 0x70) {
+		DBG("SMBCTL2 readback failed\n");
+		return -ENXIO;
+	}
+
+	smb_outb(smb_inb(SMBCTL1) | SMBCTL1_NMINTE, SMBCTL1);
+
+	val = smb_inb(SMBCTL1);
+	if (val) {
+		DBG("disabled, but SMBCTL1=0x%02x\n", val);
+		return -ENXIO;
+	}
+
+	smb_outb(smb_inb(SMBCTL2) | SMBCTL2_ENABLE, SMBCTL2);
+
+	smb_outb(smb_inb(SMBCTL1) | SMBCTL1_NMINTE, SMBCTL1);
+
+	val = smb_inb(SMBCTL1);
+	if ((val & SMBCTL1_NMINTE) != SMBCTL1_NMINTE) {
+		DBG("enabled, but NMINTE won't be set, SMBCTL1=0x%02x\n", val);
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static int __init cs5535_smb_create(int base, int index)
+{
+	struct cs5535_smb_iface *iface;
+	struct i2c_adapter *adapter;
+	int rc = 0;
+
+	iface = kzalloc(sizeof(*iface), GFP_KERNEL);
+	if (!iface) {
+		printk(KERN_ERR NAME ": can't allocate memory\n");
+		rc = -ENOMEM;
+		goto errout;
+	}
+
+	adapter = &iface->adapter;
+	i2c_set_adapdata(adapter, iface);
+	snprintf(adapter->name, I2C_NAME_SIZE, "CS5535 SMB%d", index);
+	adapter->owner = THIS_MODULE;
+	adapter->id = I2C_HW_SMBUS_CS5535;
+	adapter->algo = &cs5535_smb_algorithm;
+	adapter->class = I2C_CLASS_HWMON;
+
+	init_MUTEX(&iface->sem);
+
+	iface->base = base;
+	if (request_region(iface->base, SMB_IO_SIZE, adapter->name) == 0) {
+		printk(KERN_ERR NAME ": request_region(%d) failed\n",
+		       iface->base);
+		rc = -EBUSY;
+		goto errout;
+	}
+
+	rc = cs5535_smb_probe(iface);
+	if (rc) {
+		dev_warn(&adapter->dev, "probe failed\n");
+		goto errout;
+	}
+
+	cs5535_smb_reset(iface);
+
+	if (i2c_add_adapter(adapter) < 0) {
+		dev_err(&adapter->dev, "failed to register\n");
+		rc = -ENODEV;
+		goto errout;
+	}
+
+	cs5535_iface = iface;
+
+	return 0;
+
+errout:
+	if (iface) {
+		if (iface->base)
+			release_region(iface->base, SMB_IO_SIZE);
+		kfree(iface);
+	}
+	return rc;
+}
+
+static int __init cs5535_smb_init(void)
+{
+	u32 low32, high32;
+	u32 smb_base;
+
+	pr_debug(NAME ": AMD CS5535 SMB Driver\n");
+
+	if (cs5535_gpio_base == 0) {
+		printk(KERN_WARNING NAME ": CS5535 GPIO not present\n");
+		return -ENODEV;
+	}
+
+	/* Grab & reserve the SMB I/O range */
+	rdmsr(MSR_LBAR_SMB, low32, high32);
+
+	/* Check the mask and whether SMB is enabled */
+	if (high32 != 0x0000F001) {
+		/* TODO: enable SMB IO mappings via LBAR? */
+		printk(KERN_WARNING NAME ": SMBus not enabled\n");
+		return -ENODEV;
+	}
+
+	/* SMBus IO size is 8 bytes */
+	smb_base = low32 & 0x0000FFF8;
+
+	return cs5535_smb_create(smb_base, 0);
+}
+
+static void __exit cs5535_smb_cleanup(void)
+{
+	if (cs5535_iface != NULL) {
+		release_region(cs5535_iface->base, SMB_IO_SIZE);
+		i2c_del_adapter(&cs5535_iface->adapter);
+		kfree(cs5535_iface);
+	}
+}
+
+module_init(cs5535_smb_init);
+module_exit(cs5535_smb_cleanup);
+
Index: linux-2.6.14/include/linux/i2c-id.h
===================================================================
--- linux-2.6.14.orig/include/linux/i2c-id.h
+++ linux-2.6.14/include/linux/i2c-id.h
@@ -256,6 +256,7 @@
 #define I2C_HW_SMBUS_OV518	0x04000f /* OV518(+) USB 1.1 webcam ICs */
 #define I2C_HW_SMBUS_OV519	0x040010 /* OV519 USB 1.1 webcam IC */
 #define I2C_HW_SMBUS_OVFX2	0x040011 /* Cypress/OmniVision FX2 webcam */
+#define I2C_HW_SMBUS_CS5535	0x040012
 
 /* --- ISA pseudo-adapter						*/
 #define I2C_HW_ISA		0x050000

------=_Part_1984_2206685.1133976862429--
