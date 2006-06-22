Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161072AbWFVLbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161072AbWFVLbL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 07:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161076AbWFVLbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 07:31:11 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:42908 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1161072AbWFVLbJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 07:31:09 -0400
Date: Thu, 22 Jun 2006 15:31:46 +0400
From: Vitaly Wool <vitalywool@gmail.com>
To: i2c@lm-sensors.org
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] I2C bus driver for Philips ARM boards
Message-Id: <20060622153146.2ae56e33.vitalywool@gmail.com>
X-Mailer: Sylpheed version 2.2.1 (GTK+ 2.8.13; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please find below the I2C bus driver for Philips ARM boards (Philips IP3204 I2C IP block). This I2C controller can be found on PNX010x, PNX52xx and PNX4008 Philips boards.
Any comments are welcome.

 arch/arm/mach-pnx4008/Makefile     |    2
 arch/arm/mach-pnx4008/i2c.c        |  190 +++++++++
 drivers/i2c/busses/Kconfig         |   10
 drivers/i2c/busses/Makefile        |    2
 drivers/i2c/busses/i2c-pnx.c       |  710 +++++++++++++++++++++++++++++++++++++
 include/asm-arm/arch-pnx4008/i2c.h |   86 ++++
 include/linux/i2c-pnx.h            |   52 ++
 7 files changed, 1051 insertions(+), 1 deletion(-)

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
@@ -0,0 +1,710 @@
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
+static inline void i2c_pnx_arm_timer(struct timer_list *timer, void *data)
+{
+	del_timer_sync(timer);
+
+	pr_debug("%s: Timer armed at %lu plus %u jiffies.\n",
+		 __FUNCTION__, jiffies, TIMEOUT);
+
+	timer->expires = jiffies + TIMEOUT;
+	timer->data = (unsigned long)data;
+
+	add_timer(timer);
+}
+
+static inline int i2c_pnx_bus_busy(volatile struct i2c_regs *master)
+{
+	long timeout;
+
+	timeout = TIMEOUT * 10000;
+	if (timeout > 0 && (master->sts & mstatus_active)) {
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
+	pr_debug("%s(%d): %s() addr 0x%x mode %s\n", __FILE__,
+		 __LINE__, __FUNCTION__, slave_addr,
+		 i2c_pnx_modestr[alg_data->mif.mode]);
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
+	if (i2c_pnx_bus_busy(alg_data->master)) {
+		/* Somebody else is monopolising the bus */
+		printk(KERN_ERR "%s: Bus busy. Slave addr = %02x, "
+		       "cntrl = %x, stat = %x\n",
+		       adap->name, slave_addr,
+		       alg_data->master->ctl, alg_data->master->sts);
+		return -EBUSY;
+	} else if (alg_data->master->sts & mstatus_afi) {
+		/* Sorry, we lost the bus */
+		printk(KERN_ERR "%s: Arbitration failure. "
+		       "Slave addr = %02x\n", adap->name, slave_addr);
+		return -EIO;
+	}
+
+	/* OK, I2C is enabled and we have the bus. */
+	/* Clear the current TDI and AFI status flags. */
+	alg_data->master->sts |= mstatus_tdi | mstatus_afi;
+
+	pr_debug("%s(%d): %s() sending %#x\n", __FILE__, __LINE__,
+		 __FUNCTION__, (slave_addr << 1) | start_bit |
+		 (alg_data->mif.mode == rcv ? rw_bit : 0));
+
+	/* Write the slave address, START bit and R/W bit */
+	alg_data->master->fifo.tx = (slave_addr << 1) | start_bit |
+	    (alg_data->mif.mode == rcv ? rw_bit : 0);
+
+	pr_debug("%s(%d): %s() exit\n", __FILE__, __LINE__, __FUNCTION__);
+
+	return 0;
+}
+
+/**
+ * i2c_pnx_start - stop a device
+ * @alg_data:		pointer to I2C-PNX algorithm data structure
+ *
+ * Generate a STOP signal to terminate the master transaction.
+ */
+static void i2c_pnx_stop(struct i2c_pnx_algo_data *alg_data)
+{
+	int cnt = 10000;
+
+	pr_debug("%s: %s() enter - stat = %04x.\n",
+		 __FILE__, __FUNCTION__, alg_data->master->sts);
+
+	/* Write a STOP bit to TX FIFO */
+	alg_data->master->fifo.tx = 0x000000ff | stop_bit;
+
+	/* Wait until the STOP is seen. */
+	while (alg_data->master->sts & mstatus_active && cnt--);
+
+	pr_debug("%s: %s() exit - stat = %04x.\n",
+		 __FILE__, __FUNCTION__, alg_data->master->sts);
+}
+
+/**
+ * i2c_pnx_master_xmit - transmit data to slave
+ * @alg_data:		pointer to I2C-PNX algorithm data structure
+ *
+ * Sends one byte of data to the slave
+ */
+static int i2c_pnx_master_xmit(struct i2c_pnx_algo_data *alg_data)
+{
+	u32 val;
+
+	pr_debug("%s(): Entered\n", __FUNCTION__);
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
+		alg_data->master->fifo.tx = val;
+
+		pr_debug("%s: xmit %#x [%d]\n", __FUNCTION__, val,
+			 alg_data->mif.len + 1);
+
+		if (alg_data->mif.len == 0) {
+			/* Wait until the STOP is seen. */
+			while (alg_data->master->sts & mstatus_active) ;
+
+			/* Disable master interrupts */
+			alg_data->master->ctl &= ~(mcntrl_afie | mcntrl_naie |
+						   mcntrl_drmie);
+
+			del_timer_sync(&alg_data->mif.timer);
+
+			pr_debug("%s: Waking up xfer routine.\n", __FUNCTION__);
+
+			complete(&alg_data->mif.complete);
+		}
+	} else /* For zero-sized transfers. */ if (alg_data->mif.len == 0) {
+		/* Isue a stop. */
+		i2c_pnx_stop(alg_data);
+
+		/* Disable master interrupts. */
+		alg_data->master->ctl &= ~(mcntrl_afie | mcntrl_naie |
+					   mcntrl_drmie);
+
+		/* Stop timer. */
+		del_timer_sync(&alg_data->mif.timer);
+		pr_debug("%s: Waking up xfer routine after zero-xfer.\n",
+			 __FUNCTION__);
+
+		complete(&alg_data->mif.complete);
+	}
+
+	pr_debug("%s(): Exit\n", __FUNCTION__);
+
+	return 0;
+}
+
+/**
+ * i2c_pnx_master_rcv - receive data from slave
+ * @alg_data:		pointer to I2C-PNX algorithm data structure
+ *
+ * Reads one byte data from the slave
+ */
+static int i2c_pnx_master_rcv(struct i2c_pnx_algo_data *alg_data)
+{
+	unsigned int val = 0;
+
+	pr_debug("%s(): Entered\n", __FUNCTION__);
+
+	/* Check, whether there is already data,
+	 * or we didn't 'ask' for it yet.
+	 */
+	if (alg_data->master->sts & mstatus_rfe) {
+		pr_debug("%s(): Write dummy data to fill Rx-fifo...\n",
+			 __FUNCTION__);
+
+		if (alg_data->mif.len == 1) {
+			/* Last byte, do not acknowledge next rcv. */
+			val |= stop_bit;
+
+			/* Enable interrupt RFDAIE (= data in Rx-fifo.),
+			 * and disable DRMIE (= need data for Tx.)
+			 */
+			alg_data->master->ctl |= mcntrl_rffie | mcntrl_daie;
+			alg_data->master->ctl &= ~(mcntrl_drmie);
+		}
+
+		/* Now we'll 'ask' for data:
+		 * For each byte we want to receive, we must
+		 * write a (dummy) byte to the Tx-FIFO.
+		 */
+		alg_data->master->fifo.tx = val;
+
+		return 0;
+	}
+
+	/* Handle data. */
+	if (alg_data->mif.len > 0) {
+
+		pr_debug("%s(): Get data from Rx-fifo...\n", __FUNCTION__);
+
+		val = alg_data->master->fifo.rx;
+		*alg_data->mif.buf++ = (u8) (val & 0xff);
+		pr_debug("%s: rcv 0x%x [%d]\n", __FUNCTION__, val,
+			 alg_data->mif.len);
+
+		alg_data->mif.len--;
+		if (alg_data->mif.len == 0) {
+			/* Wait until the STOP is seen. */
+			while (alg_data->master->sts & mstatus_active) ;
+
+			/* Disable master interrupts */
+			alg_data->master->ctl &= ~(mcntrl_afie | mcntrl_naie |
+						   mcntrl_rffie | mcntrl_drmie |
+						   mcntrl_daie);
+
+			/* Kill timer. */
+			del_timer_sync(&alg_data->mif.timer);
+			pr_debug("%s: Waking up xfer routine after rcv.\n",
+				 __FUNCTION__);
+
+			complete(&alg_data->mif.complete);
+		}
+	}
+
+	pr_debug("%s: Exit\n", __FUNCTION__);
+
+	return 0;
+}
+
+static irqreturn_t
+i2c_pnx_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	unsigned long stat;
+	struct i2c_pnx_algo_data *alg_data = (struct i2c_pnx_algo_data *)dev_id;
+
+	pr_debug("%s(): mstat = %x mctrl = %x, mmode = %s\n", __FUNCTION__,
+		 alg_data->master->sts, alg_data->master->ctl,
+		 i2c_pnx_modestr[alg_data->mif.mode]);
+	stat = alg_data->master->sts;
+
+	/* let's see what kind of event this is */
+	if (stat & mstatus_afi) {
+		/* We lost arbitration in the midst of a transfer */
+		alg_data->mif.ret = -EIO;
+
+		/* Disable master interrupts. */
+		alg_data->master->ctl &= ~(mcntrl_afie | mcntrl_naie |
+					   mcntrl_drmie | mcntrl_rffie);
+
+		/* Stop timer, to prevent timeout. */
+		del_timer_sync(&alg_data->mif.timer);
+		complete(&alg_data->mif.complete);
+	} else if (stat & mstatus_nai) {
+		/* Slave did not acknowledge, generate a STOP */
+		pr_debug
+		    ("%s(): Slave did not acknowledge, generating a STOP.\n",
+		     __FUNCTION__);
+		i2c_pnx_stop(alg_data);
+
+		/* Disable master interrupts. */
+		alg_data->master->ctl &= ~(mcntrl_afie | mcntrl_naie |
+					   mcntrl_drmie | mcntrl_rffie);
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
+				i2c_pnx_master_xmit(alg_data);
+			} else if (alg_data->mif.mode == rcv) {
+				i2c_pnx_master_rcv(alg_data);
+			}
+		}
+	}
+
+	/* Clear TDI and AFI bits */
+	alg_data->master->sts |= mstatus_tdi | mstatus_afi;
+
+	pr_debug("%s(): Exit, stat = %x ctrl = %x.\n",
+		 __FUNCTION__, alg_data->master->sts, alg_data->master->ctl);
+
+	return IRQ_HANDLED;
+}
+
+static void i2c_pnx_timeout(unsigned long data)
+{
+	struct i2c_pnx_algo_data *alg_data = (struct i2c_pnx_algo_data *)data;
+
+	printk(KERN_ERR
+	       "Master timed out. stat = %04x, cntrl = %04x. Resetting master ...\n",
+	       alg_data->master->sts, alg_data->master->ctl);
+
+	/* Reset master and disable interrupts */
+	alg_data->master->ctl &=
+	    ~(mcntrl_afie | mcntrl_naie | mcntrl_drmie | mcntrl_rffie);
+	alg_data->master->ctl |= mcntrl_reset;
+	while (alg_data->master->ctl & mcntrl_reset) ;
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
+	int rc = 0, completed = 0, i;
+	struct i2c_pnx_algo_data *alg_data =
+	    (struct i2c_pnx_algo_data *)adap->algo_data;
+
+	pr_debug("%s: Entered\n", __FUNCTION__);
+
+	down(&alg_data->mif.sem);
+
+	/* If the bus is still active, or there is already
+	 * data in one of the fifo's, there is something wrong.
+	 * Repair this by a reset ...
+	 */
+	if ((alg_data->master->sts & mstatus_active)) {
+		alg_data->master->ctl |= mcntrl_reset;
+		while (alg_data->master->ctl & mcntrl_reset) ;
+	} else if (!(alg_data->master->sts & mstatus_rfe) ||
+		   !(alg_data->master->sts & mstatus_tfe)) {
+		printk(KERN_ERR
+		       "%s: FIFO's contain already data before xfer. Reset it ...\n",
+		       adap->name);
+
+		alg_data->master->ctl |= mcntrl_reset;
+		while (alg_data->master->ctl & mcntrl_reset) ;
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
+			printk(KERN_ERR
+			       "%s: 10 bits addr not supported !\n",
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
+		pr_debug("%s: %s mode, %d bytes\n", __FUNCTION__,
+			 i2c_pnx_modestr[alg_data->mif.mode],
+			 alg_data->mif.len);
+
+		/* Arm timer */
+		i2c_pnx_arm_timer(&alg_data->mif.timer, (void *)alg_data);
+
+		/* initialize the completion var */
+		init_completion(&alg_data->mif.complete);
+
+		/* Enable master interrupt */
+		alg_data->master->ctl =
+		    mcntrl_afie | mcntrl_naie | mcntrl_drmie;
+
+		/* Put start-code and slave-address on the bus. */
+		rc = i2c_pnx_start(addr, adap);
+		if (0 != rc) {
+			break;
+		}
+
+		pr_debug("%s(%d): stat = %04x, cntrl = %04x.\n",
+			 __FUNCTION__, __LINE__, alg_data->master->sts,
+			 alg_data->master->ctl);
+
+		/* Wait for completion */
+		wait_for_completion(&alg_data->mif.complete);
+
+		if (!(rc = alg_data->mif.ret))
+			completed++;
+		pr_debug("%s: Return code = %d.\n", __FUNCTION__, rc);
+
+		/* Clear TDI and AFI bits in case they are set. */
+		if (alg_data->master->sts & mstatus_tdi) {
+			printk("%s: TDI still set ... clearing now.\n",
+			       adap->name);
+			alg_data->master->sts |= mstatus_tdi;
+		}
+		if (alg_data->master->sts & mstatus_afi) {
+			printk("%s: AFI still set ... clearing now.\n",
+			       adap->name);
+			alg_data->master->sts |= mstatus_afi;
+		}
+	}
+
+	/* If the bus is still active, reset it to prevent
+	 * corruption of future transactions.
+	 */
+	if ((alg_data->master->sts & mstatus_active)) {
+		printk("%s: Bus is still active after xfer. Reset it ...\n",
+		       adap->name);
+		alg_data->master->ctl |= mcntrl_reset;
+		while (alg_data->master->ctl & mcntrl_reset) ;
+	} else
+		/* If there is data in the fifo's after transfer,
+		 * flush fifo's by reset.
+		 */
+	if (!(alg_data->master->sts & mstatus_rfe) ||
+		    !(alg_data->master->sts & mstatus_tfe)) {
+		alg_data->master->ctl |= mcntrl_reset;
+		while (alg_data->master->ctl & mcntrl_reset) ;
+	} else if ((alg_data->master->sts & mstatus_nai)) {
+		alg_data->master->ctl |= mcntrl_reset;
+		while (alg_data->master->ctl & mcntrl_reset) ;
+	}
+
+	/* Cleanup to be sure ... */
+	alg_data->mif.buf = NULL;
+	alg_data->mif.len = 0;
+
+	/* Release sem */
+	up(&alg_data->mif.sem);
+	pr_debug("%s: Exit\n", __FUNCTION__);
+
+	if (completed != num) {
+		return ((rc < 0) ? rc : -EREMOTEIO);
+	}
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
+	int ret = 0, cnt = 10000;
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
+	alg_data->master->ckh = tmp;
+	alg_data->master->ckl = tmp;
+	alg_data->master->ctl = 0;
+
+	alg_data->master->ctl |= mcntrl_reset;
+	while ((alg_data->master->ctl & mcntrl_reset) && cnt--) ;
+	if (!cnt) {
+		ret = -ENODEV;
+		goto out1;
+	}
+	init_completion(&alg_data->mif.complete);
+
+	ret = request_irq(alg_data->irq, i2c_pnx_interrupt,
+			0, CHIP_NAME, alg_data);
+	if (ret)
+		goto out2;
+
+	/* Register this adapter with the I2C subsystem */
+	i2c_pnx->adapter->dev.parent = &pdev->dev;
+	ret = i2c_add_adapter(i2c_pnx->adapter);
+	if (ret < 0) {
+		printk(KERN_INFO "I2C: Failed to add bus\n");
+		goto out3;
+	}
+
+	printk(KERN_INFO "%s: Master at %#8x, irq %d.\n",
+	       i2c_pnx->adapter->name, alg_data->base, alg_data->irq);
+
+	return 0;
+
+      out3:
+	free_irq(alg_data->irq, alg_data);
+      out2:
+	i2c_pnx->set_clock_stop(pdev);
+      out1:
+	release_region(alg_data->base, I2C_BLOCK_SIZE);
+      out0:
+	kfree(i2c_pnx);
+      out:
+	return ret;
+}
+
+static int i2c_pnx_remove(struct platform_device *pdev)
+{
+	struct pnx_i2c *i2c_pnx = platform_get_drvdata(pdev);
+	struct i2c_adapter *adap = i2c_pnx->adapter;
+	struct i2c_pnx_algo_data *alg_data =
+	    (struct i2c_pnx_algo_data *)adap->algo_data;
+	int cnt = 10000;
+
+	/* Reset the I2C controller. The reset bit is self clearing. */
+	alg_data->master->ctl |= mcntrl_reset;
+	while ((alg_data->master->ctl & mcntrl_reset) && cnt--) ;
+
+	free_irq(alg_data->irq, alg_data);
+	i2c_del_adapter(adap);
+	i2c_pnx->set_clock_stop(pdev);
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
+		   },
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
@@ -0,0 +1,86 @@
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
+struct i2c_regs {
+	/* LSB */
+	union {
+		const u32 rx;	/* Receive FIFO Register - Read Only */
+		u32 tx;		/* Transmit FIFO Register - Write Only */
+	} fifo;
+	u32 sts;		/* Status Register - Read Only */
+	u32 ctl;		/* Control Register - Read/Write */
+	u32 ckl;		/* Clock divider low  - Read/Write */
+	u32 ckh;		/* Clock divider high - Read/Write */
+	u32 adr;		/* I2C address (optional) - Read/Write */
+	const u32 rfl;		/* Rx FIFO level (optional) - Read Only */
+	const u32 _unused;	/* Tx FIFO level (optional) - Read Only */
+	const u32 rxb;		/* Number of bytes received (opt.) - Read Only */
+	const u32 txb;		/* Number of bytes transmitted (opt.) - Read Only */
+	u32 txs;		/* Tx Slave FIFO register - Write Only */
+	const u32 stfl;		/* Tx Slave FIFO level - Read Only */
+	/* MSB */
+};
+
+#define HCLK_MHZ		13
+#define TIMEOUT			(2*(HZ))
+
+struct i2c_pnx_platform_data {
+	int (*suspend) (struct platform_device * pdev, pm_message_t state);
+	int (*resume) (struct platform_device * pdev);
+	 u32(*calculate_input_freq) (struct platform_device * pdev);
+	int (*set_clock_run) (struct platform_device * pdev);
+	int (*set_clock_stop) (struct platform_device * pdev);
+	struct i2c_adapter *adapter;
+};
+
+#endif				/* __ASM_ARCH_I2C_H___ */
Index: linux-2.6.git/include/linux/i2c-pnx.h
===================================================================
--- /dev/null
+++ linux-2.6.git/include/linux/i2c-pnx.h
@@ -0,0 +1,52 @@
+/*
+ * include/linux/i2c-pnx.h
+ *
+ * Header file for i2c support for PNX010x/4008.
+ *
+ * Author: Dennis Kovalev <dkovalev@ru.mvista.com>
+ *
+ * 2004 (c) MontaVista Software, Inc. This file is licensed under
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
+	i2c_pnx_mode_t	mode;		/* Interface mode */
+	struct semaphore	sem;		/* Mutex for this interface */
+	struct completion 	complete;	/* I/O completion */
+	struct timer_list	timer;		/* Timeout */
+	char *			buf;		/* Data buffer */
+	int			len;		/* Length of data buffer */
+};
+
+struct i2c_pnx_algo_data {
+	u32	base;
+	int	irq;
+	int	clock_id;
+	volatile struct i2c_regs *	master;
+	char	buffer [I2C_BUFFER_SIZE];	/* contains data received from I2C bus */
+	int	buf_index;			/* index within I2C buffer (see above) */
+	struct i2c_pnx_mif	mif;
+};
+
+#include <asm/arch/platform.h>
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
@@ -0,0 +1,190 @@
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
+	clk = clk_get(0, name);
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
+	clk = clk_get(0, name);
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
+	clk = clk_get(0, name);
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
+	clk = clk_get(0, name);
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
+	.master = (struct i2c_regs *)IO_ADDRESS(PNX4008_I2C1_BASE),
+};
+
+static struct i2c_pnx_algo_data pnx_algo_data1 = {
+	.base = PNX4008_I2C2_BASE,
+	.irq = I2C_2_INT,
+	.master = (struct i2c_regs *)IO_ADDRESS(PNX4008_I2C2_BASE),
+};
+
+static struct i2c_pnx_algo_data pnx_algo_data2 = {
+	.base = (PNX4008_USB_CONFIG_BASE + 0x300),
+	.irq = USB_I2C_INT,
+	.master =
+	    (struct i2c_regs *)(IO_ADDRESS(PNX4008_USB_CONFIG_BASE) + 0x300),
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
