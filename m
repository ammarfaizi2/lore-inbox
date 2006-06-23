Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932971AbWFWJkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932971AbWFWJkO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 05:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932973AbWFWJkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 05:40:14 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:25798 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S932971AbWFWJkL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 05:40:11 -0400
Date: Fri, 23 Jun 2006 13:41:08 +0400
From: Vitaly Wool <vwool@ru.mvista.com>
To: i2c@lm-sensors.org
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] I2C bus driver for Philips ARM boards: version 2
Message-Id: <20060623134108.5d8187c3.vwool@ru.mvista.com>
X-Mailer: Sylpheed version 2.2.1 (GTK+ 2.8.13; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please find below the I2C bus driver for Philips ARM boards (Philips IP3204 I2C IP block). This I2C controller can be found on PNX010x, PNX52xx and PNX4008 Philips boards.
Any comments are still welcome. :)

 arch/arm/mach-pnx4008/Makefile     |    2
 arch/arm/mach-pnx4008/i2c.c        |  186 +++++++++
 drivers/i2c/busses/Kconfig         |   10
 drivers/i2c/busses/Makefile        |    2
 drivers/i2c/busses/i2c-pnx.c       |  761 +++++++++++++++++++++++++++++++++++++
 include/asm-arm/arch-pnx4008/i2c.h |   80 +++
 include/linux/i2c-pnx.h            |   51 ++
 7 files changed, 1091 insertions(+), 1 deletion(-)

Signed-off-by: Vitaly Wool <vitalywool@gmail.com>

Index: linux-2.6.git/drivers/i2c/busses/Kconfig
===================================================================
--- linux-2.6.git.orig/drivers/i2c/busses/Kconfig
+++ linux-2.6.git/drivers/i2c/busses/Kconfig
@@ -517,4 +517,14 @@ config I2C_MV64XXX
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-mv64xxx.
 
+config I2C_PNX
+       tristate "I2C bus support for Philips PNX targets"
+       depends on ARCH_PNX4008 && I2C
+       help
+         This driver supports the Philips IP3204 I2C IP block master and/or
+         slave controller
+
+         This driver can also be built as a module.  If so, the module
+         will be called i2c-pnx.
+
 endmenu
Index: linux-2.6.git/drivers/i2c/busses/Makefile
===================================================================
--- linux-2.6.git.orig/drivers/i2c/busses/Makefile
+++ linux-2.6.git/drivers/i2c/busses/Makefile
@@ -42,6 +42,8 @@ obj-$(CONFIG_I2C_VIAPRO)	+= i2c-viapro.o
 obj-$(CONFIG_I2C_VOODOO3)	+= i2c-voodoo3.o
 obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
 obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
+obj-$(CONFIG_I2C_PNX)		+= i2c-pnx.o
+
 
 ifeq ($(CONFIG_I2C_DEBUG_BUS),y)
 EXTRA_CFLAGS += -DDEBUG
Index: linux-2.6.git/drivers/i2c/busses/i2c-pnx.c
===================================================================
--- /dev/null
+++ linux-2.6.git/drivers/i2c/busses/i2c-pnx.c
@@ -0,0 +1,761 @@
+/*
+ * drivers/i2c/i2c-pnx.c
+ *
+ * Provides i2c support for PNX010x/PNX4008.
+ *
+ * Authors: Dennis Kovalev <dkovalev@ru.mvista.com>
+ * 	    Vitaly Wool <vwool@ru.mvista.com>
+ *
+ * 2004-2006 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/interrupt.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/miscdevice.h>
+#include <linux/timer.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <linux/completion.h>
+#include <linux/platform_device.h>
+#include <asm/hardware.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+#include <linux/i2c-pnx.h>
+#include <asm/arch/i2c.h>
+
+#define COMPLETION_COUNT	10000
+
+struct pnx_i2c {
+	int (*suspend) (struct platform_device * pdev, pm_message_t state);
+	int (*resume) (struct platform_device * pdev);
+	 u32(*calculate_input_freq) (struct platform_device * pdev);
+	int (*set_clock_run) (struct platform_device * pdev);
+	int (*set_clock_stop) (struct platform_device * pdev);
+	struct i2c_adapter *adapter;
+};
+
+char *i2c_pnx_modestr[] = {
+	"Transmit",
+	"Receive",
+	"No Data",
+};
+
+static inline void i2c_pnx_arm_timer(struct i2c_adapter *adap)
+{
+	struct i2c_pnx_algo_data *data = adap->algo_data;
+	struct timer_list *timer = &data->mif.timer;
+
+	del_timer_sync(timer);
+
+	dev_dbg(&adap->dev, "Timer armed at %lu plus %u jiffies.\n",
+		jiffies, TIMEOUT);
+
+	timer->expires = jiffies + TIMEOUT;
+	timer->data = (unsigned long)data;
+
+	add_timer(timer);
+}
+
+static inline int i2c_pnx_bus_busy(struct i2c_pnx_algo_data *adata)
+{
+	long timeout;
+
+	timeout = TIMEOUT * COMPLETION_COUNT;
+	if (timeout > 0 && (ioread32(I2C_REG_STS(adata)) & mstatus_active)) {
+		udelay(500);
+		timeout -= 500;
+	}
+
+	return (timeout <= 0) ? 1 : 0;
+}
+
+/**
+ * i2c_pnx_start - start a device
+ * @slave_addr:		slave address
+ * @adap:		pointer to adapter structure
+ *
+ * Generate a START signal in the desired mode.
+ */
+static int i2c_pnx_start(unsigned char slave_addr, struct i2c_adapter *adap)
+{
+	struct i2c_pnx_algo_data *alg_data =
+	    (struct i2c_pnx_algo_data *)adap->algo_data;
+
+	dev_dbg(&adap->dev, "%s(): addr 0x%x mode %s\n", __FUNCTION__,
+		slave_addr, i2c_pnx_modestr[alg_data->mif.mode]);
+
+	/* Check for 7 bit slave addresses only */
+	if (slave_addr & ~0x7f) {
+		printk(KERN_ERR "%s: Invalid slave address %x. "
+		       "Only 7-bit addresses are supported\n",
+		       adap->name, slave_addr);
+		return -EINVAL;
+	}
+
+	/* First, make sure bus is idle */
+	if (i2c_pnx_bus_busy(alg_data)) {
+		/* Somebody else is monopolising the bus */
+		printk(KERN_ERR "%s: Bus busy. Slave addr = %02x, "
+		       "cntrl = %x, stat = %x\n",
+		       adap->name, slave_addr,
+		       ioread32(I2C_REG_CTL(alg_data)),
+		       ioread32(I2C_REG_STS(alg_data)));
+		return -EBUSY;
+	} else if (ioread32(I2C_REG_STS(alg_data)) & mstatus_afi) {
+		/* Sorry, we lost the bus */
+		printk(KERN_ERR "%s: Arbitration failure. "
+		       "Slave addr = %02x\n", adap->name, slave_addr);
+		return -EIO;
+	}
+
+	/* OK, I2C is enabled and we have the bus. */
+	/* Clear the current TDI and AFI status flags. */
+	iowrite32(ioread32(I2C_REG_STS(alg_data)) | mstatus_tdi | mstatus_afi,
+		  I2C_REG_STS(alg_data));
+
+	dev_dbg(&adap->dev, "%s(): sending %#x\n", __FUNCTION__,
+		(slave_addr << 1) | start_bit |
+		 (alg_data->mif.mode == rcv ? rw_bit : 0));
+
+	/* Write the slave address, START bit and R/W bit */
+	iowrite32((slave_addr << 1) | start_bit |
+			(alg_data->mif.mode == rcv ? rw_bit : 0),
+		  I2C_REG_TX(alg_data));
+
+	dev_dbg(&adap->dev, "%s(): exit\n", __FUNCTION__);
+
+	return 0;
+}
+
+/**
+ * i2c_pnx_start - stop a device
+ * @adap:		pointer to I2C adapter structure
+ *
+ * Generate a STOP signal to terminate the master transaction.
+ */
+static void i2c_pnx_stop(struct i2c_adapter *adap)
+{
+	struct i2c_pnx_algo_data *alg_data = adap->algo_data;
+	int cnt = COMPLETION_COUNT;
+
+	dev_dbg(&adap->dev, "%s(): entering: stat = %04x.\n",
+		__FUNCTION__, ioread32(I2C_REG_STS(alg_data)));
+
+	/* Write a STOP bit to TX FIFO */
+	iowrite32(0x000000ff | stop_bit, I2C_REG_TX(alg_data));
+
+	/* Wait until the STOP is seen. */
+	while (ioread32(I2C_REG_STS(alg_data)) & mstatus_active && cnt--);
+
+	dev_dbg(&adap->dev, "%s(): exiting: stat = %04x.\n",
+		__FUNCTION__, ioread32(I2C_REG_STS(alg_data)));
+}
+
+/**
+ * i2c_pnx_master_xmit - transmit data to slave
+ * @adap:		pointer to I2C adapter structure
+ *
+ * Sends one byte of data to the slave
+ */
+static int i2c_pnx_master_xmit(struct i2c_adapter *adap)
+{
+	struct i2c_pnx_algo_data *alg_data = adap->algo_data;
+	u32 val;
+	int cnt = COMPLETION_COUNT;
+
+	dev_dbg(&adap->dev, "%s(): entering: stat = %04x.\n",
+		__FUNCTION__, ioread32(I2C_REG_STS(alg_data)));
+
+	if (alg_data->mif.len > 0) {
+		/* We still have somthing to talk about... */
+		val = *alg_data->mif.buf++;
+		val &= 0x000000ff;
+
+		if (alg_data->mif.len == 1) {
+			/* Last byte, issue a stop */
+			val |= stop_bit;
+		}
+
+		alg_data->mif.len--;
+		iowrite32(val, I2C_REG_TX(alg_data));
+
+		dev_dbg(&adap->dev, "%s(): xmit %#x [%d]\n", __FUNCTION__,
+			val, alg_data->mif.len + 1);
+
+		if (alg_data->mif.len == 0) {
+			/* Wait until the STOP is seen. */
+			while(ioread32(I2C_REG_STS(alg_data)) & mstatus_active
+					&& cnt--);
+			if (cnt <= 0)
+				printk(KERN_WARNING "The bus is still "
+					"active after timeout\n");
+
+			/* Disable master interrupts */
+			iowrite32(ioread32(I2C_REG_CTL(alg_data)) &
+				~(mcntrl_afie | mcntrl_naie | mcntrl_drmie),
+				  I2C_REG_CTL(alg_data));
+
+			del_timer_sync(&alg_data->mif.timer);
+
+			dev_dbg(&adap->dev, "%s(): Waking up xfer routine.\n",
+				__FUNCTION__);
+
+			complete(&alg_data->mif.complete);
+		}
+	} else /* For zero-sized transfers */ if (alg_data->mif.len == 0) {
+		i2c_pnx_stop(adap); /* Issue a stop. */
+
+		/* Disable master interrupts. */
+		iowrite32(ioread32(I2C_REG_CTL(alg_data)) &
+			~(mcntrl_afie | mcntrl_naie | mcntrl_drmie),
+			  I2C_REG_CTL(alg_data));
+
+		/* Stop timer. */
+		del_timer_sync(&alg_data->mif.timer);
+		dev_dbg(&adap->dev, "%s(): Waking up xfer routine after "
+			"zero-xfer.\n", __FUNCTION__);
+
+		complete(&alg_data->mif.complete);
+	}
+
+	dev_dbg(&adap->dev, "%s(): exiting: stat = %04x.\n",
+		__FUNCTION__, ioread32(I2C_REG_STS(alg_data)));
+
+	return 0;
+}
+
+/**
+ * i2c_pnx_master_rcv - receive data from slave
+ * @adap:		pointer to I2C adapter structure
+ *
+ * Reads one byte data from the slave
+ */
+static int i2c_pnx_master_rcv(struct i2c_adapter *adap)
+{
+	struct i2c_pnx_algo_data *alg_data = adap->algo_data;
+	unsigned int val = 0, cnt = COMPLETION_COUNT;
+	u32 ctl;
+
+	dev_dbg(&adap->dev, "%s(): entering: stat = %04x.\n",
+		__FUNCTION__, ioread32(I2C_REG_STS(alg_data)));
+
+	/* Check, whether there is already data,
+	 * or we didn't 'ask' for it yet.
+	 */
+	if (ioread32(I2C_REG_STS(alg_data)) & mstatus_rfe) {
+		dev_dbg(&adap->dev, "%s(): Write dummy data to fill "
+			"Rx-fifo...\n", __FUNCTION__);
+
+		if (alg_data->mif.len == 1) {
+			/* Last byte, do not acknowledge next rcv. */
+			val |= stop_bit;
+
+			/* Enable interrupt RFDAIE (= data in Rx-fifo.),
+			 * and disable DRMIE (= need data for Tx.)
+			 */
+			ctl = ioread32(I2C_REG_CTL(alg_data));
+			ctl |= mcntrl_rffie | mcntrl_daie;
+			ctl &= ~mcntrl_drmie;
+			iowrite32(ctl, I2C_REG_CTL(alg_data));
+		}
+
+		/* Now we'll 'ask' for data:
+		 * For each byte we want to receive, we must
+		 * write a (dummy) byte to the Tx-FIFO.
+		 */
+		iowrite32(val, I2C_REG_TX(alg_data));
+
+		return 0;
+	}
+
+	/* Handle data. */
+	if (alg_data->mif.len > 0) {
+
+		val = ioread32(I2C_REG_RX(alg_data));
+		*alg_data->mif.buf++ = (u8) (val & 0xff);
+		dev_dbg(&adap->dev, "%s(): rcv 0x%x [%d]\n", __FUNCTION__, val,
+			alg_data->mif.len);
+
+		alg_data->mif.len--;
+		if (alg_data->mif.len == 0) {
+			/* Wait until the STOP is seen. */
+			while(ioread32(I2C_REG_STS(alg_data)) & mstatus_active
+					&& cnt--);
+
+			/* Disable master interrupts */
+			ctl = ioread32(I2C_REG_CTL(alg_data));
+			ctl &= ~(mcntrl_afie | mcntrl_naie |mcntrl_rffie |
+				 mcntrl_drmie | mcntrl_daie);
+			iowrite32(ctl, I2C_REG_CTL(alg_data));
+
+			/* Kill timer. */
+			del_timer_sync(&alg_data->mif.timer);
+			complete(&alg_data->mif.complete);
+		}
+	}
+
+	dev_dbg(&adap->dev, "%s(): exiting: stat = %04x.\n",
+		__FUNCTION__, ioread32(I2C_REG_STS(alg_data)));
+
+	return 0;
+}
+
+static irqreturn_t
+i2c_pnx_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	u32 stat, ctl;
+	struct i2c_adapter *adap = dev_id;
+	struct i2c_pnx_algo_data *alg_data = adap->algo_data;
+
+	dev_dbg(&adap->dev, "%s(): mstat = %x mctrl = %x, mmode = %s\n",
+		__FUNCTION__,
+		ioread32(I2C_REG_STS(alg_data)),
+		ioread32(I2C_REG_CTL(alg_data)),
+		i2c_pnx_modestr[alg_data->mif.mode]);
+	stat = ioread32(I2C_REG_STS(alg_data));
+
+	/* let's see what kind of event this is */
+	if (stat & mstatus_afi) {
+		/* We lost arbitration in the midst of a transfer */
+		alg_data->mif.ret = -EIO;
+
+		/* Disable master interrupts. */
+		ctl = ioread32(I2C_REG_CTL(alg_data));
+		ctl &= ~(mcntrl_afie | mcntrl_naie | mcntrl_rffie |
+			 mcntrl_drmie);
+		iowrite32(ctl, I2C_REG_CTL(alg_data));
+
+		/* Stop timer, to prevent timeout. */
+		del_timer_sync(&alg_data->mif.timer);
+		complete(&alg_data->mif.complete);
+	} else if (stat & mstatus_nai) {
+		/* Slave did not acknowledge, generate a STOP */
+		dev_dbg(&adap->dev, "%s(): "
+			"Slave did not acknowledge, generating a STOP.\n",
+			__FUNCTION__);
+		i2c_pnx_stop(adap);
+
+		/* Disable master interrupts. */
+		ctl = ioread32(I2C_REG_CTL(alg_data));
+		ctl &= ~(mcntrl_afie | mcntrl_naie | mcntrl_rffie |
+			 mcntrl_drmie);
+		iowrite32(ctl, I2C_REG_CTL(alg_data));
+
+		/* Our return value. */
+		alg_data->mif.ret = -EFAULT;
+
+		/* Stop timer, to prevent timeout. */
+		del_timer_sync(&alg_data->mif.timer);
+		complete(&alg_data->mif.complete);
+	} else {
+		/* Two options:
+		 * - Master Tx needs data.
+		 * - There is data in the Rx-fifo
+		 * The latter is only the case if we have requested for data,
+		 * via a dummy write. (See 'i2c_pnx_master_rcv'.)
+		 * We therefore check, as a sanity check, whether that interrupt
+		 * has been enabled.
+		 */
+		if ((stat & mstatus_drmi) || !(stat & mstatus_rfe)) {
+			if (alg_data->mif.mode == xmit) {
+				i2c_pnx_master_xmit(adap);
+			} else if (alg_data->mif.mode == rcv) {
+				i2c_pnx_master_rcv(adap);
+			}
+		}
+	}
+
+	/* Clear TDI and AFI bits */
+	stat = ioread32(I2C_REG_STS(alg_data));
+	iowrite32(stat | mstatus_tdi | mstatus_afi, I2C_REG_STS(alg_data));
+
+	dev_dbg(&adap->dev, "%s(): exiting, stat = %x ctrl = %x.\n",
+		 __FUNCTION__, ioread32(I2C_REG_STS(alg_data)),
+		 ioread32(I2C_REG_CTL(alg_data)));
+
+	return IRQ_HANDLED;
+}
+
+static void i2c_pnx_timeout(unsigned long data)
+{
+	struct i2c_pnx_algo_data *alg_data = (struct i2c_pnx_algo_data *)data;
+	u32 ctl;
+	int cnt = COMPLETION_COUNT;
+
+	printk(KERN_ERR "Master timed out. stat = %04x, cntrl = %04x. "
+	       "Resetting master ...\n",
+	       ioread32(I2C_REG_STS(alg_data)),
+	       ioread32(I2C_REG_CTL(alg_data)));
+
+	/* Reset master and disable interrupts */
+	ctl = ioread32(I2C_REG_CTL(alg_data));
+	ctl &= ~(mcntrl_afie | mcntrl_naie | mcntrl_rffie | mcntrl_drmie);
+	iowrite32(ctl, I2C_REG_CTL(alg_data));
+
+	ctl |= mcntrl_reset;
+	iowrite32(ctl, I2C_REG_CTL(alg_data));
+	while (ioread32(I2C_REG_CTL(alg_data)) & mcntrl_reset && cnt--);
+
+	alg_data->mif.ret = -EIO;
+
+	complete(&alg_data->mif.complete);
+}
+
+/**
+ * i2c_pnx_xfer - generic transfer entry point
+ * @adap:		pointer to I2C adapter structure
+ * @msgs:		array of messages
+ * @num:		number of messages
+ *
+ * Initiates the transfer
+ */
+static int
+i2c_pnx_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
+{
+	struct i2c_msg *pmsg;
+	int rc = 0, completed = 0, i, cnt = COMPLETION_COUNT;
+	struct i2c_pnx_algo_data *alg_data = adap->algo_data;
+	u32 stat;
+
+	dev_dbg(&adap->dev, "%s(): entering: stat = %04x.\n",
+		__FUNCTION__, ioread32(I2C_REG_STS(alg_data)));
+
+	down(&alg_data->mif.sem);
+
+	/* If the bus is still active, or there is already
+	 * data in one of the fifo's, there is something wrong.
+	 * Repair this by a reset ...
+	 */
+	if (ioread32(I2C_REG_STS(alg_data)) & mstatus_active) {
+		iowrite32(ioread32(I2C_REG_CTL(alg_data)) | mcntrl_reset,
+			  I2C_REG_CTL(alg_data));
+		while(ioread32(I2C_REG_CTL(alg_data)) & mcntrl_reset && cnt--);
+	} else if (!(ioread32(I2C_REG_STS(alg_data)) & mstatus_rfe) ||
+		   !(ioread32(I2C_REG_STS(alg_data)) & mstatus_tfe)) {
+		printk(KERN_ERR "%s: FIFO's contain already data before xfer."
+		       " Reset it ...\n", adap->name);
+		iowrite32(ioread32(I2C_REG_CTL(alg_data)) | mcntrl_reset,
+			  I2C_REG_CTL(alg_data));
+		while(ioread32(I2C_REG_CTL(alg_data)) & mcntrl_reset && cnt--);
+	}
+
+	/* Process transactions in a loop. */
+	for (i = 0; rc >= 0 && i < num;) {
+		u8 addr;
+
+		pmsg = &msgs[i++];
+		addr = pmsg->addr;
+
+		if (pmsg->flags & I2C_M_TEN) {
+			printk(KERN_ERR "%s: 10 bits addr not supported!\n",
+			       adap->name);
+			rc = -EINVAL;
+			break;
+		}
+
+		/* Set up address and r/w bit */
+		if (pmsg->flags & I2C_M_REV_DIR_ADDR) {
+			addr ^= 1;
+		}
+
+		alg_data->mif.buf = pmsg->buf;
+		alg_data->mif.len = pmsg->len;
+		alg_data->mif.mode = (pmsg->flags & I2C_M_RD) ? rcv : xmit;
+		alg_data->mif.ret = 0;
+
+		dev_dbg(&adap->dev, "%s(): %s mode, %d bytes\n", __FUNCTION__,
+			i2c_pnx_modestr[alg_data->mif.mode],
+			alg_data->mif.len);
+
+		i2c_pnx_arm_timer(adap);
+
+		/* initialize the completion var */
+		init_completion(&alg_data->mif.complete);
+
+		/* Enable master interrupt */
+		iowrite32(ioread32(I2C_REG_CTL(alg_data)) | mcntrl_afie |
+				mcntrl_naie | mcntrl_drmie,
+			  I2C_REG_CTL(alg_data));
+
+		/* Put start-code and slave-address on the bus. */
+		rc = i2c_pnx_start(addr, adap);
+		if (rc < 0)
+			break;
+
+		/* Wait for completion */
+		wait_for_completion(&alg_data->mif.complete);
+
+		if (!(rc = alg_data->mif.ret))
+			completed++;
+		dev_dbg(&adap->dev, "%s(): Complete, return code = %d.\n",
+			__FUNCTION__, rc);
+
+		/* Clear TDI and AFI bits in case they are set. */
+		if ((stat = ioread32(I2C_REG_STS(alg_data))) & mstatus_tdi) {
+			printk(KERN_WARNING
+				"%s: TDI still set ... clearing now.\n",
+			       adap->name);
+			stat |= mstatus_tdi;
+			iowrite32(stat, I2C_REG_STS(alg_data));
+		}
+		if ((stat = ioread32(I2C_REG_STS(alg_data))) & mstatus_afi) {
+			printk(KERN_WARNING
+				"%s: AFI still set ... clearing now.\n",
+			       adap->name);
+			stat |= mstatus_afi;
+			iowrite32(stat, I2C_REG_STS(alg_data));
+		}
+	}
+
+	/* If the bus is still active, reset it to prevent
+	 * corruption of future transactions.
+	 */
+	if (ioread32(I2C_REG_STS(alg_data)) & mstatus_active) {
+		printk(KERN_WARNING
+			"%s: Bus is still active after xfer. Reset it ...\n",
+		       adap->name);
+		iowrite32(ioread32(I2C_REG_CTL(alg_data)) | mcntrl_reset,
+			  I2C_REG_CTL(alg_data));
+		while(ioread32(I2C_REG_CTL(alg_data)) & mcntrl_reset && cnt--);
+	} else if (!((stat = ioread32(I2C_REG_STS(alg_data))) & mstatus_rfe) ||
+		    !(stat & mstatus_tfe)) {
+		/* If there is data in the fifo's after transfer,
+		 * flush fifo's by reset.
+		 */
+		iowrite32(ioread32(I2C_REG_CTL(alg_data)) | mcntrl_reset,
+			  I2C_REG_CTL(alg_data));
+		while(ioread32(I2C_REG_CTL(alg_data)) & mcntrl_reset && cnt--);
+	} else if (ioread32(I2C_REG_STS(alg_data)) & mstatus_nai) {
+		iowrite32(ioread32(I2C_REG_CTL(alg_data)) | mcntrl_reset,
+			  I2C_REG_CTL(alg_data));
+		while(ioread32(I2C_REG_CTL(alg_data)) & mcntrl_reset && cnt--);
+	}
+
+	/* Cleanup to be sure ... */
+	alg_data->mif.buf = NULL;
+	alg_data->mif.len = 0;
+
+	/* Release sem */
+	up(&alg_data->mif.sem);
+	dev_dbg(&adap->dev, "%s(): exiting, stat = %x\n",
+		__FUNCTION__, ioread32(I2C_REG_STS(alg_data)));
+
+	if (completed != num)
+		return ((rc < 0) ? rc : -EREMOTEIO);
+
+	return num;
+}
+
+static u32 i2c_pnx_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_I2C |
+	    I2C_FUNC_SMBUS_WRITE_BYTE_DATA | I2C_FUNC_SMBUS_READ_BYTE_DATA |
+	    I2C_FUNC_SMBUS_WRITE_WORD_DATA | I2C_FUNC_SMBUS_READ_WORD_DATA |
+	    I2C_FUNC_SMBUS_QUICK;
+}
+
+/* For now, we only handle combined mode (smbus) */
+static struct i2c_algorithm pnx_algorithm = {
+	.master_xfer = i2c_pnx_xfer,
+	.functionality = i2c_pnx_func,
+};
+
+static int i2c_pnx_controller_suspend(struct platform_device *pdev,
+				      pm_message_t state)
+{
+	struct pnx_i2c *i2c_pnx = platform_get_drvdata(pdev);
+	return i2c_pnx->suspend(pdev, state);
+}
+
+static int i2c_pnx_controller_resume(struct platform_device *pdev)
+{
+	struct pnx_i2c *i2c_pnx = platform_get_drvdata(pdev);
+	return i2c_pnx->resume(pdev);
+}
+
+static int i2c_pnx_probe(struct platform_device *pdev)
+{
+	unsigned long tmp;
+	int ret = 0, cnt = COMPLETION_COUNT;
+	struct i2c_pnx_platform_data *plat_data = pdev->dev.platform_data;
+	struct i2c_pnx_algo_data *alg_data;
+	int freq_mhz;
+	struct pnx_i2c *i2c_pnx;
+
+	if (!plat_data) {
+		printk(KERN_ERR "%s: no platform data supplied\n",
+		       __FUNCTION__);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	i2c_pnx = kzalloc(sizeof(struct pnx_i2c), SLAB_KERNEL);
+	if (!i2c_pnx) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	i2c_pnx->suspend = plat_data->suspend;
+	i2c_pnx->resume = plat_data->resume;
+	i2c_pnx->calculate_input_freq = plat_data->calculate_input_freq;
+	i2c_pnx->set_clock_run = plat_data->set_clock_run;
+	i2c_pnx->set_clock_stop = plat_data->set_clock_stop;
+	i2c_pnx->adapter = plat_data->adapter;
+	platform_set_drvdata(pdev, i2c_pnx);
+
+	if (i2c_pnx->calculate_input_freq)
+		freq_mhz = i2c_pnx->calculate_input_freq(pdev);
+	else {
+		freq_mhz = 13;
+		printk(KERN_WARNING "Setting bus frequency to default value: "
+		       "%d MHz", freq_mhz);
+	}
+
+	i2c_pnx->adapter->algo = &pnx_algorithm;
+
+	alg_data = i2c_pnx->adapter->algo_data;
+	memset(&alg_data->mif, 0, sizeof(alg_data->mif));
+	init_MUTEX(&alg_data->mif.sem);
+	init_timer(&alg_data->mif.timer);
+	alg_data->mif.timer.function = i2c_pnx_timeout;
+	alg_data->mif.timer.data = (unsigned long)alg_data;
+
+	/* Register I/O resource */
+	if (!request_region(alg_data->base, I2C_BLOCK_SIZE, "i2c-pnx")) {
+		printk(KERN_ERR
+		       "I/O region 0x%08x for I2C already in use.\n",
+		       alg_data->base);
+		ret = -ENODEV;
+		goto out0;
+	}
+
+	if (!(alg_data->ioaddr =
+			(u32)ioremap(alg_data->base, I2C_BLOCK_SIZE))) {
+		printk(KERN_ERR "Couldn't ioremap I2C I/O region\n");
+		ret = -ENOMEM;
+		goto out1;
+	}
+
+	i2c_pnx->set_clock_run(pdev);
+
+	/* Clock Divisor High This value is the number of system clocks
+	 * the serial clock (SCL) will be high. n is defined at compile
+	 * time based on the system clock (PCLK) and minimum serial frequency.
+	 * For example, if the system clock period is 50 ns and the maximum
+	 * desired serial period is 10000 ns (100 kHz), then CLKHI would be
+	 * set to 0.5*(f_sys/f_i2c)-2=0.5*(20e6/100e3)-2=98. The actual value
+	 * programmed into CLKHI will vary from this slightly due to
+	 * variations in the output pad s rise and fall times as well as
+	 * the deglitching filter length. In this example, n = 7, since
+	 * eight bits are needed to hold the clock divider count.
+	 */
+
+	tmp = ((freq_mhz * 1000) / I2C_PNX_SPEED_KHZ) / 2 - 2;
+	iowrite32(tmp, I2C_REG_CKH(alg_data));
+	iowrite32(tmp, I2C_REG_CKL(alg_data));
+	iowrite32(0, I2C_REG_CTL(alg_data));
+
+	iowrite32(mcntrl_reset, I2C_REG_CTL(alg_data));
+	while ((ioread32(I2C_REG_CTL(alg_data)) & mcntrl_reset) && cnt--);
+	if (!cnt) {
+		ret = -ENODEV;
+		goto out2;
+	}
+	init_completion(&alg_data->mif.complete);
+
+	ret = request_irq(alg_data->irq, i2c_pnx_interrupt,
+			0, CHIP_NAME, i2c_pnx->adapter);
+	if (ret)
+		goto out3;
+
+	/* Register this adapter with the I2C subsystem */
+	i2c_pnx->adapter->dev.parent = &pdev->dev;
+	ret = i2c_add_adapter(i2c_pnx->adapter);
+	if (ret < 0) {
+		printk(KERN_INFO "I2C: Failed to add bus\n");
+		goto out4;
+	}
+
+	printk(KERN_INFO "%s: Master at %#8x, irq %d.\n",
+	       i2c_pnx->adapter->name, alg_data->base, alg_data->irq);
+
+	return 0;
+
+out4:
+	free_irq(alg_data->irq, alg_data);
+out3:
+	i2c_pnx->set_clock_stop(pdev);
+out2:
+	iounmap((void *)alg_data->ioaddr);
+out1:
+	release_region(alg_data->base, I2C_BLOCK_SIZE);
+out0:
+	kfree(i2c_pnx);
+out:
+	return ret;
+}
+
+static int i2c_pnx_remove(struct platform_device *pdev)
+{
+	struct pnx_i2c *i2c_pnx = platform_get_drvdata(pdev);
+	struct i2c_adapter *adap = i2c_pnx->adapter;
+	struct i2c_pnx_algo_data *alg_data =
+	    (struct i2c_pnx_algo_data *)adap->algo_data;
+	int cnt = COMPLETION_COUNT;
+
+	/* Reset the I2C controller. The reset bit is self clearing. */
+	iowrite32(ioread32(I2C_REG_CTL(alg_data)) | mcntrl_reset,
+		  I2C_REG_CTL(alg_data));
+	while (ioread32(I2C_REG_CTL(alg_data)) & mcntrl_reset && cnt--);
+
+	free_irq(alg_data->irq, alg_data);
+	i2c_del_adapter(adap);
+	i2c_pnx->set_clock_stop(pdev);
+	iounmap((void *)alg_data->ioaddr);
+	release_region(alg_data->base, I2C_BLOCK_SIZE);
+	kfree(i2c_pnx);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver i2c_pnx_driver = {
+	.driver = {
+		   .name = "pnx-i2c",
+	},
+	.probe = i2c_pnx_probe,
+	.remove = i2c_pnx_remove,
+	.suspend = i2c_pnx_controller_suspend,
+	.resume = i2c_pnx_controller_resume,
+};
+
+static int __init i2c_adap_pnx_init(void)
+{
+	return platform_driver_register(&i2c_pnx_driver);
+}
+
+static void i2c_adap_pnx_exit(void)
+{
+	return platform_driver_unregister(&i2c_pnx_driver);
+}
+
+MODULE_AUTHOR("Dennis Kovalev <dkovalev@ru.mvista.com>");
+MODULE_DESCRIPTION("I2C driver for PNX bus");
+MODULE_LICENSE("GPL");
+
+subsys_initcall(i2c_adap_pnx_init);
+module_exit(i2c_adap_pnx_exit);
Index: linux-2.6.git/include/asm-arm/arch-pnx4008/i2c.h
===================================================================
--- /dev/null
+++ linux-2.6.git/include/asm-arm/arch-pnx4008/i2c.h
@@ -0,0 +1,80 @@
+/*
+ *  include/asm-arm/arch-pnx4008/i2c.h
+ *
+ * Author: Vitaly Wool <vwool@ru.mvista.com>
+ *
+ * PNX4008-specific tweaks for I2C IP3204 block
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifndef __ASM_ARCH_I2C_H__
+#define __ASM_ARCH_I2C_H__
+
+#include <linux/i2c.h>
+#include <linux/i2c-pnx.h>
+#include <linux/platform_device.h>
+#include <asm/irq.h>
+
+enum {
+	mstatus_tdi = 0x00000001,
+	mstatus_afi = 0x00000002,
+	mstatus_nai = 0x00000004,
+	mstatus_drmi = 0x00000008,
+	mstatus_active = 0x00000020,
+	mstatus_scl = 0x00000040,
+	mstatus_sda = 0x00000080,
+	mstatus_rff = 0x00000100,
+	mstatus_rfe = 0x00000200,
+	mstatus_tff = 0x00000400,
+	mstatus_tfe = 0x00000800,
+};
+
+enum {
+	mcntrl_tdie = 0x00000001,
+	mcntrl_afie = 0x00000002,
+	mcntrl_naie = 0x00000004,
+	mcntrl_drmie = 0x00000008,
+	mcntrl_daie = 0x00000020,
+	mcntrl_rffie = 0x00000040,
+	mcntrl_tffie = 0x00000080,
+	mcntrl_reset = 0x00000100,
+	mcntrl_cdbmode = 0x00000400,
+};
+
+enum {
+	rw_bit = 1 << 0,
+	start_bit = 1 << 8,
+	stop_bit = 1 << 9,
+};
+
+#define I2C_REG_RX(a)	((a)->ioaddr)		/* Rx FIFO reg (RO) */
+#define I2C_REG_TX(a)	((a)->ioaddr)		/* Tx FIFO reg (WO) */
+#define I2C_REG_STS(a)	((a)->ioaddr + 0x04)	/* Status reg (RO) */
+#define I2C_REG_CTL(a)	((a)->ioaddr + 0x08)	/* Ctl reg */
+#define I2C_REG_CKL(a)	((a)->ioaddr + 0x0c)	/* Clock divider low */
+#define I2C_REG_CKH(a)	((a)->ioaddr + 0x10)	/* Clock divider high */
+#define I2C_REG_ADR(a)	((a)->ioaddr + 0x14)	/* I2C address */
+#define I2C_REG_RFL(a)	((a)->ioaddr + 0x18)	/* Rx FIFO level (RO) */
+#define I2C_REG_TFL(a)	((a)->ioaddr + 0x1c)	/* Tx FIFO level (RO) */
+#define I2C_REG_RXB(a)	((a)->ioaddr + 0x20)	/* Num of bytes Rx-ed (RO) */
+#define I2C_REG_TXB(a)	((a)->ioaddr + 0x24)	/* Num of bytes Tx-ed (RO) */
+#define I2C_REG_TXS(a)	((a)->ioaddr + 0x28)	/* Tx slave FIFO (RO) */
+#define I2C_REG_STFL(a)	((a)->ioaddr + 0x2c)	/* Tx slave FIFO level (RO) */
+
+#define HCLK_MHZ		13
+#define TIMEOUT			(2*(HZ))
+
+struct i2c_pnx_platform_data {
+	int (*suspend) (struct platform_device *pdev, pm_message_t state);
+	int (*resume) (struct platform_device *pdev);
+	u32 (*calculate_input_freq) (struct platform_device *pdev);
+	int (*set_clock_run) (struct platform_device *pdev);
+	int (*set_clock_stop) (struct platform_device *pdev);
+	struct i2c_adapter *adapter;
+};
+
+#endif				/* __ASM_ARCH_I2C_H___ */
Index: linux-2.6.git/include/linux/i2c-pnx.h
===================================================================
--- /dev/null
+++ linux-2.6.git/include/linux/i2c-pnx.h
@@ -0,0 +1,51 @@
+/*
+ * include/linux/i2c-pnx.h
+ *
+ * Header file for i2c support for PNX010x/4008.
+ *
+ * Author: Dennis Kovalev <dkovalev@ru.mvista.com>
+ *
+ * 2004-2006 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifndef _I2C_PNX_H
+#define _I2C_PNX_H
+
+typedef enum {
+	xmit,
+	rcv,
+	nodata,
+} i2c_pnx_mode_t;
+
+#define I2C_BUFFER_SIZE   0x100
+
+struct i2c_pnx_mif {
+	int			ret;		/* Return value */
+	i2c_pnx_mode_t		mode;		/* Interface mode */
+	struct semaphore	sem;		/* Mutex for this interface */
+	struct completion 	complete;	/* I/O completion */
+	struct timer_list	timer;		/* Timeout */
+	char *			buf;		/* Data buffer */
+	int			len;		/* Length of data buffer */
+};
+
+struct i2c_pnx_algo_data {
+	u32			base;
+	u32			ioaddr;
+	int			irq;
+	int			clock_id;
+	/* buffer for data received from I2C bus */
+	char			buffer[I2C_BUFFER_SIZE];
+	int			buf_index;
+	struct i2c_pnx_mif	mif;
+};
+
+#define TIMEOUT			(2*(HZ))
+#define I2C_PNX_SPEED_KHZ	100
+#define I2C_BLOCK_SIZE		0x100
+#define CHIP_NAME		"PNX-I2C"
+
+#endif
Index: linux-2.6.git/arch/arm/mach-pnx4008/Makefile
===================================================================
--- linux-2.6.git.orig/arch/arm/mach-pnx4008/Makefile
+++ linux-2.6.git/arch/arm/mach-pnx4008/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-obj-y			:= core.o irq.o time.o clock.o gpio.o serial.o dma.o
+obj-y			:= core.o irq.o time.o clock.o gpio.o serial.o dma.o i2c.o
 obj-m			:=
 obj-n			:=
 obj-			:=
Index: linux-2.6.git/arch/arm/mach-pnx4008/i2c.c
===================================================================
--- /dev/null
+++ linux-2.6.git/arch/arm/mach-pnx4008/i2c.c
@@ -0,0 +1,186 @@
+/*
+ * arch/arm/mach-pnx4008/i2c.c
+ *
+ * I2C initialization for PNX4008.
+ *
+ * Author: Vitaly Wool <vitalywool@gmail.com>
+ *
+ * 2005-2006 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <asm/arch/platform.h>
+#include <asm/arch/i2c.h>
+#include <linux/clk.h>
+#include <linux/config.h>
+#include <linux/platform_device.h>
+#include <linux/err.h>
+
+static inline int i2c_pnx_suspend(struct platform_device *pdev,
+				  pm_message_t state)
+{
+	int retval = 0;
+#ifdef CONFIG_PM
+	struct clk *clk;
+	char name[10];
+
+	sprintf(name, "i2c%d_ck", pdev->id);
+	clk = clk_get(&pdev->dev, name);
+	if (!IS_ERR(clk)) {
+		clk_set_rate(clk, 0);
+		clk_put(clk);
+	} else
+		retval = -ENOENT;
+#endif
+	return retval;
+}
+
+static inline int i2c_pnx_resume(struct platform_device *pdev)
+{
+	int retval = 0;
+#ifdef CONFIG_PM
+	struct clk *clk;
+	char name[10];
+
+	sprintf(name, "i2c%d_ck", pdev->id);
+	clk = clk_get(&pdev->dev, name);
+	if (!IS_ERR(clk)) {
+		clk_set_rate(clk, 1);
+		clk_put(clk);
+	} else
+		retval = -ENOENT;
+#endif
+	return retval;
+}
+
+static inline u32 calculate_input_freq(struct platform_device *pdev)
+{
+	return HCLK_MHZ;
+}
+
+static inline int set_clock_run(struct platform_device *pdev)
+{
+	struct clk *clk;
+	char name[10];
+	int retval = 0;
+
+	sprintf(name, "i2c%d_ck", pdev->id);
+	clk = clk_get(&pdev->dev, name);
+	if (!IS_ERR(clk)) {
+		clk_set_rate(clk, 1);
+		clk_put(clk);
+	} else
+		retval = -ENOENT;
+
+	return retval;
+}
+
+static inline int set_clock_stop(struct platform_device *pdev)
+{
+	struct clk *clk;
+	char name[10];
+	int retval = 0;
+
+	sprintf(name, "i2c%d_ck", pdev->id);
+	clk = clk_get(&pdev->dev, name);
+	if (!IS_ERR(clk)) {
+		clk_set_rate(clk, 0);
+		clk_put(clk);
+	} else
+		retval = -ENOENT;
+
+	return retval;
+}
+
+static struct i2c_pnx_algo_data pnx_algo_data0 = {
+	.base = PNX4008_I2C1_BASE,
+	.irq = I2C_1_INT,
+};
+
+static struct i2c_pnx_algo_data pnx_algo_data1 = {
+	.base = PNX4008_I2C2_BASE,
+	.irq = I2C_2_INT,
+};
+
+static struct i2c_pnx_algo_data pnx_algo_data2 = {
+	.base = (PNX4008_USB_CONFIG_BASE + 0x300),
+	.irq = USB_I2C_INT,
+};
+
+static struct i2c_adapter pnx_adapter0 = {
+	.name = CHIP_NAME "0",
+	.algo_data = (void *)&pnx_algo_data0,
+};
+static struct i2c_adapter pnx_adapter1 = {
+	.name = CHIP_NAME "1",
+	.algo_data = (void *)&pnx_algo_data1,
+};
+
+static struct i2c_adapter pnx_adapter2 = {
+	.name = "USB-I2C",
+	.algo_data = (void *)&pnx_algo_data2,
+};
+
+static struct i2c_pnx_platform_data i2c0_platform_data = {
+	.suspend = i2c_pnx_suspend,
+	.resume = i2c_pnx_resume,
+	.calculate_input_freq = calculate_input_freq,
+	.set_clock_run = set_clock_run,
+	.set_clock_stop = set_clock_stop,
+	.adapter = &pnx_adapter0,
+};
+
+static struct i2c_pnx_platform_data i2c1_platform_data = {
+	.suspend = i2c_pnx_suspend,
+	.resume = i2c_pnx_resume,
+	.calculate_input_freq = calculate_input_freq,
+	.set_clock_run = set_clock_run,
+	.set_clock_stop = set_clock_stop,
+	.adapter = &pnx_adapter1,
+};
+
+static struct i2c_pnx_platform_data i2c2_platform_data = {
+	.suspend = i2c_pnx_suspend,
+	.resume = i2c_pnx_resume,
+	.calculate_input_freq = calculate_input_freq,
+	.set_clock_run = set_clock_run,
+	.set_clock_stop = set_clock_stop,
+	.adapter = &pnx_adapter2,
+};
+
+static struct platform_device i2c0_device = {
+	.name = "pnx-i2c",
+	.id = 0,
+	.dev = {
+		.platform_data = &i2c0_platform_data,
+		},
+};
+
+static struct platform_device i2c1_device = {
+	.name = "pnx-i2c",
+	.id = 1,
+	.dev = {
+		.platform_data = &i2c1_platform_data,
+		},
+};
+
+static struct platform_device i2c2_device = {
+	.name = "pnx-i2c",
+	.id = 2,
+	.dev = {
+		.platform_data = &i2c2_platform_data,
+		},
+};
+
+static struct platform_device *devices[] __initdata = {
+	&i2c0_device,
+	&i2c1_device,
+	&i2c2_device,
+};
+
+void __init pnx4008_register_i2c_devices(void)
+{
+	platform_add_devices(devices, ARRAY_SIZE(devices));
+}
