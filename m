Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263210AbVCDVG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263210AbVCDVG4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 16:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbVCDVDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 16:03:53 -0500
Received: from mail.kroah.org ([69.55.234.183]:9634 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263166AbVCDUyf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:35 -0500
Cc: mgreer@mvista.com
Subject: [PATCH] I2C: add Marvell mv64xxx i2c driver
In-Reply-To: <11099685951076@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:36:35 -0800
Message-Id: <11099685952512@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2100, 2005/03/02 12:17:29-08:00, mgreer@mvista.com

[PATCH] I2C: add Marvell mv64xxx i2c driver

Marvell makes a line of host bridge for PPC and MIPS systems.  On those
bridges is an i2c controller.  This patch adds the driver for that i2c
controller.

Please apply.

Depends on patch submitted by Jean Delvare:
http://archives.andrew.net.au/lm-sensors/msg29405.html

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/busses/Kconfig       |   10 
 drivers/i2c/busses/Makefile      |    1 
 drivers/i2c/busses/i2c-mv64xxx.c |  596 +++++++++++++++++++++++++++++++++++++++
 include/linux/i2c-id.h           |    3 
 include/linux/mv643xx.h          |   17 -
 5 files changed, 621 insertions(+), 6 deletions(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	2005-03-04 12:24:29 -08:00
+++ b/drivers/i2c/busses/Kconfig	2005-03-04 12:24:29 -08:00
@@ -486,4 +486,14 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-pca-isa.
 
+config I2C_MV64XXX
+	tristate "Marvell mv64xxx I2C Controller"
+	depends on I2C && MV64X60 && EXPERIMENTAL
+	help
+	  If you say yes to this option, support will be included for the
+	  built-in I2C interface on the Marvell 64xxx line of host bridges.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-mv64xxx.
+
 endmenu
diff -Nru a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
--- a/drivers/i2c/busses/Makefile	2005-03-04 12:24:29 -08:00
+++ b/drivers/i2c/busses/Makefile	2005-03-04 12:24:29 -08:00
@@ -21,6 +21,7 @@
 obj-$(CONFIG_I2C_IXP4XX)	+= i2c-ixp4xx.o
 obj-$(CONFIG_I2C_KEYWEST)	+= i2c-keywest.o
 obj-$(CONFIG_I2C_MPC)		+= i2c-mpc.o
+obj-$(CONFIG_I2C_MV64XXX)	+= i2c-mv64xxx.o
 obj-$(CONFIG_I2C_NFORCE2)	+= i2c-nforce2.o
 obj-$(CONFIG_I2C_PARPORT)	+= i2c-parport.o
 obj-$(CONFIG_I2C_PARPORT_LIGHT)	+= i2c-parport-light.o
diff -Nru a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/i2c/busses/i2c-mv64xxx.c	2005-03-04 12:24:29 -08:00
@@ -0,0 +1,596 @@
+/*
+ * drivers/i2c/busses/i2c-mv64xxx.c
+ * 
+ * Driver for the i2c controller on the Marvell line of host bridges for MIPS
+ * and PPC (e.g, gt642[46]0, mv643[46]0, mv644[46]0).
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * 2005 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/mv643xx.h>
+#include <asm/io.h>
+
+/* Register defines */
+#define	MV64XXX_I2C_REG_SLAVE_ADDR			0x00
+#define	MV64XXX_I2C_REG_DATA				0x04
+#define	MV64XXX_I2C_REG_CONTROL				0x08
+#define	MV64XXX_I2C_REG_STATUS				0x0c
+#define	MV64XXX_I2C_REG_BAUD				0x0c
+#define	MV64XXX_I2C_REG_EXT_SLAVE_ADDR			0x10
+#define	MV64XXX_I2C_REG_SOFT_RESET			0x1c
+
+#define	MV64XXX_I2C_REG_CONTROL_ACK			0x00000004
+#define	MV64XXX_I2C_REG_CONTROL_IFLG			0x00000008
+#define	MV64XXX_I2C_REG_CONTROL_STOP			0x00000010
+#define	MV64XXX_I2C_REG_CONTROL_START			0x00000020
+#define	MV64XXX_I2C_REG_CONTROL_TWSIEN			0x00000040
+#define	MV64XXX_I2C_REG_CONTROL_INTEN			0x00000080
+
+/* Ctlr status values */
+#define	MV64XXX_I2C_STATUS_BUS_ERR			0x00
+#define	MV64XXX_I2C_STATUS_MAST_START			0x08
+#define	MV64XXX_I2C_STATUS_MAST_REPEAT_START		0x10
+#define	MV64XXX_I2C_STATUS_MAST_WR_ADDR_ACK		0x18
+#define	MV64XXX_I2C_STATUS_MAST_WR_ADDR_NO_ACK		0x20
+#define	MV64XXX_I2C_STATUS_MAST_WR_ACK			0x28
+#define	MV64XXX_I2C_STATUS_MAST_WR_NO_ACK		0x30
+#define	MV64XXX_I2C_STATUS_MAST_LOST_ARB		0x38
+#define	MV64XXX_I2C_STATUS_MAST_RD_ADDR_ACK		0x40
+#define	MV64XXX_I2C_STATUS_MAST_RD_ADDR_NO_ACK		0x48
+#define	MV64XXX_I2C_STATUS_MAST_RD_DATA_ACK		0x50
+#define	MV64XXX_I2C_STATUS_MAST_RD_DATA_NO_ACK		0x58
+#define	MV64XXX_I2C_STATUS_MAST_WR_ADDR_2_ACK		0xd0
+#define	MV64XXX_I2C_STATUS_MAST_WR_ADDR_2_NO_ACK	0xd8
+#define	MV64XXX_I2C_STATUS_MAST_RD_ADDR_2_ACK		0xe0
+#define	MV64XXX_I2C_STATUS_MAST_RD_ADDR_2_NO_ACK	0xe8
+#define	MV64XXX_I2C_STATUS_NO_STATUS			0xf8
+
+/* Driver states */
+enum {
+	MV64XXX_I2C_STATE_INVALID,
+	MV64XXX_I2C_STATE_IDLE,
+	MV64XXX_I2C_STATE_WAITING_FOR_START_COND,
+	MV64XXX_I2C_STATE_WAITING_FOR_ADDR_1_ACK,
+	MV64XXX_I2C_STATE_WAITING_FOR_ADDR_2_ACK,
+	MV64XXX_I2C_STATE_WAITING_FOR_SLAVE_ACK,
+	MV64XXX_I2C_STATE_WAITING_FOR_SLAVE_DATA,
+	MV64XXX_I2C_STATE_ABORTING,
+};
+
+/* Driver actions */
+enum {
+	MV64XXX_I2C_ACTION_INVALID,
+	MV64XXX_I2C_ACTION_CONTINUE,
+	MV64XXX_I2C_ACTION_SEND_START,
+	MV64XXX_I2C_ACTION_SEND_ADDR_1,
+	MV64XXX_I2C_ACTION_SEND_ADDR_2,
+	MV64XXX_I2C_ACTION_SEND_DATA,
+	MV64XXX_I2C_ACTION_RCV_DATA,
+	MV64XXX_I2C_ACTION_RCV_DATA_STOP,
+	MV64XXX_I2C_ACTION_SEND_STOP,
+};
+
+struct mv64xxx_i2c_data {
+	int			irq;
+	u32			state;
+	u32			action;
+	u32			cntl_bits;
+	void __iomem		*reg_base;
+	u32			reg_base_p;
+	u32			addr1;
+	u32			addr2;
+	u32			bytes_left;
+	u32			byte_posn;
+	u32			block;
+	int			rc;
+	u32			freq_m;
+	u32			freq_n;
+	wait_queue_head_t	waitq;
+	spinlock_t		lock;
+	struct i2c_msg		*msg;
+	struct i2c_adapter	adapter;
+};
+
+/*
+ *****************************************************************************
+ *
+ *	Finite State Machine & Interrupt Routines
+ *
+ *****************************************************************************
+ */
+static void
+mv64xxx_i2c_fsm(struct mv64xxx_i2c_data *drv_data, u32 status)
+{
+	/*
+	 * If state is idle, then this is likely the remnants of an old
+	 * operation that driver has given up on or the user has killed.
+	 * If so, issue the stop condition and go to idle.
+	 */
+	if (drv_data->state == MV64XXX_I2C_STATE_IDLE) {
+		drv_data->action = MV64XXX_I2C_ACTION_SEND_STOP;
+		return;
+	}
+
+	if (drv_data->state == MV64XXX_I2C_STATE_ABORTING) {
+		drv_data->action = MV64XXX_I2C_ACTION_SEND_STOP;
+		drv_data->state = MV64XXX_I2C_STATE_IDLE;
+		return;
+	}
+
+	/* The status from the ctlr [mostly] tells us what to do next */
+	switch (status) {
+	/* Start condition interrupt */
+	case MV64XXX_I2C_STATUS_MAST_START: /* 0x08 */
+	case MV64XXX_I2C_STATUS_MAST_REPEAT_START: /* 0x10 */
+		drv_data->action = MV64XXX_I2C_ACTION_SEND_ADDR_1;
+		drv_data->state = MV64XXX_I2C_STATE_WAITING_FOR_ADDR_1_ACK;
+		break;
+
+	/* Performing a write */
+	case MV64XXX_I2C_STATUS_MAST_WR_ADDR_ACK: /* 0x18 */
+		if (drv_data->msg->flags & I2C_M_TEN) {
+			drv_data->action = MV64XXX_I2C_ACTION_SEND_ADDR_2;
+			drv_data->state =
+				MV64XXX_I2C_STATE_WAITING_FOR_ADDR_2_ACK;
+			break;
+		}
+		/* FALLTHRU */
+	case MV64XXX_I2C_STATUS_MAST_WR_ADDR_2_ACK: /* 0xd0 */
+	case MV64XXX_I2C_STATUS_MAST_WR_ACK: /* 0x28 */
+		if (drv_data->bytes_left > 0) {
+			drv_data->action = MV64XXX_I2C_ACTION_SEND_DATA;
+			drv_data->state =
+				MV64XXX_I2C_STATE_WAITING_FOR_SLAVE_ACK;
+			drv_data->bytes_left--;
+		} else {
+			drv_data->action = MV64XXX_I2C_ACTION_SEND_STOP;
+			drv_data->state = MV64XXX_I2C_STATE_IDLE;
+		}
+		break;
+
+	/* Performing a read */
+	case MV64XXX_I2C_STATUS_MAST_RD_ADDR_ACK: /* 40 */
+		if (drv_data->msg->flags & I2C_M_TEN) {
+			drv_data->action = MV64XXX_I2C_ACTION_SEND_ADDR_2;
+			drv_data->state =
+				MV64XXX_I2C_STATE_WAITING_FOR_ADDR_2_ACK;
+			break;
+		}
+		/* FALLTHRU */
+	case MV64XXX_I2C_STATUS_MAST_RD_ADDR_2_ACK: /* 0xe0 */
+		if (drv_data->bytes_left == 0) {
+			drv_data->action = MV64XXX_I2C_ACTION_SEND_STOP;
+			drv_data->state = MV64XXX_I2C_STATE_IDLE;
+			break;
+		}
+		/* FALLTHRU */
+	case MV64XXX_I2C_STATUS_MAST_RD_DATA_ACK: /* 0x50 */
+		if (status != MV64XXX_I2C_STATUS_MAST_RD_DATA_ACK)
+			drv_data->action = MV64XXX_I2C_ACTION_CONTINUE;
+		else {
+			drv_data->action = MV64XXX_I2C_ACTION_RCV_DATA;
+			drv_data->bytes_left--;
+		}
+		drv_data->state = MV64XXX_I2C_STATE_WAITING_FOR_SLAVE_DATA;
+
+		if (drv_data->bytes_left == 1)
+			drv_data->cntl_bits &= ~MV64XXX_I2C_REG_CONTROL_ACK;
+		break;
+
+	case MV64XXX_I2C_STATUS_MAST_RD_DATA_NO_ACK: /* 0x58 */
+		drv_data->action = MV64XXX_I2C_ACTION_RCV_DATA_STOP;
+		drv_data->state = MV64XXX_I2C_STATE_IDLE;
+		break;
+
+	case MV64XXX_I2C_STATUS_MAST_WR_ADDR_NO_ACK: /* 0x20 */
+	case MV64XXX_I2C_STATUS_MAST_WR_NO_ACK: /* 30 */
+	case MV64XXX_I2C_STATUS_MAST_RD_ADDR_NO_ACK: /* 48 */
+		/* Doesn't seem to be a device at other end */
+		drv_data->action = MV64XXX_I2C_ACTION_SEND_STOP;
+		drv_data->state = MV64XXX_I2C_STATE_IDLE;
+		drv_data->rc = -ENODEV;
+		break;
+
+	default:
+		dev_err(&drv_data->adapter.dev,
+			"mv64xxx_i2c_fsm: Ctlr Error -- state: 0x%x, "
+			"status: 0x%x, addr: 0x%x, flags: 0x%x\n",
+			 drv_data->state, status, drv_data->msg->addr,
+			 drv_data->msg->flags);
+		drv_data->action = MV64XXX_I2C_ACTION_SEND_STOP;
+		drv_data->state = MV64XXX_I2C_STATE_IDLE;
+		drv_data->rc = -EIO;
+	}
+}
+
+static void
+mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
+{
+	switch(drv_data->action) {
+	case MV64XXX_I2C_ACTION_CONTINUE:
+		writel(drv_data->cntl_bits,
+			drv_data->reg_base + MV64XXX_I2C_REG_CONTROL);
+		break;
+
+	case MV64XXX_I2C_ACTION_SEND_START:
+		writel(drv_data->cntl_bits | MV64XXX_I2C_REG_CONTROL_START,
+			drv_data->reg_base + MV64XXX_I2C_REG_CONTROL);
+		break;
+
+	case MV64XXX_I2C_ACTION_SEND_ADDR_1:
+		writel(drv_data->addr1,
+			drv_data->reg_base + MV64XXX_I2C_REG_DATA);
+		writel(drv_data->cntl_bits,
+			drv_data->reg_base + MV64XXX_I2C_REG_CONTROL);
+		break;
+
+	case MV64XXX_I2C_ACTION_SEND_ADDR_2:
+		writel(drv_data->addr2,
+			drv_data->reg_base + MV64XXX_I2C_REG_DATA);
+		writel(drv_data->cntl_bits,
+			drv_data->reg_base + MV64XXX_I2C_REG_CONTROL);
+		break;
+
+	case MV64XXX_I2C_ACTION_SEND_DATA:
+		writel(drv_data->msg->buf[drv_data->byte_posn++],
+			drv_data->reg_base + MV64XXX_I2C_REG_DATA);
+		writel(drv_data->cntl_bits,
+			drv_data->reg_base + MV64XXX_I2C_REG_CONTROL);
+		break;
+
+	case MV64XXX_I2C_ACTION_RCV_DATA:
+		drv_data->msg->buf[drv_data->byte_posn++] =
+			readl(drv_data->reg_base + MV64XXX_I2C_REG_DATA);
+		writel(drv_data->cntl_bits,
+			drv_data->reg_base + MV64XXX_I2C_REG_CONTROL);
+		break;
+
+	case MV64XXX_I2C_ACTION_RCV_DATA_STOP:
+		drv_data->msg->buf[drv_data->byte_posn++] =
+			readl(drv_data->reg_base + MV64XXX_I2C_REG_DATA);
+		drv_data->cntl_bits &= ~MV64XXX_I2C_REG_CONTROL_INTEN;
+		writel(drv_data->cntl_bits | MV64XXX_I2C_REG_CONTROL_STOP,
+			drv_data->reg_base + MV64XXX_I2C_REG_CONTROL);
+		drv_data->block = 0;
+		wake_up_interruptible(&drv_data->waitq);
+		break;
+
+	case MV64XXX_I2C_ACTION_INVALID:
+	default:
+		dev_err(&drv_data->adapter.dev,
+			"mv64xxx_i2c_do_action: Invalid action: %d\n",
+			drv_data->action);
+		drv_data->rc = -EIO;
+		/* FALLTHRU */
+	case MV64XXX_I2C_ACTION_SEND_STOP:
+		drv_data->cntl_bits &= ~MV64XXX_I2C_REG_CONTROL_INTEN;
+		writel(drv_data->cntl_bits | MV64XXX_I2C_REG_CONTROL_STOP,
+			drv_data->reg_base + MV64XXX_I2C_REG_CONTROL);
+		drv_data->block = 0;
+		wake_up_interruptible(&drv_data->waitq);
+		break;
+	}
+}
+
+static int
+mv64xxx_i2c_intr(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct mv64xxx_i2c_data	*drv_data = dev_id;
+	unsigned long	flags;
+	u32		status;
+	int		rc = IRQ_NONE;
+
+	spin_lock_irqsave(&drv_data->lock, flags);
+	while (readl(drv_data->reg_base + MV64XXX_I2C_REG_CONTROL) &
+						MV64XXX_I2C_REG_CONTROL_IFLG) {
+		status = readl(drv_data->reg_base + MV64XXX_I2C_REG_STATUS);
+		mv64xxx_i2c_fsm(drv_data, status);
+		mv64xxx_i2c_do_action(drv_data);
+		rc = IRQ_HANDLED;
+	}
+	spin_unlock_irqrestore(&drv_data->lock, flags);
+
+	return rc;
+}
+
+/*
+ *****************************************************************************
+ *
+ *	I2C Msg Execution Routines
+ *
+ *****************************************************************************
+ */
+static void
+mv64xxx_i2c_prepare_for_io(struct mv64xxx_i2c_data *drv_data,
+	struct i2c_msg *msg)
+{
+	u32	dir = 0;
+
+	drv_data->msg = msg;
+	drv_data->byte_posn = 0;
+	drv_data->bytes_left = msg->len;
+	drv_data->rc = 0;
+	drv_data->cntl_bits = MV64XXX_I2C_REG_CONTROL_ACK |
+		MV64XXX_I2C_REG_CONTROL_INTEN | MV64XXX_I2C_REG_CONTROL_TWSIEN;
+
+	if (msg->flags & I2C_M_RD)
+		dir = 1;
+
+	if (msg->flags & I2C_M_REV_DIR_ADDR)
+		dir ^= 1;
+
+	if (msg->flags & I2C_M_TEN) {
+		drv_data->addr1 = 0xf0 | (((u32)msg->addr & 0x300) >> 7) | dir;
+		drv_data->addr2 = (u32)msg->addr & 0xff;
+	} else {
+		drv_data->addr1 = ((u32)msg->addr & 0x7f) << 1 | dir;
+		drv_data->addr2 = 0;
+	}
+}
+
+static void
+mv64xxx_i2c_wait_for_completion(struct mv64xxx_i2c_data *drv_data)
+{
+	long		time_left;
+	unsigned long	flags;
+	char		abort = 0;
+
+	time_left = wait_event_interruptible_timeout(drv_data->waitq,
+		!drv_data->block, msecs_to_jiffies(drv_data->adapter.timeout));
+
+	spin_lock_irqsave(&drv_data->lock, flags);
+	if (!time_left) { /* Timed out */
+		drv_data->rc = -ETIMEDOUT;
+		abort = 1;
+	} else if (time_left < 0) { /* Interrupted/Error */
+		drv_data->rc = time_left; /* errno value */
+		abort = 1;
+	}
+
+	if (abort && drv_data->block) {
+		drv_data->state = MV64XXX_I2C_STATE_ABORTING;
+		spin_unlock_irqrestore(&drv_data->lock, flags);
+
+		time_left = wait_event_timeout(drv_data->waitq,
+			!drv_data->block,
+			msecs_to_jiffies(drv_data->adapter.timeout));
+
+		if (time_left <= 0) {
+			drv_data->state = MV64XXX_I2C_STATE_IDLE;
+			dev_err(&drv_data->adapter.dev,
+				"mv64xxx: I2C bus locked\n");
+		}
+	} else
+		spin_unlock_irqrestore(&drv_data->lock, flags);
+}
+
+static int
+mv64xxx_i2c_execute_msg(struct mv64xxx_i2c_data *drv_data, struct i2c_msg *msg)
+{
+	unsigned long	flags;
+
+	spin_lock_irqsave(&drv_data->lock, flags);
+	mv64xxx_i2c_prepare_for_io(drv_data, msg);
+
+	if (unlikely(msg->flags & I2C_M_NOSTART)) { /* Skip start/addr phases */
+		if (drv_data->msg->flags & I2C_M_RD) {
+			/* No action to do, wait for slave to send a byte */
+			drv_data->action = MV64XXX_I2C_ACTION_CONTINUE;
+			drv_data->state =
+				MV64XXX_I2C_STATE_WAITING_FOR_SLAVE_DATA;
+		} else {
+			drv_data->action = MV64XXX_I2C_ACTION_SEND_DATA;
+			drv_data->state =
+				MV64XXX_I2C_STATE_WAITING_FOR_SLAVE_ACK;
+			drv_data->bytes_left--;
+		}
+	} else {
+		drv_data->action = MV64XXX_I2C_ACTION_SEND_START;
+		drv_data->state = MV64XXX_I2C_STATE_WAITING_FOR_START_COND;
+	}
+
+	drv_data->block = 1;
+	mv64xxx_i2c_do_action(drv_data);
+	spin_unlock_irqrestore(&drv_data->lock, flags);
+
+	mv64xxx_i2c_wait_for_completion(drv_data);
+	return drv_data->rc;
+}
+
+/*
+ *****************************************************************************
+ *
+ *	I2C Core Support Routines (Interface to higher level I2C code)
+ *
+ *****************************************************************************
+ */
+static u32
+mv64xxx_i2c_functionality(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR | I2C_FUNC_SMBUS_EMUL;
+}
+
+static int
+mv64xxx_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
+{
+	struct mv64xxx_i2c_data *drv_data = i2c_get_adapdata(adap);
+	int	i, rc = 0;
+
+	for (i=0; i<num; i++)
+		if ((rc = mv64xxx_i2c_execute_msg(drv_data, &msgs[i])) != 0)
+			break;
+
+	return rc;
+}
+
+static struct i2c_algorithm mv64xxx_i2c_algo = {
+	.name = MV64XXX_I2C_CTLR_NAME " algorithm",
+	.id = I2C_ALGO_MV64XXX,
+	.master_xfer = mv64xxx_i2c_xfer,
+	.functionality = mv64xxx_i2c_functionality,
+};
+
+/*
+ *****************************************************************************
+ *
+ *	Driver Interface & Early Init Routines
+ *
+ *****************************************************************************
+ */
+static void __devinit
+mv64xxx_i2c_hw_init(struct mv64xxx_i2c_data *drv_data)
+{
+	writel(0, drv_data->reg_base + MV64XXX_I2C_REG_SOFT_RESET);
+	writel((((drv_data->freq_m & 0xf) << 3) | (drv_data->freq_n & 0x7)),
+		drv_data->reg_base + MV64XXX_I2C_REG_BAUD);
+	writel(0, drv_data->reg_base + MV64XXX_I2C_REG_SLAVE_ADDR);
+	writel(0, drv_data->reg_base + MV64XXX_I2C_REG_EXT_SLAVE_ADDR);
+	writel(MV64XXX_I2C_REG_CONTROL_TWSIEN | MV64XXX_I2C_REG_CONTROL_STOP,
+		drv_data->reg_base + MV64XXX_I2C_REG_CONTROL);
+	drv_data->state = MV64XXX_I2C_STATE_IDLE;
+}
+
+static int __devinit
+mv64xxx_i2c_map_regs(struct platform_device *pd,
+	struct mv64xxx_i2c_data *drv_data)
+{
+	struct resource	*r;
+
+	if ((r = platform_get_resource(pd, IORESOURCE_MEM, 0)) &&
+		request_mem_region(r->start, MV64XXX_I2C_REG_BLOCK_SIZE,
+			drv_data->adapter.name)) {
+
+		drv_data->reg_base = ioremap(r->start,
+			MV64XXX_I2C_REG_BLOCK_SIZE);
+		drv_data->reg_base_p = r->start;
+	} else
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void __devexit
+mv64xxx_i2c_unmap_regs(struct mv64xxx_i2c_data *drv_data)
+{
+	if (drv_data->reg_base) {
+		iounmap(drv_data->reg_base);
+		release_mem_region(drv_data->reg_base_p,
+			MV64XXX_I2C_REG_BLOCK_SIZE);
+	}
+
+	drv_data->reg_base = NULL;
+	drv_data->reg_base_p = 0;
+}
+
+static int __devinit
+mv64xxx_i2c_probe(struct device *dev)
+{
+	struct platform_device		*pd = to_platform_device(dev);
+	struct mv64xxx_i2c_data		*drv_data;
+	struct mv64xxx_i2c_pdata	*pdata = dev->platform_data;
+	int	rc;
+
+	if ((pd->id != 0) || !pdata)
+		return -ENODEV;
+
+	drv_data = kmalloc(sizeof(struct mv64xxx_i2c_data), GFP_KERNEL);
+
+	if (!drv_data)
+		return -ENOMEM;
+
+	memset(drv_data, 0, sizeof(struct mv64xxx_i2c_data));
+
+	if (mv64xxx_i2c_map_regs(pd, drv_data)) {
+		rc = -ENODEV;
+		goto exit_kfree;
+	}
+
+	strncpy(drv_data->adapter.name, MV64XXX_I2C_CTLR_NAME " adapter",
+		I2C_NAME_SIZE);
+
+	init_waitqueue_head(&drv_data->waitq);
+	spin_lock_init(&drv_data->lock);
+
+	drv_data->freq_m = pdata->freq_m;
+	drv_data->freq_n = pdata->freq_n;
+	drv_data->irq = platform_get_irq(pd, 0);
+	drv_data->adapter.id = I2C_ALGO_MV64XXX | I2C_HW_MV64XXX;
+	drv_data->adapter.algo = &mv64xxx_i2c_algo;
+	drv_data->adapter.timeout = pdata->timeout;
+	drv_data->adapter.retries = pdata->retries;
+	dev_set_drvdata(dev, drv_data);
+	i2c_set_adapdata(&drv_data->adapter, drv_data);
+
+	if (request_irq(drv_data->irq, mv64xxx_i2c_intr, 0,
+		MV64XXX_I2C_CTLR_NAME, drv_data)) {
+
+		dev_err(dev, "mv64xxx: Can't register intr handler "
+			"irq: %d\n", drv_data->irq);
+		rc = -EINVAL;
+		goto exit_unmap_regs;
+	} else if ((rc = i2c_add_adapter(&drv_data->adapter)) != 0) {
+		dev_err(dev, "mv64xxx: Can't add i2c adapter, rc: %d\n", -rc);
+		goto exit_free_irq;
+	}
+
+	mv64xxx_i2c_hw_init(drv_data);
+
+	return 0;
+
+	exit_free_irq:
+		free_irq(drv_data->irq, drv_data);
+	exit_unmap_regs:
+		mv64xxx_i2c_unmap_regs(drv_data);
+	exit_kfree:
+		kfree(drv_data);
+	return rc;
+}
+
+static int __devexit
+mv64xxx_i2c_remove(struct device *dev)
+{
+	struct mv64xxx_i2c_data		*drv_data = dev_get_drvdata(dev);
+	int	rc;
+
+	rc = i2c_del_adapter(&drv_data->adapter);
+	free_irq(drv_data->irq, drv_data);
+	mv64xxx_i2c_unmap_regs(drv_data);
+	kfree(drv_data);
+
+	return rc;
+}
+
+static struct device_driver mv64xxx_i2c_driver = {
+	.name	= MV64XXX_I2C_CTLR_NAME,
+	.bus	= &platform_bus_type,
+	.probe	= mv64xxx_i2c_probe,
+	.remove	= mv64xxx_i2c_remove,
+};
+
+static int __init
+mv64xxx_i2c_init(void)
+{
+	return driver_register(&mv64xxx_i2c_driver);
+}
+
+static void __exit
+mv64xxx_i2c_exit(void)
+{
+	driver_unregister(&mv64xxx_i2c_driver);
+}
+
+module_init(mv64xxx_i2c_init);
+module_exit(mv64xxx_i2c_exit);
+
+MODULE_AUTHOR("Mark A. Greer <mgreer@mvista.com>");
+MODULE_DESCRIPTION("Marvell mv64xxx host bridge i2c ctlr driver");
+MODULE_LICENSE("GPL");
diff -Nru a/include/linux/i2c-id.h b/include/linux/i2c-id.h
--- a/include/linux/i2c-id.h	2005-03-04 12:24:29 -08:00
+++ b/include/linux/i2c-id.h	2005-03-04 12:24:29 -08:00
@@ -310,4 +310,7 @@
 /* --- MCP107 adapter */
 #define I2C_HW_MPC107 0x00
 
+/* --- Marvell mv64xxx i2c adapter */
+#define I2C_HW_MV64XXX 0x00
+
 #endif /* LINUX_I2C_ID_H */
diff -Nru a/include/linux/mv643xx.h b/include/linux/mv643xx.h
--- a/include/linux/mv643xx.h	2005-03-04 12:24:29 -08:00
+++ b/include/linux/mv643xx.h	2005-03-04 12:24:29 -08:00
@@ -977,12 +977,9 @@
 /* I2C Registers                        */
 /****************************************/
 
-#define MV64340_I2C_SLAVE_ADDR                                      0xc000
-#define MV64340_I2C_EXTENDED_SLAVE_ADDR                             0xc010
-#define MV64340_I2C_DATA                                            0xc004
-#define MV64340_I2C_CONTROL                                         0xc008
-#define MV64340_I2C_STATUS_BAUDE_RATE                               0xc00C
-#define MV64340_I2C_SOFT_RESET                                      0xc01c
+#define MV64XXX_I2C_CTLR_NAME					"mv64xxx i2c"
+#define MV64XXX_I2C_OFFSET                                          0xc000
+#define MV64XXX_I2C_REG_BLOCK_SIZE                                  0x0020
 
 /****************************************/
 /* GPP Interface Registers              */
@@ -1083,6 +1080,14 @@
 	u8	brg_can_tune;
 	u8	brg_clk_src;
 	u32	brg_clk_freq;
+};
+
+/* i2c Platform Device, Driver Data */
+struct mv64xxx_i2c_pdata {
+	u32	freq_m;
+	u32	freq_n;
+	u32	timeout;	/* In milliseconds */
+	u32	retries;
 };
 
 #endif /* __ASM_MV64340_H */

