Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVAHIzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVAHIzf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 03:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbVAHIzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 03:55:01 -0500
Received: from mail.kroah.org ([69.55.234.183]:53125 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261881AbVAHFsY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:24 -0500
Subject: Re: [PATCH] I2C patches for 2.6.10
In-Reply-To: <11051627764199@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:39:36 -0800
Message-Id: <1105162776515@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 8BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.445.9, 2004/12/21 11:08:43-08:00, sjhill@realitydiluted.com

[PATCH] I2C patch from MIPS tree...

Here is a newer i2c patch from the mainline Linux/MIPS kernel
tree. Some more changes came in since yesterday. Please apply
this for inclusion in the next Linux release. Thanks.

Signed-off-by: Steven J. Hill <sjhill@realitydiluted.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/algos/Kconfig           |   13 ++
 drivers/i2c/algos/Makefile          |    2 
 drivers/i2c/algos/i2c-algo-sgi.c    |  189 +++++++++++++++++++++++++++++
 drivers/i2c/algos/i2c-algo-sibyte.c |  231 ++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/Kconfig          |    6 
 drivers/i2c/busses/Makefile         |    1 
 drivers/i2c/busses/i2c-sibyte.c     |   71 +++++++++++
 include/linux/i2c-algo-sgi.h        |   27 ++++
 include/linux/i2c-algo-sibyte.h     |   33 +++++
 include/linux/i2c-id.h              |   11 +
 10 files changed, 584 insertions(+)


diff -Nru a/drivers/i2c/algos/Kconfig b/drivers/i2c/algos/Kconfig
--- a/drivers/i2c/algos/Kconfig	2005-01-07 14:55:20 -08:00
+++ b/drivers/i2c/algos/Kconfig	2005-01-07 14:55:20 -08:00
@@ -53,5 +53,18 @@
 	tristate "MPC8xx CPM I2C interface"
 	depends on 8xx && I2C
 
+config I2C_ALGO_SIBYTE
+	tristate "SiByte SMBus interface"
+	depends on SIBYTE_SB1xxx_SOC && I2C
+	help
+	  Supports the SiByte SOC on-chip I2C interfaces (2 channels).
+
+config I2C_ALGO_SGI
+	tristate "I2C SGI interfaces"
+	depends on I2C
+	help
+	  Supports the SGI interfaces like the ones found on SGI Indy VINO
+	  or SGI O2 MACE.
+
 endmenu
 
diff -Nru a/drivers/i2c/algos/Makefile b/drivers/i2c/algos/Makefile
--- a/drivers/i2c/algos/Makefile	2005-01-07 14:55:20 -08:00
+++ b/drivers/i2c/algos/Makefile	2005-01-07 14:55:20 -08:00
@@ -6,6 +6,8 @@
 obj-$(CONFIG_I2C_ALGOPCF)	+= i2c-algo-pcf.o
 obj-$(CONFIG_I2C_ALGOPCA)	+= i2c-algo-pca.o
 obj-$(CONFIG_I2C_ALGOITE)	+= i2c-algo-ite.o
+obj-$(CONFIG_I2C_ALGO_SIBYTE)	+= i2c-algo-sibyte.o
+obj-$(CONFIG_I2C_ALGO_SGI)	+= i2c-algo-sgi.o
 
 ifeq ($(CONFIG_I2C_DEBUG_ALGO),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/drivers/i2c/algos/i2c-algo-sgi.c b/drivers/i2c/algos/i2c-algo-sgi.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/i2c/algos/i2c-algo-sgi.c	2005-01-07 14:55:20 -08:00
@@ -0,0 +1,189 @@
+/*
+ * i2c-algo-sgi.c: i2c driver algorithms for SGI adapters.
+ * 
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License version 2 as published by the Free Software Foundation.
+ *
+ * Copyright (C) 2003 Ladislav Michl <ladis@linux-mips.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+
+#include <linux/i2c.h>
+#include <linux/i2c-algo-sgi.h>
+
+
+#define SGI_I2C_FORCE_IDLE	(0 << 0)
+#define SGI_I2C_NOT_IDLE	(1 << 0)
+#define SGI_I2C_WRITE		(0 << 1)
+#define SGI_I2C_READ		(1 << 1)
+#define SGI_I2C_RELEASE_BUS	(0 << 2)
+#define SGI_I2C_HOLD_BUS	(1 << 2)
+#define SGI_I2C_XFER_DONE	(0 << 4)
+#define SGI_I2C_XFER_BUSY	(1 << 4)
+#define SGI_I2C_ACK		(0 << 5)
+#define SGI_I2C_NACK		(1 << 5)
+#define SGI_I2C_BUS_OK		(0 << 7)
+#define SGI_I2C_BUS_ERR		(1 << 7)
+
+#define get_control()		adap->getctrl(adap->data)
+#define set_control(val)	adap->setctrl(adap->data, val)
+#define read_data()		adap->rdata(adap->data)
+#define write_data(val)		adap->wdata(adap->data, val)
+
+
+static int wait_xfer_done(struct i2c_algo_sgi_data *adap)
+{
+	int i;
+
+	for (i = 0; i < adap->xfer_timeout; i++) {
+		if ((get_control() & SGI_I2C_XFER_BUSY) == 0)
+			return 0;
+		udelay(1);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int wait_ack(struct i2c_algo_sgi_data *adap)
+{
+	int i;
+
+	if (wait_xfer_done(adap))
+		return -ETIMEDOUT;
+	for (i = 0; i < adap->ack_timeout; i++) {
+		if ((get_control() & SGI_I2C_NACK) == 0)
+			return 0;
+		udelay(1);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int force_idle(struct i2c_algo_sgi_data *adap)
+{
+	int i;
+
+	set_control(SGI_I2C_FORCE_IDLE);
+	for (i = 0; i < adap->xfer_timeout; i++) {
+		if ((get_control() & SGI_I2C_NOT_IDLE) == 0)
+			goto out;
+		udelay(1);
+	}
+	return -ETIMEDOUT;
+out:
+	if (get_control() & SGI_I2C_BUS_ERR)
+		return -EIO;
+	return 0;
+}
+
+static int do_address(struct i2c_algo_sgi_data *adap, unsigned int addr,
+		      int rd)
+{
+	if (rd)
+		set_control(SGI_I2C_NOT_IDLE);
+	/* Check if bus is idle, eventually force it to do so */
+	if (get_control() & SGI_I2C_NOT_IDLE)
+		if (force_idle(adap))
+	                return -EIO;
+	/* Write out the i2c chip address and specify operation */
+	set_control(SGI_I2C_HOLD_BUS | SGI_I2C_WRITE | SGI_I2C_NOT_IDLE);
+	if (rd)
+		addr |= 1;
+	write_data(addr);
+	if (wait_ack(adap))
+		return -EIO;
+	return 0;
+}
+
+static int i2c_read(struct i2c_algo_sgi_data *adap, unsigned char *buf,
+		    unsigned int len)
+{
+	int i;
+
+	set_control(SGI_I2C_HOLD_BUS | SGI_I2C_READ | SGI_I2C_NOT_IDLE);
+	for (i = 0; i < len; i++) {
+		if (wait_xfer_done(adap))
+			return -EIO;
+		buf[i] = read_data();
+	}
+	set_control(SGI_I2C_RELEASE_BUS | SGI_I2C_FORCE_IDLE);
+
+	return 0;
+
+}
+
+static int i2c_write(struct i2c_algo_sgi_data *adap, unsigned char *buf,
+		     unsigned int len)
+{
+	int i;
+
+	/* We are already in write state */
+	for (i = 0; i < len; i++) {
+		write_data(buf[i]);
+		if (wait_ack(adap))
+			return -EIO;
+	}
+	return 0;
+}
+
+static int sgi_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[],
+		    int num)
+{
+	struct i2c_algo_sgi_data *adap = i2c_adap->algo_data;
+	struct i2c_msg *p;
+	int i, err = 0;
+
+	for (i = 0; !err && i < num; i++) {
+		p = &msgs[i];
+		err = do_address(adap, p->addr, p->flags & I2C_M_RD);
+		if (err || !p->len)
+			continue;
+		if (p->flags & I2C_M_RD)
+			err = i2c_read(adap, p->buf, p->len);
+		else
+			err = i2c_write(adap, p->buf, p->len);
+	}
+
+	return err;
+}
+
+static u32 sgi_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_SMBUS_EMUL;
+}
+
+static struct i2c_algorithm sgi_algo = {
+	.name		= "SGI algorithm",
+	.id		= I2C_ALGO_SGI,
+	.master_xfer	= sgi_xfer,
+	.functionality	= sgi_func,
+};
+
+/* 
+ * registering functions to load algorithms at runtime 
+ */
+int i2c_sgi_add_bus(struct i2c_adapter *adap)
+{
+	adap->id |= sgi_algo.id;
+	adap->algo = &sgi_algo;
+
+	return i2c_add_adapter(adap);
+}
+
+
+int i2c_sgi_del_bus(struct i2c_adapter *adap)
+{
+	return i2c_del_adapter(adap);
+}
+
+EXPORT_SYMBOL(i2c_sgi_add_bus);
+EXPORT_SYMBOL(i2c_sgi_del_bus);
+
+MODULE_AUTHOR("Ladislav Michl <ladis@linux-mips.org>");
+MODULE_DESCRIPTION("I2C-Bus SGI algorithm");
+MODULE_LICENSE("GPL");
diff -Nru a/drivers/i2c/algos/i2c-algo-sibyte.c b/drivers/i2c/algos/i2c-algo-sibyte.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/i2c/algos/i2c-algo-sibyte.c	2005-01-07 14:55:20 -08:00
@@ -0,0 +1,231 @@
+/* ------------------------------------------------------------------------- */
+/* i2c-algo-sibyte.c i2c driver algorithms for bit-shift adapters		     */
+/* ------------------------------------------------------------------------- */
+/*   Copyright (C) 2001,2002,2003 Broadcom Corporation
+     Copyright (C) 1995-2000 Simon G. Vogl
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     */
+/* ------------------------------------------------------------------------- */
+
+/* With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi> and even
+   Frodo Looijaard <frodol@dds.nl>.  */
+
+/* Ported for SiByte SOCs by Broadcom Corporation.  */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+
+#include <asm/io.h>
+#include <asm/sibyte/sb1250_regs.h>
+#include <asm/sibyte/sb1250_smbus.h>
+
+#include <linux/i2c.h>
+#include <linux/i2c-algo-sibyte.h>
+
+/* ----- global defines ----------------------------------------------- */
+#define SMB_CSR(a,r) ((long)(a->reg_base + r))
+
+/* ----- global variables ---------------------------------------------	*/
+
+/* module parameters:
+ */
+static int bit_scan=0;	/* have a look at what's hanging 'round		*/
+
+
+static int smbus_xfer(struct i2c_adapter *i2c_adap, u16 addr, 
+                      unsigned short flags, char read_write,
+                      u8 command, int size, union i2c_smbus_data * data)
+{
+	struct i2c_algo_sibyte_data *adap = i2c_adap->algo_data;
+        int data_bytes = 0;
+        int error;
+
+        while (csr_in32(SMB_CSR(adap, R_SMB_STATUS)) & M_SMB_BUSY)
+                ;
+
+        switch (size) {
+        case I2C_SMBUS_QUICK:
+                csr_out32((V_SMB_ADDR(addr) | (read_write == I2C_SMBUS_READ ? M_SMB_QDATA : 0) |
+			   V_SMB_TT_QUICKCMD), SMB_CSR(adap, R_SMB_START));
+                break;
+        case I2C_SMBUS_BYTE:
+                if (read_write == I2C_SMBUS_READ) {
+                        csr_out32((V_SMB_ADDR(addr) | V_SMB_TT_RD1BYTE),
+				  SMB_CSR(adap, R_SMB_START));
+                        data_bytes = 1;
+                } else {
+                        csr_out32(V_SMB_CMD(command), SMB_CSR(adap, R_SMB_CMD));
+                        csr_out32((V_SMB_ADDR(addr) | V_SMB_TT_WR1BYTE),
+				  SMB_CSR(adap, R_SMB_START));
+                }
+                break;
+        case I2C_SMBUS_BYTE_DATA:
+                csr_out32(V_SMB_CMD(command), SMB_CSR(adap, R_SMB_CMD));
+                if (read_write == I2C_SMBUS_READ) {
+                        csr_out32((V_SMB_ADDR(addr) | V_SMB_TT_CMD_RD1BYTE),
+				  SMB_CSR(adap, R_SMB_START));
+                        data_bytes = 1;
+                } else {
+                        csr_out32(V_SMB_LB(data->byte), SMB_CSR(adap, R_SMB_DATA));
+                        csr_out32((V_SMB_ADDR(addr) | V_SMB_TT_WR2BYTE),
+				  SMB_CSR(adap, R_SMB_START));
+                }
+                break;
+        case I2C_SMBUS_WORD_DATA:
+                csr_out32(V_SMB_CMD(command), SMB_CSR(adap, R_SMB_CMD));
+                if (read_write == I2C_SMBUS_READ) {
+                        csr_out32((V_SMB_ADDR(addr) | V_SMB_TT_CMD_RD2BYTE),
+				  SMB_CSR(adap, R_SMB_START));
+                        data_bytes = 2;
+                } else {
+                        csr_out32(V_SMB_LB(data->word & 0xff), SMB_CSR(adap, R_SMB_DATA));
+                        csr_out32(V_SMB_MB(data->word >> 8), SMB_CSR(adap, R_SMB_DATA));
+                        csr_out32((V_SMB_ADDR(addr) | V_SMB_TT_WR2BYTE),
+				  SMB_CSR(adap, R_SMB_START));
+                }
+                break;
+        default:
+                return -1;      /* XXXKW better error code? */
+        }
+
+        while (csr_in32(SMB_CSR(adap, R_SMB_STATUS)) & M_SMB_BUSY)
+                ;
+
+        error = csr_in32(SMB_CSR(adap, R_SMB_STATUS));
+        if (error & M_SMB_ERROR) {
+                /* Clear error bit by writing a 1 */
+                csr_out32(M_SMB_ERROR, SMB_CSR(adap, R_SMB_STATUS));
+                return -1;      /* XXXKW better error code? */
+        }
+
+        if (data_bytes == 1)
+                data->byte = csr_in32(SMB_CSR(adap, R_SMB_DATA)) & 0xff;
+        if (data_bytes == 2)
+                data->word = csr_in32(SMB_CSR(adap, R_SMB_DATA)) & 0xffff;
+
+        return 0;
+}
+
+static int algo_control(struct i2c_adapter *adapter, 
+	unsigned int cmd, unsigned long arg)
+{
+	return 0;
+}
+
+static u32 bit_func(struct i2c_adapter *adap)
+{
+	return (I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
+                I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA);
+}
+
+
+/* -----exported algorithm data: -------------------------------------	*/
+
+static struct i2c_algorithm i2c_sibyte_algo = {
+	"SiByte algorithm",
+	I2C_ALGO_SIBYTE,
+	NULL,                           /* master_xfer          */
+	smbus_xfer,                   	/* smbus_xfer           */
+	NULL,				/* slave_xmit		*/
+	NULL,				/* slave_recv		*/
+	algo_control,			/* ioctl		*/
+	bit_func,			/* functionality	*/
+};
+
+/* 
+ * registering functions to load algorithms at runtime 
+ */
+int i2c_sibyte_add_bus(struct i2c_adapter *i2c_adap, int speed)
+{
+	int i;
+	struct i2c_algo_sibyte_data *adap = i2c_adap->algo_data;
+
+	/* register new adapter to i2c module... */
+
+	i2c_adap->id |= i2c_sibyte_algo.id;
+	i2c_adap->algo = &i2c_sibyte_algo;
+        
+        /* Set the frequency to 100 kHz */
+        csr_out32(speed, SMB_CSR(adap,R_SMB_FREQ));
+        csr_out32(0, SMB_CSR(adap,R_SMB_CONTROL));
+
+	/* scan bus */
+	if (bit_scan) {
+                union i2c_smbus_data data;
+                int rc;
+		printk(KERN_INFO " i2c-algo-sibyte.o: scanning bus %s.\n",
+		       i2c_adap->name);
+		for (i = 0x00; i < 0x7f; i++) {
+                        /* XXXKW is this a realistic probe? */
+                        rc = smbus_xfer(i2c_adap, i, 0, I2C_SMBUS_READ, 0,
+                                        I2C_SMBUS_BYTE_DATA, &data);
+			if (!rc) {
+				printk("(%02x)",i); 
+			} else 
+				printk("."); 
+		}
+		printk("\n");
+	}
+
+#ifdef MODULE
+	MOD_INC_USE_COUNT;
+#endif
+	i2c_add_adapter(i2c_adap);
+
+	return 0;
+}
+
+
+int i2c_sibyte_del_bus(struct i2c_adapter *adap)
+{
+	int res;
+
+	if ((res = i2c_del_adapter(adap)) < 0)
+		return res;
+
+#ifdef MODULE
+	MOD_DEC_USE_COUNT;
+#endif
+	return 0;
+}
+
+int __init i2c_algo_sibyte_init (void)
+{
+	printk("i2c-algo-sibyte.o: i2c SiByte algorithm module\n");
+	return 0;
+}
+
+
+EXPORT_SYMBOL(i2c_sibyte_add_bus);
+EXPORT_SYMBOL(i2c_sibyte_del_bus);
+
+#ifdef MODULE
+MODULE_AUTHOR("Kip Walker, Broadcom Corp.");
+MODULE_DESCRIPTION("SiByte I2C-Bus algorithm");
+MODULE_PARM(bit_scan, "i");
+MODULE_PARM_DESC(bit_scan, "Scan for active chips on the bus");
+MODULE_LICENSE("GPL");
+
+int init_module(void) 
+{
+	return i2c_algo_sibyte_init();
+}
+
+void cleanup_module(void) 
+{
+}
+#endif
diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	2005-01-07 14:55:20 -08:00
+++ b/drivers/i2c/busses/Kconfig	2005-01-07 14:55:20 -08:00
@@ -323,6 +323,12 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-savage4.
 
+config I2C_SIBYTE
+	tristate "SiByte SMBus interface"
+	depends on SIBYTE_SB1xxx_SOC && I2C
+	help
+	  Supports the SiByte SOC on-chip I2C interfaces (2 channels).
+
 config SCx200_I2C
 	tristate "NatSemi SCx200 I2C using GPIO pins"
 	depends on SCx200_GPIO && I2C
diff -Nru a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
--- a/drivers/i2c/busses/Makefile	2005-01-07 14:55:20 -08:00
+++ b/drivers/i2c/busses/Makefile	2005-01-07 14:55:20 -08:00
@@ -29,6 +29,7 @@
 obj-$(CONFIG_I2C_RPXLITE)	+= i2c-rpx.o
 obj-$(CONFIG_I2C_S3C2410)	+= i2c-s3c2410.o
 obj-$(CONFIG_I2C_SAVAGE4)	+= i2c-savage4.o
+obj-$(CONFIG_I2C_SIBYTE)	+= i2c-sibyte.o
 obj-$(CONFIG_I2C_SIS5595)	+= i2c-sis5595.o
 obj-$(CONFIG_I2C_SIS630)	+= i2c-sis630.o
 obj-$(CONFIG_I2C_SIS96X)	+= i2c-sis96x.o
diff -Nru a/drivers/i2c/busses/i2c-sibyte.c b/drivers/i2c/busses/i2c-sibyte.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/i2c/busses/i2c-sibyte.c	2005-01-07 14:55:20 -08:00
@@ -0,0 +1,71 @@
+/*
+ * Copyright (C) 2004 Steven J. Hill
+ * Copyright (C) 2001,2002,2003 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/i2c-algo-sibyte.h>
+#include <asm/sibyte/sb1250_regs.h>
+#include <asm/sibyte/sb1250_smbus.h>
+
+static struct i2c_algo_sibyte_data sibyte_board_data[2] = {
+	{ NULL, 0, (void *) (KSEG1+A_SMB_BASE(0)) },
+	{ NULL, 1, (void *) (KSEG1+A_SMB_BASE(1)) }
+};
+
+static struct i2c_adapter sibyte_board_adapter[2] = {
+	{
+		.owner		= THIS_MODULE,
+		.id		= I2C_HW_SIBYTE,
+		.class		= I2C_CLASS_HWMON,
+		.algo		= NULL,
+		.algo_data	= &sibyte_board_data[0],
+		.name		= "SiByte SMBus 0",
+	},
+	{
+		.owner		= THIS_MODULE,
+		.id		= I2C_HW_SIBYTE,
+		.class		= I2C_CLASS_HWMON,
+		.algo		= NULL,
+		.algo_data	= &sibyte_board_data[1],
+		.name		= "SiByte SMBus 1",
+	},
+};
+
+static int __init i2c_sibyte_init(void)
+{
+	printk("i2c-swarm.o: i2c SMBus adapter module for SiByte board\n");
+	if (i2c_sibyte_add_bus(&sibyte_board_adapter[0], K_SMB_FREQ_100KHZ) < 0)
+		return -ENODEV;
+	if (i2c_sibyte_add_bus(&sibyte_board_adapter[1], K_SMB_FREQ_400KHZ) < 0)
+		return -ENODEV;
+	return 0;
+}
+
+static void __exit i2c_sibyte_exit(void)
+{
+	i2c_sibyte_del_bus(&sibyte_board_adapter[0]);
+	i2c_sibyte_del_bus(&sibyte_board_adapter[1]);
+}
+
+module_init(i2c_sibyte_init);
+module_exit(i2c_sibyte_exit);
+
+MODULE_AUTHOR("Kip Walker <kwalker@broadcom.com>, Steven J. Hill <sjhill@realitydiluted.com>");
+MODULE_DESCRIPTION("SMBus adapter routines for SiByte boards");
+MODULE_LICENSE("GPL");
diff -Nru a/include/linux/i2c-algo-sgi.h b/include/linux/i2c-algo-sgi.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/linux/i2c-algo-sgi.h	2005-01-07 14:55:20 -08:00
@@ -0,0 +1,27 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License version 2 as published by the Free Software Foundation.
+ *
+ * Copyright (C) 2003 Ladislav Michl <ladis@linux-mips.org>
+ */
+
+#ifndef I2C_ALGO_SGI_H
+#define I2C_ALGO_SGI_H 1
+
+#include <linux/i2c.h>
+
+struct i2c_algo_sgi_data {
+	void *data;	/* private data for lowlevel routines */
+	unsigned (*getctrl)(void *data);
+	void (*setctrl)(void *data, unsigned val);
+	unsigned (*rdata)(void *data);
+	void (*wdata)(void *data, unsigned val);
+
+	int xfer_timeout;
+	int ack_timeout;
+};
+
+int i2c_sgi_add_bus(struct i2c_adapter *);
+int i2c_sgi_del_bus(struct i2c_adapter *);
+
+#endif /* I2C_ALGO_SGI_H */
diff -Nru a/include/linux/i2c-algo-sibyte.h b/include/linux/i2c-algo-sibyte.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/linux/i2c-algo-sibyte.h	2005-01-07 14:55:20 -08:00
@@ -0,0 +1,33 @@
+/*
+ * Copyright (C) 2001,2002,2003 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#ifndef I2C_ALGO_SIBYTE_H
+#define I2C_ALGO_SIBYTE_H 1
+
+#include <linux/i2c.h>
+
+struct i2c_algo_sibyte_data {
+	void *data;		/* private data */
+        int   bus;		/* which bus */
+        void *reg_base;		/* CSR base */
+};
+
+int i2c_sibyte_add_bus(struct i2c_adapter *, int speed);
+int i2c_sibyte_del_bus(struct i2c_adapter *);
+
+#endif /* I2C_ALGO_SIBYTE_H */
diff -Nru a/include/linux/i2c-id.h b/include/linux/i2c-id.h
--- a/include/linux/i2c-id.h	2005-01-07 14:55:20 -08:00
+++ b/include/linux/i2c-id.h	2005-01-07 14:55:20 -08:00
@@ -109,6 +109,7 @@
 #define I2C_DRIVERID_OVCAMCHIP	61	/* OmniVision CMOS image sens.	*/
 #define I2C_DRIVERID_TDA7313	62	/* TDA7313 audio processor	*/
 #define I2C_DRIVERID_MAX6900	63	/* MAX6900 real-time clock	*/
+#define I2C_DRIVERID_SAA7114H	64	/* video decoder		*/
 
 
 #define I2C_DRIVERID_EXP0	0xF0	/* experimental use id's	*/
@@ -196,6 +197,9 @@
 #define I2C_ALGO_OCP_IOP3XX  0x140000	/* XSCALE IOP3XX On-chip I2C alg */
 #define I2C_ALGO_PCA	0x150000	/* PCA 9564 style adapters	*/
 
+#define I2C_ALGO_SIBYTE 0x150000	/* Broadcom SiByte SOCs		*/
+#define I2C_ALGO_SGI	0x160000        /* SGI algorithm                */
+
 #define I2C_ALGO_EXP	0x800000	/* experimental			*/
 
 #define I2C_ALGO_MASK	0xff0000	/* Mask for algorithms		*/
@@ -257,6 +261,13 @@
 
 /* --- PowerPC on-chip adapters						*/
 #define I2C_HW_OCP 0x00	/* IBM on-chip I2C adapter 	*/
+
+/* --- Broadcom SiByte adapters						*/
+#define I2C_HW_SIBYTE	0x00
+
+/* --- SGI adapters							*/
+#define I2C_HW_SGI_VINO	0x00
+#define I2C_HW_SGI_MACE	0x01
 
 /* --- XSCALE on-chip adapters                          */
 #define I2C_HW_IOP321 0x00

