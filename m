Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbTFOQOb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 12:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbTFOQOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 12:14:31 -0400
Received: from m239.net195-132-57.noos.fr ([195.132.57.239]:27268 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP id S262336AbTFOQOL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 12:14:11 -0400
Date: Sun, 15 Jun 2003 18:27:53 +0200
From: Stelian Pop <stelian@popies.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4.21] sonypi driver update
Message-ID: <20030615162753.GC1857@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Now that a new -pre cycle is about to start, here is my latest
version of the sonypi driver.

The attached patch:
* fixes a hang problem when loading the driver on (at least) a
  PCG-FX105k. Thanks to Jozef Kruger for reporting the problem
  and testing different versions of this fix.

* tests if the ACPI subsystem is not disabled before trying to
  use its ec_read/ec_write methods.

* fixes the hangs when enabling bluetooth (thanks to Daniel K. for
  the patch).

* other miscellaneous small fixes.

Marcelo, please apply.

Stelian.

===== Documentation/sonypi.txt 1.11 vs edited =====
--- 1.11/Documentation/sonypi.txt	Tue Feb 18 12:33:56 2003
+++ edited/Documentation/sonypi.txt	Thu Apr 17 09:57:06 2003
@@ -130,7 +130,7 @@
 	  tested) when using the driver with the fnkeyinit parameter. I cannot
 	  reproduce it on my laptop and not all users have this problem.
 	  This happens because the fnkeyinit parameter enables the ACPI 
-	  mode (but without additionnal ACPI control, like processor 
+	  mode (but without additional ACPI control, like processor 
 	  speed handling etc). Use ACPI instead of APM if it works on your
 	  laptop.
 	
===== drivers/char/sonypi.h 1.16 vs edited =====
--- 1.16/drivers/char/sonypi.h	Fri Feb 21 11:22:44 2003
+++ edited/drivers/char/sonypi.h	Tue Jun 10 10:55:27 2003
@@ -37,7 +37,7 @@
 #ifdef __KERNEL__
 
 #define SONYPI_DRIVER_MAJORVERSION	 1
-#define SONYPI_DRIVER_MINORVERSION	18
+#define SONYPI_DRIVER_MINORVERSION	20
 
 #define SONYPI_DEVICE_MODEL_TYPE1	1
 #define SONYPI_DEVICE_MODEL_TYPE2	2
@@ -335,6 +335,15 @@
 	unsigned char buf[SONYPI_BUF_SIZE];
 };
 
+/* We enable input subsystem event forwarding if the input 
+ * subsystem is compiled in, but only if sonypi is not into the
+ * kernel and input as a module... */
+#if defined(CONFIG_INPUT) || defined(CONFIG_INPUT_MODULE)
+#if ! (defined(CONFIG_SONYPI) && defined(CONFIG_INPUT_MODULE))
+#define SONYPI_USE_INPUT
+#endif
+#endif
+
 /* The name of the Jog Dial for the input device drivers */
 #define SONYPI_INPUTNAME	"Sony VAIO Jog Dial"
 
@@ -351,7 +360,7 @@
 	struct sonypi_queue queue;
 	int open_count;
 	int model;
-#if defined(CONFIG_INPUT) || defined(CONFIG_INPUT_MODULE)
+#ifdef SONYPI_USE_INPUT
 	struct input_dev jog_dev;
 #endif
 #ifdef CONFIG_PM
@@ -373,14 +382,30 @@
 #ifdef CONFIG_ACPI
 #include <linux/acpi.h>
 #if (ACPI_CA_VERSION > 0x20021121)
-#define USE_ACPI
+#ifdef CONFIG_ACPI_EC
+#define SONYPI_USE_ACPI
+#endif
 #endif
 #endif /* CONFIG_ACPI */
 
-#ifndef USE_ACPI
+#ifdef CONFIG_ACPI
+#ifdef SONYPI_USE_ACPI
+extern int acpi_disabled;
+#define SONYPI_ACPI_ACTIVE (!acpi_disabled)
+#else
+#define SONYPI_ACPI_ACTIVE 1
+#endif
+#else /* CONFIG_ACPI */
+#define SONYPI_ACPI_ACTIVE 0
+#endif /* CONFIG_ACPI */
+
 extern int verbose;
 
-static inline int ec_write(u8 addr, u8 value) {
+static inline int sonypi_ec_write(u8 addr, u8 value) {
+#ifdef SONYPI_USE_ACPI
+	if (!acpi_disabled)
+		return ec_write(addr, value);
+#endif
 	wait_on_command(1, inb_p(SONYPI_CST_IOPORT) & 3, ITERATIONS_LONG);
 	outb_p(0x81, SONYPI_CST_IOPORT);
 	wait_on_command(0, inb_p(SONYPI_CST_IOPORT) & 2, ITERATIONS_LONG);
@@ -391,7 +416,11 @@
 	return 0;
 }
 
-static inline int ec_read(u8 addr, u8 *value) {
+static inline int sonypi_ec_read(u8 addr, u8 *value) {
+#ifdef SONYPI_USE_ACPI
+	if (!acpi_disabled)
+		return ec_read(addr, value);
+#endif
 	wait_on_command(1, inb_p(SONYPI_CST_IOPORT) & 3, ITERATIONS_LONG);
 	outb_p(0x80, SONYPI_CST_IOPORT);
 	wait_on_command(0, inb_p(SONYPI_CST_IOPORT) & 2, ITERATIONS_LONG);
@@ -400,7 +429,6 @@
 	*value = inb_p(SONYPI_DATA_IOPORT);
 	return 0;
 }
-#endif /* ! USE_ACPI */
 
 #endif /* __KERNEL__ */
 
===== drivers/char/sonypi.c 1.15 vs edited =====
--- 1.15/drivers/char/sonypi.c	Mon Mar 31 18:39:06 2003
+++ edited/drivers/char/sonypi.c	Fri Jun 13 14:30:21 2003
@@ -120,9 +120,9 @@
 
 static int ec_read16(u8 addr, u16 *value) {
 	u8 val_lb, val_hb;
-	if (ec_read(addr, &val_lb))
+	if (sonypi_ec_read(addr, &val_lb))
 		return -1;
-	if (ec_read(addr + 1, &val_hb))
+	if (sonypi_ec_read(addr + 1, &val_hb))
 		return -1;
 	*value = val_lb | (val_hb << 8);
 	return 0;
@@ -152,11 +152,11 @@
 }
 
 static void __devinit sonypi_type2_srs(void) {
-	if (ec_write(SONYPI_SHIB, (sonypi_device.ioport1 & 0xFF00) >> 8))
+	if (sonypi_ec_write(SONYPI_SHIB, (sonypi_device.ioport1 & 0xFF00) >> 8))
 		printk(KERN_WARNING "ec_write failed\n");
-	if (ec_write(SONYPI_SLOB,  sonypi_device.ioport1 & 0x00FF))
+	if (sonypi_ec_write(SONYPI_SLOB,  sonypi_device.ioport1 & 0x00FF))
 		printk(KERN_WARNING "ec_write failed\n");
-	if (ec_write(SONYPI_SIRQ,  sonypi_device.bits))
+	if (sonypi_ec_write(SONYPI_SIRQ,  sonypi_device.bits))
 		printk(KERN_WARNING "ec_write failed\n");
 	udelay(10);
 }
@@ -175,11 +175,11 @@
 }
 
 static void sonypi_type2_dis(void) {
-	if (ec_write(SONYPI_SHIB, 0))
+	if (sonypi_ec_write(SONYPI_SHIB, 0))
 		printk(KERN_WARNING "ec_write failed\n");
-	if (ec_write(SONYPI_SLOB, 0))
+	if (sonypi_ec_write(SONYPI_SLOB, 0))
 		printk(KERN_WARNING "ec_write failed\n");
-	if (ec_write(SONYPI_SIRQ, 0))
+	if (sonypi_ec_write(SONYPI_SIRQ, 0))
 		printk(KERN_WARNING "ec_write failed\n");
 }
 
@@ -265,7 +265,7 @@
 
 	for (j = 5; j > 0; j--) {
 
-		while (sonypi_call2(0x91, 0x1) != 0) {
+		while (sonypi_call2(0x91, 0x1)) {
 			set_current_state(TASK_UNINTERRUPTIBLE);
 			schedule_timeout(1);
 		}
@@ -277,7 +277,7 @@
 			set_current_state(TASK_UNINTERRUPTIBLE);
 			schedule_timeout(1);
 		}
-		if (i != 0)
+		if (i)
 			break;
 	}
 	
@@ -293,14 +293,12 @@
 /* sets the bluetooth subsystem power state */
 static void sonypi_setbluetoothpower(u8 state) {
 
-	state = (state != 0);
-	if (sonypi_device.bluetooth_power && state) 
-		return;
-	if (!sonypi_device.bluetooth_power && !state) 
+	state = !!state;
+	if (sonypi_device.bluetooth_power == state) 
 		return;
 	
 	sonypi_call2(0x96, state);
-	sonypi_call1(0x93);
+	sonypi_call1(0x82);
 	sonypi_device.bluetooth_power = state;
 }
 
@@ -312,10 +310,6 @@
 	v1 = inb_p(sonypi_device.ioport1);
 	v2 = inb_p(sonypi_device.ioport2);
 
-	if (verbose > 1)
-		printk(KERN_INFO 
-		       "sonypi: event port1=0x%02x,port2=0x%02x\n", v1, v2);
-
 	for (i = 0; sonypi_eventtypes[i].model; i++) {
 		if (sonypi_device.model != sonypi_eventtypes[i].model)
 			continue;
@@ -337,7 +331,11 @@
 	return;
 
 found:
-#if defined(CONFIG_INPUT) || defined(CONFIG_INPUT_MODULE)
+	if (verbose > 1)
+		printk(KERN_INFO 
+		       "sonypi: event port1=0x%02x,port2=0x%02x\n", v1, v2);
+
+#ifdef SONYPI_USE_INPUT
 	if (useinput) {
 		struct input_dev *jog_dev = &sonypi_device.jog_dev;
 		if (event == SONYPI_EVENT_JOGDIAL_PRESSED)
@@ -351,7 +349,7 @@
 			 (event == SONYPI_EVENT_JOGDIAL_DOWN_PRESSED))
 			input_report_rel(jog_dev, REL_WHEEL, -1);
 	}
-#endif /* CONFIG_INPUT || CONFIG_INPUT_MODULE */
+#endif /* SONYPI_USE_INPUT */
 	sonypi_pushq(event);
 }
 
@@ -507,7 +505,7 @@
 	down(&sonypi_device.lock);
 	switch (cmd) {
 	case SONYPI_IOCGBRT:
-		if (ec_read(SONYPI_LCD_LIGHT, &val8)) {
+		if (sonypi_ec_read(SONYPI_LCD_LIGHT, &val8)) {
 			ret = -EIO;
 			break;
 		}
@@ -519,7 +517,7 @@
 			ret = -EFAULT;
 			break;
 		}
-		if (ec_write(SONYPI_LCD_LIGHT, val8))
+		if (sonypi_ec_write(SONYPI_LCD_LIGHT, val8))
 			ret = -EIO;
 		break;
 	case SONYPI_IOCGBAT1CAP:
@@ -555,7 +553,7 @@
 			ret = -EFAULT;
 		break;
 	case SONYPI_IOCGBATFLAGS:
-		if (ec_read(SONYPI_BAT_FLAGS, &val8)) {
+		if (sonypi_ec_read(SONYPI_BAT_FLAGS, &val8)) {
 			ret = -EIO;
 			break;
 		}
@@ -611,18 +609,14 @@
 			sonypi_type2_dis();
 		else
 			sonypi_type1_dis();
-#ifndef CONFIG_ACPI
 		/* disable ACPI mode */
-		if (fnkeyinit)
+		if (!SONYPI_ACPI_ACTIVE && fnkeyinit)
 			outb(0xf1, 0xb2);
-#endif
 		break;
 	case PM_RESUME:
-#ifndef CONFIG_ACPI
 		/* Enable ACPI mode to get Fn key events */
-		if (fnkeyinit)
+		if (!SONYPI_ACPI_ACTIVE && fnkeyinit)
 			outb(0xf0, 0xb2);
-#endif
 		if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2)
 			sonypi_type2_srs();
 		else
@@ -696,36 +690,44 @@
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
 	}
 
-#ifndef CONFIG_ACPI
 	/* Enable ACPI mode to get Fn key events */
-	if (fnkeyinit)
+	if (!SONYPI_ACPI_ACTIVE && fnkeyinit)
 		outb(0xf0, 0xb2);
-#endif
-
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
@@ -748,7 +750,7 @@
 		printk(KERN_INFO "sonypi: device allocated minor is %d\n",
 		       sonypi_misc_device.minor);
 
-#if defined(CONFIG_INPUT) || defined(CONFIG_INPUT_MODULE)
+#ifdef SONYPI_USE_INPUT
 	if (useinput) {
 		/* Initialize the Input Drivers: */
 		sonypi_device.jog_dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REL);
@@ -765,7 +767,7 @@
 			sonypi_device.jog_dev.name,
 			sonypi_device.jog_dev.number);
 	}
-#endif /* CONFIG_INPUT || CONFIG_INPUT_MODULE */
+#endif /* SONYPI_USE_INPUT */
 
 #ifdef CONFIG_PM
 	sonypi_device.pm = pm_register(PM_PCI_DEV, 0, sonypi_pm_callback);
@@ -789,12 +791,12 @@
 
 	sonypi_call2(0x81, 0); /* make sure we don't get any more events */
 	
-#if defined(CONFIG_INPUT) || defined(CONFIG_INPUT_MODULE)
+#ifdef SONYPI_USE_INPUT
 	if (useinput) {
 		input_unregister_device(&sonypi_device.jog_dev);
 		kfree(sonypi_device.jog_dev.name);
 	}
-#endif /* CONFIG_INPUT || CONFIG_INPUT_MODULE */
+#endif /* SONYPI_USE_INPUT */
 
 	if (camera)
 		sonypi_camera_off();
@@ -802,11 +804,9 @@
 		sonypi_type2_dis();
 	else
 		sonypi_type1_dis();
-#ifndef CONFIG_ACPI
 	/* disable ACPI mode */
-	if (fnkeyinit)
+	if (!SONYPI_ACPI_ACTIVE && fnkeyinit)
 		outb(0xf1, 0xb2);
-#endif
 	free_irq(sonypi_device.irq, sonypi_irq);
 	release_region(sonypi_device.ioport1, sonypi_device.region_size);
 	misc_deregister(&sonypi_misc_device);
-- 
Stelian Pop <stelian@popies.net>
