Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316339AbSHFUyy>; Tue, 6 Aug 2002 16:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316446AbSHFUyf>; Tue, 6 Aug 2002 16:54:35 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:19689 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316339AbSHFUwb>;
	Tue, 6 Aug 2002 16:52:31 -0400
Date: Tue, 6 Aug 2002 13:56:08 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] : ir240_mcp2120_act200l_ma600_drivers-3.diff
Message-ID: <20020806205608.GJ11677@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir240_mcp2120_act200l_ma600_drivers-3.diff :
------------------------------------------
	        <Following patch from Felix Tang>
	o [FEATURE] Dongle driver for mcp2120/crystal hardware
	        <Following patch from Shimizu Takuja/Gerhard Bertelsmann>
	o [FEATURE] Dongle driver for ActiSys 200L hardware
	        <Following patch from Leung/me>
	o [FEATURE] Dongle driver for Mobile Action MA600 hardware


--- linux/include/linux/irda.d7.h	Thu Jun  6 17:55:23 2002
+++ linux/include/linux/irda.h	Thu Jun  6 18:01:42 2002
@@ -67,6 +67,9 @@ typedef enum {
 	IRDA_AIRPORT_DONGLE      = 6,
 	IRDA_OLD_BELKIN_DONGLE   = 7,
 	IRDA_EP7211_IR           = 8,
+	IRDA_MCP2120_DONGLE      = 9,
+	IRDA_ACT200L_DONGLE      = 10,
+	IRDA_MA600_DONGLE        = 11,
 } IRDA_DONGLE;
 
 /* Protocol types to be used for SOCK_DGRAM */
diff -u -p linux/Documentation/Configure.d7.help linux/Documentation/Configure.help
--- linux/Documentation/Configure.d7.help       Tue Aug  6 12:02:46 2002
+++ linux/Documentation/Configure.help  Tue Aug  6 12:03:45 2002
@@ -23524,6 +23524,18 @@ CONFIG_LITELINK_DONGLE
   used by IrTTY.  To activate support for Parallax dongles you will
   have to start irattach like this "irattach -d litelink".
 
+Microchip MCP2120 dongle
+CONFIG_MCP2120_DONGLE
+  Say Y here if you want to build support for the Microchip MCP2120
+  dongle.  If you want to compile it as a module, say M here and read
+  <file:Documentation/modules.txt>.  The MCP2120 dongle attaches to
+  the normal 9-pin serial port connector, and can currently only be
+  used by IrTTY.  To activate support for MCP2120 dongles you will
+  have to insert "irattach -d mcp2120" in the /etc/irda/drivers script.
+
+  You must build this dongle yourself.  For more information see:
+  <http://www.eyetap.org/~tangf/irda_sir_linux.html>
+
 Old Belkin dongle
 CONFIG_OLD_BELKIN_DONGLE
   Say Y here if you want to build support for the Adaptec Airport 1000
@@ -23531,6 +23543,30 @@ CONFIG_OLD_BELKIN_DONGLE
   and read <file:Documentation/modules.txt>.  The module will be
   called old_belkin.o.  Some information is contained in the comments
   at the top of <file:drivers/net/irda/old_belkin.c>.
+ 
+ACTiSYS IR-200L dongle (Experimental)
+CONFIG_ACT200L_DONGLE
+  Say Y here if you want to build support for the ACTiSYS IR-200L
+  dongle. If you want to compile it as a module, say M here and read
+  Documentation/modules.txt. The ACTiSYS IR-200L dongle attaches to
+  the normal 9-pin serial port connector, and can currently only be
+  used by IrTTY. To activate support for ACTiSYS IR-200L dongles
+  you will have to start irattach like this: "irattach -d act200l".
+
+Mobile Action MA600 dongle (Experimental)
+CONFIG_MA600_DONGLE
+  Say Y here if you want to build support for the Mobile Action MA600
+  dongle.  If you want to compile it as a module, say M here and read
+  <file:Documentation/modules.txt>.  The MA600 dongle attaches to
+  the normal 9-pin serial port connector, and can currently only be
+  tested on IrCOMM.  To activate support for MA600 dongles you will
+  have to insert "irattach -d ma600" in the /etc/irda/drivers script.
+  Note: irutils 0.9.15 requires no modification. irutils 0.9.9 needs
+  modification. For more information, download the following tar gzip
+  file.
+
+  There is a pre-compiled module on
+  <http://engsvr.ust.hk/~eetwl95/download/ma600-2.4.x.tar.gz>
 
 VME (Motorola and BVM) support
 CONFIG_VME
diff -u -p -r --new-file linux/drivers/net/irda.d7/Config.in linux/drivers/net/irda/Config.in
--- linux/drivers/net/irda.d7/Config.in	Thu Jun  6 14:43:27 2002
+++ linux/drivers/net/irda/Config.in	Thu Jun  6 18:01:51 2002
@@ -13,9 +13,14 @@ if [ "$CONFIG_DONGLE" != "n" ]; then
    dep_tristate '  Tekram IrMate 210B dongle' CONFIG_TEKRAM_DONGLE $CONFIG_IRDA
    dep_tristate '  Greenwich GIrBIL dongle' CONFIG_GIRBIL_DONGLE $CONFIG_IRDA
    dep_tristate '  Parallax LiteLink dongle' CONFIG_LITELINK_DONGLE $CONFIG_IRDA
+   dep_tristate '  Microchip MCP2120' CONFIG_MCP2120_DONGLE $CONFIG_IRDA
    dep_tristate '  Old Belkin dongle' CONFIG_OLD_BELKIN_DONGLE $CONFIG_IRDA   
    if [ "$CONFIG_ARCH_EP7211" = "y" ]; then
       dep_tristate '  EP7211 I/R support' CONFIG_EP7211_IR $CONFIG_IRDA
+   fi
+   if [ "$CONFIG_EXPERIMENTAL" != "n" ]; then
+      dep_tristate '  ACTiSYS IR-200L dongle (Experimental)' CONFIG_ACT200L_DONGLE $CONFIG_IRDA
+      dep_tristate '  Mobile Action MA600 dongle (Experimental)' CONFIG_MA600_DONGLE $CONFIG_IRDA
    fi
 fi
 
diff -u -p -r --new-file linux/drivers/net/irda.d7/Makefile linux/drivers/net/irda/Makefile
--- linux/drivers/net/irda.d7/Makefile	Thu Jun  6 14:43:27 2002
+++ linux/drivers/net/irda/Makefile	Thu Jun  6 18:01:51 2002
@@ -29,5 +29,8 @@ obj-$(CONFIG_LITELINK_DONGLE)	+= litelin
 obj-$(CONFIG_OLD_BELKIN_DONGLE)	+= old_belkin.o
 obj-$(CONFIG_EP7211_IR)		+= ep7211_ir.o
 obj-$(CONFIG_AU1000_FIR)	+= au1k_ir.o
+obj-$(CONFIG_MCP2120_DONGLE)	+= mcp2120.o
+obj-$(CONFIG_ACT200L_DONGLE)	+= act200l.o
+obj-$(CONFIG_MA600_DONGLE)	+= ma600.o
 
 include $(TOPDIR)/Rules.make
diff -u -p -r --new-file linux/drivers/net/irda.d7/act200l.c linux/drivers/net/irda/act200l.c
--- linux/drivers/net/irda.d7/act200l.c	Wed Dec 31 16:00:00 1969
+++ linux/drivers/net/irda/act200l.c	Thu Jun  6 18:01:51 2002
@@ -0,0 +1,299 @@
+/*********************************************************************
+ *
+ * Filename:      act200l.c
+ * Version:       0.8
+ * Description:   Implementation for the ACTiSYS ACT-IR200L dongle
+ * Status:        Experimental.
+ * Author:        SHIMIZU Takuya <tshimizu@ga2.so-net.ne.jp>
+ * Created at:    Fri Aug  3 17:35:42 2001
+ * Modified at:   Fri Aug 17 10:22:40 2001
+ * Modified by:   SHIMIZU Takuya <tshimizu@ga2.so-net.ne.jp>
+ *
+ *     Copyright (c) 2001 SHIMIZU Takuya, All Rights Reserved.
+ *
+ *     This program is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of
+ *     the License, or (at your option) any later version.
+ *
+ ********************************************************************/
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/tty.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+
+#include <net/irda/irda.h>
+#include <net/irda/irda_device.h>
+#include <net/irda/irtty.h>
+
+static int  act200l_reset(struct irda_task *task);
+static void act200l_open(dongle_t *self, struct qos_info *qos);
+static void act200l_close(dongle_t *self);
+static int  act200l_change_speed(struct irda_task *task);
+
+/* Regsiter 0: Control register #1 */
+#define ACT200L_REG0    0x00
+#define ACT200L_TXEN    0x01 /* Enable transmitter */
+#define ACT200L_RXEN    0x02 /* Enable receiver */
+
+/* Register 1: Control register #2 */
+#define ACT200L_REG1    0x10
+#define ACT200L_LODB    0x01 /* Load new baud rate count value */
+#define ACT200L_WIDE    0x04 /* Expand the maximum allowable pulse */
+
+/* Register 4: Output Power register */
+#define ACT200L_REG4    0x40
+#define ACT200L_OP0     0x01 /* Enable LED1C output */
+#define ACT200L_OP1     0x02 /* Enable LED2C output */
+#define ACT200L_BLKR    0x04
+
+/* Register 5: Receive Mode register */
+#define ACT200L_REG5    0x50
+#define ACT200L_RWIDL   0x01 /* fixed 1.6us pulse mode */
+
+/* Register 6: Receive Sensitivity register #1 */
+#define ACT200L_REG6    0x60
+#define ACT200L_RS0     0x01 /* receive threshold bit 0 */
+#define ACT200L_RS1     0x02 /* receive threshold bit 1 */
+
+/* Register 7: Receive Sensitivity register #2 */
+#define ACT200L_REG7    0x70
+#define ACT200L_ENPOS   0x04 /* Ignore the falling edge */
+
+/* Register 8,9: Baud Rate Dvider register #1,#2 */
+#define ACT200L_REG8    0x80
+#define ACT200L_REG9    0x90
+
+#define ACT200L_2400    0x5f
+#define ACT200L_9600    0x17
+#define ACT200L_19200   0x0b
+#define ACT200L_38400   0x05
+#define ACT200L_57600   0x03
+#define ACT200L_115200  0x01
+
+/* Register 13: Control register #3 */
+#define ACT200L_REG13   0xd0
+#define ACT200L_SHDW    0x01 /* Enable access to shadow registers */
+
+/* Register 15: Status register */
+#define ACT200L_REG15   0xf0
+
+/* Register 21: Control register #4 */
+#define ACT200L_REG21   0x50
+#define ACT200L_EXCK    0x02 /* Disable clock output driver */
+#define ACT200L_OSCL    0x04 /* oscillator in low power, medium accuracy mode */
+
+static struct dongle_reg dongle = {
+	Q_NULL,
+	IRDA_ACT200L_DONGLE,
+	act200l_open,
+	act200l_close,
+	act200l_reset,
+	act200l_change_speed,
+};
+
+int __init act200l_init(void)
+{
+	return irda_device_register_dongle(&dongle);
+}
+
+void __exit act200l_cleanup(void)
+{
+	irda_device_unregister_dongle(&dongle);
+}
+
+static void act200l_open(dongle_t *self, struct qos_info *qos)
+{
+	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+
+	/* Power on the dongle */
+	self->set_dtr_rts(self->dev, TRUE, TRUE);
+
+	/* Set the speeds we can accept */
+	qos->baud_rate.bits &= IR_9600|IR_19200|IR_38400|IR_57600|IR_115200;
+	qos->min_turn_time.bits = 0x03;
+
+	MOD_INC_USE_COUNT;
+}
+
+static void act200l_close(dongle_t *self)
+{
+	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+
+	/* Power off the dongle */
+	self->set_dtr_rts(self->dev, FALSE, FALSE);
+
+	MOD_DEC_USE_COUNT;
+}
+
+/*
+ * Function act200l_change_speed (dev, speed)
+ *
+ *    Set the speed for the ACTiSYS ACT-IR200L type dongle.
+ *
+ */
+static int act200l_change_speed(struct irda_task *task)
+{
+	dongle_t *self = (dongle_t *) task->instance;
+	__u32 speed = (__u32) task->param;
+	__u8 control[3];
+	int ret = 0;
+
+	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+
+	self->speed_task = task;
+
+	switch (task->state) {
+	case IRDA_TASK_INIT:
+		if (irda_task_execute(self, act200l_reset, NULL, task,
+				(void *) speed))
+		{
+			/* Dongle need more time to reset */
+			irda_task_next_state(task, IRDA_TASK_CHILD_WAIT);
+
+			/* Give reset 1 sec to finish */
+			ret = MSECS_TO_JIFFIES(1000);
+		}
+		break;
+	case IRDA_TASK_CHILD_WAIT:
+		WARNING(__FUNCTION__ "(), resetting dongle timed out!\n");
+		ret = -1;
+		break;
+	case IRDA_TASK_CHILD_DONE:
+		/* Clear DTR and set RTS to enter command mode */
+		self->set_dtr_rts(self->dev, FALSE, TRUE);
+
+		switch (speed) {
+		case 9600:
+		default:
+			control[0] = ACT200L_REG8 |  (ACT200L_9600       & 0x0f);
+			control[1] = ACT200L_REG9 | ((ACT200L_9600 >> 4) & 0x0f);
+			break;
+		case 19200:
+			control[0] = ACT200L_REG8 |  (ACT200L_19200       & 0x0f);
+			control[1] = ACT200L_REG9 | ((ACT200L_19200 >> 4) & 0x0f);
+			break;
+		case 38400:
+			control[0] = ACT200L_REG8 |  (ACT200L_38400       & 0x0f);
+			control[1] = ACT200L_REG9 | ((ACT200L_38400 >> 4) & 0x0f);
+			break;
+		case 57600:
+			control[0] = ACT200L_REG8 |  (ACT200L_57600       & 0x0f);
+			control[1] = ACT200L_REG9 | ((ACT200L_57600 >> 4) & 0x0f);
+			break;
+		case 115200:
+			control[0] = ACT200L_REG8 |  (ACT200L_115200       & 0x0f);
+			control[1] = ACT200L_REG9 | ((ACT200L_115200 >> 4) & 0x0f);
+			break;
+		}
+		control[2] = ACT200L_REG1 | ACT200L_LODB | ACT200L_WIDE;
+
+		/* Write control bytes */
+		self->write(self->dev, control, 3);
+		irda_task_next_state(task, IRDA_TASK_WAIT);
+		ret = MSECS_TO_JIFFIES(5);
+		break;
+	case IRDA_TASK_WAIT:
+		/* Go back to normal mode */
+		self->set_dtr_rts(self->dev, TRUE, TRUE);
+
+		irda_task_next_state(task, IRDA_TASK_DONE);
+		self->speed_task = NULL;
+		break;
+	default:
+		ERROR(__FUNCTION__ "(), unknown state %d\n", task->state);
+		irda_task_next_state(task, IRDA_TASK_DONE);
+		self->speed_task = NULL;
+		ret = -1;
+		break;
+	}
+	return ret;
+}
+
+/*
+ * Function act200l_reset (driver)
+ *
+ *    Reset the ACTiSYS ACT-IR200L type dongle.
+ */
+static int act200l_reset(struct irda_task *task)
+{
+	dongle_t *self = (dongle_t *) task->instance;
+	__u8 control[9] = {
+		ACT200L_REG15,
+		ACT200L_REG13 | ACT200L_SHDW,
+		ACT200L_REG21 | ACT200L_EXCK | ACT200L_OSCL,
+		ACT200L_REG13,
+		ACT200L_REG7  | ACT200L_ENPOS,
+		ACT200L_REG6  | ACT200L_RS0  | ACT200L_RS1,
+		ACT200L_REG5  | ACT200L_RWIDL,
+		ACT200L_REG4  | ACT200L_OP0  | ACT200L_OP1 | ACT200L_BLKR,
+		ACT200L_REG0  | ACT200L_TXEN | ACT200L_RXEN
+	};
+	int ret = 0;
+
+	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+
+	self->reset_task = task;
+
+	switch (task->state) {
+	case IRDA_TASK_INIT:
+		/* Power on the dongle */
+		self->set_dtr_rts(self->dev, TRUE, TRUE);
+
+		irda_task_next_state(task, IRDA_TASK_WAIT1);
+		ret = MSECS_TO_JIFFIES(50);
+		break;
+	case IRDA_TASK_WAIT1:
+		/* Reset the dongle : set RTS low for 25 ms */
+		self->set_dtr_rts(self->dev, TRUE, FALSE);
+
+		irda_task_next_state(task, IRDA_TASK_WAIT2);
+		ret = MSECS_TO_JIFFIES(50);
+		break;
+	case IRDA_TASK_WAIT2:
+		/* Clear DTR and set RTS to enter command mode */
+		self->set_dtr_rts(self->dev, FALSE, TRUE);
+
+		/* Write control bytes */
+		self->write(self->dev, control, 9);
+		irda_task_next_state(task, IRDA_TASK_WAIT3);
+		ret = MSECS_TO_JIFFIES(15);
+		break;
+	case IRDA_TASK_WAIT3:
+		/* Go back to normal mode */
+		self->set_dtr_rts(self->dev, TRUE, TRUE);
+
+		irda_task_next_state(task, IRDA_TASK_DONE);
+		self->reset_task = NULL;
+		break;
+	default:
+		ERROR(__FUNCTION__ "(), unknown state %d\n", task->state);
+		irda_task_next_state(task, IRDA_TASK_DONE);
+		self->reset_task = NULL;
+		ret = -1;
+		break;
+	}
+	return ret;
+}
+
+MODULE_AUTHOR("SHIMIZU Takuya <tshimizu@ga2.so-net.ne.jp>");
+MODULE_DESCRIPTION("ACTiSYS ACT-IR200L dongle driver");
+MODULE_LICENSE("GPL");
+
+/*
+ * Function init_module (void)
+ *
+ *    Initialize ACTiSYS ACT-IR200L module
+ *
+ */
+module_init(act200l_init);
+
+/*
+ * Function cleanup_module (void)
+ *
+ *    Cleanup ACTiSYS ACT-IR200L module
+ *
+ */
+module_exit(act200l_cleanup);
diff -u -p -r --new-file linux/drivers/net/irda.d7/ma600.c linux/drivers/net/irda/ma600.c
--- linux/drivers/net/irda.d7/ma600.c	Wed Dec 31 16:00:00 1969
+++ linux/drivers/net/irda/ma600.c	Thu Jun  6 18:01:51 2002
@@ -0,0 +1,356 @@
+/*********************************************************************
+ *                
+ * Filename:      ma600.c
+ * Version:       0.1
+ * Description:   Implementation of the MA600 dongle
+ * Status:        Experimental.
+ * Author:        Leung <95Etwl@alumni.ee.ust.hk> http://www.engsvr.ust/~eetwl95
+ * Created at:    Sat Jun 10 20:02:35 2000
+ * Modified at:   
+ * Modified by:   
+ *
+ * Note: very thanks to Mr. Maru Wang <maru@mobileaction.com.tw> for providing 
+ *       information on the MA600 dongle
+ * 
+ *     Copyright (c) 2000 Leung, All Rights Reserved.
+ *      
+ *     This program is free software; you can redistribute it and/or 
+ *     modify it under the terms of the GNU General Public License as 
+ *     published by the Free Software Foundation; either version 2 of 
+ *     the License, or (at your option) any later version.
+ *  
+ *     This program is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ *     GNU General Public License for more details.
+ * 
+ *     You should have received a copy of the GNU General Public License 
+ *     along with this program; if not, write to the Free Software 
+ *     Foundation, Inc., 59 Temple Place, Suite 330, Boston, 
+ *     MA 02111-1307 USA
+ *     
+ ********************************************************************/
+
+/* define this macro for release version */
+//#define NDEBUG
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/tty.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+
+#include <net/irda/irda.h>
+#include <net/irda/irda_device.h>
+#include <net/irda/irtty.h>
+
+#ifndef NDEBUG
+	#undef IRDA_DEBUG
+	#define IRDA_DEBUG(n, args...) (printk(KERN_DEBUG args))
+
+	#undef ASSERT(expr, func)
+	#define ASSERT(expr, func) \
+	if(!(expr)) { \
+	        printk( "Assertion failed! %s,%s,%s,line=%d\n",\
+        	#expr,__FILE__,__FUNCTION__,__LINE__); \
+	        ##func}
+#endif
+
+/* convert hex value to ascii hex */
+static const char hexTbl[] = "0123456789ABCDEF";
+
+
+static void ma600_open(dongle_t *self, struct qos_info *qos);
+static void ma600_close(dongle_t *self);
+static int  ma600_change_speed(struct irda_task *task);
+static int  ma600_reset(struct irda_task *task);
+
+/* control byte for MA600 */
+#define MA600_9600	0x00
+#define MA600_19200	0x01
+#define MA600_38400	0x02
+#define MA600_57600	0x03
+#define MA600_115200	0x04
+#define MA600_DEV_ID1	0x05
+#define MA600_DEV_ID2	0x06
+#define MA600_2400	0x08
+
+static struct dongle_reg dongle = {
+	Q_NULL,
+	IRDA_MA600_DONGLE,
+	ma600_open,
+	ma600_close,
+	ma600_reset,
+	ma600_change_speed,
+};
+
+int __init ma600_init(void)
+{
+	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	return irda_device_register_dongle(&dongle);
+}
+
+void __exit ma600_cleanup(void)
+{
+	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	irda_device_unregister_dongle(&dongle);
+}
+
+/*
+	Power on:
+		(0) Clear RTS and DTR for 1 second
+		(1) Set RTS and DTR for 1 second
+		(2) 9600 bps now
+	Note: assume RTS, DTR are clear before
+*/
+static void ma600_open(dongle_t *self, struct qos_info *qos)
+{
+	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+
+	qos->baud_rate.bits &= IR_2400|IR_9600|IR_19200|IR_38400
+				|IR_57600|IR_115200;
+	qos->min_turn_time.bits = 0x01;		/* Needs at least 1 ms */	
+	irda_qos_bits_to_value(qos);
+
+	//self->set_dtr_rts(self->dev, FALSE, FALSE);
+	// should wait 1 second
+
+	self->set_dtr_rts(self->dev, TRUE, TRUE);
+	// should wait 1 second
+
+	MOD_INC_USE_COUNT;
+}
+
+static void ma600_close(dongle_t *self)
+{
+	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+
+	/* Power off dongle */
+	self->set_dtr_rts(self->dev, FALSE, FALSE);
+
+	MOD_DEC_USE_COUNT;
+}
+
+static __u8 get_control_byte(__u32 speed)
+{
+	__u8 byte;
+
+	switch (speed) {
+	default:
+	case 115200:
+		byte = MA600_115200;
+		break;
+	case 57600:
+		byte = MA600_57600;
+		break;
+	case 38400:
+		byte = MA600_38400;
+		break;
+	case 19200:
+		byte = MA600_19200;
+		break;
+	case 9600:
+		byte = MA600_9600;
+		break;
+	case 2400:
+		byte = MA600_2400;
+		break;
+	}
+
+	return byte;
+}
+
+/*
+ * Function ma600_change_speed (dev, state, speed)
+ *
+ *    Set the speed for the MA600 type dongle. Warning, this 
+ *    function must be called with a process context!
+ *
+ *    Algorithm
+ *    1. Reset
+ *    2. clear RTS, set DTR and wait for 1ms
+ *    3. send Control Byte to the MA600 through TXD to set new baud rate
+ *       wait until the stop bit of Control Byte is sent (for 9600 baud rate, 
+ *       it takes about 10 msec)
+ *    4. set RTS, set DTR (return to NORMAL Operation)
+ *    5. wait at least 10 ms, new setting (baud rate, etc) takes effect here 
+ *       after
+ */
+static int ma600_change_speed(struct irda_task *task)
+{
+	dongle_t *self = (dongle_t *) task->instance;
+	__u32 speed = (__u32) task->param;
+	static __u8 byte;
+	__u8 byte_echo;
+	int ret = 0;
+	
+	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+
+	ASSERT(task != NULL, return -1;);
+
+	if (self->speed_task && self->speed_task != task) {
+		IRDA_DEBUG(0, __FUNCTION__ "(), busy!\n");
+		return MSECS_TO_JIFFIES(10);
+	} else {
+		self->speed_task = task;
+	}
+
+	switch (task->state) {
+	case IRDA_TASK_INIT:
+	case IRDA_TASK_CHILD_INIT:
+		/* 
+		 * Need to reset the dongle and go to 9600 bps before
+                 * programming 
+		 */
+		if (irda_task_execute(self, ma600_reset, NULL, task, 
+				      (void *) speed)) {
+			/* Dongle need more time to reset */
+			irda_task_next_state(task, IRDA_TASK_CHILD_WAIT);
+	
+			/* give 1 second to finish */
+			ret = MSECS_TO_JIFFIES(1000);
+		} else {
+			irda_task_next_state(task, IRDA_TASK_CHILD_DONE);
+		}
+		break;
+
+	case IRDA_TASK_CHILD_WAIT:
+		WARNING(__FUNCTION__ "(), resetting dongle timed out!\n");
+		ret = -1;
+		break;
+
+	case IRDA_TASK_CHILD_DONE:
+		/* Set DTR, Clear RTS */
+		self->set_dtr_rts(self->dev, TRUE, FALSE);
+	
+		ret = MSECS_TO_JIFFIES(1);		/* Sleep 1 ms */
+		irda_task_next_state(task, IRDA_TASK_WAIT);
+		break;
+
+	case IRDA_TASK_WAIT:
+		speed = (__u32) task->param;
+		byte = get_control_byte(speed);
+
+		/* Write control byte */
+		self->write(self->dev, &byte, sizeof(byte));
+		
+		irda_task_next_state(task, IRDA_TASK_WAIT1);
+
+		/* Wait at least 10 ms */
+		ret = MSECS_TO_JIFFIES(15);
+		break;
+
+	case IRDA_TASK_WAIT1:
+		/* Read control byte echo */
+		self->read(self->dev, &byte_echo, sizeof(byte_echo));
+
+		if(byte != byte_echo) {
+			/* if control byte != echo, I don't know what to do */
+			printk(KERN_WARNING __FUNCTION__ "() control byte written != read!\n");
+			printk(KERN_WARNING "control byte = 0x%c%c\n", 
+			       hexTbl[(byte>>4)&0x0f], hexTbl[byte&0x0f]);
+			printk(KERN_WARNING "byte echo = 0x%c%c\n", 
+			       hexTbl[(byte_echo>>4) & 0x0f], 
+			       hexTbl[byte_echo & 0x0f]);
+		#ifndef NDEBUG
+		} else {
+			IRDA_DEBUG(2, __FUNCTION__ "() control byte write read OK\n");
+		#endif
+		}
+
+		/* Set DTR, Set RTS */
+		self->set_dtr_rts(self->dev, TRUE, TRUE);
+
+		irda_task_next_state(task, IRDA_TASK_WAIT2);
+
+		/* Wait at least 10 ms */
+		ret = MSECS_TO_JIFFIES(10);
+		break;
+
+	case IRDA_TASK_WAIT2:
+		irda_task_next_state(task, IRDA_TASK_DONE);
+		self->speed_task = NULL;
+		break;
+
+	default:
+		ERROR(__FUNCTION__ "(), unknown state %d\n", task->state);
+		irda_task_next_state(task, IRDA_TASK_DONE);
+		self->speed_task = NULL;
+		ret = -1;
+		break;
+	}
+	return ret;
+}
+
+/*
+ * Function ma600_reset (driver)
+ *
+ *      This function resets the ma600 dongle. Warning, this function 
+ *      must be called with a process context!! 
+ *
+ *      Algorithm:
+ *    	  0. DTR=0, RTS=1 and wait 10 ms
+ *    	  1. DTR=1, RTS=1 and wait 10 ms
+ *        2. 9600 bps now
+ */
+int ma600_reset(struct irda_task *task)
+{
+	dongle_t *self = (dongle_t *) task->instance;
+	int ret = 0;
+
+	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+
+	ASSERT(task != NULL, return -1;);
+
+	if (self->reset_task && self->reset_task != task) {
+		IRDA_DEBUG(0, __FUNCTION__ "(), busy!\n");
+		return MSECS_TO_JIFFIES(10);
+	} else
+		self->reset_task = task;
+	
+	switch (task->state) {
+	case IRDA_TASK_INIT:
+		/* Clear DTR and Set RTS */
+		self->set_dtr_rts(self->dev, FALSE, TRUE);
+		irda_task_next_state(task, IRDA_TASK_WAIT1);
+		ret = MSECS_TO_JIFFIES(10);		/* Sleep 10 ms */
+		break;
+	case IRDA_TASK_WAIT1:
+		/* Set DTR and RTS */
+		self->set_dtr_rts(self->dev, TRUE, TRUE);
+		irda_task_next_state(task, IRDA_TASK_WAIT2);
+		ret = MSECS_TO_JIFFIES(10);		/* Sleep 10 ms */
+		break;
+	case IRDA_TASK_WAIT2:
+		irda_task_next_state(task, IRDA_TASK_DONE);
+		self->reset_task = NULL;
+		break;
+	default:
+		ERROR(__FUNCTION__ "(), unknown state %d\n", task->state);
+		irda_task_next_state(task, IRDA_TASK_DONE);		
+		self->reset_task = NULL;
+		ret = -1;
+	}
+	return ret;
+}
+
+MODULE_AUTHOR("Leung <95Etwl@alumni.ee.ust.hk> http://www.engsvr.ust/~eetwl95");
+MODULE_DESCRIPTION("MA600 dongle driver version 0.1");
+MODULE_LICENSE("GPL");
+		
+/*
+ * Function init_module (void)
+ *
+ *    Initialize MA600 module
+ *
+ */
+module_init(ma600_init);
+
+/*
+ * Function cleanup_module (void)
+ *
+ *    Cleanup MA600 module
+ *
+ */
+module_exit(ma600_cleanup);
+
diff -u -p -r --new-file linux/drivers/net/irda.d7/mcp2120.c linux/drivers/net/irda/mcp2120.c
--- linux/drivers/net/irda.d7/mcp2120.c	Wed Dec 31 16:00:00 1969
+++ linux/drivers/net/irda/mcp2120.c	Thu Jun  6 17:58:16 2002
@@ -0,0 +1,252 @@
+/*********************************************************************
+ *            
+ *    
+ * Filename:      mcp2120.c
+ * Version:       1.0
+ * Description:   Implementation for the MCP2120 (Microchip)
+ * Status:        Experimental.
+ * Author:        Felix Tang (tangf@eyetap.org)
+ * Created at:    Sun Mar 31 19:32:12 EST 2002
+ * Based on code by:   Dag Brattli <dagb@cs.uit.no>
+ * 
+ *     Copyright (c) 2002 Felix Tang, All Rights Reserved.
+ *      
+ *     This program is free software; you can redistribute it and/or 
+ *     modify it under the terms of the GNU General Public License as 
+ *     published by the Free Software Foundation; either version 2 of 
+ *     the License, or (at your option) any later version.
+ *  
+ ********************************************************************/
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/tty.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+
+#include <net/irda/irda.h>
+#include <net/irda/irmod.h>
+#include <net/irda/irda_device.h>
+#include <net/irda/irtty.h>
+
+static int  mcp2120_reset(struct irda_task *task);
+static void mcp2120_open(dongle_t *self, struct qos_info *qos);
+static void mcp2120_close(dongle_t *self);
+static int  mcp2120_change_speed(struct irda_task *task);
+
+#define MCP2120_9600    0x87
+#define MCP2120_19200   0x8B
+#define MCP2120_38400   0x85
+#define MCP2120_57600   0x83
+#define MCP2120_115200  0x81
+
+#define MCP2120_COMMIT  0x11
+
+static struct dongle_reg dongle = {
+	Q_NULL,
+	IRDA_MCP2120_DONGLE,
+	mcp2120_open,
+	mcp2120_close,
+	mcp2120_reset,
+	mcp2120_change_speed,
+};
+
+int __init mcp2120_init(void)
+{
+	return irda_device_register_dongle(&dongle);
+}
+
+void mcp2120_cleanup(void)
+{
+	irda_device_unregister_dongle(&dongle);
+}
+
+static void mcp2120_open(dongle_t *self, struct qos_info *qos)
+{
+	qos->baud_rate.bits &= IR_9600|IR_19200|IR_38400|IR_57600|IR_115200;
+	qos->min_turn_time.bits = 0x01;
+
+	MOD_INC_USE_COUNT;
+}
+
+static void mcp2120_close(dongle_t *self)
+{
+	/* Power off dongle */
+        /* reset and inhibit mcp2120 */
+	self->set_dtr_rts(self->dev, TRUE, TRUE);
+	//self->set_dtr_rts(self->dev, FALSE, FALSE);
+
+	MOD_DEC_USE_COUNT;
+}
+
+/*
+ * Function mcp2120_change_speed (dev, speed)
+ *
+ *    Set the speed for the MCP2120.
+ *
+ */
+static int mcp2120_change_speed(struct irda_task *task)
+{
+	dongle_t *self = (dongle_t *) task->instance;
+	__u32 speed = (__u32) task->param;
+	__u8 control[2];
+	int ret = 0;
+
+	self->speed_task = task;
+
+	switch (task->state) {
+	case IRDA_TASK_INIT:
+		/* Need to reset the dongle and go to 9600 bps before
+                   programming */
+                //printk("Dmcp2120_change_speed irda_task_init\n");
+		if (irda_task_execute(self, mcp2120_reset, NULL, task, 
+				      (void *) speed))
+		{
+			/* Dongle need more time to reset */
+			irda_task_next_state(task, IRDA_TASK_CHILD_WAIT);
+
+			/* Give reset 1 sec to finish */
+			ret = MSECS_TO_JIFFIES(1000);
+		}
+		break;
+	case IRDA_TASK_CHILD_WAIT:
+		WARNING(__FUNCTION__ "(), resetting dongle timed out!\n");
+		ret = -1;
+		break;
+	case IRDA_TASK_CHILD_DONE:
+		/* Set DTR to enter command mode */
+		self->set_dtr_rts(self->dev, TRUE, FALSE);
+                udelay(500);
+
+		switch (speed) {
+		case 9600:
+		default:
+			control[0] = MCP2120_9600;
+                        //printk("mcp2120 9600\n");
+			break;
+		case 19200:
+			control[0] = MCP2120_19200;
+                        //printk("mcp2120 19200\n");
+			break;
+		case 34800:
+			control[0] = MCP2120_38400;
+                        //printk("mcp2120 38400\n");
+			break;
+		case 57600:
+			control[0] = MCP2120_57600;
+                        //printk("mcp2120 57600\n");
+			break;
+		case 115200:
+                        control[0] = MCP2120_115200;
+                        //printk("mcp2120 115200\n");
+			break;
+		}
+	        control[1] = MCP2120_COMMIT;
+	
+		/* Write control bytes */
+                self->write(self->dev, control, 2);
+ 
+                irda_task_next_state(task, IRDA_TASK_WAIT);
+		ret = MSECS_TO_JIFFIES(100);
+                //printk("mcp2120_change_speed irda_child_done\n");
+		break;
+	case IRDA_TASK_WAIT:
+		/* Go back to normal mode */
+		self->set_dtr_rts(self->dev, FALSE, FALSE);
+		irda_task_next_state(task, IRDA_TASK_DONE);
+		self->speed_task = NULL;
+                //printk("mcp2120_change_speed irda_task_wait\n");
+		break;
+	default:
+		ERROR(__FUNCTION__ "(), unknown state %d\n", task->state);
+		irda_task_next_state(task, IRDA_TASK_DONE);
+		self->speed_task = NULL;
+		ret = -1;
+		break;
+	}
+	return ret;
+}
+
+/*
+ * Function mcp2120_reset (driver)
+ *
+ *      This function resets the mcp2120 dongle.
+ *      
+ *      Info: -set RTS to reset mcp2120
+ *            -set DTR to set mcp2120 software command mode
+ *            -mcp2120 defaults to 9600 baud after reset
+ *
+ *      Algorithm:
+ *      0. Set RTS to reset mcp2120.
+ *      1. Clear RTS and wait for device reset timer of 30 ms (max).
+ *      
+ */
+
+
+static int mcp2120_reset(struct irda_task *task)
+{
+	dongle_t *self = (dongle_t *) task->instance;
+	int ret = 0;
+
+	self->reset_task = task;
+
+	switch (task->state) {
+	case IRDA_TASK_INIT:
+                //printk("mcp2120_reset irda_task_init\n");
+		/* Reset dongle by setting RTS*/
+		self->set_dtr_rts(self->dev, TRUE, TRUE);
+		irda_task_next_state(task, IRDA_TASK_WAIT1);
+		ret = MSECS_TO_JIFFIES(50);
+		break;
+	case IRDA_TASK_WAIT1:
+                //printk("mcp2120_reset irda_task_wait1\n");
+                /* clear RTS and wait for at least 30 ms. */
+		self->set_dtr_rts(self->dev, FALSE, FALSE);
+		irda_task_next_state(task, IRDA_TASK_WAIT2);
+		ret = MSECS_TO_JIFFIES(50);
+		break;
+	case IRDA_TASK_WAIT2:
+                //printk("mcp2120_reset irda_task_wait2\n");
+		/* Go back to normal mode */
+		self->set_dtr_rts(self->dev, FALSE, FALSE);
+		irda_task_next_state(task, IRDA_TASK_DONE);
+		self->reset_task = NULL;
+		break;
+	default:
+		ERROR(__FUNCTION__ "(), unknown state %d\n", task->state);
+		irda_task_next_state(task, IRDA_TASK_DONE);
+		self->reset_task = NULL;
+		ret = -1;
+		break;
+	}
+	return ret;
+}
+
+#ifdef MODULE
+MODULE_AUTHOR("Felix Tang <tangf@eyetap.org>");
+MODULE_DESCRIPTION("Microchip MCP2120");
+MODULE_LICENSE("GPL");
+
+	
+/*
+ * Function init_module (void)
+ *
+ *    Initialize MCP2120 module
+ *
+ */
+int init_module(void)
+{
+	return mcp2120_init();
+}
+
+/*
+ * Function cleanup_module (void)
+ *
+ *    Cleanup MCP2120 module
+ *
+ */
+void cleanup_module(void)
+{
+        mcp2120_cleanup();
+}
+#endif /* MODULE */
