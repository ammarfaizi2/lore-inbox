Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262271AbVA0A3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbVA0A3z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 19:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbVA0A1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:27:45 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:6648 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262271AbVAZX7r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 18:59:47 -0500
Message-ID: <41F82EE9.6020709@mvista.com>
Date: Wed, 26 Jan 2005 16:59:37 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][I2C] Marvell mv64xxx i2c driver
References: <41F6F1D5.90601@mvista.com> <20050126205619.4c0b41fa.khali@linux-fr.org> <41F81227.6070101@mvista.com> <20050126224231.GA4874@kroah.com>
In-Reply-To: <20050126224231.GA4874@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------010201060801070105090904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------010201060801070105090904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:

>Please put <asm/ after <linux/
>

Done.

>You have a lot of pr_debug and other printk() for stuff in this driver.
>Please use dev_dbg(), dev_err() and friends instead.  That way you get a
>consistant message, that points to the exact device that is causing the
>message.
>

Cool.  Done.

>You have some big inline functions here.  Should they really be inline?
>We aren't really worried about speed here, right?  Size is probably a
>bigger issue.
>

No, no, and done.

>
>Is this header file really needed?  Does any other file other than this
>single driver ever include it?  If not, please just put it into the
>driver itself.
>  
>

No, no, and done.

Included is an *incremental* patch that I hope addresses your concerns.

Thanks Greg.

Mark
--

--------------010201060801070105090904
Content-Type: text/plain;
 name="i2c_3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c_3.patch"

diff -Nru a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
--- a/drivers/i2c/busses/i2c-mv64xxx.c	2005-01-26 16:52:56 -07:00
+++ b/drivers/i2c/busses/i2c-mv64xxx.c	2005-01-26 16:52:56 -07:00
@@ -11,21 +11,94 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/sched.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/wait.h>
 #include <linux/spinlock.h>
-#include <asm/io.h>
-#include <asm/ocp.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
-#include <linux/delay.h>
 #include <linux/mv643xx.h>
-#include "i2c-mv64xxx.h"
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
+	uint			state;
+	uint			action;
+	u32			cntl_bits;
+	void			*reg_base;
+	ulong			reg_base_p;
+	u32			addr1;
+	u32			addr2;
+	uint			bytes_left;
+	uint			byte_posn;
+	uint			block;
+	int			rc;
+	u32			freq_m;
+	u32			freq_n;
+	wait_queue_head_t	waitq;
+	spinlock_t		lock;
+	struct i2c_msg		*msg;
+	struct i2c_adapter	adapter;
+};
 
 /*
  *****************************************************************************
@@ -34,12 +107,9 @@
  *
  *****************************************************************************
  */
-static inline void
+static void
 mv64xxx_i2c_fsm(struct mv64xxx_i2c_data *drv_data, u32 status)
 {
-	pr_debug("mv64xxx_i2c_fsm: ENTER--state: %d, status: 0x%x\n",
-		drv_data->state, status);
-
 	/*
 	 * If state is idle, then this is likely the remnants of an old
 	 * operation that driver has given up on or the user has killed.
@@ -48,14 +118,12 @@
 	if (drv_data->state == MV64XXX_I2C_STATE_IDLE) {
 		drv_data->action = MV64XXX_I2C_ACTION_SEND_STOP;
 		drv_data->state = MV64XXX_I2C_STATE_IDLE;
-		pr_debug("mv64xxx_i2c_fsm: EXIT--Entered when in IDLE state\n");
 		return;
 	}
 
 	if (drv_data->state == MV64XXX_I2C_STATE_ABORTING) {
 		drv_data->action = MV64XXX_I2C_ACTION_SEND_STOP;
 		drv_data->state = MV64XXX_I2C_STATE_IDLE;
-		pr_debug("mv64xxx_i2c_fsm: EXIT--Aborting\n");
 		return;
 	}
 
@@ -135,27 +203,22 @@
 		break;
 
 	default:
-		printk(KERN_ERR "mv64xxx_i2c_fsm: Ctlr Error -- "
-			"state: 0x%x, status: 0x%x\n", drv_data->state, status);
-		printk(KERN_INFO "addr: 0x%x, flags: 0x%x\n",
-			drv_data->msg->addr, drv_data->msg->flags);
+		dev_err(&drv_data->adapter.dev,
+			"mv64xxx_i2c_fsm: Ctlr Error -- state: 0x%x, "
+			"status: 0x%x, addr: 0x%x, flags: 0x%x\n",
+			 drv_data->state, status, drv_data->msg->addr,
+			 drv_data->msg->flags);
 		drv_data->action = MV64XXX_I2C_ACTION_SEND_STOP;
 		drv_data->state = MV64XXX_I2C_STATE_IDLE;
 		drv_data->rc = -EIO;
 	}
 
-	pr_debug("mv64xxx_i2c_fsm: EXIT--action: %d, state: %d, rc: 0x%x\n",
-		drv_data->action, drv_data->state, drv_data->rc);
 	return;
 }
 
 static void
 mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 {
-	pr_debug("mv64xxx_i2c_do_action: ENTER--action: %d, state: %d, "
-		"cntl: 0x%x\n", drv_data->action, drv_data->state,
-		drv_data->cntl_bits);
-
 	switch(drv_data->action) {
 	case MV64XXX_I2C_ACTION_CONTINUE:
 		writel(drv_data->cntl_bits,
@@ -207,7 +270,8 @@
 
 	case MV64XXX_I2C_ACTION_INVALID:
 	default:
-		printk(KERN_ERR "mv64xxx_i2c_do_action: Invalid action: %d\n",
+		dev_err(&drv_data->adapter.dev,
+			"mv64xxx_i2c_do_action: Invalid action: %d\n",
 			drv_data->action);
 		drv_data->rc = -EIO;
 		/* FALLTHRU */
@@ -220,7 +284,6 @@
 		break;
 	}
 
-	pr_debug("mv64xxx_i2c_do_action: EXIT\n");
 	return;
 }
 
@@ -252,7 +315,7 @@
  *
  *****************************************************************************
  */
-static inline void
+static void
 mv64xxx_i2c_prepare_for_io(struct mv64xxx_i2c_data *drv_data,
 	struct i2c_msg *msg)
 {
@@ -283,7 +346,7 @@
 	return;
 }
 
-static inline void
+static void
 mv64xxx_i2c_wait_for_completion(struct mv64xxx_i2c_data *drv_data)
 {
 	long	flags, time_left;
@@ -312,7 +375,8 @@
 
 		if (!time_left <= 0) {
 			drv_data->state = MV64XXX_I2C_STATE_IDLE;
-			printk(KERN_WARNING "mv64xxx: I2C bus locked\n");
+			dev_err(&drv_data->adapter.dev,
+				"mv64xxx: I2C bus locked\n");
 		}
 	}
 	else
@@ -321,7 +385,7 @@
 	return;
 }
 
-static inline int
+static int
 mv64xxx_i2c_execute_msg(struct mv64xxx_i2c_data *drv_data, struct i2c_msg *msg)
 {
 	long	flags;
@@ -484,7 +548,7 @@
 		if (request_irq(drv_data->irq, mv64xxx_i2c_intr, 0,
 			MV64XXX_I2C_CTLR_NAME, drv_data)) {
 
-			printk(KERN_ERR "mv64xxx: Can't register intr handler "
+			dev_err(dev, "mv64xxx: Can't register intr handler "
 				"irq: %d\\n", drv_data->irq);
 
 			mv64xxx_i2c_unmap_regs(drv_data);
@@ -492,8 +556,8 @@
 			return -EINVAL;
 		}
 		else if ((rc = i2c_add_adapter(&drv_data->adapter)) != 0) {
-			printk(KERN_WARNING "mv64xxx: Can't add i2c adapter "
-				"rc: %d\n", -rc);
+			dev_err(dev, "mv64xxx: Can't add i2c adapter, rc: %d\n",
+				-rc);
 			free_irq(drv_data->irq, drv_data);
 			mv64xxx_i2c_unmap_regs(drv_data);
 			kfree(drv_data);
diff -Nru a/drivers/i2c/busses/i2c-mv64xxx.h b/drivers/i2c/busses/i2c-mv64xxx.h
--- a/drivers/i2c/busses/i2c-mv64xxx.h	2005-01-26 16:52:56 -07:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,99 +0,0 @@
-/*
- * drivers/i2c/busses/i2c-mv64xxx.h
- * 
- * Driver for the i2c controller on the Marvell line of host bridges for MIPS
- * and PPC (e.g, gt642[46]0, mv643[46]0, mv644[46]0).
- *
- * Author: Mark A. Greer <mgreer@mvista.com>
- *
- * 2005 (c) MontaVista, Software, Inc.  This file is licensed under
- * the terms of the GNU General Public License version 2.  This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-
-#ifndef I2C_MV64XXX_H
-#define I2C_MV64XXX_H
-
-/* Register defines */
-#define	MV64XXX_I2C_REG_SLAVE_ADDR			0x00
-#define	MV64XXX_I2C_REG_DATA				0x04
-#define	MV64XXX_I2C_REG_CONTROL				0x08
-#define	MV64XXX_I2C_REG_STATUS				0x0c
-#define	MV64XXX_I2C_REG_BAUD				0x0c
-#define	MV64XXX_I2C_REG_EXT_SLAVE_ADDR			0x10
-#define	MV64XXX_I2C_REG_SOFT_RESET			0x1c
-
-#define	MV64XXX_I2C_REG_CONTROL_ACK			0x00000004
-#define	MV64XXX_I2C_REG_CONTROL_IFLG			0x00000008
-#define	MV64XXX_I2C_REG_CONTROL_STOP			0x00000010
-#define	MV64XXX_I2C_REG_CONTROL_START			0x00000020
-#define	MV64XXX_I2C_REG_CONTROL_TWSIEN			0x00000040
-#define	MV64XXX_I2C_REG_CONTROL_INTEN			0x00000080
-
-/* Ctlr status values */
-#define	MV64XXX_I2C_STATUS_BUS_ERR			0x00
-#define	MV64XXX_I2C_STATUS_MAST_START			0x08
-#define	MV64XXX_I2C_STATUS_MAST_REPEAT_START		0x10
-#define	MV64XXX_I2C_STATUS_MAST_WR_ADDR_ACK		0x18
-#define	MV64XXX_I2C_STATUS_MAST_WR_ADDR_NO_ACK		0x20
-#define	MV64XXX_I2C_STATUS_MAST_WR_ACK			0x28
-#define	MV64XXX_I2C_STATUS_MAST_WR_NO_ACK		0x30
-#define	MV64XXX_I2C_STATUS_MAST_LOST_ARB		0x38
-#define	MV64XXX_I2C_STATUS_MAST_RD_ADDR_ACK		0x40
-#define	MV64XXX_I2C_STATUS_MAST_RD_ADDR_NO_ACK		0x48
-#define	MV64XXX_I2C_STATUS_MAST_RD_DATA_ACK		0x50
-#define	MV64XXX_I2C_STATUS_MAST_RD_DATA_NO_ACK		0x58
-#define	MV64XXX_I2C_STATUS_MAST_WR_ADDR_2_ACK		0xd0
-#define	MV64XXX_I2C_STATUS_MAST_WR_ADDR_2_NO_ACK	0xd8
-#define	MV64XXX_I2C_STATUS_MAST_RD_ADDR_2_ACK		0xe0
-#define	MV64XXX_I2C_STATUS_MAST_RD_ADDR_2_NO_ACK	0xe8
-#define	MV64XXX_I2C_STATUS_NO_STATUS			0xf8
-
-/* Driver states */
-enum {
-	MV64XXX_I2C_STATE_INVALID,
-	MV64XXX_I2C_STATE_IDLE,
-	MV64XXX_I2C_STATE_WAITING_FOR_START_COND,
-	MV64XXX_I2C_STATE_WAITING_FOR_ADDR_1_ACK,
-	MV64XXX_I2C_STATE_WAITING_FOR_ADDR_2_ACK,
-	MV64XXX_I2C_STATE_WAITING_FOR_SLAVE_ACK,
-	MV64XXX_I2C_STATE_WAITING_FOR_SLAVE_DATA,
-	MV64XXX_I2C_STATE_ABORTING,
-};
-
-/* Driver actions */
-enum {
-	MV64XXX_I2C_ACTION_INVALID,
-	MV64XXX_I2C_ACTION_CONTINUE,
-	MV64XXX_I2C_ACTION_SEND_START,
-	MV64XXX_I2C_ACTION_SEND_ADDR_1,
-	MV64XXX_I2C_ACTION_SEND_ADDR_2,
-	MV64XXX_I2C_ACTION_SEND_DATA,
-	MV64XXX_I2C_ACTION_RCV_DATA,
-	MV64XXX_I2C_ACTION_RCV_DATA_STOP,
-	MV64XXX_I2C_ACTION_SEND_STOP,
-};
-
-struct mv64xxx_i2c_data {
-	int			irq;
-	uint			state;
-	uint			action;
-	u32			cntl_bits;
-	void			*reg_base;
-	ulong			reg_base_p;
-	u32			addr1;
-	u32			addr2;
-	uint			bytes_left;
-	uint			byte_posn;
-	uint			block;
-	int			rc;
-	u32			freq_m;
-	u32			freq_n;
-	wait_queue_head_t	waitq;
-	spinlock_t		lock;
-	struct i2c_msg		*msg;
-	struct i2c_adapter	adapter;
-};
-
-#endif /* I2C_MV64XXX_H */

--------------010201060801070105090904--

