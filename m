Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261354AbTC3OpP>; Sun, 30 Mar 2003 09:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261357AbTC3OpP>; Sun, 30 Mar 2003 09:45:15 -0500
Received: from d146.dhcp212-198-27.noos.fr ([212.198.27.146]:17795 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP
	id <S261354AbTC3OpL>; Sun, 30 Mar 2003 09:45:11 -0500
Date: Sun, 30 Mar 2003 16:56:06 +0200
From: Stelian Pop <stelian@popies.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@fs.tum.de>, Jozef Kruger <jozefkruger@hotmail.com>
Subject: [PATCH 2.5.66-BK] sonypi driver update
Message-ID: <20030330165606.C10928@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Adrian Bunk <bunk@fs.tum.de>,
	Jozef Kruger <jozefkruger@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The attached patch:
* fixes a hang problem when loading the driver on (at least) a 
  PCG-FX105k. Thanks to Jozef Kruger for reporting the problem
  and testing different versions of this fix.
* fixes a .text.exit problem in the sonypi driver related to the
  recent PM changes (thanks to Adrian Bunk for the patch).

Linus, please apply.

Stelian.

===== drivers/char/sonypi.h 1.15 vs edited =====
--- 1.15/drivers/char/sonypi.h	Tue Feb 18 12:33:04 2003
+++ edited/drivers/char/sonypi.h	Sun Mar 30 15:11:30 2003
@@ -37,7 +37,7 @@
 #ifdef __KERNEL__
 
 #define SONYPI_DRIVER_MAJORVERSION	 1
-#define SONYPI_DRIVER_MINORVERSION	18
+#define SONYPI_DRIVER_MINORVERSION	19
 
 #define SONYPI_DEVICE_MODEL_TYPE1	1
 #define SONYPI_DEVICE_MODEL_TYPE2	2
===== drivers/char/sonypi.c 1.14 vs edited =====
--- 1.14/drivers/char/sonypi.c	Tue Feb 18 12:33:10 2003
+++ edited/drivers/char/sonypi.c	Sun Mar 30 15:11:37 2003
@@ -162,7 +162,7 @@
 }
 
 /* Disables the device - this comes from the AML code in the ACPI bios */
-static void __devexit sonypi_type1_dis(void) {
+static void sonypi_type1_dis(void) {
 	u32 v;
 
 	pci_read_config_dword(sonypi_device.dev, SONYPI_G10A, &v);
@@ -174,7 +174,7 @@
 	outl(v, SONYPI_IRQ_PORT);
 }
 
-static void __devexit sonypi_type2_dis(void) {
+static void sonypi_type2_dis(void) {
 	if (ec_write(SONYPI_SHIB, 0))
 		printk(KERN_WARNING "ec_write failed\n");
 	if (ec_write(SONYPI_SLOB, 0))
@@ -697,14 +697,36 @@
 	}
 
 	for (i = 0; irq_list[i].irq; i++) {
-		if (!request_irq(irq_list[i].irq, sonypi_irq, 
-				 SA_SHIRQ, "sonypi", sonypi_irq)) {
-			sonypi_device.irq = irq_list[i].irq;
-			sonypi_device.bits = irq_list[i].bits;
+
+		sonypi_device.irq = irq_list[i].irq;
+		sonypi_device.bits = irq_list[i].bits;
+
+		/* Enable sonypi IRQ settings */
+		if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2)
+			sonypi_type2_srs();
+		else
+			sonypi_type1_srs();
+
+		sonypi_call1(0x82);
+		sonypi_call2(0x81, 0xff);
+		if (compat)
+			sonypi_call1(0x92); 
+		else
+			sonypi_call1(0x82);
+
+		/* Now try requesting the irq from the system */
+		if (!request_irq(sonypi_device.irq, sonypi_irq, 
+				 SA_SHIRQ, "sonypi", sonypi_irq))
 			break;
-		}
+
+		/* If request_irq failed, disable sonypi IRQ settings */
+		if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2)
+			sonypi_type2_dis();
+		else
+			sonypi_type1_dis();
 	}
-	if (!sonypi_device.irq ) {
+
+	if (!irq_list[i].irq) {
 		printk(KERN_ERR "sonypi: request_irq failed\n");
 		ret = -ENODEV;
 		goto out3;
@@ -716,17 +738,6 @@
 		outb(0xf0, 0xb2);
 #endif
 
-	if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2)
-		sonypi_type2_srs();
-	else
-		sonypi_type1_srs();
-
-	sonypi_call1(0x82);
-	sonypi_call2(0x81, 0xff);
-	if (compat)
-		sonypi_call1(0x92); 
-	else
-		sonypi_call1(0x82);
 
 	printk(KERN_INFO "sonypi: Sony Programmable I/O Controller Driver v%d.%d.\n",
 	       SONYPI_DRIVER_MAJORVERSION,

-- 
Stelian Pop <stelian@popies.net>
