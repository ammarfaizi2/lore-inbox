Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264296AbTCXQgp>; Mon, 24 Mar 2003 11:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264300AbTCXQfI>; Mon, 24 Mar 2003 11:35:08 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:58602 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264296AbTCXQbE>; Mon, 24 Mar 2003 11:31:04 -0500
Message-Id: <200303241642.h2OGgE35008365@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:42:02 +0000
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: bring OSS mad16 in sync with 2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/sound/oss/mad16.c linux-2.5/sound/oss/mad16.c
--- bk-linus/sound/oss/mad16.c	2003-03-08 09:58:07.000000000 +0000
+++ linux-2.5/sound/oss/mad16.c	2003-03-17 23:43:14.000000000 +0000
@@ -365,6 +365,8 @@ static int __init init_c930(struct addre
 {
 	unsigned char cfg = 0;
 
+	cfg |= (0x0f & mad16_conf);
+
 	if(c931_detected)
 	{
 		/* Bit 0 has reversd meaning. Bits 1 and 2 sese
@@ -402,7 +404,10 @@ static int __init init_c930(struct addre
 	   and the C931. */
 	cfg = c931_detected ? 0x04 : 0x00;
 
-	mad_write(MC4_PORT, 0x52|cfg);
+	if(mad16_cdsel & 0x20)
+		mad_write(MC4_PORT, 0x62|cfg);  /* opl4 */
+	else
+		mad_write(MC4_PORT, 0x52|cfg);  /* opl3 */
 
 	mad_write(MC5_PORT, 0x3C);	/* Init it into mode2 */
 	mad_write(MC6_PORT, 0x02);	/* Enable WSS, Disable MPU and SB */
@@ -529,10 +534,12 @@ static int __init probe_mad16(struct add
 		return init_c930(hw_config);
 
 
-	for (i = 0xf8d; i <= 0xf93; i++)
+	for (i = 0xf8d; i <= 0xf93; i++) {
 		if (!c924pnp)
-			DDB(printk("port %03x = %02x\n", i, mad_read(i))) else
+			DDB(printk("port %03x = %02x\n", i, mad_read(i)))
+		else
 			DDB(printk("port %03x = %02x\n", i-0x80, mad_read(i)));
+	}
 
 /*
  * Set the WSS address
@@ -559,10 +566,10 @@ static int __init probe_mad16(struct add
 	 */
 
 	tmp &= ~0x0f;
+	tmp |= (mad16_conf & 0x0f);	/* CD-ROM and joystick bits */
 	mad_write(MC1_PORT, tmp);
 
-	tmp = mad_read(MC2_PORT);
-
+	tmp = mad16_cdsel;
 	mad_write(MC2_PORT, tmp);
 	mad_write(MC3_PORT, 0xf0);	/* Disable SB */
 
@@ -590,9 +597,12 @@ static int __init probe_mad16(struct add
 		mad_write(MC5_PORT, 0x30 | cs4231_mode);
 	}
 
-	for (i = 0xf8d; i <= 0xf93; i++) if (!c924pnp)
-		DDB(printk("port %03x after init = %02x\n", i, mad_read(i))) else
-		DDB(printk("port %03x after init = %02x\n", i-0x80, mad_read(i)));
+	for (i = 0xf8d; i <= 0xf93; i++) {
+		if (!c924pnp)
+			DDB(printk("port %03x after init = %02x\n", i, mad_read(i)))
+		else
+			DDB(printk("port %03x after init = %02x\n", i-0x80, mad_read(i)));
+	}
 	wss_init(hw_config);
 
 	return 1;
@@ -879,7 +889,7 @@ static int __initdata cdirq = 0;
 static int __initdata cdport = 0x340;
 static int __initdata cddma = -1;
 static int __initdata opl4 = 0;
-static int __initdata joystick = 1;
+static int __initdata joystick = 0;
 
 MODULE_PARM(mpu_io, "i");
 MODULE_PARM(mpu_irq, "i");
@@ -953,14 +963,14 @@ static int __init init_mad16(void)
 			return -EINVAL;
 	}
 
- 	/*
-         *    Build the config words
-         */
+	/*
+	 *    Build the config words
+	 */
 
-        mad16_conf = (joystick ^ 1) | cdtype;
+	mad16_conf = (joystick ^ 1) | cdtype;
 	mad16_cdsel = 0;
-        if (opl4)
-                mad16_cdsel |= 0x20;
+	if (opl4)
+		mad16_cdsel |= 0x20;
 
 	if(cdtype){
 		if (cddma > 7 || cddma < 0 || dma_map[dmatype][cddma] == -1)
@@ -978,8 +988,8 @@ static int __init init_mad16(void)
 			printk(", no IRQ");
 		else if (cdirq < 0 || cdirq > 15 || irq_map[cdirq] == -1)
 		{
-		  	printk(", invalid IRQ (disabling)");
-		  	cdirq = 0;
+			printk(", invalid IRQ (disabling)");
+			cdirq = 0;
 		}
 		else printk(", IRQ %d", cdirq);
 
@@ -1032,14 +1042,14 @@ static int __init init_mad16(void)
 	found_mpu = probe_mad16_mpu(&cfg_mpu);
 
 	if (joystick == 1) {
-	        /* register gameport */
-                if (!request_region(0x201, 1, "mad16 gameport"))
-                        printk(KERN_ERR "mad16: gameport address 0x201 already in use\n");
-                else {
+		/* register gameport */
+		if (!request_region(0x201, 1, "mad16 gameport"))
+			printk(KERN_ERR "mad16: gameport address 0x201 already in use\n");
+		else {
 			printk(KERN_ERR "mad16: gameport enabled at 0x201\n");
-                        gameport.io = 0x201;
-		        gameport_register_port(&gameport);
-                }
+			gameport.io = 0x201;
+			gameport_register_port(&gameport);
+		}
 	}
 	else printk(KERN_ERR "mad16: gameport disabled.\n");
 	return 0;
@@ -1049,6 +1059,12 @@ static void __exit cleanup_mad16(void)
 {
 	if (found_mpu)
 		unload_mad16_mpu(&cfg_mpu);
+	if (gameport.io) {
+		/* the gameport was initialized so we must free it up */
+		gameport_unregister_port(&gameport);
+		gameport.io = 0;
+		release_region(0x201, 1);
+	}
 	unload_mad16(&cfg);
 }
 
@@ -1058,9 +1074,9 @@ module_exit(cleanup_mad16);
 #ifndef MODULE
 static int __init setup_mad16(char *str)
 {
-        /* io, irq */
+	/* io, irq */
 	int ints[8];
-	
+
 	str = get_options(str, ARRAY_SIZE(ints), ints);
 
 	io	 = ints[1];
