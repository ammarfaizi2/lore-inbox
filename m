Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbVIGS05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbVIGS05 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 14:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbVIGS05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 14:26:57 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:64412 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S932153AbVIGS04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 14:26:56 -0400
Date: Wed, 7 Sep 2005 20:26:53 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: khali@linux-fr.org
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Add code for completely disabling I2C interface to the w83627hf driver
Message-ID: <20050907182653.GB468@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  While getting w83627hf driver to work on Tyan Thunder K7 (BIOS disables
hardware monitoring and forwards only addresses 0xC00 - 0xDFF to the LPC,
so force_address's value must be in this range...) I've noticed that it
is possible to completely disable I2C interface on the w83627hf chip
(BIOS left chip in this state...; other three chips supported by w83627hf 
do not have I2C interface at all).  So this code does that - by default 
it disables w83627hf's I2C interface by switching these pins from I2C 
to the input GPIO pins.  This is sufficient to stop chip from being 
accessible through I2C bus, and as there are no I2C devices on chip, 
it seems like right thing to do, instead of programming chip with I2C 
address 0x1F.

  I've tested this on w83627hf in Tyan Thunder K7 and Tyan S2885, and
with w83627thf in Asus A8V.  I have no computer with w637hf & w697hf
chips, but their datasheets suggest that they do not have I2C bus like
w627thf, so there should be no problem.

  To revert to old behavior it is still possible to use force_i2c=0x1F,
but note that driver does not reenable i2c bus under any circumstances,
so if you want to reenable i2c you have to clear bits 7,6 in GPIO2_MUX_REG
manually.

  Although watchdog driver (w83627hf_wdt) uses GPIO2 bank too (and enables 
it), there is no problem, as when GPIO2 logical device is going from 
disabled to enabled state, it automatically sets direction for all GPIO2 pins
to input, exactly in the way we want, and watchdog driver itself does
not touch GPIO2 pins at all.
							Thanks,
								Petr Vandrovec

Signed-off-by: Petr Vandrovec <vandrove@vc.cvut.cz>


diff -urN linux-2.6.13-5bca.dist/drivers/hwmon/w83627hf.c linux-2.6.13-5bca/drivers/hwmon/w83627hf.c
--- linux-2.6.13-5bca.dist/drivers/hwmon/w83627hf.c     2005-09-06 13:50:03.000000000 +0200
+++ linux-2.6.13-5bca/drivers/hwmon/w83627hf.c  2005-09-07 19:54:08.000000000 +0200
@@ -25,7 +25,7 @@
     Supports following chips:
 
     Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
-    w83627hf	9	3	2	3	0x20	0x5ca3	no	yes(LPC)
+    w83627hf	9	3	2	3	0x20	0x5ca3	yes	yes(LPC)
     w83627thf	7	3	3	3	0x90	0x5ca3	no	yes(LPC)
     w83637hf	7	3	3	3	0x80	0x5ca3	no	yes(LPC)
     w83697hf	8	2	2	2	0x60	0x5ca3	no	yes(LPC)
@@ -53,8 +53,8 @@
 module_param(force_addr, ushort, 0);
 MODULE_PARM_DESC(force_addr,
 		 "Initialize the base address of the sensors");
-static u8 force_i2c = 0x1f;
-module_param(force_i2c, byte, 0);
+static s16 force_i2c = -1;
+module_param(force_i2c, short, 0);
 MODULE_PARM_DESC(force_i2c,
 		 "Initialize the i2c address of the sensors");
 
@@ -134,8 +134,10 @@
 #define W627THF_DEVID 0x82
 #define W697_DEVID 0x60
 #define W637_DEVID 0x70
-#define WINB_ACT_REG 0x30
-#define WINB_BASE_REG 0x60
+#define WINB_ACT_REG		0x30	/* Common for all banks */
+#define WINB_BASE_REG		0x60	/* Common for all banks */
+#define WINB_GPIO2_MUX_REG	0x2B	/* Not banked */
+#define WINB_GPIO2_DIR_REG	0xF0	/* In LD_GPIO2 bank */
 /* Constants specified below */
 
 /* Alignment of ISA address */
@@ -1035,7 +1037,7 @@
 	}
 
 	superio_select(W83627HF_LD_HWM);
-	if((val = 0x01 & superio_inb(WINB_ACT_REG)) == 0)
+	if((superio_inb(WINB_ACT_REG) & 0x01) == 0)
 		superio_outb(WINB_ACT_REG, 1);
 	superio_exit();
 
@@ -1277,6 +1279,30 @@
 	return 0;
 }
 
+/* Invoked with superio extended access enabled. */
+static void w83627hf_disable_i2c(void)
+{
+	int mux;
+
+	/* SCL/SDA pins already GPIO => i2c is (already) disabled, or */
+	/* not connected, or whatever.  Do not touch.                 */
+	mux = superio_inb(WINB_GPIO2_MUX_REG);
+	if ((mux & 0xC0) == 0xC0)
+		return;
+	superio_select(W83627HF_LD_GPIO2);
+	/* If GPIO2 function is disabled, GPIO2 pins are always input and */
+	/*   GPIO2 direction configuration register is hardwired to 0xFF. */
+	/* If GPIO2 function is enabled, GPIO2 pins are bidirectional and */
+	/*   GPIO2 direction configuration register matters.              */
+	if (superio_inb(WINB_ACT_REG) & 0x01) {
+		/* Switch GPIO21 (mux with SCL) & GPIO22 (SDA) pins to input. */
+		int dir = superio_inb(WINB_GPIO2_DIR_REG);
+		superio_outb(WINB_GPIO2_DIR_REG, dir | 0x06);
+	}
+	/* Select GPIO functionality on GPIO21/SCL & GPIO22/SDA pins. */
+	superio_outb(WINB_GPIO2_MUX_REG, mux | 0xC0);
+}
+
 /* Called when we have found a new W83781D. It should set limits, etc. */
 static void w83627hf_init_client(struct i2c_client *client)
 {
@@ -1300,11 +1326,23 @@
 		w83627hf_write_value(client, W83781D_REG_BEEP_INTS2, 0);
 	}
 
-	/* Minimize conflicts with other winbond i2c-only clients...  */
-	/* disable i2c subclients... how to disable main i2c client?? */
-	/* force i2c address to relatively uncommon address */
+	/* Minimize conflicts with other winbond i2c-only clients... */
+	/* disable i2c subclients... and either force main client to */
+	/* relatively uncommon address, or disable i2c interface     */
+	/* completely.   Note that only 627hf has i2c interface, so  */
+	/* there is nothing to disable on other chips - but as we    */
+	/* were touching these reserved registers for years and      */
+	/* nothing exploded, let's continue doing that.              */
 	w83627hf_write_value(client, W83781D_REG_I2C_SUBADDR, 0x89);
-	w83627hf_write_value(client, W83781D_REG_I2C_ADDR, force_i2c);
+	if (force_i2c < 0) {
+		if (w83627hf == data->type) {
+			superio_enter();
+			w83627hf_disable_i2c();
+			superio_exit();
+		}
+	} else {
+		w83627hf_write_value(client, W83781D_REG_I2C_ADDR, force_i2c);
+	}
 
 	/* Read VID only once */
 	if (w83627hf == data->type || w83637hf == data->type) {
