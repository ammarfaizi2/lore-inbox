Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWINHT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWINHT5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 03:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWINHT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 03:19:56 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:624 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751394AbWINHT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 03:19:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Sq+AlQ6zIcGKEmW8Mu06WGB24y7WCSnkSfQnKzGFeRXUTzJUsVJDjOKUeXZpP0z3xk7DPsxs9YEZmGdiApX7YQ6nF5ndzU+y6aKclOHjLsir92FuJQUhUUJuj2aAFYUjZQa0/TrvfWJJGT1HlSpZkk5NeNeaSzrt1nQe73bBxdY=
Message-ID: <450902B8.6040407@gmail.com>
Date: Thu, 14 Sep 2006 01:20:24 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Jim Cromie <jim.cromie@gmail.com>
CC: Sergey Vlasov <vsu@altlinux.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Samuel Tardieu <sam@rfc1149.net>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
Subject: Re: [RFC-patch 3/3] SuperIO locks coordinator - use in pc8736x_gpio
References: <87fyf5jnkj.fsf@willow.rfc1149.net>	<1157815525.6877.43.camel@localhost.localdomain> <20060909220256.d4486a4f.vsu@altlinux.ru> <4508FF2F.5020504@gmail.com>
In-Reply-To: <4508FF2F.5020504@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> 3/3   adapts drivers/char/pc8736x_gpio
>    this module needs the superio-port at runtime to alter pin-configs,
>    so it doesnt release its superio-port reservation until module-exit
>

diff -ruNp -X dontdiff -X exclude-diffs 6locks-3/drivers/char/pc8736x_gpio.c 6locks-4/drivers/char/pc8736x_gpio.c
--- 6locks-3/drivers/char/pc8736x_gpio.c	2006-09-07 16:11:44.000000000 -0600
+++ 6locks-4/drivers/char/pc8736x_gpio.c	2006-09-13 23:03:38.000000000 -0600
@@ -20,6 +20,7 @@
 #include <linux/mutex.h>
 #include <linux/nsc_gpio.h>
 #include <linux/platform_device.h>
+#include <linux/superio-locks.h>
 #include <asm/uaccess.h>
 
 #define DEVNAME "pc8736x_gpio"
@@ -36,12 +37,11 @@ static DEFINE_MUTEX(pc8736x_gpio_config_
 static unsigned pc8736x_gpio_base;
 static u8 pc8736x_gpio_shadow[4];
 
-#define SIO_BASE1       0x2E	/* 1st command-reg to check */
-#define SIO_BASE2       0x4E	/* alt command-reg to check */
-
-#define SIO_SID		0x20	/* SuperI/O ID Register */
-#define SIO_SID_VALUE	0xe9	/* Expected value in SuperI/O ID Register */
+static u16 cmd_addrs[] = { 0x2E, 0x4E, 0 };
+static u8 devid_vals[] = { 0xE1, 0xE8, 0xE4, 0xE5, 0xE9, 0 };
+static struct superio* gate;
 
+#define SIO_DEVID	0x20	/* SuperI/O Device ID Register */
 #define SIO_CF1		0x21	/* chip config, bit0 is chip enable */
 
 #define PC8736X_GPIO_RANGE	16 /* ioaddr range */
@@ -62,7 +62,6 @@ static u8 pc8736x_gpio_shadow[4];
 #define SIO_GPIO_PIN_CONFIG     0xF1
 #define SIO_GPIO_PIN_EVENT      0xF2
 
-static unsigned char superio_cmd = 0;
 static unsigned char selected_device = 0xFF;	/* bogus start val */
 
 /* GPIO port runtime access, functionality */
@@ -76,35 +75,9 @@ static int port_offset[] = { 0, 4, 8, 10
 
 static struct platform_device *pdev;  /* use in dev_*() */
 
-static inline void superio_outb(int addr, int val)
-{
-	outb_p(addr, superio_cmd);
-	outb_p(val, superio_cmd + 1);
-}
-
-static inline int superio_inb(int addr)
-{
-	outb_p(addr, superio_cmd);
-	return inb_p(superio_cmd + 1);
-}
-
-static int pc8736x_superio_present(void)
-{
-	/* try the 2 possible values, read a hardware reg to verify */
-	superio_cmd = SIO_BASE1;
-	if (superio_inb(SIO_SID) == SIO_SID_VALUE)
-		return superio_cmd;
-
-	superio_cmd = SIO_BASE2;
-	if (superio_inb(SIO_SID) == SIO_SID_VALUE)
-		return superio_cmd;
-
-	return 0;
-}
-
 static void device_select(unsigned devldn)
 {
-	superio_outb(SIO_UNIT_SEL, devldn);
+	superio_outb(gate, SIO_UNIT_SEL, devldn);
 	selected_device = devldn;
 }
 
@@ -112,7 +85,7 @@ static void select_pin(unsigned iminor)
 {
 	/* select GPIO port/pin from device minor number */
 	device_select(SIO_GPIO_UNIT);
-	superio_outb(SIO_GPIO_PIN_SELECT,
+	superio_outb(gate, SIO_GPIO_PIN_SELECT,
 		     ((iminor << 1) & 0xF0) | (iminor & 0x7));
 }
 
@@ -121,19 +94,19 @@ static inline u32 pc8736x_gpio_configure
 {
 	u32 config, new_config;
 
+	superio_enter(gate);
 	mutex_lock(&pc8736x_gpio_config_lock);
 
-	device_select(SIO_GPIO_UNIT);
+	/* read pin's current config value */
 	select_pin(index);
-
-	/* read current config value */
-	config = superio_inb(func_slct);
+	config = superio_inb(gate, func_slct);
 
 	/* set new config */
 	new_config = (config & mask) | bits;
-	superio_outb(func_slct, new_config);
+	superio_outb(gate, func_slct, new_config);
 
 	mutex_unlock(&pc8736x_gpio_config_lock);
+	superio_exit(gate);
 
 	return config;
 }
@@ -188,6 +161,8 @@ static void pc8736x_gpio_set(unsigned mi
 	pc8736x_gpio_shadow[port] = val;
 }
 
+#if 0
+/* may re-enable for sysfs-gpio */
 static void pc8736x_gpio_set_high(unsigned index)
 {
 	pc8736x_gpio_set(index, 1);
@@ -197,6 +172,7 @@ static void pc8736x_gpio_set_low(unsigne
 {
 	pc8736x_gpio_set(index, 0);
 }
+#endif
 
 static int pc8736x_gpio_current(unsigned minor)
 {
@@ -269,40 +245,44 @@ static int __init pc8736x_gpio_init(void
 		rc = -ENODEV;
 		goto undo_platform_dev_alloc;
 	}
+	pc8736x_gpio_ops.dev = &pdev->dev;
+
 	dev_info(&pdev->dev, "NatSemi pc8736x GPIO Driver Initializing\n");
 
-	if (!pc8736x_superio_present()) {
+	gate = superio_find(cmd_addrs, SIO_DEVID, devid_vals);
+	if (!gate) {
 		rc = -ENODEV;
-		dev_err(&pdev->dev, "no device found\n");
+		dev_err(&pdev->dev, "no superio port found\n");
+		// goto err2;
 		goto undo_platform_dev_add;
 	}
-	pc8736x_gpio_ops.dev = &pdev->dev;
 
 	/* Verify that chip and it's GPIO unit are both enabled.
 	   My BIOS does this, so I take minimum action here
 	 */
-	rc = superio_inb(SIO_CF1);
+	superio_enter(gate);
+	rc = superio_inb(gate, SIO_CF1);
 	if (!(rc & 0x01)) {
 		rc = -ENODEV;
 		dev_err(&pdev->dev, "device not enabled\n");
-		goto undo_platform_dev_add;
+		goto undo_superio_enter;
 	}
 	device_select(SIO_GPIO_UNIT);
-	if (!superio_inb(SIO_UNIT_ACT)) {
+	if (!superio_inb(gate, SIO_UNIT_ACT)) {
 		rc = -ENODEV;
 		dev_err(&pdev->dev, "GPIO unit not enabled\n");
-		goto undo_platform_dev_add;
+		goto undo_superio_enter;
 	}
 
 	/* read the GPIO unit base addr that chip responds to */
-	pc8736x_gpio_base = (superio_inb(SIO_BASE_HADDR) << 8
-			     | superio_inb(SIO_BASE_LADDR));
+	pc8736x_gpio_base = (superio_inb(gate, SIO_BASE_HADDR) << 8
+			     | superio_inb(gate, SIO_BASE_LADDR));
 
 	if (!request_region(pc8736x_gpio_base, PC8736X_GPIO_RANGE, DEVNAME)) {
 		rc = -ENODEV;
 		dev_err(&pdev->dev, "GPIO ioport %x busy\n",
 			pc8736x_gpio_base);
-		goto undo_platform_dev_add;
+		goto undo_superio_enter;
 	}
 	dev_info(&pdev->dev, "GPIO ioport %x reserved\n", pc8736x_gpio_base);
 
@@ -329,10 +309,14 @@ static int __init pc8736x_gpio_init(void
 	cdev_init(&pc8736x_gpio_cdev, &pc8736x_gpio_fileops);
 	cdev_add(&pc8736x_gpio_cdev, devid, PC8736X_GPIO_CT);
 
+	superio_exit(gate);	/* no release, we need to stay registered */
 	return 0;
 
 undo_request_region:
 	release_region(pc8736x_gpio_base, PC8736X_GPIO_RANGE);
+undo_superio_enter:
+	superio_exit(gate);
+	superio_release(gate);
 undo_platform_dev_add:
 	platform_device_del(pdev);
 undo_platform_dev_alloc:
@@ -351,6 +335,7 @@ static void __exit pc8736x_gpio_cleanup(
 
 	platform_device_del(pdev);
 	platform_device_put(pdev);
+	superio_release(gate);
 }
 
 module_init(pc8736x_gpio_init);


