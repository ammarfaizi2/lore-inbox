Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbUL0NSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbUL0NSb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 08:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbUL0NSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 08:18:30 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:45700 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S261887AbUL0NSQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 08:18:16 -0500
Date: Mon, 27 Dec 2004 13:18:40 +0000
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Twibright I2C2P driver
Message-ID: <20041227131840.GC3045@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have just published Twibright I2C2P:

    * I2C interface (adaptor) for parallel port
    * Free technology electronics device
    * Bidirectional: Both SDA and SCL are bidirectional
    * Optically isolated
    * Powered from parallel port
    * Driver for Linux kernel 

http://i2c2p.twibright.com

The driver is at the end of this mail. The driver is tested and seems to
work flawlessly (which of course doesn't say much about it correctness ;-) )
The driver was developed on 2.6.8.1, 2.6.9 and 2.6.10 kernels.

Cl<

diff -Pur linux-2.6.9/drivers/i2c/busses/i2c-parport.c linux-2.6.9-patched/drivers/i2c/busses/i2c-parport.c
--- linux-2.6.9/drivers/i2c/busses/i2c-parport.c	2004-10-18 23:54:31.000000000 +0200
+++ linux-2.6.9-patched/drivers/i2c/busses/i2c-parport.c	2004-12-21 13:47:58.000000000 +0100
@@ -28,6 +28,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 #include <linux/parport.h>
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
@@ -140,7 +141,11 @@
 	.getscl		= parport_getscl,
 	.udelay		= 60,
 	.mdelay		= 60,
-	.timeout	= HZ,
+	.timeout	= (HZ+99)/100,
+			/* This is 10ms. Parport adapter of type 6 may be
+			 * powered down which introduces 90sec delay to
+			 * machine boot. I consider 10ms to be sufficient for
+			 * the parport adapter timeout. --Clock */
 }; 
 
 /* ----- I2c and parallel port call-back functions and structures --------- */
@@ -190,6 +195,14 @@
 	/* Other init if needed (power on...) */
 	if (adapter_parm[type].init.val)
 		line_set(port, 1, &adapter_parm[type].init);
+	if (adapter_parm[type].init2.val)
+		line_set(port, 1, &adapter_parm[type].init2);
+	if (adapter_parm[type].init3.val)
+		line_set(port, 1, &adapter_parm[type].init3);
+	
+	/* Wait until the adapter puffs up */
+	if (adapter_parm[type].msleep)
+		msleep_interruptible(adapter_parm[type].msleep);
 
 	parport_release(adapter->pdev);
 
@@ -220,6 +233,10 @@
 			/* Un-init if needed (power off...) */
 			if (adapter_parm[type].init.val)
 				line_set(port, 0, &adapter_parm[type].init);
+			if (adapter_parm[type].init2.val)
+				line_set(port, 0, &adapter_parm[type].init2);
+			if (adapter_parm[type].init3.val)
+				line_set(port, 0, &adapter_parm[type].init3);
 				
 			i2c_bit_del_bus(&adapter->adapter);
 			parport_unregister_device(adapter->pdev);
diff -Pur linux-2.6.9/drivers/i2c/busses/i2c-parport.h linux-2.6.9-patched/drivers/i2c/busses/i2c-parport.h
--- linux-2.6.9/drivers/i2c/busses/i2c-parport.h	2004-10-18 23:55:29.000000000 +0200
+++ linux-2.6.9-patched/drivers/i2c/busses/i2c-parport.h	2004-12-21 12:33:18.000000000 +0100
@@ -38,6 +38,9 @@
 	struct lineop getsda;
 	struct lineop getscl;
 	struct lineop init;
+	struct lineop init2;	/* Added by Clock                    */
+	struct lineop init3;	/* Needed by Twibright I2C2P driver. */
+	int msleep;		/* Milliseconds after init           */
 };
 
 static struct adapter_parm adapter_parm[] = {
@@ -47,18 +50,21 @@
 		.setscl	= { 0x08, CTRL, 0 },
 		.getsda	= { 0x80, STAT, 0 },
 		.getscl	= { 0x08, STAT, 0 },
+		.msleep = 0,
 	},
 	/* type 1: home brew teletext adapter */
 	{
 		.setsda	= { 0x02, DATA, 0 },
 		.setscl	= { 0x01, DATA, 0 },
 		.getsda	= { 0x80, STAT, 1 },
+		.msleep = 0,
 	},
 	/* type 2: Velleman K8000 adapter */
 	{
 		.setsda	= { 0x02, CTRL, 1 },
 		.setscl	= { 0x08, CTRL, 1 },
 		.getsda	= { 0x10, STAT, 0 },
+		.msleep = 0,
 	},
 	/* type 3: ELV adapter */
 	{
@@ -66,6 +72,7 @@
 		.setscl	= { 0x01, DATA, 1 },
 		.getsda	= { 0x40, STAT, 1 },
 		.getscl	= { 0x08, STAT, 1 },
+		.msleep = 0,
 	},
 	/* type 4: ADM1032 evaluation board */
 	{
@@ -73,12 +80,25 @@
 		.setscl	= { 0x01, DATA, 1 },
 		.getsda	= { 0x10, STAT, 1 },
 		.init	= { 0xf0, DATA, 0 },
+		.msleep = 0,
 	},
 	/* type 5: ADM1025, ADM1030 and ADM1031 evaluation boards */
 	{
 		.setsda	= { 0x02, DATA, 1 },
 		.setscl	= { 0x01, DATA, 1 },
 		.getsda	= { 0x10, STAT, 1 },
+		.msleep = 0,
+	},
+	/* type 6: Twibright I2C2P adapter */
+	{
+		.setsda = { 0x01, CTRL, 1},
+		.getsda = { 0x80, STAT, 1},
+		.setscl = { 0x08, CTRL, 1},
+		.getscl = { 0x40, STAT, 0},
+		.init	= { 0xff, DATA, 0},
+		.init2	= { 0x04, CTRL, 0},
+		.init3	= { 0x02, CTRL, 1},
+		.msleep = 100,
 	},
 };
 
@@ -91,4 +111,5 @@
 	" 2 = Velleman K8000 adapter\n"
 	" 3 = ELV adapter\n"
 	" 4 = ADM1032 evaluation board\n"
-	" 5 = ADM1025, ADM1030 and ADM1031 evaluation boards\n");
+	" 5 = ADM1025, ADM1030 and ADM1031 evaluation boards\n"
+	" 6 = Twibright I2C2P adapter\n");
