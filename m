Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262528AbSLAVWj>; Sun, 1 Dec 2002 16:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbSLAVWj>; Sun, 1 Dec 2002 16:22:39 -0500
Received: from [195.39.17.254] ([195.39.17.254]:14340 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262528AbSLAVWh>;
	Sun, 1 Dec 2002 16:22:37 -0500
Date: Sun, 1 Dec 2002 22:28:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: devicefs support for system timer
Message-ID: <20021201212825.GA20073@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here it is; without this, time runs 50x too slow after resume, please
apply

								Pavel

--- clean/arch/i386/kernel/i8259.c	2002-09-30 20:33:40.000000000 +0200
+++ linux-sensors/arch/i386/kernel/i8259.c	2002-12-01 22:26:19.000000000 +0100
@@ -367,6 +367,45 @@
 	}
 }
 
+static void setup_timer(void)
+{
+	outb_p(0x34,0x43);		/* binary, mode 2, LSB/MSB, ch 0 */
+	udelay(10);
+	outb_p(LATCH & 0xff , 0x40);	/* LSB */
+	udelay(10);
+	outb(LATCH >> 8 , 0x40);	/* MSB */
+}
+
+static int timer_resume(struct device *dev, u32 level)
+{
+	if (level == RESUME_POWER_ON)
+		setup_timer();
+	return 0;
+}
+
+static struct device_driver timer_driver = {
+	.name		= "timer",
+	.bus		= &system_bus_type,
+	.resume		= timer_resume,
+};
+
+static struct sys_device device_timer = {
+	.name		= "timer",
+	.id		= 0,
+	.dev		= {
+		.name	= "timer",
+		.driver	= &timer_driver,
+	},
+};
+
+static int __init init_timer_devicefs(void)
+{
+	driver_register(&timer_driver);
+	return sys_device_register(&device_timer);
+}
+
+device_initcall(init_timer_devicefs);
+
 void __init init_IRQ(void)
 {
 	int i;
@@ -386,16 +425,15 @@
 	}
 
 	/* setup after call gates are initialised (usually add in
-	 * the architecture specific gates */
+	 * the architecture specific gates)
+	 */
 	intr_init_hook();
 
 	/*
 	 * Set the clock to HZ Hz, we already have a valid
 	 * vector now:
 	 */
-	outb_p(0x34,0x43);		/* binary, mode 2, LSB/MSB, ch 0 */
-	outb_p(LATCH & 0xff , 0x40);	/* LSB */
-	outb(LATCH >> 8 , 0x40);	/* MSB */
+	setup_timer();
 
 	/*
 	 * External FPU? Set up irq13 if so, for

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
