Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312850AbSCZXvK>; Tue, 26 Mar 2002 18:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312852AbSCZXvB>; Tue, 26 Mar 2002 18:51:01 -0500
Received: from fangorn.moria.de ([194.97.106.210]:3201 "HELO mail.moria.de")
	by vger.kernel.org with SMTP id <S312850AbSCZXuq>;
	Tue, 26 Mar 2002 18:50:46 -0500
Date: Wed, 27 Mar 2002 00:50:37 +0100
From: Michael Haardt <michael@moria.de>
To: linux-kernel@vger.kernel.org
Subject: Gameport patch for drivers/sound/mad16.c
Message-ID: <20020327005037.A397@palantir.moria.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii

Hello,

the MAD16 driver is able to enable/disable its gameport, but it does
not register it in the input subsystem.  The appended patch against
2.4.19-pre4 fixes that and also allows to enable to gameport via kernel
command line, not only when loaded as module.

I am not subscribed to the list, so please put me in Cc: for answers.

Michael

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mad16.c.diff"

--- drivers/sound/mad16.c.orig	Sun Sep 30 19:26:08 2001
+++ drivers/sound/mad16.c	Tue Mar 26 21:41:23 2002
@@ -42,6 +42,7 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/gameport.h>
 
 #include "sound_config.h"
 
@@ -51,6 +52,7 @@
 
 static int      mad16_conf;
 static int      mad16_cdsel;
+static struct gameport gameport;
 
 static int      already_initialized = 0;
 
@@ -664,13 +666,13 @@
 
 	outb((bits | dma_bits[dma] | dma2_bit), config_port);	/* Write IRQ+DMA setup */
 
-	hw_config->slots[0] = ad1848_init("MAD16 WSS", hw_config->io_base + 4,
+	hw_config->slots[0] = ad1848_init("mad16 WSS", hw_config->io_base + 4,
 					  hw_config->irq,
 					  dma,
 					  dma2, 0,
 					  hw_config->osp,
 					  THIS_MODULE);
-	request_region(hw_config->io_base, 4, "MAD16 WSS config");
+	request_region(hw_config->io_base, 4, "mad16 WSS config");
 }
 
 static int __init probe_mad16_mpu(struct address_info *hw_config)
@@ -1010,14 +1012,6 @@
 	}
 
 	printk(".\n");
-        printk(KERN_INFO "Joystick port ");
-        if (joystick == 1)
-                printk("enabled.\n");
-        else
-        {
-                joystick = 0;
-                printk("disabled.\n");
-        }
 
 	cfg.io_base = io;
 	cfg.irq = irq;
@@ -1038,6 +1032,18 @@
 	attach_mad16(&cfg);
 
 	found_mpu = probe_mad16_mpu(&cfg_mpu);
+
+	if (joystick == 1) {
+	        /* register gameport */
+                if (!request_region(0x201, 1, "mad16 gameport"))
+                        printk(KERN_ERR "mad16: gameport address 0x201 already in use\n");
+                else {
+			printk(KERN_ERR "mad16: gameport enabled at 0x201\n");
+                        gameport.io = 0x201;
+		        gameport_register_port(&gameport);
+                }
+	}
+	else printk(KERN_ERR "mad16: gameport disabled.\n");
 	return 0;
 }
 
@@ -1055,16 +1061,17 @@
 static int __init setup_mad16(char *str)
 {
         /* io, irq */
-	int ints[7];
+	int ints[8];
 	
 	str = get_options(str, ARRAY_SIZE(ints), ints);
 
-	io	= ints[1];
-	irq	= ints[2];
-	dma	= ints[3];
-	dma16	= ints[4];
-	mpu_io	= ints[5];
-	mpu_irq = ints[6];
+	io	 = ints[1];
+	irq	 = ints[2];
+	dma	 = ints[3];
+	dma16	 = ints[4];
+	mpu_io	 = ints[5];
+	mpu_irq  = ints[6];
+	joystick = ints[7];
 
 	return 1;
 }

--9jxsPFA5p3P2qPhR--
