Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314519AbSDSCd2>; Thu, 18 Apr 2002 22:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314516AbSDSCcq>; Thu, 18 Apr 2002 22:32:46 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:36069 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S314517AbSDSCbz>;
	Thu, 18 Apr 2002 22:31:55 -0400
Date: Thu, 18 Apr 2002 19:30:22 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        irda-users@lists.sourceforge.net
Subject: [PATCH] : ir258_mcp2120_driver.diff
Message-ID: <20020418193022.E988@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir258_mcp2120_driver.diff :
-------------------------
	        <Following patch from Felix Tang>
	o [FEATURE] Dongle driver for mcp2120/crystal hardware

-----------------------------------------

diff -u -p linux/include/linux/irda.d7.h linux/include/linux/irda.h
--- linux/include/linux/irda.d7.h	Wed Apr 10 17:47:58 2002
+++ linux/include/linux/irda.h	Wed Apr 10 17:48:24 2002
@@ -67,6 +67,7 @@ typedef enum {
 	IRDA_AIRPORT_DONGLE      = 6,
 	IRDA_OLD_BELKIN_DONGLE   = 7,
 	IRDA_EP7211_IR           = 8,
+	IRDA_MCP2120_DONGLE      = 9,
 } IRDA_DONGLE;
 
 /* Protocol types to be used for SOCK_DGRAM */
diff -u -p linux/drivers/net/irda/Config.d7.in linux/drivers/net/irda/Config.in
--- linux/drivers/net/irda/Config.d7.in	Wed Apr 10 17:46:56 2002
+++ linux/drivers/net/irda/Config.in	Wed Apr 10 17:47:26 2002
@@ -13,6 +13,7 @@ if [ "$CONFIG_DONGLE" != "n" ]; then
    dep_tristate '  Tekram IrMate 210B dongle' CONFIG_TEKRAM_DONGLE $CONFIG_IRDA
    dep_tristate '  Greenwich GIrBIL dongle' CONFIG_GIRBIL_DONGLE $CONFIG_IRDA
    dep_tristate '  Parallax LiteLink dongle' CONFIG_LITELINK_DONGLE $CONFIG_IRDA
+   dep_tristate '  Microchip MCP2120' CONFIG_MCP2120_DONGLE $CONFIG_IRDA
    dep_tristate '  Old Belkin dongle' CONFIG_OLD_BELKIN_DONGLE $CONFIG_IRDA   
    if [ "$CONFIG_ARCH_EP7211" = "y" ]; then
       dep_tristate '  EP7211 I/R support' CONFIG_EP7211_IR $CONFIG_IRDA
diff -u -p linux/drivers/net/irda/Config.d7.help linux/drivers/net/irda/Config.help
--- linux/drivers/net/irda/Config.d7.help	Wed Apr 10 17:49:14 2002
+++ linux/drivers/net/irda/Config.help	Wed Apr 10 17:50:03 2002
@@ -138,6 +138,18 @@ CONFIG_LITELINK_DONGLE
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
 CONFIG_OLD_BELKIN_DONGLE
   Say Y here if you want to build support for the Adaptec Airport 1000
   and 2000 dongles.  If you want to compile it as a module, say M here
diff -u -p linux/drivers/net/irda/Makefile.d7 linux/drivers/net/irda/Makefile
--- linux/drivers/net/irda/Makefile.d7	Wed Apr 10 17:46:07 2002
+++ linux/drivers/net/irda/Makefile	Wed Apr 10 17:46:35 2002
@@ -28,5 +28,6 @@ obj-$(CONFIG_GIRBIL_DONGLE)	+= girbil.o
 obj-$(CONFIG_LITELINK_DONGLE)	+= litelink.o
 obj-$(CONFIG_OLD_BELKIN_DONGLE)	+= old_belkin.o
 obj-$(CONFIG_EP7211_IR)		+= ep7211_ir.o
+obj-$(CONFIG_MCP2120_DONGLE)	+= mcp2120.o
 
 include $(TOPDIR)/Rules.make
diff -u -p linux/drivers/net/irda/mcp2120.d7.c linux/drivers/net/irda/mcp2120.c
--- linux/drivers/net/irda/mcp2120.d7.c	Wed Apr 10 17:52:54 2002
+++ linux/drivers/net/irda/mcp2120.c	Wed Apr 10 17:45:29 2002
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
