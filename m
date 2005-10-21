Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbVJUM5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbVJUM5z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 08:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbVJUM5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 08:57:55 -0400
Received: from [81.2.110.250] ([81.2.110.250]:56711 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S964936AbVJUM5y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 08:57:54 -0400
Subject: PATCH: cleanup printk and a 32/64bitism
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: sebastien.bouchard@ca.kontron.com, mark.gross@intel.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 21 Oct 2005 14:26:17 +0100
Message-Id: <1129901178.26367.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure if this board can exist with a 64bit CPU but if not then
Kconfig wants fixing too.

- Fix various chaotic printks
- Remove the exclamation marks from every printk (!!!) 
- Fix the 64/32bit pointer cast by removing the printing in question.
The value is always NULL on that path anyway.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc4-mm1/drivers/char/tlclk.c linux-2.6.14-rc4-mm1/drivers/char/tlclk.c
--- linux.vanilla-2.6.14-rc4-mm1/drivers/char/tlclk.c	2005-10-20 16:12:39.000000000 +0100
+++ linux-2.6.14-rc4-mm1/drivers/char/tlclk.c	2005-10-20 17:44:53.000000000 +0100
@@ -210,7 +210,7 @@
 	result = request_irq(telclk_interrupt, &tlclk_interrupt,
 			     SA_INTERRUPT, "telco_clock", tlclk_interrupt);
 	if (result == -EBUSY) {
-		printk(KERN_ERR "telco_clock: Interrupt can't be reserved!\n");
+		printk(KERN_ERR "telco_clock: Interrupt can't be reserved.\n");
 		return -EBUSY;
 	}
 	inb(TLCLK_REG6);	/* Clear interrupt events */
@@ -740,7 +740,7 @@
 
 	ret = register_chrdev(tlclk_major, "telco_clock", &tlclk_fops);
 	if (ret < 0) {
-		printk(KERN_ERR "telco_clock: can't get major! %d\n", tlclk_major);
+		printk(KERN_ERR "tlclk: can't get major %d.\n", tlclk_major);
 		return ret;
 	}
 	alarm_events = kzalloc( sizeof(struct tlclk_alarms), GFP_KERNEL);
@@ -749,7 +749,7 @@
 
 	/* Read telecom clock IRQ number (Set by BIOS) */
 	if (!request_region(TLCLK_BASE, 8, "telco_clock")) {
-		printk(KERN_ERR "tlclk: request_region failed! 0x%X\n",
+		printk(KERN_ERR "tlclk: request_region 0x%X failed.\n",
 			TLCLK_BASE);
 		ret = -EBUSY;
 		goto out2;
@@ -757,7 +757,7 @@
 	telclk_interrupt = (inb(TLCLK_REG7) & 0x0f);
 
 	if (0x0F == telclk_interrupt ) { /* not MCPBL0010 ? */
-		printk(KERN_ERR "telclk_interrup = 0x%x non-mcpbl0010 hw\n",
+		printk(KERN_ERR "telclk_interrup = 0x%x non-mcpbl0010 hw.\n",
 			telclk_interrupt);
 		ret = -ENXIO;
 		goto out3;
@@ -767,7 +767,7 @@
 
 	ret = misc_register(&tlclk_miscdev);
 	if (ret < 0) {
-		printk(KERN_ERR " misc_register retruns %d\n", ret);
+		printk(KERN_ERR "tlclk: misc_register returns %d.\n", ret);
 		ret = -EBUSY;
 		goto out3;
 	}
@@ -775,8 +775,7 @@
 	tlclk_device = platform_device_register_simple("telco_clock",
 				-1, NULL, 0);
 	if (!tlclk_device) {
-		printk(KERN_ERR " platform_device_register retruns 0x%X\n",
-			(unsigned int) tlclk_device);
+		printk(KERN_ERR "tlclk: platform_device_register failed.\n");
 		ret = -EBUSY;
 		goto out4;
 	}
@@ -784,7 +783,7 @@
 	ret = sysfs_create_group(&tlclk_device->dev.kobj,
 			&tlclk_attribute_group);
 	if (ret) {
-		printk(KERN_ERR "failed to create sysfs device attributes\n");
+		printk(KERN_ERR "tlclk: failed to create sysfs device attributes.\n");
 		sysfs_remove_group(&tlclk_device->dev.kobj,
 			&tlclk_attribute_group);
 		goto out5;

