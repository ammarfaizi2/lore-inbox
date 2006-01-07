Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161021AbWAGTdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161021AbWAGTdU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161020AbWAGTcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:32:53 -0500
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:33133 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1161023AbWAGTcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:32:47 -0500
Message-Id: <20060107172101.746357000.dtor_core@ameritech.net>
References: <20060107171559.593824000.dtor_core@ameritech.net>
Date: Sat, 07 Jan 2006 12:16:18 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 19/24] q40kbd: convert to the new platform device interface
Content-Disposition: inline; filename=q40kbd-convert-platform-intf.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: q40kbd - convert to the new platform device interface

Do not use platform_device_register_simple() as it is going away,
implement ->probe() and ->remove() functions so manual binding and
unbinding will work with this driver.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/q40kbd.c |   91 +++++++++++++++++++++++++++----------------
 1 files changed, 58 insertions(+), 33 deletions(-)

Index: work/drivers/input/serio/q40kbd.c
===================================================================
--- work.orig/drivers/input/serio/q40kbd.c
+++ work/drivers/input/serio/q40kbd.c
@@ -75,13 +75,13 @@ static irqreturn_t q40kbd_interrupt(int 
 
 static void q40kbd_flush(void)
 {
- 	int maxread = 100;
+	int maxread = 100;
 	unsigned long flags;
 
 	spin_lock_irqsave(&q40kbd_lock, flags);
 
- 	while (maxread-- && (Q40_IRQ_KEYB_MASK & master_inb(INTERRUPT_REG)))
- 		master_inb(KEYCODE_REG);
+	while (maxread-- && (Q40_IRQ_KEYB_MASK & master_inb(INTERRUPT_REG)))
+		master_inb(KEYCODE_REG);
 
 	spin_unlock_irqrestore(&q40kbd_lock, flags);
 }
@@ -97,14 +97,14 @@ static int q40kbd_open(struct serio *por
 
 	if (request_irq(Q40_IRQ_KEYBOARD, q40kbd_interrupt, 0, "q40kbd", NULL)) {
 		printk(KERN_ERR "q40kbd.c: Can't get irq %d.\n", Q40_IRQ_KEYBOARD);
-		return -1;
+		return -EBUSY;
 	}
 
- 	/* off we go */
- 	master_outb(-1, KEYBOARD_UNLOCK_REG);
- 	master_outb(1, KEY_IRQ_ENABLE_REG);
+	/* off we go */
+	master_outb(-1, KEYBOARD_UNLOCK_REG);
+	master_outb(1, KEY_IRQ_ENABLE_REG);
 
- 	return 0;
+	return 0;
 }
 
 static void q40kbd_close(struct serio *port)
@@ -116,48 +116,73 @@ static void q40kbd_close(struct serio *p
 	q40kbd_flush();
 }
 
-static struct serio * __init q40kbd_allocate_port(void)
+static int __devinit q40kbd_probe(struct platform_device *dev)
 {
-	struct serio *serio;
+	q40kbd_port = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	if (!q40kbd_port)
+		return -ENOMEM;
 
-	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
-	if (serio) {
-		memset(serio, 0, sizeof(struct serio));
-		serio->id.type		= SERIO_8042;
-		serio->open		= q40kbd_open;
-		serio->close		= q40kbd_close;
-		serio->dev.parent	= &q40kbd_device->dev;
-		strlcpy(serio->name, "Q40 Kbd Port", sizeof(serio->name));
-		strlcpy(serio->phys, "Q40", sizeof(serio->phys));
-	}
+	q40kbd_port->id.type	= SERIO_8042;
+	q40kbd_port->open	= q40kbd_open;
+	q40kbd_port->close	= q40kbd_close;
+	q40kbd_port->dev.parent	= &dev->dev;
+	strlcpy(q40kbd_port->name, "Q40 Kbd Port", sizeof(q40kbd_port->name));
+	strlcpy(q40kbd_port->phys, "Q40", sizeof(q40kbd_port->phys));
+
+	serio_register_port(q40kbd_port);
+	printk(KERN_INFO "serio: Q40 kbd registered\n");
+
+	return 0;
+}
+
+static int __devexit q40kbd_remove(struct platform_device *dev)
+{
+	serio_unregister_port(q40kbd_port);
 
-	return serio;
+	return 0;
 }
 
+static struct platform_driver q40kbd_driver = {
+	.driver		= {
+		.name	= "q40kbd",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= q40kbd_probe,
+	.remove		= __devexit_p(q40kbd_remove),
+};
+
 static int __init q40kbd_init(void)
 {
+	int error;
+
 	if (!MACH_IS_Q40)
 		return -EIO;
 
-	q40kbd_device = platform_device_register_simple("q40kbd", -1, NULL, 0);
-	if (IS_ERR(q40kbd_device))
-		return PTR_ERR(q40kbd_device);
-
-	if (!(q40kbd_port = q40kbd_allocate_port())) {
-		platform_device_unregister(q40kbd_device);
-		return -ENOMEM;
-	}
-
-	serio_register_port(q40kbd_port);
-	printk(KERN_INFO "serio: Q40 kbd registered\n");
+	error = platform_driver_register(&q40kbd_driver);
+	if (error)
+		return error;
+
+	q40kbd_device = platform_device_alloc("q40kbd", -1);
+	if (!q40kbd_device)
+		goto err_unregister_driver;
+
+	error = platform_device_add(q40kbd_device);
+	if (error)
+		goto err_free_device;
 
 	return 0;
+
+ err_free_device:
+	platform_device_put(q40kbd_device);
+ err_unregister_driver:
+	platform_driver_unregister(&q40kbd_driver);
+	return error;
 }
 
 static void __exit q40kbd_exit(void)
 {
-	serio_unregister_port(q40kbd_port);
 	platform_device_unregister(q40kbd_device);
+	platform_driver_unregister(&q40kbd_driver);
 }
 
 module_init(q40kbd_init);

