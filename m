Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWINHPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWINHPm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 03:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWINHPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 03:15:42 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:4372 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751384AbWINHPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 03:15:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=BAfz5GeOJX22cktlJq6Dh6Oyex8GZCpm/wgQJGH1QsciMnE4wuUzYua1Rfq8CZ19bv3mm/UXdYcjFPsBDlY5p5zrQzm2kIlkCGudQU1O/xIC1TUPRu/6WSNSN5sYDZar7cRN9fMXkihbqL7BHzFWGxLXPxj+gd0RuARaMqY6GuU=
Message-ID: <450901B9.6090405@gmail.com>
Date: Thu, 14 Sep 2006 01:16:09 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Jim Cromie <jim.cromie@gmail.com>
CC: Sergey Vlasov <vsu@altlinux.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Samuel Tardieu <sam@rfc1149.net>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
Subject: Re: [RFC-patch 2/3] SuperIO locks coordinator
References: <87fyf5jnkj.fsf@willow.rfc1149.net>	<1157815525.6877.43.camel@localhost.localdomain> <20060909220256.d4486a4f.vsu@altlinux.ru> <4508FF2F.5020504@gmail.com>
In-Reply-To: <4508FF2F.5020504@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> 2/3   adapts drivers/hwmon/pc87360 to use superio_find()
>    this module needs superio port only during initialization,
>    so releases it quickly.
>

diff -ruNp -X dontdiff -X exclude-diffs 6locks-2/drivers/hwmon/pc87360.c 6locks-3/drivers/hwmon/pc87360.c
--- 6locks-2/drivers/hwmon/pc87360.c	2006-09-13 09:50:35.000000000 -0600
+++ 6locks-3/drivers/hwmon/pc87360.c	2006-09-13 16:26:51.000000000 -0600
@@ -42,6 +42,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon-vid.h>
+#include <linux/superio-locks.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <asm/io.h>
@@ -53,6 +54,9 @@ static u8 confreg[4];
 
 enum chips { any_chip, pc87360, pc87363, pc87364, pc87365, pc87366 };
 
+static u16 cmd_addrs[] = { 0x2E, 0x4E, 0 };
+static u8 devid_vals[] = { 0xE1, 0xE8, 0xE4, 0xE5, 0xE9, 0 };
+
 static int init = 1;
 module_param(init, int, 0);
 MODULE_PARM_DESC(init,
@@ -80,24 +84,6 @@ static const u8 logdev[3] = { FSCM, VLM,
 #define LD_IN		1
 #define LD_TEMP		2
 
-static inline void superio_outb(int sioaddr, int reg, int val)
-{
-	outb(reg, sioaddr);
-	outb(val, sioaddr+1);
-}
-
-static inline int superio_inb(int sioaddr, int reg)
-{
-	outb(reg, sioaddr);
-	return inb(sioaddr+1);
-}
-
-static inline void superio_exit(int sioaddr)
-{
-	outb(0x02, sioaddr);
-	outb(0x02, sioaddr+1);
-}
-
 /*
  * Logical devices
  */
@@ -821,17 +807,22 @@ static const struct attribute_group pc87
  * Device detection, registration and update
  */
 
-static int __init pc87360_find(int sioaddr, u8 *devid, unsigned short *addresses)
+static int __init pc87360_find(unsigned short *addresses)
 {
 	u16 val;
-	int i;
-	int nrdev; /* logical device count */
+	int i, nrdev; /* logical device count */
 
-	/* No superio_enter */
+	struct superio* const gate = superio_find(cmd_addrs, DEVID, devid_vals);
+	if (!gate) {
+		printk(KERN_WARNING "pc87360: superio port not detected, "
+		       "module not intalled.\n");
+		return -ENODEV;
+	}
+	superio_enter(gate);
+	devid = gate->devid;		/* Remember the device id */
 
 	/* Identify device */
-	val = superio_inb(sioaddr, DEVID);
-	switch (val) {
+	switch (devid) {
 	case 0xE1: /* PC87360 */
 	case 0xE8: /* PC87363 */
 	case 0xE4: /* PC87364 */
@@ -842,25 +833,23 @@ static int __init pc87360_find(int sioad
 		nrdev = 3;
 		break;
 	default:
-		superio_exit(sioaddr);
+		superio_exit(gate);
 		return -ENODEV;
 	}
-	/* Remember the device id */
-	*devid = val;
 
 	for (i = 0; i < nrdev; i++) {
 		/* select logical device */
-		superio_outb(sioaddr, DEV, logdev[i]);
+		superio_outb(gate, DEV, logdev[i]);
 
-		val = superio_inb(sioaddr, ACT);
+		val = superio_inb(gate, ACT);
 		if (!(val & 0x01)) {
 			printk(KERN_INFO "pc87360: Device 0x%02x not "
 			       "activated\n", logdev[i]);
 			continue;
 		}
 
-		val = (superio_inb(sioaddr, BASE) << 8)
-		    | superio_inb(sioaddr, BASE + 1);
+		val = (superio_inb(gate, BASE) << 8)
+		    | superio_inb(gate, BASE + 1);
 		if (!val) {
 			printk(KERN_INFO "pc87360: Base address not set for "
 			       "device 0x%02x\n", logdev[i]);
@@ -870,8 +859,8 @@ static int __init pc87360_find(int sioad
 		addresses[i] = val;
 
 		if (i==0) { /* Fans */
-			confreg[0] = superio_inb(sioaddr, 0xF0);
-			confreg[1] = superio_inb(sioaddr, 0xF1);
+			confreg[0] = superio_inb(gate, 0xF0);
+			confreg[1] = superio_inb(gate, 0xF1);
 
 #ifdef DEBUG
 			printk(KERN_DEBUG "pc87360: Fan 1: mon=%d "
@@ -886,12 +875,12 @@ static int __init pc87360_find(int sioad
 #endif
 		} else if (i==1) { /* Voltages */
 			/* Are we using thermistors? */
-			if (*devid == 0xE9) { /* PC87366 */
+			if (devid == 0xE9) { /* PC87366 */
 				/* These registers are not logical-device
 				   specific, just that we won't need them if
 				   we don't use the VLM device */
-				confreg[2] = superio_inb(sioaddr, 0x2B);
-				confreg[3] = superio_inb(sioaddr, 0x25);
+				confreg[2] = superio_inb(gate, 0x2B);
+				confreg[3] = superio_inb(gate, 0x25);
 
 				if (confreg[2] & 0x40) {
 					printk(KERN_INFO "pc87360: Using "
@@ -907,7 +896,8 @@ static int __init pc87360_find(int sioad
 		}
 	}
 
-	superio_exit(sioaddr);
+	superio_exit(gate);
+	superio_release(gate);	/* not needed for any post-load operations */
 	return 0;
 }
 
@@ -1411,14 +1401,10 @@ static struct pc87360_data *pc87360_upda
 
 static int __init pc87360_init(void)
 {
-	int i;
+	int i, status = -ENODEV;
 
-	if (pc87360_find(0x2e, &devid, extra_isa)
-	 && pc87360_find(0x4e, &devid, extra_isa)) {
-		printk(KERN_WARNING "pc87360: PC8736x not detected, "
-		       "module not inserted.\n");
-		return -ENODEV;
-	}
+	if (pc87360_find(extra_isa))
+		return status;
 
 	/* Arbitrarily pick one of the addresses */
 	for (i = 0; i < 3; i++) {
@@ -1431,10 +1417,10 @@ static int __init pc87360_init(void)
 	if (address == 0x0000) {
 		printk(KERN_WARNING "pc87360: No active logical device, "
 		       "module not inserted.\n");
-		return -ENODEV;
+		return status;
 	}
-
-	return i2c_isa_add_driver(&pc87360_driver);
+	status = i2c_isa_add_driver(&pc87360_driver);
+	return status;
 }
 
 static void __exit pc87360_exit(void)


