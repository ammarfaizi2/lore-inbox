Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266585AbUHWSwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266585AbUHWSwN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 14:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266752AbUHWSug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:50:36 -0400
Received: from mail.kroah.org ([69.55.234.183]:17348 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267340AbUHWShO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:37:14 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860903581@kroah.com>
Date: Mon, 23 Aug 2004 11:34:51 -0700
Message-Id: <1093286090295@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.59.9, 2004/08/05 16:46:18-07:00, icampbell@arcom.com

[PATCH] I2C: algorithm and bus driver for PCA9564

Attached is a driver for the PCA9564 "Parallel to I2C" chip, it is
similar in principle to the PCF8584 which is supported by the
i2c-algo-pcf and i2c-elektor code, however it's not code compatible in
any way: http://www.semiconductors.philips.com/pip/PCA9564PW.html

The patch contains the PCA algorithm driver and a bus driver for an ISA
card. It only supports master send and receive but I'm not sure that the
Linux i2c stack supports client side operation anyhow, and I have no
hardware to test on.

It was tested on a PC104 card containing the PCA chip and an Atmel TPM
device and also on a separate PC104 card with a DS1307 RTC hotwired onto
it for testing purposes.

The driver is against a 2.6 BK tree pulled on Friday. I also have a
fairly trivial 2.4 backport if that is of interest.

From: Ian Campbell <icampbell@arcom.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/algos/Kconfig        |   11 +
 drivers/i2c/algos/Makefile       |    1 
 drivers/i2c/algos/i2c-algo-pca.c |  395 +++++++++++++++++++++++++++++++++++++++
 drivers/i2c/algos/i2c-algo-pca.h |   26 ++
 drivers/i2c/busses/Kconfig       |   11 +
 drivers/i2c/busses/Makefile      |    1 
 drivers/i2c/busses/i2c-pca-isa.c |  184 ++++++++++++++++++
 include/linux/i2c-algo-pca.h     |   17 +
 include/linux/i2c-id.h           |    4 
 9 files changed, 650 insertions(+)


diff -Nru a/drivers/i2c/algos/Kconfig b/drivers/i2c/algos/Kconfig
--- a/drivers/i2c/algos/Kconfig	2004-08-23 11:04:47 -07:00
+++ b/drivers/i2c/algos/Kconfig	2004-08-23 11:04:47 -07:00
@@ -27,6 +27,17 @@
 	  This support is also available as a module.  If so, the module 
 	  will be called i2c-algo-pcf.
 
+config I2C_ALGOPCA
+	tristate "I2C PCA 9564 interfaces"
+	depends on I2C
+	help
+	  This allows you to use a range of I2C adapters called PCA adapters.
+	  Say Y if you own an I2C adapter belonging to this class and then say
+	  Y to the specific driver for you adapter below.
+
+	  This support is also available as a module.  If so, the module 
+	  will be called i2c-algo-pca.
+
 config I2C_ALGOITE
 	tristate "ITE I2C Algorithm"
 	depends on MIPS_ITE8172 && I2C
diff -Nru a/drivers/i2c/algos/Makefile b/drivers/i2c/algos/Makefile
--- a/drivers/i2c/algos/Makefile	2004-08-23 11:04:47 -07:00
+++ b/drivers/i2c/algos/Makefile	2004-08-23 11:04:47 -07:00
@@ -4,6 +4,7 @@
 
 obj-$(CONFIG_I2C_ALGOBIT)	+= i2c-algo-bit.o
 obj-$(CONFIG_I2C_ALGOPCF)	+= i2c-algo-pcf.o
+obj-$(CONFIG_I2C_ALGOPCA)	+= i2c-algo-pca.o
 obj-$(CONFIG_I2C_ALGOITE)	+= i2c-algo-ite.o
 
 ifeq ($(CONFIG_I2C_DEBUG_ALGO),y)
diff -Nru a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-pca.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/i2c/algos/i2c-algo-pca.c	2004-08-23 11:04:47 -07:00
@@ -0,0 +1,395 @@
+/*
+ *  i2c-algo-pca.c i2c driver algorithms for PCA9564 adapters                
+ *    Copyright (C) 2004 Arcom Control Systems
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-pca.h>
+#include "i2c-algo-pca.h"
+
+#define DRIVER "i2c-algo-pca"
+
+#define DEB1(fmt, args...) do { if (i2c_debug>=1) printk(fmt, ## args); } while(0)
+#define DEB2(fmt, args...) do { if (i2c_debug>=2) printk(fmt, ## args); } while(0)
+#define DEB3(fmt, args...) do { if (i2c_debug>=3) printk(fmt, ## args); } while(0)
+
+static int i2c_debug=0;
+
+#define pca_outw(adap, reg, val) adap->write_byte(adap, reg, val)
+#define pca_inw(adap, reg) adap->read_byte(adap, reg)
+
+#define pca_status(adap) pca_inw(adap, I2C_PCA_STA)
+#define pca_clock(adap) adap->get_clock(adap)
+#define pca_own(adap) adap->get_own(adap)
+#define pca_set_con(adap, val) pca_outw(adap, I2C_PCA_CON, val)
+#define pca_get_con(adap) pca_inw(adap, I2C_PCA_CON)
+#define pca_wait(adap) adap->wait_for_interrupt(adap)
+
+/*
+ * Generate a start condition on the i2c bus.
+ *
+ * returns after the start condition has occured
+ */
+static void pca_start(struct i2c_algo_pca_data *adap)
+{
+	int sta = pca_get_con(adap);
+	DEB2("=== START\n");
+	sta |= I2C_PCA_CON_STA;
+	sta &= ~(I2C_PCA_CON_STO|I2C_PCA_CON_SI);
+	pca_set_con(adap, sta);
+	pca_wait(adap);
+}
+
+/*
+ * Generate a repeated start condition on the i2c bus 
+ *
+ * return after the repeated start condition has occured
+ */
+static void pca_repeated_start(struct i2c_algo_pca_data *adap)
+{
+	int sta = pca_get_con(adap);
+	DEB2("=== REPEATED START\n");
+	sta |= I2C_PCA_CON_STA;
+	sta &= ~(I2C_PCA_CON_STO|I2C_PCA_CON_SI);
+	pca_set_con(adap, sta);
+	pca_wait(adap);
+}
+
+/*
+ * Generate a stop condition on the i2c bus
+ *
+ * returns after the stop condition has been generated
+ *
+ * STOPs do not generate an interrupt or set the SI flag, since the
+ * part returns the the idle state (0xf8). Hence we don't need to
+ * pca_wait here.
+ */
+static void pca_stop(struct i2c_algo_pca_data *adap)
+{
+	int sta = pca_get_con(adap);
+	DEB2("=== STOP\n");
+	sta |= I2C_PCA_CON_STO;
+	sta &= ~(I2C_PCA_CON_STA|I2C_PCA_CON_SI);
+	pca_set_con(adap, sta);
+}
+
+/*
+ * Send the slave address and R/W bit
+ *
+ * returns after the address has been sent
+ */
+static void pca_address(struct i2c_algo_pca_data *adap, 
+			struct i2c_msg *msg)
+{
+	int sta = pca_get_con(adap);
+	int addr;
+
+	addr = ( (0x7f & msg->addr) << 1 );
+	if (msg->flags & I2C_M_RD )
+		addr |= 1;
+	DEB2("=== SLAVE ADDRESS %#04x+%c=%#04x\n", 
+	     msg->addr, msg->flags & I2C_M_RD ? 'R' : 'W', addr);
+	
+	pca_outw(adap, I2C_PCA_DAT, addr);
+
+	sta &= ~(I2C_PCA_CON_STO|I2C_PCA_CON_STA|I2C_PCA_CON_SI);
+	pca_set_con(adap, sta);
+
+	pca_wait(adap);
+}
+
+/*
+ * Transmit a byte.
+ *
+ * Returns after the byte has been transmitted
+ */
+static void pca_tx_byte(struct i2c_algo_pca_data *adap, 
+			__u8 b)
+{
+	int sta = pca_get_con(adap);
+	DEB2("=== WRITE %#04x\n", b);
+	pca_outw(adap, I2C_PCA_DAT, b);
+
+	sta &= ~(I2C_PCA_CON_STO|I2C_PCA_CON_STA|I2C_PCA_CON_SI);
+	pca_set_con(adap, sta);
+
+	pca_wait(adap);
+}
+
+/*
+ * Receive a byte
+ *
+ * returns immediately.
+ */
+static void pca_rx_byte(struct i2c_algo_pca_data *adap, 
+			__u8 *b, int ack)
+{
+	*b = pca_inw(adap, I2C_PCA_DAT);
+	DEB2("=== READ %#04x %s\n", *b, ack ? "ACK" : "NACK");
+}
+
+/* 
+ * Setup ACK or NACK for next received byte and wait for it to arrive.
+ *
+ * Returns after next byte has arrived.
+ */
+static void pca_rx_ack(struct i2c_algo_pca_data *adap, 
+		       int ack)
+{
+	int sta = pca_get_con(adap);
+
+	sta &= ~(I2C_PCA_CON_STO|I2C_PCA_CON_STA|I2C_PCA_CON_SI|I2C_PCA_CON_AA);
+
+	if ( ack )
+		sta |= I2C_PCA_CON_AA;
+
+	pca_set_con(adap, sta);
+	pca_wait(adap);
+}
+
+/* 
+ * Reset the i2c bus / SIO 
+ */
+static void pca_reset(struct i2c_algo_pca_data *adap)
+{
+	/* apparently only an external reset will do it. not a lot can be done */
+	printk(KERN_ERR DRIVER ": Haven't figured out how to do a reset yet\n");
+}
+
+static int pca_xfer(struct i2c_adapter *i2c_adap,
+                    struct i2c_msg msgs[],
+                    int num)
+{
+        struct i2c_algo_pca_data *adap = i2c_adap->algo_data;
+        struct i2c_msg *msg = NULL;
+        int curmsg;
+	int numbytes = 0;
+	int state;
+
+	state = pca_status(adap);
+	if ( state != 0xF8 ) {
+		printk(KERN_ERR DRIVER ": bus is not idle. status is %#04x\n", state );
+		/* FIXME: what to do. Force stop ? */
+		return -EREMOTEIO;
+	}
+
+	DEB1("{{{ XFER %d messages\n", num);
+
+	if (i2c_debug>=2) {
+		for (curmsg = 0; curmsg < num; curmsg++) {
+			int addr, i;
+			msg = &msgs[curmsg];
+			
+			addr = (0x7f & msg->addr) ;
+		
+			if (msg->flags & I2C_M_RD )
+				printk(KERN_INFO "    [%02d] RD %d bytes from %#02x [%#02x, ...]\n", 
+				       curmsg, msg->len, addr, (addr<<1) | 1);
+			else {
+				printk(KERN_INFO "    [%02d] WR %d bytes to %#02x [%#02x%s", 
+				       curmsg, msg->len, addr, addr<<1,
+				       msg->len == 0 ? "" : ", ");
+				for(i=0; i < msg->len; i++)
+					printk("%#04x%s", msg->buf[i], i == msg->len - 1 ? "" : ", ");
+				printk("]\n");
+			}
+		}
+	}
+
+	curmsg = 0;
+	while (curmsg < num) {
+		state = pca_status(adap);
+
+		DEB3("STATE is 0x%02x\n", state);
+		msg = &msgs[curmsg];
+
+		switch (state) {
+		case 0xf8: /* On reset or stop the bus is idle */
+			pca_start(adap);
+			break;
+
+		case 0x08: /* A START condition has been transmitted */
+		case 0x10: /* A repeated start condition has been transmitted */
+			pca_address(adap, msg);
+			break;
+			
+		case 0x18: /* SLA+W has been transmitted; ACK has been received */
+		case 0x28: /* Data byte in I2CDAT has been transmitted; ACK has been received */
+			if (numbytes < msg->len) {
+				pca_tx_byte(adap, msg->buf[numbytes]);
+				numbytes++;
+				break;
+			}
+			curmsg++; numbytes = 0;
+			if (curmsg == num)
+				pca_stop(adap);
+			else
+				pca_repeated_start(adap);
+			break;
+
+		case 0x20: /* SLA+W has been transmitted; NOT ACK has been received */
+			DEB2("NOT ACK recieved after SLA+W\n");
+			pca_stop(adap);
+			return -EREMOTEIO;
+
+		case 0x40: /* SLA+R has been transmitted; ACK has been received */
+			pca_rx_ack(adap, msg->len > 1);
+			break;
+
+		case 0x50: /* Data bytes has been received; ACK has been returned */
+			if (numbytes < msg->len) {
+				pca_rx_byte(adap, &msg->buf[numbytes], 1);
+				numbytes++;
+				pca_rx_ack(adap, numbytes < msg->len - 1);
+				break;
+			} 
+			curmsg++; numbytes = 0;
+			if (curmsg == num)
+				pca_stop(adap);
+			else
+				pca_repeated_start(adap);
+			break;
+
+		case 0x48: /* SLA+R has been transmitted; NOT ACK has been received */
+			DEB2("NOT ACK received after SLA+R\n");
+			pca_stop(adap);
+			return -EREMOTEIO;
+
+		case 0x30: /* Data byte in I2CDAT has been transmitted; NOT ACK has been received */
+			DEB2("NOT ACK recieved after data byte\n");
+			return -EREMOTEIO;
+
+		case 0x38: /* Arbitration lost during SLA+W, SLA+R or data bytes */
+			DEB2("Arbitration lost\n");
+			return -EREMOTEIO;
+			
+		case 0x58: /* Data byte has been received; NOT ACK has been returned */
+			if ( numbytes == msg->len - 1 ) {
+				pca_rx_byte(adap, &msg->buf[numbytes], 0);
+				curmsg++; numbytes = 0;
+				if (curmsg == num)
+					pca_stop(adap);
+				else
+					pca_repeated_start(adap);
+			} else {
+				DEB2("NOT ACK sent after data byte received. "
+				     "Not final byte. numbytes %d. len %d\n",
+				     numbytes, msg->len);
+				pca_stop(adap);
+				return -EREMOTEIO;
+			}
+			break;
+		case 0x70: /* Bus error - SDA stuck low */
+			DEB2("BUS ERROR - SDA Stuck low\n");
+			pca_reset(adap);
+			return -EREMOTEIO;
+		case 0x90: /* Bus error - SCL stuck low */
+			DEB2("BUS ERROR - SCL Stuck low\n");
+			pca_reset(adap);
+			return -EREMOTEIO;
+		case 0x00: /* Bus error during master or slave mode due to illegal START or STOP condition */
+			DEB2("BUS ERROR - Illegal START or STOP\n");
+			pca_reset(adap);
+			return -EREMOTEIO;
+		default:
+			printk(KERN_ERR DRIVER ": unhandled SIO state 0x%02x\n", state);
+			break;
+		}
+		
+	}
+
+	DEB1(KERN_CRIT "}}} transfered %d messages. "
+	     "status is %#04x. control is %#04x\n", 
+	     num, pca_status(adap),
+	     pca_get_con(adap));
+	return curmsg;
+}
+
+static u32 pca_func(struct i2c_adapter *adap)
+{
+        return I2C_FUNC_SMBUS_EMUL;
+}
+
+static int pca_init(struct i2c_algo_pca_data *adap)
+{
+	static int freqs[] = {330,288,217,146,88,59,44,36};
+	int own, clock;
+
+	own = pca_own(adap);
+	clock = pca_clock(adap);
+	DEB1(KERN_INFO DRIVER ": own address is %#04x\n", own);
+	DEB1(KERN_INFO DRIVER ": clock freqeuncy is %dkHz\n", freqs[clock]);
+
+	pca_outw(adap, I2C_PCA_ADR, own << 1);
+
+	pca_set_con(adap, I2C_PCA_CON_ENSIO | clock);
+	udelay(500); /* 500 µs for oscilator to stabilise */
+
+	return 0;
+}
+
+static struct i2c_algorithm pca_algo = {
+	.name		= "PCA9564 algorithm",
+	.id		= I2C_ALGO_PCA,
+	.master_xfer	= pca_xfer,
+	.functionality	= pca_func,
+};
+
+/* 
+ * registering functions to load algorithms at runtime 
+ */
+int i2c_pca_add_bus(struct i2c_adapter *adap)
+{
+	struct i2c_algo_pca_data *pca_adap = adap->algo_data;
+	int rval;
+
+	/* register new adapter to i2c module... */
+
+	adap->id |= pca_algo.id;
+	adap->algo = &pca_algo;
+
+	adap->timeout = 100;		/* default values, should	*/
+	adap->retries = 3;		/* be replaced by defines	*/
+
+	rval = pca_init(pca_adap);
+
+	if (!rval)
+		i2c_add_adapter(adap);
+
+	return rval;
+}
+
+int i2c_pca_del_bus(struct i2c_adapter *adap)
+{
+	return i2c_del_adapter(adap);
+}
+
+EXPORT_SYMBOL(i2c_pca_add_bus);
+EXPORT_SYMBOL(i2c_pca_del_bus);
+
+MODULE_AUTHOR("Ian Campbell <icampbell@arcom.com>");
+MODULE_DESCRIPTION("I2C-Bus PCA9564 algorithm");
+MODULE_LICENSE("GPL");
+
+module_param(i2c_debug, int, 0);
diff -Nru a/drivers/i2c/algos/i2c-algo-pca.h b/drivers/i2c/algos/i2c-algo-pca.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/i2c/algos/i2c-algo-pca.h	2004-08-23 11:04:47 -07:00
@@ -0,0 +1,26 @@
+#ifndef I2C_PCA9564_H
+#define I2C_PCA9564_H 1
+
+#define I2C_PCA_STA		0x00 /* STATUS  Read Only  */
+#define I2C_PCA_TO		0x00 /* TIMEOUT Write Only */
+#define I2C_PCA_DAT		0x01 /* DATA    Read/Write */
+#define I2C_PCA_ADR		0x02 /* OWN ADR Read/Write */
+#define I2C_PCA_CON		0x03 /* CONTROL Read/Write */
+
+#define I2C_PCA_CON_AA		0x80 /* Assert Acknowledge */
+#define I2C_PCA_CON_ENSIO	0x40 /* Enable */
+#define I2C_PCA_CON_STA		0x20 /* Start */
+#define I2C_PCA_CON_STO		0x10 /* Stop */
+#define I2C_PCA_CON_SI		0x08 /* Serial Interrupt */
+#define I2C_PCA_CON_CR		0x07 /* Clock Rate (MASK) */
+
+#define I2C_PCA_CON_330kHz	0x00
+#define I2C_PCA_CON_288kHz	0x01
+#define I2C_PCA_CON_217kHz	0x02
+#define I2C_PCA_CON_146kHz	0x03
+#define I2C_PCA_CON_88kHz	0x04
+#define I2C_PCA_CON_59kHz	0x05
+#define I2C_PCA_CON_44kHz	0x06
+#define I2C_PCA_CON_36kHz	0x07
+
+#endif /* I2C_PCA9564_H */
diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	2004-08-23 11:04:47 -07:00
+++ b/drivers/i2c/busses/Kconfig	2004-08-23 11:04:47 -07:00
@@ -419,4 +419,15 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-voodoo3.
 
+config I2C_PCA_ISA
+	tristate "PCA9564 on an ISA bus"
+	depends on I2C
+	select I2C_ALGOPCA
+	help
+	  This driver supports ISA boards using the Philips PCA 9564
+	  Parallel bus to I2C bus controller
+	  
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-pca-isa.
+
 endmenu
diff -Nru a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
--- a/drivers/i2c/busses/Makefile	2004-08-23 11:04:47 -07:00
+++ b/drivers/i2c/busses/Makefile	2004-08-23 11:04:47 -07:00
@@ -22,6 +22,7 @@
 obj-$(CONFIG_I2C_NFORCE2)	+= i2c-nforce2.o
 obj-$(CONFIG_I2C_PARPORT)	+= i2c-parport.o
 obj-$(CONFIG_I2C_PARPORT_LIGHT)	+= i2c-parport-light.o
+obj-$(CONFIG_I2C_PCA_ISA)	+= i2c-pca-isa.o
 obj-$(CONFIG_I2C_PIIX4)		+= i2c-piix4.o
 obj-$(CONFIG_I2C_PROSAVAGE)	+= i2c-prosavage.o
 obj-$(CONFIG_I2C_RPXLITE)	+= i2c-rpx.o
diff -Nru a/drivers/i2c/busses/i2c-pca-isa.c b/drivers/i2c/busses/i2c-pca-isa.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/i2c/busses/i2c-pca-isa.c	2004-08-23 11:04:47 -07:00
@@ -0,0 +1,184 @@
+/*
+ *  i2c-pca-isa.c driver for PCA9564 on ISA boards
+ *    Copyright (C) 2004 Arcom Control Systems
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/wait.h>
+
+#include <linux/i2c.h>
+#include <linux/i2c-algo-pca.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+
+#include "../algos/i2c-algo-pca.h"
+
+#define IO_SIZE 4
+
+#undef DEBUG_IO
+//#define DEBUG_IO
+
+static unsigned long base   = 0x330;
+static int irq 	  = 10;
+
+/* Data sheet recommends 59kHz for 100kHz operation due to variation
+ * in the actual clock rate */
+static int clock  = I2C_PCA_CON_59kHz;
+
+static int own    = 0x55;
+
+static wait_queue_head_t pca_wait;
+
+static int pca_isa_getown(struct i2c_algo_pca_data *adap)
+{
+	return (own);
+}
+
+static int pca_isa_getclock(struct i2c_algo_pca_data *adap)
+{
+	return (clock);
+}
+
+static void
+pca_isa_writebyte(struct i2c_algo_pca_data *adap, int reg, int val)
+{
+#ifdef DEBUG_IO
+	static char *names[] = { "T/O", "DAT", "ADR", "CON" };
+	printk("*** write %s at %#lx <= %#04x\n", names[reg], base+reg, val);
+#endif
+	outb(val, base+reg);
+}
+
+static int
+pca_isa_readbyte(struct i2c_algo_pca_data *adap, int reg)
+{
+	int res = inb(base+reg);
+#ifdef DEBUG_IO
+	{
+		static char *names[] = { "STA", "DAT", "ADR", "CON" };	
+		printk("*** read  %s => %#04x\n", names[reg], res);
+	}
+#endif
+	return res;
+}
+
+static int pca_isa_waitforinterrupt(struct i2c_algo_pca_data *adap)
+{
+	int ret = 0;
+
+	if (irq > -1) {
+		ret = wait_event_interruptible(pca_wait,
+					       pca_isa_readbyte(adap, I2C_PCA_CON) & I2C_PCA_CON_SI);
+	} else {
+		while ((pca_isa_readbyte(adap, I2C_PCA_CON) & I2C_PCA_CON_SI) == 0) 
+			udelay(100);
+	}
+	return ret;
+}
+
+static irqreturn_t pca_handler(int this_irq, void *dev_id, struct pt_regs *regs) {
+	wake_up_interruptible(&pca_wait);
+	return IRQ_HANDLED;
+}
+
+static struct i2c_algo_pca_data pca_isa_data = {
+	.get_own		= pca_isa_getown,
+	.get_clock		= pca_isa_getclock,
+	.write_byte		= pca_isa_writebyte,
+	.read_byte		= pca_isa_readbyte,
+	.wait_for_interrupt	= pca_isa_waitforinterrupt,
+};
+
+static struct i2c_adapter pca_isa_ops = {
+	.owner          = THIS_MODULE,
+	.id		= I2C_HW_A_ISA,
+	.algo_data	= &pca_isa_data,
+	.name		= "PCA9564 ISA Adapter",
+};
+
+static int __init pca_isa_init(void)
+{
+
+	init_waitqueue_head(&pca_wait);
+
+	printk(KERN_INFO "i2c-pca-isa: i/o base %#08lx. irq %d\n", base, irq);
+
+	if (!request_region(base, IO_SIZE, "i2c-pca-isa")) {
+		printk(KERN_ERR "i2c-pca-isa: I/O address %#08lx is in use.\n", base);
+		goto out;
+	}
+
+	if (irq > -1) {
+		if (request_irq(irq, pca_handler, 0, "i2c-pca-isa", &pca_isa_ops) < 0) {
+			printk(KERN_ERR "i2c-pca-isa: Request irq%d failed\n", irq);
+			goto out_region;
+		}
+	}
+
+	if (i2c_pca_add_bus(&pca_isa_ops) < 0) {
+		printk(KERN_ERR "i2c-pca-isa: Failed to add i2c bus\n");
+		goto out_irq;
+	}
+
+	return 0;
+
+ out_irq:
+	if (irq > -1)
+		free_irq(irq, &pca_isa_ops);
+ out_region:
+	release_region(base, IO_SIZE);
+ out:
+	return -ENODEV;
+}
+
+static void pca_isa_exit(void)
+{
+	i2c_pca_del_bus(&pca_isa_ops);
+
+	if (irq > 0) {
+		disable_irq(irq);
+		free_irq(irq, &pca_isa_ops);
+	}
+	release_region(base, IO_SIZE);
+}
+
+MODULE_AUTHOR("Ian Campbell <icampbell@arcom.com>");
+MODULE_DESCRIPTION("ISA base PCA9564 driver");
+MODULE_LICENSE("GPL");
+
+module_param(base, ulong, 0);
+MODULE_PARM_DESC(base, "I/O base address");
+
+module_param(irq, int, 0);
+MODULE_PARM_DESC(irq, "IRQ");
+module_param(clock, int, 0);
+MODULE_PARM_DESC(clock, "Clock rate as described in table 1 of PCA9564 datasheet");
+
+module_param(own, int, 0); /* the driver can't do slave mode, so there's no real point in this */
+
+module_init(pca_isa_init);
+module_exit(pca_isa_exit);
diff -Nru a/include/linux/i2c-algo-pca.h b/include/linux/i2c-algo-pca.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/linux/i2c-algo-pca.h	2004-08-23 11:04:47 -07:00
@@ -0,0 +1,17 @@
+#ifndef _LINUX_I2C_ALGO_PCA_H
+#define _LINUX_I2C_ALGO_PCA_H
+
+struct i2c_algo_pca_data {
+	int  (*get_own)			(struct i2c_algo_pca_data *adap); /* Obtain own address */
+	int  (*get_clock)		(struct i2c_algo_pca_data *adap);
+	void (*write_byte)		(struct i2c_algo_pca_data *adap, int reg, int val);
+	int  (*read_byte)		(struct i2c_algo_pca_data *adap, int reg);
+	int  (*wait_for_interrupt)	(struct i2c_algo_pca_data *adap);
+};
+
+#define I2C_PCA_ADAP_MAX	16
+
+int i2c_pca_add_bus(struct i2c_adapter *);
+int i2c_pca_del_bus(struct i2c_adapter *);
+
+#endif /* _LINUX_I2C_ALGO_PCA_H */
diff -Nru a/include/linux/i2c-id.h b/include/linux/i2c-id.h
--- a/include/linux/i2c-id.h	2004-08-23 11:04:47 -07:00
+++ b/include/linux/i2c-id.h	2004-08-23 11:04:47 -07:00
@@ -194,6 +194,7 @@
 #define I2C_ALGO_OCP    0x120000	/* IBM or otherwise On-chip I2C algorithm */
 #define I2C_ALGO_BITHS	0x130000	/* enhanced bit style adapters	*/
 #define I2C_ALGO_OCP_IOP3XX  0x140000	/* XSCALE IOP3XX On-chip I2C alg */
+#define I2C_ALGO_PCA	0x150000	/* PCA 9564 style adapters	*/
 
 #define I2C_ALGO_EXP	0x800000	/* experimental			*/
 
@@ -238,6 +239,9 @@
 #define I2C_HW_P_LP	0x00	/* Parallel port interface		*/
 #define I2C_HW_P_ISA	0x01	/* generic ISA Bus inteface card	*/
 #define I2C_HW_P_ELEK	0x02	/* Elektor ISA Bus inteface card	*/
+
+/* --- PCA 9564 based algorithms */
+#define I2C_HW_A_ISA	0x00	/* generic ISA Bus interface card	*/
 
 /* --- ACPI Embedded controller algorithms                              */
 #define I2C_HW_ACPI_EC          0x00

