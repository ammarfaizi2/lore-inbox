Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269669AbSKEBtP>; Mon, 4 Nov 2002 20:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269745AbSKEBtP>; Mon, 4 Nov 2002 20:49:15 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:5343 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S269669AbSKEBrw>;
	Mon, 4 Nov 2002 20:47:52 -0500
Date: Mon, 4 Nov 2002 17:54:25 -0800
To: irda-users@lists.sourceforge.net, Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] : ir255_irtty-sir-1.diff
Message-ID: <20021105015425.GB8849@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir255_irtty-sir-1.diff :
----------------------
	        <Following patch from Martin Diehl>
	o [CRITICA] Do all serial driver config change in process context
	o [CORRECT] Safe registration of dongle drivers
	o [FEATURE] Rework infrastructure of SIR drivers
	o [CORRECT] Port irtty driver to new SIR infrastructure
	o [CORRECT] Port esi/actisys/tekram driver to new SIR infrastructure
		<Note : there is still some more work to do around SIR drivers,
		 such as porting other drivers to the new infrastructure, but
		 this is functional and tested, and old irtty is broken>


--- linux-2.5.45/drivers/net/irda/Kconfig	Sat Nov  2 18:27:41 2002
+++ v2.5.45-md/drivers/net/irda/Kconfig	Sun Nov  3 00:57:46 2002
@@ -9,7 +9,7 @@
 	depends on IRDA
 	help
 	  Say Y here if you want to build support for the IrTTY line
-	  discipline.  If you want to compile it as a module (irtty.o), say M
+	  discipline.  If you want to compile it as a module (irtty-sir.o), say M
 	  here and read <file:Documentation/modules.txt>.  IrTTY makes it
 	  possible to use Linux's own serial driver for all IrDA ports that
 	  are 16550 compatible.  Most IrDA chips are 16550 compatible so you
@@ -18,6 +18,69 @@
 
 	  If unsure, say Y.
 
+comment "Dongle support"
+
+config DONGLE
+	bool "Serial dongle support"
+	help
+	  Say Y here if you have an infrared device that connects to your
+	  computer's serial port. These devices are called dongles. Then say Y
+	  or M to the driver for your particular dongle below.
+
+	  Note that the answer to this question won't directly affect the
+	  kernel: saying N will just cause the configurator to skip all
+	  the questions about serial dongles.
+
+config ESI_DONGLE
+	tristate "ESI JetEye PC dongle"
+	depends on DONGLE && IRDA
+	help
+	  Say Y here if you want to build support for the Extended Systems
+	  JetEye PC dongle.  If you want to compile it as a module, say M here
+	  and read <file:Documentation/modules.txt>.  The ESI dongle attaches
+	  to the normal 9-pin serial port connector, and can currently only be
+	  used by IrTTY.  To activate support for ESI dongles you will have to
+	  start irattach like this: "irattach -d esi".
+
+config ACTISYS_DONGLE
+	tristate "ACTiSYS IR-220L and IR220L+ dongle"
+	depends on DONGLE && IRDA
+	help
+	  Say Y here if you want to build support for the ACTiSYS IR-220L and
+	  IR220L+ dongles.  If you want to compile it as a module, say M here
+	  and read <file:Documentation/modules.txt>.  The ACTiSYS dongles
+	  attaches to the normal 9-pin serial port connector, and can
+	  currently only be used by IrTTY.  To activate support for ACTiSYS
+	  dongles you will have to start irattach like this:
+	  "irattach -d actisys" or "irattach -d actisys+".
+
+config TEKRAM_DONGLE
+	tristate "Tekram IrMate 210B dongle"
+	depends on DONGLE && IRDA
+	help
+	  Say Y here if you want to build support for the Tekram IrMate 210B
+	  dongle.  If you want to compile it as a module, say M here and read
+	  <file:Documentation/modules.txt>.  The Tekram dongle attaches to the
+	  normal 9-pin serial port connector, and can currently only be used
+	  by IrTTY.  To activate support for Tekram dongles you will have to
+	  start irattach like this: "irattach -d tekram".
+
+comment "Old SIR device drivers"
+
+config IRTTY_OLD
+	tristate "Old IrTTY (broken)"
+	depends on IRDA
+	help
+	  Say Y here if you want to build support for the IrTTY line
+	  discipline.  If you want to compile it as a module (irtty.o), say M
+	  here and read <file:Documentation/modules.txt>.  IrTTY makes it
+	  possible to use Linux's own serial driver for all IrDA ports that
+	  are 16550 compatible.  Most IrDA chips are 16550 compatible so you
+	  should probably say Y to this option.  Using IrTTY will however
+	  limit the speed of the connection to 115200 bps (IrDA SIR mode).
+
+	  If unsure, say N.
+
 config IRPORT_SIR
 	tristate "IrPORT (IrDA serial driver)"
 	depends on IRDA
@@ -35,10 +98,10 @@
 
 	  If unsure, say Y.
 
-comment "Dongle support"
+comment "Old Serial dongle support"
 
-config DONGLE
-	bool "Serial dongle support"
+config DONGLE_OLD
+	bool "Old Serial dongle support"
 	help
 	  Say Y here if you have an infrared device that connects to your
 	  computer's serial port. These devices are called dongles. Then say Y
@@ -48,9 +111,9 @@
 	  kernel: saying N will just cause the configurator to skip all
 	  the questions about serial dongles.
 
-config ESI_DONGLE
+config ESI_DONGLE_OLD
 	tristate "ESI JetEye PC dongle"
-	depends on DONGLE && IRDA
+	depends on DONGLE_OLD && IRDA
 	help
 	  Say Y here if you want to build support for the Extended Systems
 	  JetEye PC dongle.  If you want to compile it as a module, say M here
@@ -59,9 +122,9 @@
 	  used by IrTTY.  To activate support for ESI dongles you will have to
 	  start irattach like this: "irattach -d esi".
 
-config ACTISYS_DONGLE
+config ACTISYS_DONGLE_OLD
 	tristate "ACTiSYS IR-220L and IR220L+ dongle"
-	depends on DONGLE && IRDA
+	depends on DONGLE_OLD && IRDA
 	help
 	  Say Y here if you want to build support for the ACTiSYS IR-220L and
 	  IR220L+ dongles.  If you want to compile it as a module, say M here
@@ -71,9 +134,9 @@
 	  dongles you will have to start irattach like this:
 	  "irattach -d actisys" or "irattach -d actisys+".
 
-config TEKRAM_DONGLE
+config TEKRAM_DONGLE_OLD
 	tristate "Tekram IrMate 210B dongle"
-	depends on DONGLE && IRDA
+	depends on DONGLE_OLD && IRDA
 	help
 	  Say Y here if you want to build support for the Tekram IrMate 210B
 	  dongle.  If you want to compile it as a module, say M here and read
@@ -84,7 +147,7 @@
 
 config GIRBIL_DONGLE
 	tristate "Greenwich GIrBIL dongle"
-	depends on DONGLE && IRDA
+	depends on DONGLE_OLD && IRDA
 	help
 	  Say Y here if you want to build support for the Greenwich GIrBIL
 	  dongle.  If you want to compile it as a module, say M here and read
@@ -95,7 +158,7 @@
 
 config LITELINK_DONGLE
 	tristate "Parallax LiteLink dongle"
-	depends on DONGLE && IRDA
+	depends on DONGLE_OLD && IRDA
 	help
 	  Say Y here if you want to build support for the Parallax Litelink
 	  dongle.  If you want to compile it as a module, say M here and read
@@ -106,7 +169,7 @@
 
 config MCP2120_DONGLE
 	tristate "Microchip MCP2120"
-	depends on DONGLE && IRDA
+	depends on DONGLE_OLD && IRDA
 	help
 	  Say Y here if you want to build support for the Microchip MCP2120
 	  dongle.  If you want to compile it as a module, say M here and read
@@ -120,7 +183,7 @@
 
 config OLD_BELKIN_DONGLE
 	tristate "Old Belkin dongle"
-	depends on DONGLE && IRDA
+	depends on DONGLE_OLD && IRDA
 	help
 	  Say Y here if you want to build support for the Adaptec Airport 1000
 	  and 2000 dongles.  If you want to compile it as a module, say M here
@@ -130,11 +193,11 @@
 
 config EP7211_IR
 	tristate "EP7211 I/R support"
-	depends on DONGLE && ARCH_EP7211 && IRDA
+	depends on DONGLE_OLD && ARCH_EP7211 && IRDA
 
 config ACT200L_DONGLE
 	tristate "ACTiSYS IR-200L dongle (EXPERIMENTAL)"
-	depends on DONGLE && EXPERIMENTAL && IRDA
+	depends on DONGLE_OLD && EXPERIMENTAL && IRDA
 	help
 	  Say Y here if you want to build support for the ACTiSYS IR-200L
 	  dongle. If you want to compile it as a module, say M here and read
@@ -145,7 +208,7 @@
 
 config MA600_DONGLE
 	tristate "Mobile Action MA600 dongle (EXPERIMENTAL)"
-	depends on DONGLE && EXPERIMENTAL && IRDA
+	depends on DONGLE_OLD && EXPERIMENTAL && IRDA
 	---help---
 	  Say Y here if you want to build support for the Mobile Action MA600
 	  dongle.  If you want to compile it as a module, say M here and read
diff -u -p --new-file linux/drivers/net/irda-d6/Makefile linux/drivers/net/irda/Makefile
--- linux/drivers/net/irda-d6/Makefile	Mon Oct 21 14:15:03 2002
+++ linux/drivers/net/irda/Makefile	Thu Oct 31 16:33:46 2002
@@ -5,10 +5,12 @@
 # Rewritten to use lists instead of if-statements.
 #
 
-export-objs	= irport.o
+export-objs	= irport.o sir_core.o
 
-obj-$(CONFIG_IRTTY_SIR)		+= irtty.o
+# Old SIR drivers (irtty is broken)
+obj-$(CONFIG_IRTTY_OLD)		+= irtty.o
 obj-$(CONFIG_IRPORT_SIR)	+= 		irport.o
+# FIR drivers
 obj-$(CONFIG_USB_IRDA)		+= irda-usb.o
 obj-$(CONFIG_NSC_FIR)		+= nsc-ircc.o
 obj-$(CONFIG_WINBOND_FIR)	+= w83977af_ir.o
@@ -18,9 +20,10 @@ obj-$(CONFIG_TOSHIBA_FIR)	+= donauboe.o
 obj-$(CONFIG_SMC_IRCC_FIR)	+= smc-ircc.o	irport.o
 obj-$(CONFIG_ALI_FIR)		+= ali-ircc.o
 obj-$(CONFIG_VLSI_FIR)		+= vlsi_ir.o
-obj-$(CONFIG_ESI_DONGLE)	+= esi.o
-obj-$(CONFIG_TEKRAM_DONGLE)	+= tekram.o
-obj-$(CONFIG_ACTISYS_DONGLE)	+= actisys.o
+# Old dongle drivers for old SIR drivers
+obj-$(CONFIG_ESI_OLD)		+= esi.o
+obj-$(CONFIG_TEKRAM_OLD)	+= tekram.o
+obj-$(CONFIG_ACTISYS_OLD)	+= actisys.o
 obj-$(CONFIG_GIRBIL_DONGLE)	+= girbil.o
 obj-$(CONFIG_LITELINK_DONGLE)	+= litelink.o
 obj-$(CONFIG_OLD_BELKIN_DONGLE)	+= old_belkin.o
@@ -28,5 +31,14 @@ obj-$(CONFIG_EP7211_IR)		+= ep7211_ir.o
 obj-$(CONFIG_MCP2120_DONGLE)	+= mcp2120.o
 obj-$(CONFIG_ACT200L_DONGLE)	+= act200l.o
 obj-$(CONFIG_MA600_DONGLE)	+= ma600.o
+# New SIR drivers
+obj-$(CONFIG_IRTTY_SIR)		+= irtty-sir.o	sir-dev.o
+# New dongles drivers for new SIR drivers
+obj-$(CONFIG_ESI_DONGLE)	+= esi-sir.o
+obj-$(CONFIG_TEKRAM_DONGLE)	+= tekram-sir.o
+obj-$(CONFIG_ACTISYS_DONGLE)	+= actisys-sir.o
+
+# The SIR helper module
+sir-dev-objs := sir_core.o sir_dev.o sir_dongle.o sir_kthread.o
 
 include $(TOPDIR)/Rules.make
diff -u -p --new-file linux/drivers/net/irda-d6/actisys-sir.c linux/drivers/net/irda/actisys-sir.c
--- linux/drivers/net/irda-d6/actisys-sir.c	Wed Dec 31 16:00:00 1969
+++ linux/drivers/net/irda/actisys-sir.c	Thu Oct 31 16:29:44 2002
@@ -0,0 +1,240 @@
+/*********************************************************************
+ *                
+ * Filename:      actisys.c
+ * Version:       1.1
+ * Description:   Implementation for the ACTiSYS IR-220L and IR-220L+ 
+ *                dongles
+ * Status:        Beta.
+ * Authors:       Dag Brattli <dagb@cs.uit.no> (initially)
+ *		  Jean Tourrilhes <jt@hpl.hp.com> (new version)
+ *		  Martin Diehl <mad@mdiehl.de> (new version for sir_dev)
+ * Created at:    Wed Oct 21 20:02:35 1998
+ * Modified at:   Sun Oct 27 22:02:13 2002
+ * Modified by:   Martin Diehl <mad@mdiehl.de>
+ * 
+ *     Copyright (c) 1998-1999 Dag Brattli, All Rights Reserved.
+ *     Copyright (c) 1999 Jean Tourrilhes
+ *     Copyright (c) 2002 Martin Diehl
+ *      
+ *     This program is free software; you can redistribute it and/or 
+ *     modify it under the terms of the GNU General Public License as 
+ *     published by the Free Software Foundation; either version 2 of 
+ *     the License, or (at your option) any later version.
+ *  
+ *     Neither Dag Brattli nor University of Tromsø admit liability nor
+ *     provide warranty for any of this software. This material is 
+ *     provided "AS-IS" and at no charge.
+ *     
+ ********************************************************************/
+
+/*
+ * Changelog
+ *
+ * 0.8 -> 0.9999 - Jean
+ *	o New initialisation procedure : much safer and correct
+ *	o New procedure the change speed : much faster and simpler
+ *	o Other cleanups & comments
+ *	Thanks to Lichen Wang @ Actisys for his excellent help...
+ *
+ * 1.0 -> 1.1 - Martin Diehl
+ *	modified for new sir infrastructure
+ */
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+
+#include <net/irda/irda.h>
+
+#include "sir-dev.h"
+
+/* 
+ * Define the timing of the pulses we send to the dongle (to reset it, and
+ * to toggle speeds). Basically, the limit here is the propagation speed of
+ * the signals through the serial port, the dongle being much faster.  Any
+ * serial port support 115 kb/s, so we are sure that pulses 8.5 us wide can
+ * go through cleanly . If you are on the wild side, you can try to lower
+ * this value (Actisys recommended me 2 us, and 0 us work for me on a P233!)
+ */
+#define MIN_DELAY 10	/* 10 us to be on the conservative side */
+
+static int actisys_open(struct sir_dev *);
+static int actisys_close(struct sir_dev *);
+static int actisys_change_speed(struct sir_dev *, unsigned);
+static int actisys_reset(struct sir_dev *);
+
+/* These are the baudrates supported, in the order available */
+/* Note : the 220L doesn't support 38400, but we will fix that below */
+static __u32 baud_rates[] = { 9600, 19200, 57600, 115200, 38400 };
+
+#define MAX_SPEEDS (sizeof(baud_rates)/sizeof(baud_rates[0]))
+
+static struct dongle_driver act220l = {
+	.owner		= THIS_MODULE,
+	.driver_name	= "Actisys ACT-220L",
+	.type		= IRDA_ACTISYS_DONGLE,
+	.open		= actisys_open,
+	.close		= actisys_close,
+	.reset		= actisys_reset,
+	.set_speed	= actisys_change_speed,
+};
+
+static struct dongle_driver act220l_plus = {
+	.owner		= THIS_MODULE,
+	.driver_name	= "Actisys ACT-220L+",
+	.type		= IRDA_ACTISYS_PLUS_DONGLE,
+	.open		= actisys_open,
+	.close		= actisys_close,
+	.reset		= actisys_reset,
+	.set_speed	= actisys_change_speed,
+};
+
+int __init actisys_sir_init(void)
+{
+	int ret;
+
+	/* First, register an Actisys 220L dongle */
+	ret = irda_register_dongle(&act220l);
+	if (ret < 0)
+		return ret;
+
+	/* Now, register an Actisys 220L+ dongle */
+	ret = irda_register_dongle(&act220l_plus);
+	if (ret < 0) {
+		irda_unregister_dongle(&act220l);
+		return ret;
+	}
+	return 0;
+}
+
+void __exit actisys_sir_cleanup(void)
+{
+	/* We have to remove both dongles */
+	irda_unregister_dongle(&act220l_plus);
+	irda_unregister_dongle(&act220l);
+}
+
+static int actisys_open(struct sir_dev *dev)
+{
+	struct qos_info *qos = &dev->qos;
+
+	dev->set_dtr_rts(dev, TRUE, TRUE);
+
+	/* Set the speeds we can accept */
+	qos->baud_rate.bits &= IR_9600|IR_19200|IR_38400|IR_57600|IR_115200;
+
+	/* Remove support for 38400 if this is not a 220L+ dongle */
+	if (dev->dongle_drv->type == IRDA_ACTISYS_DONGLE)
+		qos->baud_rate.bits &= ~IR_38400;
+
+	qos->min_turn_time.bits = 0x7f; /* Needs 0.01 ms */
+	irda_qos_bits_to_value(qos);
+
+	return 0;
+}
+
+static int actisys_close(struct sir_dev *dev)
+{
+	/* Power off the dongle */
+	dev->set_dtr_rts(dev, FALSE, FALSE);
+
+	return 0;
+}
+
+/*
+ * Function actisys_change_speed (task)
+ *
+ *    Change speed of the ACTiSYS IR-220L and IR-220L+ type IrDA dongles.
+ *    To cycle through the available baud rates, pulse RTS low for a few us.
+ *
+ *	First, we reset the dongle to always start from a known state.
+ *	Then, we cycle through the speeds by pulsing RTS low and then up.
+ *	The dongle allow us to pulse quite fast, se we can set speed in one go,
+ * which is must faster ( < 100 us) and less complex than what is found
+ * in some other dongle drivers...
+ *	Note that even if the new speed is the same as the current speed,
+ * we reassert the speed. This make sure that things are all right,
+ * and it's fast anyway...
+ *	By the way, this function will work for both type of dongles,
+ * because the additional speed is at the end of the sequence...
+ */
+static int actisys_change_speed(struct sir_dev *dev, unsigned speed)
+{
+	int ret = 0;
+	int i = 0;
+
+        IRDA_DEBUG(4, "%s(), speed=%d (was %d)\n", __FUNCTION__,
+        	speed, dev->speed);
+
+	/* dongle was already resetted from irda_request state machine,
+	 * we are in known state (dongle default)
+	 */
+
+	/* 
+	 * Now, we can set the speed requested. Send RTS pulses until we
+         * reach the target speed 
+	 */
+	for (i=0; i<MAX_SPEEDS; i++) {
+		if (speed == baud_rates[i]) {
+			dev->speed = baud_rates[i];
+			break;
+		}
+		/* Set RTS low for 10 us */
+		dev->set_dtr_rts(dev, TRUE, FALSE);
+		udelay(MIN_DELAY);
+
+		/* Set RTS high for 10 us */
+		dev->set_dtr_rts(dev, TRUE, TRUE);
+		udelay(MIN_DELAY);
+	}
+
+	/* Check if life is sweet... */
+	if (i >= MAX_SPEEDS)
+		ret = -1;  /* This should not happen */
+
+	/* Basta lavoro, on se casse d'ici... */
+	return ret;
+}
+
+/*
+ * Function actisys_reset (task)
+ *
+ *      Reset the Actisys type dongle. Warning, this function must only be
+ *      called with a process context!
+ *
+ * We need to do two things in this function :
+ *	o first make sure that the dongle is in a state where it can operate
+ *	o second put the dongle in a know state
+ *
+ *	The dongle is powered of the RTS and DTR lines. In the dongle, there
+ * is a big capacitor to accomodate the current spikes. This capacitor
+ * takes a least 50 ms to be charged. In theory, the Bios set those lines
+ * up, so by the time we arrive here we should be set. It doesn't hurt
+ * to be on the conservative side, so we will wait...
+ * <Martin : move above comment to irda_config_fsm>
+ *	Then, we set the speed to 9600 b/s to get in a known state (see in
+ * change_speed for details). It is needed because the IrDA stack
+ * has tried to set the speed immediately after our first return,
+ * so before we can be sure the dongle is up and running.
+ */
+
+static int actisys_reset(struct sir_dev *dev)
+{
+	/* Reset the dongle : set DTR low for 10 us */
+	dev->set_dtr_rts(dev, FALSE, TRUE);
+	udelay(MIN_DELAY);
+
+	/* Go back to normal mode */
+	dev->set_dtr_rts(dev, TRUE, TRUE);
+	
+	dev->speed = 9600;	/* That's the default */
+
+	return 0;
+}
+
+MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no> - Jean Tourrilhes <jt@hpl.hp.com>");
+MODULE_DESCRIPTION("ACTiSYS IR-220L and IR-220L+ dongle driver");	
+MODULE_LICENSE("GPL");
+
+module_init(actisys_sir_init);
+module_exit(actisys_sir_cleanup);
diff -u -p --new-file linux/drivers/net/irda-d6/esi-sir.c linux/drivers/net/irda/esi-sir.c
--- linux/drivers/net/irda-d6/esi-sir.c	Wed Dec 31 16:00:00 1969
+++ linux/drivers/net/irda/esi-sir.c	Thu Oct 31 16:30:19 2002
@@ -0,0 +1,145 @@
+/*********************************************************************
+ *                
+ * Filename:      esi.c
+ * Version:       1.6
+ * Description:   Driver for the Extended Systems JetEye PC dongle
+ * Status:        Experimental.
+ * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Created at:    Sat Feb 21 18:54:38 1998
+ * Modified at:   Sun Oct 27 22:01:04 2002
+ * Modified by:   Martin Diehl <mad@mdiehl.de>
+ * 
+ *     Copyright (c) 1999 Dag Brattli, <dagb@cs.uit.no>,
+ *     Copyright (c) 1998 Thomas Davis, <ratbert@radiks.net>,
+ *     Copyright (c) 2002 Martin Diehl, <mad@mdiehl.de>,
+ *     All Rights Reserved.
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
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+
+#include <net/irda/irda.h>
+
+#include "sir-dev.h"
+
+static int esi_open(struct sir_dev *);
+static int esi_close(struct sir_dev *);
+static int esi_change_speed(struct sir_dev *, unsigned);
+static int esi_reset(struct sir_dev *);
+
+static struct dongle_driver esi = {
+	.owner		= THIS_MODULE,
+	.driver_name	= "JetEye PC ESI-9680 PC",
+	.type		= IRDA_ESI_DONGLE,
+	.open		= esi_open,
+	.close		= esi_close,
+	.reset		= esi_reset,
+	.set_speed	= esi_change_speed,
+};
+
+static int __init esi_sir_init(void)
+{
+	return irda_register_dongle(&esi);
+}
+
+static void __exit esi_sir_cleanup(void)
+{
+	irda_unregister_dongle(&esi);
+}
+
+static int esi_open(struct sir_dev *dev)
+{
+	struct qos_info *qos = &dev->qos;
+
+	qos->baud_rate.bits &= IR_9600|IR_19200|IR_115200;
+	qos->min_turn_time.bits = 0x01; /* Needs at least 10 ms */
+	irda_qos_bits_to_value(qos);
+
+	/* shouldn't we do set_dtr_rts(FALSE, TRUE) here (power up at 9600)? */
+
+	return 0;
+}
+
+static int esi_close(struct sir_dev *dev)
+{
+	/* Power off dongle */
+	dev->set_dtr_rts(dev, FALSE, FALSE);
+
+	return 0;
+}
+
+/*
+ * Function esi_change_speed (task)
+ *
+ *    Set the speed for the Extended Systems JetEye PC ESI-9680 type dongle
+ *
+ */
+static int esi_change_speed(struct sir_dev *dev, unsigned speed)
+{
+	int dtr, rts;
+	
+	switch (speed) {
+	case 19200:
+		dtr = TRUE;
+		rts = FALSE;
+		break;
+	case 115200:
+		dtr = rts = TRUE;
+		break;
+	default:
+		speed = 9600;
+		/* fall through */
+	case 9600:
+		dtr = FALSE;
+		rts = TRUE;
+		break;
+	}
+
+	/* Change speed of dongle */
+	dev->set_dtr_rts(dev, dtr, rts);
+	dev->speed = speed;
+
+	/* do we need some delay for power stabilization? */
+
+	return 0;
+}
+
+/*
+ * Function esi_reset (task)
+ *
+ *    Reset dongle;
+ *
+ */
+static int esi_reset(struct sir_dev *dev)
+{
+	dev->set_dtr_rts(dev, FALSE, FALSE);
+
+	/* Hm, probably repower to 9600 and some delays? */
+
+	return 0;
+}
+
+MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
+MODULE_DESCRIPTION("Extended Systems JetEye PC dongle driver");
+MODULE_LICENSE("GPL");
+
+module_init(esi_sir_init);
+module_exit(esi_sir_cleanup);
+
diff -u -p --new-file linux/drivers/net/irda-d6/irtty-sir.c linux/drivers/net/irda/irtty-sir.c
--- linux/drivers/net/irda-d6/irtty-sir.c	Wed Dec 31 16:00:00 1969
+++ linux/drivers/net/irda/irtty-sir.c	Thu Oct 31 18:19:01 2002
@@ -0,0 +1,684 @@
+/*********************************************************************
+ *                
+ * Filename:      irtty-sir.c
+ * Version:       2.0
+ * Description:   IrDA line discipline implementation
+ * Status:        Experimental.
+ * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Created at:    Tue Dec  9 21:18:38 1997
+ * Modified at:   Sun Oct 27 22:13:30 2002
+ * Modified by:   Martin Diehl <mad@mdiehl.de>
+ * Sources:       slip.c by Laurence Culhane,   <loz@holmes.demon.co.uk>
+ *                          Fred N. van Kempen, <waltje@uwalt.nl.mugnet.org>
+ * 
+ *     Copyright (c) 1998-2000 Dag Brattli,
+ *     Copyright (c) 2002 Martin Diehl,
+ *     All Rights Reserved.
+ *      
+ *     This program is free software; you can redistribute it and/or 
+ *     modify it under the terms of the GNU General Public License as 
+ *     published by the Free Software Foundation; either version 2 of 
+ *     the License, or (at your option) any later version.
+ *  
+ *     Neither Dag Brattli nor University of Tromsø admit liability nor
+ *     provide warranty for any of this software. This material is 
+ *     provided "AS-IS" and at no charge.
+ *     
+ ********************************************************************/    
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/tty.h>
+#include <linux/init.h>
+#include <asm/uaccess.h>
+#include <linux/smp_lock.h>
+
+#include <net/irda/irda.h>
+#include <net/irda/irda_device.h>
+
+#include "sir-dev.h"
+#include "irtty-sir.h"
+
+MODULE_PARM(qos_mtt_bits, "i");
+MODULE_PARM_DESC(qos_mtt_bits, "Minimum Turn Time");
+
+static int qos_mtt_bits = 0x03;      /* 5 ms or more */
+
+/* ------------------------------------------------------- */
+
+/* device configuration callbacks always invoked with irda-thread context */
+
+/* find out, how many chars we have in buffers below us
+ * this is allowed to lie, i.e. return less chars than we
+ * actually have. The returned value is used to determine
+ * how long the irdathread should wait before doing the
+ * real blocking wait_until_sent()
+ */
+
+static int irtty_chars_in_buffer(struct sir_dev *dev)
+{
+	struct sirtty_cb *priv = dev->priv;
+
+	ASSERT(priv != NULL, return -1;);
+	ASSERT(priv->magic == IRTTY_MAGIC, return -1;);
+
+	return priv->tty->driver.chars_in_buffer(priv->tty);
+}
+
+/* Wait (sleep) until underlaying hardware finished transmission
+ * i.e. hardware buffers are drained
+ * this must block and not return before all characters are really sent
+ *
+ * If the tty sits on top of a 16550A-like uart, there are typically
+ * up to 16 bytes in the fifo - f.e. 9600 bps 8N1 needs 16.7 msec
+ *
+ * With usbserial the uart-fifo is basically replaced by the converter's
+ * outgoing endpoint buffer, which can usually hold 64 bytes (at least).
+ * With pl2303 it appears we are safe with 60msec here.
+ *
+ * I really wish all serial drivers would provide
+ * correct implementation of wait_until_sent()
+ */
+
+#define USBSERIAL_TX_DONE_DELAY	60
+
+static void irtty_wait_until_sent(struct sir_dev *dev)
+{
+	struct sirtty_cb *priv = dev->priv;
+	struct tty_struct *tty;
+
+	ASSERT(priv != NULL, return;);
+	ASSERT(priv->magic == IRTTY_MAGIC, return;);
+
+	tty = priv->tty;
+	if (tty->driver.wait_until_sent) {
+		lock_kernel();
+		tty->driver.wait_until_sent(tty, MSECS_TO_JIFFIES(100));
+		unlock_kernel();
+	}
+	else {
+		set_task_state(current, TASK_UNINTERRUPTIBLE);
+		schedule_timeout(MSECS_TO_JIFFIES(USBSERIAL_TX_DONE_DELAY));
+	}
+}
+
+/* 
+ *  Function irtty_change_speed (dev, speed)
+ *
+ *    Change the speed of the serial port.
+ *
+ * This may sleep in set_termios (usbserial driver f.e.) and must
+ * not be called from interrupt/timer/tasklet therefore.
+ * All such invocations are deferred to kIrDAd now so we can sleep there.
+ */
+
+static int irtty_change_speed(struct sir_dev *dev, unsigned speed)
+{
+	struct sirtty_cb *priv = dev->priv;
+	struct tty_struct *tty;
+        struct termios old_termios;
+	int cflag;
+
+	ASSERT(priv != NULL, return -1;);
+	ASSERT(priv->magic == IRTTY_MAGIC, return -1;);
+
+	tty = priv->tty;
+
+	lock_kernel();
+	old_termios = *(tty->termios);
+	cflag = tty->termios->c_cflag;
+
+	cflag &= ~CBAUD;
+
+	IRDA_DEBUG(2, "%s(), Setting speed to %d\n", __FUNCTION__, speed);
+
+	switch (speed) {
+	case 1200:
+		cflag |= B1200;
+		break;
+	case 2400:
+		cflag |= B2400;
+		break;
+	case 4800:
+		cflag |= B4800;
+		break;
+	case 19200:
+		cflag |= B19200;
+		break;
+	case 38400:
+		cflag |= B38400;
+		break;
+	case 57600:
+		cflag |= B57600;
+		break;
+	case 115200:
+		cflag |= B115200;
+		break;
+	case 9600:
+	default:
+		cflag |= B9600;
+		break;
+	}	
+
+	tty->termios->c_cflag = cflag;
+	if (tty->driver.set_termios)
+		tty->driver.set_termios(tty, &old_termios);
+	unlock_kernel();
+
+	priv->io.speed = speed;
+
+	return 0;
+}
+
+/*
+ * Function irtty_set_dtr_rts (dev, dtr, rts)
+ *
+ *    This function can be used by dongles etc. to set or reset the status
+ *    of the dtr and rts lines
+ */
+
+static int irtty_set_dtr_rts(struct sir_dev *dev, int dtr, int rts)
+{
+	struct sirtty_cb *priv = dev->priv;
+	int arg = 0;
+
+	ASSERT(priv != NULL, return -1;);
+	ASSERT(priv->magic == IRTTY_MAGIC, return -1;);
+
+#ifdef TIOCM_OUT2 /* Not defined for ARM */
+	arg = TIOCM_OUT2;
+#endif
+	if (rts)
+		arg |= TIOCM_RTS;
+	if (dtr)
+		arg |= TIOCM_DTR;
+
+	/*
+	 * The ioctl() function, or actually set_modem_info() in serial.c
+	 * expects a pointer to the argument in user space. This is working
+	 * here because we are always called from the kIrDAd thread which
+	 * has set_fs(KERNEL_DS) permanently set. Therefore copy_from_user()
+	 * is happy with our arg-parameter being local here in kernel space.
+	 */
+
+	lock_kernel();
+	if (priv->tty->driver.ioctl(priv->tty, NULL, TIOCMSET, (unsigned long) &arg)) { 
+		IRDA_DEBUG(2, "%s(), error doing ioctl!\n", __FUNCTION__);
+	}
+	unlock_kernel();
+
+	return 0;
+}
+
+/* ------------------------------------------------------- */
+
+/* called from sir_dev when there is more data to send
+ * context is either netdev->hard_xmit or some transmit-completion bh
+ * i.e. we are under spinlock here and must not sleep.
+ *
+ * Note: as of 2.5.44 the usb-serial driver calls down() on a semaphore
+ * hence we are hitting the might_sleep bugcatcher. IMHO the whole tty-api
+ * would be pretty pointless if write_room/write would be allowed to sleep.
+ * Furthermore other tty ldiscs (like ppp) do also require the driver not
+ * to sleep there. Hence this is considered a current limitation of
+ * usb-serial.
+ */
+
+static int irtty_do_write(struct sir_dev *dev, const unsigned char *ptr, size_t len)
+{
+	struct sirtty_cb *priv = dev->priv;
+	struct tty_struct *tty;
+	int writelen;
+
+	ASSERT(priv != NULL, return -1;);
+	ASSERT(priv->magic == IRTTY_MAGIC, return -1;);
+
+	tty = priv->tty;
+	if (!tty->driver.write)
+		return 0;
+	tty->flags |= (1 << TTY_DO_WRITE_WAKEUP);
+	if (tty->driver.write_room) {
+		writelen = tty->driver.write_room(tty);
+		if (writelen > len)
+			writelen = len;
+	}
+	else
+		writelen = len;
+	return tty->driver.write(tty, 0, ptr, writelen);
+}
+
+/* ------------------------------------------------------- */
+
+/* irda line discipline callbacks */
+
+/* 
+ *  Function irtty_receive_buf( tty, cp, count)
+ *
+ *    Handle the 'receiver data ready' interrupt.  This function is called
+ *    by the 'tty_io' module in the kernel when a block of IrDA data has
+ *    been received, which can now be decapsulated and delivered for
+ *    further processing 
+ *
+ * calling context depends on underlying driver and tty->low_latency!
+ * for example (low_latency: 1 / 0):
+ * serial.c:	uart-interrupt / softint
+ * usbserial:	urb-complete-interrupt / softint
+ */
+
+static void irtty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
+			      char *fp, int count) 
+{
+	struct sir_dev *dev;
+	struct sirtty_cb *priv = tty->disc_data;
+	int	i;
+
+	if (unlikely(!priv || priv->magic!=IRTTY_MAGIC))
+		return;
+	/* Please use ASSERT - Fix ASSERT as needed - Jean II */
+
+	if (unlikely(count==0))		/* yes, this happens */
+		return;
+
+	dev = priv->dev;
+	if (!dev) {
+		printk(KERN_ERR "%s(), not ready yet!\n", __FUNCTION__);
+		return;
+	}
+
+	for (i = 0; i < count; i++) {
+		/* 
+		 *  Characters received with a parity error, etc?
+		 */
+ 		if (fp && *fp++) { 
+			IRDA_DEBUG(0, "Framing or parity error!\n");
+			sirdev_receive(dev, NULL, 0);	/* notify sir_dev (updating stats) */
+			return;
+ 		}
+	}
+
+	sirdev_receive(dev, cp, count);
+}
+
+/*
+ * Function irtty_receive_room (tty)
+ *
+ *    Used by the TTY to find out how much data we can receive at a time
+ * 
+*/
+static int irtty_receive_room(struct tty_struct *tty) 
+{
+	struct sirtty_cb *priv = tty->disc_data;
+
+	if (unlikely(!priv || priv->magic!=IRTTY_MAGIC))
+		return 0;
+
+	return 65536;  /* We can handle an infinite amount of data. :-) */
+}
+
+/*
+ * Function irtty_write_wakeup (tty)
+ *
+ *    Called by the driver when there's room for more data.  If we have
+ *    more packets to send, we send them here.
+ *
+ */
+static void irtty_write_wakeup(struct tty_struct *tty) 
+{
+	struct sirtty_cb *priv = tty->disc_data;
+
+	if (unlikely(!priv || priv->magic!=IRTTY_MAGIC))
+		return;
+
+	tty->flags &= ~(1 << TTY_DO_WRITE_WAKEUP);
+
+	if (priv->dev)
+		sirdev_write_complete(priv->dev);
+}
+
+/* ------------------------------------------------------- */
+
+/*
+ * Function irtty_stop_receiver (tty, stop)
+ *
+ */
+
+static inline void irtty_stop_receiver(struct tty_struct *tty, int stop)
+{
+	struct termios old_termios;
+	int cflag;
+
+	lock_kernel();
+	old_termios = *(tty->termios);
+	cflag = tty->termios->c_cflag;
+	
+	if (stop)
+		cflag &= ~CREAD;
+	else
+		cflag |= CREAD;
+
+	tty->termios->c_cflag = cflag;
+	if (tty->driver.set_termios)
+		tty->driver.set_termios(tty, &old_termios);
+	unlock_kernel();
+}
+
+/*****************************************************************/
+
+DECLARE_MUTEX(irtty_sem);		/* serialize ldisc open/close with sir_dev */
+
+/* notifier from sir_dev when irda% device gets opened (ifup) */
+
+static int irtty_start_dev(struct sir_dev *dev)
+{
+	struct sirtty_cb *priv;
+	struct tty_struct *tty;
+
+	/* serialize with ldisc open/close */
+	down(&irtty_sem);
+
+	priv = dev->priv;
+	if (unlikely(!priv || priv->magic!=IRTTY_MAGIC)) {
+		up(&irtty_sem);
+		return -ESTALE;
+	}
+
+	tty = priv->tty;
+
+	if (tty->driver.start)
+		tty->driver.start(tty);
+	/* Make sure we can receive more data */
+	irtty_stop_receiver(tty, FALSE);
+
+	up(&irtty_sem);
+	return 0;
+}
+
+/* notifier from sir_dev when irda% device gets closed (ifdown) */
+
+static int irtty_stop_dev(struct sir_dev *dev)
+{
+	struct sirtty_cb *priv;
+	struct tty_struct *tty;
+
+	/* serialize with ldisc open/close */
+	down(&irtty_sem);
+
+	priv = dev->priv;
+	if (unlikely(!priv || priv->magic!=IRTTY_MAGIC)) {
+		up(&irtty_sem);
+		return -ESTALE;
+	}
+
+	tty = priv->tty;
+
+	/* Make sure we don't receive more data */
+	irtty_stop_receiver(tty, TRUE);
+	if (tty->driver.stop)
+		tty->driver.stop(tty);
+
+	up(&irtty_sem);
+
+	return 0;
+}
+
+/* ------------------------------------------------------- */
+
+struct sir_driver sir_tty_drv = {
+	.owner			= THIS_MODULE,
+	.driver_name		= "sir_tty",
+	.start_dev		= irtty_start_dev,
+	.stop_dev		= irtty_stop_dev,
+	.do_write		= irtty_do_write,
+	.chars_in_buffer	= irtty_chars_in_buffer,
+	.wait_until_sent	= irtty_wait_until_sent,
+	.set_speed		= irtty_change_speed,
+	.set_dtr_rts		= irtty_set_dtr_rts,
+};
+
+/* ------------------------------------------------------- */
+
+/*
+ * Function irtty_ioctl (tty, file, cmd, arg)
+ *
+ *     The Swiss army knife of system calls :-)
+ *
+ */
+static int irtty_ioctl(struct tty_struct *tty, struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct irtty_info { char name[6]; } info;
+	struct sir_dev *dev;
+	struct sirtty_cb *priv = tty->disc_data;
+	int size = _IOC_SIZE(cmd);
+	int err = 0;
+
+	ASSERT(priv != NULL, return -ENODEV;);
+	ASSERT(priv->magic == IRTTY_MAGIC, return -EBADR;);
+
+	IRDA_DEBUG(3, "%s(cmd=0x%X)\n", __FUNCTION__, cmd);
+
+	dev = priv->dev;
+	ASSERT(dev != NULL, return -1;);
+
+	if (_IOC_DIR(cmd) & _IOC_READ)
+		err = verify_area(VERIFY_WRITE, (void *) arg, size);
+	else if (_IOC_DIR(cmd) & _IOC_WRITE)
+		err = verify_area(VERIFY_READ, (void *) arg, size);
+	if (err)
+		return err;
+	
+	switch (cmd) {
+	case TCGETS:
+	case TCGETA:
+		err = n_tty_ioctl(tty, file, cmd, arg);
+		break;
+
+	case IRTTY_IOCTDONGLE:
+		/* this call blocks for completion */
+		err = sirdev_set_dongle(dev, (IRDA_DONGLE) arg);
+		break;
+
+	case IRTTY_IOCGET:
+		ASSERT(dev->netdev != NULL, return -1;);
+
+		memset(&info, 0, sizeof(info)); 
+		strncpy(info.name, dev->netdev->name, sizeof(info.name)-1);
+
+		if (copy_to_user((void *)arg, &info, sizeof(info)))
+			err = -EFAULT;
+		break;
+	default:
+		err = -ENOIOCTLCMD;
+		break;
+	}
+	return err;
+}
+
+
+/* 
+ *  Function irtty_open(tty)
+ *
+ *    This function is called by the TTY module when the IrDA line
+ *    discipline is called for.  Because we are sure the tty line exists,
+ *    we only have to link it to a free IrDA channel.  
+ */
+static int irtty_open(struct tty_struct *tty) 
+{
+	struct sir_dev *dev;
+	struct sirtty_cb *priv;
+	char hwname[16];
+	int ret = 0;
+
+	/* unfortunately, there's no tty_ldisc->owner field
+	 * so there is some window for SMP race with rmmod
+	 */
+	MOD_INC_USE_COUNT;
+
+	/* First make sure we're not already connected. */
+	if (tty->disc_data != NULL) {
+		priv = tty->disc_data;
+		if (priv && priv->magic == IRTTY_MAGIC) {
+			ret = -EEXIST;
+			goto out;
+		}
+		tty->disc_data = NULL;		/* ### */
+	}
+
+	/* stop the underlying  driver */
+	irtty_stop_receiver(tty, TRUE);
+	if (tty->driver.stop)
+		tty->driver.stop(tty);
+
+	if (tty->driver.flush_buffer)
+		tty->driver.flush_buffer(tty);
+	
+/* from old irtty - but what is it good for?
+ * we _are_ the ldisc and we _dont_ implement flush_buffer!
+ *
+ *	if (tty->ldisc.flush_buffer)
+ *		tty->ldisc.flush_buffer(tty);
+ */
+
+
+	/* create device name - could we use tty_name() here? */
+
+	if (strchr(tty->driver.name, '%')) {
+		sprintf(hwname, tty->driver.name,
+			minor(tty->device) - tty->driver.minor_start +
+			tty->driver.name_base);
+	}
+	else {
+		sprintf(hwname, "%s%d", tty->driver.name,
+			minor(tty->device) - tty->driver.minor_start +
+			tty->driver.name_base);
+	}
+
+	/* apply mtt override */
+	sir_tty_drv.qos_mtt_bits = qos_mtt_bits;
+
+	/* get a sir device instance for this driver */
+	dev = sirdev_get_instance(&sir_tty_drv, hwname);
+	if (!dev) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	/* allocate private device info block */
+	priv = kmalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		goto out_put;
+	memset(priv, 0, sizeof(*priv));
+
+	priv->magic = IRTTY_MAGIC;
+	priv->tty = tty;
+	priv->dev = dev;
+
+	/* serialize with start_dev - in case we were racing with ifup */
+	down(&irtty_sem);
+
+	dev->priv = priv;
+	tty->disc_data = priv;
+
+	up(&irtty_sem);
+
+	printk(KERN_INFO "%s - done\n", __FUNCTION__);
+
+	return 0;
+
+out_put:
+	sirdev_put_instance(dev);
+out:
+	MOD_DEC_USE_COUNT;
+	return ret;
+}
+
+/* 
+ *  Function irtty_close (tty)
+ *
+ *    Close down a IrDA channel. This means flushing out any pending queues,
+ *    and then restoring the TTY line discipline to what it was before it got
+ *    hooked to IrDA (which usually is TTY again).  
+ */
+static void irtty_close(struct tty_struct *tty) 
+{
+	struct sirtty_cb *priv = tty->disc_data;
+
+	if (!priv  ||  priv->magic != IRTTY_MAGIC)
+		return;
+
+	/* Hm, with a dongle attached the dongle driver wants
+	 * to close the dongle - which requires the use of
+	 * some tty write and/or termios or ioctl operations.
+	 * Are we allowed to call those when already requested
+	 * to shutdown the ldisc?
+	 * If not, we should somehow mark the dev being staled.
+	 * Question remains, how to close the dongle in this case...
+	 * For now let's assume we are granted to issue tty driver calls
+	 * until we return here from the ldisc close. I'm just wondering
+	 * how this behaves with hotpluggable serial hardware like
+	 * rs232-pcmcia card or usb-serial...
+	 *
+	 * priv->tty = NULL?;
+	 */
+
+	/* we are dead now */
+	tty->disc_data = 0;
+
+	sirdev_put_instance(priv->dev);
+
+	/* Stop tty */
+	irtty_stop_receiver(tty, TRUE);
+	tty->flags &= ~(1 << TTY_DO_WRITE_WAKEUP);
+	if (tty->driver.stop)
+		tty->driver.stop(tty);
+
+	kfree(priv);
+
+	MOD_DEC_USE_COUNT;
+}
+
+/* ------------------------------------------------------- */
+
+static struct tty_ldisc irda_ldisc = {
+	.magic		= TTY_LDISC_MAGIC,
+ 	.name		= "irda",
+	.flags		= 0,
+	.open		= irtty_open,
+	.close		= irtty_close,
+	.read		= NULL,
+	.write		= NULL,
+	.ioctl		= irtty_ioctl,
+ 	.poll		= NULL,
+	.receive_buf	= irtty_receive_buf,
+	.receive_room	= irtty_receive_room,
+	.write_wakeup	= irtty_write_wakeup,
+};
+
+/* ------------------------------------------------------- */
+
+static int __init irtty_sir_init(void)
+{
+	int err;
+
+	if ((err = tty_register_ldisc(N_IRDA, &irda_ldisc)) != 0)
+		ERROR("IrDA: can't register line discipline (err = %d)\n",
+			err);
+	return err;
+}
+
+static void __exit irtty_sir_cleanup(void) 
+{
+	int err;
+
+	if ((err = tty_register_ldisc(N_IRDA, NULL))) {
+		ERROR("%s(), can't unregister line discipline (err = %d)\n",
+		      __FUNCTION__, err);
+	}
+}
+
+module_init(irtty_sir_init);
+module_exit(irtty_sir_cleanup);
+
+MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
+MODULE_DESCRIPTION("IrDA TTY device driver");
+MODULE_LICENSE("GPL");
+
diff -u -p --new-file linux/drivers/net/irda-d6/irtty-sir.h linux/drivers/net/irda/irtty-sir.h
--- linux/drivers/net/irda-d6/irtty-sir.h	Wed Dec 31 16:00:00 1969
+++ linux/drivers/net/irda/irtty-sir.h	Thu Oct 31 15:53:41 2002
@@ -0,0 +1,34 @@
+/*********************************************************************
+ *
+ *	sir_tty.h:	definitions for the irtty_sir client driver (former irtty)
+ *
+ *	Copyright (c) 2002 Martin Diehl
+ *
+ *	This program is free software; you can redistribute it and/or 
+ *	modify it under the terms of the GNU General Public License as 
+ *	published by the Free Software Foundation; either version 2 of 
+ *	the License, or (at your option) any later version.
+ *
+ ********************************************************************/
+
+#ifndef IRTTYSIR_H
+#define IRTTYSIR_H
+
+#include <net/irda/irda.h>
+#include <net/irda/irda_device.h>		// chipio_t
+
+#define IRTTY_IOC_MAGIC 'e'
+#define IRTTY_IOCTDONGLE  _IO(IRTTY_IOC_MAGIC, 1)
+#define IRTTY_IOCGET     _IOR(IRTTY_IOC_MAGIC, 2, struct irtty_info)
+#define IRTTY_IOC_MAXNR   2
+
+struct sirtty_cb {
+	magic_t magic;
+
+	struct sir_dev *dev;
+	struct tty_struct  *tty;
+
+	chipio_t io;               /* IrDA controller information */
+};
+
+#endif
diff -u -p --new-file linux/drivers/net/irda-d6/sir-dev.h linux/drivers/net/irda/sir-dev.h
--- linux/drivers/net/irda-d6/sir-dev.h	Wed Dec 31 16:00:00 1969
+++ linux/drivers/net/irda/sir-dev.h	Thu Oct 31 15:54:20 2002
@@ -0,0 +1,203 @@
+/*********************************************************************
+ *
+ *	sir.h:	include file for irda-sir device abstraction layer
+ *
+ *	Copyright (c) 2002 Martin Diehl
+ *
+ *	This program is free software; you can redistribute it and/or 
+ *	modify it under the terms of the GNU General Public License as 
+ *	published by the Free Software Foundation; either version 2 of 
+ *	the License, or (at your option) any later version.
+ *
+ ********************************************************************/
+
+#ifndef IRDA_SIR_H
+#define IRDA_SIR_H
+
+#include <linux/netdevice.h>
+
+#include <net/irda/irda.h>
+#include <net/irda/irda_device.h>		// iobuff_t
+
+/* FIXME: unify irda_request with sir_fsm! */
+
+struct irda_request {
+	struct list_head lh_request;
+	unsigned long pending;
+	void (*func)(void *);
+	void *data;
+	struct timer_list timer;
+};
+
+struct sir_fsm {
+	struct semaphore	sem;
+	struct irda_request	rq;
+	unsigned		state, substate;
+	int			param;
+	int			result;
+};
+
+#define SIRDEV_STATE_WAIT_TX_COMPLETE	0x0100
+
+/* substates for wait_tx_complete */
+#define SIRDEV_STATE_WAIT_XMIT		0x0101
+#define SIRDEV_STATE_WAIT_UNTIL_SENT	0x0102
+#define SIRDEV_STATE_TX_DONE		0x0103
+
+#define SIRDEV_STATE_DONGLE_OPEN		0x0300
+
+/* 0x0301-0x03ff reserved for individual dongle substates */
+
+#define SIRDEV_STATE_DONGLE_CLOSE	0x0400
+
+/* 0x0401-0x04ff reserved for individual dongle substates */
+
+#define SIRDEV_STATE_SET_DTR_RTS		0x0500
+
+#define SIRDEV_STATE_SET_SPEED		0x0700
+#define SIRDEV_STATE_DONGLE_CHECK	0x0800
+#define SIRDEV_STATE_DONGLE_RESET	0x0900
+
+/* 0x0901-0x09ff reserved for individual dongle substates */
+
+#define SIRDEV_STATE_DONGLE_SPEED	0x0a00
+/* 0x0a01-0x0aff reserved for individual dongle substates */
+
+#define SIRDEV_STATE_PORT_SPEED		0x0b00
+#define SIRDEV_STATE_DONE		0x0c00
+#define SIRDEV_STATE_ERROR		0x0d00
+#define SIRDEV_STATE_COMPLETE		0x0e00
+
+#define SIRDEV_STATE_DEAD		0xffff
+
+
+struct sir_dev;
+
+struct dongle_driver {
+
+	struct module *owner;
+
+	const char *driver_name;
+
+	IRDA_DONGLE type;
+
+	int	(*open)(struct sir_dev *dev);
+	int	(*close)(struct sir_dev *dev);
+	int	(*reset)(struct sir_dev *dev);
+	int	(*set_speed)(struct sir_dev *dev, unsigned speed);
+
+	struct list_head dongle_list;
+};
+
+struct sir_driver {
+
+	struct module *owner;
+
+	const char *driver_name;
+
+	int qos_mtt_bits;
+
+	int (*chars_in_buffer)(struct sir_dev *dev);
+	void (*wait_until_sent)(struct sir_dev *dev);
+	int (*set_speed)(struct sir_dev *dev, unsigned speed);
+	int (*set_dtr_rts)(struct sir_dev *dev, int dtr, int rts);
+
+	int (*do_write)(struct sir_dev *dev, const unsigned char *ptr, size_t len);
+
+	int (*start_dev)(struct sir_dev *dev);
+	int (*stop_dev)(struct sir_dev *dev);
+};
+
+
+/* exported */
+
+extern int irda_register_dongle(struct dongle_driver *new);
+extern int irda_unregister_dongle(struct dongle_driver *drv);
+
+extern struct sir_dev * sirdev_get_instance(const struct sir_driver *drv, const char *name);
+extern int sirdev_put_instance(struct sir_dev *self);
+
+extern int sirdev_set_dongle(struct sir_dev *dev, IRDA_DONGLE type);
+extern void sirdev_write_complete(struct sir_dev *dev);
+extern int sirdev_receive(struct sir_dev *dev, const unsigned char *cp, size_t count);
+
+/* not exported */
+
+extern int sirdev_get_dongle(struct sir_dev *self, IRDA_DONGLE type);
+extern int sirdev_put_dongle(struct sir_dev *self);
+
+extern int sirdev_raw_write(struct sir_dev *dev, const char *buf, int len);
+extern int sirdev_raw_read(struct sir_dev *dev, char *buf, int len);
+extern void sirdev_enable_rx(struct sir_dev *dev);
+
+extern int sirdev_schedule_request(struct sir_dev *dev, int state, unsigned param);
+extern int __init irda_thread_create(void);
+extern void __exit irda_thread_join(void);
+
+/* inline helpers */
+
+static inline int sirdev_schedule_speed(struct sir_dev *dev, unsigned speed)
+{
+	return sirdev_schedule_request(dev, SIRDEV_STATE_SET_SPEED, speed);
+}
+
+static inline int sirdev_schedule_dongle_open(struct sir_dev *dev, int dongle_id)
+{
+	return sirdev_schedule_request(dev, SIRDEV_STATE_DONGLE_OPEN, dongle_id);
+}
+
+static inline int sirdev_schedule_dongle_close(struct sir_dev *dev)
+{
+	return sirdev_schedule_request(dev, SIRDEV_STATE_DONGLE_CLOSE, 0);
+}
+
+static inline int sirdev_schedule_dtr_rts(struct sir_dev *dev, int dtr, int rts)
+{
+	int	dtrrts;
+
+	dtrrts = ((dtr) ? 0x02 : 0x00) | ((rts) ? 0x01 : 0x00);
+	return sirdev_schedule_request(dev, SIRDEV_STATE_SET_DTR_RTS, dtrrts);
+}
+
+#if 0
+static inline int sirdev_schedule_mode(struct sir_dev *dev, int mode)
+{
+	return sirdev_schedule_request(dev, SIRDEV_STATE_SET_MODE, mode);
+}
+#endif
+
+
+struct sir_dev {
+	struct net_device *netdev;
+	struct net_device_stats stats;
+
+	struct irlap_cb    *irlap;
+
+	struct qos_info qos;
+
+	char hwname[32];
+
+	struct sir_fsm fsm;
+	atomic_t enable_rx;
+	spinlock_t tx_lock;
+
+	u32 new_speed;
+ 	u32 flags;
+
+	unsigned	speed;
+
+	iobuff_t tx_buff;          /* Transmit buffer */
+	iobuff_t rx_buff;          /* Receive buffer */
+	struct sk_buff *tx_skb;
+
+	const struct dongle_driver * dongle_drv;
+	const struct sir_driver * drv;
+	void *priv;
+
+	/* dongle callbacks to the SIR device */
+	int (*read)(struct sir_dev *, char *buf, int len);
+	int (*write)(struct sir_dev *, const char *buf, int len);
+	int (*set_dtr_rts)(struct sir_dev *, int dtr, int rts);
+};
+
+#endif	/* IRDA_SIR_H */
diff -u -p --new-file linux/drivers/net/irda-d6/sir_core.c linux/drivers/net/irda/sir_core.c
--- linux/drivers/net/irda-d6/sir_core.c	Wed Dec 31 16:00:00 1969
+++ linux/drivers/net/irda/sir_core.c	Thu Oct 31 16:17:07 2002
@@ -0,0 +1,52 @@
+/*********************************************************************
+ *
+ *	sir_core.c:	module core for irda-sir abstraction layer
+ *
+ *	Copyright (c) 2002 Martin Diehl
+ * 
+ *	This program is free software; you can redistribute it and/or 
+ *	modify it under the terms of the GNU General Public License as 
+ *	published by the Free Software Foundation; either version 2 of 
+ *	the License, or (at your option) any later version.
+ *
+ ********************************************************************/    
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+
+#include <net/irda/irda.h>
+
+#include "sir-dev.h"
+
+/***************************************************************************/
+
+MODULE_AUTHOR("Martin Diehl <info@mdiehl.de>");
+MODULE_DESCRIPTION("IrDA SIR core");
+MODULE_LICENSE("GPL");
+
+/***************************************************************************/
+
+EXPORT_SYMBOL(irda_register_dongle);
+EXPORT_SYMBOL(irda_unregister_dongle);
+
+EXPORT_SYMBOL(sirdev_get_instance);
+EXPORT_SYMBOL(sirdev_put_instance);
+
+EXPORT_SYMBOL(sirdev_set_dongle);
+EXPORT_SYMBOL(sirdev_write_complete);
+EXPORT_SYMBOL(sirdev_receive);
+
+static int __init sir_core_init(void)
+{
+	return irda_thread_create();
+}
+
+static void __exit sir_core_exit(void)
+{
+	irda_thread_join();
+}
+
+module_init(sir_core_init);
+module_exit(sir_core_exit);
+
diff -u -p --new-file linux/drivers/net/irda-d6/sir_dev.c linux/drivers/net/irda/sir_dev.c
--- linux/drivers/net/irda-d6/sir_dev.c	Wed Dec 31 16:00:00 1969
+++ linux/drivers/net/irda/sir_dev.c	Thu Oct 31 17:50:08 2002
@@ -0,0 +1,673 @@
+/*********************************************************************
+ *
+ *	sir_dev.c:	irda sir network device
+ * 
+ *	Copyright (c) 2002 Martin Diehl
+ * 
+ *	This program is free software; you can redistribute it and/or 
+ *	modify it under the terms of the GNU General Public License as 
+ *	published by the Free Software Foundation; either version 2 of 
+ *	the License, or (at your option) any later version.
+ *
+ ********************************************************************/    
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/smp_lock.h>
+
+#include <net/irda/irda.h>
+#include <net/irda/wrapper.h>
+#include <net/irda/irda_device.h>
+
+#include "sir-dev.h"
+
+/***************************************************************************/
+
+void sirdev_enable_rx(struct sir_dev *dev)
+{
+	if (unlikely(atomic_read(&dev->enable_rx)))
+		return;
+
+	/* flush rx-buffer - should also help in case of problems with echo cancelation */
+	dev->rx_buff.data = dev->rx_buff.head;
+	dev->tx_buff.len = 0;
+	atomic_set(&dev->enable_rx, 1);
+}
+
+static int sirdev_is_receiving(struct sir_dev *dev)
+{
+	if (!atomic_read(&dev->enable_rx))
+		return 0;
+
+	return (dev->rx_buff.state != OUTSIDE_FRAME);
+}
+
+int sirdev_set_dongle(struct sir_dev *dev, IRDA_DONGLE type)
+{
+	int err;
+
+	IRDA_DEBUG(3, "%s : requesting dongle %d.\n", __FUNCTION__, type);
+
+	err = sirdev_schedule_dongle_open(dev, type);
+	if (unlikely(err))
+		return err;
+	down(&dev->fsm.sem);		/* block until config change completed */
+	err = dev->fsm.result;
+	up(&dev->fsm.sem);
+	return err;
+}
+
+/* used by dongle drivers for dongle programming */
+
+int sirdev_raw_write(struct sir_dev *dev, const char *buf, int len)
+{
+	int ret;
+
+	if (unlikely(len > dev->tx_buff.truesize))
+		return -ENOSPC;
+
+	spin_lock_bh(&dev->tx_lock);		/* serialize with other tx operations */
+	while (dev->tx_buff.len > 0) {		/* wait until tx idle */
+		spin_unlock_bh(&dev->tx_lock);
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(MSECS_TO_JIFFIES(10));
+		spin_lock_bh(&dev->tx_lock);
+	}
+
+	dev->tx_buff.data = dev->tx_buff.head;
+	memcpy(dev->tx_buff.data, buf, len);	
+
+	ret = dev->drv->do_write(dev, dev->tx_buff.data, dev->tx_buff.len);
+	spin_unlock_bh(&dev->tx_lock);
+	return ret;
+}
+
+/* seems some dongle drivers may need this */
+
+int sirdev_raw_read(struct sir_dev *dev, char *buf, int len)
+{
+	int count;
+
+	if (atomic_read(&dev->enable_rx))
+		return -EIO;		/* fail if we expect irda-frames */
+
+	count = (len < dev->rx_buff.len) ? len : dev->rx_buff.len;
+
+	if (count > 0)
+		memcpy(buf, dev->rx_buff.head, count);
+
+	/* forget trailing stuff */
+	dev->rx_buff.data = dev->rx_buff.head;
+	dev->rx_buff.len = 0;
+	dev->rx_buff.state = OUTSIDE_FRAME;
+
+	return count;
+}
+
+/**********************************************************************/
+
+/* called from client driver - likely with bh-context - to indicate
+ * it made some progress with transmission. Hence we send the next
+ * chunk, if any, or complete the skb otherwise
+ */
+
+void sirdev_write_complete(struct sir_dev *dev)
+{
+	struct sk_buff *skb;
+	int actual = 0;
+	int err;
+	
+	spin_lock_bh(&dev->tx_lock);
+
+	IRDA_DEBUG(3, "%s() - dev->tx_buff.len = %d\n",
+		   __FUNCTION__, dev->tx_buff.len);
+
+	if (likely(dev->tx_buff.len > 0))  {
+		/* Write data left in transmit buffer */
+		actual = dev->drv->do_write(dev, dev->tx_buff.data, dev->tx_buff.len);
+
+		if (likely(actual>0)) {
+			dev->tx_buff.data += actual;
+			dev->tx_buff.len  -= actual;
+		}
+		else if (unlikely(actual<0)) {
+			/* could be dropped later when we have tx_timeout to recover */
+			ERROR("%s: drv->do_write failed (%d)\n", __FUNCTION__, actual);
+			if ((skb=dev->tx_skb) != NULL) {
+				dev->tx_skb = NULL;
+				dev_kfree_skb_any(skb);
+				dev->stats.tx_errors++;		      
+				dev->stats.tx_dropped++;		      
+			}
+			dev->tx_buff.len = 0;
+		}
+		if (dev->tx_buff.len > 0) {
+			spin_unlock_bh(&dev->tx_lock);
+			return;
+		}
+	}
+
+	/* we have finished now sending this skb.
+	 * update statistics and free the skb.
+	 * finally we check and trigger a pending speed change, if any.
+	 * if not we switch to rx mode and wake the queue for further
+	 * packets.
+	 * note the scheduled speed request blocks until the lower
+	 * client driver and the corresponding hardware has really
+	 * finished sending all data (xmit fifo drained f.e.)
+	 * before the speed change gets finally done and the queue
+	 * re-activated.
+	 */
+
+	IRDA_DEBUG(5, "%s(), finished with frame!\n", __FUNCTION__);
+		
+	if ((skb=dev->tx_skb) != NULL) {
+		dev->tx_skb = NULL;
+		dev->stats.tx_packets++;		      
+		dev->stats.tx_bytes += skb->len;
+		dev_kfree_skb_any(skb);
+	}
+
+	if (unlikely(dev->new_speed > 0)) {
+		IRDA_DEBUG(5, "%s(), Changing speed!\n", __FUNCTION__);
+		err = sirdev_schedule_speed(dev, dev->new_speed);
+		if (unlikely(err)) {
+			/* should never happen
+			 * forget the speed change and hope the stack recovers
+			 */
+			ERROR("%s - schedule speed change failed: %d\n", __FUNCTION__, err);
+			netif_wake_queue(dev->netdev);
+		}
+		/* else: success
+		 *	speed change in progress now
+		 *	on completion dev->new_speed gets cleared,
+		 *	rx-reenabled and the queue restarted
+		 */
+	}
+	else {
+		sirdev_enable_rx(dev);
+		netif_wake_queue(dev->netdev);
+	}
+
+	spin_unlock_bh(&dev->tx_lock);
+}
+
+/* called from client driver - likely with bh-context - to give us
+ * some more received bytes. We put them into the rx-buffer,
+ * normally unwrapping and building LAP-skb's (unless rx disabled)
+ */
+
+int sirdev_receive(struct sir_dev *dev, const unsigned char *cp, size_t count) 
+{
+	if (!dev || !dev->netdev) {
+		IRDA_DEBUG(0, "%s(), not ready yet!\n", __FUNCTION__);
+		/* Use WARNING instead of IRDA_DEBUG */
+		return -1;
+	}
+
+	if (!dev->irlap) {
+		IRDA_DEBUG(0, "%s - too early: %p / %d!\n", __FUNCTION__, cp, count);
+		/* Use WARNING instead of IRDA_DEBUG */
+		return -1;
+	}
+
+	if (cp==NULL) {
+		/* error already at lower level receive
+		 * just update stats and set media busy
+		 */
+		irda_device_set_media_busy(dev->netdev, TRUE);
+		dev->stats.rx_dropped++;
+		printk(KERN_INFO "%s; rx-drop: %d\n", __FUNCTION__, count);
+		return 0;
+	}
+
+	/* Read the characters into the buffer */
+ 	while (count--) {
+		if (likely(atomic_read(&dev->enable_rx))) {
+			/* Unwrap and destuff one byte */
+			async_unwrap_char(dev->netdev, &dev->stats, 
+				  &dev->rx_buff, *cp++);
+		}
+		else {
+			/* rx not enabled: save the raw bytes and never
+			 * trigger any netif_rx. The received bytes are flushed
+			 * later when we re-enable rx but might be read meanwhile
+			 * by the dongle driver.
+			 */
+			dev->rx_buff.data[dev->rx_buff.len++] = *cp++;
+		}
+
+		/* What should we do when the buffer is full? */
+		if (unlikely(dev->rx_buff.len == dev->rx_buff.truesize))
+			dev->rx_buff.len = 0;
+			
+	}
+
+	return 0;
+}
+
+/**********************************************************************/
+
+/* callbacks from network layer */
+
+static struct net_device_stats *sirdev_get_stats(struct net_device *ndev)
+{
+	struct sir_dev *dev = ndev->priv;
+
+	return (dev) ? &dev->stats : NULL;
+}
+
+static int sirdev_hard_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct sir_dev *dev = ndev->priv;
+	int actual = 0;
+	int err;
+	s32 speed;
+
+	ASSERT(dev != NULL, return 0;);
+
+	netif_stop_queue(ndev);
+
+	IRDA_DEBUG(3, "%s(), skb->len = %d\n", __FUNCTION__, skb->len);
+
+	speed = irda_get_next_speed(skb);
+	if ((speed != dev->speed) && (speed != -1)) {
+		if (!skb->len) {
+			err = sirdev_schedule_speed(dev, speed);
+			if (unlikely(err == -EWOULDBLOCK)) {
+				/* Failed to initiate the speed change, likely the fsm
+				 * is still busy (pretty unlikely, but...)
+				 * We refuse to accept the skb and return with the queue
+				 * stopped so the network layer will retry after the
+				 * fsm completes and wakes the queue.
+				 */
+				 return 1;
+			}
+			else if (unlikely(err)) {
+				/* other fatal error - forget the speed change and
+				 * hope the stack will recover somehow
+				 */
+				 netif_start_queue(ndev);
+			}
+			/* else: success
+			 *	speed change in progress now
+			 *	on completion the queue gets restarted
+			 */
+
+			dev_kfree_skb_any(skb);
+			return 0;
+		} else
+			dev->new_speed = speed;
+	}
+
+	/* Init tx buffer*/
+	dev->tx_buff.data = dev->tx_buff.head;
+
+	/* Check problems */
+	if(spin_is_locked(&dev->tx_lock)) {
+		IRDA_DEBUG(3, "%s(), write not completed\n", __FUNCTION__);
+	}
+
+	/* serialize with write completion */
+	spin_lock_bh(&dev->tx_lock);
+
+        /* Copy skb to tx_buff while wrapping, stuffing and making CRC */
+	dev->tx_buff.len = async_wrap_skb(skb, dev->tx_buff.data, dev->tx_buff.truesize); 
+
+	/* transmission will start now - disable receive.
+	 * if we are just in the middle of an incoming frame,
+	 * treat it as collision. probably it's a good idea to
+	 * reset the rx_buf OUTSIDE_FRAME in this case too?
+	 */
+	atomic_set(&dev->enable_rx, 0);
+	if (unlikely(sirdev_is_receiving(dev)))
+		dev->stats.collisions++;
+
+	actual = dev->drv->do_write(dev, dev->tx_buff.data, dev->tx_buff.len);
+
+	if (likely(actual > 0)) {
+		dev->tx_skb = skb;
+		ndev->trans_start = jiffies;
+		dev->tx_buff.data += actual;
+		dev->tx_buff.len -= actual;
+	}
+	else if (unlikely(actual < 0)) {
+		/* could be dropped later when we have tx_timeout to recover */
+		ERROR("%s: drv->do_write failed (%d)\n", __FUNCTION__, actual);
+		dev_kfree_skb_any(skb);
+		dev->stats.tx_errors++;		      
+		dev->stats.tx_dropped++;		      
+		netif_wake_queue(ndev);
+	}
+	spin_unlock_bh(&dev->tx_lock);
+
+	return 0;
+}
+
+/* called from network layer with rtnl hold */
+
+static int sirdev_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
+{
+	struct if_irda_req *irq = (struct if_irda_req *) rq;
+	struct sir_dev *dev = ndev->priv;
+	int ret = 0;
+
+	ASSERT(dev != NULL, return -1;);
+
+	IRDA_DEBUG(3, "%s(), %s, (cmd=0x%X)\n", __FUNCTION__, ndev->name, cmd);
+	
+	switch (cmd) {
+	case SIOCSBANDWIDTH: /* Set bandwidth */
+		if (!capable(CAP_NET_ADMIN))
+			ret = -EPERM;
+		else
+			ret = sirdev_schedule_speed(dev, irq->ifr_baudrate);
+		/* cannot sleep here for completion
+		 * we are called from network layer with rtnl hold
+		 */
+		break;
+
+	case SIOCSDONGLE: /* Set dongle */
+		if (!capable(CAP_NET_ADMIN))
+			ret = -EPERM;
+		else
+			ret = sirdev_schedule_dongle_open(dev, irq->ifr_dongle);
+		/* cannot sleep here for completion
+		 * we are called from network layer with rtnl hold
+		 */
+		break;
+
+	case SIOCSMEDIABUSY: /* Set media busy */
+		if (!capable(CAP_NET_ADMIN))
+			ret = -EPERM;
+		else
+			irda_device_set_media_busy(dev->netdev, TRUE);
+		break;
+
+	case SIOCGRECEIVING: /* Check if we are receiving right now */
+		irq->ifr_receiving = sirdev_is_receiving(dev);
+		break;
+
+	case SIOCSDTRRTS:
+		if (!capable(CAP_NET_ADMIN))
+			ret = -EPERM;
+		else
+			ret = sirdev_schedule_dtr_rts(dev, irq->ifr_dtr, irq->ifr_rts);
+		/* cannot sleep here for completion
+		 * we are called from network layer with rtnl hold
+		 */
+		break;
+
+	case SIOCSMODE:
+#if 0
+		if (!capable(CAP_NET_ADMIN))
+			ret = -EPERM;
+		else
+			ret = sirdev_schedule_mode(dev, irq->ifr_mode);
+		/* cannot sleep here for completion
+		 * we are called from network layer with rtnl hold
+		 */
+		break;
+#endif
+	default:
+		ret = -EOPNOTSUPP;
+	}
+	
+	return ret;
+}
+
+/* ----------------------------------------------------------------------------- */
+
+#define SIRBUF_ALLOCSIZE 4269	/* worst case size of a wrapped IrLAP frame */
+
+static int sirdev_alloc_buffers(struct sir_dev *dev)
+{
+	dev->rx_buff.truesize = SIRBUF_ALLOCSIZE; 
+	dev->tx_buff.truesize = SIRBUF_ALLOCSIZE;
+
+	dev->rx_buff.head = kmalloc(dev->rx_buff.truesize, GFP_KERNEL);
+	if (dev->rx_buff.head == NULL)
+		return -ENOMEM;
+	memset(dev->rx_buff.head, 0, dev->rx_buff.truesize);
+
+	dev->tx_buff.head = kmalloc(dev->tx_buff.truesize, GFP_KERNEL);
+	if (dev->tx_buff.head == NULL) {
+		kfree(dev->rx_buff.head);
+		dev->rx_buff.head = NULL;
+		return -ENOMEM;
+		memset(dev->tx_buff.head, 0, dev->tx_buff.truesize);
+	}
+
+	dev->tx_buff.data = dev->tx_buff.head;
+	dev->rx_buff.data = dev->rx_buff.head;
+	dev->tx_buff.len = 0;
+	dev->rx_buff.len = 0;
+
+	dev->rx_buff.in_frame = FALSE;
+	dev->rx_buff.state = OUTSIDE_FRAME;
+	return 0;
+};
+
+static void sirdev_free_buffers(struct sir_dev *dev)
+{
+	if (dev->rx_buff.head)
+		kfree(dev->rx_buff.head);
+	if (dev->tx_buff.head)
+		kfree(dev->tx_buff.head);
+	dev->rx_buff.head = dev->tx_buff.head = NULL;
+}
+
+static int sirdev_open(struct net_device *ndev)
+{
+	struct sir_dev *dev = ndev->priv;
+	const struct sir_driver *drv = dev->drv;
+
+	if (!drv)
+		return -ENODEV;
+
+	lock_kernel();		/* serialize with rmmod */
+	/* increase the reference count of the driver module before doing serious stuff */
+	if (drv->owner  &&  !try_inc_mod_count(drv->owner)) {
+		unlock_kernel();
+		return -ESTALE;
+	}
+	unlock_kernel();
+
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
+
+	if (sirdev_alloc_buffers(dev))
+		goto errout_dec;
+
+	if (!dev->drv->start_dev  ||  dev->drv->start_dev(dev))
+		goto errout_free;
+
+	sirdev_enable_rx(dev);
+
+	netif_start_queue(ndev);
+	dev->irlap = irlap_open(ndev, &dev->qos, dev->hwname);
+	if (!dev->irlap)
+		goto errout_stop;
+
+	netif_wake_queue(ndev);
+
+	printk(KERN_INFO "%s - done, speed = %d\n", __FUNCTION__, dev->speed);
+
+	return 0;
+
+errout_stop:
+	atomic_set(&dev->enable_rx, 0);
+	if (dev->drv->stop_dev)
+		dev->drv->stop_dev(dev);
+errout_free:
+	sirdev_free_buffers(dev);
+errout_dec:
+	if (drv->owner)
+		__MOD_DEC_USE_COUNT(drv->owner);
+	return -EAGAIN;
+}
+
+static int sirdev_close(struct net_device *ndev)
+{
+	struct sir_dev *dev = ndev->priv;
+	const struct sir_driver *drv;
+
+	printk(KERN_INFO "%s\n", __FUNCTION__);
+
+	netif_stop_queue(ndev);
+
+	down(&dev->fsm.sem);		/* block on pending config completion */
+
+	atomic_set(&dev->enable_rx, 0);
+
+	if (unlikely(!dev->irlap))
+		goto out;
+	irlap_close(dev->irlap);
+	dev->irlap = NULL;
+
+	drv = dev->drv;
+	if (unlikely(!drv  ||  !dev->priv))
+		goto out;
+
+	if (drv->stop_dev)
+		drv->stop_dev(dev);
+
+	sirdev_free_buffers(dev);
+
+	lock_kernel();
+	if (drv->owner)
+		__MOD_DEC_USE_COUNT(drv->owner);
+	unlock_kernel();
+
+out:
+	dev->speed = 0;
+	up(&dev->fsm.sem);
+	return 0;
+}
+
+/* ----------------------------------------------------------------------------- */
+
+static int sirdev_init(struct net_device *ndev)
+{
+	struct sir_dev *dev = ndev->priv;
+
+	SET_MODULE_OWNER(ndev);
+
+	/* Set up to be a normal IrDA network device driver */
+	irda_device_setup(ndev);
+
+	dev->flags = IFF_SIR | IFF_PIO;
+
+	/* Override the network functions we need to use */
+	ndev->hard_start_xmit = sirdev_hard_xmit;
+	ndev->open = sirdev_open;
+	ndev->stop = sirdev_close;
+	ndev->get_stats = sirdev_get_stats;
+	ndev->do_ioctl = sirdev_ioctl;
+
+	return 0;
+}
+
+
+struct sir_dev * sirdev_get_instance(const struct sir_driver *drv, const char *name)
+{
+	struct net_device *ndev;
+	struct sir_dev *dev;
+
+	printk(KERN_INFO "%s - %s\n", __FUNCTION__, name);
+
+	/* instead of adding tests to protect against drv->do_write==NULL
+	 * at several places we refuse to create a sir_dev instance for
+	 * drivers which dont implement do_write.
+	 */
+	if (!drv ||  !drv->do_write)
+		return NULL;
+
+	/*
+	 *  Allocate new instance of the device
+	 */
+	dev = kmalloc(sizeof(*dev), GFP_KERNEL);
+	if (dev == NULL) {
+		printk(KERN_ERR "IrDA: Can't allocate memory for "
+		       "IrDA control block!\n");
+		goto out;
+	}
+	memset(dev, 0, sizeof(*dev));
+
+	irda_init_max_qos_capabilies(&dev->qos);
+	dev->qos.baud_rate.bits = IR_9600|IR_19200|IR_38400|IR_57600|IR_115200;
+	dev->qos.min_turn_time.bits = drv->qos_mtt_bits;
+	irda_qos_bits_to_value(&dev->qos);
+
+	strncpy(dev->hwname, name, sizeof(dev->hwname)-1);
+
+	ndev = kmalloc(sizeof(*ndev), GFP_KERNEL);
+	if (ndev == NULL)
+		goto out_freedev;
+	memset(ndev, 0, sizeof(*ndev));
+
+	atomic_set(&dev->enable_rx, 0);
+	dev->tx_skb = NULL;
+
+	spin_lock_init(&dev->tx_lock);
+	init_MUTEX(&dev->fsm.sem);
+
+	INIT_LIST_HEAD(&dev->fsm.rq.lh_request);
+	dev->fsm.rq.pending = 0;
+	init_timer(&dev->fsm.rq.timer);
+
+	dev->drv = drv;
+	dev->netdev = ndev;
+
+	ndev->priv = (void *) dev;
+	ndev->init = sirdev_init;
+
+	strcpy(ndev->name, "irda%d");
+	if (register_netdev(ndev)) {
+		ERROR("%s(), register_netdev() failed!\n", __FUNCTION__);
+		goto out_freenetdev;
+	}
+
+	return dev;
+
+out_freenetdev:
+	kfree(ndev);
+out_freedev:
+	kfree(dev);
+out:
+	return NULL;
+}
+
+int sirdev_put_instance(struct sir_dev *dev)
+{
+	int err = 0;
+
+	printk(KERN_INFO "%s\n", __FUNCTION__);
+
+	atomic_set(&dev->enable_rx, 0);
+
+	netif_carrier_off(dev->netdev);
+	netif_device_detach(dev->netdev);
+
+	if (dev->dongle_drv)
+		err = sirdev_schedule_dongle_close(dev);
+	if (err)
+		ERROR("%s - error %d\n", __FUNCTION__, err);
+
+	sirdev_close(dev->netdev);
+
+	down(&dev->fsm.sem);
+	dev->fsm.state = SIRDEV_STATE_DEAD;	/* mark staled */
+	dev->dongle_drv = NULL;
+	dev->priv = NULL;
+	up(&dev->fsm.sem);
+
+	/* Remove netdevice */
+	if (dev->netdev)
+		unregister_netdev(dev->netdev);
+
+	kfree(dev);
+
+	return 0;
+}
+
diff -u -p --new-file linux/drivers/net/irda-d6/sir_dongle.c linux/drivers/net/irda/sir_dongle.c
--- linux/drivers/net/irda-d6/sir_dongle.c	Wed Dec 31 16:00:00 1969
+++ linux/drivers/net/irda/sir_dongle.c	Thu Oct 31 17:05:33 2002
@@ -0,0 +1,146 @@
+/*********************************************************************
+ *
+ *	sir_dongle.c:	manager for serial dongle protocol drivers
+ *
+ *	Copyright (c) 2002 Martin Diehl
+ *
+ *	This program is free software; you can redistribute it and/or 
+ *	modify it under the terms of the GNU General Public License as 
+ *	published by the Free Software Foundation; either version 2 of 
+ *	the License, or (at your option) any later version.
+ *
+ ********************************************************************/    
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/smp_lock.h>
+#include <linux/kmod.h>
+
+#include <net/irda/irda.h>
+
+#include "sir-dev.h"
+
+/**************************************************************************
+ *
+ * dongle registration and attachment
+ *
+ */
+
+static LIST_HEAD(dongle_list);			/* list of registered dongle drivers */
+static DECLARE_MUTEX(dongle_list_lock);		/* protects the list */
+
+int irda_register_dongle(struct dongle_driver *new)
+{
+	struct list_head *entry;
+	struct dongle_driver *drv;
+
+	IRDA_DEBUG(0, "%s : registering dongle \"%s\" (%d).\n",
+		   __FUNCTION__, new->driver_name, new->type);
+
+	down(&dongle_list_lock);
+	list_for_each(entry, &dongle_list) {
+		drv = list_entry(entry, struct dongle_driver, dongle_list);
+		if (new->type == drv->type) {
+			up(&dongle_list_lock);
+			return -EEXIST;
+		}
+	}
+	list_add(&new->dongle_list, &dongle_list);
+	up(&dongle_list_lock);
+	return 0;
+}
+
+int irda_unregister_dongle(struct dongle_driver *drv)
+{
+	down(&dongle_list_lock);
+	list_del(&drv->dongle_list);
+	up(&dongle_list_lock);
+	return 0;
+}
+
+int sirdev_get_dongle(struct sir_dev *dev, IRDA_DONGLE type)
+{
+	struct list_head *entry;
+	const struct dongle_driver *drv = NULL;
+	int err = -EINVAL;
+
+#ifdef CONFIG_KMOD
+	char modname[30];
+
+	sprintf(modname, "irda-dongle-%d", type);
+	request_module(modname);
+#endif
+
+	if (dev->dongle_drv != NULL)
+		return -EBUSY;
+	
+	/* serialize access to the list of registered dongles */
+	down(&dongle_list_lock);
+
+	list_for_each(entry, &dongle_list) {
+		drv = list_entry(entry, struct dongle_driver, dongle_list);
+		if (drv->type == type)
+			break;
+		else
+			drv = NULL;
+	}
+
+	if (!drv) {
+		err = -ENODEV;
+		goto out_unlock;	/* no such dongle */
+	}
+
+	/* handling of SMP races with dongle module removal - three cases:
+	 * 1) dongle driver was already unregistered - then we haven't found the
+	 *	requested dongle above and are already out here
+	 * 2) the module is already marked deleted but the driver is still
+	 *	registered - then the try_inc_mod_count() below will fail
+	 * 3) the try_inc_mod_count() below succeeds before the module is marked
+	 *	deleted - then sys_delete_module() fails and prevents the removal
+	 *	because the module is in use.
+	 */
+
+	if (drv->owner && !try_inc_mod_count(drv->owner)) {
+		err = -ESTALE;
+		goto out_unlock;	/* rmmod already pending */
+	}
+
+	/* Initialize dongle driver callbacks */
+	dev->read        = sirdev_raw_read;
+	dev->write       = sirdev_raw_write;
+	dev->set_dtr_rts = dev->drv->set_dtr_rts;
+
+	dev->dongle_drv = drv;
+
+	if (!drv->open  ||  (err=drv->open(dev))!=0)
+		goto out_reject;		/* failed to open driver */
+
+	up(&dongle_list_lock);
+	return 0;
+
+out_reject:
+	dev->dongle_drv = NULL;
+	if (drv->owner)
+		__MOD_DEC_USE_COUNT(drv->owner);
+out_unlock:
+	up(&dongle_list_lock);
+	return err;
+}
+
+int sirdev_put_dongle(struct sir_dev *dev)
+{
+	const struct dongle_driver *drv = dev->dongle_drv;
+
+	if (drv) {
+		if (drv->close)
+			drv->close(dev);		/* close this dongle instance */
+
+		dev->dongle_drv = NULL;			/* unlink the dongle driver */
+
+		if (drv->owner)
+			__MOD_DEC_USE_COUNT(drv->owner);/* decrement driver's module refcount */
+	}
+
+	return 0;
+}
diff -u -p --new-file linux/drivers/net/irda-d6/sir_kthread.c linux/drivers/net/irda/sir_kthread.c
--- linux/drivers/net/irda-d6/sir_kthread.c	Wed Dec 31 16:00:00 1969
+++ linux/drivers/net/irda/sir_kthread.c	Thu Oct 31 16:17:55 2002
@@ -0,0 +1,543 @@
+/*********************************************************************
+ *
+ *	sir_kthread.c:		dedicated thread to process scheduled
+ *				sir device setup requests
+ *
+ *	Copyright (c) 2002 Martin Diehl
+ *
+ *	This program is free software; you can redistribute it and/or 
+ *	modify it under the terms of the GNU General Public License as 
+ *	published by the Free Software Foundation; either version 2 of 
+ *	the License, or (at your option) any later version.
+ *
+ ********************************************************************/    
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/version.h>
+#include <linux/init.h>
+#include <linux/smp_lock.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/sched.h>
+
+#include <net/irda/irda.h>
+
+#include "sir-dev.h"
+
+/**************************************************************************
+ *
+ * kIrDAd kernel thread and config state machine
+ *
+ */
+
+struct irda_request_queue {
+	struct list_head request_list;
+	spinlock_t lock;
+	task_t *thread;
+	struct completion exit;
+	wait_queue_head_t kick, done;
+	atomic_t num_pending;
+};
+
+static struct irda_request_queue irda_rq_queue;
+
+static int irda_queue_request(struct irda_request *rq)
+{
+	int ret = 0;
+	unsigned long flags;
+
+	if (!test_and_set_bit(0, &rq->pending)) {
+		spin_lock_irqsave(&irda_rq_queue.lock, flags);
+		list_add_tail(&rq->lh_request, &irda_rq_queue.request_list);
+		wake_up(&irda_rq_queue.kick);
+		atomic_inc(&irda_rq_queue.num_pending);
+		spin_unlock_irqrestore(&irda_rq_queue.lock, flags);
+		ret = 1;
+	}
+	return ret;
+}
+
+static void irda_request_timer(unsigned long data)
+{
+	struct irda_request *rq = (struct irda_request *)data;
+	unsigned long flags;
+	
+	spin_lock_irqsave(&irda_rq_queue.lock, flags);
+	list_add_tail(&rq->lh_request, &irda_rq_queue.request_list);
+	wake_up(&irda_rq_queue.kick);
+	spin_unlock_irqrestore(&irda_rq_queue.lock, flags);
+}
+
+static int irda_queue_delayed_request(struct irda_request *rq, unsigned long delay)
+{
+	int ret = 0;
+	struct timer_list *timer = &rq->timer;
+
+	if (!test_and_set_bit(0, &rq->pending)) {
+		timer->expires = jiffies + delay;
+		timer->function = irda_request_timer;
+		timer->data = (unsigned long)rq;
+		atomic_inc(&irda_rq_queue.num_pending);
+		add_timer(timer);
+		ret = 1;
+	}
+	return ret;
+}
+
+static void run_irda_queue(void)
+{
+	unsigned long flags;
+	struct list_head *entry, *tmp;
+	struct irda_request *rq;
+
+	spin_lock_irqsave(&irda_rq_queue.lock, flags);
+	list_for_each_safe(entry, tmp, &irda_rq_queue.request_list) {
+		rq = list_entry(entry, struct irda_request, lh_request);
+		list_del_init(entry);
+		spin_unlock_irqrestore(&irda_rq_queue.lock, flags);
+
+		clear_bit(0, &rq->pending);
+		rq->func(rq->data);
+
+		if (atomic_dec_and_test(&irda_rq_queue.num_pending))
+			wake_up(&irda_rq_queue.done);
+
+		spin_lock_irqsave(&irda_rq_queue.lock, flags);
+	}
+	spin_unlock_irqrestore(&irda_rq_queue.lock, flags);
+}		
+
+static int irda_rt_prio = 0;		/* MODULE_PARM? */
+
+static int irda_thread(void *startup)
+{
+	DECLARE_WAITQUEUE(wait, current);
+
+	daemonize();
+	strcpy(current->comm, "kIrDAd");
+
+	spin_lock_irq(&current->sig->siglock);
+	sigfillset(&current->blocked);
+	recalc_sigpending();
+	spin_unlock_irq(&current->sig->siglock);
+
+	set_fs(KERNEL_DS);
+
+	if (irda_rt_prio > 0) {
+#if 0		/* works but requires EXPORT_SYMBOL(setscheduler) */
+		struct sched_param param;
+
+		param.sched_priority = irda_rt_prio;
+		setscheduler(0, SCHED_FIFO, &param);
+#endif
+
+#if 0		/* doesn't work - has some tendency to trigger instant reboot!
+		 * looks like we would have to deactivate current on the
+		 * runqueue - which is only possible inside of kernel/sched.h
+		 */
+
+		/* runqueues are per-cpu and we are current on this cpu. Hence
+		 * The tasklist_lock with irq-off protects our runqueue too
+		 * and we don't have to lock it (which would be impossible,
+		 * because it is private in kernel/sched.c)
+		 */
+
+		read_lock_irq(&tasklist_lock);
+		current->rt_priority = (irda_rt_prio<MAX_RT_PRIO)
+					? irda_rt_prio : MAX_RT_PRIO-1;
+		current->policy = SCHED_FIFO;
+		current->prio = MAX_USER_RT_PRIO-1 - irda_rt_prio;
+		read_unlock_irq(&tasklist_lock);
+#endif
+	}
+
+	irda_rq_queue.thread = current;
+
+	complete((struct completion *)startup);
+
+	while (irda_rq_queue.thread != NULL) {
+
+		set_task_state(current, TASK_UNINTERRUPTIBLE);
+		add_wait_queue(&irda_rq_queue.kick, &wait);
+		if (list_empty(&irda_rq_queue.request_list))
+			schedule();
+		else
+			set_task_state(current, TASK_RUNNING);
+		remove_wait_queue(&irda_rq_queue.kick, &wait);
+
+		run_irda_queue();
+	}
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,35)
+	reparent_to_init();
+#endif
+	complete_and_exit(&irda_rq_queue.exit, 0);
+	/* never reached */
+	return 0;
+}
+
+
+static void flush_irda_queue(void)
+{
+	if (atomic_read(&irda_rq_queue.num_pending)) {
+
+		DECLARE_WAITQUEUE(wait, current);
+
+		if (!list_empty(&irda_rq_queue.request_list))
+			run_irda_queue();
+
+		set_task_state(current, TASK_UNINTERRUPTIBLE);
+		add_wait_queue(&irda_rq_queue.done, &wait);
+		if (atomic_read(&irda_rq_queue.num_pending))
+			schedule();
+		else
+			set_task_state(current, TASK_RUNNING);
+		remove_wait_queue(&irda_rq_queue.done, &wait);
+	}
+}
+
+/* substate handler of the config-fsm to handle the cases where we want
+ * to wait for transmit completion before changing the port configuration
+ */
+
+static int irda_tx_complete_fsm(struct sir_dev *dev)
+{
+	struct sir_fsm *fsm = &dev->fsm;
+	unsigned next_state, delay;
+	unsigned bytes_left;
+
+	do {
+		next_state = fsm->substate;	/* default: stay in current substate */
+		delay = 0;
+
+		switch(fsm->substate) {
+
+		case SIRDEV_STATE_WAIT_XMIT:
+			if (dev->drv->chars_in_buffer)
+				bytes_left = dev->drv->chars_in_buffer(dev);
+			else
+				bytes_left = 0;
+			if (!bytes_left) {
+				next_state = SIRDEV_STATE_WAIT_UNTIL_SENT;
+				break;
+			}
+
+			if (dev->speed > 115200)
+				delay = (bytes_left*8*10000) / (dev->speed/100);
+			else if (dev->speed > 0)
+				delay = (bytes_left*10*10000) / (dev->speed/100);
+			else
+				delay = 0;
+			/* expected delay (usec) until remaining bytes are sent */
+			if (delay < 100) {
+				udelay(delay);
+				delay = 0;
+				break;
+			}
+			/* sleep some longer delay (msec) */
+			delay = (delay+999) / 1000;
+			break;
+
+		case SIRDEV_STATE_WAIT_UNTIL_SENT:
+			/* block until underlaying hardware buffer are empty */
+			if (dev->drv->wait_until_sent)
+				dev->drv->wait_until_sent(dev);
+			next_state = SIRDEV_STATE_TX_DONE;
+			break;
+
+		case SIRDEV_STATE_TX_DONE:
+			return 0;
+
+		default:
+			ERROR("%s - undefined state\n", __FUNCTION__);
+			return -EINVAL;
+		}
+		fsm->substate = next_state;
+	} while (delay == 0);
+	return delay;
+}
+
+/*
+ * Function irda_config_fsm
+ *
+ * State machine to handle the configuration of the device (and attached dongle, if any).
+ * This handler is scheduled for execution in kIrDAd context, so we can sleep.
+ * however, kIrDAd is shared by all sir_dev devices so we better don't sleep there too
+ * long. Instead, for longer delays we start a timer to reschedule us later.
+ * On entry, fsm->sem is always locked and the netdev xmit queue stopped.
+ * Both must be unlocked/restarted on completion - but only on final exit.
+ */
+
+static void irda_config_fsm(void *data)
+{
+	struct sir_dev *dev = data;
+	struct sir_fsm *fsm = &dev->fsm;
+	int next_state;
+	int ret = -1;
+	unsigned delay;
+
+	IRDA_DEBUG(2, "%s(), <%ld>\n", __FUNCTION__, jiffies); 
+
+	do {
+		IRDA_DEBUG(3, "%s - state=0x%04x / substate=0x%04x\n",
+			__FUNCTION__, fsm->state, fsm->substate);
+
+		next_state = fsm->state;
+		delay = 0;
+
+		switch(fsm->state) {
+
+		case SIRDEV_STATE_DONGLE_OPEN:
+			if (dev->dongle_drv != NULL) {
+				ret = sirdev_put_dongle(dev);
+				if (ret) {
+					fsm->result = -EINVAL;
+					next_state = SIRDEV_STATE_ERROR;
+					break;
+				}
+			}
+
+			/* Initialize dongle */
+			ret = sirdev_get_dongle(dev, fsm->param);
+			if (ret) {
+				fsm->result = ret;
+				next_state = SIRDEV_STATE_ERROR;
+				break;
+			}
+
+			/* Dongles are powered through the modem control lines which
+			 * were just set during open. Before resetting, let's wait for
+			 * the power to stabilize. This is what some dongle drivers did
+			 * in open before, while others didn't - should be safe anyway.
+			 */
+
+			delay = 50;
+			fsm->substate = SIRDEV_STATE_DONGLE_RESET;
+			next_state = SIRDEV_STATE_DONGLE_RESET;
+
+			fsm->param = 9600;
+
+			break;
+
+		case SIRDEV_STATE_DONGLE_CLOSE:
+			/* shouldn't we just treat this as success=? */
+			if (dev->dongle_drv == NULL) {
+				fsm->result = -EINVAL;
+				next_state = SIRDEV_STATE_ERROR;
+				break;
+			}
+
+			ret = sirdev_put_dongle(dev);
+			if (ret) {
+				fsm->result = ret;
+				next_state = SIRDEV_STATE_ERROR;
+				break;
+			}
+			next_state = SIRDEV_STATE_DONE;
+			break;
+
+		case SIRDEV_STATE_SET_DTR_RTS:
+			if (dev->drv->set_dtr_rts) {
+				int	dtr, rts;
+
+				dtr = (fsm->param&0x02) ? TRUE : FALSE;
+				rts = (fsm->param&0x01) ? TRUE : FALSE;
+				ret = dev->drv->set_dtr_rts(dev,dtr,rts);
+			}
+			else
+				ret = -EINVAL;
+			next_state = SIRDEV_STATE_DONE;
+			break;
+
+		case SIRDEV_STATE_SET_SPEED:
+			fsm->substate = SIRDEV_STATE_WAIT_XMIT;
+			next_state = SIRDEV_STATE_DONGLE_CHECK;
+			break;
+
+		case SIRDEV_STATE_DONGLE_CHECK:
+			ret = irda_tx_complete_fsm(dev);
+			if (ret < 0) {
+				fsm->result = ret;
+				next_state = SIRDEV_STATE_ERROR;
+				break;
+			}
+			if ((delay=ret) != 0)
+				break;
+
+			if (dev->dongle_drv) {
+				fsm->substate = SIRDEV_STATE_DONGLE_RESET;
+				next_state = SIRDEV_STATE_DONGLE_RESET;
+			}
+			else {
+				dev->speed = fsm->param;
+				next_state = SIRDEV_STATE_PORT_SPEED;
+			}
+			break;
+
+		case SIRDEV_STATE_DONGLE_RESET:
+			if (dev->dongle_drv->reset) {
+				ret = dev->dongle_drv->reset(dev);	
+				if (ret < 0) {
+					fsm->result = ret;
+					next_state = SIRDEV_STATE_ERROR;
+					break;
+				}
+			}
+			else
+				ret = 0;
+			if ((delay=ret) == 0) {
+				/* set serial port according to dongle default speed */
+				if (dev->drv->set_speed)
+					dev->drv->set_speed(dev, dev->speed);
+				fsm->substate = SIRDEV_STATE_DONGLE_SPEED;
+				next_state = SIRDEV_STATE_DONGLE_SPEED;
+			}
+			break;
+
+		case SIRDEV_STATE_DONGLE_SPEED:				
+			if (dev->dongle_drv->reset) {
+				ret = dev->dongle_drv->set_speed(dev, fsm->param);
+				if (ret < 0) {
+					fsm->result = ret;
+					next_state = SIRDEV_STATE_ERROR;
+					break;
+				}
+			}
+			else
+				ret = 0;
+			if ((delay=ret) == 0)
+				next_state = SIRDEV_STATE_PORT_SPEED;
+			break;
+
+		case SIRDEV_STATE_PORT_SPEED:
+			/* Finally we are ready to change the serial port speed */
+			if (dev->drv->set_speed)
+				dev->drv->set_speed(dev, dev->speed);
+			dev->new_speed = 0;
+			next_state = SIRDEV_STATE_DONE;
+			break;
+
+		case SIRDEV_STATE_DONE:
+			/* Signal network layer so it can send more frames */
+			netif_wake_queue(dev->netdev);
+			next_state = SIRDEV_STATE_COMPLETE;
+			break;
+
+		default:
+			ERROR("%s - undefined state\n", __FUNCTION__);
+			fsm->result = -EINVAL;
+			/* fall thru */
+
+		case SIRDEV_STATE_ERROR:
+			ERROR("%s - error: %d\n", __FUNCTION__, fsm->result);
+
+#if 0	/* don't enable this before we have netdev->tx_timeout to recover */
+			netif_stop_queue(dev->netdev);
+#else
+			netif_wake_queue(dev->netdev);
+#endif
+			/* fall thru */
+
+		case SIRDEV_STATE_COMPLETE:
+			/* config change finished, so we are not busy any longer */
+			sirdev_enable_rx(dev);
+			printk(KERN_INFO "%s - up\n", __FUNCTION__);
+			up(&fsm->sem);
+			return;
+		}
+		fsm->state = next_state;
+	} while(!delay);
+
+	irda_queue_delayed_request(&fsm->rq, MSECS_TO_JIFFIES(delay));
+}
+
+/* schedule some device configuration task for execution by kIrDAd
+ * on behalf of the above state machine.
+ * can be called from process or interrupt/tasklet context.
+ */
+
+int sirdev_schedule_request(struct sir_dev *dev, int initial_state, unsigned param)
+{
+	struct sir_fsm *fsm = &dev->fsm;
+	int xmit_was_down;
+
+//	IRDA_DEBUG(2, "%s - state=0x%04x / param=%u\n", __FUNCTION__, initial_state, param);
+
+	printk(KERN_INFO "%s - state=0x%04x / param=%u\n", __FUNCTION__, initial_state, param);
+
+	if (in_interrupt()) {
+		if (down_trylock(&fsm->sem)) {
+			IRDA_DEBUG(1, "%s(), state machine busy!\n", __FUNCTION__);
+			return -EWOULDBLOCK;
+		}
+	}
+	else
+		down(&fsm->sem);
+	printk(KERN_INFO "%s - down\n", __FUNCTION__);
+
+	if (fsm->state == SIRDEV_STATE_DEAD) {
+		/* race with sirdev_close should never happen */
+		ERROR("%s(), instance staled!\n", __FUNCTION__);
+		printk(KERN_INFO "%s - up\n", __FUNCTION__);
+		up(&fsm->sem);
+		return -ESTALE;		/* or better EPIPE? */
+	}
+
+	xmit_was_down = netif_queue_stopped(dev->netdev);
+	netif_stop_queue(dev->netdev);
+	atomic_set(&dev->enable_rx, 0);
+
+	fsm->state = initial_state;
+	fsm->param = param;
+	fsm->result = 0;
+
+	INIT_LIST_HEAD(&fsm->rq.lh_request);
+	fsm->rq.pending = 0;
+	fsm->rq.func = irda_config_fsm;
+	fsm->rq.data = dev;
+
+	if (!irda_queue_request(&fsm->rq)) {	/* returns 0 on error! */
+		atomic_set(&dev->enable_rx, 1);
+		if (!xmit_was_down)
+			netif_wake_queue(dev->netdev);		
+		printk(KERN_INFO "%s - up\n", __FUNCTION__);
+		up(&fsm->sem);
+		return -EAGAIN;
+	}
+	return 0;
+}
+
+int __init irda_thread_create(void)
+{
+	struct completion startup;
+	int pid;
+
+	spin_lock_init(&irda_rq_queue.lock);
+	irda_rq_queue.thread = NULL;
+	INIT_LIST_HEAD(&irda_rq_queue.request_list);
+	init_waitqueue_head(&irda_rq_queue.kick);
+	init_waitqueue_head(&irda_rq_queue.done);
+	atomic_set(&irda_rq_queue.num_pending, 0);
+
+	init_completion(&startup);
+	pid = kernel_thread(irda_thread, &startup, CLONE_FS|CLONE_FILES);
+	if (pid <= 0)
+		return -EAGAIN;
+	else
+		wait_for_completion(&startup);
+
+	return 0;
+}
+
+void __exit irda_thread_join(void) 
+{
+	if (irda_rq_queue.thread) {
+		flush_irda_queue();
+		init_completion(&irda_rq_queue.exit);
+		irda_rq_queue.thread = NULL;
+		wake_up(&irda_rq_queue.kick);		
+		wait_for_completion(&irda_rq_queue.exit);
+	}
+}
+
diff -u -p --new-file linux/drivers/net/irda-d6/tekram-sir.c linux/drivers/net/irda/tekram-sir.c
--- linux/drivers/net/irda-d6/tekram-sir.c	Wed Dec 31 16:00:00 1969
+++ linux/drivers/net/irda/tekram-sir.c	Thu Oct 31 16:31:09 2002
@@ -0,0 +1,265 @@
+/*********************************************************************
+ *                
+ * Filename:      tekram.c
+ * Version:       1.3
+ * Description:   Implementation of the Tekram IrMate IR-210B dongle
+ * Status:        Experimental.
+ * Author:        Dag Brattli <dagb@cs.uit.no>
+ * Created at:    Wed Oct 21 20:02:35 1998
+ * Modified at:   Sun Oct 27 22:02:38 2002
+ * Modified by:   Martin Diehl <mad@mdiehl.de>
+ * 
+ *     Copyright (c) 1998-1999 Dag Brattli,
+ *     Copyright (c) 2002 Martin Diehl,
+ *     All Rights Reserved.
+ *      
+ *     This program is free software; you can redistribute it and/or 
+ *     modify it under the terms of the GNU General Public License as 
+ *     published by the Free Software Foundation; either version 2 of 
+ *     the License, or (at your option) any later version.
+ *  
+ *     Neither Dag Brattli nor University of Tromsø admit liability nor
+ *     provide warranty for any of this software. This material is 
+ *     provided "AS-IS" and at no charge.
+ *     
+ ********************************************************************/
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+
+#include <net/irda/irda.h>
+
+#include "sir-dev.h"
+
+MODULE_PARM(tekram_delay, "i");
+MODULE_PARM_DESC(tekram_delay, "tekram dongle write complete delay");
+static int tekram_delay = 50;		/* default is 50 ms */
+
+static int tekram_open(struct sir_dev *);
+static int tekram_close(struct sir_dev *);
+static int tekram_change_speed(struct sir_dev *, unsigned);
+static int tekram_reset(struct sir_dev *);
+
+#define TEKRAM_115200 0x00
+#define TEKRAM_57600  0x01
+#define TEKRAM_38400  0x02
+#define TEKRAM_19200  0x03
+#define TEKRAM_9600   0x04
+
+#define TEKRAM_PW     0x10 /* Pulse select bit */
+
+static struct dongle_driver tekram = {
+	.owner		= THIS_MODULE,
+	.driver_name	= "Tekram IR-210B",
+	.type		= IRDA_TEKRAM_DONGLE,
+	.open		= tekram_open,
+	.close		= tekram_close,
+	.reset		= tekram_reset,
+	.set_speed	= tekram_change_speed,
+};
+
+int __init tekram_sir_init(void)
+{
+	if (tekram_delay < 1  ||  tekram_delay>500)
+		tekram_delay = 200;
+	return irda_register_dongle(&tekram);
+}
+
+void __exit tekram_sir_cleanup(void)
+{
+	irda_unregister_dongle(&tekram);
+}
+
+#define TEKRAM_STATE_POWERED	(SIRDEV_STATE_DONGLE_OPEN + 1)
+
+static int tekram_open(struct sir_dev *dev)
+{
+	unsigned delay = 0;
+	unsigned next_state = dev->fsm.substate;
+	struct qos_info *qos = &dev->qos;
+
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
+
+	switch(dev->fsm.substate) {
+
+	case SIRDEV_STATE_DONGLE_OPEN:
+		dev->set_dtr_rts(dev, TRUE, TRUE);
+		next_state = TEKRAM_STATE_POWERED;
+		delay = 50;
+		break;
+
+	case TEKRAM_STATE_POWERED:
+		qos->baud_rate.bits &= IR_9600|IR_19200|IR_38400|IR_57600|IR_115200;
+		qos->min_turn_time.bits = 0x01; /* Needs at least 10 ms */	
+		irda_qos_bits_to_value(qos);
+		return 0;
+
+	default:
+		ERROR("%s - undefined state\n", __FUNCTION__);
+		return -EINVAL;
+	}
+
+	dev->fsm.substate = next_state;
+
+	return delay;
+}
+
+static int tekram_close(struct sir_dev *dev)
+{
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
+
+	/* Power off dongle */
+	dev->set_dtr_rts(dev, FALSE, FALSE);
+
+	return 0;
+}
+
+/*
+ * Function tekram_change_speed (dev, state, speed)
+ *
+ *    Set the speed for the Tekram IRMate 210 type dongle. Warning, this 
+ *    function must be called with a process context!
+ *
+ *    Algorithm
+ *    1. clear DTR 
+ *    2. set RTS, and wait at least 7 us
+ *    3. send Control Byte to the IR-210 through TXD to set new baud rate
+ *       wait until the stop bit of Control Byte is sent (for 9600 baud rate, 
+ *       it takes about 100 msec)
+ *
+ *	[oops, why 100 msec? sending 1 byte (10 bits) takes 1.05 msec
+ *	 - is this probably to compensate for delays in tty layer?]
+ *
+ *    5. clear RTS (return to NORMAL Operation)
+ *    6. wait at least 50 us, new setting (baud rate, etc) takes effect here 
+ *       after
+ */
+
+#define TEKRAM_STATE_WAIT_SPEED	(SIRDEV_STATE_DONGLE_SPEED + 1)
+
+static int tekram_change_speed(struct sir_dev *dev, unsigned speed)
+{
+	unsigned delay = 0;
+	unsigned next_state = dev->fsm.substate;
+	u8 byte;
+	
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
+
+	switch(dev->fsm.substate) {
+
+	case SIRDEV_STATE_DONGLE_SPEED:
+
+		switch (speed) {
+		default:
+			speed = 9600;
+			/* fall thru */
+		case 9600:
+			byte = TEKRAM_PW|TEKRAM_9600;
+			break;
+		case 19200:
+			byte = TEKRAM_PW|TEKRAM_19200;
+			break;
+		case 38400:
+			byte = TEKRAM_PW|TEKRAM_38400;
+			break;
+		case 57600:
+			byte = TEKRAM_PW|TEKRAM_57600;
+			break;
+		case 115200:
+			byte = TEKRAM_115200;
+			break;
+		}
+
+		/* Set DTR, Clear RTS */
+		dev->set_dtr_rts(dev, TRUE, FALSE);
+	
+		/* Wait at least 7us */
+		udelay(14);
+
+		/* Write control byte */
+		dev->write(dev, &byte, 1);
+		
+		dev->speed = speed;
+
+		next_state = TEKRAM_STATE_WAIT_SPEED;
+		delay = tekram_delay;		/* default: 50 ms */
+		break;
+
+	case TEKRAM_STATE_WAIT_SPEED:
+		/* Set DTR, Set RTS */
+		dev->set_dtr_rts(dev, TRUE, TRUE);
+
+		udelay(50);
+
+		return 0;
+
+	default:
+		ERROR("%s - undefined state\n", __FUNCTION__);
+		return -EINVAL;
+	}
+
+	dev->fsm.substate = next_state;
+
+	return delay;
+}
+
+/*
+ * Function tekram_reset (driver)
+ *
+ *      This function resets the tekram dongle. Warning, this function 
+ *      must be called with a process context!! 
+ *
+ *      Algorithm:
+ *    	  0. Clear RTS and DTR, and wait 50 ms (power off the IR-210 )
+ *        1. clear RTS 
+ *        2. set DTR, and wait at least 1 ms 
+ *        3. clear DTR to SPACE state, wait at least 50 us for further 
+ *         operation
+ */
+
+
+#define TEKRAM_STATE_WAIT_RESET	(SIRDEV_STATE_DONGLE_RESET + 1)
+
+static int tekram_reset(struct sir_dev *dev)
+{
+	unsigned delay = 0;
+	unsigned next_state = dev->fsm.substate;
+
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
+
+	switch(dev->fsm.substate) {
+
+	case SIRDEV_STATE_DONGLE_RESET:
+		/* Clear DTR, Set RTS */
+		dev->set_dtr_rts(dev, FALSE, TRUE); 
+
+		next_state = TEKRAM_STATE_WAIT_RESET;
+		delay = 1;		/* Should sleep 1 ms */
+		break;
+
+	case TEKRAM_STATE_WAIT_RESET:
+		/* Set DTR, Set RTS */
+		dev->set_dtr_rts(dev, TRUE, TRUE);
+	
+		/* Wait at least 50 us */
+		udelay(75);
+
+		return 0;
+
+	default:
+		ERROR("%s - undefined state\n", __FUNCTION__);
+		return -EINVAL;
+	}
+
+	dev->fsm.substate = next_state;
+
+	return delay;
+}
+
+MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
+MODULE_DESCRIPTION("Tekram IrMate IR-210B dongle driver");
+MODULE_LICENSE("GPL");
+		
+module_init(tekram_sir_init);
+module_exit(tekram_sir_cleanup);
