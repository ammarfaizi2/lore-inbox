Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264292AbTCXRPT>; Mon, 24 Mar 2003 12:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264280AbTCXQtT>; Mon, 24 Mar 2003 11:49:19 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:57578 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264293AbTCXQbD>; Mon, 24 Mar 2003 11:31:03 -0500
Message-Id: <200303241642.h2OGgD35008355@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:42:01 +0000
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Bose sound support for cs4232 OSS driver.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/sound/oss/cs4232.c linux-2.5/sound/oss/cs4232.c
--- bk-linus/sound/oss/cs4232.c	2003-03-08 09:58:07.000000000 +0000
+++ linux-2.5/sound/oss/cs4232.c	2003-02-26 10:52:04.000000000 +0000
@@ -34,6 +34,8 @@
  * anyway.
  *
  * Changes
+ *      John Rood               Added Bose Sound System Support.
+ *      Toshio Spoor
  *	Alan Cox		Modularisation, Basic cleanups.
  *      Paul Barton-Davis	Separated MPU configuration, added
  *                                       Tropez+ (WaveFront) support
@@ -58,6 +60,10 @@
 
 #define KEY_PORT	0x279	/* Same as LPT1 status port */
 #define CSN_NUM		0x99	/* Just a random number */
+#define INDEX_ADDRESS   0x00    /* (R0) Index Address Register */
+#define INDEX_DATA      0x01    /* (R1) Indexed Data Register */
+#define PIN_CONTROL     0x0a    /* (I10) Pin Control */
+#define ENABLE_PINS     0xc0    /* XCTRL0/XCTRL1 enable */
 
 static void CS_OUT(unsigned char a)
 {
@@ -67,6 +73,7 @@ static void CS_OUT(unsigned char a)
 #define CS_OUT2(a, b)		{CS_OUT(a);CS_OUT(b);}
 #define CS_OUT3(a, b, c)	{CS_OUT(a);CS_OUT(b);CS_OUT(c);}
 
+static int __initdata bss       = 0;
 static int mpu_base = 0, mpu_irq = 0;
 static int synth_base = 0, synth_irq = 0;
 static int mpu_detected = 0;
@@ -97,7 +104,31 @@ static void sleep(unsigned howlong)
 	schedule_timeout(howlong);
 }
 
-int probe_cs4232(struct address_info *hw_config, int isapnp_configured)
+static void enable_xctrl(int baseio)
+{
+        unsigned char regd;
+                
+        /*
+         * Some IBM Aptiva's have the Bose Sound System. By default
+         * the Bose Amplifier is disabled. The amplifier will be 
+         * activated, by setting the XCTRL0 and XCTRL1 bits.
+         * Volume of the monitor bose speakers/woofer, can then
+         * be set by changing the PCM volume.
+         *
+         */
+                
+        printk("cs4232: enabling Bose Sound System Amplifier.\n");
+        
+        /* Switch to Pin Control Address */                   
+        regd = inb(baseio + INDEX_ADDRESS) & 0xe0;
+        outb(((unsigned char) (PIN_CONTROL | regd)), baseio + INDEX_ADDRESS );
+        
+        /* Activate the XCTRL0 and XCTRL1 Pins */
+        regd = inb(baseio + INDEX_DATA);
+        outb(((unsigned char) (ENABLE_PINS | regd)), baseio + INDEX_DATA );
+}
+
+int __init probe_cs4232(struct address_info *hw_config, int isapnp_configured)
 {
 	int i, n;
 	int base = hw_config->io_base, irq = hw_config->irq;
@@ -218,7 +249,7 @@ int probe_cs4232(struct address_info *hw
 	return 0;
 }
 
-void attach_cs4232(struct address_info *hw_config)
+void __init attach_cs4232(struct address_info *hw_config)
 {
 	int base = hw_config->io_base,
 		irq = hw_config->irq,
@@ -275,9 +306,14 @@ void attach_cs4232(struct address_info *
 		}
 		hw_config->slots[1] = hw_config2.slots[1];
 	}
+	
+	if (bss)
+	{
+        	enable_xctrl(base);
+	}
 }
 
-static void unload_cs4232(struct address_info *hw_config)
+static void __exit unload_cs4232(struct address_info *hw_config)
 {
 	int base = hw_config->io_base, irq = hw_config->irq;
 	int dma1 = hw_config->dma, dma2 = hw_config->dma2;
@@ -349,6 +385,8 @@ MODULE_PARM(synthirq,"i");
 MODULE_PARM_DESC(synthirq,"Maui WaveTable IRQ");
 MODULE_PARM(isapnp,"i");
 MODULE_PARM_DESC(isapnp,"Enable ISAPnP probing (default 1)");
+MODULE_PARM(bss,"i");
+MODULE_PARM_DESC(bss,"Enable Bose Sound System Support (default 0)");
 
 /*
  *	Install a CS4232 based card. Need to have ad1848 and mpu401
