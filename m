Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264701AbUF1FfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264701AbUF1FfE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 01:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264685AbUF1FeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 01:34:04 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:51129 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264701AbUF1FVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 01:21:24 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 13/19] more platform device conversions
Date: Mon, 28 Jun 2004 00:21:17 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200406280008.21465.dtor_core@ameritech.net> <200406280019.04030.dtor_core@ameritech.net> <200406280020.01085.dtor_core@ameritech.net>
In-Reply-To: <200406280020.01085.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406280021.21090.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1787, 2004-06-27 15:58:55-05:00, dtor_core@ameritech.net
  Input: integrate ct82c710, maceps2, q40kbd and rpckbd with sysfs
         as platform devices so their serio ports have proper parents
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 ct82c710.c |   50 ++++++++++++++++++++++++++++----------------------
 maceps2.c  |   19 ++++++++++++++-----
 q40kbd.c   |   18 ++++++++++++++----
 rpckbd.c   |   20 +++++++++++++++-----
 4 files changed, 71 insertions(+), 36 deletions(-)


===================================================================



diff -Nru a/drivers/input/serio/ct82c710.c b/drivers/input/serio/ct82c710.c
--- a/drivers/input/serio/ct82c710.c	2004-06-27 17:51:01 -05:00
+++ b/drivers/input/serio/ct82c710.c	2004-06-27 17:51:01 -05:00
@@ -36,6 +36,7 @@
 #include <linux/interrupt.h>
 #include <linux/serio.h>
 #include <linux/errno.h>
+#include <linux/err.h>
 
 #include <asm/io.h>
 
@@ -58,10 +59,12 @@
 
 #define CT82C710_IRQ          12
 
-static struct serio *ct82c710_port;
-static int ct82c710_data;
-static int ct82c710_status;
+#define CT82C710_DATA         ct82c710_iores.start
+#define CT82C710_STATUS       (ct82c710_iores.start + 1)
 
+static struct serio *ct82c710_port;
+static struct platform_device *ct82c710_device;
+static struct resource ct82c710_iores;
 
 /*
  * Interrupt handler for the 82C710 mouse port. A character
@@ -70,7 +73,7 @@
 
 static irqreturn_t ct82c710_interrupt(int cpl, void *dev_id, struct pt_regs * regs)
 {
-	return serio_interrupt(ct82c710_port, inb(ct82c710_data), 0, regs);
+	return serio_interrupt(ct82c710_port, inb(CT82C710_DATA), 0, regs);
 }
 
 /*
@@ -81,10 +84,10 @@
 {
 	int timeout = 60000;
 
-	while ((inb(ct82c710_status) & (CT82C710_RX_FULL | CT82C710_TX_IDLE | CT82C710_DEV_IDLE))
+	while ((inb(CT82C710_STATUS) & (CT82C710_RX_FULL | CT82C710_TX_IDLE | CT82C710_DEV_IDLE))
 		       != (CT82C710_DEV_IDLE | CT82C710_TX_IDLE) && timeout) {
 
-		if (inb_p(ct82c710_status) & CT82C710_RX_FULL) inb_p(ct82c710_data);
+		if (inb_p(CT82C710_STATUS) & CT82C710_RX_FULL) inb_p(CT82C710_DATA);
 
 		udelay(1);
 		timeout--;
@@ -98,7 +101,7 @@
 	if (ct82c170_wait())
 		printk(KERN_WARNING "ct82c710.c: Device busy in close()\n");
 
-	outb_p(inb_p(ct82c710_status) & ~(CT82C710_ENABLE | CT82C710_INTS_ON), ct82c710_status);
+	outb_p(inb_p(CT82C710_STATUS) & ~(CT82C710_ENABLE | CT82C710_INTS_ON), CT82C710_STATUS);
 
 	if (ct82c170_wait())
 		printk(KERN_WARNING "ct82c710.c: Device busy in close()\n");
@@ -113,21 +116,21 @@
 	if (request_irq(CT82C710_IRQ, ct82c710_interrupt, 0, "ct82c710", NULL))
 		return -1;
 
-	status = inb_p(ct82c710_status);
+	status = inb_p(CT82C710_STATUS);
 
 	status |= (CT82C710_ENABLE | CT82C710_RESET);
-	outb_p(status, ct82c710_status);
+	outb_p(status, CT82C710_STATUS);
 
 	status &= ~(CT82C710_RESET);
-	outb_p(status, ct82c710_status);
+	outb_p(status, CT82C710_STATUS);
 
 	status |= CT82C710_INTS_ON;
-	outb_p(status, ct82c710_status);	/* Enable interrupts */
+	outb_p(status, CT82C710_STATUS);	/* Enable interrupts */
 
 	while (ct82c170_wait()) {
 		printk(KERN_ERR "ct82c710: Device busy in open()\n");
 		status &= ~(CT82C710_ENABLE | CT82C710_INTS_ON);
-		outb_p(status, ct82c710_status);
+		outb_p(status, CT82C710_STATUS);
 		free_irq(CT82C710_IRQ, NULL);
 		return -1;
 	}
@@ -142,7 +145,7 @@
 static int ct82c710_write(struct serio *port, unsigned char c)
 {
 	if (ct82c170_wait()) return -1;
-	outb_p(c, ct82c710_data);
+	outb_p(c, CT82C710_DATA);
 	return 0;
 }
 
@@ -162,8 +165,9 @@
 		return -1;				/* No: no 82C710 here */
 
 	outb_p(0x0d, 0x390);				/* Write index */
-	ct82c710_data = inb_p(0x391) << 2;		/* Get mouse I/O address */
-	ct82c710_status = ct82c710_data + 1;
+	ct82c710_iores.start = inb_p(0x391) << 2;	/* Get mouse I/O address */
+	ct82c710_iores.end = ct82c710_iores.start + 1;
+	ct82c710_iores.flags = IORESOURCE_IO;
 	outb_p(0x0f, 0x390);
 	outb_p(0x0f, 0x391);				/* Close config mode */
 
@@ -181,8 +185,9 @@
 		serio->open = ct82c710_open;
 		serio->close = ct82c710_close;
 		serio->write = ct82c710_write;
+		serio->dev.parent = &ct82c710_device->dev;
 		strlcpy(serio->name, "C&T 82c710 mouse port", sizeof(serio->name));
-		snprintf(serio->phys, sizeof(serio->phys), "isa%04x/serio0", ct82c710_data);
+		snprintf(serio->phys, sizeof(serio->phys), "isa%04lx/serio0", CT82C710_DATA);
 	}
 
 	return serio;
@@ -193,18 +198,19 @@
 	if (ct82c710_probe())
 		return -ENODEV;
 
-	if (request_region(ct82c710_data, 2, "ct82c710"))
-		return -EBUSY;
+	ct82c710_device = platform_device_register_simple("ct82c710", -1, &ct82c710_iores, 1);
+	if (IS_ERR(ct82c710_device))
+		return PTR_ERR(ct82c710_device);
 
 	if (!(ct82c710_port = ct82c710_allocate_port())) {
-		release_region(ct82c710_data, 2);
+		platform_device_unregister(ct82c710_device);
 		return -ENOMEM;
 	}
 
 	serio_register_port(ct82c710_port);
 
-	printk(KERN_INFO "serio: C&T 82c710 mouse port at %#x irq %d\n",
-		ct82c710_data, CT82C710_IRQ);
+	printk(KERN_INFO "serio: C&T 82c710 mouse port at %#lx irq %d\n",
+		CT82C710_DATA, CT82C710_IRQ);
 
 	return 0;
 }
@@ -212,7 +218,7 @@
 void __exit ct82c710_exit(void)
 {
 	serio_unregister_port(ct82c710_port);
-	release_region(ct82c710_data, 2);
+	platform_device_unregister(ct82c710_device);
 }
 
 module_init(ct82c710_init);
diff -Nru a/drivers/input/serio/maceps2.c b/drivers/input/serio/maceps2.c
--- a/drivers/input/serio/maceps2.c	2004-06-27 17:51:01 -05:00
+++ b/drivers/input/serio/maceps2.c	2004-06-27 17:51:01 -05:00
@@ -17,6 +17,7 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/err.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -53,6 +54,7 @@
 
 static struct maceps2_data port_data[2];
 static struct serio *maceps2_port[2];
+static struct platform_device *maceps2_device;
 
 static int maceps2_write(struct serio *dev, unsigned char val)
 {
@@ -123,13 +125,14 @@
 	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
 	if (serio) {
 		memset(serio, 0, sizeof(struct serio));
-		serio->type	= SERIO_8042;
-		serio->write	= maceps2_write;
-		serio->open	= maceps2_open;
-		serio->close	= maceps2_close;
+		serio->type		= SERIO_8042;
+		serio->write		= maceps2_write;
+		serio->open		= maceps2_open;
+		serio->close		= maceps2_close;
 		snprintf(serio->name, sizeof(serio->name), "MACE PS/2 port%d", idx);
 		snprintf(serio->phys, sizeof(serio->phys), "mace/serio%d", idx);
-		serio->port_data = &port_data[idx];
+		serio->port_data	= &port_data[idx];
+		serio->dev.parent	= &maceps2_device->dev;
 	}
 
 	return serio;
@@ -138,6 +141,10 @@
 
 static int __init maceps2_init(void)
 {
+	maceps2_device = platform_device_register_simple("maceps2", -1, NULL, 0);
+	if (IS_ERR(maceps2_device))
+		return PTR_ERR(maceps2_device);
+
 	port_data[0].port = &mace->perif.ps2.keyb;
 	port_data[0].irq  = MACEISA_KEYB_IRQ;
 	port_data[1].port = &mace->perif.ps2.mouse;
@@ -148,6 +155,7 @@
 	if (!maceps2_port[0] || !maceps2_port[1]) {
 		kfree(maceps2_port[0]);
 		kfree(maceps2_port[1]);
+		platform_device_unregister(maceps2_device);
 		return -ENOMEM;
 	}
 
@@ -161,6 +169,7 @@
 {
 	serio_unregister_port(maceps2_port[0]);
 	serio_unregister_port(maceps2_port[1]);
+	platform_device_unregister(maceps2_device);
 }
 
 module_init(maceps2_init);
diff -Nru a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40kbd.c
--- a/drivers/input/serio/q40kbd.c	2004-06-27 17:51:01 -05:00
+++ b/drivers/input/serio/q40kbd.c	2004-06-27 17:51:01 -05:00
@@ -35,6 +35,7 @@
 #include <linux/init.h>
 #include <linux/serio.h>
 #include <linux/interrupt.h>
+#include <linux/err.h>
 
 #include <asm/bitops.h>
 #include <asm/io.h>
@@ -49,6 +50,7 @@
 
 spinlock_t q40kbd_lock = SPIN_LOCK_UNLOCKED;
 static struct serio *q40kbd_port;
+static struct platform_device *q40kbd_device;
 
 static irqreturn_t q40kbd_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
@@ -120,9 +122,10 @@
 	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
 	if (serio) {
 		memset(serio, 0, sizeof(struct serio));
-		serio->type	= SERIO_8042;
-		serio->open	= q40kbd_open;
-		serio->close	= q40kbd_close;
+		serio->type		= SERIO_8042;
+		serio->open		= q40kbd_open;
+		serio->close		= q40kbd_close;
+		serio->dev.parent	= &q40kbd_device->dev;
 		strlcpy(serio->name, "Q40 Kbd Port", sizeof(serio->name));
 		strlcpy(serio->phys, "Q40", sizeof(serio->phys));
 	}
@@ -135,8 +138,14 @@
 	if (!MACH_IS_Q40)
 		return -EIO;
 
-	if (!(q40kbd_port = q40kbd_allocate_port()))
+	q40kbd_device = platform_device_register_simple("q40kbd", -1, NULL, 0);
+	if (IS_ERR(q40kbd_device))
+		return PTR_ERR(q40kbd_device);
+
+	if (!(q40kbd_port = q40kbd_allocate_port())) {
+		platform_device_unregister(q40kbd_device);
 		return -ENOMEM;
+	}
 
 	serio_register_port(q40kbd_port);
 	printk(KERN_INFO "serio: Q40 kbd registered\n");
@@ -147,6 +156,7 @@
 static void __exit q40kbd_exit(void)
 {
 	serio_unregister_port(q40kbd_port);
+	platform_device_unregister(q40kbd_device);
 }
 
 module_init(q40kbd_init);
diff -Nru a/drivers/input/serio/rpckbd.c b/drivers/input/serio/rpckbd.c
--- a/drivers/input/serio/rpckbd.c	2004-06-27 17:51:01 -05:00
+++ b/drivers/input/serio/rpckbd.c	2004-06-27 17:51:01 -05:00
@@ -33,6 +33,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/serio.h>
+#include <linux/err.h>
 
 #include <asm/irq.h>
 #include <asm/hardware.h>
@@ -45,6 +46,7 @@
 MODULE_LICENSE("GPL");
 
 static struct serio *rpckbd_port;
+static struct platform_device *rpckbd_device;
 
 static int rpckbd_write(struct serio *port, unsigned char val)
 {
@@ -115,10 +117,11 @@
 	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
 	if (serio) {
 		memset(serio, 0, sizeof(struct serio));
-		serio->type	= SERIO_8042;
-		serio->write	= rpckbd_write;
-		serio->open	= rpckbd_open;
-		serio->close	= rpckbd_close;
+		serio->type		= SERIO_8042;
+		serio->write		= rpckbd_write;
+		serio->open		= rpckbd_open;
+		serio->close		= rpckbd_close;
+		serio->dev.parent	= &rpckbd_device->dev;
 		strlcpy(serio->name, "RiscPC PS/2 kbd port", sizeof(serio->name));
 		strlcpy(serio->phys, "rpckbd/serio0", sizeof(serio->phys));
 	}
@@ -128,8 +131,14 @@
 
 static int __init rpckbd_init(void)
 {
-	if (!(rpckbd_port = rpckbd_allocate_port()))
+	rpckbd_device = platform_device_register_simple("rpckbd", -1, NULL, 0);
+	if (IS_ERR(rpckbd_device))
+		return PTR_ERR(rpckbd_device);
+
+	if (!(rpckbd_port = rpckbd_allocate_port())) {
+		platform_device_unregister(rpckbd_device);
 		return -ENOMEM;
+	}
 
 	serio_register_port(rpckbd_port);
 	return 0;
@@ -138,6 +147,7 @@
 static void __exit rpckbd_exit(void)
 {
 	serio_unregister_port(rpckbd_port);
+	platform_device_unregister(rpckbd_device);
 }
 
 module_init(rpckbd_init);
